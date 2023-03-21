import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilderDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<String> getValue() async {
  await Future.delayed(Duration(seconds: 3));
  return 'Flutter Demo';
}

class FutureBuilderDemo extends StatefulWidget {
  var value=0;
  @override
  State<StatefulWidget> createState() {
    return _FutureBuilderDemoState ();
  }
}

class _FutureBuilderDemoState extends State<FutureBuilderDemo> {

  late Future<String> _value;

  @override
  initState() {
    super.initState();
    _value = getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text('Flutter FutureBuilder Demo'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: FutureBuilder<String>(
            future: _value,
            initialData: 'Demo Name',
            builder: (
                BuildContext context,
                AsyncSnapshot<String> snapshot,
                ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Visibility(
                      visible: snapshot.hasData,
                      child: Text(
                        snapshot.data??'',
                        style: const TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    )
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return Text(
                      snapshot.data??'',
                      style: const TextStyle(color: Colors.cyan, fontSize: 36)
                  );
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),
        ),
      ),
    );
  }
}