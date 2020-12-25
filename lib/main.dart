import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// DB用意するのは面倒なので省略します
class DummyFirestoreRepository {
  Future<int> getCount(String document) async => await Future.value(100);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  final DummyFirestoreRepository repos = DummyFirestoreRepository();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _documentCount = 0;

  @override
  void initState() {
    super.initState();
    initCount();
    // 短い処理なので、initCount 関数を作らずに以下のようにしてもよい
    // widget.repos
    //  .getCount('hogehoge')
    //  .then((count) => setState(() => _documentCount = count));
  }

  Future<void> initCount() async {
    final count = await widget.repos.getCount('hogehoge');
    setState(() => _documentCount = count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Future Demo Project'),
        ),
        body: Center(
          child: Text(
            '$_documentCount',
            style: Theme.of(context).textTheme.headline4,
          ),
        ));
  }
}
