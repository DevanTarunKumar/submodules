#!/usr/bin/env bash

set -euo pipefail

root="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../../" && pwd )"

hooks="$root/.git/hooks"

echo "Checking Git hooks..."

if [ -L "$hooks" ]; then
  echo "Git hooks symbolic link is already in place."
  if [ "$(readlink "$hooks")" == '../hooks' ]; then
    echo 'Symbolic link is configured correctly.'
  else
    echo 'Symbolic link is NOT configured correctly. Removing...'
    rm "$hooks"

    echo 'Creating symbolic link...'
    ln -s ../hooks "$hooks"
  fi
else
  echo 'Git hooks symbolic link is not in place.'
  if [ -e "$hooks" ]; then
    echo 'Git hooks dir present. Removing...'
    rm -rf "$hooks"
  fi

  echo 'Creating symbolic link...'
  ln -s ../hooks "$hooks"
fi

echo "Git hooks symbolic link setup is complete."
