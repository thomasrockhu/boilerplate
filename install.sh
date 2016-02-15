#!/bin/bash

REQUIREMENTS="requirements.txt"

DJANGO_PROJECT_NAME=tarasbday
WEBCLIENT_NAME=webclient
REPO_ROOT=$(pwd)
DJANGO_ROOT=$REPO_ROOT/$DJANGO_PROJECT_NAME
WEBCLIENT_ROOT=$REPO_ROOT/$WEBCLIENT_NAME
VIRTUALENVWRAPPER_PATH="/usr/local/bin/virtualenvwrapper.sh"

# install git hooks
./tools/hooks/install.sh

# setup virtualenv
if [ -f $VIRTUALENVWRAPPER_PATH ]; then
    . $VIRTUALENVWRAPPER_PATH
fi
mkvirtualenv $DJANGO_PROJECT_NAME &&
   +   pip install -r $REPO_ROOT/$REQUIREMENTS

cdsitepackages  # defined by virtualenvwrapper
if [ ! -e _virtualenv_path_extensions.pth ]; then
    # _virtualenv_path_extensions.pth has custom PYTHONPATH paths,
    # created by add2virtualenv
    add2virtualenv $REPO_ROOT $REPO_ROOT/external-apps $REPO_ROOT/external-libs
    echo cd $DJANGO_ROOT >> ~/.virtualenvs/$DJANGO_PROJECT_NAME/bin/postactivate
fi
cd -  # go back to the previous directory (before cdsitepackages)

# install node/npm dependencies
cd ../$WEBCLIENT_NAME

#npm install --cache $REPO_ROOT/npm-cache --cache-min 9999999 --no-registry
#echo "Finished installing node/npm dependencies"
#cd - # go back to previous directory

# setup webclient development configuration path
#echo "Setting up the configuration path for development."
#sh ./config.sh
