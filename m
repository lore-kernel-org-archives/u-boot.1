Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290C8C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 17:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4AF182161;
	Mon,  5 May 2025 18:59:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="NOlWMIRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9C2582ACF; Mon,  5 May 2025 18:59:30 +0200 (CEST)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7623E82A65
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 18:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4ZrnnB3FLtzDqRS;
 Mon,  5 May 2025 16:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1746464366; bh=Ir9w9Jh02S+uuSUBBj3TeKu2twN0ygUaezkvHhPmhlA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=NOlWMIRlwGcQyD0RqlWFc2Bue8wB71U2tlMgHrKzOICWcWjwvpuoiBWFpc/C5xR02
 4DPFk0LCJlt6fT+e/J55PmZXfOctOxw/5OojCyLGUtE36EmlukMPHPPh4leRXwAT+2
 cNRh7nJ6iRVg4ttje/A5qFnQDvU19YN99ZwhBc2w=
X-Riseup-User-ID: 06BF2E8C32C6540D764F2ACCAACB8DDC10DE9051EDF12598DF281E10D470C3B8
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Zrnn704kzzJsNx;
 Mon,  5 May 2025 16:59:22 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Mon, 05 May 2025 23:58:28 +0700
Subject: [PATCH v4 12/12] clk: rockchip: rk3568: Use assigned VPLL clock
 when possible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-vop2-pt2-v4-12-3b7c3ab1a617@riseup.net>
References: <20250505-vop2-pt2-v4-0-3b7c3ab1a617@riseup.net>
In-Reply-To: <20250505-vop2-pt2-v4-0-3b7c3ab1a617@riseup.net>
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>, 
 Dragan Simic <dsimic@manjaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de, 
 Piotr Zalewski <pZ010001011111@proton.me>, Dang Huynh <danct12@riseup.net>
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

This matches how VPLL is configured under Linux and avoid weird
behaviors when VPLL is reconfigured under Linux.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 drivers/clk/rockchip/clk_rk3568.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 533031caead6818fe41774c9efee969fdd428dbc..cd0e24d77dcc5ce69b75f23eb6d62582b452a986 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -1820,7 +1820,11 @@ static ulong rk3568_dclk_vop_set_clk(struct rk3568_clk_priv *priv,
 			     ((div - 1) << DCLK0_VOP_DIV_SHIFT));
 		rk3568_pmu_pll_set_rate(priv, HPLL, div * rate);
 	} else if (sel == DCLK_VOP_SEL_VPLL) {
-		div = DIV_ROUND_UP(RK3568_VOP_PLL_LIMIT_FREQ, rate);
+		if (priv->vpll_hz)
+			div = DIV_ROUND_UP(priv->vpll_hz, rate);
+		else
+			div = DIV_ROUND_UP(RK3568_VOP_PLL_LIMIT_FREQ, rate);
+
 		rk_clrsetreg(&cru->clksel_con[conid],
 			     DCLK0_VOP_DIV_MASK | DCLK0_VOP_SEL_MASK,
 			     (DCLK_VOP_SEL_VPLL << DCLK0_VOP_SEL_SHIFT) |

-- 
2.49.0

