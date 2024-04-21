Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FB9C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 23:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17C6E88375;
	Mon, 22 Apr 2024 01:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713741557;
	bh=/orHB0b6JD2P2Id/oQtkXMIiitXNLIDePnz8w8X2EOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P1KzZKE3/HXyOwdV5L4cdEfJv5J5nKAr0yxQELidSGGqBJunPkKNt/zV5XjC/UGQG
	 FEwzB+TsEktEcGnHdjD3F55cRc7kafzHQLZmr9TH7KqbE85cDNhPDvCFaxLSQeThe1
	 aSGxp77akQa5prHGBAgKT1JMyGWMUbhnQ0jbTcphjo8Y05nk7t7IAIkdpTPP3vWJoq
	 PcVns9wm3A4chgvWyZKLy3elrDBfp7K+gPhDvs/81s94xwS1fvGQL8IuCxpLjJA8vM
	 dYCh2YaVLEmqLKJ9HsQkyNgtRDtcHEqFxDI2DhFl8IKvQgJAHOqRWdXf79s/6mj7Hq
	 7CojAK1fzUI6Q==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8A8AA88334;
 Mon, 22 Apr 2024 01:19:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713741551;
 bh=/orHB0b6JD2P2Id/oQtkXMIiitXNLIDePnz8w8X2EOg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=I+IKisk3k88PLflUnsZBDcTRYJnkkL/auoT5XSHtcgkpcixwxQRwVZOv/JG3l53Gf
 MNDRZFZtce/dpQ7dItDfRKFvt7jfyBQamgaX5bpiYWrdVsrcFXG25+F2xNEOeQfixh
 z96hwtMcDm2vJv9+pb/jrASpHjH634XAEVKb3asHuIDuvCdDF6sDI7fVi+eH7ybpUJ
 fdbnbcbN8/h/8k8x9tVyWXD1L/aex2EMGxAL6lk/7Ij7lG1Xkn1HI6ajbyC02P0mRo
 8STZkMAJGffHwJOU70tbrScRNGz1rQpUZqlBh+MHxps3SIdOSZV/olaMLcBuxXdr3m
 wKp2Btwn5SK7A==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 14/19] ARM: dts: stm32: Add alternate pinmux for MP13 SPI3 pins
Date: Mon, 22 Apr 2024 01:17:00 +0200
Message-ID: <20240421231849.194648-14-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240421231849.194648-1-marex@denx.de>
References: <20240421231849.194648-1-marex@denx.de>
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

Add another mux option for SPI3 pins, this is used on
DH electronics STM32MP13xx DHCOR DHSBC board.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13-pinctrl.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/dts/stm32mp13-pinctrl.dtsi b/arch/arm/dts/stm32mp13-pinctrl.dtsi
index 17acd2850d3..7abd227e69f 100644
--- a/arch/arm/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/dts/stm32mp13-pinctrl.dtsi
@@ -534,6 +534,29 @@
 		};
 	};
 
+	spi3_pins_a: spi3-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('H', 13, AF6)>, /* SPI3_SCK */
+				 <STM32_PINMUX('F', 1, AF5)>; /* SPI3_MOSI */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('D', 4, AF5)>; /* SPI3_MISO */
+			bias-disable;
+		};
+	};
+
+	spi3_sleep_pins_a: spi3-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('H', 13, ANALOG)>, /* SPI3_SCK */
+				 <STM32_PINMUX('D', 4, ANALOG)>, /* SPI3_MISO */
+				 <STM32_PINMUX('F', 1, ANALOG)>; /* SPI3_MOSI */
+		};
+	};
+
 	spi5_pins_a: spi5-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('H', 7, AF6)>, /* SPI5_SCK */
-- 
2.43.0

