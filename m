Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAACE6BF1B
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 15:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5EA4844CB;
	Fri, 30 Jan 2026 16:40:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uwc43QZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D02C844C0; Fri, 30 Jan 2026 16:39:39 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 450C184073
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 16:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=george.mccollister@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-66314fa03c9so297930eaf.2
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 07:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769787575; x=1770392375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Krgkw7x732nUWNBxwah344X9hakz4cdm9cKdpC/rn00=;
 b=uwc43QZZ8vDkZ2I3BU3XODY/FlR0c9uNyEZyW9MLBnWDqC1uDBAATq8J+bRNUEl7pF
 epsZHyY1FDVai2R0roo2raoW+v/Mn23LjTbMK83ELVpDtwStWGn6fn0JC3JQQY1Mxskb
 TBqgkkLVLwJEXZkX9IQvi+kvKvwmzenQBIa6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769787575; x=1770392375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Krgkw7x732nUWNBxwah344X9hakz4cdm9cKdpC/rn00=;
 b=HYwYMITODtHPTmrEJvTcovwo1oViWv6DISom4z3gih/kNc+VdXFK3GipWCct9fUeVO
 6E8X93YCRjnOyNRpWwz65z+HPX0DR2Rtfr43kKDBw9nW3oTLPI02B5geboGiWhnxb4Ip
 2QAcTaMgaaWB2Vmkg47lIG/FdWICnULIawhXsdhPvpO8cU3N2b46MH+tasYN/6wKatWL
 Hq3sLSGZysMTAmV4vRHyft8d3omwyHp7bPSYPmrtdqS6z7NfLX4BHOemwF7fM6zIvtPW
 /yGfb/fV4R8l2R0OqD65XgBppjEPPoDRuBVVNJ+A8uqadqLfqFQU/cEfyjnjNXfv4rhw
 mQag==
X-Gm-Message-State: AOJu0YwP9fjPKYy9NSpvUW/3ANmvtnZXmz72VeCimat6TvBx2VVf+UrJ
 y6GJKsoVm6qbO5PnTmOcCG7a7Y2NAKgVYSpELgRHMbIIjhwPcirMfKahMY1IMGVXd9SmBjgpMWN
 9vOHl
X-Gm-Gg: AZuq6aL5FUErkAeAGoysqKDDYbk1dC4HjTJkyye6rNjhgD2hAQe0ySqB8VG05fxzyQv
 X5aNuGZDfHlXfa3aL/CAmbjrkZuGyZc64COuiFuyv11IpVrOLFUOTC95LS0JefsOcZ4Gu8+uNGe
 7pPXmpRyy9n85pZNtjIeMVBJM22y3jmgbgnRGsy2rjjN+S0pE7f3Op7kkX2oFigYUNjF08V8TCO
 bkYyhT0OnMTO5KjW5eUUF6yK/BPGTrrxo9yjbNnf/DqpbFvUSGSylCmRt3/ghL3PpxZl7u6nNNj
 Q4zXYepifIzcotwy3a2w98b/M266LP6xx6OFaTZyNdV0IuxRr6M+LV89yi7RZtBww+RLs0kOAAb
 +yGAbvhotSifPrAgwB7dBTKI/UQCL3PQuS2IKObCgM2vNomIDVeLvradZEQQ/5jZV5GoPkeW7nR
 xWXyll5JEGpKcRHGg/h12pDBmgpepURFn1whtmkTIlb7QFMw==
X-Received: by 2002:a05:6820:c91:b0:662:c112:c506 with SMTP id
 006d021491bc7-6630f3b507bmr1533870eaf.69.1769787574600; 
 Fri, 30 Jan 2026 07:39:34 -0800 (PST)
Received: from ryzen.localdomain ([136.33.243.183])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095752ef7bsm5944934fac.16.2026.01.30.07.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 07:39:34 -0800 (PST)
From: George McCollister <george.mccollister@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bryan Brattlof <bb@ti.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/6] phy: ti: j721e-wiz: Enable reference clock output in
 cmn_refclk_<p/m>
Date: Fri, 30 Jan 2026 09:38:02 -0600
Message-ID: <20260130153856.2049575-3-george.mccollister@konsulko.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130153856.2049575-1-george.mccollister@konsulko.com>
References: <20260130153856.2049575-1-george.mccollister@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Jan 2026 16:40:08 +0100
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

cmn_refclk_<p/m> lines in Torrent SERDES are used for an connecting
external reference clock. cmn_refclk_<p/m> can also be configured to
output the reference clock. In order to drive the refclk out from the
SERDES (Cadence Torrent), PHY_EN_REFCLK should be set in SERDES_RST of
WIZ. Model PHY_EN_REFCLK as a clock, so that platforms like AM642 EVM
can enable it.

Based on: https://lore.kernel.org/r/20210310120840.16447-6-kishon@ti.com

Signed-off-by: George McCollister <george.mccollister@konsulko.com>
Tested-by: Bryan Brattlof <bb@ti.com>
---

(no changes since v1)

 drivers/phy/ti/phy-j721e-wiz.c | 46 ++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index eaf68d18f3a1..466e2a5d0b50 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -75,6 +75,7 @@ enum wiz_typec_master_lane {
 
 static const struct reg_field por_en = REG_FIELD(WIZ_SERDES_CTRL, 31, 31);
 static const struct reg_field phy_reset_n = REG_FIELD(WIZ_SERDES_RST, 31, 31);
+static const struct reg_field phy_en_refclk = REG_FIELD(WIZ_SERDES_RST, 30, 30);
 static const struct reg_field pll1_refclk_mux_sel =
 					REG_FIELD(WIZ_SERDES_RST, 29, 29);
 static const struct reg_field pll1_refclk_mux_sel_2 =
@@ -534,9 +535,43 @@ static int wiz_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
 	return 0;
 }
 
+static int wiz_phy_en_refclk_enable(struct clk *clk)
+{
+	struct udevice *dev = clk->dev;
+	struct wiz_clk *priv = dev_get_priv(dev);
+	struct wiz *wiz = priv->wiz;
+	int id;
+
+	id = clk->id >> 10;
+	if (id != TI_WIZ_PHY_EN_REFCLK)
+		return 0;
+
+	regmap_field_write(wiz->phy_en_refclk, 1);
+
+	return 0;
+}
+
+static int wiz_phy_en_refclk_disable(struct clk *clk)
+{
+	struct udevice *dev = clk->dev;
+	struct wiz_clk *priv = dev_get_priv(dev);
+	struct wiz *wiz = priv->wiz;
+	int id;
+
+	id = clk->id >> 10;
+	if (id != TI_WIZ_PHY_EN_REFCLK)
+		return 0;
+
+	regmap_field_write(wiz->phy_en_refclk, 0);
+
+	return 0;
+}
+
 static const struct clk_ops wiz_clk_ops = {
 	.set_parent = wiz_clk_set_parent,
 	.of_xlate = wiz_clk_of_xlate,
+	.enable = wiz_phy_en_refclk_enable,
+	.disable = wiz_phy_en_refclk_disable,
 };
 
 int wiz_clk_probe(struct udevice *dev)
@@ -818,6 +853,12 @@ static int wiz_regfield_init(struct wiz *wiz)
 		return PTR_ERR(wiz->phy_reset_n);
 	}
 
+	wiz->phy_en_refclk = devm_regmap_field_alloc(dev, regmap, phy_en_refclk);
+	if (IS_ERR(wiz->phy_en_refclk)) {
+		dev_err(dev, "PHY_EN_REFCLK reg field init failed\n");
+		return PTR_ERR(wiz->phy_en_refclk);
+	}
+
 	wiz->pma_cmn_refclk_int_mode =
 		devm_regmap_field_alloc(dev, regmap, pma_cmn_refclk_int_mode);
 	if (IS_ERR(wiz->pma_cmn_refclk_int_mode)) {
@@ -1042,6 +1083,11 @@ static int j721e_wiz_bind_clocks(struct wiz *wiz)
 		}
 	}
 
+	rc = device_bind(dev, wiz_clk_drv, "phy-en-refclk",
+			 NULL, dev_ofnode(dev), NULL);
+	if (rc)
+		dev_err(dev, "cannot bind driver for clock phy-en-refclk\n");
+
 	return 0;
 }
 
-- 
2.52.0

