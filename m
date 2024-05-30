Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835ADC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 04:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E065886A0;
	Thu, 30 May 2024 06:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OimzU3H9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9883D8869E; Thu, 30 May 2024 06:42:39 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64D9F886A0
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 06:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bschnei@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f4c7b022f8so4496295ad.1
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 21:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717044155; x=1717648955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CzW9fmeHFH0X44+Kl7z2Lf528jRVyqaPoHWJZxFfbvI=;
 b=OimzU3H9uxHOtsXn0JQZheCp0BvVlGK1GqNcJy8v+/Vei1erL8OH9wRNOJmvIJuRF+
 Jf/hXZu048f2gI/PvlKWOZk2mq70EzPAAHiBP4sjhUU2MKg+lfdpZQ6+M55zFsOq5d3g
 cZtzswt9YV3a2thUYuCxJq7DBT2aqhfVfPLlo4tZNV99g97fTooxJAPQuFEbYd7XEWbM
 /q+DN/MObPCB1NcKHiPbmvv1YURpAbTTrBtgvt3iPvpDAcRVlZf8+ZsHwWDyd79ffMPF
 flkpO0tONSi+ma+ijImXNHL/FBYkLxRSWXoV2bDczmPR2rwcLNqXaMUQFKu/D1JmzKE5
 NnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717044155; x=1717648955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CzW9fmeHFH0X44+Kl7z2Lf528jRVyqaPoHWJZxFfbvI=;
 b=PqdvrbRNV4jKq9smusg1iB6S5xa6+PtaS/YLucv71o+sVuVajwUl4GMybeBn9TYyeW
 hGh/JU8SI9G15f2/VQQ9mRbzPPaRPWpaS8U3LrZoUCZanqoTA8KVxbtyv70Oz/+ciWj9
 E41ui7HPmzWVAlJabV4my3BLAyxftDsByZ0R0KgqmPsY3yzk2HcKvNWEV2Syq1/VieBl
 Ds+pM6TdY0pAUPZnb6BFJeRsmpZan9YcaFahhLYVuXO2aoe+mmykZ9GhvaEeDCkfIl6c
 opGgYCVVoCLvfkQDl/HrjYEbJLWRcshQnnGNObRGLjkbYVdowMqy7fYfg9s2BAI+cvFG
 0dwg==
X-Gm-Message-State: AOJu0Yw5G6JVCDCdSyWDxtoExylLkUVEVpxVwr6luUwbZuF+dWI5yjI6
 232CgwJMl7i+r79P0RKHObRAQwCM35tomIuNC9wRQKPxlmTmxHjVu8GM9FUFSh4=
X-Google-Smtp-Source: AGHT+IHY+X1Z5KkE2EoG4hSKSl5tI++nfstZwR99VIgBm1w2grDk6XZfWmgiJJrdLHb4nrqAKdK+jw==
X-Received: by 2002:a17:902:cec4:b0:1f3:46e:1901 with SMTP id
 d9443c01a7336-1f6193f4331mr11271455ad.10.1717044155447; 
 Wed, 29 May 2024 21:42:35 -0700 (PDT)
Received: from desky.home.arpa ([2605:59c8:790:a501:f1ba:ae8f:59a9:41e3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f615b219d4sm6395745ad.100.2024.05.29.21.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 21:42:34 -0700 (PDT)
From: Benjamin Schneider <bschnei@gmail.com>
X-Google-Original-From: Benjamin Schneider <ben@bens.haus>
To: u-boot@lists.denx.de
Cc: Benjamin Schneider <ben@bens.haus>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2] configs: add mvebu_espressobin_ultra-88f3720_defconfig
Date: Wed, 29 May 2024 21:42:11 -0700
Message-ID: <20240530044231.174950-1-ben@bens.haus>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 May 2024 06:43:16 +0200
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

Add support for a Marvell Armada 3720 device variant

Signed-off-by: Benjamin Schneider <ben@bens.haus>
---

Changes in v2:
- Update MAINTAINERS

 board/Marvell/mvebu_armada-37xx/MAINTAINERS   |   5 +
 .../mvebu_espressobin_ultra-88f3720_defconfig | 106 ++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 configs/mvebu_espressobin_ultra-88f3720_defconfig

diff --git a/board/Marvell/mvebu_armada-37xx/MAINTAINERS b/board/Marvell/mvebu_armada-37xx/MAINTAINERS
index 9b0afeef10..f1ddd513cf 100644
--- a/board/Marvell/mvebu_armada-37xx/MAINTAINERS
+++ b/board/Marvell/mvebu_armada-37xx/MAINTAINERS
@@ -9,3 +9,8 @@ ESPRESSOBin BOARD
 M:	Konstantin Porotchkin <kostap@marvell.com>
 S:	Maintained
 F:	configs/mvebu_espressobin-88f3720_defconfig
+
+ESPRESSOBin Ultra BOARD
+M:	Ben Schneider <ben@bens.haus>
+S:	Maintained
+F:	configs/mvebu_espressobin-ultra_88f3720_defconfig
diff --git a/configs/mvebu_espressobin_ultra-88f3720_defconfig b/configs/mvebu_espressobin_ultra-88f3720_defconfig
new file mode 100644
index 0000000000..c6ffaaabca
--- /dev/null
+++ b/configs/mvebu_espressobin_ultra-88f3720_defconfig
@@ -0,0 +1,106 @@
+CONFIG_ARM=y
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_ARCH_MVEBU=y
+CONFIG_TEXT_BASE=0x00000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
+CONFIG_TARGET_MVEBU_ARMADA_37XX=y
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x3F0000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_DEFAULT_DEVICE_TREE="marvell/armada-3720-espressobin-ultra"
+CONFIG_SYS_LOAD_ADDR=0x6000000
+CONFIG_PCI=y
+CONFIG_AHCI=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_SATA=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_WDT=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_BTRFS=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_SQUASHFS=y
+CONFIG_CMD_FS_UUID=y
+CONFIG_MAC_PARTITION=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ARP_TIMEOUT=200
+CONFIG_NET_RETRY_COUNT=50
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_AHCI_PCI=y
+CONFIG_AHCI_MVEBU=y
+CONFIG_LBA48=y
+CONFIG_SYS_64BIT_LBA=y
+CONFIG_CLK=y
+CONFIG_CLK_MVEBU=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_MV=y
+CONFIG_MISC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_XENON=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_MARVELL=y
+CONFIG_PHY_FIXED=y
+CONFIG_PHY_GIGE=y
+CONFIG_DM_DSA=y
+CONFIG_MV88E6XXX=y
+CONFIG_MVNETA=y
+CONFIG_MVMDIO=y
+CONFIG_NVME_PCI=y
+CONFIG_PCI_AARDVARK=y
+CONFIG_PHY=y
+CONFIG_MVEBU_COMPHY_SUPPORT=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_ARMADA_37XX=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DEFAULT_ENV_IS_RW=y
+CONFIG_MVEBU_A3700_UART=y
+CONFIG_MVEBU_A3700_SPI=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_WDT=y
+CONFIG_WDT_ARMADA_37XX=y
+CONFIG_SHA1=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_PCF8563=y
+# CONFIG_DEBUG_UART=y
+# CONFIG_DEBUG_UART_BASE=0xd0012000
+# CONFIG_DEBUG_UART_CLOCK=25804800
+# CONFIG_DEBUG_UART_SHIFT=2
+# CONFIG_DEBUG_UART_ANNOUNCE=y
-- 
2.45.1

