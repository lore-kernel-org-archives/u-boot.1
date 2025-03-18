Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7899C28B30
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 00:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A8E9805D7;
	Tue, 18 Mar 2025 01:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E16080F70; Tue, 18 Mar 2025 01:40:04 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 45D0180107
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 01:40:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37C7F13D5;
 Mon, 17 Mar 2025 17:40:10 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78F6D3F63F;
 Mon, 17 Mar 2025 17:40:00 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] sunxi: pmic_bus: Move SPL I2C addresses into Kconfig
Date: Tue, 18 Mar 2025 00:39:43 +0000
Message-ID: <20250318003943.6714-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
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

Some of the X-Power AXP PMICs can be ordered with an alternative I2C
address, for instance an AXP717 could be shipped with address 0x34 or
with address 0x35. Similarly the AXP803 lists two possible addresses.
For DM (DT) based drivers this is no problem, but the Allwinner SPL
code relies on exactly one hardcoded address per PMIC so far.

Add a Kconfig variable that holds the I2C address used by the PMIC
accessed in the SPL, and provide the (mostly only one) supported address
as its default, for the PMICs we use. Boards using the other address
can easily set this in their defconfig.
This effectively moves the hardcoding from C code to Kconfig.

That enables to use the AXP717 on some boards with the new Allwinner
A523 chip, which use the other I2C address there.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/pmic_bus.c | 27 ++-------------------------
 drivers/power/Kconfig          | 10 ++++++++++
 2 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-sunxi/pmic_bus.c b/arch/arm/mach-sunxi/pmic_bus.c
index 8e19324c8ac..c77dc538456 100644
--- a/arch/arm/mach-sunxi/pmic_bus.c
+++ b/arch/arm/mach-sunxi/pmic_bus.c
@@ -16,33 +16,10 @@
 #include <power/pmic.h>
 #include <asm/arch/pmic_bus.h>
 
-#define AXP152_I2C_ADDR			0x30
-
-#define AXP209_I2C_ADDR			0x34
-#define AXP717_I2C_ADDR			0x34
-
-#define AXP305_I2C_ADDR			0x36
-#define AXP313_I2C_ADDR			0x36
-
 #define AXP221_CHIP_ADDR		0x68
 
 #if CONFIG_IS_ENABLED(PMIC_AXP)
 static struct udevice *pmic;
-#else
-static int pmic_i2c_address(void)
-{
-	if (IS_ENABLED(CONFIG_AXP152_POWER))
-		return AXP152_I2C_ADDR;
-	if (IS_ENABLED(CONFIG_AXP305_POWER))
-		return AXP305_I2C_ADDR;
-	if (IS_ENABLED(CONFIG_AXP313_POWER))
-		return AXP313_I2C_ADDR;
-	if (IS_ENABLED(CONFIG_AXP717_POWER))
-		return AXP717_I2C_ADDR;
-
-	/* Other AXP2xx and AXP8xx variants */
-	return AXP209_I2C_ADDR;
-}
 #endif
 
 int pmic_bus_init(void)
@@ -88,7 +65,7 @@ int pmic_bus_read(u8 reg, u8 *data)
 	if (IS_ENABLED(CONFIG_SYS_I2C_SUN8I_RSB))
 		return rsb_read(AXP_PMIC_PRI_RUNTIME_ADDR, reg, data);
 
-	return i2c_read(pmic_i2c_address(), reg, 1, data, 1);
+	return i2c_read(CONFIG_AXP_I2C_ADDRESS, reg, 1, data, 1);
 #endif
 }
 
@@ -102,7 +79,7 @@ int pmic_bus_write(u8 reg, u8 data)
 	if (IS_ENABLED(CONFIG_SYS_I2C_SUN8I_RSB))
 		return rsb_write(AXP_PMIC_PRI_RUNTIME_ADDR, reg, data);
 
-	return i2c_write(pmic_i2c_address(), reg, 1, &data, 1);
+	return i2c_write(CONFIG_AXP_I2C_ADDRESS, reg, 1, &data, 1);
 #endif
 }
 
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 5c73bc75a15..eed65058e66 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -148,6 +148,16 @@ config SY8106A_POWER
 
 endchoice
 
+config AXP_I2C_ADDRESS
+	hex "AXP PMIC I2C address"
+	depends on ARCH_SUNXI && !SUNXI_NO_PMIC
+	default 0x36 if AXP305_POWER
+	default 0x36 if AXP313_POWER
+	default 0x30 if AXP152_POWER
+	default 0x34
+	---help---
+	I2C address of the AXP PMIC, used for the SPL only.
+
 config AXP_DCDC1_VOLT
 	int "axp pmic dcdc1 voltage"
 	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP803_POWER
-- 
2.46.3

