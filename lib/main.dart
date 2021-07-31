import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shopping',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Temp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Temp extends StatefulWidget {
  @override
  _TempState createState() => _TempState();
}

class _TempState extends State<Temp> {
  PageController? _controller;
  Timer? _timer;
  int _currentPage = 0;
  List<String> _assets = <String>[
    'https://images.macrumors.com/article-new/2020/10/iphone12progold.jpg',
    'https://www.apple.com/newsroom/images/product/ipad/standard/apple_ipad-pro-spring21_hero_04202021_big.jpg.large.jpg',
    'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/macbook-pro-13-og-202011?wid=600&hei=315&fmt=jpeg&qlt=95&.v=1604347427000',
  ];
  List<String> _pageData = [
    'Meet the ultimate iPhone. With the fastest smartphone chip. A Pro camera system that’s killer in low light. A LiDAR Scanner for more realistic AR. And two great sizes to choose from — including our largest display ever.'
        ' Let’s see what this thing can do.'
        'Two new sizes for more screen than ever.'
        'The fastest chip ever in a smartphone.'
        'Impressive battery life.'
        'A design pushed right to the edge.'
        'Pro camera system with Night mode portraits.'
        'LiDAR Scanner for next-level AR and beyond.'
        'Ceramic Shield with 4x better drop performance.'
        'Big, bright, beautiful OLED display.'
        'MagSafe.Snap on the perfect accessory.'
        ' Blows other phones out of the water.'
        ' There’s no phone like iPhone.',
    'The new iPad combines tremendous capability with unmatched ease of use and versatility. With the powerful A12 Bionic chip, support for Apple Pencil and the Smart Keyboard, '
        'and the amazing new things you can do with iPadOS 14,'
        'now there’s even more to love about iPad.'
        'With iPad, getting work done is all hustle and no hassle.'
        'Edit a document while researching something on the web and making a '
        'FaceTime call to a colleague at the same time. Attach a full‑sized Smart Keyboard for comfortable typing.1 And for tasks that require more precision, support for a trackpad '
        'or mouse complements the familiar Multi‑Touch experience of iPad.',
    'It’s here. Our first chip designed specifically for Mac. Packed with an astonishing 16 billion transistors, the Apple M1 system on a chip (SoC) integrates the CPU, GPU, Neural Engine, I/O, and so much more onto a single tiny chip. With incredible performance, custom technologies, and industry-leading power efficiency,1 '
        'M1 is not just a next step for Mac — it’s another level entirely.'
        'Up to 9x faster.14 Even for a 16‑core Neural Engine, that’s a lot to process. Apps on MacBook Air can use machine learning (ML) to automatically retouch photos like a pro, make smart tools such as magic wands and audio filters more accurate at auto‑detection, and so much more.',
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController()
      ..addListener(() {
        if (_controller!.hasClients) {
          setState(() {
            _currentPage = _controller!.page!.toInt();
          });
        }
      });
    _timer = Timer.periodic(
      Duration(seconds: 30),
      (timer) {
        if (_controller!.page!.toInt() == _pageData.length - 1) {
          _controller!.animateToPage(
            0,
            duration: Duration(milliseconds: 250),
            curve: Curves.ease,
          );
        } else {
          _controller!.nextPage(
            duration: Duration(milliseconds: 250),
            curve: Curves.ease,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: PageView(
              controller: _controller,
              children: List.generate(
                3,
                (index) => Container(
                  alignment: Alignment.center,
                  color: Colors.black87,
                  child: Image.network(
                    _assets[index].toString(),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
                color: Colors.white38,
                child: RichText(
                  text: TextSpan(
                    text: _currentPage == 0
                        ? 'IPHONE 12 PRO (Rs.69,999)\n'
                        : _currentPage == 1
                            ? 'IPAD PRO (Rs.1,13,900)\n'
                            : 'MACBOOK AIR (Rs.92,900)\n',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: _pageData[_currentPage],
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                )
                // child: Text(_pageData[_currentPage]),
                ),
          ),
        ],
      ),
    );
  }
}
