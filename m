Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49DAC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 20:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDEA088971;
	Tue, 16 Jul 2024 22:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mail.de header.i=@mail.de header.b="w3TrKTEr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A1E588A07; Tue, 16 Jul 2024 22:45:32 +0200 (CEST)
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17AB48875A
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 22:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=seb-dev@mail.de
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
 by shout02.mail.de (Postfix) with ESMTP id BC96F240F0F;
 Tue, 16 Jul 2024 22:45:29 +0200 (CEST)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
 by postfix02.mail.de (Postfix) with ESMTP id 9A942A00E2;
 Tue, 16 Jul 2024 22:45:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
 s=mailde202009; t=1721162729;
 bh=nLYc2xn77t16OWaVgcfinv2nQfPT79HURvJfcSdvQts=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
 b=w3TrKTEr0u+uVfB1golwgbStP7d8w0e+5+MUQZYotnJH4nPwUcGWYUvoVjuBvdkrE
 ryWxYsAHNZurgG0R8hNaM+7U17yJ3u1XmDRugTqyY7UIn/NrFsAeC3sjXYjN/yhREJ
 b0WEoRo2NLdSVxFd9h5zC9L++ha+FkrGESF2y18rTuiN12DKR/Qq8hNEF7eVNxRMuw
 SdzqZYm8Ze9OVgGG97iCoA5xHqNQlI33w89rPU1uTTSPTUwnQM6TjpIi3npqvakurq
 xfqMPHlSK+4sxqcu4y3x3WiZwN86sIiaxh+BopPVyizeoy/1FnA/u1z8W0EKa8cZsu
 QdF/cxBxqjQpg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp01.mail.de (Postfix) with ESMTPSA id 3F84A240A08;
 Tue, 16 Jul 2024 22:45:29 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/5] phy: rockchip: naneng-combphy: Introduce PHY-IDs to
 fix RK3588 muxing
Date: Tue, 16 Jul 2024 22:42:07 +0200
Message-ID: <ed6198ccb2635f0e950e3c21fa8898216bf949fa.1721161722.git.seb-dev@mail.de>
In-Reply-To: <cover.1721161722.git.seb-dev@mail.de>
References: <cover.1721161722.git.seb-dev@mail.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 3892
X-purgate-ID: 154282::1721162729-45DBE670-286AB513/0/0
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

Fix multiplex configuration for PCIe1L0 and PCIe1L1 in PCIESEL_CON for
RK3588 to correctly select between Combo PHYs and PCIe3 PHY.
Currently, the code incorrectly muxes both ports to Combo PHYs,
interfering with PCIe3 PHY settings.
Introduce PHY identifiers to identify the correct Combo PHY and set
the necessary bits accordingly.

This fix is adapted from the upstream Linux commit by Sebastian Reichel:
d16d4002fea6 ("phy: rockchip: naneng-combphy: Fix mux on rk3588")

Fixes: b37260bca1aa ("phy: rockchip: naneng-combphy: Use signal from comb PHY on RK3588")
Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
---
 .../rockchip/phy-rockchip-naneng-combphy.c    | 49 ++++++++++++++++++-
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 1b85cbcce8..7d61913af1 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -67,12 +67,15 @@ struct rockchip_combphy_grfcfg {
 };
 
 struct rockchip_combphy_cfg {
+	unsigned int num_phys;
+	unsigned int phy_ids[3];
 	const struct rockchip_combphy_grfcfg *grfcfg;
 	int (*combphy_cfg)(struct rockchip_combphy_priv *priv);
 };
 
 struct rockchip_combphy_priv {
 	u32 mode;
+	int id;
 	void __iomem *mmio;
 	struct udevice *dev;
 	struct regmap *pipe_grf;
@@ -270,6 +273,8 @@ static int rockchip_combphy_probe(struct udevice *udev)
 {
 	struct rockchip_combphy_priv *priv = dev_get_priv(udev);
 	const struct rockchip_combphy_cfg *phy_cfg;
+	fdt_addr_t addr;
+	int id;
 
 	priv->mmio = (void __iomem *)dev_read_addr(udev);
 	if (IS_ERR(priv->mmio))
@@ -281,6 +286,26 @@ static int rockchip_combphy_probe(struct udevice *udev)
 		return -EINVAL;
 	}
 
+	addr = dev_read_addr(udev);
+	if (addr == FDT_ADDR_T_NONE) {
+		dev_err(udev, "No valid device address found\n");
+		return -EINVAL;
+	}
+
+	/* Find the phy-id based on the device's I/O-address */
+	priv->id = -ENODEV;
+	for (id = 0; id < phy_cfg->num_phys; id++) {
+		if (addr == phy_cfg->phy_ids[id]) {
+			priv->id = id;
+			break;
+		}
+	}
+
+	if (priv->id == -ENODEV) {
+		dev_err(udev, "Failed to find PHY ID\n");
+		return -ENODEV;
+	}
+
 	priv->dev = udev;
 	priv->mode = PHY_TYPE_SATA;
 	priv->cfg = phy_cfg;
@@ -421,6 +446,12 @@ static const struct rockchip_combphy_grfcfg rk3568_combphy_grfcfgs = {
 };
 
 static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
+	.num_phys = 3,
+	.phy_ids = {
+		0xfe820000,
+		0xfe830000,
+		0xfe840000,
+	},
 	.grfcfg		= &rk3568_combphy_grfcfgs,
 	.combphy_cfg	= rk3568_combphy_cfg,
 };
@@ -436,8 +467,16 @@ static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
 		param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
 		param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
 		param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
-		param_write(priv->pipe_grf, &cfg->pipe_pcie1l0_sel, true);
-		param_write(priv->pipe_grf, &cfg->pipe_pcie1l1_sel, true);
+		switch (priv->id) {
+		case 1:
+			printf("rk3588_combphy_cfg: priv->id was configured to 1");
+			param_write(priv->pipe_grf, &cfg->pipe_pcie1l0_sel, true);
+			break;
+		case 2:
+			printf("rk3588_combphy_cfg: priv->id was configured to 2");
+			param_write(priv->pipe_grf, &cfg->pipe_pcie1l1_sel, true);
+			break;
+		}
 		break;
 	case PHY_TYPE_USB3:
 		param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
@@ -515,6 +554,12 @@ static const struct rockchip_combphy_grfcfg rk3588_combphy_grfcfgs = {
 };
 
 static const struct rockchip_combphy_cfg rk3588_combphy_cfgs = {
+	.num_phys = 3,
+	.phy_ids = {
+		0xfee00000,
+		0xfee10000,
+		0xfee20000,
+	},
 	.grfcfg		= &rk3588_combphy_grfcfgs,
 	.combphy_cfg	= rk3588_combphy_cfg,
 };
-- 
2.43.0

