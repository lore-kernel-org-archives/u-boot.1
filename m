Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF62CFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:05:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7CE184500;
	Sat, 25 Apr 2026 20:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="YhHATot6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27FC084105; Sat, 25 Apr 2026 19:20:10 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D55183FF5
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-38c620f1699so79444921fa.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777137602; x=1777742402;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dk1rmcVRvVD3mSxO5woI0MfXaxD2FYrS+EFBkps1DRU=;
 b=YhHATot6lWIIlin6a4JxPq5vqKRKzrrsp5MMO/kzwYmXtWyNgQ50WdfONMR7LgTg+5
 wI+nnjWQtj4wB8FUrgsBmKIAZk3zIQAwCIWwt62mmlIpC0mEsV//6l8eHodf8/Xpd+lW
 ZrWWkyEb6nIVg66NEmizMc8xe2yZ4aBYZKERDWm5T4AD5KdbnCU9IVQyKKR3p/vO6iDT
 7MPcn1zq/Ytez9+Azwn1moXQH4T4718fekDwP+NN7E3bK+X81Socpp8JWq7gRSVTbcBq
 muQChlb1IrAEiFrXbAr0IUmhPd5GmPXXwGlu0mmbpE9/3l0//db/zDZMSflWsNRV4a6T
 ZT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777137602; x=1777742402;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dk1rmcVRvVD3mSxO5woI0MfXaxD2FYrS+EFBkps1DRU=;
 b=cJQCz9wi/mpxTO9efRhzhM/Lv4s901RLRM8j/JSyw62+xE5H8QWorMSQNeEC6O+2D1
 d2LwqfKfkRoaq88PAYtTIN0TFIh2j44TR4SDQ/wwrq7NpDI/1dq0p7xeOIEEZgP4tUfR
 DnMaSIeNEgBfNbqT42cCYcPPsAKFXOGc6WJo98bhyXYecYgCT6tSEETmLO9zSVLc1TH0
 spBUSdDR1HGxOWKIgPWPvJ9gW0k1yDNm/MhYXwoXJ5YVRWcH6LCP49MUBNny5ztQZEAZ
 y1ig3P+aYIj7Rro8XbxU3dkIzCwlxujLI4TVWBC4auJSZ8dWst6Fks8PdX/sTg2D83pJ
 EPdQ==
X-Gm-Message-State: AOJu0YwDrU+RfVrrlOTpcOZ01zjWRHePJr9klWxNwdct8glZJ+wjQkk3
 YieD2QkN2UCLGtjI2bmjAVTRhrmfHq4QoYIxiQQ+x+EI90Dxoxa3G7SIF5FbD7ZpwetqqsjgZ3f
 7y4txEns=
X-Gm-Gg: AeBDieuuE0NZWT3tsG00tkZE7QWY2H+4fZGaMd6pLKH0D0zygtnytBIPtwGMl9vnrkW
 V0wCE7PWVuXUT0jUcehUyiyWLofWAFXZ+i0mYTjS8Dyw3Q8lh0/irhVl5PZ3f/jleamadln+DOz
 N/pjzdbSrsTv4uk8YmWhMWZH0WnU3+36FUfXxA6gwCJa+Be+Q/8u2ddzbNQoCEyBuW8TSDHOXQ+
 Z4pxUYR5kyf0Uq9sHlN0cGC3e8sCdfx9i8cHP/K2K31htoKOxL3Q5WbDM6kAoNsCWnmoe/4ZZIA
 cbdXSY3WTiMKSWeiVvJetQNP9ghh2Kuuo+5iw+MAX6eV6y0yC/og0sMKNZQz5bHBKmIg2eibl8W
 UaT2AGe0Cq6ifsdJNqeYXfNKrNeWt1rLDEZjwapWq6DC0/yZ/26BNwU55cWqpFCXTUnggyid/q0
 vZFQ97nCZw7JTiqpB5Udz8FkN0jtBe272lz5ZCvs3b2HkZDKhWoHrS8w/tXTdYO/nV4/AHenOmD
 SoOHaJ71Y7aj8JsIEBdvMipBa/ZIg88unifEKZ/iwkjbAG2OMHW8N6Yrqs642/B5cVaqoi5+CzN
 KdK6Pz6h56vCQK5MTqf2pEh6MqpO
X-Received: by 2002:a05:600c:6296:b0:483:64b4:79da with SMTP id
 5b1f17b1804b1-488fb7923a9mr358057685e9.26.1776950788998; 
 Thu, 23 Apr 2026 06:26:28 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-56a2-efb9-07f1-cf08.rev.sfr.net.
 [2a02:842a:d52e:6101:56a2:efb9:7f1:cf08])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm500300885e9.14.2026.04.23.06.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:26:28 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 23 Apr 2026 15:25:59 +0200
Subject: [PATCH 8/9] arm: dts: mt8189: Add ethernet support for Genio
 520/720 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-add-ethernet-support-for-genio-520-720-v1-8-47ca918e0017@baylibre.com>
References: <20260423-add-ethernet-support-for-genio-520-720-v1-0-47ca918e0017@baylibre.com>
In-Reply-To: <20260423-add-ethernet-support-for-genio-520-720-v1-0-47ca918e0017@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, Beiyan Yun <root@infi.wang>, 
 Ryder Lee <ryder.lee@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 fanyi zhang <fanyi.zhang@mediatek.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Christophe Roullier <christophe.roullier@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Tommy Shih <tommy.shih@airoha.com>, 
 Kevin-KW Huang <kevin-kw.huang@airoha.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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

Add Ethernet support for MediaTek MT8189-based Genio 520 and Genio 720
development boards.

The ethernet interface is disabled by default in the SoC dtsi and
enabled in the board-specific configuration with proper PHY settings.

The ethernet related nodes are not part of current dt submission on the
kernel [1] and come from downstream u-boot. When switching to
OF_UPSTREAM we should add them back.

[1]: https://lore.kernel.org/all/20251203-add-mediatek-genio-520-720-evk-v1-3-df794b2a30ae@collabora.com/

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 arch/arm/dts/mt8189.dtsi              | 77 ++++++++++++++++++++++++++++++++
 arch/arm/dts/mt8371-genio-common.dtsi | 83 +++++++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+)

diff --git a/arch/arm/dts/mt8189.dtsi b/arch/arm/dts/mt8189.dtsi
index d246be63293..f6272d5c807 100644
--- a/arch/arm/dts/mt8189.dtsi
+++ b/arch/arm/dts/mt8189.dtsi
@@ -240,6 +240,83 @@
 			#reset-cells = <1>;
 		};
 
+		eth: ethernet@1101a000 {
+			compatible = "mediatek,mt8189-gmac", "snps,dwmac-5.10a";
+			reg = <0 0x1101a000 0 0x4000>;
+			interrupts = <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "macirq";
+			clock-names = "mac_main",
+				      "ptp_ref";
+			clocks = <&topckgen_clk CLK_TOP_ETH_250M_SEL>,
+				 <&topckgen_clk CLK_TOP_ETH_62P4M_PTP_SEL>;
+			assigned-clocks = <&topckgen_clk CLK_TOP_ETH_250M_SEL>,
+					  <&topckgen_clk CLK_TOP_ETH_62P4M_PTP_SEL>,
+					  <&topckgen_clk CLK_TOP_ETH_50M_RMII_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_ETHPLL_D2>,
+						 <&topckgen_clk CLK_TOP_ETHPLL_D8>,
+						 <&topckgen_clk CLK_TOP_ETHPLL_D10>;
+			mediatek,pericfg = <&pericfg_ao_clk>;
+			snps,axi-config = <&stmmac_axi_setup>;
+			snps,mtl-rx-config = <&mtl_rx_setup>;
+			snps,mtl-tx-config = <&mtl_tx_setup>;
+			snps,txpbl = <16>;
+			snps,rxpbl = <16>;
+			clk-csr = <4>;
+			status = "disabled";
+
+			stmmac_axi_setup: stmmac-axi-config {
+				snps,wr-osr-lmt = <0x7>;
+				snps,rd-osr-lmt = <0x7>;
+				snps,blen = <0 0 0 0 16 8 4>;
+			};
+
+			mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <4>;
+				snps,rx-sched-sp;
+				queue0 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+				queue1 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+				queue2 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+				queue3 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+			};
+
+			mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <4>;
+				snps,tx-sched-wrr;
+				queue0 {
+					snps,weight = <0x10>;
+					snps,dcb-algorithm;
+					snps,priority = <0x0>;
+				};
+				queue1 {
+					snps,weight = <0x11>;
+					snps,dcb-algorithm;
+					snps,priority = <0x1>;
+				};
+				queue2 {
+					snps,weight = <0x12>;
+					snps,dcb-algorithm;
+					snps,priority = <0x2>;
+				};
+				queue3 {
+					snps,weight = <0x13>;
+					snps,dcb-algorithm;
+					snps,priority = <0x3>;
+				};
+			};
+		};
+
 		topckgen_clk: clock-controller@10000000 {
 			compatible = "mediatek,mt8189-topckgen", "syscon";
 			reg = <0 0x10000000 0 0x1000>;
diff --git a/arch/arm/dts/mt8371-genio-common.dtsi b/arch/arm/dts/mt8371-genio-common.dtsi
index 58322193aef..e91a4b74c53 100644
--- a/arch/arm/dts/mt8371-genio-common.dtsi
+++ b/arch/arm/dts/mt8371-genio-common.dtsi
@@ -236,8 +236,91 @@
 			bias-pull-up;
 		};
 	};
+
+	eth_default_pins: eth-default-pins {
+		txd-pins {
+			pinmux = <PINMUX_GPIO119__FUNC_GBE_TXD3>,
+				 <PINMUX_GPIO120__FUNC_GBE_TXD2>,
+				 <PINMUX_GPIO121__FUNC_GBE_TXD1>,
+				 <PINMUX_GPIO122__FUNC_GBE_TXD0>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+		cc-pins {
+			pinmux = <PINMUX_GPIO127__FUNC_GBE_TXC>,
+				 <PINMUX_GPIO130__FUNC_GBE_TXEN>,
+				 <PINMUX_GPIO129__FUNC_GBE_RXDV>,
+				 <PINMUX_GPIO128__FUNC_GBE_RXC>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+		rxd-pins {
+			pinmux = <PINMUX_GPIO123__FUNC_GBE_RXD3>,
+				 <PINMUX_GPIO124__FUNC_GBE_RXD2>,
+				 <PINMUX_GPIO125__FUNC_GBE_RXD1>,
+				 <PINMUX_GPIO126__FUNC_GBE_RXD0>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+		mdio-pins {
+			pinmux = <PINMUX_GPIO131__FUNC_GBE_MDC>,
+				 <PINMUX_GPIO132__FUNC_GBE_MDIO>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			input-enable;
+		};
+		power-pins {
+			pinmux = <PINMUX_GPIO133__FUNC_GPIO133>,
+				 <PINMUX_GPIO134__FUNC_GPIO134>;
+			output-high;
+		};
+	};
+
+	eth_sleep_pins: eth-sleep-pins {
+		txd-pins {
+			pinmux = <PINMUX_GPIO119__FUNC_GPIO119>,
+				 <PINMUX_GPIO120__FUNC_GPIO120>,
+				 <PINMUX_GPIO121__FUNC_GPIO121>,
+				 <PINMUX_GPIO122__FUNC_GPIO122>;
+		};
+		cc-pins {
+			pinmux = <PINMUX_GPIO127__FUNC_GPIO127>,
+				 <PINMUX_GPIO130__FUNC_GPIO130>,
+				 <PINMUX_GPIO129__FUNC_GPIO129>,
+				 <PINMUX_GPIO128__FUNC_GPIO128>;
+		};
+		rxd-pins {
+			pinmux = <PINMUX_GPIO123__FUNC_GPIO123>,
+				 <PINMUX_GPIO124__FUNC_GPIO124>,
+				 <PINMUX_GPIO125__FUNC_GPIO125>,
+				 <PINMUX_GPIO126__FUNC_GPIO126>;
+		};
+		mdio-pins {
+			pinmux = <PINMUX_GPIO131__FUNC_GPIO131>,
+				 <PINMUX_GPIO132__FUNC_GPIO132>;
+			input-disable;
+			bias-disable;
+		};
+	};
 };
 
 &pmic {
 	interrupts-extended = <&pio 194 IRQ_TYPE_LEVEL_HIGH>;
 };
+
+&eth {
+	/*
+	 * TX clock is provided by MAC
+	 */
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&phy>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&eth_default_pins>;
+	pinctrl-1 = <&eth_sleep_pins>;
+	status = "okay";
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy: phy@0 {
+			compatible = "ethernet-phy-idc0ff.0421";
+			reg = <0>;
+		};
+	};
+};

-- 
2.52.0

