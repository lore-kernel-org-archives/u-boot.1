Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240FDC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 01:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E901878B0;
	Mon,  4 Dec 2023 02:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C83BA87076; Mon,  4 Dec 2023 02:01:31 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A2C88878E5
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 02:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14E47106F;
 Sun,  3 Dec 2023 17:02:06 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AB8B3F6C4;
 Sun,  3 Dec 2023 17:01:17 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Vignesh R <vigneshr@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
 Bob McChesney <bob@electricworry.net>,
 Stephen Graf <stephen.graf@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH v2 3/3] sunxi: H616: Add OrangePi Zero 3 board support
Date: Mon,  4 Dec 2023 00:59:54 +0000
Message-Id: <20231204005954.13201-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20231204005954.13201-1-andre.przywara@arm.com>
References: <20231204005954.13201-1-andre.przywara@arm.com>
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

The OrangePi Zero 3 is a small development board featuring the Allwinner
H618 SoC, shipping with up to 4GB of DRAM, Gigabit Ethernet, a micro-HDMI
connector and two USB sockets.
The board uses LPDDR4 DRAM and an X-Powers AXP313a PMIC, support for
which was recently added to U-Boot.

Add a defconfig file selecting the right drivers and DRAM options.
Since the .dts file was synced from the Linux kernel repo already, we
just need to add one line to the Makefile to actually build the .dtb.

The DRAM parameters were derived from the values found in the BSP DRAM
drivers on the SPI NOR flash.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Mikhail Kalashnikov <iuncuim@gmail.com>
Tested-by: Bob McChesney <bob@electricworry.net>
---
 arch/arm/dts/Makefile            |  1 +
 board/sunxi/MAINTAINERS          |  5 +++++
 configs/orangepi_zero3_defconfig | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)
 create mode 100644 configs/orangepi_zero3_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 1be08c5fdc2..5fc888680b3 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -835,6 +835,7 @@ dtb-$(CONFIG_MACH_SUN50I_H6) += \
 	sun50i-h6-tanix-tx6-mini.dtb
 dtb-$(CONFIG_MACH_SUN50I_H616) += \
 	sun50i-h616-orangepi-zero2.dtb \
+	sun50i-h618-orangepi-zero3.dtb \
 	sun50i-h616-x96-mate.dtb
 dtb-$(CONFIG_MACH_SUN50I) += \
 	sun50i-a64-amarula-relic.dtb \
diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index 00614372119..f556857a391 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -455,6 +455,11 @@ M:	Jernej Skrabec <jernej.skrabec@siol.net>
 S:	Maintained
 F:	configs/orangepi_zero2_defconfig
 
+ORANGEPI ZERO 3 BOARD
+M:	Andre Przywara <andre.przywara@arm.com>
+S:	Maintained
+F:	configs/orangepi_zero3_defconfig
+
 ORANGEPI PC 2 BOARD
 M:	Andre Przywara <andre.przywara@arm.com>
 S:	Maintained
diff --git a/configs/orangepi_zero3_defconfig b/configs/orangepi_zero3_defconfig
new file mode 100644
index 00000000000..5a019fed84b
--- /dev/null
+++ b/configs/orangepi_zero3_defconfig
@@ -0,0 +1,32 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun50i-h618-orangepi-zero3"
+CONFIG_SPL=y
+CONFIG_DRAM_SUN50I_H616_DX_ODT=0x07070707
+CONFIG_DRAM_SUN50I_H616_DX_DRI=0x0e0e0e0e
+CONFIG_DRAM_SUN50I_H616_CA_DRI=0x0e0e
+CONFIG_DRAM_SUN50I_H616_ODT_EN=0xaaaaeeee
+CONFIG_DRAM_SUN50I_H616_TPR6=0x44000000
+CONFIG_DRAM_SUN50I_H616_TPR10=0x402f6663
+CONFIG_DRAM_SUN50I_H616_TPR11=0x24242624
+CONFIG_DRAM_SUN50I_H616_TPR12=0x0f0f100f
+CONFIG_MACH_SUN50I_H616=y
+CONFIG_SUNXI_DRAM_H616_LPDDR4=y
+CONFIG_DRAM_CLK=792
+CONFIG_USB1_VBUS_PIN="PC16"
+CONFIG_R_I2C_ENABLE=y
+CONFIG_SPL_SPI_SUNXI=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SLAVE=0x7f
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_SPI_FLASH_ZBIT=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_SUN8I_EMAC=y
+CONFIG_AXP313_POWER=y
+CONFIG_SPI=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_MUSB_GADGET=y
-- 
2.35.8

