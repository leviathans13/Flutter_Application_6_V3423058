import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(MaterialApp(home: MainApp()));
}

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainState();
  }
}

class MainState extends State<MainApp> {
  num count = 0;
  bool statusWarna = true;
  Color warna = Colors.cyan;

  void increase() {
    count += 1;
  }

  void decrease() {
    count -= 1;
  }

  Future<void> setColor(num pilihan) async {
    bool? confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Perubahan Warna'),
          content: const Text('Apakah Anda yakin ingin mengubah warna?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      setState(() {
        if (pilihan == 1) {
          warna = Colors.cyan;
        } else if (pilihan == 2) {
          warna = Colors.orange;
        } else if (pilihan == 3) {
          statusWarna = true;
        } else if (pilihan == 4) {
          statusWarna = false;
        }
      });
    }
  }

  void _openColorPicker() {
    Color tempColor = warna; // Warna sementara untuk konfirmasi

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Warna'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: tempColor,
              onColorChanged: (Color newColor) {
                tempColor = newColor; // Perbarui warna sementara
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup tanpa menyimpan warna
              },
            ),
            TextButton(
              child: const Text('Pilih'),
              onPressed: () async {
                bool? confirm = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Konfirmasi Perubahan Warna'),
                      content: const Text('Apakah Anda yakin ingin menyimpan warna ini?'),
                      actions: [
                        TextButton(
                          child: const Text('Tidak'),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                        TextButton(
                          child: const Text('Ya'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    );
                  },
                );

                if (confirm == true) {
                  setState(() {
                    warna = tempColor; // Simpan warna jika konfirmasi "Ya"
                  });
                }
                Navigator.of(context).pop(); // Menutup dialog ColorPicker
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter & Color Picker"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$count",
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        decrease();
                      });
                    },
                    child: const Text("-"),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        increase();
                      });
                    },
                    child: const Text("+"),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: 100,
                height: 100,
                color: statusWarna ? Colors.red : Colors.green,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setColor(3);
                    },
                    child: const Text("Red"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setColor(4);
                    },
                    child: const Text("Green"),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: 100,
                height: 100,
                color: warna,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setColor(1);
                    },
                    child: const Text("Cyan"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setColor(2);
                    },
                    child: const Text("Orange"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _openColorPicker,
                child: const Text("Pilih Warna Custom"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
