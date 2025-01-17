Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D86C02187
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 01:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67F8C80778;
	Fri, 17 Jan 2025 02:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2569680716; Fri, 17 Jan 2025 02:47:18 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CF24480757
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC93E16F8;
 Thu, 16 Jan 2025 17:47:43 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8E253F673;
 Thu, 16 Jan 2025 17:47:13 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>, Simon Glass <sjg@chromium.org>,
 linux-sunxi@lists.linux.dev, Parthiban <parthiban@linumiz.com>
Subject: [PATCH 6/8] power: pmic: sunxi: add SPL support for the AXP803
Date: Fri, 17 Jan 2025 01:45:35 +0000
Message-ID: <20250117014537.22513-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20250117014537.22513-1-andre.przywara@arm.com>
References: <20250117014537.22513-1-andre.przywara@arm.com>
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

The AXP803 has been around for about a decade now, but so far we didn't
need SPL support, since the DRAM rail was wired up correctly at reset.

Now some boards using the A133 SoC use the (compatible) AXP707 with DDR4
memory, which requires the SPL to set the required 1.1V voltage manually.

Add the descriptions for the DC/DC regulators of the AXP803, and enable
that when CONFIG_AXP803_POWER is enabled.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/pmic_bus.c |  3 +++
 board/sunxi/board.c            |  5 ++++-
 drivers/power/Kconfig          | 17 ++++++++++++-----
 drivers/power/Makefile         |  1 +
 drivers/power/axp_spl.c        | 17 +++++++++++++++++
 5 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-sunxi/pmic_bus.c b/arch/arm/mach-sunxi/pmic_bus.c
index f0201f76f42..b8b51dae6b0 100644
--- a/arch/arm/mach-sunxi/pmic_bus.c
+++ b/arch/arm/mach-sunxi/pmic_bus.c
@@ -20,6 +20,7 @@
 
 #define AXP209_I2C_ADDR			0x34
 #define AXP717_I2C_ADDR			0x34
+#define AXP803_I2C_ADDR			0x34
 
 #define AXP305_I2C_ADDR			0x36
 #define AXP313_I2C_ADDR			0x36
@@ -44,6 +45,8 @@ static int pmic_i2c_address(void)
 		return AXP313_I2C_ADDR;
 	if (IS_ENABLED(CONFIG_AXP717_POWER))
 		return AXP717_I2C_ADDR + i2c_offset;
+	if (IS_ENABLED(CONFIG_AXP803_POWER))
+		return AXP803_I2C_ADDR + i2c_offset;
 
 	/* Other AXP2xx and AXP8xx variants */
 	return AXP209_I2C_ADDR;
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 824c322a0dc..a4a84d652d8 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -562,7 +562,8 @@ void sunxi_board_init(void)
 #if defined CONFIG_AXP152_POWER || defined CONFIG_AXP209_POWER || \
 	defined CONFIG_AXP221_POWER || defined CONFIG_AXP305_POWER || \
 	defined CONFIG_AXP809_POWER || defined CONFIG_AXP818_POWER || \
-	defined CONFIG_AXP313_POWER || defined CONFIG_AXP717_POWER
+	defined CONFIG_AXP313_POWER || defined CONFIG_AXP717_POWER || \
+	defined CONFIG_AXP803_POWER
 	power_failed = axp_init();
 
 	if (IS_ENABLED(CONFIG_AXP_DISABLE_BOOT_ON_POWERON) && !power_failed) {
@@ -581,6 +582,8 @@ void sunxi_board_init(void)
 #endif
 #ifdef CONFIG_AXP_DCDC2_VOLT
 	power_failed |= axp_set_dcdc2(CONFIG_AXP_DCDC2_VOLT);
+#endif
+#ifdef CONFIG_AXP_DCDC3_VOLT
 	power_failed |= axp_set_dcdc3(CONFIG_AXP_DCDC3_VOLT);
 #endif
 #ifdef CONFIG_AXP_DCDC4_VOLT
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 4c2211097fd..e163217dfdf 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -116,6 +116,12 @@ config AXP717_POWER
 	---help---
 	Select this to enable support for the AXP717 PMIC found on some boards.
 
+config AXP803_POWER
+	bool "AXP803 PMIC support"
+	select AXP_PMIC_BUS
+	---help---
+	Select this to enable support for the AXP803 PMIC found on some boards.
+
 config AXP809_POWER
 	bool "axp809 pmic support"
 	depends on MACH_SUN9I
@@ -144,7 +150,7 @@ endchoice
 
 config AXP_ALT_I2C_ADDR
 	bool "use alternative I2C address"
-	depends on AXP717_POWER
+	depends on AXP717_POWER || AXP803_POWER
 	---help---
 	Some PMICs can be ordered with a different I2C address (+1), to avoid
 	address clashes or accommodate two PMICs on the same bus.
@@ -152,8 +158,8 @@ config AXP_ALT_I2C_ADDR
 
 config AXP_DCDC1_VOLT
 	int "axp pmic dcdc1 voltage"
-	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
-	default 3300 if AXP818_POWER || MACH_SUN8I_R40
+	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP803_POWER
+	default 3300 if AXP818_POWER || MACH_SUN8I_R40 || AXP803_POWER
 	default 3000 if MACH_SUN6I || MACH_SUN8I || MACH_SUN9I
 	---help---
 	Set the voltage (mV) to program the axp pmic dcdc1 at, set to 0 to
@@ -166,11 +172,12 @@ config AXP_DCDC1_VOLT
 
 config AXP_DCDC2_VOLT
 	int "axp pmic dcdc2 voltage"
-	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP313_POWER || AXP717_POWER
+	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP313_POWER || AXP717_POWER || AXP803_POWER
 	default 900 if AXP818_POWER
 	default 1400 if AXP152_POWER || AXP209_POWER
 	default 1000 if AXP313_POWER
 	default 1000 if AXP717_POWER
+	default 1000 if AXP803_POWER
 	default 1200 if MACH_SUN6I
 	default 1100 if MACH_SUN8I
 	default 0 if MACH_SUN9I
@@ -227,7 +234,7 @@ config AXP_DCDC4_VOLT
 
 config AXP_DCDC5_VOLT
 	int "axp pmic dcdc5 voltage"
-	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
+	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP803_POWER
 	default 1500 if MACH_SUN6I || MACH_SUN8I || MACH_SUN9I
 	---help---
 	Set the voltage (mV) to program the axp pmic dcdc5 at, set to 0 to
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 3f4d56f5139..3363191fdc8 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_AXP313_POWER)	+= axp_spl.o
 obj-$(CONFIG_AXP717_POWER)	+= axp_spl.o
 obj-$(CONFIG_AXP809_POWER)	+= axp809.o
 obj-$(CONFIG_AXP818_POWER)	+= axp818.o
+obj-$(CONFIG_AXP803_POWER)	+= axp_spl.o
 endif
 obj-$(CONFIG_EXYNOS_TMU)	+= exynos-tmu.o
 obj-$(CONFIG_SY8106A_POWER)	+= sy8106a.o
diff --git a/drivers/power/axp_spl.c b/drivers/power/axp_spl.c
index 3c86eb20ab4..7c51a9b3dfb 100644
--- a/drivers/power/axp_spl.c
+++ b/drivers/power/axp_spl.c
@@ -36,6 +36,23 @@ static const struct axp_reg_desc_spl axp_spl_dcdc_regulators[] = {
 #define AXP_SHUTDOWN_REG	0x27
 #define AXP_SHUTDOWN_MASK	BIT(0)
 
+#elif defined(CONFIG_AXP803_POWER)				/* AXP803 */
+
+static const struct axp_reg_desc_spl axp_spl_dcdc_regulators[] = {
+	{ 0x10, BIT(0), 0x20, 0x1f, 1600, 3400, 100, NA },
+	{ 0x10, BIT(1), 0x21, 0x7f,  500, 1300,  10, 70 },
+	{ 0x10, BIT(2), 0x22, 0x7f,  500, 1300,  10, 70 },
+	{ 0x10, BIT(3), 0x23, 0x7f,  500, 1300,  10, 70 },
+	{ 0x10, BIT(4), 0x24, 0x7f,  800, 1840,  10, 32 },
+	{ 0x10, BIT(5), 0x25, 0x7f,  600, 1520,  10, 50 },
+};
+
+#define AXP_CHIP_VERSION	0x3
+#define AXP_CHIP_VERSION_MASK	0xcf
+#define AXP_CHIP_ID		0x41
+#define AXP_SHUTDOWN_REG	0x32
+#define AXP_SHUTDOWN_MASK	BIT(7)
+
 #elif defined(CONFIG_AXP313_POWER)				/* AXP313 */
 
 static const struct axp_reg_desc_spl axp_spl_dcdc_regulators[] = {
-- 
2.46.2

