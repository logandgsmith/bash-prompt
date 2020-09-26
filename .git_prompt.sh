__git_ps1()
{
    local branch=$(git branch 2>&1 2>/dev/null | perl -ne 'print if (s/^\* //g)')
    if [ -n "$branch" ]; then
        local remote=$(git config "branch.${branch}.remote")
        local aheadbehind=$(git rev-list --left-right "${remote}/${branch}"...HEAD 2>/dev/null \
           | perl -e '
             $ahead = $behind = $lines = 0;
             while(<>) {
                 if (/^([<>])/g) {
                     $lines++;
                     if ($1 eq "<") {
                         $behind--;
                     } else {
                         $ahead++;
                     }
                 }
             }
             print "${behind}|${ahead}" if $lines;')
        local remote_changes=""
        local color_yellow="\001\033[0;33m\002"
        local color_red="\001\033[0;31m\002"
        local color_cyan="\001\033[0;36m\002"
        local color_reset="\001\033[0;00m\002"
         if [ -n "$aheadbehind" ]; then
            local behind=$(echo "$aheadbehind" | cut -d'|' -f1)
            local ahead=$(echo "$aheadbehind" | cut -d'|' -f2)

            local ahead_color=$color_cyan
            local behind_color=$color_red
            if [ "$ahead" -eq "0" ]; then
                ahead_color=""
            else
                ahead="+${ahead}"
            fi
            if [ "$behind" -eq "0" ]; then
                behind_color=""
            fi
            remote_changes=$(printf "[${behind_color}%s${color_reset}:${ahead_color}%s${color_reset}]" "$behind" "$ahead")
        fi
        printf "(${color_yellow}%s${color_reset}${remote_changes})" "$branch"
    fi
}


export PS1="\[\033[1;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$(__git_ps1)\$ "
