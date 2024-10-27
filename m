Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F9DD0C604
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 02:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C860988C4A;
	Sun, 27 Oct 2024 03:21:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FmUmx9Sh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WfGl3uK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B236389051; Sun, 27 Oct 2024 03:21:35 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE8C188F01
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 03:21:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XbgHt36GXz9sls;
 Sun, 27 Oct 2024 03:21:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729995690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vurt8x24b555QfX+dZOuG3S2uahoz1Q7xxr+BSJE0kM=;
 b=FmUmx9ShIRfUbjYfDc/3ZiGAObaYIS0iG3wQpPIbbI2EPSckmO8bnDaA25uJwG+wUX+N8L
 l3aC6n/pHOr4fH4e2iXWdlXtPduwljWQWtmgAaUxpkyii4d+x1Q6xbdtGO6R0kf0O0k1eY
 1kAu5qMJOwEdCdvOGvA5fdWKmpsqeL90HW+FoNaKieXUrLI/rg19r8VAnXDnXKltNDd8Bw
 KbFD/pjp85lXCLkScl+pss4rIYD4+4Dc7ASBnUaFwHSWPaiCtcip7mFwZIXdHn/JfUrjUp
 laFBVJODD20esuqlgkRljl9T29SE/nXfjn20DCNbO2u5coLB5GwgJEfyzHVI+A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729995688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vurt8x24b555QfX+dZOuG3S2uahoz1Q7xxr+BSJE0kM=;
 b=WfGl3uK3cn7ghxFPY2RxEcNZ4E9g5y5MPUtAA9F7Sl5zBIpT4keGicogIoT9NcFmXKo1mg
 rXI2YXExfOqCko9l7JmhUJg8VJVycI3Rg6eQGhYOxmf0/rAJpGqtQP7Q/w4YTNHbz/D6Tp
 GgOxcPqAhgMXP2kfK0s61DUq7j0nSIALKR++KhfEhLKhm/MGPTjLD20Fu6P1J00s5zB/4a
 j//lIhVgh+HpU2PdZMHPPFb0cnXk+sq8ESVi5wJpZOKEHAuilJfTRi1vrzHY+LfoF1u1ns
 FH09Tva0UoIRwcbCPky+kFuyXAIqbPSDqnTo92Q84O24Ofclen4xeNNjjC+FYA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/5] ARM: renesas: Deduplicate Renesas R-Car Gen4 defconfigs
Date: Sun, 27 Oct 2024 03:20:05 +0100
Message-ID: <20241027022040.356716-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241027022040.356716-1-marek.vasut+renesas@mailbox.org>
References: <20241027022040.356716-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ycuwmdabiboodixaptqbmotet45fs76z
X-MBO-RS-ID: 4c787a95bfe2c65ab53
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

Deduplicate defconfigs for all Renesas R-Car Gen4 systems by factoring
out the common parts into generic renesas_rcar4.config and including
those using the #include <configs/...> preprocessor macro in the current
set of board specific defconfigs. The preprocessor macro is applicable
to defconfigs as well.

This introduces no functional change, the resulting .config is identical
for all Renesas R-Car Gen4 systems.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Cogent Embedded, Inc." <source@cogentembedded.com>
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Rename common _defconfig to .config
---
 configs/r8a779a0_falcon_defconfig    | 60 ++--------------------------
 configs/r8a779f0_spider_defconfig    | 58 ++-------------------------
 configs/r8a779g0_whitehawk_defconfig | 58 ++-------------------------
 configs/r8a779h0_grayhawk_defconfig  | 58 ++-------------------------
 configs/renesas_rcar4.config         | 56 ++++++++++++++++++++++++++
 5 files changed, 69 insertions(+), 221 deletions(-)
 create mode 100644 configs/renesas_rcar4.config

diff --git a/configs/r8a779a0_falcon_defconfig b/configs/r8a779a0_falcon_defconfig
index ad53d8815b5..aae4406bf04 100644
--- a/configs/r8a779a0_falcon_defconfig
+++ b/configs/r8a779a0_falcon_defconfig
@@ -1,75 +1,23 @@
+#include <configs/renesas_rcar4.config>
+
 CONFIG_ARM=y
-CONFIG_COUNTER_FREQUENCY=16666666
-CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_RENESAS=y
+CONFIG_RCAR_GEN4=y
+CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_TEXT_BASE=0x50000000
-CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC00000
 CONFIG_ENV_SECT_SIZE=0x40000
-CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779a0-falcon"
-CONFIG_RCAR_GEN4=y
 CONFIG_TARGET_FALCON=y
-CONFIG_SYS_MONITOR_LEN=1048576
-CONFIG_SYS_LOAD_ADDR=0x58000000
 CONFIG_SYS_CLK_FREQ=16666666
-# CONFIG_PSCI_RESET is not set
 CONFIG_ARMV8_PSCI=y
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="root=/dev/nfs rw nfsroot=192.168.0.1:/export/rfs ip=192.168.0.20"
-CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a779a0-falcon.dtb; booti 0x48080000 - 0x48000000"
 CONFIG_DEFAULT_FDT_FILE="r8a779a0-falcon.dtb"
 CONFIG_SYS_PBSIZE=2068
-CONFIG_SYS_MALLOC_BOOTPARAMS=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_VERSION_VARIABLE=y
-CONFIG_REGMAP=y
-CONFIG_SYSCON=y
-CONFIG_CLK=y
-CONFIG_CLK_RENESAS=y
-CONFIG_RCAR_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_RCAR_I2C=y
-CONFIG_MMC_IO_VOLTAGE=y
-CONFIG_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS200_SUPPORT=y
-CONFIG_RENESAS_SDHI=y
-CONFIG_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_SPANSION=y
-# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
-CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
-CONFIG_DM_ETH_PHY=y
 CONFIG_RENESAS_RAVB=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SCIF_CONSOLE=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_RENESAS_RPC_SPI=y
diff --git a/configs/r8a779f0_spider_defconfig b/configs/r8a779f0_spider_defconfig
index 1959abc3c32..7274038a202 100644
--- a/configs/r8a779f0_spider_defconfig
+++ b/configs/r8a779f0_spider_defconfig
@@ -1,84 +1,32 @@
+#include <configs/renesas_rcar4.config>
+
 CONFIG_ARM=y
-CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_RENESAS=y
-CONFIG_SYS_MALLOC_LEN=0x4000000
+CONFIG_RCAR_GEN4=y
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xD00000
 CONFIG_ENV_SECT_SIZE=0x40000
-CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779f0-spider"
-CONFIG_RCAR_GEN4=y
 CONFIG_TARGET_SPIDER=y
-CONFIG_SYS_MONITOR_LEN=1048576
-CONFIG_SYS_LOAD_ADDR=0x58000000
 CONFIG_SYS_CLK_FREQ=20000000
-# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_BOOT_GET_CMDLINE=y
 CONFIG_SYS_BARGSIZE=2048
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="root=/dev/nfs rw nfsroot=192.168.0.1:/export/rfs ip=192.168.0.20"
-CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="tftp 0x48080000 Image && tftp 0x48000000 Image-r8a779f0-spider.dtb && booti 0x48080000 - 0x48000000"
 CONFIG_DEFAULT_FDT_FILE="r8a779f0-spider.dtb"
 CONFIG_SYS_CBSIZE=2048
-CONFIG_SYS_MALLOC_BOOTPARAMS=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
-CONFIG_CMD_SPI=y
 CONFIG_CMD_UFS=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_VERSION_VARIABLE=y
-CONFIG_REGMAP=y
-CONFIG_SYSCON=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
-CONFIG_CLK=y
 CONFIG_CLK_GPIO=y
-CONFIG_CLK_RENESAS=y
-CONFIG_RCAR_GPIO=y
 CONFIG_DM_PCA953X=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_RCAR_I2C=y
-CONFIG_MMC_IO_VOLTAGE=y
-CONFIG_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS200_SUPPORT=y
-CONFIG_RENESAS_SDHI=y
-CONFIG_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_SPANSION=y
-# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
-CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHYLIB_10G=y
 CONFIG_PHY_MARVELL_10G=y
-CONFIG_DM_ETH_PHY=y
 CONFIG_RENESAS_ETHER_SWITCH=y
 CONFIG_PHY_R8A779F0_ETHERNET_SERDES=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SCSI=y
 CONFIG_BAUDRATE=1843200
-CONFIG_SCIF_CONSOLE=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_RENESAS_RPC_SPI=y
 CONFIG_UFS=y
 CONFIG_UFS_RENESAS=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=131072
diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whitehawk_defconfig
index ba7abb93dff..758b0ff5c97 100644
--- a/configs/r8a779g0_whitehawk_defconfig
+++ b/configs/r8a779g0_whitehawk_defconfig
@@ -1,75 +1,23 @@
+#include <configs/renesas_rcar4.config>
+
 CONFIG_ARM=y
-CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_RENESAS=y
-CONFIG_SYS_MALLOC_LEN=0x4000000
+CONFIG_RCAR_GEN4=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
-CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779g0-white-hawk"
-CONFIG_RCAR_GEN4=y
 CONFIG_TARGET_WHITEHAWK=y
-CONFIG_SYS_MONITOR_LEN=1048576
-CONFIG_SYS_LOAD_ADDR=0x58000000
 CONFIG_SYS_CLK_FREQ=16666666
-# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_BOOT_GET_CMDLINE=y
 CONFIG_SYS_BARGSIZE=2048
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="root=/dev/nfs rw nfsroot=192.168.0.1:/export/rfs ip=192.168.0.20"
-CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="tftp 0x48080000 Image && tftp 0x48000000 Image-r8a779g0-white-hawk.dtb && booti 0x48080000 - 0x48000000"
 CONFIG_DEFAULT_FDT_FILE="r8a779g0-white-hawk.dtb"
 CONFIG_SYS_CBSIZE=2048
-CONFIG_SYS_MALLOC_BOOTPARAMS=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
-CONFIG_VERSION_VARIABLE=y
-CONFIG_REGMAP=y
-CONFIG_SYSCON=y
-CONFIG_CLK=y
-CONFIG_CLK_RENESAS=y
-CONFIG_RCAR_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_RCAR_I2C=y
-CONFIG_MMC_IO_VOLTAGE=y
-CONFIG_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS200_SUPPORT=y
-CONFIG_RENESAS_SDHI=y
-CONFIG_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_SPANSION=y
-# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
-CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
-CONFIG_DM_ETH_PHY=y
 CONFIG_RENESAS_RAVB=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_BAUDRATE=921600
-CONFIG_SCIF_CONSOLE=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_RENESAS_RPC_SPI=y
diff --git a/configs/r8a779h0_grayhawk_defconfig b/configs/r8a779h0_grayhawk_defconfig
index 73dd62eb539..ef709214f03 100644
--- a/configs/r8a779h0_grayhawk_defconfig
+++ b/configs/r8a779h0_grayhawk_defconfig
@@ -1,75 +1,23 @@
+#include <configs/renesas_rcar4.config>
+
 CONFIG_ARM=y
-CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_RENESAS=y
-CONFIG_SYS_MALLOC_LEN=0x4000000
+CONFIG_RCAR_GEN4=y
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
-CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779h0-gray-hawk-single"
-CONFIG_RCAR_GEN4=y
 CONFIG_TARGET_GRAYHAWK=y
-CONFIG_SYS_MONITOR_LEN=1048576
-CONFIG_SYS_LOAD_ADDR=0x58000000
 CONFIG_SYS_CLK_FREQ=16666666
-# CONFIG_PSCI_RESET is not set
 CONFIG_SYS_BOOT_GET_CMDLINE=y
 CONFIG_SYS_BARGSIZE=2048
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="root=/dev/nfs rw nfsroot=192.168.0.1:/export/rfs ip=192.168.0.20"
-CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="tftp 0x48080000 Image && tftp 0x48000000 Image-r8a779h0-gray-hawk.dtb && booti 0x48080000 - 0x48000000"
 CONFIG_DEFAULT_FDT_FILE="r8a779h0-gray-hawk.dtb"
 CONFIG_SYS_CBSIZE=2048
-CONFIG_SYS_MALLOC_BOOTPARAMS=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
-CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_MMC=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
-CONFIG_VERSION_VARIABLE=y
-CONFIG_REGMAP=y
-CONFIG_SYSCON=y
-CONFIG_CLK=y
-CONFIG_CLK_RENESAS=y
-CONFIG_RCAR_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_RCAR_I2C=y
-CONFIG_MMC_IO_VOLTAGE=y
-CONFIG_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS200_SUPPORT=y
-CONFIG_RENESAS_SDHI=y
-CONFIG_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_SPANSION=y
-# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
-CONFIG_PHY_ANEG_TIMEOUT=20000
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
-CONFIG_DM_ETH_PHY=y
 CONFIG_RENESAS_RAVB=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_BAUDRATE=921600
-CONFIG_SCIF_CONSOLE=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_RENESAS_RPC_SPI=y
diff --git a/configs/renesas_rcar4.config b/configs/renesas_rcar4.config
new file mode 100644
index 00000000000..ebca0591838
--- /dev/null
+++ b/configs/renesas_rcar4.config
@@ -0,0 +1,56 @@
+# CONFIG_PSCI_RESET is not set
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_ARCH_CPU_INIT=y
+CONFIG_ARCH_RENESAS=y
+CONFIG_ARM=y
+CONFIG_BOOTARGS="root=/dev/nfs rw nfsroot=192.168.0.1:/export/rfs ip=192.168.0.20"
+CONFIG_CLK=y
+CONFIG_CLK_RENESAS=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_SPI=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_DM_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_SPI=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_FIT=y
+CONFIG_HUSH_PARSER=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MTD=y
+CONFIG_OF_CONTROL=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
+CONFIG_RCAR_GPIO=y
+CONFIG_REGMAP=y
+CONFIG_REMAKE_ELF=y
+CONFIG_RENESAS_RPC_SPI=y
+CONFIG_RENESAS_SDHI=y
+CONFIG_SCIF_CONSOLE=y
+CONFIG_SPI=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_SYSCON=y
+CONFIG_SYS_I2C_RCAR_I2C=y
+CONFIG_SYS_LOAD_ADDR=0x58000000
+CONFIG_SYS_MALLOC_BOOTPARAMS=y
+CONFIG_SYS_MALLOC_LEN=0x4000000
+CONFIG_SYS_MONITOR_LEN=1048576
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_USE_BOOTARGS=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_VERSION_VARIABLE=y
-- 
2.45.2

