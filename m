Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4029C48BC4
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 18:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79EA987ED9;
	Sat, 17 Feb 2024 19:38:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TQ7jz65l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCF0A87E75; Sat, 17 Feb 2024 19:37:36 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0D3D87E8C
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 19:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f1ab=J3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708195019; bh=nB3/XCA0LwrV2aHwEadxGk+zllYFsXQjxZWDXBWp7co=;
 b=TQ7jz65lL+fkqtLcBFIIMRHIa/zzfLGAcjbhX6Rxvi3lEqcIzNJt9YCUJTvsAcCn/NlELKVEa
 1zqMDpnwFFr9+c7LowYpjkUEb8tJ5fdQ/liO2vcNCrwDNMK35d7o9Iv4GEXVdRd+QFoFHOBf+yF
 q70YTpXC7Gme0psEJsC6ZpoJscGrTghX0UmA9dWpklqXaPyCIaupDK/o66cvxqXGT7KoEhEVPzi
 e4lAT+fkuQchYxqJ0EVKRIYKJ1wo+/zdZhcqnAYVo4JUe8CwYY24tveqIelLYVVIxaWaRNwLdnc
 xACbe1AC25T97cnjeT2QAPiXfyw/X9sSOUiivICtwzbA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 08/11] rockchip: pine64: pinephone-pro: Migrate to use
 IO-domain driver
Date: Sat, 17 Feb 2024 18:35:53 +0000
Message-ID: <20240217183610.2621132-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217183610.2621132-1-jonas@kwiboo.se>
References: <20240217183610.2621132-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65d0fcc8af53a5c07f266cde
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
---
This should be runtime tested by someone with a pinephone-pro device.
All DT props and driver seem to be enabled and I expect the io_vsel to
be configured with correct value.
---
 board/pine64/pinephone-pro-rk3399/Makefile    |  1 -
 .../pinephone-pro-rk3399.c                    | 42 -------------------
 configs/pinephone-pro-rk3399_defconfig        |  1 +
 3 files changed, 1 insertion(+), 43 deletions(-)
 delete mode 100644 board/pine64/pinephone-pro-rk3399/Makefile
 delete mode 100644 board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c

diff --git a/board/pine64/pinephone-pro-rk3399/Makefile b/board/pine64/pinephone-pro-rk3399/Makefile
deleted file mode 100644
index 8d9203053e57..000000000000
--- a/board/pine64/pinephone-pro-rk3399/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-y	+= pinephone-pro-rk3399.o
diff --git a/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c b/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
deleted file mode 100644
index 06dc512c57d8..000000000000
--- a/board/pine64/pinephone-pro-rk3399/pinephone-pro-rk3399.c
+++ /dev/null
@@ -1,42 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2016 Rockchip Electronics Co., Ltd
- * (C) Copyright 2022 Peter Robinson <pbrobinson at gmail.com>
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
-#define GRF_IO_VSEL_BT565_GPIO2AB 1
-#define GRF_IO_VSEL_AUDIO_GPIO3D4A 2
-#define PMUGRF_CON0_VSEL_SHIFT 8
-
-#ifdef CONFIG_MISC_INIT_R
-static void setup_iodomain(void)
-{
-	struct rk3399_grf_regs *grf =
-	   syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
-	struct rk3399_pmugrf_regs *pmugrf =
-	   syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
-
-	/* BT565 is in 1.8v domain */
-	rk_setreg(&grf->io_vsel,
-		  GRF_IO_VSEL_BT565_GPIO2AB | GRF_IO_VSEL_AUDIO_GPIO3D4A);
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
-
-}
-#endif
diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
index 04551df1da9b..47124196d626 100644
--- a/configs/pinephone-pro-rk3399_defconfig
+++ b/configs/pinephone-pro-rk3399_defconfig
@@ -58,6 +58,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
-- 
2.43.0

