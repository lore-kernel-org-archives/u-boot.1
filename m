Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC60D1F9DE
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDE5B8409A;
	Thu,  4 Dec 2025 13:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IL6nGWp7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B8084008; Thu,  4 Dec 2025 11:26:40 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5DD283FA5
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b7633027cb2so120359566b.1
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 02:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764843997; x=1765448797;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J1aIykjQmOQNOgBgDJFfCLuR39L8pQSDudZvnMp3jXg=;
 b=IL6nGWp7opjGxEIMxtkIf3kPUYMuCyvukO6xqrmVIWvWoVXktHEM44eCi7DvaSOc8N
 QoL4wRb7iL+oqd+q2sUvKRm62DQt4Cez+YnQlOvZYZ+YP6YVClkg5v+oGfGSN/VKz5aN
 K4ZPHOnqEhkXE5cwTLfDqVyw3cwn3ujSnLY5+tfR5rqStP9ZZNl+EOZtt276Xhubt8/7
 4Lb2CpmqdO4XzwfPt4e8eAlMbOUcJdrXPz1vQGAKAWzOvOO6mPfD+zaiFs1emfLCkX7a
 rnKIYeET8dVve4LbKeOa+4sPLi/TJPlbreTdTd/gCPMRKw89FA5+Xx2byphR0RsyxR3d
 13ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764843997; x=1765448797;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J1aIykjQmOQNOgBgDJFfCLuR39L8pQSDudZvnMp3jXg=;
 b=gj6QfQVmMdZ2QlcV3Pi5G0Z1eacFe4bM1ih7rSBD+J6tgl2pvQn0XggNahCBJQqPYT
 ExEESsZWJRN6K0PpZ1yzCO86hnjG15RuknZjgHZBLSACkrwglkTeg/C4XOs02yuiog6F
 MdnfYbzDRxMcwLXomeYoIO3CBe0eD6QIsxVgOzq1osEAlHDjFYz1IqZZEvSXpykFS+V5
 JtlYSkIprVbTxBdPEXM7cEzmZlxn4xdhCDEmDlNjmnvoQjXN8I9cxG3B8WEdjoWsBsk9
 /irpvUWEKjSxcmKfZws8S7OGqvmvvMvkimEqpy1c6Ma72gAz2LN8d0dfYAKpwy36GqcO
 9aLw==
X-Gm-Message-State: AOJu0YxxUHzjeWquwzJuMQsRfQw5FBd4+RQ5WN9J3EOqNiPEFBMf8KJm
 K0RRlkRaN7M3zQHoo+sYnGyGJAHhOOwQu6bH3Kcw6JNBY0Vu8T51cvqbq8jBXrQB7tg=
X-Gm-Gg: ASbGncs8bA6/JQ0CSelZJUBo52YUM/vUem2RLMxKMBRslKYOhJhXkBVFlUV5QIAUj+Q
 EWZbazptsWpJPLXlNJsHFFoGULslTXMqhtuptzRrR2n7R1vh9uy3X2FN3P+bIMJVSpQ2FkCRcTL
 p2yS7orwkb1C+mhgLKrVFU2AsYnEnFjmf5oW+/xDjtOg3cqqmko8+OtQRg6bFHlVoBICPCuxfTK
 kIitj3eDZ6uE8UC1CNUOzv3quors7KuTZ/wJ5bdtnlGU1bygL5NuF5c6osFmBq6jUEed4dNNKu1
 YeAb0aaOOorw7uyNHhMgEppKFtKc2fkSY4IFdUbZnbZfneDgpV+nttKia/Vvbt0Im9V8BrEqu7s
 lzMFPgyMwGvKelR/zsg9+OdJ5fB8oInDY5zgiZv42nSXC1Q0IZHpYUv2lQUSesBdcbxnvmvU/RO
 vEqwdW3fs=
X-Google-Smtp-Source: AGHT+IF1RUTkI0EwP4lHZumsj6/QTwuf8JdZ4DX6v+mPL9FKbebqKjnHxihFVVvEmNSf1Gaiy1Mwcw==
X-Received: by 2002:a17:907:608c:b0:b73:5d8c:dd0d with SMTP id
 a640c23a62f3a-b79dc7780fcmr568757466b.52.1764843997216; 
 Thu, 04 Dec 2025 02:26:37 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4975b94sm92126366b.40.2025.12.04.02.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 02:26:36 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 04 Dec 2025 11:25:40 +0100
Subject: [PATCH v3 4/9] configs: am335x_evm: Unify evm board defconfigs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-topic-am33-evm-oftree-v2026-01-v3-4-3d1566ce4dc7@baylibre.com>
References: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
In-Reply-To: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=18746; i=msp@baylibre.com;
 h=from:subject:message-id; bh=+I8lD+VEheFIgDbIfG5syeswMSY79LGp9FedvC5C2k8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzDxJ2FmS/DI5yPcc9Ze3zJsmlCHu9KXlpU1pruPbfiS
 tNVyc25HaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCRP5oM/8zO1BxddP9f5BtT
 3wkzTq1y+GSobzjXPPKChbnN7OtvEnMZ/scWGMa1rpugYZ9r82ijmU8cQ+a97fmTiu/O659yInZ
 6GTMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:52:18 +0100
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

Much of the config symbols between the evm boards are the same
independent of the actual board. This patch creates a hierarchy for the
am335x_evm configs:

  am335x_evm.config
  `-> am335x_evm_defconfig
  `-> am335x_evm_spiboot_defconfig
  `-> am335x_hs_evm.config
      `-> am335x_hs_evm_defconfig
      `-> am335x_hs_evm_uart_defconfig

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 configs/am335x_evm.config            | 81 ++++++++++++++++++++++++++++++
 configs/am335x_evm_defconfig         | 83 +------------------------------
 configs/am335x_evm_spiboot_defconfig | 83 +------------------------------
 configs/am335x_hs_evm.config         | 14 ++++++
 configs/am335x_hs_evm_defconfig      | 95 +-----------------------------------
 configs/am335x_hs_evm_uart_defconfig | 94 +----------------------------------
 6 files changed, 103 insertions(+), 347 deletions(-)

diff --git a/configs/am335x_evm.config b/configs/am335x_evm.config
new file mode 100644
index 0000000000000000000000000000000000000000..ba39ae274c4095a61f2d102f0bc3de6d0637f53a
--- /dev/null
+++ b/configs/am335x_evm.config
@@ -0,0 +1,81 @@
+CONFIG_ARM=y
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_TI_COMMON_CMD_OPTIONS=y
+CONFIG_SF_DEFAULT_SPEED=24000000
+CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
+CONFIG_AM33XX=y
+CONFIG_CLOCK_SYNTHESIZER=y
+CONFIG_SYS_BOOTM_LEN=0x1000000
+CONFIG_SPL=y
+CONFIG_TIMESTAMP=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
+CONFIG_LOGLEVEL=3
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
+CONFIG_SPL_FIT_IMAGE_TINY=y
+# CONFIG_SPL_FS_EXT4 is not set
+CONFIG_SPL_MTD=y
+CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
+CONFIG_CMD_NAND=y
+CONFIG_BOOTP_DNS2=y
+CONFIG_CMD_MTDPARTS=y
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RETRY_COUNT=10
+CONFIG_BOOTP_SEND_HOSTNAME=y
+CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_SYS_BOOTCOUNT_BE=y
+CONFIG_CLK_CDCE9XX=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_NAND=y
+CONFIG_DFU_RAM=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x50
+# CONFIG_MMC_HW_PARTITIONING is not set
+CONFIG_MMC_OMAP_HS=y
+CONFIG_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_SYS_NAND_PAGE_SIZE=0x800
+CONFIG_SYS_NAND_OOBSIZE=0x40
+CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
+CONFIG_SYS_NAND_U_BOOT_OFFS=0xc0000
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ATHEROS=y
+CONFIG_PHY_SMSC=y
+CONFIG_MII=y
+CONFIG_DRIVER_TI_CPSW=y
+CONFIG_DM_PMIC=y
+# CONFIG_SPL_DM_PMIC is not set
+CONFIG_PMIC_TPS65217=y
+CONFIG_SPL_POWER_TPS65910=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_OMAP3_SPI=y
+CONFIG_TIMER=y
+CONFIG_OMAP_TIMER=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_MUSB_HOST=y
+CONFIG_USB_MUSB_GADGET=y
+CONFIG_USB_MUSB_TI=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0451
+CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
+CONFIG_USB_ETHER=y
+CONFIG_WDT=y
+# CONFIG_SPL_WDT is not set
+CONFIG_DYNAMIC_CRC_TABLE=y
+CONFIG_LZO=y
diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index bd188c252780fb541afbbe61a243bddaab79be93..448b0a8308fcca04732b81313c72f7fd2247d1ca 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -1,32 +1,12 @@
-CONFIG_ARM=y
-CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_SF_DEFAULT_SPEED=24000000
-CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
-CONFIG_AM33XX=y
-CONFIG_CLOCK_SYNTHESIZER=y
+#include <configs/am335x_evm.config>
+
 CONFIG_AM335X_USB0=y
 CONFIG_AM335X_USB0_PERIPHERAL=y
 CONFIG_AM335X_USB1=y
-CONFIG_SYS_BOOTM_LEN=0x1000000
-CONFIG_SPL=y
-CONFIG_TIMESTAMP=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
-CONFIG_LOGLEVEL=3
-CONFIG_SYS_CONSOLE_INFO_QUIET=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
-CONFIG_SPL_FIT_IMAGE_TINY=y
 CONFIG_SPL_ETH=y
-# CONFIG_SPL_FS_EXT4 is not set
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
-CONFIG_SPL_MTD=y
 CONFIG_SPL_MUSB_NEW=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
@@ -41,90 +21,31 @@ CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
 CONFIG_CMD_EXTENSION=y
 CONFIG_CMD_SPL_NAND_OFS=0x00080000
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_NAND=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_BOOTP_DNS2=y
-CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
-# CONFIG_SPL_EFI_PARTITION is not set
-CONFIG_OF_CONTROL=y
 CONFIG_OF_LIST="am335x-evm am335x-bone am335x-sancloud-bbe am335x-sancloud-bbe-lite am335x-sancloud-bbe-extended-wifi am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_ENV_IS_NOWHERE=y
-CONFIG_VERSION_VARIABLE=y
-CONFIG_NET_RETRY_COUNT=10
-CONFIG_BOOTP_SEND_HOSTNAME=y
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
-CONFIG_CLK_CDCE9XX=y
 CONFIG_CLK_TI_AM3_DPLL=y
 CONFIG_CLK_TI_CTRL=y
 CONFIG_CLK_TI_DIVIDER=y
 CONFIG_CLK_TI_GATE=y
 CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_TFTP=y
-CONFIG_DFU_MMC=y
-CONFIG_DFU_NAND=y
-CONFIG_DFU_RAM=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=1
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
-CONFIG_DM_I2C=y
 CONFIG_MISC=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-# CONFIG_MMC_HW_PARTITIONING is not set
-CONFIG_MMC_OMAP_HS=y
-CONFIG_MTD=y
-CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_SIZE=0x800
-CONFIG_SYS_NAND_OOBSIZE=0x40
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0xc0000
-CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_SMSC=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_PHY_GIGE=y
-CONFIG_MII=y
-CONFIG_DRIVER_TI_CPSW=y
-CONFIG_DM_PMIC=y
-# CONFIG_SPL_DM_PMIC is not set
-CONFIG_PMIC_TPS65217=y
-CONFIG_SPL_POWER_TPS65910=y
 CONFIG_DM_PWM=y
 CONFIG_PWM_TI_ECAP=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_OMAP3_SPI=y
-CONFIG_TIMER=y
-CONFIG_OMAP_TIMER=y
-CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
 CONFIG_SPL_DM_USB_GADGET=y
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_GADGET=y
-CONFIG_USB_MUSB_TI=y
-CONFIG_USB_GADGET=y
 CONFIG_SPL_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0451
-CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
-CONFIG_USB_ETHER=y
 CONFIG_SPL_USB_ETHER=y
 CONFIG_VIDEO=y
 CONFIG_AM335X_LCD=y
-CONFIG_WDT=y
-# CONFIG_SPL_WDT is not set
-CONFIG_DYNAMIC_CRC_TABLE=y
-CONFIG_LZO=y
diff --git a/configs/am335x_evm_spiboot_defconfig b/configs/am335x_evm_spiboot_defconfig
index 97f56f36aa6c5912bbd5fec7580cd1cd204bec2f..eebd916c02a2cad0d01ab738aab37b11dd3a9645 100644
--- a/configs/am335x_evm_spiboot_defconfig
+++ b/configs/am335x_evm_spiboot_defconfig
@@ -1,108 +1,29 @@
-CONFIG_ARM=y
-CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_SF_DEFAULT_SPEED=24000000
+#include <configs/am335x_evm.config>
+
 CONFIG_ENV_OFFSET=0x100000
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
-CONFIG_AM33XX=y
-CONFIG_CLOCK_SYNTHESIZER=y
 # CONFIG_SPL_MMC is not set
-CONFIG_SYS_BOOTM_LEN=0x1000000
-CONFIG_SPL=y
 # CONFIG_SPL_FS_FAT is not set
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
-CONFIG_TIMESTAMP=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
-CONFIG_LOGLEVEL=3
-CONFIG_SYS_CONSOLE_INFO_QUIET=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
-CONFIG_SPL_FIT_IMAGE_TINY=y
-# CONFIG_SPL_FS_EXT4 is not set
-CONFIG_SPL_MTD=y
 # CONFIG_SPL_NAND_SUPPORT is not set
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_NAND=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_BOOTP_DNS2=y
-CONFIG_CMD_MTDPARTS=y
-# CONFIG_SPL_EFI_PARTITION is not set
-CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
-CONFIG_ENV_OVERWRITE=y
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_SPL_ENV_IS_NOWHERE=y
-CONFIG_VERSION_VARIABLE=y
-CONFIG_NET_RETRY_COUNT=10
-CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_SPL_TI_SYSC=y
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_SPL_CLK=y
-CONFIG_CLK_CDCE9XX=y
 CONFIG_CLK_TI_CTRL=y
 CONFIG_DFU_TFTP=y
-CONFIG_DFU_MMC=y
-CONFIG_DFU_NAND=y
-CONFIG_DFU_RAM=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=1
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 # CONFIG_SPL_DM_MMC is not set
-# CONFIG_MMC_HW_PARTITIONING is not set
-CONFIG_MMC_OMAP_HS=y
-CONFIG_MTD=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_SIZE=0x800
-CONFIG_SYS_NAND_OOBSIZE=0x40
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0xc0000
-CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_SMSC=y
-CONFIG_MII=y
-CONFIG_DRIVER_TI_CPSW=y
-CONFIG_DM_PMIC=y
-# CONFIG_SPL_DM_PMIC is not set
-CONFIG_PMIC_TPS65217=y
-CONFIG_SPL_POWER_TPS65910=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_OMAP3_SPI=y
-CONFIG_TIMER=y
-CONFIG_OMAP_TIMER=y
-CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_GADGET=y
-CONFIG_USB_MUSB_TI=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0451
-CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
-CONFIG_USB_ETHER=y
-CONFIG_WDT=y
-# CONFIG_SPL_WDT is not set
-CONFIG_DYNAMIC_CRC_TABLE=y
 CONFIG_RSA=y
-CONFIG_LZO=y
diff --git a/configs/am335x_hs_evm.config b/configs/am335x_hs_evm.config
new file mode 100644
index 0000000000000000000000000000000000000000..7ade2fb163b204ad8bcc9554455fdd3e81657890
--- /dev/null
+++ b/configs/am335x_hs_evm.config
@@ -0,0 +1,14 @@
+#include <configs/am335x_evm.config>
+
+CONFIG_TI_SECURE_DEVICE=y
+# CONFIG_SPL_ENV_SUPPORT is not set
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
+# CONFIG_SPL_NAND_SUPPORT is not set
+CONFIG_SPL_NAND_DRIVERS=y
+CONFIG_SPL_NAND_ECC=y
+CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
+CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_SPL_TINY_MEMSET=y
+CONFIG_RSA=y
diff --git a/configs/am335x_hs_evm_defconfig b/configs/am335x_hs_evm_defconfig
index e4eedd439c8a26052f57764059d660fbfabcb15b..8f140fa5b1e9d0edc80374fdd740e0ba9c65935d 100644
--- a/configs/am335x_hs_evm_defconfig
+++ b/configs/am335x_hs_evm_defconfig
@@ -1,96 +1,5 @@
-CONFIG_ARM=y
-CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_TI_SECURE_DEVICE=y
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_SF_DEFAULT_SPEED=24000000
-CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
-CONFIG_AM33XX=y
-CONFIG_CLOCK_SYNTHESIZER=y
+#include <configs/am335x_hs_evm.config>
+
 CONFIG_SPL_TEXT_BASE=0x40300350
-CONFIG_SYS_BOOTM_LEN=0x1000000
-CONFIG_SPL=y
-CONFIG_TIMESTAMP=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
-CONFIG_LOGLEVEL=3
-CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_MAX_SIZE=0xb0b0
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
-CONFIG_SPL_FIT_IMAGE_TINY=y
-# CONFIG_SPL_ENV_SUPPORT is not set
-# CONFIG_SPL_FS_EXT4 is not set
-CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
-CONFIG_SPL_MTD=y
-# CONFIG_SPL_NAND_SUPPORT is not set
-CONFIG_SPL_NAND_DRIVERS=y
-CONFIG_SPL_NAND_ECC=y
 # CONFIG_SPL_YMODEM_SUPPORT is not set
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_NAND=y
-CONFIG_BOOTP_DNS2=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
-# CONFIG_SPL_EFI_PARTITION is not set
-CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-CONFIG_VERSION_VARIABLE=y
-CONFIG_NET_RETRY_COUNT=10
-CONFIG_BOOTP_SEND_HOSTNAME=y
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_SYS_BOOTCOUNT_BE=y
-CONFIG_CLK_CDCE9XX=y
-CONFIG_DFU_MMC=y
-CONFIG_DFU_NAND=y
-CONFIG_DFU_RAM=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-# CONFIG_MMC_HW_PARTITIONING is not set
-CONFIG_MMC_OMAP_HS=y
-CONFIG_MTD=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_SIZE=0x800
-CONFIG_SYS_NAND_OOBSIZE=0x40
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0xc0000
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_SMSC=y
-CONFIG_MII=y
-CONFIG_DRIVER_TI_CPSW=y
-CONFIG_DM_PMIC=y
-# CONFIG_SPL_DM_PMIC is not set
-CONFIG_PMIC_TPS65217=y
-CONFIG_SPL_POWER_TPS65910=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_OMAP3_SPI=y
-CONFIG_TIMER=y
-CONFIG_OMAP_TIMER=y
-CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
-CONFIG_SPL_DM_USB_GADGET=y
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_GADGET=y
-CONFIG_USB_MUSB_TI=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0451
-CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
-CONFIG_USB_ETHER=y
-CONFIG_WDT=y
-# CONFIG_SPL_WDT is not set
-CONFIG_DYNAMIC_CRC_TABLE=y
-CONFIG_SPL_TINY_MEMSET=y
-CONFIG_RSA=y
-CONFIG_LZO=y
diff --git a/configs/am335x_hs_evm_uart_defconfig b/configs/am335x_hs_evm_uart_defconfig
index f60f63f87d7018e10840b27ee9c5afc179c1e167..ff60802fdf1b01c53b650993d14b7ca0a081af9b 100644
--- a/configs/am335x_hs_evm_uart_defconfig
+++ b/configs/am335x_hs_evm_uart_defconfig
@@ -1,98 +1,8 @@
-CONFIG_ARM=y
-CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_TI_SECURE_DEVICE=y
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_SF_DEFAULT_SPEED=24000000
-CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
-CONFIG_AM33XX=y
-CONFIG_CLOCK_SYNTHESIZER=y
+#include <configs/am335x_hs_evm.config>
+
 # CONFIG_SPL_MMC is not set
 CONFIG_SPL_TEXT_BASE=0x40301950
-CONFIG_SYS_BOOTM_LEN=0x1000000
-CONFIG_SPL=y
 # CONFIG_SPL_FS_FAT is not set
 # CONFIG_SPL_LIBDISK_SUPPORT is not set
-CONFIG_TIMESTAMP=y
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
-CONFIG_LOGLEVEL=3
-CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_MAX_SIZE=0x9ab0
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
-CONFIG_SPL_FIT_IMAGE_TINY=y
-# CONFIG_SPL_ENV_SUPPORT is not set
-# CONFIG_SPL_FS_EXT4 is not set
-CONFIG_SPL_MTD=y
-# CONFIG_SPL_NAND_SUPPORT is not set
-CONFIG_SPL_NAND_DRIVERS=y
-CONFIG_SPL_NAND_ECC=y
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_NAND=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_BOOTP_DNS2=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
-# CONFIG_SPL_EFI_PARTITION is not set
-CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-CONFIG_VERSION_VARIABLE=y
-CONFIG_NET_RETRY_COUNT=10
-CONFIG_BOOTP_SEND_HOSTNAME=y
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_SYS_BOOTCOUNT_BE=y
-CONFIG_CLK_CDCE9XX=y
-CONFIG_DFU_MMC=y
-CONFIG_DFU_NAND=y
-CONFIG_DFU_RAM=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-# CONFIG_MMC_HW_PARTITIONING is not set
-CONFIG_MMC_OMAP_HS=y
-CONFIG_MTD=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_SIZE=0x800
-CONFIG_SYS_NAND_OOBSIZE=0x40
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0xc0000
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_SMSC=y
-CONFIG_MII=y
-CONFIG_DRIVER_TI_CPSW=y
-CONFIG_DM_PMIC=y
-# CONFIG_SPL_DM_PMIC is not set
-CONFIG_PMIC_TPS65217=y
-CONFIG_SPL_POWER_TPS65910=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_OMAP3_SPI=y
-CONFIG_TIMER=y
-CONFIG_OMAP_TIMER=y
-CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
-CONFIG_SPL_DM_USB_GADGET=y
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_GADGET=y
-CONFIG_USB_MUSB_TI=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0451
-CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
-CONFIG_USB_ETHER=y
-CONFIG_WDT=y
-# CONFIG_SPL_WDT is not set
-CONFIG_DYNAMIC_CRC_TABLE=y
-CONFIG_SPL_TINY_MEMSET=y
-CONFIG_RSA=y
-CONFIG_LZO=y

-- 
2.51.0

