Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E12C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 18:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 514C480944;
	Tue, 15 Apr 2025 20:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uOi9sk9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEF7582B32; Tue, 15 Apr 2025 20:10:32 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E922807B1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 20:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5fcef5dc742so1773444eaf.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744740628; x=1745345428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8c7WBV9EpPx4l34cNnTt1wkJHaNmIzCPPchJZwo9l1U=;
 b=uOi9sk9um+Z8mxOmNPxl8Q24Q9SlYXpHDXaH4CGMRV/5Rt0Q9Q6nk/l7D3jdi+s7xy
 uBfOawUdvwzW+4XWY9yNkX77VfHNQDc26u/Dybb4lXz1f/WTRu3eDUciKLLbgQGTIXY5
 vPSJZUQI7JZdWidTUOflEogx7zk93gkmOoRr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744740628; x=1745345428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8c7WBV9EpPx4l34cNnTt1wkJHaNmIzCPPchJZwo9l1U=;
 b=nDYYL5Ff9dxvXUyC65zFqHXYXZIHB4q6h9OdYvw2t7cdc2Ou47pD+fQ4eyS1QnfH0f
 Uaw6M1mXk4gICM1idqzgldzPtpRUlg8xA9OKY4+HG/xmbObREQUwTaikYxj709ApMd0r
 dnC7iX8dyyKrM5IFTP64hh4odJAv7HQ8dGY4A69mw4pIGzq89DfHLqGhYlBCm/ctbwTU
 XEIKVz/dzoDrGUR2HT8JmgSvvYDqTaKwYiwE4+f0BqC/OJPGhEbABTLIjy/0DNGoynlt
 7wDoCZw9hVaXljLhDkSAluWgB20Jpxt2WwviHhNjAqAbMiQmmMeC5XrO1S/zq7AaAYwJ
 7NWQ==
X-Gm-Message-State: AOJu0YwNjuX3VB2TJFt1Ir/fTm/Z9XYNhcAy9PJz90AtyXqz6ZDd9Oxl
 63EAuJUPxyG7gN9uV9SnH8OhENJH9uEmtBPwMu/+AAikjQLD4i+StwQlNU46JmdBUYzqqRgahcy
 W
X-Gm-Gg: ASbGncttIvpiSbB7sHxVC8NqsLDvvpI3o/VWt2ClPH4QlUK0IU+ATyzRY5BoM8YzMfL
 C2tUJ9QAv9xrYNlHX5Vvxsw3WIXm6n+vPtpCy5vSUdA6kW5xpiy3KqNUEjPWyXXDb1bZr6wizVc
 2MFWylgQtsl3j5vZYgQQJmDCF8T6ZuoXCSOmNpHQ82dIYOqE4I+XRVtcOrCu2wqvVFJqrQUu7x6
 xmYtcliyz3lDrlUKclZEsLD2OHhnQfo0xZGEJR5X+KG3jtk1PpR3eITq2Ji4ufBXCifz1eQSlSs
 UypHEfxenZJ0lcUKEh3nkHwB45+H62G5oZBvXVDvanOCUw/aV/adYPCDKwL7o1B7CqSKp/lPODu
 76wAWPiLzFkNGDEc=
X-Google-Smtp-Source: AGHT+IFQYtgO0ElYxo9vpvs4FY5EFa7DQJhVXyYHqRYzBJTe+JxnH2TwbBzYcFvpRqK+222evdFxSg==
X-Received: by 2002:a05:6871:c:b0:2c2:542b:bce4 with SMTP id
 586e51a60fabf-2d4c395e4e1mr150772fac.8.1744740628558; 
 Tue, 15 Apr 2025 11:10:28 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-400762d486dsm2497436b6e.24.2025.04.15.11.10.27
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 11:10:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] python: Use and refer to the venv module rather than
 virtualenv
Date: Tue, 15 Apr 2025 12:10:26 -0600
Message-ID: <20250415181026.652393-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Using some form of sandbox with Python modules is a long standing best
practice with the language. There are a number of ways to have a Python
sandbox be created. At this point in time, it seems the Python community
is moving towards using the "venv" module provided with Python rather
than a separate tool. To match that we make the following changes:

- Refer to a "Python sandbox" rather than virtualenv in comments, etc.
- Install the python3-venv module in our container and not virtualenv.
- In our CI files, invoke "python -m venv" rather than "virtualenv".
- In documentation, tell users to install python3-venv and not
  virtualenv.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml            | 10 +++++-----
 .gitlab-ci.yml                  | 10 +++++-----
 doc/build/gcc.rst               |  2 +-
 doc/develop/py_testing.rst      | 12 ++++++------
 tools/buildman/test.py          |  2 +-
 tools/buildman/toolchain.py     |  2 +-
 tools/docker/Dockerfile         |  5 ++---
 tools/u_boot_pylib/test_util.py |  2 +-
 8 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index cb787d32f142..cbf4ced19f91 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -90,7 +90,7 @@ stages:
     steps:
       - script: |
           set -e
-          virtualenv -p /usr/bin/python3 /tmp/venvhtml
+          python3 -m venv /tmp/venvhtml
           . /tmp/venvhtml/bin/activate
           pip install -r doc/sphinx/requirements.txt
           make htmldocs KDOC_WERROR=1
@@ -132,7 +132,7 @@ stages:
           git config --global user.email bmeng.cn@gmail.com
           git config --global --add safe.directory $(work_dir)
           export USER=azure
-          virtualenv -p /usr/bin/python3 /tmp/venv
+          python3 -m venv /tmp/venv
           . /tmp/venv/bin/activate
           pip install -r test/py/requirements.txt \
             -r tools/binman/requirements.txt \
@@ -170,7 +170,7 @@ stages:
       - script: |
           git config --global --add safe.directory $(work_dir)
           export USER=azure
-          virtualenv -p /usr/bin/python3 /tmp/venv
+          python3 -m venv /tmp/venv
           . /tmp/venv/bin/activate
           pip install -r test/py/requirements.txt \
             -r tools/binman/requirements.txt \
@@ -277,7 +277,7 @@ stages:
           if [ -n "\${BUILD_ENV}" ]; then
               export \${BUILD_ENV};
           fi
-          virtualenv -p /usr/bin/python3 /tmp/venv
+          python3 -m venv /tmp/venv
           . /tmp/venv/bin/activate
           pip install -r tools/binman/requirements.txt \
             -r tools/buildman/requirements.txt \
@@ -592,7 +592,7 @@ stages:
           # make environment variables available as tests are running inside a container
           export BUILDMAN="${BUILDMAN}"
           git config --global --add safe.directory ${WORK_DIR}
-          virtualenv -p /usr/bin/python3 /tmp/venv
+          python3 -m venv /tmp/venv
           . /tmp/venv/bin/activate
           pip install -r tools/binman/requirements.txt \
             -r tools/buildman/requirements.txt
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5f3418e482fe..12bcdeaf25ab 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -57,7 +57,7 @@ stages:
         export BINMAN_INDIRS=/tmp;
       fi
     # Prepare python environment
-    - virtualenv -p /usr/bin/python3 /tmp/venv;
+    - python3 -m venv /tmp/venv;
       . /tmp/venv/bin/activate;
       pip install -r test/py/requirements.txt -r tools/binman/requirements.txt
         -r tools/buildman/requirements.txt -r tools/u_boot_pylib/requirements.txt
@@ -124,7 +124,7 @@ build all platforms in a single job:
     - ${HOST}
   script:
     # Prepare python environment
-    - virtualenv -p /usr/bin/python3 /tmp/venv;
+    - python3 -m venv /tmp/venv;
       . /tmp/venv/bin/activate;
       pip install -r tools/binman/requirements.txt
         -r tools/buildman/requirements.txt
@@ -155,7 +155,7 @@ check for new CONFIG symbols outside Kconfig:
 docs:
   extends: .testsuites
   script:
-    - virtualenv -p /usr/bin/python3 /tmp/venvhtml
+    - python3 -m venv /tmp/venvhtml
     - . /tmp/venvhtml/bin/activate
     - pip install -r doc/sphinx/requirements.txt
     - make htmldocs KDOC_WERROR=1
@@ -184,7 +184,7 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
       git config --global user.email trini@konsulko.com;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
       export USER=gitlab;
-      virtualenv -p /usr/bin/python3 /tmp/venv;
+      python3 -m venv /tmp/venv;
       . /tmp/venv/bin/activate;
       pip install -r test/py/requirements.txt -r tools/binman/requirements.txt
         -r tools/buildman/requirements.txt -r tools/patman/requirements.txt
@@ -210,7 +210,7 @@ Run pylint:
   extends: .testsuites
   script:
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
-    - virtualenv -p /usr/bin/python3 /tmp/venv
+    - python3 -m venv /tmp/venv
     - . /tmp/venv/bin/activate
     - pip install -r test/py/requirements.txt -r tools/binman/requirements.txt
         -r tools/buildman/requirements.txt -r tools/patman/requirements.txt
diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
index d8fcfdc4bf21..480e0e3091e2 100644
--- a/doc/build/gcc.rst
+++ b/doc/build/gcc.rst
@@ -31,7 +31,7 @@ Depending on the build targets further packages maybe needed
       python3-pkg-resources python3-pycryptodome python3-pyelftools \
       python3-pytest python3-pytest-xdist python3-sphinxcontrib.apidoc \
       python3-sphinx-rtd-theme python3-subunit python3-testtools \
-      python3-virtualenv swig uuid-dev
+      python3-venv swig uuid-dev
 
 SUSE based
 ~~~~~~~~~~
diff --git a/doc/develop/py_testing.rst b/doc/develop/py_testing.rst
index 502053f09fc4..217ae447035c 100644
--- a/doc/develop/py_testing.rst
+++ b/doc/develop/py_testing.rst
@@ -69,19 +69,19 @@ To create disk images we have helper functions located in
 `test/py/tests/fs_helper.py` which shall be used in any tests that require
 creating disk images.
 
-Using `virtualenv` to provide requirements
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Using a Python sandbox to provide requirements
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The recommended way to run the test suite, in order to ensure reproducibility
-is to use `virtualenv` to set up the necessary environment.  This can be done
-via the following commands:
+is to use a Python sandbox such as `python -m venv` to set up the necessary
+environment.  This can be done via the following commands:
 
 
 .. code-block:: console
 
     $ cd /path/to/u-boot
-    $ sudo apt-get install python3 python3-virtualenv
-    $ virtualenv -p /usr/bin/python3 venv
+    $ sudo apt-get install python3 python3-venv
+    $ python3 -m venv venv
     $ . ./venv/bin/activate
     $ pip install -r test/py/requirements.txt
 
diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index c5feb74a1050..e31e6c72e1a1 100644
--- a/tools/buildman/test.py
+++ b/tools/buildman/test.py
@@ -987,7 +987,7 @@ class TestBuild(unittest.TestCase):
         diff = self.call_make_environment(tchn, full_path=True)[0]
         self.assertEqual({b'LC_ALL': b'C'}, diff)
 
-        # Test that virtualenv is handled correctly
+        # Test that Python sandbox is handled correctly
         tchn.override_toolchain = False
         sys.prefix = '/some/venv'
         env = dict(os.environb)
diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
index f4c832be8d33..5e5bb4b0aedd 100644
--- a/tools/buildman/toolchain.py
+++ b/tools/buildman/toolchain.py
@@ -217,7 +217,7 @@ class Toolchain:
         elif self.cross:
             env[b'CROSS_COMPILE'] = tools.to_bytes(wrapper + self.cross)
 
-            # Detect a Python virtualenv and avoid defeating it
+            # Detect a Python sandbox and avoid defeating it
             if sys.prefix != sys.base_prefix:
                 paths = env[b'PATH'].split(b':')
                 new_paths = []
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index a0fd174ff602..dec1d516a6c6 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -124,7 +124,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	python3-dev \
 	python3-pip \
 	python3-sphinx \
-	python3-virtualenv \
+	python3-venv \
 	rpm2cpio \
 	sbsigntool \
 	socat \
@@ -136,7 +136,6 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	texinfo \
 	util-linux \
 	uuid-dev \
-	virtualenv \
 	vboot-kernel-utils \
 	vboot-utils \
 	xilinx-bootgen \
@@ -313,7 +312,7 @@ RUN wget -O /tmp/binman-requirements.txt https://source.denx.de/u-boot/u-boot/-/
 RUN wget -O /tmp/buildman-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/buildman/requirements.txt
 RUN wget -O /tmp/patman-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/patman/requirements.txt
 RUN wget -O /tmp/u_boot_pylib-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/u_boot_pylib/requirements.txt
-RUN virtualenv -p /usr/bin/python3 /tmp/venv && \
+RUN python3 -m venv /tmp/venv && \
 	. /tmp/venv/bin/activate && \
 	pip install -r /tmp/pytest-requirements.txt \
 		-r /tmp/sphinx-requirements.txt \
diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
index 4835847bfc67..637403f87154 100644
--- a/tools/u_boot_pylib/test_util.py
+++ b/tools/u_boot_pylib/test_util.py
@@ -64,7 +64,7 @@ def run_test_coverage(prog, filter_fname, exclude_list, build_dir,
     if build_dir:
         prefix = 'PYTHONPATH=$PYTHONPATH:%s/sandbox_spl/tools ' % build_dir
 
-    # Detect a Python virtualenv and use 'coverage' instead
+    # Detect a Python sandbox and use 'coverage' instead
     covtool = ('python3-coverage' if sys.prefix == sys.base_prefix else
                'coverage')
 
-- 
2.43.0

