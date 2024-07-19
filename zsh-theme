# ~/.oh-my-zsh/themes/

function prompt_custom() {
    local last_status=$?
    local path=$PWD

    local black_fg="%{\033[30m%}"
    local black_bg="%{\033[40m%}"
    local white_bg="%{\033[48;2;255;255;255m%}"
    local blue_fg="%{\e[38;2;129;169;254m%}"
    local blue_bg="%{\e[48;2;129;169;254m%}"
    local dark_blue_fg="%{\e[38;2;59;66;97m%}"
    local dark_blue_bg="%{\e[48;2;59;66;97m%}"
    local pink_fg="%{\e[38;2;197;134;192m%}"
    local bold="%{\e[1m%}"
    local reset="%{\e[0m%}"

    if [[ $path == $HOME* ]]; then
        path="~${path#$HOME}"
        path=${path//\//" $black_fg $blue_fg"}
    elif [[ $path != "/" ]]; then
        path=${path//\//" $black_fg $blue_fg"}
        path="/$path"
    else
        path="/"
    fi

    local user=$USERNAME

    local git_branch=$(/usr/bin/git symbolic-ref --short HEAD 2>/dev/null)
    local git_info=""
    if [[ -n $git_branch ]]; then
        git_info="$git_branch"
    fi

    echo -en "\n┌ "
    echo -en "$blue_fg$reset"
    echo -en "$blue_bg$black_fg ZS▕ $user $reset"
    echo -en "$black_bg$blue_fg$reset"
    echo -en "$dark_blue_bg$black_fg"
    echo -en "$dark_blue_bg$blue_fg $path $reset"
    echo -en "$dark_blue_fg$reset"

    if [[ -n $git_info ]]; then
        echo -en " $pink_fg $git_info $reset"
    fi

    if [[ $last_status -ne 0 ]]; then
        if [[ -n $git_info ]]; then
            echo -ne "\b"
        fi
        echo -en " $bold$dark_blue_fg$last_status $reset"
    fi

    echo -en "$blue_fg$reset"
    echo -en "\n└ "

    if [[ $EUID -eq 0 ]]; then
        echo -n "# "
    else
        echo -n "%% "
    fi
}

PROMPT='%{%f%b%k%}$(prompt_custom)'
RPROMPT=''
