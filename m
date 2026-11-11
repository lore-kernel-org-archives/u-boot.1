Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1228606A89B
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PJzXwU54;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=v59R2C4V
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9EFB8117E;
	Wed, 11 Nov 2026 22:35:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E1SKlIQcDZtp; Wed, 11 Nov 2026 22:35:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1F705811CF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794436522;
	b=hw8rLu4qtXnkHYgYVVnmCdmCgGFWnoV9nzg7W7XcmVRXq2PEKJ7rst5xtyPURx9iA9hl
	 qXKpaOlcrRn6jo084OUnSRQsj/Myz0Tio9khbI9G/TgKz76X6pfXZdJvnCcOyRhZrb0iH
	 AdyeiplVW9AmCiZYJeiOfKprxzYK1cRcrkkI0y9HtN6O35sfTcLoN7GYymojnHRt2T056
	 aVVyowZfHrJPqIewiGNPX9gS0hMcInuQqEVMNQFZhReTRmilaOKm2kyLT26hEL+tA17Up
	 pku/Pqnx9RzfAl1UmbYlVgTdGibvCTsgWsmjf555VEHPTYdYSfU3V/Tuwq7tSpOC7sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794436522;
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
	bh=OpMoNZkrk5JM1Vbn4K6xKmRMyuvN9siifmCxHAmqaKA=;
	b=sUkBwyY4l7TXdSPk0vTX8hFKZ66Bw5YZ1EhKkdfg2+/LVqZ6dnpyTLNYQbZi4rxX2e4/
	 1IM60QZzkJIgBQccLWSQKxrTeGRvsG5p7HZhnFfwLimw0RD3MOnQ9GSTbiJVcWLmG69XA
	 JcOXHcgmQhzABftXkKcGnMTmD4Zpa6c25kuoT/L7+nT/0v49blbg+sg6WDZBbh6JcMQFj
	 +pp18VB7cB25EpYmaE+Keg//vwJ+Jc93nNJd5bvu0hHEWGJ9A0or3wSU5p45nhOY4ZCZu
	 gDy/CyrKBLFj4UgYmKfv23tCGULsHSs7kCgOytBQydmTYQY1ltCHiVAqZyEFuUFv0HQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794436522;
	bh=OpMoNZkrk5JM1Vbn4K6xKmRMyuvN9siifmCxHAmqaKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PJzXwU54BAxG18aKRHXLdpKEW3Po4Xxxku5UhVVFT0t/oY3I60olvJoySkEKSBK1j
	 QiYVMPLgwerJAaWdB1YOUCtREOZjyl7xrip1CRXbju0k1Qkuq/Vuuc1mIXNRmeOVkT
	 tUahaPgdJexDWepMwnlrEhXYvFkVlkJEz0hign7Qa7yiJFWiaodxdbsIql5dgWZPYJ
	 EtTkH2zKmEp12hyXWdxbitm2wNB0SPYtiXV2Li2UrA9XaVu/Q6QX/aBOtQoHbjBtBA
	 M52e95vFxVITH9BFXh8wn0PV8MejeK0QA87McE05lV+DCke7UIQ10hEDQSjjwCHp34
	 G7DbqFjd2kXQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F705811CF;
	Wed, 11 Nov 2026 22:35:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 182A070B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0586940C78
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:35:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qU5oxRlKfizH for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 22:35:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 77A9540AEF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=v59R2C4V
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 77A9540AEF
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 22:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794436518; bh=OpMoNZkrk5JM1Vbn4K6xKmRMyuvN9siifmCxHAmqaKA=;
 b=v59R2C4Vsi76l38+IsLzyhQqcabihYXtxpPHo5i6qzmABGN40dn3x28x+zhRAt4vrUwn82jHS
 DHuVaNI+gt0nNv990R+pJ2iRUvM2koP5h1NBQuFIb2Xi5cE0ZTh3NO0JsGZJNQwNsWCHZJsz1qq
 BUBSNnU7RMfaz2zlCZVrBhl92DOfuYbD9gMRyg6qe0HYNXP0tQcHWyjK8b5dcQenpOh18xYNPIy
 HUIYttru/Ygt4+dmcsfTrSMvsmIvOe1mrpqKpb/SJaNwI7cRTk8ZfaZLxxm62cqaTnWiWe2vwjb
 zQlwLosNsrScrpjiCEzeB2ndFmygQRJDVzWPhffrB8rA==
X-Forward-Email-ID: 6af4eda54e7b1f439360f057
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 2/4] clk: rockchip: rk3568: Fix PWM0 parent selection mask
Date: Wed, 11 Nov 2026 22:35:01 +0000
Message-ID: <20261111223505.158852-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111223505.158852-1-jonas@kwiboo.se>
References: <20261111223505.158852-1-jonas@kwiboo.se>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CLK_PWM0 divider mask is used twice, leaving the parent selection
unchanged. Change to use the intended CLK_PWM0 parent selection mask.

Fixes: 4a262feba3a5 ("rockchip: rk3568: add clock driver")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- No change
Changes in v2:
- Split from "rk3568: Fix trivial clock configuration errors"
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3568.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 38c5d62493bc..3651aac0ad33 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -299,7 +299,7 @@ static ulong rk3568_pwm_set_pmuclk(struct rk3568_pmuclk_priv *priv,
 			src_clk_div = DIV_ROUND_UP(priv->ppll_hz, rate);
 			assert(src_clk_div - 1 <= 127);
 			rk_clrsetreg(&pmucru->pmu_clksel_con[6],
-				     CLK_PWM0_DIV_MASK | CLK_PWM0_DIV_MASK,
+				     CLK_PWM0_SEL_MASK | CLK_PWM0_DIV_MASK,
 				     (CLK_PWM0_SEL_PPLL << CLK_PWM0_SEL_SHIFT) |
 				     (src_clk_div - 1) << CLK_PWM0_DIV_SHIFT);
 		}
-- 
2.56.1

