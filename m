Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90545C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5E6D88A85;
	Tue, 30 Apr 2024 15:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QJMHJIPl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16C2488A6A; Tue, 30 Apr 2024 15:36:36 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A24A188A54
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6a0d1032362so7713556d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484192; x=1715088992; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Yx066OMgWSNE9Vn7R8C3s+Ts05XZI9PT5/BT545ao5M=;
 b=QJMHJIPlgwG4k6pAVVlVvHj3p+l+ntm6PNOIjLuGXLTOLx0YtvR2VJuepkZavNGPJs
 UNCwC+Ed58s25RKLuzScknXKNUZ91jfJfR4u28iAUPcT0T9PzVldW9gX3iMRlsYvp/hU
 AA58v4rMuFDzCovhJ11ME8mXW6beNOaDIvUE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484192; x=1715088992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yx066OMgWSNE9Vn7R8C3s+Ts05XZI9PT5/BT545ao5M=;
 b=JpLpIs7R3fww+V2CS1h6huuxgIENMdgU7cLCpmFTzn0ffWMJzL9uESsyd+Apom22Ju
 MQLVgavc9j6w8csUE/VLo6m9GaLJkkH5gdSlzJMSZ3IbHnT/ZN4PWb9w2Rl1IIlv7WAx
 v4fM3ahJKiJjBNmWPCr1KKlCmOQ11+h4HUDfubymgVp/0nCSC/GRu7yGNEfoc/JVXtws
 gIKePuD/x7u8OEjdMlKkqMpTjbU14W2YDhiWnlIaQidp17OMlKzBMSULnv1aSenlU0sN
 Jf41AkgDg21//fj4SOUrmIaOSiQU64TfOPNRDmsMyBYbpb/L9RQulMpbp7PH1JMJckvo
 lE8g==
X-Gm-Message-State: AOJu0YzNNPqTIr9MlqS0+J0FZW+SrBxaYxLg9NIOEA0+igOYeIoerqGz
 T0lZ/e4Idyk0a7HC0a34XC9FOQ0rg2pa32dxXem+HkwOdUdnoAJ7B/SOBy/RsVTNm66l+oODdwt
 EEX5RPQ==
X-Google-Smtp-Source: AGHT+IFFbbZ7E5ZSK3uxecZ4E+gjhilA2oHLq+Q7k2KHFCHhjzSbBxea4yT+T/FU4FW5xIH3G4FCpw==
X-Received: by 2002:a05:6214:2a49:b0:6a0:d56e:4b30 with SMTP id
 jf9-20020a0562142a4900b006a0d56e4b30mr5562589qvb.53.1714484192229; 
 Tue, 30 Apr 2024 06:36:32 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.31
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 28/33] arm: bcm: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:54 -0600
Message-Id: <20240430133559.1836389-28-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430133559.1836389-1-trini@konsulko.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
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

Remove <common.h> from all mach-bcmbca, mach-bcm283x and bcm* CPU
directory files and when needed add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/cpu/armv7/bcm235xx/clk-bcm235xx.c | 1 -
 arch/arm/cpu/armv7/bcm235xx/clk-bsc.c      | 1 -
 arch/arm/cpu/armv7/bcm235xx/clk-core.c     | 1 -
 arch/arm/cpu/armv7/bcm235xx/clk-eth.c      | 1 -
 arch/arm/cpu/armv7/bcm235xx/clk-sdio.c     | 1 -
 arch/arm/cpu/armv7/bcm235xx/clk-usb-otg.c  | 1 -
 arch/arm/cpu/armv7/bcm281xx/clk-bcm281xx.c | 1 -
 arch/arm/cpu/armv7/bcm281xx/clk-bsc.c      | 1 -
 arch/arm/cpu/armv7/bcm281xx/clk-core.c     | 1 -
 arch/arm/cpu/armv7/bcm281xx/clk-eth.c      | 1 -
 arch/arm/cpu/armv7/bcm281xx/clk-sdio.c     | 1 -
 arch/arm/cpu/armv7/bcm281xx/clk-usb-otg.c  | 1 -
 arch/arm/cpu/armv7/bcm281xx/reset.c        | 1 -
 arch/arm/cpu/armv7/bcmcygnus/reset.c       | 1 -
 arch/arm/cpu/armv7/bcmnsp/reset.c          | 1 -
 arch/arm/mach-bcm283x/init.c               | 1 -
 arch/arm/mach-bcm283x/mbox.c               | 2 +-
 arch/arm/mach-bcm283x/msg.c                | 1 -
 arch/arm/mach-bcm283x/reset.c              | 2 +-
 arch/arm/mach-bcmbca/bcm4908/mmu_table.c   | 1 -
 arch/arm/mach-bcmbca/bcm4912/mmu_table.c   | 1 -
 arch/arm/mach-bcmbca/bcm63146/mmu_table.c  | 1 -
 arch/arm/mach-bcmbca/bcm63158/mmu_table.c  | 1 -
 arch/arm/mach-bcmbca/bcm6813/mmu_table.c   | 1 -
 arch/arm/mach-bcmbca/bcm6856/mmu_table.c   | 1 -
 arch/arm/mach-bcmbca/bcm6858/mmu_table.c   | 1 -
 26 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/arm/cpu/armv7/bcm235xx/clk-bcm235xx.c b/arch/arm/cpu/armv7/bcm235xx/clk-bcm235xx.c
index 39217c5b2bf1..7f73f893458b 100644
--- a/arch/arm/cpu/armv7/bcm235xx/clk-bcm235xx.c
+++ b/arch/arm/cpu/armv7/bcm235xx/clk-bcm235xx.c
@@ -9,7 +9,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <linux/errno.h>
 #include <asm/arch/sysmap.h>
diff --git a/arch/arm/cpu/armv7/bcm235xx/clk-bsc.c b/arch/arm/cpu/armv7/bcm235xx/clk-bsc.c
index 1b3f36aebe11..55dcc2fd78ca 100644
--- a/arch/arm/cpu/armv7/bcm235xx/clk-bsc.c
+++ b/arch/arm/cpu/armv7/bcm235xx/clk-bsc.c
@@ -3,7 +3,6 @@
  * Copyright 2013 Broadcom Corporation.
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <linux/errno.h>
 #include <asm/arch/sysmap.h>
diff --git a/arch/arm/cpu/armv7/bcm235xx/clk-core.c b/arch/arm/cpu/armv7/bcm235xx/clk-core.c
index d7edefee2318..b769c451105f 100644
--- a/arch/arm/cpu/armv7/bcm235xx/clk-core.c
+++ b/arch/arm/cpu/armv7/bcm235xx/clk-core.c
@@ -9,7 +9,6 @@
  *
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <linux/delay.h>
diff --git a/arch/arm/cpu/armv7/bcm235xx/clk-eth.c b/arch/arm/cpu/armv7/bcm235xx/clk-eth.c
index 209ceca9a06e..5f7cc4a102d0 100644
--- a/arch/arm/cpu/armv7/bcm235xx/clk-eth.c
+++ b/arch/arm/cpu/armv7/bcm235xx/clk-eth.c
@@ -3,7 +3,6 @@
  * Copyright 2014 Broadcom Corporation.
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
diff --git a/arch/arm/cpu/armv7/bcm235xx/clk-sdio.c b/arch/arm/cpu/armv7/bcm235xx/clk-sdio.c
index f2ba354c24f8..f3ff29bebe85 100644
--- a/arch/arm/cpu/armv7/bcm235xx/clk-sdio.c
+++ b/arch/arm/cpu/armv7/bcm235xx/clk-sdio.c
@@ -3,7 +3,6 @@
  * Copyright 2013 Broadcom Corporation.
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <linux/errno.h>
 #include <asm/arch/sysmap.h>
diff --git a/arch/arm/cpu/armv7/bcm235xx/clk-usb-otg.c b/arch/arm/cpu/armv7/bcm235xx/clk-usb-otg.c
index f604aec62fa6..87918059408c 100644
--- a/arch/arm/cpu/armv7/bcm235xx/clk-usb-otg.c
+++ b/arch/arm/cpu/armv7/bcm235xx/clk-usb-otg.c
@@ -3,7 +3,6 @@
  * Copyright 2014 Broadcom Corporation.
  */
 
-#include <common.h>
 #include <linux/errno.h>
 #include <asm/arch/sysmap.h>
 #include "clk-core.h"
diff --git a/arch/arm/cpu/armv7/bcm281xx/clk-bcm281xx.c b/arch/arm/cpu/armv7/bcm281xx/clk-bcm281xx.c
index 8f6260e7857e..b258fea45c8e 100644
--- a/arch/arm/cpu/armv7/bcm281xx/clk-bcm281xx.c
+++ b/arch/arm/cpu/armv7/bcm281xx/clk-bcm281xx.c
@@ -9,7 +9,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <linux/errno.h>
 #include <asm/arch/sysmap.h>
diff --git a/arch/arm/cpu/armv7/bcm281xx/clk-bsc.c b/arch/arm/cpu/armv7/bcm281xx/clk-bsc.c
index 1b3f36aebe11..55dcc2fd78ca 100644
--- a/arch/arm/cpu/armv7/bcm281xx/clk-bsc.c
+++ b/arch/arm/cpu/armv7/bcm281xx/clk-bsc.c
@@ -3,7 +3,6 @@
  * Copyright 2013 Broadcom Corporation.
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <linux/errno.h>
 #include <asm/arch/sysmap.h>
diff --git a/arch/arm/cpu/armv7/bcm281xx/clk-core.c b/arch/arm/cpu/armv7/bcm281xx/clk-core.c
index 26b673a5405e..3f2e021a307c 100644
--- a/arch/arm/cpu/armv7/bcm281xx/clk-core.c
+++ b/arch/arm/cpu/armv7/bcm281xx/clk-core.c
@@ -9,7 +9,6 @@
  *
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <linux/delay.h>
diff --git a/arch/arm/cpu/armv7/bcm281xx/clk-eth.c b/arch/arm/cpu/armv7/bcm281xx/clk-eth.c
index 209ceca9a06e..5f7cc4a102d0 100644
--- a/arch/arm/cpu/armv7/bcm281xx/clk-eth.c
+++ b/arch/arm/cpu/armv7/bcm281xx/clk-eth.c
@@ -3,7 +3,6 @@
  * Copyright 2014 Broadcom Corporation.
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
diff --git a/arch/arm/cpu/armv7/bcm281xx/clk-sdio.c b/arch/arm/cpu/armv7/bcm281xx/clk-sdio.c
index f2ba354c24f8..f3ff29bebe85 100644
--- a/arch/arm/cpu/armv7/bcm281xx/clk-sdio.c
+++ b/arch/arm/cpu/armv7/bcm281xx/clk-sdio.c
@@ -3,7 +3,6 @@
  * Copyright 2013 Broadcom Corporation.
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <linux/errno.h>
 #include <asm/arch/sysmap.h>
diff --git a/arch/arm/cpu/armv7/bcm281xx/clk-usb-otg.c b/arch/arm/cpu/armv7/bcm281xx/clk-usb-otg.c
index f604aec62fa6..87918059408c 100644
--- a/arch/arm/cpu/armv7/bcm281xx/clk-usb-otg.c
+++ b/arch/arm/cpu/armv7/bcm281xx/clk-usb-otg.c
@@ -3,7 +3,6 @@
  * Copyright 2014 Broadcom Corporation.
  */
 
-#include <common.h>
 #include <linux/errno.h>
 #include <asm/arch/sysmap.h>
 #include "clk-core.h"
diff --git a/arch/arm/cpu/armv7/bcm281xx/reset.c b/arch/arm/cpu/armv7/bcm281xx/reset.c
index 1491e5c88b20..87e4337be4e0 100644
--- a/arch/arm/cpu/armv7/bcm281xx/reset.c
+++ b/arch/arm/cpu/armv7/bcm281xx/reset.c
@@ -3,7 +3,6 @@
  * Copyright 2013 Broadcom Corporation.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/sysmap.h>
diff --git a/arch/arm/cpu/armv7/bcmcygnus/reset.c b/arch/arm/cpu/armv7/bcmcygnus/reset.c
index 63992fd87018..617c8d68a2a9 100644
--- a/arch/arm/cpu/armv7/bcmcygnus/reset.c
+++ b/arch/arm/cpu/armv7/bcmcygnus/reset.c
@@ -3,7 +3,6 @@
  * Copyright 2014 Broadcom Corporation.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/io.h>
 
diff --git a/arch/arm/cpu/armv7/bcmnsp/reset.c b/arch/arm/cpu/armv7/bcmnsp/reset.c
index a3137752e886..c3be33124c6a 100644
--- a/arch/arm/cpu/armv7/bcmnsp/reset.c
+++ b/arch/arm/cpu/armv7/bcmnsp/reset.c
@@ -3,7 +3,6 @@
  * Copyright 2014 Broadcom Corporation.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/io.h>
 
diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
index 016bc1eb4129..1b459707bc63 100644
--- a/arch/arm/mach-bcm283x/init.c
+++ b/arch/arm/mach-bcm283x/init.c
@@ -6,7 +6,6 @@
  * project.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <dm/device.h>
diff --git a/arch/arm/mach-bcm283x/mbox.c b/arch/arm/mach-bcm283x/mbox.c
index da9faafe1ddc..c7cbfa72ffcc 100644
--- a/arch/arm/mach-bcm283x/mbox.c
+++ b/arch/arm/mach-bcm283x/mbox.c
@@ -3,9 +3,9 @@
  * (C) Copyright 2012 Stephen Warren
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <asm/arch/base.h>
diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c
index 2188b38d84b4..4993c0bdb819 100644
--- a/arch/arm/mach-bcm283x/msg.c
+++ b/arch/arm/mach-bcm283x/msg.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2012 Stephen Warren
  */
 
-#include <common.h>
 #include <memalign.h>
 #include <phys2bus.h>
 #include <asm/arch/mbox.h>
diff --git a/arch/arm/mach-bcm283x/reset.c b/arch/arm/mach-bcm283x/reset.c
index f13ac0c63757..9199234917f7 100644
--- a/arch/arm/mach-bcm283x/reset.c
+++ b/arch/arm/mach-bcm283x/reset.c
@@ -6,7 +6,7 @@
  * project.
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/base.h>
diff --git a/arch/arm/mach-bcmbca/bcm4908/mmu_table.c b/arch/arm/mach-bcmbca/bcm4908/mmu_table.c
index 5ab04083cc6c..ca403bae9912 100644
--- a/arch/arm/mach-bcmbca/bcm4908/mmu_table.c
+++ b/arch/arm/mach-bcmbca/bcm4908/mmu_table.c
@@ -2,7 +2,6 @@
 /*
  *  Copyright 2022 Broadcom Ltd.
  */
-#include <common.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
 
diff --git a/arch/arm/mach-bcmbca/bcm4912/mmu_table.c b/arch/arm/mach-bcmbca/bcm4912/mmu_table.c
index 52a53a2c76d0..b11effe06678 100644
--- a/arch/arm/mach-bcmbca/bcm4912/mmu_table.c
+++ b/arch/arm/mach-bcmbca/bcm4912/mmu_table.c
@@ -2,7 +2,6 @@
 /*
  *  Copyright 2022 Broadcom Ltd.
  */
-#include <common.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
 
diff --git a/arch/arm/mach-bcmbca/bcm63146/mmu_table.c b/arch/arm/mach-bcmbca/bcm63146/mmu_table.c
index c6b7a54fbdfa..a883e74ac005 100644
--- a/arch/arm/mach-bcmbca/bcm63146/mmu_table.c
+++ b/arch/arm/mach-bcmbca/bcm63146/mmu_table.c
@@ -2,7 +2,6 @@
 /*
  *  Copyright 2022 Broadcom Ltd.
  */
-#include <common.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
 
diff --git a/arch/arm/mach-bcmbca/bcm63158/mmu_table.c b/arch/arm/mach-bcmbca/bcm63158/mmu_table.c
index fe7efb30e22b..eb3cc3e5aec2 100644
--- a/arch/arm/mach-bcmbca/bcm63158/mmu_table.c
+++ b/arch/arm/mach-bcmbca/bcm63158/mmu_table.c
@@ -2,7 +2,6 @@
 /*
  *  Copyright 2022 Broadcom Ltd.
  */
-#include <common.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
 
diff --git a/arch/arm/mach-bcmbca/bcm6813/mmu_table.c b/arch/arm/mach-bcmbca/bcm6813/mmu_table.c
index eb736bf7d508..458624e87aa9 100644
--- a/arch/arm/mach-bcmbca/bcm6813/mmu_table.c
+++ b/arch/arm/mach-bcmbca/bcm6813/mmu_table.c
@@ -2,7 +2,6 @@
 /*
  *  Copyright 2022 Broadcom Ltd.
  */
-#include <common.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
 
diff --git a/arch/arm/mach-bcmbca/bcm6856/mmu_table.c b/arch/arm/mach-bcmbca/bcm6856/mmu_table.c
index 8e53b4929eb8..83c07727573a 100644
--- a/arch/arm/mach-bcmbca/bcm6856/mmu_table.c
+++ b/arch/arm/mach-bcmbca/bcm6856/mmu_table.c
@@ -2,7 +2,6 @@
 /*
  *  Copyright 2022 Broadcom Ltd.
  */
-#include <common.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
 
diff --git a/arch/arm/mach-bcmbca/bcm6858/mmu_table.c b/arch/arm/mach-bcmbca/bcm6858/mmu_table.c
index 898291075f5e..82aba326dcb3 100644
--- a/arch/arm/mach-bcmbca/bcm6858/mmu_table.c
+++ b/arch/arm/mach-bcmbca/bcm6858/mmu_table.c
@@ -2,7 +2,6 @@
 /*
  *  Copyright 2022 Broadcom Ltd.
  */
-#include <common.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
 
-- 
2.34.1

