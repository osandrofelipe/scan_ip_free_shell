clear
echo "============================================================================"
echo "|                 Script de verificação de IPs disponiveis                 |"
echo "============================================================================"
echo ""
echo "Informe a faixa de rede desejada para verificar disponibilidade de IPs: "
read -p "Ex.: 192.168.100 -> " REDE
echo ""
#rede="172.18.23"
read -p "IP Inicial de HOSTs: " IPI
read -p "IP final de HOSTs: "  IPF
echo ""

output_file="ip_verification_results.txt"
echo "" > $output_file  # Clear the file if it exists

echo "======================================================" | tee -a $output_file
echo "  Verificação de IPs disponiveis na rede $REDE.0" | tee -a $output_file
echo "======================================================" | tee -a $output_file
echo "" | tee -a $output_file
cont=0
total=0

# Function to handle script termination
terminate_script() {
    echo "" | tee -a $output_file
    echo "======================================================" | tee -a $output_file
    echo "Script interrompido pelo usuário." | tee -a $output_file
    echo "$cont IPs LIVRES DO TOTAL DE $total" | tee -a $output_file
    echo "======================================================" | tee -a $output_file
    exit 1
}

# Trap SIGINT (Ctrl+C) and call terminate_script
trap terminate_script SIGINT

for i in $(seq $IPI $IPF); do
    if ping -c 1 -W 1 $REDE.$i > /dev/null; then
        echo "$REDE.$i EM USO" | tee -a $output_file
    else
        echo "$REDE.$i IP LIVRE" | tee -a $output_file
        ((cont++))
    fi
    ((total++))
done

echo "" | tee -a $output_file
echo "======================================================" | tee -a $output_file
echo "$cont IPs LIVRES DO TOTAL DE $total" | tee -a $output_file
echo "======================================================" | tee -a $output_file
echo ""
