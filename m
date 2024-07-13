Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375EFC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 14:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 439EC8874D;
	Sat, 13 Jul 2024 16:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tSnzkFsG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE88B887EB; Sat, 13 Jul 2024 16:38:43 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A7D288747
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 16:38:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-708adad61f8so1447800a34.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 07:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720881520; x=1721486320; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0kmWQ3KDzBKta0dPYybxcFf6vUd5fCmsNVUmF7CoP0=;
 b=tSnzkFsGLi2Z8tqiX6VA8hI4D5zIWj7D7rCuyWqxvrqIkDn1cNQabN/cSZiibAvQDd
 F5imBYFA5JZxF+hMchksp2mfN68buluLq+/ot/XZTg1nMjMpUKDGink+54xWzQOu0WBe
 EJAXG2GmhjGhiWHMH/p8w/hyLUdhgy7YOzXt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720881520; x=1721486320;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q0kmWQ3KDzBKta0dPYybxcFf6vUd5fCmsNVUmF7CoP0=;
 b=e/ogHzBu+Vf937VaL3xgG6qTlse+Ese/VCSYRJhjyZK0qZQ454YWRHqIzlw5bBhUzb
 EjSMBWmidxHoDjH6JsweAgyC4buyEoH9L2VeTKJ01b8eTmogHp8v3l+NcxmvcTtnLxdO
 Mpk+3gNf/r5+v+4TWoYmoTz3T3JcU5ebUFxlgzq+96jIQQNCWNcgbTqaDQreJMG8HrDn
 bTfjbUgTXCQd5llU+1x7qIIFJhRQx1AwuxPg1ql58KaMnT9qFfKCpe3MGXMlksR2CzH2
 7Mfr5R0T8mPSldjg3TTSYLxHX8GfdrYD/bx0jRsDuBvpe6YbOX0/N23J6OWd2eGzF9wc
 GQqw==
X-Gm-Message-State: AOJu0YyDLzhGi/XWbn8aEg12VfupnODOh99DBx/oS0WoZduHK5vukOXM
 A+kOsLFlHi8lxzqyELlgy0oWA5girVZ4YxjHLDc2D3m16x1FYyKIBZOpsYVA/VYEsYKHNk8K/b6
 4
X-Google-Smtp-Source: AGHT+IFx3lGsbE+k/hZHznL66oP5daUplCuacnio2WNaGboHT9LlBsqM2MbjmHtgVloSbDj74BYRVw==
X-Received: by 2002:a9d:7ad4:0:b0:703:7022:657d with SMTP id
 46e09a7af769-70375a05870mr16882809a34.15.1720881520131; 
 Sat, 13 Jul 2024 07:38:40 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-103-45.totalplay.net. [189.203.103.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0d021fcsm265244a34.64.2024.07.13.07.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 07:38:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH] turris_1x: Normalize Kconfig usage
Date: Sat, 13 Jul 2024 08:38:38 -0600
Message-Id: <20240713143838.3049800-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We don't set many options in the board Kconfig entry file but instead
use defconfigs, select in some cases on the target itself, or update the
"default" options of the main entries when needed. In this case we can
remove most of the board Kconfig entries and just add them to the
defconfig like other platforms.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
I'd be open to someone else taking this patch and doing a v2 that has
one of the defconfig's #include the other and then make the required
changes (see other defconfigs which use #include for the constraints
however) as an alternative.

Cc: "Marek Mojík" <marek.mojik@nic.cz>
Cc: "Marek Behún" <kabel@kernel.org>
---
 arch/powerpc/cpu/mpc85xx/Kconfig   |   4 +
 board/CZ.NIC/turris_1x/Kconfig     | 139 -----------------------------
 configs/turris_1x_nor_defconfig    |  35 ++++++++
 configs/turris_1x_sdcard_defconfig |  47 ++++++++++
 4 files changed, 86 insertions(+), 139 deletions(-)

diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index b441ba9840ad..fd0ef3633b77 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -177,6 +177,10 @@ config TARGET_TURRIS_1X
 	bool "Support Turris 1.x"
 	select SUPPORT_SPL
 	select ARCH_P2020
+	select BOARD_EARLY_INIT_F
+	select BOARD_EARLY_INIT_R
+	select LAST_STAGE_INIT
+	select OF_BOARD_SETUP
 	select SYS_L2_SIZE_512KB
 
 config TARGET_P2041RDB
diff --git a/board/CZ.NIC/turris_1x/Kconfig b/board/CZ.NIC/turris_1x/Kconfig
index baea4d80d1c5..d769c42c1a3b 100644
--- a/board/CZ.NIC/turris_1x/Kconfig
+++ b/board/CZ.NIC/turris_1x/Kconfig
@@ -13,143 +13,4 @@ config SYS_CONFIG_NAME
 config DEFAULT_DEVICE_TREE
 	default "turris1x"
 
-# Board functions
-config ATSHA204A
-	default y
-config BOARD_EARLY_INIT_F
-	default y
-config BOARD_EARLY_INIT_R
-	default y
-config LAST_STAGE_INIT
-	default y
-config MISC
-	default y
-config OF_BOARD_FIXUP
-	default y
-config OF_BOARD_SETUP
-	default y
-
-# ENV
-config ENV_SIZE
-	default 0x2000
-config ENV_SECT_SIZE
-	default 0x20000
-config ENV_OVERWRITE
-	default y
-config ENV_IS_IN_FLASH
-	default y
-config ENV_ADDR
-	default 0xeff20000 # in NOR
-config SYS_RELOC_GD_ENV_ADDR
-	default y
-
-# DDR
-config DDR_CLK_FREQ
-	default 66666666
-config NR_DRAM_BANKS
-	default 5
-
-# UART
-config DEBUG_UART_BASE
-	default 0xffe04500 if DEBUG_UART
-config DEBUG_UART_CLOCK
-	default 37500000 if DEBUG_UART
-config SYS_NS16550
-	default y
-
-# I2C
-config I2C_SET_DEFAULT_BUS_NUM
-	default y
-config SYS_FSL_I2C_OFFSET
-	default 0x3000
-config SYS_FSL_HAS_I2C2_OFFSET
-	default y
-config SYS_FSL_I2C2_OFFSET
-	default 0x3100
-config SYS_I2C_FSL
-	default y
-
-# GPIO
-config MPC8XXX_GPIO
-	default y
-
-# WDT
-config WDT_MAX6370
-	default y
-
-# PCIe
-config PCI_INIT_R
-	default y
-config PCIE_FSL
-	default y
-
-# Ethernet
-config MII
-	default y
-config PHY_FIXED
-	default y
-config TSEC_ENET
-	default y
-
-# USB
-config USB_EHCI_FSL
-	default y
-config USB_XHCI_HCD
-	default y
-config USB_XHCI_PCI
-	default y
-
-# SDHC
-config FSL_ESDHC
-	default y
-config SYS_FSL_ESDHC_DEFAULT_BUS_WIDTH
-	default 4
-
-# NOR
-config MTD_NOR_FLASH
-	default y
-config CFI_FLASH
-	default y
-config FLASH_CFI_MTD
-	default y
-config SYS_FLASH_USE_BUFFER_WRITE
-	default y
-
-# NAND
-config MTD_RAW_NAND
-	default y
-config NAND_FSL_ELBC
-	default y
-config NAND_FSL_ELBC_DT
-	default y
-config BCH
-	default y
-config SYS_FLASH_CFI
-	default y
-config NAND_ECC_BCH
-	default y
-config SYS_LOAD_ADDR
-	default 0x1000000
-
-if SPL
-
-config SPL_ENV_SUPPORT
-	default y
-config SPL_FRAMEWORK
-	default n
-config SPL_I2C
-	default y
-config SPL_LIBCOMMON_SUPPORT
-	default y
-config SPL_LIBGENERIC_SUPPORT
-	default y
-config SPL_MPC8XXX_INIT_DDR
-	default y
-config SPL_SERIAL
-	default y
-config SPL_SYS_I2C_LEGACY
-	default y
-
-endif
-
 endif
diff --git a/configs/turris_1x_nor_defconfig b/configs/turris_1x_nor_defconfig
index f06daaaca601..52819b11c8c2 100644
--- a/configs/turris_1x_nor_defconfig
+++ b/configs/turris_1x_nor_defconfig
@@ -1,7 +1,12 @@
 CONFIG_PPC=y
 CONFIG_TEXT_BASE=0xeff40000
 CONFIG_SYS_MALLOC_F_LEN=0x1000
+CONFIG_NR_DRAM_BANKS=5
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_SYS_MONITOR_LEN=786432
+CONFIG_SYS_LOAD_ADDR=0x1000000
+CONFIG_ENV_ADDR=0xeff20000
 CONFIG_MPC85xx=y
 CONFIG_SYS_INIT_RAM_LOCK=y
 # CONFIG_CMD_ERRATA is not set
@@ -10,6 +15,7 @@ CONFIG_MPC85XX_HAVE_RESET_VECTOR=y
 CONFIG_L2_CACHE=y
 CONFIG_ENABLE_36BIT_PHYS=y
 CONFIG_AHCI=y
+CONFIG_OF_BOARD_FIXUP=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_PCIE3=y
@@ -25,6 +31,7 @@ CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run distro_bootcmd"
 CONFIG_USE_PREBOOT=y
+CONFIG_PCI_INIT_R=y
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_BOOTZ=y
 # CONFIG_CMD_EEPROM is not set
@@ -50,6 +57,9 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_OF_CONTROL=y
 CONFIG_OF_INITIAL_DTB_READONLY=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_FLASH=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth2"
 # CONFIG_DM_DEVICE_REMOVE is not set
@@ -57,6 +67,7 @@ CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
+CONFIG_DDR_CLK_FREQ=66666666
 CONFIG_CHIP_SELECTS_PER_CTRL=2
 CONFIG_SYS_BR0_PRELIM_BOOL=y
 CONFIG_SYS_BR0_PRELIM=0xef001001
@@ -67,21 +78,45 @@ CONFIG_SYS_OR1_PRELIM=0xfffc0796
 CONFIG_SYS_BR3_PRELIM_BOOL=y
 CONFIG_SYS_BR3_PRELIM=0xffa00801
 CONFIG_SYS_OR3_PRELIM=0xfffe09f7
+CONFIG_MPC8XXX_GPIO=y
 CONFIG_DM_I2C=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
+CONFIG_SYS_I2C_FSL=y
+CONFIG_MISC=y
+CONFIG_ATSHA204A=y
 # CONFIG_MMC_HW_PARTITIONING is not set
 # CONFIG_MMC_VERBOSE is not set
+CONFIG_FSL_ESDHC=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
+CONFIG_MTD_NOR_FLASH=y
+CONFIG_CFI_FLASH=y
+CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_EMPTY_INFO=y
+CONFIG_FLASH_CFI_MTD=y
+CONFIG_SYS_FLASH_CFI=y
 CONFIG_SYS_FLASH_QUIET_TEST=y
 CONFIG_SYS_MAX_FLASH_SECT=128
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_FSL_ELBC=y
+CONFIG_NAND_FSL_ELBC_DT=y
 CONFIG_MTD_UBI=y
+CONFIG_PHY_FIXED=y
 CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_TSEC_ENET=y
 CONFIG_NVME_PCI=y
+CONFIG_PCIE_FSL=y
 CONFIG_SCSI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_PCI=y
+CONFIG_USB_EHCI_FSL=y
 CONFIG_USB_STORAGE=y
 CONFIG_WDT=y
+CONFIG_WDT_MAX6370=y
+CONFIG_BCH=y
 # CONFIG_BINMAN_FDT is not set
diff --git a/configs/turris_1x_sdcard_defconfig b/configs/turris_1x_sdcard_defconfig
index fb42e024c50a..b402004f588a 100644
--- a/configs/turris_1x_sdcard_defconfig
+++ b/configs/turris_1x_sdcard_defconfig
@@ -1,10 +1,20 @@
 CONFIG_PPC=y
 CONFIG_TEXT_BASE=0x11000000
 CONFIG_SYS_MALLOC_F_LEN=0x1000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=5
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_SPL_TEXT_BASE=0xf8f80000
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
 CONFIG_SPL=y
+CONFIG_DEBUG_UART_BASE=0xffe04500
+CONFIG_DEBUG_UART_CLOCK=37500000
+CONFIG_SYS_LOAD_ADDR=0x1000000
+CONFIG_ENV_ADDR=0xeff20000
 CONFIG_MPC85xx=y
 CONFIG_SYS_INIT_RAM_LOCK=y
 CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR=y
@@ -16,6 +26,7 @@ CONFIG_SYS_MPC85XX_NO_RESETVEC=y
 CONFIG_SPL_SYS_MPC85XX_NO_RESETVEC=y
 CONFIG_DEBUG_UART=y
 CONFIG_AHCI=y
+CONFIG_OF_BOARD_FIXUP=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_PCIE3=y
@@ -28,6 +39,8 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_PREBOOT=y
+CONFIG_PCI_INIT_R=y
+# CONFIG_SPL_FRAMEWORK is not set
 CONFIG_SPL_MAX_SIZE=0x80200
 CONFIG_SPL_PAD_TO=0x0
 CONFIG_SPL_MMC_BOOT=y
@@ -36,6 +49,9 @@ CONFIG_SPL_RELOC_STACK=0xf8f9d000
 CONFIG_SPL_RELOC_MALLOC=y
 CONFIG_SPL_RELOC_MALLOC_ADDR=0xf8fa5000
 CONFIG_SPL_RELOC_MALLOC_SIZE=0x5b000
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_MPC8XXX_INIT_DDR=y
 CONFIG_SPL_TARGET="u-boot-with-spl.bin"
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_IMLS=y
@@ -66,6 +82,9 @@ CONFIG_CMD_SQUASHFS=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_FLASH=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth2"
 CONFIG_NETCONSOLE=y
@@ -73,6 +92,7 @@ CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
+CONFIG_DDR_CLK_FREQ=66666666
 CONFIG_CHIP_SELECTS_PER_CTRL=2
 CONFIG_SYS_BR0_PRELIM_BOOL=y
 CONFIG_SYS_BR0_PRELIM=0xef001001
@@ -84,15 +104,37 @@ CONFIG_SYS_BR3_PRELIM_BOOL=y
 CONFIG_SYS_BR3_PRELIM=0xffa00801
 CONFIG_SYS_OR3_PRELIM=0xfffe09f7
 CONFIG_DM_PCA953X=y
+CONFIG_MPC8XXX_GPIO=y
 CONFIG_DM_I2C=y
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
+CONFIG_SYS_I2C_FSL=y
+CONFIG_SYS_FSL_I2C_OFFSET=0x3000
+CONFIG_SYS_FSL_HAS_I2C2_OFFSET=y
+CONFIG_SYS_FSL_I2C2_OFFSET=0x3100
+CONFIG_MISC=y
+CONFIG_ATSHA204A=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x52
+CONFIG_FSL_ESDHC=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
+CONFIG_MTD_NOR_FLASH=y
+CONFIG_CFI_FLASH=y
+CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_SYS_FLASH_EMPTY_INFO=y
+CONFIG_FLASH_CFI_MTD=y
+CONFIG_SYS_FLASH_CFI=y
 CONFIG_SYS_FLASH_QUIET_TEST=y
 CONFIG_SYS_MAX_FLASH_SECT=128
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_FSL_ELBC=y
+CONFIG_NAND_FSL_ELBC_DT=y
+CONFIG_PHY_FIXED=y
 CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_TSEC_ENET=y
 CONFIG_NVME_PCI=y
+CONFIG_PCIE_FSL=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_DS1307=y
 CONFIG_SCSI=y
@@ -102,5 +144,10 @@ CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_ESPI=y
 CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_PCI=y
+CONFIG_USB_EHCI_FSL=y
 CONFIG_WDT=y
+CONFIG_WDT_MAX6370=y
 CONFIG_FAT_WRITE=y
+CONFIG_BCH=y
-- 
2.34.1

