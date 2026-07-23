Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23F3C531D1
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:05:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 928B0409D2;
	Thu, 23 Jul 2026 15:05:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3HDK_b3PAGCL; Thu, 23 Jul 2026 15:05:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A8FFA409E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819102;
	bh=gluQf3Djp+Po1jvpu6kCqFnNTAgivzl3dLBpboGagVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GC20pc/zgTeYhwjEpY0pmp2CGrR6EPHlpw2CIQmBizycLrLXGVQ6/y56etY28aGI/
	 EJK2usA8jgQZIx2uONX+cnurZdp2Y1Inxv3ayB4EQTuv1PkrxzTlAy3kHLOJM+V4ky
	 c6tOsNcd6iEr7YrUAyTVf+HHxEOpfAWgt9yg9jpaVdqaorQM3pttZOuEvF6SV3oaHO
	 Pr9gmOQpk+THThFomEylYQBJgIXzyNdvWZu268z72/EvPiD1exX6mdFMt63r8WcpfW
	 z70003rSgNJ4V8SAGqU0GnjJq6mpDITUzK90iz1hatCyPYHPBu9ihYpteL14HA4CP3
	 m+xCEKTEjpgBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8FFA409E5;
	Thu, 23 Jul 2026 15:05:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DA213B0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F72F403DE
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:05:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fgZ06N7_rfCQ for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 15:04:59 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5117B4020F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5117B4020F
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5117B4020F
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:04:59 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C56B780287; Thu, 23 Jul 2026 17:04:57 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB0D080087
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 17:04:55 +0200 (CEST)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c15e03c2763so104591566b.0
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 08:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784819095; x=1785423895;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gluQf3Djp+Po1jvpu6kCqFnNTAgivzl3dLBpboGagVE=;
 b=ilx/4KUn2bLwTzkQKKjntFGwavl6eil0I4i2Vfv+xwmp2YVZIaDqZHa/Nu1pVfVwJy
 NRdtASNhAQvFw56/TAqgH4L4qQuOvQ/sxAts5CgzB8ffH56NEFQa3/PLeCl/sFpKFudd
 j3HGEEjQ/k/AghrHdOtegsyuysnRWn0+H1berr2mY5j0ANIK1G1cT40sKhcnaCaDVOQr
 3R7j9qh2Zpglvl8Eh0aVqKy+kb1uQ2aJMudaeTNtRuC4664gbyYMxJeLMSjq+N3aHFXe
 hRQhsLzTAJ6xY+M5XkrgNqtrv1yfkcB7sphNvAYP2aQgxhvrydgixAcrMJUY77Wf4w6l
 3qqA==
X-Gm-Message-State: AOJu0YysJywFCIvBiFYItwsKrHI16HZ49e2yilLd+vdT8R4Ou6ltotK3
 GGoOrXpEa4VBS1PRoqOJ9lHIDZUEuYKMowfQ1UeE6/6hRHtDi8++ud7ldsfGFgTNg54=
X-Gm-Gg: AR+sD13+7of5wQWR0O6J59ys/xHPsjuhwWMZmbi7rxCNQS++tOSlqqx9Lrh+qplHXwk
 9MUy5R+rUWcCLWavP+K/+FIskcQRNB2bqO6IdXeJRasSf6yqOO+NX9FBYWKd56QENjhjn6k1eQA
 Q5P8F1w7+ltOLLlxHK49v4Buu9exN5hGFCY6ERD7ambFl1bcZyGHbAOygMtZn7omR4oOq/N/WRC
 OxqaicJU4JAgo0WYKywo3SWH9eIt90795famcG/ZZCfofUfYmuZ5bEHYMZz+MyQ9L/TdskVi3iV
 7ZkCcGWn/xRunDF82k8yk6lFnVYcKswLKfQuT+y71FCORF3mjVq39ZQ83wypw1ybujEGHRHHays
 6oluClGJtZTlPliPiVMG7mHzfN+PMVV9PS6mcH0zZ+7uHOZaqDG0z1M+oN25DRmqlbX7MF2OpDA
 5b2ZJmDNJ0RLbnTroyvVPpB341vHihtw2g
X-Received: by 2002:a17:907:3e92:b0:c08:5bdb:e904 with SMTP id
 a640c23a62f3a-c1c536bebadmr171337766b.9.1784819095168; 
 Thu, 23 Jul 2026 08:04:55 -0700 (PDT)
Received: from alchark-surface.localdomain ([193.32.126.214])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32f1127fsm248769566b.55.2026.07.23.08.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 08:04:53 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 23 Jul 2026 19:04:26 +0400
Subject: [PATCH v2 4/5] clk: rockchip: pll: let rockchip_rk3588_pll_k_get
 update m directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-rk3588-fracpll-v2-4-382d113f3a80@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2530; i=alchark@flipper.net;
 h=from:subject:message-id; bh=5iRP/gYDRYDdn8zps7urfvniGSutNZR0Q+/5uF6MFM0=;
 b=kA0DAAoWsqLYjxBZ1KUByyZiAGpiLXug///gc2UL5qf3v1FT7L+g2JbunSkdcfNXGQDnfXSde
 oiRBAAWCgA5FiEEnfakPZUyDpq6SEj1sqLYjxBZ1KUFAmpiLXsbFIAAAAAABAAObWFudTIsMi41
 KzEuMTIsMywyAAoJELKi2I8QWdSljiUA/3szjZEWrA83zZN7B+vz40/FFaZRsKDUJV2cdB8/A9k
 AAP9bDy4VQNO7D7WBQtPDYvI/YQ9Q5O2u69DQqqIDkmwhCg==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1784819095; x=1785423895; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gluQf3Djp+Po1jvpu6kCqFnNTAgivzl3dLBpboGagVE=;
 b=jO4bkvhKb+ZKsNOwEjKAvgEk9tF0SsZv8eWr0m+wqCkBAxEq54FesyMpPavGeq/WJG
 BkNdkJLo02UJlGHdMAe9HcbQIKhuus/Hi+3Y6PaCsNMPmqwZEkEn/XfaHyzhWrkl1T1/
 7jOqMVDdQmj7G+P7PS8mjMTVteKMHJGti6SgR7AoEw27qOqdc502O0Vv+RgegjV3wgDw
 gDUvlFfUA4tzIp9N/j+yylD7PZUAAlxLWwMwbRJoc1dTcJkOJAkBD3gUp1aC0xSsgsp1
 KKFsEQh68/1vR2bG4eyPsa0bbIhNzFwSRVFoVsD7hCRZcQGI4zaLDV0mfVD0iX2dZEQc
 uIrQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=jO4bkvhK
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="jO4bkvhK"; 
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

Selecting the next integer multiplier m is coupled to setting a negative
fractional coefficient k. The current code checks for negative k in two
separate places, which is error-prone.

Let rockchip_rk3588_pll_k_get update m directly, to make it the single
source of truth for the final value of the integer multiplier m, which
also reduces the number of scattered conditional branches in the code.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/clk/rockchip/clk_pll.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 6cef5a36ccfe..94d30ccb1425 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -167,31 +167,31 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
 	return rate_table;
 }
 
-static u32
-rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64 fin_hz, u64 fvco)
+static void
+rockchip_rk3588_pll_k_get(struct rockchip_pll_rate_table *rate_table, u64 fref, u64 fvco)
 {
-	u64 fref, ffrac;
+	u64 ffrac;
 	u32 k = 0;
 
-	fref = fin_hz / p;
-	ffrac = fvco - (m * fref);
+	ffrac = fvco - (rate_table->m) * fref;
 	k = ffrac * 65536 / fref;
 	if (k > 32767) {
-		ffrac = ((m + 1) * fref) - fvco;
+		rate_table->m += 1;
+		ffrac = (rate_table->m) * fref - fvco;
 		/*
 		 * Round up to avoid overshooting requested rate for negative k
 		 */
 		k = DIV64_U64_ROUND_UP(ffrac * 65536, fref);
 		k = ~k + 1;
 	}
-	return k;
+	rate_table->k = k;
 }
 
 static struct rockchip_pll_rate_table *
 rockchip_rk3588_pll_frac_by_auto(unsigned long fin_hz, unsigned long fout_hz)
 {
 	struct rockchip_pll_rate_table *rate_table = &rockchip_auto_table;
-	u32 p, m, s, k;
+	u32 p, m, s;
 	u64 fvco;
 
 	for (s = 0; s <= 6; s++) {
@@ -202,18 +202,13 @@ rockchip_rk3588_pll_frac_by_auto(unsigned long fin_hz, unsigned long fout_hz)
 			for (m = 64; m <= 1023; m++) {
 				if ((fvco >= m * fin_hz / p) &&
 				    (fvco < (m + 1) * fin_hz / p)) {
-					k = rockchip_rk3588_pll_k_get(m, p, s,
-								      fin_hz,
-								      fvco);
-					if (!k)
-						continue;
 					rate_table->p = p;
+					rate_table->m = m;
 					rate_table->s = s;
-					rate_table->k = k;
-					if (k > 32767)
-						rate_table->m = m + 1;
-					else
-						rate_table->m = m;
+
+					rockchip_rk3588_pll_k_get(rate_table,
+								  fin_hz / p,
+								  fvco);
 					return rate_table;
 				}
 			}

-- 
2.54.0

