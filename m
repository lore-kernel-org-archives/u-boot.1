Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20001CCF9F5
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 22:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A888A83A71;
	Wed, 26 Nov 2025 23:17:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="WM+1RJRw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 982B483A8C; Wed, 26 Nov 2025 23:17:36 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEAD483A64
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 23:17:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1764195385;
 bh=/oOm9g3y6UJyuEhHw5QHLV9Wo39h1vgZKCo+o4Bc1qw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WM+1RJRwRFBBQfq+DfUQ5ml3HCVx4ox67krhFDEIn+/NX2hjlBzxfneUtfeylJ+d2
 K19YodlX3OYzm1aHtlQiGo2NQFyYqX9LnPCGojHwM6B2GUq56N+zSQNdLmqLDTWx/d
 taioLlXsJYp1Nwi/hyrI4tbWNAtwoZ3/RFAbWsFZza3xLIwhKCV2L+OMEGQNZ8tUZA
 PcYx5j5obmi+2LIW/AweM+XCLj1arTcy91/c90XaXcyBX+sgKcjfhisPyt6qNr41dn
 69PcLzuCq/6SlY3nqEylJN4xzXXGw67wJcIYhrg/ZTnRmwljpHaslYWNKku1bKwWCO
 60sS691FOri4w==
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 04E9BB221311;
 Wed, 26 Nov 2025 23:16:23 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Icenowy Zheng <uwu@icenowy.me>
Subject: [RFC PATCH v1 1/4] riscv: dts: starfive: Add Orange Pi RV from
 upstream Linux for-next
Date: Wed, 26 Nov 2025 14:15:26 -0800
Message-ID: <20251126221552.87574-2-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251126221552.87574-1-e@freeshell.de>
References: <20251126221552.87574-1-e@freeshell.de>
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

Import dts for Orange Pi RV as per-board automatic inclusion. This
commit should be reverted when devicetree-rebasing release candidate for
Linux 6.19 is sync'ed.

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/dts/jh7110-orangepi-rv-u-boot.dtsi | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 arch/riscv/dts/jh7110-orangepi-rv-u-boot.dtsi

diff --git a/arch/riscv/dts/jh7110-orangepi-rv-u-boot.dtsi b/arch/riscv/dts/jh7110-orangepi-rv-u-boot.dtsi
new file mode 100644
index 00000000000..053c35992ec
--- /dev/null
+++ b/arch/riscv/dts/jh7110-orangepi-rv-u-boot.dtsi
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

