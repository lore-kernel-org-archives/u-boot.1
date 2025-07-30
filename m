Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D878C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 23:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A90A83280;
	Thu, 31 Jul 2025 01:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="g34Bqh4H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 305128323A; Thu, 31 Jul 2025 01:54:11 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F01C8319C
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 01:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5dd1=2M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753919640; bh=KSENZmgbFGAVXSsrlyJXu0o4dxWMH0K+YE/GlhppZbM=;
 b=g34Bqh4HuQp3a6Rjz2SHvJoEU9DSXVEHJsS6s8uqv/SH2UFx0n6z58O2NTDcYS6mBNp5uMUhN
 pawF72Oqw2sDXCKfFdrf/fI4/wnlA4I5DAvd3k/V9ShBNDmi8tNkVDuFJwOJyJHVXlR0eninSfT
 uywxdzBkoX1FngwuNLXt2BInfTyXZCaJSBBooIZlljCdKqkVildPStM0eCNQvyxNa1t+fEO6BCi
 9/+sD6EwGAamcYKcIAlXQkLU+2KOx5TgZ7NpDocTAoJcGpHJ+tWw7ZT94vuU/qzK3yvy5XvoCup
 M3OzS6A9RqF/rlIFBFql8Hl27pakmpIgZAjxo0od6n9Q==
X-Forward-Email-ID: 688ab07b1851584377f6218e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Jianwei Zheng <jianwei.zheng@rock-chips.com>
Subject: [PATCH 7/8] phy: rockchip: naneng-combphy: Add support for RK3528
Date: Wed, 30 Jul 2025 23:52:48 +0000
Message-ID: <20250730235301.1774089-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730235301.1774089-1-jonas@kwiboo.se>
References: <20250730235301.1774089-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Jianwei Zheng <jianwei.zheng@rock-chips.com>

Add support for the PCIe/USB3 combo PHY used in the RK3528 SoC.

Config values are taken from vendor U-Boot linux-6.1-stan-rkr5 tag.

Signed-off-by: Jianwei Zheng <jianwei.zheng@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../rockchip/phy-rockchip-naneng-combphy.c    | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 81195de60bc6..432a8f8e03a0 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -37,6 +37,7 @@ struct rockchip_combphy_grfcfg {
 	struct combphy_reg pipe_rxterm_set;
 	struct combphy_reg pipe_txelec_set;
 	struct combphy_reg pipe_txcomp_set;
+	struct combphy_reg pipe_clk_24m;
 	struct combphy_reg pipe_clk_25m;
 	struct combphy_reg pipe_clk_100m;
 	struct combphy_reg pipe_phymode_sel;
@@ -245,6 +246,103 @@ static int rockchip_combphy_probe(struct udevice *udev)
 	return rockchip_combphy_parse_dt(udev, priv);
 }
 
+static int rk3528_combphy_cfg(struct rockchip_combphy_priv *priv)
+{
+	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
+	u32 val;
+
+	switch (priv->mode) {
+	case PHY_TYPE_PCIE:
+		/* Set SSC downward spread spectrum */
+		val = readl(priv->mmio + 0x18);
+		val &= ~GENMASK(5, 4);
+		val |= 0x01 << 4;
+		writel(val, priv->mmio + 0x18);
+
+		param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
+		param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
+		param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
+		param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
+		break;
+	case PHY_TYPE_USB3:
+		/* Set SSC downward spread spectrum */
+		val = readl(priv->mmio + 0x18);
+		val &= ~GENMASK(5, 4);
+		val |= 0x01 << 4;
+		writel(val, priv->mmio + 0x18);
+
+		/* Enable adaptive CTLE for USB3.0 Rx */
+		val = readl(priv->mmio + 0x200);
+		val &= ~GENMASK(17, 17);
+		val |= 0x01 << 17;
+		writel(val, priv->mmio + 0x200);
+
+		/* Set Rx squelch input filler bandwidth */
+		val = readl(priv->mmio + 0x20c);
+		val &= ~GENMASK(2, 0);
+		val |= 0x06;
+		writel(val, priv->mmio + 0x20c);
+
+		param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
+		param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
+		param_write(priv->phy_grf, &cfg->usb_mode_set, true);
+		param_write(priv->pipe_grf, &cfg->u3otg0_port_en, true);
+		break;
+	default:
+		dev_err(priv->dev, "incompatible PHY type\n");
+		return -EINVAL;
+	}
+
+	param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
+
+	if (priv->mode == PHY_TYPE_PCIE) {
+		/* PLL KVCO tuning fine */
+		val = readl(priv->mmio + 0x18);
+		val &= ~(0x7 << 10);
+		val |= 0x2 << 10;
+		writel(val, priv->mmio + 0x18);
+
+		/* su_trim[6:4]=111, [10:7]=1001, [2:0]=000 */
+		val = readl(priv->mmio + 0x108);
+		val &= ~(0x7f7);
+		val |= 0x4f0;
+		writel(val, priv->mmio + 0x108);
+	}
+
+	return 0;
+}
+
+static const struct rockchip_combphy_grfcfg rk3528_combphy_grfcfgs = {
+	/* pipe-phy-grf */
+	.pcie_mode_set		= { 0x0000, 5, 0, 0x00, 0x11 },
+	.usb_mode_set		= { 0x0000, 5, 0, 0x00, 0x04 },
+	.pipe_rxterm_set	= { 0x0000, 12, 12, 0x00, 0x01 },
+	.pipe_txelec_set	= { 0x0004, 1, 1, 0x00, 0x01 },
+	.pipe_txcomp_set	= { 0x0004, 4, 4, 0x00, 0x01 },
+	.pipe_clk_24m		= { 0x0004, 14, 13, 0x00, 0x00 },
+	.pipe_clk_100m		= { 0x0004, 14, 13, 0x00, 0x02 },
+	.pipe_rxterm_sel	= { 0x0008, 8, 8, 0x00, 0x01 },
+	.pipe_txelec_sel	= { 0x0008, 12, 12, 0x00, 0x01 },
+	.pipe_txcomp_sel	= { 0x0008, 15, 15, 0x00, 0x01 },
+	.pipe_clk_ext		= { 0x000c, 9, 8, 0x02, 0x01 },
+	.pipe_phy_status	= { 0x0034, 6, 6, 0x01, 0x00 },
+	.con0_for_pcie		= { 0x0000, 15, 0, 0x00, 0x110 },
+	.con1_for_pcie		= { 0x0004, 15, 0, 0x00, 0x00 },
+	.con2_for_pcie		= { 0x0008, 15, 0, 0x00, 0x101 },
+	.con3_for_pcie		= { 0x000c, 15, 0, 0x00, 0x0200 },
+	/* pipe-grf */
+	.u3otg0_port_en		= { 0x0044, 15, 0, 0x0181, 0x1100 },
+};
+
+static const struct rockchip_combphy_cfg rk3528_combphy_cfgs = {
+	.num_phys = 1,
+	.phy_ids = {
+		0xffdc0000,
+	},
+	.grfcfg		= &rk3528_combphy_grfcfgs,
+	.combphy_cfg	= rk3528_combphy_cfg,
+};
+
 static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 {
 	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
@@ -503,6 +601,10 @@ static const struct rockchip_combphy_cfg rk3588_combphy_cfgs = {
 };
 
 static const struct udevice_id rockchip_combphy_ids[] = {
+	{
+		.compatible = "rockchip,rk3528-naneng-combphy",
+		.data = (ulong)&rk3528_combphy_cfgs
+	},
 	{
 		.compatible = "rockchip,rk3568-naneng-combphy",
 		.data = (ulong)&rk3568_combphy_cfgs
-- 
2.50.1

