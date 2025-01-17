Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70692C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 01:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AECB80762;
	Fri, 17 Jan 2025 02:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4319F8073F; Fri, 17 Jan 2025 02:47:13 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CA13D8073F
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6463175A;
 Thu, 16 Jan 2025 17:47:38 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B90F73F673;
 Thu, 16 Jan 2025 17:47:08 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>, Simon Glass <sjg@chromium.org>,
 linux-sunxi@lists.linux.dev, Parthiban <parthiban@linumiz.com>
Subject: [PATCH 3/8] sunxi: H616: DRAM: rename Kconfig parameters to be more
 generic
Date: Fri, 17 Jan 2025 01:45:32 +0000
Message-ID: <20250117014537.22513-4-andre.przywara@arm.com>
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

The H616 DRAM controller requires some board specific parameters, which
we declare in Kconfig, let each board specify in their defconfig, and
then use in the DRAM init code.

Other DRAM controllers now require a very similar, if not identical
parameter set, with so far the same parameter names used.

To help keep the Kconfig file at bay, rename the existing parameter
names to drop the H616_ part in there, to make them more naturally
reusable for other SoCs.

No functional change, just a rename.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/Kconfig            | 58 +++++++++++++-------------
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 26 ++++++------
 configs/anbernic_rg35xx_h700_defconfig | 20 ++++-----
 configs/orangepi_zero2_defconfig       |  8 ++--
 configs/orangepi_zero2w_defconfig      | 16 +++----
 configs/orangepi_zero3_defconfig       | 16 +++----
 configs/tanix_tx1_defconfig            | 16 +++----
 configs/transpeed-8k618-t_defconfig    | 14 +++----
 configs/x96_mate_defconfig             | 14 +++----
 9 files changed, 93 insertions(+), 95 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index f941bf4a493..ba1b1541437 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -52,78 +52,76 @@ config DRAM_SUN50I_H616
 	  like H616.
 
 if DRAM_SUN50I_H616
-config DRAM_SUN50I_H616_DX_ODT
-	hex "H616 DRAM DX ODT parameter"
+config DRAM_SUNXI_DX_ODT
+	hex "DRAM DX ODT parameter"
 	help
 	  DX ODT value from vendor DRAM settings.
 
-config DRAM_SUN50I_H616_DX_DRI
-	hex "H616 DRAM DX DRI parameter"
+config DRAM_SUNXI_DX_DRI
+	hex "DRAM DX DRI parameter"
 	help
 	  DX DRI value from vendor DRAM settings.
 
-config DRAM_SUN50I_H616_CA_DRI
-	hex "H616 DRAM CA DRI parameter"
+config DRAM_SUNXI_CA_DRI
+	hex "DRAM CA DRI parameter"
 	help
 	  CA DRI value from vendor DRAM settings.
 
-config DRAM_SUN50I_H616_ODT_EN
-	hex "H616 DRAM ODT EN parameter"
+config DRAM_SUNXI_ODT_EN
+	hex "DRAM ODT EN parameter"
 	default 0x1
 	help
 	  ODT EN value from vendor DRAM settings.
 
-config DRAM_SUN50I_H616_TPR0
-	hex "H616 DRAM TPR0 parameter"
+config DRAM_SUNXI_TPR0
+	hex "DRAM TPR0 parameter"
 	default 0x0
 	help
 	  TPR0 value from vendor DRAM settings.
 
-config DRAM_SUN50I_H616_TPR2
-	hex "H616 DRAM TPR2 parameter"
+config DRAM_SUNXI_TPR2
+	hex "DRAM TPR2 parameter"
 	default 0x0
 	help
 	  TPR2 value from vendor DRAM settings.
 
-config DRAM_SUN50I_H616_TPR6
-	hex "H616 DRAM TPR6 parameter"
+config DRAM_SUNXI_TPR6
+	hex "DRAM TPR6 parameter"
 	default 0x3300c080
 	help
 	  TPR6 value from vendor DRAM settings.
 
-config DRAM_SUN50I_H616_TPR10
-	hex "H616 DRAM TPR10 parameter"
+config DRAM_SUNXI_TPR10
+	hex "DRAM TPR10 parameter"
 	help
 	  TPR10 value from vendor DRAM settings. It tells which features
 	  should be configured, like write leveling, read calibration, etc.
 
-config DRAM_SUN50I_H616_TPR11
-	hex "H616 DRAM TPR11 parameter"
+config DRAM_SUNXI_TPR11
+	hex "DRAM TPR11 parameter"
 	default 0x0
 	help
 	  TPR11 value from vendor DRAM settings.
 
-config DRAM_SUN50I_H616_TPR12
-	hex "H616 DRAM TPR12 parameter"
+config DRAM_SUNXI_TPR12
+	hex "DRAM TPR12 parameter"
 	default 0x0
 	help
 	  TPR12 value from vendor DRAM settings.
 
 choice
-	prompt "H616 PHY pin mapping selection"
-	default DRAM_SUN50I_H616_PHY_ADDR_MAP_0
+	prompt "DRAM PHY pin mapping selection"
+	default DRAM_SUNXI_PHY_ADDR_MAP_0
 
-config DRAM_SUN50I_H616_PHY_ADDR_MAP_0
-	bool "H313/H616/H618"
+config DRAM_SUNXI_PHY_ADDR_MAP_0
+	bool "DRAM PHY address map 0"
 	help
-	  The pin mapping selection used by the H313, H616, H618, and
-	  possibly other dies which use the H616 DRAM controller.
+	  This pin mapping selection should be used by the H313, H616, H618.
 
-config DRAM_SUN50I_H616_PHY_ADDR_MAP_1
-	bool "H700"
+config DRAM_SUNXI_PHY_ADDR_MAP_1
+	bool "DRAM PHY address map 1"
 	help
-	  The pin mapping selection used by the H700 and possibly other
-	  dies which use the H616 DRAM controller.
+	  This pin mapping selection should be used by the H700.
 endchoice
 endif
 
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 863c4f1d7a8..b3554cc64bf 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -226,7 +226,7 @@ static void mctl_set_addrmap(const struct dram_config *config)
 	mctl_ctl->addrmap[8] = 0x3F3F;
 }
 
-#ifdef CONFIG_DRAM_SUN50I_H616_PHY_ADDR_MAP_1
+#ifdef CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1
 static const u8 phy_init[] = {
 #ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
 	0x08, 0x02, 0x12, 0x05, 0x15, 0x17, 0x18, 0x0b,
@@ -245,7 +245,7 @@ static const u8 phy_init[] = {
 	0x18, 0x04, 0x1a
 #endif
 };
-#else /* CONFIG_DRAM_SUN50I_H616_PHY_ADDR_MAP_0 */
+#else /* CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_0 */
 static const u8 phy_init[] = {
 #ifdef CONFIG_SUNXI_DRAM_H616_DDR3_1333
 	0x07, 0x0b, 0x02, 0x16, 0x0d, 0x0e, 0x14, 0x19,
@@ -264,7 +264,7 @@ static const u8 phy_init[] = {
 	0x18, 0x03, 0x1a
 #endif
 };
-#endif /* CONFIG_DRAM_SUN50I_H616_PHY_ADDR_MAP_0 */
+#endif /* CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_0 */
 #define MASK_BYTE(reg, nr) (((reg) >> ((nr) * 8)) & 0x1f)
 static void mctl_phy_configure_odt(const struct dram_para *para)
 {
@@ -1409,16 +1409,16 @@ static const struct dram_para para = {
 #elif defined(CONFIG_SUNXI_DRAM_H616_LPDDR4)
 	.type = SUNXI_DRAM_TYPE_LPDDR4,
 #endif
-	.dx_odt = CONFIG_DRAM_SUN50I_H616_DX_ODT,
-	.dx_dri = CONFIG_DRAM_SUN50I_H616_DX_DRI,
-	.ca_dri = CONFIG_DRAM_SUN50I_H616_CA_DRI,
-	.odt_en = CONFIG_DRAM_SUN50I_H616_ODT_EN,
-	.tpr0 = CONFIG_DRAM_SUN50I_H616_TPR0,
-	.tpr2 = CONFIG_DRAM_SUN50I_H616_TPR2,
-	.tpr6 = CONFIG_DRAM_SUN50I_H616_TPR6,
-	.tpr10 = CONFIG_DRAM_SUN50I_H616_TPR10,
-	.tpr11 = CONFIG_DRAM_SUN50I_H616_TPR11,
-	.tpr12 = CONFIG_DRAM_SUN50I_H616_TPR12,
+	.dx_odt = CONFIG_DRAM_SUNXI_DX_ODT,
+	.dx_dri = CONFIG_DRAM_SUNXI_DX_DRI,
+	.ca_dri = CONFIG_DRAM_SUNXI_CA_DRI,
+	.odt_en = CONFIG_DRAM_SUNXI_ODT_EN,
+	.tpr0 = CONFIG_DRAM_SUNXI_TPR0,
+	.tpr2 = CONFIG_DRAM_SUNXI_TPR2,
+	.tpr6 = CONFIG_DRAM_SUNXI_TPR6,
+	.tpr10 = CONFIG_DRAM_SUNXI_TPR10,
+	.tpr11 = CONFIG_DRAM_SUNXI_TPR11,
+	.tpr12 = CONFIG_DRAM_SUNXI_TPR12,
 };
 
 unsigned long sunxi_dram_init(void)
diff --git a/configs/anbernic_rg35xx_h700_defconfig b/configs/anbernic_rg35xx_h700_defconfig
index cd3d6bfba06..c5c40a158d3 100644
--- a/configs/anbernic_rg35xx_h700_defconfig
+++ b/configs/anbernic_rg35xx_h700_defconfig
@@ -2,16 +2,16 @@ CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-h700-anbernic-rg35xx-2024"
 CONFIG_SPL=y
-CONFIG_DRAM_SUN50I_H616_DX_ODT=0x08080808
-CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
-CONFIG_DRAM_SUN50I_H616_CA_DRI=0x0e0e
-CONFIG_DRAM_SUN50I_H616_ODT_EN=0x7887bbbb
-CONFIG_DRAM_SUN50I_H616_TPR2=0x1
-CONFIG_DRAM_SUN50I_H616_TPR6=0x40808080
-CONFIG_DRAM_SUN50I_H616_TPR10=0x402f6633
-CONFIG_DRAM_SUN50I_H616_TPR11=0x1b1f1e1c
-CONFIG_DRAM_SUN50I_H616_TPR12=0x06060606
-CONFIG_DRAM_SUN50I_H616_PHY_ADDR_MAP_1=y
+CONFIG_DRAM_SUNXI_DX_ODT=0x08080808
+CONFIG_DRAM_SUNXI_DX_DRI=0x0e0e0e0e
+CONFIG_DRAM_SUNXI_CA_DRI=0x0e0e
+CONFIG_DRAM_SUNXI_ODT_EN=0x7887bbbb
+CONFIG_DRAM_SUNXI_TPR2=0x1
+CONFIG_DRAM_SUNXI_TPR6=0x40808080
+CONFIG_DRAM_SUNXI_TPR10=0x402f6633
+CONFIG_DRAM_SUNXI_TPR11=0x1b1f1e1c
+CONFIG_DRAM_SUNXI_TPR12=0x06060606
+CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1=y
 CONFIG_MACH_SUN50I_H616=y
 CONFIG_SUNXI_DRAM_H616_LPDDR4=y
 CONFIG_DRAM_CLK=672
diff --git a/configs/orangepi_zero2_defconfig b/configs/orangepi_zero2_defconfig
index f60ee7375da..f2265ea5179 100644
--- a/configs/orangepi_zero2_defconfig
+++ b/configs/orangepi_zero2_defconfig
@@ -2,10 +2,10 @@ CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-h616-orangepi-zero2"
 CONFIG_SPL=y
-CONFIG_DRAM_SUN50I_H616_DX_ODT=0x08080808
-CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
-CONFIG_DRAM_SUN50I_H616_CA_DRI=0x0e0e
-CONFIG_DRAM_SUN50I_H616_TPR10=0xf83438
+CONFIG_DRAM_SUNXI_DX_ODT=0x08080808
+CONFIG_DRAM_SUNXI_DX_DRI=0x0e0e0e0e
+CONFIG_DRAM_SUNXI_CA_DRI=0x0e0e
+CONFIG_DRAM_SUNXI_TPR10=0xf83438
 CONFIG_MACH_SUN50I_H616=y
 CONFIG_SUNXI_DRAM_H616_DDR3_1333=y
 CONFIG_USB1_VBUS_PIN="PC16"
diff --git a/configs/orangepi_zero2w_defconfig b/configs/orangepi_zero2w_defconfig
index cbb702d85b3..ec030f32403 100644
--- a/configs/orangepi_zero2w_defconfig
+++ b/configs/orangepi_zero2w_defconfig
@@ -2,14 +2,14 @@ CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-h618-orangepi-zero2w"
 CONFIG_SPL=y
-CONFIG_DRAM_SUN50I_H616_DX_ODT=0x07070707
-CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
-CONFIG_DRAM_SUN50I_H616_CA_DRI=0x0e0e
-CONFIG_DRAM_SUN50I_H616_ODT_EN=0xaaaaeeee
-CONFIG_DRAM_SUN50I_H616_TPR6=0x48808080
-CONFIG_DRAM_SUN50I_H616_TPR10=0x402f6663
-CONFIG_DRAM_SUN50I_H616_TPR11=0x26262524
-CONFIG_DRAM_SUN50I_H616_TPR12=0x100f100f
+CONFIG_DRAM_SUNXI_DX_ODT=0x07070707
+CONFIG_DRAM_SUNXI_DX_DRI=0x0e0e0e0e
+CONFIG_DRAM_SUNXI_CA_DRI=0x0e0e
+CONFIG_DRAM_SUNXI_ODT_EN=0xaaaaeeee
+CONFIG_DRAM_SUNXI_TPR6=0x48808080
+CONFIG_DRAM_SUNXI_TPR10=0x402f6663
+CONFIG_DRAM_SUNXI_TPR11=0x26262524
+CONFIG_DRAM_SUNXI_TPR12=0x100f100f
 CONFIG_MACH_SUN50I_H616=y
 CONFIG_SUNXI_DRAM_H616_LPDDR4=y
 CONFIG_DRAM_CLK=792
diff --git a/configs/orangepi_zero3_defconfig b/configs/orangepi_zero3_defconfig
index 4e9b0ec4d33..63f9a735378 100644
--- a/configs/orangepi_zero3_defconfig
+++ b/configs/orangepi_zero3_defconfig
@@ -2,14 +2,14 @@ CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-h618-orangepi-zero3"
 CONFIG_SPL=y
-CONFIG_DRAM_SUN50I_H616_DX_ODT=0x07070707
-CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
-CONFIG_DRAM_SUN50I_H616_CA_DRI=0x0e0e
-CONFIG_DRAM_SUN50I_H616_ODT_EN=0xaaaaeeee
-CONFIG_DRAM_SUN50I_H616_TPR6=0x44000000
-CONFIG_DRAM_SUN50I_H616_TPR10=0x402f6663
-CONFIG_DRAM_SUN50I_H616_TPR11=0x24242624
-CONFIG_DRAM_SUN50I_H616_TPR12=0x0f0f100f
+CONFIG_DRAM_SUNXI_DX_ODT=0x07070707
+CONFIG_DRAM_SUNXI_DX_DRI=0x0e0e0e0e
+CONFIG_DRAM_SUNXI_CA_DRI=0x0e0e
+CONFIG_DRAM_SUNXI_ODT_EN=0xaaaaeeee
+CONFIG_DRAM_SUNXI_TPR6=0x44000000
+CONFIG_DRAM_SUNXI_TPR10=0x402f6663
+CONFIG_DRAM_SUNXI_TPR11=0x24242624
+CONFIG_DRAM_SUNXI_TPR12=0x0f0f100f
 CONFIG_MACH_SUN50I_H616=y
 CONFIG_SUNXI_DRAM_H616_LPDDR4=y
 CONFIG_DRAM_CLK=792
diff --git a/configs/tanix_tx1_defconfig b/configs/tanix_tx1_defconfig
index 706306b1444..28cf9513c30 100644
--- a/configs/tanix_tx1_defconfig
+++ b/configs/tanix_tx1_defconfig
@@ -2,14 +2,14 @@ CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-h313-tanix-tx1"
 CONFIG_SPL=y
-CONFIG_DRAM_SUN50I_H616_DX_ODT=0x06060606
-CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0d0d0d0d
-CONFIG_DRAM_SUN50I_H616_CA_DRI=0x1919
-CONFIG_DRAM_SUN50I_H616_ODT_EN=0x9988eeee
-CONFIG_DRAM_SUN50I_H616_TPR6=0x2fb08080
-CONFIG_DRAM_SUN50I_H616_TPR10=0x402f4469
-CONFIG_DRAM_SUN50I_H616_TPR11=0x0e0f0d0d
-CONFIG_DRAM_SUN50I_H616_TPR12=0x11131213
+CONFIG_DRAM_SUNXI_DX_ODT=0x06060606
+CONFIG_DRAM_SUNXI_DX_DRI=0x0d0d0d0d
+CONFIG_DRAM_SUNXI_CA_DRI=0x1919
+CONFIG_DRAM_SUNXI_ODT_EN=0x9988eeee
+CONFIG_DRAM_SUNXI_TPR6=0x2fb08080
+CONFIG_DRAM_SUNXI_TPR10=0x402f4469
+CONFIG_DRAM_SUNXI_TPR11=0x0e0f0d0d
+CONFIG_DRAM_SUNXI_TPR12=0x11131213
 CONFIG_MACH_SUN50I_H616=y
 CONFIG_SUNXI_DRAM_H616_LPDDR3=y
 CONFIG_R_I2C_ENABLE=y
diff --git a/configs/transpeed-8k618-t_defconfig b/configs/transpeed-8k618-t_defconfig
index 1d5a0c264b3..221614762e8 100644
--- a/configs/transpeed-8k618-t_defconfig
+++ b/configs/transpeed-8k618-t_defconfig
@@ -2,13 +2,13 @@ CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-h618-transpeed-8k618-t"
 CONFIG_SPL=y
-CONFIG_DRAM_SUN50I_H616_DX_ODT=0x03030303
-CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
-CONFIG_DRAM_SUN50I_H616_CA_DRI=0x1f12
-CONFIG_DRAM_SUN50I_H616_TPR0=0xc0001002
-CONFIG_DRAM_SUN50I_H616_TPR10=0x2f1107
-CONFIG_DRAM_SUN50I_H616_TPR11=0xddddcccc
-CONFIG_DRAM_SUN50I_H616_TPR12=0xeddc7665
+CONFIG_DRAM_SUNXI_DX_ODT=0x03030303
+CONFIG_DRAM_SUNXI_DX_DRI=0x0e0e0e0e
+CONFIG_DRAM_SUNXI_CA_DRI=0x1f12
+CONFIG_DRAM_SUNXI_TPR0=0xc0001002
+CONFIG_DRAM_SUNXI_TPR10=0x2f1107
+CONFIG_DRAM_SUNXI_TPR11=0xddddcccc
+CONFIG_DRAM_SUNXI_TPR12=0xeddc7665
 CONFIG_MACH_SUN50I_H616=y
 CONFIG_SUNXI_DRAM_H616_DDR3_1333=y
 CONFIG_DRAM_CLK=648
diff --git a/configs/x96_mate_defconfig b/configs/x96_mate_defconfig
index f876cc91f6e..bd9b611d6f5 100644
--- a/configs/x96_mate_defconfig
+++ b/configs/x96_mate_defconfig
@@ -2,13 +2,13 @@ CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-h616-x96-mate"
 CONFIG_SPL=y
-CONFIG_DRAM_SUN50I_H616_DX_ODT=0x03030303
-CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
-CONFIG_DRAM_SUN50I_H616_CA_DRI=0x1c12
-CONFIG_DRAM_SUN50I_H616_TPR0=0xc0000c05
-CONFIG_DRAM_SUN50I_H616_TPR10=0x2f0007
-CONFIG_DRAM_SUN50I_H616_TPR11=0xffffdddd
-CONFIG_DRAM_SUN50I_H616_TPR12=0xfedf7557
+CONFIG_DRAM_SUNXI_DX_ODT=0x03030303
+CONFIG_DRAM_SUNXI_DX_DRI=0x0e0e0e0e
+CONFIG_DRAM_SUNXI_CA_DRI=0x1c12
+CONFIG_DRAM_SUNXI_TPR0=0xc0000c05
+CONFIG_DRAM_SUNXI_TPR10=0x2f0007
+CONFIG_DRAM_SUNXI_TPR11=0xffffdddd
+CONFIG_DRAM_SUNXI_TPR12=0xfedf7557
 CONFIG_MACH_SUN50I_H616=y
 CONFIG_SUNXI_DRAM_H616_DDR3_1333=y
 CONFIG_R_I2C_ENABLE=y
-- 
2.46.2

