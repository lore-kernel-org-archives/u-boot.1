Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7F8E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 19:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BDDE895A1;
	Sun,  8 Dec 2024 20:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NTEmhHyr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87ACF893D6; Sun,  8 Dec 2024 20:07:57 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ADF3893F9
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 20:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b6c3629816so71300985a.1
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 11:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733684874; x=1734289674; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dRURVZeHrlrrvUADeWkc5efAgR4545thxV0StQv2ER0=;
 b=NTEmhHyrQdfwKhJMC9AU2K6RP7tDPpuWNHwghv2hEsahEALESOfojL91ROGe/qaukp
 hzEx/YeWZGgPxXTcLPDvY0Nef5Sbio2p9BJ7I8hCIoO8BmrIgP/EY1ecfiyaIigVXvYc
 zLkIcd/+ngfXjQaxiKwi2C2sS8jq33Rj116Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733684874; x=1734289674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dRURVZeHrlrrvUADeWkc5efAgR4545thxV0StQv2ER0=;
 b=uPuRClc+TEWkQci9vVEcup/UmFC8ep8FN2zqHcnckFXjt6PGim3alXczfmDeflATYz
 kCL5Mu+Kavlq+ZlnrQLvhxT94JScBrJ+38OoApHzL02lMEDd/J2DJWZ32raoEDi2Oifs
 qb1m3LQQ2y5cYxzQnuciD69GLbWlK7JaS/Kc43+D/cTdzvYwA4EpF/y9Bgv+c9o1m6ZA
 YDT8n8bHi+lNLENrW4brtqp2+5oQt3sbZgQRNHIkAIuroPrqOxCykM6sA/Z4UJ3uzxhm
 voRxj23q31glKSv7JXpDT5wUSZVjFx1ltGedtLoZTdZ74RHMPzry9VBjBylvOtnMbV1i
 Pm3A==
X-Gm-Message-State: AOJu0YzypPRTArsb47SFsQugKBtfxFl4kVhcVkvvzfT7ITe38/AdDW2n
 cYNnY9ALz3dBWoqmHbT/xou+qBti/yqheJm7vf/jLxmVe6B7YtYIGem9d3PYwTDgMbAMQsqbQhR
 KoHM=
X-Gm-Gg: ASbGncvEz7HjiKBuGUvKqL1/p4Voyw+y5tNvkzvaqfgOCUV4LzB/YmcjWn4iGxyDF/J
 f/ns50dQPSogDWMrXm3JEVDMDsqaN/UsYJUA8N4I/gaipBCfl1dTngTIRQdNCG3hsI6GlgsmpvN
 1iwllYIsntkOp9opTLcotiU+M7B8nuZn6trabhp6pVqjyirxyae1FatRmY0b/uD+yLHm6g6hkrK
 NJ+vQtouq5kwl3t+JbLkxKqAaWjGDb9gjTJoBMUTpwc8h6NSUgCwVEg/pZldxBDvBTDrxMCLg==
X-Google-Smtp-Source: AGHT+IFKw+XP/YSD07EUdp43uAUjmP1+ZryCDzQp0KGIMyC0Ccgfa1Yhs44einXfZV7xJGerxJUzqg==
X-Received: by 2002:a05:6214:c82:b0:6d8:8f81:e2ea with SMTP id
 6a1803df08f44-6d8e71a6756mr148968936d6.31.1733684874083; 
 Sun, 08 Dec 2024 11:07:54 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da66ddeasm41154076d6.25.2024.12.08.11.07.52
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 11:07:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/9] GitLab CI: Make wider use of tags
Date: Sun,  8 Dec 2024 11:07:26 -0600
Message-ID: <20241208190741.4192601-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208190741.4192601-1-trini@konsulko.com>
References: <20241208190741.4192601-1-trini@konsulko.com>
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

First, introduce DEFAULT_ALL_TAG, DEFAULT_ARM64_TAG, DEFAULT_AMD64_TAG
and DEFAULT_FAST_AMD64_TAG and remove the previous DEFAULT_TAG (as
anyone making use of that will need to adjust their jobs). This allows
us to say that some jobs can run on amd64 or arm64 hosts under the all
tag, while some jobs must run on amd64 (the Xtensa jobs due to
binary-only toolchains and sandbox for now) Then we rework the world
build stage to only run on our very fast amd64 hosts, or our arm64 hosts
(which are also very fast). This should result in a similar overall
build time but also a much more consistent overall build time as we
won't have the two big world jobs possibly run on our slower build
nodes.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .gitlab-ci.yml | 74 ++++++++++++++++++--------------------------------
 1 file changed, 27 insertions(+), 47 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2671c3bb1061..7912eeee4401 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,14 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 variables:
-  DEFAULT_TAG: ""
+  DEFAULT_ALL_TAG: "all"
+  DEFAULT_ARM64_TAG: "arm64"
+  DEFAULT_AMD64_TAG: "amd64"
+  DEFAULT_FAST_AMD64_TAG: "fast amd64"
   MIRROR_DOCKER: docker.io
   SJG_LAB: ""
   PLATFORM: linux/amd64,linux/arm64
 
 default:
   tags:
-    - ${DEFAULT_TAG}
+    - ${DEFAULT_ALL_TAG}
 
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
@@ -102,56 +105,21 @@ stages:
       junit: results.xml
     expire_in: 1 week
 
-.world_build:
+build all platforms in a single job:
   stage: world build
   rules:
     - when: always
-
-build all 32bit ARM platforms:
-  extends: .world_build
-  script:
-    - ret=0;
-      git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      pip install -r tools/buildman/requirements.txt;
-      ./tools/buildman/buildman -o /tmp -PEWM arm -x aarch64 || ret=$?;
-      if [[ $ret -ne 0 ]]; then
-        ./tools/buildman/buildman -o /tmp -seP;
-        exit $ret;
-      fi;
-
-build all 64bit ARM platforms:
-  extends: .world_build
+  parallel:
+    matrix:
+      - HOST: "arm64"
+      - HOST: "fast amd64"
+  tags:
+    - ${HOST}
   script:
-    - virtualenv -p /usr/bin/python3 /tmp/venv
-    - . /tmp/venv/bin/activate
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
       pip install -r tools/buildman/requirements.txt;
-      ./tools/buildman/buildman -o /tmp -PEWM aarch64 || ret=$?;
-      if [[ $ret -ne 0 ]]; then
-        ./tools/buildman/buildman -o /tmp -seP;
-        exit $ret;
-      fi;
-
-build all PowerPC platforms:
-  extends: .world_build
-  script:
-    - ret=0;
-      git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      ./tools/buildman/buildman -o /tmp -P -E -W powerpc || ret=$?;
-      if [[ $ret -ne 0 ]]; then
-        ./tools/buildman/buildman -o /tmp -seP;
-        exit $ret;
-      fi;
-
-# We exclude xtensa here due to not being able to build on aarch64
-# hosts but covering all platforms in the pytest section.
-build all other platforms:
-  extends: .world_build
-  script:
-    - ret=0;
-      git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      ./tools/buildman/buildman -o /tmp -PEWM -x arm,powerpc,xtensa || ret=$?;
+      ./tools/buildman/buildman -o /tmp -PEWM -x xtensa || ret=$?;
       if [[ $ret -ne 0 ]]; then
         ./tools/buildman/buildman -o /tmp -seP;
         exit $ret;
@@ -200,6 +168,8 @@ Build tools-only and envtools:
 
 Run binman, buildman, dtoc, Kconfig and patman testsuites:
   extends: .testsuites
+  tags:
+    - ${DEFAULT_AMD64_TAG}
   script:
     - git config --global user.name "GitLab CI Runner";
       git config --global user.email trini@konsulko.com;
@@ -259,22 +229,30 @@ Check packing of Python tools:
 
 # Test sandbox with test.py
 sandbox test.py:
+  tags:
+    - ${DEFAULT_AMD64_TAG}
   variables:
     TEST_PY_BD: "sandbox"
   <<: *buildman_and_testpy_dfn
 
 sandbox with clang test.py:
+  tags:
+    - ${DEFAULT_AMD64_TAG}
   variables:
     TEST_PY_BD: "sandbox"
     OVERRIDE: "-O clang-17"
   <<: *buildman_and_testpy_dfn
 
 sandbox64 test.py:
+  tags:
+    - ${DEFAULT_AMD64_TAG}
   variables:
     TEST_PY_BD: "sandbox64"
   <<: *buildman_and_testpy_dfn
 
 sandbox64 with clang test.py:
+  tags:
+    - ${DEFAULT_AMD64_TAG}
   variables:
     TEST_PY_BD: "sandbox64"
     OVERRIDE: "-O clang-17"
@@ -329,6 +307,8 @@ evb-ast2600 test.py:
   <<: *buildman_and_testpy_dfn
 
 sandbox_flattree test.py:
+  tags:
+    - ${DEFAULT_AMD64_TAG}
   variables:
     TEST_PY_BD: "sandbox_flattree"
   <<: *buildman_and_testpy_dfn
@@ -454,7 +434,7 @@ qemu-xtensa-dc233c test.py:
     TEST_PY_BD: "qemu-xtensa-dc233c"
     TEST_PY_TEST_SPEC: "not sleep and not efi"
   tags:
-    - all
+    - ${DEFAULT_AMD64_TAG}
   <<: *buildman_and_testpy_dfn
 
 r2dplus_i82557c test.py:
@@ -519,7 +499,7 @@ xtfpga test.py:
     TEST_PY_TEST_SPEC: "not sleep"
     TEST_PY_ID: "--id qemu"
   tags:
-    - all
+    - ${DEFAULT_AMD64_TAG}
   <<: *buildman_and_testpy_dfn
 
 coreboot test.py:
-- 
2.43.0

