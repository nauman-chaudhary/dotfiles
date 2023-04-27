eval $(/opt/homebrew/bin/brew shellenv)

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH


# Load all seperated config files
for conf in "$HOME/dotfiles/"*.zsh; do
  source "${conf}"
done
unset conf

# exec "$SHELL"


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
