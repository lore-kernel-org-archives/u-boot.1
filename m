Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F01CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 09:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07F828491C;
	Wed,  3 Jun 2026 11:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="EK32Im9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CF9583FF5; Wed,  3 Jun 2026 11:55:28 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D1F9848E3
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 11:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id F11531A37B7;
 Wed,  3 Jun 2026 09:55:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BEB1B5FFA8;
 Wed,  3 Jun 2026 09:55:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6DD3410888CC5; 
 Wed,  3 Jun 2026 11:55:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780480524; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Z2YyO7qOWlh72Qh432ttC66SZp7c7pX/pXvg56JoM0U=;
 b=EK32Im9NAj1YKofnNfO8I62D9gXRAIA4XcR3H3jUxRDbIwxfo5CmK/v3zIIm5bF1FP3cDx
 SzRwYQB5Vwqp72T3BvtFheqGUDXrkRUwxRrlBtoeOl5O+kdDsWVykbz8u6UX4MnunRmBm8
 W0410AbuV40LLL++5aaz0JNgWar5l6FuSLM8uqdRE0KWGi4peBfmX50whcf/4/sbT78Ws7
 +RztWjA4vlJqSzClwD/0rzKYGooZdLkWj4GJPSUa0ndMOiMEGgG0Vdp4clDZ6lTQZktxj/
 M+qB8Q65qXmRFfoEWY2xo/VunKnXgJLrbZOlEPYziyOzAgAm86aKrRZwysuEyg==
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
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH v2 11/16] arm: mach-k3: j784s4: Enable LPM resume flow for
 J784s4/J742s2 SOCs
Date: Wed,  3 Jun 2026 11:54:44 +0200
Message-ID: <20260603095449.2089514-12-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603095449.2089514-1-richard.genoud@bootlin.com>
References: <20260603095449.2089514-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
 arch/arm/mach-k3/j784s4/j784s4_init.c | 70 ++++++++++++++++++++++++++-
 board/ti/j784s4/evm.c                 |  3 +-
 2 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
index 53f152ccd9c6..5646d41a59f4 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -18,11 +18,18 @@
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
 
 #define CTRL_MMR_CFG0_AUDIO_REFCLK1_CTRL	0x001082e4
 #define AUDIO_REFCLK1_DEFAULT			0x1c
@@ -264,26 +271,85 @@ void k3_spl_init(void)
 		k3_dm_print_ver();
 }
 
+#define DDR_RET_VAL BIT(5)
+#define GPIO_OUT_1 0x3D
+#define PMIC_NSLEEP_REG 0x86
+
+static void k3_deassert_DDR_RET(void)
+{
+	struct udevice *pmic;
+	int regval;
+	int err;
+
+	err = uclass_get_device_by_name(UCLASS_PMIC,
+					"pmic@48", &pmic);
+	if (err) {
+		printf("Getting PMIC init failed: %d\n", err);
+		return;
+	}
+
+	/* Set DDR_RET Signal Low on PMIC B */
+	regval = pmic_reg_read(pmic, GPIO_OUT_1) & ~DDR_RET_VAL;
+
+	pmic_reg_write(pmic, GPIO_OUT_1, regval);
+	pmic_reg_write(pmic, PMIC_NSLEEP_REG, 0x3);
+}
+
+__weak bool j7xx_board_is_resuming(void)
+{
+	return false;
+}
+
 void k3_mem_init(void)
 {
 	struct udevice *dev;
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
+			k3_deassert_DDR_RET();
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
index 73730ca94438..851dc274d509 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -63,7 +63,8 @@ int board_late_init(void)
 }
 #endif
 
-#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM))
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && (IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM) || \
+				      IS_ENABLED(CONFIG_TARGET_J742S2_R5_EVM)))
 void clear_isolation(void)
 {
 	int ret;
-- 
2.47.3

