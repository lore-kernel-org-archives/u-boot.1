Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C512C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 22:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F865820EB;
	Thu,  8 May 2025 00:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fVT8CkjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7E8182162; Thu,  8 May 2025 00:11:20 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D95D8210D
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 00:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2c12b7af278so334268fac.0
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 15:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746655877; x=1747260677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L82jcXTDxbuNb+L2X+lJ2KH9uazQY380zOesa5CFwpo=;
 b=fVT8CkjI4ipbvJPhZIwtskgGCInXpm8ftBt7ykWKacWeyLS4+r0PxuT4W/zHfxZSar
 9m9rFYzxYLlZaW1DuYduh5AKSGVlWH9JMeX9AOT6giQsxEcDP8HZZzddBG6VXiuHuq+L
 1+c2M9852+GK/IVLYrXAF09wEwVT30ptjlahY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746655877; x=1747260677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L82jcXTDxbuNb+L2X+lJ2KH9uazQY380zOesa5CFwpo=;
 b=eY5elwwuDi9VoRW2PBUZLX2vaGl1c0V7MH/5jpUQO+/hxQ7KRWlYGBYi2g+fNGcarR
 zeRgTdsQ922/QjLyju+2CBJRWIrflFNeVAawvaeU3K887Y6Qw6TO42vsSGHlDyaKZwC+
 MwfrbRdMgTUywyXo0MJD7OQSFHanVqUYbNdISqmFfuEFiVrUQnJ6qoWZ8s5uNRDVHWUs
 jkiEPOs6R4mEPoyDDDC4XgRkG24aEO2FKouD7kK44UkEVCzFlKB1hGidTqYyHUjl8BAO
 1XpnBQ+T9g/DuvOmzGwzcV9Dc+rBqzBpcLjujoQcxMha1Vomg2WzNIrguZQq8T9+FJwg
 2NKQ==
X-Gm-Message-State: AOJu0YzxHzH6Vy/bUomEQ3DsmB0X8BkSPbl+CQbja1MMlWp2kiX2fNfb
 pfbH0AWLww7oe+Hmjr8ggqPvlHwMLg39y+CXi5QEabFUz2Y+x2pgUGl8Mh9wNqbiPVLYCqcPpCP
 T
X-Gm-Gg: ASbGncsVTfRRpvoRPiwuiAM5GrfX1b+Ym+vPG3NvOOFPJ6I3NoLQOz/B9lVi1Zp+p11
 2lF9IkMsHBxv1zL54V7956k80HyBXFsQuxG1xpjsI5sEuv9WuFRZBuugroD2ngJzNSO0v/GKNy2
 +pjtZ2NAEjQs/RazzwuD778sPz2HjBY12AeHR9NzRYFil0PiOJ889vvyNadGDXe5JNZ9dUuIoyd
 kR6H/oc8wbn+KBjKyIW2F7CuRxtyy5+0s/E6Dbfo8HNJPYm2sIp5PRaDymKjRF5Hss8McRfLNqN
 LhHdiHN8ggtBIZo6bzZo3AabbOA8WiNY1NzOzLvh9SVgUlUV8hdvtEE40Xw4C86zCqavqRAp8Pv
 oT64g
X-Google-Smtp-Source: AGHT+IFfGJZe0S0JHRN+olIymLxY+OAmSCZtzvIjmZ2PV2XRJ86xJFCWATK/+o2AVn6stTAt6gdbrw==
X-Received: by 2002:a05:6870:828a:b0:2d6:8eb:8918 with SMTP id
 586e51a60fabf-2db806da92fmr841885fac.7.1746655877047; 
 Wed, 07 May 2025 15:11:17 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2db5cbf16f1sm967181fac.20.2025.05.07.15.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 15:11:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/4] doc: Start improving our pytest documentation
Date: Wed,  7 May 2025 16:08:17 -0600
Message-ID: <20250507221112.518041-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507221112.518041-1-trini@konsulko.com>
References: <20250225205003.2640910-1-trini@konsulko.com>
 <20250507221112.518041-1-trini@konsulko.com>
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

Begin the work of documenting all of our pytests. To do this, we should
have a directory under develop for it as there will be a large number of
new files. As the current document is referenced externally in a number
of locations, add the sphinx_reredirects module so that we can redirect
from the old location to the new.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>
---
 doc/conf.py                                      |  8 +++++++-
 doc/develop/ci_testing.rst                       |  2 +-
 doc/develop/index.rst                            |  2 +-
 doc/develop/pytest/index.rst                     | 12 ++++++++++++
 doc/develop/{py_testing.rst => pytest/usage.rst} |  2 +-
 doc/develop/testing.rst                          |  4 ++--
 doc/develop/tests_writing.rst                    |  2 +-
 doc/sphinx/requirements.txt                      |  1 +
 8 files changed, 26 insertions(+), 7 deletions(-)
 create mode 100644 doc/develop/pytest/index.rst
 rename doc/develop/{py_testing.rst => pytest/usage.rst} (99%)

diff --git a/doc/conf.py b/doc/conf.py
index c50daf874a53..3cb9b2bb65e5 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -47,7 +47,8 @@ needs_sphinx = '2.4.4'
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', # 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel',
-              'kernel_abi', 'kernel_feat', 'sphinx-prompt']
+              'kernel_abi', 'kernel_feat', 'sphinx-prompt',
+              'sphinx_reredirects' ]
 
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
index c907f8c9c2c0..0c83ef109ab8 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -82,7 +82,7 @@ Testing
    :maxdepth: 1
 
    testing
-   py_testing
+   pytest/index
    tests_writing
    tests_sandbox
    binman_tests
diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
new file mode 100644
index 000000000000..435d84fc619f
--- /dev/null
+++ b/doc/develop/pytest/index.rst
@@ -0,0 +1,12 @@
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
diff --git a/doc/develop/py_testing.rst b/doc/develop/pytest/usage.rst
similarity index 99%
rename from doc/develop/py_testing.rst
rename to doc/develop/pytest/usage.rst
index 217ae447035c..17e1ff5193ab 100644
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
index f6f852c297df..062194659b5a 100644
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
-- 
2.43.0

