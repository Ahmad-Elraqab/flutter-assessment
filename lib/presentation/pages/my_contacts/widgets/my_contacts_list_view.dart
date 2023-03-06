import 'package:assessment/domain/entities/contact_entities/contact_entity.dart';
import 'package:assessment/presentation/pages/my_contacts/viewmodels/user_viewmodel.dart';
import 'package:assessment/presentation/pages/my_contacts/viewmodels/user_widget_viewmodel.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyContactsListView extends StatefulWidget {
  const MyContactsListView({
    super.key,
  });

  @override
  State<MyContactsListView> createState() => _MyContactsListViewState();
}

class _MyContactsListViewState extends State<MyContactsListView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 29.0,
          ),
          Consumer2<UserViewmodel, UserWidgetViewmodel>(
            builder: (context, value, value2, child) {
              final List<ContactEntity> data = value2.isAll!
                  ? value.users!
                      .where(
                        (e) =>
                            e.first_name!.toLowerCase().startsWith(
                                  value2.searchController.toLowerCase(),
                                ) ||
                            e.last_name!.toLowerCase().startsWith(
                                  value2.searchController.toLowerCase(),
                                ),
                      )
                      .toList()
                  : value.users!
                      .where(
                        (e) => value.favourite.favourite.contains(e),
                      )
                      .where(
                        (e) =>
                            e.first_name!.toLowerCase().startsWith(
                                  value2.searchController.toLowerCase(),
                                ) ||
                            e.last_name!.toLowerCase().startsWith(
                                  value2.searchController.toLowerCase(),
                                ),
                      )
                      .toList()
                      .toList();
              return Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => Slidable(
                    closeOnScroll: true,
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.27,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Positioned(
                                top: 5.0,
                                child: Container(
                                  margin: EdgeInsets.zero,
                                  width: 126.0,
                                  height: 51.0,
                                  color:
                                      const Color(0XFF32BAA5).withOpacity(0.1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 21.0,
                                        width: 21.0,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/edit.png'),
                                          ),
                                        ),
                                        margin:
                                            const EdgeInsets.only(right: 22.0),
                                      ),
                                      Container(
                                        color: const Color(0XFFC5E2DE),
                                        width: 2.0,
                                        height: 36.0,
                                      ),
                                      Container(
                                        height: 24.01,
                                        width: 19.43,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/delete.png'),
                                          ),
                                        ),
                                        margin:
                                            const EdgeInsets.only(left: 21.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    child: Container(
                      height: 64.0,
                      margin: const EdgeInsets.only(bottom: 12.0),
                      padding: const EdgeInsets.only(
                        left: 36.0,
                        right: 21.0,
                      ),
                      // color: Colors.amberAccent,
                      child: ElevatedButton(
                        onPressed: () => {context.navigateNamedTo('/profile')},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                          overlayColor: MaterialStatePropertyAll(
                            const Color(0XFF32BAA5).withOpacity(0.1),
                          ),
                          elevation: const MaterialStatePropertyAll(0),
                          padding:
                              const MaterialStatePropertyAll(EdgeInsets.zero),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            // color: const Color(0XFF32BAA5)
                            //     .withOpacity(0.1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 48.0,
                                height: 48.0,
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      data[index].avatar.toString(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${data[index].first_name} ${data[index].last_name}',
                                        style: GoogleFonts.raleway(
                                          color: const Color(0XFF1B1A57),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      value.favourite.favourite
                                              .contains(data[index])
                                          ? InkWell(
                                              onTap: () => context
                                                  .read<UserViewmodel>()
                                                  .deleteFromFavourite(
                                                    data[index],
                                                  ),
                                              child: const SizedBox(
                                                width: 15.0,
                                                height: 14.0,
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/images/Vector.png'),
                                                ),
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () => context
                                                  .read<UserViewmodel>()
                                                  .addToFavourite(
                                                    data[index],
                                                  ),
                                              child: const SizedBox(
                                                width: 15.0,
                                                height: 14.0,
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/images/Vectorfav_icon.png'),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    data[index].email.toString(),
                                    style: GoogleFonts.lato(
                                      color: const Color(0XFF4F5E7B),
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              const Expanded(child: SizedBox()),
                              Container(
                                width: 27.0,
                                height: 23.0,
                                margin: const EdgeInsets.only(right: 10.0),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/Frame.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}