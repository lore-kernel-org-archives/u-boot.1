Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C4BCA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C01360717;
	Sun, 11 Oct 2026 22:30:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kw6zpFdut-HD; Sun, 11 Oct 2026 22:30:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 72A84606EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757807;
	b=PJ9BHe1SWWWGKrL8MQpCZwYN2QbCiZ0klj1p4G2GHwoH29xjn6KiaCJyIq64XjwMX+B2
	 OgBYRjshk2OaKBRom+X8e4R0YHly5ScQ1Vwa2wC8n24Cmo75fpONFq1S6PhkBLj5TaotF
	 oKw1W1OZzkhiSvfA8BJmJBbSUxWJuapHuNFroP7+h1kVzf5dcIMkF05P/uY/74wuUsOIE
	 ewMyiT97edKZUABlGEt+OWZWehPr+wG9xaN9u+MVKYcZDQ5mvdzR/Y/0oig2I6s94VVOu
	 mEVZxW0bmd+Wy5me+7LvCA2FfrJWloHazxOMTyigivpkwzAPAZIpir7DWOhAiFdEMbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757807;
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
	bh=8Uf7HoTl1paeyNcoyaCmR6q5Q0dxa/vdKcjBnOfd0EU=;
	b=LSmw5dsTRzbAU3Ikw7ABPOnWeeb9WiCxf/hha34QFahRKzeHcZgwsDwba/psAmnQJzwq
	 9iPePnjDPUIVoHJhAbXdASrBTEuQYo+VmEE/7cX4XaXyx7UYvZkcmgojcE9XxLDbRdk3S
	 dNqRQ1l/x/1kQgvo8dXQdJNl/+M6GO4RIdve584uqvShBTmSvN3YML0FJzrV4P/WQt3CR
	 wa2/4YDk78PjkOIf/zZj4APUO/sZ6hpvLeRNS7a+nysF9SBnq3fDv6pmL9yAcxEUqikMs
	 u4jy8sfhEIt4xmbUwptgKNXejCENdqyNa6Fg08UkH/ifwd58abePlUlY0mvcemXdxCQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757807;
	bh=8Uf7HoTl1paeyNcoyaCmR6q5Q0dxa/vdKcjBnOfd0EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o5nVR0aiLEtwFzSRRqnhAywWPMA/CuOWi/oHVkaQ21GdoqVg7Vumv7ZaF4P9a7Axr
	 kNwG8A2e1vrKX46iWcFVplmR/hl0uyhviTyqLbgVrN7dQEETfLu/X4b9VWzr1i46Lh
	 2qZCj0YhVFMLijXuL+p2rXLnxa0R1ib363ZGz3VElNgFd2k3v4rW3+wDTgkhwkSvTg
	 HIMU6Ts0K8fjXk4n8ZNTYE/nRwwaEx/N9sHFJq1Ph8U+tWoSnTyowgIf9IwP2t6m2/
	 4LJhsQZpxO7tpoMBGstakT79X4jd6CZKUtxCu2RriHlDszrK6EtmQFp9JMiyYayWgY
	 /KydISnBuiy/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72A84606EA;
	Sun, 11 Oct 2026 22:30:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 138D8DE0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0589580CFE
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qXjoIcLCtWYR for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:30:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4150C80CEB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757805;
 b=V6WA1F2Nv340lQwWbaIb0iW8v8BvvdvOzwXBbii0eV1xl0ehufjV7DS0M8IRb11twVxb
 PasQO6WSteAaXmwJNPx+O8Z5nMGaEwjYuxGuhcfvQ7HODXkrGBuh7ljLiZ99BnfRgPkbR
 2NCaDQP+hNhW4DMWfepO3N61HCFRMxAcwpCOCokQeph5x8kHOhYVdrOpQBhr1jte7NBWP
 i3POj1w1MxgslTSA121IvScxzi70kf0nrcKhIT+yGrEjJankIV22FwLs/gdzk08yynK5b
 ETM8fHabTmTsHbv/IDclT6f9mfnhdpNoJ7qXVrfrtdnJzaoF386Cq4GwE692QyyIBBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757805;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=8Uf7HoTl1paeyNcoyaCmR6q5Q0dxa/vdKcjBnOfd0EU=;
 b=rsKiFKCskGJ2n+Ea2AxbLVRh5mrd/STUI34UgXs+Gd5e2KL+mR9lXcTIl9v3IjxNH0kJ
 5WErinhXzllbTke+zzfyyumyZjqyIhgZS1Jen+5U2d6D8Wq6bzKUq5rGGniMhMuZF5D7k
 u34ipv0vz7D1d+EF0w6Nkt/a1B3X7r5RZWAsRSb3U8OgRIG1P0FlCVfP+H/w0TzSQne9f
 gB++fy93T7Y2iyNyOKKf0wEalB7/dho1xlXnjvELSWu7/U+Ytpp6jQ1xKCvvJ9UMGyizR
 4X6if+gYiNRQEUQS5IudJi3dPTITsdvLisoA3FIlEmRaVq3t0p4EIpP5YAUt92uN9+g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=DruVmLJZ; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=DruVmLJZ
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4150C80CEB
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757803; bh=8Uf7HoTl1paeyNcoyaCmR6q5Q0dxa/vdKcjBnOfd0EU=;
 b=DruVmLJZ4bVP76+1C5LhwDB/uyqMfe+TdZagFL1iBbbvlBnceLnApkacfZBl+NAoDd9TwPb0K
 Mg2mXJKfxtPe1SHCf7yRT45sa5wvdJUeIcfc9ZPCqjiGrSiN/dlgVrkDkEp511oAIQpKljsQATJ
 VFDbLcFWDCKKY/1V5Vtnf4CjoeogZT1WIEoSlNBEywz/6HLpBoCSEiUaFopSqjUDDoN+F32GK9h
 uYMqX4OoKOiFN8xAJxz0/fwKQx9FQsoo8N87gzzuYn/T8wNaNL0IDfea/vr7V05qN2Fs7jF3KnI
 69MgatRbZJ6UbmB1TI8GPok22FvBhYbCbJXRBZdz0krw==
X-Forward-Email-ID: 6acc0dea4548822a24c17352
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 07/37] clk: rockchip: rk3568: Use correct clock id for GPLL
Date: Sun, 11 Oct 2026 22:28:42 +0000
Message-ID: <20261011222930.1085075-8-jonas@kwiboo.se>
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

The GPLL entry incorrectly uses PLL_HPLL. Use PLL_GPLL to match the
PLL represented by this entry.

Fixes: 4a262feba3a5 ("rockchip: rk3568: add clock driver")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Split from "rk3568: Fix trivial clock configuration errors"
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3568.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index bb49af358e60..86881728667a 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -77,7 +77,7 @@ static struct rockchip_pll_clock rk3568_pll_clks[] = {
 		     RK3568_MODE_CON, 2, 10, 0, NULL),
 	[CPLL] = PLL(pll_rk3328, PLL_CPLL, RK3568_PLL_CON(24),
 		     RK3568_MODE_CON, 4, 10, 0, rk3568_pll_rates),
-	[GPLL] = PLL(pll_rk3328, PLL_HPLL, RK3568_PLL_CON(16),
+	[GPLL] = PLL(pll_rk3328, PLL_GPLL, RK3568_PLL_CON(16),
 		     RK3568_MODE_CON, 6, 10, 0, rk3568_pll_rates),
 	[NPLL] = PLL(pll_rk3328, PLL_NPLL, RK3568_PLL_CON(32),
 		     RK3568_MODE_CON, 10, 10, 0, rk3568_pll_rates),
-- 
2.55.0

