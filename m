Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B27CF6491
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 23:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78143889DA;
	Sun, 29 Sep 2024 01:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727567649;
	bh=qRxZQy5a1cYPOlgGSbTyJUUQWH/gVdIJ4VES5MzfqBg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pm4JP33gWHMMmSjLEiUszgDYB425vjBS5AXn8gOG6OLItRiPScIwpJv4deti5OB6E
	 eQc6msQVtJhs5/qb0bphI5D5IYIU+lnZ2Yc/HNcVIQV9eRjxTlCamjfdyi4z/8/tAg
	 6hpBm315i0rhtJZlYaczP7x+QKky2gFtgMUYLDIyKGlCW+hRzYYNcXND6XBpraTiuJ
	 XdPRiA1LQsi67jDkx+Qagd6rRBOrWibe0ZxvcvnLw+hpqn8rUGc8rZ2JaQJstcO4Vx
	 ga5/Bw7d1GzJdLTLiDy/7OQQI+eRTQTEgc6HbRMq/O8uOzqW+IbgZJ5O2Sy/YWUeQA
	 ynJKFVZlOAc5g==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6119588972;
 Sun, 29 Sep 2024 01:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727567648;
 bh=qRxZQy5a1cYPOlgGSbTyJUUQWH/gVdIJ4VES5MzfqBg=;
 h=From:To:Cc:Subject:Date:From;
 b=roE+xtApHHBtKf79h2O9F9qHu39nfNAiaJpnU0RCNQKV5+FvYxfWTG+cmLXBt6vac
 iqBZBsrx8QsL1l0Zt4tWkFz7C+ptsQAddg/ii8OZAkIS/M+U5I7HeJi9oZ5TgEb6k/
 wx9fhIlJdInjARWI2oMn5OvUpFCYyckXYJ1LQzCdtuzTjFOE3ZAUCeLxWYp8BcAjqf
 aU5RsxdZ6F4B+H+DAX3+fWdQ2gpjsZjCmc1Zk/wjtJE1vwmwMzYy/LEThZFEND+3hR
 ThoeteKqjamKJbvqdFMKOJlBa/r6lfeu81kWAfB0NO+0kHnzvr+5HQdJUrSIu+6Utw
 7mxVZ54xdQItQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
Subject: [PATCH] arm64: dts: imx8mp: Add support for DH electronics i.MX8M
 Plus DHCOM PicoITX
Date: Sun, 29 Sep 2024 01:52:35 +0200
Message-ID: <20240928235325.358821-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

Add support for DH electronics i.MX8M Plus DHCOM SoM on PicoITX carrier board.
This system is populated with serial console, EQoS ethernet, eMMC, SD, SPI NOR,
LEDs and USB 3.0 host used in USB 2.0 mode on PicoITX.

Matching Linux kernel patch has been posted:
https://lore.kernel.org/imx/20240928234949.357893-2-marex@denx.de/

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/imx8mp-dhcom-picoitx-u-boot.dtsi |   6 +
 arch/arm/dts/imx8mp-dhcom-picoitx.dts         | 152 ++++++++++
 configs/imx8mp_dhcom_picoitx_defconfig        | 273 ++++++++++++++++++
 4 files changed, 432 insertions(+)
 create mode 100644 arch/arm/dts/imx8mp-dhcom-picoitx-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx8mp-dhcom-picoitx.dts
 create mode 100644 configs/imx8mp_dhcom_picoitx_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index cdb90f1d358..d69b53ce8f7 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -972,6 +972,7 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mp-dhcom-pdk2.dtb \
 	imx8mp-dhcom-pdk3.dtb \
 	imx8mp-dhcom-pdk3-overlay-rev100.dtbo \
+	imx8mp-dhcom-picoitx.dtb \
 	imx8mp-icore-mx8mp-edimm2.2.dtb \
 	imx8mp-msc-sm2s.dtb \
 	imx8mq-pico-pi.dtb \
diff --git a/arch/arm/dts/imx8mp-dhcom-picoitx-u-boot.dtsi b/arch/arm/dts/imx8mp-dhcom-picoitx-u-boot.dtsi
new file mode 100644
index 00000000000..4e95cd0e483
--- /dev/null
+++ b/arch/arm/dts/imx8mp-dhcom-picoitx-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023-2024 Marek Vasut <marex@denx.de>
+ */
+
+#include "imx8mp-dhcom-u-boot.dtsi"
diff --git a/arch/arm/dts/imx8mp-dhcom-picoitx.dts b/arch/arm/dts/imx8mp-dhcom-picoitx.dts
new file mode 100644
index 00000000000..285aaa5b6c0
--- /dev/null
+++ b/arch/arm/dts/imx8mp-dhcom-picoitx.dts
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023-2024 Marek Vasut <marex@denx.de>
+ *
+ * DHCOM iMX8MP variant:
+ * DHCM-iMX8ML8-C160-R204-F1638-SPI16-E-SD-RTC-T-RGB-I-01D2
+ * DHCOM PCB number: 660-200 or newer
+ * PicoITX PCB number: 487-600 or newer
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include "imx8mp-dhcom-som.dtsi"
+
+/ {
+	model = "DH electronics i.MX8M Plus DHCOM PicoITX";
+	compatible = "dh,imx8mp-dhcom-picoitx", "dh,imx8mp-dhcom-som",
+		     "fsl,imx8mp";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	led {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_YELLOW>;
+			default-state = "off";
+			function = LED_FUNCTION_INDICATOR;
+			gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>; /* GPIO I */
+			pinctrl-0 = <&pinctrl_dhcom_i>;
+			pinctrl-names = "default";
+		};
+	};
+};
+
+&eqos {	/* First ethernet */
+	pinctrl-0 = <&pinctrl_eqos_rmii>;
+	phy-handle = <&ethphy0f>;
+	phy-mode = "rmii";
+
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_266M>,
+				 <&clk IMX8MP_SYS_PLL2_100M>,
+				 <&clk IMX8MP_SYS_PLL2_50M>;
+	assigned-clock-rates = <0>, <100000000>, <50000000>;
+};
+
+&ethphy0g {	/* Micrel KSZ9131RNXI */
+	status = "disabled";
+};
+
+&ethphy0f {	/* SMSC LAN8740Ai */
+	status = "okay";
+};
+
+&fec {
+	status = "disabled";
+};
+
+&flexcan1 {
+	status = "okay";
+};
+
+&gpio1 {
+	gpio-line-names =
+		"DHCOM-G", "", "", "",
+		"", "DHCOM-I", "PicoITX-HW0", "PicoITX-HW2",
+		"DHCOM-B", "DHCOM-A", "", "DHCOM-H", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio2 {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"", "", "", "PicoITX-HW1", "", "", "", "",
+		"", "", "", "", "DHCOM-INT", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "SOM-HW1", "", "", "", "",
+		"", "", "", "PicoITX-Out2", "", "", "", "";
+};
+
+&gpio5 {
+	gpio-line-names =
+		"", "", "PicoITX-In2", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "",
+		"", "", "PicoITX-In1", "PicoITX-Out1",
+		"", "", "", "", "", "", "", "";
+};
+
+/* No HS connector on this SoM variant, so no HDMI, PCIe and only USB HS. */
+&pcie_phy {
+	status = "disabled";
+};
+
+&pcie {
+	status = "disabled";
+};
+
+/* No WiFi/BT chipset on this SoM variant. */
+&uart2 {
+	bluetooth {
+		status = "disabled";
+	};
+};
+
+/* USB_OTG port is not routed out on PicoITX. */
+&usb3_0 {
+	status = "disabled";
+};
+
+&usb_dwc3_0 {
+	status = "disabled";
+};
+
+&usb3_1 {
+	fsl,over-current-active-low;
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+	maximum-speed = "high-speed";
+};
+
+/* No WiFi/BT chipset on this SoM variant. */
+&usdhc1 {
+	status = "disabled";
+};
+
+&iomuxc {
+	/*
+	 * The following DHCOM GPIOs are used on this board.
+	 * Therefore, they have been removed from the list below.
+	 * I: yellow led
+	 */
+	pinctrl-0 = <&pinctrl_dhcom_a &pinctrl_dhcom_b &pinctrl_dhcom_c
+		     &pinctrl_dhcom_d &pinctrl_dhcom_e &pinctrl_dhcom_f
+		     &pinctrl_dhcom_g &pinctrl_dhcom_h &pinctrl_dhcom_j
+		     &pinctrl_dhcom_k &pinctrl_dhcom_l &pinctrl_dhcom_m
+		     &pinctrl_dhcom_n &pinctrl_dhcom_o &pinctrl_dhcom_p
+		     &pinctrl_dhcom_q &pinctrl_dhcom_r &pinctrl_dhcom_s
+		     &pinctrl_dhcom_int>;
+};
diff --git a/configs/imx8mp_dhcom_picoitx_defconfig b/configs/imx8mp_dhcom_picoitx_defconfig
new file mode 100644
index 00000000000..4d8ce2dba4b
--- /dev/null
+++ b/configs/imx8mp_dhcom_picoitx_defconfig
@@ -0,0 +1,273 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX8M=y
+CONFIG_TEXT_BASE=0x40200000
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_SYS_MALLOC_F_LEN=0x18000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_SF_DEFAULT_SPEED=50000000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0xFE0000
+CONFIG_ENV_SECT_SIZE=0x1000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="imx8mp-dhcom-picoitx"
+CONFIG_SPL_TEXT_BASE=0x920000
+CONFIG_TARGET_IMX8MP_DH_DHCOM_PDK2=y
+CONFIG_DM_RESET=y
+CONFIG_SYS_MONITOR_LEN=1048576
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_BOOTCOUNT_BOOTLIMIT=3
+CONFIG_SYS_BOOTCOUNT_ADDR=0x30370090
+CONFIG_SPL_STACK=0x96fc00
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x96fc00
+CONFIG_SPL_BSS_MAX_SIZE=0x400
+CONFIG_SPL=y
+CONFIG_SYS_BOOTCOUNT_SINGLEWORD=y
+CONFIG_DEBUG_UART_BASE=0x30860000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_ENV_OFFSET_REDUND=0xFF0000
+CONFIG_IMX_BOOTAUX=y
+CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
+CONFIG_SYS_LOAD_ADDR=0x50000000
+CONFIG_DEBUG_UART=y
+CONFIG_ENV_VARS_UBOOT_CONFIG=y
+CONFIG_FIT=y
+CONFIG_FIT_EXTERNAL_OFFSET=0x3000
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x44000000
+CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY=y
+CONFIG_SYS_BOOTM_LEN=0x8000000
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_USE_BOOTARGS=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="run dh_update_env distro_bootcmd ; reset"
+CONFIG_USE_PREBOOT=y
+CONFIG_DEFAULT_FDT_FILE="imx8mp-dhcom-picoitx.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2081
+CONFIG_CONSOLE_MUX=y
+CONFIG_SYS_CONSOLE_ENV_OVERWRITE=y
+CONFIG_ARCH_MISC_INIT=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x26000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_BOOTROM_SUPPORT=y
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x4c000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
+# CONFIG_SPL_FIT_IMAGE_TINY is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="u-boot=> "
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+CONFIG_CMD_ASKENV=y
+# CONFIG_CMD_EXPORTENV is not set
+CONFIG_CMD_ERASEENV=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
+CONFIG_SYS_EEPROM_SIZE=16384
+CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=6
+CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=20
+CONFIG_CMD_MD5SUM=y
+CONFIG_MD5SUM_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_SHA1SUM=y
+CONFIG_SHA1SUM_VERIFY=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_GPT_RENAME=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_LSBLK=y
+CONFIG_CMD_MBR=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_BKOPS_ENABLE=y
+CONFIG_MMC_SPEED_MODE_SET=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_READ=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_SDP=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_CAT=y
+CONFIG_CMD_XXD=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_DHCP6=y
+CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_WGET=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_PXE=y
+CONFIG_CMD_BOOTCOUNT=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_KASLRSEED=y
+CONFIG_CMD_SYSBOOT=y
+CONFIG_CMD_UUID=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_SMC=y
+CONFIG_HASH_VERIFY=y
+CONFIG_CMD_BTRFS=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_FS_UUID=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
+CONFIG_MTDIDS_DEFAULT="nor0=flash@0"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=flash@0:-(sf)"
+CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_SECT_SIZE_AUTO=y
+CONFIG_ENV_SPI_MAX_HZ=80000000
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_NETCONSOLE=y
+CONFIG_IP_DEFRAG=y
+CONFIG_TFTP_TSIZE=y
+CONFIG_PROT_TCP_SACK=y
+CONFIG_IPV6=y
+CONFIG_SPL_DM=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_SYS_BOOTCOUNT_MAGIC=0xB0C40000
+CONFIG_SPL_CLK_COMPOSITE_CCF=y
+CONFIG_CLK_COMPOSITE_CCF=y
+CONFIG_SPL_CLK_IMX8MP=y
+CONFIG_CLK_IMX8MP=y
+CONFIG_FSL_CAAM=y
+CONFIG_IMX8M_DRAM_INLINE_ECC=y
+CONFIG_DFU_TFTP=y
+CONFIG_DFU_TIMEOUT=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_MTD=y
+CONFIG_DFU_RAM=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x42800000
+CONFIG_FASTBOOT_BUF_SIZE=0x20000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_GPIO_HOG=y
+CONFIG_SPL_GPIO_HOG=y
+CONFIG_MXC_GPIO=y
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
+# CONFIG_INPUT is not set
+CONFIG_LED=y
+CONFIG_LED_BLINK=y
+CONFIG_LED_GPIO=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x50
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+# CONFIG_SPI_FLASH_UNLOCK_ALL is not set
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_ANEG_TIMEOUT=20000
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_PHY_SMSC=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_IMX=y
+CONFIG_FEC_MXC=y
+CONFIG_RGMII=y
+CONFIG_MII=y
+CONFIG_PHY_IMX8MQ_USB=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX8M=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
+CONFIG_SPL_DM_PMIC_PCA9450=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PCA9450=y
+CONFIG_SPL_DM_REGULATOR_PCA9450=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RNG=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_M41T62=y
+CONFIG_CONS_INDEX=2
+CONFIG_DM_SERIAL=y
+# CONFIG_SPL_DM_SERIAL is not set
+CONFIG_MXC_UART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_MXC_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_DM_THERMAL=y
+CONFIG_IMX_TMU=y
+CONFIG_USB=y
+# CONFIG_SPL_DM_USB is not set
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="DH electronics"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_USB_FUNCTION_ACM=y
+CONFIG_USB_ETHER=y
+CONFIG_USB_ETH_CDC=y
+CONFIG_IMX_WATCHDOG=y
-- 
2.45.2

