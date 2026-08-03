Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D58C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D51E6070A;
	Mon,  3 Aug 2026 19:10:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hCCXDF_Padds; Mon,  3 Aug 2026 19:10:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03D8F6069F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785784204;
	bh=aVLAMBeVeWjj2jWD6WO766jTvU5du3dQrYnOXbWshjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ubgNDdTwFeyvg9jpTEyXA7Aml35Ye3jD06SgKj8Tunt8cTjFdwH2CxC1lz7jodAjR
	 v9abgO/pdCQlVlHeVec4yTp8y6ytTilwExxRon9utDUCVnOap6NpCqYU0AmIuBxHEc
	 0FRMhxHCOgFzwyvb6GXZDfBt7+pjCbnqvxTTG2MDG0gs7wo67VSlBC38aD/HDrUePn
	 Z43brHl4RgQnGilC3X2L9a/pnDxigGIRXrVhjULzAv7fEPUDjxy4KOCj+elUOpwV3R
	 FyhJ0tZ65xzzL3ktordNwfnqf11I9ii8wl4B/TMz0bWA40Qq13nCifftUpkl0I30N9
	 6Q/9JOWw6YGfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03D8F6069F;
	Mon,  3 Aug 2026 19:10:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DF672296
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9F7A80BFA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:10:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bgdaIz6izPSr for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:09:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a02:6ea0:d71e::9;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 830C580BF1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 830C580BF1
Received: from smtp.forwardemail.net (smtp.forwardemail.net
 [IPv6:2a02:6ea0:d71e::9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 830C580BF1
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:09:59 +0000 (UTC)
X-Forward-Email-ID: 6a70e785ae1ce3dd2fb7e5b4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.13.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 4/6] clk: rockchip: rk3506: Fix CLK_SARADC set rate issues
Date: Mon,  3 Aug 2026 19:09:42 +0000
Message-ID: <20260803190946.2259514-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803190946.2259514-1-jonas@kwiboo.se>
References: <20260803190946.2259514-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785784198; bh=aVLAMBeVeWjj2jWD6WO766jTvU5du3dQrYnOXbWshjY=;
 b=OT2E3OSrrh1tBosSI14L38ntRBnWughMrtIDgYOxM24ZTfr2673gXErU0Zms17ZHgFs0AJjrt
 ph3Ad7YlmY4YQDYtSvgE6JzDccjV4/46QTPbeeQitnxZWezjfJHOPAhsFZFv/7887/KoG41HX1y
 PHJcYN8XppuYL6IoOIwW9x2PpxDwghiGMzRmaiHbo0GVQP8X0FIf4Jnad5AY5X/VyvUcIJCMhAJ
 fZZYxRI/RLq2QuLwtcJksgNhxh5Us/9ZdxkmemlCyV86RYArTQ9FTw0m1KTEqdp1NaGlHyRsIb5
 r8LrXt3VVvm4dgcZXPFFURYaei3IACL/C3s37pcLeP+w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=OT2E3OSr
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

The set_rate ops for the CLK_SARADC clock in RK3506 clock driver
force use of 32 KHz or 400 KHz rates when any requested rate is
divisible with 32 KHz or 400 KHz.

Adjust logic to better match the 32 KHz, 400 KHz or 1.5-24 GHz rate
limitation of the CLK_SARADC clock in RK3506.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/clk_rk3506.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
index 457082eea87b..e156bf19a6b4 100644
--- a/drivers/clk/rockchip/clk_rk3506.c
+++ b/drivers/clk/rockchip/clk_rk3506.c
@@ -440,22 +440,19 @@ static ulong rk3506_sdmmc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
 static ulong rk3506_saradc_get_rate(struct rk3506_clk_priv *priv, ulong clk_id)
 {
 	u32 con, div, sel;
-	ulong prate;
 
 	con = readl(RK3506_CLKSEL_CON(54));
 	sel = FIELD_GET(CLK_SARADC_SEL_MASK, con);
 	div = FIELD_GET(CLK_SARADC_DIV_MASK, con);
 
 	if (sel == CLK_SARADC_SEL_24M)
-		prate = OSC_HZ;
+		return DIV_TO_RATE(OSC_HZ, div);
 	else if (sel == CLK_SARADC_SEL_400K)
-		prate = 400000;
+		return 400000;
 	else if (sel == CLK_SARADC_SEL_32K)
-		prate = 32000;
+		return 32000;
 	else
 		return -EINVAL;
-
-	return DIV_TO_RATE(prate, div);
 }
 
 static ulong rk3506_saradc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
@@ -463,10 +460,10 @@ static ulong rk3506_saradc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
 {
 	u32 div, sel;
 
-	if (32000 % rate == 0) {
+	if (rate <= 32768) {
 		sel = CLK_SARADC_SEL_32K;
 		div = 1;
-	} else if (400000 % rate == 0) {
+	} else if (rate == 400000) {
 		sel = CLK_SARADC_SEL_400K;
 		div = 1;
 	} else {
-- 
2.54.0

