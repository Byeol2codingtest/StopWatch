import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int secs = 0, mins = 0, hours = 0;
  String digitSecs = "00", digitMins = "00", digitHours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  // creating the stop timer function
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  // creating the reset function

  void reset() {
    timer!.cancel();
    setState(() {
      secs = 0;
      mins = 0;
      hours = 0;
      digitSecs = "00";
      digitMins = "00";
      digitHours = "00";
      started = false;
    });
  }

  void addLaps() {
    String lap = "$digitHours:$digitMins:$digitSecs";
    setState(() {
      laps.add(lap);
    });
  }

  // creating the start timer function
  void start() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSecs = secs + 1;
      int localMins = mins;
      int localHours = hours;
      if (localSecs > 59) {
        if (localMins > 59) {
          localHours++;
          localMins = 0;
        } else {
          localMins++;
          localSecs = 0;
        }
      }
      setState(() {
        secs = localSecs;
        mins = localMins;
        hours = localHours;
        digitSecs = (secs >= 10) ? "$secs" : "0$secs";
        digitMins = (mins >= 10) ? "$mins" : "0$mins";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1c2757),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  "StopWatch App",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "$digitHours:$digitMins:$digitSecs",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 82,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  color: const Color(0xFF323f68),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lap n${index + 1}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${laps[index]}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              Row(
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        (!started) ? start() : stop();
                      },
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                      child: Text(
                        (!started) ? "Start" : "Stop",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  IconButton(
                    color: Colors.white,
                    onPressed: () {
                      addLaps();
                    },
                    icon: const Icon(Icons.flag),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        reset();
                      },
                      fillColor: Colors.blue,
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                      child: const Text(
                        "Reset",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
