Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9503AC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 18:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D0C884C78;
	Mon, 13 Jul 2026 20:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="AHymmo2z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B49F784C75; Mon, 13 Jul 2026 20:36:18 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0D6984C6D
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 20:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47db714766aso118493f8f.0
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 11:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783967776; x=1784572576; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kQa/CsKSSswb1w1i4iINqQa+br41ULN4gvOLljruM2s=;
 b=AHymmo2zY7NPY47X7fra3d6+BdsRcj1xVlKcpQI6fdKp86n6f0klP3IY/UryiPGmhO
 ArCG9frYEcfIaDG9lZV+JfzSbxBo6Ur92hzb/QtBeTVvj8/vkM2jwa+DfcVr8aLwT0ZL
 9Fm4pS0jRaQxPq0/LtukCrPFw7j6G8VxZL72gDOiBVgxmtaTwK4HlZDGIA2FiYcYe6tG
 DVEqGriK0PeIVdXyz3JPCpMv10yL0ODoY5zX9bV11r/lhfk0kzyAOrhsW8feVdQs33fa
 EvZgbeRetpGhwJu+jSjP8eI70zRjCP3HHhxdcv0g4eSkbi3AAznCc52YjwiHqdoFnOjq
 vVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783967776; x=1784572576;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kQa/CsKSSswb1w1i4iINqQa+br41ULN4gvOLljruM2s=;
 b=e07P5Kh3PU4J879xpFKRq0zyd8RG7l79Dn359DSUsF+RO2ZETu/dk/gKRUiH4uEGRs
 8udZ7dCUZgkPwh45LwTgV9pCt/s8TmDqRghlhMado/tRZ5AD52s+M+p6fbAJh6fiKLpq
 Id3y5LjhtRLR4xyK7jW5JnRTrQj7zWlxgFxurjJB02swjDPiQiNTolCDqg98gPyAr20s
 Vj3euOkAcQlTXKDUq2nIeYo90XRpJ+QHaj+GK09sY7Qj1VVWVURp7jSNYU40g0NvLwre
 dzpWVXnBbx52pxlTnxV0re1woTGX7gSL9hIELTKBbxiXuyYQyIVgBb08k1hvKMH+UBi1
 np7A==
X-Gm-Message-State: AOJu0YxNXxfSwdoywZU/7aRoUTrTJ0b1MzysRm/feNg402vPJReNV0L9
 Wiv5O4D7LQ06ObmUr/t5kZ0EMo72iCaxt3TIc/pY9HWObXu6TasHkWH1mdtaWadXGCEvaQT7g+V
 Uwzc/
X-Gm-Gg: AfdE7cnOD825EN1Q3hoxfvexw8bp0LaJ0JLqdwlxsFpWArMZ5wv8t/tMylKi3oBMZdH
 mLytfR1v2dfzDWmhS/Os6w1CJYuSfHaoPG3eVhIujv9DGYt3R9aL4uaaunRp/U9acF5icIKoWkB
 4JlGgFp2RXl1iTY+vbYU3XslYwebncz8LyYRLzGga1v3pQTvvlDKPBTc6AIJAiqFMNigbmyiRUT
 0BqGaSplUoowHhJaP1ZSUh9k93IcqBJoTXQG+J5y4yh854d/WaW+OyvI/lHeJpxWh0nAelvL95O
 lpyr+s9aqmOuaLAar1vT3nL7M9ekoIouMxrQgNizV1u+cbDYFQTU9cf+3eDbXITisvhAmgp97lK
 8MJVj1BFmccdkhux6NQtFE9eKIXsoj4SR/EczA1brQ/n5zQaWyUR5ym5hD2NoDaxjKjdF/ApNAE
 jgyjpe4mtEO4VS7j1FM2kho0EzQftZT2oE23vRFSaIzF9y2Q4DkfPhH79SWoSt9IRR
X-Received: by 2002:a05:6000:614:b0:47d:f681:b74a with SMTP id
 ffacd0b85a97d-47ef6990c8dmr17175578f8f.26.1783967776267; 
 Mon, 13 Jul 2026 11:36:16 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c1f84sm1434703f8f.29.2026.07.13.11.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 11:36:15 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 13 Jul 2026 22:35:17 +0400
Subject: [PATCH 1/6] clk: rockchip: pll: drop misleading fout in
 rockchip_rk3588_pll_k_get()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-rk3588-fracpll-v1-1-cdf47f2ca0b8@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1279; i=alchark@flipper.net;
 h=from:subject:message-id; bh=W3nuv0XG5mChpeYxbtU6xLVNL9tK+QYWpzS35Q7HaSc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSFGkgVzvprceHAUcXPUyorrr2YLJ/E66NnWvPgxftN1
 5NudWnkdUxkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVMnsY/vCG3xat7vjz+OBS9hT7e/XHMq2dJB5OiXe1/6RTcsPlTQMjw3LWrrC
 L4rcveP6fFF7/mulAsYrfEov66eaT+PRepsV/ZgQA
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

The calculation in rockchip_rk3588_pll_k_get() uses an intermediate
variable misleadingly named fout, which is not the output frequency.

Drop it and inline its calculation into the k assignment, which also
improves clarity. While at that, also drop the redundant reassignment of
fref which doesn't change within this function.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/clk/rockchip/clk_pll.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 9dec40b1fe83..d0df3b8fb49d 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -169,18 +169,15 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
 static u32
 rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64 fin_hz, u64 fvco)
 {
-	u64 fref, fout, ffrac;
+	u64 fref, ffrac;
 	u32 k = 0;
 
 	fref = fin_hz / p;
 	ffrac = fvco - (m * fref);
-	fout = ffrac * 65536;
-	k = fout / fref;
+	k = ffrac * 65536 / fref;
 	if (k > 32767) {
-		fref = fin_hz / p;
 		ffrac = ((m + 1) * fref) - fvco;
-		fout = ffrac * 65536;
-		k = ((fout * 10 / fref) + 7) / 10;
+		k = ((ffrac * 65536 * 10 / fref) + 7) / 10;
 		if (k > 32767)
 			k = 0;
 		else

-- 
2.53.0

