import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/http/dio_agent.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class HomePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance=ScreenUtil(width: 750,height: 1334)
      ..init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活+"),
      ),
      body: FutureBuilder(
        future: getHomeContent(),
          builder: (context,snapshot)
              {
                if(snapshot.hasData)
                  {
                    var data=json.decode(snapshot.data.toString());
                    List<Map> swiperDataList=(data['data']['slides'] as List).cast();
                    return Column(
                      children: <Widget>[

                        SwiperWidget(items: swiperDataList)
                      ],
                    );
                  }
                else
                  {
                    return Container(
                      alignment: Alignment.topCenter,
                      //loading效果
                      child: Text("加载中。。。"),
                    );
                  }
              }
      ),
    );
  }
}

class SwiperWidget extends StatelessWidget
{
  SwiperWidget({Key key,this.items}):super(key:key);
  List<Map> items;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.instance.setWidth(750),
      height: ScreenUtil.instance.setHeight(333),
      child: Swiper(
        itemCount: items.length,
        autoplay: true,
        //指示条
        pagination: SwiperPagination(),
        itemBuilder: (context,index){
          return Image.network("${items[index]['image']}",fit: BoxFit.fill);
        },
      ),
    );
  }
  
}