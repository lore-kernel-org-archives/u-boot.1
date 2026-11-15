Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B3606A31F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HzTq93oJ;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=TB/bUr1a
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E074E80EE7;
	Sun, 15 Nov 2026 19:56:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WXodkcNzJGs9; Sun, 15 Nov 2026 19:56:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D041480EB3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794772587;
	b=jHRd0CdjxeKm4+4OC2E4MpUR9b45SpJ2rmMpR3rEvedmezz2w+D8zSeSNgTsmIaFB5+p
	 Ru1bLczJ04tNjTWKh+mlQgNnImFbNkNwsgkN5Tg5FE58kVibcAB0PaNtZSotpVYK34yQe
	 KjvDaQt44OMMkucrppsaoeDauB6Br0zflU6uTn5lRDzNMCHVo0sj7AsS1NpzgSFlYFwey
	 2qJ2by0TTHvgeatyrK7pz6QSjJ3Mfw9tBxqvVZJCPA6DRExoCdEhtdCAj4ofT+4x0Vnpz
	 N8a0rF/S4D3HqOmaFFWhWNnqmOteo+uQ66I4u7jDRifTH1TIW6tUdNUbsjQ15+DOBvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794772587;
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
	bh=4O1PMeqitt0HxqjIAixy7C1jEs2W4aVOJsk4xzz8tvk=;
	b=WiyGIQsVV9UrgiflphR4fcZyIhippvHXw1qp20jXKioOCDBtNNxEvNf9Hy/KpiCKxWUr
	 H3Eir3eCAPFRiBrtp9g4Kf1kvg0K8qL9VHJnAfZr3U+b96435fDqLMjzjHRwJdAubSq+g
	 qLJmLLt6RczxJNPL8fec3Oh6LFwuxuG0k6+LM7KuoRgiztfGUIKeJZtBkHdzSCN6FgHxZ
	 Y+1dPlWTXCmcDtBpekAVw5Dlai7N+FNH1CeqH6VytVQEiy7GJ23n/rgb15MkSyLn31Zn3
	 G7lyHt9NZV9TI/lOaDPWcCLvc9gl6vV2Lv3/5zuZujrif1a3AU04SVFb5SQwBjaRB1Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794772587;
	bh=4O1PMeqitt0HxqjIAixy7C1jEs2W4aVOJsk4xzz8tvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HzTq93oJAWxO2/PIeFC/KMeZ9jhhIUD+M9vOUaqGBCLOsTkPt68/tDC/aGZZkTzxD
	 kVRF8iUoJ2dc/GiADzsARdlXUI8QToIYF/O8WKRPR7Wd3VjeGpQ85Sz0lsv5A/wH1R
	 uKJegqB/tjjjeju9RYLZ68xnlk8dzThpzVsdusniZyWRQQE2RvCnnBPYkowEXiZZU5
	 xTKf4mJ+bxkIzhDlAX8pWQ5B+Nf124X2aMJBMyYeI16UPwQTRc1T1TA1D0ub0AlV0H
	 65PB6vw2hPO/kbaUTwdvz9T93XfgtbbOrVlf7+OBg90P0dUbBsVI39XVby9ofsaEP+
	 Q2ygC61iBPTjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D041480EB3;
	Sun, 15 Nov 2026 19:56:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D96251A6
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C01386061A
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nc5ejuhjZ70Z for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 19:56:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2457A60672
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=0bb9=jf=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=TB/bUr1a
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2457A60672
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794772582; bh=4O1PMeqitt0HxqjIAixy7C1jEs2W4aVOJsk4xzz8tvk=;
 b=TB/bUr1aKRxNFNycMAyB1zB8sIPhFjNs2HxH6E0tH/2Tyxw9u2pk9mUJvdxQ1JupGaui2Skyp
 u1Nc6OsQ4B+LK6i9sHt+7UwxaRifMYOCjEOJsjhwyrQI7jns3WkdZV4pFRo2B8Imw1M12vx5Q4x
 QY7MZ3ec2TCpu5NKpaGBq/Wr37XiisrWzQ39pT/1j78eTcXtMDtC4tMGfrsrPv7H12wS4N2ML6W
 leYIRMc3f7hJLts/is38FMXm7kMrg9WAmb0BDWOsApORsxb7ZYoHHJwz3oSKlsTanWeA07z4qLN
 +SKGWyZu+ievhpjBrfN/Z5cMgHAI6D08tfVThNKKvSEg==
X-Forward-Email-ID: 6afa0e602aaf531b6d740502
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v4 3/6] clk: rockchip: pll: Always write the dsmpd flag
Date: Sun, 15 Nov 2026 19:55:55 +0000
Message-ID: <20261115195600.119868-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115195600.119868-1-jonas@kwiboo.se>
References: <20261115195600.119868-1-jonas@kwiboo.se>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The dsmpd flag controls whether an rk3036-style PLL uses fractional
mode. When changing from a fractional rate to an integer rate, the
dsmpd field is left cleared, keeping fractional mode active.

Always write dsmpd to the register so integer rates disable fractional
mode. This also matches how Linux configures these PLLs.

Fixes: bbda2ed5840c ("rockchip: clk: pll: add common pll setting funcs")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v4:
- No change
Changes in v3:
- No change
Changes in v2:
- Update commit message
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_pll.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index ed825ac19c52..1256396aa24e 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -329,13 +329,12 @@ static int rk3036_pll_set_rate(struct rockchip_pll_clock *pll,
 		     rate->fbdiv);
 	rk_clrsetreg(base + pll->con_offset + 0x4,
 		     (RK3036_PLLCON1_POSTDIV2_MASK |
-		     RK3036_PLLCON1_REFDIV_MASK),
+		     RK3036_PLLCON1_REFDIV_MASK |
+		     RK3036_PLLCON1_DSMPD_MASK),
 		     (rate->postdiv2 << RK3036_PLLCON1_POSTDIV2_SHIFT |
-		     rate->refdiv << RK3036_PLLCON1_REFDIV_SHIFT));
+		     rate->refdiv << RK3036_PLLCON1_REFDIV_SHIFT |
+		     rate->dsmpd << RK3036_PLLCON1_DSMPD_SHIFT));
 	if (!rate->dsmpd) {
-		rk_clrsetreg(base + pll->con_offset + 0x4,
-			     RK3036_PLLCON1_DSMPD_MASK,
-			     rate->dsmpd << RK3036_PLLCON1_DSMPD_SHIFT);
 		writel((readl(base + pll->con_offset + 0x8) &
 			(~RK3036_PLLCON2_FRAC_MASK)) |
 			    (rate->frac << RK3036_PLLCON2_FRAC_SHIFT),
-- 
2.56.1

