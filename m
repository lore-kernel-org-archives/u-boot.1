Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FC1C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E02EF88CB9;
	Wed,  1 May 2024 04:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WhBdiPh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FDB688CA6; Wed,  1 May 2024 04:45:57 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34A1D88771
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-78f056f928eso484859885a.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531553; x=1715136353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Prji7872oUwakDrs0B938ZTA9hkwhqJYKpPEyxypl8g=;
 b=WhBdiPh39k+tMiLVrMLUIayWy4mfZVTQmcbzzzlDPZwhJ7W7E9TJZkRsNOR6vftXLt
 76pZ6W9WKrzNumk5zzGw3z2A6U1CekYXKQRGxVT98jw3sDEsOH40KnJ+rju//BRjcQAj
 EsJq0OCKfH4vnk0SEtin1zpiX/BhDDCqXoStQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531553; x=1715136353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Prji7872oUwakDrs0B938ZTA9hkwhqJYKpPEyxypl8g=;
 b=B7nF6tkoqjPsbamylqu2LQNJfU2+TfGGlB/dFrzMuAfKEMGKfAG9OM4cU/g+sHJ8+z
 +Js08PR03qeGjJeXw2+djLb54aKLLDMO6BZWof3cv3fjjBkA7bI+ag7fSnOdYUpnDoMI
 4CgpcuqVe0WqLUX+vQRXGGkMI8VL4YR9HPs7Q7A95d7ME2bMksWOLZGNqrNPvxxmpCtI
 f74mIhI6TGViy/umMaAEDr5jf5EJAWiIUmSpNaSVrTfgc9iOFqq+x+CLAiggHbahakhk
 9GMTzRggwOzkXpiCtuxWtNr6yYyn8w3p+XGw+adAF9ZcYTSZa64K6b+w4xSF+Tu9+hli
 YIlA==
X-Gm-Message-State: AOJu0YyzfUP2ldHAyUvrRI0pvwlEMyCZqR9V8Ui0+gVq5A6yHpDgTDZp
 +W71qjJB+toSXsOZTlaMEHzpnyQ+86Oy6aFGz3KrbYWWHMg+7lWnMqsKEz4lu8Q3UTxA/1EL2F+
 EGUEHOYDN
X-Google-Smtp-Source: AGHT+IGvfXhE6EOz7H88bfD3UOwH2U2tyNuBurJA9g8xKJVaXRPFZaD1sbGxgRLMyuF1+DbD1X0kKg==
X-Received: by 2002:a05:6214:1d2b:b0:6a0:5528:9594 with SMTP id
 f11-20020a0562141d2b00b006a055289594mr1116782qvd.64.1714531552968; 
 Tue, 30 Apr 2024 19:45:52 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Andrew Davis <afd@ti.com>, "Derald D. Woods" <woods.technical@gmail.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 135/149] board: ti: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:43:02 -0600
Message-Id: <20240501024316.1767971-135-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Andrew Davis <afd@ti.com>
Cc: "Derald D. Woods" <woods.technical@gmail.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Prasanth Babu Mantena <p-mantena@ti.com>
Cc: Simon Glass <sjg@chromium.org>
---
 board/ti/am335x/board.c        | 2 +-
 board/ti/am335x/board.h        | 2 ++
 board/ti/am335x/mux.c          | 2 +-
 board/ti/am43xx/board.c        | 2 +-
 board/ti/am43xx/board.h        | 1 +
 board/ti/am43xx/mux.c          | 1 -
 board/ti/am57xx/board.c        | 2 +-
 board/ti/common/board_detect.c | 2 +-
 board/ti/common/cape_detect.c  | 3 ++-
 board/ti/dra7xx/evm.c          | 2 +-
 board/ti/ks2_evm/board.c       | 2 +-
 board/ti/ks2_evm/board_k2e.c   | 1 -
 board/ti/ks2_evm/board_k2g.c   | 2 +-
 board/ti/ks2_evm/board_k2hk.c  | 1 -
 board/ti/ks2_evm/board_k2l.c   | 1 -
 board/ti/ks2_evm/ddr3_cfg.c    | 1 -
 board/ti/ks2_evm/ddr3_k2e.c    | 1 -
 board/ti/ks2_evm/ddr3_k2g.c    | 1 -
 board/ti/ks2_evm/ddr3_k2hk.c   | 1 -
 board/ti/ks2_evm/ddr3_k2l.c    | 1 -
 board/ti/omap3evm/evm.c        | 2 +-
 board/ti/panda/panda.c         | 1 -
 board/ti/sdp4430/cmd_bat.c     | 1 -
 board/ti/sdp4430/sdp.c         | 1 -
 include/linux/mtd/omap_gpmc.h  | 2 ++
 25 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
index 34f987c2b728..34f4a919656e 100644
--- a/board/ti/am335x/board.c
+++ b/board/ti/am335x/board.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <env.h>
 #include <errno.h>
diff --git a/board/ti/am335x/board.h b/board/ti/am335x/board.h
index 1284c160d811..b0a3842423fb 100644
--- a/board/ti/am335x/board.h
+++ b/board/ti/am335x/board.h
@@ -10,6 +10,8 @@
 #ifndef _BOARD_H_
 #define _BOARD_H_
 
+#include <linux/string.h>
+
 /**
  * AM335X (EMIF_4D) EMIF REG_COS_COUNT_1, REG_COS_COUNT_2, and
  * REG_PR_OLD_COUNT values to avoid LCDC DMA FIFO underflows and Frame
diff --git a/board/ti/am335x/mux.c b/board/ti/am335x/mux.c
index 0bad154f86ed..960de15398f8 100644
--- a/board/ti/am335x/mux.c
+++ b/board/ti/am335x/mux.c
@@ -13,7 +13,7 @@
  * GNU General Public License for more details.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/mux.h>
diff --git a/board/ti/am43xx/board.c b/board/ti/am43xx/board.c
index fdeb63d47900..40b7fcfc3876 100644
--- a/board/ti/am43xx/board.c
+++ b/board/ti/am43xx/board.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2013, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/global_data.h>
 #include <dm/uclass.h>
 #include <env.h>
diff --git a/board/ti/am43xx/board.h b/board/ti/am43xx/board.h
index 37a169aaf758..b1025bdda1e1 100644
--- a/board/ti/am43xx/board.h
+++ b/board/ti/am43xx/board.h
@@ -11,6 +11,7 @@
 #ifndef _BOARD_H_
 #define _BOARD_H_
 
+#include <linux/string.h>
 #include <asm/arch/omap.h>
 
 #define DEV_ATTR_MAX_OFFSET    5
diff --git a/board/ti/am43xx/mux.c b/board/ti/am43xx/mux.c
index 463f1cc71784..2fcccbd1f043 100644
--- a/board/ti/am43xx/mux.c
+++ b/board/ti/am43xx/mux.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/mux.h>
 #include "../common/board_detect.h"
diff --git a/board/ti/am57xx/board.c b/board/ti/am57xx/board.c
index b004a89bb324..48668884bdd5 100644
--- a/board/ti/am57xx/board.c
+++ b/board/ti/am57xx/board.c
@@ -7,7 +7,7 @@
  * Based on board/ti/dra7xx/evm.c
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <fastboot.h>
 #include <fdt_support.h>
diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detect.c
index 644df3b0b6ab..ea21d48bbc01 100644
--- a/board/ti/common/board_detect.c
+++ b/board/ti/common/board_detect.c
@@ -7,9 +7,9 @@
  *	Steve Kipisz
  */
 
-#include <common.h>
 #include <log.h>
 #include <net.h>
+#include <linux/types.h>
 #include <asm/arch/hardware.h>
 #include <asm/omap_common.h>
 #include <dm/uclass.h>
diff --git a/board/ti/common/cape_detect.c b/board/ti/common/cape_detect.c
index 2e6105cfbf15..da805befabcb 100644
--- a/board/ti/common/cape_detect.c
+++ b/board/ti/common/cape_detect.c
@@ -4,10 +4,11 @@
  * Köry Maincent, Bootlin, <kory.maincent@bootlin.com>
  */
 
-#include <common.h>
+#include <stdio.h>
 #include <malloc.h>
 #include <i2c.h>
 #include <extension_board.h>
+#include <vsprintf.h>
 
 #include "cape_detect.h"
 
diff --git a/board/ti/dra7xx/evm.c b/board/ti/dra7xx/evm.c
index a8a216d034a4..2b1db2541b0b 100644
--- a/board/ti/dra7xx/evm.c
+++ b/board/ti/dra7xx/evm.c
@@ -9,7 +9,7 @@
  * Aneesh V       <aneesh@ti.com>
  * Steve Sakoman  <steve@sakoman.com>
  */
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <fastboot.h>
diff --git a/board/ti/ks2_evm/board.c b/board/ti/ks2_evm/board.c
index 5dcda12105b9..c6735d37dda7 100644
--- a/board/ti/ks2_evm/board.c
+++ b/board/ti/ks2_evm/board.c
@@ -6,7 +6,7 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/global_data.h>
 #include "board.h"
 #include <env.h>
diff --git a/board/ti/ks2_evm/board_k2e.c b/board/ti/ks2_evm/board_k2e.c
index 39abb24e1560..4385be4221b7 100644
--- a/board/ti/ks2_evm/board_k2e.c
+++ b/board/ti/ks2_evm/board_k2e.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include <image.h>
 #include <init.h>
 #include <asm/arch/ddr3.h>
diff --git a/board/ti/ks2_evm/board_k2g.c b/board/ti/ks2_evm/board_k2g.c
index 4fed42ec1244..d07b77d23e27 100644
--- a/board/ti/ks2_evm/board_k2g.c
+++ b/board/ti/ks2_evm/board_k2g.c
@@ -5,7 +5,7 @@
  * (C) Copyright 2015
  *     Texas Instruments Incorporated, <www.ti.com>
  */
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <hang.h>
 #include <image.h>
diff --git a/board/ti/ks2_evm/board_k2hk.c b/board/ti/ks2_evm/board_k2hk.c
index 12c4649c3c4c..2b5d2d756649 100644
--- a/board/ti/ks2_evm/board_k2hk.c
+++ b/board/ti/ks2_evm/board_k2hk.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include <image.h>
 #include <init.h>
 #include <asm/arch/clock.h>
diff --git a/board/ti/ks2_evm/board_k2l.c b/board/ti/ks2_evm/board_k2l.c
index f759ee364666..1971bc94f7d3 100644
--- a/board/ti/ks2_evm/board_k2l.c
+++ b/board/ti/ks2_evm/board_k2l.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include <image.h>
 #include <init.h>
 #include <asm/arch/ddr3.h>
diff --git a/board/ti/ks2_evm/ddr3_cfg.c b/board/ti/ks2_evm/ddr3_cfg.c
index 0ade75263f8d..fe350fee795e 100644
--- a/board/ti/ks2_evm/ddr3_cfg.c
+++ b/board/ti/ks2_evm/ddr3_cfg.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 
 #include <asm/arch/ddr3.h>
 #include "ddr3_cfg.h"
diff --git a/board/ti/ks2_evm/ddr3_k2e.c b/board/ti/ks2_evm/ddr3_k2e.c
index 95fe3a9021e2..28305326e6a1 100644
--- a/board/ti/ks2_evm/ddr3_k2e.c
+++ b/board/ti/ks2_evm/ddr3_k2e.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include "ddr3_cfg.h"
 #include <asm/arch/ddr3.h>
 
diff --git a/board/ti/ks2_evm/ddr3_k2g.c b/board/ti/ks2_evm/ddr3_k2g.c
index 3000d7245eb2..ef39e0781521 100644
--- a/board/ti/ks2_evm/ddr3_k2g.c
+++ b/board/ti/ks2_evm/ddr3_k2g.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include "ddr3_cfg.h"
 #include <asm/arch/ddr3.h>
 #include <asm/arch/hardware.h>
diff --git a/board/ti/ks2_evm/ddr3_k2hk.c b/board/ti/ks2_evm/ddr3_k2hk.c
index 198c5da0e622..05c050cee440 100644
--- a/board/ti/ks2_evm/ddr3_k2hk.c
+++ b/board/ti/ks2_evm/ddr3_k2hk.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include "ddr3_cfg.h"
 #include <asm/arch/ddr3.h>
 #include <asm/arch/hardware.h>
diff --git a/board/ti/ks2_evm/ddr3_k2l.c b/board/ti/ks2_evm/ddr3_k2l.c
index 805bf81f6bdf..aa6d45f0f8af 100644
--- a/board/ti/ks2_evm/ddr3_k2l.c
+++ b/board/ti/ks2_evm/ddr3_k2l.c
@@ -6,7 +6,6 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
 #include "ddr3_cfg.h"
 #include <asm/arch/ddr3.h>
 
diff --git a/board/ti/omap3evm/evm.c b/board/ti/omap3evm/evm.c
index a4d6a0138d9b..4eb08add2564 100644
--- a/board/ti/omap3evm/evm.c
+++ b/board/ti/omap3evm/evm.c
@@ -10,7 +10,7 @@
  *	Richard Woodruff <r-woodruff2@ti.com>
  *	Syed Mohammed Khasim <khasim@ti.com>
  */
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/ti/panda/panda.c b/board/ti/panda/panda.c
index 220931860190..e47d3a952d5c 100644
--- a/board/ti/panda/panda.c
+++ b/board/ti/panda/panda.c
@@ -4,7 +4,6 @@
  * Texas Instruments Incorporated, <www.ti.com>
  * Steve Sakoman  <steve@sakoman.com>
  */
-#include <common.h>
 #include <init.h>
 #include <log.h>
 #include <net.h>
diff --git a/board/ti/sdp4430/cmd_bat.c b/board/ti/sdp4430/cmd_bat.c
index 6c1e6ca393c6..6bf44d926550 100644
--- a/board/ti/sdp4430/cmd_bat.c
+++ b/board/ti/sdp4430/cmd_bat.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2010 Texas Instruments
  */
 
-#include <common.h>
 #include <command.h>
 
 #ifdef CONFIG_CMD_BAT
diff --git a/board/ti/sdp4430/sdp.c b/board/ti/sdp4430/sdp.c
index 2c9ae794fd4b..1a71390f543b 100644
--- a/board/ti/sdp4430/sdp.c
+++ b/board/ti/sdp4430/sdp.c
@@ -5,7 +5,6 @@
  * Aneesh V       <aneesh@ti.com>
  * Steve Sakoman  <steve@sakoman.com>
  */
-#include <common.h>
 #include <init.h>
 #include <net.h>
 #include <twl6030.h>
diff --git a/include/linux/mtd/omap_gpmc.h b/include/linux/mtd/omap_gpmc.h
index f08e700a1daf..2dbf988863f9 100644
--- a/include/linux/mtd/omap_gpmc.h
+++ b/include/linux/mtd/omap_gpmc.h
@@ -8,6 +8,8 @@
 #ifndef __ASM_OMAP_GPMC_H
 #define __ASM_OMAP_GPMC_H
 
+#include <linux/types.h>
+
 /* Maximum Number of Chip Selects */
 #define GPMC_CS_NUM	8
 
-- 
2.34.1

