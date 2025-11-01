Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C926CCFA03
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 15:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9009083642;
	Sat,  1 Nov 2025 16:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SEKLa7O7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A7E836D1; Sat,  1 Nov 2025 16:32:08 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A9178331F
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 16:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3d37c1fb05aso1334269fac.0
 for <u-boot@lists.denx.de>; Sat, 01 Nov 2025 08:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762011124; x=1762615924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=EPJNhWFjvWbtytOqEVUJF39NCieFOqVMQUjSW+mJwgs=;
 b=SEKLa7O7Pcc4Sv4HZF5Z1CFtGILpT5vmK7w+95asTmoLmhnI2niEygzwrdSzE8p4Ff
 d6e4CqHJtvFLWD7ct1nfrp8GhSnplR7qPBZiXzxX1Z0nR8Y2dYwfNWEvjEZl7W49TtAV
 EUEd7kihlavrW921qI0Lr0eQ6ihCytlZ5k99o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762011124; x=1762615924;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EPJNhWFjvWbtytOqEVUJF39NCieFOqVMQUjSW+mJwgs=;
 b=HSHYLkyVlU3hnvc2R980zMS6lTkct7VIjTCOy8iKbUxbGRT3ORNRTSfDSxcfQV0ZGd
 7KV+eQ85kstgi+7tCs1UWMsLFIHpnGCWXgW98qeMRl/YWlZbyk1GHzr6fX319ywjTzM4
 OxProoq2dh9K8w8YEemPfG3vi2dfhvlJAyPoT69NG5eHvvIbWB3bkC19bRElu1RwEKtL
 KfHMhVghDzvLX3dePEouKnPMXrZdUVS4qn3VpdhahrUl3PhiOrkCNqjXGS4iJPs1OzjU
 Do4dRRoC4YrDyqCdQHEGn1TF2YEJbFZmZgFHazoEJJkvLLyPPx3wjdk532woNTlcPNJo
 jJGQ==
X-Gm-Message-State: AOJu0Yz4/7xWU3ffzM3AE2kXyxY2GX1NKPOw4xroJ+QWLn2X80svSmcW
 J56okdeuxpSxuy5iRkYOA1MTtXz5pRFA4UA7A878OuLczDjJUGGL/+0dZiTKPuvb4R7Fbl6UXGg
 meXx3FKlC1g==
X-Gm-Gg: ASbGncsreUi9883Eam76pFjUMTWLcXBhmwPb/qO+WF6SwRYT0lI/Quzms6757vb4EPq
 6KVPJoPwZuxF2s2ZG/39xMtzwXc6jorQVRmCO+g7Xt2Mgvys1aqth+C/u+AyMN+lNdkXDdM1uvx
 Uk9n/JqLjYe97bK0ts+jwmi9Vsf1mtLKrMZhMH0TwnaYOd8kvBO4qhCw59TBP1KUtEzXPPWUuKg
 BVZ045s4hAHHfZv60FpDGNPIQ4dFJyA1GdpKh/DHj1PpO8mWRTevIt69cTHUt5HJTVD9hxqRvH7
 PtvSkuXa1MSxZg1hROUPxMz7lu4zG/Qe/GkXKTcRkKWDODpay2tLEifUkOEnFuMN/qsmxRybmd1
 iA6EmguXRAeFdZBgG7bl9wnXP5D4Bx/dgl7jFNS99i9Ft/xhZNsEqQJdpYLtJPRsXXb6eO3FkPM
 jeAtoHRJpEpcirbTVkPqeWZ7Sa1JW6AknEHDzVo2bC5WyolEiIoR1t
X-Google-Smtp-Source: AGHT+IFgNJSl95S1mULYR9tbp0XtLHX8jQSfhmcBWv2x+flq5i57HPoVNvWbLS8+4PVUpXMF50UPdQ==
X-Received: by 2002:a05:6870:1c8:b0:3cd:aa5b:9d1f with SMTP id
 586e51a60fabf-3dacf0009d3mr3570001fac.51.1762011123920; 
 Sat, 01 Nov 2025 08:32:03 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3db40891bd5sm1739328fac.6.2025.11.01.08.32.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Nov 2025 08:32:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] CI: Move to Ubuntu 24.04 'Noble' as the base
Date: Sat,  1 Nov 2025 09:32:01 -0600
Message-ID: <20251101153201.830803-1-trini@konsulko.com>
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

The changes here are that we need to ensure python setuptools are
in our build virtual environments as they will no longer come in via
python even in a virtual environment. As part of this ensure setuptools
is in our cache and also include pytest-azurepipelines as we should have
been doing. Next, we move away from using apt-key directly and move that
stanza towards the rest of the apt work.  This also lets us drop
directly installing gnupg2. These steps are not strictly required for
24.04 but will be for later releases and are valid now. Finally, we drop
the unused PTYHONPATH ENV line.

In order to use these containers however, we need to stop running the
event_dump test as the 'addr2line' tool provided by binutils no longer
is able to decode those specific events in most cases. As this is a
problem with binutils and present for some time now, disabling the test
until someone has time to work with upstream this seems reasonable.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
For completeness, this depends on Heinrich's patch to drop the python2.7
package from the Dockerfile.
---
 .azure-pipelines.yml    |  9 +++++++--
 .gitlab-ci.yml          |  7 ++++++-
 tools/docker/Dockerfile | 16 +++++++++-------
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index fc55c8b21006..c4d84d0c66e7 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -2,7 +2,7 @@ variables:
   windows_vm: windows-2022
   ubuntu_vm: ubuntu-24.04
   macos_vm: macOS-14
-  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025
+  ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20251001-31Oct2025
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
   # denied" error when it tries to "useradd -m -u 1001 vsts_azpcontainer",
   # since our $(ci_runner_image) user is not root.
@@ -352,6 +352,8 @@ stages:
         sandbox:
           TEST_PY_BD: "sandbox"
           TEST_PY_EXTRA: "--timing"
+          # addr2line in Ubuntu 'Noble' and later are broken.
+          TEST_PY_TEST_SPEC: "not event_dump"
         sandbox_asan:
           TEST_PY_BD: "sandbox"
           OVERRIDE: "-a ASAN"
@@ -359,6 +361,8 @@ stages:
         sandbox_clang:
           TEST_PY_BD: "sandbox"
           OVERRIDE: "-O clang-18"
+          # addr2line in Ubuntu 'Noble' and later are broken.
+          TEST_PY_TEST_SPEC: "not event_dump"
         sandbox_clang_asan:
           TEST_PY_BD: "sandbox"
           OVERRIDE: "-O clang-18 -a ASAN"
@@ -638,7 +642,8 @@ stages:
           python3 -m venv /tmp/venv
           . /tmp/venv/bin/activate
           pip install -r tools/binman/requirements.txt \
-            -r tools/buildman/requirements.txt
+            -r tools/buildman/requirements.txt \
+            setuptools
           EOF
           cat << "EOF" >> build.sh
           if [[ "${BUILDMAN}" != "" ]]; then
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 73ff975e5746..e1409af57e4c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -20,7 +20,7 @@ workflow:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025
+image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:noble-20251001-31Oct2025
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
@@ -146,6 +146,7 @@ build all platforms in a single job:
       . /tmp/venv/bin/activate;
       pip install -r tools/binman/requirements.txt
         -r tools/buildman/requirements.txt
+        setuptools
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
       ./tools/buildman/buildman -o /tmp -PEWM -x xtensa || ret=$?;
@@ -271,6 +272,8 @@ sandbox test.py:
   variables:
     TEST_PY_BD: "sandbox"
     TEST_PY_EXTRA: "--timing"
+    # addr2line in Ubuntu 'Noble' and later are broken.
+    TEST_PY_TEST_SPEC: "not event_dump"
   <<: *buildman_and_testpy_dfn
 
 sandbox with clang test.py:
@@ -283,6 +286,8 @@ sandbox with clang test.py:
   variables:
     TEST_PY_BD: "sandbox"
     OVERRIDE: "-O clang-18"
+    # addr2line in Ubuntu 'Noble' and later are broken.
+    TEST_PY_TEST_SPEC: "not event_dump"
   <<: *buildman_and_testpy_dfn
 
 sandbox64 test.py:
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 95ce1fdc6cc1..fa6eeb4ba51e 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -2,7 +2,7 @@
 # This Dockerfile is used to build an image containing basic stuff to be used
 # to build U-Boot and run our test suites.
 
-FROM ubuntu:jammy-20250714
+FROM ubuntu:noble-20251001
 LABEL org.opencontainers.image.authors="Tom Rini <trini@konsulko.com>"
 LABEL org.opencontainers.image.description=" This image is for building U-Boot inside a container"
 
@@ -27,12 +27,10 @@ ENV TCVER=14.2.0
 
 RUN echo "Building on $BUILDPLATFORM, for target $TARGETPLATFORM"
 
-# Add LLVM repository
+# Add tools to fetch archives with
 RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
     --mount=type=cache,target=/var/lib/apt,sharing=locked \
-    apt-get update && apt-get install -y gnupg2 wget xz-utils
-RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
-RUN echo deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-18 main | tee /etc/apt/sources.list.d/llvm.list
+    apt-get update && apt-get install -y wget xz-utils
 
 # Create a list of URLs to process, then pass them into a 'while read' loop
 RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then HOSTARCH=x86_64; else HOSTARCH=arm64; fi; ( \
@@ -54,6 +52,10 @@ RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
 		wget -O - https://github.com/foss-xtensa/toolchain/releases/download/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz; \
 	fi
 
+# Add LLVM repository
+RUN wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc
+RUN echo deb http://apt.llvm.org/noble/ llvm-toolchain-noble-18 main | tee /etc/apt/sources.list.d/llvm.list
+
 # Update and install things from apt now
 RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
     --mount=type=cache,target=/var/lib/apt,sharing=locked \
@@ -325,7 +327,8 @@ RUN python3 -m venv /tmp/venv && \
 		-r /tmp/binman-requirements.txt \
 		-r /tmp/buildman-requirements.txt \
 		-r /tmp/patman-requirements.txt \
-		-r /tmp/u_boot_pylib-requirements.txt && \
+		-r /tmp/u_boot_pylib-requirements.txt \
+		setuptools pytest-azurepipelines && \
 	deactivate && \
 	rm -rf /tmp/venv /tmp/*-requirements.txt
 
@@ -343,4 +346,3 @@ RUN /bin/echo -e "\nx86 = i386" >> ~/.buildman;
 
 # Add mkbootimg tool
 RUN git clone https://android.googlesource.com/platform/system/tools/mkbootimg /home/uboot/mkbootimg
-ENV PYTHONPATH="${PYTHONPATH}:/home/uboot/mkbootimg"
-- 
2.43.0

