import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: App()));
}

final myProvider = FutureProvider<String>((ref) {
  return Future.delayed(Duration(seconds: 2), () => 'This is a test');
});

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final huh = watch(myProvider).data?.value;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              huh == null ? 'Test' : huh,
              style: TextStyle(color: huh == null ? Colors.red : Colors.green, fontSize: 55.0),
            ),
          ),
          Slash(),
        ],
      ),
    );
  }
}

class Slash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer(
        builder: (context, watch, child) {
          final s = watch(myProvider);
          print(s.runtimeType);
          return s.when(
              error: (err, stack) => Text('uh oh!'),
              loading: () => CircularProgressIndicator(),
              data: (data) {
                return Text(data);
              },
          );
        },
      ),
    );
  }
}

