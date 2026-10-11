Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AF6CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BF1E60710;
	Sun, 11 Oct 2026 22:32:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w8N-Ruzg1Ftd; Sun, 11 Oct 2026 22:32:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C629E60714
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757919;
	b=CWSuT5P5wpForWNJgGGRGu9BdylCCMfYGor5zE3cJuJRyuq9pXkulgaIZydl2MjD6cFG
	 AfLeA4vaV1JfNZKZ2omh6ZmUwLe5BRZthKyPsBCLY8zIBWXd6+Sddk4Wc8a+XqsJi3bZL
	 m5F+0uzZgJaSe4j1+B+er+W4DRtJMjMClOjOg2Hq26c432It0w+RnMB6wHIJys6w2NTfZ
	 d7IXXQ6TMPCkj3EvNGIJZFNkS48ePort7lfWJsfk+8zc1AqTRfQGzBePTR4F3049JBG31
	 RGSWaD2T9rhUFGU4f/7/mjOG/dGWB8JlCAMkBOj1LNU2KUr5VQxnvsDqF9aNYHJbuoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757919;
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
	bh=iNNRfuO7aqck4VfCtVpY9aoauWQ/F0HVwMDntTPfAEQ=;
	b=YA11GEnCIgZWtZsvlrY3WcPXxwAqXROlFvMjFBzvTU0SjMaXpigVN+kyfAfxitGtxb0U
	 leL7EiSgIEbgdtUdXCuy1TrCWHVfRIXNGbfMGd9t23Cws96nA5OTu1RX6vQElgKt39EW0
	 buCprgTTMSQ/T5mCpTUmYcoBKtbJ7mt/HFAN7E5XdBIMoKcbFwE4Fwh3Q1Lv9iddkRX5X
	 Dw7/bi+2tbJdEniBIjDM2n8WmMt0RAMKXjn659a/KYNF2DYgxh3zUfjRDIXlYO6DghjI5
	 oPAU0SpE6xO8xB0KyvqPIHD9Nxa3DXH4CEmdSKB1c0tOgB6bw6fbAI4WT429FJII6vQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757919;
	bh=iNNRfuO7aqck4VfCtVpY9aoauWQ/F0HVwMDntTPfAEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MMrcIEDrLGSq7iahKo1LNv2FQc+woHLlji5GU0xh7GbbU+wLEwY9ejtE9n9JTpFed
	 LfXqcZsQICzd662rjfKkWxDJZ8JJ1gsG2oEaMera2C/T6/6Lbb6r/pkmqW2CGJYsJu
	 PoQ04ni8vZE7C38DcHlhRA1Kb0YSpfmGmHe7i3u5EkUPHawS5SVkkC6MIKQ7q68ULe
	 dU80eLK4nZEEFPFO45V0VXcawDIybUXoppwKp/2R+2cS2MIG/Bqsuvt5P3KA1ZNd4v
	 WWuG9z/5BpdlKf/qspS7TUBVbZZKa9Fa9RG7uItPQ9Pox/EijXHV9iwU3QQi4rCUum
	 GbzkyW/NTdlmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C629E60714;
	Sun, 11 Oct 2026 22:31:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BEE0475
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A55E980DC5
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JjS1BSNyXCNw for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D2D6A80D1D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757917;
 b=cbeUg+QE/445/xHyV4yclFJI/yZNCY3+pGT/dN6sOeTEmqP//LdocLNCD+Z8CN5Tueb0
 I8yMhSt1mLq0/3TnnjLFk2U0gm0Pmvhl9xGnkC36Wbs7BC81Za4M2pkRYjb+ABKUXwoRc
 ZoJkz6ywOyyTX2pfmV0hklqbsmhOQ+WCJROUMTK//wSdtDTGeisw2RMLQkZo8nEy199ab
 CF7NA9cmASFnLt2NPSoOlvAIjJu7mXYClYBcLMLf7RbdBW8I6EX1PPyBgEF264Rvuqbzh
 rKugypyv8jiTc6dFhNWLN3UAnLw8/QG7uVGINRs//xEP2ckvEvk5eNLIpufh6oYjRBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757917;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=iNNRfuO7aqck4VfCtVpY9aoauWQ/F0HVwMDntTPfAEQ=;
 b=NPKur8v9mdmZeZhs1a3easgYu+JUD5NwJkwVixeOye1JeoeuN2Dnusjs4eWhglmmCV0k
 toSFvwr0kvktmVYGPMbYfOl4xsUdVn8KJ0XfgqWMIF0UlAv6KFj4MDi7Qrc+y3wOnzFHf
 Vz7byx7GGMXemNUnyS6e/lmQjfm/Tooci/3JG22EPxIdK9NG4l4hcTkov/jCE1+wTzTFz
 RxpvaKrky0/8d9wBw2UhhO6JTM7mVlADDiA9rjI/lgulbA8q7SOPietH5jcSJtGZJYrC1
 ynZSuydS3wCI+OfFxSUjrIrTEGA52rKo/daJYTzPBLKyelhmoy7qZVydeEC+dP5snUQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=Wn9wjesW; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Wn9wjesW
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2D6A80D1D
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757916; bh=iNNRfuO7aqck4VfCtVpY9aoauWQ/F0HVwMDntTPfAEQ=;
 b=Wn9wjesWc+r3ajBRGX2mfjnj/Fi5EUAC3IxOSSaIu7Y7O2MiyiLdEeRqJfQO4fc05r6xjCgUk
 OGes8R0OBpR34kxFwGGYM5C8/LYYc80hlqbwiXlolY3lAFxG7xSRwv+T9Chbn4DyONHo2nPo7wU
 Shgiv7nJhT+9J11efJOEUbTM2va/xwzSYKsYb+YW0I/6SaFJyY0L4ihUrUqwhAHyjMDrL3IHjWI
 j3gjZn27A+gC7TRv0+C7qx9MOZzDebumgQvoWDRKWFsPqhGlbE1ZqCnZ6Gzd5yrjnihMDEQC1PJ
 K6d2xPqqjEjoFSE4qcbaxdeYrERRxWU6FXFGvSqhE+UQ==
X-Forward-Email-ID: 6acc0e0d4548822a24c17469
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 17/37] clk: rockchip: rk3588: Align BxPLL entries in PLL
 table
Date: Sun, 11 Oct 2026 22:28:52 +0000
Message-ID: <20261011222930.1085075-18-jonas@kwiboo.se>
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

Keep the B0PLL and B1PLL entries formatted in a similar way matching the
other PLL entries for consistency.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Split from "rk3588: Fix trivial clock configuration errors"
---
 drivers/clk/rockchip/clk_rk3588.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 3b21c7f8465d..aba200ad2390 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -44,11 +44,9 @@ static struct rockchip_pll_rate_table rk3588_pll_rates[] = {
 
 static struct rockchip_pll_clock rk3588_pll_clks[] = {
 	[B0PLL] = PLL(pll_rk3588, PLL_B0PLL, RK3588_B0_PLL_CON(0),
-		      RK3588_B0_PLL_MODE_CON, 0, 15, 0,
-		      rk3588_pll_rates),
+		      RK3588_B0_PLL_MODE_CON, 0, 15, 0, rk3588_pll_rates),
 	[B1PLL] = PLL(pll_rk3588, PLL_B1PLL, RK3588_B1_PLL_CON(8),
-		      RK3588_B1_PLL_MODE_CON, 0, 15, 0,
-		      rk3588_pll_rates),
+		      RK3588_B1_PLL_MODE_CON, 0, 15, 0, rk3588_pll_rates),
 	[LPLL] = PLL(pll_rk3588, PLL_LPLL, RK3588_LPLL_CON(16),
 		     RK3588_LPLL_MODE_CON, 0, 15, 0, rk3588_pll_rates),
 	[V0PLL] = PLL(pll_rk3588, PLL_V0PLL, RK3588_PLL_CON(88),
-- 
2.55.0

