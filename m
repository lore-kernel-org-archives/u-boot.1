Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52ABFF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 15:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEACA845D8;
	Tue, 28 Apr 2026 17:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="TiUqYgzF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7482284255; Tue, 28 Apr 2026 15:17:29 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51A8C84119
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 15:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso6257500f8f.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 06:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777382247; x=1777987047;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QFgGCKBb75M1KBAd4XUR3VRHVE2SjOFMXhwqyL8/eXk=;
 b=TiUqYgzFUJV5hvThnfW6jYI4mEnbO7RPkUZxffHKKTfrc4gAdUOB+n/4VlXkAtBWhw
 rbGQyvTdwSxWV9fTKHXAjZEHuUCOfVD2SNStwDUdnPv1BLAGWfVUwI5frX5+T4kVIE2Q
 NmJx+wMY4F6tB5PsEDPiq+s6PkQioMTnZ15uKDfTiIAhBhCl3gg8iMZEqBWbtOU0w6GW
 onUlNVZTe1fkoSWOl/fOOUk8mwr+a1F7VqHQ4TLYBY5OSiVXbzvIh4+aEgjtjl5RhT7T
 DQs+2Nkh7UzOUptYU2ZEwUVaAEe0ILOiJCbEDT2yGkvdHVKaxVfCOPWu0uwKPmSuGTt3
 EW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777382247; x=1777987047;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QFgGCKBb75M1KBAd4XUR3VRHVE2SjOFMXhwqyL8/eXk=;
 b=FbOgcFSjt4/t/Z6Dz3G4N9GAjpyS755D0imoZpP51YCz8X8RUiSkLS30bdewW6kxtI
 Bx0xeVzsLF2L6b4t+xcQ9twvIsTBhVueWptpzEZFNl2mYD85zWlg4BziErhjBElw7hIg
 8y0NcrKFpEVh8iIg/b+4UKiKTGeqC4A18IFbZ8w91j1qT9GAtyX0GzBTkoKEfHKJXSlG
 cW7Kzn90Mp6SvGzAZk4jEUzDZCgJGqivOAF1sCUoV+t/ht+wHdyTMS+P2fZVYGK9ld/l
 AIz3h3aggANRwyvS7RZ/nDulxojCAIGPwHCoGMoS8OHfofjMWZrO59IVsPMFwbWdgFaN
 9FSw==
X-Gm-Message-State: AOJu0Yymj8HRv1V+gkCp/OBiEenWvGWIkeKrVKmJmZs9ReTR7z6lbCTv
 p+S+Ys8jX9KFlAEKnXz0fvP62XTKOZa1/6nbua/A7LDmCHyYRxKh2U0J+HULGl6iO94=
X-Gm-Gg: AeBDiet+IGKd2D1szYgjUYQUiBAetnJrCceBBTIsdeptkZFpcrgPOWN+1O0bXHjflR4
 uGOI0HOwnEqRuLkiRytOwEBwC0hs+Hzg+i329Wi3zubPT+1wOJwgZwftwyrfauvXD7EwTa77odP
 og15wcW/1MPOyAiX5dW94AR+Jk4Pf/W0i/VRcsA4Ck3tYM99oiLB84ofD8yXbokwJWTge0O8QT6
 zeaqVLen9kdGwknv3tKIo6hTOG6vwxg1wywXzMswBfE0BJ/mdrtE/jL8U/MJSzPXFpyORGl+6Lh
 OLF6Ge+iBUQ6+d85MMACKouWMbuCof5+s8pIgViG3xwCAYFqi+qwfgAyt50wrLlBG/cAgkzNLGl
 Gq8hIkQWr6RBk4s5Ms2fI46l8LWv40tGq4YB3bUaGgBVLC8KtupNdf16QeVS5h8uiUeR5hxhHMM
 wbw9MN2kSsnZEEU4DxKG1E2nUI0LcD0quVsV9WjRl4Qo9gu3qMRC9vaAychlK7HWB5RccH9lUf8
 nN8jhxX3WBwz3sNa16xhdoOmbA6fv2sJO0Tjpux+CVYS843HnO6S2lPvBc8hcj2kKvcaBW2fowQ
 g+3+EB6bE5axWrgjxg==
X-Received: by 2002:a05:6000:2089:b0:43c:f66e:f31 with SMTP id
 ffacd0b85a97d-446494ebaf2mr5714618f8f.27.1777382246573; 
 Tue, 28 Apr 2026 06:17:26 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d5ee9ecsm7139599f8f.16.2026.04.28.06.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 06:17:24 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Apr 2026 15:17:10 +0200
Subject: [PATCH v2 3/9] net: Fix alphabetical ordering in drivers/net/Makefile
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-add-ethernet-support-for-genio-520-720-v2-3-9cf2f0884bd8@baylibre.com>
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

