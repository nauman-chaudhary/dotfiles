#!/bin/bash

set -e

# variables
dir=~/dotfiles
olddir=~/dotfiles_old
files=".zshrc" 

# assumes git is installed
git config --global core.excludesfile $dir/.gitignore_global
git config --global --add --bool push.autoSetupRemote true


# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"


# install brew
which -s brew || NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export HOMEBREW_NO_ANALYTICS=1
export PATH="$PATH:/opt"
eval "$(/opt/homebrew/bin/brew shellenv)"


# set up python
brew install xz
brew list pyenv || brew install pyenv
pyenv install $(pyenv install --list | grep --extended-regexp "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1)


# # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    [ -f ~/$file ] && mv ~/$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done


# install oh-my-zsh
if [ ! -d ~/.oh-my-zsh/ ]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi
