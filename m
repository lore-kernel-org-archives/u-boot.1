Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDF7C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 05:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B4F81FFC;
	Tue,  3 Jun 2025 07:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="yBbUv7Ar";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 291BF828A2; Tue,  3 Jun 2025 07:06:55 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A277380BAE
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 07:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2426dda6b=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1748927212; x=1780463212;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hF3L594yGNZjmZPto+rxNQCklZPNL7f4PynacImV7vA=;
 b=yBbUv7Ar8HJ2g2KPdZDL5SmQF1xpmx5qA/qHeLiju7d5nLGTyDvbxajc
 SpWa/jEmjN9NsJhwxnYoeeEhvlt8i5LCupMReD12srQbXiWihAqXvdY6I
 5GdHDpoovN/CwsJ4JMb0Kr9yQ8/noYF0QEQfWVhuT1E4ylfMZzAaFvbrl
 BEbAtvR5cLbh5PWPm8lJqjLXdWuFAKcJ5fGoIe9d/mJDfICCVpxviRVhl
 1FVGMQj9GFFHww+aih2G1HmaFDfqTOXFB5Xp0SFoo5qvjJIhEfIfnPetG
 y1Xrl8pR/XUFekNmOgPLgBVXlG7ahrAkIPO2yeR5BjOXApUot7cqR97n3 Q==;
X-CSE-ConnectionGUID: B4IgzVtZSEitk6TmeJ3+kw==
X-CSE-MsgGUID: WMEMVjWJQLuFlLjbvU9skw==
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="273727172"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Jun 2025 22:06:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 2 Jun 2025 22:06:30 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 2 Jun 2025 22:06:23 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 <seanga2@gmail.com>, <sjg@chromium.org>, <Oliver.Gaskell@analog.com>,
 <malysagreg@gmail.com>, <nathan.morrison@timesys.com>,
 <mkorpershoek@kernel.org>, <robert.marko@sartura.hr>,
 <jerome.forissier@linaro.org>, <sebastian.reichel@collabora.com>,
 <duje.mihanovic@skole.hr>, <sumit.garg@kernel.org>,
 <patrice.chotard@foss.st.com>, <nicolas.ferre@microchip.com>,
 <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>, Varshini Rajendran
 <varshini.rajendran@microchip.com>
Subject: [PATCH v6 2/9] clk: at91: sam9x60-pll: add support for core clock
 frequency inputs
Date: Tue, 3 Jun 2025 10:35:49 +0530
Message-ID: <20250603050556.80851-3-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603050556.80851-1-manikandan.m@microchip.com>
References: <20250603050556.80851-1-manikandan.m@microchip.com>
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

