Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D81BC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 10:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECF0E8056B;
	Fri, 21 Feb 2025 11:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="SG9HfxMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D80780F96; Fri, 21 Feb 2025 11:04:17 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7BC98056B
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 11:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1402d5598=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1740132254; x=1771668254;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e6h3HBK/Z0eq8U5knHp8+29ylNguOwIOBMGSB5giDFw=;
 b=SG9HfxMff/ILWmi4qB27ct9xJxAAaXTkDwBloZbQvvxPrl1PjvmRCPNJ
 vhk2LnhKkzqCbqzntJbI2IT7NDyyxoxpJUaCJxzSv313Zg0xxJr4ClYLq
 gSppMKqb9jV1GZIdeLYWYHxoaOnlFXWTkExJtjColVwRcsWvfnYBdqcjb
 1A+4LyN+UmZ5sgYhB/EeEGLxN8sS7nf/K9vqPGHteM65JG3lBPfYPI2fH
 2LbJ7Ttgy3/z6tKiRJv/sdrczjblfpCFpo4YrdipXW6ZshCRicWr91o7y
 KeQ9BGyBHDwUCky/Ipn2/g4FEIOqnjRIPXUC3VbZJjbPrDhJiVQU/tOGC g==;
X-CSE-ConnectionGUID: SrdQanc4TIuN9o0SWC77gg==
X-CSE-MsgGUID: rLjUyW/mRJeDoLUZcUasfw==
X-IronPort-AV: E=Sophos;i="6.13,304,1732604400"; d="scan'208";a="37553916"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 21 Feb 2025 03:04:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 21 Feb 2025 03:03:43 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 21 Feb 2025 03:03:34 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 <seanga2@gmail.com>, <sumit.garg@linaro.org>, <kever.yang@rock-chips.com>, 
 <marek.vasut+renesas@mailbox.org>, <jonas@kwiboo.se>, <festevam@denx.de>, 
 <Oliver.Gaskell@analog.com>, <aford173@gmail.com>, <prasad.kummari@amd.com>,
 <caleb.connolly@linaro.org>, <andre.przywara@arm.com>,
 <neil.armstrong@linaro.org>, <mibodhi@gmail.com>,
 <nicolas.ferre@microchip.com>, <mihai.sain@microchip.com>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>, Varshini Rajendran
 <varshini.rajendran@microchip.com>
Subject: [PATCH 2/8] clk: at91: sam9x60-pll: add support for HW PLL freq
 dividers
Date: Fri, 21 Feb 2025 15:33:08 +0530
Message-ID: <20250221100314.464818-3-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221100314.464818-1-manikandan.m@microchip.com>
References: <20250221100314.464818-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

From: Varshini Rajendran <varshini.rajendran@microchip.com>

Add support for hardware dividers for PLL IDs.In sam9x7 SoC,
PLL_ID_PLLA and PLL_ID_PLLA_DIV2 has /2 hardware dividers
each.

fcorepllack -----> HW Div = 2 -+--> fpllack
                               |
                               +--> HW Div = 2 ---> fplladiv2ck

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 38 +++++++++++++++++++++++++++++-
 drivers/clk/at91/pmc.h             |  1 +
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index 676ad8294a6..df8172bccac 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -22,6 +22,7 @@
 
 #define UBOOT_DM_CLK_AT91_SAM9X60_DIV_PLL	"at91-sam9x60-div-pll-clk"
 #define UBOOT_DM_CLK_AT91_SAM9X60_FRAC_PLL	"at91-sam9x60-frac-pll-clk"
+#define UBOOT_DM_CLK_AT91_SAM9X60_FIXED_DIV_PLL	"at91-sam9x60-fixed-div-pll-clk"
 
 #define	PMC_PLL_CTRL0_DIV_MSK	GENMASK(7, 0)
 #define	PMC_PLL_CTRL1_MUL_MSK	GENMASK(31, 24)
@@ -140,6 +141,7 @@ static ulong sam9x60_frac_pll_get_rate(struct clk *clk)
 	void __iomem *base = pll->base;
 	ulong parent_rate = clk_get_parent_rate(clk);
 	u32 mul, frac, val;
+	ulong pll_rate;
 
 	if (!parent_rate)
 		return 0;
@@ -149,8 +151,12 @@ static ulong sam9x60_frac_pll_get_rate(struct clk *clk)
 	pmc_read(base, AT91_PMC_PLL_CTRL1, &val);
 	mul = (val & pll->layout->mul_mask) >> pll->layout->mul_shift;
 	frac = (val & pll->layout->frac_mask) >> pll->layout->frac_shift;
+	pll_rate = (parent_rate * (mul + 1) + ((u64)parent_rate * frac >> 22));
 
-	return (parent_rate * (mul + 1) + ((u64)parent_rate * frac >> 22));
+	if (pll->layout->div2)
+		pll_rate >>= 1;
+
+	return pll_rate;
 }
 
 static int sam9x60_frac_pll_enable(struct clk *clk)
@@ -359,6 +365,16 @@ static ulong sam9x60_div_pll_get_rate(struct clk *clk)
 	return parent_rate / (div + 1);
 }
 
+static ulong sam9x60_fixed_div_pll_get_rate(struct clk *clk)
+{
+	ulong parent_rate = clk_get_parent_rate(clk);
+
+	if (!parent_rate)
+		return 0;
+
+	return parent_rate >> 1;
+}
+
 static const struct clk_ops sam9x60_div_pll_ops = {
 	.enable = sam9x60_div_pll_enable,
 	.disable = sam9x60_div_pll_disable,
@@ -366,6 +382,12 @@ static const struct clk_ops sam9x60_div_pll_ops = {
 	.get_rate = sam9x60_div_pll_get_rate,
 };
 
+static const struct clk_ops sam9x60_fixed_div_pll_ops = {
+	.enable = sam9x60_div_pll_enable,
+	.disable = sam9x60_div_pll_disable,
+	.get_rate = sam9x60_fixed_div_pll_get_rate,
+};
+
 static struct clk *
 sam9x60_clk_register_pll(void __iomem *base, const char *type,
 			 const char *name, const char *parent_name, u8 id,
@@ -406,6 +428,13 @@ sam9x60_clk_register_div_pll(void __iomem *base, const char *name,
 			     const struct clk_pll_characteristics *characteristics,
 			     const struct clk_pll_layout *layout, bool critical)
 {
+	if (layout->div2) {
+		return sam9x60_clk_register_pll(base,
+			UBOOT_DM_CLK_AT91_SAM9X60_FIXED_DIV_PLL, name, parent_name,
+			id, characteristics, layout,
+			CLK_GET_RATE_NOCACHE | (critical ? CLK_IS_CRITICAL : 0));
+	}
+
 	return sam9x60_clk_register_pll(base,
 		UBOOT_DM_CLK_AT91_SAM9X60_DIV_PLL, name, parent_name, id,
 		characteristics, layout,
@@ -431,6 +460,13 @@ U_BOOT_DRIVER(at91_sam9x60_div_pll_clk) = {
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
+U_BOOT_DRIVER(at91_sam9x60_fixed_div_pll_clk) = {
+	.name = UBOOT_DM_CLK_AT91_SAM9X60_FIXED_DIV_PLL,
+	.id = UCLASS_CLK,
+	.ops = &sam9x60_fixed_div_pll_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
 U_BOOT_DRIVER(at91_sam9x60_frac_pll_clk) = {
 	.name = UBOOT_DM_CLK_AT91_SAM9X60_FRAC_PLL,
 	.id = UCLASS_CLK,
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 49134531564..580c9964ff4 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -54,6 +54,7 @@ struct clk_pll_layout {
 	u8 frac_shift;
 	u8 div_shift;
 	u8 endiv_shift;
+	u8 div2;
 };
 
 struct clk_programmable_layout {
-- 
2.25.1

