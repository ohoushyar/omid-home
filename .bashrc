# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Load profile if it's not login mode
# if [[ $0 != -* ]]; then
#     source $HOME/.profile
# fi

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1=' ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] '
else
    PS1=' ${debian_chroot:+($debian_chroot)}\u@\h:\w '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    source /etc/bash_completion
    if [ "`type -t __git_ps1`" = 'function' ]; then git_ps=1; fi;
elif [ -f /etc/bash_completion.d/git ]; then
    source /etc/bash_completion.d/git
    git_ps=1
elif [ -f $HOME/.git-completion.sh ]; then
    # git auto completion
    source $HOME/.git-completion.sh
elif [ -f $HOME/.git-completion.bash ]; then
    # git auto completion
    source $HOME/.git-completion.bash
fi
if [ -f $HOME/.git-prompt.sh ]; then
    source $HOME/.git-prompt.sh
    git_ps=1
fi

COLOR_GREEN='\033[0;32m'
PS1="[$PS1]\n\[${COLOR_GREEN}\]"
if [ -n "$git_ps" ]; then
    PS1="$PS1"'$(__git_ps1 "(%s) ")'
fi
COLOR_DEFAULT='\033[0m'
PS1="$PS1\[${COLOR_DEFAULT}\]"'\$ '

if [ -f $HOME/.lymbix_api/init ]; then
    source $HOME/.lymbix_api/init
fi

# Unit test parallelism for perlbrew
if [ -f $HOME/perl5/perlbrew/etc/bashrc ]; then
    TEST_JOBS=5
    source $HOME/perl5/perlbrew/etc/bashrc
fi

# local::lib config
if [ -f $HOME/perl5/lib/perl5 ]; then
    eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
fi

if [ -f $HOME/.ssh_agent_reuse ]; then
    source $HOME/.ssh_agent_reuse

    # add keys
    ssh-add -l >/dev/null 2>&1
    if [ $? = 2 ]; then
        ssh-add ~/.ssh/id_dsa ~/.ssh/id_dsa_cheetahmail
    fi
fi

# Disable gnome keyring control
#unset GNOME_KEYRING_CONTROL

