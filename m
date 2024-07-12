Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87206C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 16:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13289887CF;
	Fri, 12 Jul 2024 18:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 277848881D; Fri, 12 Jul 2024 18:54:11 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DFCD3887CF
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 18:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D15B1042;
 Fri, 12 Jul 2024 09:54:33 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD4103F766;
 Fri, 12 Jul 2024 09:54:06 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>,
 Philippe Simons <simons.philippe@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH v2 6/6] power: pmic: sunxi: use generic AXP SPL driver for
 AXP305
Date: Fri, 12 Jul 2024 17:53:52 +0100
Message-Id: <20240712165352.3767166-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240712165352.3767166-1-andre.przywara@arm.com>
References: <20240712165352.3767166-1-andre.przywara@arm.com>
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
need for the AXP305.

Add the descriptions for four of the six DC/DC regulators of the AXP305,
and enable that when CONFIG_AXP305_POWER is enabled. We won't need DCDC2
and DCDC3, but by using the position in the array for the index we keep
the code cleaner.
Also remove the old driver, and switch the Makefile to include the new,
generic driver.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/power/Makefile  |  2 +-
 drivers/power/axp305.c  | 82 -----------------------------------------
 drivers/power/axp_spl.c | 16 ++++++++
 3 files changed, 17 insertions(+), 83 deletions(-)
 delete mode 100644 drivers/power/axp305.c

diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 30e0daf0621..8d36f87ed32 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -12,7 +12,7 @@ ifdef CONFIG_SPL_BUILD
 obj-$(CONFIG_AXP152_POWER)	+= axp152.o
 obj-$(CONFIG_AXP209_POWER)	+= axp209.o
 obj-$(CONFIG_AXP221_POWER)	+= axp221.o
-obj-$(CONFIG_AXP305_POWER)	+= axp305.o
+obj-$(CONFIG_AXP305_POWER)	+= axp_spl.o
 obj-$(CONFIG_AXP313_POWER)	+= axp_spl.o
 obj-$(CONFIG_AXP717_POWER)	+= axp_spl.o
 obj-$(CONFIG_AXP809_POWER)	+= axp809.o
diff --git a/drivers/power/axp305.c b/drivers/power/axp305.c
deleted file mode 100644
index 0312ad9af76..00000000000
--- a/drivers/power/axp305.c
+++ /dev/null
@@ -1,82 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * AXP305 driver
- *
- * (C) Copyright 2020 Jernej Skrabec <jernej.skrabec@siol.net>
- *
- * Based on axp221.c
- * (C) Copyright 2014 Hans de Goede <hdegoede@redhat.com>
- * (C) Copyright 2013 Oliver Schinagl <oliver@schinagl.nl>
- */
-
-#include <command.h>
-#include <errno.h>
-#include <asm/arch/pmic_bus.h>
-#include <axp_pmic.h>
-
-#define AXP305_DCDC4_1600MV_OFFSET 46
-
-static u8 axp305_mvolt_to_cfg(int mvolt, int min, int max, int div)
-{
-	if (mvolt < min)
-		mvolt = min;
-	else if (mvolt > max)
-		mvolt = max;
-
-	return  (mvolt - min) / div;
-}
-
-int axp_set_dcdc4(unsigned int mvolt)
-{
-	int ret;
-	u8 cfg;
-
-	if (mvolt >= 1600)
-		cfg = AXP305_DCDC4_1600MV_OFFSET +
-			axp305_mvolt_to_cfg(mvolt, 1600, 3300, 100);
-	else
-		cfg = axp305_mvolt_to_cfg(mvolt, 600, 1500, 20);
-
-	if (mvolt == 0)
-		return pmic_bus_clrbits(AXP305_OUTPUT_CTRL1,
-					AXP305_OUTPUT_CTRL1_DCDCD_EN);
-
-	ret = pmic_bus_write(AXP305_DCDCD_VOLTAGE, cfg);
-	if (ret)
-		return ret;
-
-	return pmic_bus_setbits(AXP305_OUTPUT_CTRL1,
-				AXP305_OUTPUT_CTRL1_DCDCD_EN);
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
-	ret = pmic_bus_read(AXP305_CHIP_VERSION, &axp_chip_id);
-	if (ret)
-		return ret;
-
-	if ((axp_chip_id & AXP305_CHIP_VERSION_MASK) != 0x40)
-		return -ENODEV;
-
-	return ret;
-}
-
-#if !CONFIG_IS_ENABLED(ARM_PSCI_FW) && !IS_ENABLED(CONFIG_SYSRESET_CMD_POWEROFF)
-int do_poweroff(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	pmic_bus_write(AXP305_SHUTDOWN, AXP305_POWEROFF);
-
-	/* infinite loop during shutdown */
-	while (1) {}
-
-	/* not reached */
-	return 0;
-}
-#endif
diff --git a/drivers/power/axp_spl.c b/drivers/power/axp_spl.c
index 68cbf60eedf..3c86eb20ab4 100644
--- a/drivers/power/axp_spl.c
+++ b/drivers/power/axp_spl.c
@@ -50,6 +50,22 @@ static const struct axp_reg_desc_spl axp_spl_dcdc_regulators[] = {
 #define AXP_SHUTDOWN_REG	0x1a
 #define AXP_SHUTDOWN_MASK	BIT(7)
 
+#elif defined(CONFIG_AXP305_POWER)				/* AXP305 */
+
+static const struct axp_reg_desc_spl axp_spl_dcdc_regulators[] = {
+	{ 0x10, BIT(0), 0x12, 0x7f,  600, 1520,  10, 50 },
+	{ 0x10, BIT(1), 0x13, 0x1f, 1000, 2550,  50, NA },
+	{ 0x10, BIT(2), 0x14, 0x7f,  600, 1520,  10, 50 },
+	{ 0x10, BIT(3), 0x15, 0x3f,  600, 1500,  20, NA },
+	{ 0x10, BIT(4), 0x16, 0x1f, 1100, 3400, 100, NA },
+};
+
+#define AXP_CHIP_VERSION	0x3
+#define AXP_CHIP_VERSION_MASK	0xcf
+#define AXP_CHIP_ID		0x40
+#define AXP_SHUTDOWN_REG	0x32
+#define AXP_SHUTDOWN_MASK	BIT(7)
+
 #else
 
 	#error "Please define the regulator registers in axp_spl_regulators[]."
-- 
2.25.1

