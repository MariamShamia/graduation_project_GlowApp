// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:Glow/controllers/fb_auth_controller.dart';
// import 'package:Glow/constants.dart';
// import 'package:Glow/widgets/my_drawer.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   String nameText = '';
//   String skinTypeText = '';
//   String ageText = '';
//   List<String> skinConcernsText = [];
//   List<Map<String, dynamic>> skincareRoutines = [];
//   bool isDermatologist = false; // Define the variable

//   @override
//   void initState() {
//     super.initState();
//     _getdata();
//     _getSkincareRoutines();
//   }

//   User user = FbAuthController().user;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Column(
//           children: [
//             Image.asset(
//               'images/buttrfly.jpg',
//               width: 20,
//               height: 20,
//               alignment: Alignment.bottomCenter,
//             ),
//             const Text(
//               'My Profile',
//               style: TextStyle(color: kTitleColor),
//             ),
//           ],
//         ),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         drawer: MyDrawer(isDermatologist: isDermatologist, currentPage: 'profile'),
//         actions: [
//           IconButton(
//             onPressed: () =>
//                 Navigator.pushNamed(context, '/edit_profile_screen'),
//             icon: const Icon(Icons.edit_outlined, color: kTitleColor),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           Image.asset(
//             'images/background.png',
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   buildProfileField("Name", nameText),
//                   buildProfileField("Age", ageText),
//                   buildProfileField("Skin Type", skinTypeText),

//                   // Concerns Section
//                   const Text(
//                     "Concerns",
//                     style: TextStyle(
//                       color: kTitleColor,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   skinConcernsText.isEmpty
//                       ? const Center(
//                           child: Text(
//                             'There are no concerns',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: kTitleColor,
//                             ),
//                           ),
//                         )
//                       : Wrap(
//                           spacing: 10,
//                           children: skinConcernsText
//                               .map((concern) => Chip(
//                                     label: Text(
//                                       concern,
//                                       style:
//                                           const TextStyle(color: kTitleColor),
//                                     ),
//                                     backgroundColor:
//                                         kPrimaryColor.withOpacity(0.2),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                   ))
//                               .toList(),
//                         ),

//                   const SizedBox(height: 20),

//                   // Skincare Routine Section
//                   Row(
//                     children: [
//                       const Text(
//                         "Skincare routine",
//                         style: TextStyle(
//                           color: kTitleColor,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.save,
//                             color: kTitleColor, size: 20),
//                         onPressed: () {
//                           // Add your save functionality here
//                         },
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   skincareRoutines.isEmpty
//                       ? const Center(
//                           child: Text(
//                             'No Routines saved yet.',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: kTitleColor,
//                             ),
//                           ),
//                         )
//                       //
//                       : ListView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: skincareRoutines.length,
//                           itemBuilder: (context, index) {
//                             final routine = skincareRoutines[index];
//                             return Card(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               elevation: 3,
//                               child: ListTile(
//                                 leading: Image.network(
//                                   routine['image'],
//                                   width: 50,
//                                   height: 50,
//                                   fit: BoxFit.cover,
//                                 ),
//                                 title: Text(
//                                   routine['name'],
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 subtitle: Text(
//                                   routine['description'] ?? '',
//                                   style: const TextStyle(fontSize: 12),
//                                 ),
//                               ),
//                             );
//                           },
//                         )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildProfileField(String title, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             color: kTitleColor,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 5),
//         TextField(
//           controller: TextEditingController(text: value),
//           style: const TextStyle(color: kTitleColor),
//           readOnly: true,
//           decoration: InputDecoration(
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: Colors.grey),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: kPrimaryColor),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }

//   void _getdata() async {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .snapshots()
//         .listen((userData) {
//       setState(() {
//         nameText = userData.data()?['name'] ?? '';
//         skinTypeText = userData.data()?['skinType'] ?? '';
//         ageText = userData.data()?['age']?.toString() ?? '';
//         skinConcernsText =
//             List<String>.from(userData.data()?['skinConcerns'] ?? []);
//       });
//     });
//   }

//   // void _getSkincareRoutines() async {
//   //   FirebaseFirestore.instance
//   //       .collection('routines')
//   //       .where('userId', isEqualTo: user.uid)
//   //       .get()
//   //       .then((querySnapshot) {
//   //     setState(() {
//   //       skincareRoutines = querySnapshot.docs
//   //           .map((doc) => {
//   //                 'name': doc['name'] ?? '',
//   //                 'image': doc['image'] ?? '',
//   //                 'description': doc['description'] ?? '',
//   //               })
//   //           .toList();
//   //     });
//   //   });
//   // }
//   void _getSkincareRoutines() async {
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .snapshots()
//         .listen((userData) {
//       setState(() {
//         skincareRoutines = List<Map<String, dynamic>>.from(
//           userData.data()?['savedRoutines'] ?? [],
//         );
//       });
//     });
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Glow/controllers/fb_auth_controller.dart';
import 'package:Glow/constants.dart';
import 'package:Glow/widgets/my_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String nameText = '';
  String skinTypeText = '';
  String ageText = '';
  List<String> skinConcernsText = [];
  List<Map<String, dynamic>> skincareRoutines = [];
  bool isDermatologist = false;

  @override
  void initState() {
    super.initState();
    _getData();
    _getSkincareRoutines();
  }

  final User user = FbAuthController().user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Image.asset(
              'images/buttrfly.jpg',
              width: 20,
              height: 20,
              alignment: Alignment.bottomCenter,
            ),
            const Text(
              'My Profile',
              style: TextStyle(color: kTitleColor),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, '/edit_profile_screen'),
            icon: const Icon(Icons.edit_outlined, color: kTitleColor),
          ),
        ],
      ),
      drawer: MyDrawer(
          isDermatologist: isDermatologist, currentPage: '/profile_screen'),
      body: Stack(
        children: [
          Image.asset(
            'images/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildProfileField("Name", nameText),
                  buildProfileField("Age", ageText),
                  buildProfileField("Skin Type", skinTypeText),

                  // Concerns Section
                  const Text(
                    "Concerns",
                    style: TextStyle(
                      color: kTitleColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  skinConcernsText.isEmpty
                      ? const Center(
                          child: Text(
                            'There are no concerns',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kTitleColor,
                            ),
                          ),
                        )
                      : Wrap(
                          spacing: 10,
                          children: skinConcernsText
                              .map((concern) => Chip(
                                    label: Text(
                                      concern,
                                      style:
                                          const TextStyle(color: kTitleColor),
                                    ),
                                    backgroundColor:
                                        kPrimaryColor.withOpacity(0.2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ))
                              .toList(),
                        ),
                  const SizedBox(height: 20),

                  // Skincare Routine Section
                  Row(
                    children: [
                      const Text(
                        "Skincare Routine",
                        style: TextStyle(
                          color: kTitleColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.save,
                            color: kTitleColor, size: 20),
                        onPressed: () {
                          // Add your save functionality here
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  skincareRoutines.isEmpty
                      ? const Center(
                          child: Text(
                            'No Routines saved yet.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kTitleColor,
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: skincareRoutines.length,
                          itemBuilder: (context, index) {
                            final routine = skincareRoutines[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: ListTile(
                                leading: Image.network(
                                  routine['image'],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  routine['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  routine['description'] ?? '',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileField(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: kTitleColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: TextEditingController(text: value),
          style: const TextStyle(color: kTitleColor),
          readOnly: true,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: kPrimaryColor),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  void _getData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .listen((userData) {
      setState(() {
        nameText = userData.data()?['name'] ?? '';
        skinTypeText = userData.data()?['skinType'] ?? '';
        ageText = userData.data()?['age']?.toString() ?? '';
        skinConcernsText =
            List<String>.from(userData.data()?['skinConcerns'] ?? []);
      });
    });
  }

  void _getSkincareRoutines() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .listen((userData) {
      setState(() {
        skincareRoutines = List<Map<String, dynamic>>.from(
          userData.data()?['savedRoutines'] ?? [],
        );
      });
    });
  }
}
