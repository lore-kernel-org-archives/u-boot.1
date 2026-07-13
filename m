Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829A5C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 18:36:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BBC984C91;
	Mon, 13 Jul 2026 20:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="23hpb/9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96A1E84C8C; Mon, 13 Jul 2026 20:36:27 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACBFF84C6D
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 20:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47df6a5202bso2063481f8f.0
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 11:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783967785; x=1784572585; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nZ/XDzV8yDTgnTIbXwryIpzjYC8U4IFFQoZ1P1RJepA=;
 b=23hpb/9gPbTh2VU35vIqlxk9gH7wo8rpFgJZqpZw3972dhT5dCOFIQYkSz2jlsO56p
 qKVyfonCX8gknz3/CYm9msOKW/4FdOyNCBs19ieG7c+Qd75jhcGTlgNyNbw5HM34l2GE
 2RvJt37wspJFOaVPjH5b8H95t/3k49NqWTYXe/43hBIBt0S4Z8059PRkt7uPJrEsLgM/
 0yE99LZmR5G3bekZswy+Y+9fi36gn71HMSzrXZcqCFz8b54tm9LrR85/kwIJjyWV6ewJ
 9VCDkciK1hik/0UT88Y/k4UsoP2kIF1zzkcBuWxjLQHNkTL3nQPpPlz31BsmK7aKT5jH
 n7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783967785; x=1784572585;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nZ/XDzV8yDTgnTIbXwryIpzjYC8U4IFFQoZ1P1RJepA=;
 b=SFYlsonfZM3vjERRcIOyteDfVhz3fShLZVIIhGd1+bwbdWSA6lAycR6SfKNnhePVtD
 46tSaFmNq+2+8j07OP9cmcjcnjICImLllANoTWMUckF7wvnxAdvrEPTS1MJROpPRTAhA
 gVuWtEVO07bmSQQq3vo8nQaib8Xa3oP7wHulPwuVOkBOsiHuTcypdzWwyeyUysay6EA8
 Lumwn9iVQNnjNv3fddHSZ2QMJTJ1/iqGqef0ngTd1Q2eoiNkIDhZe6fVvuzzGKCZbSJx
 jRNafYCklnLeIzB2Scgl+H2+2j3vvTCWChMI18x/8vaVmAtBDXdVt+tIgS0X3CT0KCas
 XA1A==
X-Gm-Message-State: AOJu0Yw+Mo1gYm/jlMYqq9Rn4gNx8Yviq6FisXnd8unbv7anCekcUD9s
 6NBSu61K7bcV5u+9k9+Vq+p7zpwKl9goLIXUnZGtEXz7Ph/6TgP5T0gyhDVlf9pMeVXZlQcHZtr
 3vZeu
X-Gm-Gg: AfdE7cmQHZ6UNieBJ2SbMHqfcE4ehJw428QlnsPK2AbBvVscI4CfSDkqoyQiElS3Ad0
 Fb6nBwKqA6939ZjizmDfS2vrg327GMq30iMVLiJrIcgHUgyMlhiWhOeIWxhMYzlDtZlKgBmqgda
 P4bSnYrbiGiFD5TvzgPLDj11je4ZqK1ymd4Li4ypg83m3rMIHSwdCEKCi4I6vUXIBbLRqjRjAb3
 mFtEonQpQiFHBJDmQmRz93rU5vpYLMbNZTDxy5Yi65aynseJuHXfuGtnX7StCimf1xHskrmlG1q
 Oke49fMpfk9F2DktCQgqOlfElavJGj+z224sU2os+lPTkLmhg3ibNVZcDS+ASuhLZJYZcGzxzS+
 QuxmfFVt7S870+vnQXqlauxkui+Fg5KqwyN8wLwdLMf9/Kx1xiE1FEzyNVfUX2DtzzV8eDnTj6U
 1LcAgfofPoBqhrsaxLdAFZanGG5NSvO0BU9g/nrCHv3cz5EVIMMAdMId0uKOBcKxwV
X-Received: by 2002:a05:6000:2907:b0:464:8d68:618a with SMTP id
 ffacd0b85a97d-47f2dce9703mr11720560f8f.32.1783967785071; 
 Mon, 13 Jul 2026 11:36:25 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c1f84sm1434703f8f.29.2026.07.13.11.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 11:36:24 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 13 Jul 2026 22:35:20 +0400
Subject: [PATCH 4/6] clk: rockchip: pll: let rockchip_rk3588_pll_k_get
 update m directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-rk3588-fracpll-v1-4-cdf47f2ca0b8@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2256; i=alchark@flipper.net;
 h=from:subject:message-id; bh=sh7HaQzk5qK2ZPJZ660WKiWfKRFKZtksga3SACRDMU4=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSFGki1LE6TL5Hz5DCSjW7sXW15Uj03QSFr1fJdrf/8j
 r/aYsTYMZGFQYyLwVJMkWXutyW2U434Zu3y8PgKM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6xgxcHEKwFRXrWNkmFQzuVzsjFhLlvK1hN2vvjXZreT24V67JEjc0nvagg6zG4wMy5e+ef5
 m0SuGHXwz9+8PfrlfRWn91w7VyMumbpefzt3lwwgA
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

Selecting the next integer multiplier m is coupled to setting a negative
fractional coefficient k. The current code checks for negative k in two
separate places, which is error-prone.

Let rockchip_rk3588_pll_k_get update m directly, to make it the single
source of truth for the final value of the integer multiplier m, which
also reduces the number of scattered conditional branches in the code.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/clk/rockchip/clk_pll.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index c6fbeb71c77a..6324c11091af 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -168,16 +168,21 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
 }
 
 static s16
-rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64 fin_hz, u64 fvco)
+rockchip_rk3588_pll_k_get(u32 *m, u32 p, u32 s, u64 fin_hz, u64 fvco)
 {
 	u64 fref, ffrac;
 	int k;
 
 	fref = fin_hz / p;
-	ffrac = fvco - (m * fref);
+	ffrac = fvco - (*m) * fref;
 	k = ffrac * 65536 / fref;
 	if (k > 32767) {
-		ffrac = ((m + 1) * fref) - fvco;
+		/*
+		 * The requested rate is closer to the next integer multiplier
+		 * m, so pick it and use a negative fractional coefficient k
+		 */
+		*m += 1;
+		ffrac = (*m) * fref - fvco;
 		/*
 		 * Round up to avoid overshooting requested rate for negative k
 		 */
@@ -201,7 +206,10 @@ rockchip_rk3588_pll_frac_by_auto(unsigned long fin_hz, unsigned long fout_hz)
 			for (m = 64; m <= 1023; m++) {
 				if ((fvco >= m * fin_hz / p) &&
 				    (fvco < (m + 1) * fin_hz / p)) {
-					k = rockchip_rk3588_pll_k_get(m, p, s,
+					u32 m_tmp = m;
+
+					k = rockchip_rk3588_pll_k_get(&m_tmp,
+								      p, s,
 								      fin_hz,
 								      fvco);
 					if (!k)
@@ -209,10 +217,7 @@ rockchip_rk3588_pll_frac_by_auto(unsigned long fin_hz, unsigned long fout_hz)
 					rate_table->p = p;
 					rate_table->s = s;
 					rate_table->k = k;
-					if (k > 32767)
-						rate_table->m = m + 1;
-					else
-						rate_table->m = m;
+					rate_table->m = m_tmp;
 					return rate_table;
 				}
 			}

-- 
2.53.0

