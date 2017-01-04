#!/usr/bin/env bash

if [ -d ~/.dotfiles ]; then
    echo 'Please remove or rename "~/.dotfiles" directory" first'
    exit
fi;

### check dependencies
if ! type git > /dev/null; then
    echo 'Please install git before starting'
    exit
fi

if ! type zsh > /dev/null; then
    echo 'Please install zsh before starting'
    exit
fi

if ! type tmux > /dev/null; then
    echo 'I suggest to install tmux'
fi

if ! type axel > /dev/null; then
    echo 'I suggest to install axel'
fi

if ! type autojump > /dev/null; then
    echo 'I suggest to install autojump'
fi

if ! type autojump > /dev/null; then
    echo 'I suggest to install thefuck'
fi

### clone main repository
echo 'Cloning dotfiles...'
git clone -q --depth=1 https://github.com/omid/dotfiles.git ~/.dotfiles

### ZSH
if [ ! -f ~/.zsh_local ]; then
    echo '# Put your local ZSH changes and configs here' > ~/.zsh_local
fi
ln -sf ~/.dotfiles/zsh/zshrc ~/.zshrc

### GIT
if [ -f ~/.gitconfig ]; then
    mv ~/.gitconfig ~/.gitconfig_local
fi
if [ -f ~/.gitconfig_local ] && [ $(grep -q gitconfig_local ~/.gitconfig_local) ]; then
    rm -rf ~/.gitconfig_local
fi
if [ ! -f ~/.gitconfig_local ]; then
    echo '# Put your local Git changes and configs here' > ~/.gitconfig_local
fi
ln -sf ~/.dotfiles/gitconfig ~/.gitconfig

### TMUX
ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf

### AXEL
ln -sf ~/.dotfiles/axelrc ~/.axelrc

### WGET
ln -sf ~/.dotfiles/wgetrc ~/.wgetrc


### finalize
echo 'Finished. To change your default shell to ZSH, run "chsh -s $(grep /zsh$ /etc/shells | tail -1)"'
