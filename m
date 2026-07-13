Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A95C44501
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 18:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A601684C6E;
	Mon, 13 Jul 2026 20:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="G+Brat71";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80A6A84C70; Mon, 13 Jul 2026 20:36:21 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A34F784C6D
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 20:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso2311411f8f.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 11:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783967779; x=1784572579; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xf2wvAXW9xr19iioTATRhueMgFggrBaJTXFTiNPs1Mk=;
 b=G+Brat71rbJCqbxtE+FihuPwwDtKXZ5XqZ5HYeektjn1bgyigcITld7Gx3gXQRv9Fb
 RSpV1+dcihif3IBE1gQOBp2hl/2lJOSW8S5hEKiFD+DPdgtLDUWX8df0aLGaCHI6DSTO
 G9+XRNZIUpELrxcFpZc3JQ+4MJ3u/1BFe7ji5nOGFV6t6rsY6WZ9H4Z/tFQky68fdX5R
 vZcq9gBKIduSZTTrs+XdUn0RZ+YMuMvt5FF5yf3132S/AO8CxYUSKOO1YRT4wVOBdqDe
 CWIdzpBWTvkWRZ9eTKXne83L1s6SAAEpi5cBWpheYL1+zfOFGaVSaaF5XX8naJFiEnBt
 6b8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783967779; x=1784572579;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xf2wvAXW9xr19iioTATRhueMgFggrBaJTXFTiNPs1Mk=;
 b=a/Y6UGX5eWwNEs0gO3KT3b9Hr2CH/ZjweVCO49kTd482S9Ju7yLb6jFXmYQSkvjz+0
 4imlKgN3t8SKGSt/5PR+pAKv60x0sTq6KcAdoi6v6dzfglulvyAAkCDgtboHGN4KCY4Q
 04A0kycAg58aOwRN3VNWjVVFmVhIOx37PNT/ULYnsNb4oCpBnFhF4kWobRp/N/kvZPdW
 Ay0eAdzXYdm4wm4/Ug8gLV4qtNFrmy8okzrqP8IEja4dOXzJXxqMp2cDuc3P7iKw5yfV
 mBhgMuOXbu2QExi7BM0gWJTTkBMsVRdeFtSE9ZaeKeOiX/7xQQJCm/Ht94SuET0S0Lct
 v1FQ==
X-Gm-Message-State: AOJu0Yy/FXBO4+iz7Rv5zXVHeo8xP85QtCxGLJQVDGLC3xfm+viMrr+K
 cQit14oYkGgUnOXgeuo1DAPLe+Xe3W40APTHjDwvZsXhJvj5SbQu6EfAV5vTIvg4G40=
X-Gm-Gg: AfdE7ckHWfMDILsAc98UR4QBr7GqgCg+D2grtrgiTlK2SqW/n/G5NUyKnTk3YyvfSpJ
 fRyylcueudi7YFW1dbwoOvhSi/CosrSxHu2QKB3ZK+chrY4S4f2dVhZIiY+Xjf+CmF9FqsLkPBr
 YledxzGlyANcEEVXtYv1hGs7Hrl43H1iWUE2+UtXC0RX3gNt/KuVo7UDbPlItWrZq0DQiZ3VCAr
 jRKDgcOF6gpEWSt9Hu96jR7XLrefRdeF5yP7X8E/wcQJ/Gd3EssQ8g585VfgP06x/y3x9sIP0s6
 l5NPg+1PNm4g53VF/BLw1H3OHj9KTRYKDTstn6JbUQpye5VS4xyYfgf+sfo7+b+F37VaWaevGKz
 TwYuxxwq03ZhsMSj93qDUAvIAw1/w4amxTp7aki9+lI4+PVAY+/3Rad++o3+5s93k/cMfP1NAmx
 KttiMjFS0JAQ4PoWo2wFULXK1ijGzay44ialcnb6fGmZbtS6ks8CaZPf9Rfmap+4+978l1+I7fg
 Do=
X-Received: by 2002:a5d:6e47:0:b0:475:f0f0:9eef with SMTP id
 ffacd0b85a97d-47f463a3d05mr679624f8f.52.1783967779024; 
 Mon, 13 Jul 2026 11:36:19 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c1f84sm1434703f8f.29.2026.07.13.11.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 11:36:18 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 13 Jul 2026 22:35:18 +0400
Subject: [PATCH 2/6] clk: rockchip: pll: fix rounding of negative k in
 RK3588 frac PLL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-rk3588-fracpll-v1-2-cdf47f2ca0b8@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=alchark@flipper.net;
 h=from:subject:message-id; bh=NSq1opaVli5nw3t3IGjfmrj162AKlviqf0gY5+KpNxY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSFGkidfHDTRf+gmZrEvgORO7dF/f2bP9Hid5dXBEML6
 /zEpy8/dUxkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVObYM/wuTpFcsSaqadVTvTfa86eaT7DrnzpiUe+n5JnWn1rvF0+cw/LPT22L
 d9+96iYvEnYyV/mcniho+D3v39HKiuk/0KX2tq9wA
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

Current code uses magical constants when rounding up the magnitude of
negative fractional PLL component k. This leads to overshooting the
requested rate when the calculated fractional part has less than 0.3 in
its decimal part due to failure to round up the fractional part.

Use a proper rounding up function to avoid overshooting the requested
rate and make the calculation more readable.

Fixes: 6bfb37e70209 ("clk: rockchip: rk3588: fix up the frac pll calculation")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/clk/rockchip/clk_pll.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index d0df3b8fb49d..69d2d182dcb5 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -11,6 +11,7 @@
 #include <asm/arch-rockchip/hardware.h>
 #include <div64.h>
 #include <linux/delay.h>
+#include <linux/math64.h>
 
 static struct rockchip_pll_rate_table rockchip_auto_table;
 
@@ -177,7 +178,10 @@ rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64 fin_hz, u64 fvco)
 	k = ffrac * 65536 / fref;
 	if (k > 32767) {
 		ffrac = ((m + 1) * fref) - fvco;
-		k = ((ffrac * 65536 * 10 / fref) + 7) / 10;
+		/*
+		 * Round up to avoid overshooting requested rate for negative k
+		 */
+		k = DIV64_U64_ROUND_UP(ffrac * 65536, fref);
 		if (k > 32767)
 			k = 0;
 		else

-- 
2.53.0

