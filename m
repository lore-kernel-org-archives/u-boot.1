Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF83FF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 21:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8169E84912;
	Wed, 29 Apr 2026 23:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="jbv4G4Io";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A13C284855; Wed, 29 Apr 2026 15:59:29 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 146BC84837
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 15:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso87237125e9.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 06:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777471165; x=1778075965;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f6quaoxQhjr9s3rbFQ1AfbME3klMiGPKGJ3Ars8yRck=;
 b=jbv4G4IoPK7UKSoMrdbuj9TXQSya/fQFR+DVNBhEHL9U3HhBenWx/C5bdR5RdHT71h
 /r4Loi1uTZYjb1KWIWC3UBUSCnrOSzOIUFoXwoicL+4yN55kYoFIje4NQQxImDL+S7OS
 alF/H/4eZRPznbofGZ+r3GG21423zFbMhn6sID9tk67ItHv0I6tnTf/VwceMateYDIzS
 3+QAc1w98MREey0P6cASxWXnQrQRzTM1V3mftVS7HOjF8pmQwIDaz5h2FCqp4fgCh6nE
 rZ6LGcODKO9u3ndR5mneuuoaXrqEpUfdGMk4pVPhbk9/K8F8qagw+TfYJQU959HK9XQO
 Mx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471165; x=1778075965;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f6quaoxQhjr9s3rbFQ1AfbME3klMiGPKGJ3Ars8yRck=;
 b=pDweIVPj2nxwSvf9el2/9k4kgRwL08i1x2T6lLSrCBUMYsUQsLQQdDNNiiTMLJAbKd
 eeSjCwKx2UpknCP9srWkrDcjEgVxLjkQZ64ZdiuUT/kV+2dmrf4edAL3tJFFDCH41gUE
 N5L0UgHRImL8O/aeMWhfyO9MWFXepmocYHpL/7cmDVtx9w2CVDIP7pBkWKpR5nIjjIjh
 MCDopRbxFgAxEx1LBaA3fBExemLQg8rx6Sj4a/7HiUa+o7Ld7B975spGa+rmg8+SR5de
 Prbmfx3f4TT9L7o1cfpRTQqpCm0pY3SwYncTG3keWogcva3dtfXVDEM0+EelqjwNVsQs
 5Jtg==
X-Gm-Message-State: AOJu0Ywv//PxzgcmGp3E9pzPXYoTIXyoAOUnA4r92DysjFnM0JTDm17c
 CJKW0bZhfKtrdFpKMrSkHBLtZ73oMw4zGhHjpRse1Voa0bjlAcWPLgXRJEbMInovn08=
X-Gm-Gg: AeBDietzI/5zfxm96joM3hsNTky3DSzDRzGj/OiL2Dq9i7L8FO5CxPOS5IHZw48Fq+o
 O2+k5neNinMC1bnsbOR5kz4JFVhZeCqd9Pi/ER29c11tSof/uEQq5msciZ1rAiO2MsPDb6JmsQ0
 bI+Iz3JR09zwKiky29nAh6wg5IjjjP+Ze3cUqUI4LvKi4QEwo3yMAtt76BMUYU9x7N8P2rMub1A
 Zlms+ZCLbSztQ8XCknyeBZUW54w+LCkF1Qec1KrGHBNgoQ3rSWb6V7tXd8A9xRp9JBV9/n8eO/W
 suDlSr/2wdDjLaiw4N6QicROcRYvi9bPy9rCo+ReEYI3sKnhqFwl8w8btY+AGE9kM4jzeZ4tr+w
 Xq0BV9ExlThch7lTtzKtO6sEuj9H5rwyPNFsQrBd7oJfW3tDy+ppWRP0WJ+n2rl9UTffzx84uv/
 W2xBP/yGsc3p26KIBCUsiWfQhTDh/6RK18a527q0ubx46sXTh5LijWX+4qtAqeQBM/o/0FXwyQP
 66KqrZZRE15Cx9mdAuV3DRLoLEivlD/pthTi7Lfbbo/KUft3uxb/xz5gBqRu/DFHS/LYEJEx3MJ
 OhOZCS339skNSKZnmf8=
X-Received: by 2002:a05:600c:5299:b0:489:1d74:56d with SMTP id
 5b1f17b1804b1-48a77b25324mr131213935e9.29.1777471165341; 
 Wed, 29 Apr 2026 06:59:25 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7ca64ffsm6289675f8f.37.2026.04.29.06.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:59:25 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 29 Apr 2026 15:59:01 +0200
Subject: [PATCH v4 8/9] arm: dts: mt8189: Add ethernet support for Genio
 520/720 boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-add-ethernet-support-for-genio-520-720-v4-8-be54e17239b7@baylibre.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
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
 Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 29 Apr 2026 23:15:47 +0200
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
index e550745ac5d..d4ee268a298 100644
--- a/arch/arm/dts/mt8189.dtsi
+++ b/arch/arm/dts/mt8189.dtsi
@@ -364,6 +364,83 @@
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
index 046e9d57752..1376a4c378c 100644
--- a/arch/arm/dts/mt8371-genio-common.dtsi
+++ b/arch/arm/dts/mt8371-genio-common.dtsi
@@ -281,6 +281,68 @@
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
@@ -311,3 +373,24 @@
 	vbus-supply = <&usb_p4_vbus>;
 	status = "okay";
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

