Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27575FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 12:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CED68484F;
	Wed, 29 Apr 2026 14:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="p634QsF5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE3A984876; Wed, 29 Apr 2026 14:19:17 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6623784886
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 14:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3DD5344503;
 Wed, 29 Apr 2026 12:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B25EC19425;
 Wed, 29 Apr 2026 12:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777465153;
 bh=Zqg0gydv7PiyV3hTvghCt+oZyP3C/Pn580L29NzCq5M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=p634QsF5zp80Ds8l3f9XQrc3ovbsYKmkstcKVmIV3pEhhO3h4vgic1Ldnk3miVh7/
 wg6mus/dkB1AGNklobbbIKehYTzWmPa8XHdrGTOhns2rnfTAGTyMfwnp24QVAMpcCv
 beYrqAzIy56kqO2seSnnaLGW24zBuhVHPZquFl96VwyhufQQClSVzlzo5Bkwu/A7g8
 nKFBcnDq4t8nkUc7tpCKFmrDbmokg5w2kmb2x+xct5i7nu0GXxlbbz7DQT4pXGLsSj
 iWUBZZkh07vj0KWcq/KPiczyvSSwFgztQXASPJ/Rx2Xv0ERSJlMpvGaj+gqkLDKe4y
 yTL+6diq1lYeQ==
From: Michael Walle <mwalle@kernel.org>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Vladimir Oltean <olteanv@gmail.com>, Alison Wang <alison.wang@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH 10/10] p2041rdb: remove NAND defconfig
Date: Wed, 29 Apr 2026 14:17:24 +0200
Message-ID: <20260429121816.1026326-11-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429121816.1026326-1-mwalle@kernel.org>
References: <20260429121816.1026326-1-mwalle@kernel.org>
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

The RDB doesn't support NAND boot at all, remove the config for it.
Apparently, it was introduced by commit dd84058d24ff ("kconfig: add
board Kconfig and defconfig files") which ran some scripts. Maybe that
script was wrong or the source boards.cfg was wrong. In any case, there
is no NAND flash on the RDB.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 configs/P2041RDB_NAND_defconfig | 117 --------------------------------
 1 file changed, 117 deletions(-)
 delete mode 100644 configs/P2041RDB_NAND_defconfig

diff --git a/configs/P2041RDB_NAND_defconfig b/configs/P2041RDB_NAND_defconfig
deleted file mode 100644
index 1bef841990f..00000000000
--- a/configs/P2041RDB_NAND_defconfig
+++ /dev/null
@@ -1,117 +0,0 @@
-CONFIG_PPC=y
-CONFIG_TEXT_BASE=0xFFF40000
-CONFIG_SYS_MALLOC_LEN=0x100000
-CONFIG_SF_DEFAULT_SPEED=10000000
-CONFIG_ENV_SIZE=0x20000
-CONFIG_ENV_OFFSET=0xE0000
-CONFIG_DEFAULT_DEVICE_TREE="p2041rdb"
-CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_MPC85xx=y
-CONFIG_SYS_INIT_RAM_LOCK=y
-CONFIG_SYS_SRIO=y
-CONFIG_SRIO1=y
-CONFIG_SRIO2=y
-CONFIG_SRIO_PCIE_BOOT_MASTER=y
-CONFIG_TARGET_P2041RDB=y
-CONFIG_MPC85XX_HAVE_RESET_VECTOR=y
-CONFIG_ENABLE_36BIT_PHYS=y
-CONFIG_SYS_BOOK3E_HV=y
-CONFIG_SYS_CACHE_STASHING=y
-CONFIG_USE_UBOOTPATH=y
-CONFIG_PCIE1=y
-CONFIG_PCIE2=y
-CONFIG_PCIE3=y
-CONFIG_SYS_FSL_NUM_CC_PLLS=2
-CONFIG_MP=y
-CONFIG_DYNAMIC_SYS_CLK_FREQ=y
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/nxp/p2041rdb/pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/nxp/p2041rdb/rcw_p2041rdb.cfg"
-CONFIG_BOOTDELAY=10
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv bootargs root=/dev/$bdev rw console=$consoledev,$baudrate $othbootargs;tftp $loadaddr $bootfile;tftp $fdtaddr $fdtfile;bootm $loadaddr - $fdtaddr"
-CONFIG_SYS_PBSIZE=276
-CONFIG_BOARD_EARLY_INIT_F=y
-CONFIG_BOARD_EARLY_INIT_R=y
-CONFIG_ID_EEPROM=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_IMLS=y
-CONFIG_CMD_GREPENV=y
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_DM=y
-CONFIG_CMD_I2C=y
-CONFIG_LOADS_ECHO=y
-CONFIG_SYS_LOADS_BAUD_CHANGE=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_FAT=y
-CONFIG_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_NAND=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="uImage"
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="FM1@DTSEC1"
-CONFIG_USE_ROOTPATH=y
-CONFIG_FSL_SATA_V2=y
-CONFIG_SYS_SATA_MAX_DEVICE=2
-CONFIG_FSL_CAAM=y
-CONFIG_SYS_BR0_PRELIM_BOOL=y
-CONFIG_SYS_BR0_PRELIM=0xFFA00C21
-CONFIG_SYS_OR0_PRELIM=0xFFFC0796
-CONFIG_SYS_BR1_PRELIM_BOOL=y
-CONFIG_SYS_BR1_PRELIM=0xE8001001
-CONFIG_SYS_OR1_PRELIM=0xF8000F85
-CONFIG_SYS_BR3_PRELIM_BOOL=y
-CONFIG_SYS_BR3_PRELIM=0xFFDF0801
-CONFIG_SYS_OR3_PRELIM=0xFFFFEFF7
-CONFIG_DM_I2C=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_FSL=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-CONFIG_FSL_ESDHC=y
-CONFIG_MTD=y
-CONFIG_MTD_NOR_FLASH=y
-CONFIG_FLASH_CFI_DRIVER=y
-CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
-CONFIG_SYS_FLASH_EMPTY_INFO=y
-CONFIG_SYS_FLASH_CFI=y
-CONFIG_SYS_FLASH_QUIET_TEST=y
-CONFIG_SYS_MAX_FLASH_SECT=1024
-CONFIG_MTD_RAW_NAND=y
-CONFIG_NAND_FSL_ELBC=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_PHYLIB=y
-CONFIG_PHYLIB_10G=y
-CONFIG_PHY_TERANETICS=y
-CONFIG_PHY_VITESSE=y
-CONFIG_DM_MDIO=y
-CONFIG_PHY_GIGE=y
-CONFIG_E1000=y
-CONFIG_FMAN_ENET=y
-CONFIG_SYS_FMAN_FW_ADDR=0x100000
-CONFIG_MII=y
-CONFIG_PCIE_FSL=y
-CONFIG_SYS_QE_FMAN_FW_IN_NAND=y
-CONFIG_DM_SERIAL=y
-CONFIG_SYS_NS16550=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_FSL_ESPI=y
-CONFIG_USB=y
-CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_MAX_CONTROLLER_COUNT=2
-CONFIG_USB_STORAGE=y
-CONFIG_ADDR_MAP=y
-CONFIG_SYS_NUM_ADDR_MAP=64
-CONFIG_POST=y
-- 
2.47.3

