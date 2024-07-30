import 'package:flutter/material.dart';

import 'currency_service.dart';

class CurrencyConverter extends StatefulWidget {
  const  CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState()=> Currency_Converter();

}

class Currency_Converter extends State<CurrencyConverter>{
  double result = 0;
  double conversionRate=1.0;


  @override
  void initState(){
    super.initState();
    fetchConversionRate();
  }

  Future<void> fetchConversionRate ()async{
    try{
      final rates= await CurrencyService().getCurrencyRates();
      double usdToInrRate=rates['INR'];
      print('Rates:$usdToInrRate');

      setState(() {
        conversionRate=usdToInrRate;
      });

    }
    catch(e){
      print('Failed to fetch conversion rate:$e');
    }
  }
  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController   =TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Currency Converter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            const SizedBox(height: 140,),
            const Text(
              'Hello User',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 40,),
        Text(
          result.toString(),
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: textEditingController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Please enter the amount in USD',

                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: const Icon(Icons.monetization_on),
                  prefixIconColor: Colors.black,
                  filled: true,
                  fillColor: Colors.white,

                  enabledBorder: OutlineInputBorder(
                    // Color(0xAARRGGBB)
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(40),

                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: () {
                  try{
                    setState(() {
                      result = double.parse(textEditingController.text) * conversionRate ;
                      print('Result: $result');
                    });
                  }
                  catch (e){
                    print('Failed to parse input:$e');
                  }

                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Convert'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
