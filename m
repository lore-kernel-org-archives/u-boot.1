Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7A0C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED63B826AA;
	Sun, 23 Mar 2025 17:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745735;
	bh=Q8GCK05uSsXAhMEzBtYb+mO4UEKXSuKlFSTNISo2lFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CfD3OypjQtQMtUMTFcGlaSLI1EYEfQtEUTHfV+t7venBYroO0Lxv1YXyUI6mbGGVO
	 50zybilS7MWxyXbKPP1Tpe8a3mDQ8FgJByjnc3NeNGabO4gTe/09nCVv9FFhgMYzEj
	 NKs7WDb98EB71bC/i3JiteC51olPWP4BPIU7Y0ldwIulSxshxIc33zSxBeQhEm5d3h
	 oevuAK3R0WQ+6yNl3wd1JnfedWB2kjrnp7Slojx71F42MRMbXLu/dVHaqrQq2+QNdf
	 BC2Z49g9RAUZZyENCMJVkRxsOmEk07PGTzmPKEV1RVOyi/oe0CpexIj89kYq/AzvNo
	 7tKEOi+JH/roQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B9D081DAB; Sun, 23 Mar 2025 17:02:12 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0761482145
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="JPpyC4m8"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BD7F010290251; Sun, 23 Mar 2025 17:02:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745729; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Q8GCK05uSsXAhMEzBtYb+mO4UEKXSuKlFSTNISo2lFM=;
 b=JPpyC4m810G3oFy8ewEU32BotQNfz4hANNYa40NSE1j4tyM7ppGOzobq9asxgKDaFw27gV
 lPKncn3umyrPkJ2d8tKU/6aFcMcvZ6oHOyDrCxxBppP7XIJVvpZqd1Kl00DtW3jSrzxZzr
 WHquZZuYEg1tIc996SPlUIEXLnUhmfVS4OnlwZa4tF6hOmGFENSTMRtkhWfWJSeVKU3kXE
 jSFYxl/5P8YUEnibsFe9NTeMgQh+0BNVcvTK/NY3JyQSIuR5fYhOlNgZkhwA5Db1ejFzwJ
 7hRiC6yff4jGA6EuwqZSp9swUgUcPO6dJt/WezYzdTtgNLoDpMQcRAMpb5IyMg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 17/24] clk: imx: Pass struct udevice into imx_clk_pllv3*()
Date: Sun, 23 Mar 2025 16:58:46 +0100
Message-ID: <20250323160107.145749-18-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250323160107.145749-1-marex@denx.de>
References: <20250323160107.145749-1-marex@denx.de>
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
Cc: Adam Ford <aford173@gmail.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
V2: Rebase on u-boot/next with additional clock patches
---
 drivers/clk/imx/clk-imx6q.c     | 6 +++---
 drivers/clk/imx/clk-imxrt1020.c | 4 ++--
 drivers/clk/imx/clk-imxrt1050.c | 8 ++++----
 drivers/clk/imx/clk-imxrt1170.c | 6 +++---
 drivers/clk/imx/clk-pllv3.c     | 6 +++---
 drivers/clk/imx/clk.h           | 6 +++---
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index d9eb43d82be..8327aea8950 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -46,10 +46,10 @@ static int imx6q_clk_probe(struct udevice *dev)
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
@@ -58,7 +58,7 @@ static int imx6q_clk_probe(struct udevice *dev)
 	clk_dm(IMX6QDL_CLK_PLL2_PFD2_396M,
 	       imx_clk_pfd("pll2_pfd2_396m", "pll2_bus", base + 0x100, 2));
 	clk_dm(IMX6QDL_CLK_PLL6,
-	       imx_clk_pllv3(IMX_PLLV3_ENET, "pll6", "osc", base + 0xe0, 0x3));
+	       imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll6", "osc", base + 0xe0, 0x3));
 	clk_dm(IMX6QDL_CLK_PLL6_ENET,
 	       imx_clk_gate(dev, "pll6_enet", "pll6", base + 0xe0, 13));
 
diff --git a/drivers/clk/imx/clk-imxrt1020.c b/drivers/clk/imx/clk-imxrt1020.c
index 40cba218c29..62c00ba3314 100644
--- a/drivers/clk/imx/clk-imxrt1020.c
+++ b/drivers/clk/imx/clk-imxrt1020.c
@@ -38,10 +38,10 @@ static int imxrt1020_clk_probe(struct udevice *dev)
 	base = (void *)ofnode_get_addr(ofnode_by_compatible(ofnode_null(), "fsl,imxrt-anatop"));
 
 	clk_dm(IMXRT1020_CLK_PLL2_SYS,
-	       imx_clk_pllv3(IMX_PLLV3_GENERIC, "pll2_sys", "osc",
+	       imx_clk_pllv3(dev, IMX_PLLV3_GENERIC, "pll2_sys", "osc",
 			     base + 0x30, 0x1));
 	clk_dm(IMXRT1020_CLK_PLL3_USB_OTG,
-	       imx_clk_pllv3(IMX_PLLV3_USB, "pll3_usb_otg", "osc",
+	       imx_clk_pllv3(dev, IMX_PLLV3_USB, "pll3_usb_otg", "osc",
 			     base + 0x10, 0x1));
 
 	/* PLL bypass out */
diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
index 71d5fa8a90e..02f7b05da5f 100644
--- a/drivers/clk/imx/clk-imxrt1050.c
+++ b/drivers/clk/imx/clk-imxrt1050.c
@@ -49,17 +49,17 @@ static int imxrt1050_clk_probe(struct udevice *dev)
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 
 	clk_dm(IMXRT1050_CLK_PLL1_ARM,
-	       imx_clk_pllv3(IMX_PLLV3_SYS, "pll1_arm", "pll1_arm_ref_sel",
+	       imx_clk_pllv3(dev, IMX_PLLV3_SYS, "pll1_arm", "pll1_arm_ref_sel",
 			     base + 0x0, 0x7f));
 	clk_dm(IMXRT1050_CLK_PLL2_SYS,
-	       imx_clk_pllv3(IMX_PLLV3_GENERIC, "pll2_sys", "pll2_sys_ref_sel",
+	       imx_clk_pllv3(dev, IMX_PLLV3_GENERIC, "pll2_sys", "pll2_sys_ref_sel",
 			     base + 0x30, 0x1));
 	clk_dm(IMXRT1050_CLK_PLL3_USB_OTG,
-	       imx_clk_pllv3(IMX_PLLV3_USB, "pll3_usb_otg",
+	       imx_clk_pllv3(dev, IMX_PLLV3_USB, "pll3_usb_otg",
 			     "pll3_usb_otg_ref_sel",
 			     base + 0x10, 0x1));
 	clk_dm(IMXRT1050_CLK_PLL5_VIDEO,
-	       imx_clk_pllv3(IMX_PLLV3_AV, "pll5_video", "pll5_video_ref_sel",
+	       imx_clk_pllv3(dev, IMX_PLLV3_AV, "pll5_video", "pll5_video_ref_sel",
 			     base + 0xa0, 0x7f));
 
 	/* PLL bypass out */
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

