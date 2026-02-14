Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3B3EF99FD
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 04:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF40D83E76;
	Sat, 14 Feb 2026 05:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="aJIDX9eT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6022783DFF; Sat, 14 Feb 2026 05:57:14 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A27F83DE4
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 05:57:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7B8811101C5; Sat, 14 Feb 2026 05:57:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771045031; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=eW87iC9Qn/uwH8CzcxTDrmdaF8WNpaCD5p9bxlprono=;
 b=aJIDX9eTuPoYcu68HIjE5P3ExVPh78aLt2/mF16FumKdxRxt8T8Ax2sbBh5jF3s92yd2tU
 TIF/CQItuqAh7WU5RD7UcFHvpHpM+kwgaToto4LVcvZKRfczmVwt/eDc9Rm2YroSgXWYLW
 HUHjhYKRssuiultoET+ydVaFcZajyarI682BKCMBPHThxeufD0u1zk6VK8PfyisX0PwGs2
 CInxfjVO/GIE5R7UhDPZcajJzsHl1ff002GNyvk/xVtK26w7ADVt6CXK7Ds27JRks6Ch3O
 Idtvid7M9wB57DwBpa4gvMoeeotzUFGipVaR9rjmlnjKV/I5sVl+fvwNAFMrzw==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>, Peng Fan <peng.fan@nxp.com>,
 Heiko Schocher <hs@nabladev.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v2 04/11] arm: dts: capricorn: move fec2 config
Date: Sat, 14 Feb 2026 05:56:56 +0100
Message-Id: <20260214045703.28051-5-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260214045703.28051-1-hs@nabladev.com>
References: <20260214045703.28051-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Lukas Stockmann <lukas.stockmann@siemens.com>

fec2 config does not belong to the Capricorn CPU module, move it to
the main board.

Signed-off-by: Lukas Stockmann <lukas.stockmann@siemens.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

Changes in v2:
Added Reviewed-by from Peng

 arch/arm/dts/imx8-capricorn-cxg3.dts | 44 ++++++++++++++++++++++++++++
 arch/arm/dts/imx8-capricorn.dtsi     | 44 ----------------------------
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/arm/dts/imx8-capricorn-cxg3.dts b/arch/arm/dts/imx8-capricorn-cxg3.dts
index 2f8597579f3..b40410b2b6f 100644
--- a/arch/arm/dts/imx8-capricorn-cxg3.dts
+++ b/arch/arm/dts/imx8-capricorn-cxg3.dts
@@ -102,6 +102,26 @@
 	pinctrl-0 = <&pinctrl_gpio_keys>;
 
 	muxcgrp: imx8qxp-som {
+		pinctrl_fec2: fec2grp {
+			fsl,pins = <
+				SC_P_COMP_CTL_GPIO_1V8_3V3_ENET_ENETB0_PAD	0x000014a0
+				SC_P_COMP_CTL_GPIO_1V8_3V3_ENET_ENETB1_PAD	0x000014a0
+				SC_P_COMP_CTL_GPIO_1V8_3V3_GPIORHB_PAD		0x000514a0
+
+				SC_P_ENET0_MDC_CONN_ENET1_MDC			0x00000060
+				SC_P_ENET0_MDIO_CONN_ENET1_MDIO			0x00000060
+
+				SC_P_ESAI0_FSR_CONN_ENET1_RCLK50M_IN		0x00000060
+				SC_P_SPDIF0_RX_CONN_ENET1_RGMII_RXD0		0x00000060
+				SC_P_ESAI0_TX3_RX2_CONN_ENET1_RGMII_RXD1	0x00000060
+				SC_P_ESAI0_TX2_RX3_CONN_ENET1_RMII_RX_ER	0x00000060
+				SC_P_SPDIF0_TX_CONN_ENET1_RGMII_RX_CTL		0x00000060
+				SC_P_ESAI0_TX4_RX1_CONN_ENET1_RGMII_TXD0	0x00000060
+				SC_P_ESAI0_TX5_RX0_CONN_ENET1_RGMII_TXD1	0x00000060
+				SC_P_ESAI0_SCKR_CONN_ENET1_RGMII_TX_CTL		0x00000060
+			>;
+		};
+
 		pinctrl_gpio_leds: gpioledsgrp {
 			fsl,pins = <
 			SC_P_ESAI0_FST_LSIO_GPIO0_IO01		0x06000021
@@ -127,3 +147,27 @@
 		>;
 	};
 };
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec2>;
+	phy-mode = "rmii";
+
+	phy-handle = <&ethphy1>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+		};
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+		};
+	};
+};
diff --git a/arch/arm/dts/imx8-capricorn.dtsi b/arch/arm/dts/imx8-capricorn.dtsi
index 41f4b2f646b..f640daa775f 100644
--- a/arch/arm/dts/imx8-capricorn.dtsi
+++ b/arch/arm/dts/imx8-capricorn.dtsi
@@ -65,26 +65,6 @@
 				SC_P_EMMC0_RESET_B_CONN_EMMC0_RESET_B	0x00000021
 			>;
 		};
-
-		pinctrl_fec2: fec2grp {
-			fsl,pins = <
-				SC_P_COMP_CTL_GPIO_1V8_3V3_ENET_ENETB0_PAD	0x000014a0
-				SC_P_COMP_CTL_GPIO_1V8_3V3_ENET_ENETB1_PAD	0x000014a0
-				SC_P_COMP_CTL_GPIO_1V8_3V3_GPIORHB_PAD		0x000514a0
-
-				SC_P_ENET0_MDC_CONN_ENET1_MDC                   0x00000060
-				SC_P_ENET0_MDIO_CONN_ENET1_MDIO                 0x00000060
-
-				SC_P_ESAI0_FSR_CONN_ENET1_RCLK50M_IN            0x00000060
-				SC_P_SPDIF0_RX_CONN_ENET1_RGMII_RXD0            0x00000060
-				SC_P_ESAI0_TX3_RX2_CONN_ENET1_RGMII_RXD1        0x00000060
-				SC_P_ESAI0_TX2_RX3_CONN_ENET1_RMII_RX_ER        0x00000060
-				SC_P_SPDIF0_TX_CONN_ENET1_RGMII_RX_CTL          0x00000060
-				SC_P_ESAI0_TX4_RX1_CONN_ENET1_RGMII_TXD0        0x00000060
-				SC_P_ESAI0_TX5_RX0_CONN_ENET1_RGMII_TXD1        0x00000060
-				SC_P_ESAI0_SCKR_CONN_ENET1_RGMII_TX_CTL         0x00000060	/* ERST: Reset pin */
-			>;
-		};
 	};
 };
 
@@ -146,27 +126,3 @@
 &fec1 {
 	status ="disabled";
 };
-
-&fec2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec2>;
-	phy-mode = "rmii";
-
-	phy-handle = <&ethphy1>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy0: ethernet-phy@0 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-		};
-		ethphy1: ethernet-phy@1 {
-			compatible = "ethernet-phy-ieee802.3-c22";
-			reg = <1>;
-		};
-	};
-};
-- 
2.20.1

