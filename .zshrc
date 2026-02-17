# =============================================================================
#                                   ZSH Configuration
# =============================================================================

# # Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# =============================================================================
#                                   Core Settings
# =============================================================================

# History configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000               # Maximum events in internal history
SAVEHIST=50000               # Maximum events in history file
setopt HIST_IGNORE_ALL_DUPS  # Don't record duplicates in history
setopt HIST_FIND_NO_DUPS     # Don't display duplicates when searching
setopt HIST_SAVE_NO_DUPS     # Don't save duplicates
setopt HIST_REDUCE_BLANKS    # Remove unnecessary blanks
setopt INC_APPEND_HISTORY    # Append immediately
setopt EXTENDED_HISTORY      # Add timestamps to history
setopt HIST_VERIFY           # Don't execute immediately upon history expansion
setopt SHARE_HISTORY         # Share history between all sessions

# Directory navigation
setopt AUTO_PUSHD            # Push the current directory visited on the stack
setopt PUSHD_IGNORE_DUPS     # Do not store duplicates in the stack
setopt PUSHD_SILENT          # Do not print the directory stack after pushd or popd

# =============================================================================
#                                   Plugins
# =============================================================================

# Theme and appearance
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# Essential plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# TheFuck command correction
eval $(thefuck --alias)

# Initialize zoxide
eval "$(zoxide init zsh)"

# History search configuration
bindkey '^[[A' history-substring-search-up     # Up arrow
bindkey '^[[B' history-substring-search-down   # Down arrow
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Node Version Manager (uncomment if needed)
# source /usr/share/nvm/init-nvm.sh

# FZF configuration
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh


# List of plugins used
 plugins=(git zsh-autosuggestions fast-syntax-highlighting zsh-completions)

# =============================================================================
#                               Completion System
# =============================================================================

# Initialize completion system
autoload -Uz compinit -i
compinit -i

# Completion options
zstyle ':completion:*' menu select                 # Use menu selection
zstyle ':completion:*' rehash true                 # Automatically rehash
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:cd:__zoxide_z:*' fzf-preview 'ls --color $realpath'


# Key bindings
bindkey '^[[A' history-substring-search-up        # Up arrow
bindkey '^[[B' history-substring-search-down      # Down arrow
bindkey '^[[H' beginning-of-line                  # Home
bindkey '^[[F' end-of-line                        # End
bindkey '^[[3~' delete-char                       # Delete
bindkey '^H' backward-delete-char                 # Backspace
bindkey '^[[1;5C' forward-word                    # Ctrl + Right
bindkey '^[[1;5D' backward-word                   # Ctrl + Left

# =============================================================================
#                                   Aliases
# =============================================================================

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cd='z'  # Use zoxide instead of cd

# Modern command replacements
alias ls='eza --group-directories-first --icons=auto'
# alias ls='lsd'
alias l='eza -lh --icons=auto'
alias ll='eza -lah --icons=auto --sort=name --group-directories-first'
alias lt='eza --tree --level=2 --icons=auto'
alias cat='bat --style=plain'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Git aliases
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gca='git commit -v --amend'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias glog='git log --oneline --decorate --graph'
alias gb='git branch'
alias gf='git fetch --all'
alias gm='git add . && git commit -m'

# System aliases
alias c='clear'
alias arduino='arduino-ide'
alias edex='/home/dexter/Downloads/eDEX-UI-Linux-x86_64.AppImage --no-sandbox'
alias reload='source ~/.zshrc'

# Development tools
alias py='python'
alias ipy='ipython'
alias pip-upgrade='pip list --outdated --format=freeze | grep -v "^\-e" | cut -d = -f 1 | xargs -n1 pip install -U'
alias npm-upgrade='npm update -g'
alias docker-clean='docker system prune -af'
alias un='$aurhelper -Rns' # uninstall package
alias up='$aurhelper -Syu' # update system/package/aur
alias pl='$aurhelper -Qs'  # list installed package
alias pa='$aurhelper -Ss'  # list available package
alias pc='$aurhelper -Sc'  # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
alias vc='code'            # gui code editor
alias kill='hyprctl kill'  # kill application
alias ts-up="tailscaled --tun=userspace-networking & sleep 2 && tailscale up"
alias ts-status="tailscale status"

# Flutter
alias fr='flutter run'
alias fpg='flutter pub get'
alias fbc='flutter clean && flutter pub get'
alias fbm='flutter pub run build_runner build --delete-conflicting-outputs'

# Laravel (Artisan)
alias art='php artisan'
alias fresh='php artisan migrate:fresh --seed'
alias tinker='php artisan tinker'

# Git 
alias gcm='git commit -m'
alias gcap='git add . && git commit -m "update" && git push' 

# Arduino CLI Manager alias
alias acm='arduino-manager'
alias icat='kitty +kitten icat'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'

# alias xfind="fzf --bind "change:reload:rg --line-number --no-heading --color=always {q} || true" --ansi --disabled"
# alias nvimfind="rg --line-number --no-heading --color=always "pattern" | fzf | cut -d: -f1 | xargs nvim"
# alias ff="rg --line-number --no-heading --color=always "pattern" | fzf"


# Interactive live search (ripgrep + fzf)

# xfind() {
#   fzf --ansi --disabled \
#       --delimiter : \
#       --bind 'change:reload:rg --line-number --no-heading --color=always {q} || true' \
#       --preview 'bat --color=always --style=numbers {1} --line-range {2}:'
# }

xfind() {
  local query="${1:-}"

  fzf --ansi --disabled --query="$query" \
      --delimiter : \
      --bind "start:reload:rg --line-number --no-heading --color=always {q} || true" \
      --bind "change:reload:rg --line-number --no-heading --color=always {q} || true" \
      --preview 'bat --color=always --style=numbers --highlight-line {2} {1} --line-range {2}:+50' \
      --preview-window 'right:60%:border-left' \
      # --bind 'enter:become(nvim +{2} {1})'
}

nvimfind() {
  local query="${1:-}"

  fzf --ansi --disabled --query="$query" \
      --delimiter : \
      --bind "start:reload:rg --line-number --no-heading --color=always {q} || true" \
      --bind "change:reload:rg --line-number --no-heading --color=always {q} || true" \
      --preview 'bat --color=always --style=numbers --highlight-line {2} {1} --line-range {2}:+50' \
      --preview-window 'right:60%:border-left' \
      --bind 'enter:become(nvim +{2} {1})'
}

ff() {
  rg --line-number --no-heading --color=always "$1" | fzf --ansi
}


# =============================================================================
#                                   Functions
# =============================================================================

# Create a new directory and enter it
mkcd() {
    mkdir -p "$@" && cd "$_"
}

# Extract various archive formats
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick Python virtual environment management
venv() {
    if [ $# -eq 0 ]; then
        [ -d "venv" ] && source venv/bin/activate || echo "No venv found in current directory"
    elif [ "$1" = "create" ]; then
        python -m venv venv && source venv/bin/activate
    elif [ "$1" = "remove" ]; then
        deactivate 2>/dev/null
        rm -rf venv
    else
        echo "Usage: venv [create|remove]"
    fi
}

# Copy to clipboard in Wayland

copy() {
    if [ -p /dev/stdin ]; then
        wl-copy
    else
        wl-copy <<< "$@"
    fi
}

# =============================================================================
#                               Environment Variables
# =============================================================================
# arduino-ide
export PATH=$HOME/go/bin:$PATH
# Input method
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus 
# Development paths
export PATH=$PATH:/opt/gradle/gradle-8.10/bin
export PATH=$PATH:/home/dexter/flutter/bin
export PATH=$PATH:/home/dexter/.pub-cache/bin

# Default applications
export EDITOR='code'
export VISUAL='code'
export PAGER='less'
export BROWSER='chromium'
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export CHROME_EXECUTABLE=/usr/bin/chromium
export JAVA_HOME=/usr/lib/jvm/java-23-openjdk
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export PATH=$PATH:$HOME/Android/Sdk/emulator:$HOME/Android/Sdk/platform-tools
export PATH="$PATH:/opt/android-sdk/build-tools/<version>/"
export PATH="$HOME/.local/bin:$PATH"

# FZF colors - nord theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=fg:#e5e9f0,bg:#2e3440,hl:#81a1c1
--color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1
--color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
--color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!

# __conda_setup="$('/home/dexter/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/dexter/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/dexter/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/dexter/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup

# <<< conda initialize <<<



## [Completion]
## Completion scripts setup. Remove the following line to uninstall
 [[ -f /home/dexter/.dart-cli-completion/zsh-config.zsh ]] && . /home/dexter/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


precmd() {
  if [[ $? -ne 0 ]]; then
    paplay /usr/share/sounds/freedesktop/stereo/bell.oga &>/dev/null
    # paplay /usr/share/sounds/freedesktop/stereo/dialog-error.oga &>/dev/null
  fi
}



# =============================================================================
#           Functions and Completions after Instant Prompt Initialization
# =============================================================================

# In case a command is not found, try to find the package that has it
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
    if (( ${#entries[@]} )) ; then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}" ; do
            local fields=( ${(0)entry} )
            if [[ "$pkg" != "${fields[2]}" ]]; then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}

# Detect AUR wrapper
if pacman -Qi yay &>/dev/null; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null; then
   aurhelper="paru"
fi

function in {
    local -a inPkg=("$@")
    local -a arch=()
    local -a aur=()

    for pkg in "${inPkg[@]}"; do
        if pacman -Si "${pkg}" &>/dev/null; then
            arch+=("${pkg}")
        else
            aur+=("${pkg}")
        fi
    done

    if [[ ${#arch[@]} -gt 0 ]]; then
        sudo pacman -S "${arch[@]}"
    fi

    if [[ ${#aur[@]} -gt 0 ]]; then
        ${aurhelper} -S "${aur[@]}"
    fi
}


# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
