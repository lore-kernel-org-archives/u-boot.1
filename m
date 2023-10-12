Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59157CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 10:18:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAA6086D0C;
	Thu, 12 Oct 2023 12:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ibiU4Hnp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB5AD86D1F; Thu, 12 Oct 2023 12:18:50 +0200 (CEST)
Received: from mail-m127158.xmail.ntesmail.com
 (mail-m127158.xmail.ntesmail.com [115.236.127.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B7DD86CF3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 12:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhangqing@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ibiU4HnpJwgU5W9CGos369QQIeVLXkMsgLyAxlYwqbECuvMTBZwizhLl27LaccfAnq6r8wsK9RAhqW1OJT1cTnlntiqgcd5VMGsTEUaX73HyEMrjokHEUuvL7gBRaP0XmCwmaPpY4oEaz5uWgzRzXn3AUUKLPaq+hqPNvVX7KgE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=oU88Tj2ZxlrlKkM1peVO0YFzAq3yxfgknQcmgq759Xs=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id B8CCB40037D;
 Thu, 12 Oct 2023 18:18:13 +0800 (CST)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: lukma@denx.de, seanga2@gmail.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de, chenjh@rock-chips.com,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 4/5] clk: rockchip: rk3588: Avoid re-setting the pll rate
 of dclk_vop's parent
Date: Thu, 12 Oct 2023 18:18:12 +0800
Message-Id: <20231012101812.27142-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231011102947.21188-1-zhangqing@rock-chips.com>
References: <20231011102947.21188-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUJDH1ZPGhlDTUkaQx4fQklVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8b2364da3c2eb3kusnb8ccb40037d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pyo6Mjo*HDw8KgsSCisoT08S
 SBIaCjFVSlVKTUJMSktOQ0JPTUtCVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
 C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlMTkk3Bg++
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

Optimize setting process.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk_rk3588.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 7ba037ad72ba..a995dd5591d3 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -1130,13 +1130,23 @@ static ulong rk3588_dclk_vop_set_clk(struct rk3588_clk_priv *priv,
 	}
 
 	if (sel == DCLK_VOP_SRC_SEL_V0PLL) {
-		div = DIV_ROUND_UP(RK3588_VOP_PLL_LIMIT_FREQ, rate);
-		rk_clrsetreg(&cru->clksel_con[conid],
-			     mask,
-			     DCLK_VOP_SRC_SEL_V0PLL << sel_shift |
-			     ((div - 1) << div_shift));
-		rockchip_pll_set_rate(&rk3588_pll_clks[V0PLL],
-				      priv->cru, V0PLL, div * rate);
+		pll_rate = rockchip_pll_get_rate(&rk3588_pll_clks[V0PLL],
+						 priv->cru, V0PLL);
+		if (pll_rate >= RK3588_VOP_PLL_LIMIT_FREQ && pll_rate % rate == 0) {
+			div = DIV_ROUND_UP(pll_rate, rate);
+			rk_clrsetreg(&cru->clksel_con[conid],
+				     mask,
+				     DCLK_VOP_SRC_SEL_V0PLL << sel_shift |
+				     ((div - 1) << div_shift));
+		} else {
+			div = DIV_ROUND_UP(RK3588_VOP_PLL_LIMIT_FREQ, rate);
+			rk_clrsetreg(&cru->clksel_con[conid],
+				     mask,
+				     DCLK_VOP_SRC_SEL_V0PLL << sel_shift |
+				     ((div - 1) << div_shift));
+			rockchip_pll_set_rate(&rk3588_pll_clks[V0PLL],
+					      priv->cru, V0PLL, div * rate);
+		}
 	} else {
 		for (i = 0; i <= DCLK_VOP_SRC_SEL_AUPLL; i++) {
 			switch (i) {
-- 
2.17.1

