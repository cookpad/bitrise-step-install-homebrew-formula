#!/usr/bin/env bash
set -e

brew install $packages

if [ "$cache_enabled" = "1" ] || [ "$cache_enabled" = "true" ] || [ "$cache_enabled" = "yes" ]; then
  brew_cache=`brew --cache`
  if [ -z "$BITRISE_CACHE_INCLUDE_PATHS" ]; then
    BITRISE_CACHE_INCLUDE_PATHS="$brew_cache"
  else
    # It's a mess how "\n" is handled differently in scripts and on the command
    # line, so use a real new line in the string.
    BITRISE_CACHE_INCLUDE_PATHS="$BITRISE_CACHE_INCLUDE_PATHS
$brew_cache"
  fi

  envman add --key "BITRISE_CACHE_INCLUDE_PATHS" --value "$BITRISE_CACHE_INCLUDE_PATHS"
fi
