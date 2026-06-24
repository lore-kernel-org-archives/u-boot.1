Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674B4CDB470
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 07:45:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51A6384671;
	Wed, 24 Jun 2026 09:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Rh5QkENU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95AA084671; Wed, 24 Jun 2026 09:45:20 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7859880287
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 09:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 337324E407B2;
 Wed, 24 Jun 2026 07:45:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0734C601C5;
 Wed, 24 Jun 2026 07:45:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C8BE9106C83D2; 
 Wed, 24 Jun 2026 09:45:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782287115; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=MXRcEsNS60jkduDLj4Ghw4jLWtAO5tVoyrLE804xOjs=;
 b=Rh5QkENUZAILD9DJ/kxnwW3J4Kw7vMd1WP3d7d4JRk33IBxRaczpzmnphAAEbX0bTudvXn
 o8Eczvxodzn2pBylcuvjecFgc7Mx02D8jWiagHMyY+HnbhQkPADb7hiZMX9uSUMnWCT3TH
 oRfhns+j6mo29emrpRtV4Z/t7xjizUFSfsZcC53Fg09rA75S5bgS8dAH5iW7XZZlpCUC1U
 vBNoJF+VHILqk0keB43BsQ5u+0P13g5+QE2+lEGSBP9V7G3lpvRMmL+YW1PmhdETSh8R5L
 JT5ztR0c/1brHWQT1IPUROLTq8rudpgPkBKVHn343ceQxeirBfBGJVy4A0qJMw==
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
Subject: [PATCH v3 04/19] mach-k3: r5: common: introduce
 j7xx_board_is_resuming()
Date: Wed, 24 Jun 2026 09:44:44 +0200
Message-ID: <20260624074459.873906-5-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624074459.873906-1-richard.genoud@bootlin.com>
References: <20260624074459.873906-1-richard.genoud@bootlin.com>
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

Add the capability to detect a resume on J7200, J784s4, J721e, j722s,
j721s2 SoCs.

To detect the resume, SPL searches a magic value (0xBA) in a register
of PMIC.
This value is set by DM-Firmware during the suspend sequence.

NB: As this is called in board_init_f(), there's no BSS, so we can't
use global/static variables.

NB2: For j722s HS-* devices, we need an extra call to ctrl_mmr_unlock(),
and we have to use I2C API instead of PMIC API for this to work.
This is because bind is called before anything comes up, in between either
bootrom or TIFS messing up, clearing pad config and pd config.

Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/common.c                |  6 ++
 arch/arm/mach-k3/include/mach/hardware.h |  2 +
 arch/arm/mach-k3/r5/lpm-common.c         | 78 +++++++++++++++++++++++-
 3 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 2f3df5519c53..3608b76ad4d8 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -605,3 +605,9 @@ int spl_start_uboot(void)
 	return 0;
 }
 #endif
+
+/* if r5/lpm-common.c is compiled, this will be overridden */
+__weak bool j7xx_board_is_resuming(void)
+{
+	return false;
+}
diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 81b5f1fa45ea..1c8510bf99bf 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -126,4 +126,6 @@ struct rom_extended_boot_data {
 
 u32 get_boot_device(void);
 const char *get_reset_reason(void);
+bool j7xx_board_is_resuming(void);
+
 #endif /* _ASM_ARCH_HARDWARE_H_ */
diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
index 6bab0189b032..95f777c5029f 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -6,18 +6,28 @@
  * Copyright (C) 2026 Bootlin
  */
 
+#include <asm/global_data.h>
 #include <clk.h>
+#include <dm/device.h>
 #include <dm/read.h>
 #include <elf.h>
+#include <i2c.h>
 #include <linux/printk.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <power-domain.h>
+#include <power/pmic.h>
 #include <remoteproc.h>
 #include <mach/security.h>
 
 #include "../common.h"
 #include "../lpm-common.h"
 
+/* Magic value in PMIC register to indicate the suspend state (SOC_OFF) */
+#define K3_LPM_MAGIC_SUSPEND 0xba
+
+/* PMIC register where the magic value resides */
+#define K3_LPM_SCRATCH_PAD_REG_3 0xcb
+
 #define FW_IMAGE_SIZE 0x80000
 
 struct lpm_addr_info {
@@ -28,9 +38,73 @@ struct lpm_addr_info {
 	u32 size;
 };
 
-__weak bool j7xx_board_is_resuming(void)
+/* This is used by J722s */
+__weak void ctrl_mmr_unlock(void) { }
+
+/* in board_init_f(), there's no BSS, so we can't use global/static variables */
+bool j7xx_board_is_resuming(void)
 {
-	return false;
+	struct udevice *pmic, *i2c;
+	int ret, magic;
+
+	if (gd_k3_resuming() != K3_RESUME_STATE_UNKNOWN)
+		goto end;
+
+	if (IS_ENABLED(CONFIG_SOC_K3_J722S)) {
+		/*
+		 * On J722S devices, i2c access fails unless MMR
+		 * registers are unlocked.
+		 * Moreover, it fails also if we use PMIC API instead of I2C API.
+		 */
+		ctrl_mmr_unlock();
+		ret = uclass_get_device_by_name(UCLASS_I2C,
+						"i2c@2b200000", &i2c);
+		if (ret) {
+			printf("Getting I2C failed: %d\n", ret);
+			goto end;
+		}
+		ret = dm_i2c_probe(i2c, 0x48, 0, &pmic);
+		if (ret) {
+			printf("Getting PMIC failed: %d\n", ret);
+			goto end;
+		}
+	} else {
+		ret = uclass_get_device_by_name(UCLASS_PMIC,
+						"pmic@48", &pmic);
+		if (ret) {
+			printf("Getting PMIC init failed: %d\n", ret);
+			goto end;
+		}
+	}
+	debug("%s: PMIC is detected (%s)\n", __func__, pmic->name);
+
+	if (IS_ENABLED(CONFIG_SOC_K3_J722S))
+		magic = dm_i2c_reg_read(pmic, K3_LPM_SCRATCH_PAD_REG_3);
+	else
+		magic = pmic_reg_read(pmic, K3_LPM_SCRATCH_PAD_REG_3);
+
+	if (magic == K3_LPM_MAGIC_SUSPEND) {
+		debug("%s: board is resuming\n", __func__);
+		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
+
+		/* clean magic suspend */
+		if (IS_ENABLED(CONFIG_SOC_K3_J722S))
+			ret = dm_i2c_reg_write(pmic, K3_LPM_SCRATCH_PAD_REG_3, 0);
+		else
+			ret = pmic_reg_write(pmic, K3_LPM_SCRATCH_PAD_REG_3, 0);
+
+		if (ret)
+			printf("Failed to clean magic value for suspend detection in PMIC\n");
+		/*
+		 * For robustness, the DM should also clean the magic value at
+		 * startup.
+		 */
+	} else {
+		debug("%s: board is booting (no resume detected)\n", __func__);
+		gd_set_k3_resuming(K3_RESUME_STATE_BOOTING);
+	}
+end:
+	return gd_k3_resuming() == K3_RESUME_STATE_RESUMING;
 }
 
 static int extract_lpm_region(struct lpm_addr_info *mem_addr_lpm)
