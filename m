Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C56DC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E096088C3B;
	Thu,  2 May 2024 03:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YpxDYorE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93DE288C37; Thu,  2 May 2024 03:32:15 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5038D88C09
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-434d0a63151so44108861cf.3
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613532; x=1715218332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypGq2VE4anqM1zIyL+UA+bTJ4O+5nMfIHWHc9HOQ5AY=;
 b=YpxDYorE2lUDpRhSGoZAgQHzmKbasCsGFD5UgKFJewjJhaCIjd3g99QNwqgDEEFP/k
 N8GSHvXalgH7TjjQjAdsZjZZOLfe97qLuFYhypLhNBbCMj4Je4Dw0dAXvo/5AedMUAXQ
 9Zbn8AAujfx4VAw9eU6qpd+Q5IyjYFLpjkhfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613532; x=1715218332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypGq2VE4anqM1zIyL+UA+bTJ4O+5nMfIHWHc9HOQ5AY=;
 b=GeMCxjTopF0pFis5j4/Z4ghcBFFojbHfrobMqq+JOuZCkaFFGNl3vCqzwdMuTinBzK
 h4pDlCbfd9fBXZSC1rEOeqAqPdIWQRH1szVdCKFoaQRP/ZN1sSYv8xP9XVpL0ngqa/FU
 yo/B2/7q4A4fD0tTenm001HkCl/dYb8bFqSXszhDBFMbmbfH2Vu6WzFumGk2ln8u/3kJ
 0H1vqlc52Ysgvkit6cEv1Guq5gr+GOKMf+/gBSN0mm1LBmpLY2O1XTGDaReoZdoxACLA
 fZd+WOQq+RGYcrnPHZTLBNY/M1OQt4WlO3qY8p/zumMSF/9V7z/gaC1zozXg5ehJIjTf
 xMFg==
X-Gm-Message-State: AOJu0YwwPrIw2Yta6xDKXwFSVUNbSRxfQTgMZOkt/uXqK1RGrLCVduy7
 PYHMV7iGsHOPPXeAHI+YSGtEBC9pXlkXrwN/OFR3FffYETuJvL6ro+La90NHZkTviclpwHMb7Ku
 cCkbEaT1P
X-Google-Smtp-Source: AGHT+IGsI9P8MeGCAQcRb0L1o7XypOQcuF6LVqm25ry3QUPhQTT4x7IEj7gg3J+olyGne2J+GHFY0g==
X-Received: by 2002:ac8:598d:0:b0:43a:db38:5cb4 with SMTP id
 e13-20020ac8598d000000b0043adb385cb4mr4149117qte.18.1714613531746; 
 Wed, 01 May 2024 18:32:11 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 20/81] core: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:37 -0600
Message-Id: <20240502013138.2383421-20-trini@konsulko.com>
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
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/core/acpi.c          | 1 -
 drivers/core/device-remove.c | 1 -
 drivers/core/device.c        | 2 +-
 drivers/core/devres.c        | 1 -
 drivers/core/dump.c          | 1 -
 drivers/core/fdtaddr.c       | 1 -
 drivers/core/lists.c         | 1 -
 drivers/core/of_access.c     | 1 -
 drivers/core/of_addr.c       | 1 -
 drivers/core/of_extra.c      | 1 -
 drivers/core/ofnode.c        | 1 -
 drivers/core/read.c          | 1 -
 drivers/core/read_extra.c    | 1 -
 drivers/core/regmap.c        | 1 -
 drivers/core/root.c          | 1 -
 drivers/core/simple-bus.c    | 1 -
 drivers/core/simple-pm-bus.c | 1 -
 drivers/core/syscon-uclass.c | 1 -
 drivers/core/uclass.c        | 1 -
 drivers/core/util.c          | 1 -
 20 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/core/acpi.c b/drivers/core/acpi.c
index 0ebd288ab420..9f7842289218 100644
--- a/drivers/core/acpi.c
+++ b/drivers/core/acpi.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEOGRY	LOGC_ACPI
 
-#include <common.h>
 #include <display_options.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/core/device-remove.c b/drivers/core/device-remove.c
index a86b9325dd8d..437080ed7780 100644
--- a/drivers/core/device-remove.c
+++ b/drivers/core/device-remove.c
@@ -10,7 +10,6 @@
 
 #define LOG_CATEGORY	LOGC_DM
 
-#include <common.h>
 #include <errno.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/core/device.c b/drivers/core/device.c
index bf7f261cbce0..18e2bd02dd56 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -8,8 +8,8 @@
  * Pavel Herrmann <morpheus.ibis@gmail.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
+#include <errno.h>
 #include <event.h>
 #include <log.h>
 #include <asm/global_data.h>
diff --git a/drivers/core/devres.c b/drivers/core/devres.c
index 78914bdf7f21..8df08b91021c 100644
--- a/drivers/core/devres.c
+++ b/drivers/core/devres.c
@@ -9,7 +9,6 @@
 
 #define LOG_CATEGORY LOGC_DEVRES
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <linux/compat.h>
diff --git a/drivers/core/dump.c b/drivers/core/dump.c
index 841124830ee7..5ec30d5b3c1a 100644
--- a/drivers/core/dump.c
+++ b/drivers/core/dump.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <malloc.h>
 #include <mapmem.h>
diff --git a/drivers/core/fdtaddr.c b/drivers/core/fdtaddr.c
index 5f27d2511485..6be8ea0c0a9c 100644
--- a/drivers/core/fdtaddr.c
+++ b/drivers/core/fdtaddr.c
@@ -8,7 +8,6 @@
  * Pavel Herrmann <morpheus.ibis@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdt_support.h>
 #include <log.h>
diff --git a/drivers/core/lists.c b/drivers/core/lists.c
index 8034a8f48d99..2839a9b73718 100644
--- a/drivers/core/lists.c
+++ b/drivers/core/lists.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY LOGC_DM
 
-#include <common.h>
 #include <errno.h>
 #include <log.h>
 #include <dm/device.h>
diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
index c8db743f5298..41f2e09b9c27 100644
--- a/drivers/core/of_access.c
+++ b/drivers/core/of_access.c
@@ -19,7 +19,6 @@
  * Linux version.
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <asm/global_data.h>
diff --git a/drivers/core/of_addr.c b/drivers/core/of_addr.c
index b3b3d7ccdd56..d7913ab3d2fd 100644
--- a/drivers/core/of_addr.c
+++ b/drivers/core/of_addr.c
@@ -6,7 +6,6 @@
  * Copyright (c) 2017 Google, Inc
  */
 
-#include <common.h>
 #include <log.h>
 #include <linux/bug.h>
 #include <linux/libfdt.h>
diff --git a/drivers/core/of_extra.c b/drivers/core/of_extra.c
index 59ce9174ad07..a3ebe9e9c245 100644
--- a/drivers/core/of_extra.c
+++ b/drivers/core/of_extra.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <log.h>
 #include <linux/libfdt.h>
 #include <dm/of_access.h>
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 21a233f90f0b..9a5eaaa4d134 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY	LOGC_DT
 
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <fdt_support.h>
diff --git a/drivers/core/read.c b/drivers/core/read.c
index 1a4a95cddea3..55c19f335ae1 100644
--- a/drivers/core/read.c
+++ b/drivers/core/read.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/of_access.h>
 #include <mapmem.h>
diff --git a/drivers/core/read_extra.c b/drivers/core/read_extra.c
index 513834882783..5a0153a46610 100644
--- a/drivers/core/read_extra.c
+++ b/drivers/core/read_extra.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/of_addr.h>
 #include <dm/read.h>
diff --git a/drivers/core/regmap.c b/drivers/core/regmap.c
index dd32328098c4..7ff7834bdf08 100644
--- a/drivers/core/regmap.c
+++ b/drivers/core/regmap.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY	LOGC_DM
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/core/root.c b/drivers/core/root.c
index d4ae652bcfb1..4bfd08f48130 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_ROOT
 
-#include <common.h>
 #include <errno.h>
 #include <fdtdec.h>
 #include <log.h>
diff --git a/drivers/core/simple-bus.c b/drivers/core/simple-bus.c
index 6022e7514e0e..f402bb5d6748 100644
--- a/drivers/core/simple-bus.c
+++ b/drivers/core/simple-bus.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_SIMPLE_BUS
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <dm.h>
 #include <dm/simple_bus.h>
diff --git a/drivers/core/simple-pm-bus.c b/drivers/core/simple-pm-bus.c
index 1bb0d86e289d..f38372ec60bc 100644
--- a/drivers/core/simple-pm-bus.c
+++ b/drivers/core/simple-pm-bus.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Sean Anderson <seanga2@gmail.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 
diff --git a/drivers/core/syscon-uclass.c b/drivers/core/syscon-uclass.c
index a47b8bd3c017..f0e69d7216b3 100644
--- a/drivers/core/syscon-uclass.c
+++ b/drivers/core/syscon-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_SYSCON
 
-#include <common.h>
 #include <log.h>
 #include <syscon.h>
 #include <dm.h>
diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
index e46d5717aa62..762536eebc6e 100644
--- a/drivers/core/uclass.c
+++ b/drivers/core/uclass.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY LOGC_DM
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/core/util.c b/drivers/core/util.c
index 81497df85ffd..108a3bc4dac1 100644
--- a/drivers/core/util.c
+++ b/drivers/core/util.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2013 Google, Inc
  */
 
-#include <common.h>
 #include <dm/device.h>
 #include <dm/ofnode.h>
 #include <dm/read.h>
-- 
2.34.1

