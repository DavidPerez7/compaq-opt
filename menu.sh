#!/bin/bash

cat << 'EOF'
 ██████╗ ██████╗ ███╗   ███╗██████╗  █████╗  ██████╗            ██████╗ ██████╗ ████████╗
██╔════╝██╔═══██╗████╗ ████║██╔══██╗██╔══██╗██╔═══██╗          ██╔═══██╗██╔══██╗╚══██╔══╝
██║     ██║   ██║██╔████╔██║██████╔╝███████║██║   ██║    █████╗██║   ██║██████╔╝   ██║   
██║     ██║   ██║██║╚██╔╝██║██╔═══╝ ██╔══██║██║▄▄ ██║    ╚════╝██║   ██║██╔═══╝    ██║   
╚██████╗╚██████╔╝██║ ╚═╝ ██║██║     ██║  ██║╚██████╔╝          ╚██████╔╝██║        ██║   
 ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝  ╚═╝ ╚══▀▀═╝            ╚═════╝ ╚═╝        ╚═╝   
                                                                                         
EOF

while true; do
    echo "1. Instalar Kernel Liquorix"
    echo "2. Salir"
    read -p "Elige una opción: " choice
    if [ "$choice" = "1" ]; then
        echo "Instalando Kernel Liquorix..."
        curl -s 'https://liquorix.net/install-liquorix.sh' | sudo bash
        if [ $? -ne 0 ]; then echo "Error en la instalación del kernel."; exit 1; fi
        # Instalar los headers del kernel (necesarios para el driver de wifi)
        sudo apt install linux-headers-liquorix-amd64
        if [ $? -ne 0 ]; then echo "Error en la instalación de headers."; exit 1; fi
        # Reinstalar el driver de Broadcom para que se vincule al nuevo kernel
        sudo apt install --reinstall broadcom-sta-dkms
        if [ $? -ne 0 ]; then echo "Error en la reinstalación del driver Broadcom."; exit 1; fi
        echo "Instalación completada. Reiniciando en 3 segundos..."
        sleep 3
        sudo reboot
    elif [ "$choice" = "2" ]; then
        echo "Saliendo..."
        exit 0
    else
        echo "Opción inválida. Intenta de nuevo."
    fi
done


