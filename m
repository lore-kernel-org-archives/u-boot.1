Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C730EC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBA6788C4B;
	Thu,  2 May 2024 03:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AGBTDpea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A04988C05; Thu,  2 May 2024 03:32:23 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35E7088C3C
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-439b3cc8d91so39867651cf.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613540; x=1715218340; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6AvOrM7NKUMuaksqP1j6iiu5aT30eCWV9yyTAkOLtWg=;
 b=AGBTDpeaMp4qi1RoTGakss9ZVBK4j7rKi8fGhQgOq9rz7XpyCb5J2r6TiH9g6jxoGc
 cetYeFRR4gXk2IgT4EZKShFGCliOTJm7A8ymVY5HB5r1bQ8nBTVGIrnrTMduVzzf4OCB
 57/ZY48ry0t2lzPOHb2HzirHmXjtNji2hHPU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613540; x=1715218340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6AvOrM7NKUMuaksqP1j6iiu5aT30eCWV9yyTAkOLtWg=;
 b=LFopqAwLuBjC1OPAAI8FeE7KZ6OsCCxBZin8ixP4b1PnoVzu4n9AjbxpN098iN+iLT
 cwbI5rMA++UVFYA2l6h0IYuaLO47tmgtyASEwQcVDJLz4KzUr/1B/EwULHlTpvufKA9J
 t/Ogkv0Iw2azSVWCcFqrqXLWa+kgkWVgjmLt/qAV1LVmGIFpfz886oY5lNelDHHL16yj
 4oNJAkIsJXBoimO5SAO64MSXtxGK6ZjZ58nb7jBhXd+AW+eWGl3m8iC29qRPVJVkJYX+
 b4Us5CdPfK9QtG0bJ9bPFff/v0A8feopgwvlNbZjHw4+0dxMoyytrqHX59wRz3O+fG7O
 W3TQ==
X-Gm-Message-State: AOJu0YzQqYsM8kRG6+tFzYuyJwTNjcYQsZ2C48OLYY3cxhSwbM3yRcPm
 gB4FLUfB5BUyEilh2IEYHhYsYBkVDxSUfiUrD6ndrtPg/r3HjtrnmBLtb5vyX2Mw7jNDLPV38u1
 X6Zt9ti6V
X-Google-Smtp-Source: AGHT+IFR8cKhuywrg5esFJQq2Nbz86vl15f3x+C6aesPf0pgrk0x0YGB/2W9ByKojWKU+OY7BLfgtA==
X-Received: by 2002:a05:622a:4d2:b0:43a:ed56:4c86 with SMTP id
 q18-20020a05622a04d200b0043aed564c86mr639653qtx.56.1714613539748; 
 Wed, 01 May 2024 18:32:19 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 26/81] dma: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:43 -0600
Message-Id: <20240502013138.2383421-26-trini@konsulko.com>
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
Cc: Michal Simek <michal.simek@amd.com>
Cc: Sean Anderson <seanga2@gmail.com>
---
 drivers/dma/apbh_dma.c         | 1 -
 drivers/dma/bcm6348-iudma.c    | 1 -
 drivers/dma/dma-uclass.c       | 1 -
 drivers/dma/fsl_dma.c          | 1 -
 drivers/dma/keystone_nav.c     | 2 +-
 drivers/dma/lpc32xx_dma.c      | 2 +-
 drivers/dma/sandbox-dma-test.c | 1 -
 drivers/dma/ti-edma3.c         | 1 -
 drivers/dma/ti/k3-udma.c       | 1 -
 drivers/dma/xilinx_dpdma.c     | 1 -
 10 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/apbh_dma.c b/drivers/dma/apbh_dma.c
index da988f6bb667..331815c469f9 100644
--- a/drivers/dma/apbh_dma.c
+++ b/drivers/dma/apbh_dma.c
@@ -15,7 +15,6 @@
 #include <asm/cache.h>
 #include <linux/list.h>
 
-#include <common.h>
 #include <malloc.h>
 #include <linux/errno.h>
 #include <asm/io.h>
diff --git a/drivers/dma/bcm6348-iudma.c b/drivers/dma/bcm6348-iudma.c
index 33c7b9814156..fd3a353d5484 100644
--- a/drivers/dma/bcm6348-iudma.c
+++ b/drivers/dma/bcm6348-iudma.c
@@ -15,7 +15,6 @@
  *	Copyright (C) 2010 Broadcom Corporation
  */
 
-#include <common.h>
 #include <clk.h>
 #include <cpu_func.h>
 #include <dm.h>
diff --git a/drivers/dma/dma-uclass.c b/drivers/dma/dma-uclass.c
index 0c1d88e10c65..2c76ba3fe328 100644
--- a/drivers/dma/dma-uclass.c
+++ b/drivers/dma/dma-uclass.c
@@ -11,7 +11,6 @@
 
 #define LOG_CATEGORY UCLASS_DMA
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/dma/fsl_dma.c b/drivers/dma/fsl_dma.c
index 700df2236bd1..0cd9bcb51109 100644
--- a/drivers/dma/fsl_dma.c
+++ b/drivers/dma/fsl_dma.c
@@ -9,7 +9,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <asm/io.h>
 #include <asm/fsl_dma.h>
 
diff --git a/drivers/dma/keystone_nav.c b/drivers/dma/keystone_nav.c
index 9a5ba79f3fe5..c84db454bfd4 100644
--- a/drivers/dma/keystone_nav.c
+++ b/drivers/dma/keystone_nav.c
@@ -5,10 +5,10 @@
  * (C) Copyright 2012-2014
  *     Texas Instruments Incorporated, <www.ti.com>
  */
-#include <common.h>
 #include <asm/io.h>
 #include <asm/ti-common/keystone_nav.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 struct qm_config qm_memmap = {
 	.stat_cfg	= KS2_QM_QUEUE_STATUS_BASE,
diff --git a/drivers/dma/lpc32xx_dma.c b/drivers/dma/lpc32xx_dma.c
index 0efdfd028cfd..f15b67546a9f 100644
--- a/drivers/dma/lpc32xx_dma.c
+++ b/drivers/dma/lpc32xx_dma.c
@@ -7,9 +7,9 @@
  * Copyright (c) 2015 Tyco Fire Protection Products.
  */
 
-#include <common.h>
 #include <errno.h>
 #include <init.h>
+#include <time.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/clk.h>
diff --git a/drivers/dma/sandbox-dma-test.c b/drivers/dma/sandbox-dma-test.c
index a19e5e37fb9d..0290b93340f4 100644
--- a/drivers/dma/sandbox-dma-test.c
+++ b/drivers/dma/sandbox-dma-test.c
@@ -7,7 +7,6 @@
  * Author: Grygorii Strashko <grygorii.strashko@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/dma/ti-edma3.c b/drivers/dma/ti-edma3.c
index 31ffff07f5b3..d64059f39ab8 100644
--- a/drivers/dma/ti-edma3.c
+++ b/drivers/dma/ti-edma3.c
@@ -10,7 +10,6 @@
 
 #include <asm/cache.h>
 #include <asm/io.h>
-#include <common.h>
 #include <dm.h>
 #include <dma-uclass.h>
 #include <linux/dma-mapping.h>
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index ef3074aa13ff..8e11d817a5b4 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5,7 +5,6 @@
  */
 #define pr_fmt(fmt) "udma: " fmt
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <asm/cache.h>
diff --git a/drivers/dma/xilinx_dpdma.c b/drivers/dma/xilinx_dpdma.c
index d4ee21dfc07f..1d615ec28387 100644
--- a/drivers/dma/xilinx_dpdma.c
+++ b/drivers/dma/xilinx_dpdma.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2021 Xilinx Inc.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <dma.h>
-- 
2.34.1

