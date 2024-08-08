import 'dart:io';
import 'dart:math';

void main() {
  // List untuk menyimpan data input
  List<Map<String, double>> dataInput = [];

  // Mengambil input dari pengguna untuk jarak, massa, dan percepatan
  print('Masukkan jumlah data: ');
  int jumlahData = int.parse(stdin.readLineSync()!); // Perulangan (loop)

  for (int i = 0; i < jumlahData; i++) { // Perulangan (loop)
    print('Data ke-${i + 1}');
    print('Masukkan jarak (meter): ');
    double jarak = double.parse(stdin.readLineSync()!);

    print('Masukkan massa (kg): ');
    double massa = double.parse(stdin.readLineSync()!);

    print('Masukkan percepatan (cm/min^2): ');
    double percepatan = double.parse(stdin.readLineSync()!);

    // Menyimpan data ke dalam list
    dataInput.add({'jarak': jarak, 'massa': massa, 'percepatan': percepatan});
  }

  // Konversi percepatan dari cm/min^2 ke m/s^2 menggunakan map
  Set<double> percepatanSet = dataInput.map((data) {
    double percepatanMS2 = data['percepatan']! * 0.01 / 3600;
    return percepatanMS2;
  }).toSet();

  // Anonymous function untuk menghitung waktu gerak benda
  var hitungWaktu = (double jarak, double percepatan) {
    return sqrt((2 * jarak) / percepatan); // Operator
  };

  // Function untuk mengonversi detik ke menit dan detik
  String konversiKeMenit(double waktu) {
    int menit = waktu ~/ 60; // Pembagian integer untuk mendapatkan menit
    double detik = waktu % 60; // Sisa pembagian untuk mendapatkan detik
    return '$menit menit ${detik.toStringAsFixed(2)} detik';
  }

  // Function untuk mengonversi detik ke jam, menit, dan detik
  String konversiKeJam(double waktu) {
    int jam = waktu ~/ 3600; // Pembagian integer untuk mendapatkan jam
    double sisaMenit = (waktu % 3600) / 60; // Sisa pembagian untuk mendapatkan menit
    int menit = sisaMenit.toInt(); // Mendapatkan menit dari sisa
    double detik = (sisaMenit - menit) * 60; // Mendapatkan detik dari sisa
    return '$jam jam $menit menit ${detik.toStringAsFixed(2)} detik';
  }

  // Menghitung waktu dan menampung hasilnya dalam List
  List<double> waktuList = [];
  for (var data in dataInput) { // Perulangan (loop)
    double percepatanMS2 = data['percepatan']! * 0.01 / 3600;
    double waktu = hitungWaktu(data['jarak']!, percepatanMS2);
    waktuList.add(waktu);

    // Menampilkan hasil perhitungan dalam detik
    print('Waktu yang dibutuhkan untuk menempuh jarak ${data['jarak']} meter dengan percepatan ${data['percepatan']} cm/min^2 adalah ${waktu.toStringAsFixed(2)} detik.');

    // Mengubah waktu ke menit dan menampilkan hasilnya
    String waktuDalamMenit = konversiKeMenit(waktu);
    print('Waktu dalam menit: $waktuDalamMenit');

    // Mengubah waktu ke jam hanya jika lebih dari 1 jam
    if (waktu >= 3600) {
      String waktuDalamJam = konversiKeJam(waktu);
      print('Waktu dalam jam: $waktuDalamJam');
    }
  }

  // Inner function untuk mencetak data waktu dalam berbagai satuan
  void cetakDataWaktu() {
    for (var waktu in waktuList) {
      String waktuDalamMenit = konversiKeMenit(waktu);
      String waktuDalamJam = waktu >= 3600 ? konversiKeJam(waktu) : 'Kurang dari 1 jam';
      print('Waktu: ${waktu.toStringAsFixed(2)} detik, $waktuDalamMenit, $waktuDalamJam');
    }
  }

  // Memanggil inner function
  cetakDataWaktu();
}