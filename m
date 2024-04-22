Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075A0C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56BA288333;
	Mon, 22 Apr 2024 08:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="w1T7R63V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B0568832D; Mon, 22 Apr 2024 08:30:13 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A287888333
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767393; bh=FMU7XpN4tet/SJb0h4t4DDKVZB7yk3eDGo1nmEOuzy8=;
 b=w1T7R63VoR2F9T7mb1gMhDy8wYqg/yWYCGe2Hh+ATXPDGaEqKPT7YpLBWFfJCd3YObRwa5OjY
 wOUmThGyino++K35Cubo4b6g6D23vl4Si3nTwXPLv42zp4cVyw/DxMFf1qTUkILp/JIyI7iQE8x
 wCJHwF41J5jIQrjvQcc9W79YhsYMXyRmwAILgn6s49TUpn9j0Ldfj8TmuoIgSQbtLKFS8HyNiB1
 XxG1BPY/Q5jCQO3HAEIsr8C6TSF9oTlka3iRlTz13L4PRLptaTbCo87isXTWtlzoYQ2cRawsdUv
 7xvgkxYZmVBwnWHewDiW/srYSJ5pSu97yj67XNXDkO/w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 03/28] clk: rockchip: rk356x: Fix set rate of SCLK_SFC clock
Date: Mon, 22 Apr 2024 06:28:40 +0000
Message-ID: <20240422062936.681359-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422062936.681359-1-jonas@kwiboo.se>
References: <20240422062936.681359-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 662603e134ba165ad4474290
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

The SCLK_SFC can be set to a rate of 24, 50, 75, 100, 125 or 150 MHz.

However, clk_set_rate() will fail unless one of those exact rates are
used, and with newer and updated device tree files that contain
spi-max-frequency values that does not exactly match these rates use of
SPI flash may fail.

Fix this by using the highest possible rate that exceeds or is equal to
the requested rate.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: New patch
---
 drivers/clk/rockchip/clk_rk3568.c | 32 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 999f48ea4b4e..24eeca8bf265 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -1527,28 +1527,20 @@ static ulong rk3568_sfc_set_clk(struct rk3568_clk_priv *priv, ulong rate)
 	struct rk3568_cru *cru = priv->cru;
 	int src_clk;
 
-	switch (rate) {
-	case OSC_HZ:
-		src_clk = SCLK_SFC_SEL_24M;
-		break;
-	case 50 * MHz:
-		src_clk = SCLK_SFC_SEL_50M;
-		break;
-	case 75 * MHz:
-		src_clk = SCLK_SFC_SEL_75M;
-		break;
-	case 100 * MHz:
-		src_clk = SCLK_SFC_SEL_100M;
-		break;
-	case 125 * MHz:
-		src_clk = SCLK_SFC_SEL_125M;
-		break;
-	case 150 * MHz:
+	if (rate >= 150 * MHz)
 		src_clk = SCLK_SFC_SEL_150M;
-		break;
-	default:
+	else if (rate >= 125 * MHz)
+		src_clk = SCLK_SFC_SEL_125M;
+	else if (rate >= 100 * MHz)
+		src_clk = SCLK_SFC_SEL_100M;
+	else if (rate >= 75 * MHz)
+		src_clk = SCLK_SFC_SEL_75M;
+	else if (rate >= 50 * MHz)
+		src_clk = SCLK_SFC_SEL_50M;
+	else if (rate >= OSC_HZ)
+		src_clk = SCLK_SFC_SEL_24M;
+	else
 		return -ENOENT;
-	}
 
 	rk_clrsetreg(&cru->clksel_con[28],
 		     SCLK_SFC_SEL_MASK,
-- 
2.43.2

