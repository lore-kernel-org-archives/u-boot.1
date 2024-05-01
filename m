Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE6AC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 16:23:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F28AC88B65;
	Wed,  1 May 2024 18:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="N/GCsrC/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED7288B61; Wed,  1 May 2024 18:23:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C58E88B15
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 18:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=373c=MF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714580606; bh=ROYwfsnkasCz5CNZ4bnayarCc3ao4ChMdhGfKNKvmgA=;
 b=N/GCsrC/y0+y3HOgTRvgndSrnRmp2Uol8bV12n7zL86VvW4CQrHPEvCPj2MGNFtV+aGwFKytF
 rKztJH/xnK6CHe9p9AxIjEenjXtJwGzQVoT6+A5vxx3Do+wSpHmISc8azunSdXQjQhPup1cS8TV
 qYcKOh5kmMLNeXWGMgnRL5L934VaBBsVmiU0pAX3Z1AIBVijTg8NtKaFTwmagxD1+d8tMdugSNE
 BFKQz19J5qcT2mEDSUW16/w1kmOyEyBBg+75JlQ5Ti2AfYcPiF9K46JINVjhuR9GVEh655WwPIE
 MX+DEw/Hhq+MTLmCMy5xAT6RP4bJ+FrEVdRcaoL5TNaw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, Christopher Obbard <chris.obbard@collabora.com>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 03/22] clk: rockchip: rk3399: Improve support for
 SCLK_PCIEPHY_REF clock
Date: Wed,  1 May 2024 16:22:20 +0000
Message-ID: <20240501162308.875193-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240501162308.875193-1-jonas@kwiboo.se>
References: <20240501162308.875193-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66326c7d3e72fadc559db9bf
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

rk3399-nanopi-4.dtsi try to set parent of and set rate to 100 MHz of the
SCLK_PCIEPHY_REF clock.

The existing enable/disable ops for SCLK_PCIEPHY_REF currently force
use of 24 MHz parent and rate.

Add improved support for setting parent and rate of the pciephy refclk
to driver to better support assign-clock props for pciephy refclk in DT.

This limited implementation only support setting 24 or 100 MHz rate,
and expect npll and clk_pciephy_ref100m divider to use default values.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Implement partial instead of dummy support for SCLK_PCIEPHY_REF
---
 drivers/clk/rockchip/clk_rk3399.c | 59 +++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index 5934771b4096..0b3223611a32 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -926,6 +926,26 @@ static ulong rk3399_saradc_set_clk(struct rockchip_cru *cru, uint hz)
 	return rk3399_saradc_get_clk(cru);
 }
 
+static ulong rk3399_pciephy_get_clk(struct rockchip_cru *cru)
+{
+	if (readl(&cru->clksel_con[18]) & BIT(10))
+		return 100 * MHz;
+	else
+		return OSC_HZ;
+}
+
+static ulong rk3399_pciephy_set_clk(struct rockchip_cru *cru, uint hz)
+{
+	if (hz == 100 * MHz)
+		rk_setreg(&cru->clksel_con[18], BIT(10));
+	else if (hz == OSC_HZ)
+		rk_clrreg(&cru->clksel_con[18], BIT(10));
+	else
+		return -EINVAL;
+
+	return rk3399_pciephy_get_clk(cru);
+}
+
 static ulong rk3399_clk_get_rate(struct clk *clk)
 {
 	struct rk3399_clk_priv *priv = dev_get_priv(clk->dev);
@@ -967,6 +987,9 @@ static ulong rk3399_clk_get_rate(struct clk *clk)
 	case SCLK_SARADC:
 		rate = rk3399_saradc_get_clk(priv->cru);
 		break;
+	case SCLK_PCIEPHY_REF:
+		rate = rk3399_pciephy_get_clk(priv->cru);
+		break;
 	case ACLK_VIO:
 	case ACLK_HDCP:
 	case ACLK_GIC_PRE:
@@ -1058,6 +1081,9 @@ static ulong rk3399_clk_set_rate(struct clk *clk, ulong rate)
 	case SCLK_SARADC:
 		ret = rk3399_saradc_set_clk(priv->cru, rate);
 		break;
+	case SCLK_PCIEPHY_REF:
+		ret = rk3399_pciephy_set_clk(priv->cru, rate);
+		break;
 	case ACLK_VIO:
 	case ACLK_HDCP:
 	case ACLK_GIC_PRE:
@@ -1108,12 +1134,39 @@ static int __maybe_unused rk3399_gmac_set_parent(struct clk *clk,
 	return -EINVAL;
 }
 
+static int __maybe_unused rk3399_pciephy_set_parent(struct clk *clk,
+						    struct clk *parent)
+{
+	struct rk3399_clk_priv *priv = dev_get_priv(clk->dev);
+	const char *clock_output_name;
+	int ret;
+
+	if (parent->dev == clk->dev && parent->id == SCLK_PCIEPHY_REF100M) {
+		rk_setreg(&priv->cru->clksel_con[18], BIT(10));
+		return 0;
+	}
+
+	ret = dev_read_string_index(parent->dev, "clock-output-names",
+				    parent->id, &clock_output_name);
+	if (ret < 0)
+		return -ENODATA;
+
+	if (!strcmp(clock_output_name, "xin24m")) {
+		rk_clrreg(&priv->cru->clksel_con[18], BIT(10));
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int __maybe_unused rk3399_clk_set_parent(struct clk *clk,
 						struct clk *parent)
 {
 	switch (clk->id) {
 	case SCLK_RMII_SRC:
 		return rk3399_gmac_set_parent(clk, parent);
+	case SCLK_PCIEPHY_REF:
+		return rk3399_pciephy_set_parent(clk, parent);
 	}
 
 	debug("%s: unsupported clk %ld\n", __func__, clk->id);
@@ -1204,7 +1257,8 @@ static int rk3399_clk_enable(struct clk *clk)
 		rk_clrreg(&priv->cru->clkgate_con[13], BIT(7));
 		break;
 	case SCLK_PCIEPHY_REF:
-		rk_clrreg(&priv->cru->clksel_con[18], BIT(10));
+		if (readl(&priv->cru->clksel_con[18]) & BIT(10))
+			rk_clrreg(&priv->cru->clkgate_con[12], BIT(6));
 		break;
 	default:
 		debug("%s: unsupported clk %ld\n", __func__, clk->id);
@@ -1298,7 +1352,8 @@ static int rk3399_clk_disable(struct clk *clk)
 		rk_setreg(&priv->cru->clkgate_con[13], BIT(7));
 		break;
 	case SCLK_PCIEPHY_REF:
-		rk_clrreg(&priv->cru->clksel_con[18], BIT(10));
+		if (readl(&priv->cru->clksel_con[18]) & BIT(10))
+			rk_setreg(&priv->cru->clkgate_con[12], BIT(6));
 		break;
 	default:
 		debug("%s: unsupported clk %ld\n", __func__, clk->id);
-- 
2.43.2

