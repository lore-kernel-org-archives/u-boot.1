Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3515CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:31:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78D9984975;
	Tue, 16 Jun 2026 16:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JfOVCZVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CC0984975; Tue, 16 Jun 2026 16:30:05 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D1F384954
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e6d14aaef8so2024850a34.3
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781620201; x=1782225001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/RX/qSsKe8zL8S6nE7Ilzbn8dLwWLGeVraVOD/qTEkg=;
 b=JfOVCZVeIgOcDJh6JXz8rTnDqIaraA3q3yroFss7QBVns/SWSf7sek/iUO94lXAIuz
 6OxIwvx6DNLET8sz8lh4WJ/9g5srOLfN4kz5esZgsZAg2IF5MPqfa/mwpsFmswEc4bn3
 tF0wUmeFlcWPaoDx1sXxUIS7LmhBkAQqyizJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781620201; x=1782225001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/RX/qSsKe8zL8S6nE7Ilzbn8dLwWLGeVraVOD/qTEkg=;
 b=ddcKQN0zUcHMT2JKHNIYV/bRaJL1INYqMXDO/UcYvQ0hg8Gv5e+9Jmgx9pxsCMCaib
 viTuzlqbdFPiq/xyNZ1nOSIKlatMCMMRwNNTyZ6bCYazgvNOdb4MDYBsS0rvKchkb0X6
 SnaW+Si4Myvq+f5NaAUqoHBbq7iM+dn981oDuK4WmV5s1e1ceZU2daU79a5HA4+Ipp3I
 Z9RQG0T9cG6OrRMLkXtShWc+ObCb2Z9jsYK6S1k8dgLCAGieiH+Bj/f2C0xb614b7xsu
 61jkKN+WuzOjN7JYp17W+JEvDxf+uj8R+gPPX7xJVAzqWfo99euH8czBNiNqTGJUM64b
 3YcA==
X-Gm-Message-State: AOJu0YyCZVj1wccbnT/i4kNnfo6luqc6ZBYbr6ApGJCgnl1ZlO1JUP/4
 avVP37AnGa6kzdc+7ediAMTt6MK9varD8o+Cc1gTbGKeP2sbeOUPqA1LbuD5RSsjdDj1qXo2j3j
 X9Pg=
X-Gm-Gg: Acq92OErgC5D0zs/ldMbq9+b+PbGDhydGtl618bmmlqREgatnbBFZJQB6kHwvLFoG75
 whwIXj15Y13y3VUJR7QYMcbNn62OF7s4M6d+MFPytoK5bUh4i5r+QPiQOWnlBxwRlkOAqMgWhVE
 Q2Rfrwu12xbQ2llJxSOODspzDljHR9vFd+qBtI62T43XF46SoY0JtvbnBv6NeGh9XmXz3rpleP/
 Z+blkgQbYt0oO2eiU7+/ffErx4Y/vYm2Sq4UuB62Jg1Dk2Lisa6vUIVAbszhqVQk7yfV4jaActH
 wdzSrRDlQCx8xrPwJRL9nNlCsE2k208V4bNsKC0n342Nm0i7PPxaggyOXQhJfuDEFwZHfPEr+9A
 LHcgAc+13cWXo8eAxeHpK8Fc6Aa36lnhAgcC5a3OJYCKW8SWIIfUtIOwTVTC3c3HZE/vpE6LNMa
 FVpvFnIhQDzYNsbR8XNg==
X-Received: by 2002:a05:6830:3689:b0:7e6:f31c:47bd with SMTP id
 46e09a7af769-7e78e5b932dmr11657258a34.3.1781620200549; 
 Tue, 16 Jun 2026 07:30:00 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e79f6fb5edsm7263749a34.26.2026.06.16.07.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:29:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH 8/9] tools: Stop packaging patman as a pip module
Date: Tue, 16 Jun 2026 08:28:48 -0600
Message-ID: <20260616142859.54136-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616142859.54136-1-sjg@chromium.org>
References: <20260616142859.54136-1-sjg@chromium.org>
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
index cb90be978d7..eb66bdaff8a 100644
--- a/Makefile
+++ b/Makefile
@@ -2691,7 +2691,6 @@ pip pip_test pip_release: _pip
 
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

