#!/bin/bash


## This function determines which HTTP get tool the system has installed and returns an error if there isn't one
getConfiguredClient()
{
    if  command -v curl &>/dev/null ; then
      configuredClient="curl"
    elif command -v wget &>/dev/null ; then
      configuredClient="wget"
    elif command -v fetch &>/dev/null ; then
      configuredClient="fetch"
    else
      echo "Error: This script reqires either curl, wget, or fetch to be installed."
      return 1
    fi

}

httpGet()
{
  case "$configuredClient" in
    curl) curl -A curl -s "$@";;
    wget) wget -qO- "$@";;
    fetch) fetch -o "...";;
  esac
}


checkInternetConnection()
{
	httpGet blockchain.info > /dev/null 2>&1 || { echo "Error: no active internet connection or blockchain.info is down" >&2; return 1; } # query google with a get request
}

checkValidCurrency()
{
  if [[ $1 != "USD" && $1 != "ISK" && $1 != "HKD" \
      && $1 != "TWD" && $1 != "CHF" && $1 != "EUR" && $1 != "DKK" && $1 != "CLP" \
      && $1 != "CAD" && $1 != "INR" && $1 != "CNY" && $1 != "THB" && $1 != "AUD" \
      && $1 != "SGD" && $1 != "KRW" && $1 != "JPY" && $1 != "PLN" && $1 != "GBP" \
      && $1 != "SEK" && $1 != "NZD" && $1 != "BRL" && $1 != "RUB"\
      ]];then
    echo "1"
  else
    echo "0"
  fi
}


getBitcoinRate()
{	
	bitcoinRate=$(httpGet "https://blockchain.info/ticker" | grep -Eo '"'$currency'" : {"15m" : (.*?),' | grep -Eo "[0-9]+\.[0-9]+") > /dev/null
	echo "1 BTC = $bitcoinRate $currency"
}

getConvertBitcoin()
{
	convertBitcoin=$(httpGet "https://blockchain.info/tobtc?currency=$currency&value=$amount") > /dev/null
	echo "$amount $currency = $convertBitcoin BTC"
}


getConfiguredClient || exit 1
checkInternetConnection || exit 1

if [[ $# == 0 ]]; then
  currency="USD"
  getBitcoinRate
  exit 0
elif [[ $# == "1" ]]; then
  currency=$1
  currency=$(echo $currency | tr /a-z/ /A-Z/)
  if [[ $(checkValidCurrency $currency) == "1" ]];then
    echo "Unknown currency code. Fix it and try again."
    exit 1
  fi
  getBitcoinRate
  exit 0
elif [[ $# == "2" ]]; then
  currency=$1
  currency=$(echo $currency | tr /a-z/ /A-Z/)
  if [[ $(checkValidCurrency $currency) == "1" ]];then
    echo "Unknown currency code. Fix it and try again."
    exit 1
  fi
  amount=$2
  if [[ ! "$amount" =~ ^[0-9]+(\.[0-9]+)?$ ]]
  then
    echo "The amount has to be a number. Fix it and try again."
    exit 1
  fi
  getConvertBitcoin
  exit 0  
fi
