Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8097BD29C4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 15:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1831F83A8F;
	Tue, 20 Jan 2026 16:57:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="Xk3fveIr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF6FF83B03; Tue, 20 Jan 2026 16:56:59 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1C6183A6A
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1768924482;
 bh=OFXNA+IQLoUCHebyIiv+iajGPpjY/HXQepsa87Jzyx4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Xk3fveIr4L5ilF9ST8MEhE5lqAmgdw1PvBEfskk5NS0NbpRQ5+4eMIN8z7YMO2INa
 dIciqnTSk0Jg4Q7Xu4qYpa5FGft41sjs5UPMrk0W34QVpxIWAcgio/4tO92TPyarVx
 W+/lrjhZoAgu8Zy4cfJXDwH1qT7NXq4YPGSEx5nr750Gd3Bhq3tAehNWuqpiNMqPjM
 AJX+Lk5Bxn9I9tF8sBwYegs5jkykDwtORbcNxGqWH7pAzVYyjslwhWrHEpXDSqppOz
 7vjhdoLULwTTbudYAm043GrLQ+Zb3XqqNZfYH7PBzfuVFBJVJkDz2ZaduyA+rRQfFq
 lriq+qA7xWQqA==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id B7D74B220BE3;
 Tue, 20 Jan 2026 16:54:39 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Icenowy Zheng <uwu@icenowy.me>, Conor Dooley <conor.dooley@microchip.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v3 2/5] riscv: dts: starfive: add Orange Pi RV
Date: Tue, 20 Jan 2026 07:53:35 -0800
Message-ID: <20260120155406.34916-3-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260120155406.34916-1-e@freeshell.de>
References: <20260120155406.34916-1-e@freeshell.de>
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

From: Icenowy Zheng <uwu@icenowy.me>

Orange Pi RV is a SBC based on the StarFive VisionFive 2 board.

Orange Pi RV features:

- StarFive JH7110 SoC
- GbE port connected to JH7110 GMAC0 via YT8531 PHY
- 4x USB ports via VL805 PCIe USB controller connected to JH7110 pcie0
- M.2 M-key slot connected to JH7110 pcie1
- HDMI video output
- 3.5mm audio output
- Ampak AP6256 SDIO Wi-Fi/Bluetooth module on mmc0
- microSD slot on mmc1
- SPI NOR flash memory
- 24c02 EEPROM (read only by default)

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Signed-off-by: E Shattow <e@freeshell.de>
[conor: amend comment to say what's missing]
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

[ upstream commit: 5b70764e10190d57e6cd3287d3a3b06f8c89f69c ]

(cherry picked from commit ca39a8e36acbe7d258cadee4ae703fbaac60e18b)
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 .../src/riscv/starfive/jh7110-orangepi-rv.dts | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-orangepi-rv.dts

diff --git a/dts/upstream/src/riscv/starfive/jh7110-orangepi-rv.dts b/dts/upstream/src/riscv/starfive/jh7110-orangepi-rv.dts
new file mode 100644
index 00000000000..053c35992ec
--- /dev/null
+++ b/dts/upstream/src/riscv/starfive/jh7110-orangepi-rv.dts
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 Icenowy Zheng <uwu@icenowy.me>
+ */
+
+/dts-v1/;
+#include "jh7110-common.dtsi"
+
+/ {
+	model = "Xunlong Orange Pi RV";
+	compatible = "xunlong,orangepi-rv", "starfive,jh7110";
+
+	/* This regulator is always on by hardware */
+	reg_vcc3v3_pcie: regulator-vcc3v3-pcie {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3-pcie";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&sysgpio 62 GPIO_ACTIVE_LOW>;
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
+&mmc0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cap-sd-highspeed;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	vmmc-supply = <&reg_vcc3v3_pcie>;
+	vqmmc-supply = <&vcc_3v3>;
+	status = "okay";
+
+	ap6256: wifi@1 {
+		compatible = "brcm,bcm43456-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+		/* TODO: out-of-band IRQ on GPIO21, lacking pinctrl support */
+	};
+};
+
+&mmc1 {
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_HIGH>;
+};
+
+&pcie0 {
+	status = "okay";
+};
+
+&pcie1 {
+	status = "okay";
+};
+
+&phy0 {
+	rx-internal-delay-ps = <1500>;
+	tx-internal-delay-ps = <1500>;
+	motorcomm,rx-clk-drv-microamp = <3970>;
+	motorcomm,rx-data-drv-microamp = <2910>;
+	motorcomm,tx-clk-adj-enabled;
+	motorcomm,tx-clk-10-inverted;
+	motorcomm,tx-clk-100-inverted;
+	motorcomm,tx-clk-1000-inverted;
+};
+
+&pwmdac {
+	status = "okay";
+};
-- 
2.50.0

