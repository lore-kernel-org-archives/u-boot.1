Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1134EE4993
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 17:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7BB586B7E;
	Sun, 20 Aug 2023 19:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K1ChZzp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B77D869B4; Sun, 20 Aug 2023 19:31:37 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2F4E869D0
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 19:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-589e4179fc7so29526007b3.2
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692552692; x=1693157492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1Z/ceWneChRxGjG2HqTty+p0mSSKTIfbSneWl8CQahM=;
 b=K1ChZzp+XT5w5Z8jfpU0chiO1e9cnn44wsLdeiEPaRnwJcia7TfPAW5zUP4cl9obL4
 yxYyiO1tcOZx8h21EiyFEOcU4qVeJEFVHWzRl13pysIIKYriIGltkrfhiJN2P5y1l/gj
 u+JGYH0kkAavQEctopC6Ab9mVwLsebb/XHleY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692552692; x=1693157492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Z/ceWneChRxGjG2HqTty+p0mSSKTIfbSneWl8CQahM=;
 b=O19fnSFrFBQPKMUCdWWf/Iqxg4KsE6Ha80UcMi7p9XL2iUhxT0CuSkmuiwT3tWD13A
 2lbgYZiYIAJbP65l0lr5CI6RV7zdtM6FXvWFcOMy0c4OBquiP9iUrIAWYxB2dfIgvQqS
 qXwQ8q7VLRuOuhtzvGooM0QnIXVfezxmYkvUCRKH3pytXAMXWaT+oMhRNX/FBjdAftFH
 /dn5USTJnp4X4nBBZNFnglyJXBxoEfOVZxBnjWXGSHhzgwfO0sBQpTWlD5cmZNg/oEaS
 y11pt/YRJAE74OyfrxLI+mhzNyimDLLPf20+czXFGFnqBNClkAlq91HjsGPIKJdNQO8a
 4Quw==
X-Gm-Message-State: AOJu0YxorOd250VGU+XJ+hKV3zbKJWOmQry2ACEQ+GsxeZbHUX+a/9eG
 CqKhT0OBr683xNI2yq+thg9kXWbSMkIFs5Hnd7UrrA==
X-Google-Smtp-Source: AGHT+IFP43ww9He5z+mBLbCyb+Q+i5oIiB9sthGbwyUT9fQu9dleFK1Mz+8LuZkXCHw7DNtPeLK1tw==
X-Received: by 2002:a0d:c405:0:b0:56d:43cb:da98 with SMTP id
 g5-20020a0dc405000000b0056d43cbda98mr4862128ywd.29.1692552692204; 
 Sun, 20 Aug 2023 10:31:32 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-2d48-63ba-cc6c-366e.res6.spectrum.com.
 [2603:6081:7b00:6400:2d48:63ba:cc6c:366e])
 by smtp.gmail.com with ESMTPSA id
 i194-20020a816dcb000000b0057042405e2csm1800683ywc.71.2023.08.20.10.31.31
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 10:31:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 4/4] CI: Drop some jobs we didn't really utilize
Date: Sun, 20 Aug 2023 13:31:29 -0400
Message-Id: <20230820173129.781985-4-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820173129.781985-1-trini@konsulko.com>
References: <20230820173129.781985-1-trini@konsulko.com>
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

- We have added more TODO/etc comments since this task was created and
  never focused on removing them.
- The output of sloccount isn't preserved or looked at, and if desired
  should be in the release stats pages instead somehow.
- The results of cppcheck aren't investigated and require modeling work
  to be useful to start with.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml    | 32 --------------------------------
 .gitlab-ci.yml          | 22 ----------------------
 tools/docker/Dockerfile |  2 --
 3 files changed, 56 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index e0ac7166d653..ad04f43b4339 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -67,16 +67,6 @@ stages:
                   :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
                   :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
 
-  - job: cppcheck
-    displayName: 'Static code analysis with cppcheck'
-    pool:
-      vmImage: $(ubuntu_vm)
-    container:
-      image: $(ci_runner_image)
-      options: $(container_option)
-    steps:
-      - script: cppcheck -j$(nproc) --force --quiet --inline-suppr .
-
   - job: docs
     displayName: 'Build documentation'
     pool:
@@ -92,28 +82,6 @@ stages:
           make htmldocs KDOC_WERROR=1
           make infodocs
 
-  - job: todo
-    displayName: 'Search for TODO within source tree'
-    pool:
-      vmImage: $(ubuntu_vm)
-    container:
-      image: $(ci_runner_image)
-      options: $(container_option)
-    steps:
-      - script: grep -r TODO .
-      - script: grep -r FIXME .
-      - script: grep -r HACK . | grep -v HACKKIT
-
-  - job: sloccount
-    displayName: 'Some statistics about the code base'
-    pool:
-      vmImage: $(ubuntu_vm)
-    container:
-      image: $(ci_runner_image)
-      options: $(container_option)
-    steps:
-      - script: sloccount .
-
   - job: maintainers
     displayName: 'Ensure all configs have MAINTAINERS entries'
     pool:
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7400d1225d9e..7f3ad40eae8d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -151,22 +151,6 @@ check for new CONFIG symbols outside Kconfig:
         :^doc/ :^arch/arm/dts/ :^scripts/kconfig/lkc.h
         :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
 
-# QA jobs for code analytics
-# static code analysis with cppcheck (we can add --enable=all later)
-cppcheck:
-  stage: testsuites
-  script:
-    - cppcheck -j$(nproc) --force --quiet --inline-suppr .
-
-# search for TODO within source tree
-grep TODO/FIXME/HACK:
-  stage: testsuites
-  script:
-    - grep -r TODO .
-    - grep -r FIXME .
-    # search for HACK within source tree and ignore HACKKIT board
-    - grep -r HACK . | grep -v HACKKIT
-
 # build documentation
 docs:
   stage: testsuites
@@ -177,12 +161,6 @@ docs:
     - make htmldocs KDOC_WERROR=1
     - make infodocs
 
-# some statistics about the code base
-sloccount:
-  stage: testsuites
-  script:
-    - sloccount .
-
 # ensure all configs have MAINTAINERS entries
 Check for configs without MAINTAINERS entry:
   stage: testsuites
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 3d2b64a355f3..4d496700f1fd 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -42,7 +42,6 @@ RUN apt-get update && apt-get install -y \
 	clang-16 \
 	coreutils \
 	cpio \
-	cppcheck \
 	curl \
 	device-tree-compiler \
 	dosfstools \
@@ -104,7 +103,6 @@ RUN apt-get update && apt-get install -y \
 	python3-virtualenv \
 	rpm2cpio \
 	sbsigntool \
-	sloccount \
 	socat \
 	softhsm2 \
 	sparse \
-- 
2.34.1

