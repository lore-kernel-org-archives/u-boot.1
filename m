Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453C8C35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4346A81E66;
	Wed, 19 Mar 2025 04:19:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354380;
	bh=8OHDFD33ibKPnD4g1hBBrbKU8aTxAcmABz7TA7uDE7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gnmJuwexVZdPZhDg1fkbVyh8se3InH3b/lOcWm3S5Pq04QtUlBfR53HUDPcRdfHZe
	 YgN46KV4wkh9pmBXTZJ3AhEhhZRpQf+ulYYvMvPN1PM3KgzyK8R2WhPZAW9RnpDM3u
	 DW2HNZ4jyd6dm5ZlgvlSnY3lDNBaRepI4Wng6SXyIIXZAmHnS5NttL/rEpi8Pn7Rf/
	 RlbvSJr1GRTBilP6LdhIKwjOS3NRaz7w+NRXV8i1a46jEvaMuwLzeZVU+MEM6LgrM8
	 NdFxPucwtlOA918HeFI0kakDpX0jeMBOLfoR438BRrAfl0a1mQXK5lOWak4onxk948
	 VHH8fiqeF5r8A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBC5A81F00; Wed, 19 Mar 2025 04:19:36 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE6E81A0C
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="V6SQEmti"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BE305101F63AB; Wed, 19 Mar 2025 04:19:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354372; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=8OHDFD33ibKPnD4g1hBBrbKU8aTxAcmABz7TA7uDE7g=;
 b=V6SQEmtimmBnLtfCrfVFuw1UhWHFNlvsG9QRKnS2jzhbwsvGXwhBR5UJIDv98zCg+9P/rf
 jGzHvJB0DDBzlPK4QMFQN32gEpLtgJ2iBlcf/8kSNPl3fS2x97bwqVYpGlx0/aYzsb9G2+
 yHmJew+IFAGO1YagwSX1MCc0YST38xjDb9yR0MRxWyaXfiInrMeYzYDidrQPOcwUXqkmGx
 4pH4XLUMQnUkpOpA9uFMeizmafz5Reqx0NY/8La1+DzxKHR777KjTspvDovWLU8WkUYNSP
 MabxkOSGqC3VMgQhnjSJwEq08wEuApak0Eg7CxuwsiJkKZ/kAFRRwKwAK2DaBw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 17/24] clk: imx: Pass struct udevice into imx_clk_pllv3*()
Date: Wed, 19 Mar 2025 04:17:27 +0100
Message-ID: <20250319031852.233537-18-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319031852.233537-1-marex@denx.de>
References: <20250319031852.233537-1-marex@denx.de>
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

Pass struct udevice * into imx_clk_pllv3*() functions, so the
clock core would have access to parent struct udevice *.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
 drivers/clk/imx/clk-imx6q.c     | 6 +++---
 drivers/clk/imx/clk-imxrt1170.c | 6 +++---
 drivers/clk/imx/clk-pllv3.c     | 6 +++---
 drivers/clk/imx/clk.h           | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 8de8ef13c51..8d86caead9a 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -44,10 +44,10 @@ static int imx6q_clk_probe(struct udevice *dev)
 	base = (void *)ANATOP_BASE_ADDR;
 
 	clk_dm(IMX6QDL_CLK_PLL2,
-	       imx_clk_pllv3(IMX_PLLV3_GENERIC, "pll2_bus", "osc",
+	       imx_clk_pllv3(dev, IMX_PLLV3_GENERIC, "pll2_bus", "osc",
 			     base + 0x30, 0x1));
 	clk_dm(IMX6QDL_CLK_PLL3_USB_OTG,
-	       imx_clk_pllv3(IMX_PLLV3_USB, "pll3_usb_otg", "osc",
+	       imx_clk_pllv3(dev, IMX_PLLV3_USB, "pll3_usb_otg", "osc",
 			     base + 0x10, 0x3));
 	clk_dm(IMX6QDL_CLK_PLL3_60M,
 	       imx_clk_fixed_factor("pll3_60m",  "pll3_usb_otg",   1, 8));
@@ -56,7 +56,7 @@ static int imx6q_clk_probe(struct udevice *dev)
 	clk_dm(IMX6QDL_CLK_PLL2_PFD2_396M,
 	       imx_clk_pfd("pll2_pfd2_396m", "pll2_bus", base + 0x100, 2));
 	clk_dm(IMX6QDL_CLK_PLL6,
-	       imx_clk_pllv3(IMX_PLLV3_ENET, "pll6", "osc", base + 0xe0, 0x3));
+	       imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll6", "osc", base + 0xe0, 0x3));
 	clk_dm(IMX6QDL_CLK_PLL6_ENET,
 	       imx_clk_gate(dev, "pll6_enet", "pll6", base + 0xe0, 13));
 
diff --git a/drivers/clk/imx/clk-imxrt1170.c b/drivers/clk/imx/clk-imxrt1170.c
index 7e06504584f..caf34a55459 100644
--- a/drivers/clk/imx/clk-imxrt1170.c
+++ b/drivers/clk/imx/clk-imxrt1170.c
@@ -121,13 +121,13 @@ static int imxrt1170_clk_probe(struct udevice *dev)
 	       imx_clk_fixed_factor("rcosc48M_div2",  "rcosc48M", 1, 2));
 
 	clk_dm(IMXRT1170_CLK_PLL_ARM,
-	       imx_clk_pllv3(IMX_PLLV3_SYS, "pll_arm", "osc",
+	       imx_clk_pllv3(dev, IMX_PLLV3_SYS, "pll_arm", "osc",
 			     base + 0x200, 0xff));
 	clk_dm(IMXRT1170_CLK_PLL3,
-	       imx_clk_pllv3(IMX_PLLV3_GENERICV2, "pll3_sys", "osc",
+	       imx_clk_pllv3(dev, IMX_PLLV3_GENERICV2, "pll3_sys", "osc",
 			     base + 0x210, 1));
 	clk_dm(IMXRT1170_CLK_PLL2,
-	       imx_clk_pllv3(IMX_PLLV3_GENERICV2, "pll2_sys", "osc",
+	       imx_clk_pllv3(dev, IMX_PLLV3_GENERICV2, "pll2_sys", "osc",
 			     base + 0x240, 1));
 
 	clk_dm(IMXRT1170_CLK_PLL3_PFD0,
diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index c6692f2f9f5..bc9916385c8 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -281,9 +281,9 @@ static const struct clk_ops clk_pllv3_enet_ops = {
 	.get_rate	= clk_pllv3_enet_get_rate,
 };
 
-struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
-			  const char *parent_name, void __iomem *base,
-			  u32 div_mask)
+struct clk *imx_clk_pllv3(struct udevice *dev, enum imx_pllv3_type type,
+			  const char *name, const char *parent_name,
+			  void __iomem *base, u32 div_mask)
 {
 	struct clk_pllv3 *pll;
 	struct clk *clk;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 1a814d9a386..4caf3b053d4 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -83,9 +83,9 @@ struct clk *clk_register_gate2(struct udevice *dev, const char *name,
 		void __iomem *reg, u8 bit_idx, u8 cgr_val,
 		u8 clk_gate_flags, unsigned int *share_count);
 
-struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
-			  const char *parent_name, void __iomem *base,
-			  u32 div_mask);
+struct clk *imx_clk_pllv3(struct udevice *dev, enum imx_pllv3_type type,
+			  const char *name, const char *parent_name,
+			  void __iomem *base, u32 div_mask);
 
 static inline struct clk *imx_clk_gate2(struct udevice *dev, const char *name,
 					const char *parent, void __iomem *reg,
-- 
2.47.2

