Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D176CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D4218386D;
	Fri, 17 Oct 2025 17:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Qa9qkWRC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E67648382E; Fri, 17 Oct 2025 17:21:58 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F110A8051F
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id B468B26173;
 Fri, 17 Oct 2025 17:21:56 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aXJgnrXRjOmf; Fri, 17 Oct 2025 17:21:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714516; bh=U4T0m4xxoCsFvAk7okjn13OBh0H/GFkPw44v1Ykl3TI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Qa9qkWRCO1Y5rgbAEXrz4xTkmmhfVaDFPAVdu04eKGXwsY3eu4mdxXjtbC0NVoEL1
 2AG4fboBo31R2asWjqjKLmxFz2fQYJproBZRmI9TrtKiyOS0m/t+sv4LojkDcUtBda
 oN46R5GAlnwN627IqZW12K2ArSceKJ0iYBcsM/C0c6wARet19mr2JRqDnESbF5pZ1Q
 vYs9mt0hOiBrJQ1NiTGgAuxdQUbCVpdkRzXDAVzhm83lqNBxjL72kuKzihyWTpyvah
 rzznIOs2L9iIONc3a8Pd/bfEBKIPoDADDzd9eNXComery+ICZGWFt5XOi/FpMDm1Pc
 lQQt29BmzNLBA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:51:29 +0530
Subject: [PATCH 1/6] clk: exynos: provide device pointer to clk_register_*
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-clk-exynos7870-v1-1-83f90d425699@disroot.org>
References: <20251017-clk-exynos7870-v1-0-83f90d425699@disroot.org>
In-Reply-To: <20251017-clk-exynos7870-v1-0-83f90d425699@disroot.org>
To: u-boot@lists.denx.de
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Ye Li <ye.li@nxp.com>, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714499; l=6015;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=U4T0m4xxoCsFvAk7okjn13OBh0H/GFkPw44v1Ykl3TI=;
 b=9HOiTu/ayOQpkwfArfLbrRo41f5lM/0DsQIEw2BGEDSJ8itDLULcpLgafqnHHKU+jbyz9Eaky
 qkmXi8Lt+T0D74kuOq1pKE0F1OyE59gEkpivCfnFmZYI4ZBvzzInCED
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:22:22 +0200
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

The device pointer set as NULL causes problems when clock banks depend
on clocks from another clock bank. In such case, the appropriate clock
needs to be resolved from OF phandle arguments, which is not possible if
the associated device is not provided. Make necessary changes to make
the correct device pointer available.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/clk/exynos/clk-pll.c |  3 ++-
 drivers/clk/exynos/clk-pll.h |  3 ++-
 drivers/clk/exynos/clk.c     | 43 ++++++++++++++++++++++++-------------------
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/exynos/clk-pll.c b/drivers/clk/exynos/clk-pll.c
index 542d577eaa6f667ba4fb31590eee01b034b22007..fc7e638134a9529edac644d1dfff173adc3e1c5d 100644
--- a/drivers/clk/exynos/clk-pll.c
+++ b/drivers/clk/exynos/clk-pll.c
@@ -136,7 +136,8 @@ static struct clk *_samsung_clk_register_pll(void __iomem *base,
 	return clk;
 }
 
-void samsung_clk_register_pll(void __iomem *base, unsigned int cmu_id,
+void samsung_clk_register_pll(struct udevice *dev, void __iomem *base,
+			      unsigned int cmu_id,
 			      const struct samsung_pll_clock *clk_list,
 			      unsigned int nr_clk)
 {
diff --git a/drivers/clk/exynos/clk-pll.h b/drivers/clk/exynos/clk-pll.h
index bdc94e7624d21a5da95282f686354da0fc771826..22cc15a40a4f8933d0e79da864f4f50b732c86a4 100644
--- a/drivers/clk/exynos/clk-pll.h
+++ b/drivers/clk/exynos/clk-pll.h
@@ -22,7 +22,8 @@ enum samsung_pll_type {
 	pll_0831x,
 };
 
-void samsung_clk_register_pll(void __iomem *base, unsigned int cmu_id,
+void samsung_clk_register_pll(struct udevice *dev, void __iomem *base,
+			      unsigned int cmu_id,
 			      const struct samsung_pll_clock *clk_list,
 			      unsigned int nr_clk);
 
diff --git a/drivers/clk/exynos/clk.c b/drivers/clk/exynos/clk.c
index 943e8bd0189236f4e6035aaf2ac612075a7ee126..2f5a3de65631dfba1b69c4e877cb54ec254a5399 100644
--- a/drivers/clk/exynos/clk.c
+++ b/drivers/clk/exynos/clk.c
@@ -10,7 +10,8 @@
 #include <dm.h>
 #include "clk.h"
 
-static void samsung_clk_register_mux(void __iomem *base, unsigned int cmu_id,
+static void samsung_clk_register_mux(struct udevice *dev, void __iomem *base,
+				     unsigned int cmu_id,
 				     const struct samsung_mux_clock *clk_list,
 				     unsigned int nr_clk)
 {
@@ -22,15 +23,17 @@ static void samsung_clk_register_mux(void __iomem *base, unsigned int cmu_id,
 		unsigned long clk_id;
 
 		m = &clk_list[cnt];
-		clk = clk_register_mux(NULL, m->name, m->parent_names,
-			m->num_parents, m->flags, base + m->offset, m->shift,
-			m->width, m->mux_flags);
+		clk = clk_register_mux(dev, m->name, m->parent_names,
+				       m->num_parents, m->flags,
+				       base + m->offset, m->shift, m->width,
+				       m->mux_flags);
 		clk_id = SAMSUNG_TO_CLK_ID(cmu_id, m->id);
 		clk_dm(clk_id, clk);
 	}
 }
 
-static void samsung_clk_register_div(void __iomem *base, unsigned int cmu_id,
+static void samsung_clk_register_div(struct udevice *dev, void __iomem *base,
+				     unsigned int cmu_id,
 				     const struct samsung_div_clock *clk_list,
 				     unsigned int nr_clk)
 {
@@ -42,15 +45,16 @@ static void samsung_clk_register_div(void __iomem *base, unsigned int cmu_id,
 		unsigned long clk_id;
 
 		d = &clk_list[cnt];
-		clk = clk_register_divider(NULL, d->name, d->parent_name,
-			d->flags, base + d->offset, d->shift,
-			d->width, d->div_flags);
+		clk = clk_register_divider(dev, d->name, d->parent_name,
+					   d->flags, base + d->offset, d->shift,
+					   d->width, d->div_flags);
 		clk_id = SAMSUNG_TO_CLK_ID(cmu_id, d->id);
 		clk_dm(clk_id, clk);
 	}
 }
 
-static void samsung_clk_register_gate(void __iomem *base, unsigned int cmu_id,
+static void samsung_clk_register_gate(struct udevice *dev, void __iomem *base,
+				      unsigned int cmu_id,
 				      const struct samsung_gate_clock *clk_list,
 				      unsigned int nr_clk)
 {
@@ -62,16 +66,16 @@ static void samsung_clk_register_gate(void __iomem *base, unsigned int cmu_id,
 		unsigned long clk_id;
 
 		g = &clk_list[cnt];
-		clk = clk_register_gate(NULL, g->name, g->parent_name,
-			g->flags, base + g->offset, g->bit_idx,
-			g->gate_flags, NULL);
+		clk = clk_register_gate(dev, g->name, g->parent_name,
+					g->flags, base + g->offset, g->bit_idx,
+					g->gate_flags, NULL);
 		clk_id = SAMSUNG_TO_CLK_ID(cmu_id, g->id);
 		clk_dm(clk_id, clk);
 	}
 }
 
-typedef void (*samsung_clk_register_fn)(void __iomem *base, unsigned int cmu_id,
-					const void *clk_list,
+typedef void (*samsung_clk_register_fn)(struct udevice *dev, void __iomem *base,
+					unsigned int cmu_id, const void *clk_list,
 					unsigned int nr_clk);
 
 static const samsung_clk_register_fn samsung_clk_register_fns[] = {
@@ -91,16 +95,17 @@ static const samsung_clk_register_fn samsung_clk_register_fns[] = {
  * Having the array of clock groups @clk_groups makes it possible to keep a
  * correct clocks registration order.
  */
-static void samsung_cmu_register_clocks(void __iomem *base, unsigned int cmu_id,
-				const struct samsung_clk_group *clk_groups,
-				unsigned int nr_groups)
+static void samsung_cmu_register_clocks(struct udevice *dev, void __iomem *base,
+					unsigned int cmu_id,
+					const struct samsung_clk_group *clk_groups,
+					unsigned int nr_groups)
 {
 	unsigned int i;
 
 	for (i = 0; i < nr_groups; i++) {
 		const struct samsung_clk_group *g = &clk_groups[i];
 
-		samsung_clk_register_fns[g->type](base, cmu_id,
+		samsung_clk_register_fns[g->type](dev, base, cmu_id,
 						  g->clk_list, g->nr_clk);
 	}
 }
@@ -124,7 +129,7 @@ int samsung_cmu_register_one(struct udevice *dev, unsigned int cmu_id,
 	if (!base)
 		return -EINVAL;
 
-	samsung_cmu_register_clocks(base, cmu_id, clk_groups, nr_groups);
+	samsung_cmu_register_clocks(dev, base, cmu_id, clk_groups, nr_groups);
 
 	return 0;
 }

-- 
2.51.0

