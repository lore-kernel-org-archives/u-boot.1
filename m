Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD97C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 08:40:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C994A88A27;
	Thu, 15 Aug 2024 10:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723711230;
	bh=AoIWyqaNVed0teL8WIbVEIQ3PGifm5pEFD2F+quP1O8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sVrAswKAxKxXtXEwFEMoLyDjEiDMkFdstwih+iWKjM31rKn7Tsh679pT+fYP2ef9t
	 tcWPwz5olvr2EosZSa6GSGSbq/0cFvmiWbLGarl0U+xcYPBawl5W4LXKb3LT90W8fL
	 7EmVzZXUcJa2t22YFnOHtayqclbVxzTPiicYbMO8RcpMrgl51FqzksIUEwqS+em7Ji
	 m4nY/KXwU/HhwVt45UqCizhFpn5HeMTFQ2myAEPA339haxiF5Vir2PIUqzMzkUSxVO
	 SnXGAieBf/y1E4VjEs+pON2PhHTxsK8RfqsGfGt2yD/CQ+/mUva1/SaL4TECxBuYWQ
	 CpQwPmxc7UgCQ==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F25348899D;
 Thu, 15 Aug 2024 10:40:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723711229;
 bh=AoIWyqaNVed0teL8WIbVEIQ3PGifm5pEFD2F+quP1O8=;
 h=From:To:Cc:Subject:Date:From;
 b=MzuG6piD3gEVKHMpsQfPuHF61TVxEQj4CtPm4UBTDh9+RRDN82UzDpSSEculvEKEm
 4xGBl1yzALhxea7elcZSQqSt/IeT1U2Ec4nOzcttItaQh2CdHkkglx+kB7OMYt9E7N
 j5TjuwJQpDnABLmumj8qwzUo0MX4ch7We8gGpbEZyGooSy/HOukUQV5QMsJsnNQlnp
 oJMJHo50qbS/nMYmUxfhQJ8RRUrtXvISXsRLaqKGp6GKLIhYK0SJWnG8A4U7PdZ3ns
 gxEEdlMZN0+6UNOAxESpo3GbeTzMqKHqazjbV4T0lE5iafgGtuqr2LhNnHgGuh1iTi
 Qklnd5u7rHyRA==
From: Lukasz Majewski <lukma@denx.de>
To: Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com, Cem Tenruh <c.tenruh@phytec.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Yannic Moog <y.moog@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] config: imx: Add PHYTEC's phycore-imx8mm-fspi_defconfig
Date: Thu, 15 Aug 2024 10:40:12 +0200
Message-Id: <20240815084012.477436-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
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

This configuration file provides support for booting phycore module
(on e.g. polis-rdk base development board) from QSPI memory.

Moreover, the SDP SPL gadget is supported, so single flash.bin
binary can be used with uuu (with uuu -v -b qspi ~/u-boot/flash.bin)
to flash QSPI in the factory or during debricking.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 configs/phycore-imx8mm-fspi_defconfig | 158 ++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 configs/phycore-imx8mm-fspi_defconfig

diff --git a/configs/phycore-imx8mm-fspi_defconfig b/configs/phycore-imx8mm-fspi_defconfig
new file mode 100644
index 0000000000..79a2668254
--- /dev/null
+++ b/configs/phycore-imx8mm-fspi_defconfig
@@ -0,0 +1,158 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX8M=y
+CONFIG_TEXT_BASE=0x40200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SF_DEFAULT_SPEED=80000000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x3C0000
+CONFIG_IMX_CONFIG="board/freescale/imx8mm_evk/imximage-8mm-lpddr4-fspi.cfg"
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-phyboard-polis-rdk"
+CONFIG_SPL_TEXT_BASE=0x7E2000
+CONFIG_TARGET_PHYCORE_IMX8MM=y
+CONFIG_DM_RESET=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x920000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x910000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0x3E0000
+CONFIG_SYS_LOAD_ADDR=0x40480000
+CONFIG_PCI=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_FIT_EXTERNAL_OFFSET=0x3000
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then run mmcboot; else run netboot; fi; fi;"
+CONFIG_DEFAULT_FDT_FILE="oftree"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x25000
+CONFIG_SPL_PAD_TO=0x0
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
+CONFIG_SPL_I2C=y
+CONFIG_SPL_NOR_SUPPORT=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_SPI_FLASH_MTD=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="u-boot=> "
+# CONFIG_CMD_EXPORTENV is not set
+# CONFIG_CMD_IMPORTENV is not set
+# CONFIG_CMD_CRC32 is not set
+CONFIG_CMD_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
+CONFIG_SYS_EEPROM_SIZE=4096
+CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
+CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
+CONFIG_CMD_CLK=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=2
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_CLK_COMPOSITE_CCF=y
+CONFIG_CLK_COMPOSITE_CCF=y
+CONFIG_SPL_CLK_IMX8MM=y
+CONFIG_CLK_IMX8MM=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x42800000
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_MXC_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x51
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SF_DEFAULT_BUS=3
+CONFIG_SPI_FLASH_BAR=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_SST=y
+CONFIG_SPI_FLASH_WINBOND=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_PHY_GIGE=y
+CONFIG_FEC_MXC=y
+CONFIG_MII=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_IMX=y
+CONFIG_PHY_IMX8M_PCIE=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX8M=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_SERIAL=y
+CONFIG_MXC_UART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_DM_THERMAL=y
+CONFIG_IMX_TMU=y
+CONFIG_USB=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_MXC_USB_OTG_HACTIVE=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_CI_UDC=y
+CONFIG_SDP_LOADADDR=0x40400000
+CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_IMX_WATCHDOG=y
+CONFIG_FSPI_CONF_HEADER=y
+CONFIG_FSPI_CONF_FILE="fspi_header.bin"
-- 
2.39.2

