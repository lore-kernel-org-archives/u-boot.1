Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F76C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69B0E88C94;
	Thu,  2 May 2024 03:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hAC5B8tT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EEC088BEF; Thu,  2 May 2024 03:32:59 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7222788C81
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-439884be4efso46708421cf.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613574; x=1715218374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pzzk2NcA4HezPX82Yuw+MXFMe7ZOVB2mxcyIeigpe/U=;
 b=hAC5B8tTAx57yheeqHqIVZh5jVZ+3S30awu+8W/tw4QPA9TjuUWlfR2waUJqZYcy/2
 I65lnnTEMdoSqpmfHsczZfsyZRB5gZK8AiSinR8QehyLr0oQMphq7Wn3JBEus0uqoBFb
 5cqSPKnGmPPbPnKfsc1PFFUAzFbaztKjSR+4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613574; x=1715218374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pzzk2NcA4HezPX82Yuw+MXFMe7ZOVB2mxcyIeigpe/U=;
 b=evIfK2ZJ3UUAofnfPCDuRW3RsTAb1fOKNQM9mG+qwSpz70rLSiR/AANgzLc5fo5AKV
 o47GCiq8vMkv6SbBwvnGYsaUcUx7LfGhCZEC9uwyoj0+HtClXhILMsfhqiD+EJFYLphV
 VhlOU6Q4YLu+FNZP+9em+k4XJqHXMdLGFhOE/2C0vduD3kRXLr/uFKudoGiXlUcElPHo
 l4IlAhjZyG6RFyToa4pnRT+Ug4lQ8G5QUWkbEBjZ0oNIolSJG7qfY5YYmPWq4wG0h0nX
 WblcibcCeW/sKiZddH/XQLnU2C6plZ6/zf92xDtLdXa/MG/MirREIrKpTEu2rgr+tIvN
 allg==
X-Gm-Message-State: AOJu0Yw5+jVEvmsdZvyL3f9G2H8to4wHP5BzXtCA+HZOUyHHxx1HqlPr
 Cm92XWjAfjJi+yMxteHKfCp624FHxErFhvuNOAKGEdC9o6r2VXt3xj9sbpcvX822MT5+NYV9Kcm
 cKtn+9kqi
X-Google-Smtp-Source: AGHT+IGNarEVVQstyM2vbUGXGe7U/ZZXkh6STqH04j3DbbjE4Io/W3rcKfXYsa3wiIi+6QlQNEAJsw==
X-Received: by 2002:ac8:5a50:0:b0:43a:b16d:a0ca with SMTP id
 o16-20020ac85a50000000b0043ab16da0camr4994102qta.60.1714613573904; 
 Wed, 01 May 2024 18:32:53 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Joel Peshkin <joel.peshkin@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Nishanth Menon <nm@ti.com>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 43/81] mtd: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:00 -0600
Message-Id: <20240502013138.2383421-43-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Stefan Roese <sr@denx.de>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Anand Gore <anand.gore@broadcom.com>
Cc: William Zhang <william.zhang@broadcom.com>
Cc: Kursad Oney <kursad.oney@broadcom.com>
Cc: Joel Peshkin <joel.peshkin@broadcom.com>
Cc: Philippe Reynes <philippe.reynes@softathome.com>
Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Vignesh R <vigneshr@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Sean Anderson <seanga2@gmail.com>
---
 drivers/mtd/altera_qspi.c                       | 1 -
 drivers/mtd/cfi_flash.c                         | 3 ++-
 drivers/mtd/cfi_mtd.c                           | 1 -
 drivers/mtd/hbmc-am654.c                        | 1 -
 drivers/mtd/jedec_flash.c                       | 1 -
 drivers/mtd/mtd-uclass.c                        | 1 -
 drivers/mtd/mtd_uboot.c                         | 1 -
 drivers/mtd/mtdpart.c                           | 1 -
 drivers/mtd/nand/bbt.c                          | 1 -
 drivers/mtd/nand/core.c                         | 1 -
 drivers/mtd/nand/raw/am335x_spl_bch.c           | 2 +-
 drivers/mtd/nand/raw/arasan_nfc.c               | 1 -
 drivers/mtd/nand/raw/atmel_nand.c               | 2 +-
 drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c   | 1 -
 drivers/mtd/nand/raw/brcmnand/bcm6368_nand.c    | 1 -
 drivers/mtd/nand/raw/brcmnand/bcm6753_nand.c    | 1 -
 drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c   | 1 -
 drivers/mtd/nand/raw/brcmnand/bcm6838_nand.c    | 1 -
 drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c    | 1 -
 drivers/mtd/nand/raw/brcmnand/brcmnand.c        | 1 -
 drivers/mtd/nand/raw/brcmnand/brcmnand_compat.c | 1 -
 drivers/mtd/nand/raw/brcmnand/iproc_nand.c      | 1 -
 drivers/mtd/nand/raw/cortina_nand.c             | 1 -
 drivers/mtd/nand/raw/davinci_nand.c             | 2 +-
 drivers/mtd/nand/raw/denali.c                   | 1 -
 drivers/mtd/nand/raw/denali_spl.c               | 2 +-
 drivers/mtd/nand/raw/fsl_elbc_nand.c            | 2 +-
 drivers/mtd/nand/raw/fsl_elbc_spl.c             | 2 +-
 drivers/mtd/nand/raw/fsl_ifc_nand.c             | 2 +-
 drivers/mtd/nand/raw/fsl_ifc_spl.c              | 2 +-
 drivers/mtd/nand/raw/kirkwood_nand.c            | 1 -
 drivers/mtd/nand/raw/kmeter1_nand.c             | 2 +-
 drivers/mtd/nand/raw/lpc32xx_nand_mlc.c         | 2 +-
 drivers/mtd/nand/raw/lpc32xx_nand_slc.c         | 2 +-
 drivers/mtd/nand/raw/mxc_nand.c                 | 2 +-
 drivers/mtd/nand/raw/mxc_nand_spl.c             | 2 +-
 drivers/mtd/nand/raw/mxic_nand.c                | 1 -
 drivers/mtd/nand/raw/mxs_nand.c                 | 1 -
 drivers/mtd/nand/raw/mxs_nand_spl.c             | 1 -
 drivers/mtd/nand/raw/nand.c                     | 2 +-
 drivers/mtd/nand/raw/nand_base.c                | 1 -
 drivers/mtd/nand/raw/nand_bbt.c                 | 1 -
 drivers/mtd/nand/raw/nand_bch.c                 | 1 -
 drivers/mtd/nand/raw/nand_ecc.c                 | 1 -
 drivers/mtd/nand/raw/nand_ids.c                 | 1 -
 drivers/mtd/nand/raw/nand_spl_load.c            | 2 +-
 drivers/mtd/nand/raw/nand_spl_simple.c          | 2 +-
 drivers/mtd/nand/raw/nand_timings.c             | 1 -
 drivers/mtd/nand/raw/nand_util.c                | 1 -
 drivers/mtd/nand/raw/omap_elm.c                 | 1 -
 drivers/mtd/nand/raw/omap_gpmc.c                | 2 +-
 drivers/mtd/nand/raw/pxa3xx_nand.c              | 1 -
 drivers/mtd/nand/raw/rockchip_nfc.c             | 1 -
 drivers/mtd/nand/raw/stm32_fmc2_nand.c          | 1 -
 drivers/mtd/nand/raw/sunxi_nand.c               | 1 -
 drivers/mtd/nand/raw/sunxi_nand_spl.c           | 1 -
 drivers/mtd/nand/raw/tegra_nand.c               | 1 -
 drivers/mtd/nand/raw/vf610_nfc.c                | 2 +-
 drivers/mtd/nand/raw/zynq_nand.c                | 1 -
 drivers/mtd/nand/spi/core.c                     | 1 -
 drivers/mtd/nvmxip/nvmxip-uclass.c              | 1 -
 drivers/mtd/nvmxip/nvmxip.c                     | 1 -
 drivers/mtd/nvmxip/nvmxip_qspi.c                | 1 -
 drivers/mtd/onenand/onenand_base.c              | 1 -
 drivers/mtd/onenand/onenand_bbt.c               | 1 -
 drivers/mtd/onenand/onenand_spl.c               | 3 ++-
 drivers/mtd/onenand/onenand_uboot.c             | 2 +-
 drivers/mtd/onenand/samsung.c                   | 1 -
 drivers/mtd/renesas_rpc_hf.c                    | 1 -
 drivers/mtd/spi/fsl_espi_spl.c                  | 2 +-
 drivers/mtd/spi/sandbox.c                       | 1 -
 drivers/mtd/spi/sf-uclass.c                     | 1 -
 drivers/mtd/spi/sf_bootdev.c                    | 1 -
 drivers/mtd/spi/sf_dataflash.c                  | 1 -
 drivers/mtd/spi/sf_mtd.c                        | 1 -
 drivers/mtd/spi/sf_probe.c                      | 1 -
 drivers/mtd/spi/spi-nor-core.c                  | 1 -
 drivers/mtd/spi/spi-nor-ids.c                   | 1 -
 drivers/mtd/spi/spi-nor-tiny.c                  | 1 -
 drivers/mtd/stm32_flash.c                       | 2 +-
 drivers/mtd/ubispl/ubispl.c                     | 1 -
 81 files changed, 25 insertions(+), 81 deletions(-)

diff --git a/drivers/mtd/altera_qspi.c b/drivers/mtd/altera_qspi.c
index d31391f36a47..c26615821c80 100644
--- a/drivers/mtd/altera_qspi.c
+++ b/drivers/mtd/altera_qspi.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Thomas Chou <thomas@wytron.com.tw>
  */
 
-#include <common.h>
 #include <console.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/mtd/cfi_flash.c b/drivers/mtd/cfi_flash.c
index 8ade7949a68e..a7826e81c177 100644
--- a/drivers/mtd/cfi_flash.c
+++ b/drivers/mtd/cfi_flash.c
@@ -16,7 +16,7 @@
 /* The DEBUG define must be before common to enable debugging */
 /* #define DEBUG	*/
 
-#include <common.h>
+#include <config.h>
 #include <console.h>
 #include <dm.h>
 #include <env.h>
@@ -26,6 +26,7 @@
 #include <init.h>
 #include <irq_func.h>
 #include <log.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <asm/processor.h>
 #include <asm/io.h>
diff --git a/drivers/mtd/cfi_mtd.c b/drivers/mtd/cfi_mtd.c
index bf4473ba9e83..b14d4773931b 100644
--- a/drivers/mtd/cfi_mtd.c
+++ b/drivers/mtd/cfi_mtd.c
@@ -5,7 +5,6 @@
  * Written by: Piotr Ziecik <kosmo@semihalf.com>
  */
 
-#include <common.h>
 #include <dma.h>
 #include <flash.h>
 #include <malloc.h>
diff --git a/drivers/mtd/hbmc-am654.c b/drivers/mtd/hbmc-am654.c
index 8161087b50c0..599beda30d55 100644
--- a/drivers/mtd/hbmc-am654.c
+++ b/drivers/mtd/hbmc-am654.c
@@ -3,7 +3,6 @@
 // Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
 // Author: Vignesh Raghavendra <vigneshr@ti.com>
 
-#include <common.h>
 #include <asm/io.h>
 #include <dm.h>
 #include <regmap.h>
diff --git a/drivers/mtd/jedec_flash.c b/drivers/mtd/jedec_flash.c
index 859c7fd4ec24..a832f348f22d 100644
--- a/drivers/mtd/jedec_flash.c
+++ b/drivers/mtd/jedec_flash.c
@@ -11,7 +11,6 @@
 /* The DEBUG define must be before common to enable debugging */
 /*#define DEBUG*/
 
-#include <common.h>
 #include <flash.h>
 #include <log.h>
 #include <asm/processor.h>
diff --git a/drivers/mtd/mtd-uclass.c b/drivers/mtd/mtd-uclass.c
index 0743fe7af9fd..720bd824c4d7 100644
--- a/drivers/mtd/mtd-uclass.c
+++ b/drivers/mtd/mtd-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_MTD
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <errno.h>
diff --git a/drivers/mtd/mtd_uboot.c b/drivers/mtd/mtd_uboot.c
index 14ce726b10d8..69cb3b51f922 100644
--- a/drivers/mtd/mtd_uboot.c
+++ b/drivers/mtd/mtd_uboot.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2014
  * Heiko Schocher, DENX Software Engineering, hs@denx.de.
  */
-#include <common.h>
 #include <env.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 4886392a1cfa..be1d19b4ffa5 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -19,7 +19,6 @@
 #include <linux/kmod.h>
 #endif
 
-#include <common.h>
 #include <malloc.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
diff --git a/drivers/mtd/nand/bbt.c b/drivers/mtd/nand/bbt.c
index 972aec6e2666..4ff0999f62a1 100644
--- a/drivers/mtd/nand/bbt.c
+++ b/drivers/mtd/nand/bbt.c
@@ -9,7 +9,6 @@
 
 #define pr_fmt(fmt)	"nand-bbt: " fmt
 
-#include <common.h>
 #include <dm/devres.h>
 #include <linux/bitops.h>
 #include <linux/mtd/nand.h>
diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
index f6d9c584f786..472ad0bdefb1 100644
--- a/drivers/mtd/nand/core.c
+++ b/drivers/mtd/nand/core.c
@@ -9,7 +9,6 @@
 
 #define pr_fmt(fmt)	"nand: " fmt
 
-#include <common.h>
 #include <watchdog.h>
 #ifndef __UBOOT__
 #include <linux/compat.h>
diff --git a/drivers/mtd/nand/raw/am335x_spl_bch.c b/drivers/mtd/nand/raw/am335x_spl_bch.c
index 6831af98b73b..64d8ce0965ad 100644
--- a/drivers/mtd/nand/raw/am335x_spl_bch.c
+++ b/drivers/mtd/nand/raw/am335x_spl_bch.c
@@ -9,7 +9,7 @@
  * Stefan Roese, DENX Software Engineering, sr@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <nand.h>
 #include <system-constants.h>
 #include <asm/io.h>
diff --git a/drivers/mtd/nand/raw/arasan_nfc.c b/drivers/mtd/nand/raw/arasan_nfc.c
index ffcd963b3dac..4f013efafb36 100644
--- a/drivers/mtd/nand/raw/arasan_nfc.c
+++ b/drivers/mtd/nand/raw/arasan_nfc.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2014 - 2015 Xilinx, Inc.
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <asm/io.h>
 #include <linux/delay.h>
diff --git a/drivers/mtd/nand/raw/atmel_nand.c b/drivers/mtd/nand/raw/atmel_nand.c
index 6d94e7af38e9..4dbf7b47135c 100644
--- a/drivers/mtd/nand/raw/atmel_nand.c
+++ b/drivers/mtd/nand/raw/atmel_nand.c
@@ -10,7 +10,7 @@
  *     (C) Copyright 2012 ATMEL, Hong Xu
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <system-constants.h>
 #include <asm/gpio.h>
diff --git a/drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c b/drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c
index 4e6d99fd3ca4..3f59fbbbb8f1 100644
--- a/drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c
+++ b/drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <asm/io.h>
 #include <memalign.h>
 #include <nand.h>
diff --git a/drivers/mtd/nand/raw/brcmnand/bcm6368_nand.c b/drivers/mtd/nand/raw/brcmnand/bcm6368_nand.c
index 6164989b9378..d54de0b3ecce 100644
--- a/drivers/mtd/nand/raw/brcmnand/bcm6368_nand.c
+++ b/drivers/mtd/nand/raw/brcmnand/bcm6368_nand.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <asm/io.h>
 #include <memalign.h>
 #include <nand.h>
diff --git a/drivers/mtd/nand/raw/brcmnand/bcm6753_nand.c b/drivers/mtd/nand/raw/brcmnand/bcm6753_nand.c
index feae66ef25a6..a101222a28fa 100644
--- a/drivers/mtd/nand/raw/brcmnand/bcm6753_nand.c
+++ b/drivers/mtd/nand/raw/brcmnand/bcm6753_nand.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <asm/io.h>
 #include <memalign.h>
 #include <nand.h>
diff --git a/drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c b/drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c
index dbd85af7079d..385642d0c091 100644
--- a/drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c
+++ b/drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <asm/io.h>
 #include <memalign.h>
 #include <nand.h>
diff --git a/drivers/mtd/nand/raw/brcmnand/bcm6838_nand.c b/drivers/mtd/nand/raw/brcmnand/bcm6838_nand.c
index ef3649688c66..407898ddae6e 100644
--- a/drivers/mtd/nand/raw/brcmnand/bcm6838_nand.c
+++ b/drivers/mtd/nand/raw/brcmnand/bcm6838_nand.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <asm/io.h>
 #include <memalign.h>
 #include <nand.h>
diff --git a/drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c b/drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c
index 027fdd37da3b..564c678c9ef2 100644
--- a/drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c
+++ b/drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <asm/io.h>
 #include <memalign.h>
 #include <nand.h>
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index efbf9a3120a4..b7bf7cc0893d 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -12,7 +12,6 @@
  * GNU General Public License for more details.
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <memalign.h>
 #include <nand.h>
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand_compat.c b/drivers/mtd/nand/raw/brcmnand/brcmnand_compat.c
index a6acf556bcc7..b3b3df5c042e 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand_compat.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand_compat.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 
-#include <common.h>
 #include <dm.h>
 #include <malloc.h>
 #include <dm/devres.h>
diff --git a/drivers/mtd/nand/raw/brcmnand/iproc_nand.c b/drivers/mtd/nand/raw/brcmnand/iproc_nand.c
index 69711d98ce1b..430d6c938538 100644
--- a/drivers/mtd/nand/raw/brcmnand/iproc_nand.c
+++ b/drivers/mtd/nand/raw/brcmnand/iproc_nand.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2015 Broadcom Corporation
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <memalign.h>
 #include <nand.h>
diff --git a/drivers/mtd/nand/raw/cortina_nand.c b/drivers/mtd/nand/raw/cortina_nand.c
index b7be6602f7cc..06918a46e93f 100644
--- a/drivers/mtd/nand/raw/cortina_nand.c
+++ b/drivers/mtd/nand/raw/cortina_nand.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2020, Cortina Access Inc..
  */
 
-#include <common.h>
 #include <linux/delay.h>
 #include <linux/bitops.h>
 #include <linux/sizes.h>
diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 71bbb8231bfb..d4daf06b8de5 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -28,7 +28,7 @@
  -
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <linux/mtd/rawnand.h>
 #include <asm/io.h>
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index c827f80281c1..b2401116689a 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2009-2010, Intel Corporation and its suppliers.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <malloc.h>
 #include <nand.h>
diff --git a/drivers/mtd/nand/raw/denali_spl.c b/drivers/mtd/nand/raw/denali_spl.c
index 165a23312cb5..b1e2c9d81617 100644
--- a/drivers/mtd/nand/raw/denali_spl.c
+++ b/drivers/mtd/nand/raw/denali_spl.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2014-2015  Masahiro Yamada <yamada.masahiro@socionext.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/unaligned.h>
diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
index 7853c3f74e2a..157330cb287a 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
@@ -7,7 +7,7 @@
  *          Scott Wood <scottwood@freescale.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <malloc.h>
 #include <nand.h>
diff --git a/drivers/mtd/nand/raw/fsl_elbc_spl.c b/drivers/mtd/nand/raw/fsl_elbc_spl.c
index 26aaab08e893..17b8ef7ff4b9 100644
--- a/drivers/mtd/nand/raw/fsl_elbc_spl.c
+++ b/drivers/mtd/nand/raw/fsl_elbc_spl.c
@@ -9,7 +9,7 @@
  * Author: Scott Wood <scottwood@freescale.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <linux/mtd/rawnand.h>
 #include <asm/io.h>
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index 1d7c1fddd3f6..857d50ef9b09 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -6,7 +6,7 @@
  * Authors: Dipen Dudhat <Dipen.Dudhat@freescale.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <malloc.h>
 #include <nand.h>
diff --git a/drivers/mtd/nand/raw/fsl_ifc_spl.c b/drivers/mtd/nand/raw/fsl_ifc_spl.c
index 69d26f1f79ab..c2ebee948707 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_spl.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_spl.c
@@ -6,7 +6,7 @@
  * Author: Dipen Dudhat <dipen.dudhat@freescale.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <asm/io.h>
 #include <fsl_ifc.h>
diff --git a/drivers/mtd/nand/raw/kirkwood_nand.c b/drivers/mtd/nand/raw/kirkwood_nand.c
index 621d2d232c88..cd182be268dc 100644
--- a/drivers/mtd/nand/raw/kirkwood_nand.c
+++ b/drivers/mtd/nand/raw/kirkwood_nand.c
@@ -5,7 +5,6 @@
  * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
  */
 
-#include <common.h>
 #include <linux/mtd/rawnand.h>
 #include <asm/io.h>
 #include <asm/arch/soc.h>
diff --git a/drivers/mtd/nand/raw/kmeter1_nand.c b/drivers/mtd/nand/raw/kmeter1_nand.c
index dfe73d64e46a..e9398eb4093e 100644
--- a/drivers/mtd/nand/raw/kmeter1_nand.c
+++ b/drivers/mtd/nand/raw/kmeter1_nand.c
@@ -4,7 +4,7 @@
  * Heiko Schocher, DENX Software Engineering, hs@denx.de
  */
 
-#include <common.h>
+#include <config.h>
 #include <nand.h>
 #include <asm/io.h>
 #include <linux/delay.h>
diff --git a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
index f8ae216d56c6..c89661badbf5 100644
--- a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
@@ -19,7 +19,7 @@
  * should not rely on the ECC validity.
  */
 
-#include <common.h>
+#include <config.h>
 #include <nand.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
diff --git a/drivers/mtd/nand/raw/lpc32xx_nand_slc.c b/drivers/mtd/nand/raw/lpc32xx_nand_slc.c
index b21a0b9d293f..4d643bc64bc2 100644
--- a/drivers/mtd/nand/raw/lpc32xx_nand_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_nand_slc.c
@@ -10,7 +10,7 @@
  * Author: Kevin Wells
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <nand.h>
 #include <linux/bug.h>
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index dbdc5b0bca1c..0750b38f7081 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -5,7 +5,7 @@
  * Copyright 2009 Ilya Yanok, <yanok@emcraft.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <nand.h>
 #include <linux/delay.h>
diff --git a/drivers/mtd/nand/raw/mxc_nand_spl.c b/drivers/mtd/nand/raw/mxc_nand_spl.c
index a855c9987f80..c5872848954e 100644
--- a/drivers/mtd/nand/raw/mxc_nand_spl.c
+++ b/drivers/mtd/nand/raw/mxc_nand_spl.c
@@ -10,7 +10,7 @@
  * Stefan Roese, DENX Software Engineering, sr at denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <hang.h>
 #include <nand.h>
 #include <system-constants.h>
diff --git a/drivers/mtd/nand/raw/mxic_nand.c b/drivers/mtd/nand/raw/mxic_nand.c
index 6abdc24bd30c..0e54b5f69389 100644
--- a/drivers/mtd/nand/raw/mxic_nand.c
+++ b/drivers/mtd/nand/raw/mxic_nand.c
@@ -6,7 +6,6 @@
  *	Zhengxun Li <zhengxunli@mxic.com.tw>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <malloc.h>
diff --git a/drivers/mtd/nand/raw/mxs_nand.c b/drivers/mtd/nand/raw/mxs_nand.c
index fd65772af806..11b0247b2842 100644
--- a/drivers/mtd/nand/raw/mxs_nand.c
+++ b/drivers/mtd/nand/raw/mxs_nand.c
@@ -13,7 +13,6 @@
  * Copyright 2017-2019 NXP
  */
 
-#include <common.h>
 #include <clk.h>
 #include <cpu_func.h>
 #include <dm.h>
diff --git a/drivers/mtd/nand/raw/mxs_nand_spl.c b/drivers/mtd/nand/raw/mxs_nand_spl.c
index f7d3f02f85a0..c8e064347ada 100644
--- a/drivers/mtd/nand/raw/mxs_nand_spl.c
+++ b/drivers/mtd/nand/raw/mxs_nand_spl.c
@@ -4,7 +4,6 @@
  * Copyright 2019 NXP
  * Author: Tim Harvey <tharvey@gateworks.com>
  */
-#include <common.h>
 #include <log.h>
 #include <nand.h>
 #include <malloc.h>
diff --git a/drivers/mtd/nand/raw/nand.c b/drivers/mtd/nand/raw/nand.c
index b591170346d0..36054492e186 100644
--- a/drivers/mtd/nand/raw/nand.c
+++ b/drivers/mtd/nand/raw/nand.c
@@ -5,7 +5,7 @@
  * Ladislav Michl <michl@2n.cz>
  */
 
-#include <common.h>
+#include <config.h>
 #include <nand.h>
 #include <errno.h>
 #include <linux/mtd/concat.h>
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 688d17ba3c2f..18b95caffeff 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -28,7 +28,6 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <watchdog.h>
diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index cd451870a6f9..1fb8535ab054 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -57,7 +57,6 @@
  *
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <dm/devres.h>
diff --git a/drivers/mtd/nand/raw/nand_bch.c b/drivers/mtd/nand/raw/nand_bch.c
index bb48ebbb96c7..f317cc26c903 100644
--- a/drivers/mtd/nand/raw/nand_bch.c
+++ b/drivers/mtd/nand/raw/nand_bch.c
@@ -7,7 +7,6 @@
  *
  */
 
-#include <common.h>
 #include <log.h>
 #include <dm/devres.h>
 #include <linux/printk.h>
diff --git a/drivers/mtd/nand/raw/nand_ecc.c b/drivers/mtd/nand/raw/nand_ecc.c
index 2bc329be1a3b..0530ccb07226 100644
--- a/drivers/mtd/nand/raw/nand_ecc.c
+++ b/drivers/mtd/nand/raw/nand_ecc.c
@@ -22,7 +22,6 @@
  * this file might be covered by the GNU General Public License.
  */
 
-#include <common.h>
 
 #include <linux/errno.h>
 #include <linux/mtd/mtd.h>
diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
index be60d6d9d995..4f46378ffe10 100644
--- a/drivers/mtd/nand/raw/nand_ids.c
+++ b/drivers/mtd/nand/raw/nand_ids.c
@@ -6,7 +6,6 @@
  * published by the Free Software Foundation.
  *
  */
-#include <common.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/sizes.h>
 
diff --git a/drivers/mtd/nand/raw/nand_spl_load.c b/drivers/mtd/nand/raw/nand_spl_load.c
index 7ac9bf4d1206..87af675c1391 100644
--- a/drivers/mtd/nand/raw/nand_spl_load.c
+++ b/drivers/mtd/nand/raw/nand_spl_load.c
@@ -4,7 +4,7 @@
  * Heiko Schocher, DENX Software Engineering, hs@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <nand.h>
 
 /*
diff --git a/drivers/mtd/nand/raw/nand_spl_simple.c b/drivers/mtd/nand/raw/nand_spl_simple.c
index 80d6e0e1e4ef..c0956ab0e491 100644
--- a/drivers/mtd/nand/raw/nand_spl_simple.c
+++ b/drivers/mtd/nand/raw/nand_spl_simple.c
@@ -4,7 +4,7 @@
  * Stefan Roese, DENX Software Engineering, sr@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <nand.h>
 #include <system-constants.h>
 #include <asm/io.h>
diff --git a/drivers/mtd/nand/raw/nand_timings.c b/drivers/mtd/nand/raw/nand_timings.c
index e6aa79039131..c1bac1d01cc4 100644
--- a/drivers/mtd/nand/raw/nand_timings.c
+++ b/drivers/mtd/nand/raw/nand_timings.c
@@ -8,7 +8,6 @@
  * published by the Free Software Foundation.
  *
  */
-#include <common.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/mtd/rawnand.h>
diff --git a/drivers/mtd/nand/raw/nand_util.c b/drivers/mtd/nand/raw/nand_util.c
index 72cc24f40376..fda4239fa792 100644
--- a/drivers/mtd/nand/raw/nand_util.c
+++ b/drivers/mtd/nand/raw/nand_util.c
@@ -18,7 +18,6 @@
  * Copyright 2010 Freescale Semiconductor
  */
 
-#include <common.h>
 #include <command.h>
 #include <log.h>
 #include <watchdog.h>
diff --git a/drivers/mtd/nand/raw/omap_elm.c b/drivers/mtd/nand/raw/omap_elm.c
index 015ec9bc2de0..61751b9ae2db 100644
--- a/drivers/mtd/nand/raw/omap_elm.c
+++ b/drivers/mtd/nand/raw/omap_elm.c
@@ -12,7 +12,6 @@
  *    sets in uboot
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <linux/errno.h>
 #include <asm/arch/hardware.h>
diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/omap_gpmc.c
index 2f8fa7d73d21..92a92ad63a02 100644
--- a/drivers/mtd/nand/raw/omap_gpmc.c
+++ b/drivers/mtd/nand/raw/omap_gpmc.c
@@ -4,7 +4,7 @@
  * Rohit Choraria <rohitkc@ti.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <system-constants.h>
 #include <asm/io.h>
diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/pxa3xx_nand.c
index 1d9a6d107b17..17c5601bead0 100644
--- a/drivers/mtd/nand/raw/pxa3xx_nand.c
+++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
@@ -6,7 +6,6 @@
  * Copyright © 2006 Marvell International Ltd.
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <fdtdec.h>
 #include <nand.h>
diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/rockchip_nfc.c
index 088cc7fead24..f730e15d0410 100644
--- a/drivers/mtd/nand/raw/rockchip_nfc.c
+++ b/drivers/mtd/nand/raw/rockchip_nfc.c
@@ -5,7 +5,6 @@
  * Author: Yifeng Zhao <yifeng.zhao@rock-chips.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index d284b8cbb123..083ea4c5a74b 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_MTD
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 0b5b74dc242d..34197bb09a19 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -25,7 +25,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <malloc.h>
 #include <memalign.h>
diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index c9b8c78ed752..040138e25592 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -6,7 +6,6 @@
 
 #include <asm/arch/clock.h>
 #include <asm/io.h>
-#include <common.h>
 #include <config.h>
 #include <nand.h>
 #include <linux/bitops.h>
diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index 6086ecdfa3db..8285f87359e7 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -6,7 +6,6 @@
  * (C) Copyright 2006 DENX Software Engineering
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index d2363a0662e2..102659503689 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -21,7 +21,7 @@
  * - HW ECC: Only 24 and 32-bit error correction implemented.
  */
 
-#include <common.h>
+#include <config.h>
 #include <malloc.h>
 #include <dm/device_compat.h>
 #include <linux/printk.h>
diff --git a/drivers/mtd/nand/raw/zynq_nand.c b/drivers/mtd/nand/raw/zynq_nand.c
index bacaf13c570d..5f90171a6fe3 100644
--- a/drivers/mtd/nand/raw/zynq_nand.c
+++ b/drivers/mtd/nand/raw/zynq_nand.c
@@ -6,7 +6,6 @@
  * This driver is based on plat_nand.c and mxc_nand.c drivers
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <asm/io.h>
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 62c28aa422d2..ef50237f10e6 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -21,7 +21,6 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #else
-#include <common.h>
 #include <errno.h>
 #include <watchdog.h>
 #include <spi.h>
diff --git a/drivers/mtd/nvmxip/nvmxip-uclass.c b/drivers/mtd/nvmxip/nvmxip-uclass.c
index 9a316d1de397..95dfa58def17 100644
--- a/drivers/mtd/nvmxip/nvmxip-uclass.c
+++ b/drivers/mtd/nvmxip/nvmxip-uclass.c
@@ -6,7 +6,6 @@
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #if CONFIG_IS_ENABLED(SANDBOX64)
diff --git a/drivers/mtd/nvmxip/nvmxip.c b/drivers/mtd/nvmxip/nvmxip.c
index 0bd98d64275f..229938db3806 100644
--- a/drivers/mtd/nvmxip/nvmxip.c
+++ b/drivers/mtd/nvmxip/nvmxip.c
@@ -6,7 +6,6 @@
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <mapmem.h>
diff --git a/drivers/mtd/nvmxip/nvmxip_qspi.c b/drivers/mtd/nvmxip/nvmxip_qspi.c
index 4d7471118a4c..460887c7da34 100644
--- a/drivers/mtd/nvmxip/nvmxip_qspi.c
+++ b/drivers/mtd/nvmxip/nvmxip_qspi.c
@@ -6,7 +6,6 @@
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdt_support.h>
 #include <linux/errno.h>
diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index 762b01c1b0f0..edecb841338f 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -19,7 +19,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <common.h>
 #include <log.h>
 #include <watchdog.h>
 #include <dm/devres.h>
diff --git a/drivers/mtd/onenand/onenand_bbt.c b/drivers/mtd/onenand/onenand_bbt.c
index cc1e449f4a72..6af1cb2ec19a 100644
--- a/drivers/mtd/onenand/onenand_bbt.c
+++ b/drivers/mtd/onenand/onenand_bbt.c
@@ -14,7 +14,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <common.h>
 #include <log.h>
 #include <linux/compat.h>
 #include <linux/mtd/mtd.h>
diff --git a/drivers/mtd/onenand/onenand_spl.c b/drivers/mtd/onenand/onenand_spl.c
index 2699958a5de2..a9d54a243ade 100644
--- a/drivers/mtd/onenand/onenand_spl.c
+++ b/drivers/mtd/onenand/onenand_spl.c
@@ -7,9 +7,10 @@
  *	Kyungmin Park <kyungmin.park@samsung.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <linux/mtd/onenand_regs.h>
 #include <onenand_uboot.h>
 
diff --git a/drivers/mtd/onenand/onenand_uboot.c b/drivers/mtd/onenand/onenand_uboot.c
index ecacabefadcf..db0ac6c1fb8f 100644
--- a/drivers/mtd/onenand/onenand_uboot.c
+++ b/drivers/mtd/onenand/onenand_uboot.c
@@ -13,7 +13,7 @@
  * OneNAND initialization at U-Boot
  */
 
-#include <common.h>
+#include <config.h>
 #include <display_options.h>
 #include <linux/compat.h>
 #include <linux/mtd/mtd.h>
diff --git a/drivers/mtd/onenand/samsung.c b/drivers/mtd/onenand/samsung.c
index c415e5149a01..ccfdad4913e8 100644
--- a/drivers/mtd/onenand/samsung.c
+++ b/drivers/mtd/onenand/samsung.c
@@ -9,7 +9,6 @@
  *	Emulate the pseudo BufferRAM
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <linux/compat.h>
 #include <linux/mtd/mtd.h>
diff --git a/drivers/mtd/renesas_rpc_hf.c b/drivers/mtd/renesas_rpc_hf.c
index 979b64d4a2f6..8dcffde9aa39 100644
--- a/drivers/mtd/renesas_rpc_hf.c
+++ b/drivers/mtd/renesas_rpc_hf.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2017 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <asm/io.h>
 #include <clk.h>
diff --git a/drivers/mtd/spi/fsl_espi_spl.c b/drivers/mtd/spi/fsl_espi_spl.c
index cdbdbd6ea581..73eea922c33a 100644
--- a/drivers/mtd/spi/fsl_espi_spl.c
+++ b/drivers/mtd/spi/fsl_espi_spl.c
@@ -3,7 +3,7 @@
  * Copyright 2013 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <hang.h>
 #include <spi_flash.h>
diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
index 4fe547171a5f..2d5a16bf6a29 100644
--- a/drivers/mtd/spi/sandbox.c
+++ b/drivers/mtd/spi/sandbox.c
@@ -10,7 +10,6 @@
 
 #define LOG_CATEGORY UCLASS_SPI_FLASH
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/mtd/spi/sf-uclass.c b/drivers/mtd/spi/sf-uclass.c
index 2da0cf0dcf9f..a4d15bd64aa2 100644
--- a/drivers/mtd/spi/sf-uclass.c
+++ b/drivers/mtd/spi/sf-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_SPI_FLASH
 
-#include <common.h>
 #include <bootdev.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/mtd/spi/sf_bootdev.c b/drivers/mtd/spi/sf_bootdev.c
index d6b47b11ce45..017a74a3016f 100644
--- a/drivers/mtd/spi/sf_bootdev.c
+++ b/drivers/mtd/spi/sf_bootdev.c
@@ -5,7 +5,6 @@
  * Copyright 2022 Google LLC
  */
 
-#include <common.h>
 #include <bootdev.h>
 #include <bootflow.h>
 #include <bootmeth.h>
diff --git a/drivers/mtd/spi/sf_dataflash.c b/drivers/mtd/spi/sf_dataflash.c
index 6a0d953a7290..6db24189c8ea 100644
--- a/drivers/mtd/spi/sf_dataflash.c
+++ b/drivers/mtd/spi/sf_dataflash.c
@@ -6,7 +6,6 @@
  * Haikun Wang (haikun.wang@freescale.com)
  */
 
-#include <common.h>
 #include <display_options.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/mtd/spi/sf_mtd.c b/drivers/mtd/spi/sf_mtd.c
index 071b25ac67f2..7342f26d88e0 100644
--- a/drivers/mtd/spi/sf_mtd.c
+++ b/drivers/mtd/spi/sf_mtd.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2012-2014 Daniel Schwierzeck, daniel.schwierzeck@gmail.com
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <linux/errno.h>
 #include <linux/mtd/mtd.h>
diff --git a/drivers/mtd/spi/sf_probe.c b/drivers/mtd/spi/sf_probe.c
index de6516f1065b..7100b64bf22a 100644
--- a/drivers/mtd/spi/sf_probe.c
+++ b/drivers/mtd/spi/sf_probe.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2013 Jagannadha Sutradharudu Teki, Xilinx Inc.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <linux/mtd/spi-nor.h>
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index f86003ca8c06..982dd251150d 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -9,7 +9,6 @@
  * Synced from Linux v4.19
  */
 
-#include <common.h>
 #include <display_options.h>
 #include <log.h>
 #include <watchdog.h>
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 4e83b8c94c96..684206ea07dd 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
 #include <spi.h>
 #include <spi_flash.h>
 
diff --git a/drivers/mtd/spi/spi-nor-tiny.c b/drivers/mtd/spi/spi-nor-tiny.c
index 0719fe845ca9..5755c5eed297 100644
--- a/drivers/mtd/spi/spi-nor-tiny.c
+++ b/drivers/mtd/spi/spi-nor-tiny.c
@@ -9,7 +9,6 @@
  * Synced from Linux v4.19
  */
 
-#include <common.h>
 #include <log.h>
 #include <dm/device_compat.h>
 #include <linux/err.h>
diff --git a/drivers/mtd/stm32_flash.c b/drivers/mtd/stm32_flash.c
index 4523344ba6b0..ec83be6b51fd 100644
--- a/drivers/mtd/stm32_flash.c
+++ b/drivers/mtd/stm32_flash.c
@@ -4,7 +4,7 @@
  * Kamil Lulko, <kamil.lulko@gmail.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <flash.h>
 #include <asm/io.h>
 #include <asm/arch/stm32.h>
diff --git a/drivers/mtd/ubispl/ubispl.c b/drivers/mtd/ubispl/ubispl.c
index b58d8e8d5656..90a7c4c6f9e0 100644
--- a/drivers/mtd/ubispl/ubispl.c
+++ b/drivers/mtd/ubispl/ubispl.c
@@ -7,7 +7,6 @@
  * Copyright (c) International Business Machines Corp., 2006
  */
 
-#include <common.h>
 #include <errno.h>
 #include <linux/bug.h>
 #include <u-boot/crc.h>
-- 
2.34.1

