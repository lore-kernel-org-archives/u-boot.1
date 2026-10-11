Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE3FCA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:30:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65CEB60612;
	Sun, 11 Oct 2026 22:30:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wm7Aa_JRV9cE; Sun, 11 Oct 2026 22:30:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 93A38606E3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757833;
	b=cBmjVVtNUFCxzXpmqTSufeQwd8bPqojlLu/9GJYTYFF2+RVya9G7h/BmKskhDN3mCAqq
	 GxvIZzi5GuKjsiXGj079VTwBhkXQ0sz4iAFYBWKmTYPAJ93kLgaIVWbzks/I6EBEFYdtu
	 KOBt7M4OgceEoT4TKxCj1WBfmn7JuZ4IW1VDhXoMPwLqUiltIF4P0CGZAb9ihoKuELR2/
	 bNq1qtd601n2b/LYY/n+s4HHUmavIiumxqI6RF7BFKNxYqZ3nidjbQ3eFNzGhywgI18vQ
	 bzTDvDTxJl5YIuZ/wwfi/zKkvcd8dFNfYUOfRpDXHRYy9KUA5KLruah7i59/wCAeGRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757833;
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
	bh=WZ/P/lVuUqNu9Wy/jGKjwOaUgQxMN2D05Lo/LzqqofE=;
	b=YrFIkdGYXAusbf5bs5PWlw2fqAdPgJgv+eUSBGhsWSempA3xvL5f1rCcJZuXJRODk2VU
	 pQuq22JQaTXufBGmNwGasKr12sZpzGrfUrjEiLa4LYRSPHPsywKvLvsb5SRO2jbyosWWh
	 A5+S9a2j7KsY0mTuqgAIBMakk/Asm966tZGitT7Uz6bw/ztgouWR0EcDnOPupHpnSw89M
	 4xyVz2RXzSHIme5cpHSB8S06V0LtSwOxMHn8uOnnaic12SG3FJbtkwNfyKKjtjvbON9sz
	 kYofgqhDSTkYPSHShlBbd5DYxBAYOXOcnxR2ca4WoFBLcwqd9n6Ng8KgrWgP9cx1KWQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757833;
	bh=WZ/P/lVuUqNu9Wy/jGKjwOaUgQxMN2D05Lo/LzqqofE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DK3hvXwRJ+xXz6GVsAOpLsbWrc/uhzQ2DrCoIrbVM/Codl/B7PDaPNyNUdNu7Mk47
	 E2hYlu7Uz/o4ajJwT2M1BKHz6lKJebKYFBImFJAVptHGKu58lJ2WBzwuBGORj6QrOP
	 CyI/6WfQ0Fem7SH1m3tpE6LI/58Y0iiSL+drsr9Gtpnj5CFTAa+G9rBDdo1KEPGVFb
	 K5YqQPpVmb379WjdRAM5/KYZ8kJKIyBtYuCgDITLeWLnhwJ0w1Unt5SurRAFxCYFRk
	 hcrcDiCt9qTpHqf7e2VJ/XJK7d3FCi5uYCDPRjuPej9M0KyIm0emYB2vY+Nz8qfbjM
	 dc9LEEM0KjQug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93A38606E3;
	Sun, 11 Oct 2026 22:30:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BEFA875
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A4A9580C88
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KEaHsTIlfD5z for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:30:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0546280C6A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757831;
 b=GdhQEOsCI9RrjuqScrZCJyzGqHZbmdNDiD5aTR2kj1LJOURimivIMZUYANvQDcDyZiZQ
 RsnJB2nAleZMvZTSgyJncBeV38igmBN5laIyiWcIP/EZn5RKblsUqIzES4Z+a8n9YfdfS
 2EPmKHLBP0ZVIfPxY6THnr+hnJLX0TAZ4EGs/HLn0Gu5kw3J/+hL18SoXMEu4vkBmpMeu
 i3svEMOKs+bUrK1dhmL/A1ZKaIzm4QIo7B91UH/FN+QmaZA6LTISssrEKe9LubGk2ffA6
 qNrmnKLPnbB3+OuQ4yfQUKQfpHaTblVwjeHRyl02eVVs9eSCELWUSpjo61geZ7zHJCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757831;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=WZ/P/lVuUqNu9Wy/jGKjwOaUgQxMN2D05Lo/LzqqofE=;
 b=Q4K/n63R3X4YOvionaxu7mklZmECOJAU3O2FwcJ8WvZBp8MJJzqjsNGSq2XHIlF7d7k1
 kE3lR40T5dokvWLTGJBK8612im+x5gWzpaaVidqWBRBA6sVGx1qlIgJrZMTzYObUDEvQo
 ySlRTFkVPq1QqhSLAx2GSmLExgjGEuvtk6cJyb8LihEUmrYJIOHb+BwH3DPA2gEE2FDk7
 Nn+K9QOeyWBwKIYBOvbu+a0eqYUGVaBCSezXOI5cc2QBdxnO1Yi+T4Ey+SW9n879VLyU0
 ZtutrsejGj9rt+4eYRnVwkuVgAnT2xDHyUWEpjBucu69KcZaZp00SZBzpExhgf9hsrQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=I7A5ZgSX; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=I7A5ZgSX
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0546280C6A
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757829; bh=WZ/P/lVuUqNu9Wy/jGKjwOaUgQxMN2D05Lo/LzqqofE=;
 b=I7A5ZgSXEI551jl4AF4jKt7XOqqlVxlhwYnuOAmRbwYEaGwTIuDevLp1RAGEoI4BibifJjna8
 ErNHGN4oq+3OxH/GBNdLVY3HeUFIsJXNejgljnlInvmryeHinreaigUELgEiop31gxSUoi8Fqyq
 TNqrYfzmxzQQ8AYnAGX3NyoZ3arapf3pFhmK4+Uwt2R53AH9KhBMJqjLjDvT2LIVA44EaRDhKy8
 aSZRsmwHm6k3KvrUqhCI8CU3CkslcbA1tLqwmnHFgIdaLB5DVOSdrP80pm/pj9t1Y4sYlMT69/h
 7yzHXNxSdM6ar8w+/E2j/IknlSFheKx0GUUKL1hIvvqA==
X-Forward-Email-ID: 6acc0e034548822a24c17413
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
 Tom Rini <trini@konsulko.com>, Eugen Hristev <ehristev@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 14/37] clk: rockchip: rk3588: Set ACLK_BUS_ROOT to 375 MHz
Date: Sun, 11 Oct 2026 22:28:49 +0000
Message-ID: <20261011222930.1085075-15-jonas@kwiboo.se>
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

The clock driver always reports ACLK_BUS_ROOT rate as 375 MHz. However,
the clock is initialized to use GPLL as parent and a target rate of
300 MHz, with GPLLs typicall 1.188 GHz rate the clock ends up at 297 MHz.

Change to use CPLL as parent and request a 375 MHz rate, the same rate
that is already being reported by the driver and what the SoC DT uses in
assigned-clock-rates. With CPLLs typicall 1.5 GHz rate, this matches the
parent and rate Linux typically ends up using for this clock.

Fixes: 716ed2a8c0bb ("clk: rockchip: rk3588: add hardcoded assigned clocks values")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Split from "rk3588: Fix ACLK_BUS_ROOT rate set during probe"
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3588.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 50e0a27819df..872e36748caf 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -1923,10 +1923,10 @@ static void rk3588_clk_init(struct rk3588_clk_priv *priv)
 {
 	int ret, div;
 
-	div = DIV_ROUND_UP(GPLL_HZ, 300 * MHz);
+	div = DIV_ROUND_UP(CPLL_HZ, 375 * MHz);
 	rk_clrsetreg(&priv->cru->clksel_con[38],
-		     ACLK_BUS_ROOT_SEL_MASK |
-		     ACLK_BUS_ROOT_DIV_MASK,
+		     ACLK_BUS_ROOT_SEL_MASK | ACLK_BUS_ROOT_DIV_MASK,
+		     (ACLK_BUS_ROOT_SEL_CPLL << ACLK_BUS_ROOT_SEL_SHIFT) |
 		     (div - 1) << ACLK_BUS_ROOT_DIV_SHIFT);
 
 	if (priv->cpll_hz != CPLL_HZ) {
-- 
2.55.0

