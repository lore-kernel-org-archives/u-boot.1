Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C670CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0B9684932;
	Tue, 16 Jun 2026 16:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YEjrbuQ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 556CF84895; Tue, 16 Jun 2026 16:30:01 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD3AE84956
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so3990087a34.1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781620196; x=1782224996; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9YlUaEzU619ErOKZrAVFqIQPSwJzfPZgdQKv4sfAsU=;
 b=YEjrbuQ6kCKSpLKQ8+uUnglFkroMnwCmV5yy/41KQClMkvcTahNDr0JiVTuvSbutYm
 KB5Ze0uiaYrQadLxNhpYtSEFr9+G8s5pmYNBAUqlEVE1In85ejiwe9vqUJg8/m2Gefeq
 qg56+X2dJRk/Fyl4T1w6nOj8tnzR7pFH/a07g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781620196; x=1782224996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b9YlUaEzU619ErOKZrAVFqIQPSwJzfPZgdQKv4sfAsU=;
 b=EDMa71IFAC1L5/wgrusfPmDuLhJrqtMpzezWvgP2YB5LI9uUVKm8mf5c6A5EHgvuJE
 ignI2hcLMD1AnDOr6B0k5NHiJTrp5dnF87v6N9BCOeAlsKgCDZYPhlGn+5VHEePJp+Cs
 m01Sez5C4r0lfDPxu64J0iBGt+iH6lGavU6LCeTwHnLWt1aJ8elVuAhGEcu6gwsh0UPI
 Wdky+6s6Ayg9YMEVWWQvXvh7AfkNllzaAnUGebwJWUDYrczPvEsJ3zuIk/qqW60QQK+t
 pHpYl64RlbD/xUdEYva3m/xmd7hNSusCZfQMSdPi5/K4EQeYTjzG9xET6553c2HSYFUs
 4u9w==
X-Gm-Message-State: AOJu0YwpAYdEA/e0h72kRSJySIvm5VrwfCeNt7RZn6Xux0hQNhnZxOpf
 Odqvg7J24NMYIn2barKWK/oq/E2cQv0ritHROKVKKhDLmDcfvDv8uiFHqOVGvCnckOJ7XlTHnqS
 aS5c=
X-Gm-Gg: Acq92OH2E2Lr7Y8FaHGcLO91opCLVAdcc6tQi+hdj5eY5WvmR3F5T+p1wEGPAkTcbM/
 qBvGv8wGvsF0DkerAeD6DWBO7ODDZ8UQUl8NpiVZljQUvzqqjcmJN4/DqfzsIuEucKgHUD39Npa
 kgfYr0rWvM0HyFkDrKsUWuguAQr1za6jlxDiYKPh6+GS6fMMJE4n/BTzO9Wv6bGCPy4N6hsPLQT
 Bbaqai23XNO3D3JL9k70Dr3YxjRv24+tsC6V6R6cvKF6Xwv+0IzjIhscHazO0Oq3fXpv7sdaByE
 HdItYsYIKsAtOTSxqfq+W+1no7DslhvG7gV/DqmZLe0dwmjhMjufnLpsqGFMXXGDJ7Ia6bqKF8f
 UybRE9jAmbB2mb3phqtO1QrBwUvJI2pzQU5jaeRvv9i8PBAySrNEogbKRFDLDtFkLJzjOrzd0km
 PW4wleGHt4zJhKMfbiZQ==
X-Received: by 2002:a05:6830:2b2a:b0:7e6:ef1d:4aeb with SMTP id
 46e09a7af769-7e7847629fbmr13198039a34.15.1781620196586; 
 Tue, 16 Jun 2026 07:29:56 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e79f6fb5edsm7263749a34.26.2026.06.16.07.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:29:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/9] CI: Stop building and testing patman
Date: Tue, 16 Jun 2026 08:28:46 -0600
Message-ID: <20260616142859.54136-7-sjg@chromium.org>
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

patman is now just a stub, so drop its requirements file and its
'patman test' run from the Azure and GitLab pipelines.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .azure-pipelines.yml | 5 +----
 .gitlab-ci.yml       | 7 +++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 4417ef4e5a5..a95e4ce17c3 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -146,7 +146,7 @@ stages:
           make tools-only_config envtools -j$(nproc)
 
   - job: utils
-    displayName: 'Run binman, buildman, dtoc, Kconfig and patman testsuites'
+    displayName: 'Run binman, buildman, dtoc and Kconfig testsuites'
     pool:
       vmImage: $(ubuntu_vm)
     container:
@@ -163,7 +163,6 @@ stages:
           pip install -r test/py/requirements.txt \
             -r tools/binman/requirements.txt \
             -r tools/buildman/requirements.txt \
-            -r tools/patman/requirements.txt \
             -r tools/u_boot_pylib/requirements.txt
           export UBOOT_TRAVIS_BUILD_DIR=/tmp/tools-only
           export PYTHONPATH=${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt
@@ -177,7 +176,6 @@ stages:
           COVERAGE_FILE=/tmp/.coverage ./tools/binman/binman ${TOOLPATH} test -T
           ./tools/buildman/buildman -t
           ./tools/dtoc/dtoc -t
-          ./tools/patman/patman test
           make O=${UBOOT_TRAVIS_BUILD_DIR} testconfig
 
   - job: pylint
@@ -196,7 +194,6 @@ stages:
           pip install -r test/py/requirements.txt \
             -r tools/binman/requirements.txt \
             -r tools/buildman/requirements.txt \
-            -r tools/patman/requirements.txt \
             -r tools/u_boot_pylib/requirements.txt \
             asteval pylint==3.3.4 pyopenssl
           export PATH=${PATH}:~/.local/bin
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 245e422d72f..d3aa89e14aa 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -206,7 +206,7 @@ Build allyesconfig, tools-only and envtools:
       make mrproper;
       make tools-only_config envtools -j$(nproc)
 
-Run binman, buildman, dtoc, Kconfig and patman testsuites:
+Run binman, buildman, dtoc and Kconfig testsuites:
   extends: .testsuites
   tags:
     - ${DEFAULT_AMD64_TAG}
@@ -218,7 +218,7 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
       python3 -m venv /tmp/venv;
       . /tmp/venv/bin/activate;
       pip install -r test/py/requirements.txt -r tools/binman/requirements.txt
-        -r tools/buildman/requirements.txt -r tools/patman/requirements.txt
+        -r tools/buildman/requirements.txt
         -r tools/u_boot_pylib/requirements.txt;
       export UBOOT_TRAVIS_BUILD_DIR=/tmp/tools-only;
       export PYTHONPATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt";
@@ -233,7 +233,6 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
       ./tools/binman/binman ${TOOLPATH} test -T;
       ./tools/buildman/buildman -t;
       ./tools/dtoc/dtoc -t;
-      ./tools/patman/patman test;
       make testconfig
 
 # Check for any pylint regressions
@@ -244,7 +243,7 @@ Run pylint:
     - python3 -m venv /tmp/venv
     - . /tmp/venv/bin/activate
     - pip install -r test/py/requirements.txt -r tools/binman/requirements.txt
-        -r tools/buildman/requirements.txt -r tools/patman/requirements.txt
+        -r tools/buildman/requirements.txt
         -r tools/u_boot_pylib/requirements.txt asteval pylint==3.3.4 pyopenssl
     - export PATH=${PATH}:~/.local/bin
     - echo "[MASTER]" >> .pylintrc
-- 
2.43.0

