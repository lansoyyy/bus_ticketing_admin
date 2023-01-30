import 'package:bus_ticketing_admin/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RidesTab extends StatelessWidget {
  const RidesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: BoldText(
                      label: 'Ride History',
                      fontSize: 38,
                      color: Colors.black)),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Card(
                  child: Container(
                    color: Colors.white,
                    height: 150,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.bus_alert_sharp,
                                size: 54,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              BoldText(
                                  label: 'No. of Rides',
                                  fontSize: 24,
                                  color: Colors.black),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Rides')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  print(snapshot.error);
                                  return const Center(child: Text('Error'));
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  print('waiting');
                                  return const Padding(
                                    padding: EdgeInsets.only(top: 50),
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.black,
                                    )),
                                  );
                                }

                                final data = snapshot.requireData;
                                return Align(
                                  alignment: Alignment.bottomCenter,
                                  child: BoldText(
                                      label: data.size.toString(),
                                      fontSize: 38,
                                      color: Colors.black),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Rides')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Center(child: Text('Error'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print('waiting');
                      return const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.black,
                        )),
                      );
                    }

                    final data = snapshot.requireData;
                    return Align(
                      alignment: Alignment.topLeft,
                      child: DataTable(columns: [
                        DataColumn(
                            label: NormalText(
                                label: 'No.',
                                fontSize: 18,
                                color: Colors.black)),
                        DataColumn(
                            label: NormalText(
                                label: 'Name',
                                fontSize: 18,
                                color: Colors.black)),
                        DataColumn(
                            label: NormalText(
                                label: 'Origin',
                                fontSize: 18,
                                color: Colors.black)),
                        DataColumn(
                            label: NormalText(
                                label: 'Destination',
                                fontSize: 18,
                                color: Colors.black)),
                        DataColumn(
                            label: NormalText(
                                label: 'Fare',
                                fontSize: 18,
                                color: Colors.black)),
                      ], rows: [
                        for (int i = 0; i < data.size; i++)
                          DataRow(cells: [
                            DataCell(
                              NormalText(
                                  label: i.toString(),
                                  fontSize: 16,
                                  color: Colors.grey),
                            ),
                            DataCell(
                              NormalText(
                                  label: data.docs[i]['name'],
                                  fontSize: 16,
                                  color: Colors.grey),
                            ),
                            DataCell(
                              NormalText(
                                  label: data.docs[i]['from'],
                                  fontSize: 16,
                                  color: Colors.grey),
                            ),
                            DataCell(
                              NormalText(
                                  label: data.docs[i]['to'],
                                  fontSize: 16,
                                  color: Colors.grey),
                            ),
                            DataCell(
                              NormalText(
                                  label: data.docs[i]['payment'],
                                  fontSize: 16,
                                  color: Colors.grey),
                            ),
                          ])
                      ]),
                    );
                  }),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
