all:
	mkdir -p bin/include
	mkdir -p bin/lib
	cp src/*.h bin/include/
	g++ -c -I dependency/simple_log/include/ -I dependency/json-cpp/include/ -I src src/http_parser.cpp -o bin/http_parser.o
	g++ -c -I dependency/simple_log/include/ -I dependency/json-cpp/include/ -I src src/http_server.cpp -o bin/http_server.o
	ar -rcs libsimpleserver.a bin/*.o
	mv libsimpleserver.a bin/lib/
	rm -rf bin/*.o
test: test/http_server_test.cpp test/http_parser_test.cpp
	g++ -I dependency/simple_log/include/ -I dependency/json-cpp/include/ -I bin/include test/http_server_test.cpp dependency/simple_log/lib/libsimplelog.a dependency/json-cpp/lib/libjson_libmt.a bin/lib/libsimpleserver.a -o bin/http_server_test
	g++ -I dependency/simple_log/include/ -I dependency/json-cpp/include/ -I bin/include test/http_parser_test.cpp dependency/simple_log/lib/libsimplelog.a bin/lib/libsimpleserver.a dependency/json-cpp/lib/libjson_libmt.a -o bin/http_parser_test
	