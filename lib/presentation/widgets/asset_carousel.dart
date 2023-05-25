import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:financial_literacy_game/domain/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../config/color_palette.dart';
import '../../domain/concepts/asset.dart';

class AssetCarousel extends StatelessWidget {
  final List<Asset> assets;
  final AutoSizeGroup textGroup;
  final Function changingIndex;
  const AssetCarousel({
    Key? key,
    required this.assets,
    required this.textGroup,
    required this.changingIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // build widget to display from asset
    List<Widget> widgetList = [];
    for (Asset asset in assets) {
      widgetList.add(
        LayoutBuilder(builder: (context, constraints) {
          String assetName;
          switch (asset.type) {
            case AssetType.cow:
              {
                assetName = AppLocalizations.of(context)!.cow;
              }
              break;

            case AssetType.chicken:
              {
                assetName = AppLocalizations.of(context)!.chicken;
              }
              break;

            case AssetType.goat:
              {
                assetName = AppLocalizations.of(context)!.goat;
              }
              break;

            default:
              {
                assetName = AppLocalizations.of(context)!.chicken;
              }
              break;
          }

          return Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              color: ColorPalette().backgroundContentCard,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        '${asset.numberOfAnimals} x $assetName',
                        style: const TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(asset.imagePath, fit: BoxFit.cover),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: AutoSizeText(
                      AppLocalizations.of(context)!
                          .price(asset.price)
                          .capitalize(),
                      style: const TextStyle(
                        fontSize: 100,
                        color: Colors.white,
                      ),
                      group: textGroup,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: AutoSizeText(
                      AppLocalizations.of(context)!
                          .incomePerYear(asset.income)
                          .capitalize(),
                      style: const TextStyle(
                        fontSize: 100,
                        color: Colors.white,
                      ),
                      group: textGroup,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: AutoSizeText(
                      AppLocalizations.of(context)!
                          .lifeExpectancy(asset.lifeExpectancy)
                          .capitalize(),
                      style: const TextStyle(
                        fontSize: 100,
                        color: Colors.white,
                      ),
                      group: textGroup,
                    ),
                  ),
                  if (asset.riskLevel > 0)
                    Expanded(
                      flex: 2,
                      child: AutoSizeText(
                        AppLocalizations.of(context)!
                            .lifeRisk((100 / (asset.riskLevel * 100))
                                .toStringAsFixed(0))
                            .capitalize(),
                        style: TextStyle(
                          fontSize: 100,
                          color: Colors.grey[200],
                        ),
                        group: textGroup,
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      );
    }

    return CarouselSlider(
      options: CarouselOptions(
          aspectRatio: 1.0,
          //viewportFraction: 0.8,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) {
            changingIndex(index);
          }),
      items: widgetList,
    );
  }
}
