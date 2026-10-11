Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF33CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64046606E2;
	Sun, 11 Oct 2026 22:31:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UW3d2zFvcseA; Sun, 11 Oct 2026 22:31:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B6941606E5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757910;
	b=mE/dkMe6hhGzZK+SMoBHV5PC+vhFFILkAoOiebuz1Xckf5/VRoo4A2ybm/W5Uq+lVevh
	 O9gC/MAxC92ncvG4tDpbRr4V7uujXvCow4B9jr4hMEaYpOZwX+aYM34Ak07XdnH2zcxhm
	 +z9m4VhNI8QbzpzTNYAKghUT5AlMT8QbGqeH5jPfTdr/bIREpjv2Bgo1tvJg4lzUfbPsf
	 KeJBh8uXGYgmJIHrRirO9RbA72St3gsSd05X7A2kcmF1p+Y0OB3sbdFfHfePgAuJGXS/9
	 RFZb+NV43fu+wmzvgHPVHeysuBVrpsf1oK9byFjxeS0tJo7tSTtHFw8mIEsgu9SHk6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757910;
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
	bh=Zi0jHAbKsRTe8xrxPCH8ZXwh4uqUoQfaHMzhaeFApBI=;
	b=hE0LbiLI83eiKQ3id8YhNx8tKxUimmCGjBKsgTmOYb65N2fCJG9D1I1y2eE9YW1rcK9W
	 tx0aSymFIKloJj2Pk4uqffTEg39tCLhXnu4hEuEtWkbHkdf+9IV6AxDfZoUd/xBIxCfsh
	 zEOAXbxFTNryIhgekiQCDNIek0KWDPAZETcRXfNulKmymnn46fz5PBltZiHcE3HPiSaiC
	 XpqchFrsyYgN4VLwM9Cj751wh+Y8xMjnToxS6KrHRGrkomQzGLkQbXm2OiGhHDArakymt
	 XKLWyb6YEZjTGGE7p7v69pwmqs802MvO74mW1DDIyZSwROYuj0WW7b0AlD7nRdEAD8Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757910;
	bh=Zi0jHAbKsRTe8xrxPCH8ZXwh4uqUoQfaHMzhaeFApBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OmvO4FxZUMtgEOm/VtJdTBQqYCdtFyIBO07wtBWVuh9nJr6gF1QuRXKr2/bXNY/jp
	 M7NWf8wXfJixSnObDihABe7v0Y5/dlb6fcj3M6r2DywOkJpRSUcecBpDeYEcyvogKI
	 2ZGhKXfAE8NgkgaMiqm26aiZm6YVivC2nkWCyCZ8rf6V7pgizf0en91Qid801IBtpc
	 000cbN5bX/jvrtj1mv+bfn0RS3Zex2rxnjOgvCfB3hd8IviUleP/NZkijTMRIV8Lrr
	 rZBAWkt9Bv50H9d1R3zv08obNEUTz9mPXLYGPRRnQTnHIorSXG7j2KKadI0jlfDGxf
	 vMaGIF4Yu7tBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6941606E5;
	Sun, 11 Oct 2026 22:31:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DBDA5DE0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDCA180D50
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b41yuqnhiEU3 for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0E5D880D7F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757906;
 b=gecku2nl0G6iE+wWPdPQSO1WSpgHMMz8du6+1zlCV1qBr5hmN/5llFOjxlj1n+Mmy+QZ
 mqool2XwOiSD343h1jVP8CO/MsbrJIfKJogM/dkalUVuQJMqyboWRVcD4OQwlACwNUp++
 rllpYER+SATYdByp7+uyerls+ZjqwR5em4kz7+oAgnCH0jBv7EbkHQu5h1DG39nMQZEhu
 h/+2hEcjtkCR+8VSrceFklvFGNE91pFq0rknMiYHkYVgIls8xVTefFWUOxcJHhGwbpqze
 Ls+8bM6w8RjmvjzzUzV4pY5kt3kAQEXJTajhjClXMWCaWL8KjvnmemZDMb4mpFLYEFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757906;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=Zi0jHAbKsRTe8xrxPCH8ZXwh4uqUoQfaHMzhaeFApBI=;
 b=SM4bAIbkA7DnB9G1MOrxzRLyFFNSc+IQJorTqHt8nVyGC2agWAsBLUBYptUI9LFCX9Ql
 sVr8c9Wv3NtTxtclkH0E8wHVgNFgC+7xNovAWzaA9ABeTLAl1mtPXBKa1qO/bcLsa+dJf
 ae994B4Huci7JeBiZYS0PtlITe4MhecFe5Zliilfrr9eU2qro8CTsuknllnT2JzhWaqT8
 Jn8FrCNIVr3JgsqnFHLR0RY8fyYftVBV5TdhdhjNquJZPRFWvHUnJszjIIcfmq6Hp3GkV
 VCOOVmR1YIq9NrQsyEmvjU5hpXdLRfWVqELEF13E74JSNL/ZUl3xmXnaIzXjIAMtCIw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=vcf1UIur; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=vcf1UIur
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E5D880D7F
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757905; bh=Zi0jHAbKsRTe8xrxPCH8ZXwh4uqUoQfaHMzhaeFApBI=;
 b=vcf1UIurdG7JOGyGBDrnGqcHgZXW6/p5gz+CGBlb5uiQrw75jGz1LPz/TxR2kxbfER/2gyGWK
 c1NE43t2yK00J4WT3cf6qvBpmfviXtT6+aMxAfPEsmGgYOAyBTO07vhzk6ha7f3CJSoWDcwNqqn
 HG5NLfrshGDgNQ1i6Pji1U/6fx+EaBS27fBHYEhpcb9ocj6o0vt0eysR08He5B8wpv43HdEzz2K
 IHx5e2L4tlnXFac5cICYangpulJ61sReqyfkTC7BzV4VBEj6XUMVGj64B1Yxe7NfnvGpqY7J0Ma
 2N8PRnA61qiUHz5aLdp14iDGF14H2cgelTFTdfQr2mlQ==
X-Forward-Email-ID: 6acc0dff4548822a24c173f8
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
Subject: [PATCH v2 13/37] clk: rockchip: rk3588: Fix ACLK_BUS_ROOT divider
 encoding
Date: Sun, 11 Oct 2026 22:28:48 +0000
Message-ID: <20261011222930.1085075-14-jonas@kwiboo.se>
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

The ACLK_BUS_ROOT divider field stores the divisor minus one. Subtract
one when writing the field so the clock uses the intended divisor.

Fixes: 7a474df74023 ("clk: rockchip: Add rk3588 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Split from "rk3588: Fix ACLK_BUS_ROOT rate set during probe"
- Add fixes tag
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3588.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index dbb4cd57e250..50e0a27819df 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -1927,7 +1927,7 @@ static void rk3588_clk_init(struct rk3588_clk_priv *priv)
 	rk_clrsetreg(&priv->cru->clksel_con[38],
 		     ACLK_BUS_ROOT_SEL_MASK |
 		     ACLK_BUS_ROOT_DIV_MASK,
-		     div << ACLK_BUS_ROOT_DIV_SHIFT);
+		     (div - 1) << ACLK_BUS_ROOT_DIV_SHIFT);
 
 	if (priv->cpll_hz != CPLL_HZ) {
 		ret = rockchip_pll_set_rate(&rk3588_pll_clks[CPLL], priv->cru,
-- 
2.55.0

