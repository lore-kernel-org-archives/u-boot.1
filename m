Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B10E7848C
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 19:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA80384310;
	Wed, 24 Dec 2025 20:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B86TuNcG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E2D5842C2; Wed, 24 Dec 2025 20:32:33 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 734C6842F2
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 20:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=george.mccollister@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c765f41346so2751407a34.3
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 11:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766604749; x=1767209549; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WdCQwEPAEsBf/MtSucKVDtuCZK5NgGbCROpH60LugIs=;
 b=B86TuNcGjUY09gLwsi2veKT7taCS3n6bg4zQJ+GCWtgz+c8jf617cfjiMdrBDIZ42T
 dT4UpJLqx4i1vpeVmEcTsudJLuMIVsfb7NEBT2IHUUUaIaY5OEl2qbaVQaH+10uQi8vp
 Xkj1XOCVpu/PKTu3U0OI2hrspFt2cVNiK9Dz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766604749; x=1767209549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WdCQwEPAEsBf/MtSucKVDtuCZK5NgGbCROpH60LugIs=;
 b=LNF7ciM+kxNoBmQpLCIPaWIgEwWZCO7QXPqfnHBxlR/tTGEwpjeC8o+fdP8WjrLg62
 vHSOsuNn5znRe7d+BN5lX/e7pJySAVeESZrYAnax+OReCBWIMxcZmUE/SsciabVwSQX5
 pD1RfiKWBSpMBTQBmIubSBN+C+g6c7xmJoceyq2MUni9Z36uH8NI3WanMNz64YWcMIJQ
 AECUZSMB2TOmkQkVCeGJpWkJaFdGcv7v4k193MS5KPjTfWgOWGLneB2lih/CdBfxxlbP
 kBxrSbC3CfI6GRNXxaz1csrzTvoy9DxVfd5wmeX1o1HPb0fd3moHIbmle2NNODjQCN5f
 xW1Q==
X-Gm-Message-State: AOJu0Yy0gFtnwax0ZE4Nc6hiwvtsQwcqmk53ZRuWgsCbPe3FmN1VoODF
 OmVpVXzzpHdIWj2NKDwGovGhcFuYe5Qq2XBMqlSrvwTJtDIzg4gmVqg+bHLg633jbkV7y1Hx45q
 YXHtivik=
X-Gm-Gg: AY/fxX5IeMTmJU19hx1Z3bzw+U9RRK7YgYKCbisGnI9TyqJ3MsTNrw5WFqkhwWK5spk
 yW55UVw7QlhqFexVMDemrwB1EOXemGCtE7P2D0/j+1XpuEA3Q0X6RbRB6zkf+FBWw3IDg87Eyrb
 j+MLWIqdHIe4ODqFQ5/Qeh2FjBPwLl95K6rHctIKG4hXmaiMPSFfuGyvfey3DXuEALHViMGRqEY
 UZnVALA9MaStpQ3uctVvmjltqxYVsvkOgmZuE4ZhCSNlPeGbWnx7k8qD+QKghl0eO0hfLf3uYM1
 I78wVaBnqW1drUHupVuMVjNP66z3120gMhnFw+TbndlYdKdL9XY6ASILk7vBR089qeluUtfnPPL
 anQG/eLKUJzZ2B32B6rm0xA0nkWk74WvAgTg9nBNA7jnCi0xdPKi09/4JM4Iih7QRq8NXqZ4Bfn
 ifLGOIdl7/pb0ybyIHkcKKm3mFcc+8pgawgqw=
X-Google-Smtp-Source: AGHT+IF6vP2OZHEX8Z4l5N4PgWYJTCFMP0vgxqabCAAnP95oLy5yCjwbVyDVGPCTBBaRSrHVLqDhRg==
X-Received: by 2002:a05:6830:dc6:b0:7c7:1c77:f107 with SMTP id
 46e09a7af769-7cc66a9e05dmr9503293a34.34.1766604748802; 
 Wed, 24 Dec 2025 11:32:28 -0800 (PST)
Received: from ryzen.localdomain ([136.33.243.183])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673bc05sm12049723a34.8.2025.12.24.11.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 11:32:28 -0800 (PST)
From: George McCollister <george.mccollister@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bryan Brattlof <bb@ti.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/6] phy: cadence-torrent: Add support to drive refclk out
Date: Wed, 24 Dec 2025 13:32:01 -0600
Message-ID: <20251224193213.802246-4-george.mccollister@konsulko.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251224193213.802246-1-george.mccollister@konsulko.com>
References: <20251224193213.802246-1-george.mccollister@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Dec 2025 20:37:54 +0100
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

cmn_refclk_<p/m> lines in Torrent SERDES are used for connecting an
external reference clock. cmn_refclk_<p/m> can also be configured to
output the reference clock. Model this derived reference clock as a
"clock" so that platforms like AM642 EVM can enable it.

This is used by PCIe to use the same refclk both in local SERDES
and remote device. Add support here to drive refclk out.

Based on: https://lore.kernel.org/all/20210310120840.16447-7-kishon@ti.com/

Signed-off-by: George McCollister <george.mccollister@konsulko.com>
---

 drivers/phy/cadence/phy-cadence-torrent.c | 168 ++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 28fe026223c1..933533b2b0b7 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -11,16 +11,19 @@
  */
 
 #include <clk.h>
+#include <clk-uclass.h>
 #include <generic-phy.h>
 #include <reset.h>
 #include <dm/device.h>
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
+#include <dm/devres.h>
 #include <dm/lists.h>
 #include <dm/read.h>
 #include <dm/uclass.h>
 #include <linux/io.h>
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-cadence.h>
 #include <regmap.h>
 #include <linux/delay.h>
 #include <linux/string.h>
@@ -64,6 +67,8 @@
 #define CMN_PLLSM1_PLLLOCK_TMR		0x0034U
 #define CMN_CDIAG_CDB_PWRI_OVRD		0x0041U
 #define CMN_CDIAG_XCVRC_PWRI_OVRD	0x0047U
+#define CMN_CDIAG_REFCLK_OVRD		0x004CU
+#define CMN_CDIAG_REFCLK_DRV0_CTRL	0x0050U
 #define CMN_BGCAL_INIT_TMR		0x0064U
 #define CMN_BGCAL_ITER_TMR		0x0065U
 #define CMN_IBCAL_INIT_TMR		0x0074U
@@ -191,6 +196,7 @@
 #define RX_DIAG_ACYA			0x01FFU
 
 /* PHY PCS common registers */
+#define PHY_PIPE_CMN_CTRL1		0x0000U
 #define PHY_PLL_CFG			0x000EU
 #define PHY_PIPE_USB3_GEN2_PRE_CFG0	0x0020U
 #define PHY_PIPE_USB3_GEN2_POST_CFG0	0x0022U
@@ -214,6 +220,26 @@ static const struct reg_field phy_pma_pll_raw_ctrl =
 #define reset_control reset_ctl
 #define reset_control_put reset_free
 
+static const struct reg_field phy_pipe_cmn_ctrl1_0 = REG_FIELD(PHY_PIPE_CMN_CTRL1, 0, 0);
+
+#define REFCLK_OUT_NUM_CMN_CONFIG	5
+
+enum cdns_torrent_refclk_out_cmn {
+	CMN_CDIAG_REFCLK_OVRD_4,
+	CMN_CDIAG_REFCLK_DRV0_CTRL_1,
+	CMN_CDIAG_REFCLK_DRV0_CTRL_4,
+	CMN_CDIAG_REFCLK_DRV0_CTRL_5,
+	CMN_CDIAG_REFCLK_DRV0_CTRL_6,
+};
+
+static const struct reg_field refclk_out_cmn_cfg[] = {
+	[CMN_CDIAG_REFCLK_OVRD_4]	= REG_FIELD(CMN_CDIAG_REFCLK_OVRD, 4, 4),
+	[CMN_CDIAG_REFCLK_DRV0_CTRL_1]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 1, 1),
+	[CMN_CDIAG_REFCLK_DRV0_CTRL_4]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 4, 4),
+	[CMN_CDIAG_REFCLK_DRV0_CTRL_5]  = REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 5, 5),
+	[CMN_CDIAG_REFCLK_DRV0_CTRL_6]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 6, 6),
+};
+
 enum cdns_torrent_phy_type {
 	TYPE_NONE,
 	TYPE_DP,
@@ -257,6 +283,9 @@ struct cdns_torrent_phy {
 	struct regmap_field *phy_pma_cmn_ctrl_1;
 	struct regmap_field *phy_pma_cmn_ctrl_2;
 	struct regmap_field *phy_pma_pll_raw_ctrl;
+	struct clk *clks[CDNS_TORRENT_REFCLK_DRIVER + 1];
+	struct regmap_field *phy_pipe_cmn_ctrl1_0;
+	struct regmap_field *cmn_fields[REFCLK_OUT_NUM_CMN_CONFIG];
 };
 
 struct cdns_reg_pairs {
@@ -592,6 +621,141 @@ static int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_ph
 	return 0;
 }
 
+struct cdns_torrent_derived_refclk {
+	unsigned int		id;
+	struct cdns_torrent_phy *cdns_phy;
+};
+
+static int cdns_torrent_derived_refclk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
+{
+	struct udevice *dev = clk->dev;
+	struct cdns_torrent_derived_refclk *derived_refclk = dev_get_priv(dev);
+
+	if (derived_refclk->id != CDNS_TORRENT_REFCLK_DRIVER)
+		return -EINVAL;
+
+	derived_refclk->id = args->args[0];
+
+	return 0;
+}
+
+static int cdns_torrent_derived_refclk_enable(struct clk *clk)
+{
+	struct udevice *dev = clk->dev;
+	struct cdns_torrent_derived_refclk *derived_refclk = dev_get_priv(dev);
+	struct cdns_torrent_phy *cdns_phy = derived_refclk->cdns_phy;
+
+	if (derived_refclk->id != CDNS_TORRENT_REFCLK_DRIVER)
+		return -EINVAL;
+
+	regmap_field_write(cdns_phy->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_6], 0);
+	regmap_field_write(cdns_phy->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_4], 1);
+	regmap_field_write(cdns_phy->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_5], 1);
+	regmap_field_write(cdns_phy->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_1], 0);
+	regmap_field_write(cdns_phy->cmn_fields[CMN_CDIAG_REFCLK_OVRD_4], 1);
+	regmap_field_write(cdns_phy->phy_pipe_cmn_ctrl1_0, 1);
+
+	return 0;
+}
+
+static int cdns_torrent_derived_refclk_disable(struct clk *clk)
+{
+	struct udevice *dev = clk->dev;
+	struct cdns_torrent_derived_refclk *derived_refclk = dev_get_priv(dev);
+	struct cdns_torrent_phy *cdns_phy = derived_refclk->cdns_phy;
+
+	regmap_field_write(cdns_phy->phy_pipe_cmn_ctrl1_0, 0);
+
+	return 0;
+}
+
+static const struct clk_ops cdns_torrent_derived_refclk_ops = {
+	.of_xlate = cdns_torrent_derived_refclk_of_xlate,
+	.enable = cdns_torrent_derived_refclk_enable,
+	.disable = cdns_torrent_derived_refclk_disable,
+};
+
+int cdns_torrent_derived_refclk_probe(struct udevice *dev)
+{
+	struct cdns_torrent_derived_refclk *priv = dev_get_priv(dev);
+
+	priv->cdns_phy = dev_get_priv(dev->parent);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(cdns_torrent_derived_refclk) = {
+	.name		= "cdns_torrent_derived_refclk",
+	.id		= UCLASS_CLK,
+	.priv_auto	= sizeof(struct cdns_torrent_derived_refclk),
+	.ops		= &cdns_torrent_derived_refclk_ops,
+	.probe		= cdns_torrent_derived_refclk_probe,
+};
+
+static int cdns_torrent_derived_refclk_register(struct cdns_torrent_phy *cdns_phy)
+{
+	struct driver *cdns_torrent_derived_refclk_drv;
+	struct udevice *dev = cdns_phy->dev;
+	struct regmap_field *field;
+	struct regmap *regmap;
+	struct clk *clk;
+	int rc;
+	int i;
+
+	clk = devm_clk_get_optional(dev, "phy_en_refclk");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "No parent clock for derived_refclk\n");
+		return PTR_ERR(clk);
+	}
+
+	clk_enable(clk);
+
+	regmap = cdns_phy->regmap_phy_pcs_common_cdb;
+	field = devm_regmap_field_alloc(dev, regmap, phy_pipe_cmn_ctrl1_0);
+	if (IS_ERR(field)) {
+		dev_err(dev, "phy_pipe_cmn_ctrl1_0 reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	cdns_phy->phy_pipe_cmn_ctrl1_0 = field;
+
+	regmap = cdns_phy->regmap_common_cdb;
+	for (i = 0; i < REFCLK_OUT_NUM_CMN_CONFIG; i++) {
+		field = devm_regmap_field_alloc(dev, regmap, refclk_out_cmn_cfg[i]);
+		if (IS_ERR(field)) {
+			dev_err(dev, "CMN reg field init failed\n");
+			return PTR_ERR(field);
+		}
+		cdns_phy->cmn_fields[i] = field;
+	}
+
+	cdns_torrent_derived_refclk_drv = lists_driver_lookup_name("cdns_torrent_derived_refclk");
+	if (!cdns_torrent_derived_refclk_drv) {
+		dev_err(dev, "Cannot find driver 'cdns_torrent_derived_refclk'\n");
+		return -ENOENT;
+	}
+
+	rc = device_bind(dev, cdns_torrent_derived_refclk_drv, "cdns-torrent-derived-refclk",
+			 NULL, dev_ofnode(dev), NULL);
+	if (rc)
+		dev_err(dev, "cannot bind driver for clock cdns-torrent-derived-refclk\n");
+
+	return 0;
+}
+
+static int cdns_torrent_clk_register(struct cdns_torrent_phy *cdns_phy)
+{
+	struct udevice *dev = cdns_phy->dev;
+	int ret;
+
+	ret = cdns_torrent_derived_refclk_register(cdns_phy);
+	if (ret) {
+		dev_err(dev, "failed to register derived refclk\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int cdns_torrent_phy_probe(struct udevice *dev)
 {
 	struct cdns_torrent_phy *cdns_phy = dev_get_priv(dev);
@@ -646,6 +810,10 @@ static int cdns_torrent_phy_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	ret = cdns_torrent_clk_register(cdns_phy);
+	if (ret)
+		return ret;
+
 	/* Going through all the available subnodes or children*/
 	ofnode_for_each_subnode(child, dev_ofnode(dev)) {
 		/* PHY subnode name must be a 'phy' */
-- 
2.51.2

