Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37552D46601
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 17:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98AE580325;
	Thu, 15 Jan 2026 18:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CGOyDMaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF26F82BF2; Thu, 15 Jan 2026 17:02:01 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E2A480077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 17:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-65e943048afso387431eaf.0
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 08:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768492918; x=1769097718;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K+LERpvqVH5vkRRJU30EBSFCSBFz9H1aTWsiD+YX05Y=;
 b=CGOyDMaXmwHhriXhRyU9qvyTeXaA0dgknXBL1PnxLVxKX9vT4c7ks5VolXelnEnTD/
 ihxanhZjk5ICnAz/qSnHJodUcrqIrnOIzdBAoBc3UxyC5HuHtNwUxS1rzWPnePkckiMe
 hMWOS2VkPy22yS/+GdnDTNJh5D90s48hFhj4As+DeLggMyZi4ZA1PkIzn/J4e26xx/T/
 CI0ARYM5JC7WLZbaCQZgwVina/b6yf9xK8HLDimKYVQlmzQnZw+0YMq3ZwUJLxHoRnk5
 nKxR87jTPsS7rUnGuKZMDHDQuZohIdxcye59qXUiQ8QddAugG3t0uxOceRy1QSmBgV3C
 +63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768492918; x=1769097718;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K+LERpvqVH5vkRRJU30EBSFCSBFz9H1aTWsiD+YX05Y=;
 b=gw3tt0b/DuPDMA674ikl4eiLI2ZlyijDBauCHGy+gs1P4PZf3GJYc3gctDqvCOeo4r
 sbHkIrREAsiDvKQT3WXR2mXBc3G2E8mkeSvF/FfRE5tiSgWb3vbOKb2+7WTYI86x7P36
 MyNxEi9GKCFNR8dnP2wc21bg6eHQ2RkO0eH5EAc4flpLdm8y9unu2vYQGdTHeeVKIDzF
 JxRN1X7YEiDPb1m2ZEf0fNgM5/r7VmBN1Sf0CH6PER+/0srRQ1Ha7w8Leuk4vWu6POfi
 IY2eVycSEVCqOu5yKC9a/E3Nfk1RpUc6tXiGQEJKNLn0vPrcuHZSDE4uTkunKPRU/8Un
 OovQ==
X-Gm-Message-State: AOJu0YxNHMElpxkzsLMHgbG4rZZ4ufsyrWGrJMhaVlRq30/2bg3J1m3z
 y2zjXRAmsCF6UT8XRA41RrY4CCI7z1RtauEy2PwDyt/spYuY5U+U7SysP+S0wWRERB4=
X-Gm-Gg: AY/fxX6Vq+xXDzmgL70zIUQJgzwuwwnwVlOdL1IGebXfHvJMvubTacYyZ2W7ZKGlMfF
 rPFP/AJLMur4gO7Q7JrbOxusfiGMD39NnzMvn/FB5H+kOc76q8NSjmh9QAg2sC79ZBfio7RYM/C
 Oj0MXnz0bsTMWWndqtd6Uutko2RJG5rvyy2GseIVKGP7azTGGCGqcDHrIXryPzvDOpQt7WK6uIm
 Y+pq9c+bz87aRAfrWYGcmyYUXEn2fNzaKsMD90D++RsFCTynHJ8kd2CMM8mR0BJuZ1f74ou7M4I
 en1VNXWRO/EQp/kmRXA651wy6h8pDH8jceL/a3tdW40H0n0hrm10s++ZBEGqCod1O4zRHNRUE6e
 u+NrvFvk/O/FW1P91RKyZepZBQmZQxRw5bcBboK/S8M8Livk4dPaCN+iAD5FP6WaNbeNR7ADcVK
 SdFaEK4SXwF8GWo9r6iVjz2SlnK5sIFd0oEobCiWZr5GbEV/IK+Q26hnKKzcad
X-Received: by 2002:a05:6820:16a1:b0:65d:2a0:4b47 with SMTP id
 006d021491bc7-6611795a63dmr95751eaf.31.1768492917357; 
 Thu, 15 Jan 2026 08:01:57 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:5a03:4c75:91fc:a21d?
 ([2600:8803:e7e4:500:5a03:4c75:91fc:a21d])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6611578c2d1sm352027eaf.0.2026.01.15.08.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 08:01:55 -0800 (PST)
Message-ID: <82b05fd6-183c-4c9f-846e-c6378260ad08@baylibre.com>
Date: Thu, 15 Jan 2026 10:01:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] clk: mediatek: mt8365: fix missing and out of order
 clocks
To: =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 =?UTF-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "lukma@denx.de" <lukma@denx.de>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 =?UTF-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 =?UTF-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?= <Chris-qj.Chen@mediatek.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com>
 <20251218-clk-mtk-mt8365-fixes-v1-2-4f8ff0de3268@baylibre.com>
 <78dcd04a17910a2c3ee7fe32809413dca2293c68.camel@mediatek.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <78dcd04a17910a2c3ee7fe32809413dca2293c68.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Jan 2026 18:01:19 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/15/26 1:05 AM, Macpaul Lin (林智斌) wrote:
> On Thu, 2025-12-18 at 17:23 -0600, David Lechner wrote:
>> Fix a few missing clocks and even more clocks in the incorrect order.
>> Since the clocks are looked up by index, having them out of order or
>> skipping an ID will lead to incorrect clocks being used.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/clk/mediatek/clk-mt8365.c | 32 +++++++++++++++++------------
>> ---
>>  1 file changed, 17 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-mt8365.c
>> b/drivers/clk/mediatek/clk-mt8365.c
>> index c88545fc7cf..b6332b14aea 100644
>> --- a/drivers/clk/mediatek/clk-mt8365.c
>> +++ b/drivers/clk/mediatek/clk-mt8365.c
>> @@ -80,7 +80,7 @@ static const struct mtk_fixed_clk top_fixed_clks[]
>> = {
>>         FACTOR(_id, _parent, _mult, _div, CLK_PARENT_APMIXED)
>>
>>  static const struct mtk_fixed_factor top_divs[] = {
>> -       PLL_FACTOR(CLK_TOP_SYS_26M_D2, "sys_26m_d2", CLK_XTAL, 1, 2),
>> +       PLL_FACTOR(CLK_TOP_MFGPLL, "mfgpll_ck", CLK_APMIXED_MFGPLL,
>> 1, 1),
>>         PLL_FACTOR(CLK_TOP_SYSPLL_D2, "syspll_d2",
>> CLK_APMIXED_MAINPLL, 1, 2),
>>         PLL_FACTOR(CLK_TOP_SYSPLL1_D2, "syspll1_d2",
>> CLK_APMIXED_MAINPLL, 1, 4),
>>         PLL_FACTOR(CLK_TOP_SYSPLL1_D4, "syspll1_d4",
>> CLK_APMIXED_MAINPLL, 1, 8),
>> @@ -110,7 +110,6 @@ static const struct mtk_fixed_factor top_divs[] =
>> {
>>         PLL_FACTOR(CLK_TOP_UNIVPLL3_D4, "univpll3_d4",
>> CLK_APMIXED_UNIVPLL, 1, 20),
>>         PLL_FACTOR(CLK_TOP_MMPLL, "mmpll_ck", CLK_APMIXED_MMPLL, 1,
>> 1),
>>         PLL_FACTOR(CLK_TOP_MMPLL_D2, "mmpll_d2", CLK_APMIXED_MMPLL,
>> 1, 2),
>> -       PLL_FACTOR(CLK_TOP_MFGPLL, "mfgpll_ck", CLK_APMIXED_MFGPLL,
>> 1, 1),
>>         PLL_FACTOR(CLK_TOP_LVDSPLL_D2, "lvdspll_d2",
>> CLK_APMIXED_LVDSPLL, 1, 2),
> 
> I'm not familiar with clock driver, however, I've compare this
> modification with kernel's clock order then found some differences.
> 
> For example,
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/mediatek/clk-mt8365.c#n34
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/mediatek/clk-mt8365.c#n64
> 
> The origin order of clock CLK_TOP_SYS_26M_D2, and CLK_TOP_MFGPLL are
> the same as kernel upstream. Are the behaviors of these clocks
> different from kernel upstream?

In the Linux kernel, each clock is registered separately and clocks are
looked up by name rather than array index. So in the Linux kernel, the
order does ntt matter. In U-Boot, only the parent device is registered and
individual clocks are looked up by array index so order does matter.

> 
> [snip]
> 
>>         PLL_FACTOR(CLK_TOP_LVDSPLL_D4, "lvdspll_d4",
>> CLK_APMIXED_LVDSPLL, 1, 4),
>>         PLL_FACTOR(CLK_TOP_LVDSPLL_D8, "lvdspll_d8",
>> CLK_APMIXED_LVDSPLL, 1, 8),
>> @@ -128,6 +127,7 @@ static const struct mtk_fixed_factor top_divs[] =
>> {
>>         PLL_FACTOR(CLK_TOP_APLL2_D2, "apll2_d2", CLK_APMIXED_APLL2,
>> 1, 2),
>>         PLL_FACTOR(CLK_TOP_APLL2_D4, "apll2_d4", CLK_APMIXED_APLL2,
>> 1, 4),
>>         PLL_FACTOR(CLK_TOP_APLL2_D8, "apll2_d8", CLK_APMIXED_APLL2,
>> 1, 8),
>> +       PLL_FACTOR(CLK_TOP_SYS_26M_D2, "sys_26m_d2", CLK_XTAL, 1, 2),
> 
> And so on for the other re-ordered clocks.
> 
> [snip]
> 
> 
> Could you help to explain how to verify it?

I verified the U-Boot driver by running the `clk dump` command. This will
print `error!` if any clocks are out of order (which would break array index
lookup) or if they are missing a parent clock.

Once I fixed all of the errors, then I checked that the parent printed for
each clock matched the documentation. There were a few mistakes, so I fixed
those as well (in a separate patch).

Now that we have the `clk dump` command for Mediatek clocks, I recommend doing
this on the other boards in U-Boot as well. I expect we will find more bugs
like this.

> Did you dump clock tree and compare the orders between u-boot and Linux
> kernel?

Since the order doesn't matter in Linux, I did not do this.

> Do we need to update kernel's clock driver for MT8365?

I don't think so. All of the bugs I found in U-Boot had to do with the
array lookup implementation which does not apply to Linux.

> 
> Thanks
> Macpaul Lin
> 

