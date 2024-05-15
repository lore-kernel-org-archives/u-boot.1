Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6E6C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 23:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FDB088361;
	Thu, 16 May 2024 01:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D94188363; Thu, 16 May 2024 01:49:38 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E62D28833D
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 01:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9DD41042;
 Wed, 15 May 2024 16:49:59 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11B783F641;
 Wed, 15 May 2024 16:49:33 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: [PATCH 4/6] power: pmic: sunxi: use generic AXP SPL driver for AXP313
Date: Thu, 16 May 2024 00:48:37 +0100
Message-Id: <20240515234839.26898-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240515234839.26898-1-andre.przywara@arm.com>
References: <20240515234839.26898-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The generic AXP SPL driver implementation can cover all regulators we
need for the AXP313.

Add the descriptions for the three DC/DC regulators of the AXP313, and
enable that when CONFIG_AXP313_POWER is enabled. Also remove the old
driver, and switch the Makefile to include the new, generic version.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/power/Makefile  |   2 +-
 drivers/power/axp313.c  | 133 ----------------------------------------
 drivers/power/axp_spl.c |  13 ++++
 3 files changed, 14 insertions(+), 134 deletions(-)
 delete mode 100644 drivers/power/axp313.c

diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 6df23a81c29..30e0daf0621 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_AXP152_POWER)	+= axp152.o
 obj-$(CONFIG_AXP209_POWER)	+= axp209.o
 obj-$(CONFIG_AXP221_POWER)	+= axp221.o
 obj-$(CONFIG_AXP305_POWER)	+= axp305.o
-obj-$(CONFIG_AXP313_POWER)	+= axp313.o
+obj-$(CONFIG_AXP313_POWER)	+= axp_spl.o
 obj-$(CONFIG_AXP717_POWER)	+= axp_spl.o
 obj-$(CONFIG_AXP809_POWER)	+= axp809.o
 obj-$(CONFIG_AXP818_POWER)	+= axp818.o
diff --git a/drivers/power/axp313.c b/drivers/power/axp313.c
deleted file mode 100644
index 09ecb5b1ec2..00000000000
--- a/drivers/power/axp313.c
+++ /dev/null
@@ -1,133 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * AXP313(a) driver
- *
- * (C) Copyright 2023 Arm Ltd.
- *
- * Based on axp305.c
- * (C) Copyright 2020 Jernej Skrabec <jernej.skrabec@siol.net>
- * (C) Copyright 2014 Hans de Goede <hdegoede@redhat.com>
- * (C) Copyright 2013 Oliver Schinagl <oliver@schinagl.nl>
- */
-
-#include <command.h>
-#include <errno.h>
-#include <asm/arch/pmic_bus.h>
-#include <axp_pmic.h>
-
-enum axp313_reg {
-	AXP313_CHIP_VERSION	= 0x03,
-	AXP313_OUTPUT_CTRL	= 0x10,
-	AXP313_DCDC1_CTRL	= 0x13,
-	AXP313_SHUTDOWN		= 0x1a,
-};
-
-#define AXP313_CHIP_VERSION_MASK	0xcf
-#define AXP313_CHIP_VERSION_AXP1530	0x48
-#define AXP313_CHIP_VERSION_AXP313A	0x4b
-#define AXP313_CHIP_VERSION_AXP313B	0x4c
-
-#define AXP313_DCDC_SPLIT_OFFSET	71
-#define AXP313_DCDC_SPLIT_MVOLT		1200
-
-#define AXP313_POWEROFF			BIT(7)
-
-static u8 mvolt_to_cfg(int mvolt, int min, int max, int div)
-{
-	if (mvolt < min)
-		mvolt = min;
-	else if (mvolt > max)
-		mvolt = max;
-
-	return (mvolt - min) / div;
-}
-
-static int axp_set_dcdc(int dcdc_num, unsigned int mvolt)
-{
-	int ret;
-	u8 cfg, enable_mask = 1U << (dcdc_num - 1);
-	int volt_reg = AXP313_DCDC1_CTRL + dcdc_num - 1;
-	int max_mV;
-
-	switch (dcdc_num) {
-	case 1:
-	case 2:
-		max_mV	= 1540;
-		break;
-	case 3:
-		/*
-		 * The manual defines a different split point, but tests
-		 * show that it's the same 1200mV as for DCDC1/2.
-		 */
-		max_mV	= 1840;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (mvolt > AXP313_DCDC_SPLIT_MVOLT)
-		cfg = AXP313_DCDC_SPLIT_OFFSET + mvolt_to_cfg(mvolt,
-				AXP313_DCDC_SPLIT_MVOLT + 20, max_mV, 20);
-	else
-		cfg = mvolt_to_cfg(mvolt, 500, AXP313_DCDC_SPLIT_MVOLT, 10);
-
-	if (mvolt == 0)
-		return pmic_bus_clrbits(AXP313_OUTPUT_CTRL, enable_mask);
-
-	debug("DCDC%d: writing 0x%x to reg 0x%x\n", dcdc_num, cfg, volt_reg);
-	ret = pmic_bus_write(volt_reg, cfg);
-	if (ret)
-		return ret;
-
-	return pmic_bus_setbits(AXP313_OUTPUT_CTRL, enable_mask);
-}
-
-int axp_set_dcdc2(unsigned int mvolt)
-{
-	return axp_set_dcdc(2, mvolt);
-}
-
-int axp_set_dcdc3(unsigned int mvolt)
-{
-	return axp_set_dcdc(3, mvolt);
-}
-
-int axp_init(void)
-{
-	u8 axp_chip_id;
-	int ret;
-
-	ret = pmic_bus_init();
-	if (ret)
-		return ret;
-
-	ret = pmic_bus_read(AXP313_CHIP_VERSION, &axp_chip_id);
-	if (ret)
-		return ret;
-
-	axp_chip_id &= AXP313_CHIP_VERSION_MASK;
-	switch (axp_chip_id) {
-	case AXP313_CHIP_VERSION_AXP1530:
-	case AXP313_CHIP_VERSION_AXP313A:
-	case AXP313_CHIP_VERSION_AXP313B:
-		break;
-	default:
-		debug("unknown PMIC: 0x%x\n", axp_chip_id);
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-#if !CONFIG_IS_ENABLED(ARM_PSCI_FW) && !IS_ENABLED(CONFIG_SYSRESET_CMD_POWEROFF)
-int do_poweroff(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	pmic_bus_write(AXP313_SHUTDOWN, AXP313_POWEROFF);
-
-	/* infinite loop during shutdown */
-	while (1) {}
-
-	/* not reached */
-	return 0;
-}
-#endif
diff --git a/drivers/power/axp_spl.c b/drivers/power/axp_spl.c
index 36eb6bd0b2a..f72d106315e 100644
--- a/drivers/power/axp_spl.c
+++ b/drivers/power/axp_spl.c
@@ -34,6 +34,19 @@ static const struct axp_reg_desc_spl axp_spl_dcdc_regulators[] = {
 #define AXP_SHUTDOWN_REG	0x27
 #define AXP_SHUTDOWN_MASK	BIT(0)
 
+#elif defined(CONFIG_AXP313_POWER)				/* AXP313 */
+
+static const struct axp_reg_desc_spl axp_spl_dcdc_regulators[] = {
+	{ 0x10, BIT(0), 0x13, 0x7f,  500, 1540,  10, 70 },
+	{ 0x10, BIT(1), 0x14, 0x7f,  500, 1540,  10, 70 },
+	{ 0x10, BIT(2), 0x15, 0x7f,  500, 1840,  10, 70 },
+};
+#define AXP_CHIP_VERSION	0x3
+#define AXP_CHIP_VERSION_MASK	0xc8
+#define AXP_CHIP_ID		0x48
+#define AXP_SHUTDOWN_REG	0x1a
+#define AXP_SHUTDOWN_MASK	BIT(7)
+
 #else
 
 	#error "Please define the regulator registers in axp_spl_regulators[]."
-- 
2.35.8

