Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096F1109C059
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F96183FB6;
	Wed, 25 Mar 2026 20:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="yLMBUZuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C4AD840AE; Wed, 25 Mar 2026 20:27:28 +0100 (CET)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AFE583FA7
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
 bh=xefSctjPuuAIiDQIo2+rCMrMoGaL2bChSeJJ0RrE7XU=;
 b=yLMBUZuhFTgTFbdUf3wzeUdo/DWeVMWJyPPy+JuDoZoid3LZSo4q+zXCjxaNbFO/+L7xbr7kjbusLGF/OyX34DgsDbajg39L+VD3XqCrs/mQtnVmUe4K4EPjawGMQpcgitr+6pgmLE0zhW+FB7d4bKtlRUE0EQhgphakF5J72uY=
Received: from lukas-hpz440workstation.lan.sk100508.local
 (193-80-178-216.hdsl.highway.telekom.at [193.80.178.216])
 by mail.netcube.li with ESMTPA ; Wed, 25 Mar 2026 20:27:25 +0100
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	u-boot@lists.denx.de
Subject: [PATCH 6/6] sunxi: add support for NetCube Systems Nagami and
 associated carrier boards
Date: Wed, 25 Mar 2026 20:26:13 +0100
Message-ID: <20260325192628.750398-7-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325192628.750398-1-lukas.schmid@netcube.li>
References: <20260325192628.750398-1-lukas.schmid@netcube.li>
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

NetCube Systems Nagami is a system-on-module based on the Allwinner
T113-S3 and T113-S4 series chips.

Its features include:
* Dual ARM Cortex-A7 @ 1.2 GHz
* 128/256 MiB DDR3 memory, 4 GiB eMMC
* 10/100 Ethernet PHY
* 1x USB 2.0 OTG, 1x USB 2.0 host
* 1x SPI interface with HOLD/WP
* Up to 5 UARTs (2 with RTS/CTS)
* Up to 4 I2C interfaces
* Up to 2 CAN 2.0B interfaces
* Up to 2 I2S/PCM interfaces
* Up to 1 SPDIF input and output
* I2C extension interface with INT

Add defconfigs for the basic carrier and keypad carrier variants,
plus a secure-boot example defconfig for the basic carrier.

The basic carrier brings out the SD interface to a microSD slot, the
USB host to USB-A, and USB OTG to micro-B. It has an Ethernet
MagJack and exposes CAN, I2C, SPI, I2S and GPIO signals on pin
headers.

The keypad carrier adds an I2C-connected PN532 NFC reader, a 4x3
keypad, Ethernet with PoE, a USB mini-B diagnostics port, and a
two-colour status LED.

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
 .../netcube_nagami_basic_carrier_defconfig    | 43 +++++++++++++++
 ..._nagami_basic_carrier_secureboot_defconfig | 52 +++++++++++++++++++
 .../netcube_nagami_keypad_carrier_defconfig   | 43 +++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 configs/netcube_nagami_basic_carrier_defconfig
 create mode 100644 configs/netcube_nagami_basic_carrier_secureboot_defconfig
 create mode 100644 configs/netcube_nagami_keypad_carrier_defconfig

diff --git a/configs/netcube_nagami_basic_carrier_defconfig b/configs/netcube_nagami_basic_carrier_defconfig
new file mode 100644
index 00000000000..ab56479545d
--- /dev/null
+++ b/configs/netcube_nagami_basic_carrier_defconfig
@@ -0,0 +1,43 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun8i-t113s-netcube-nagami-basic-carrier"
+CONFIG_DRAM_CLK=792
+CONFIG_SPL=y
+CONFIG_DRAM_SUNXI_ODT_EN=0
+CONFIG_DRAM_SUNXI_TPR0=0x004a2195
+CONFIG_DRAM_SUNXI_TPR11=0x340000
+CONFIG_DRAM_SUNXI_TPR12=0x46
+CONFIG_DRAM_SUNXI_TPR13=0x34000100
+CONFIG_MACH_SUN8I_R528=y
+CONFIG_DRAM_ZQ=8092667
+CONFIG_SUNXI_MINIMUM_DRAM_MB=128
+CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_BOOTDELAY=1
+CONFIG_PREBOOT="gpio set PD9"
+# CONFIG_SYS_DEVICE_NULLDEV is not set
+# CONFIG_SYS_MMCSD_FS_BOOT is not set
+CONFIG_SYS_PROMPT="Nagami> "
+CONFIG_CMD_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_BUS=1
+CONFIG_CMD_I2C=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_HOSTNAME=y
+CONFIG_HOSTNAME="nagami"
+CONFIG_VERSION_VARIABLE=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_MISC=y
+CONFIG_NVMEM=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x50
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_RMII=y
+CONFIG_SUN8I_EMAC=y
+CONFIG_CONS_INDEX=4
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_MUSB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
diff --git a/configs/netcube_nagami_basic_carrier_secureboot_defconfig b/configs/netcube_nagami_basic_carrier_secureboot_defconfig
new file mode 100644
index 00000000000..65bf42299f8
--- /dev/null
+++ b/configs/netcube_nagami_basic_carrier_secureboot_defconfig
@@ -0,0 +1,52 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun8i-t113s-netcube-nagami-basic-carrier"
+CONFIG_DRAM_CLK=792
+CONFIG_SPL=y
+CONFIG_DRAM_SUNXI_ODT_EN=0
+CONFIG_DRAM_SUNXI_TPR0=0x004a2195
+CONFIG_DRAM_SUNXI_TPR11=0x340000
+CONFIG_DRAM_SUNXI_TPR12=0x46
+CONFIG_DRAM_SUNXI_TPR13=0x34000100
+CONFIG_MACH_SUN8I_R528=y
+CONFIG_DRAM_ZQ=8092667
+CONFIG_SUNXI_MINIMUM_DRAM_MB=128
+CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_SPL_IMAGE_TYPE_SUNXI_TOC0=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_PRINT=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_BOOTDELAY=1
+CONFIG_PREBOOT="gpio set PD9"
+# CONFIG_SYS_DEVICE_NULLDEV is not set
+CONFIG_SPL_MAX_SIZE=0x17fa0
+CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
+# CONFIG_SYS_MMCSD_FS_BOOT is not set
+CONFIG_SYS_PROMPT="Nagami> "
+CONFIG_CMD_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_BUS=1
+CONFIG_CMD_I2C=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_HOSTNAME=y
+CONFIG_HOSTNAME="nagami"
+CONFIG_VERSION_VARIABLE=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_MISC=y
+CONFIG_NVMEM=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x50
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_RMII=y
+CONFIG_SUN8I_EMAC=y
+CONFIG_CONS_INDEX=4
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_MUSB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
diff --git a/configs/netcube_nagami_keypad_carrier_defconfig b/configs/netcube_nagami_keypad_carrier_defconfig
new file mode 100644
index 00000000000..c4d44e9dddc
--- /dev/null
+++ b/configs/netcube_nagami_keypad_carrier_defconfig
@@ -0,0 +1,43 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun8i-t113s-netcube-nagami-keypad-carrier"
+CONFIG_DRAM_CLK=792
+CONFIG_SPL=y
+CONFIG_DRAM_SUNXI_ODT_EN=0
+CONFIG_DRAM_SUNXI_TPR0=0x004a2195
+CONFIG_DRAM_SUNXI_TPR11=0x340000
+CONFIG_DRAM_SUNXI_TPR12=0x46
+CONFIG_DRAM_SUNXI_TPR13=0x34000100
+CONFIG_MACH_SUN8I_R528=y
+CONFIG_DRAM_ZQ=8092667
+CONFIG_SUNXI_MINIMUM_DRAM_MB=128
+CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_BOOTDELAY=1
+CONFIG_PREBOOT="gpio set PD9"
+# CONFIG_SYS_DEVICE_NULLDEV is not set
+# CONFIG_SYS_MMCSD_FS_BOOT is not set
+CONFIG_SYS_PROMPT="Nagami> "
+CONFIG_CMD_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_BUS=1
+CONFIG_CMD_I2C=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_HOSTNAME=y
+CONFIG_HOSTNAME="nagami"
+CONFIG_VERSION_VARIABLE=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_MISC=y
+CONFIG_NVMEM=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x50
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_RMII=y
+CONFIG_SUN8I_EMAC=y
+CONFIG_CONS_INDEX=4
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_MUSB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
-- 
2.47.3


