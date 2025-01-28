Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A0DC0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 23:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C56681244;
	Wed, 29 Jan 2025 00:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DzjtsYC1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A48A781727; Wed, 29 Jan 2025 00:02:11 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EC08811E1
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 00:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d92e457230so60475876d6.1
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 15:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738105328; x=1738710128; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6zxmRzM1h97Z4uB0FGqxOQd08eHUK0H85xuW7aLKF80=;
 b=DzjtsYC11WRCkxDPJNyfk/GCZ9oVLY/SXlrOi+bsxC3MfZIruT6XSLPp8KHPvIZjYd
 30+c+5YgMo71Tf54SQcbE1SsPi/TH02H/xUQ41TSjO/whRig86PbBe5vAR8sqPctdN+0
 ejN/fKrqd4imYDwnYo527wuyY1V0kMFosDQoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738105328; x=1738710128;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6zxmRzM1h97Z4uB0FGqxOQd08eHUK0H85xuW7aLKF80=;
 b=tQFbUkaOCaIlW1/cHoIebTChf/VBRU9c55U03rMXg9WxiPe9U/i6D5tTq9A6PlGF/1
 HtzFspf7PKIXlPOPM8Zr98ZdttdGvhuC6hApcVS+N0dhefsTjpkZ8eBIsGzGDX4f4S9Z
 PFxoLCzkFN8sdySwqEXaIAHUY3Kb36SrnDWiO9DzHgqJnGBoJIvfMHHeQQ43upF16I04
 G0uBwwk0+3xy74tFdRXEsnbQKjXnOj7FXdI3bxC/XCXTcvcbxMWmt840M/CqpUrRcGru
 ATJncvyk61+6t1T3cvV80Jkqij1JR8g19hNWJFMrkNKQi49UBj4rEIdRo1+UQON4arQF
 nCsg==
X-Gm-Message-State: AOJu0YxWp3dAvaqfLFA1vpVEp3Yet2XOSYIJ9sIWC/X5pSY3S4fYwA/b
 XwYSRJYTxHxyJ386YkacMsovHzHuYEgC0CZ9r+rpLAutbbO3qeQEn3SyBeM8wC80GOgy/lqSzc1
 a
X-Gm-Gg: ASbGncs3qV38KzB9Q3Rny+2cdZqWWgZJbIJETg3SOWKdLlWHOR+9u7qp/KYeIzfbpOI
 gzthkwq7HRoI7GHuEu9Kfl7wTgOC56onvAh20Y9aj9znoSBfRmWha8pWgzp8nwupMy0X5KkSFxb
 UEBFNOfjjtu4rYZ46jnMvcttMmip3a2ZI9ZXOd1VBkvePG/AUpUx+03RkI2fRevzmMCMCWtpB0i
 Nk1WWg/bpTumYDcpmgw1WDgKg0H7Yv5GoRfBdR4PVqZGRQhTMPRGhyhfV+Q6MQVWtqDNdAli4nl
 7d51x5WPBn6SWQPRTQ==
X-Google-Smtp-Source: AGHT+IFmzeWI95LBUCYsucB3/BsGMtr6ATzU9bGTroMRrWPr4XMh3YMEFECPQPbKT77OiSsFSbUO3Q==
X-Received: by 2002:a05:6214:19c4:b0:6d8:8b9d:1502 with SMTP id
 6a1803df08f44-6e243c648b9mr13135606d6.30.1738105327914; 
 Tue, 28 Jan 2025 15:02:07 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2058c1e64sm49898476d6.96.2025.01.28.15.02.06
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 15:02:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Dockerfile: Update to gcc-14.2.0 and clang-18
Date: Tue, 28 Jan 2025 17:02:05 -0600
Message-ID: <20250128230205.2062703-1-trini@konsulko.com>
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

Outside of changing versions here the other visible change is that we
tell grub that riscv64 does not have "large model" support. Without this
change the resulting mkimage is non-functional. This is known upstream
already.

Link: https://savannah.gnu.org/bugs/?65909
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml    | 8 ++++----
 .gitlab-ci.yml          | 6 +++---
 tools/docker/Dockerfile | 8 ++++----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index ba351b9802d1..4d3a5800beb3 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -2,7 +2,7 @@ variables:
   windows_vm: windows-2022
   ubuntu_vm: ubuntu-24.04
   macos_vm: macOS-14
-  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20240911.1-08Dec2024
+  ci_runner_image: trini/u-boot-gitlab-ci-runner:jammy-20240911.1-28Jan2025
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
   # denied" error when it tries to "useradd -m -u 1001 vsts_azpcontainer",
   # since our $(ci_runner_image) user is not root.
@@ -324,16 +324,16 @@ stages:
           TEST_PY_TEST_SPEC: "version"
         sandbox_clang:
           TEST_PY_BD: "sandbox"
-          OVERRIDE: "-O clang-17"
+          OVERRIDE: "-O clang-18"
         sandbox_clang_asan:
           TEST_PY_BD: "sandbox"
-          OVERRIDE: "-O clang-17 -a ASAN"
+          OVERRIDE: "-O clang-18 -a ASAN"
           TEST_PY_TEST_SPEC: "version"
         sandbox64:
           TEST_PY_BD: "sandbox64"
         sandbox64_clang:
           TEST_PY_BD: "sandbox64"
-          OVERRIDE: "-O clang-17"
+          OVERRIDE: "-O clang-18"
         sandbox_spl:
           TEST_PY_BD: "sandbox_spl"
           TEST_PY_TEST_SPEC: "test_ofplatdata or test_handoff or test_spl"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 74dc05d58a70..c3c38e24fd1d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -20,7 +20,7 @@ workflow:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240911.1-08Dec2024
+image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240911.1-28Jan2025
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
@@ -241,7 +241,7 @@ sandbox with clang test.py:
     - ${DEFAULT_AMD64_TAG}
   variables:
     TEST_PY_BD: "sandbox"
-    OVERRIDE: "-O clang-17"
+    OVERRIDE: "-O clang-18"
   <<: *buildman_and_testpy_dfn
 
 sandbox64 test.py:
@@ -256,7 +256,7 @@ sandbox64 with clang test.py:
     - ${DEFAULT_AMD64_TAG}
   variables:
     TEST_PY_BD: "sandbox64"
-    OVERRIDE: "-O clang-17"
+    OVERRIDE: "-O clang-18"
   <<: *buildman_and_testpy_dfn
 
 sandbox_spl test.py:
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index d2848ab85f35..b72ed357fa36 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -23,7 +23,7 @@ ENV ARCHS="aarch64 arc i386 m68k mips microblaze nios2 powerpc riscv64 riscv32 s
 ENV MIRROR=https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin
 
 # Toolchain version
-ENV TCVER=13.2.0
+ENV TCVER=14.2.0
 
 RUN echo "Building on $BUILDPLATFORM, for target $TARGETPLATFORM"
 
@@ -32,7 +32,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
     --mount=type=cache,target=/var/lib/apt,sharing=locked \
     apt-get update && apt-get install -y gnupg2 wget xz-utils
 RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
-RUN echo deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-17 main | tee /etc/apt/sources.list.d/llvm.list
+RUN echo deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-18 main | tee /etc/apt/sources.list.d/llvm.list
 
 # Create a list of URLs to process, then pass them into a 'while read' loop
 RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then HOSTARCH=x86_64; else HOSTARCH=arm64; fi; ( \
@@ -65,7 +65,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	bison \
 	build-essential \
 	cgpt \
-	clang-17 \
+	clang-18 \
 	coreutils \
 	cpio \
 	curl \
@@ -182,7 +182,7 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 	search search_fs_file search_fs_uuid search_label serial sleep test \
 	true && \
 	make clean && \
-	./configure --target=riscv64 --with-platform=efi \
+	grub_cv_cc_mcmodel=no ./configure --target=riscv64 --with-platform=efi \
 	CC=gcc \
 	TARGET_CC=/opt/gcc-${TCVER}-nolibc/riscv64-linux/bin/riscv64-linux-gcc \
 	TARGET_OBJCOPY=/opt/gcc-${TCVER}-nolibc/riscv64-linux/bin/riscv64-linux-objcopy \
-- 
2.43.0

