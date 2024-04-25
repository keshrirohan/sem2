import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(SmartAgricultureApp());
}

class SmartAgricultureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Agriculture',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Agriculture Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SensorCard(
              title: 'Soil Moisture (Depth 1)',
              value: '60%',
              icon: Icons.opacity,
              color: Colors.green,
            ),
            SensorCard(
              title: 'Soil Moisture (Depth 2)',
              value: '50%',
              icon: Icons.opacity,
              color: Colors.green,
            ),
            SensorCard(
              title: 'Soil Moisture (Depth 3)',
              value: '40%',
              icon: Icons.opacity,
              color: Colors.green,
            ),
            SensorCard(
              title: 'Ambient Temperature',
              value: '25°C',
              icon: Icons.thermostat,
              color: Colors.orange,
            ),
            SensorCard(
              title: 'Relative Humidity',
              value: '70%',
              icon: Icons.water_drop,
              color: Colors.blue,
            ),
            SensorCard(
              title: 'Barometric Pressure',
              value: '1013 hPa',
              icon: Icons.compress,
              color: Colors.deepPurple,
            ),
            SensorCard(
              title: 'Pest and Bird Noise',
              value: 'Detected',
              icon: Icons.bug_report,
              color: Colors.red,
            ),
            SizedBox(height: 16.0),
            Text(
              'Soil Moisture Trends',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              height: 200,
              child: charts.TimeSeriesChart(
                _createSampleData(),
                animate: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<charts.Series<TimeSeriesData, DateTime>> _createSampleData() {
    final data = [
      TimeSeriesData(DateTime(2022, 1, 1), 50),
      TimeSeriesData(DateTime(2022, 1, 2), 55),
      TimeSeriesData(DateTime(2022, 1, 3), 60),
      TimeSeriesData(DateTime(2022, 1, 4), 65),
      TimeSeriesData(DateTime(2022, 1, 5), 70),
    ];

    return [
      charts.Series<TimeSeriesData, DateTime>(
        id: 'Soil Moisture',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesData sales, _) => sales.time,
        measureFn: (TimeSeriesData sales, _) => sales.value,
        data: data,
      )
    ];
  }
}

class SensorCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const SensorCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 48.0,
              color: color,
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Value: $value',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimeSeriesData {
  final DateTime time;
  final int value;

  TimeSeriesData(this.time, this.value);
}
