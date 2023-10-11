Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02397CD6E54
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 10:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89AD486D4D;
	Wed, 11 Oct 2023 12:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="WLKOwK9K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 129F986D07; Wed, 11 Oct 2023 12:30:47 +0200 (CEST)
Received: from mail-m127217.xmail.ntesmail.com
 (mail-m127217.xmail.ntesmail.com [115.236.127.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53AFC86D05
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 12:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhangqing@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=WLKOwK9KrYKxE7OULh33GXTFpBbKcBmYBfNCVvscNXbbG2WZN25CSqbu+a9Uybh8yUAHq4SCM0gMM1UfJ6jVAfLGIrP+sj7ZYLyBU7DXelbZzJaABzw3QUxj9LJnu4Q58Q8qdLejDOyh1VZM+Eym8xzQ6pB+k9t5U17lhsBnwJY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=xbdqYtpTXUxPsnxinTWD2fJqVYnD1l1paMVT2jJtYGc=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m118115.qiye.163.com (Hmail) with ESMTPA id 06997AA02EE;
 Wed, 11 Oct 2023 18:29:51 +0800 (CST)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: lukma@denx.de, seanga2@gmail.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de, chenjh@rock-chips.com,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 1/5] clk: rockchip: rk3568: support dclk_vop select more
 parent clks
Date: Wed, 11 Oct 2023 18:29:43 +0800
Message-Id: <20231011102947.21188-2-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231011102947.21188-1-zhangqing@rock-chips.com>
References: <20231011102947.21188-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR4fSlZISkJKQ0hKSksYTE5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8b1e4921d32ec3kusn06997aa02ee
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQw6Agw4Ejw5CBY#Hx8vFTEZ
 AixPCSFVSlVKTUJMS0lLSkJKTENOVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
 C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlNSE03Bg++
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

For dclk_vop to support more frequencies.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk_rk3568.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 599b7b130eb9..68f5bbbb9e57 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -1838,7 +1838,7 @@ static ulong rk3568_dclk_vop_set_clk(struct rk3568_clk_priv *priv,
 		rockchip_pll_set_rate(&rk3568_pll_clks[VPLL],
 				      priv->cru, VPLL, div * rate);
 	} else {
-		for (i = 0; i <= DCLK_VOP_SEL_CPLL; i++) {
+		for (i = sel; i <= DCLK_VOP_SEL_CPLL; i++) {
 			switch (i) {
 			case DCLK_VOP_SEL_GPLL:
 				pll_rate = priv->gpll_hz;
@@ -2785,9 +2785,15 @@ static int rk3568_dclk_vop_set_parent(struct clk *clk, struct clk *parent)
 	if (parent->id == PLL_VPLL) {
 		rk_clrsetreg(&cru->clksel_con[con_id], DCLK0_VOP_SEL_MASK,
 			     DCLK_VOP_SEL_VPLL << DCLK0_VOP_SEL_SHIFT);
-	} else {
+	} else if (parent->id == PLL_HPLL) {
 		rk_clrsetreg(&cru->clksel_con[con_id], DCLK0_VOP_SEL_MASK,
 			     DCLK_VOP_SEL_HPLL << DCLK0_VOP_SEL_SHIFT);
+	} else if (parent->id == PLL_CPLL) {
+		rk_clrsetreg(&cru->clksel_con[con_id], DCLK0_VOP_SEL_MASK,
+			     DCLK_VOP_SEL_CPLL << DCLK0_VOP_SEL_SHIFT);
+	} else {
+		rk_clrsetreg(&cru->clksel_con[con_id], DCLK0_VOP_SEL_MASK,
+			     DCLK_VOP_SEL_GPLL << DCLK0_VOP_SEL_SHIFT);
 	}
 
 	return 0;
-- 
2.17.1

