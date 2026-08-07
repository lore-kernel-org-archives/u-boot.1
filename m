Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3535C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CCE880E78;
	Fri,  7 Aug 2026 16:45:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ixQmc0AS4k9E; Fri,  7 Aug 2026 16:45:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1536F80E6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786121125;
	bh=mTwvYkkug8ryg66k01o89JZisbFX9vt/wQfb7wqMcCg=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=k0eQX4VUPMOiIIVqKyKzTA4hMwRVZLde1fzDVj4+XHXoIYL2fLymFoe/kpyAO62Db
	 1WUqAp4lKLySVM4+Cpt+lRfHKTCVWRzNVhyHYKELiS8youdRtKboEMNa+XU2ap/yip
	 vCwJuGlqBsi1TMiRv0e81Shb9QsgtZA9ctnIcaVMH+CnLtXlCvtjnRgU28sQQXr+x2
	 Syr4r6NIEgrzP86KV5vtNRMBFQopSqF5eN8zQpNALIEZpMMiHzLwDLtiya6vkYlV7Y
	 nyB4zD/b3DvCnJYDsqoa8VOm+d29wmIg0Swkpcjrf3shDii5sTGXS1unYPyMlbZtTW
	 u5iug8q9GwpNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1536F80E6E;
	Fri,  7 Aug 2026 16:45:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 64B0F296
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:45:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 566B64010A
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:45:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wb1o1aNfwrkh for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:45:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:b8b8::42ab; helo=smtp-42ab.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0B2684008E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B2684008E
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::42ab])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B2684008E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:45:21 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hGqb84256zPJL;
 Fri,  7 Aug 2026 18:38:28 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hGqb73r9XzTQk; Fri,  7 Aug 2026 18:38:27 +0200 (CEST)
Message-ID: <0881ae1c-1d92-4c3f-abc1-77608abd9850@0leil.net>
Date: Fri, 7 Aug 2026 18:38:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] clk: rockchip: pll: Fix double use of postdiv1
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-2-jonas@kwiboo.se>
 <cdb6ebf1-6d92-45ce-ac93-18135c23d3ca@0leil.net>
 <811ccc5b-d7bf-4c4d-930d-d66bd388919e@kwiboo.se>
Content-Language: en-US
In-Reply-To: <811ccc5b-d7bf-4c4d-930d-d66bd388919e@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786120708;
 bh=mTwvYkkug8ryg66k01o89JZisbFX9vt/wQfb7wqMcCg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DCGVDSOUhPKRoB6DcZt8ee2Eee3bs+RR+8C3eHUeta96CwimMJKhqMxc+rDjX36bO
 1Hnx83HPHiY5UBMU2JynZtwi5G+f5F/ylxLACWKxED3S8QKmBZQiENpskSbB3EuNiJ
 SaGeP298vtX5d5Bu7eMj9zu4uKYmnz7T5Bvic1fXH9CQtk34QMEkk5bftc2jHkJBUu
 rlSELNsutP4Iv+QnkFUv5Sr0UYLsgIVAc7DY9Sl4usRaJHbQ2Rc39TkhOzdQ7CsaZH
 bQDY9vBxm2QeB8MvRhfz1+MzzyzO4h8+9n5bXbQvxsFZlXKlL6zP733+Mta9kfDNvq
 ugLRaeuXmqxJw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=DCGVDSOU
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 8/7/26 12:38 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 8/7/2026 11:36 AM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 7/30/26 4:12 PM, Jonas Karlman wrote:
>>> The possible frac_rate part of rk3036_pll plls is divided two times by
>>> postdiv1 instead of both postdiv1 and postdiv2 as the integer part. Fix
>>> this by using postdiv2 in the second do_div() call.
>>>
>>
>> I... cannot find which SoC(s) actually makes use of that function. It's
>> only called when pll->type = rk3036 (which is 0, so anything that
>> doesn't explicitly set ->type will have its type be rk3036), but all the
>> drivers declaring a rockchip_pll_clock array specify something that
>> isn't rk3036. So... is this dead code or what did I miss :)?
> 
> It is also called for the pll_rk3328 type, i.e. rk3308, rk3506, rk3528,
> rk3588 and rv1126, strangely not for rk3328 (in U-Boot).
> 

s/rk3588/rk3568/ above.

Thanks for the pointer, I missed the second call to 
rk3036_pll_[gs]et_rate() when pll->type = pll_rk3328.

As for rk3328, it isn't using the common PLL core from 
drivers/clk/rockchip/clk-pll.c but it is indeed weird to have it named 
following the name of an SoC that doesn't actually make use of it.

> I do think there is a very low chance we actually use the fractal pll
> rates in U-Boot but the double use of postdiv1 seems (and should be)
> wrong.
> 

Alexey started to look into supporting them for RK3576 and found a few 
issues, so I'm guessing we are going to start seeing more users.

>>
>> Where did you get the formula also, I couldn't quickly find a publicly
>> leaked TRM for RK3036 (and since I couldn't figure out which SoC(s) use
>> the same formula...).
> 
> I think they are very similar as most fractional plls used by RK.
> 
> Following is a snippet from Rockchip RK3036 TRM V1.0 20150907-Part1
> (that used to exist in a GitHub repo at Poco-Ye/rk-datasheet)
> 
>    The Fractional PLL output frequency can be calculated using some
>    simple formulas.
>    
>    If DSMPD = 1 (DSM is disabled, "integer mode")
>     FOUTVCO = FREF / REFDIV * FBDIV
>     FOUTPOSTDIV = FOUTVCO / POSTDIV1 / POSTDIV2
>    
>    If DSMPD = 0 (DSM is enabled, "fractional mode")
>     FOUTVCO = FREF / REFDIV * (FBDIV + FRAC / 224)

This one's funny because I think it's supposed to be 2^24 and not 224. 
They made the same mistake in the RK3308 TRM. It's fine in other TRMs.

>     FOUTPOSTDIV = FOUTVCO / POSTDIV1 / POSTDIV2
>    
>    Where:
>     FOUTVCO = Fractional PLL non-divided output frequency
>     FOUTPOSTDIV = Fractional PLL divided output frequency (output of
>                   second post divider)
>     FREF = Fractional PLL input reference frequency
>     REFDIV = Fractional PLL input reference clock divider
>     FVCO = Frequency of internal VCO
>     FBDIV = Integer value programmed into feedback divide
>     FRAC = Fractional value programmed into DSM
> 
> And Linux use following in rockchip_rk3036_pll_recalc_rate():
> 
> 	rate64 *= cur.fbdiv;
> 	do_div(rate64, cur.refdiv);
> 
> 	if (cur.dsmpd == 0) {
> 		/* fractional mode */
> 		u64 frac_rate64 = prate * cur.frac;
> 
> 		do_div(frac_rate64, cur.refdiv);
> 		rate64 += frac_rate64 >> 24;
> 	}
> 
> 	do_div(rate64, cur.postdiv1);
> 	do_div(rate64, cur.postdiv2);
> 
> In U-Boot the postdiv part seem to be handled for the integer and
> fractal parts separately. Maybe we should just try to adopt something
> similar/closer to Linux?
> 

Casey has posted a series[1] porting some parts of the Linux's CCF to 
U-Boot which should allow us to import the Linux kernel driver(s) with 
minimal adaptation[2]. We would still need a minimal clock driver for 
xPL (and currently also proper pre-relocation) if I understood 
correctly, but we hopefully would need so little that it wouldn't cost 
us much to effectively have two separate clock drivers depending on the 
boot stage. I believe she's looking into making it work in proper pre-reloc.

I'm honestly not sure if I'll have the time to give this a try any time 
soon but maybe someone else would like to see if this can work out for 
us. I would also feel much better if we had CI with Rockchip boards so 
it feels less like a coin toss to do such big changes.

[1] 
https://lore.kernel.org/u-boot/20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org/
[2] 
https://lore.kernel.org/u-boot/20260720-casey-ccf-upstream-july-v1-33-8fece1b0333d@linaro.org/

Cheers,
Quentin
