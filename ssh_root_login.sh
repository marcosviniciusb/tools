#!/bin/bash

# Função para habilitar o login SSH como root
enable_root_login() {
    sed -i 's/^PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    systemctl restart sshd
    echo ""
    echo "Login SSH como root habilitado."
    echo ""

}

# Função para desabilitar o login SSH como root
disable_root_login() {
    sed -i 's/^PermitRootLogin yes/#PermitRootLogin yes/' /etc/ssh/sshd_config
    systemctl restart sshd
    echo ""
    echo "Login SSH como root desabilitado."
    echo ""

}

# Verifica se o usuário é root
if [ "$(id -u)" -ne 0 ]; then
    echo ""
    echo "Este script precisa ser executado como root."
    echo ""
    exit 1
fi

# Verifica se o número de argumentos está correto
if [ $# -ne 1 ]; then
    echo ""
    echo "Uso: \$0 [on|off]"
    echo ""
    exit 1
fi

# Verifica se o argumento é "on" ou "off"
if [ "$1" = "on" ]; then
    enable_root_login
elif [ "$1" = "off" ]; then
    disable_root_login
else
    echo ""
    echo "Opção inválida. Use 'on' para habilitar ou 'off' para desabilitar."
    echo ""
    exit 1
fi
