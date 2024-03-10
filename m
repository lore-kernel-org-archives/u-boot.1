Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA51C54791
	for <u-boot@archiver.kernel.org>; Sun, 10 Mar 2024 19:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBEBF87C82;
	Sun, 10 Mar 2024 20:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sDTwMDVv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3055387D73; Sun, 10 Mar 2024 20:59:36 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A18B878E2
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 20:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-42f468b62f1so2106401cf.1
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 12:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710100770; x=1710705570; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=hCB0TtPHB+F7MpTUQeGJjWIvJNkjdtgfOcTFkT2Cb20=;
 b=sDTwMDVvexhA8HzS5lyTMkU9iwfnyDxQyYm2z3DcMpn5buAJ471MVLAAm/cDq56EW2
 JOXaDetxKIFyo33AZ5LVhAI+/SaG7B2+xATHfDN4WwZ9Gv0jZ2//kd0K5cZQsgrolBsR
 lyWZCkeSCLBys2mHs+xHZcIFT+IWAJK8mdvAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710100770; x=1710705570;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hCB0TtPHB+F7MpTUQeGJjWIvJNkjdtgfOcTFkT2Cb20=;
 b=GggvTbO8YsWDiC1ohK7exUYm3HLfChaZ0J+HzaUuzOnVTJ03rsoPIXqSeeqkwL79zp
 G4iIv31qs8Zzu4H13hR292r6rYZZu/G4UHZvKBAhpFggiJA8N59TD7wx0nAl7LztyPgv
 UbJjz8kNZos3FgQc8ESufNsaL5cdy7cbpcsRvI0I3TOKGUpadxLKeSMt0UbnMKHoU0gR
 rjM64GzufjeijwP6ZjvWlvPCXsMT61UcB+OueGZFDxK40qHVhQk3A0rhSbcTo6b2dDpo
 AzWraI3axJxLJffK3SrEurrgrIo51TkLC1PYj/K217MCVY8WHvrPTWs+2LYmB1Cb26LI
 xRnQ==
X-Gm-Message-State: AOJu0YxVkRNtcgFdSuNJ4YUSlQtWhwhdMeUtCpeX/GTjmSFih/QiCRcd
 q9uLzm3kftLyDHkLHygUmbrlTsqmyIkFmLiPxzaM4zD/VcJyEK/+OjSrsVc2B1MoQMhuly/vuPO
 c
X-Google-Smtp-Source: AGHT+IEii2t72dof0jxAX3sikvNRpjGckKsYkUEwLpbAFfE0eEPbDida6K3TYSt8OgMxxJIHDVceQA==
X-Received: by 2002:a05:622a:10:b0:42e:f994:5970 with SMTP id
 x16-20020a05622a001000b0042ef9945970mr7149140qtw.38.1710100769867; 
 Sun, 10 Mar 2024 12:59:29 -0700 (PDT)
Received: from bill-the-cat..
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 f15-20020ac8464f000000b0042e703a8d74sm2056801qto.56.2024.03.10.12.59.29
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Mar 2024 12:59:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] CI: Update to using clang-17
Date: Sun, 10 Mar 2024 15:59:28 -0400
Message-Id: <20240310195928.730127-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

Currently, llvm-17 is the stable release. Update our container and CI to
fetch and use that.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml    | 6 +++---
 .gitlab-ci.yml          | 4 ++--
 tools/docker/Dockerfile | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 1d73215afbae..798c137b2f6e 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -278,16 +278,16 @@ stages:
           TEST_PY_TEST_SPEC: "version"
         sandbox_clang:
           TEST_PY_BD: "sandbox"
-          OVERRIDE: "-O clang-16"
+          OVERRIDE: "-O clang-17"
         sandbox_clang_asan:
           TEST_PY_BD: "sandbox"
-          OVERRIDE: "-O clang-16 -a ASAN"
+          OVERRIDE: "-O clang-17 -a ASAN"
           TEST_PY_TEST_SPEC: "version"
         sandbox64:
           TEST_PY_BD: "sandbox64"
         sandbox64_clang:
           TEST_PY_BD: "sandbox64"
-          OVERRIDE: "-O clang-16"
+          OVERRIDE: "-O clang-17"
         sandbox_spl:
           TEST_PY_BD: "sandbox_spl"
           TEST_PY_TEST_SPEC: "test_ofplatdata or test_handoff or test_spl"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8bfbadd6c89f..dc68187d79cf 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -256,7 +256,7 @@ sandbox test.py:
 sandbox with clang test.py:
   variables:
     TEST_PY_BD: "sandbox"
-    OVERRIDE: "-O clang-16"
+    OVERRIDE: "-O clang-17"
   <<: *buildman_and_testpy_dfn
 
 sandbox64 test.py:
@@ -267,7 +267,7 @@ sandbox64 test.py:
 sandbox64 with clang test.py:
   variables:
     TEST_PY_BD: "sandbox64"
-    OVERRIDE: "-O clang-16"
+    OVERRIDE: "-O clang-17"
   <<: *buildman_and_testpy_dfn
 
 sandbox_spl test.py:
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 6122776bc64d..ab82d01a3417 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -12,7 +12,7 @@ ENV DEBIAN_FRONTEND=noninteractive
 # Add LLVM repository
 RUN apt-get update && apt-get install -y gnupg2 wget xz-utils && rm -rf /var/lib/apt/lists/*
 RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
-RUN echo deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-16 main | tee /etc/apt/sources.list.d/llvm.list
+RUN echo deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-17 main | tee /etc/apt/sources.list.d/llvm.list
 
 # Manually install the kernel.org "Crosstool" based toolchains for gcc-13.2.0
 RUN wget -O - https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2.0/x86_64-gcc-13.2.0-nolibc-aarch64-linux.tar.xz | tar -C /opt -xJ
@@ -40,7 +40,7 @@ RUN apt-get update && apt-get install -y \
 	bison \
 	build-essential \
 	cgpt \
-	clang-16 \
+	clang-17 \
 	coreutils \
 	cpio \
 	curl \
-- 
2.34.1

