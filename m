Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37D6C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 07:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8647381D3B;
	Thu, 27 Mar 2025 08:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="u4gjxwBo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A6581D27; Thu, 27 Mar 2025 08:07:05 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B13E881B4B
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 08:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=174f6da1a=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1743059222; x=1774595222;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e6h3HBK/Z0eq8U5knHp8+29ylNguOwIOBMGSB5giDFw=;
 b=u4gjxwBomqLuEd5AAtOMfxaeEMgdCQ2A4U7o2VnuWLmzkcSsnVK5qAM7
 GJ4HjEK0HIMFMQN38uuXsCw0HZU1OQIaKSur+UqkQ9Na4GM+OBNv2FgpC
 hcRZbqloL6zYBNYIZsgibgHMo0XdhoEAO1Z4SR8yy3MhcqjqavtOL0LRd
 JHAGnRI2PVDgAlCWfBcR8BdDNJDxE9ktcouCK5p3Eh/SD5dGilrhefohS
 z9cueYqJ5A0hinze9MJnH5LNWt2ZbInz4uEGmyVTQ5WERsfXirN6JUEP7
 UMHqnT1QRsl4ahZkKH7oDhtm4Y2Dg/gpzoUSw9w4ExidZgqQdAhpqaFvf g==;
X-CSE-ConnectionGUID: hKcK+CcVRse6cfoq3OL+Lg==
X-CSE-MsgGUID: rRZSIl9/RqGKZEPeRhd0Qg==
X-IronPort-AV: E=Sophos;i="6.14,279,1736838000"; d="scan'208";a="44135953"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Mar 2025 00:06:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 00:06:50 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 27 Mar 2025 00:06:43 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 <seanga2@gmail.com>, <sjg@chromium.org>, <mkorpershoek@baylibre.com>,
 <nathan.morrison@timesys.com>, <ilias.apalodimas@linaro.org>,
 <greg.malysa@timesys.com>, <caleb.connolly@linaro.org>,
 <Oliver.Gaskell@analog.com>, <robert.marko@sartura.hr>,
 <igor.opaniuk@gmail.com>, <semen.protsenko@linaro.org>,
 <william.zhang@broadcom.com>, <nicolas.ferre@microchip.com>,
 <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>, Varshini Rajendran
 <varshini.rajendran@microchip.com>
Subject: [PATCH v5 3/8] clk: at91: sam9x60-pll: add support for HW PLL freq
 dividers
Date: Thu, 27 Mar 2025 12:36:10 +0530
Message-ID: <20250327070615.334551-4-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250327070615.334551-1-manikandan.m@microchip.com>
References: <20250327070615.334551-1-manikandan.m@microchip.com>
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

