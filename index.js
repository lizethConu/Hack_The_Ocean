var http = require('http'); //Se importa el módulo HTTP
var url = require('url'); //Se importa el módulo URL
var fs = require('fs'); //Se importa el módulo File System

//create a server object:
http.createServer(function(req, res) {
    var q = url.parse(req.url, true);
    var filename = "./app/html" + q.pathname;
    fs.readFile(filename, function(err, data) {
        if (err) {
            res.writeHead(404, {'Content-Type': 'text/html;charset=utf-8'});
            return res.end("404 Not Found");
        } 
        res.writeHead(200, {'Content-Type': 'text/html'});
        res.write(data);
        return res.end();
    });
  }).listen(8080); //the server object listens on port 8080