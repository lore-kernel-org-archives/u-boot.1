Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC30EE49A5
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 17:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9544A869B9;
	Sun, 20 Aug 2023 19:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rBKy64mR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66F5086AF4; Sun, 20 Aug 2023 19:31:37 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E991E869B4
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 19:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-591ba8bd094so8083167b3.3
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692552691; x=1693157491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jOBFJXH2wi6n98XVTSgcJAnW8vZQVdttkbBLwQSVoD0=;
 b=rBKy64mRA8m/fNBln+HeKdIqY2Nx2kg+vhzQmJvofoPba2MjXUmRlGn+Zpmtck/mcU
 0GsVyOxgXpfA52HueD7rMLmegQ+QfoJ0RjA43nUALqnxr8/l9iWu25ZJJI9xEUIZ/DuX
 lMBA7VAo1V+9PbcILrDl6GF1HTdLQbxAdwCbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692552691; x=1693157491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jOBFJXH2wi6n98XVTSgcJAnW8vZQVdttkbBLwQSVoD0=;
 b=QU+1rOuRxRbpuQyoX3QfQnN1CZr++EsMHhB4pCpbB1rsm8ctC/K0aUrZchXDF93yFi
 WUB78lYG5zV6AxOunbOp7N6LwMDqMJ7FBpz9ICna1zRb5gmQN2YqZNSL2AWBY9Kqtv+D
 qThNsps5ANyWUQcmtJ9eiltFLEiz8z2213ytqAmo0jpSHb0F2xaZEO1ZG1tkyFcMI4pX
 lPPQyWTdw7Ik+mKPH4triDhSgokIt0hbNnTNYLgaPThCwCwlpV8+F7s3IT+UZeEGLE+/
 3t+tZ2WZHC7o7/0ufPGSc5j35AGsPwQ6qcpqzIBb0Z62Mxi3VyTIgZm7O3l9X8OEEpPs
 H56g==
X-Gm-Message-State: AOJu0YzclJ7DR6MvYWFHO1BMwNqc47x63RnSXTddIQm//oAKygPc+kgJ
 d0p/ClJh0Vla08ArxPZQMr+axSizDVBzLQzO+UrLkA==
X-Google-Smtp-Source: AGHT+IHgWL3z9n45kQJ6GipySI7pAWGk4J6ULfI4TOAeDDZuQWfKo0CMTsbv7hzahrsE8a3LhgArcg==
X-Received: by 2002:a81:60c2:0:b0:591:4f2b:7eea with SMTP id
 u185-20020a8160c2000000b005914f2b7eeamr2756652ywb.18.1692552691504; 
 Sun, 20 Aug 2023 10:31:31 -0700 (PDT)
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
Subject: [PATCH 3/4] CI: Combine tools-only and envtools jobs
Date: Sun, 20 Aug 2023 13:31:28 -0400
Message-Id: <20230820173129.781985-3-trini@konsulko.com>
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

These jobs are to confirm specific build targets, on a Linux host.  We
can safely combine these two build tests, with a make mrproper in
between.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 13 ++-----------
 .gitlab-ci.yml       | 12 ++++--------
 2 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index ab3f961e01ee..e0ac7166d653 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -126,7 +126,7 @@ stages:
           ./tools/buildman/buildman --maintainer-check || exit 0
 
   - job: tools_only
-    displayName: 'Ensure host tools build'
+    displayName: 'Ensure host tools and env tools build'
     pool:
       vmImage: $(ubuntu_vm)
     container:
@@ -135,16 +135,7 @@ stages:
     steps:
       - script: |
           make tools-only_config tools-only -j$(nproc)
-
-  - job: envtools
-    displayName: 'Ensure env tools build'
-    pool:
-      vmImage: $(ubuntu_vm)
-    container:
-      image: $(ci_runner_image)
-      options: $(container_option)
-    steps:
-      - script: |
+          make mrproper
           make tools-only_config envtools -j$(nproc)
 
   - job: utils
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d9f6b31792f3..7400d1225d9e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -190,16 +190,12 @@ Check for configs without MAINTAINERS entry:
     - ./tools/buildman/buildman --maintainer-check || exit 0
 
 # Ensure host tools build
-Build tools-only:
+Build tools-only and envtools:
   stage: testsuites
   script:
-    - make tools-only_config tools-only -j$(nproc)
-
-# Ensure env tools build
-Build envtools:
-  stage: testsuites
-  script:
-    - make tools-only_config envtools -j$(nproc)
+    - make tools-only_config tools-only -j$(nproc);
+      make mrproper;
+      make tools-only_config envtools -j$(nproc)
 
 Run binman, buildman, dtoc, Kconfig and patman testsuites:
   stage: testsuites
-- 
2.34.1

