Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D17CCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 15:11:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C517D8389A;
	Sun,  2 Nov 2025 16:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gxX4zQcS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02EE0838A5; Sun,  2 Nov 2025 16:11:36 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8069A83642
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 16:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3d1bc63d5f0so2114853fac.0
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 07:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762096292; x=1762701092; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=N/xXZkdee4DtMDcKBlSDydatpcIz7pUYprcL0xDZNUI=;
 b=gxX4zQcSPqmSYx+bGTp/J39tV4XkOGUvPPKKE9iJTNcUibFuzeXfz76+hdcD7NbYlk
 5mtcZKFqQGmxhcai5GxDw6iHt2aNxblBnqbQTzVGD+2cQ4MlZ55vPTnm0TdPJ9B7tMlt
 AI9Tt8vWPMZ08iZZ1uuGc5BcCxvCpN8H1Wstc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762096292; x=1762701092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N/xXZkdee4DtMDcKBlSDydatpcIz7pUYprcL0xDZNUI=;
 b=HeHJOv538Mflpu70Yazb8IETbYZNT9u5bWO9uTkss1wKRbZBM0ERqeC4Z6P8MWzZpH
 hprdTzI2+VCbOxhyrScrXfLC3D39SXodS3L1j6EIMnc1duYlAVbjrm4C2pGCxKm0zM5p
 3s2pafOvzR20kM4uIE78gqCLGJVuYsGIfaW2fas1QF6yVpqv5lPLtXi2OWXqQ0hPLzB2
 JQNjnCR+UJ4/0AXANz6boqz48io+9WYFe6EGbt7/RVX1WqXX6/7lsSFWfqoNnJi7bvLO
 YqfXnBix96/Y7ViaxLUKfbRVuJ+hsahvbZH77NthE21jUtGALdjw3q5xMN17Dv8nj9aC
 MVqg==
X-Gm-Message-State: AOJu0YzkmZsyxV0nCoCjxB2ByCUeLxfA6rAw7TjjtlkCKznOjIOOf0oI
 nFpEhRPrnd0tE+LfueeyrtV0f/XytUdgLqU5lm2fkVINTL8pKPtklqvHdxS3KYq/O/ZdPDmpMnq
 +RhDvJqzkkw==
X-Gm-Gg: ASbGncsLZ9FnZ02ia5HpYo7GPnaBJeij/+mYspkgSTk0aPFFOz6bvOF0/ZiWiVydcbK
 h2yeRvT2IZ8UDC+qPn9pcnh+1KqPiNqMO+WkUvTr2UqATSc3eMYC3EpefWgSD2QBIWi1Q/oqAZf
 as3rQT24T0yaY0svzcS7HclrGQf7kLuOlzTyDBiYCrb67OEYt+6kxVJ6QZ7H15dAcqsqnPt5kWw
 DkVZqFtZQdc5npoGasUGOwBF5oq4iznt0G1T9qZpvRZZX2P43aUg2907tgbp3EvJIMEbsOQGK9h
 m0mtcPDg+cHuvOFo3XruR0OlV/CGFLxJcWhF4ByJadQRfvGNtwdpGZFBmXaObZyNclsyyBXryx6
 27TYVHPKAYCj7r505EnEZnSbP/NxRTEVZvwn8et1nYIqdHfqDJzcFzGmAEOnlzq+iBqWKWplL+D
 qZJ4N6Yq5Yx0a+GPYvSfMeSFJfakTg6hUXRY4KaM6HRAbrOdJoGpb4UT7C9uI0XWg=
X-Google-Smtp-Source: AGHT+IF4htm7dynm4dpPFuy2r3dcP+Yv4g983PplsmyVcuDDHJ+VCurXrxHZIk81bYcmMh2qj1+EvA==
X-Received: by 2002:a05:6871:ea0b:b0:3d9:158e:d943 with SMTP id
 586e51a60fabf-3dac9f03a5dmr4004755fac.9.1762096292164; 
 Sun, 02 Nov 2025 07:11:32 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c699c204ddsm2131041a34.12.2025.11.02.07.11.30
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 07:11:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] CI: Update to LLVM 20 release
Date: Sun,  2 Nov 2025 09:11:30 -0600
Message-ID: <20251102151130.1429360-1-trini@konsulko.com>
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

The current stable release for LLVM is 20, so update to that from 18. No
issues seen in CI.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml    | 8 ++++----
 .gitlab-ci.yml          | 6 +++---
 tools/docker/Dockerfile | 4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index c4d84d0c66e7..c33f39a1da30 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -2,7 +2,7 @@ variables:
   windows_vm: windows-2022
   ubuntu_vm: ubuntu-24.04
   macos_vm: macOS-14
-  ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20251001-31Oct2025
+  ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20251001-01Nov2025
   # Add '-u 0' options for Azure pipelines, otherwise we get "permission
   # denied" error when it tries to "useradd -m -u 1001 vsts_azpcontainer",
   # since our $(ci_runner_image) user is not root.
@@ -360,18 +360,18 @@ stages:
           TEST_PY_TEST_SPEC: "version"
         sandbox_clang:
           TEST_PY_BD: "sandbox"
-          OVERRIDE: "-O clang-18"
+          OVERRIDE: "-O clang-20"
           # addr2line in Ubuntu 'Noble' and later are broken.
           TEST_PY_TEST_SPEC: "not event_dump"
         sandbox_clang_asan:
           TEST_PY_BD: "sandbox"
-          OVERRIDE: "-O clang-18 -a ASAN"
+          OVERRIDE: "-O clang-20 -a ASAN"
           TEST_PY_TEST_SPEC: "version"
         sandbox64:
           TEST_PY_BD: "sandbox64"
         sandbox64_clang:
           TEST_PY_BD: "sandbox64"
-          OVERRIDE: "-O clang-18"
+          OVERRIDE: "-O clang-20"
         sandbox64_lwip:
           TEST_PY_BD: "sandbox64_lwip"
         sandbox_spl:
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e1409af57e4c..fb8f36b37553 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -20,7 +20,7 @@ workflow:
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
-image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:noble-20251001-31Oct2025
+image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:noble-20251001-01Nov2025
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
@@ -285,7 +285,7 @@ sandbox with clang test.py:
     - ${HOST}
   variables:
     TEST_PY_BD: "sandbox"
-    OVERRIDE: "-O clang-18"
+    OVERRIDE: "-O clang-20"
     # addr2line in Ubuntu 'Noble' and later are broken.
     TEST_PY_TEST_SPEC: "not event_dump"
   <<: *buildman_and_testpy_dfn
@@ -310,7 +310,7 @@ sandbox64 with clang test.py:
     - ${HOST}
   variables:
     TEST_PY_BD: "sandbox64"
-    OVERRIDE: "-O clang-18"
+    OVERRIDE: "-O clang-20"
   <<: *buildman_and_testpy_dfn
 
 sandbox64_lwip test.py:
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index fa6eeb4ba51e..f227049fbbf2 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -54,7 +54,7 @@ RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
 
 # Add LLVM repository
 RUN wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc
-RUN echo deb http://apt.llvm.org/noble/ llvm-toolchain-noble-18 main | tee /etc/apt/sources.list.d/llvm.list
+RUN echo deb http://apt.llvm.org/noble/ llvm-toolchain-noble-20 main | tee /etc/apt/sources.list.d/llvm.list
 
 # Update and install things from apt now
 RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
@@ -68,7 +68,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	build-essential \
 	byacc \
 	cgpt \
-	clang-18 \
+	clang-20 \
 	coreutils \
 	cpio \
 	curl \
-- 
2.43.0

