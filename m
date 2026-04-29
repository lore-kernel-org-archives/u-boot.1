Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4581FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 12:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F2084867;
	Wed, 29 Apr 2026 14:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="cggIkoGV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5375F84705; Wed, 29 Apr 2026 11:17:33 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E09F984711
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 11:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891cd41959so106773025e9.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777454250; x=1778059050;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QFgGCKBb75M1KBAd4XUR3VRHVE2SjOFMXhwqyL8/eXk=;
 b=cggIkoGVZCWAzgCg/ePDxW35PO5hSRzP+T8a3XFmvSgF9pB6wn2atZ4ahwiZ7B3Ovb
 Yg6xShDMjXy2RO+eXpB2i+cq51LNnzb+wWPuzAU8S2MSvggUa1/iFaH6LrFwD4ryxLSa
 1khtwGkIUoIiIJy0ygnXFdyh/a0Pd2LCURMjkBGC15nYBIWdDh4Oxu6IXSFpHfvQqUr2
 ofOrrBWBsCWCDwro69aacQEYGPDjsBb7r5EnVWYOEW9UqjM1MYu/SzUVUo3IAeOQcOp9
 df2a23RlE5aKPTb1BYBW5Tm+9j6MeYBSQCD+XNgLO6fWB5sJqe4254UmechxCDDcn9XV
 99bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777454250; x=1778059050;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QFgGCKBb75M1KBAd4XUR3VRHVE2SjOFMXhwqyL8/eXk=;
 b=rcoGrf60AThtcp8F4+MVaUrlH/OX5dfwisZWkVLjNZUcjHcxARlrzkbT/Ra4687B8Z
 YwZZk/VnS1SWwsINtWFkoId6byMP2Gztwwv1PUMb4r79rWB6p+AzecmEtoJSGlP614a4
 8JJgKEEshvgIEiBFC3I+GklAElsSlTVJhudcUsecJM1jK59e2bKTyTjHYH0SksMi1xe9
 e2AMSt2ip0n/+sUVFRS40iZo19m8IJHE7sOOHYUCe/BwjUezl3ctGtGCafiXs1xghWJP
 sfUDNoQuIt8zzWFghQVeJlXmGDonRnWeEFm1QBs+jqa1C+Wf5mDap4XLdQ9AKhmeEGom
 v9qQ==
X-Gm-Message-State: AOJu0YxHWgpkyasmjD8czLJUhKJ+jrIrJquGdXMcmabh0RGA6se+CgpR
 6pbE7nNHEbfO6eEvmuZXrq6rlaOLgyF3alxmQgZE/bUf4SsOJcYFbBuAculrcgV+TNo=
X-Gm-Gg: AeBDieteUWGH7ssJNGBsnfg9AeF0z1fmlRlsGJVLmWdqdQx3ueHEHR0d0uW5wNq5Y85
 1MJyG/BGbgHi+bYdR6PvSfv+KmRKjiha0zex6moB/8x3M6O3sT+EYL5bCp4Y9n2/PjwfrUmVrtJ
 c/qi8Bss9Io73JMuhGDrL+pvj6cAYQ+xbr3sDLRduJqJfWx0KqgHSuq8WDZURciJzv1VU76UQtO
 N751Rm9XsHgSOjsA9Tv8ri333p/6t3d4N2uQB6Y1uFhMwIbkQBHGtns9mQSa/06SWYQR1G0iFIa
 amIJd8FQ1jBOTFAOvUnfxnpWHX9z0O77FseKZblyplGuJGvdfY89Uf+sSMS4jX236Sc+aEyqHIV
 uLdkSqz1bhDxXwGGyRZZVeQ2l5ug2WN3tTCfyeKrRvUPV6bRK9C9lr9uf75ehHGb0S38IAo4QMp
 l0hF6jUYLoJisjSCnNpc4R99gnUST61epr0Rl2sltGrIrLdrAPAG1EB05EavquZKvNdzPpduBRn
 c6mQ54cJEiQX55sMZ3/yOIGGEKTBH3LwY269zQvwQyHUhIRYPL9gc7oETNQQxHl1tcqRYTH14+7
 +n0Fe1w7Zb/EoY9K
X-Received: by 2002:a05:600c:a414:b0:48a:53ea:13df with SMTP id
 5b1f17b1804b1-48a77ad59bfmr90689175e9.2.1777454249936; 
 Wed, 29 Apr 2026 02:17:29 -0700 (PDT)
Received: from [192.168.1.64]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b9dee18sm44478375e9.0.2026.04.29.02.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 02:17:29 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 29 Apr 2026 11:17:11 +0200
Subject: [PATCH v3 3/9] net: Fix alphabetical ordering in drivers/net/Makefile
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-add-ethernet-support-for-genio-520-720-v3-3-1f65e18d4f54@baylibre.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v3-0-1f65e18d4f54@baylibre.com>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v3-0-1f65e18d4f54@baylibre.com>
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
X-Mailman-Approved-At: Wed, 29 Apr 2026 14:40:47 +0200
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

Reorder entries to maintain alphabetical sorting by CONFIG_ names:
- Move CONFIG_DWC_ETH_QOS_QCOM before CONFIG_DWC_ETH_QOS_ROCKCHIP
- Move CONFIG_DWC_ETH_XGMAC after CONFIG_DWC_ETH_QOS_STM32
- Move CONFIG_MDIO_GPIO_BITBANG before CONFIG_MDIO_IPQ4019
- Move airoha directory at the end

This ensures consistent alphabetical ordering throughout the Makefile.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/net/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 5e90183d090..c485068e5d2 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -5,7 +5,6 @@
 
 
 obj-$(CONFIG_AG7XXX) += ag7xxx.o
-obj-y += airoha/
 obj-$(CONFIG_AIROHA_ETH) += airoha_eth.o
 obj-$(CONFIG_ALTERA_TSE) += altera_tse.o
 obj-$(CONFIG_ASPEED_MDIO) += aspeed_mdio.o
@@ -22,12 +21,12 @@ obj-$(CONFIG_DWC_ETH_QOS) += dwc_eth_qos.o
 obj-$(CONFIG_DWC_ETH_QOS_ADI) += dwc_eth_qos_adi.o
 obj-$(CONFIG_DWC_ETH_QOS_IMX) += dwc_eth_qos_imx.o
 obj-$(CONFIG_DWC_ETH_QOS_INTEL) += dwc_eth_qos_intel.o
-obj-$(CONFIG_DWC_ETH_QOS_ROCKCHIP) += dwc_eth_qos_rockchip.o
 obj-$(CONFIG_DWC_ETH_QOS_QCOM) += dwc_eth_qos_qcom.o
-obj-$(CONFIG_DWC_ETH_XGMAC) += dwc_eth_xgmac.o
-obj-$(CONFIG_DWC_ETH_XGMAC_SOCFPGA) += dwc_eth_xgmac_socfpga.o
+obj-$(CONFIG_DWC_ETH_QOS_ROCKCHIP) += dwc_eth_qos_rockchip.o
 obj-$(CONFIG_DWC_ETH_QOS_STARFIVE) += dwc_eth_qos_starfive.o
 obj-$(CONFIG_DWC_ETH_QOS_STM32) += dwc_eth_qos_stm32.o
+obj-$(CONFIG_DWC_ETH_XGMAC) += dwc_eth_xgmac.o
+obj-$(CONFIG_DWC_ETH_XGMAC_SOCFPGA) += dwc_eth_xgmac_socfpga.o
 obj-$(CONFIG_E1000) += e1000.o
 obj-$(CONFIG_E1000_SPI) += e1000_spi.o
 obj-$(CONFIG_EEPRO100) += eepro100.o
@@ -62,9 +61,9 @@ obj-$(CONFIG_KSZ9477) += ksz9477.o
 obj-$(CONFIG_LITEETH) += liteeth.o
 obj-$(CONFIG_MACB) += macb.o
 obj-$(CONFIG_MCFFEC) += mcffec.o mcfmii.o
+obj-$(CONFIG_MDIO_GPIO_BITBANG) += mdio_gpio.o
 obj-$(CONFIG_MDIO_IPQ4019) += mdio-ipq4019.o
 obj-$(CONFIG_MDIO_MSCC_MIIM) += mdio-mscc-miim.o
-obj-$(CONFIG_MDIO_GPIO_BITBANG) += mdio_gpio.o
 obj-$(CONFIG_MDIO_MT7531_MMIO) += mdio-mt7531-mmio.o
 obj-$(CONFIG_MDIO_MUX_I2CREG) += mdio_mux_i2creg.o
 obj-$(CONFIG_MDIO_MUX_MESON_G12A) += mdio_mux_meson_g12a.o
@@ -109,6 +108,7 @@ obj-$(CONFIG_XILINX_AXIEMAC) += xilinx_axi_emac.o
 obj-$(CONFIG_XILINX_AXIMRMAC) += xilinx_axi_mrmac.o
 obj-$(CONFIG_XILINX_EMACLITE) += xilinx_emaclite.o
 obj-$(CONFIG_ZYNQ_GEM) += zynq_gem.o
+obj-y += airoha/
 obj-y += mscc_eswitch/
 obj-y += phy/
 obj-y += qe/

-- 
2.52.0

