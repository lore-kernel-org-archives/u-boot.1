Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC544C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 18:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7E3984C8D;
	Mon, 13 Jul 2026 20:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="xAj0Cw3s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC2B184C86; Mon, 13 Jul 2026 20:36:33 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EA6E84C8D
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 20:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so1885579f8f.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 11:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783967790; x=1784572590; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XO70k/Toquqvi/lJge3J+jyHf8Jh0fPgEyuzYTcgmRQ=;
 b=xAj0Cw3syUgnHr42gzFc1GBbEeoQjbBk84H1qzYnvvWbf7R444vRVtyacWFdwOiiS/
 /8C4hCPvXv80P+WOltbSvEFeS+0slZ79KcLC7rcEBPIFCKjL6sJTlPr/uRmb57NI5JKi
 WFaPy4gYU4NhvHjk742gjo/qDXyLbIPO+tEcfM3bmgNf3LpVt2Np1r9ZPKzriDca1AAp
 0eKdI0f9QWSgXS/bc8XgNh2ud6XHoIdxo4EyZOXMfb89qCOmyms0VT9p9VzAKmwO9Vx/
 svUPgoSMe3c12/8L/BJSUtFMJIlGYhoRcLytg+GbUzt1RoePSN+fCo2x9cKh1G5vhjga
 kpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783967790; x=1784572590;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XO70k/Toquqvi/lJge3J+jyHf8Jh0fPgEyuzYTcgmRQ=;
 b=hwcHcYEmb5G9Z3CH77noyjuLboDKpCN+V4Qj97mw2O5VRmKn6I7U1FRnX0GcA9yfvo
 j2Zv2qtstR6EDQSgVqT0G1/Da2njNuorWZr5l/rPgDb3BFxbvCGXGa4nEwn/RRZTnbxQ
 1HzZQK94cxMxOW81Zqxv+Dthfk/gxq7n0cba6q1m42uX+pjLPseoC4RVCHmiHrm8SOPe
 Efj/KYiPvzHtyONg/Wg9kzfW2mlykb7475Z3IF45/5uuphEye20AsPg2XqsCDrlzbDlb
 82/l6ef0SftcfAcqHRR9d3D61yYvThe0j8DM9Xi/HDVgbU+n6L5lvlZpCMwTlY1aXsrU
 N5UQ==
X-Gm-Message-State: AOJu0YxYdaTRX3/0KXB8Z6wS+tMHb9wLfU7p7my/qOy2vLTsr7utJt0i
 XYBvY8rjyrMo+Kl8d3CAl9RypBXtH8ohQ+H0ckK9qrjjkB+/N3zThiYmzKXMjxhMrUg=
X-Gm-Gg: AfdE7ckD4BDXQXq5g7ejcqUDA06Ar5L54RmjdvxlQr79mDvgJW/4kzAa9mJ1vQgzziz
 3YJAbmuPlvrJinuxt9jAHdmOBH8GetB+UhiGV/sauQxGjrmjjuOsKzW+fa5ogL59pK2VBh3rzqU
 jASqFdTi9E1nmuRJyxIbhSLhtYh4bXtMVFaNnq/K6oNEA7U5f59PxbWMJdeqq5xVFpKaLc5Hho4
 9rZM7ZT2DMC7mEGRySzfFRD8WIiMFh1LvVBYh9DQOS1y0w91bxYZTxRVYHxazVYgGTwkAWjJ4UX
 aShGdqjKpXGRMPFuV02BRbzEH89my7kaNRkdQ6HdUxI+zJLpVYIlUQEa6+7WE++SRrTdM+syRyr
 DlXvYtm/B4D9ryktkuS57CBRCwG6oDt2A9qCnmC4OVIo4zf8sq3L0yeYMbbshhIhsSQgtLAGAPC
 olcu2Jy6bZtBx1Hz6pX64s3JUm4WNEbuKv7gnoOJ3nnDDhwRvL8DcpRk7w0je6B03Q
X-Received: by 2002:a05:6000:290f:b0:47f:250f:720c with SMTP id
 ffacd0b85a97d-47f2dce7333mr11649022f8f.59.1783967790588; 
 Mon, 13 Jul 2026 11:36:30 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c1f84sm1434703f8f.29.2026.07.13.11.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 11:36:30 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 13 Jul 2026 22:35:22 +0400
Subject: [PATCH 6/6] clk: rockchip: pll: fix overflow and drop manual two's
 complement in rk3588_pll_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-rk3588-fracpll-v1-6-cdf47f2ca0b8@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; i=alchark@flipper.net;
 h=from:subject:message-id; bh=65ec8ksZjiGrbJGiFOJTJjOiTkBxm0n6USnj4as9n9o=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSFGkizWh0+2xzgbBb6+oD8LKGWa5/8xfM5PhUKz6jqn
 iYjEHS1YyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx1jFi4OIUgKnOrmP4p+UksDmELePWnIQHx/Sl4lkuHmXq4Vas2Xz7rILgXb2kmwz/3ds31/A
 mv46Inn/29jyXDQ9ivib1lzd+5msW3/rq92IxLgA=
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

Current code calculates the fractional component in 32 bits before
assigning it to a 64-bit holding variable, causing overflow for real-world
values of k, given that OSC_HZ is 24000000U. It also does bitwise manual
massaging of an unsigned representation of what is actually a two's
complement signed value, which is confusing and makes the code harder to
read.

Read k into a properly signed type and promote operands to avoid overflow,
which also enables the use of div_s64() to express the math more clearly.

Fixes: b851c006a150 ("clk: rockchip: pll: Add pll_rk3588 type for rk3588")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/clk/rockchip/clk_pll.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index ebe90b55ea06..9d529242be31 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -559,9 +559,10 @@ static int rk3588_pll_set_rate(struct rockchip_pll_clock *pll,
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
@@ -588,25 +589,7 @@ static ulong rk3588_pll_get_rate(struct rockchip_pll_clock *pll,
 
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
2.53.0

