Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B738C5472E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 18:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB74288BC6;
	Mon, 26 Aug 2024 20:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aW+HOdO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9D8488B78; Mon, 26 Aug 2024 20:05:10 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 929B588B61
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 20:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71446fefddfso2393808b3a.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 11:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724695507; x=1725300307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxl6MiOwRzGw5LUtTeB5B0FIdbylCnjcYrt4o/riylM=;
 b=aW+HOdO+akG2rrZ8qbuY0iWE6fDLGXMslaVCLne6NjVoFFp4odfyf49gvA47TSToZA
 NfGQT4XXLltimMhcU3dxSKd9qWIOKazcGUHw7WhZqNjLmPs459J4GPaFEym52oEDE8o2
 vOtB1sFLs8vcNZK4S4CxDl1j5maB4NQipV0bfBMkuale80u86KgtbgmtukDbCbAFkZ8c
 P8RutBJeOh3sppotlp5EODrWjXB5O3+3gshnmnVZL1w4rNldekD53Ih/iSGDuPnJ8816
 OaFL46hNxTNuKFk9BKZTW5idisU1BZVzHE3kRlfxIjgy3qXY6KZip+NZUPX74LwRUPOm
 aq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724695507; x=1725300307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mxl6MiOwRzGw5LUtTeB5B0FIdbylCnjcYrt4o/riylM=;
 b=v4+LfZnapoKfTJLksqwct40/1I/doSu1dZsmD6tQRY3p8P6wk3+N757ofmJRj4Pb13
 SkeCbfcabcO0cKAV/s3hu2kCISEwCwwRQv4nwWfaM2bwAAacPJqeZfcNn6JtIXww9N1k
 GpRE2XQuaL/aMc+WYGzBXgCJGppDWfWG/fsdmjSnHjlVVmF0PqXxMnwLjNdemdqbrVDP
 hLPV3v+YC/mETZasy9xrcma9HsqHmHU/fgUbTk6BhwCBbFzBP+g35xVoGSx7pvIp75MR
 HaAuIAvHeGP64KW/WbuMhIztFuWd6a0Fm+0MV9ewnjSbpTQGEBFSs3VAMvd1iZ5mkjjk
 GL5g==
X-Gm-Message-State: AOJu0Yxlt5Hoi/7k4JLBmS6vO3T0pEfRjOREBjRmTAT+/TvuiM97iW3v
 MELf1JBmOyurITV8eJ+zMWr9DQkOMS5EnhWbPH9ej4ReEEl7yyccJMBTzQ==
X-Google-Smtp-Source: AGHT+IE+IyrShhwE6zi1GQd3TzOScz+f216ce5hrcMl2629mg9mcpAclRl27lRdATqplm3rKa8zL1w==
X-Received: by 2002:a05:6a00:6f60:b0:714:21f0:c799 with SMTP id
 d2e1a72fcca58-714457a04e6mr12064319b3a.12.1724695506824; 
 Mon, 26 Aug 2024 11:05:06 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bc67:f2c3:ca16:906f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422eaabsm7544947b3a.12.2024.08.26.11.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 11:05:06 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 3/4] mx6slevk: Keep a single defconfig
Date: Mon, 26 Aug 2024 15:04:53 -0300
Message-Id: <20240826180454.2778016-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826180454.2778016-1-festevam@gmail.com>
References: <20240826180454.2778016-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Remove mx6slevk_spinor_defconfig and mx6slevk_spl_defconfig in
favor of having a single mx6slevk_defconfig to help reducing
the maintenance effort.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 configs/mx6slevk_spinor_defconfig | 71 -------------------------
 configs/mx6slevk_spl_defconfig    | 88 -------------------------------
 2 files changed, 159 deletions(-)
 delete mode 100644 configs/mx6slevk_spinor_defconfig
 delete mode 100644 configs/mx6slevk_spl_defconfig

diff --git a/configs/mx6slevk_spinor_defconfig b/configs/mx6slevk_spinor_defconfig
deleted file mode 100644
index 3491cbc5b10d..000000000000
--- a/configs/mx6slevk_spinor_defconfig
+++ /dev/null
@@ -1,71 +0,0 @@
-CONFIG_ARM=y
-CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x87800000
-CONFIG_SYS_MALLOC_LEN=0x300000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_SF_DEFAULT_SPEED=20000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0xC0000
-CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_MX6SL=y
-CONFIG_TARGET_MX6SLEVK=y
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx6sl-evk"
-# CONFIG_CMD_BMODE is not set
-CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_SPI_BOOT=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
-CONFIG_SYS_PBSIZE=532
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_USB=y
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_BOUNCE_BUFFER=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_MXC=y
-CONFIG_FSL_USDHC=y
-CONFIG_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_PHYLIB=y
-CONFIG_PHY_SMSC=y
-CONFIG_FEC_MXC=y
-CONFIG_MII=y
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_IMX6=y
-CONFIG_DM_PMIC=y
-CONFIG_DM_PMIC_PFUZE100=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_PFUZE100=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_DM_SERIAL=y
-CONFIG_MXC_UART=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_MXC_SPI=y
-CONFIG_DM_THERMAL=y
-CONFIG_IMX_THERMAL=y
-CONFIG_USB=y
-CONFIG_USB_STORAGE=y
-CONFIG_USB_HOST_ETHER=y
-CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/mx6slevk_spl_defconfig b/configs/mx6slevk_spl_defconfig
deleted file mode 100644
index 9c923609000c..000000000000
--- a/configs/mx6slevk_spl_defconfig
+++ /dev/null
@@ -1,88 +0,0 @@
-CONFIG_ARM=y
-CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x87800000
-CONFIG_SYS_MALLOC_LEN=0x300000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_SF_DEFAULT_SPEED=20000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x80000
-CONFIG_MX6SL=y
-CONFIG_TARGET_MX6SLEVK=y
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C2=y
-CONFIG_SYS_I2C_MXC_I2C3=y
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx6sl-evk"
-CONFIG_SPL_TEXT_BASE=0x00908000
-CONFIG_SYS_MONITOR_LEN=409600
-CONFIG_SPL_MMC=y
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL=y
-CONFIG_SPL_LIBDISK_SUPPORT=y
-# CONFIG_CMD_BMODE is not set
-CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
-CONFIG_SYS_PBSIZE=532
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_FS_EXT4=y
-CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot-dtb.img"
-CONFIG_SPL_I2C=y
-CONFIG_SPL_WATCHDOG=y
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PART=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_DEV=1
-CONFIG_BOUNCE_BUFFER=y
-CONFIG_DM_I2C=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-CONFIG_SYS_I2C_MXC=y
-CONFIG_FSL_USDHC=y
-CONFIG_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_PHYLIB=y
-CONFIG_PHY_SMSC=y
-CONFIG_FEC_MXC=y
-CONFIG_MII=y
-CONFIG_PINCTRL=y
-CONFIG_PINCTRL_IMX6=y
-CONFIG_DM_PMIC=y
-CONFIG_DM_PMIC_PFUZE100=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_PFUZE100=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_DM_SERIAL=y
-CONFIG_MXC_UART=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_MXC_SPI=y
-CONFIG_DM_THERMAL=y
-CONFIG_IMX_THERMAL=y
-CONFIG_USB=y
-CONFIG_USB_STORAGE=y
-CONFIG_USB_HOST_ETHER=y
-CONFIG_USB_ETHER_ASIX=y
-- 
2.34.1

