Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54024C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 06:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C789819B1;
	Mon, 17 Mar 2025 07:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="0dEJURPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D358E81A10; Mon, 17 Mar 2025 07:56:57 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6046F8197F
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1648c5b74=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1742194615; x=1773730615;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hF3L594yGNZjmZPto+rxNQCklZPNL7f4PynacImV7vA=;
 b=0dEJURPeAV69CaNSn4xLHc++z2W3MJaadKmOouyE539SXSFf02Gb09JW
 opQuxqCsFRjWajCkEPSbLbCzRBNBFADPJw0WOcUKoNK8OABXAsQzef+Uy
 nO5lJGoBOOytMBj1+FEIIMaTvrRKpBBtwOFkKeEZNGcTtekAEksx3SQoR
 tN6RIQfwOyhYJNoaTbpPEa0MrMsr5MokP17uxOuhextB5vgS4JST0sTOK
 v2xCMs9ug7O5OUI0CjypPaphMGkOa1aXhc04wiwiSC48jVx6Jdg2AJkm0
 t52orgmv2etACBFzCw2U63/xyGgpe/3JWrU+ElP4FAO/S3wy6fWQ9oJv7 w==;
X-CSE-ConnectionGUID: B2VTkOt4RDCPtsISDDyAfQ==
X-CSE-MsgGUID: Gy5AV1gGS7Wi8DXicvlXtA==
X-IronPort-AV: E=Sophos;i="6.14,253,1736838000"; d="scan'208";a="206763682"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Mar 2025 23:56:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 16 Mar 2025 23:56:44 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Sun, 16 Mar 2025 23:56:37 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 <seanga2@gmail.com>, <sjg@chromium.org>, <mkorpershoek@baylibre.com>,
 <nathan.morrison@timesys.com>, <ilias.apalodimas@linaro.org>,
 <greg.malysa@timesys.com>, <caleb.connolly@linaro.org>,
 <Oliver.Gaskell@analog.com>, <robert.marko@sartura.hr>,
 <jerome.forissier@linaro.org>, <semen.protsenko@linaro.org>,
 <william.zhang@broadcom.com>, <nicolas.ferre@microchip.com>,
 <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>, Varshini Rajendran
 <varshini.rajendran@microchip.com>
Subject: [PATCH v4 2/8] clk: at91: sam9x60-pll: add support for core clock
 frequency inputs
Date: Mon, 17 Mar 2025 12:26:03 +0530
Message-ID: <20250317065609.55071-3-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250317065609.55071-1-manikandan.m@microchip.com>
References: <20250317065609.55071-1-manikandan.m@microchip.com>
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

Add support for different core clock frequency input ranges
for different PLL IDs in the PLL driver and align sam9x60, sama7g5 SOC
platforms.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 17 ++++++++---------
 drivers/clk/at91/pmc.h             |  1 +
 drivers/clk/at91/sam9x60.c         |  7 +++++++
 drivers/clk/at91/sama7g5.c         |  6 ++++++
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index a30035eb8ce..676ad8294a6 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -31,9 +31,6 @@
 #define UPLL_DIV		2
 #define PLL_MUL_MAX		(FIELD_GET(PMC_PLL_CTRL1_MUL_MSK, UINT_MAX) + 1)
 
-#define FCORE_MIN		(600000000)
-#define FCORE_MAX		(1200000000)
-
 #define PLL_MAX_ID		7
 
 struct sam9x60_pll {
@@ -55,14 +52,15 @@ static inline bool sam9x60_pll_ready(void __iomem *base, int id)
 	return !!(status & BIT(id));
 }
 
-static long sam9x60_frac_pll_compute_mul_frac(u32 *mul, u32 *frac, ulong rate,
+static long sam9x60_frac_pll_compute_mul_frac(const struct clk_range *core_clk,
+					      u32 *mul, u32 *frac, ulong rate,
 					      ulong parent_rate)
 {
 	unsigned long tmprate, remainder;
 	unsigned long nmul = 0;
 	unsigned long nfrac = 0;
 
-	if (rate < FCORE_MIN || rate > FCORE_MAX)
+	if (rate < core_clk->min || rate > core_clk->max)
 		return -ERANGE;
 
 	/*
@@ -82,7 +80,7 @@ static long sam9x60_frac_pll_compute_mul_frac(u32 *mul, u32 *frac, ulong rate,
 	}
 
 	/* Check if resulted rate is valid.  */
-	if (tmprate < FCORE_MIN || tmprate > FCORE_MAX)
+	if (tmprate < core_clk[0].min || tmprate > core_clk[0].max)
 		return -ERANGE;
 
 	*mul = nmul - 1;
@@ -103,8 +101,8 @@ static ulong sam9x60_frac_pll_set_rate(struct clk *clk, ulong rate)
 	if (!parent_rate)
 		return 0;
 
-	ret = sam9x60_frac_pll_compute_mul_frac(&nmul, &nfrac, rate,
-						parent_rate);
+	ret = sam9x60_frac_pll_compute_mul_frac(pll->characteristics->core_output,
+						&nmul, &nfrac, rate, parent_rate);
 	if (ret < 0)
 		return 0;
 
@@ -163,7 +161,8 @@ static int sam9x60_frac_pll_enable(struct clk *clk)
 	ulong crate;
 
 	crate = sam9x60_frac_pll_get_rate(clk);
-	if (crate < FCORE_MIN || crate > FCORE_MAX)
+	if (crate < pll->characteristics->core_output[0].min ||
+	    crate > pll->characteristics->core_output[0].max)
 		return -ERANGE;
 
 	pmc_update_bits(base, AT91_PMC_PLL_UPDT, AT91_PMC_PLL_UPDT_ID_MSK,
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index ff464522aa0..49134531564 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -38,6 +38,7 @@ struct clk_pll_characteristics {
 	struct clk_range input;
 	int num_output;
 	const struct clk_range *output;
+	const struct clk_range *core_output;
 	u16 *icpll;
 	u8 *out;
 	u8 upll : 1;
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index b7d64bdbb3d..e04266a2be2 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -112,17 +112,24 @@ static const struct clk_range upll_outputs[] = {
 	{ .min = 300000000, .max = 500000000 },
 };
 
+/* Fractional PLL core output range. */
+static const struct clk_range core_outputs[] = {
+	{ .min = 600000000, .max = 1200000000 },
+};
+
 /* PLL characteristics. */
 static const struct clk_pll_characteristics apll_characteristics = {
 	.input = { .min = 12000000, .max = 48000000 },
 	.num_output = ARRAY_SIZE(plla_outputs),
 	.output = plla_outputs,
+	.core_output = core_outputs,
 };
 
 static const struct clk_pll_characteristics upll_characteristics = {
 	.input = { .min = 12000000, .max = 48000000 },
 	.num_output = ARRAY_SIZE(upll_outputs),
 	.output = upll_outputs,
+	.core_output = core_outputs,
 	.upll = true,
 };
 
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 63b2c647467..c0e27828b1a 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -158,11 +158,17 @@ static const struct clk_range pll_outputs[] = {
 	{ .min = 2343750, .max = 1200000000 },
 };
 
+/* Fractional PLL core output range. */
+static const struct clk_range core_outputs[] = {
+	{ .min = 600000000, .max = 1200000000 },
+};
+
 /* PLL characteristics. */
 static const struct clk_pll_characteristics pll_characteristics = {
 	.input = { .min = 12000000, .max = 50000000 },
 	.num_output = ARRAY_SIZE(pll_outputs),
 	.output = pll_outputs,
+	.core_output = core_outputs,
 };
 
 /* Layout for fractional PLLs. */
-- 
2.25.1

