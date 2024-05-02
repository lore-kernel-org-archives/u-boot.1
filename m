Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D24C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2448F88C3A;
	Thu,  2 May 2024 03:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cAVomDzs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E9588BDF; Thu,  2 May 2024 03:32:21 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9A6D88C31
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-43ab76cac73so12861431cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613536; x=1715218336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZQWPUe64wC4rARzEGwUPa3Dtg381sXiIRYDZP0TVP8=;
 b=cAVomDzscdBz0HktHbbhYTuKSwElU1kI0Tq8zyMXUVM/msWU9WCHaq2hUjhdVX5t/g
 6fTSH+EUJmmycCII+UwRzcYZWPiTnljg4Sq/xqSFL6h/Y/HoK/Dwd1hj0W3Y2JOlBSOX
 pHDiZ4LKzt7RvrwZzC7ThsbdOyf4EMzgrgWAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613536; x=1715218336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LZQWPUe64wC4rARzEGwUPa3Dtg381sXiIRYDZP0TVP8=;
 b=OtcPcioDwWaF1Gns/MiIhGu5M6labI6uVMkVxFyrZcVg/jeaPrzLaMqMVWaMGNqJR+
 e5amtCJkMnewoW88dP69/r/Zbt/w/l9Dc5SE0fsxQBXNe0Psw2yAxlfLoQBwjwRXlXno
 +w6HTHM0+4vVkdwUZUT0kJe3sk45ZzGadimbBsoYMVB7akk2a6bT5kII3QgTXKptrtt3
 5b/3rsldvl7JTGG5OMdo1E978OvEUIMxEFQ665G6ondR73ncKXzTBcHuv3UDLQCOw4SZ
 Dbdj6mrj3oMdb45HP2NbSwa1giSwo9PZ0VNXtQNAlGaNZZSgGv1bHZ8B0k2mLIRMmmE4
 eZsw==
X-Gm-Message-State: AOJu0YxDaeHUzLCV5OZENKp+p8wDcnS0bn/oByuEcSzgNl/uozdeZ596
 pAbsb9qGNJkRGRweub7WLn8XbLaV+syBB+id+xyICl6fDeG7rk381QrpqOjfaI0hjRJru4j5fJZ
 2yVvWJtgO
X-Google-Smtp-Source: AGHT+IGsfIyrR6y0B7cIHIb+5dN0ayaxXRq4SsDdohRdxgxiHdF1hyKzs3JskGgqy207bj8mSZOIHQ==
X-Received: by 2002:ac8:5a49:0:b0:43a:f5db:88b8 with SMTP id
 o9-20020ac85a49000000b0043af5db88b8mr2527645qta.24.1714613536657; 
 Wed, 01 May 2024 18:32:16 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>,
 Johan Jonker <jbx6244@gmail.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 23/81] ddr: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:40 -0600
Message-Id: <20240502013138.2383421-23-trini@konsulko.com>
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
Cc: Stefan Roese <sr@denx.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jacky Bai <ping.bai@nxp.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/ddr/altera/sdram_agilex.c             | 1 -
 drivers/ddr/altera/sdram_arria10.c            | 1 -
 drivers/ddr/altera/sdram_gen5.c               | 1 -
 drivers/ddr/altera/sdram_n5x.c                | 1 -
 drivers/ddr/altera/sdram_s10.c                | 1 -
 drivers/ddr/altera/sdram_soc64.c              | 1 -
 drivers/ddr/altera/sequencer.c                | 2 +-
 drivers/ddr/altera/sequencer.h                | 2 ++
 drivers/ddr/fsl/arm_ddr_gen3.c                | 2 +-
 drivers/ddr/fsl/ctrl_regs.c                   | 3 ++-
 drivers/ddr/fsl/ddr1_dimm_params.c            | 1 -
 drivers/ddr/fsl/ddr2_dimm_params.c            | 2 +-
 drivers/ddr/fsl/ddr3_dimm_params.c            | 2 +-
 drivers/ddr/fsl/ddr4_dimm_params.c            | 2 +-
 drivers/ddr/fsl/fsl_ddr_gen4.c                | 2 +-
 drivers/ddr/fsl/fsl_mmdc.c                    | 2 +-
 drivers/ddr/fsl/interactive.c                 | 2 +-
 drivers/ddr/fsl/lc_common_dimm_params.c       | 1 -
 drivers/ddr/fsl/main.c                        | 2 +-
 drivers/ddr/fsl/mpc85xx_ddr_gen1.c            | 2 +-
 drivers/ddr/fsl/mpc85xx_ddr_gen2.c            | 4 ++--
 drivers/ddr/fsl/mpc85xx_ddr_gen3.c            | 3 ++-
 drivers/ddr/fsl/options.c                     | 5 ++++-
 drivers/ddr/fsl/util.c                        | 3 ++-
 drivers/ddr/imx/imx8m/ddr_init.c              | 1 -
 drivers/ddr/imx/imx8ulp/ddr_init.c            | 1 -
 drivers/ddr/imx/imx9/ddr_init.c               | 2 +-
 drivers/ddr/imx/phy/ddrphy_train.c            | 1 -
 drivers/ddr/imx/phy/ddrphy_utils.c            | 1 -
 drivers/ddr/imx/phy/helper.c                  | 1 -
 drivers/ddr/marvell/axp/ddr3_dfs.c            | 1 -
 drivers/ddr/marvell/axp/ddr3_dqs.c            | 1 -
 drivers/ddr/marvell/axp/ddr3_hw_training.c    | 1 -
 drivers/ddr/marvell/axp/ddr3_init.c           | 1 -
 drivers/ddr/marvell/axp/ddr3_pbs.c            | 1 -
 drivers/ddr/marvell/axp/ddr3_read_leveling.c  | 1 -
 drivers/ddr/marvell/axp/ddr3_sdram.c          | 1 -
 drivers/ddr/marvell/axp/ddr3_spd.c            | 1 -
 drivers/ddr/marvell/axp/ddr3_write_leveling.c | 1 -
 drivers/ddr/marvell/axp/xor.c                 | 1 -
 drivers/ddr/microchip/ddr2.c                  | 1 -
 41 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/drivers/ddr/altera/sdram_agilex.c b/drivers/ddr/altera/sdram_agilex.c
index 65ecdd022c43..7f2cccb6af20 100644
--- a/drivers/ddr/altera/sdram_agilex.c
+++ b/drivers/ddr/altera/sdram_agilex.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <div64.h>
diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index 8ef5fa4c481c..bd2af94bb0dd 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017 Intel Corporation <www.intel.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
index 34d2a2789ccf..46c53e7c7a34 100644
--- a/drivers/ddr/altera/sdram_gen5.c
+++ b/drivers/ddr/altera/sdram_gen5.c
@@ -2,7 +2,6 @@
 /*
  * Copyright Altera Corporation (C) 2014-2015
  */
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <div64.h>
diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
index d9039443b91c..db09986f64b4 100644
--- a/drivers/ddr/altera/sdram_n5x.c
+++ b/drivers/ddr/altera/sdram_n5x.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <clk.h>
 #include <div64.h>
 #include <dm.h>
diff --git a/drivers/ddr/altera/sdram_s10.c b/drivers/ddr/altera/sdram_s10.c
index 4d36fb453323..4ac4c79e0ac3 100644
--- a/drivers/ddr/altera/sdram_s10.c
+++ b/drivers/ddr/altera/sdram_s10.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
index 4716abfc9a8b..9e57c2ecfa4f 100644
--- a/drivers/ddr/altera/sdram_soc64.c
+++ b/drivers/ddr/altera/sdram_soc64.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/ddr/altera/sequencer.c b/drivers/ddr/altera/sequencer.c
index e402f2929ab7..7636e71a0a6b 100644
--- a/drivers/ddr/altera/sequencer.c
+++ b/drivers/ddr/altera/sequencer.c
@@ -3,8 +3,8 @@
  * Copyright Altera Corporation (C) 2012-2015
  */
 
-#include <common.h>
 #include <log.h>
+#include <linux/string.h>
 #include <asm/io.h>
 #include <asm/arch/sdram.h>
 #include <errno.h>
diff --git a/drivers/ddr/altera/sequencer.h b/drivers/ddr/altera/sequencer.h
index c72a683ffef2..618ba00da645 100644
--- a/drivers/ddr/altera/sequencer.h
+++ b/drivers/ddr/altera/sequencer.h
@@ -6,6 +6,8 @@
 #ifndef _SEQUENCER_H_
 #define _SEQUENCER_H_
 
+#include <config.h>
+
 #define RW_MGR_NUM_DM_PER_WRITE_GROUP (seq->rwcfg->mem_data_mask_width \
 	/ seq->rwcfg->mem_if_write_dqs_width)
 #define RW_MGR_NUM_TRUE_DM_PER_WRITE_GROUP ( \
diff --git a/drivers/ddr/fsl/arm_ddr_gen3.c b/drivers/ddr/fsl/arm_ddr_gen3.c
index 9dada5e11756..9f9aea804d97 100644
--- a/drivers/ddr/fsl/arm_ddr_gen3.c
+++ b/drivers/ddr/fsl/arm_ddr_gen3.c
@@ -5,7 +5,7 @@
  * Derived from mpc85xx_ddr_gen3.c, removed all workarounds
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <asm/io.h>
 #include <fsl_ddr_sdram.h>
diff --git a/drivers/ddr/fsl/ctrl_regs.c b/drivers/ddr/fsl/ctrl_regs.c
index 8f8c2c864c3f..9a25192c0798 100644
--- a/drivers/ddr/fsl/ctrl_regs.c
+++ b/drivers/ddr/fsl/ctrl_regs.c
@@ -10,12 +10,13 @@
  * Author: James Yang [at freescale.com]
  */
 
-#include <common.h>
+#include <config.h>
 #include <fsl_ddr_sdram.h>
 #include <fsl_errata.h>
 #include <fsl_ddr.h>
 #include <fsl_immap.h>
 #include <log.h>
+#include <linux/string.h>
 #include <asm/bitops.h>
 #include <asm/io.h>
 #if defined(CONFIG_FSL_LSCH2) || defined(CONFIG_FSL_LSCH3) || \
diff --git a/drivers/ddr/fsl/ddr1_dimm_params.c b/drivers/ddr/fsl/ddr1_dimm_params.c
index e5481eaa0ddd..cc87a95214d8 100644
--- a/drivers/ddr/fsl/ddr1_dimm_params.c
+++ b/drivers/ddr/fsl/ddr1_dimm_params.c
@@ -3,7 +3,6 @@
  * Copyright 2008 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <fsl_ddr_sdram.h>
 #include <log.h>
 #include <asm/bitops.h>
diff --git a/drivers/ddr/fsl/ddr2_dimm_params.c b/drivers/ddr/fsl/ddr2_dimm_params.c
index 3b78118a9d82..5674685a191e 100644
--- a/drivers/ddr/fsl/ddr2_dimm_params.c
+++ b/drivers/ddr/fsl/ddr2_dimm_params.c
@@ -3,9 +3,9 @@
  * Copyright 2008 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <fsl_ddr_sdram.h>
 #include <log.h>
+#include <linux/string.h>
 #include <asm/bitops.h>
 
 #include <fsl_ddr.h>
diff --git a/drivers/ddr/fsl/ddr3_dimm_params.c b/drivers/ddr/fsl/ddr3_dimm_params.c
index 1f8db90c45bd..c30ecdaafafd 100644
--- a/drivers/ddr/fsl/ddr3_dimm_params.c
+++ b/drivers/ddr/fsl/ddr3_dimm_params.c
@@ -8,7 +8,7 @@
  * JEDEC standard No.21-C 4_01_02_11R18.pdf
  */
 
-#include <common.h>
+#include <linux/string.h>
 #include <fsl_ddr_sdram.h>
 #include <log.h>
 
diff --git a/drivers/ddr/fsl/ddr4_dimm_params.c b/drivers/ddr/fsl/ddr4_dimm_params.c
index ea7916226287..75e3bfe08be7 100644
--- a/drivers/ddr/fsl/ddr4_dimm_params.c
+++ b/drivers/ddr/fsl/ddr4_dimm_params.c
@@ -10,10 +10,10 @@
  *
  */
 
-#include <common.h>
 #include <fsl_ddr_sdram.h>
 #include <log.h>
 #include <linux/bug.h>
+#include <linux/string.h>
 
 #include <fsl_ddr.h>
 
diff --git a/drivers/ddr/fsl/fsl_ddr_gen4.c b/drivers/ddr/fsl/fsl_ddr_gen4.c
index f8d1468a26f1..31c58d9a8e31 100644
--- a/drivers/ddr/fsl/fsl_ddr_gen4.c
+++ b/drivers/ddr/fsl/fsl_ddr_gen4.c
@@ -4,7 +4,7 @@
  * Copyright 2021 NXP
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <log.h>
 #include <asm/io.h>
diff --git a/drivers/ddr/fsl/fsl_mmdc.c b/drivers/ddr/fsl/fsl_mmdc.c
index 28f2219b2a43..7812b1b01caf 100644
--- a/drivers/ddr/fsl/fsl_mmdc.c
+++ b/drivers/ddr/fsl/fsl_mmdc.c
@@ -7,7 +7,7 @@
  * Generic driver for Freescale MMDC(Multi Mode DDR Controller).
  */
 
-#include <common.h>
+#include <config.h>
 #include <fsl_mmdc.h>
 #include <asm/io.h>
 #include <linux/delay.h>
diff --git a/drivers/ddr/fsl/interactive.c b/drivers/ddr/fsl/interactive.c
index eb2f06e8300a..94a5e447d56a 100644
--- a/drivers/ddr/fsl/interactive.c
+++ b/drivers/ddr/fsl/interactive.c
@@ -11,11 +11,11 @@
  *         York Sun [at freescale.com]
  */
 
-#include <common.h>
 #include <cli.h>
 #include <command.h>
 #include <env.h>
 #include <log.h>
+#include <vsprintf.h>
 #include <asm/bitops.h>
 #include <linux/ctype.h>
 #include <asm/types.h>
diff --git a/drivers/ddr/fsl/lc_common_dimm_params.c b/drivers/ddr/fsl/lc_common_dimm_params.c
index 5e4ad56f0714..aaf9800b3723 100644
--- a/drivers/ddr/fsl/lc_common_dimm_params.c
+++ b/drivers/ddr/fsl/lc_common_dimm_params.c
@@ -4,7 +4,6 @@
  * Copyright 2017-2021 NXP Semiconductor
  */
 
-#include <common.h>
 #include <fsl_ddr_sdram.h>
 #include <log.h>
 #include <asm/bitops.h>
diff --git a/drivers/ddr/fsl/main.c b/drivers/ddr/fsl/main.c
index cd332718b640..31091bb44952 100644
--- a/drivers/ddr/fsl/main.c
+++ b/drivers/ddr/fsl/main.c
@@ -10,7 +10,7 @@
  * Author: James Yang [at freescale.com]
  */
 
-#include <common.h>
+#include <config.h>
 #include <display_options.h>
 #include <dm.h>
 #include <i2c.h>
diff --git a/drivers/ddr/fsl/mpc85xx_ddr_gen1.c b/drivers/ddr/fsl/mpc85xx_ddr_gen1.c
index 16186bdbae72..a8520754006a 100644
--- a/drivers/ddr/fsl/mpc85xx_ddr_gen1.c
+++ b/drivers/ddr/fsl/mpc85xx_ddr_gen1.c
@@ -3,7 +3,7 @@
  * Copyright 2008 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <asm/io.h>
 #include <fsl_ddr_sdram.h>
diff --git a/drivers/ddr/fsl/mpc85xx_ddr_gen2.c b/drivers/ddr/fsl/mpc85xx_ddr_gen2.c
index b830e7cbd141..00b4b376dd45 100644
--- a/drivers/ddr/fsl/mpc85xx_ddr_gen2.c
+++ b/drivers/ddr/fsl/mpc85xx_ddr_gen2.c
@@ -3,9 +3,9 @@
  * Copyright 2008-2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
-#include <asm/processor.h>
+#include <asm/ppc.h>
 #include <fsl_ddr_sdram.h>
 #include <linux/delay.h>
 
diff --git a/drivers/ddr/fsl/mpc85xx_ddr_gen3.c b/drivers/ddr/fsl/mpc85xx_ddr_gen3.c
index 1c4a1cae4df4..b0a61fa2b416 100644
--- a/drivers/ddr/fsl/mpc85xx_ddr_gen3.c
+++ b/drivers/ddr/fsl/mpc85xx_ddr_gen3.c
@@ -3,9 +3,10 @@
  * Copyright 2008-2020 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <asm/io.h>
+#include <asm/ppc.h>
 #include <fsl_ddr_sdram.h>
 #include <asm/processor.h>
 #include <linux/delay.h>
diff --git a/drivers/ddr/fsl/options.c b/drivers/ddr/fsl/options.c
index 7cff82345847..852a5d0eca41 100644
--- a/drivers/ddr/fsl/options.c
+++ b/drivers/ddr/fsl/options.c
@@ -4,16 +4,19 @@
  * Copyright 2017-2018 NXP Semiconductor
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <hwconfig.h>
 #include <fsl_ddr_sdram.h>
 #include <log.h>
+#include <vsprintf.h>
 
 #include <fsl_ddr.h>
 #if defined(CONFIG_FSL_LSCH2) || defined(CONFIG_FSL_LSCH3) || \
 	defined(CONFIG_ARM)
 #include <asm/arch/clock.h>
+#else
+#include <asm/ppc.h>
 #endif
 
 /*
diff --git a/drivers/ddr/fsl/util.c b/drivers/ddr/fsl/util.c
index 60051392e713..0a73170e4183 100644
--- a/drivers/ddr/fsl/util.c
+++ b/drivers/ddr/fsl/util.c
@@ -4,9 +4,10 @@
  * Copyright 2021 NXP
  */
 
-#include <common.h>
+#include <config.h>
 #ifdef CONFIG_PPC
 #include <asm/fsl_law.h>
+#include <asm/ppc.h>
 #endif
 #include <div64.h>
 #include <linux/delay.h>
diff --git a/drivers/ddr/imx/imx8m/ddr_init.c b/drivers/ddr/imx/imx8m/ddr_init.c
index 52a4aa632304..e9209ce8b61d 100644
--- a/drivers/ddr/imx/imx8m/ddr_init.c
+++ b/drivers/ddr/imx/imx8m/ddr_init.c
@@ -3,7 +3,6 @@
  * Copyright 2018-2019 NXP
  */
 
-#include <common.h>
 #include <errno.h>
 #include <log.h>
 #include <asm/io.h>
diff --git a/drivers/ddr/imx/imx8ulp/ddr_init.c b/drivers/ddr/imx/imx8ulp/ddr_init.c
index c362a2da338b..172e260a55d9 100644
--- a/drivers/ddr/imx/imx8ulp/ddr_init.c
+++ b/drivers/ddr/imx/imx8ulp/ddr_init.c
@@ -2,7 +2,6 @@
 /*
  * Copyright 2021 NXP
  */
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/ddr.h>
diff --git a/drivers/ddr/imx/imx9/ddr_init.c b/drivers/ddr/imx/imx9/ddr_init.c
index 7a333880e6b6..5b0ad773875d 100644
--- a/drivers/ddr/imx/imx9/ddr_init.c
+++ b/drivers/ddr/imx/imx9/ddr_init.c
@@ -3,7 +3,6 @@
  * Copyright 2022 NXP
  */
 
-#include <common.h>
 #include <errno.h>
 #include <log.h>
 #include <asm/io.h>
@@ -11,6 +10,7 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 static unsigned int g_cdd_rr_max[4];
 static unsigned int g_cdd_rw_max[4];
diff --git a/drivers/ddr/imx/phy/ddrphy_train.c b/drivers/ddr/imx/phy/ddrphy_train.c
index cd905f952c64..ccc10df18452 100644
--- a/drivers/ddr/imx/phy/ddrphy_train.c
+++ b/drivers/ddr/imx/phy/ddrphy_train.c
@@ -3,7 +3,6 @@
  * Copyright 2018 NXP
  */
 
-#include <common.h>
 #include <log.h>
 #include <linux/kernel.h>
 #include <asm/arch/ddr.h>
diff --git a/drivers/ddr/imx/phy/ddrphy_utils.c b/drivers/ddr/imx/phy/ddrphy_utils.c
index 45e1a70dbd44..cf5bdad7abe7 100644
--- a/drivers/ddr/imx/phy/ddrphy_utils.c
+++ b/drivers/ddr/imx/phy/ddrphy_utils.c
@@ -3,7 +3,6 @@
  * Copyright 2018 NXP
  */
 
-#include <common.h>
 #include <errno.h>
 #include <log.h>
 #include <asm/io.h>
diff --git a/drivers/ddr/imx/phy/helper.c b/drivers/ddr/imx/phy/helper.c
index b9b2403012d9..c1fc800f191b 100644
--- a/drivers/ddr/imx/phy/helper.c
+++ b/drivers/ddr/imx/phy/helper.c
@@ -3,7 +3,6 @@
  * Copyright 2018 NXP
  */
 
-#include <common.h>
 #include <binman_sym.h>
 #include <log.h>
 #include <spl.h>
diff --git a/drivers/ddr/marvell/axp/ddr3_dfs.c b/drivers/ddr/marvell/axp/ddr3_dfs.c
index 2a4596680b19..985835ec9235 100644
--- a/drivers/ddr/marvell/axp/ddr3_dfs.c
+++ b/drivers/ddr/marvell/axp/ddr3_dfs.c
@@ -3,7 +3,6 @@
  * Copyright (C) Marvell International Ltd. and its affiliates
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <spl.h>
 #include <asm/io.h>
diff --git a/drivers/ddr/marvell/axp/ddr3_dqs.c b/drivers/ddr/marvell/axp/ddr3_dqs.c
index 0db94212b90f..bda0d7ec4735 100644
--- a/drivers/ddr/marvell/axp/ddr3_dqs.c
+++ b/drivers/ddr/marvell/axp/ddr3_dqs.c
@@ -3,7 +3,6 @@
  * Copyright (C) Marvell International Ltd. and its affiliates
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <log.h>
 #include <spl.h>
diff --git a/drivers/ddr/marvell/axp/ddr3_hw_training.c b/drivers/ddr/marvell/axp/ddr3_hw_training.c
index 35d98faf58f3..bb3e1be1f4c6 100644
--- a/drivers/ddr/marvell/axp/ddr3_hw_training.c
+++ b/drivers/ddr/marvell/axp/ddr3_hw_training.c
@@ -3,7 +3,6 @@
  * Copyright (C) Marvell International Ltd. and its affiliates
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <log.h>
 #include <spl.h>
diff --git a/drivers/ddr/marvell/axp/ddr3_init.c b/drivers/ddr/marvell/axp/ddr3_init.c
index a9dcb74cecb7..23c6d119f61e 100644
--- a/drivers/ddr/marvell/axp/ddr3_init.c
+++ b/drivers/ddr/marvell/axp/ddr3_init.c
@@ -3,7 +3,6 @@
  * Copyright (C) Marvell International Ltd. and its affiliates
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <log.h>
 #include <spl.h>
diff --git a/drivers/ddr/marvell/axp/ddr3_pbs.c b/drivers/ddr/marvell/axp/ddr3_pbs.c
index 069a42fbf5ed..2322900185d3 100644
--- a/drivers/ddr/marvell/axp/ddr3_pbs.c
+++ b/drivers/ddr/marvell/axp/ddr3_pbs.c
@@ -3,7 +3,6 @@
  * Copyright (C) Marvell International Ltd. and its affiliates
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <spl.h>
 #include <asm/io.h>
diff --git a/drivers/ddr/marvell/axp/ddr3_read_leveling.c b/drivers/ddr/marvell/axp/ddr3_read_leveling.c
index 30a5c3548857..db7003f72caf 100644
--- a/drivers/ddr/marvell/axp/ddr3_read_leveling.c
+++ b/drivers/ddr/marvell/axp/ddr3_read_leveling.c
@@ -3,7 +3,6 @@
  * Copyright (C) Marvell International Ltd. and its affiliates
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <log.h>
 #include <spl.h>
diff --git a/drivers/ddr/marvell/axp/ddr3_sdram.c b/drivers/ddr/marvell/axp/ddr3_sdram.c
index 0b150b20f3a1..f8fee2623d04 100644
--- a/drivers/ddr/marvell/axp/ddr3_sdram.c
+++ b/drivers/ddr/marvell/axp/ddr3_sdram.c
@@ -3,7 +3,6 @@
  * Copyright (C) Marvell International Ltd. and its affiliates
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <spl.h>
 #include <asm/io.h>
diff --git a/drivers/ddr/marvell/axp/ddr3_spd.c b/drivers/ddr/marvell/axp/ddr3_spd.c
index 4763403c1278..c169a8ea16b4 100644
--- a/drivers/ddr/marvell/axp/ddr3_spd.c
+++ b/drivers/ddr/marvell/axp/ddr3_spd.c
@@ -3,7 +3,6 @@
  * Copyright (C) Marvell International Ltd. and its affiliates
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <spl.h>
 #include <asm/io.h>
diff --git a/drivers/ddr/marvell/axp/ddr3_write_leveling.c b/drivers/ddr/marvell/axp/ddr3_write_leveling.c
index d4add4477745..ea7bac56d0ed 100644
--- a/drivers/ddr/marvell/axp/ddr3_write_leveling.c
+++ b/drivers/ddr/marvell/axp/ddr3_write_leveling.c
@@ -3,7 +3,6 @@
  * Copyright (C) Marvell International Ltd. and its affiliates
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <log.h>
 #include <spl.h>
diff --git a/drivers/ddr/marvell/axp/xor.c b/drivers/ddr/marvell/axp/xor.c
index 76aea96682c7..6ecacfeb9336 100644
--- a/drivers/ddr/marvell/axp/xor.c
+++ b/drivers/ddr/marvell/axp/xor.c
@@ -3,7 +3,6 @@
  * Copyright (C) Marvell International Ltd. and its affiliates
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <log.h>
 #include <spl.h>
diff --git a/drivers/ddr/microchip/ddr2.c b/drivers/ddr/microchip/ddr2.c
index 149b6071cfde..bfba5d245c68 100644
--- a/drivers/ddr/microchip/ddr2.c
+++ b/drivers/ddr/microchip/ddr2.c
@@ -3,7 +3,6 @@
  * (c) 2015 Paul Thacker <paul.thacker@microchip.com>
  *
  */
-#include <common.h>
 #include <wait_bit.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
-- 
2.34.1

