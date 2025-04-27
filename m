Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF12AC369D1
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 15:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1734780FDE;
	Sun, 27 Apr 2025 17:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745768421;
	bh=WT69d/JJt4q0wAOZ6nJwhfk3Ft8MYXr/EbaSi/f4aus=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XvTpbTL1jn1qpUBXDojBWQf1T1ouKvGAhtMCr05xGWVXybL0LOHtT4sWy//2VHLoG
	 9Gi50ZzJl8+7QF0u/KmlncE4HI2EHENtVxiyDe4wfB+A+sscbnlrC+rbojTuM81xtj
	 sZb0MHI7aL7cxBWG+WnMfzazcpCj3WuzQHtdM0v8B1zok7dwINOitpA+xwgWHcz43z
	 qmyD5Ugzxv14eMd6ItLUeOWzClKaoWzSemM8QlcNzGBJQadWzVjo96apmMRslLMXb5
	 RPiKy+++WstCtmjF/Kw0zMOebGeBlwFVbGKq2iXwDUm8OVt9NfOFVyfewB4wKIeJll
	 CSKJ83Nr2YKHg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC84B81E0F; Sun, 27 Apr 2025 17:40:19 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B956780FDA
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 17:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="PngtYU2P"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6C605102A8CA4; 
 Sun, 27 Apr 2025 17:40:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745768416; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=WT69d/JJt4q0wAOZ6nJwhfk3Ft8MYXr/EbaSi/f4aus=;
 b=PngtYU2PWmPGv4+UY0lelKycaHJmGazXlf+SzGUdYpP103fg22ZzoYv+c9/9TCaeZiG83J
 WBK15n7YOagHZ4ZLdpqvpt/YBaSiYKDY4zIWzTfTKuyn2+YSWBeFJq/tpVoaxCCj6FMtMi
 q1JagSrGNUUrn57tRPrQ7W4xqRLZSKq6QilyXci0G7P+4LVdmc8/IaN4PT6bEyPmYv6wna
 aP4xeJcdPdtXFrjW4dWQNBBFW1o7Yb+ApyqFCB7ugtUskWld2655+4IOhKQ2pW1JZUjD1+
 B5OcZ7TfaJo70XwoZgp2CZarzNQze322CFsPunM2HPp8cL8VJdLcTgLcaTQj+w==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] clk: imx: Pass CCM udevice into clk_register_composite()
Date: Sun, 27 Apr 2025 17:39:34 +0200
Message-ID: <20250427154002.146276-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Pass the clock controller udevice into clk_register_composite(),
so it can be passed further to any registered composite clocks
and used for look up of parent clock referenced in DT "clocks"
and "clock-names" properties by phandle and name pair.

Use the clock controller udevice in imx8m_clk_mux_set_parent()
to perform accurate look up of parent clock referenced in the
CCM driver by name. If the clock name that is being looked up
matches one of the names listed in the clock controller DT node
"clock-names" array property, then the offset of the name is
looked up in the "clocks" DT property and the phandle at that
offset is resolved to the parent clock udevice. The test to
determine whether a particular driver instance registered with
clock uclass matches the parent clock is done by comparing the
OF nodes of the clock registered with clock uclass and parent
clock resolved from the phandle.

Example:

drivers/clk/imx/clk-imx8mm.c:
static const char * const imx8mm_a53_sels[] = {"osc_24m", "arm_pll_out", ...
                                      _____________|
arch/arm/dts/imx8mm.dtsi:            |
clk: clock-controller@30380000 {     v
        clock-names = "osc_32k", "osc_24m", ...
	                           |
				   v
        clocks = <&osc_32k>, <&osc_24m>, ...
};          _______________________|
...        |
/ {        v
        osc_24m: clock-osc-24m {
                compatible = "fixed-clock";
...
};

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/clk/clk-composite.c        |  2 ++
 drivers/clk/imx/clk-composite-8m.c | 30 +++++++++++++++++++++++++++++-
 include/linux/clk-provider.h       |  2 ++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 9e3b5191767..207224b1320 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -155,6 +155,8 @@ struct clk *clk_register_composite(struct udevice *dev, const char *name,
 		goto err;
 	}
 
+	composite->dev = dev;
+
 	if (composite->mux)
 		composite->mux->dev = clk->dev;
 	if (composite->rate)
diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 14c5b92939c..e1a3c0af308 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -116,14 +116,42 @@ static const struct clk_ops imx8m_clk_composite_divider_ops = {
 	.set_rate = imx8m_clk_composite_divider_set_rate,
 };
 
+static int imx8m_clk_mux_fetch_parent_index(struct udevice *cdev, struct clk *clk, struct clk *parent)
+{
+	struct clk_mux *mux = to_clk_mux(clk);
+	struct clk cclk;
+	int ret;
+	int i;
+
+	if (!parent)
+		return -EINVAL;
+
+	for (i = 0; i < mux->num_parents; i++) {
+		ret = clk_get_by_name(cdev, mux->parent_names[i], &cclk);
+		if (!ret && ofnode_equal(dev_ofnode(parent->dev), dev_ofnode(cclk.dev)))
+			return i;
+
+		if (!strcmp(parent->dev->name, mux->parent_names[i]))
+			return i;
+		if (!strcmp(parent->dev->name,
+			    clk_resolve_parent_clk(clk->dev,
+						   mux->parent_names[i])))
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+
 static int imx8m_clk_mux_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct clk_mux *mux = to_clk_mux(clk);
+	struct clk_composite *composite = (struct clk_composite *)clk->data;
 	int index;
 	u32 val;
 	u32 reg;
 
-	index = clk_mux_fetch_parent_index(clk, parent);
+	index = imx8m_clk_mux_fetch_parent_index(composite->dev, clk, parent);
 	if (index < 0) {
 		log_err("Could not fetch index\n");
 		return index;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 5ea2171492e..267757939e0 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -219,6 +219,8 @@ struct clk_composite {
 	const struct clk_ops	*mux_ops;
 	const struct clk_ops	*rate_ops;
 	const struct clk_ops	*gate_ops;
+
+	struct udevice *dev;
 };
 
 #define to_clk_composite(_clk) container_of(_clk, struct clk_composite, clk)
-- 
2.47.2

