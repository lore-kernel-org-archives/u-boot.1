Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954D1C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D61D380C93;
	Sat, 15 Mar 2025 15:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VpW9MKmi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A574580FDA; Sat, 15 Mar 2025 15:17:50 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BB2380C93
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7c24ae82de4so351673885a.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742048267; x=1742653067; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KlSaa55Pc9sfjWGqHlfbqi+JVHv4g7fx2qEzkiHXJHs=;
 b=VpW9MKminXY2yRvcK+u0RUKdKd2Fa2ynL0WWka7ZLppJAt7mjhm9UdZs2W+jG2jpFk
 EMkwh5ZkL4yV9GzIgYbrphbRJuXoDXVcOs7V3+oMUJLcbBLajIDzalPEghJ+/VQz5Pnz
 ZqSy5danb7OGRnhr41x2vA1772xEi7uQMODYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048267; x=1742653067;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KlSaa55Pc9sfjWGqHlfbqi+JVHv4g7fx2qEzkiHXJHs=;
 b=EdhXaqEUEAXTwx3u5ID30UFQdXudbTm8CBAx1LzxS/ZPOawenAUyQuhgoBlwIe/FCW
 /vSbLqcNXaIEqFjQfDNNSSEA/+AIKiXGzGdhAl8wrrOqkStPqLNk+J+adI6OCiFKZ7bF
 fIElZkdaqhNu2qGV29O68IqV589f+iN5TUAGmUE2KPofVpsU6K0siauNcdG05/m8w0JW
 5UMpCYawizIEo7d20hPyWK2ZSkVC9Mr4pDMJ0C8A7+aos9S0lS/Ep8E3coMOTiukrLIF
 Zrf7FZSAFskkTz0xW+HUoxpoYxVwOGKq8GHb6lT8z7cGpA4eFKr4KkUjU8btAC3fXh/1
 TJvw==
X-Gm-Message-State: AOJu0YxuqV9R7j6d/spsSyrUaqSNhvHlZfZ0j+Xvv5MqKBw0natmttgB
 Pu3sWcG2uFCtWcARi4ZpNaybqwbF9+IFVCwIpm0RK7SL90OTZN3dg/5oVRxkxpqNpBBIp/nQ6uA
 e
X-Gm-Gg: ASbGnctOMmDVCuRUminTzs8t0OPrZUdTG/H28wB41kvLWZfk4dhux6L2ukfQP9Xp/3E
 Ygu1ZpDYmkX0hGgnJ2TpQtIXCR7NeCcpBO5VYFHI9yVzbCnhcqFnS1rOpr/Z9vde+wNW9+JtCG0
 CYHBbXuf79h49jhCleMfCmBHF5pypwMh/udznkWO1u0vfiRDJaF9Ub990/9E9mum3cuZSdyIGDP
 lzMB3pHFkMmXQjoKxnr1w3Q4PLjwZfeuqFC+gpWpfK11bl/SqDgFrU0ygskMw8ooEd60A4yCYX4
 zxoCmEDDHDQjt2+UkKtsE2thmyfgUnWb8jmfsXKTEkxtFmXGNiNkBpUG92c=
X-Google-Smtp-Source: AGHT+IH4MnjlusP0fTR5XgANgkzm2Az55X8rxXnQc7s8xfM9hjN4xXt64hG2rwBtsgECWocaZIyVZw==
X-Received: by 2002:a05:620a:2992:b0:7c5:3e22:6167 with SMTP id
 af79cd13be357-7c57c7d6d33mr971605585a.23.1742048267185; 
 Sat, 15 Mar 2025 07:17:47 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c7859bsm380567785a.34.2025.03.15.07.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:17:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [RFC PATCH] Gitlab CI: Clean up more
Date: Sat, 15 Mar 2025 08:17:44 -0600
Message-ID: <20250315141744.452073-1-trini@konsulko.com>
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

A problem we hit on our CI runners themselves, from time to time, is a
lack of disk space on the host. This is because Gitlab has no automation
itself around the removal of items it put in a "cache". While part of
the way to alleviate this is for the runners to run various docker
cleanup commands on their own, periodically, another thing to
potentially help would be to further clean-up in the job itself.

This patch adds "git clean -dfx" in jobs that leave some files in the
source tree (these files may lead to a cache miss, more investigation
would be required) and deleting the board build directory. This part is
both a minimal size reclamation and minimal time increase (a few
seconds).

The other part this adds is making the world build use "/tmp/world" as
the output directory not "/tmp" so that we can then delete "/tmp/world"
afterwards. This adds between 1m30 and 3m to the build.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 .gitlab-ci.yml | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2dbe6325f334..ce7a391bbd00 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -63,8 +63,9 @@ stages:
         -r tools/buildman/requirements.txt -r tools/u_boot_pylib/requirements.txt
 
   after_script:
+    - git clean -dfx
     - cp -v /tmp/${TEST_PY_BD}/*.{html,css,xml} .
-    - rm -rf /tmp/uboot-test-hooks /tmp/venv
+    - rm -rf /tmp/uboot-test-hooks /tmp/venv /tmp/${TEST_PY_BD}
   script:
     # If we've been asked to use clang only do one configuration.
     - export UBOOT_TRAVIS_BUILD_DIR=/tmp/${TEST_PY_BD}
@@ -130,11 +131,13 @@ build all platforms in a single job:
         -r tools/buildman/requirements.txt
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      ./tools/buildman/buildman -o /tmp -PEWM -x xtensa || ret=$?;
+      ./tools/buildman/buildman -o /tmp/world -PEWM -x xtensa || ret=$?;
       if [[ $ret -ne 0 ]]; then
-        ./tools/buildman/buildman -o /tmp -seP;
+        ./tools/buildman/buildman -o /tmp/world -seP;
         exit $ret;
       fi;
+  after_script:
+    - rm -rf /tmp/world
 
 .testsuites:
   stage: testsuites
@@ -155,11 +158,15 @@ check for new CONFIG symbols outside Kconfig:
 docs:
   extends: .testsuites
   script:
+    - git config --global --add safe.directory "${CI_PROJECT_DIR}"
     - virtualenv -p /usr/bin/python3 /tmp/venvhtml
     - . /tmp/venvhtml/bin/activate
     - pip install -r doc/sphinx/requirements.txt
     - make htmldocs KDOC_WERROR=1
     - make infodocs
+  after_script:
+    - rm -rf /tmp/venvhtml
+    - git clean -dfx
 
 # ensure all configs have MAINTAINERS entries
 Check for configs without MAINTAINERS entry:
@@ -173,7 +180,8 @@ Build tools-only and envtools:
   script:
     - make tools-only_config tools-only -j$(nproc);
       make mrproper;
-      make tools-only_config envtools -j$(nproc)
+      make tools-only_config envtools -j$(nproc);
+      make mrproper
 
 Run binman, buildman, dtoc, Kconfig and patman testsuites:
   extends: .testsuites
@@ -201,6 +209,9 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
       ./tools/dtoc/dtoc -t;
       ./tools/patman/patman test;
       make testconfig
+  after_script:
+    - rm -rf /tmp/venv /tmp/tools-only
+    - git clean -dfx
 
 # Check for any pylint regressions
 Run pylint:
@@ -223,6 +234,9 @@ Run pylint:
     - pylint --version
     - export PYTHONPATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt"
     - make pylint_err
+  after_script:
+    - rm -rf /tmp/venv /tmp/tools-only
+    - git clean -dfx
 
 # Check for pre-schema driver model tags
 Check for pre-schema tags:
-- 
2.43.0

