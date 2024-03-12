Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36010C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 23:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BCD087F4F;
	Wed, 13 Mar 2024 00:37:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sukbGpC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45C6987F0E; Wed, 13 Mar 2024 00:37:30 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC3F87F4F
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 00:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=03ce=KT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710286638; bh=q+euCc2hW/SjIBDjrK0pMtd331e+XUR3bSOZ+Ls5CPE=;
 b=sukbGpC/ZTR3lzEFQn0JAQU8nUZwQWdYLz9MSVMMnqhvoS/ADs+M2BmDOdRFE7cwFDBz0Rpyj
 mOVPNDmj+By+Jo7CD3bDo0Mj7/VuduM+tiNxeFr1PuFwrR4SKKRxY33naQPhxO5djInAwyG35NO
 ehx44R+n6ypD23GkVxRVqfnQXIeZm8pPKseXRrXhWG1dlinkoNGhTW1hloZLGWSAXWIWJgOHGKW
 B76ZL7fEa5uERzOwMfMc+O3xJoWp8NQE/hYIwvhhIJS2efZW5Jv9GIuCorLZfC6M/qztx4GbYVp
 pFts61yF6FBQqPACt/T4jJfW4j0ItQHs5MQMqsr0reqg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: [PATCH v2 07/12] rockchip: pine64: pinebook-pro: Migrate to use
 IO-domain driver
Date: Tue, 12 Mar 2024 23:36:17 +0000
Message-ID: <20240312233636.1428749-8-jonas@kwiboo.se>
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
 149.28.215.223
X-ForwardEmail-ID: 65f0e72ce6c04c5b30593666
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
 board/pine64/pinebook-pro-rk3399/Makefile     |  1 -
 .../pinebook-pro-rk3399/pinebook-pro-rk3399.c | 39 -------------------
 configs/pinebook-pro-rk3399_defconfig         |  1 +
 3 files changed, 1 insertion(+), 40 deletions(-)
 delete mode 100644 board/pine64/pinebook-pro-rk3399/Makefile
 delete mode 100644 board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c

diff --git a/board/pine64/pinebook-pro-rk3399/Makefile b/board/pine64/pinebook-pro-rk3399/Makefile
deleted file mode 100644
index 2f692a12a673..000000000000
--- a/board/pine64/pinebook-pro-rk3399/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-y	+= pinebook-pro-rk3399.o
diff --git a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c b/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
deleted file mode 100644
index 0001022c62a6..000000000000
--- a/board/pine64/pinebook-pro-rk3399/pinebook-pro-rk3399.c
+++ /dev/null
@@ -1,39 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2016 Rockchip Electronics Co., Ltd
- * (C) Copyright 2020 Peter Robinson <pbrobinson at gmail.com>
- */
-
-#include <common.h>
-#include <dm.h>
-#include <syscon.h>
-#include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/grf_rk3399.h>
-#include <asm/arch-rockchip/hardware.h>
-#include <linux/printk.h>
-
-#define GRF_IO_VSEL_BT565_SHIFT 0
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
-#endif
diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
index 57e614c314e9..23ac24a0bffe 100644
--- a/configs/pinebook-pro-rk3399_defconfig
+++ b/configs/pinebook-pro-rk3399_defconfig
@@ -49,6 +49,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
-- 
2.43.2

