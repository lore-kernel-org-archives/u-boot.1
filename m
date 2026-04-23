Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F60FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C6DD8442B;
	Sat, 25 Apr 2026 22:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="BCW/V0MZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 395FF844BF; Sat, 25 Apr 2026 20:30:19 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF43484445
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9c745e18a0so1528481966b.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777141816; x=1777746616;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QFgGCKBb75M1KBAd4XUR3VRHVE2SjOFMXhwqyL8/eXk=;
 b=BCW/V0MZQgonbNj6y7g9e2ybmWvGZowilGDOSX792mXKc94FkyQab9oNoDGS9T091b
 ohFTGMKbR51j3pShIyrggeq7Osde1DGKBWPJAjeJjlKulC7ekd5RoW0L47EwwP12pVP3
 1vKh52CWaSQErQrvwyXyZJeuQbWxPqNlXOTxb5m54iog2vYtaxNvYlaLHh6zXwyKsepV
 0bYqdwZuO+/U7ZO4CORT0NJpPk+5FQ2Hf8uBzImCOhKxqo7DjFqTdypXRLyiuEMbutPF
 He1JV44SSS6te7AZctOhtOrgCpJdrILij2SGV82c/BnAg7eVVV79Ka5Dyw910vEhpJUm
 vskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777141816; x=1777746616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QFgGCKBb75M1KBAd4XUR3VRHVE2SjOFMXhwqyL8/eXk=;
 b=coWPWCdC7EFuGEIyHbZfCsjM8I7E2Htp4epkRUm786pYguodz8WQZkTpfrvzf7WlUq
 dKJIZY2PYop3JVDJB3o6HfwEuQe21fI+Zs2QRH4WkVcTw+/RhEPx9t9hGi5mJ5Q958MX
 VqXjSCQ8B5kaOr+97NGlWPq/lPpIJ/1Li270Xv+BmbCw/bPeDSjV7RpBEJ0RCvsdLTxS
 WfuVlTKZ6tF1eAbUPmYwWHR4ue8fOdVfB3Z8kyOsH/finvhA6BhFMQOmGzQGrZlUKwY3
 wEvJdUdkN4GHRe9kgZ5OKP4tWx5Z0x+Cu8QYIHoA4bRKJqM2OaTpel7MgR/EvIHWvs8C
 OAUw==
X-Gm-Message-State: AOJu0YxHUsEkouYRKTUc94hvMdke0DMHgRozqJUmd23n2K5aK2yV0UoX
 rE8eeq2AaL7M602e3J+OUd/TDa5DN7v/3+ExVpRd3lMdLHn9Tw6j96PTSqcxFbiOtD3yVOYJnyl
 14x4YvxA=
X-Gm-Gg: AeBDieubbGNbJQ2OOScG3MSUPfnXkjsZRBNoTBPH2l9bLLue9F9ka1/vI+LTNkxRUjQ
 rtY+c6ckHYcO7dA9Wsx6AsycFvsKmkmkakf39+MtG6BsLDwGMS1987txG0Yq3G7z+cvn7CV5Ha/
 PW81b9kG1PAf9xO2pc6ZthzmQHCOoQ+hh+/r79iNn4CHx8aOSvMzWSMQ9f3tWIips2261qyBgp6
 bj98Mmntqp/6bfi3hoLSxHxjTK2XtqiyAo1FhQkzEPpx3eXx5zPq3bbEUTgaiIqXkXcy/dDt+nz
 EWMMqrQSmunupA2cACQqKzP3YLzG77mNjVloPcKIAjuwLMmAh6OV9QKfNV7dHUskScZqHcFgTKi
 FtYrtEwhEbNcyYubrxFU+S0SAmKf/oDz4VVm8N9KTLws/f2MV8DGBlKfU9feMuQi2HKshqZMqCj
 g1ar/RHr/qfJw0Qbrcvxh5cfqCRzXBqQeP7jbwW8uFys/JXveqX7dpI+El+rPsHM8rWyMUUNtNd
 VQTaNwlQIr84tzk0TtMLzQzd1qRZLiJ22jDCybdhf9kfnxyFKLdBfhDMgoXT0+VzhDsRhFqrkbE
 xAjjgJ85SkTc22j5OVqBa/yF4XMp
X-Received: by 2002:a05:600c:19d3:b0:48a:55ec:c007 with SMTP id
 5b1f17b1804b1-48a55ecc113mr148807775e9.15.1776950762274; 
 Thu, 23 Apr 2026 06:26:02 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-56a2-efb9-07f1-cf08.rev.sfr.net.
 [2a02:842a:d52e:6101:56a2:efb9:7f1:cf08])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm500300885e9.14.2026.04.23.06.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:26:01 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 23 Apr 2026 15:25:54 +0200
Subject: [PATCH 3/9] net: Fix alphabetical ordering in drivers/net/Makefile
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-add-ethernet-support-for-genio-520-720-v1-3-47ca918e0017@baylibre.com>
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
X-Mailman-Approved-At: Sat, 25 Apr 2026 22:36:28 +0200
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

