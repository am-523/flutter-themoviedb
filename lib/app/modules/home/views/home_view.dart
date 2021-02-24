import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hypemovies/app/data/models/enum.dart';
import 'package:hypemovies/app/views/button_widgets.dart';
import 'package:hypemovies/app/views/label.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  // HomeController hc = Get.find<HomeController>();
  TextEditingController _searchController = new TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    Size size = context.mediaQuery.size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('HomeView'),
      //   centerTitle: true,
      // ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              width: size.width,
              height: 250,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          "https://source.unsplash.com/500x300/?design",
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(40.0),
                                ),
                              ),
                              child: TextField(
                                controller: _searchController,
                                keyboardType: TextInputType.text,
                                onSubmitted: (v) {
                                  Get.toNamed("/search/${_searchController.text}/1");
                                },
                                decoration: InputDecoration(
                                  hintText: "Search for movies,tv show...",
                                  focusColor: Colors.redAccent,
                                  fillColor: Colors.white70,
                                  suffixIcon: IconButton(
                                    color: Colors.redAccent,
                                    icon: Icon(Icons.search),
                                    onPressed: () {
                                      Get.toNamed("/search/${_searchController.text}/1");
                                    },
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                    borderSide: BorderSide(color: Colors.white, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                    borderSide: BorderSide(color: Colors.redAccent, width: 2),
                                  ),
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                CustomButton(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 10,
                                  ),
                                  onTap: () {
                                    // Get.find<HomeController>().getM();
                                  },
                                  text: 'Movies',
                                ),
                                CustomButton(
                                  firstColor: Colors.yellow,
                                  secondColor: Colors.orangeAccent,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 10,
                                  ),
                                  onTap: () {},
                                  text: 'Tv Series',
                                ),
                                CustomButton(
                                  firstColor: Colors.orangeAccent,
                                  secondColor: Colors.red,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 10,
                                  ),
                                  onTap: () {},
                                  text: 'Live',
                                ),
                                CustomButton(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 10,
                                  ),
                                  onTap: () {},
                                  text: 'Action',
                                ),
                                CustomButton(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 10,
                                  ),
                                  onTap: () {},
                                  text: 'Drama',
                                ),
                                CustomButton(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 10,
                                  ),
                                  onTap: () {},
                                  text: 'Documentary',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: LabelWidgets(
              firstText: "Trending",
              secondText: null,
              onTap: () {},
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              width: size.width,
              child: GetX<HomeController>(
                init: Get.find(),
                builder: (val) {
                  return ListView.builder(
                    itemCount: val.trending.value.results == null ? 0 : val.trending.value.results.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, int i) {
                      return GestureDetector(
                        onTap: () {
                          String route = "/detail/${mediaTypeValues.reverse[val.trending.value.results[i].mediaType]}/${val.trending.value.results[i].id}";
                          Get.toNamed(route);
                        },
                        child: Container(
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Column(
                            children: [
                              Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider("https://image.tmdb.org/t/p/w500${val.trending.value.results[i].posterPath}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  val.trending.value.results[i].title == null ? val.trending.value.results[i].name : val.trending.value.results[i].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: LabelWidgets(
              firstText: "Discover Movies",
              secondText: "View All",
              onTap: () {
                // Get.toNamed("/list/popular");
                // hc.fetchData();
                // print(hc.movies.value);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              width: size.width,
              child: GetX<HomeController>(
                init: Get.find(),
                builder: (val) {
                  return ListView.builder(
                    itemCount: val.movies.value.results == null ? 0 : val.movies.value.results.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, int i) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed("/detail/movie/${val.movies.value.results[i].id}");
                        },
                        child: Container(
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Column(
                            children: [
                              Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider("https://image.tmdb.org/t/p/w500${val.movies.value.results[i].posterPath}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "${val.movies.value.results[i].title}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: LabelWidgets(
              firstText: "Discover Tv",
              secondText: "View All",
              onTap: () {},
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              width: size.width,
              child: GetX<HomeController>(
                init: Get.find(),
                builder: (val) {
                  return ListView.builder(
                    itemCount: val.tv.value.results == null ? 0 : val.tv.value.results.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, int i) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed("/detail/tv/${val.tv.value.results[i].id}");
                        },
                        child: Container(
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Column(
                            children: [
                              Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider("https://image.tmdb.org/t/p/w500${val.tv.value.results[i].posterPath}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "${val.tv.value.results[i].name}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
