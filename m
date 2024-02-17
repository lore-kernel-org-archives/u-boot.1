Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4573AC48BC3
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 18:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17B2F87EBB;
	Sat, 17 Feb 2024 19:38:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="guFOZUVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E381987E9D; Sat, 17 Feb 2024 19:37:30 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BA1487E91
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 19:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f1ab=J3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708195027; bh=QloRLOIHy8H22MGXagQR5M+Adv6w3srrpmhGVZU00Bw=;
 b=guFOZUVJOaI7X6ArrsR1NS5tNUuQWZe924Ug3lMntwAGJzm5jEp2vXOLBeYomMakWMao2FLQD
 L3nEH7bpOlTiUsws4N9fVUXoArDsT7IZ+O0jpIXapbdPAesiYT2YH9MeikMEqlcl0op6lKwN6+V
 86+Kf4B2uhJe0ne8bMxj/4jIiF2IogpLKpF2mvtN0XjuwVF7IuCUkDBjHzP8Kym9hZdejrKyO3I
 RhW7uBk3XHj3/3JJ92rIQfs6b9k9gylFxrrmUGV0W7BKbKp5K26cF6EDLYKyr2NTcL3sCe5hg65
 LdVwuKmqUhnBZ/vHTFL4epjeqk7zteWLEWLE6l0FM4Fw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 10/11] rockchip: theobroma-systems: puma: Migrate to use
 IO-domain driver
Date: Sat, 17 Feb 2024 18:35:55 +0000
Message-ID: <20240217183610.2621132-11-jonas@kwiboo.se>
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
 149.28.215.223
X-ForwardEmail-ID: 65d0fcd1af53a5c07f266d02
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
This should be runtime tested by someone with a puma device. All DT
props and driver seem to be enabled and I expect the io_vsel to be
configured with correct value.
---
 .../puma_rk3399/puma-rk3399.c                 | 21 -------------------
 configs/puma-rk3399_defconfig                 |  1 +
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/board/theobroma-systems/puma_rk3399/puma-rk3399.c b/board/theobroma-systems/puma_rk3399/puma-rk3399.c
index 8b998ef45565..eeb8a99231e4 100644
--- a/board/theobroma-systems/puma_rk3399/puma-rk3399.c
+++ b/board/theobroma-systems/puma_rk3399/puma-rk3399.c
@@ -3,31 +3,10 @@
  * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
  */
 
-#include <dm.h>
-#include <syscon.h>
-#include <dm/pinctrl.h>
-#include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/hardware.h>
-#include <asm/arch-rockchip/grf_rk3399.h>
 #include "../common/common.h"
 
-static void setup_iodomain(void)
-{
-	const u32 GRF_IO_VSEL_GPIO4CD_SHIFT = 3;
-	struct rk3399_grf_regs *grf =
-	    syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
-
-	/*
-	 * Set bit 3 in GRF_IO_VSEL so PCIE_RST# works (pin GPIO4_C6).
-	 * Linux assumes that PCIE_RST# works out of the box as it probes
-	 * PCIe before loading the iodomain driver.
-	 */
-	rk_setreg(&grf->io_vsel, 1 << GRF_IO_VSEL_GPIO4CD_SHIFT);
-}
-
 int rockchip_early_misc_init_r(void)
 {
-	setup_iodomain();
 	setup_boottargets();
 
 	return 0;
diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index 818bfdf9aa9b..e30305abfafd 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -66,6 +66,7 @@ CONFIG_GPIO_HOG=y
 CONFIG_SPL_GPIO_HOG=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
-- 
2.43.0

