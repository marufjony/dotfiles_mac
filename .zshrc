# Author: Maruf Jony <maruf@codersgarage.com>
# Source: http://github.com/marufjony/dotfiles

#Global options
export SHELL_SESSION_HISTORY=0
export HISTFILESIZE=999999
export HISTSIZE=999999
export HISTCONTROL=ignoredups:ignorespace

#fortune


export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export TERM="xterm-256color"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

#ZSH_DISABLE_COMPFIX="true"

#aliases
alias ls='ls -G'
alias ll='ls -ltrG'
alias la='ls -alG'
alias less='less -R'
alias fnd='open -a Finder'
alias yt='youtube-dl'
alias wt='webtorrent'
alias python='python3'
alias pip='pip3'

ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='nerdfont-complete'

export ZSH=$HOME/.oh-my-zsh
plugins=(git 
        zsh-autosuggestions 
        zsh-syntax-highlighting)       #This line must be before sourcing ZSH!!!






# Prompt
	POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
	POWERLEVEL9K_PROMPT_ON_NEWLINE=true
	POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir_writable_joined dir vcs)
	POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time custom_wifi_signal battery context)
	POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
	POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{014}\u2570%F{cyan}\uF054%F{073}\uF054%F{109}\uF054%f "
	POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='%F{103}\uf460%F{103}'			# lightslategrey=103
	POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
	POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='%F{146}\ue621%F'
	#POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR_FOREGROUND='146'

## os_icon: os identifier
	POWERLEVEL9K_OS_ICON_FOREGROUND="cyan"
	POWERLEVEL9K_OS_ICON_BACKGROUND="none"

## context: user
	POWERLEVEL9K_CONTEXT_TEMPLATE="%B%n"
	POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='green'
	POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='none'

## dir: current directory
	POWERLEVEL9K_DIR_BACKGROUND="none"
	POWERLEVEL9K_DIR_FOREGROUND='010'
	POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear"
	POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="012"
	POWERLEVEL9K_DIR_HOME_BACKGROUND="clear"
	POWERLEVEL9K_DIR_HOME_FOREGROUND="012"
	POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
	POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="012"
	POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{008}/%F{cyan}"
	POWERLEVEL9K_DIR_ETC_BACKGROUND="clear"
	POWERLEVEL9K_ETC_ICON='%F{blue}\uf423'
	POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"
	POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="clear"

## vcs: git status
	# Version control system colors.

## status: exit code of the last command
    # Status on success. No content, just an icon. No need to show it if prompt_char is enabled as it will signify success by turning green.
	POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
	POWERLEVEL9K_STATUS_OK_BACKGROUND="none"
    # Status when it's just an error code (e.g., '1'). No need to show it if prompt_char is enabled as it will signify error by turning red.
	POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
	POWERLEVEL9K_STATUS_ERROR_BACKGROUND="none"

## time: current time
    # Current time color.
	POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
	POWERLEVEL9K_TIME_BACKGROUND='none'
	POWERLEVEL9K_TIME_FOREGROUND='081'



# Battery Status

POWERLEVEL9K_BATTERY_VERBOSE=false
POWERLEVEL9K_CUSTOM_BATTERY_STATUS="battery"
POWERLEVEL9K_CUSTOM_BATTERY_BACKGROUND="none"

battery() {
    local percentage=`pmset -g ps  |  sed -n 's/.*[[:blank:]]+*\(.*%\).*/\1/p'`
    local percentage=`echo "${percentage//\%}"`
    local color='%F{red}'
    local symbol="\uf00d"
if [ $(bc <<< "scale=2 ; $percentage<25") = '1' ]
    then symbol="\uf244" ; color='%F{red}' ;
        #Less than 25
        fi
        
if [ $(bc <<< "scale=2 ; $percentage>=25") = '1' ] && [ $(bc <<< "scale=2 ; $percentage<50") = '1' ]
    then symbol='\uf243' ; color='%F{red}' ;
    #25%
    fi
if [ $(bc <<< "scale=2 ; $percentage>=50") = '1' ] && [ $(bc <<< "scale=2 ; $percentage<75") = '1' ]  
     then symbol="\uf242" ; color='%F{yellow}' ;
     #50%
     fi
if [ $(bc <<< "scale=2 ; $percentage>=75") = '1' ] && [ $(bc <<< "scale=2 ; $percentage<100") = '1' ]
        then symbol="\uf241" ; color='%F{blue}' ;
        #75%
        fi  
 
if [ $(bc <<< "scale=2 ; $percentage>99") = '1' ]
        then symbol="\uf240" ; color='%F{green}' ;
        #100%
        fi
pmset -g ps | grep "discharging" >& /dev/null
if [ $? -eq 0 ]; then
    true;
else ;
   color='%F{green}' ;
fi
echo -n "%{$color%}$symbol" ;
}


# WiFi Signal

POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_BACKGROUND="none"
#  POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_FOREGROUND="yellow"

zsh_wifi_signal(){
        local output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I) 
        local airport=$(echo $output | grep 'AirPort' | awk -F': ' '{print $2}')

        if [ "$airport" = "Off" ]; then
                local color='%F{yellow}'
                echo -n "%{$color%}Wifi Off \ufaa9"
        else
                local ssid=$(echo $output | grep ' SSID' | awk -F': ' '{print $2}')
                local speed=$(echo $output | grep 'lastTxRate' | awk -F': ' '{print $2}')
                local color='%F{yellow}'

                [[ $speed -gt 100 ]] && color='%F{green}'
                [[ $speed -lt 50 ]] && color='%F{red}'

                echo -n "%{$color%}$speed kB/s \uf1eb%{%f%}" # removed char not in my PowerLine font 
        fi
}



source $ZSH/oh-my-zsh.sh


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"




# The fucking autojump tool
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
alias config='/usr/bin/git --git-dir=/Users/marufjony/.dotfiles/ --work-tree=/Users/marufjony'
