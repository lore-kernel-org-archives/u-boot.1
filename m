Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7C6CCD193
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 10:24:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8C008367F;
	Wed, 15 Oct 2025 12:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9232983678; Wed, 15 Oct 2025 12:24:00 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D5FF835FE
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 12:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 4F6CCB22030F;
 Wed, 15 Oct 2025 12:23:57 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 06/10] riscv: dts: starfive: add common board dtsi for
 Milk-V Mars CM variants
Date: Wed, 15 Oct 2025 03:22:49 -0700
Message-ID: <20251015102253.48276-7-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251015102253.48276-1-e@freeshell.de>
References: <20251015102253.48276-1-e@freeshell.de>
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

Add a common board dtsi for use by Milk-V Mars CM and Milk-V Mars CM Lite.

Signed-off-by: E Shattow <e@freeshell.de>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

[ upstream commit: 651b30c58775e334c79aa3ecd44a3d98ac201db2 ]

(cherry picked from commit 034af14dcd1e6dbfa4f41a340b6d92b054604858)
---
 .../riscv/starfive/jh7110-milkv-marscm.dtsi   | 159 ++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-milkv-marscm.dtsi

diff --git a/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm.dtsi b/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm.dtsi
new file mode 100644
index 00000000000..25b70af564e
--- /dev/null
+++ b/dts/upstream/src/riscv/starfive/jh7110-milkv-marscm.dtsi
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 E Shattow <e@freeshell.de>
+ */
+
+/dts-v1/;
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "jh7110-common.dtsi"
+
+/ {
+	aliases {
+		i2c1 = &i2c1;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		serial3 = &uart3;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&sysgpio 33 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&gmac0 {
+	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
+	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
+	starfive,tx-use-rgmii-clk;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "disabled";
+};
+
+&i2c6 {
+	status = "disabled";
+};
+
+&mmc1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	status = "okay";
+
+	ap6256: wifi@1 {
+		compatible = "brcm,bcm43456-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&sysgpio>;
+		interrupts = <34 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wake";
+		pinctrl-0 = <&wifi_host_wake_irq>;
+		pinctrl-names = "default";
+	};
+};
+
+&pcie0 {
+	status = "okay";
+};
+
+&phy0 {
+	rx-internal-delay-ps = <1500>;
+	tx-internal-delay-ps = <1500>;
+	motorcomm,rx-clk-drv-microamp = <3970>;
+	motorcomm,rx-data-drv-microamp = <2910>;
+	motorcomm,tx-clk-10-inverted;
+	motorcomm,tx-clk-100-inverted;
+	motorcomm,tx-clk-1000-inverted;
+	motorcomm,tx-clk-adj-enabled;
+};
+
+&pwm {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&sysgpio {
+	uart1_pins: uart1-0 {
+		tx-pins {
+			pinmux = <GPIOMUX(16, GPOUT_SYS_UART1_TX,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+		};
+
+		rx-pins {
+			pinmux = <GPIOMUX(17, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_UART1_RX)>;
+			bias-pull-up;
+			input-enable;
+			input-schmitt-enable;
+		};
+
+		cts-pins {
+			pinmux = <GPIOMUX(3, GPOUT_LOW,
+					     GPOEN_DISABLE,
+					     GPI_SYS_UART1_CTS)>;
+			bias-disable;
+			input-enable;
+			input-schmitt-enable;
+		};
+
+		rts-pins {
+			pinmux = <GPIOMUX(2, GPOUT_SYS_UART1_RTS,
+					     GPOEN_ENABLE,
+					     GPI_NONE)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+		};
+	};
+
+	usb0_pins: usb0-0 {
+		vbus-pins {
+			pinmux = <GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	wifi_host_wake_irq: wifi-host-wake-irq-0 {
+		wake-pins {
+			pinmux = <GPIOMUX(34, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			input-enable;
+		};
+	};
+};
+
+&uart1 {
+	uart-has-rtscts;
+	pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usb0 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins>;
+	status = "okay";
+};
-- 
2.50.0

