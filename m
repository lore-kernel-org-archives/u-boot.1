Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA9CC021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 20:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEF7A80F7B;
	Tue, 25 Feb 2025 21:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eoMZpupo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FAFD80F92; Tue, 25 Feb 2025 21:50:12 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6516A80805
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 21:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-868e5684712so1710122241.3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 12:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740516608; x=1741121408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rei+aFRWbcnMhAxFJotlZTAZFJXdYz6mogZ35Wrp/R4=;
 b=eoMZpupoRzieS5vqbEhUc/+wa+mGRTMWv8ULvdbWN8itdA4HKdqW/W45YVIbb0BoSb
 MkXSBqAby5XG/JJZEqkpZ7CfIF3KR8PGVnNyA0zBZ+k83AMcrBYqOh54n6HaNzuV1JqB
 1w1b66y+qEYycUgN/hHWZ7meql4qIkwCpY/WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740516608; x=1741121408;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rei+aFRWbcnMhAxFJotlZTAZFJXdYz6mogZ35Wrp/R4=;
 b=k3TzdeChOaeQA/Wq1pSihWNMwV3Hqeo8qpXgMGRH5cOUReqogMnIqNdTpgHa/Dnqtf
 w9LkKrspmDsx2K5sYLmH4Xrkg3SLMagDQIBBevtfG599DbUXAmRP1QwDVz4O15yaH0Vb
 oGVmfHKrQyPDX/hJQB40DlgdwFQTztymYhpthbiq6NWY8fnw2kGxrNtk/voSfvppfWKH
 M5NKT9oEzO+No/BQslAi0pgnKazO5XEC/NQORi6uqbKbTVW+k7AsbptsU0t4Xx5wGObb
 hhRNMFnzp3Kds95ruOUhpzGDrMVKhJxk6+hzLfxyqhla3a/oAak/MrLGwKz+KE1j7XlH
 t8vA==
X-Gm-Message-State: AOJu0YxYU+hUoCXFZyU3rOB/LuC+ZcIJxg2mKknvbmh+YGibtO3x69vR
 dz9BdtqQNm+1alAQin3YheC+hL7kuATfXtE/rkFeXYdCTveksTWvOFLCDQ8FZEV0dnN3YJPcoEd
 /
X-Gm-Gg: ASbGncv7Q2ES8crpJUEa2k05ffpbPXnKscnjkdfkHXc/09lFh1j9PNWjLdX3AFLZfH0
 XjSbDEVqjj5cIBbJPkJBfZqpoNZ19c1O8IVwTkYkO/UYXYZUf3WjvXiwv3Lac6CmK7urjfR0NJJ
 E9sEXHow9sb2HWVnupFjC9FV3EfaM8G9BOUe3h95jGMZJbBu1iT8n7CupeD8059BfQ+pDxo74+o
 pC/NSClX6mZ2wzYc09wFbSYXQGyN0Y2ByruRLcRd4Nddj/1Zvtx0K037LTakqvUnNdepN7e+Pie
 SgiAMBwqeI9DHHeb0iUGOqn34mQ=
X-Google-Smtp-Source: AGHT+IHml1Jhq7kayfy+0ODRoMerKsyGOLB7QTpGYhYCv6gWSVVIk3EMdLoCuR+/VDK19u0XRkLqug==
X-Received: by 2002:a05:6122:1790:b0:50a:c70b:9453 with SMTP id
 71dfb90a1353d-5223cd83aefmr2663755e0c.10.1740516607591; 
 Tue, 25 Feb 2025 12:50:07 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5223e1b23c1sm330903e0c.31.2025.02.25.12.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 12:50:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH RFC] doc: Include pytests directly in documentation
Date: Tue, 25 Feb 2025 14:50:03 -0600
Message-ID: <20250225205003.2640910-1-trini@konsulko.com>
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

As there is support within the Sphinx framework to take Python
docstrings and generate documentation from it, we can make use of that
to more clearly and consistently document our pytests and how to
configure them. To do this we:
- Add PYTHONPATH to DOC_TARGETS so that modules will be found, have CI
  install pytest module as well.
- Add the autodoc extension for Python and then redirects so we can move
  py_testing.html (which is heavily referenced in archives, etc).
- Create a doc/develop/pytest directory and move the existing py_testing
  file there, update references.
- Update the test_000_version.py test to have a docstring
- Move the imports in test_net_boot.py so the docstring is in the
  correct place.
- Use code-block for all of the code blocks in test_net_boot.py so they
  are rendered correctly in documentation.
  - Adding these code-block lines makes the diff larger when read but a
    "git show -w" for example makes it clearer that the textual changes
    are removing '#' from lines so the output reads nicer.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>

As this is a RFC, I didn't split it up as much as it needs to be as I'm
looking for some feedback on the concept.
---
 .azure-pipelines.yml                          |   2 +-
 .gitlab-ci.yml                                |   2 +-
 Makefile                                      |   3 +-
 doc/conf.py                                   |   8 +-
 doc/develop/ci_testing.rst                    |   2 +-
 doc/develop/index.rst                         |   2 +-
 doc/develop/pytest/index.rst                  |  21 +++
 doc/develop/pytest/test_000_version.rst       |   8 +
 doc/develop/pytest/test_net_boot.rst          |   8 +
 .../{py_testing.rst => pytest/usage.rst}      |   2 +-
 doc/develop/testing.rst                       |   4 +-
 doc/develop/tests_writing.rst                 |   2 +-
 doc/sphinx/requirements.txt                   |   1 +
 test/py/tests/test_000_version.py             |  10 +-
 test/py/tests/test_net_boot.py                | 163 ++++++++++--------
 15 files changed, 150 insertions(+), 88 deletions(-)
 create mode 100644 doc/develop/pytest/index.rst
 create mode 100644 doc/develop/pytest/test_000_version.rst
 create mode 100644 doc/develop/pytest/test_net_boot.rst
 rename doc/develop/{py_testing.rst => pytest/usage.rst} (99%)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index d5cfa59a8a61..e401e5cf99b4 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -92,7 +92,7 @@ stages:
           set -e
           virtualenv -p /usr/bin/python3 /tmp/venvhtml
           . /tmp/venvhtml/bin/activate
-          pip install -r doc/sphinx/requirements.txt
+          pip install -r doc/sphinx/requirements.txt pytest
           make htmldocs KDOC_WERROR=1
           make infodocs
 
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 64f92f8b5b9d..083f67695081 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -156,7 +156,7 @@ docs:
   script:
     - virtualenv -p /usr/bin/python3 /tmp/venvhtml
     - . /tmp/venvhtml/bin/activate
-    - pip install -r doc/sphinx/requirements.txt
+    - pip install -r doc/sphinx/requirements.txt pytest
     - make htmldocs KDOC_WERROR=1
     - make infodocs
 
diff --git a/Makefile b/Makefile
index 93fa86a18705..e2e452ae4aa0 100644
--- a/Makefile
+++ b/Makefile
@@ -2445,7 +2445,8 @@ DOC_TARGETS := xmldocs latexdocs pdfdocs htmldocs epubdocs cleandocs \
 	       linkcheckdocs dochelp refcheckdocs texinfodocs infodocs
 PHONY += $(DOC_TARGETS)
 $(DOC_TARGETS): scripts_basic FORCE
-	$(Q)$(MAKE) $(build)=doc $@
+	$(Q)PYTHONPATH=$(srctree)/test/py/tests:$(srctree)/test/py \
+	$(MAKE) $(build)=doc $@
 
 PHONY += checkstack ubootrelease ubootversion
 
diff --git a/doc/conf.py b/doc/conf.py
index c50daf874a53..a935d674aae9 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -47,7 +47,8 @@ needs_sphinx = '2.4.4'
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', # 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel',
-              'kernel_abi', 'kernel_feat', 'sphinx-prompt']
+              'kernel_abi', 'kernel_feat', 'sphinx-prompt',
+              'sphinx.ext.autodoc', 'sphinx_reredirects' ]
 
 #
 # cdomain is badly broken in Sphinx 3+.  Leaving it out generates *most*
@@ -148,6 +149,11 @@ project = 'Das U-Boot'
 copyright = 'The U-Boot development community'
 author = 'The U-Boot development community'
 
+# Pages we have moved after being heavily referenced externally
+redirects = {
+    "develop/py_testing": "pytest/usage.html"
+}
+
 # The version info for the project you're documenting, acts as replacement for
 # |version| and |release|, also used in various other places throughout the
 # built documents.
diff --git a/doc/develop/ci_testing.rst b/doc/develop/ci_testing.rst
index ffaacedc3d88..2033e3447e9e 100644
--- a/doc/develop/ci_testing.rst
+++ b/doc/develop/ci_testing.rst
@@ -18,7 +18,7 @@ be built with mingw to run on Windows.
 Each of the pipelines is written in such as way as to be a "world build" style
 test and as such we try and build all possible platforms.  In addition, for all
 platforms that support being run in QEMU we run them in QEMU and use our pytest
-suite.  See :doc:`py_testing` for more information about those tests.
+suite.  See :doc:`pytest/usage` for more information about those tests.
 
 Azure Pipelines
 ---------------
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index d9f2a8382077..131e5fb3188f 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -81,7 +81,7 @@ Testing
    :maxdepth: 1
 
    testing
-   py_testing
+   pytest/index
    tests_writing
    tests_sandbox
    binman_tests
diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
new file mode 100644
index 000000000000..36083882584f
--- /dev/null
+++ b/doc/develop/pytest/index.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+pytest Framework within U-Boot
+==============================
+
+General
+-------
+
+.. toctree::
+   :maxdepth: 1
+
+   usage
+
+Individual tests
+----------------
+
+.. toctree::
+   :maxdepth: 1
+
+   test_000_version
+   test_net_boot
diff --git a/doc/develop/pytest/test_000_version.rst b/doc/develop/pytest/test_000_version.rst
new file mode 100644
index 000000000000..09e9a361729b
--- /dev/null
+++ b/doc/develop/pytest/test_000_version.rst
@@ -0,0 +1,8 @@
+test_000_version
+================
+
+.. automodule:: test_000_version
+   :synopsis:
+   :member-order: bysource
+   :members:
+   :undoc-members:
diff --git a/doc/develop/pytest/test_net_boot.rst b/doc/develop/pytest/test_net_boot.rst
new file mode 100644
index 000000000000..369bd3b809cf
--- /dev/null
+++ b/doc/develop/pytest/test_net_boot.rst
@@ -0,0 +1,8 @@
+test_net_boot
+=============
+
+.. automodule:: test_net_boot
+   :synopsis:
+   :member-order: bysource
+   :members:
+   :undoc-members:
diff --git a/doc/develop/py_testing.rst b/doc/develop/pytest/usage.rst
similarity index 99%
rename from doc/develop/py_testing.rst
rename to doc/develop/pytest/usage.rst
index b50473039be4..0b0038ba1899 100644
--- a/doc/develop/py_testing.rst
+++ b/doc/develop/pytest/usage.rst
@@ -13,7 +13,7 @@ results. Advantages of this approach are:
   U-Boot; there can be no disconnect.
 - There is no need to write or embed test-related code into U-Boot itself.
   It is asserted that writing test-related code in Python is simpler and more
-  flexible than writing it all in C. But see :doc:`tests_writing` for caveats
+  flexible than writing it all in C. But see :doc:`../tests_writing` for caveats
   and more discussion / analysis.
 - It is reasonably simple to interact with U-Boot in this way.
 
diff --git a/doc/develop/testing.rst b/doc/develop/testing.rst
index 9114d11ad26d..aa7786c99fd5 100644
--- a/doc/develop/testing.rst
+++ b/doc/develop/testing.rst
@@ -33,7 +33,7 @@ You can also run a selection tests in parallel with::
     make pcheck
 
 All of the above use the test/run script with a paremeter to select which tests
-are run. See :doc:`py_testing` for more information.
+are run. See :doc:`pytest/usage` for more information.
 
 
 Sandbox
@@ -69,7 +69,7 @@ build::
 
    ./test/py/test.py --bd sandbox_spl --build -k test_spl
 
-See :doc:`py_testing` for more information about the pytest suite.
+See :doc:`pytest/usage` for more information about the pytest suite.
 
 See :doc:`tests_sandbox` for how to run tests directly (not through pytest).
 
diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
index 5f3c43d5da24..2adcfb072099 100644
--- a/doc/develop/tests_writing.rst
+++ b/doc/develop/tests_writing.rst
@@ -376,5 +376,5 @@ An example SPL test is spl_test_load().
 Writing Python tests
 --------------------
 
-See :doc:`py_testing` for brief notes how to write Python tests. You
+See :doc:`pytest/usage` for brief notes how to write Python tests. You
 should be able to use the existing tests in test/py/tests as examples.
diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index 13e0327c0f67..12c5772684dc 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -15,6 +15,7 @@ six==1.16.0
 snowballstemmer==2.2.0
 Sphinx==8.1.3
 sphinx-prompt==1.9.0
+sphinx-reredirects==0.1.5
 sphinx-rtd-theme==3.0.1
 sphinxcontrib-applehelp==2.0.0
 sphinxcontrib-devhelp==2.0.0
diff --git a/test/py/tests/test_000_version.py b/test/py/tests/test_000_version.py
index bd089ab5439d..77effbbc38f4 100644
--- a/test/py/tests/test_000_version.py
+++ b/test/py/tests/test_000_version.py
@@ -2,10 +2,12 @@
 # Copyright (c) 2015 Stephen Warren
 # Copyright (c) 2016, NVIDIA CORPORATION. All rights reserved.
 
-# pytest runs tests the order of their module path, which is related to the
-# filename containing the test. This file is named such that it is sorted
-# first, simply as a very basic sanity check of the functionality of the U-Boot
-# command prompt.
+"""
+pytest runs tests the order of their module path, which is related to the
+filename containing the test. This file is named such that it is sorted
+first, simply as a very basic sanity check of the functionality of the U-Boot
+command prompt.
+"""
 
 def test_version(u_boot_console):
     """Test that the "version" command prints the U-Boot version."""
diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
index d7d74356928e..68a91ef5b518 100644
--- a/test/py/tests/test_net_boot.py
+++ b/test/py/tests/test_net_boot.py
@@ -1,11 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # (C) Copyright 2023, Advanced Micro Devices, Inc.
 
-import pytest
-import u_boot_utils
-import test_net
-import re
-
 """
 Note: This test relies on boardenv_* containing configuration values to define
 which the network environment available for testing. Without this, this test
@@ -13,77 +8,88 @@ will be automatically skipped.
 
 For example:
 
-# Details regarding a boot image file that may be read from a TFTP server. This
-# variable may be omitted or set to None if TFTP boot testing is not possible
-# or desired.
-env__net_tftp_bootable_file = {
-    'fn': 'image.ub',
-    'addr': 0x10000000,
-    'size': 5058624,
-    'crc32': 'c2244b26',
-    'pattern': 'Linux',
-    'config': 'config@2',
-    'timeout': 50000,
-    'check_type': 'boot_error',
-    'check_pattern': 'ERROR',
-}
-
-# False or omitted if a TFTP boot test should be tested.
-# If TFTP boot testing is not possible or desired, set this variable to True.
-# For example: If FIT image is not proper to boot
-env__tftp_boot_test_skip = False
-
-# Here is the example of FIT image configurations:
-configurations {
-    default = "config@1";
-    config@1 {
-        description = "Boot Linux kernel with config@1";
-        kernel = "kernel@0";
-        fdt = "fdt@0";
-        ramdisk = "ramdisk@0";
-        hash@1 {
-            algo = "sha1";
-        };
-    };
-    config@2 {
-        description = "Boot Linux kernel with config@2";
-        kernel = "kernel@1";
-        fdt = "fdt@1";
-        ramdisk = "ramdisk@1";
-        hash@1 {
-            algo = "sha1";
-        };
-    };
-};
-
-# Details regarding a file that may be read from a TFTP server. This variable
-# may be omitted or set to None if PXE testing is not possible or desired.
-env__net_pxe_bootable_file = {
-    'fn': 'default',
-    'addr': 0x10000000,
-    'size': 74,
-    'timeout': 50000,
-    'pattern': 'Linux',
-    'valid_label': '1',
-    'invalid_label': '2',
-    'exp_str_invalid': 'Skipping install for failure retrieving',
-    'local_label': '3',
-    'exp_str_local': 'missing environment variable: localcmd',
-    'empty_label': '4',
-    'exp_str_empty': 'No kernel given, skipping boot',
-    'check_type': 'boot_error',
-    'check_pattern': 'ERROR',
-}
-
-# False if a PXE boot test should be tested.
-# If PXE boot testing is not possible or desired, set this variable to True.
-# For example: If pxe configuration file is not proper to boot
-env__pxe_boot_test_skip = False
-
-# Here is the example of pxe configuration file ordered based on the execution
-# flow:
+.. code-block:: python
+
+   # Details regarding a boot image file that may be read from a TFTP server. This
+   # variable may be omitted or set to None if TFTP boot testing is not possible
+   # or desired.
+   env__net_tftp_bootable_file = {
+       'fn': 'image.ub',
+       'addr': 0x10000000,
+       'size': 5058624,
+       'crc32': 'c2244b26',
+       'pattern': 'Linux',
+       'config': 'config@2',
+       'timeout': 50000,
+       'check_type': 'boot_error',
+       'check_pattern': 'ERROR',
+   }
+
+   # False or omitted if a TFTP boot test should be tested.
+   # If TFTP boot testing is not possible or desired, set this variable to True.
+   # For example: If FIT image is not proper to boot
+   env__tftp_boot_test_skip = False
+
+
+Here is the example of FIT image configurations:
+
+.. code-block:: devicetree
+
+   configurations {
+       default = "config@1";
+       config@1 {
+           description = "Boot Linux kernel with config@1";
+           kernel = "kernel@0";
+           fdt = "fdt@0";
+           ramdisk = "ramdisk@0";
+           hash@1 {
+               algo = "sha1";
+           };
+       };
+       config@2 {
+           description = "Boot Linux kernel with config@2";
+           kernel = "kernel@1";
+           fdt = "fdt@1";
+           ramdisk = "ramdisk@1";
+           hash@1 {
+               algo = "sha1";
+           };
+       };
+   };
+
+.. code-block:: python
+
+   # Details regarding a file that may be read from a TFTP server. This variable
+   # may be omitted or set to None if PXE testing is not possible or desired.
+   env__net_pxe_bootable_file = {
+       'fn': 'default',
+       'addr': 0x10000000,
+       'size': 74,
+       'timeout': 50000,
+       'pattern': 'Linux',
+       'valid_label': '1',
+       'invalid_label': '2',
+       'exp_str_invalid': 'Skipping install for failure retrieving',
+       'local_label': '3',
+       'exp_str_local': 'missing environment variable: localcmd',
+       'empty_label': '4',
+       'exp_str_empty': 'No kernel given, skipping boot',
+       'check_type': 'boot_error',
+       'check_pattern': 'ERROR',
+   }
+
+   # False if a PXE boot test should be tested.
+   # If PXE boot testing is not possible or desired, set this variable to True.
+   # For example: If pxe configuration file is not proper to boot
+   env__pxe_boot_test_skip = False
+
+Here is the example of pxe configuration file ordered based on the execution
+flow:
+
 1) /tftpboot/pxelinux.cfg/default-arm-zynqmp
 
+.. code-block::
+
     menu include pxelinux.cfg/default-arm
     timeout 50
 
@@ -91,6 +97,8 @@ env__pxe_boot_test_skip = False
 
 2) /tftpboot/pxelinux.cfg/default-arm
 
+.. code-block::
+
     menu title Linux boot selections
     menu include pxelinux.cfg/default
 
@@ -110,6 +118,8 @@ env__pxe_boot_test_skip = False
 
 3) /tftpboot/pxelinux.cfg/default
 
+.. code-block::
+
     label Linux
         menu label Boot kernel
         kernel Image
@@ -117,6 +127,11 @@ env__pxe_boot_test_skip = False
         initrd rootfs.cpio.gz.u-boot
 """
 
+import pytest
+import u_boot_utils
+import test_net
+import re
+
 def setup_networking(u_boot_console):
     test_net.test_net_dhcp(u_boot_console)
     if not test_net.net_set_up:
-- 
2.43.0

