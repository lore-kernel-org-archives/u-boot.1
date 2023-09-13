Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08472EDEC5C
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 14:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16C6E86AEE;
	Wed, 13 Sep 2023 16:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hewKqXxP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD8886AF5; Wed, 13 Sep 2023 16:15:43 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84C1686AED
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 16:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2bcde83ce9fso115693631fa.1
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694614539; x=1695219339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AmqqzNfI/aYjjGv6FLSAbPzs3Psb/Qsk45IVVMokonA=;
 b=hewKqXxPp2gvzuOHpcvWuofSohvEYUTtjFSvf65T8mm9GWYDNNGEJ+wT367YH+xCER
 96JQZdnvMT6crIPgXUEMCpWxopTc3PqYEBEvY7J1htpb9S8QRz1/nWHsrZRW+hwpyjLb
 tYjLw6ojbofHyxiVnpr7/g+fgM1oQxKagTmNnuUbCLCJtCzltmuJKsW5m6VX9srXs7rE
 OCQUgEG3QlwjGLdLuY2ewGDg3QJqeh7lvhFIuvFARKLyTF+23YQN/la/IX4b+/y2KMTZ
 W4LrkUwgTYFdDKakMMmedH7bErh8CjdwUB2lYC3tpkDo7tIHuAQA1aXcXhwLgemnVMFf
 LpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694614539; x=1695219339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AmqqzNfI/aYjjGv6FLSAbPzs3Psb/Qsk45IVVMokonA=;
 b=MA9PyEe5cYyhCueqJ9SUsUA0O08DxaC5W8bOXKrVFkgxIUef0Qj9jwM9O2v7WRMJLK
 pXC4+OacXKAvIRW27Hh6RtZtv0/NipRgkMFn8JPF74qyD5rBB1D1ld0YUHu3bp90bhhR
 3WyHTA0LS6sAEyvQBZi4vP8JXICfAgQza5TcRIcGea4/TB7CvH6HeyoQ/tXRT2noJ3Z9
 MMnR3Kc+f7r3Upjnah26QAU2w6RCToqqcTDZ0T07ofZGjN8HrCIX2unEahkT65k3ELkI
 UOivDLLG02Iq3RVNf9J/mjFopasuPEjcA5CQmqgxbFDVhbgYGJe7nUvV2t8E2gIZOoEY
 DKGw==
X-Gm-Message-State: AOJu0YyBqwUDLhE5ZB966gbtyVkuyVZ8/qpLd5ECXiM6Fzup2eosN+6t
 BgSVDRS1gUiUBgD6Airx56KOXua4YujsTw==
X-Google-Smtp-Source: AGHT+IE0VZVUGSQPFeBmsl5iA8TPxGxdscm2p9FTNtdn/3Z18Vde/bU+14ZIv70nheTyerHYz2AvBg==
X-Received: by 2002:a2e:3818:0:b0:2bc:c0e3:4a30 with SMTP id
 f24-20020a2e3818000000b002bcc0e34a30mr2197585lja.26.1694614539082; 
 Wed, 13 Sep 2023 07:15:39 -0700 (PDT)
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch.
 [77.59.154.235]) by smtp.gmail.com with ESMTPSA id
 u24-20020a170906b11800b0099c971ba285sm8536113ejy.5.2023.09.13.07.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 07:15:38 -0700 (PDT)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v2] CI: allow jobs to be run in merge requests
Date: Wed, 13 Sep 2023 16:15:36 +0200
Message-Id: <20230913141536.109844-1-andrejs.cainikovs@gmail.com>
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

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Out-of-tree users could run an out-of-tree CI with limited coverage,
however it is convenient to be able to run the upstream CI from time
to time. To enable that we would need to change job rules to be able
to run on any GitLab event. Excerpt from GitLab documentation:

> Jobs with no rules default to except: merge_requests

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 .gitlab-ci.yml | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6efbd8021c8..981b95c00d8 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -21,6 +21,8 @@ stages:
 .buildman_and_testpy_template: &buildman_and_testpy_dfn
   stage: test.py
   retry: 2 # QEMU may be too slow, etc.
+  rules:
+    - when: always
   before_script:
     # Clone uboot-test-hooks
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
@@ -93,8 +95,13 @@ stages:
       - "*.css"
     expire_in: 1 week
 
-build all 32bit ARM platforms:
+.world_build:
   stage: world build
+  rules:
+    - when: always
+
+build all 32bit ARM platforms:
+  extends: .world_build
   script:
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
@@ -106,7 +113,7 @@ build all 32bit ARM platforms:
       fi;
 
 build all 64bit ARM platforms:
-  stage: world build
+  extends: .world_build
   script:
     - virtualenv -p /usr/bin/python3 /tmp/venv
     - . /tmp/venv/bin/activate
@@ -120,7 +127,7 @@ build all 64bit ARM platforms:
       fi;
 
 build all PowerPC platforms:
-  stage: world build
+  extends: .world_build
   script:
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
@@ -131,7 +138,7 @@ build all PowerPC platforms:
       fi;
 
 build all other platforms:
-  stage: world build
+  extends: .world_build
   script:
     - ret=0;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
@@ -141,8 +148,13 @@ build all other platforms:
         exit $ret;
       fi;
 
-check for new CONFIG symbols outside Kconfig:
+.testsuites:
   stage: testsuites
+  rules:
+    - when: always
+
+check for new CONFIG symbols outside Kconfig:
+  extends: .testsuites
   script:
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
     # If grep succeeds and finds a match the test fails as we should
@@ -153,7 +165,7 @@ check for new CONFIG symbols outside Kconfig:
 
 # build documentation
 docs:
-  stage: testsuites
+  extends: .testsuites
   script:
     - virtualenv -p /usr/bin/python3 /tmp/venvhtml
     - . /tmp/venvhtml/bin/activate
@@ -163,20 +175,20 @@ docs:
 
 # ensure all configs have MAINTAINERS entries
 Check for configs without MAINTAINERS entry:
-  stage: testsuites
+  extends: .testsuites
   script:
     - ./tools/buildman/buildman --maintainer-check || exit 0
 
 # Ensure host tools build
 Build tools-only and envtools:
-  stage: testsuites
+  extends: .testsuites
   script:
     - make tools-only_config tools-only -j$(nproc);
       make mrproper;
       make tools-only_config envtools -j$(nproc)
 
 Run binman, buildman, dtoc, Kconfig and patman testsuites:
-  stage: testsuites
+  extends: .testsuites
   script:
     - git config --global user.name "GitLab CI Runner";
       git config --global user.email trini@konsulko.com;
@@ -200,7 +212,7 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
       make testconfig
 
 Run tests for Nokia RX-51 (aka N900):
-  stage: testsuites
+  extends: .testsuites
   script:
     - mkdir nokia_rx51_tmp;
       ln -s /opt/nokia/u-boot-gen-combined nokia_rx51_tmp/;
@@ -214,7 +226,7 @@ Run tests for Nokia RX-51 (aka N900):
 
 # Check for any pylint regressions
 Run pylint:
-  stage: testsuites
+  extends: .testsuites
   script:
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
     - pip install -r test/py/requirements.txt
@@ -234,7 +246,7 @@ Run pylint:
 
 # Check for pre-schema driver model tags
 Check for pre-schema tags:
-  stage: testsuites
+  extends: .testsuites
   script:
     - git config --global --add safe.directory "${CI_PROJECT_DIR}";
     # If grep succeeds and finds a match the test fails as we should
@@ -243,7 +255,7 @@ Check for pre-schema tags:
 
 # Check we can package the Python tools
 Check packing of Python tools:
-  stage: testsuites
+  extends: .testsuites
   script:
     - make pip
 
-- 
2.34.1

