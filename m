Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE64C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 19:34:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D39AA84987;
	Sun,  5 Jul 2026 21:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WiCoRCD8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98E4084832; Sun,  5 Jul 2026 21:33:50 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F10F84987
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 21:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6a308736a36so1362396eaf.3
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783280027; x=1783884827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kAG7ALzeAvag9q3i83jRKzueacZictGJr3nYgnWoCyU=;
 b=WiCoRCD8jE7RJIfv2lmpQ41n4+CM/ekTN14BruP8cDse1o/Pmhh82OZc/a7hrzqh2C
 j+/fC4JqiJAfyYXvgX25Vs0wjzG09FFGkAoVPK9OscIerNCc/9ErBmYas48XEDOAb8X5
 3ebHoQseMUzbST8ghSCIyXtH/7YDEw6PJLTvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783280027; x=1783884827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kAG7ALzeAvag9q3i83jRKzueacZictGJr3nYgnWoCyU=;
 b=LQaOMLMIQ4YkSMPxWICLaq8TjgkITEHhJt/w5EdOBCzlF9NIU9EvxFb5hEm1Vqgdyn
 s32mw6N9tm570KUz9rDVw2vN2xtIFSiqKcEA4hZed10MTdNgvCtfDFku01pR+JpJIWru
 JaUnZ4jvQfVRGA6/VofyvYOm5bY4kVm1Ay/V+4LGgDV6uqmRbRDs9BQrsVMTPZx5oIwf
 ENxatXaMRoDX1ZGzDUNNmZS8Ex64KcXALu24HM51hc/xr2+BO9fsAlilBMIZrKrvZDzi
 XlPmXWheOmFSWcjULryjgL00bd5L4u+wxQF4ERGFIIUY0JAl8luj60bDk1NgPMB1ClJa
 sqig==
X-Gm-Message-State: AOJu0YztnWP/aBDx386Li9TC1bPFhTDShiLgI7vjOwOCGhBK+OvOWFil
 2nU1b4q63Cqld0lrFk9ruWqmlica6zdWIXKokV21j1fRkjpL1N5B9pdTty2iWhr1h9XDF38PVvK
 0dcfkfA==
X-Gm-Gg: AfdE7ckc8o97zem3c7Ebc/bc64gV7yOw0qpQ6VWLpe9KqieSq8Zm2eQf8NF/3hyQvqo
 NcSlB4vPJw/w8ozWyDh62ZGLakhp6GkmrPC/3ozDKmrzlxxbqffTqngMaLeCsWb5g397aP6dSvd
 BKIemEcntJAy4fSNCfpVpzpkVvd/8nTx/VMWBESCP9ikRped1ikkuFaskY0GshtZvfLDnB0wZAr
 LLXklQEv9gLS0c8szkp/0GtIGC3pmWy1q7jgnNkBzCKwzaxcu+Px3To24KGlw4E0cfsbB7Yrvrd
 GyjtY/690gwec99UxFw2pLOzzspjxVIHcd9tHubRra5m4Vf+l2BkDMsfWHzaJ1L4Wp724PXrhmi
 R/1R/PQtTGZuj+J7cmVMq+8btsWY+Bg5mvJr+M9b54j0NDnzhHW638K5a5CNLDiSxB2yW
X-Received: by 2002:a05:6820:310c:b0:6a1:50eb:211e with SMTP id
 006d021491bc7-6a32f5e86d0mr3852351eaf.66.1783280026721; 
 Sun, 05 Jul 2026 12:33:46 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a3103e064esm7513448eaf.14.2026.07.05.12.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:33:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v2 10/11] tools: Stop packaging patman as a pip module
Date: Sun,  5 Jul 2026 13:32:21 -0600
Message-ID: <20260705193251.2190705-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705193251.2190705-1-sjg@chromium.org>
References: <20260705193251.2190705-1-sjg@chromium.org>
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

patman is no longer shipped from the U-Boot tree, so drop it from the
'make pip' target and from make_pip.sh, and remove its packaging files
(setup.py, pyproject.toml, requirements.txt). Nothing else refers to
them by this point in the series, so they can go.

Also fix binman's pyproject.toml, which declares package-data for a
'patman' package (a copy-paste leftover); use 'binman' instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 Makefile                      |  1 -
 scripts/make_pip.sh           | 10 +++++-----
 tools/binman/pyproject.toml   |  2 +-
 tools/patman/pyproject.toml   | 29 -----------------------------
 tools/patman/requirements.txt |  6 ------
 tools/patman/setup.py         | 11 -----------
 6 files changed, 6 insertions(+), 53 deletions(-)
 delete mode 100644 tools/patman/pyproject.toml
 delete mode 100644 tools/patman/requirements.txt
 delete mode 100644 tools/patman/setup.py

diff --git a/Makefile b/Makefile
index d8287323c43..91a45ee217f 100644
--- a/Makefile
+++ b/Makefile
@@ -2692,7 +2692,6 @@ pip pip_test pip_release: _pip
 
 _pip:
 	scripts/make_pip.sh u_boot_pylib ${PIP_ARGS}
-	scripts/make_pip.sh patman ${PIP_ARGS}
 	scripts/make_pip.sh buildman ${PIP_ARGS}
 	scripts/make_pip.sh dtoc ${PIP_ARGS}
 	scripts/make_pip.sh binman ${PIP_ARGS}
diff --git a/scripts/make_pip.sh b/scripts/make_pip.sh
index 33ad51ada70..ffe22db199c 100755
--- a/scripts/make_pip.sh
+++ b/scripts/make_pip.sh
@@ -5,7 +5,7 @@
 #
 # Usage: make_pip.sh <tool_name> [--real]
 #
-# Where tool_name is one of patman, buildman, dtoc, binman, u_boot_pylib
+# Where tool_name is one of buildman, dtoc, binman, u_boot_pylib
 #
 # and --real means to upload to the real server (otherwise the test one is used)
 #
@@ -36,10 +36,10 @@ tool="$1"
 shift
 flags="$*"
 
-if [[ "${tool}" =~ ^(patman|buildman|dtoc|binman|u_boot_pylib)$ ]]; then
+if [[ "${tool}" =~ ^(buildman|dtoc|binman|u_boot_pylib)$ ]]; then
 	echo "Building dist package for tool ${tool}"
 else
-	echo "Unknown tool ${tool}: use u_boot_pylib, patman, buildman, dtoc or binman"
+	echo "Unknown tool ${tool}: use u_boot_pylib, buildman, dtoc or binman"
 	exit 1
 fi
 
@@ -61,8 +61,8 @@ if [ -n "${upload}" ]; then
 	fi
 fi
 
-if [[ "${tool}" =~ ^(patman|u_boot_pylib)$ ]]; then
-	# Leave test_util.py and patman test files alone
+if [[ "${tool}" =~ ^(u_boot_pylib)$ ]]; then
+	# Leave test_util.py and the u_boot_pylib test files alone
 	delete_testfiles=
 fi
 
diff --git a/tools/binman/pyproject.toml b/tools/binman/pyproject.toml
index 2f17588e9df..fd43a71b02b 100644
--- a/tools/binman/pyproject.toml
+++ b/tools/binman/pyproject.toml
@@ -26,4 +26,4 @@ classifiers = [
 binman = "binman.main:start_binman"
 
 [tool.setuptools.package-data]
-patman = ["*.rst"]
+binman = ["*.rst"]
diff --git a/tools/patman/pyproject.toml b/tools/patman/pyproject.toml
deleted file mode 100644
index 0fc4b7d4ecd..00000000000
--- a/tools/patman/pyproject.toml
+++ /dev/null
@@ -1,29 +0,0 @@
-[build-system]
-requires = ["setuptools>=78.1.1"]
-build-backend = "setuptools.build_meta"
-
-[project]
-name = "patch-manager"
-version = "0.0.6"
-authors = [
-  { name="Simon Glass", email="sjg@chromium.org" },
-]
-dependencies = ["u_boot_pylib >= 0.0.6", "aiohttp >= 3.9.1" ]
-description = "Patman patch manager"
-readme = "README.rst"
-requires-python = ">=3.7"
-classifiers = [
-    "Programming Language :: Python :: 3",
-    "License :: OSI Approved :: GNU General Public License v2 or later (GPLv2+)",
-    "Operating System :: OS Independent",
-]
-
-[project.urls]
-"Homepage" = "https://docs.u-boot-project.org/en/latest/develop/patman.html"
-"Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
-
-[project.scripts]
-patman = "patman.__main__:run_patman"
-
-[tool.setuptools.package-data]
-patman = ["*.rst"]
diff --git a/tools/patman/requirements.txt b/tools/patman/requirements.txt
deleted file mode 100644
index d4fcb1061c2..00000000000
--- a/tools/patman/requirements.txt
+++ /dev/null
@@ -1,6 +0,0 @@
-aiohttp==3.10.11
-ConfigParser==7.1.0
-importlib_resources==6.5.2
-pygit2==1.14.1
-requests==2.32.4
-setuptools==78.1.1
diff --git a/tools/patman/setup.py b/tools/patman/setup.py
deleted file mode 100644
index bcaad69a1c2..00000000000
--- a/tools/patman/setup.py
+++ /dev/null
@@ -1,11 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-
-from setuptools import setup
-setup(name='patman',
-      version='1.0',
-      scripts=['patman'],
-      packages=['patman'],
-      package_dir={'patman': ''},
-      package_data={'patman': ['README.rst']},
-      classifiers=['Environment :: Console',
-                   'Topic :: Software Development'])
-- 
2.43.0

