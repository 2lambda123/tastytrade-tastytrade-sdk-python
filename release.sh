#!/bin/bash

export RELEASE_TYPE="$1"

export ERROR_MESSAGE="Usage: './release.sh (patch|minor|major)'"
<<<<<<< HEAD
if [ -z "${RELEASE_TYPE}" ]; then
  echo "${ERROR_MESSAGE}"
  echo 'Error: Failed to set RELEASE_TYPE variable. Exiting.'
=======
if [ -z "$RELEASE_TYPE" ]; then
  echo "$ERROR_MESSAGE"
>>>>>>> origin/fix-release-script
  exit 1
fi
if ! [[ "$RELEASE_TYPE" =~ (patch|minor|major) ]]; then
  echo "$ERROR_MESSAGE"
  exit 1
fi

if [[ "$(git rev-parse --abbrev-ref HEAD)" != "master" ]]; then
  echo 'Error: Release should be run on master. Exiting.'
  exit 1
fi

if [[ -n $(git status -s) ]]; then
  echo 'Error: There are uncommitted changes. Exiting.'
  exit 1
fi

if [[ $(git rev-parse HEAD) != $(git rev-parse origin/master) ]]; then
  echo 'Error: Local master is not in sync with remote. Exiting.'
  exit 1
fi

<<<<<<< HEAD
NEW_VERSION=NEW_VERSION=$(poetry version ${RELEASE_TYPE} --short) || { echo 'Error: Failed to determine the new version. Exiting.'; exit 1; }
git checkout -b "release-${NEW_VERSION}"
=======
export NEW_VERSION="$(poetry version "$RELEASE_TYPE" --short)"
git checkout -b "release-$NEW_VERSION"
>>>>>>> origin/fix-release-script
git add pyproject.toml
git commit -m "Release $NEW_VERSION"
git tag -f "$NEW_VERSION"
git tag -f latest
git push origin -f "$NEW_VERSION"
git push origin -f latest

NEW_PREPATCH_VERSION=$(poetry version prepatch --short) || { echo 'Error: Failed to determine the new pre-patch version. Exiting.'; exit 1; }
git add pyproject.toml
git commit -m "Bumping to next pre-patch version $NEW_PREPATCH_VERSION"
git push

<<<<<<< HEAD
echo 'Error: Failed to create pull request. Exiting.'
=======
hub pull-request -m "Release ${NEW_VERSION}"
>>>>>>> origin/fix-release-script
