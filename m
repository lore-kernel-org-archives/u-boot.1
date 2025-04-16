Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1CCC369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 09:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E91D582CBC;
	Wed, 16 Apr 2025 11:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744794270;
	bh=1z8VEcRa114HJHR7pg0RtqrzQbMF+6xE6pzrW2xvLh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jukJfvGNL3huEWDftJu3snACtYOiQLJcuwN6gVGIpJR0kdP9mmpfx7+xcKef8Sc4f
	 RlC6X5Ad7BkSY8lpCRtE1XUvDO6AzDWqyXYNUZB+eaT2EwcORaHIHZgUvQHwGZF7uN
	 q6/0ObSFHp6KnJ4c7RKGli0mFxoQekWx7r5WygUptZeOIPsE65DW/Sbv33RRm0LfFz
	 izfAPYOJwSHWVQ06OIQwXW+EINANFp28N2EJ43Sgf5m8FZM+78ZHBcIzp5oudHZD8s
	 hbOsGI8QB+LupwQUvYub9ThQMhBkrxMhDlr5ds0Eva9CZOHpmKLzmGQJEjZm6j1VqT
	 I9jzU0ncLzJPg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51C2182D4E; Wed, 16 Apr 2025 11:04:30 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DDE782CA2
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 11:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="G/RvqHMw"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B09921039EF2C; 
 Wed, 16 Apr 2025 11:04:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744794267; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=1z8VEcRa114HJHR7pg0RtqrzQbMF+6xE6pzrW2xvLh0=;
 b=G/RvqHMwGIha9HKfA2KBw2ORgRm1nUpkx7/dgO3jiYx2c8dPEfBsNMP7zaKueib3CQ3r/m
 zDvQM552EV+uE97aGinm3mKubBvV58cdqjDg24AaxZQbJaMSpcTn6Kwpik6O+ZSZCiKcp9
 of8gZwu2AG9uG4MQvPeGPXcAtHe0/OQinAGGK3F+isjWChcHW1nYFIwwYmaxwIHmXDIXin
 1njaxUnOU9d4TlNQ/aVtzzFKl2qjPHUjaPY3+g0DglJOd4wZnavBecZ+PvS3yQyQZNzRBB
 3f67ZTV0GoTDVDgKANI7a49OcZ7sPP5cvy6bwRmZ5zDIEPRh/VRAQH/h8xXiyQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@denx.de>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tomas Peterka <atheiste@seznam.cz>
Subject: [PATCH v1 1/3] imx8qxp: capricorn defconfig: collect common Kconfig
 options
Date: Wed, 16 Apr 2025 11:04:17 +0200
Message-Id: <20250416090419.54781-2-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250416090419.54781-1-hs@denx.de>
References: <20250416090419.54781-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

siemens have some defconfigs for different hardware versions,
all based on mainline cxg3 board. For easier updating the
downstream defconfigs, move common settings into new file.

configs/imx8qxp_capricorn.config

Signed-off-by: Heiko Schocher <hs@denx.de>
Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>

---

 board/siemens/capricorn/MAINTAINERS |   1 +
 configs/capricorn_cxg3_defconfig    | 132 +--------------------------
 configs/imx8qxp_capricorn.config    | 135 ++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 128 deletions(-)
 create mode 100644 configs/imx8qxp_capricorn.config

diff --git a/board/siemens/capricorn/MAINTAINERS b/board/siemens/capricorn/MAINTAINERS
index 5f467aa9b6e..3b4bd64dd00 100644
--- a/board/siemens/capricorn/MAINTAINERS
+++ b/board/siemens/capricorn/MAINTAINERS
@@ -9,4 +9,5 @@ F:	arch/arm/dts/imx8-capricorn-u-boot.dtsi
 F:	arch/arm/dts/imx8-capricorn.dtsi
 F:	board/siemens/capricorn/
 F:	configs/capricorn_cxg3_defconfig
+F:	configs/imx8qxp_capricorn.config
 F:	include/configs/capricorn-common.h
diff --git a/configs/capricorn_cxg3_defconfig b/configs/capricorn_cxg3_defconfig
index 3cc46067f7d..530b1f47695 100644
--- a/configs/capricorn_cxg3_defconfig
+++ b/configs/capricorn_cxg3_defconfig
@@ -1,117 +1,13 @@
-CONFIG_ARM=y
-CONFIG_ARCH_IMX8=y
-CONFIG_TEXT_BASE=0x80020000
-CONFIG_SYS_MALLOC_LEN=0x2800000
-CONFIG_SYS_MALLOC_F_LEN=0x4000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=3
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x200000
-CONFIG_DM_GPIO=y
+#include <configs/imx8qxp_capricorn.config>
+
 CONFIG_DEFAULT_DEVICE_TREE="imx8-capricorn-cxg3"
-CONFIG_TARGET_CAPRICORN=y
-CONFIG_SPL_MMC=y
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_STACK=0x13e000
-CONFIG_SPL_TEXT_BASE=0x100000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x128000
-CONFIG_SPL_BSS_MAX_SIZE=0x1000
-CONFIG_SYS_BOOTM_LEN=0x800000
-CONFIG_SYS_LOAD_ADDR=0x80280000
-CONFIG_SPL=y
-CONFIG_ENV_OFFSET_REDUND=0x202000
 CONFIG_IDENT_STRING=" ##v01.06"
-CONFIG_REMAKE_ELF=y
-# CONFIG_EFI_LOADER is not set
-CONFIG_FIT=y
-CONFIG_FIT_EXTERNAL_OFFSET=0x3000
-CONFIG_BOOTDELAY=3
-CONFIG_AUTOBOOT_KEYED=y
-CONFIG_AUTOBOOT_PROMPT="Autobooting in %d seconds, press \"<Esc><Esc>\" to stop\n"
-CONFIG_AUTOBOOT_STOP_STR="\x1b\x1b"
-CONFIG_AUTOBOOT_KEYED_CTRLC=y
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="if usrbutton; then run flash_self_test; reset; fi;run flash_self;reset;"
-CONFIG_SYS_CBSIZE=2048
-CONFIG_SYS_PBSIZE=2073
-CONFIG_LOG=y
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_SPL_MAX_SIZE=0x1f000
-CONFIG_SPL_BOARD_INIT=y
-# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-# CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
-CONFIG_SPL_LOAD_IMX_CONTAINER=y
-CONFIG_IMX_CONTAINER_CFG="board/siemens/capricorn/uboot-container.cfg"
-CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_HAVE_INIT_STACK=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x120000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x4000
-CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
-CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
-CONFIG_SPL_POWER_DOMAIN=y
-CONFIG_SPL_WATCHDOG=y
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_PROMPT="U-Boot# "
-CONFIG_CMD_CPU=y
-# CONFIG_BOOTM_NETBSD is not set
-# CONFIG_CMD_EXPORTENV is not set
-# CONFIG_CMD_IMPORTENV is not set
-# CONFIG_CMD_CRC32 is not set
-CONFIG_CMD_CLK=y
-CONFIG_CMD_DM=y
-CONFIG_CMD_FUSE=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_READ=y
-CONFIG_CMD_WDT=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
-CONFIG_SYS_MMC_ENV_PART=2
+
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
 CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SPL_DM=y
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_BOOTCOUNT_ENV=y
-CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
-CONFIG_SPL_CLK=y
-CONFIG_CLK_IMX8=y
-CONFIG_CPU=y
-CONFIG_MXC_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_IMX_LPI2C=y
-CONFIG_LED=y
-CONFIG_LED_GPIO=y
-CONFIG_MISC=y
-CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_MMC_IO_VOLTAGE=y
-CONFIG_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_FSL_USDHC=y
-CONFIG_PHYLIB=y
+
 CONFIG_MV88E61XX_SWITCH=y
 CONFIG_MV88E61XX_CPU_PORT=5
 CONFIG_MV88E61XX_PHY_PORTS=0x7
@@ -119,23 +15,3 @@ CONFIG_DM_ETH_PHY=y
 CONFIG_FEC_MXC_SHARE_MDIO=y
 CONFIG_FEC_MXC_MDIO_BASE=0x5B050000
 CONFIG_FEC_MXC=y
-CONFIG_MII=y
-CONFIG_PHY=y
-CONFIG_NOP_PHY=y
-CONFIG_PINCTRL=y
-CONFIG_SPL_PINCTRL=y
-CONFIG_PINCTRL_IMX8=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8_POWER_DOMAIN=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPL_DM_REGULATOR_GPIO=y
-CONFIG_DM_SERIAL=y
-CONFIG_FSL_LPUART=y
-CONFIG_DM_THERMAL=y
-CONFIG_IMX_SCU_THERMAL=y
-# CONFIG_WATCHDOG is not set
-CONFIG_WDT=y
-CONFIG_WDT_SIEMENS_PMIC=y
-CONFIG_SPL_TINY_MEMSET=y
diff --git a/configs/imx8qxp_capricorn.config b/configs/imx8qxp_capricorn.config
new file mode 100644
index 00000000000..f59f2129d56
--- /dev/null
+++ b/configs/imx8qxp_capricorn.config
@@ -0,0 +1,135 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX8=y
+CONFIG_TEXT_BASE=0x80020000
+CONFIG_SYS_MALLOC_LEN=0x2800000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0x200000
+CONFIG_ENV_OFFSET_REDUND=0x202000
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_SYS_MMC_ENV_PART=2
+
+CONFIG_DM_GPIO=y
+
+CONFIG_TARGET_CAPRICORN=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x13e000
+CONFIG_SPL_TEXT_BASE=0x100000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x128000
+CONFIG_SPL_BSS_MAX_SIZE=0x1000
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_SYS_LOAD_ADDR=0x80280000
+CONFIG_SPL=y
+
+CONFIG_REMAKE_ELF=y
+# CONFIG_EFI_LOADER is not set
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_FIT_EXTERNAL_OFFSET=0x3000
+CONFIG_BOOTDELAY=3
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_PROMPT="Autobooting in %d seconds, press \"<Esc><Esc>\" to stop\n"
+CONFIG_AUTOBOOT_STOP_STR="\x1b\x1b"
+CONFIG_AUTOBOOT_KEYED_CTRLC=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="if usrbutton; then run flash_self_test; reset; fi;run flash_self;reset;"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2073
+CONFIG_LOG=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_SPL_MAX_SIZE=0x1f000
+CONFIG_SPL_BOARD_INIT=y
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+# CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="board/siemens/capricorn/uboot-container.cfg"
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x120000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x4000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="U-Boot# "
+CONFIG_CMD_CPU=y
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_CMD_EXPORTENV is not set
+# CONFIG_CMD_IMPORTENV is not set
+# CONFIG_CMD_CRC32 is not set
+# CONFIG_CMD_BIND is not set
+CONFIG_CMD_WDT=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_READ=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+
+CONFIG_SPL_DM=y
+CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTCOUNT_ENV=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
+CONFIG_SPL_CLK=y
+CONFIG_CLK_IMX8=y
+CONFIG_CPU=y
+CONFIG_MXC_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_PHYLIB=y
+
+CONFIG_MII=y
+CONFIG_PHY=y
+CONFIG_NOP_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX8=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_IMX8_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SPL_DM_REGULATOR_GPIO=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_DM_THERMAL=y
+CONFIG_IMX_SCU_THERMAL=y
+# CONFIG_WATCHDOG is not set
+CONFIG_WDT=y
+CONFIG_WDT_SIEMENS_PMIC=y
+CONFIG_SPL_TINY_MEMSET=y
-- 
2.20.1

