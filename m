Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F15FF8874
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 15:02:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3260084666;
	Tue, 28 Apr 2026 17:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="HReNvbTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 991D684119; Tue, 28 Apr 2026 15:17:46 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F23C84255
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 15:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-671dad7cac8so16416856a12.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 06:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777382262; x=1777987062;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dk1rmcVRvVD3mSxO5woI0MfXaxD2FYrS+EFBkps1DRU=;
 b=HReNvbTzT3YDuXWa/+y1kLyoLOzHsGp9LDQLN3XyRznyp4qW1uunfjTOHh1wvtR2k2
 VNyn1uY76aPKMz3yVrss28NQB6FX0Vi+HWnaWwYzFh/J1TyJbLrIZUlvXIsH4938Zfrb
 QGVg//nEPPYH95nQNPk7OGJ3FgiUAjpOTkS3F1jAN7/tNbLwW9Yvs2AT2N3sRc8/NH+O
 poOQqxXGUVPzsXTMLjGc1PKI5v+pKVvQeZmjF7ILVsGhPlMl4rjn5i1w5myjERClt3I9
 4Y3900GtbZCrXn3RnMXXGaW49WL3fHVgGt0MTqMoxKbn53kZhP7ZNWzwCRcTY1rdwEJl
 CpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777382262; x=1777987062;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dk1rmcVRvVD3mSxO5woI0MfXaxD2FYrS+EFBkps1DRU=;
 b=i1oUgRk0/gH3ndN6AvZqqAsIHrSrh1C5s8Eix2qHF2G3BMQm0FBSo4NXybx0Bw7t76
 STLmqOGe4YnO5ZAtef1pj9KY5a3u8kcRgKAJFeIHOEwr2sBkxhybOhGnfxaDPVuXRXEN
 gVp229RZNyCwWH1uOofRDJRa4NWJdizbAcUVAVRPzNcGcEXzAAcqfdI/lH8bMxvVfEkT
 kpJwYA854KOQdlZMulZ6Dij51W+MiHS47qvfndu4Za+tgGIjPgSvjiNFTTAwejLvjByq
 KRmUQcNmOiUribWfY115/msTNgt1bFsFlSafWydol0VQ87KcaeON2gxHrmBpxpXlhiif
 Ot3w==
X-Gm-Message-State: AOJu0Yzpv5DxdrvRZ9mYzdax6/Y9KlrICsBC7YJ7x6p2C074Owo0J6dx
 b4TmfIo6jtxCcf3OP1Axk/v1ponNYEzWU2GkHmeDYmL/XN/G6fkKrpjOP0IJJUtngx8=
X-Gm-Gg: AeBDiesfGVoorrGS5Rnx4cHKMvlhvIWy4H1hBqb7KQe2ROhBUre517SHYA9x4j/1InV
 kiUoovUcz3rOONUlHie8u1GW/vpy+m5BNqEqGLVXJdNlphjgu3Jv0czDbnQnSpzGmx1TkYJtjSE
 LC92voWrACzSiJCeM2Qpovuf0i6ViW7xv7J6HqPIgLA4T7YCKW24uK0UEYtD18oiDPu+MMN14mX
 leT3uxXUCM+Kt90LsFomO9fXtkNcb7w1Tls/JwXESP6cBzQcRnluuyPtdpPUWVeMxxFfDeasw+H
 vLmIiw3hxfForfDl9+/9S9PFukYrEPYrXdrkyroj6A5aKpJ2kAwJgUjAmMd9NL0pJM72L6DGcgp
 Je9B+6KjpLrJeRKF4l50ixXwC8yne0IgLWAX3Lxf6zcStNNvLv4yTgw5pu3sS+hP5YkUO9baI6Y
 MW3t3c+QvzUpbSIV59P0vM/zYDZU9NNIFuZ8c6yoRh5tVJiKw/LZyepgPN4TVGC8Qky0nutoga0
 UFkoR0A0xVe6D3uzG4HDvytx7i5jO00Zt7kSiDHdzVPrXWBENcagJE5uFup7yk6tCRplBm4rC5E
 +UZOHGCCyA0hIk8QqQ==
X-Received: by 2002:a05:6402:e0e:b0:674:74bf:8813 with SMTP id
 4fb4d7f45d1cf-679bb0959damr1432106a12.21.1777382261637; 
 Tue, 28 Apr 2026 06:17:41 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d5ee9ecsm7139599f8f.16.2026.04.28.06.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 06:17:41 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Apr 2026 15:17:15 +0200
Subject: [PATCH v2 8/9] arm: dts: mt8189: Add ethernet support for Genio
 520/720 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-add-ethernet-support-for-genio-520-720-v2-8-9cf2f0884bd8@baylibre.com>
References: <20260428-add-ethernet-support-for-genio-520-720-v2-0-9cf2f0884bd8@baylibre.com>
In-Reply-To: <20260428-add-ethernet-support-for-genio-520-720-v2-0-9cf2f0884bd8@baylibre.com>
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
X-Mailman-Approved-At: Tue, 28 Apr 2026 17:00:38 +0200
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

