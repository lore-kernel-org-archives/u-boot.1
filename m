Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCE8C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 23:20:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70DA382CA0;
	Fri, 13 Jun 2025 01:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0EA582B0F; Fri, 13 Jun 2025 01:19:59 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B66A6828A2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 01:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F5E31D31;
 Thu, 12 Jun 2025 16:19:37 -0700 (PDT)
Received: from e134369.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0040F3F59E;
 Thu, 12 Jun 2025 16:19:55 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 2/2] sunxi: H616: add support for YuzukiHD Chameleon board
Date: Fri, 13 Jun 2025 00:19:45 +0100
Message-ID: <20250612231945.981893-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250612231945.981893-1-andre.przywara@arm.com>
References: <20250612231945.981893-1-andre.przywara@arm.com>
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

The Chameleon board is an OpenHardware devboard made by YuzukiTsuru,
featuring an Allwinner H616 SoC. The form factor resembles the Raspberry
Pi Model A boards, though it differs significantly in its features.
Apart from the usual peripherals of those kind of boards (SD card, eMMC,
WiFi, HDMI), it features four USB-C 2.0 ports.

Add a defconfig for the board, the DRAM parameters have been extracted
from the firmware shipped with the board.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 configs/yuzukihd-chameleon_defconfig | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 configs/yuzukihd-chameleon_defconfig

diff --git a/configs/yuzukihd-chameleon_defconfig b/configs/yuzukihd-chameleon_defconfig
new file mode 100644
index 00000000000..883be12c4ef
--- /dev/null
+++ b/configs/yuzukihd-chameleon_defconfig
@@ -0,0 +1,30 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-h618-yuzukihd-chameleon"
+CONFIG_SPL=y
+CONFIG_DRAM_SUNXI_DX_ODT=0x03030303
+CONFIG_DRAM_SUNXI_DX_DRI=0x0e0e0e0e
+CONFIG_DRAM_SUNXI_CA_DRI=0x1c12
+CONFIG_DRAM_SUNXI_ODT_EN=0x1
+CONFIG_DRAM_SUNXI_TPR6=0x33808080
+CONFIG_DRAM_SUNXI_TPR10=0x002f0006
+CONFIG_DRAM_SUNXI_TPR11=0xddddcccc
+CONFIG_DRAM_SUNXI_TPR12=0xeddc7564
+CONFIG_MACH_SUN50I_H616=y
+CONFIG_SUNXI_DRAM_H616_DDR3_1333=y
+CONFIG_DRAM_CLK=648
+CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_R_I2C_ENABLE=y
+CONFIG_SPL_SPI_SUNXI=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SLAVE=0x7f
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_AXP313_POWER=y
+CONFIG_AXP_DCDC3_VOLT=1500
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_MUSB_GADGET=y
-- 
2.43.0

