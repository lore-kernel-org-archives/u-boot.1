Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7671C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43A7488C6C;
	Thu,  2 May 2024 03:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hTpevprC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7785E88C72; Thu,  2 May 2024 03:33:31 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA3EC88BEE
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-436ee76c3b8so57812931cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613606; x=1715218406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1grXJo5AhkpReuUtFYfGikfQvgGdt7iPkIaFd62oH8=;
 b=hTpevprCay7a/5/k0woXTC5U5kNzY+N2kDz750bmmskXVCo4Gn0Ot+lfPscoI6q8aK
 eivgEVdcTYd/Vo4MnTqJQlNZYXwiDuQGHaC5Su+o7CDj9Aw20eMDIAbQ/i2iwFjjyB+n
 m+LowPHhi1lv3wCAKYddEveHGhkUq6wLAQoGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613606; x=1715218406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1grXJo5AhkpReuUtFYfGikfQvgGdt7iPkIaFd62oH8=;
 b=W/SJPMBMWK/kTvwQVoSn1HfZ+iY3Sk7omOJwhRZtYOMBIrDb5fbNvm8Arphm891gz2
 NxQqh0lQZJPfC/plDICNV7szyVFNONIzPQBFlqyLa4dVucJ9zCEHrnPBtv8ZPGACXnPz
 ylCElqjDY/ccwEns6/QSfO1/VhoKxgfCkRwR1KTLB66QgAduWYMhiuf6l8VgxIeRXJoS
 UA3ySFY5AFwn5h936tNQZ5bWaZLlQYpaOFfV5durjve+omvW2x+gKT2xS/VTKY5x3mkb
 jgCStVVx+OEzErVbRD2szRrExZw+uug/f8NptWentXt8TXzvn7KCbTvtk2FlVN/+onVg
 syMA==
X-Gm-Message-State: AOJu0Yws5kMwa4Bzwk9fp0VkmQhe4sIxmXFS2r1Scng6ilE8gxurqaRQ
 TpR5j+WLXaIAUZhXbSIEDr2DeiAHLF8yKmNP9BLBc41J0MDKW/xT/tRqcooB9pUUpiSyCBONVvi
 Q1n8BleoN
X-Google-Smtp-Source: AGHT+IFSZ3WAt5Pn9fg2BeoHVnmrrIwTiWQrJr3g8mGGnWSNCwLaB7frMP1Mpb4/f/QooHoLl3LdjQ==
X-Received: by 2002:a05:622a:d4:b0:43a:dd5b:d306 with SMTP id
 p20-20020a05622a00d400b0043add5bd306mr4790034qtw.55.1714613606369; 
 Wed, 01 May 2024 18:33:26 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Mario Six <mario.six@gdsys.cc>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH 54/81] ram: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:11 -0600
Message-Id: <20240502013138.2383421-54-trini@konsulko.com>
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
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: Yanhong Wang <yanhong.wang@starfivetech.com>
Cc: Andre Przywara <andre.przywara@arm.com>
---
 drivers/ram/aspeed/sdram_ast2500.c          | 2 +-
 drivers/ram/aspeed/sdram_ast2600.c          | 2 +-
 drivers/ram/bmips_ram.c                     | 1 -
 drivers/ram/cadence/ddr_ctrl.c              | 1 -
 drivers/ram/imxrt_sdram.c                   | 1 -
 drivers/ram/k3-am654-ddrss.c                | 1 -
 drivers/ram/k3-ddrss/k3-ddrss.c             | 1 -
 drivers/ram/mediatek/ddr3-mt7629.c          | 2 +-
 drivers/ram/mpc83xx_sdram.c                 | 1 -
 drivers/ram/ram-uclass.c                    | 1 -
 drivers/ram/renesas/rzn1/ddr_async.c        | 1 -
 drivers/ram/rockchip/dmc-rk3368.c           | 2 +-
 drivers/ram/rockchip/sdram_common.c         | 2 +-
 drivers/ram/rockchip/sdram_pctl_px30.c      | 1 -
 drivers/ram/rockchip/sdram_phy_px30.c       | 1 -
 drivers/ram/rockchip/sdram_px30.c           | 2 +-
 drivers/ram/rockchip/sdram_rk3066.c         | 2 +-
 drivers/ram/rockchip/sdram_rk3128.c         | 2 +-
 drivers/ram/rockchip/sdram_rk3188.c         | 2 +-
 drivers/ram/rockchip/sdram_rk322x.c         | 2 +-
 drivers/ram/rockchip/sdram_rk3288.c         | 2 +-
 drivers/ram/rockchip/sdram_rk3308.c         | 2 +-
 drivers/ram/rockchip/sdram_rk3328.c         | 2 +-
 drivers/ram/rockchip/sdram_rk3399.c         | 2 +-
 drivers/ram/rockchip/sdram_rk3568.c         | 2 +-
 drivers/ram/rockchip/sdram_rk3588.c         | 2 +-
 drivers/ram/rockchip/sdram_rv1126.c         | 2 +-
 drivers/ram/sandbox_ram.c                   | 1 -
 drivers/ram/sifive/sifive_ddr.c             | 1 -
 drivers/ram/starfive/ddrcsr_boot.c          | 1 -
 drivers/ram/starfive/ddrphy_start.c         | 1 -
 drivers/ram/starfive/ddrphy_train.c         | 2 +-
 drivers/ram/starfive/ddrphy_utils.c         | 2 +-
 drivers/ram/starfive/starfive_ddr.c         | 1 -
 drivers/ram/starfive/starfive_ddr.h         | 2 ++
 drivers/ram/stm32_sdram.c                   | 1 -
 drivers/ram/stm32mp1/stm32mp1_ddr.c         | 1 -
 drivers/ram/stm32mp1/stm32mp1_interactive.c | 1 -
 drivers/ram/stm32mp1/stm32mp1_ram.c         | 1 -
 drivers/ram/stm32mp1/stm32mp1_tests.c       | 1 -
 drivers/ram/sunxi/dram_sun20i_d1.c          | 2 +-
 41 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/drivers/ram/aspeed/sdram_ast2500.c b/drivers/ram/aspeed/sdram_ast2500.c
index dc466a88e712..0d6ab79f96fc 100644
--- a/drivers/ram/aspeed/sdram_ast2500.c
+++ b/drivers/ram/aspeed/sdram_ast2500.c
@@ -5,7 +5,7 @@
  * Copyright 2016 Google, Inc
  */
 
-#include <common.h>
+#include <config.h>
 #include <clk.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/ram/aspeed/sdram_ast2600.c b/drivers/ram/aspeed/sdram_ast2600.c
index d463933363ee..55e80fba3dc0 100644
--- a/drivers/ram/aspeed/sdram_ast2600.c
+++ b/drivers/ram/aspeed/sdram_ast2600.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) ASPEED Technology Inc.
  */
-#include <common.h>
+#include <config.h>
 #include <clk.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/ram/bmips_ram.c b/drivers/ram/bmips_ram.c
index 98045248ecfb..760bebdbba04 100644
--- a/drivers/ram/bmips_ram.c
+++ b/drivers/ram/bmips_ram.c
@@ -7,7 +7,6 @@
  *	Copyright (C) 2009 Florian Fainelli <florian@openwrt.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <init.h>
diff --git a/drivers/ram/cadence/ddr_ctrl.c b/drivers/ram/cadence/ddr_ctrl.c
index 3e5959a84a37..0fa60e766a7e 100644
--- a/drivers/ram/cadence/ddr_ctrl.c
+++ b/drivers/ram/cadence/ddr_ctrl.c
@@ -24,7 +24,6 @@
  * bandwidth allocated to each AXI slave can be set.
  */
 
-#include <common.h>
 #include <linux/delay.h>
 #include <linux/sizes.h>
 #include <asm/io.h>
diff --git a/drivers/ram/imxrt_sdram.c b/drivers/ram/imxrt_sdram.c
index 6a15242c20cc..3df106c9b79a 100644
--- a/drivers/ram/imxrt_sdram.c
+++ b/drivers/ram/imxrt_sdram.c
@@ -4,7 +4,6 @@
  * Author(s): Giulio Benetti <giulio.benetti@benettiengineering.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/ram/k3-am654-ddrss.c b/drivers/ram/k3-am654-ddrss.c
index cff8ffc89295..21ff9d761e1b 100644
--- a/drivers/ram/k3-am654-ddrss.c
+++ b/drivers/ram/k3-am654-ddrss.c
@@ -6,7 +6,6 @@
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index a5c9b82cf1da..525b6d5b79fc 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
 #include <config.h>
 #include <clk.h>
 #include <div64.h>
diff --git a/drivers/ram/mediatek/ddr3-mt7629.c b/drivers/ram/mediatek/ddr3-mt7629.c
index f65fcf179cf6..c27c4593b9d9 100644
--- a/drivers/ram/mediatek/ddr3-mt7629.c
+++ b/drivers/ram/mediatek/ddr3-mt7629.c
@@ -8,7 +8,7 @@
  */
 
 #include <clk.h>
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <ram.h>
 #include <asm/io.h>
diff --git a/drivers/ram/mpc83xx_sdram.c b/drivers/ram/mpc83xx_sdram.c
index 11676d4fae7e..28a663289a23 100644
--- a/drivers/ram/mpc83xx_sdram.c
+++ b/drivers/ram/mpc83xx_sdram.c
@@ -4,7 +4,6 @@
  * Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <log.h>
diff --git a/drivers/ram/ram-uclass.c b/drivers/ram/ram-uclass.c
index 4e21240fd4cb..a33d583cc448 100644
--- a/drivers/ram/ram-uclass.c
+++ b/drivers/ram/ram-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_RAM
 
-#include <common.h>
 #include <ram.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/ram/renesas/rzn1/ddr_async.c b/drivers/ram/renesas/rzn1/ddr_async.c
index 7a81497bc92b..4d470aae1914 100644
--- a/drivers/ram/renesas/rzn1/ddr_async.c
+++ b/drivers/ram/renesas/rzn1/ddr_async.c
@@ -7,7 +7,6 @@
  *
  * Copyright (C) 2015 Renesas Electronics Europe Ltd
  */
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/ram/rockchip/dmc-rk3368.c b/drivers/ram/rockchip/dmc-rk3368.c
index 5279bf0a1548..42114a5aa917 100644
--- a/drivers/ram/rockchip/dmc-rk3368.c
+++ b/drivers/ram/rockchip/dmc-rk3368.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
  */
 
-#include <common.h>
+#include <config.h>
 #include <clk.h>
 #include <dm.h>
 #include <hang.h>
diff --git a/drivers/ram/rockchip/sdram_common.c b/drivers/ram/rockchip/sdram_common.c
index 60fc90d0a5c0..b7a8fce607c8 100644
--- a/drivers/ram/rockchip/sdram_common.c
+++ b/drivers/ram/rockchip/sdram_common.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2018 Rockchip Electronics Co., Ltd.
  */
 
-#include <common.h>
+#include <config.h>
 #include <debug_uart.h>
 #include <ram.h>
 #include <asm/io.h>
diff --git a/drivers/ram/rockchip/sdram_pctl_px30.c b/drivers/ram/rockchip/sdram_pctl_px30.c
index e5c80fb83b3f..3ec98af536e8 100644
--- a/drivers/ram/rockchip/sdram_pctl_px30.c
+++ b/drivers/ram/rockchip/sdram_pctl_px30.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2018 Rockchip Electronics Co., Ltd.
  */
 
-#include <common.h>
 #include <ram.h>
 #include <asm/io.h>
 #include <asm/arch-rockchip/sdram.h>
diff --git a/drivers/ram/rockchip/sdram_phy_px30.c b/drivers/ram/rockchip/sdram_phy_px30.c
index f7f6de1ba98b..5416eef38788 100644
--- a/drivers/ram/rockchip/sdram_phy_px30.c
+++ b/drivers/ram/rockchip/sdram_phy_px30.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2018 Rockchip Electronics Co., Ltd.
  */
 
-#include <common.h>
 #include <ram.h>
 #include <asm/io.h>
 #include <asm/arch-rockchip/sdram.h>
diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
index 21498e89570f..37e621205047 100644
--- a/drivers/ram/rockchip/sdram_px30.c
+++ b/drivers/ram/rockchip/sdram_px30.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2018 Rockchip Electronics Co., Ltd.
  */
 
-#include <common.h>
+#include <config.h>
 #include <debug_uart.h>
 #include <dm.h>
 #include <init.h>
diff --git a/drivers/ram/rockchip/sdram_rk3066.c b/drivers/ram/rockchip/sdram_rk3066.c
index 562cf544c909..a280e2d9fa1d 100644
--- a/drivers/ram/rockchip/sdram_rk3066.c
+++ b/drivers/ram/rockchip/sdram_rk3066.c
@@ -6,7 +6,7 @@
  * Adapted from the very similar rk3188 ddr init.
  */
 
-#include <common.h>
+#include <config.h>
 #include <clk.h>
 #include <dm.h>
 #include <dt-structs.h>
diff --git a/drivers/ram/rockchip/sdram_rk3128.c b/drivers/ram/rockchip/sdram_rk3128.c
index ded65393806e..66611f80b2da 100644
--- a/drivers/ram/rockchip/sdram_rk3128.c
+++ b/drivers/ram/rockchip/sdram_rk3128.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2017 Rockchip Electronics Co., Ltd.
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <log.h>
 #include <ram.h>
diff --git a/drivers/ram/rockchip/sdram_rk3188.c b/drivers/ram/rockchip/sdram_rk3188.c
index e1b28c6e5933..618bce5c9f49 100644
--- a/drivers/ram/rockchip/sdram_rk3188.c
+++ b/drivers/ram/rockchip/sdram_rk3188.c
@@ -6,7 +6,7 @@
  * Adapted from the very similar rk3288 ddr init.
  */
 
-#include <common.h>
+#include <config.h>
 #include <clk.h>
 #include <dm.h>
 #include <dt-structs.h>
diff --git a/drivers/ram/rockchip/sdram_rk322x.c b/drivers/ram/rockchip/sdram_rk322x.c
index 5fc23c11193f..a48a50911844 100644
--- a/drivers/ram/rockchip/sdram_rk322x.c
+++ b/drivers/ram/rockchip/sdram_rk322x.c
@@ -2,7 +2,7 @@
 /*
  * (C) Copyright 2017 Rockchip Electronics Co., Ltd
  */
-#include <common.h>
+#include <config.h>
 #include <clk.h>
 #include <dm.h>
 #include <dt-structs.h>
diff --git a/drivers/ram/rockchip/sdram_rk3288.c b/drivers/ram/rockchip/sdram_rk3288.c
index 242d564a7d26..c9f61e933e9a 100644
--- a/drivers/ram/rockchip/sdram_rk3288.c
+++ b/drivers/ram/rockchip/sdram_rk3288.c
@@ -6,7 +6,7 @@
  * Adapted from coreboot.
  */
 
-#include <common.h>
+#include <config.h>
 #include <clk.h>
 #include <dm.h>
 #include <dt-structs.h>
diff --git a/drivers/ram/rockchip/sdram_rk3308.c b/drivers/ram/rockchip/sdram_rk3308.c
index 264366291cf8..8071997f8d86 100644
--- a/drivers/ram/rockchip/sdram_rk3308.c
+++ b/drivers/ram/rockchip/sdram_rk3308.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2019 Rockchip Electronics Co., Ltd.
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <ram.h>
 #include <syscon.h>
diff --git a/drivers/ram/rockchip/sdram_rk3328.c b/drivers/ram/rockchip/sdram_rk3328.c
index b5ca8ca436f5..99690d67a501 100644
--- a/drivers/ram/rockchip/sdram_rk3328.c
+++ b/drivers/ram/rockchip/sdram_rk3328.c
@@ -2,7 +2,7 @@
 /*
  * (C) Copyright 2017 Rockchip Electronics Co., Ltd.
  */
-#include <common.h>
+#include <config.h>
 #include <clk.h>
 #include <debug_uart.h>
 #include <dm.h>
diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 02cc4a38cf0b..ef9a1824b2b3 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -5,7 +5,7 @@
  * Adapted from coreboot.
  */
 
-#include <common.h>
+#include <config.h>
 #include <clk.h>
 #include <dm.h>
 #include <dt-structs.h>
diff --git a/drivers/ram/rockchip/sdram_rk3568.c b/drivers/ram/rockchip/sdram_rk3568.c
index f661615c1b91..a252d5c70106 100644
--- a/drivers/ram/rockchip/sdram_rk3568.c
+++ b/drivers/ram/rockchip/sdram_rk3568.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2021 Rockchip Electronics Co., Ltd.
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <ram.h>
 #include <syscon.h>
diff --git a/drivers/ram/rockchip/sdram_rk3588.c b/drivers/ram/rockchip/sdram_rk3588.c
index cf56e2a94121..a144b432d76f 100644
--- a/drivers/ram/rockchip/sdram_rk3588.c
+++ b/drivers/ram/rockchip/sdram_rk3588.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2021 Rockchip Electronics Co., Ltd.
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <ram.h>
 #include <syscon.h>
diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
index 849e15a91932..4fbb088a8d98 100644
--- a/drivers/ram/rockchip/sdram_rv1126.c
+++ b/drivers/ram/rockchip/sdram_rv1126.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
  */
 
-#include <common.h>
+#include <config.h>
 #include <debug_uart.h>
 #include <dm.h>
 #include <ram.h>
diff --git a/drivers/ram/sandbox_ram.c b/drivers/ram/sandbox_ram.c
index 910dce623e90..2097da565322 100644
--- a/drivers/ram/sandbox_ram.c
+++ b/drivers/ram/sandbox_ram.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <ram.h>
diff --git a/drivers/ram/sifive/sifive_ddr.c b/drivers/ram/sifive/sifive_ddr.c
index 4bd69a62be2b..bd2f438d7271 100644
--- a/drivers/ram/sifive/sifive_ddr.c
+++ b/drivers/ram/sifive/sifive_ddr.c
@@ -6,7 +6,6 @@
  *   Pragnesh Patel <pragnesh.patel@sifive.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <init.h>
diff --git a/drivers/ram/starfive/ddrcsr_boot.c b/drivers/ram/starfive/ddrcsr_boot.c
index f2dd55f74a08..6764b3ed5cc9 100644
--- a/drivers/ram/starfive/ddrcsr_boot.c
+++ b/drivers/ram/starfive/ddrcsr_boot.c
@@ -4,7 +4,6 @@
  * Author: Yanhong Wang<yanhong.wang@starfivetech.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/regs.h>
 #include <linux/delay.h>
diff --git a/drivers/ram/starfive/ddrphy_start.c b/drivers/ram/starfive/ddrphy_start.c
index 479b6ef10418..efe3f8a181a5 100644
--- a/drivers/ram/starfive/ddrphy_start.c
+++ b/drivers/ram/starfive/ddrphy_start.c
@@ -4,7 +4,6 @@
  * Author: Yanhong Wang<yanhong.wang@starfivetech.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 
 #include "starfive_ddr.h"
diff --git a/drivers/ram/starfive/ddrphy_train.c b/drivers/ram/starfive/ddrphy_train.c
index 0740f49be5bb..0aff1e8727ef 100644
--- a/drivers/ram/starfive/ddrphy_train.c
+++ b/drivers/ram/starfive/ddrphy_train.c
@@ -4,7 +4,7 @@
  * Author: Yanhong Wang<yanhong.wang@starfivetech.com>
  */
 
-#include <common.h>
+#include <linux/kernel.h>
 #include <asm/io.h>
 
 static const u32 ddr_train_data[] = {
diff --git a/drivers/ram/starfive/ddrphy_utils.c b/drivers/ram/starfive/ddrphy_utils.c
index 1c9fe0a78465..d6dd6ee7a859 100644
--- a/drivers/ram/starfive/ddrphy_utils.c
+++ b/drivers/ram/starfive/ddrphy_utils.c
@@ -4,7 +4,7 @@
  * Author: Yanhong Wang<yanhong.wang@starfivetech.com>
  */
 
-#include <common.h>
+#include <linux/kernel.h>
 #include <asm/io.h>
 
 static const  u32 ddr_phy_data[] = {
diff --git a/drivers/ram/starfive/starfive_ddr.c b/drivers/ram/starfive/starfive_ddr.c
index a0a3d6b33dc2..b31ed3bcf617 100644
--- a/drivers/ram/starfive/starfive_ddr.c
+++ b/drivers/ram/starfive/starfive_ddr.c
@@ -4,7 +4,6 @@
  * Author: Yanhong Wang<yanhong.wang@starfivetech.com>
  */
 
-#include <common.h>
 #include <asm/arch/regs.h>
 #include <asm/io.h>
 #include <clk.h>
diff --git a/drivers/ram/starfive/starfive_ddr.h b/drivers/ram/starfive/starfive_ddr.h
index d0ec1c1da807..c29d26b510c9 100644
--- a/drivers/ram/starfive/starfive_ddr.h
+++ b/drivers/ram/starfive/starfive_ddr.h
@@ -7,6 +7,8 @@
 #ifndef __STARFIVE_DDR_H__
 #define __STARFIVE_DDR_H__
 
+#include <linux/kernel.h>
+
 #define SEC_CTRL_ADDR		0x1000
 #define PHY_BASE_ADDR		0x800
 #define PHY_AC_BASE_ADDR	0x1000
diff --git a/drivers/ram/stm32_sdram.c b/drivers/ram/stm32_sdram.c
index 891f4137813e..10dc05dd6404 100644
--- a/drivers/ram/stm32_sdram.c
+++ b/drivers/ram/stm32_sdram.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_RAM
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <init.h>
diff --git a/drivers/ram/stm32mp1/stm32mp1_ddr.c b/drivers/ram/stm32mp1/stm32mp1_ddr.c
index 8ee4e24f39df..d7834b322992 100644
--- a/drivers/ram/stm32mp1/stm32mp1_ddr.c
+++ b/drivers/ram/stm32mp1/stm32mp1_ddr.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_RAM
 
-#include <common.h>
 #include <clk.h>
 #include <log.h>
 #include <ram.h>
diff --git a/drivers/ram/stm32mp1/stm32mp1_interactive.c b/drivers/ram/stm32mp1/stm32mp1_interactive.c
index 2c19847c6633..6340afbb8709 100644
--- a/drivers/ram/stm32mp1/stm32mp1_interactive.c
+++ b/drivers/ram/stm32mp1/stm32mp1_interactive.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_RAM
 
-#include <common.h>
 #include <command.h>
 #include <console.h>
 #include <cli.h>
diff --git a/drivers/ram/stm32mp1/stm32mp1_ram.c b/drivers/ram/stm32mp1/stm32mp1_ram.c
index a82b1db7592d..debc458c0e2e 100644
--- a/drivers/ram/stm32mp1/stm32mp1_ram.c
+++ b/drivers/ram/stm32mp1/stm32mp1_ram.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_RAM
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <init.h>
diff --git a/drivers/ram/stm32mp1/stm32mp1_tests.c b/drivers/ram/stm32mp1/stm32mp1_tests.c
index c5f33544144f..6108faa70730 100644
--- a/drivers/ram/stm32mp1/stm32mp1_tests.c
+++ b/drivers/ram/stm32mp1/stm32mp1_tests.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_RAM
 
-#include <common.h>
 #include <console.h>
 #include <init.h>
 #include <log.h>
diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c b/drivers/ram/sunxi/dram_sun20i_d1.c
index 38379281d739..a1794032f3b8 100644
--- a/drivers/ram/sunxi/dram_sun20i_d1.c
+++ b/drivers/ram/sunxi/dram_sun20i_d1.c
@@ -13,7 +13,7 @@
  */
 
 #include <asm/io.h>
-#include <common.h>
+#include <config.h>
 #ifdef CONFIG_RAM
   #include <dm.h>
   #include <ram.h>
-- 
2.34.1

