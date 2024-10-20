(( ${+commands[bun]} || ${+commands[asdf]} && ${+functions[_direnv_hook]} )) && () {

  local command=${commands[bun]:-"$(${commands[asdf]} which bun 2> /dev/null)"}
  [[ -z $command ]] && return 1
  [[ ! -d ${BUN_INSTALL:-} ]] && return 1

   # generating init file
  local initfile=$1/bun-init.zsh
  if [[ ! -e $initfile || $initfile -ot $command ]]; then
    echo "# bun version: $($command --version)" >| $initfile
    cat "$BUN_INSTALL/_bun" >> $initfile
    zcompile -UR $initfile
  fi

  source $initfile
} ${0:h}