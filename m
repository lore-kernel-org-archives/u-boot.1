Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADB0C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 00:19:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B0488CFF;
	Wed, 24 Apr 2024 02:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C47F88CFA; Wed, 24 Apr 2024 02:18:35 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D8D9E88CF1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 02:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF948339;
 Tue, 23 Apr 2024 17:18:58 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D9493F7BD;
 Tue, 23 Apr 2024 17:18:30 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Subject: [PATCH 4/4] sunxi: H616: add Tanix TX1 support
Date: Wed, 24 Apr 2024 01:18:08 +0100
Message-Id: <20240424001808.14388-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240424001808.14388-1-andre.przywara@arm.com>
References: <20240424001808.14388-1-andre.przywara@arm.com>
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

The Tanix TX1 is a tiny TV box, featuring the Allwinner H313 SoC with up
to 2GB of DRAM and 16GB of eMMC. There is no SD card or Ethernet port on
this small device, but it can be booted via the USB debug "FEL" mode.
The bootloader could then be written to the eMMC.

Add the defconfig for that board, and add the devicetree file to the
Makefile, for it to be built.
The DRAM parameters were taken from the vendor firmware on the eMMC.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/dts/Makefile       |  1 +
 configs/tanix_tx1_defconfig | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 configs/tanix_tx1_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 127345975ef..69b0d6a9ad7 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -779,6 +779,7 @@ dtb-$(CONFIG_MACH_SUN50I_H6) += \
 	sun50i-h6-tanix-tx6.dtb \
 	sun50i-h6-tanix-tx6-mini.dtb
 dtb-$(CONFIG_MACH_SUN50I_H616) += \
+	sun50i-h313-tanix-tx1.dtb \
 	sun50i-h616-orangepi-zero2.dtb \
 	sun50i-h618-orangepi-zero2w.dtb \
 	sun50i-h618-orangepi-zero3.dtb \
diff --git a/configs/tanix_tx1_defconfig b/configs/tanix_tx1_defconfig
new file mode 100644
index 00000000000..9915fff4a00
--- /dev/null
+++ b/configs/tanix_tx1_defconfig
@@ -0,0 +1,25 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun50i-h313-tanix-tx1"
+CONFIG_SPL=y
+CONFIG_DRAM_SUN50I_H616_DX_ODT=0x06060606
+CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0d0d0d0d
+CONFIG_DRAM_SUN50I_H616_CA_DRI=0x1919
+CONFIG_DRAM_SUN50I_H616_ODT_EN=0x9988eeee
+CONFIG_DRAM_SUN50I_H616_TPR6=0x2fb08080
+CONFIG_DRAM_SUN50I_H616_TPR10=0x402f4469
+CONFIG_DRAM_SUN50I_H616_TPR11=0x0e0f0d0d
+CONFIG_DRAM_SUN50I_H616_TPR12=0x11131213
+CONFIG_MACH_SUN50I_H616=y
+CONFIG_SUNXI_DRAM_H616_LPDDR3=y
+CONFIG_R_I2C_ENABLE=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SLAVE=0x7f
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_AXP313_POWER=y
+CONFIG_AXP_DCDC3_VOLT=1200
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
-- 
2.35.8

