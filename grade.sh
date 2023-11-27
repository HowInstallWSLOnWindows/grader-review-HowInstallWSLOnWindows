CPATH='.:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

if [[ -e ./student-submission/ListExamples.java ]]; then
    cp -r ./student-submission/*.java ./grading-area/
    cp -r ./TestListExamples.java ./grading-area/

    cd grading-area

    javac -cp $CPATH ./*.java

    if [ $? -eq 0 ]; then
        junit_output=$(java -cp $CPATH org.junit.runner.JUnitCore TestListExamples 2>&1)

        if echo "$junit_output" | grep -q "OK (1 test)"; then

            echo "passed"
        else
            echo "failed"
            echo "JUnit Output:"
            echo "$junit_output"
        fi

    else
        echo "Compilation failed."
    fi

    cd ..
else
    echo "Error: ListExamples.java not found in student submission."
fi