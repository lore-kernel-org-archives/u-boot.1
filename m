Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B9BC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 05:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33A2A82B7C;
	Tue, 10 Jun 2025 07:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="A2zm/nkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73A1E82AE9; Tue, 10 Jun 2025 07:39:25 +0200 (CEST)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7800A8070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 07:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
 bh=kw06BSE0u529N0Hpne8GdNfbq3B5rz++ebPvac4ZRec=;
 b=A2zm/nkQ61pgpBWjRXPEZcFbKGIiLvE2sjJJFruD+3TFWzV30Cr2NSZwt7Xv3YUglzPLx8lpjn1MKLKHXupp6UmXMMnIc/G54zPe7o32XIs8GPMbK67Zziy3sJF/THADtIjmf7M78q+h3hf4TZXj948PozvfqTYtpu9loQMEcHk=
Received: from lukas-hpz440workstation.lan.sk100508.local (cm70-231.liwest.at
 [212.241.70.231]) by mail.netcube.li with ESMTPA
 ; Tue, 10 Jun 2025 07:39:22 +0200
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Hans de Goede <hdegoede@redhat.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/2] configs: add support for NetCube Systems Kumquat
Date: Tue, 10 Jun 2025 07:38:55 +0200
Message-Id: <20250610053856.1873969-3-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610053856.1873969-1-lukas.schmid@netcube.li>
References: <20250610053856.1873969-1-lukas.schmid@netcube.li>
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

NetCube Systems Kumquat is a board based on the Allwinner V3s SoC,
including:

- 64MB DDR2 included in SoC
- 10/100 Mbps Ethernet
- USB-C DRD
- Audio Codec
- Isolated CAN-FD
- ESP32 over SDIO
- 8MB SPI-NOR Flash for bootloader
- I2C EEPROM for MAC addresses
- SDIO Connector for eMMC or SD-Card
- 8x 12/24V IOs, 4x normally open relays
- DS3232 RTC with Battery Backup
- QWIIC connectors for external I2C devices

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
 configs/netcube_kumquat_defconfig | 45 +++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 configs/netcube_kumquat_defconfig

diff --git a/configs/netcube_kumquat_defconfig b/configs/netcube_kumquat_defconfig
new file mode 100644
index 00000000..cfe331cb
--- /dev/null
+++ b/configs/netcube_kumquat_defconfig
@@ -0,0 +1,45 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun8i-v3s-netcube-kumquat"
+CONFIG_SPL=y
+CONFIG_MACH_SUN8I_V3S=y
+CONFIG_DRAM_CLK=360
+CONFIG_SPL_SPI_SUNXI=y
+# CONFIG_HAS_ARMV7_SECURE_BASE is not set
+# CONFIG_TIMESTAMP is not set
+CONFIG_BOOTDELAY=1
+CONFIG_PREBOOT=""
+# CONFIG_SYS_DEVICE_NULLDEV is not set
+CONFIG_SPL_MTD=y
+CONFIG_SYS_PROMPT="Kumquat> "
+CONFIG_CMD_EEPROM=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MTD=y
+CONFIG_MTDIDS_DEFAULT="nor0=firmware"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=firmware:960k(u-boot)ro,64k(u-boot-env),-(user)"
+CONFIG_CMD_DIAG=y
+CONFIG_OF_UPSTREAM=y
+# CONFIG_ENV_IS_IN_FAT is not set
+CONFIG_ENV_SPI_MAX_HZ=1000000
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_HOSTNAME=y
+CONFIG_HOSTNAME="kumquat"
+CONFIG_VERSION_VARIABLE=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_MISC=y
+CONFIG_NVMEM=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x50
+CONFIG_MTD=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_SUN8I_EMAC=y
+CONFIG_PHY_SUN4I_USB=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_DS3232=y
+CONFIG_SPI=y
+CONFIG_USB_MUSB_HOST=y
+CONFIG_USB_MUSB_GADGET=y
+# CONFIG_USB_ETHER is not set
-- 
2.39.5


