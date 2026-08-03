Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9C6C55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:10:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C42F6072C;
	Mon,  3 Aug 2026 19:10:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oMwFCX7HZwcW; Mon,  3 Aug 2026 19:10:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 32B4C60708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785784205;
	bh=P4jit9jN2lfG25r/ezLXockuZ4mXuAGtM6bydDed9f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=btzr4WrPlxkHM7hyiuhm321J5qEVzQ1Bo1KkQsLqS6DlLskr9eXreiAgy7kkUkEX0
	 5hNdSQ7XRrQA3KnblCz1iasbUSF5/jP7AMM11sH9vVDkgnxM6TwFh2zejg8UYqoNnh
	 lflwPw3S5coQYC0wXGpZ+KELf2pF2SxDnKzqD0x8L3nMGcVz8X+M5XPyMHKHvP0fap
	 bbLJ66L/H+Jfiv5Bw1IM9tW+xfyp2wYvqxsz44BvMSYccmbXLymsm3fYb9PknD67bD
	 0cQe+hoEs5b46m3zx1Th0sKPqs7sqOe5nkuvPZ+/hQnNEFmIROvePDDC693JLGZKDA
	 6tblLSgAvrgoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32B4C60708;
	Mon,  3 Aug 2026 19:10:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 27D1B194
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B75A80BF1
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:10:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0FUZ6zdfwU5W for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:10:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EA7BD80BDF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA7BD80BDF
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA7BD80BDF
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:10:00 +0000 (UTC)
X-Forward-Email-ID: 6a70e787ae1ce3dd2fb7e5d2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 5/6] clk: rockchip: rk3506: Use FIELD_PREP_WM16 macro
Date: Mon,  3 Aug 2026 19:09:43 +0000
Message-ID: <20260803190946.2259514-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803190946.2259514-1-jonas@kwiboo.se>
References: <20260803190946.2259514-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785784200; bh=P4jit9jN2lfG25r/ezLXockuZ4mXuAGtM6bydDed9f0=;
 b=scvQ7HuFfLJ1o2w4T29szjUDeDLwSl/3NhrMeNGthY/vnhMKGaVfo5bNTP7cSphkZxFun+18E
 gQtZVNfdiMztP3do9H4pLFEEl4Im+8SvCDycAe9PLDlL1ZHUGA2AqRP1BNvihS7Je+UxoF1tU/L
 cChQ5Ugi0chL+sqQa/bRKLPXoLAAVdzeEdhZsRPMVRXI8RZgAHSX/ZaD9bhv+SHxC4ZIGfF2zTH
 DBnZXtc2iU/o9yvKGUhkmJAgtReRU8pVZllLyEXr8yN1UzwnxbOWr1FmkyA9Hpqr160uAUwpcE+
 xX8KIH6Xn3L09ohVSJaIIHgnFOPGxvRWxZiVLla9KrIw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=scvQ7HuF
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Change to use writel() together with the FIELD_PREP_WM16() macro
instead of using the rk_clrsetreg() macro to avoid having to define the
mask as a parameter to both rk_clrsetreg() and FIELD_PREP(). Also change
to use u32 variables consistently.

No change in behavior is expected due to this code style change.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3506.c | 195 ++++++++++++++----------------
 1 file changed, 90 insertions(+), 105 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
index e156bf19a6b4..7ccab313e6ec 100644
--- a/drivers/clk/rockchip/clk_rk3506.c
+++ b/drivers/clk/rockchip/clk_rk3506.c
@@ -9,10 +9,11 @@
 #include <clk-uclass.h>
 #include <asm/arch-rockchip/clock.h>
 #include <asm/arch-rockchip/cru_rk3506.h>
-#include <asm/arch-rockchip/hardware.h>
+#include <asm/io.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dt-bindings/clock/rockchip,rk3506-cru.h>
+#include <linux/hw_bitfield.h>
 
 #define DIV_TO_RATE(input_rate, div)    ((input_rate) / ((div) + 1))
 
@@ -122,10 +123,10 @@ static int rk3506_armclk_set_rate(struct rk3506_clk_priv *priv, ulong new_rate)
 	 */
 	old_rate = rk3506_armclk_get_rate(priv);
 	if (new_rate >= old_rate) {
-		rk_clrsetreg(RK3506_CLKSEL_CON(15), ACLK_CORE_DIV_MASK,
-			     FIELD_PREP(ACLK_CORE_DIV_MASK, rate->aclk_div));
-		rk_clrsetreg(RK3506_CLKSEL_CON(16), PCLK_CORE_DIV_MASK,
-			     FIELD_PREP(PCLK_CORE_DIV_MASK, rate->pclk_div));
+		writel(FIELD_PREP_WM16(ACLK_CORE_DIV_MASK, rate->aclk_div),
+		       RK3506_CLKSEL_CON(15));
+		writel(FIELD_PREP_WM16(PCLK_CORE_DIV_MASK, rate->pclk_div),
+		       RK3506_CLKSEL_CON(16));
 	}
 
 	if (new_rate == 589824000 || new_rate == 1179648000) {
@@ -146,22 +147,22 @@ static int rk3506_armclk_set_rate(struct rk3506_clk_priv *priv, ulong new_rate)
 	con = readl(RK3506_CLKSEL_CON(15));
 	old_div = FIELD_GET(CLK_CORE_SRC_DIV_MASK, con);
 	if (DIV_TO_RATE(prate, old_div) > new_rate) {
-		rk_clrsetreg(RK3506_CLKSEL_CON(15), CLK_CORE_SRC_DIV_MASK,
-			     FIELD_PREP(CLK_CORE_SRC_DIV_MASK, div - 1));
-		rk_clrsetreg(RK3506_CLKSEL_CON(15), CLK_CORE_SRC_SEL_MASK,
-			     FIELD_PREP(CLK_CORE_SRC_SEL_MASK, sel));
+		writel(FIELD_PREP_WM16(CLK_CORE_SRC_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(15));
+		writel(FIELD_PREP_WM16(CLK_CORE_SRC_SEL_MASK, sel),
+		       RK3506_CLKSEL_CON(15));
 	} else {
-		rk_clrsetreg(RK3506_CLKSEL_CON(15), CLK_CORE_SRC_SEL_MASK,
-			     FIELD_PREP(CLK_CORE_SRC_SEL_MASK, sel));
-		rk_clrsetreg(RK3506_CLKSEL_CON(15), CLK_CORE_SRC_DIV_MASK,
-			     FIELD_PREP(CLK_CORE_SRC_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(CLK_CORE_SRC_SEL_MASK, sel),
+		       RK3506_CLKSEL_CON(15));
+		writel(FIELD_PREP_WM16(CLK_CORE_SRC_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(15));
 	}
 
 	if (new_rate < old_rate) {
-		rk_clrsetreg(RK3506_CLKSEL_CON(15), ACLK_CORE_DIV_MASK,
-			     FIELD_PREP(ACLK_CORE_DIV_MASK, rate->aclk_div));
-		rk_clrsetreg(RK3506_CLKSEL_CON(16), PCLK_CORE_DIV_MASK,
-			     FIELD_PREP(PCLK_CORE_DIV_MASK, rate->pclk_div));
+		writel(FIELD_PREP_WM16(ACLK_CORE_DIV_MASK, rate->aclk_div),
+		       RK3506_CLKSEL_CON(15));
+		writel(FIELD_PREP_WM16(PCLK_CORE_DIV_MASK, rate->pclk_div),
+		       RK3506_CLKSEL_CON(16));
 	}
 
 	return rk3506_armclk_get_rate(priv);
@@ -209,26 +210,26 @@ static ulong rk3506_pll_div_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
 	case CLK_GPLL_DIV:
 		div = DIV_ROUND_UP(priv->gpll_hz, rate);
 		assert(div - 1 <= 15);
-		rk_clrsetreg(RK3506_CLKSEL_CON(0), CLK_GPLL_DIV_MASK,
-			     FIELD_PREP(CLK_GPLL_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(CLK_GPLL_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(0));
 		break;
 	case CLK_GPLL_DIV_100M:
 		div = DIV_ROUND_UP(priv->gpll_div_hz, rate);
 		assert(div - 1 <= 15);
-		rk_clrsetreg(RK3506_CLKSEL_CON(0), CLK_GPLL_DIV_100M_MASK,
-			     FIELD_PREP(CLK_GPLL_DIV_100M_MASK, div - 1));
+		writel(FIELD_PREP_WM16(CLK_GPLL_DIV_100M_MASK, div - 1),
+		       RK3506_CLKSEL_CON(0));
 		break;
 	case CLK_V0PLL_DIV:
 		div = DIV_ROUND_UP(priv->v0pll_hz, rate);
 		assert(div - 1 <= 15);
-		rk_clrsetreg(RK3506_CLKSEL_CON(1), CLK_V0PLL_DIV_MASK,
-			     FIELD_PREP(CLK_V0PLL_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(CLK_V0PLL_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(1));
 		break;
 	case CLK_V1PLL_DIV:
 		div = DIV_ROUND_UP(priv->v1pll_hz, rate);
 		assert(div - 1 <= 15);
-		rk_clrsetreg(RK3506_CLKSEL_CON(1), CLK_V1PLL_DIV_MASK,
-			     FIELD_PREP(CLK_V1PLL_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(CLK_V1PLL_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(1));
 		break;
 	default:
 		return -ENOENT;
@@ -293,22 +294,19 @@ static ulong rk3506_bus_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
 
 	switch (clk_id) {
 	case ACLK_BUS_ROOT:
-		rk_clrsetreg(RK3506_CLKSEL_CON(21),
-			     ACLK_BUS_SEL_MASK | ACLK_BUS_DIV_MASK,
-			     FIELD_PREP(ACLK_BUS_SEL_MASK, sel) |
-			     FIELD_PREP(ACLK_BUS_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(ACLK_BUS_SEL_MASK, sel) |
+		       FIELD_PREP_WM16(ACLK_BUS_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(21));
 		break;
 	case HCLK_BUS_ROOT:
-		rk_clrsetreg(RK3506_CLKSEL_CON(21),
-			     HCLK_BUS_SEL_MASK | HCLK_BUS_DIV_MASK,
-			     FIELD_PREP(HCLK_BUS_SEL_MASK, sel) |
-			     FIELD_PREP(HCLK_BUS_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(HCLK_BUS_SEL_MASK, sel) |
+		       FIELD_PREP_WM16(HCLK_BUS_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(21));
 		break;
 	case PCLK_BUS_ROOT:
-		rk_clrsetreg(RK3506_CLKSEL_CON(22),
-			     PCLK_BUS_SEL_MASK | PCLK_BUS_DIV_MASK,
-			     FIELD_PREP(PCLK_BUS_SEL_MASK, sel) |
-			     FIELD_PREP(PCLK_BUS_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(PCLK_BUS_SEL_MASK, sel) |
+		       FIELD_PREP_WM16(PCLK_BUS_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(22));
 		break;
 	default:
 		return -ENOENT;
@@ -368,16 +366,14 @@ static ulong rk3506_peri_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
 
 	switch (clk_id) {
 	case ACLK_HSPERI_ROOT:
-		rk_clrsetreg(RK3506_CLKSEL_CON(49),
-			     ACLK_HSPERI_SEL_MASK | ACLK_HSPERI_DIV_MASK,
-			     FIELD_PREP(ACLK_HSPERI_SEL_MASK, sel) |
-			     FIELD_PREP(ACLK_HSPERI_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(ACLK_HSPERI_SEL_MASK, sel) |
+		       FIELD_PREP_WM16(ACLK_HSPERI_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(49));
 		break;
 	case HCLK_LSPERI_ROOT:
-		rk_clrsetreg(RK3506_CLKSEL_CON(29),
-			     HCLK_LSPERI_SEL_MASK | HCLK_LSPERI_DIV_MASK,
-			     FIELD_PREP(HCLK_LSPERI_SEL_MASK, sel) |
-			     FIELD_PREP(HCLK_LSPERI_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(HCLK_LSPERI_SEL_MASK, sel) |
+		       FIELD_PREP_WM16(HCLK_LSPERI_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(29));
 		break;
 	default:
 		return -ENOENT;
@@ -429,10 +425,9 @@ static ulong rk3506_sdmmc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
 	}
 	assert(div - 1 <= 63);
 
-	rk_clrsetreg(RK3506_CLKSEL_CON(49),
-		     CCLK_SDMMC_SEL_MASK | CCLK_SDMMC_DIV_MASK,
-		     FIELD_PREP(CCLK_SDMMC_SEL_MASK, sel) |
-		     FIELD_PREP(CCLK_SDMMC_DIV_MASK, div - 1));
+	writel(FIELD_PREP_WM16(CCLK_SDMMC_SEL_MASK, sel) |
+	       FIELD_PREP_WM16(CCLK_SDMMC_DIV_MASK, div - 1),
+	       RK3506_CLKSEL_CON(49));
 
 	return rk3506_sdmmc_get_rate(priv, clk_id);
 }
@@ -472,10 +467,9 @@ static ulong rk3506_saradc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
 	}
 	assert(div - 1 <= 15);
 
-	rk_clrsetreg(RK3506_CLKSEL_CON(54),
-		     CLK_SARADC_SEL_MASK | CLK_SARADC_DIV_MASK,
-		     FIELD_PREP(CLK_SARADC_SEL_MASK, sel) |
-		     FIELD_PREP(CLK_SARADC_DIV_MASK, div - 1));
+	writel(FIELD_PREP_WM16(CLK_SARADC_SEL_MASK, sel) |
+	       FIELD_PREP_WM16(CLK_SARADC_DIV_MASK, div - 1),
+	       RK3506_CLKSEL_CON(54));
 
 	return rk3506_saradc_get_rate(priv, clk_id);
 }
@@ -485,6 +479,7 @@ static ulong rk3506_tsadc_get_rate(struct rk3506_clk_priv *priv, ulong clk_id)
 	u32 con, div;
 
 	con = readl(RK3506_CLKSEL_CON(61));
+
 	switch (clk_id) {
 	case CLK_TSADC_TSEN:
 		div = FIELD_GET(CLK_TSADC_TSEN_DIV_MASK, con);
@@ -508,14 +503,14 @@ static ulong rk3506_tsadc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
 	case CLK_TSADC_TSEN:
 		div = DIV_ROUND_UP(OSC_HZ, rate);
 		assert(div - 1 <= 7);
-		rk_clrsetreg(RK3506_CLKSEL_CON(61), CLK_TSADC_TSEN_DIV_MASK,
-			     FIELD_PREP(CLK_TSADC_TSEN_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(CLK_TSADC_TSEN_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(61));
 		break;
 	case CLK_TSADC:
 		div = DIV_ROUND_UP(OSC_HZ, rate);
 		assert(div - 1 <= 255);
-		rk_clrsetreg(RK3506_CLKSEL_CON(61), CLK_TSADC_DIV_MASK,
-			     FIELD_PREP(CLK_TSADC_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(CLK_TSADC_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(61));
 		break;
 	default:
 		return -ENOENT;
@@ -580,22 +575,19 @@ static ulong rk3506_i2c_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
 
 	switch (clk_id) {
 	case CLK_I2C0:
-		rk_clrsetreg(RK3506_CLKSEL_CON(32),
-			     CLK_I2C0_SEL_MASK | CLK_I2C0_DIV_MASK,
-			     FIELD_PREP(CLK_I2C0_SEL_MASK, sel) |
-			     FIELD_PREP(CLK_I2C0_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(CLK_I2C0_SEL_MASK, sel) |
+		       FIELD_PREP_WM16(CLK_I2C0_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(32));
 		break;
 	case CLK_I2C1:
-		rk_clrsetreg(RK3506_CLKSEL_CON(32),
-			     CLK_I2C1_SEL_MASK | CLK_I2C1_DIV_MASK,
-			     FIELD_PREP(CLK_I2C1_SEL_MASK, sel) |
-			     FIELD_PREP(CLK_I2C1_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(CLK_I2C1_SEL_MASK, sel) |
+		       FIELD_PREP_WM16(CLK_I2C1_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(32));
 		break;
 	case CLK_I2C2:
-		rk_clrsetreg(RK3506_CLKSEL_CON(33),
-			     CLK_I2C2_SEL_MASK | CLK_I2C2_DIV_MASK,
-			     FIELD_PREP(CLK_I2C2_SEL_MASK, sel) |
-			     FIELD_PREP(CLK_I2C2_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(CLK_I2C2_SEL_MASK, sel) |
+		       FIELD_PREP_WM16(CLK_I2C2_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(33));
 		break;
 	default:
 		return -ENOENT;
@@ -644,8 +636,8 @@ static ulong rk3506_pwm_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
 	case CLK_PWM0:
 		div = DIV_ROUND_UP(priv->gpll_div_100mhz, rate);
 		assert(div - 1 <= 15);
-		rk_clrsetreg(RK3506_PMU_CLKSEL_CON(0), CLK_PWM0_DIV_MASK,
-			     FIELD_PREP(CLK_PWM0_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(CLK_PWM0_DIV_MASK, div - 1),
+		       RK3506_PMU_CLKSEL_CON(0));
 		break;
 	case CLK_PWM1:
 		if (priv->v0pll_hz % rate == 0) {
@@ -659,10 +651,9 @@ static ulong rk3506_pwm_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
 			div = DIV_ROUND_UP(priv->gpll_div_hz, rate);
 		}
 		assert(div - 1 <= 15);
-		rk_clrsetreg(RK3506_CLKSEL_CON(33),
-			     CLK_PWM1_SEL_MASK | CLK_PWM1_DIV_MASK,
-			     FIELD_PREP(CLK_PWM1_SEL_MASK, sel) |
-			     FIELD_PREP(CLK_PWM1_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(CLK_PWM1_SEL_MASK, sel) |
+		       FIELD_PREP_WM16(CLK_PWM1_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(33));
 		break;
 	default:
 		return -ENOENT;
@@ -727,16 +718,14 @@ static ulong rk3506_spi_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
 
 	switch (clk_id) {
 	case CLK_SPI0:
-		rk_clrsetreg(RK3506_CLKSEL_CON(34),
-			     CLK_SPI0_SEL_MASK | CLK_SPI0_DIV_MASK,
-			     FIELD_PREP(CLK_SPI0_SEL_MASK, sel) |
-			     FIELD_PREP(CLK_SPI0_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(CLK_SPI0_SEL_MASK, sel) |
+		       FIELD_PREP_WM16(CLK_SPI0_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(34));
 		break;
 	case CLK_SPI1:
-		rk_clrsetreg(RK3506_CLKSEL_CON(34),
-			     CLK_SPI1_SEL_MASK | CLK_SPI1_DIV_MASK,
-			     FIELD_PREP(CLK_SPI1_SEL_MASK, sel) |
-			     FIELD_PREP(CLK_SPI1_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(CLK_SPI1_SEL_MASK, sel) |
+		       FIELD_PREP_WM16(CLK_SPI1_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(34));
 		break;
 	default:
 		return -ENOENT;
@@ -770,7 +759,7 @@ static ulong rk3506_fspi_get_rate(struct rk3506_clk_priv *priv)
 
 static ulong rk3506_fspi_set_rate(struct rk3506_clk_priv *priv, ulong rate)
 {
-	int div, sel;
+	u32 div, sel;
 
 	if (OSC_HZ % rate == 0) {
 		sel = SCLK_FSPI_SEL_24M;
@@ -787,10 +776,9 @@ static ulong rk3506_fspi_set_rate(struct rk3506_clk_priv *priv, ulong rate)
 	}
 	assert(div - 1 <= 31);
 
-	rk_clrsetreg(RK3506_CLKSEL_CON(50),
-		     SCLK_FSPI_SEL_MASK | SCLK_FSPI_DIV_MASK,
-		     FIELD_PREP(SCLK_FSPI_SEL_MASK, sel) |
-		     FIELD_PREP(SCLK_FSPI_DIV_MASK, div - 1));
+	writel(FIELD_PREP_WM16(SCLK_FSPI_SEL_MASK, sel) |
+	       FIELD_PREP_WM16(SCLK_FSPI_DIV_MASK, div - 1),
+	       RK3506_CLKSEL_CON(50));
 
 	return rk3506_fspi_get_rate(priv);
 }
@@ -820,7 +808,7 @@ static ulong rk3506_vop_dclk_get_rate(struct rk3506_clk_priv *priv)
 
 static ulong rk3506_vop_dclk_set_rate(struct rk3506_clk_priv *priv, ulong rate)
 {
-	int div, sel;
+	u32 div, sel;
 
 	if (OSC_HZ % rate == 0) {
 		sel = DCLK_VOP_SEL_24M;
@@ -837,10 +825,9 @@ static ulong rk3506_vop_dclk_set_rate(struct rk3506_clk_priv *priv, ulong rate)
 	}
 	assert(div - 1 <= 255);
 
-	rk_clrsetreg(RK3506_CLKSEL_CON(60),
-		     DCLK_VOP_SEL_MASK | DCLK_VOP_DIV_MASK,
-		     FIELD_PREP(DCLK_VOP_SEL_MASK, sel) |
-		     FIELD_PREP(DCLK_VOP_DIV_MASK, div - 1));
+	writel(FIELD_PREP_WM16(DCLK_VOP_SEL_MASK, sel) |
+	       FIELD_PREP_WM16(DCLK_VOP_DIV_MASK, div - 1),
+	       RK3506_CLKSEL_CON(60));
 
 	return rk3506_vop_dclk_get_rate(priv);
 }
@@ -875,13 +862,13 @@ static ulong rk3506_mac_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
 	case CLK_MAC0:
 	case CLK_MAC1:
 		div = DIV_ROUND_UP(priv->gpll_hz, rate);
-		rk_clrsetreg(RK3506_CLKSEL_CON(50), CLK_MAC_DIV_MASK,
-			     FIELD_PREP(CLK_MAC_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(CLK_MAC_DIV_MASK, div - 1),
+		       RK3506_CLKSEL_CON(50));
 		break;
 	case CLK_MAC_OUT:
 		div = DIV_ROUND_UP(priv->gpll_hz, rate);
-		rk_clrsetreg(RK3506_PMU_CLKSEL_CON(0), CLK_MAC_OUT_DIV_MASK,
-			     FIELD_PREP(CLK_MAC_OUT_DIV_MASK, div - 1));
+		writel(FIELD_PREP_WM16(CLK_MAC_OUT_DIV_MASK, div - 1),
+		       RK3506_PMU_CLKSEL_CON(0));
 		break;
 	default:
 		return -ENOENT;
@@ -1091,16 +1078,14 @@ static void rk3506_clk_init(struct rk3506_clk_priv *priv)
 static void rk3506_clk_init_xpl(void)
 {
 	/* Init pka crypto rate, sel=v0pll, div=3 */
-	rk_clrsetreg(RK3506_SCRU_BASE + 0x0010,
-		     CLK_PKA_CRYPTO_SEL_MASK | CLK_PKA_CRYPTO_DIV_MASK,
-		     FIELD_PREP(CLK_PKA_CRYPTO_SEL_MASK, CLK_PKA_CRYPTO_SEL_V0PLL) |
-		     FIELD_PREP(CLK_PKA_CRYPTO_DIV_MASK, 3));
+	writel(FIELD_PREP_WM16(CLK_PKA_CRYPTO_SEL_MASK, CLK_PKA_CRYPTO_SEL_V0PLL) |
+	       FIELD_PREP_WM16(CLK_PKA_CRYPTO_DIV_MASK, 3),
+	       RK3506_SCRU_BASE + 0x0010);
 
 	/* Change clk core src rate, sel=gpll, div=3 */
-	rk_clrsetreg(RK3506_CLKSEL_CON(15),
-		     CLK_CORE_SRC_SEL_MASK | CLK_CORE_SRC_DIV_MASK,
-		     FIELD_PREP(CLK_CORE_SRC_SEL_MASK, CLK_CORE_SEL_GPLL) |
-		     FIELD_PREP(CLK_CORE_SRC_DIV_MASK, 3));
+	writel(FIELD_PREP_WM16(CLK_CORE_SRC_SEL_MASK, CLK_CORE_SEL_GPLL) |
+	       FIELD_PREP_WM16(CLK_CORE_SRC_DIV_MASK, 3),
+	       RK3506_CLKSEL_CON(15));
 }
 
 static int rk3506_clk_probe(struct udevice *dev)
-- 
2.54.0

