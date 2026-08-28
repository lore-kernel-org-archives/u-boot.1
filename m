Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3835DC61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3884408A3;
	Fri, 28 Aug 2026 13:58:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TH79tfC20mVO; Fri, 28 Aug 2026 13:58:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787925525;
	bh=VvJQbfvGXnNyAd9HCgW9EDyIfhfC2jN9kHEdbe3J2Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OmuSBGgzgMMz3KtMpH21f8InJK8LSjagJV1j9JvsiWAQHYVc3h1hq/T3uE4YPUdsI
	 GbFrrxZ57QvErjOStFAjO3Nedmpztpw4DO/alO2CmRIJM5n7hvMQ3GGOcKCi0tDrF/
	 J3b3frObrjMsOMlchkCPkvUXb5MwfpzV3A5QXnKHsOIYj5UiLJ8SBmKAxidsZdEeeD
	 Q7dz/fNTAGOV5bGScwJ3zVmvkVpOORH308wEFWWl1UAO+OCMEy3SF3KZpOaoP051GY
	 ai/eY2dlPaOkQd7W+ehCcxkXnno8KHvF6GXOTD0D6osH8pnyanA50j2vl9hI5f/ozp
	 y4RgyF9QxcMSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA15740872;
	Fri, 28 Aug 2026 13:58:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 83CED78B
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 81450403A1
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ut0nzoKrVcQu for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 13:58:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=Sl9NKZve
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5223C40317
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:58:42 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 6813A4E41401;
 Fri, 28 Aug 2026 13:58:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 336FD60537;
 Fri, 28 Aug 2026 13:58:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 72C0A11C7832B; 
 Fri, 28 Aug 2026 15:58:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787925518; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=VvJQbfvGXnNyAd9HCgW9EDyIfhfC2jN9kHEdbe3J2Tg=;
 b=Sl9NKZveNKmJRfMXurYfqAPEcTIqQumwPx+rAfVH8hB3RsQC0hKb3hS9HY4Eq1ATNg+rM8
 6astuGmfxBKEZ7ayMR272AxwSXxYNiyAxf3UUsyJ2Yi35KiY+MzcLu4HTTdQNzJso5Ft31
 8kAHIIoUpOPi1+1hh8LO2p5912iGhwPA8ta8wVGgO3K6ydcuMZnL+7f8RKEq93JgXMqV+1
 4U6bey1Cs6zfQAHN5cleLRNcyCS3/Rwu+GhNRhs7wCtnteU7wnJWmKQCP4kh+9+Mvn3urY
 +DV9TkhWLUqLxbYOs17Dw678GhJilMg4e1iVkMxYWe1CPl/VDsGNG+uedf9/wA==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 16/21] arm: mach-k3: j784s4: Enable LPM resume flow for
 J784s4/J742s2 SOCs
Date: Fri, 28 Aug 2026 15:57:25 +0200
Message-ID: <20260828135730.1565643-17-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828135730.1565643-1-richard.genoud@bootlin.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add support for resuming from suspend in board_init_f.
The resume state of the SOC is identified and lpm resume
sequence is followed accordingly.

First, add the board specific part of the exit retention sequence for
k3-ddrss following the DDR resume sequence:
   - exit DDR from retention
   - de-assert the DDR_RET pin
   - restore DDR max frequency
   - exit DDR from low power

The self-refresh exit sequence is performed in a loop for each DDR
controller. (J784S4 has 4 DDR controllers and J742S2 has only 2)

Select the number of ddr controllers on the basis of
CONFIG_TARGET_J742S2_R5_EVM build flag.

Then:
   - Extract context address from devicetree and send to TIFS.
   - Power on the rproc cluster.
   - Replay the certificates attached to saved images of ATF and OPTEE.
   - Resume sequence for context restore and rproc resume.
   - Image entry to DM firmware.
(All those steps are done in do_resume())

The context address area is firewalled by TIFS to protect it from
other hosts.

Co-developed-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
Signed-off-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
Co-developed-by: Prasanth Babu Mantena <p-mantena@ti.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
Co-developed-by: Abhash Kumar Jha <a-kumar2@ti.com>
Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/j784s4/j784s4_init.c | 44 +++++++++++++++++++++++++--
 board/ti/j784s4/evm.c                 |  3 +-
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
index 507b7ab685ad..d49249fa233a 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -18,11 +18,21 @@
 #include <mmc.h>
 #include <remoteproc.h>
 #include <k3_bist.h>
+#include <power/pmic.h>
+#include <mach/k3-ddr.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
+#include "../lpm-common.h"
 
-#define J784S4_MAX_DDR_CONTROLLERS	4
+#if IS_ENABLED(CONFIG_TARGET_J742S2_R5_EVM)
+#define MAX_DDR_CONTROLLERS	2
+#else
+#define MAX_DDR_CONTROLLERS	4
+#endif
+
+/* DDR retention bits */
+#define DDR_RET_VAL BIT(5)
 
 #define CTRL_MMR_CFG0_AUDIO_REFCLK1_CTRL	0x001082e4
 #define AUDIO_REFCLK1_DEFAULT			0x1c
@@ -279,20 +289,50 @@ void k3_mem_init(void)
 	int ret, ctrl = 0;
 
 	if (IS_ENABLED(CONFIG_K3_J721E_DDRSS)) {
+		struct udevice *devs[MAX_DDR_CONTROLLERS];
+		struct k3_ddrss_regs regs[MAX_DDR_CONTROLLERS];
+
 		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 		if (ret)
 			panic("DRAM 0 init failed: %d\n", ret);
+
+		devs[0] = dev;
 		ctrl++;
 
-		while (ctrl < J784S4_MAX_DDR_CONTROLLERS) {
+		while (ctrl < MAX_DDR_CONTROLLERS) {
 			ret = uclass_next_device_err(&dev);
 			if (ret == -ENODEV)
 				break;
 
 			if (ret)
 				panic("DRAM %d init failed: %d\n", ctrl, ret);
+			devs[ctrl] = dev;
 			ctrl++;
 		}
+
+		if (j7xx_board_is_resuming()) {
+			/* exit DDRs from retention */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++) {
+				k3_ddrss_lpddr4_exit_retention(devs[ctrl],
+							       &regs[ctrl]);
+			}
+
+			/* de-assert DDR_RET pin */
+			k3_deassert_ddr_ret("pmic@48", DDR_RET_VAL, 0, false);
+
+			/* restore DDR max frequency */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++)
+				k3_ddrss_lpddr4_change_freq(devs[ctrl]);
+
+			/* exit DDR from low power */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++) {
+				k3_ddrss_lpddr4_exit_low_power(devs[ctrl],
+							       &regs[ctrl]);
+			}
+			printf("Initialized %d DRAM controllers\n", ctrl);
+
+			do_resume();
+		}
 		printf("Initialized %d DRAM controllers\n", ctrl);
 	}
 
diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index 179a26d570fd..3b345528be5f 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -61,7 +61,8 @@ int board_late_init(void)
 }
 #endif
 
-#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM))
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && (IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM) || \
+				      IS_ENABLED(CONFIG_TARGET_J742S2_R5_EVM)))
 void clear_isolation(void)
 {
 	int ret;
