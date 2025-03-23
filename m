Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527FAC28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD8C81DB4;
	Sun, 23 Mar 2025 12:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 281C781E60; Sun, 23 Mar 2025 12:36:58 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 70B8181DDF
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9694D106F;
 Sun, 23 Mar 2025 04:37:00 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD7D53F694;
 Sun, 23 Mar 2025 04:36:52 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 34/34] sunxi: A523: add defconfigs for three boards
Date: Sun, 23 Mar 2025 11:35:44 +0000
Message-ID: <20250323113544.7933-35-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250323113544.7933-1-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
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

So far developers seem to use three popular boards:
- Avaota A1: dev board with USB 3.0, dual Ethernet, small display
- X96QPro+: TV box with Gigabit Ethernet, USB 3.0, eMMC
- Radxa A5E: small dev board with USB3/M.2 2230 (muxed), dual Ethernet

Add the defconfig files for those boards, containing the DRAM parameters
and the usual Kconfig options.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 configs/avaota-a1_defconfig     | 31 +++++++++++++++++++++++++++++++
 configs/radxa-a5e_defconfig     | 30 ++++++++++++++++++++++++++++++
 configs/x96q_pro_plus_defconfig | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 configs/avaota-a1_defconfig
 create mode 100644 configs/radxa-a5e_defconfig
 create mode 100644 configs/x96q_pro_plus_defconfig

diff --git a/configs/avaota-a1_defconfig b/configs/avaota-a1_defconfig
new file mode 100644
index 00000000000..8721f2f5d1d
--- /dev/null
+++ b/configs/avaota-a1_defconfig
@@ -0,0 +1,31 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun55i-t527-avaota-a1"
+CONFIG_SPL=y
+CONFIG_DRAM_SUNXI_DX_ODT=0x07070707
+CONFIG_DRAM_SUNXI_DX_DRI=0x0d0d0d0d
+CONFIG_DRAM_SUNXI_CA_DRI=0x0e0e
+CONFIG_DRAM_SUNXI_ODT_EN=0x84848484
+CONFIG_DRAM_SUNXI_TPR0=0x80808080
+CONFIG_DRAM_SUNXI_TPR1=0x06060606
+CONFIG_DRAM_SUNXI_TPR6=0x38000000
+CONFIG_DRAM_SUNXI_TPR10=0x802f3333
+CONFIG_DRAM_SUNXI_TPR11=0xc7c5c4c2
+CONFIG_DRAM_SUNXI_TPR12=0x3533302f
+CONFIG_MACH_SUN55I_A523=y
+CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_R_I2C_ENABLE=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SLAVE=0x7f
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_REGULATOR_AXP=y
+CONFIG_AXP717_POWER=y
+CONFIG_AXP_I2C_ADDRESS=0x35
+CONFIG_AXP_DCDC2_VOLT=920
+CONFIG_AXP_DCDC3_VOLT=1160
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
diff --git a/configs/radxa-a5e_defconfig b/configs/radxa-a5e_defconfig
new file mode 100644
index 00000000000..47c02fef7bd
--- /dev/null
+++ b/configs/radxa-a5e_defconfig
@@ -0,0 +1,30 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun55i-a527-radxa-a5e"
+CONFIG_SPL=y
+CONFIG_DRAM_SUNXI_DX_ODT=0x07070707
+CONFIG_DRAM_SUNXI_DX_DRI=0x0d0d0d0d
+CONFIG_DRAM_SUNXI_CA_DRI=0x0e0e
+CONFIG_DRAM_SUNXI_ODT_EN=0x84848484
+CONFIG_DRAM_SUNXI_TPR0=0x80808080
+CONFIG_DRAM_SUNXI_TPR1=0x06060606
+CONFIG_DRAM_SUNXI_TPR6=0x38000000
+CONFIG_DRAM_SUNXI_TPR10=0x802f3333
+CONFIG_DRAM_SUNXI_TPR11=0xc7c5c4c2
+CONFIG_DRAM_SUNXI_TPR12=0x3533302f
+# BSP value: CONFIG_DRAM_SUNXI_TPR11=0xc6c4c2c0
+# BSP value: CONFIG_DRAM_SUNXI_TPR12=0x3a373233
+CONFIG_MACH_SUN55I_A523=y
+CONFIG_R_I2C_ENABLE=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SLAVE=0x7f
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_REGULATOR_AXP=y
+CONFIG_AXP717_POWER=y
+CONFIG_AXP_DCDC2_VOLT=920
+CONFIG_AXP_DCDC3_VOLT=1100
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
diff --git a/configs/x96q_pro_plus_defconfig b/configs/x96q_pro_plus_defconfig
new file mode 100644
index 00000000000..b6bb18860f9
--- /dev/null
+++ b/configs/x96q_pro_plus_defconfig
@@ -0,0 +1,33 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun55i-h728-x96qpro+"
+CONFIG_SPL=y
+CONFIG_DRAM_SUNXI_DX_ODT=0x07070707
+CONFIG_DRAM_SUNXI_DX_DRI=0x0c0c0c0c
+CONFIG_DRAM_SUNXI_CA_DRI=0x0e0e
+CONFIG_DRAM_SUNXI_ODT_EN=0x90909090
+CONFIG_DRAM_SUNXI_TPR0=0x80808080
+CONFIG_DRAM_SUNXI_TPR1=0x06060606
+CONFIG_DRAM_SUNXI_TPR6=0x3380807e
+CONFIG_DRAM_SUNXI_TPR10=0x802f7788
+CONFIG_DRAM_SUNXI_TPR11=0x8f919190
+CONFIG_DRAM_SUNXI_TPR12=0x22222723
+CONFIG_MACH_SUN55I_A523=y
+CONFIG_SUNXI_DRAM_A523_DDR3=y
+CONFIG_DRAM_CLK=792
+CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_USB1_VBUS_PIN="PI12"
+CONFIG_R_I2C_ENABLE=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SLAVE=0x7f
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_REGULATOR_AXP=y
+CONFIG_AXP717_POWER=y
+CONFIG_AXP_DCDC2_VOLT=920
+CONFIG_AXP_DCDC3_VOLT=1360
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
-- 
2.46.3

