import 'package:flutter/material.dart';
import 'package:tarea_s4/Types/news.dart';
import 'package:http/http.dart' as http;
//API key
//abafed00887c4ff99e40cf8e9d67fc75
class MyOwnWidget extends StatefulWidget {
  const MyOwnWidget({super.key});

  @override
  State<MyOwnWidget> createState() => _MyOwnWidgetState();
}

class _MyOwnWidgetState extends State<MyOwnWidget> {

//News? news;
List<Article> articles = [];

@override
void initState()
{
  super.initState();
  getDataAPI();
}

Future getDataAPI() async
{
  String url = 'https://newsapi.org/v2/everything?q=tesla&from=2024-04-13&sortBy=publishedAt&apiKey=abafed00887c4ff99e40cf8e9d67fc75';
  final response = await http.get(Uri.parse(url));

  if(response.statusCode == 200)
  {
    //print('se obtuvieron los datos');
      News news = newsFromJson(response.body);     
      //print('resultados: ${news?.totalResults}'); 
      articles = news.articles;
      setState(()
      {
        News news = newsFromJson(response.body);     
      //print('resultados: ${news?.totalResults}'); 
        articles = news.articles;
      }

      );
      //print('total de elementos en articles: ${articles.length}');
  }

}



  @override
  Widget build(BuildContext context) {
    //print('articulos en tiempo de construccion: ${articles.length}');
    return Scaffold(
    appBar: AppBar(
      title: const Text('News API')
    ),
    body: (articles.isEmpty) ? const Center(child: Text('No se pudieron recibir los datos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),) : 
      
        ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index)
          {
            return ListTile(
              title: Text('${articles[index].author}'),
              subtitle: Text(articles[index].title),
              onTap: ()
                {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('descripcion: ${articles[index + 1].description}'),
                      )
                    );
                }
            );
        
          },
        ),
      
    );
    
  }
}