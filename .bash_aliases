# some more ls aliases
alias ls='ls -G'
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'
alias pwsafe='sudo pwsafe -E '

alias office='ssh omid@omid.regentmarkets.com'
alias star='ssh -p24312 space@localhost'

epoch_to_datetime() { perl -MDateTime -E "say DateTime->from_epoch(epoch => $1)->datetime();"; }
perl_mod_version() { perl -M$1 -E 'say '$1'->VERSION;'; }

# Stuff I don't want to be public or perhaps share in github
if [ -f $HOME/.bash_aliases_more ]; then
    source ~/.bash_aliases_more
fi

