import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Downloader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: MyHomePage(title: 'تحميل وتقطيع الفيديو'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _videoNameController = TextEditingController();
  bool _isLoading = false;
  final List<String> _reels = [];

  void _downloadAndCutVideo() {
    if (_videoNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء إدخال اسم الفيلم أو الفيديو'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      // Simulate network request and video processing
      _reels.clear();
    });

    // NOTE: This is a simulation.
    // The actual implementation of downloading and cutting videos
    // requires a backend service and is not implemented here.
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
        // Create dummy reel data
        for (int i = 1; i <= 10; i++) {
          _reels.add('"${_videoNameController.text}" - مقطع ريلز ${i}');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _videoNameController,
              decoration: const InputDecoration(
                labelText: 'اسم الفيلم أو الفيديو',
                border: OutlineInputBorder(),
                hintText: 'ادخل اسم المحتوى هنا',
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _downloadAndCutVideo,
              icon: const Icon(Icons.download),
              label: const Text('تحميل وتقطيع'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('جاري التحميل والتقطيع...')
                  ],
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _reels.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.video_collection),
                        title: Text(_reels[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () {
                            // NOTE: Sharing functionality requires a package like 'share_plus'
                            // and is not fully implemented here.
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('مشاركة "${_reels[index]}"'),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
