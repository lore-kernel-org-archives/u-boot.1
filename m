Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE125C02187
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 01:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A701E80758;
	Fri, 17 Jan 2025 02:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27A0E8074B; Fri, 17 Jan 2025 02:47:11 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0C69780312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB57216F8;
 Thu, 16 Jan 2025 17:47:36 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 149CB3F673;
 Thu, 16 Jan 2025 17:47:06 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>, Simon Glass <sjg@chromium.org>,
 linux-sunxi@lists.linux.dev, Parthiban <parthiban@linumiz.com>
Subject: [PATCH 2/8] sunxi: pmic_bus: support alternative I2C address
Date: Fri, 17 Jan 2025 01:45:31 +0000
Message-ID: <20250117014537.22513-3-andre.przywara@arm.com>
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

Some of the X-Power AXP PMICs can be ordered with an alternative I2C
address, for instance an AXP717 could be shipped with address 0x34 or
with address 0x35.
The datasheets for the AXP717 and AXP803 list two possible addresses,
and they are always consecutive. For DM (DT) based drivers this is no
problem, but the Allwinner SPL code relies on a hardcoded address.

Add a Kconfig variable that will add "1" to the existing address if it
is set.
This enables to use the AXP717 as used on boards with the new Allwinner
A523 chip.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/pmic_bus.c | 7 ++++++-
 drivers/power/Kconfig          | 8 ++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/pmic_bus.c b/arch/arm/mach-sunxi/pmic_bus.c
index 8e19324c8ac..f0201f76f42 100644
--- a/arch/arm/mach-sunxi/pmic_bus.c
+++ b/arch/arm/mach-sunxi/pmic_bus.c
@@ -31,6 +31,11 @@ static struct udevice *pmic;
 #else
 static int pmic_i2c_address(void)
 {
+	int i2c_offset = 0;
+
+	if (IS_ENABLED(CONFIG_AXP_ALT_I2C_ADDR))
+		i2c_offset = 1;
+
 	if (IS_ENABLED(CONFIG_AXP152_POWER))
 		return AXP152_I2C_ADDR;
 	if (IS_ENABLED(CONFIG_AXP305_POWER))
@@ -38,7 +43,7 @@ static int pmic_i2c_address(void)
 	if (IS_ENABLED(CONFIG_AXP313_POWER))
 		return AXP313_I2C_ADDR;
 	if (IS_ENABLED(CONFIG_AXP717_POWER))
-		return AXP717_I2C_ADDR;
+		return AXP717_I2C_ADDR + i2c_offset;
 
 	/* Other AXP2xx and AXP8xx variants */
 	return AXP209_I2C_ADDR;
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 4b81aeb7497..4c2211097fd 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -142,6 +142,14 @@ config SY8106A_POWER
 
 endchoice
 
+config AXP_ALT_I2C_ADDR
+	bool "use alternative I2C address"
+	depends on AXP717_POWER
+	---help---
+	Some PMICs can be ordered with a different I2C address (+1), to avoid
+	address clashes or accommodate two PMICs on the same bus.
+	Select this to use the secondary I2C address for the AXP PMICs.
+
 config AXP_DCDC1_VOLT
 	int "axp pmic dcdc1 voltage"
 	depends on AXP221_POWER || AXP809_POWER || AXP818_POWER
-- 
2.46.2

