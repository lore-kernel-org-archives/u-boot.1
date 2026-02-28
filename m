Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843C5FEE4F8
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 21:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE8383EC6;
	Sat, 28 Feb 2026 22:16:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ausil.us
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="aAoH3PoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A90AF83EC6; Sat, 28 Feb 2026 22:16:01 +0100 (CET)
Received: from mail-pg1-x564.google.com (mail-pg1-x564.google.com
 [IPv6:2607:f8b0:4864:20::564])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7279883CDF
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 22:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ausil.us
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dennis@ausil.us
Received: by mail-pg1-x564.google.com with SMTP id
 41be03b00d2f7-c70bfef17a4so1958912a12.2
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 13:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1772313357; x=1772918157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B32bQqNBKsfGgWK7LKTJ5e4K3vo+/4p7qy4Fwj0f01Q=;
 b=aAoH3PoXjkNcrlTR1GX0dOcBDV0Isp9Spf1R44hV9m9E+QcX9yj1jxXLJvNqONI/sv
 /caTb1EMNnc6FwmGM3zgop46hQDyqBEN3Cxiy3nEi3GySbMx9LlFuY1IDSuD96e/mQkL
 zsxfHNoaRYqWw/chO01Nd+PZXokI6y27wTnK06QUmQ01fOMub6Ebq55A6IYq/qVzbE42
 0pSQAVssjyatbB1rh0sOwkO8S7MQ3MfYm/hWQ5wRh5kLMu8EyuzxQKrP4rQGzcJdNWtT
 Z018kKKiukSG5Lm3pzMnB0hO2GN3gySG8cxlsgw9Xr0SsY+Tu9NlRk/aE5pfTRiNr+0G
 VvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772313357; x=1772918157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B32bQqNBKsfGgWK7LKTJ5e4K3vo+/4p7qy4Fwj0f01Q=;
 b=VXgacvsB8OGiJWq/NkBln6n6X3XrqbuBoddAAtsyHyqF3rjc443mhAOAA2ioN7vmO4
 BOE1xeODEgyeU4v4Lk0QF5/C7HMXBHo8GF6Z314MQhNM6OxIDojdWH+Lxv0VQFL4NIoo
 0Hn3SPzLPNo2/w3yDJPZyQ/VQXiOvqt+ioYqRSV4Nrine8Qy3cWPqi+piPsoW/qgo9qy
 Xqj2IF7sz/ncgeL6rMFpMaC3Fy97KjmmPJfSBzzNs8z1tDrDartA/n9uGs19w0Q+aDPr
 V1NEYh/H1TtBCrIPaRq0OpfFwiahvAGVPSDbx5Ubs4S2tMF3rF3AewL8djNmCEvg+ZKL
 00UQ==
X-Gm-Message-State: AOJu0YzLOZvBxDZo/j6qa9OKbCZLlhz1Hr73sAFti+c7B9tgmgqov2A2
 ZppSCswo/wwpjLThQLU50JKZXMGCLUq8ua9ZujR+b4ISZRYg2nMEDqOk/ovQUXmBh71OPZch42m
 BBaSHbNcK/Yi7W2saZzNWnIE2+AhczNen6wjr
X-Gm-Gg: ATEYQzzsBFtvj8vir8yME4SisST/Xn0KOjHAVVeX3EKfcj/xiNszdYquLPqYJfhZdC0
 gIKgoEhd1nLKq/mECtW9Jrf3p4iso2kmSVyl6AHKnytcf4G1cax/yA/tCi1HQL/j4l+cSMUzCVk
 JjOUP7Vy/5mzi18LLmIMzmzJYxsvl6wYKFek9xKMXE5v+paQ7NPMDgCFkJZrOETY1vk4XIk+4HD
 rZxxlkZ37WCio3beQLEYC7WskY4gymc0PiUqKxSF0BxQw+c3dQ5YBhciLNOFpnGfphFh+clclZP
 BTcbqlYstbu2bc4b90HsFcstVtDZqxIF/fcdwM7KKgU9WMSaS3V06gt5B0R0nyy1I0ynqkrUdQ0
 9ez60Zk6oeiWTK3J3N+EWggb9N0H8JB6bW8WTlkshBO+f
X-Received: by 2002:a05:6a21:498d:b0:393:f002:ff59 with SMTP id
 adf61e73a8af0-395c3a488e9mr6199369637.19.1772313356853; 
 Sat, 28 Feb 2026 13:15:56 -0800 (PST)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-c70fa5c17c3sm737635a12.2.2026.02.28.13.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 13:15:56 -0800 (PST)
X-Relaying-Domain: ausil.us
From: dennis@ausil.us
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de,
	Dennis Gilmore <dennis@ausil.us>
Subject: [PATCH] board: rockchip: Add Xunlong Orange Pi 5 Pro board support
Date: Sat, 28 Feb 2026 15:15:50 -0600
Message-ID: <20260228211552.2948556-1-dennis@ausil.us>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Dennis Gilmore <dennis@ausil.us>

The Xunlong Orange Pi 5 Pro is a single-board computer based on the
rockchip RK3588S SoC. The board provides many interfaces including two
HDMI output ports, PCI attached GbE network port, M.2 M-Key Slot, One
USB 3.0, four USB 2.0

Features tested on a Orange Pi 5 Plus 4GB v1.2:
    - SD-card boot
    - eMMC boot
    - PCIe/NVMe

Device tree has been submitted to the linux kernel
https://lore.kernel.org/linux-devicetree/20260228205418.2944620-1-dennis@ausil.us/T/#t

Signed-off-by: Dennis Gilmore <dennis@ausil.us>
---
 .../dts/rk3588s-orangepi-5-pro-u-boot.dtsi    |  13 +
 configs/orangepi-5-pro-rk3588s_defconfig      |  91 +++++
 .../arm64/rockchip/rk3588s-orangepi-5-pro.dts | 376 ++++++++++++++++++
 3 files changed, 480 insertions(+)
 create mode 100644 arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
 create mode 100644 configs/orangepi-5-pro-rk3588s_defconfig
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-pro.dts

diff --git a/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi b/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
new file mode 100644
index 00000000000..f0d8c4e09e1
--- /dev/null
+++ b/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588s-u-boot.dtsi"
+
+&fspim0_pins {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+};
diff --git a/configs/orangepi-5-pro-rk3588s_defconfig b/configs/orangepi-5-pro-rk3588s_defconfig
new file mode 100644
index 00000000000..4c022e0bdbc
--- /dev/null
+++ b/configs/orangepi-5-pro-rk3588s_defconfig
@@ -0,0 +1,91 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SF_DEFAULT_SPEED=24000000
+CONFIG_SF_DEFAULT_MODE=0x2000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-orangepi-5-pro"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_EVB_RK3588=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_SF_DEFAULT_BUS=5
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="pci enum; usb start; nvme scan;"
+CONFIG_AHCI=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-orangepi-5-pro.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
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
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
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
+CONFIG_VIDEO=y
+CONFIG_DISPLAY=y
+CONFIG_VIDEO_ROCKCHIP=y
+CONFIG_DISPLAY_ROCKCHIP_HDMI=y
+CONFIG_ERRNO_STR=y
diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-pro.dts b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-pro.dts
new file mode 100644
index 00000000000..788151bf167
--- /dev/null
+++ b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-pro.dts
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3588s-orangepi-5.dtsi"
+
+/ {
+	model = "Xunlong Orange Pi 5 Pro";
+	compatible = "xunlong,orangepi-5-pro", "rockchip,rk3588s";
+
+	aliases {
+		/delete-property/ ethernet0;
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
+		mmc2 = &sdio;
+	};
+
+	/* Pro uses gpio-leds instead; pwm0 LED is not wired up */
+	/delete-node/ pwm-leds;
+
+	/*
+	 * Pro uses i2s2 (i2s2m1 mux) for audio, not i2s1. Recreate the sound
+	 * card node pointing at i2s2_2ch instead.
+	 */
+	/delete-node/ analog-sound;
+
+	analog-sound {
+		compatible = "simple-audio-card";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_detect>;
+		simple-audio-card,bitclock-master = <&masterdai>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&masterdai>;
+		simple-audio-card,hp-det-gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,name = "rockchip,es8388";
+		simple-audio-card,routing =
+			"Headphones", "LOUT1",
+			"Headphones", "ROUT1",
+			"LINPUT1", "Microphone Jack",
+			"RINPUT1", "Microphone Jack",
+			"LINPUT2", "Onboard Microphone",
+			"RINPUT2", "Onboard Microphone";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Microphone", "Onboard Microphone",
+			"Headphone", "Headphones";
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s2_2ch>;
+		};
+
+		masterdai: simple-audio-card,codec {
+			sound-dai = <&es8388>;
+			system-clock-frequency = <12288000>;
+		};
+	};
+
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		#cooling-cells = <2>;
+		cooling-levels = <0 50 100 150 200 255>;
+		fan-supply = <&vcc5v0_sys>;
+		pwms = <&pwm2 0 20000000 0>;
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_rgb>;
+
+		blue-led {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio1 RK_PC6 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		green-led {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_ACTIVITY;
+			gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc0";
+		};
+	};
+
+	vcc5v0_otg: regulator-vcc5v0-otg {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_otg_en>;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vcc5v0_otg";
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&hym8563>;
+		clock-names = "ext_clock";
+		post-power-on-delay-ms = <200>;
+		reset-gpios = <&gpio0 RK_PD0 GPIO_ACTIVE_LOW>;
+	};
+
+	vcc3v3_pcie20: regulator-vcc3v3-pcie20 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_HIGH>;
+		regulator-boot-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "vcc3v3_pcie20";
+		startup-delay-us = <50000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc3v3_pcie_eth: regulator-vcc3v3-pcie-eth {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "vcc3v3_pcie_eth";
+		vin-supply = <&vcc5v0_sys>;
+	};
+};
+
+/* disable gmac1 as the pro has a PCIe attached NIC */
+&gmac1 {
+	status = "disabled";
+};
+
+/* 40-pin header pins 3/5 */
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1m4_xfer>;
+	status = "okay";
+};
+
+/*
+ * Pro routes audio codec via i2c3 (not i2c6) and i2s2m1 (not i2s1m0).
+ * Delete the inherited es8388 node from i2c6 and redeclare it here.
+ */
+/delete-node/ &es8388;
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3m0_xfer>;
+	status = "okay";
+
+	es8388: audio-codec@11 {
+		compatible = "everest,es8388", "everest,es8328";
+		reg = <0x11>;
+		#sound-dai-cells = <0>;
+		AVDD-supply = <&vcc_3v3_s0>;
+		DVDD-supply = <&vcc_1v8_s0>;
+		HPVDD-supply = <&vcc_3v3_s0>;
+		PVDD-supply = <&vcc_3v3_s0>;
+		assigned-clock-rates = <12288000>;
+		assigned-clocks = <&cru I2S2_2CH_MCLKOUT>;
+		clocks = <&cru I2S2_2CH_MCLKOUT>;
+	};
+};
+
+/* 40-pin header pins 27/28 */
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4m3_xfer>;
+	status = "okay";
+};
+
+/*
+ * i2s1_8ch uses i2s1m0 which occupies GPIO4_PA0 (CLKREQ#) and GPIO4_PA1
+ * (WAKE#) needed for the NVMe M.2 slot. Disable it; audio is on i2s2_2ch.
+ */
+&i2s1_8ch {
+	status = "disabled";
+};
+
+/* Audio codec on i2s2, m1 mux; add mclk pin to the base pinctrl */
+&i2s2_2ch {
+	pinctrl-0 = <&i2s2m1_lrck &i2s2m1_mclk &i2s2m1_sclk
+		     &i2s2m1_sdi &i2s2m1_sdo>;
+	status = "okay";
+};
+
+&package_thermal {
+	polling-delay = <1000>;
+
+	cooling-maps {
+		map0 {
+			trip = <&package_fan0>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+
+		map1 {
+			trip = <&package_fan1>;
+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
+		};
+	};
+
+	trips {
+		package_fan0: package-fan0 {
+			hysteresis = <2000>;
+			temperature = <55000>;
+			type = "active";
+		};
+
+		package_fan1: package-fan1 {
+			hysteresis = <2000>;
+			temperature = <65000>;
+			type = "active";
+		};
+	};
+};
+
+/* NVMe */
+&pcie2x1l1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie30x1m1_1_clkreqn &pcie30x1m1_1_waken>;
+	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	supports-clkreq;
+	vpcie3v3-supply = <&vcc3v3_pcie_eth>;
+	status = "okay";
+};
+
+/* NIC */
+&pcie2x1l2 {
+	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie20>;
+	status = "okay";
+};
+
+&pinctrl {
+	bluetooth {
+		bt_wake_gpio: bt-wake-pin {
+			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_wake_host_irq: bt-wake-host-irq {
+			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	gpio-leds {
+		leds_rgb: leds-rgb {
+			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>,
+					<1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb {
+		vcc5v0_otg_en: vcc5v0-otg-en {
+			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	wlan {
+		wifi_host_wake_irq: wifi-host-wake-irq {
+			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+};
+
+/* pwm0 pin conflicts with i2c4 pin 27 Pro */
+&pwm0 {
+	status = "disabled";
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm2m1_pins>;
+	status = "okay";
+};
+
+&sdhci {
+	status = "okay";
+};
+
+&sdio {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	disable-wp;
+	keep-power-in-suspend;
+	max-frequency = <150000000>;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	no-mmc;
+	no-sd;
+	non-removable;
+	sd-uhs-sdr104;
+	status = "okay";
+
+	ap6256: wifi@1 {
+		compatible = "brcm,bcm43456-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-names = "host-wake";
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA0 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_host_wake_irq>;
+	};
+};
+
+&uart9 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart9m2_xfer &uart9m2_ctsn &uart9m2_rtsn>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4345c5";
+		clocks = <&hym8563>;
+		clock-names = "lpo";
+		device-wakeup-gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
+		interrupt-names = "host-wakeup";
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PC5 IRQ_TYPE_LEVEL_HIGH>;
+		max-speed = <1500000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_wake_host_irq &bt_wake_gpio>;
+		shutdown-gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
+		vbat-supply = <&vcc_3v3_s3>;
+		vddio-supply = <&vcc_1v8_s3>;
+	};
+};
+
+/* USB2 OTG PHY for usb_host0_xhci; phy-supply enables VBUS to USB3 Type-A port */
+&u2phy0_otg {
+	phy-supply = <&vcc5v0_otg>;
+};
+
+/* Pro has no FUSB302; the USB-C port is power delivery only */
+/delete-node/ &usbc0;
+
+/*
+ * The Pro's USB-C port is power delivery only: no FUSB302, no data lines,
+ * no alt-mode switching. The parent DTSI enables usbdp_phy0 (status = "okay")
+ * and adds FUSB302 alt-mode/orientation properties; delete those here.
+ *
+ * dp-lane-mux = <0 1>: PHY lanes 0/1 are DP (physically routed to the
+ * LT8711UXD DP→HDMI2 bridge), lanes 2/3 are USB3 SuperSpeed (physically
+ * routed to the USB3 Type-A port P3). Without this property the driver
+ * defaults to USB-only mode and places USB3 on lanes 0/1, which do not
+ * reach the Type-A connector and makes the USB3 port non-functional.
+ */
+&usbdp_phy0 {
+	rockchip,dp-lane-mux = <0 1>;
+	/delete-property/ mode-switch;
+	/delete-property/ orientation-switch;
+	/delete-property/ sbu1-dc-gpios;
+	/delete-property/ sbu2-dc-gpios;
+	/delete-node/ port;
+};
+
+/* USB3 Type-A port; fixed host, no role switching (no FUSB302) */
+&usb_host0_xhci {
+	dr_mode = "host";
+	/delete-property/ usb-role-switch;
+	status = "okay";
+	/delete-node/ port;
+};
+
+/*
+ * combphy2_psu is shared between usb_host2_xhci (USB3) and pcie2x1l1 (PCIe).
+ * Disable USB3 so the PHY can be used for the NVMe M.2 slot.
+ */
+&usb_host2_xhci {
+	status = "disabled";
+};
-- 
2.53.0

