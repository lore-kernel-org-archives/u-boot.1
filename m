Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98963C004C0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 16:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE66486FB7;
	Mon, 23 Oct 2023 18:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XTdbeA0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E7C87783; Mon, 23 Oct 2023 15:35:54 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 975E787180
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 15:35:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39NDZlhV037025;
 Mon, 23 Oct 2023 08:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698068147;
 bh=oiOVJ1hZ2CXNla1GHkFSbQ+H3phl5kmv/K4c/s8P2x8=;
 h=From:To:CC:Subject:Date;
 b=XTdbeA0oQJVBwQkK/cJTgTyO5TDSN/dJmXCdFkAanI0eJkHhiHZElud2bQ9VSy7hC
 Kfa1WNSOYSeh1WetFMK2tZcpj2gt/r2/O8loeAeKPACkX6X1G4fS9DwNhHL3M2ufYQ
 s99FBVaO5oeEkeeRItK+J9/aUQVNQZppRgygO56I=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39NDZlmx011546
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 23 Oct 2023 08:35:47 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 23
 Oct 2023 08:35:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 23 Oct 2023 08:35:46 -0500
Received: from uda0271468c (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39NDZkRs014032;
 Mon, 23 Oct 2023 08:35:46 -0500
Received: from vishallocal by uda0271468c with local (Exim 4.90_1)
 (envelope-from <vishalm@ti.com>)
 id 1quv5u-0008Or-Mj; Mon, 23 Oct 2023 08:35:46 -0500
From: Vishal Mahaveer <vishalm@ti.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
Subject: [RESEND PATCH 1/1] clk: ti: k3-pll: Add calibration support for non
 fractional mode
Date: Mon, 23 Oct 2023 08:35:46 -0500
Message-ID: <20231023133546.32283-1-vishalm@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Mon, 23 Oct 2023 18:53:56 +0200
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

PLL calibration needs to be enabled when operating in non fractional
mode. Add the sequence to do a fast calibration when using PLL
in this mode.

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 drivers/clk/ti/clk-k3-pll.c | 81 ++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ti/clk-k3-pll.c b/drivers/clk/ti/clk-k3-pll.c
index bf762c558ef..c1158c13290 100644
--- a/drivers/clk/ti/clk-k3-pll.c
+++ b/drivers/clk/ti/clk-k3-pll.c
@@ -25,6 +25,23 @@
 #define PLL_16FFT_FREQ_CTRL0		0x30
 #define PLL_16FFT_FREQ_CTRL1		0x34
 #define PLL_16FFT_DIV_CTRL		0x38
+#define PLL_16FFT_CAL_CTRL		0x60
+#define PLL_16FFT_CAL_STAT		0x64
+
+/* CAL STAT register bits */
+#define PLL_16FFT_CAL_STAT_CAL_LOCK	BIT(31)
+
+/* CFG register bits */
+#define PLL_16FFT_CFG_PLL_TYPE_SHIFT	(0)
+#define PLL_16FFT_CFG_PLL_TYPE_MASK	(0x3 << 0)
+#define PLL_16FFT_CFG_PLL_TYPE_FRACF	1
+
+/* CAL CTRL register bits */
+#define PLL_16FFT_CAL_CTRL_CAL_EN               BIT(31)
+#define PLL_16FFT_CAL_CTRL_FAST_CAL             BIT(20)
+#define PLL_16FFT_CAL_CTRL_CAL_BYP              BIT(15)
+#define PLL_16FFT_CAL_CTRL_CAL_CNT_SHIFT        16
+#define PLL_16FFT_CAL_CTRL_CAL_CNT_MASK         (0x7 << 16)
 
 /* CTRL register bits */
 #define PLL_16FFT_CTRL_BYPASS_EN	BIT(31)
@@ -40,9 +57,14 @@
 /* DIV CTRL register bits */
 #define PLL_16FFT_DIV_CTRL_REF_DIV_MASK		0x3f
 
-#define PLL_16FFT_FREQ_CTRL1_FB_DIV_FRAC_BITS	24
+/* HSDIV register bits*/
 #define PLL_16FFT_HSDIV_CTRL_CLKOUT_EN          BIT(15)
 
+/* FREQ_CTRL1 bits */
+#define PLL_16FFT_FREQ_CTRL1_FB_DIV_FRAC_BITS	24
+#define PLL_16FFT_FREQ_CTRL1_FB_DIV_FRAC_MASK	0xffffff
+#define PLL_16FFT_FREQ_CTRL1_FB_DIV_FRAC_SHIFT	0
+
 /* KICK register magic values */
 #define PLL_KICK0_VALUE				0x68ef3490
 #define PLL_KICK1_VALUE				0xd172bc5a
@@ -63,18 +85,65 @@ static int ti_pll_wait_for_lock(struct clk *clk)
 {
 	struct ti_pll_clk *pll = to_clk_pll(clk);
 	u32 stat;
+	u32 cfg;
+	u32 cal;
+	u32 freq_ctrl1;
 	int i;
+	u32 pllfm;
+	u32 pll_type;
+	int success;
 
 	for (i = 0; i < 100000; i++) {
 		stat = readl(pll->reg + PLL_16FFT_STAT);
-		if (stat & PLL_16FFT_STAT_LOCK)
-			return 0;
+		if (stat & PLL_16FFT_STAT_LOCK) {
+			success = 1;
+			break;
+		}
 	}
 
-	printf("%s: pll (%s) failed to lock\n", __func__,
-	       clk->dev->name);
+	/* Enable calibration if not in fractional mode of the FRACF PLL */
+	freq_ctrl1 = readl(pll->reg + PLL_16FFT_FREQ_CTRL1);
+	pllfm = freq_ctrl1 & PLL_16FFT_FREQ_CTRL1_FB_DIV_FRAC_MASK;
+	pllfm >>= PLL_16FFT_FREQ_CTRL1_FB_DIV_FRAC_SHIFT;
+	cfg = readl(pll->reg + PLL_16FFT_CFG);
+	pll_type = (cfg & PLL_16FFT_CFG_PLL_TYPE_MASK) >> PLL_16FFT_CFG_PLL_TYPE_SHIFT;
+
+	if (success && pll_type == PLL_16FFT_CFG_PLL_TYPE_FRACF && pllfm == 0) {
+		cal = readl(pll->reg + PLL_16FFT_CAL_CTRL);
 
-	return -EBUSY;
+		/* Enable calibration for FRACF */
+		cal |= PLL_16FFT_CAL_CTRL_CAL_EN;
+
+		/* Enable fast cal mode */
+		cal |= PLL_16FFT_CAL_CTRL_FAST_CAL;
+
+		/* Disable calibration bypass */
+		cal &= ~PLL_16FFT_CAL_CTRL_CAL_BYP;
+
+		/* Set CALCNT to 2 */
+		cal &= ~PLL_16FFT_CAL_CTRL_CAL_CNT_MASK;
+		cal |= 2 << PLL_16FFT_CAL_CTRL_CAL_CNT_SHIFT;
+
+		/* Note this register does not readback the written value. */
+		writel(cal, pll->reg + PLL_16FFT_CAL_CTRL);
+
+		success = 0;
+		for (i = 0; i < 100000; i++) {
+			stat = readl(pll->reg + PLL_16FFT_CAL_STAT);
+			if (stat & PLL_16FFT_CAL_STAT_CAL_LOCK) {
+				success = 1;
+				break;
+			}
+		}
+	}
+
+	if (success == 0) {
+		printf("%s: pll (%s) failed to lock\n", __func__,
+		       clk->dev->name);
+		return -EBUSY;
+	} else {
+		return 0;
+	}
 }
 
 static ulong ti_pll_clk_get_rate(struct clk *clk)
-- 
2.36.1

