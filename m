Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF74DC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 23:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44E1B87F86;
	Wed, 13 Mar 2024 00:37:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="o58a1EWC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 558D687FC1; Wed, 13 Mar 2024 00:37:44 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 370FC87F78
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 00:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=03ce=KT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710286647; bh=pCTiTeqReXsCMgUWr/RXscn/yQicu/tjGCIfTmPrqt0=;
 b=o58a1EWC+uXLH/SMR2XSNNRgx3eZ6tCpX3L+sq6pEezOleqfjnDFQo4KD4BaDlHV+Hjn8VQJ/
 o5SM2AQeYFvyOs3GdtdUs9/4zbFnGw0aAjOJLPI/gEACp+JRMQ6CZiY8KKUSCBLaWh5eqP6dwfd
 rW7+xUpyZdkrdb2be00PGdlvtrXDY82yB5oj5kxTDAIID5Y6q6XrHx9MJvs8ebEEgIXA4IomTn1
 ykeafFlZcaAEPX4iQQSFw+sdPpwky9RtvrxLoAp/WTSjRveJOJJQw02I1uWEfsxFWziDg8b0sfm
 AJS28SZn9riibwbYlCn/464acDniuBpscZXXGaPsJvGw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 09/12] rockchip: vamrs: rock960: Migrate to use IO-domain
 driver
Date: Tue, 12 Mar 2024 23:36:19 +0000
Message-ID: <20240312233636.1428749-10-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 65f0e735e6c04c5b3059368a
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
 board/vamrs/rock960_rk3399/Makefile         |  6 -----
 board/vamrs/rock960_rk3399/rock960-rk3399.c | 27 ---------------------
 configs/ficus-rk3399_defconfig              |  1 +
 configs/rock960-rk3399_defconfig            |  1 +
 4 files changed, 2 insertions(+), 33 deletions(-)
 delete mode 100644 board/vamrs/rock960_rk3399/Makefile
 delete mode 100644 board/vamrs/rock960_rk3399/rock960-rk3399.c

diff --git a/board/vamrs/rock960_rk3399/Makefile b/board/vamrs/rock960_rk3399/Makefile
deleted file mode 100644
index 6c3e475b3a85..000000000000
--- a/board/vamrs/rock960_rk3399/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Copyright (C) 2018 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
-#
-
-obj-y	+= rock960-rk3399.o
diff --git a/board/vamrs/rock960_rk3399/rock960-rk3399.c b/board/vamrs/rock960_rk3399/rock960-rk3399.c
deleted file mode 100644
index 876be8ed9e10..000000000000
--- a/board/vamrs/rock960_rk3399/rock960-rk3399.c
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2018 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
- */
-
-#include <common.h>
-#include <syscon.h>
-#include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/grf_rk3399.h>
-#include <asm/arch-rockchip/hardware.h>
-#include <linux/bitops.h>
-
-#ifdef CONFIG_MISC_INIT_R
-int misc_init_r(void)
-{
-	struct rk3399_grf_regs *grf =
-	    syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
-
-	/**
-	 * Some SSD's to work on rock960 would require explicit
-	 * domain voltage change, so BT565 is in 1.8v domain
-	 */
-	rk_setreg(&grf->io_vsel, BIT(0));
-
-	return 0;
-}
-#endif
diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
index 90b07d847cc1..4859042d6b56 100644
--- a/configs/ficus-rk3399_defconfig
+++ b/configs/ficus-rk3399_defconfig
@@ -42,6 +42,7 @@ CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
index 5c0b95f10bd1..13575c580054 100644
--- a/configs/rock960-rk3399_defconfig
+++ b/configs/rock960-rk3399_defconfig
@@ -39,6 +39,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
-- 
2.43.2

