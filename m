Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18953FF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 21:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0308A848E7;
	Wed, 29 Apr 2026 23:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="f+diu+G/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A20C784867; Wed, 29 Apr 2026 15:59:17 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BB1C84832
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 15:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso96718315e9.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 06:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777471155; x=1778075955;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QFgGCKBb75M1KBAd4XUR3VRHVE2SjOFMXhwqyL8/eXk=;
 b=f+diu+G/aLmsarAItx/pLWA2+GnBZWf2oOpLjpo95fYtFo4DkZkMe23bVvR8/DIXFb
 XqbKEP9QevoY7Dcn63kD+fyFJ19JbZLa9HDLmCNMHPYsdZ5SJ1ISLaCsVd8emNkCO51O
 7Spk4n+FeX4VzCKhOfQwWHSQqp1XPjABhAgrC7kOFKg+czoZLl3JKnxdDWOY/S+RSCAb
 8zJDFwklR3wTXv9OSIbUOBSWi6KPfL7vinFNymuW0W56V6vv2GdfB+Ndjv1wIK64r6Mf
 v1KbDvnCNmzFu78rIrqJgH1KP1zNkGvvE6ZXbXkkiro3axBCHlDfiw/daeIINTVKpknj
 rPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471155; x=1778075955;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QFgGCKBb75M1KBAd4XUR3VRHVE2SjOFMXhwqyL8/eXk=;
 b=EFZgWW5HKDA3Vr3hnWEL7i7Njh1nnq6q/8FzbWNPHvjVztSN9ugJqi21d1dvcWrcNR
 jd24GeH0/erPzed0gV2bkXRW75OmLsh0jHtNKVnog0wsh6YUH1nC1A6tXBxFtH0ieeYI
 DpFxZM8gA37fOa4Re2Fb04oQYayBaU41ymj0MC3aNopFfbRGJynA6bIV8ZB+H/VXFFV3
 JkCm9VggzkoOFZ47X+S9n59VL3IAdvavoa7Ne6OwsC5t5r8o4TrgGus0dOWoFxziS5V8
 iAifKgbDh4fy0sa6Um9e4oFGCfdnwiHaRRq/Smv1OvTWPCTx9g0dngBcrUsR/KAfXZGp
 IGcQ==
X-Gm-Message-State: AOJu0Ywy5UVNe4rJIwf6FUI2hBkH65b3ToZbbLsZAlxNlezWB2R7Bcy7
 x4VVBkCh4uSoagN2XzTHQlL8H724G3aY9rf1gkn3jhLGxKkG91311qtpzrpjDo4FJ+8=
X-Gm-Gg: AeBDieuVSHBX/KRT8dyq8oMPUTtx06mxId3W5V3QYlb2+SJ0AMNzB5br5gAtHrX7WYo
 LhV8GbPfEB3bQmQUBo+nlOnjVhG56dLY9KiHtKAuShvBf0Q8lER+kYpmSdg2PgKAJVaFcs5z1He
 j07LG3y2FF2FUrViEHI7nGRyQgHkJw39/rAqsS+crMnHTvz+ybIKyx2wSQrFv3XlxaY0sTgT5eD
 RcOwzygUJg4Rmo5waoNO7/YYsgzf30su16iZBbqXXJTit7b+Ik3bhvLVDp793gishKMhHnwgKAf
 sEyfCc8rCUoSwimQAaudXgrfEjmIMyRzhEtA4ykbF0S2Vc/6sFNwpgOCScbVJUsamXv/RDDxOZL
 99ba9G3OTNy2KWXrt7zHAuG+D9UnmS7WXTOpioP7wNiQ6too5OoNy9dgZAwajbIBdqhK6mT2xC9
 jQASskVfVOe0G1jhFHfScc9XgUrhoBzoaD5XmAoQAbpsyoIf8r7/pwpFV69PIKK9IPYVISLtUzv
 /A4iN4NkJcR5bLYV8ZpPQrgoCLUFcBkWXOShy25rvh9UVi4XscC+iyKfpTiIcRif1xd5PO8T7In
 zzUMsugxdUTMR2SeqFk=
X-Received: by 2002:a05:600c:17d2:b0:48a:7a10:4f3d with SMTP id
 5b1f17b1804b1-48a7a1050c1mr59943935e9.0.1777471154576; 
 Wed, 29 Apr 2026 06:59:14 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7ca64ffsm6289675f8f.37.2026.04.29.06.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:59:14 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 29 Apr 2026 15:58:56 +0200
Subject: [PATCH v4 3/9] net: Fix alphabetical ordering in drivers/net/Makefile
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-add-ethernet-support-for-genio-520-720-v4-3-be54e17239b7@baylibre.com>
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

