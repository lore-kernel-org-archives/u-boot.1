Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6320C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50C4688CAE;
	Thu,  2 May 2024 03:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bhEyAc8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09C5488CA8; Thu,  2 May 2024 03:33:34 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B79288BEE
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-615019cd427so59045117b3.3
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613610; x=1715218410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nx1wgP6g+Lc5AP5rmy0Y9jJPGopZwzPmaBntBrc7FGo=;
 b=bhEyAc8FpTRvUicisZWbrIH/FniM4/g042Qfn9CjGzO4hrDA364Wi6z/DgQ3qd98RD
 T0MiH5mzSvE08YjfvTTp7v5gZ+o8jVjFDpQbAjvcUR0VcW5Rx6Cw5SLyXHia6rRBPM3U
 NMixkr2+xEr3q+xbVXrq255MX+zuAN8jUMrbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613610; x=1715218410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nx1wgP6g+Lc5AP5rmy0Y9jJPGopZwzPmaBntBrc7FGo=;
 b=PBP+5FDOR2yWgiuJyvC4o//Iq4+qq832ZYWmFqCeH3GQqZAS5DGfxW+E6dgfMNrYUx
 HXgfVxf8aBKEXUwEhIox+AAZAn16gYMzQPPNik47c6SxcwrURQjD2aoeRSHnoHw/4dPT
 JBk/rcePrvy3Oz/6h5YoUqMAekpsgKdqRxTTGmrGd0ZJ2h5qrtNZAvfhdfM5DlCF0PA3
 Wk4z6QT8ATr+N0JpTz+rI9rhpEEUWWvEK/BOU8bCNkIUGpkIqDqUlSJFwjr9N4IXH5LG
 nt9SgfitvEz2VojE+clNcqzO95nFBLI5xOwrwRFKjq0tIIsnJ6BPqzIeCfN5svBQ+esS
 x3aQ==
X-Gm-Message-State: AOJu0Yxryq7yhX4lslG04aeKynROv3qMhwK+8+C99+m+94kBrk4F1GsU
 1Q3DhRb8euu+qiH3XkkZrSMlR4DabwFqaT0Xi5epwrQFaZlX7S9m+ea3G7nsHlk/gSAGeLK9fBv
 h5QZ5yQZv
X-Google-Smtp-Source: AGHT+IGYX8ZNTJ5kZgmvu78COAcvS83C/0mx/R+4ISMrj5OkvAb06OwJLgF+Hb3VKd3/xljbrU6bZg==
X-Received: by 2002:a05:690c:7001:b0:61b:34a8:cba4 with SMTP id
 jf1-20020a05690c700100b0061b34a8cba4mr4790078ywb.30.1714613609709; 
 Wed, 01 May 2024 18:33:29 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Nishanth Menon <nm@ti.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>,
 MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH 56/81] remoteproc: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:13 -0600
Message-Id: <20240502013138.2383421-56-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/remoteproc/ipu_rproc.c            | 1 -
 drivers/remoteproc/k3_system_controller.c | 1 -
 drivers/remoteproc/pru_rproc.c            | 1 -
 drivers/remoteproc/rproc-elf-loader.c     | 1 -
 drivers/remoteproc/rproc-uclass.c         | 1 -
 drivers/remoteproc/sandbox_testproc.c     | 1 -
 drivers/remoteproc/stm32_copro.c          | 1 -
 drivers/remoteproc/ti_k3_arm64_rproc.c    | 1 -
 drivers/remoteproc/ti_k3_dsp_rproc.c      | 1 -
 drivers/remoteproc/ti_k3_r5f_rproc.c      | 1 -
 drivers/remoteproc/ti_power_proc.c        | 1 -
 11 files changed, 11 deletions(-)

diff --git a/drivers/remoteproc/ipu_rproc.c b/drivers/remoteproc/ipu_rproc.c
index 996e658e8718..2ca78b550a7e 100644
--- a/drivers/remoteproc/ipu_rproc.c
+++ b/drivers/remoteproc/ipu_rproc.c
@@ -8,7 +8,6 @@
  *      Keerthy <j-keerthy@ti.com>
  */
 
-#include <common.h>
 #include <hang.h>
 #include <cpu_func.h>
 #include <dm.h>
diff --git a/drivers/remoteproc/k3_system_controller.c b/drivers/remoteproc/k3_system_controller.c
index 071de40fbd6f..71238a6058a4 100644
--- a/drivers/remoteproc/k3_system_controller.c
+++ b/drivers/remoteproc/k3_system_controller.c
@@ -6,7 +6,6 @@
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <remoteproc.h>
diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 6ec55e27d9dd..115c342244af 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -6,7 +6,6 @@
  *	Keerthy <j-keerthy@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <elf.h>
 #include <dm/of_access.h>
diff --git a/drivers/remoteproc/rproc-elf-loader.c b/drivers/remoteproc/rproc-elf-loader.c
index 5e070e5076e1..ab1836b3f078 100644
--- a/drivers/remoteproc/rproc-elf-loader.c
+++ b/drivers/remoteproc/rproc-elf-loader.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (C) 2019, STMicroelectronics - All Rights Reserved
  */
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <elf.h>
diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
index aa7f7586a814..3ba2b40dca38 100644
--- a/drivers/remoteproc/rproc-uclass.c
+++ b/drivers/remoteproc/rproc-uclass.c
@@ -7,7 +7,6 @@
 #define LOG_CATEGORY UCLASS_REMOTEPROC
 
 #define pr_fmt(fmt) "%s: " fmt, __func__
-#include <common.h>
 #include <elf.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/remoteproc/sandbox_testproc.c b/drivers/remoteproc/sandbox_testproc.c
index f76f68ebeb43..ad575a7c10fd 100644
--- a/drivers/remoteproc/sandbox_testproc.c
+++ b/drivers/remoteproc/sandbox_testproc.c
@@ -4,7 +4,6 @@
  * Texas Instruments Incorporated - https://www.ti.com/
  */
 #define pr_fmt(fmt) "%s: " fmt, __func__
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/remoteproc/stm32_copro.c b/drivers/remoteproc/stm32_copro.c
index 3e322c4d7191..f45da9a68ac6 100644
--- a/drivers/remoteproc/stm32_copro.c
+++ b/drivers/remoteproc/stm32_copro.c
@@ -4,7 +4,6 @@
  */
 #define LOG_CATEGORY UCLASS_REMOTEPROC
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/drivers/remoteproc/ti_k3_arm64_rproc.c b/drivers/remoteproc/ti_k3_arm64_rproc.c
index 767493c1383c..d3eb957b2e49 100644
--- a/drivers/remoteproc/ti_k3_arm64_rproc.c
+++ b/drivers/remoteproc/ti_k3_arm64_rproc.c
@@ -7,7 +7,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <remoteproc.h>
 #include <errno.h>
diff --git a/drivers/remoteproc/ti_k3_dsp_rproc.c b/drivers/remoteproc/ti_k3_dsp_rproc.c
index e790406324a9..57fe1037da02 100644
--- a/drivers/remoteproc/ti_k3_dsp_rproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_rproc.c
@@ -7,7 +7,6 @@
  *	Suman Anna <s-anna@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index 631e548dccef..b55b1dc10d4a 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -7,7 +7,6 @@
  *	Suman Anna <s-anna@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/remoteproc/ti_power_proc.c b/drivers/remoteproc/ti_power_proc.c
index f55df4a91195..cf150af4ef97 100644
--- a/drivers/remoteproc/ti_power_proc.c
+++ b/drivers/remoteproc/ti_power_proc.c
@@ -4,7 +4,6 @@
  * Texas Instruments Incorporated - https://www.ti.com/
  */
 #define pr_fmt(fmt) "%s: " fmt, __func__
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
-- 
2.34.1

