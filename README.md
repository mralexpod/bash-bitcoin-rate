# bash-bitcoin-rate
Getting Bitcoin rates via [Blockchain.info API](https://blockchain.info/api/exchange_rates_api).

This simplest Bash script gets average market price across major bitcoin exchanges.

Available currencies: _USD_, _ISK_, _HKD_, _TWD_, _CHF_, _EUR_, _DKK_, _CLP_, _CAD_, _INR_, _CNY_, _THB_, _AUD_, _SGD_, _KRW_, _JPY_, _PLN_, _GBP_, _SEK_, _NZD_, _BRL_, _RUB_.

##Using

There are 3 options:
1. With no arguments (by default get price of 1 BTC in USD)
Example:
`#./btc.sh`
Result:
`1 BTC = 2324.11 USD`
2. With 1 arguments - currency (see the list above).
Example:
`#./btc.sh EUR`
Result:
`1 BTC = 2007.03 EUR`
3. With 2 arguments - currency and amount to convert (the amount must be numerical)
Example:
`#./btc.sh GBP 2500`
Result:
`2500 GBP = 1.39820247 BTC`

All currencies are case-insensitive, you could use `EUR` as well as `eur`

P.S. Do `chmod +x btc.sh` if you want to run the script without printing `"bash btc.sh"`
