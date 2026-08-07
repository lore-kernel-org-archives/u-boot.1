Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6E9C5AC7C
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 10:38:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AA5760909;
	Fri,  7 Aug 2026 10:38:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kWRzgB7tqGDa; Fri,  7 Aug 2026 10:38:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E58C1608F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786099128;
	bh=byYSGAN8mQujLTIXakezhNPXOHqvZZ454Re73ZygRaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eq4qqvJZwhTKax/narMLFMluPTv8MRLzKoFG5PHUnlyammRss4HQgcVWAYEpN81KU
	 PZdwCh6dqXHDMHVWbRS9BWRT7VnAhgEqwHNarNQcvRnKk91hYp3a0+Jj5DCaYlSouj
	 oQTbC1XgutHtmF3uCWZNJL91314f+S8Ybep1yrlWX17rVitsUYkRXTmGgWDeauW6Gn
	 aWQqoKGRsyF6W1VokEhYDJgkv/z5tanOE+KSLvnF1QeZTxlal1geMZ3zp5snqkNoY5
	 dVZH3vhD5tx/scIavLIwoJ0dP/zCU8SMUcse0KTVFa78a/9AWD0HTmwzx5tCxL+gOD
	 qWqp6fbfzlQIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E58C1608F4;
	Fri,  7 Aug 2026 10:38:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 52379282
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 10:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43F33608F4
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 10:38:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qW6lv8lzdWzH for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 10:38:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=165c=ga=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EC13F608ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC13F608ED
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC13F608ED
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 10:38:44 +0000 (UTC)
X-Forward-Email-ID: 6a75b5aab8d98458e219311d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <811ccc5b-d7bf-4c4d-930d-d66bd388919e@kwiboo.se>
Date: Fri, 7 Aug 2026 12:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] clk: rockchip: pll: Fix double use of postdiv1
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-2-jonas@kwiboo.se>
 <cdb6ebf1-6d92-45ce-ac93-18135c23d3ca@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <cdb6ebf1-6d92-45ce-ac93-18135c23d3ca@0leil.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1786099123;
 bh=byYSGAN8mQujLTIXakezhNPXOHqvZZ454Re73ZygRaY=;
 b=Ia/vD+m9OunMFCvHQnE9YJ6CNCZ+ntLtcZlwk5Z4tlG/rshf6xT8wvuumo0pYyNURF0I7Pdlk
 L5IW3b1E+tEYuKmTxfRnAH6rBra/rqw15v811e3tdMHVyvCV+vKG7B6shm4F/QFMRO2NFNv7Nb0
 bJ127ogq/x2x1RrxJPwgLDQIODONQ57YZ6Y+V/IL6uY7qhvgzVejfdxD+l4+1k/B4Q2imHclQd6
 sbiNcDz1gRiGJnmeEM58T0RBWZPMQB9+sVCRxzOtYXOf5UxobyDg4jq7+r4dJvmRinN4ut95qJO
 iBdL1VIoWYm+ztENs9Sy6jmQ1SCOMJ03F6zboBRAyk1Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=Ia/vD+m9
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

Hi Quentin,

On 8/7/2026 11:36 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 7/30/26 4:12 PM, Jonas Karlman wrote:
>> The possible frac_rate part of rk3036_pll plls is divided two times by
>> postdiv1 instead of both postdiv1 and postdiv2 as the integer part. Fix
>> this by using postdiv2 in the second do_div() call.
>>
> 
> I... cannot find which SoC(s) actually makes use of that function. It's 
> only called when pll->type = rk3036 (which is 0, so anything that 
> doesn't explicitly set ->type will have its type be rk3036), but all the 
> drivers declaring a rockchip_pll_clock array specify something that 
> isn't rk3036. So... is this dead code or what did I miss :)?

It is also called for the pll_rk3328 type, i.e. rk3308, rk3506, rk3528,
rk3588 and rv1126, strangely not for rk3328 (in U-Boot).

I do think there is a very low chance we actually use the fractal pll
rates in U-Boot but the double use of postdiv1 seems (and should be)
wrong.

> 
> Where did you get the formula also, I couldn't quickly find a publicly 
> leaked TRM for RK3036 (and since I couldn't figure out which SoC(s) use 
> the same formula...).

I think they are very similar as most fractional plls used by RK.

Following is a snippet from Rockchip RK3036 TRM V1.0 20150907-Part1
(that used to exist in a GitHub repo at Poco-Ye/rk-datasheet)

  The Fractional PLL output frequency can be calculated using some
  simple formulas.
  
  If DSMPD = 1 (DSM is disabled, "integer mode")
   FOUTVCO = FREF / REFDIV * FBDIV
   FOUTPOSTDIV = FOUTVCO / POSTDIV1 / POSTDIV2
  
  If DSMPD = 0 (DSM is enabled, "fractional mode")
   FOUTVCO = FREF / REFDIV * (FBDIV + FRAC / 224)
   FOUTPOSTDIV = FOUTVCO / POSTDIV1 / POSTDIV2
  
  Where:
   FOUTVCO = Fractional PLL non-divided output frequency
   FOUTPOSTDIV = Fractional PLL divided output frequency (output of
                 second post divider)
   FREF = Fractional PLL input reference frequency
   REFDIV = Fractional PLL input reference clock divider
   FVCO = Frequency of internal VCO
   FBDIV = Integer value programmed into feedback divide
   FRAC = Fractional value programmed into DSM

And Linux use following in rockchip_rk3036_pll_recalc_rate():

	rate64 *= cur.fbdiv;
	do_div(rate64, cur.refdiv);

	if (cur.dsmpd == 0) {
		/* fractional mode */
		u64 frac_rate64 = prate * cur.frac;

		do_div(frac_rate64, cur.refdiv);
		rate64 += frac_rate64 >> 24;
	}

	do_div(rate64, cur.postdiv1);
	do_div(rate64, cur.postdiv2);

In U-Boot the postdiv part seem to be handled for the integer and
fractal parts separately. Maybe we should just try to adopt something
similar/closer to Linux?

Regards,
Jonas

> 
> Cheers,
> Quentin

