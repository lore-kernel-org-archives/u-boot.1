Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E938D5E380
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 20:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21EFE892ED;
	Sat,  9 Nov 2024 21:06:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ngs5gcIH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B78C6892ED; Sat,  9 Nov 2024 21:06:29 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0144289328
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 21:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-460c2418e37so24113201cf.0
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 12:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731182785; x=1731787585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QfX/YKUh3OGpcDycPn9JjHKPbhBcqJ0nq/1BpVjDaBE=;
 b=Ngs5gcIHl2GtFSGR+FJaM7rBIrVzYvqpqzAQvcZCHY+oR+YXJFng9lAnQeT6uBDI9U
 7ZYm0Oc6Qz2Z7ZfXImqpn2fDFRylnnrq0vCgoUKY1Y5PvOKKaGm7bbm079cOqQfb63PC
 qE/P2kjFLJrl/OO/sOEDcLlDZF12GI8W3pEuoVU8KXfl+Ezmu5IoF+R64881qbxsPPFV
 iauipQh/DOOD0Usd5QnCvyOXxTv6I/6SeBHjASKNk7E3n35sQsU99y+GRmJcEsP+dg9S
 TQSjaKirCyUbiZQU5nkQWKN9oQoWqeBhTH2ckhW3ZtnqTZsvwWHdTL0+tdthC9B+VLVk
 XQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731182785; x=1731787585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QfX/YKUh3OGpcDycPn9JjHKPbhBcqJ0nq/1BpVjDaBE=;
 b=U3jiTvlFv+5GZ9caZho2XZffVMmMWNpgQ6UE3F8oXRKGWm8tnRUrhClNUOALMz55+m
 fBe1UqEe08nzUkNPlYZiBM081ExhTgpclEAzhNwSgHDeMDIoE8Lo6oPynSUvDc0hTTzm
 sThOhIKaJhixxZQsA56Ml4ut1tblQGUKWHUDzqnbUXYT0oP4J5fKxJn3VR+GQRTk1hfB
 vNd2OZDz2iXOkzrf3z/uQM468FUSpcH+XoRqi18G4ef+rC1Minv8558OGd53qtIJ3Thu
 p+QWzOdyqRkw6wHHngHIv79OWQ+4zQQ1UAp9Q7jNY8Sr32US+31N7QfKU945R/SSvh8D
 V6mg==
X-Gm-Message-State: AOJu0YxZEdScl2mV41LnVXW3Vuk7jmb7Kdy+7rqPfWmNj10Jn7yXOMVL
 bh7CW0Ur/omgYgGq4SteXSgBQO0QhSWuN2LgOFsvq74zAXnjfO5IVjrdZw==
X-Google-Smtp-Source: AGHT+IGccva1pZk8609xKM/DSCEwrQPQz2TRTVGMXIOOMqkRaXz+h+KLX61/lxHxo9gyQ18z7GB02A==
X-Received: by 2002:a05:622a:1889:b0:461:6113:10de with SMTP id
 d75a77b69052e-4630942c529mr99428641cf.52.1731182785122; 
 Sat, 09 Nov 2024 12:06:25 -0800 (PST)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ff5d678asm36525341cf.85.2024.11.09.12.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 12:06:24 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, lukma@denx.de, Adam Ford <aford173@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 3/4] configs: imx8mn_beacon: Remove
 imx8mn_beacon_fspi_defconfig
Date: Sat,  9 Nov 2024 14:06:04 -0600
Message-ID: <20241109200610.1615430-4-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241109200610.1615430-1-aford173@gmail.com>
References: <20241109200610.1615430-1-aford173@gmail.com>
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

Since the binman device tree can build both SD and eMMC binaries,
and the FSP_CONF_HEADER is now present in the imx8mn_beacon_defconfig,
imx8mn_beacon_fspi_defconfig is unnecessary.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 configs/imx8mn_beacon_fspi_defconfig | 152 ---------------------------
 1 file changed, 152 deletions(-)
 delete mode 100644 configs/imx8mn_beacon_fspi_defconfig

diff --git a/configs/imx8mn_beacon_fspi_defconfig b/configs/imx8mn_beacon_fspi_defconfig
deleted file mode 100644
index 3a92f0ba3b..0000000000
--- a/configs/imx8mn_beacon_fspi_defconfig
+++ /dev/null
@@ -1,152 +0,0 @@
-CONFIG_ARM=y
-CONFIG_ARCH_IMX8M=y
-CONFIG_TEXT_BASE=0x40200000
-CONFIG_SYS_MALLOC_LEN=0x2000000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_ENV_SOURCE_FILE="imx8mn_beacon"
-CONFIG_SF_DEFAULT_SPEED=40000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0xFFFFDE00
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mn-beacon-kit"
-CONFIG_SPL_TEXT_BASE=0x912000
-CONFIG_TARGET_IMX8MN_BEACON=y
-CONFIG_OF_LIBFDT_OVERLAY=y
-CONFIG_DM_RESET=y
-CONFIG_SYS_MONITOR_LEN=524288
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_STACK=0x980000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x950000
-CONFIG_SPL_BSS_MAX_SIZE=0x2000
-CONFIG_SYS_BOOTM_LEN=0x800000
-CONFIG_SYS_LOAD_ADDR=0x42000000
-CONFIG_SPL=y
-CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
-CONFIG_SYS_MEMTEST_START=0x40000000
-CONFIG_SYS_MEMTEST_END=0x44000000
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_FIT_EXTERNAL_OFFSET=0x3000
-CONFIG_SPL_LOAD_FIT=y
-CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else booti ${loadaddr} - ${fdt_addr}; fi"
-CONFIG_DEFAULT_FDT_FILE="imx8mn-beacon-kit.dtb"
-CONFIG_SYS_CBSIZE=2048
-CONFIG_SYS_PBSIZE=2074
-CONFIG_SPL_MAX_SIZE=0x25000
-CONFIG_SPL_BOARD_INIT=y
-CONFIG_SPL_BOOTROM_SUPPORT=y
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
-CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
-CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
-CONFIG_SPL_I2C=y
-CONFIG_SPL_POWER=y
-CONFIG_SPL_WATCHDOG=y
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_PROMPT="u-boot=> "
-# CONFIG_BOOTM_NETBSD is not set
-# CONFIG_CMD_EXPORTENV is not set
-# CONFIG_CMD_IMPORTENV is not set
-CONFIG_CMD_ERASEENV=y
-# CONFIG_CMD_CRC32 is not set
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_CLK=y
-CONFIG_CMD_FUSE=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PART=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_NOWHERE=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=2
-CONFIG_SYS_MMC_ENV_PART=2
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="FEC"
-CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SPL_DM=y
-CONFIG_REGMAP=y
-CONFIG_SYSCON=y
-CONFIG_SPL_CLK_IMX8MN=y
-CONFIG_CLK_IMX8MN=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_BUF_ADDR=0x42800000
-CONFIG_FASTBOOT_BUF_SIZE=0x40000000
-CONFIG_FASTBOOT_FLASH=y
-CONFIG_FASTBOOT_FLASH_MMC_DEV=0
-CONFIG_MXC_GPIO=y
-CONFIG_DM_PCA953X=y
-CONFIG_DM_I2C=y
-CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_MMC_IO_VOLTAGE=y
-CONFIG_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS400_ES_SUPPORT=y
-CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_FSL_USDHC=y
-CONFIG_MTD=y
-CONFIG_DM_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_BAR=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_MTD=y
-CONFIG_PHYLIB=y
-CONFIG_PHY_ATHEROS=y
-CONFIG_PHY_GIGE=y
-CONFIG_FEC_MXC=y
-CONFIG_MII=y
-CONFIG_PINCTRL=y
-CONFIG_SPL_PINCTRL=y
-CONFIG_PINCTRL_IMX8M=y
-CONFIG_DM_PMIC=y
-# CONFIG_SPL_PMIC_CHILDREN is not set
-CONFIG_DM_PMIC_BD71837=y
-CONFIG_SPL_DM_PMIC_BD71837=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_BD71837=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_DM_SERIAL=y
-CONFIG_MXC_UART=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_NXP_FSPI=y
-CONFIG_SYSRESET=y
-CONFIG_SPL_SYSRESET=y
-CONFIG_SYSRESET_PSCI=y
-CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
-CONFIG_USB=y
-# CONFIG_SPL_DM_USB is not set
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="FSL"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
-CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
-CONFIG_CI_UDC=y
-CONFIG_IMX_WATCHDOG=y
-CONFIG_FSPI_CONF_HEADER=y
-CONFIG_FSPI_CONF_FILE="fspi_header.bin"
-- 
2.45.2

