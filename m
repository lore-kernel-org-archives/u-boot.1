Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92032C48BC4
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 18:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84B1487EEA;
	Sat, 17 Feb 2024 19:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Dp8CL5nf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B4F387E60; Sat, 17 Feb 2024 19:37:52 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB5387E93
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 19:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f1ab=J3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708195032; bh=+wThmMe07uFvuz8Qq6m+kdatC3D3G/3Yg0ChgAmyzOw=;
 b=Dp8CL5nf9YWi53dZ1KBBa+KyEtNZaccxxWLs7VTo4wRKqwaXdChezJe4KOpABMumJEW/SJx5n
 7tK5fY5y0AzhPr7E/S6PEZ4Foc0Bz248E8NOs//cseSxFrnrGEICa/QM/moi9CeZXaLmbuKU4FB
 cW6A+HsSj7G/usq3suUMbzW0WJ7oLtwOuIsZIrJD0vdzZ/GE4MePIRbD51gaEY2qGghDLWceKE5
 Z+/5S977uxXqc4q2B0bUS2feMHXCU6aOODKpfyUxHUfYIFUUiPu2DxpwJX6GqKUsPOP8ebMEkWp
 OaiH7cW5H6fnm/rc5BVb9hOvcLLqDDFLMZ95KRey2MSQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 11/11] rockchip: google: gru: Migrate to use IO-domain driver
Date: Sat, 17 Feb 2024 18:35:56 +0000
Message-ID: <20240217183610.2621132-12-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 65d0fcd6af53a5c07f266d14
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
This should be runtime tested by someone with a gru device. All DT props
and driver seem to be enabled and I expect the io_vsel and soc_con0 to
be configured with correct value.
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
index 28697b174a05..9e13b3544d05 100644
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
index aab938014e38..e1e80447de3c 100644
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
2.43.0

