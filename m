Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83EDFCC9A5
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 01:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DB6C839DF;
	Tue, 10 Mar 2026 02:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="htN8Ox5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E33E883F82; Tue, 10 Mar 2026 02:00:49 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0BEA80050
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 02:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2964=BK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1773104446;
 bh=n87j95uX/SG10aFt/k9ZPtHUbYYyE+3UkxZEHCMLlpo=;
 b=htN8Ox5kPM6RxQMOTxUjFdP2Awxkx2TA9gFQqwLqqsvM0/J1FrEMtuJXzdkSL1/sq+ObV3b2T
 B6kYke2bHkuK9BA19RwSmbO8eWrSdmL7VlQpkkw0aHo8VU4OstncpetWcMmvW5c+gDFqgKAITOV
 hVx+yyDoW+Dra2lnJF0Tlu1q5/myRpawNjm9MaPCQwLiIuQz59WXYAx14Vb8gYr2bovx4GF6Ugv
 wYRnviWkN2aEZP5wWz293Mu9CqqLpaaezvTSaB/lzywUNHTl1M+gcbVBb4BXRSVlaXXd1ivJ5Vs
 e+AUBudcNJqorbY/sCViiToRx3drIs8K9kUrFPSgClJA==
X-Forward-Email-ID: 69af6d3df9d342db2bc2b146
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.6.49
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH] clk: rockchip: rk3528: Add CLK_REF_USB3OTG support
Date: Tue, 10 Mar 2026 01:00:39 +0000
Message-ID: <20260310010041.611322-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The CLK_REF_USB3OTG clock is used as reference clock for the DWC3 block.

Add simple support to get rate of CLK_REF_USB3OTG clock to fix reference
clock period configuration.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This fixes the ref_clk issue on RK3528 that is also fixed by "usb: dwc3:
core: Use IS_ERR_VALUE() for ref_clk rate check" [1].
---
 drivers/clk/rockchip/clk_rk3528.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
index d58557ff56de..e1a84b38ad87 100644
--- a/drivers/clk/rockchip/clk_rk3528.c
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -1337,6 +1337,7 @@ static ulong rk3528_clk_get_rate(struct clk *clk)
 					     DPLL);
 		break;
 
+	case CLK_REF_USB3OTG:
 	case TCLK_EMMC:
 	case TCLK_WDT_NS:
 		rate = OSC_HZ;
@@ -1457,6 +1458,7 @@ static ulong rk3528_clk_set_rate(struct clk *clk, ulong rate)
 		priv->ppll_hz = rockchip_pll_get_rate(&rk3528_pll_clks[PPLL],
 						      priv->cru, PPLL);
 		break;
+	case CLK_REF_USB3OTG:
 	case TCLK_EMMC:
 	case TCLK_WDT_NS:
 		return (rate == OSC_HZ) ? 0 : -EINVAL;
-- 
2.53.0

