Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFF0C531F8
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB9CC60A67;
	Thu, 23 Jul 2026 15:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pb3m06zZAu1M; Thu, 23 Jul 2026 15:05:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BADBA60A46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819107;
	bh=RF4R1X93RDLF5TIXFs9CZYyA/1oJZ1MwcTp+RnbXmvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cinUZJwyrgh7MKel/1d96VVnMUlcXOjNrucWqSNB13mLCsTHnEN0V+iUr9OCP6hxh
	 Uu3OW5vozznjN74OdJ21jyJMldaWGiaw3bH2Pt6FTJSnXh7jkPdLSTB4EvdHg+n3fu
	 e3vZeM/usPY3BXv++0UmsZzwkGsLW/kQrSSyofk65D9mp7MnahgZaIQEvJWxkoOPCO
	 By/BXsfvNOhGozZSmWAerUETM8N/3zm4POqm7pcd72CCF3mzqtKPAv6zHVmRdOxlmh
	 6KCAbUFCSKiUogcdLLwW8kFOba0JOUlOj4R7VPgQAjxV9PWQa/AE++zPMto8pFwW3k
	 5kk029ryb9J7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BADBA60A46;
	Thu, 23 Jul 2026 15:05:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BAE98390
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD184403DE
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:05:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hYd5Ihi1vtrT for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 15:05:04 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5BF7F401DD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5BF7F401DD
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5BF7F401DD
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:05:04 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 998E580287; Thu, 23 Jul 2026 17:05:02 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1981380087
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 17:05:00 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c167bda216fso108166166b.2
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 08:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784819099; x=1785423899;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RF4R1X93RDLF5TIXFs9CZYyA/1oJZ1MwcTp+RnbXmvc=;
 b=A5e8wU5fcdyATz3ltnSWhv5/vXLL6TFwP8PX3LaehsLOZk3W41B8HakryfDoQyYhtC
 Vf5bP1wKHcDtalAPJAOOjXWiXUUh6RWwOAALTjzh1Omr+4I7evpLDM6PlhUU6AGhjKuU
 FiSbvds33FC4ICf/6n6/hGDqVyD5sMUiAruqA7aJ2AOeqMjc2sQi420/Fr2Zc50cTQtX
 Hijra4Rvnwtun/n9kXuXH3+zNB6ghZQE3R47sTBozkQKhqjSI/rjnMqy3k02xPxmbJf4
 h54FpOoUBi8cjLiDIfJ3XsbPQ1f/Uh23NQsGzPRzq2Yoyl8H31A+SepJcisxfT0HnZ1b
 QA8g==
X-Gm-Message-State: AOJu0Yz/+T91QLrDLNyqeF5RWRte5gmNYeCP0Ca6MFUH9uZRxAmWZf7+
 ZPfeoGwIXYND4Ds6sMtD0CuXntRO0u0zfUTODnEE/l2zkOMEtOx8hF5IE0NYgQOtcW8=
X-Gm-Gg: AR+sD13WaziEso0HOBmf3MgUoTcrDa+Z8vm1Gy8WMwM54PCOQeB7FNqrql9iuhedJ9k
 B7vgBsfmUGVmto1WeiEI6Htb1mb8Ec5+K8VswXQxbKsYhWqTszwL3i2dyyBc7uOSgvryZDU2v0x
 qP7Tu5RUxLVbXdZWPXyqHJ8iUBka+5TFVIOisqk7fmHddvbVCmOXDKwaHfNVBsjG/S1C9Arhnip
 c5UsQU8U+Oj40Oev3mIqNNP5m7r5sVIJU4tNp28BnX58fJ2/Hwd003ezyxsnw5hJCJhda01MEHV
 x4GvEZCigckx8zP1oznps5/XcKbPznEavdmP4jcVkEz84MaaGU/glXKMn7u4WStbwKqeKTLz6eh
 HUwd7dAtFteyuMKyX/5gHrlDksdESKuW/UDys5qArTpeN22aLR47r0vBqyZzPYJNduiB0oWW4DE
 8pQWeO6gZDl3f20AekNptHdA==
X-Received: by 2002:a17:907:78d:b0:c1c:28e5:652e with SMTP id
 a640c23a62f3a-c1c509cf853mr147216166b.25.1784819099227; 
 Thu, 23 Jul 2026 08:04:59 -0700 (PDT)
Received: from alchark-surface.localdomain ([193.32.126.214])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32f1127fsm248769566b.55.2026.07.23.08.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 08:04:58 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 23 Jul 2026 19:04:27 +0400
Subject: [PATCH v2 5/5] clk: rockchip: pll: fix overflow and drop manual
 two's complement on RK3588/RK3576
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-rk3588-fracpll-v2-5-382d113f3a80@flipper.net>
References: <20260723-rk3588-fracpll-v2-0-382d113f3a80@flipper.net>
In-Reply-To: <20260723-rk3588-fracpll-v2-0-382d113f3a80@flipper.net>
To: u-boot@lists.denx.de, Elaine Zhang <zhangqing@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3972; i=alchark@flipper.net;
 h=from:subject:message-id; bh=G0vN2poFWotueIWZNMZBSD/h2L3ULjnc2bbXxPW9wTc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQl6da0Jpzed0plp6d/3qIDSkv7WaIv5S+5fuFYg1JBs
 eC3xistHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEx1qy8jw68NJd2WNy99cVZfsVnoksahDv3YSe9aMo42ci8y12h8asPwP2br25A
 FxmoC5h7vD32RsfCRiVWe+vKY/9P51z/ey37iwgcA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1784819099; x=1785423899; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RF4R1X93RDLF5TIXFs9CZYyA/1oJZ1MwcTp+RnbXmvc=;
 b=nSVa6RmbJWoXyXZle5ogaOn9KmHavozG7C+Cq+zMzCCYwTM6R6hzzUV2i5isoRmdxr
 4B2Qed1Qn2VLjlWuDc14seaawDaUCei/KH0PznU2wD/q8V4m9sL1RNfb/dVaDk57v7yn
 sVNwBPf4mW+eRAbbciAGI3M1V3seXV7nBH7WQz7uR9vD4cJxuK+Bhxm+1YN4B6kRiHz3
 nybmDY6xa+LIONL13Oug8gAmIHjQlJWYMWJgPNGBt3/etKVTVHQx/GQr8wz2gPMfu7RE
 fiNkYsw4akhRnciU2q4bIvB+tWZcJbTqhinntizvmQJymuFBhUZdXbeLuZ1jUt8oE8BJ
 HSNA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=nSVa6Rmb
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="nSVa6Rmb"; 
 dkim-atps=neutral
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

The TRM defines the fractional PLL adjustment coefficient as a signed
two's complement number, 16 bits wide, so store and use it as such to
avoid confusion and enable proper signed arithmetics, promoting operands
with automatic sign extension.

This also fixes an overflow when the current rk3588_pll_get_rate
calculates the fractional component in 32 bits before assigning it to a
64-bit holding variable, given that OSC_HZ is 24000000U and k can be from
-32768 to 32767.

Fixes: b851c006a150 ("clk: rockchip: pll: Add pll_rk3588 type for rk3588")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/arm/include/asm/arch-rockchip/clock.h |  8 +++---
 drivers/clk/rockchip/clk_pll.c             | 43 +++++++++++++-----------------
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
index 95b08bfd046f..8d3819778eb1 100644
--- a/arch/arm/include/asm/arch-rockchip/clock.h
+++ b/arch/arm/include/asm/arch-rockchip/clock.h
@@ -101,10 +101,10 @@ struct rockchip_pll_rate_table {
 	unsigned int dsmpd;
 	unsigned int frac;
 	/* for RK3588 */
-	unsigned int m;
-	unsigned int p;
-	unsigned int s;
-	unsigned int k;
+	unsigned int m;	/* main divider, 10 bit unsigned */
+	unsigned int p;	/* pre-divider, 6 bit unsigned */
+	unsigned int s;	/* scaler, 3 bit unsigned */
+	s16 k;		/* fractional part, 16 bit two's complement */
 };
 
 enum rockchip_pll_type {
diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 94d30ccb1425..f677525bba22 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -167,22 +167,34 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
 	return rate_table;
 }
 
+/*
+ * 2250 MHz <= Fvco <= 4500 MHz
+ * For Fvco > 3 GHz: period jitter +-1% frac PLL, +-0.75% int PLL
+ * For Fvco < 3 GHz: period jitter +-2% frac PLL, +-1.50% int PLL
+ * Fvco = ((m + k / 65536) * Fin) / p
+ * Fout = ((m + k / 65536) * Fin) / (p * 2^s)
+ * Fref = Fin / p
+ * -32768 <= k <= 32767 (only available in frac PLLs, not int PLLs)
+ */
 static void
 rockchip_rk3588_pll_k_get(struct rockchip_pll_rate_table *rate_table, u64 fref, u64 fvco)
 {
 	u64 ffrac;
-	u32 k = 0;
+	int k;
 
 	ffrac = fvco - (rate_table->m) * fref;
 	k = ffrac * 65536 / fref;
 	if (k > 32767) {
+		/*
+		 * The requested rate is closer to the next integer multiplier
+		 * m, so pick it and use a negative fractional coefficient k
+		 */
 		rate_table->m += 1;
 		ffrac = (rate_table->m) * fref - fvco;
 		/*
 		 * Round up to avoid overshooting requested rate for negative k
 		 */
-		k = DIV64_U64_ROUND_UP(ffrac * 65536, fref);
-		k = ~k + 1;
+		k = -(int)DIV64_U64_ROUND_UP(ffrac * 65536, fref);
 	}
 	rate_table->k = k;
 }
@@ -549,9 +561,10 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
 static ulong rk3588_pll_get_rate(struct rockchip_pll_clock *pll,
 				 void __iomem *base, ulong pll_id)
 {
-	u32 m, p, s, k;
+	u32 m, p, s;
 	u32 con = 0, shift, mode;
-	u64 rate, postdiv;
+	u64 rate;
+	s16 k;
 
 	con = readl(base + pll->mode_offset);
 	shift = pll->mode_shift;
@@ -578,25 +591,7 @@ static ulong rk3588_pll_get_rate(struct rockchip_pll_clock *pll,
 
 		rate = OSC_HZ / p;
 		rate *= m;
-		if (k & BIT(15)) {
-			/* fractional mode */
-			u64 frac_rate64;
-
-			k = (~(k - 1)) & RK3588_PLLCON2_K_MASK;
-			frac_rate64 = OSC_HZ * k;
-			postdiv = p;
-			postdiv *= 65536;
-			do_div(frac_rate64, postdiv);
-			rate -= frac_rate64;
-		} else {
-			/* fractional mode */
-			u64 frac_rate64 = OSC_HZ * k;
-
-			postdiv = p;
-			postdiv *= 65536;
-			do_div(frac_rate64, postdiv);
-			rate += frac_rate64;
-		}
+		rate += div_s64((s64)OSC_HZ * k, p * 65536);
 		rate = rate >> s;
 		return rate;
 	case RKCLK_PLL_MODE_DEEP:

-- 
2.54.0

