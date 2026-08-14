Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEA1C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 08:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 441FA80F64;
	Fri, 14 Aug 2026 08:16:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cWYouRnxlNry; Fri, 14 Aug 2026 08:16:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7BEE180F5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786695406;
	bh=W8xkYfaamBco3K5LW4eMkKt0C9zEU5qIeGdn1B4DuME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BHcBCLm9Yn3661NPsdCodhYz59KoKlCBcjr8Pxcc1772EyWjMdOm1rXclyYFKYDNf
	 rxBpCUcXmOi0Vnzh590lzPfwQHaDGFeCpsqfcOHglxt7WYDKLHm8SGPjQwYcWlGR14
	 fS4uGQpcB/wmcMo1vonZVFBibei9amzmkrQGkC0WfQQS+5XV772igK1u2Gi4skGBtL
	 1/oknyodnqXFS8ZKOrtaJDsVv2+DCzsBGKVKsOFm01XiPIgef/ukW05FhfcHq8qf6f
	 KA65evXHAlolykaG1H1pyvHZphWSXa41KJng42PdiNv0wnMaZJuKxpKPLFug8k5sGt
	 RLuQqGxKZYGFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BEE180F5F;
	Fri, 14 Aug 2026 08:16:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C096A139C
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B288340792
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:16:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rh3qNnKyszcz for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 08:16:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=7d93=gh=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CDE7740794
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CDE7740794
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=nx+RH5+1
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDE7740794
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1786695402;
 bh=W8xkYfaamBco3K5LW4eMkKt0C9zEU5qIeGdn1B4DuME=;
 b=nx+RH5+1Am452/Sg5Tx6TTo+5AQLS0de7J7cXlx8UNTzR0OLQHzgjJGZxTofiwoVyjek9TdjS
 jGjF2G45K8KtqRFlsz3sJxlvn6AjGA9AYGxzL8YTJgHh35OfCU915tZc8PaZcE3Dwy28uvp3hWB
 WvpLsgAR6FlGUYV9tGBZxV7ae44MyKuXK9hDOjXailhqKgyk8MPOqMmp1WY1YCcEebDH0jRoF6m
 PlcgpJDBzbK3C3RLlzuP/q2RuaF7E5pbKq9NAWjFEAzD9XRtGJ0H3l5RBhEnhsFJCE93VkzbKOU
 QqNvhy8O4e763G/XbvOIdkna+G5rpQ+lcHRHjWl6wbHw==
X-Forward-Email-ID: 6a7ecee8a46e8d892ce86e01
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <7cb02287-c541-40d2-8a2e-6ab018f44a91@kwiboo.se>
Date: Fri, 14 Aug 2026 10:16:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] clk: rockchip: rk3506: Use FIELD_PREP_WM16 macro
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-6-jonas@kwiboo.se>
 <fd9af4e6-17f3-4b3e-99c0-b6bb5a1ca79e@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <fd9af4e6-17f3-4b3e-99c0-b6bb5a1ca79e@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 8/12/2026 2:42 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/3/26 9:09 PM, Jonas Karlman wrote:
>> Change to use writel() together with the FIELD_PREP_WM16() macro
>> instead of using the rk_clrsetreg() macro to avoid having to define the
>> mask as a parameter to both rk_clrsetreg() and FIELD_PREP(). Also change
>> to use u32 variables consistently.
>>
>> No change in behavior is expected due to this code style change.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   drivers/clk/rockchip/clk_rk3506.c | 195 ++++++++++++++----------------
>>   1 file changed, 90 insertions(+), 105 deletions(-)
>>
>> diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
>> index e156bf19a6b4..7ccab313e6ec 100644
>> --- a/drivers/clk/rockchip/clk_rk3506.c
>> +++ b/drivers/clk/rockchip/clk_rk3506.c

[snip]

>> @@ -770,7 +759,7 @@ static ulong rk3506_fspi_get_rate(struct rk3506_clk_priv *priv)
>>   
>>   static ulong rk3506_fspi_set_rate(struct rk3506_clk_priv *priv, ulong rate)
>>   {
>> -	int div, sel;
>> +	u32 div, sel;
>>   
>>   	if (OSC_HZ % rate == 0) {
>>   		sel = SCLK_FSPI_SEL_24M;
>> @@ -787,10 +776,9 @@ static ulong rk3506_fspi_set_rate(struct rk3506_clk_priv *priv, ulong rate)
>>   	}
>>   	assert(div - 1 <= 31);
>>   
> 
> If somehow div = 0, then this will result in an underflow. Because it's 
> an unsigned type, it'll wrap around and start at U32_MAX so assert() 
> should catch it. However, assert() is a noop when DEBUG constant isn't 
> defined, so this actually does nothing.
> 
> We should switch those assert to something that actually does something 
> otherwise we could still very well attempt to write a divider that's too 
> big and have weird behaviors instead of outright fail when we know we 
> cannot do something that's requested.

I was looking into trying to use assert(FIELD_FIT(...)) to validate, but
as you mention this does not help for non-DEBUG builds.

However, I have been playing around with something like following,
still not sure I fully like it, please advise.

static inline u32 get_divider(ulong prate, ulong rate, u32 mask, bool divisible)
{
	u32 div;

	if (divisible && prate % rate)
		return 0;

	div = DIV_ROUND_UP(prate, rate);
	if (!div || ((div - 1) << __ffs(mask)) & ~mask)
		return 0;

	return div;
}

static ulong rk3506_saradc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
				    ulong rate)
{
	u32 div, sel;

	if ((div = get_divider(32000, rate, CLK_SARADC_DIV_MASK, 1)))
		sel = CLK_SARADC_SEL_32K;
	else if ((div = get_divider(400000, rate, CLK_SARADC_DIV_MASK, 1)))
		sel = CLK_SARADC_SEL_400K;
	else if ((div = get_divider(OSC_HZ, rate, CLK_SARADC_DIV_MASK, 0)))
		sel = CLK_SARADC_SEL_24M;
	else
		return -EINVAL;

	writel(FIELD_PREP_WM16(CLK_SARADC_SEL_MASK, sel) |
	       FIELD_PREP_WM16(CLK_SARADC_DIV_MASK, div - 1),
	       RK3506_CLKSEL_CON(54));

	return rk3506_saradc_get_rate(priv, clk_id);
}

Here we use a helper function, could possible also be re-made into a
macro so we actually can use FIELD_FIT() instead of bitwise ops.

Basic idea is that we assign div and test if the rate is divisible and
fit inside mask at the same time, and if not we move on to next possible
parent/divider.

With above and using the 1 MHz rate I would get something like following,
provided I also added some log_debug() calls.

  => adc list
  invalid divider 24 for prate 24000000, rate 1000000, mask f
  unsupported clk: id=193 rate=1000000 ret=-22
  - adc@ff4e8000 status: -22

In the future I would also like to drop some priv->pll_hz uses and
instead get that from a function, so would look something like:

	if ((div = get_divisor(rk3506_pll_get_rate(priv, PLL_V1PLL),
			       rate, CCLK_SDMMC_DIV_MASK, 1)))
		sel = CCLK_SDMMC_SEL_V1PLL;

Please let me know what you think of using something similar to above.

Regards,
Jonas

> 
> This here doesn't change the logic anyway so this can be done in a 
> follow-up patch, thus:
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

