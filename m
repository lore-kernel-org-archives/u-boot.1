Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FFEFF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B298466C;
	Thu, 30 Apr 2026 10:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JGEIuXJL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1F3B84694; Thu, 30 Apr 2026 10:44:42 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E860D8468E
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 2BC0EC5CD68;
 Thu, 30 Apr 2026 08:45:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A837560495;
 Thu, 30 Apr 2026 08:44:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 03CDB1072B7B2; 
 Thu, 30 Apr 2026 10:44:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777538679; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=HojJGXhy1EtalH02BCYkFlQezY/8A9+epllHBD71sqc=;
 b=JGEIuXJLCIEbrFm4CWFoAzBMzuOiEg2vTi5bTcU6P187vRpsy8WGoBd5rvAtiMM3Aw6t1L
 10TSB/C3GdOHeD3k5Qk0T/YPWjh+F5ysAOpf1+5USeiYnOeeOOa67Fi3oXDdKGHVqx1CDZ
 MiWVxwEuF8smmS/Ctg2wrotkdBiBlpDJKSf1++ZTtI2Jzu5ORqU6oylvh6QTp6jc5eSuGl
 CSOd2u0YSinL5fc/647UBlk+NC0tCyu/9VoP4i0S+RaPVQdOzcFJkenISMXDOv8JbUW8ef
 4SisE/k6+rGCzNKtbOaSy7sY2b20EIvB2g4RyYtu7fB/lsIhf+E8bxUdpAvilQ==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH 05/20] board: ti: j722s: Add resume detection
Date: Thu, 30 Apr 2026 10:43:58 +0200
Message-ID: <20260430084414.1354490-6-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430084414.1354490-1-richard.genoud@bootlin.com>
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
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

Add the capability to detect a resume. This overrides the weak
function j7xx_board_is_resuming().
To detect the resume, SPL searches a magic value (0xBA) in a register
of PMIC.
This value is set by DM-Firmware during the suspend sequence.

NB: As this is called in board_init_f(), there's no BSS, so we can't
use global/static variables.

NB2: For HS-SE device, we need an extra call to ctrl_mmr_unlock(), and
we have to use I2C API instead of PMIC API for this to work.
This is because bind is called before anything comes up, in between either
bootrom or TIFS messing up, clearing pad config and pd config.

Co-developed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/j722s/j722s_init.c |  2 +-
 board/ti/j722s/evm.c                | 51 +++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
index 1180c75f551d..7b3d27c1e855 100644
--- a/arch/arm/mach-k3/j722s/j722s_init.c
+++ b/arch/arm/mach-k3/j722s/j722s_init.c
@@ -37,7 +37,7 @@ static void store_boot_info_from_rom(void)
 	       sizeof(struct rom_extended_boot_data));
 }
 
-static void ctrl_mmr_unlock(void)
+void ctrl_mmr_unlock(void)
 {
 	/* Unlock all WKUP_CTRL_MMR0 module registers */
 	mmr_unlock(WKUP_CTRL_MMR0_BASE, 0);
diff --git a/board/ti/j722s/evm.c b/board/ti/j722s/evm.c
index 1173adc072be..86aa10ffb0fd 100644
--- a/board/ti/j722s/evm.c
+++ b/board/ti/j722s/evm.c
@@ -9,12 +9,15 @@
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
 #include <cpu_func.h>
+#include <dm/device.h>
 #include <dm/uclass.h>
+#include <i2c.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <spl.h>
 #include <asm/arch/k3-ddr.h>
 #include "../common/fdt_ops.h"
+#include "../common/k3-lpm.h"
 
 #if IS_ENABLED(CONFIG_SPL_BUILD)
 void spl_board_init(void)
@@ -23,6 +26,54 @@ void spl_board_init(void)
 }
 #endif
 
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J722S_R5_EVM))
+
+extern void ctrl_mmr_unlock(void);
+
+/* in board_init_f(), there's no BSS, so we can't use global/static variables */
+bool j7xx_board_is_resuming(void)
+{
+	struct udevice *pmic, *i2c;
+	int err;
+
+	if (gd_k3_resuming() != K3_RESUME_STATE_UNKNOWN)
+		goto end;
+
+	/*
+	 * On HS-SE devices, i2c access fails unless MMR registers are unlocked.
+	 * Moreover, it fails also if we use PMIC API instead of I2C API.
+	 */
+	ctrl_mmr_unlock();
+	err = uclass_get_device_by_name(UCLASS_I2C,
+					"i2c@2b200000", &i2c);
+	if (err) {
+		printf("Getting I2C failed: %d\n", err);
+		goto end;
+	}
+	err = dm_i2c_probe(i2c, 0x48, 0, &pmic);
+	if (err) {
+		printf("Getting PMIC failed: %d\n", err);
+		goto end;
+	}
+
+	debug("%s: PMIC is detected (%s)\n", __func__, pmic->name);
+
+	if (dm_i2c_reg_read(pmic, K3_LPM_SCRATCH_PAD_REG) == K3_LPM_MAGIC_SUSPEND) {
+		debug("%s: board is resuming\n", __func__);
+		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
+
+		/* clean magic suspend */
+		if (dm_i2c_reg_write(pmic, K3_LPM_SCRATCH_PAD_REG, 0))
+			printf("Failed to clean magic value for suspend detection in PMIC\n");
+	} else {
+		debug("%s: board is booting (no resume detected)\n", __func__);
+		gd_set_k3_resuming(K3_RESUME_STATE_BOOTING);
+	}
+end:
+	return gd_k3_resuming() == K3_RESUME_STATE_RESUMING;
+}
+#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J722S_R5_EVM */
+
 #if defined(CONFIG_XPL_BUILD)
 void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
