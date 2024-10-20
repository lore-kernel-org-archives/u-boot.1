Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD61D3C92A
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 17:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B26488ECB;
	Sun, 20 Oct 2024 19:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Y/uNjw/N";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="a70NX/Cr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A8788EC9; Sun, 20 Oct 2024 19:28:15 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0259C88E8C
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 19:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XWllJ5FkNz9sR1;
 Sun, 20 Oct 2024 19:28:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729445292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mIaiYW4ylbLAJZ81LfjfbFhvLbxwHn70mctv1gVM8L8=;
 b=Y/uNjw/Na9CZN68Iv6rBTeftCkNX6D2pkHLppaW6MbUyjlGAs3XROVxgSspWoJoy0EklMQ
 oOmUZ5oTW1JQiFNkU9a2qCI9VWURReXj/uvUI85ChgsW3LPKwgQZlpJ20YqO25aOHiJKb7
 08fUymf6DPk37ojqTjCaOcFOMtok20drmE33Mxxo1gKDB7K3k8d3rOgbJgqZq/fWGtp7eR
 zVatQvRnYUezVLz7hn8nQu7DoWbSn1hIo86luGThjU7vGFKmFnWbYbAtbOuAVJ1cowpoBi
 P/S8BxJ/hL3t7oEJIOnD9bAMEIVlIh+6e0KsJfsCw8YPplt6y14UAX7QSRudTw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729445289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mIaiYW4ylbLAJZ81LfjfbFhvLbxwHn70mctv1gVM8L8=;
 b=a70NX/CranqktxgAZ6HvArN5bVuIMJmd+Uh52ddIY4cWXT871ylYAEU465h1mph1NAe9Rg
 6rPuJg5FrMHMMiSAJPCT/qUpbt9zogbGRQM9m/MNIMgvSdlqvNE3+p9QIbEE74XAetgDmo
 QAKBXbk5MVCo+qWfrQmjTDlA9hpS9gizdD3jlytAuGSvnbjQi/R4mGRN6spiP5c2X3REVX
 6RLOqXA7wZ6Jz0JFp/Rqny98tQz6w8BAiFKULViQXs5zlsQRqfse11tbXakoumBTUCtAss
 pjAhYmYvaF8vBAkrRWtnDFKsQvry/8b7zv6xqH1ws19I+cEwg3IgoO4IsN0aRg==
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
Subject: [PATCH 3/5] ARM: renesas: Deduplicate Renesas R-Car Gen4 defconfigs
Date: Sun, 20 Oct 2024 19:27:15 +0200
Message-ID: <20241020172734.1187843-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241020172734.1187843-1-marek.vasut+renesas@mailbox.org>
References: <20241020172734.1187843-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1c8qwkst7ggeobhxpjc1sxiut56j3b8t
X-MBO-RS-ID: 314ac3589f0dcfbc791
X-Rspamd-Queue-Id: 4XWllJ5FkNz9sR1
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
out the common parts into generic renesas_rcar4_defconfig and including
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
 configs/r8a779a0_falcon_defconfig    | 59 +---------------------------
 configs/r8a779f0_spider_defconfig    | 59 +---------------------------
 configs/r8a779g0_whitehawk_defconfig | 59 +---------------------------
 configs/r8a779h0_grayhawk_defconfig  | 59 +---------------------------
 configs/renesas_rcar4_defconfig      | 57 +++++++++++++++++++++++++++
 5 files changed, 65 insertions(+), 228 deletions(-)
 create mode 100644 configs/renesas_rcar4_defconfig

diff --git a/configs/r8a779a0_falcon_defconfig b/configs/r8a779a0_falcon_defconfig
index ad53d8815b5..e89b99b6fe8 100644
--- a/configs/r8a779a0_falcon_defconfig
+++ b/configs/r8a779a0_falcon_defconfig
@@ -1,75 +1,20 @@
-CONFIG_ARM=y
+#include <configs/renesas_rcar4_defconfig>
+
 CONFIG_COUNTER_FREQUENCY=16666666
-CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RENESAS=y
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
index 1959abc3c32..f080c8e1849 100644
--- a/configs/r8a779f0_spider_defconfig
+++ b/configs/r8a779f0_spider_defconfig
@@ -1,84 +1,29 @@
-CONFIG_ARM=y
-CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RENESAS=y
-CONFIG_SYS_MALLOC_LEN=0x4000000
+#include <configs/renesas_rcar4_defconfig>
+
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
index ba7abb93dff..1bfe9d8044e 100644
--- a/configs/r8a779g0_whitehawk_defconfig
+++ b/configs/r8a779g0_whitehawk_defconfig
@@ -1,75 +1,20 @@
-CONFIG_ARM=y
-CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RENESAS=y
-CONFIG_SYS_MALLOC_LEN=0x4000000
+#include <configs/renesas_rcar4_defconfig>
+
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
index 73dd62eb539..3d1aeebb5e7 100644
--- a/configs/r8a779h0_grayhawk_defconfig
+++ b/configs/r8a779h0_grayhawk_defconfig
@@ -1,75 +1,20 @@
-CONFIG_ARM=y
-CONFIG_ARCH_CPU_INIT=y
-CONFIG_ARCH_RENESAS=y
-CONFIG_SYS_MALLOC_LEN=0x4000000
+#include <configs/renesas_rcar4_defconfig>
+
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
diff --git a/configs/renesas_rcar4_defconfig b/configs/renesas_rcar4_defconfig
new file mode 100644
index 00000000000..edc7af8ce4e
--- /dev/null
+++ b/configs/renesas_rcar4_defconfig
@@ -0,0 +1,57 @@
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
+CONFIG_RCAR_GEN4=y
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

