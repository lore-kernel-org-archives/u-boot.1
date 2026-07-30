Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EA6C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DBD08112B;
	Thu, 30 Jul 2026 14:13:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5gHio1aZQdKV; Thu, 30 Jul 2026 14:13:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 493F88108D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785420822;
	bh=eXF65Sg2W2JvkvrfNwF50qCfh7wV2vLfzAt2PUD9f0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vyyl/VYJWOJXF8vj+oQ9ETu1asBNcLCTODa3XmDab1fX4WTTIU7phKpExfVhr9+fV
	 EXdsXxYlBTKwt4fXDPI8qtHHu6CUYC27bHbLAwL3gs7Z5Y2gzpMvKZmgEx3NNR1p/5
	 kG4gSX6xoNRYrPstzkQngEqDlSx9p1oTA1+hP8HzcOr7hMSusSPFfD5li8amJrn5pV
	 VoKgqsHKvfwt+yRjPn6omFHIf1f7kGZ1tU11ai5vPcsQ6/gyUQOaZ9H8Wjc3hgOpn3
	 x3lMxwtjhX2oag6EAPU/kOuWRpu9P9NzQWgnOnPGDe8P2UCgsSCiq8Vj05jZEmdbQy
	 icB/aOMqFsD4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 493F88108D;
	Thu, 30 Jul 2026 14:13:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 954D2352
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86EBF81108
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uno9uC2kcBr5 for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:13:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 54D62810F2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 54D62810F2
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 54D62810F2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:13:37 +0000 (UTC)
X-Forward-Email-ID: 6a6b5c0fa254ae338c091824
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.12.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 11/15] clk: rockchip: rk3576: Fix trivial clock configuration
 errors
Date: Thu, 30 Jul 2026 14:13:00 +0000
Message-ID: <20260730141308.1218014-12-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730141308.1218014-1-jonas@kwiboo.se>
References: <20260730141308.1218014-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785420816; bh=eXF65Sg2W2JvkvrfNwF50qCfh7wV2vLfzAt2PUD9f0s=;
 b=IwB48DLnRtPH3ECYYpob7/XIPspfARFcCETeyNXB52xcXmlfHOKNVvb3BYd4y/1dBpqfzunq4
 imCsLPIrxECyN0PoaihzZAAcExhaHH7/+uXTCeLpj9AuG/aqAcmTn+GSsszxeFAGerTOPCBe0+8
 64B3E511oKmbN6vlR16ND8fmH9dblpYl3+2Ou2E2MoAdl4NZ+Eb0QDiso7P23U3hzA5Zy12cg+K
 BvBVCgF0wijzzUwPsWt/PWfRV5Sanifrw0vx1ewQwuQOARDssS4iu1E3k7pjPbK8Tzdx03RZaXk
 gWsjW0nKqtfQqkoBaTTJvDShsVwQtUrxhLD6TzXophbg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=IwB48DLn
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

The RK3576 clock driver has a few trivial copy-paste mistakes in its
clock handling.

Fix the trivial clock configuration errors:
- use correct VPLL mode reg
- rename and use PHP_PLL_CON macro
- set correct parent for ACLK_TOP clocks
- avoid overriding the selected I2C parent clock
- stop CLK_I2C8 from falling through into CLK_I2C9
- use correct SARADC and TSADC clksel regs
- use correct parent pll rate for UART clocks
- align BPLL configuration to match other PLLs
- remove unused BPLL_CON macro

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../include/asm/arch-rockchip/cru_rk3576.h    |  5 ++--
 drivers/clk/rockchip/clk_rk3576.c             | 23 +++++++++----------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
index fb77fbd7307a..41e225245843 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
@@ -127,24 +127,23 @@ struct pll_rate_table {
 #define RK3576_SDMMC_CON0		0xC30
 #define RK3576_SDMMC_CON1		0xC34
 
+#define RK3576_PHP_PLL_CON(x)		((x) * 0x4 + RK3576_PHP_CRU_BASE)
 #define RK3576_PHP_CLKSEL_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0x300)
 #define RK3576_PHP_CLKGATE_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0x800)
 #define RK3576_PHP_SOFTRST_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0xa00)
 
-#define RK3576_PMU_PLL_CON(x)		((x) * 0x4 + RK3576_PHP_CRU_BASE)
 #define RK3576_PMU_CLKSEL_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0x300)
 #define RK3576_PMU_CLKGATE_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0x800)
 #define RK3576_PMU_SOFTRST_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0xa00)
 
+#define RK3576_LPLL_CON(x)		((x) * 0x4 + RK3576_CCI_CRU_BASE)
 #define RK3576_CCI_CLKSEL_CON(x)	((x) * 0x4 + RK3576_CCI_CRU_BASE + 0x300)
 #define RK3576_CCI_CLKGATE_CON(x)	((x) * 0x4 + RK3576_CCI_CRU_BASE + 0x800)
 #define RK3576_CCI_SOFTRST_CON(x)	((x) * 0x4 + RK3576_CCI_CRU_BASE + 0xa00)
 
-#define RK3576_BPLL_CON(x)		((x) * 0x4 + RK3576_BIGCORE_CRU_BASE)
 #define RK3576_BIGCORE_CLKSEL_CON(x)	((x) * 0x4 + RK3576_BIGCORE_CRU_BASE + 0x300)
 #define RK3576_BIGCORE_CLKGATE_CON(x)	((x) * 0x4 + RK3576_BIGCORE_CRU_BASE + 0x800)
 #define RK3576_BIGCORE_SOFTRST_CON(x)	((x) * 0x4 + RK3576_BIGCORE_CRU_BASE + 0xa00)
-#define RK3576_LPLL_CON(x)		((x) * 0x4 + RK3576_CCI_CRU_BASE)
 #define RK3576_LITCORE_CLKSEL_CON(x)	((x) * 0x4 + RK3576_LITCORE_CRU_BASE + 0x300)
 #define RK3576_LITCORE_CLKGATE_CON(x)	((x) * 0x4 + RK3576_LITCORE_CRU_BASE + 0x800)
 #define RK3576_LITCORE_SOFTRST_CON(x)	((x) * 0x4 + RK3576_LITCORE_CRU_BASE + 0xa00)
diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 92bde425b0ee..75b705ffba2f 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -44,19 +44,18 @@ static struct rockchip_pll_rate_table rk3576_24m_pll_rates[] = {
 
 static struct rockchip_pll_clock rk3576_pll_clks[] = {
 	[BPLL] = PLL(pll_rk3588, PLL_BPLL, RK3576_PLL_CON(0),
-		      RK3576_BPLL_MODE_CON0, 0, 15, 0,
-		      rk3576_24m_pll_rates),
+		     RK3576_BPLL_MODE_CON0, 0, 15, 0, rk3576_24m_pll_rates),
 	[LPLL] = PLL(pll_rk3588, PLL_LPLL, RK3576_LPLL_CON(16),
 		     RK3576_LPLL_MODE_CON0, 0, 15, 0, rk3576_24m_pll_rates),
 	[VPLL] = PLL(pll_rk3588, PLL_VPLL, RK3576_PLL_CON(88),
-		      RK3576_LPLL_MODE_CON0, 4, 15, 0, rk3576_24m_pll_rates),
+		     RK3576_MODE_CON0, 4, 15, 0, rk3576_24m_pll_rates),
 	[AUPLL] = PLL(pll_rk3588, PLL_AUPLL, RK3576_PLL_CON(96),
 		      RK3576_MODE_CON0, 6, 15, 0, rk3576_24m_pll_rates),
 	[CPLL] = PLL(pll_rk3588, PLL_CPLL, RK3576_PLL_CON(104),
 		     RK3576_MODE_CON0, 8, 15, 0, rk3576_24m_pll_rates),
 	[GPLL] = PLL(pll_rk3588, PLL_GPLL, RK3576_PLL_CON(112),
 		     RK3576_MODE_CON0, 2, 15, 0, rk3576_24m_pll_rates),
-	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3576_PMU_PLL_CON(128),
+	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3576_PHP_PLL_CON(128),
 		     RK3576_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
 		     rk3576_24m_pll_rates),
 };
@@ -320,8 +319,7 @@ static ulong rk3576_top_set_clk(struct rk3576_clk_priv *priv,
 		rk_clrsetreg(&cru->clksel_con[10],
 			     ACLK_TOP_MID_DIV_MASK |
 			     ACLK_TOP_MID_SEL_MASK,
-			     (ACLK_TOP_MID_SEL_GPLL <<
-			      ACLK_TOP_MID_SEL_SHIFT) |
+			     (src_clk << ACLK_TOP_MID_SEL_SHIFT) |
 			     (src_clk_div - 1) << ACLK_TOP_MID_DIV_SHIFT);
 		break;
 	case PCLK_TOP_ROOT:
@@ -429,7 +427,7 @@ static ulong rk3576_i2c_set_clk(struct rk3576_clk_priv *priv, ulong clk_id,
 		src_clk = CLK_I2C_SEL_200M;
 	else if (rate >= 99 * MHz)
 		src_clk = CLK_I2C_SEL_100M;
-	if (rate >= 50 * MHz)
+	else if (rate >= 50 * MHz)
 		src_clk = CLK_I2C_SEL_50M;
 	else
 		src_clk = CLK_I2C_SEL_OSC;
@@ -470,6 +468,7 @@ static ulong rk3576_i2c_set_clk(struct rk3576_clk_priv *priv, ulong clk_id,
 	case CLK_I2C8:
 		rk_clrsetreg(&cru->clksel_con[57], CLK_I2C8_SEL_MASK,
 			     src_clk << CLK_I2C8_SEL_SHIFT);
+		break;
 	case CLK_I2C9:
 		rk_clrsetreg(&cru->clksel_con[58], CLK_I2C9_SEL_MASK,
 			     src_clk << CLK_I2C9_SEL_SHIFT);
@@ -691,7 +690,7 @@ static ulong rk3576_adc_set_clk(struct rk3576_clk_priv *priv,
 		} else {
 			src_clk_div = DIV_ROUND_UP(priv->gpll_hz, rate);
 			assert(src_clk_div - 1 <= 255);
-			rk_clrsetreg(&cru->clksel_con[59],
+			rk_clrsetreg(&cru->clksel_con[58],
 				     CLK_SARADC_SEL_MASK |
 				     CLK_SARADC_DIV_MASK,
 				     (CLK_SARADC_SEL_GPLL <<
@@ -703,7 +702,7 @@ static ulong rk3576_adc_set_clk(struct rk3576_clk_priv *priv,
 	case CLK_TSADC:
 		src_clk_div = DIV_ROUND_UP(OSC_HZ, rate);
 		assert(src_clk_div - 1 <= 255);
-		rk_clrsetreg(&cru->clksel_con[58],
+		rk_clrsetreg(&cru->clksel_con[59],
 			     CLK_TSADC_DIV_MASK,
 			     (src_clk_div - 1) <<
 			     CLK_TSADC_DIV_SHIFT);
@@ -1715,7 +1714,7 @@ static ulong rk3576_uart_frac_set_rate(struct rk3576_clk_priv *priv,
 		p_rate = OSC_HZ;
 	} else {
 		clk_src = CLK_UART_SRC_SEL_GPLL;
-		p_rate = priv->cpll_hz;
+		p_rate = priv->gpll_hz;
 	}
 
 	rational_best_approximation(rate, p_rate, GENMASK(16 - 1, 0),
@@ -1843,7 +1842,7 @@ static ulong rk3576_uart_set_rate(struct rk3576_clk_priv *priv,
 		div = DIV_ROUND_UP(priv->gpll_hz, rate);
 	} else if (!(priv->cpll_hz % rate)) {
 		clk_src = CLK_UART_SEL_CPLL;
-		div = DIV_ROUND_UP(priv->gpll_hz, rate);
+		div = DIV_ROUND_UP(priv->cpll_hz, rate);
 	} else if (!(rk3576_uart_frac_get_rate(priv, CLK_UART_FRAC_0) % rate)) {
 		clk_src = CLK_UART_SEL_FRAC0;
 		div = DIV_ROUND_UP(rk3576_uart_frac_get_rate(priv, CLK_UART_FRAC_0), rate);
@@ -2458,7 +2457,7 @@ static int rk3576_clk_probe(struct udevice *dev)
 	       RK3576_SCRU_BASE + RK3576_MODE_CON0);
 	/* fix ppll\aupll\cpll */
 	writel(BITS_WITH_WMASK(2, 0x7U, 6),
-	       RK3576_CRU_BASE + RK3576_PMU_PLL_CON(129));
+	       RK3576_CRU_BASE + RK3576_PHP_PLL_CON(129));
 	writel(BITS_WITH_WMASK(2, 0x7U, 6),
 	       RK3576_CRU_BASE + RK3576_PLL_CON(97));
 	writel(BITS_WITH_WMASK(2, 0x7U, 6),
-- 
2.54.0

