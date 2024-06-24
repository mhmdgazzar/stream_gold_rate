import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stream_gold_rate/src/features/gold/data/fake_gold_api.dart';

class GoldScreen extends StatelessWidget {
  const GoldScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 24),
                Text('Live Kurs:',
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 20),
                StreamBuilder(
                  stream: getGoldPriceStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done ||
                        snapshot.connectionState == ConnectionState.active) {
                      final response = snapshot.data;
                      return Text(
                        NumberFormat.simpleCurrency(locale: 'de_DE')
                            .format(response),
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                color: Theme.of(context).colorScheme.primary),
                      );
                    } else if (snapshot.connectionState !=
                        ConnectionState.done) {
                      return const CircularProgressIndicator();
                    } else {
                      return const Icon(Icons.error);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage('assets/bars.png'),
          width: 100,
        ),
        Text('Gold', style: Theme.of(context).textTheme.headlineLarge),
      ],
    );
  }
}
