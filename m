Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9E5CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9566F80D7F;
	Sun, 11 Oct 2026 22:31:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s0wIYVTSXANh; Sun, 11 Oct 2026 22:31:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CC01380CD9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757872;
	b=IG7wqpnwMx5c5fuLKr/zfr9X+Xpfbr2BTK2Zo9NPMcgNuaP7zMmbM6Fx5UJHVwLleQo5
	 a03ezPzt/3HE+4NwGfGCnMKrXkmsofNa2ELev4McQE9b1yVN+4PL0tL9RsI6GKaokdN+1
	 pRUtXNhHLb1pxysLZO41VnYCsz1fNFTvuEfrLJY3B1F59sKWF6iBBdIaYMOJWnfn3AuB6
	 Olni1TCEcoY0I7x7fU/xPo1PAAfAOL5CtVZUBgVcN6PE8oWThh7iN1AqdF1qZOqWG8ym3
	 fmakhyoxZFqdcspZFio2VXgl3e1YJu23y9UeVEHLQlsVf/o/pCl0/wJH7ALjHtnV5KQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757872;
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
	bh=GFugDxBLqoP0Go7zSoskrTtsdT1t4TscXvU3vPalN3Y=;
	b=rNOik6NwsEXexbzdLNT/nx22BFXxNtDGBVKotiIRdoDKX2T+GKMVM/3TnFDAnNP88l12
	 XAXPIaMICOvCnaNfZgf1ruG3zvosPDXJG/dShd+4IraeQAR+KpSvoj5NnNV2hTIlu7ckR
	 A3zqaE8TClxh8W9UZkmTTIhuhSWdGjjxMgvRoc9VrBFtFZCJ4khoU1TWjF/WXumu6vjZ4
	 HcOYmrwnpPLghlPe5rlrLQcl1WDNBEwTc3lm+lU+/PsBPn/ZKjC9+pbmcvL+oQX8Es6XQ
	 /PZrP3CKFyV02bUPsNZtqZuBe8zdXcNvrBQXhrM5KA2OVyJIjNx2OMLBILAD6iWrGnA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Occ5fXbz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757871;
	bh=GFugDxBLqoP0Go7zSoskrTtsdT1t4TscXvU3vPalN3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zTR3lmbSNb2JM3UAvXv5J5BiwouJwoCDQyy3uO0U14FXJEe32ojSgftOR9cliadqv
	 x3OLmFI2rMqb5fsENzjCFZlIjRFgbvyiK+YpuwBrM/E5Navf88rYsVE7I5LFmsBRNt
	 zQEg6Fo52w3knMjUUHzqb9poznpCASC6PU5S6FZGBPUQgrDUGrFBznEyTtkCk4raey
	 85tI6mi2q3FMnexh3LaMqsG1EqoijyR/OFQAWs5z3tWzeLwFYtxizb8RC2PwsbfJWC
	 ujVTypAcKE5kMfySWNw8nlGXHsu5POg4z7u4C2LLZYFfVoiraVYjTDLep57LIEl8nF
	 Dx6V2SLRKJz8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC01380CD9;
	Sun, 11 Oct 2026 22:31:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FEB21DE
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 85D2680D29
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2epeNxpaQKUT for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A34D580D7F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757869;
 b=S/9HKdk7Mtqhn93zmEGCIYfO/XjYxxz3OMJD8O9jtelce5hZfZvrb+4MZLQGTK49+Qf8
 Tk36wVo22FU17Qhq0YjQKQByWnz3oq4afWtVyLNgseUZrkkNEg//4ow3dQCvyoPikJbyv
 hVloRM9YaO3vx7T9+hFa7QD/aoOm20BpUaI303jIs4yOWHqhrfRViOW06L4udNlSSvHmA
 cJPM32hBQkwA+zQbIxGgw806woYaxmHaRsqjBbkpDZkLmoemAzXfe5+GiUjWmADlju3kF
 oepvuiK8eBgJw1PVSV4MH/NA4GlQMxstz3A/To4q70nkTMKC3qLqvirXeTm9JhlSV8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757869;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=GFugDxBLqoP0Go7zSoskrTtsdT1t4TscXvU3vPalN3Y=;
 b=knaAPm5SevzQ8odh9NckicOrL8v4nYMES8J5hSDeFTZyKMgxxGLsRpuPSsXdPsfC/UHB
 WwMYl5tVFDtJtrqLHl01+vnc3Y0TybWxS3IkGK/W5RtKWRXPJ03mbg5UdToeNV4P8D/Oy
 NXFnGP/XAXEF4T1LNCtaLzhVGVOC43NDAC1Ctiti9SK5EZjuq8JsHmpRojSTtJ8TWEIT/
 GGEF4sHToxkuulRVinZwzO1RixNsBoNKoG9c3mMeJg9MTGK1ici5ux/99bT+TQiw20vB3
 FTFbP6hawIkmy+Oe5TlkNLAwyNBE5bGaeMRQSFmIPnYSmpozxAgsjatxBCjN+VyDG2g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=Occ5fXbz; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Occ5fXbz
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A34D580D7F
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757868; bh=GFugDxBLqoP0Go7zSoskrTtsdT1t4TscXvU3vPalN3Y=;
 b=Occ5fXbzs11/sJ26GH0iMjHIb52ZqvJz/NHzvFUySodF5Mvz0WID1G2GIWOBd2BMPrLq3zGGW
 qg07man6MRfRlT9U3YTbHZBUiXBA3xEd7E2XgZZ9OyyGAb5nhIvbT5diTN/Fm/5pchJEetBNwYp
 CVhLlTwRfxA/EdUEDippT+uvUtNfMEctoFT6XcUOB3s962MHs1AOcEub/XaWNKlalgxcGE0iZSX
 /x/FS16nBd/hWcxBxh2prruKjbmicaPYj3EXHm92q4AcETvGHgYnqY97NmT1abuAUhse1s/e+fg
 gJBbaLIhBMlt8RzDbUFL4Mh/WeCtpsL9J53ljzmUcg+Q==
X-Forward-Email-ID: 6acc0e264548822a24c17528
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
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 24/37] clk: rockchip: rk3576: Use correct TSADC clock
 register
Date: Sun, 11 Oct 2026 22:28:59 +0000
Message-ID: <20261011222930.1085075-25-jonas@kwiboo.se>
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

Parent and divider fields for CLK_TSADC are located in CLKSEL_CON59 not
in CLKSEL_CON58. Change to use correct CLKSEL_CON for the CLK_TSADC
clock.

Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Split from "rk3576: Fix trivial clock configuration errors"
- Add fixes tag
---
 drivers/clk/rockchip/clk_rk3576.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 17f9b01ff0c8..e66368b01b5e 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -703,7 +703,7 @@ static ulong rk3576_adc_set_clk(struct rk3576_clk_priv *priv,
 	case CLK_TSADC:
 		src_clk_div = DIV_ROUND_UP(OSC_HZ, rate);
 		assert(src_clk_div - 1 <= 255);
-		rk_clrsetreg(&cru->clksel_con[58],
+		rk_clrsetreg(&cru->clksel_con[59],
 			     CLK_TSADC_DIV_MASK,
 			     (src_clk_div - 1) <<
 			     CLK_TSADC_DIV_SHIFT);
-- 
2.55.0

