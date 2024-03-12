Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D9BC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 23:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78BBF87FAC;
	Wed, 13 Mar 2024 00:37:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ISGmrXZc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD0CA87F50; Wed, 13 Mar 2024 00:37:30 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B97ED87F19
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 00:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=03ce=KT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710286634; bh=Mdn8Sx9zOpgeirUDje8Th1GPPEx5gE4XejvCdCNisdI=;
 b=ISGmrXZcY0qAKqdKNHlxD9ohPbRMwsLsWTi0pn/tqYRW+qE2uimm9UlkYt1Yoc3fx7O7RmFEJ
 MJNmKqxwMk7VKfh/eC291uibSbmwVKw+kAiYV26J3GtVxlY9Xo/2QaznoXKphNl/xXZYkDhWxKp
 qW7ShDen3MT3lJsvXGJk3zM/yK7dOmUxGKcCevdRQkBor57AdlA77W/OJQLsAcSA4A4FutoqXNy
 KQD41rqbQnMr0QsByzoKA+AMN8Crq4DIW+1sKJIocc4FvEE70kpgWenxewRpnso5vTdyNKl+dB9
 LRf/1HTvKcRTznoBmbyxFbrrtYpoIairTBZwI/e8UqMA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: [PATCH v2 06/12] rockchip: pine64: rockpro64: Migrate to use
 IO-domain driver
Date: Tue, 12 Mar 2024 23:36:16 +0000
Message-ID: <20240312233636.1428749-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240312233636.1428749-1-jonas@kwiboo.se>
References: <20240312233636.1428749-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65f0e728e6c04c5b30593654
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

Switch to use the IO-domain driver to configure IO-domain based on
device tree instead of a setup_iodomain() function.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2:
- Collect r-b tag
---
 board/pine64/rockpro64_rk3399/Makefile        |  7 ----
 .../rockpro64_rk3399/rockpro64-rk3399.c       | 39 -------------------
 configs/rockpro64-rk3399_defconfig            |  1 +
 3 files changed, 1 insertion(+), 46 deletions(-)
 delete mode 100644 board/pine64/rockpro64_rk3399/Makefile
 delete mode 100644 board/pine64/rockpro64_rk3399/rockpro64-rk3399.c

diff --git a/board/pine64/rockpro64_rk3399/Makefile b/board/pine64/rockpro64_rk3399/Makefile
deleted file mode 100644
index b015c47e6fa6..000000000000
--- a/board/pine64/rockpro64_rk3399/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# (C) Copyright 2019 Vasily Khoruzhick
-#
-# SPDX-License-Identifier:     GPL-2.0+
-#
-
-obj-y	+= rockpro64-rk3399.o
diff --git a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
deleted file mode 100644
index fd78ad60d14b..000000000000
--- a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
+++ /dev/null
@@ -1,39 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2019 Vasily Khoruzhick <anarsoul@gmail.com>
- */
-
-#include <common.h>
-#include <dm.h>
-#include <init.h>
-#include <syscon.h>
-#include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/grf_rk3399.h>
-#include <asm/arch-rockchip/hardware.h>
-
-#define GRF_IO_VSEL_BT565_SHIFT 0
-#define PMUGRF_CON0_VSEL_SHIFT 8
-
-#ifdef CONFIG_MISC_INIT_R
-static void setup_iodomain(void)
-{
-	struct rk3399_grf_regs *grf =
-	    syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
-	struct rk3399_pmugrf_regs *pmugrf =
-	    syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
-
-	/* BT565 is in 1.8v domain */
-	rk_setreg(&grf->io_vsel, 1 << GRF_IO_VSEL_BT565_SHIFT);
-
-	/* Set GPIO1 1.8v/3.0v source select to PMU1830_VOL */
-	rk_setreg(&pmugrf->soc_con0, 1 << PMUGRF_CON0_VSEL_SHIFT);
-}
-
-int rockchip_early_misc_init_r(void)
-{
-	setup_iodomain();
-
-	return 0;
-}
-
-#endif
diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index 4de3d5b1c7f8..d66b4a9d8900 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -52,6 +52,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
-- 
2.43.2

