Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3AFC3ABC9
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 01:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 461C78295C;
	Sun, 11 May 2025 03:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26C1E82A3B; Sun, 11 May 2025 03:10:23 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3BCD48091A
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 03:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B12CB1516;
 Sat, 10 May 2025 18:10:09 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 759853F58B;
 Sat, 10 May 2025 18:10:19 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Philippe Simons <simons.philippe@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 6/6] sunxi: add support for Liontron H-A133L board
Date: Sun, 11 May 2025 02:10:03 +0100
Message-ID: <20250511011003.15654-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250511011003.15654-1-andre.przywara@arm.com>
References: <20250511011003.15654-1-andre.przywara@arm.com>
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

The Liontron H-A133L is an industrial development board based on the
Allwinner A133 SoC. It uses LPDDR4 DRAM, eMMC, and an AXP707 PMIC.

Add a defconfig with the required DRAM settings.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 configs/liontron-h-a133l_defconfig | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 configs/liontron-h-a133l_defconfig

diff --git a/configs/liontron-h-a133l_defconfig b/configs/liontron-h-a133l_defconfig
new file mode 100644
index 00000000000..4b769768e5f
--- /dev/null
+++ b/configs/liontron-h-a133l_defconfig
@@ -0,0 +1,37 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-a133-liontron-h-a133l"
+CONFIG_SPL=y
+CONFIG_DRAM_SUNXI_DX_ODT=0x7070707
+CONFIG_DRAM_SUNXI_DX_DRI=0xd0d0d0d
+CONFIG_DRAM_SUNXI_CA_DRI=0xe0e
+CONFIG_DRAM_SUNXI_PARA0=0xd0a050c
+CONFIG_DRAM_SUNXI_MR11=0x4
+CONFIG_DRAM_SUNXI_MR12=0x72
+CONFIG_DRAM_SUNXI_MR13=0x0
+CONFIG_DRAM_SUNXI_MR14=0x7
+CONFIG_DRAM_SUNXI_TPR1=0x26
+CONFIG_DRAM_SUNXI_TPR2=0x6060606
+CONFIG_DRAM_SUNXI_TPR3=0x84040404
+CONFIG_DRAM_SUNXI_TPR6=0x48000000
+CONFIG_DRAM_SUNXI_TPR10=0x273333
+CONFIG_DRAM_SUNXI_TPR11=0x231d151c
+CONFIG_DRAM_SUNXI_TPR12=0x1212110e
+CONFIG_DRAM_SUNXI_TPR13=0x7521
+CONFIG_DRAM_SUNXI_TPR14=0x2023211f
+CONFIG_MACH_SUN50I_A133=y
+CONFIG_DRAM_CLK=792
+CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_SUNXI_DRAM_A133_LPDDR4=y
+CONFIG_R_I2C_ENABLE=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SLAVE=0x7f
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_AXP803_POWER=y
+CONFIG_AXP_DCDC5_VOLT=1100
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
-- 
2.46.3

