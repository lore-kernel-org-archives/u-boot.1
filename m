Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E87C61CE8
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 05:45:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9230E82BC1;
	Sat,  7 Jun 2025 07:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="FW7OLVp5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8360F807B1; Sat,  7 Jun 2025 07:44:00 +0200 (CEST)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 717AC82BF6
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 07:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4bDnDX5V3Hz9twc;
 Sat,  7 Jun 2025 05:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1749275036; bh=Ir9w9Jh02S+uuSUBBj3TeKu2twN0ygUaezkvHhPmhlA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=FW7OLVp5wAN5vVANwodedbVeHv0o/FV6q+Qo6p6/6WWriucHjiKmcn3A2W16hyXX+
 dnkmHS/1BtqwE+2LICVPqXvKgB0m8hSmCsix/shGSMqTIKI/rzjxG9Bz9bu/5d3E+u
 gOvYGiWWhyb3aEFct/ZIau2jmxU8wKI3WIq20Tgo=
X-Riseup-User-ID: B90767FC076E33823D74DBE0815F3816CD12595BEEB8A0E05433EA2B8BDA27DE
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4bDnDT3LxLzJn12;
 Sat,  7 Jun 2025 05:43:53 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Sat, 07 Jun 2025 12:43:11 +0700
Subject: [PATCH v5 12/12] clk: rockchip: rk3568: Use assigned VPLL clock
 when possible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250607-vop2-pt2-v5-12-1d52f7a2cf3c@riseup.net>
References: <20250607-vop2-pt2-v5-0-1d52f7a2cf3c@riseup.net>
In-Reply-To: <20250607-vop2-pt2-v5-0-1d52f7a2cf3c@riseup.net>
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

