# bash-prompt
A backup of the prompt I use in cmder

A nice green and blue prompt that gives you (behind|ahead) information about your current GitHub repo. Make sure to add the following to your ~/.bashrc (It assumes .git_prompt.sh is located in ~):

```
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
source ~/.git_prompt.sh
```

Modified from the prompt found at [https://gist.github.com/fdintino/2844449](https://gist.github.com/fdintino/2844449).
