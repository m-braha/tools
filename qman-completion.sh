#!/bin/bash

CONFIG_DIR="$HOME/.config/qman"

_qman_completions() {
    local cur prev words cword
    _init_completion || return

    local commands="create up exec kill ssh destroy list"
    local options="-d -n -c -s -init -p -f"

    case "$prev" in
        qman)
            mapfile -t COMPREPLY < <(compgen -W "$commands" -- "$cur")
            return
            ;;
        create)
            return
            ;;
        up|exec|kill|ssh|destroy)
            if [ -d "$CONFIG_DIR" ]; then
                local vms
                vms=$(find "$CONFIG_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)
                mapfile -t COMPREPLY < <(compgen -W "$vms" -- "$cur")
            fi
            mapfile -t COMPREPLY < <(compgen -W "$vms" -- "$cur")
            return
            ;;
        *)
            if [[ "$cur" == -* ]]; then
                mapfile -t COMPREPLY < <(compgen -W "$options" -- "$cur")
            fi
            ;;
    esac
}

complete -F _qman_completions qman