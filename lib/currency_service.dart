import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  final String apiKey = 'db17e7a6566ad1243ff376f5';
  final String baseUrl = 'https://v6.exchangerate-api.com/v6/db17e7a6566ad1243ff376f5/latest/USD';

  Future<Map<String, dynamic>> getCurrencyRates() async {
    final response = await http.get(Uri.parse('$baseUrl?apikey=$apiKey'));

    if (response.statusCode == 200) {
      var jsonResponse=jsonDecode(response.body);
      var conversionRates= jsonResponse['conversion_rates'];
      return conversionRates;

    } else {
      throw Exception('Failed to load currency rates');
    }
  }
  Future<List<String>> fetchCurrencyNames() async {
    final rates = await getCurrencyRates();
    return rates.keys.toList();
  }
}