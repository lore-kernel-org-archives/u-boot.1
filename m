Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21849C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 16:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57134887FE;
	Fri, 12 Jul 2024 18:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 088E98881D; Fri, 12 Jul 2024 18:54:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 763D98880C
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 18:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F8601042;
 Fri, 12 Jul 2024 09:54:30 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.20])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F9A03F766;
 Fri, 12 Jul 2024 09:54:03 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>,
 Philippe Simons <simons.philippe@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH v2 4/6] power: pmic: sunxi: add AXP717 SPL support
Date: Fri, 12 Jul 2024 17:53:50 +0100
Message-Id: <20240712165352.3767166-5-andre.przywara@arm.com>
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

On boards using the AXP717 PMIC, the DRAM rail is often not setup
correctly at reset time, so we have to program the PMIC very early in
the SPL, before running the DRAM initialisation.

Using the new generic AXP SPL driver, add the Kconfig options and
platform bits needed to support an AXP717 PMIC chip in I2C mode.
This allows to set up the correct voltage for the DRAM chips and the
CPU cores.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/pmic_bus.c |  3 +++
 board/sunxi/board.c            |  2 +-
 drivers/power/Kconfig          | 17 +++++++++++++----
 drivers/power/Makefile         |  1 +
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-sunxi/pmic_bus.c b/arch/arm/mach-sunxi/pmic_bus.c
index 87df312725c..8e19324c8ac 100644
--- a/arch/arm/mach-sunxi/pmic_bus.c
+++ b/arch/arm/mach-sunxi/pmic_bus.c
@@ -19,6 +19,7 @@
 #define AXP152_I2C_ADDR			0x30
 
 #define AXP209_I2C_ADDR			0x34
+#define AXP717_I2C_ADDR			0x34
 
 #define AXP305_I2C_ADDR			0x36
 #define AXP313_I2C_ADDR			0x36
@@ -36,6 +37,8 @@ static int pmic_i2c_address(void)
 		return AXP305_I2C_ADDR;
 	if (IS_ENABLED(CONFIG_AXP313_POWER))
 		return AXP313_I2C_ADDR;
+	if (IS_ENABLED(CONFIG_AXP717_POWER))
+		return AXP717_I2C_ADDR;
 
 	/* Other AXP2xx and AXP8xx variants */
 	return AXP209_I2C_ADDR;
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index ed86f1df5dc..9928069c0eb 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -562,7 +562,7 @@ void sunxi_board_init(void)
 #if defined CONFIG_AXP152_POWER || defined CONFIG_AXP209_POWER || \
 	defined CONFIG_AXP221_POWER || defined CONFIG_AXP305_POWER || \
 	defined CONFIG_AXP809_POWER || defined CONFIG_AXP818_POWER || \
-	defined CONFIG_AXP313_POWER
+	defined CONFIG_AXP313_POWER || defined CONFIG_AXP717_POWER
 	power_failed = axp_init();
 
 	if (IS_ENABLED(CONFIG_AXP_DISABLE_BOOT_ON_POWERON) && !power_failed) {
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 33b8bc1214d..5556a22cf69 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -109,6 +109,13 @@ config AXP313_POWER
 	Select this to enable support for the AXP313 PMIC found on some
 	H616 boards.
 
+config AXP717_POWER
+	bool "axp717 pmic support"
+	select AXP_PMIC_BUS
+	select CMD_POWEROFF
+	---help---
+	Select this to enable support for the AXP717 PMIC found on some boards.
+
 config AXP809_POWER
 	bool "axp809 pmic support"
 	depends on MACH_SUN9I
@@ -151,10 +158,11 @@ config AXP_DCDC1_VOLT
 
 config AXP_DCDC2_VOLT
 	int "axp pmic dcdc2 voltage"
-	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP313_POWER
+	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP313_POWER || AXP717_POWER
 	default 900 if AXP818_POWER
 	default 1400 if AXP152_POWER || AXP209_POWER
 	default 1000 if AXP313_POWER
+	default 1000 if AXP717_POWER
 	default 1200 if MACH_SUN6I
 	default 1100 if MACH_SUN8I
 	default 0 if MACH_SUN9I
@@ -167,11 +175,11 @@ config AXP_DCDC2_VOLT
 	On A80 boards dcdc2 powers the GPU and can be left off.
 	On A83T boards dcdc2 is used for VDD-CPUA(cluster 0) and should be 0.9V.
 	On R40 boards dcdc2 is VDD-CPU and should be 1.1V
-	On boards using the AXP313 it's often VDD-CPU.
+	On boards using the AXP313 or AXP717 it's often VDD-CPU.
 
 config AXP_DCDC3_VOLT
 	int "axp pmic dcdc3 voltage"
-	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP313_POWER
+	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP313_POWER || AXP717_POWER
 	default 900 if AXP809_POWER || AXP818_POWER
 	default 1500 if AXP152_POWER
 	default 1250 if AXP209_POWER
@@ -188,7 +196,8 @@ config AXP_DCDC3_VOLT
 	On A80 boards dcdc3 is used for VDD-CPUA(cluster 0) and should be 0.9V.
 	On A83T boards dcdc3 is used for VDD-CPUB(cluster 1) and should be 0.9V.
 	On R40 boards dcdc3 is VDD-SYS and VDD-GPU and should be 1.1V.
-	On boards using the AXP313 it's often VDD-DRAM and should be 1.1V for LPDDR4.
+	On boards using the AXP313 or AXP717 it's often VDD-DRAM and should
+	be 1.1V for LPDDR4.
 
 config AXP_DCDC4_VOLT
 	int "axp pmic dcdc4 voltage"
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 0f39459dec4..6df23a81c29 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_AXP209_POWER)	+= axp209.o
 obj-$(CONFIG_AXP221_POWER)	+= axp221.o
 obj-$(CONFIG_AXP305_POWER)	+= axp305.o
 obj-$(CONFIG_AXP313_POWER)	+= axp313.o
+obj-$(CONFIG_AXP717_POWER)	+= axp_spl.o
 obj-$(CONFIG_AXP809_POWER)	+= axp809.o
 obj-$(CONFIG_AXP818_POWER)	+= axp818.o
 endif
-- 
2.25.1

