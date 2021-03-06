RBO_VENV=venv-rbo-package-test

# Run a packaging test.
# At least, this requires setup.py to be executable,
# all dependencies to be properly specified,
# and proper imports in rbo/__init__.py.
# CAUTION: this will remove the directory $VENV in the current working directory.
package_test:
	rm -rf $(RBO_VENV)
	pip3 install virtualenv && virtualenv $(RBO_VENV)
	. $(RBO_VENV)/bin/activate  && \
	python3 setup.py sdist && \
	python3 setup.py install && \
	python3 -c "import rbo; assert rbo.RankingSimilarity([1], [1]).rbo() == 1"

test: package_test
	. $(RBO_VENV)/bin/activate  && \
	python3 test.py && \
	rm -rf build dist *.egg-info $(RBO_VENV)
