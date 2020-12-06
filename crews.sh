#!/bin/sh

#run this as NOT-ROOT
LIST_OF_APPS="curl cargo cmake python php redis docker npm nodejs postgresql zsh"

apt update
sudo apt install -y $LIST_OF_APPS
sudo chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
wget -O ~/.zshrc https://github.com/crewsycrews/my-dotfiles-and-etc/raw/master/confs/.zshrc
sudo snap install code --classic
cargo install exa
sudo wget -O /usr/share/fonts/AnonymousPro-Regular.ttf https://github.com/crewsycrews/my-dotfiles-and-etc/raw/master/fonts/AnonymousPro-Regular.ttf
sudo wget -O /usr/share/fonts/SourceCodePro-Regular.ttf https://github.com/crewsycrews/my-dotfiles-and-etc/raw/master/fonts/SourceCodePro-Regular.ttf

# start installing composer
EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet --install-dir=/bin --filename=composer
RESULT=$?
exit $RESULT
# end installing composer