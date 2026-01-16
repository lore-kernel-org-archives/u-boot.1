Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1285FD47CD6
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:56:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18EFD839AC;
	Fri, 16 Jan 2026 11:56:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="JIBguhtN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C66AB83981; Fri, 16 Jan 2026 11:56:24 +0100 (CET)
Received: from mx-relay48-hz3.antispameurope.com
 (mx-relay48-hz3.antispameurope.com [94.100.134.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55D0382BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0469552be2=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate48-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=zXweMgP9HrdhOuTvii+aMfNj/ZVtrFsjAkIRSWfrPCs=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1768560981;
 b=T1WilsPAl+w2/sgqb1NfCBygTbultp2E6qHwaWYcpkgwifEwmpE+W8W81kvezIBzNYoittwW
 c/Td/fTPRupEqvw9SaroRI5pLskw6tz1CZam5ayZ6K5rz+Xv0EtBaao5lmRFDzfouqPMeW8Jfra
 RCgUPeJxkkUoLa0ccsL6IC2GIGzlwaADUdaLBRAO+Shm9XyBvPF31Phulh1wsm8aaU1Ky2YssiC
 vLN1PZdbTlXoFx2UChk1je7NP0xNODy+DXIL2T6U1KEQlwIzoIHURQqTNjZSf/poRQNcLrh+JRs
 CXjhoyRlYYysQd7LpqU6PfM/xAkLsoIvWJ/vmiOSAEIjg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1768560981;
 b=WacnjJIuweDPh9P6N8OI2MfvVR6ZGeG1RM1GHi7p3HHa+MILdh9exFWmw7BQjb7QB15BGayi
 EfOWx4B0TzA4hRDkY4WpQ+od11ZoRhaVfxo95LT7FdARoJJZw0C1R1jB6HfzIdeWsF2ePOUlmC3
 nWssjDbJeAW1tkX51tIdOyNz2YW1RL8Mt0YhN92YyDUzY1urrmcYL5ZmRa61DpG6O1CAleZMzMy
 MFskWLqyfCEc45G70aTB2uaKqtLRANXqm/Kls4ehMHmMy9AugkxTaLqX7xZO0P6iK3Cbm2Q/qKD
 yb2Fln6cEbFfpWHHUGBRBPTijlHSl4XfO2ZOKN1j3Y+sA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay48-hz3.antispameurope.com; Fri, 16 Jan 2026 11:56:21 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 5F6B7220D9B; Fri, 16 Jan 2026 11:56:05 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Paul Gerber <Paul.Gerber@ew.tq-group.com>
Subject: [PATCH 3/5] configs: tqma6: mba6: add and use defconfigs with general
 configurations
Date: Fri, 16 Jan 2026 11:53:37 +0100
Message-ID: <20260116105351.2934665-4-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116105351.2934665-1-Max.Merchel@ew.tq-group.com>
References: <20260116105351.2934665-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay48-hz3.antispameurope.com with 4dsxbn6RcRz1kNh4R
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: aae75a51d423da042d55d8c3b493fae8
X-cloud-security: scantime:1.802
DKIM-Signature: a=rsa-sha256;
 bh=zXweMgP9HrdhOuTvii+aMfNj/ZVtrFsjAkIRSWfrPCs=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1768560980; v=1;
 b=JIBguhtNxei4aEpjryOZxRL9ECZBsSJWQFJumre9F0eiae4vJQsWbuG+z4xq4OvDwz/mxUCJ
 ueXq+YmxSqoXmhAjuMZwHk1TrZ0JE7yqO6Lk7LsEYnmpXdtiO/+UdJeYOqr9FhJ4MjaH4u6Ivyp
 7WJz1XaMRYRybckgMD4tHOi/VDuEimVKA8zeI5yBX4Mc48kbGg3wBW/Uq1XUNuq8YrkdJvLKxrQ
 lpIlZBl4zidqOy1RNVqVR1IHPVapGaRYv5ZCrIoJgzJGW1KeGwDZU47k9sjWOgcZ8tQk8sMOYPS
 iFrnCXKAqh8wPCRqEznass82u4KxYDdYTNhe0PRngldYQ==
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

Add a common, MMC and SPI defconfigs with the general configurations
and use them in the variant-specific defconfigs.

while at it:

- set BOOTCOMMAND to mmcboot as it is used on majority of other TQ modules
  as the default
- remove DEFAULT_FDT_FILE - The kernel device tree is set at runtime.
- remove CONFIG_CMD_EXT4_WRITE - EXT4 with default features cannot be
  written from U-Boot.
- add CONFIG_FDT_FIXUP_PARTITIONS - This is needed to propagate MTD
  partition setup via devicetree to linux.

Signed-off-by: Paul Gerber <Paul.Gerber@ew.tq-group.com>
Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 configs/tqma6_mba6_common.defconfig | 78 ++++++++++++++++++++++++++++
 configs/tqma6_mba6_mmc.defconfig    |  3 ++
 configs/tqma6_mba6_spi.defconfig    |  6 +++
 configs/tqma6dl_mba6_mmc_defconfig  | 77 ++-------------------------
 configs/tqma6dl_mba6_spi_defconfig  | 80 ++---------------------------
 configs/tqma6q_mba6_mmc_defconfig   | 76 ++-------------------------
 configs/tqma6q_mba6_spi_defconfig   | 80 ++---------------------------
 configs/tqma6s_mba6_mmc_defconfig   | 76 ++-------------------------
 configs/tqma6s_mba6_spi_defconfig   | 80 ++---------------------------
 9 files changed, 105 insertions(+), 451 deletions(-)
 create mode 100644 configs/tqma6_mba6_common.defconfig
 create mode 100644 configs/tqma6_mba6_mmc.defconfig
 create mode 100644 configs/tqma6_mba6_spi.defconfig

diff --git a/configs/tqma6_mba6_common.defconfig b/configs/tqma6_mba6_common.defconfig
new file mode 100644
index 00000000000..93517474b21
--- /dev/null
+++ b/configs/tqma6_mba6_common.defconfig
@@ -0,0 +1,78 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MX6=y
+CONFIG_SYS_MALLOC_LEN=0x202000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_SF_DEFAULT_SPEED=50000000
+CONFIG_ENV_SIZE=0x2000
+CONFIG_TARGET_TQMA6=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_FIXUP_PARTITIONS=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="run mmcboot"
+CONFIG_SYS_PBSIZE=532
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_BOOTZ=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
+CONFIG_CMD_MD5SUM=y
+CONFIG_MD5SUM_VERIFY=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_TEMPERATURE=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_ARP_TIMEOUT=200
+CONFIG_USE_ROOTPATH=y
+CONFIG_ROOTPATH="/srv/nfs"
+CONFIG_BOUNCE_BUFFER=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
+CONFIG_SYS_I2C_MXC=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x50
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_FSL_USDHC=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_PHY_ANEG_TIMEOUT=8000
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_FEC_MXC=y
+CONFIG_RGMII=y
+CONFIG_MII=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_IMX6=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PFUZE100=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PFUZE100=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_SERIAL=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_DM_THERMAL=y
+CONFIG_IMX_THERMAL=y
+CONFIG_IMX_WATCHDOG=y
diff --git a/configs/tqma6_mba6_mmc.defconfig b/configs/tqma6_mba6_mmc.defconfig
new file mode 100644
index 00000000000..a25184378e0
--- /dev/null
+++ b/configs/tqma6_mba6_mmc.defconfig
@@ -0,0 +1,3 @@
+CONFIG_ENV_OFFSET=0x100000
+CONFIG_ENV_IS_IN_MMC=y
+# CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/tqma6_mba6_spi.defconfig b/configs/tqma6_mba6_spi.defconfig
new file mode 100644
index 00000000000..5e161b1e16c
--- /dev/null
+++ b/configs/tqma6_mba6_spi.defconfig
@@ -0,0 +1,6 @@
+CONFIG_ENV_OFFSET=0x80000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_TQMA6X_SPI_BOOT=y
+CONFIG_ENV_OFFSET_REDUND=0x90000
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_REDUNDANT=y
diff --git a/configs/tqma6dl_mba6_mmc_defconfig b/configs/tqma6dl_mba6_mmc_defconfig
index ece085c3628..06166cb7da5 100644
--- a/configs/tqma6dl_mba6_mmc_defconfig
+++ b/configs/tqma6dl_mba6_mmc_defconfig
@@ -1,76 +1,5 @@
-CONFIG_ARM=y
-CONFIG_ARCH_MX6=y
-CONFIG_SYS_MALLOC_LEN=0x202000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_SF_DEFAULT_SPEED=50000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x100000
+#include <configs/tqma6_mba6_common.defconfig>
+#include <configs/tqma6_mba6_mmc.defconfig>
+
 CONFIG_MX6DL=y
-CONFIG_TARGET_TQMA6=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_BOOTDELAY=3
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run mmcboot; run netboot; run panicboot"
-CONFIG_DEFAULT_FDT_FILE="imx6dl-mba6x.dtb"
-CONFIG_SYS_PBSIZE=532
-# CONFIG_DISPLAY_BOARDINFO is not set
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_EEPROM=y
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_TEMPERATURE=y
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
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ARP_TIMEOUT=200
-CONFIG_BOUNCE_BUFFER=y
-CONFIG_BUTTON=y
-CONFIG_BUTTON_GPIO=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_MXC=y
-CONFIG_LED=y
-CONFIG_LED_GPIO=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-CONFIG_FSL_USDHC=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_WINBOND=y
-# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
-CONFIG_DM_MDIO=y
-CONFIG_DM_ETH_PHY=y
-CONFIG_FEC_MXC=y
-CONFIG_RGMII=y
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
-CONFIG_SYSRESET=y
-CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
-CONFIG_IMX_THERMAL=y
-CONFIG_IMX_WATCHDOG=y
diff --git a/configs/tqma6dl_mba6_spi_defconfig b/configs/tqma6dl_mba6_spi_defconfig
index c044cb080b0..f22ea543042 100644
--- a/configs/tqma6dl_mba6_spi_defconfig
+++ b/configs/tqma6dl_mba6_spi_defconfig
@@ -1,79 +1,5 @@
-CONFIG_ARM=y
-CONFIG_ARCH_MX6=y
-CONFIG_SYS_MALLOC_LEN=0x202000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_SF_DEFAULT_SPEED=50000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x80000
-CONFIG_ENV_SECT_SIZE=0x10000
+#include <configs/tqma6_mba6_common.defconfig>
+#include <configs/tqma6_mba6_spi.defconfig>
+
 CONFIG_MX6DL=y
-CONFIG_TARGET_TQMA6=y
-CONFIG_TQMA6X_SPI_BOOT=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
-CONFIG_ENV_OFFSET_REDUND=0x90000
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_BOOTDELAY=3
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="sf probe; run mmcboot; run netboot; run panicboot"
-CONFIG_DEFAULT_FDT_FILE="imx6dl-mba6x.dtb"
-CONFIG_SYS_PBSIZE=532
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_EEPROM=y
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_TEMPERATURE=y
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
-CONFIG_ENV_REDUNDANT=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ARP_TIMEOUT=200
-CONFIG_BOUNCE_BUFFER=y
-CONFIG_BUTTON=y
-CONFIG_BUTTON_GPIO=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_MXC=y
-CONFIG_LED=y
-CONFIG_LED_GPIO=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-CONFIG_FSL_USDHC=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_WINBOND=y
-# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
-CONFIG_DM_MDIO=y
-CONFIG_DM_ETH_PHY=y
-CONFIG_FEC_MXC=y
-CONFIG_RGMII=y
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
-CONFIG_SYSRESET=y
-CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
-CONFIG_IMX_THERMAL=y
-CONFIG_IMX_WATCHDOG=y
diff --git a/configs/tqma6q_mba6_mmc_defconfig b/configs/tqma6q_mba6_mmc_defconfig
index d5ef9be3a04..2d3fcbccc14 100644
--- a/configs/tqma6q_mba6_mmc_defconfig
+++ b/configs/tqma6q_mba6_mmc_defconfig
@@ -1,75 +1,5 @@
-CONFIG_ARM=y
-CONFIG_ARCH_MX6=y
-CONFIG_SYS_MALLOC_LEN=0x202000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_SF_DEFAULT_SPEED=50000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x100000
+#include <configs/tqma6_mba6_common.defconfig>
+#include <configs/tqma6_mba6_mmc.defconfig>
+
 CONFIG_MX6Q=y
-CONFIG_TARGET_TQMA6=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6q-mba6b"
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_BOOTDELAY=3
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run mmcboot; run netboot; run panicboot"
-CONFIG_DEFAULT_FDT_FILE="imx6q-mba6x.dtb"
-CONFIG_SYS_PBSIZE=532
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_EEPROM=y
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_TEMPERATURE=y
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
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ARP_TIMEOUT=200
-CONFIG_BOUNCE_BUFFER=y
-CONFIG_BUTTON=y
-CONFIG_BUTTON_GPIO=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_MXC=y
-CONFIG_LED=y
-CONFIG_LED_GPIO=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-CONFIG_FSL_USDHC=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_WINBOND=y
-# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
-CONFIG_DM_MDIO=y
-CONFIG_DM_ETH_PHY=y
-CONFIG_FEC_MXC=y
-CONFIG_RGMII=y
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
-CONFIG_SYSRESET=y
-CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
-CONFIG_IMX_THERMAL=y
-CONFIG_IMX_WATCHDOG=y
diff --git a/configs/tqma6q_mba6_spi_defconfig b/configs/tqma6q_mba6_spi_defconfig
index 09565189c0a..5d61d097eec 100644
--- a/configs/tqma6q_mba6_spi_defconfig
+++ b/configs/tqma6q_mba6_spi_defconfig
@@ -1,79 +1,5 @@
-CONFIG_ARM=y
-CONFIG_ARCH_MX6=y
-CONFIG_SYS_MALLOC_LEN=0x202000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_SF_DEFAULT_SPEED=50000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x80000
-CONFIG_ENV_SECT_SIZE=0x10000
+#include <configs/tqma6_mba6_common.defconfig>
+#include <configs/tqma6_mba6_spi.defconfig>
+
 CONFIG_MX6Q=y
-CONFIG_TARGET_TQMA6=y
-CONFIG_TQMA6X_SPI_BOOT=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6q-mba6b"
-CONFIG_ENV_OFFSET_REDUND=0x90000
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_BOOTDELAY=3
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="sf probe; run mmcboot; run netboot; run panicboot"
-CONFIG_DEFAULT_FDT_FILE="nxp/imx/imx6q-mba6x.dtb"
-CONFIG_SYS_PBSIZE=532
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_EEPROM=y
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_TEMPERATURE=y
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
-CONFIG_ENV_REDUNDANT=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ARP_TIMEOUT=200
-CONFIG_BOUNCE_BUFFER=y
-CONFIG_BUTTON=y
-CONFIG_BUTTON_GPIO=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_MXC=y
-CONFIG_LED=y
-CONFIG_LED_GPIO=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-CONFIG_FSL_USDHC=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_WINBOND=y
-# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
-CONFIG_DM_MDIO=y
-CONFIG_DM_ETH_PHY=y
-CONFIG_FEC_MXC=y
-CONFIG_RGMII=y
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
-CONFIG_SYSRESET=y
-CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
-CONFIG_IMX_THERMAL=y
-CONFIG_IMX_WATCHDOG=y
diff --git a/configs/tqma6s_mba6_mmc_defconfig b/configs/tqma6s_mba6_mmc_defconfig
index 9e7e7a0ecf0..323f582e874 100644
--- a/configs/tqma6s_mba6_mmc_defconfig
+++ b/configs/tqma6s_mba6_mmc_defconfig
@@ -1,75 +1,5 @@
-CONFIG_ARM=y
-CONFIG_ARCH_MX6=y
-CONFIG_SYS_MALLOC_LEN=0x202000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_SF_DEFAULT_SPEED=50000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x100000
+#include <configs/tqma6_mba6_common.defconfig>
+#include <configs/tqma6_mba6_mmc.defconfig>
+
 CONFIG_MX6S=y
-CONFIG_TARGET_TQMA6=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_BOOTDELAY=3
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run mmcboot; run netboot; run panicboot"
-CONFIG_DEFAULT_FDT_FILE="imx6dl-mba6x.dtb"
-CONFIG_SYS_PBSIZE=532
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_EEPROM=y
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_TEMPERATURE=y
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
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ARP_TIMEOUT=200
-CONFIG_BOUNCE_BUFFER=y
-CONFIG_BUTTON=y
-CONFIG_BUTTON_GPIO=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_MXC=y
-CONFIG_LED=y
-CONFIG_LED_GPIO=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-CONFIG_FSL_USDHC=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_WINBOND=y
-# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
-CONFIG_DM_MDIO=y
-CONFIG_DM_ETH_PHY=y
-CONFIG_FEC_MXC=y
-CONFIG_RGMII=y
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
-CONFIG_SYSRESET=y
-CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
-CONFIG_IMX_THERMAL=y
-CONFIG_IMX_WATCHDOG=y
diff --git a/configs/tqma6s_mba6_spi_defconfig b/configs/tqma6s_mba6_spi_defconfig
index 61c59fa416c..9701d35cfb8 100644
--- a/configs/tqma6s_mba6_spi_defconfig
+++ b/configs/tqma6s_mba6_spi_defconfig
@@ -1,79 +1,5 @@
-CONFIG_ARM=y
-CONFIG_ARCH_MX6=y
-CONFIG_SYS_MALLOC_LEN=0x202000
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_SF_DEFAULT_SPEED=50000000
-CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x80000
-CONFIG_ENV_SECT_SIZE=0x10000
+#include <configs/tqma6_mba6_common.defconfig>
+#include <configs/tqma6_mba6_spi.defconfig>
+
 CONFIG_MX6S=y
-CONFIG_TARGET_TQMA6=y
-CONFIG_TQMA6X_SPI_BOOT=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
-CONFIG_ENV_OFFSET_REDUND=0x90000
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_SUPPORT_RAW_INITRD=y
-CONFIG_BOOTDELAY=3
-CONFIG_OF_BOARD_SETUP=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="sf probe; run mmcboot; run netboot; run panicboot"
-CONFIG_DEFAULT_FDT_FILE="imx6dl-mba6x.dtb"
-CONFIG_SYS_PBSIZE=532
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_EEPROM=y
-CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_SPI=y
-CONFIG_CMD_TEMPERATURE=y
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
-CONFIG_ENV_REDUNDANT=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ARP_TIMEOUT=200
-CONFIG_BOUNCE_BUFFER=y
-CONFIG_BUTTON=y
-CONFIG_BUTTON_GPIO=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_MXC=y
-CONFIG_LED=y
-CONFIG_LED_GPIO=y
-CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-CONFIG_FSL_USDHC=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_WINBOND=y
-# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
-CONFIG_DM_MDIO=y
-CONFIG_DM_ETH_PHY=y
-CONFIG_FEC_MXC=y
-CONFIG_RGMII=y
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
-CONFIG_SYSRESET=y
-CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
-CONFIG_IMX_THERMAL=y
-CONFIG_IMX_WATCHDOG=y
-- 
2.43.0

