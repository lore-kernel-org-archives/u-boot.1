Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9591BCA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E63980A88;
	Sun, 11 Oct 2026 22:31:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FBlKdoqZ6y0k; Sun, 11 Oct 2026 22:31:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B057F80CCA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757897;
	b=fHuO0yr7E1suvxIO/mvxe2eRmQvJbTSyFz7sFwEVLm61PyIaox1/Jm+En04I5cxktarH
	 cPUgqV7TqUAqeP19Cc0kUzbJIH0FGRObDBWcRXAV06Nlw/X+RU93WMGjPETjNoYG/SQDf
	 w/qgtksvot7yrpgFHKplREtT0+B4NoYGHJFTEsJhAIWP2vzCi8wRlZ8Fgq6b7JM5T9f3e
	 F/aA4GX/mwQ0XASkyY3cDraD22okhxtclzWbqNwaMYRJWdLo74IO6RV3/Gs/IfbnOOcHO
	 YPFmhxyp8lcvVv3k3kqEInyh8PQomonc7a8mRIW/YHfsfF/M3nwcn8e4RySaHD8a9MA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757897;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TabEiKLv95wFkSVtQKl9MfaAtJVoAazbG8F2/ICrlKQ=;
	b=oC8yVo/JhGkYLuIbgT6CHDYeT87CwkrAV239bNPj611/QtHOOXCBg7qMVJVqXl7ei30x
	 FfAkJxiOEMxKc8lP9sWj4KWb5KVPfoJvBj5Y4nIkzagMXqByilCbgbwoupb7w6tRg0JPs
	 JGiUH29snpFXn1W3qaAHkkRyOC1YJLwsp7rqcT+aOHPFx0UfNTmd8Ye/5zLB3EYKNMjcz
	 YAXj5O9BeLCcCQGvjWUTll1/SNK9H6Z5354EePVbb+YuiU65qyKWLaxx13XEcfikYEXuO
	 0H75WZnN3J3DSvwjqlXzeZkAxmRD9LxY5UFuFjujOsQ43zXUYGQUKf34V+bKsyNzz2A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=TpajSzO8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757897;
	bh=TabEiKLv95wFkSVtQKl9MfaAtJVoAazbG8F2/ICrlKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oprxnvThDlk2el0sbiyP9P5rbUTmpQ8QCkH+14f5ZUJo9YLTbIVBFmXVol7GZb01I
	 Jffw5f6DPNHF5bvbvQ/Q/9QweWlKmZt5HCUkqXsWk1VQbCmAhb/JpZM1/EVw+JXv46
	 ycugJFmGG3zw9HC/AYc8xW9HNQ3zALuU4ccg4kWabZImAJ79k6ZjwCPkpxY9bPIKB6
	 4EbTH6ivjOBHNbaRI4YT7Hl/gSCg3lWhTDn3ksbYT3dsrnHJK0oG+LPH3UaVGuGRNY
	 ar+U6eC/k3jG+5rnjGqEfFzV4jWBFiV/lKhZ0MmgOz4zYcy5CvmM71O0QmgvbJVEKa
	 VhGmG+rGdOcYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B057F80CCA;
	Sun, 11 Oct 2026 22:31:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5972F1DE
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B36380DBC
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yi378J6-UYXS for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 893ED80DDE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757895;
 b=LsE6PPGOWq9P8itUElH5WLxASS+RvgV0s5XGcIiAKLPNKvNmTt3EnF7vWJaHn/Zcw71W
 V/GVafvVtvcqdnkiIUwKZIf5hvGhOdz3eKnFTtGGb8nSBbFdY+p6M0xhSwUpguneYs0fI
 iNBcGbWWn1GH/qX4M6wGrbLZyKF+bQm/XUGPjV285ZaNYl0wdSjRwgqn0uVA7s8Jn9AGS
 pKJWa64uhRW3I3N8GQwToT8buKlvoNFn0XGK9gqXsfvgnNJ37SWA15/5EZQnd5buJNS4P
 Y+bp8w53kXeqd9ynvzAEYvep/lNACAS3MkvQMAdsmuY5x/2IlkQKJjPkxgflJ2yA1yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757895;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=TabEiKLv95wFkSVtQKl9MfaAtJVoAazbG8F2/ICrlKQ=;
 b=jjk/VTxYS2yEM24sxOJtQNIAm3JFC1OBuQvYHyZNmgn5Xi6f9jiGK3/N/vy5ya1jUzlo
 kZGkGQ7u+GhvLaM4nnC1obRErDlXJQ2gleNxhxaLburqvOc8gk1XZV93c9CgxczTe34cT
 UgEBl/aAAcyJyAmdGkI4iB7uPseYhVdmIb99lzhH7cIcSi4soXX/oJMgtZvk3KhANfu35
 V/Zmey5Vu1pR9exLMlQyLN/sRdgXGWH+O55y7KbLdih2r7cuaaj9SWlg6QdQKNIbuv+Ow
 B7pKX0M6tLcZVkaGsT5Ym4IAdjcvX2Q+0FeyVY1xFn5XOK014p9Z8fcDwdPChGlxOEg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=TpajSzO8; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=TpajSzO8
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 893ED80DDE
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757895; bh=TabEiKLv95wFkSVtQKl9MfaAtJVoAazbG8F2/ICrlKQ=;
 b=TpajSzO8mt/1uKfvh1DaevMOCiQv+3tbkiPrYFIFA5f/xzBh+JjaqZJFDm6pf3fPgbgqwjlgx
 p9RDqRk0AFElhHrEiT0NbvIpFhEKSpD3MH/HOllr+dFfVxZ4ezhcKXATrV+OSaGZO84ACirsbJg
 pfuBsN8S/lev6OZncZ7FXW1uE5Cw2C/5sMMJCDataxNgKZSsH9MMwjXQLs+tLT88Dz3QAYTFfbE
 iV6PMQvZHFH9gbNvjDmC4hANmmmAkjGz71SjMTNBGhd73j8Axs6bLqSKL6T/sbeRxQT99s5y02I
 tF3i0xgXI23ksKUoZd9Fon7TYs6c63T7eyKV+1iOKzSQ==
X-Forward-Email-ID: 6acc0e3e4548822a24c175ee
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Joseph Chen <chenjh@rock-chips.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 31/37] clk: rockchip: rk3528: Return correct rate for
 CLK_PWMx
Date: Sun, 11 Oct 2026 22:29:06 +0000
Message-ID: <20261011222930.1085075-32-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011222930.1085075-1-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The PWM clock getter overwrites the 100 MHz rate with the oscillator
rate because the 50 MHz parent test starts a separate if-else statement.

Change to use else-if so the getter returns 100 MHz when the 100 MHz
parent is selected.

Fixes: 5a7a856b132f ("clk: rockchip: Add support for RK3528")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Split from "rk3528: Fix trivial clock configuration errors"
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3528.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
index cf8c3a623495..812710872729 100644
--- a/drivers/clk/rockchip/clk_rk3528.c
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -770,7 +770,7 @@ static ulong rk3528_pwm_get_clk(struct rk3528_clk_priv *priv, ulong clk_id)
 	sel = (con & mask) >> shift;
 	if (sel == CLK_PWM0_SEL_CLK_MATRIX_100M_SRC)
 		rate = 100 * MHz;
-	if (sel == CLK_PWM0_SEL_CLK_MATRIX_50M_SRC)
+	else if (sel == CLK_PWM0_SEL_CLK_MATRIX_50M_SRC)
 		rate = 50 * MHz;
 	else
 		rate = OSC_HZ;
-- 
2.55.0

