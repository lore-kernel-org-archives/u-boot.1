Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD05E95A91
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 11:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5A1086C00;
	Mon,  9 Oct 2023 13:39:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ict42.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ict42.de header.i=@ict42.de header.b="kBKHrtAr";
	dkim=permerror (0-bit key) header.d=ict42.de header.i=@ict42.de header.b="gp30GJ1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 755A086C00; Mon,  9 Oct 2023 13:39:29 +0200 (CEST)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.220])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64F7E8642A
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 13:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ict42.de
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ludwig.kormann@ict42.de
ARC-Seal: i=1; a=rsa-sha256; t=1696851566; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=TWY6I9XgFRnOPexjXyht+p5zej6rlaGuY1DTdSjHC1wtj6dN259MJ3z6TwEGRYm7ML
 723QlITjCIEGnF59b2cpuan0nzB9i6L412alsKzdZ2H6nQw4AG2BHbYiFKqemxl2l0/w
 8SQK7UYykl4V8BoUl/B8QwYZZAaDM8MSBHi2AJKU35OGMW3Oz/hPLphXpSOUKNQAvCGT
 E53+7DkTuk7Ec5Im8tMQm8f6uggcXuntJABBeZ6m4Qq2g74nR+hq0JmuLCrZERqFXu8R
 ZsphNh3WOIb16+K4ua8K1WLk545MF0BvBYMDJouXWiCkw1joTUnujdXTfyeN+8dBIyh+
 fbWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696851566;
 s=strato-dkim-0002; d=strato.com;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=HQyFwgOTr1o2IXYZUbgbLomjWyVVxsjukipNJYZtjK4=;
 b=q6ZY0OStczTcJn/C1hTQ/CcOuDmAJWQNqrmOo+6ujBOkU2jnX0Hdt5OA1DhEhda6XM
 1mknkEQF4euu+YxiYaE4nYGFRsNvEcc7iUNqix0apI6MKIXih5OZeHeJAm4qFn8Ihn0/
 yg3HXqzFJuskU2SzQWTKQAcmbsygYU5h79VH7qfYfuBPo+FZsLJpu/vYKhYDD8B01c9t
 OMYRgBzax7uaJjOT49qDPoyt+gHGAg3p3ZD4YT8nB+aoPqVxEZWovoM8Jo6KjHOh0yfN
 zWGAejDKKnfjvFB0k/tb9xR1tCO5RQKY+k/+jMdeAx5H5kZvolWomsMDkBYFLocaGLvJ
 sk7A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696851566;
 s=strato-dkim-0002; d=ict42.de;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=HQyFwgOTr1o2IXYZUbgbLomjWyVVxsjukipNJYZtjK4=;
 b=kBKHrtAr7YqxrEzxiMa1SMUC2h0RELT5X1oacXqT7LD7AgfEqqx5TWtyAeuF+TQn25
 mQ/tzwSArvG+1FPxKxXKI3HPlvOfLDNx+DClV4hPePFaqhYOMVpdFZmCiZ9ar1Qj17YP
 aX31iIgrt0eoenMNOEQxpcKGLCIyHVPvWoO4JnGps05vhlz4259JNb0hdop+vm45ojxP
 ydN/iKfrfogGVkoU/HjXjD0SWA81GCHTIM8DeK9xnyAN5c9ZIatNqnNDNCqiYYqhJRGV
 1OTxUCWofNJ1sHAjDXaC9VixVh0VQJ4fBRLkBNKB1tU3XhuMdMJVBskp2CqUi9iSaWgu
 05kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696851566;
 s=strato-dkim-0003; d=ict42.de;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=HQyFwgOTr1o2IXYZUbgbLomjWyVVxsjukipNJYZtjK4=;
 b=gp30GJ1mXQFJ5ItIoKAdFWuZLOKrie5C0gHjLH87epfpgt/mFsxOj/HGDJa7rneeMT
 pxASod+9PSczoZOn+nCg==
X-RZG-AUTH: ":IHkAYkmvNfSwjg/qSc4u8zZOVaURsoXe3UH2mQA0KglxDI1B7BeEcdPLARTmoNSwY8PK6ePqKQZ9qTSC"
Received: from debian-test.local.in-circuit.de
 by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
 with ESMTPSA id 20424fz99BdP1Fu
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 9 Oct 2023 13:39:25 +0200 (CEST)
From: Ludwig Kormann <ludwig.kormann@ict42.de>
To: hdegoede@redhat.com,
	jagan@amarulasolutions.com,
	andre.przywara@arm.com
Cc: u-boot@lists.denx.de
Subject: [PATCH RESEND v3 1/1] arm: dts: icnova-a20-adb4006: Add board support
Date: Mon,  9 Oct 2023 13:39:16 +0200
Message-Id: <20231009113916.2668425-1-ludwig.kormann@ict42.de>
X-Mailer: git-send-email 2.30.2
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

Add board support for ICnova A20 SomPi compute module on
ICnova ADB4006 development board.

Specification:
SoM
- Processor: Allwinner A20 Cortex-A7 Dual Core at 1GHz
- 512MB DDR3 RAM
- Fast Ethernet (Phy: Realtek RTL8201CP)
ADB4006
- I2C
- 2x USB 2.0
- 1x Fast Ethernet port
- 1x SATA
- 2x buttons (PWRON, Boot)
- 2x LEDS
- serial console
- HDMI
- µSD-Card slot
- Audio Line-In / Line-Out
- GPIO pinheaders

https://wiki.in-circuit.de/index.php5?title=ICnova_ADB4006
https://wiki.in-circuit.de/index.php5?title=ICnova_A20_SODIMM

devicetree upstreamed with linux 6.5

Signed-off-by: Ludwig Kormann <ludwig.kormann@ict42.de>
---
changes in v3:
- rebase on v2023.10

changes in v2:
- rebase on v2023.07-rc2
- remove pin defines from defconfig
- get dts reviewed on the linux mailing list and
  scheduled for kernel 6.5 [1]

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
commit de2bdfb7f79d5c655eb056d459e02be2c7f13c8b

---
 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts | 137 ++++++++++++++++++
 arch/arm/dts/sun7i-a20-icnova-a20.dtsi        |  62 ++++++++
 board/sunxi/MAINTAINERS                       |   5 +
 configs/icnova-a20-adb4006_defconfig          |  20 +++
 5 files changed, 225 insertions(+)
 create mode 100644 arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts
 create mode 100644 arch/arm/dts/sun7i-a20-icnova-a20.dtsi
 create mode 100644 configs/icnova-a20-adb4006_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 85fd5b1157..16d5930b78 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -667,6 +667,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-haoyu-marsboard.dtb \
 	sun7i-a20-hummingbird.dtb \
 	sun7i-a20-i12-tvbox.dtb \
+	sun7i-a20-icnova-a20-adb4006.dtb \
 	sun7i-a20-icnova-swac.dtb \
 	sun7i-a20-itead-ibox.dtb \
 	sun7i-a20-lamobo-r1.dtb \
diff --git a/arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts b/arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts
new file mode 100644
index 0000000000..577ead1d02
--- /dev/null
+++ b/arch/arm/dts/sun7i-a20-icnova-a20-adb4006.dts
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// Copyright (C) 2023 In-Circuit GmbH
+
+/dts-v1/;
+
+#include "sun7i-a20-icnova-a20.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "In-Circuit ICnova A20 ADB4006";
+	compatible = "incircuit,icnova-a20-adb4006", "incircuit,icnova-a20",
+		     "allwinner,sun7i-a20";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_YELLOW>;
+			gpios = <&pio 7 21 GPIO_ACTIVE_HIGH>; /* PH21 */
+			default-state = "on";
+		};
+
+		led-1 {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>; /* PH20 */
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&ahci {
+	target-supply = <&reg_ahci_5v>;
+	status = "okay";
+};
+
+&codec {
+	status = "okay";
+};
+
+&de {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&otg_sram {
+	status = "okay";
+};
+
+&reg_ahci_5v {
+	status = "okay";
+};
+
+&ac_power_supply {
+	status = "okay";
+};
+
+&reg_usb1_vbus {
+	status = "okay";
+};
+
+&reg_usb2_vbus {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+	usb0_vbus_det-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
diff --git a/arch/arm/dts/sun7i-a20-icnova-a20.dtsi b/arch/arm/dts/sun7i-a20-icnova-a20.dtsi
new file mode 100644
index 0000000000..46616c6bc8
--- /dev/null
+++ b/arch/arm/dts/sun7i-a20-icnova-a20.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// Copyright (C) 2023 In-Circuit GmbH
+
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_mii_pins>;
+	phy-handle = <&phy1>;
+	phy-mode = "mii";
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	axp209: pmic@34 {
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&gmac_mdio {
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+	};
+};
+
+#include "axp209.dtsi"
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index 98bbd2dd25..67cdd01371 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -236,6 +236,11 @@ M:	Stefan Roese <sr@denx.de>
 S:	Maintained
 F:	configs/icnova-a20-swac_defconfig
 
+ICnova-A20-ADB4006 BOARD
+M:	Ludwig Kormann <ludwig.kormann@ict42.de>
+S:	Maintained
+F:	configs/icnova-a20-adb4006_defconfig
+
 ITEAD IBOX BOARD
 M:	Marcus Cooper <codekipper@gmail.com>
 S:	Maintained
diff --git a/configs/icnova-a20-adb4006_defconfig b/configs/icnova-a20-adb4006_defconfig
new file mode 100644
index 0000000000..f70ffe45ab
--- /dev/null
+++ b/configs/icnova-a20-adb4006_defconfig
@@ -0,0 +1,20 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-icnova-a20-adb4006"
+CONFIG_SPL=y
+CONFIG_MACH_SUN7I=y
+CONFIG_DRAM_CLK=384
+CONFIG_AHCI=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SPL_I2C=y
+CONFIG_SCSI_AHCI=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SLAVE=0x7f
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_MII=y
+CONFIG_SUN7I_GMAC=y
+CONFIG_AXP_ALDO4_VOLT=2800
+CONFIG_SCSI=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
-- 
2.30.2

