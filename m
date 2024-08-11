Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE15BC3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 10:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A449882EF;
	Sun, 11 Aug 2024 12:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="oGANUBEA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFC6C8852D; Sun, 11 Aug 2024 12:03:11 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by phobos.denx.de (Postfix) with ESMTP id 1B21488216
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 12:03:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=andyshrk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0HSL9
 s2fYQcJ4jNz5ODm3h+4wD4Fo1mNw9ELtR1I2rk=; b=oGANUBEAfVH5wgNhAjz0Z
 g3o/9s2JgKU6dqFdekPZrieQ6O0CTyDakic5h+yeAiHRf0IRP8N20p5dfRaPIyal
 4Q7zhfSypVkgah/hk7wuTTxfqLgvmqzp7wsBxHiZZ87/NdlMkWi0tgJG1OmyBUgE
 WErxvt552S/E9RfigNa/sU=
Received: from ProDesk.. (unknown [58.22.7.114])
 by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wDXXxdQjLhm4hIOBQ--.43417S3;
 Sun, 11 Aug 2024 18:03:00 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: kever.yang@rock-chips.com
Cc: jonas@kwiboo.se,
	u-boot@lists.denx.de,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH 1/1] board: rockchip: Add support for rk3588 GenBook
Date: Sun, 11 Aug 2024 18:02:55 +0800
Message-Id: <20240811100255.1664095-2-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811100255.1664095-1-andyshrk@163.com>
References: <20240811100255.1664095-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXXxdQjLhm4hIOBQ--.43417S3
X-Coremail-Antispam: 1Uf129KBjvAXoW3Cw1DWr43WF13JrWrKr1kuFg_yoW8ArWfGo
 ZFkFWFkw4SkryrJrn5XFWakw4ag3yxKw4fKF15Cry7Gr1Sk3WDtFy7ta15ur13try8tFy8
 uF1a9rW5Zw18Jrykn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RaLvNDUUUU
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMxk4XmXAnG1XVAABsa
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

Add support for Cool Pi GenBook.

Specification:
- Rockchip RK3588
- LPDDR5X 8/32 GB
- eMMC 64 GB
- HDMI Type A out x 1
- USB 3.0 Host x 1
- USB-C 3.0 with DisplayPort AltMode
- PCIE M.2 E Key for RTL8852BE Wireless connection
- PCIE M.2 M Key for NVME connection
- eDP panel with 1920x1080

Test by a Armbian boot on USB disk.

Signed-off-by: Andy Yan <andyshrk@163.com>

---

 .../dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi |  70 ++++
 arch/arm/mach-rockchip/rk3588/Kconfig         |   7 +
 board/coolpi/genbook/Kconfig                  |  12 +
 board/coolpi/genbook/MAINTAINERS              |   7 +
 board/coolpi/genbook/README                   |  23 ++
 configs/coolpi-genbook-rk3588_defconfig       | 104 ++++++
 .../rockchip/rk3588-coolpi-cm5-genbook.dts    | 349 ++++++++++++++++++
 include/configs/genbook-rk3588.h              |  28 ++
 8 files changed, 600 insertions(+)
 create mode 100644 arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi
 create mode 100644 board/coolpi/genbook/Kconfig
 create mode 100644 board/coolpi/genbook/MAINTAINERS
 create mode 100644 board/coolpi/genbook/README
 create mode 100644 configs/coolpi-genbook-rk3588_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts
 create mode 100644 include/configs/genbook-rk3588.h

diff --git a/arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi b/arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi
new file mode 100644
index 00000000000..5835bd4352b
--- /dev/null
+++ b/arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588-u-boot.dtsi"
+
+&fspim2_pins {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+};
+
+&sfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspim2_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		bootph-pre-ram;
+		bootph-some-ram;
+		spi-max-frequency = <24000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+	};
+};
+
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
+&usbdp_phy0 {
+	status = "okay";
+};
+
+/* For Keypad */
+&usb_host0_ehci {
+	status = "disabled";
+};
+
+&usb_host0_ohci {
+	status = "disabled";
+};
+
+&usb_host0_xhci {
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+	status = "okay";
+};
+
+/* connected to a HUB for camera and BT */
+&usb_host1_ehci {
+	status = "disabled";
+};
+
+&usb_host1_ohci {
+	status = "disabled";
+};
+
+/* USB A out */
+&usb_host1_xhci {
+	snps,dis_u3_susphy_quirk;
+};
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index e751d64e1a1..dc53d559ed9 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -6,6 +6,12 @@ config TARGET_EVB_RK3588
 	help
 	  RK3588 EVB is a evaluation board for Rockchp RK3588.
 
+config TARGET_GENBOOK_RK3588
+	bool "Cool Pi GenBook"
+	select BOARD_LATE_INIT
+	help
+	  GeenBook is a notebook based on Rockchip RK3588.
+
 config TARGET_JAGUAR_RK3588
 	bool "Theobroma Systems SBC-RK3588-AMR (Jaguar)"
 	select BOARD_LATE_INIT
@@ -323,5 +329,6 @@ source "board/rockchip/evb_rk3588/Kconfig"
 source "board/rockchip/toybrick_rk3588/Kconfig"
 source "board/theobroma-systems/jaguar_rk3588/Kconfig"
 source "board/theobroma-systems/tiger_rk3588/Kconfig"
+source "board/coolpi/genbook/Kconfig"
 
 endif
diff --git a/board/coolpi/genbook/Kconfig b/board/coolpi/genbook/Kconfig
new file mode 100644
index 00000000000..48a340d79c5
--- /dev/null
+++ b/board/coolpi/genbook/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_GENBOOK_RK3588
+
+config SYS_BOARD
+	default "genbook"
+
+config SYS_VENDOR
+	default "coolpi"
+
+config SYS_CONFIG_NAME
+	default "genbook-rk3588"
+
+endif
diff --git a/board/coolpi/genbook/MAINTAINERS b/board/coolpi/genbook/MAINTAINERS
new file mode 100644
index 00000000000..45c2ddc5fa1
--- /dev/null
+++ b/board/coolpi/genbook/MAINTAINERS
@@ -0,0 +1,7 @@
+GENBOOK-RK3588
+M:	andyshrk <andyshrk@163.com>
+S:	Maintained
+F:	board/coolpi/genbook
+F:	include/configs/genbook-rk3588.h
+F:	configs/coolpi-genbook-rk3588_defconfig
+F:	arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi
diff --git a/board/coolpi/genbook/README b/board/coolpi/genbook/README
new file mode 100644
index 00000000000..ba165953154
--- /dev/null
+++ b/board/coolpi/genbook/README
@@ -0,0 +1,23 @@
+Compile the U-Boot
+==================
+
+  > cd u-boot
+  > export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.17.bin
+  > export BL31=../rkbin/bin/rk35/rk3588_bl31_v1.46.elf
+  > make coolpi-genbook-rk3588_defconfig
+  > make CROSS_COMPILE=aarch64-linux-gnu-
+
+  Get u-boot-rockchip.bin for eMMC and u-boot-rockchip-spi.bin for SPI Nor.
+
+
+Write u-boot to eMMC or SPI Nor if you have a bootable linux system on the computer:
+
+Flash the image to eMMC
+==========================
+  > dd if=u-boot-rockchip.bin of=/dev/mmcblk0 bs=512 seek=64
+
+Flash the image to SPI Nor
+==========================
+ > dd if=u-boot-rockchip-spi.bin of=/dev/mtdblock0
+
+Note: The boot priority of SPI Nor is higher than that of eMMC
diff --git a/configs/coolpi-genbook-rk3588_defconfig b/configs/coolpi-genbook-rk3588_defconfig
new file mode 100644
index 00000000000..ae6c6c296cc
--- /dev/null
+++ b/configs/coolpi-genbook-rk3588_defconfig
@@ -0,0 +1,104 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SF_DEFAULT_SPEED=24000000
+CONFIG_SF_DEFAULT_MODE=0x2000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-coolpi-cm5-genbook"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_GENBOOK_RK3588=y
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-coolpi-cm5-genbook.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
+CONFIG_SPL_ATF=y
+# CONFIG_CMD_BIND is not set
+# CONFIG_CMD_FASTBOOT is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_AHCI_PCI=y
+CONFIG_DWC_AHCI=y
+CONFIG_SPL_CLK=y
+CONFIG_FASTBOOT_BUF_ADDR=0x800800
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_SPL_MMC_HS400_SUPPORT=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SF_DEFAULT_BUS=5
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_XMC=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SFC=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_ERRNO_STR=y
diff --git a/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts b/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts
new file mode 100644
index 00000000000..6418286efe4
--- /dev/null
+++ b/dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5-genbook.dts
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include "rk3588-coolpi-cm5.dtsi"
+
+/ {
+	model = "CoolPi CM5 GenBook";
+	compatible = "coolpi,pi-cm5-genbook", "coolpi,pi-cm5", "rockchip,rk3588";
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		enable-gpios = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bl_en>;
+		power-supply = <&vcc12v_dcin>;
+		pwms = <&pwm6 0 25000 0>;
+	};
+
+	battery: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <9800000>;
+		voltage-max-design-microvolt = <4350000>;
+		voltage-min-design-microvolt = <3000000>;
+	};
+
+	charger: dc-charger {
+		compatible = "gpio-charger";
+		charger-type = "mains";
+		gpios = <&gpio1 RK_PC0 GPIO_ACTIVE_LOW>;
+	};
+
+	leds: leds {
+		compatible = "gpio-leds";
+
+		heartbeat_led: led-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio1 RK_PB0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		wlan_led: led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WLAN;
+			gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
+		};
+
+		charging_red: led-2 {
+			function = LED_FUNCTION_CHARGING;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio3 RK_PD2 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	vcc12v_dcin: vcc12v-dcin-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc12v_dcin";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	vcc_sys: vcc-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <7000000>;
+		regulator-max-microvolt = <7000000>;
+		vin-supply = <&vcc12v_dcin>;
+	};
+
+	vcc5v0_sys: vcc5v0-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <7000000>;
+		regulator-max-microvolt = <7000000>;
+		vin-supply = <&vcc_sys>;
+	};
+
+	vcc3v3_sys: vcc3v3-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc3v3_lcd: vcc3v3-lcd-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_lcd";
+		enable-active-high;
+		gpio = <&gpio1 RK_PC4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcdpwr_en>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	vcc5v0_usb: vcc5v0-usb-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb";
+		regulator-boot-on;
+		regulator-always-on;
+		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_pwren>;
+		vin-supply = <&vcc_sys>;
+	};
+
+	vcc5v0_usb_host0: vcc5v0_usb30_host: vcc5v0-usb-host-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_host";
+		regulator-boot-on;
+		regulator-always-on;
+		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 RK_PA7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_host_pwren>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4m3_xfer>;
+
+	cw2015@62 {
+		compatible = "cellwise,cw2015";
+		reg = <0x62>;
+
+		cellwise,battery-profile = /bits/ 8 <
+			0x17 0x67 0x69 0x63 0x63 0x62 0x62 0x5F
+			0x52 0x73 0x4C 0x5A 0x5B 0x4B 0x42 0x3A
+			0x33 0x2D 0x29 0x28 0x2E 0x31 0x3C 0x49
+			0x2C 0x2C 0x0C 0xCD 0x30 0x51 0x50 0x66
+			0x74 0x74 0x75 0x78 0x41 0x1B 0x84 0x5F
+			0x0B 0x34 0x1C 0x45 0x89 0x92 0xA0 0x13
+			0x2C 0x55 0xAB 0xCB 0x80 0x5E 0x7B 0xCB
+			0x2F 0x00 0x64 0xA5 0xB5 0x10 0x18 0x21
+			>;
+
+		cellwise,monitor-interval-ms = <3000>;
+		monitored-battery = <&battery>;
+		power-supplies = <&charger>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5m3_xfer>;
+
+	touchpad: touchpad@2c {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PD6 IRQ_TYPE_LEVEL_LOW>;
+		hid-descr-addr = <0x0020>;
+	};
+};
+
+&gmac0 {
+	status = "disabled";
+};
+
+/* M.2 E-Key */
+&pcie2x1l0 {
+	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_sys>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_clkreq &pcie_wake &pcie_rst &wifi_pwron &bt_pwron>;
+	status = "okay";
+};
+
+&pcie2x1l2 {
+	status = "disabled";
+};
+
+&pcie30phy {
+	status = "okay";
+};
+
+/* M.2 M-Key ssd */
+&pcie3x4 {
+	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_sys>;
+	status = "okay";
+};
+
+&pinctrl {
+	lcd {
+		lcdpwr_en: lcdpwr-en {
+			rockchip,pins = <1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		bl_en: bl-en {
+			rockchip,pins = <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb {
+		usb_pwren: usb-pwren {
+			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		usb_otg_pwren: usb-otg-pwren {
+			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		usb_host_pwren: usb-host-pwren {
+			rockchip,pins = <1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	wifi {
+		bt_pwron: bt-pwron {
+			rockchip,pins = <3 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		pcie_clkreq: pcie-clkreq {
+			rockchip,pins = <4 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		pcie_rst: pcie-rst {
+			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		wifi_pwron: wifi-pwron {
+			rockchip,pins = <3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		pcie_wake: pcie-wake {
+			rockchip,pins = <4 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&pwm6 {
+	pinctrl-0 = <&pwm6m1_pins>;
+	status = "okay";
+};
+
+&sdmmc {
+	status = "disabled";
+};
+
+&sfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspim2_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-max-frequency = <100000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+	};
+};
+
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
+&usbdp_phy0 {
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	status = "okay";
+};
+
+&u2phy2 {
+	status = "okay";
+};
+
+&u2phy3 {
+	status = "okay";
+};
+
+&u2phy2_host {
+	phy-supply = <&vcc5v0_usb_host0>;
+	status = "okay";
+};
+
+&u2phy3_host {
+	phy-supply = <&vcc5v0_usb>;
+	status = "okay";
+};
+
+&usbdp_phy1 {
+	status = "okay";
+};
+
+/* For Keypad */
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+/* Type C port */
+&usb_host0_xhci {
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+	status = "okay";
+};
+
+/* connected to a HUB for camera and BT */
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+/* USB A out */
+&usb_host1_xhci {
+	dr_mode = "host";
+	status = "okay";
+};
diff --git a/include/configs/genbook-rk3588.h b/include/configs/genbook-rk3588.h
new file mode 100644
index 00000000000..5c5957b8bf5
--- /dev/null
+++ b/include/configs/genbook-rk3588.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ */
+
+#ifndef __ROCK5B_RK3588_H
+#define __ROCK5B_RK3588_H
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#include <configs/rk3588_common.h>
+
+#undef CFG_EXTRA_ENV_SETTINGS
+
+/*
+ * As a laptop, there is no sdmmc, and we
+ * want to set usb the highest boot priority
+ * for third-part os installation.
+ */
+#define CFG_EXTRA_ENV_SETTINGS \
+	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
+	"partitions=" PARTS_DEFAULT		\
+	ENV_MEM_LAYOUT_SETTINGS			\
+	ROCKCHIP_DEVICE_SETTINGS \
+	"boot_targets=" "usb mmc0" "\0"
+
+#endif /* __GENBOOK_RK3588_H */
-- 
2.34.1

