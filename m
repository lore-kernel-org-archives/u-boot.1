Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BA0C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 23:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6BB487FC0;
	Wed, 13 Mar 2024 00:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="aZJvhwt2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A2C87FC0; Wed, 13 Mar 2024 00:37:50 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 809B487F78
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 00:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=03ce=KT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710286655; bh=Y1FUU2xTuZdqJan1m51A8K9F8tFmlyhDjS6KpJdmZmE=;
 b=aZJvhwt2ib+Jig5J4JyvzWEZfXiQeRdkldJnDUt/lsF+Xojue6qUt6RqEQ3B9h3REkb4o4RPC
 Z5zIKYsUez37SJyCxSJVBTiBEBGBHrFq4uwMsUW92pBu3euG59aNWhr5rgvn51AC1emdTxXkz8i
 Ck/31Wq8GD+7cpMYSE+uvbGlf6cYIsKwntAYySa9BtvXen3Qg6mBlLkwsb+0l4PHwK4seiCINPX
 7s/w9sveXXmytP7FHzXSNyW+4MccpFeWuMeFsfIAI4agayzpmUIDje8Yh+FwhBF/Il0Rs3R9T9K
 t/EqntjFD48aFGks9W4rdAmj7XEbrfj6wV8EFCDMgBag==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 11/12] rockchip: google: gru: Migrate to use IO-domain
 driver
Date: Tue, 12 Mar 2024 23:36:21 +0000
Message-ID: <20240312233636.1428749-12-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 65f0e73ee6c04c5b305936b2
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
 board/google/gru/gru.c             | 35 ------------------------------
 configs/chromebook_bob_defconfig   |  1 +
 configs/chromebook_kevin_defconfig |  1 +
 3 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/board/google/gru/gru.c b/board/google/gru/gru.c
index 9cb3a5252047..e08cb42c27ed 100644
--- a/board/google/gru/gru.c
+++ b/board/google/gru/gru.c
@@ -3,18 +3,9 @@
  * Copyright 2018 Google
  */
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
-#include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
-#include <asm/arch-rockchip/grf_rk3399.h>
-#include <asm/arch-rockchip/hardware.h>
-
-#define GRF_IO_VSEL_BT656_SHIFT 0
-#define GRF_IO_VSEL_AUDIO_SHIFT 1
-#define PMUGRF_CON0_VSEL_SHIFT 8
-#define PMUGRF_CON0_VOL_SHIFT 9
 
 #ifdef CONFIG_SPL_BUILD
 /* provided to defeat compiler optimisation in board_init_f() */
@@ -63,29 +54,3 @@ int board_early_init_r(void)
 	return 0;
 }
 #endif
-
-static void setup_iodomain(void)
-{
-	struct rk3399_grf_regs *grf =
-	   syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
-	struct rk3399_pmugrf_regs *pmugrf =
-	   syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
-
-	/* BT656 and audio is in 1.8v domain */
-	rk_setreg(&grf->io_vsel, (1 << GRF_IO_VSEL_BT656_SHIFT |
-				  1 << GRF_IO_VSEL_AUDIO_SHIFT));
-
-	/*
-	 * Set GPIO1 1.8v/3.0v source select to PMU1830_VOL
-	 * and explicitly configure that PMU1830_VOL to be 1.8V
-	 */
-	rk_setreg(&pmugrf->soc_con0, (1 << PMUGRF_CON0_VSEL_SHIFT |
-				      1 << PMUGRF_CON0_VOL_SHIFT));
-}
-
-int rockchip_early_misc_init_r(void)
-{
-	setup_iodomain();
-
-	return 0;
-}
diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index 989a8211f64d..d0321948697b 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -66,6 +66,7 @@ CONFIG_I2C_CROS_EC_TUNNEL=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_I2C_MUX=y
 CONFIG_CROS_EC_KEYB=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_CROS_EC=y
 CONFIG_CROS_EC_SPI=y
 CONFIG_PWRSEQ=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 07a96aa18989..120c11c04972 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -67,6 +67,7 @@ CONFIG_I2C_CROS_EC_TUNNEL=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_I2C_MUX=y
 CONFIG_CROS_EC_KEYB=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_CROS_EC=y
 CONFIG_CROS_EC_SPI=y
 CONFIG_PWRSEQ=y
-- 
2.43.2

