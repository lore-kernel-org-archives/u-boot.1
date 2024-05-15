Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF44C25B77
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 23:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0F8588335;
	Thu, 16 May 2024 01:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D8978835E; Thu, 16 May 2024 01:49:36 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7C31388286
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 01:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AFA9DA7;
 Wed, 15 May 2024 16:49:58 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 763A33F641;
 Wed, 15 May 2024 16:49:32 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: [PATCH 3/6] power: pmic: sunxi: replace AXP717 SPL driver
Date: Thu, 16 May 2024 00:48:36 +0100
Message-Id: <20240515234839.26898-4-andre.przywara@arm.com>
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

We now have a generic AXP SPL driver implementation, that already covers
the DC/DC converters of the AXP717 PMIC.

Remove the old, dedicated driver and switch to the new generic driver.
This should not introduce any change in behaviour.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/power/Makefile |  2 +-
 drivers/power/axp717.c | 92 ------------------------------------------
 2 files changed, 1 insertion(+), 93 deletions(-)
 delete mode 100644 drivers/power/axp717.c

diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 9d1f4c65262..6df23a81c29 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_AXP209_POWER)	+= axp209.o
 obj-$(CONFIG_AXP221_POWER)	+= axp221.o
 obj-$(CONFIG_AXP305_POWER)	+= axp305.o
 obj-$(CONFIG_AXP313_POWER)	+= axp313.o
-obj-$(CONFIG_AXP717_POWER)	+= axp717.o
+obj-$(CONFIG_AXP717_POWER)	+= axp_spl.o
 obj-$(CONFIG_AXP809_POWER)	+= axp809.o
 obj-$(CONFIG_AXP818_POWER)	+= axp818.o
 endif
diff --git a/drivers/power/axp717.c b/drivers/power/axp717.c
deleted file mode 100644
index 7c77c09ea8f..00000000000
--- a/drivers/power/axp717.c
+++ /dev/null
@@ -1,92 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * AXP717 SPL driver
- * (C) Copyright 2024 Arm Ltd.
- */
-
-#include <common.h>
-#include <command.h>
-#include <errno.h>
-#include <asm/arch/pmic_bus.h>
-#include <axp_pmic.h>
-
-enum axp717_reg {
-	AXP717_CHIP_VERSION = 0x3,
-	AXP717_SHUTDOWN = 0x27,
-	AXP717_OUTPUT_CTRL1 = 0x80,
-	AXP717_DCDC1_VOLTAGE = 0x83,
-};
-
-#define AXP717_CHIP_VERSION_MASK	0xc8
-#define AXP717_DCDC_1220MV_OFFSET	71
-#define AXP717_POWEROFF			(1U << 0)
-#define DCDC_DVM_ENABLE			(1U << 7)
-
-static u8 axp_mvolt_to_cfg(int mvolt, int min, int max, int div)
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
-	u8 cfg = DCDC_DVM_ENABLE;
-
-	if (dcdc_num < 1 || dcdc_num > 3)
-		return -EINVAL;
-
-	if (mvolt >= 1220)
-		cfg |= AXP717_DCDC_1220MV_OFFSET +
-			axp_mvolt_to_cfg(mvolt, 1220,
-					 dcdc_num == 3 ? 1840 : 1540, 20);
-	else
-		cfg |= axp_mvolt_to_cfg(mvolt, 500, 1200, 10);
-
-	if (mvolt == 0)
-		return pmic_bus_clrbits(AXP717_OUTPUT_CTRL1,
-					1U << (dcdc_num -1));
-
-	ret = pmic_bus_write(AXP717_DCDC1_VOLTAGE + dcdc_num - 1, cfg);
-	if (ret)
-		return ret;
-
-	return pmic_bus_setbits(AXP717_OUTPUT_CTRL1, 1U << (dcdc_num - 1));
-}
-
-int axp_set_dcdc1(unsigned int mvolt)
-{
-	return axp_set_dcdc(1, mvolt);
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
-	return pmic_bus_init();
-}
-
-#if !CONFIG_IS_ENABLED(ARM_PSCI_FW) && !IS_ENABLED(CONFIG_SYSRESET_CMD_POWEROFF)
-int do_poweroff(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	pmic_bus_setbits(AXP717_SHUTDOWN, AXP717_POWEROFF);
-
-	/* infinite loop during shutdown */
-	while (1) {}
-
-	/* not reached */
-	return 0;
-}
-#endif
-- 
2.35.8

