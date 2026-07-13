Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09859C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 18:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E495484C81;
	Mon, 13 Jul 2026 20:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="gC7oZK4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58F4D84C6D; Mon, 13 Jul 2026 20:36:25 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E25B284C75
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 20:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493e4cccd8dso1183565e9.2
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 11:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783967782; x=1784572582; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YZOZWOkFn400FYIDey1fESbI89ukGN7JnpWBZ5cbeK8=;
 b=gC7oZK4lzAp7TPJ2uwZVydwSQj4EGkVCBPeVOuRNEetftBz2kJbiihuGnZ7I1F72bu
 Mzbdg9C9o3tijEBnRzWfLV0Rely18YFT9HSNWQ19pICeYX7y8pVywEvxxL7typf/D+F3
 Uf2Ylz/g2mZ+48WjCy05q06FJy6YbgVcDBK7vO7368tqWuGmuukPiVg5IiZet216Bj1A
 3tMooCuTTQKKcj67z7qogWyjVVhyWJ3YK69ePe2hJaVFAkZpP0yq9IPvJoFPo7SRDu/S
 sYyYNTrE/oux5B7KcplWDdFG7Hib1mLomusZHc86IE1K01WhpAI9/0NY4fvD4RUNFfv0
 5gPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783967782; x=1784572582;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YZOZWOkFn400FYIDey1fESbI89ukGN7JnpWBZ5cbeK8=;
 b=NVJBGaJphN68cPxEb7el6preJM4hrqEPn5ksbyy77dxZ+jIrVo74/61QdvS8VIZDPI
 mnBXKDeYY3Xh2sKKDur07oc6WClolM3LH0Jlt13zw0BELB2MoZL3R8lIiVIGDSHiIlnQ
 lNChc/OrCPe+89YvSxc8Gabww55YpcCLF2BTQMTG2O+Sqxs5dPe6Nr6k6Om7bE2Kw8ua
 7oLMhEFYiwuaXNPC5knOjH86oez3u4r6QwNPC9Z9Y68/AhnYTzpQw4wUmgFA2z8DQ6a6
 wnw5VK9hQKBpp55a7RqJxgBVAE0ZKYUa5MDhSzO8XgG1slV5IfRn0y7NC+Qtdi0bZCQX
 89+g==
X-Gm-Message-State: AOJu0Yz2BcosvxsWe+rACEKc8xy5FpmOMm7V2VOIgkthYJTUVHzal/ao
 IKAg2Gb4ga6th3Sjn6iQQpy9yXQ3HIqtR50DHsasJf7AE+ein+aDi4Ah2908Q4hHJbQ=
X-Gm-Gg: AfdE7ckQTRkQtMyeDzmdJbnlp6/tTSR2PzZjpq4Yo9pLj0ahVBnJNFw3CKO1HCHWTxj
 svX2ERc2nO2Py6uVcJji6aYxtuuUHkkKrNvL8lwErFlCCxCOPDkneS/BXchabt1kBN/wb103j0o
 B2nxmnaIn76wAMyXVva5bw+VlKwg6kiY2A9uAyIHXfmMfUfKQtxKopaVDlVJoXdIA3xbf7O6rds
 OC0k1u9DpehYmSp1xSHNiXgr+YmUBxlOBZnQCT6xDDFdG1y5FnY5XzZdVDc/l9Qgg2zpZb5XZGe
 9JUA+t9AYBZ8nJMZ4sr6dyDpD+7pOHbfOoT3WDjYPbwBWniDs0bT2pn3OMmrs9ntLJJ34V/rDd2
 s7ZFqmBUGLDidSBIElKHToWkCCwbjkR2VHHhS29B/51jwS9Xwo0HXrxlBdppyFy8nfgkE9DdZlC
 aHgk21jKGlJGIvT3easRdpW5NUotrpYjgiMdf7mnm+bayPEunOXSHfQ/CJfbFsPp4F
X-Received: by 2002:a05:600c:a010:b0:493:c337:db19 with SMTP id
 5b1f17b1804b1-493f87f1469mr106245435e9.17.1783967782186; 
 Mon, 13 Jul 2026 11:36:22 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c1f84sm1434703f8f.29.2026.07.13.11.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 11:36:21 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 13 Jul 2026 22:35:19 +0400
Subject: [PATCH 3/6] clk: rockchip: pll: fix RK3588 frac PLL result for
 k=-32768
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-rk3588-fracpll-v1-3-cdf47f2ca0b8@flipper.net>
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
In-Reply-To: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
To: u-boot@lists.denx.de, Elaine Zhang <zhangqing@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747; i=alchark@flipper.net;
 h=from:subject:message-id; bh=BB+Fj3uBXyk+UzfZQRIhOJ/ShtybJtBkuynfB9Dswgk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSFGkhl7bz86LeXQ216XM9S6Vc3V5n/uvzj+Mwj4afff
 Gn8uN3zeMdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBTvTeNkeFWxztHj+15xoIFs7Mstsxb9E59FmfdpSVqX6TmMojotjkw/I+IN+g
 LsftjqJ1uwvB6zaKnn5Q9TKatmFuhL7X3AfehLewA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Current code needlessly sets the k value to 0 when it is calculated as
-32768, which is a valid value for the RK3588 frac PLL. This results in
the PLL output frequency being higher than requested when the requested
frequency is exactly halfway between two integer-multiplier PLL output
frequencies.

Negative k values can never go below -32768 either, because that case is
handled just above this code, so the check for k > 32767 is redundant.

What remains of the if statement is a hand-rolled two's complement
negation of the result, so write it out as such for clarity, and return
the true S16 type of k as specified in the TRM.

Fixes: 6bfb37e70209 ("clk: rockchip: rk3588: fix up the frac pll calculation")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/clk/rockchip/clk_pll.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 69d2d182dcb5..c6fbeb71c77a 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -167,11 +167,11 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
 	return rate_table;
 }
 
-static u32
+static s16
 rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64 fin_hz, u64 fvco)
 {
 	u64 fref, ffrac;
-	u32 k = 0;
+	int k;
 
 	fref = fin_hz / p;
 	ffrac = fvco - (m * fref);
@@ -181,11 +181,7 @@ rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64 fin_hz, u64 fvco)
 		/*
 		 * Round up to avoid overshooting requested rate for negative k
 		 */
-		k = DIV64_U64_ROUND_UP(ffrac * 65536, fref);
-		if (k > 32767)
-			k = 0;
-		else
-			k = ~k + 1;
+		k = -(int)DIV64_U64_ROUND_UP(ffrac * 65536, fref);
 	}
 	return k;
 }

-- 
2.53.0

