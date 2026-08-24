Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7E3C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8755B80EE6;
	Mon, 24 Aug 2026 16:56:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aJx3oI7ftYZX; Mon, 24 Aug 2026 16:56:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787590590;
	bh=k9g/uJktxqzJJaukgo7Clp6tP1yTVoRbuSHSAAwYxLA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KAbyolDvfZtnu47GyeH4/zjEn9+MxHrUfNA8iAAJzobL787wogw5M3NBP77CZv6BY
	 HxD4h8ZchrCDHYL8o8PoA34stvkyGCyTsBTSjOYKxQUzZk5s2qQjV5k5YJsXadEI6F
	 xTYAgcdmZXtQJvYwE1g7r1+XgaAMG4fcL0xvdwS4bc01TnNlx466iTRiKb0NLHyaJt
	 4p3IHDASXkU8BQnYQASgdFk6YmbdV1/PGO1QgjmbWAZjQz0Xf5fJ7IZAsoyLicvyek
	 WeJX8bOXwg0wOh0RaZCOmEsW0JC8QGCmaQ2Io+RX8trTATKWyVzPLQzo/Jw9H1HJEM
	 QWQuOj6FtRVGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5143B80EE7;
	Mon, 24 Aug 2026 16:56:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E09441A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9BB6E6064C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:56:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Fa5WXTekz1X for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 16:56:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=d786=gs=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=EIE7HBTs
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1689A6062C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1787590586;
 bh=k9g/uJktxqzJJaukgo7Clp6tP1yTVoRbuSHSAAwYxLA=;
 b=EIE7HBTsdFFQb77O172XLTHwZouk3fqvWIx3ZdVxGpz4NAmLD++Xu4jXZ0NzXsGhgfOfEWFKL
 yl1/D49lPl4CnSOBomE3kLEjpjlg764qADKudUvUZ8lXhiFw0QzAL8eOBSRWGjoQAazifubpL39
 XwKckRcTXFl+3l1BRmF6y5E3Fpq9DZVHxnAjT+gcgbnvG5/wg1Jg8CkDQ/3nRLXrCgKJCRUbUyV
 wCBwejQV/2DgTNkW+7t30Lxhjl5ny3BnoC+yOg0WTkPIMIopk0Tv/s8FTORB0Vu3MWObBdfm9eM
 eLdN7atSLuRl0iS4+3razPEJNwaLf9+QX9mWytsFualg==
X-Forward-Email-ID: 6a8c77b84fffbb6ed1c8305d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1a6a8ea6-4999-464f-b515-b97ad61b8cdc@kwiboo.se>
Date: Mon, 24 Aug 2026 18:56:21 +0200
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
 <7cb02287-c541-40d2-8a2e-6ab018f44a91@kwiboo.se>
 <2be8dfb1-517a-4326-949c-6a62bc11060d@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <2be8dfb1-517a-4326-949c-6a62bc11060d@cherry.de>
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

Hi Quentin,

On 8/24/2026 4:54 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/14/26 10:16 AM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 8/12/2026 2:42 PM, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 8/3/26 9:09 PM, Jonas Karlman wrote:
>>>> Change to use writel() together with the FIELD_PREP_WM16() macro
>>>> instead of using the rk_clrsetreg() macro to avoid having to define the
>>>> mask as a parameter to both rk_clrsetreg() and FIELD_PREP(). Also change
>>>> to use u32 variables consistently.
>>>>
>>>> No change in behavior is expected due to this code style change.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>>    drivers/clk/rockchip/clk_rk3506.c | 195 ++++++++++++++----------------
>>>>    1 file changed, 90 insertions(+), 105 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
>>>> index e156bf19a6b4..7ccab313e6ec 100644
>>>> --- a/drivers/clk/rockchip/clk_rk3506.c
>>>> +++ b/drivers/clk/rockchip/clk_rk3506.c
>>
>> [snip]
>>
>>>> @@ -770,7 +759,7 @@ static ulong rk3506_fspi_get_rate(struct rk3506_clk_priv *priv)
>>>>    
>>>>    static ulong rk3506_fspi_set_rate(struct rk3506_clk_priv *priv, ulong rate)
>>>>    {
>>>> -	int div, sel;
>>>> +	u32 div, sel;
>>>>    
>>>>    	if (OSC_HZ % rate == 0) {
>>>>    		sel = SCLK_FSPI_SEL_24M;
>>>> @@ -787,10 +776,9 @@ static ulong rk3506_fspi_set_rate(struct rk3506_clk_priv *priv, ulong rate)
>>>>    	}
>>>>    	assert(div - 1 <= 31);
>>>>    
>>>
>>> If somehow div = 0, then this will result in an underflow. Because it's
>>> an unsigned type, it'll wrap around and start at U32_MAX so assert()
>>> should catch it. However, assert() is a noop when DEBUG constant isn't
>>> defined, so this actually does nothing.
>>>
>>> We should switch those assert to something that actually does something
>>> otherwise we could still very well attempt to write a divider that's too
>>> big and have weird behaviors instead of outright fail when we know we
>>> cannot do something that's requested.
>>
>> I was looking into trying to use assert(FIELD_FIT(...)) to validate, but
>> as you mention this does not help for non-DEBUG builds.
>>
>> However, I have been playing around with something like following,
>> still not sure I fully like it, please advise.
>>
>> static inline u32 get_divider(ulong prate, ulong rate, u32 mask, bool divisible)
>> {
>> 	u32 div;
>>
>> 	if (divisible && prate % rate)
>> 		return 0;
>>
> 
> What is "divisible" supposed to represent? I don't understand from 
> reading the code.

"A number is divisible by another number if it can be divided into equal
parts with no remainder."

Basic idea is to keep existing pattern, we first check if rate can be
divided exact without any reminder, and fallback to do best effort to
get closest rate. Divisible was a word that seemed to match this meaning.

> 
>> 	div = DIV_ROUND_UP(prate, rate);
>> 	if (!div || ((div - 1) << __ffs(mask)) & ~mask)
> 
> I scratch my head looking at this so not sure it would stand the test of 
> time. Would:
> 
> ((div - 1) & mask) == (div - 1)
> 
> work better instead? If your value masked (I'm assuming you want to use 
> the bitfield mask here, so all bits are set in the bitfield) doesn't 
> equal your value, then the mask cannot contain the value.

Correct, we want to ensure that div-1 fit inside the field, i.e. same as:

  if (!div || !FIELD_FIT(mask, div - 1))

However, FIELD_FIT only works with constants, so above was a quick and
dirty unpack of FIELD_FIT to test the idea. Hopefully there is a way to
instead make use of FIELD_FIT and not a custom re-implementation.

> 
>> 		return 0;
>>
>> 	return div;
>> }
>>
>> static ulong rk3506_saradc_set_rate(struct rk3506_clk_priv *priv, ulong clk_id,
>> 				    ulong rate)
>> {
>> 	u32 div, sel;
>>
>> 	if ((div = get_divider(32000, rate, CLK_SARADC_DIV_MASK, 1)))
>> 		sel = CLK_SARADC_SEL_32K;
>> 	else if ((div = get_divider(400000, rate, CLK_SARADC_DIV_MASK, 1)))
>> 		sel = CLK_SARADC_SEL_400K;
>> 	else if ((div = get_divider(OSC_HZ, rate, CLK_SARADC_DIV_MASK, 0)))
>> 		sel = CLK_SARADC_SEL_24M;
> 
> Can you really not divide from x24m as a parent?

As mentioned above, final param was just to signal if we need exact
match / no reminder.

> 
> Also, please do not assign a variable within an if condition, I find it 
> very difficult to remember that checking an if condition can have side 
> effects. I can suggest:
> 
> div = get_divider(32000, rate, CLK_SARADC_DIV_MASK, 1);
> if (div) {
>      sel = CLK_SARADC_SEL_32K;
>      goto div_found;
> }
> 
> div = get_divider(400000, rate, CLK_SARADC_DIV_MASK, 1);
> if (div) {
>      sel = CLK_SARADC_SEL_400K;
>      goto div_found;
> }
> [...]
> 
> return -EINVAL;
> 
> div_found:
> writel(FIELD_PREP_WM16(CLK_SARADC_SEL_MASK, sel) |
> [...]
> return rk3506_saradc_get_rate(priv, clk_id);
> 
> Or use another function for
> 
> the writel+return currently at the end of your function and call that 
> instead of a goto.

Yeah, I was considering goto and extra functions, but wanted to keep
the logic as small and simple as possible.

I have evolved my idea to take advantage of macros to help make the code
more readable:

	if (RATE_TO_DIV(div, 32000, rate, CLK_SARADC_DIV_MASK, 1))
		sel = CLK_SARADC_SEL_32K;
	else if (RATE_TO_DIV(div, 400000, rate, CLK_SARADC_DIV_MASK, 1))
		sel = CLK_SARADC_SEL_400K;
	else if (RATE_TO_DIV_OSC(div, rate, CLK_SARADC_DIV_MASK, 0))
		sel = CLK_SARADC_SEL_24M;
	else
		return -EINVAL;

or

	if (RATE_TO_DIV_PLL(div, PLL_V0PLL, rate, CLK_I2C0_DIV_MASK, 1))
		sel = CLK_I2C_SEL_V0PLL;
	else if (RATE_TO_DIV_PLL(div, PLL_V1PLL, rate, CLK_I2C0_DIV_MASK, 1))
		sel = CLK_I2C_SEL_V1PLL;
	else if (RATE_TO_DIV_PLL(div, PLL_GPLL, rate, CLK_I2C0_DIV_MASK, 0))
		sel = CLK_I2C_SEL_GPLL;
	else
		return -EINVAL;

It still assigns div (first parameter) inside the if, but with the
benefit that it keeps the code and code flow as simple as possible.

See rk3506 [1] or rk3538 [2] clock driver in my rk3562 branch for a full
working example of an entire clock driver using above pattern.

[1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/blob/rk3562/drivers/clk/rockchip/clk_rk3506.c#L500-519
[2] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/blob/rk3562/drivers/clk/rockchip/clk_rk3538.c

> 
>> 	else
>> 		return -EINVAL;
>>
>> 	writel(FIELD_PREP_WM16(CLK_SARADC_SEL_MASK, sel) |
>> 	       FIELD_PREP_WM16(CLK_SARADC_DIV_MASK, div - 1),
>> 	       RK3506_CLKSEL_CON(54));
>>
>> 	return rk3506_saradc_get_rate(priv, clk_id);
>> }
>>
>> Here we use a helper function, could possible also be re-made into a
>> macro so we actually can use FIELD_FIT() instead of bitwise ops.
>>
>> Basic idea is that we assign div and test if the rate is divisible and
>> fit inside mask at the same time, and if not we move on to next possible
>> parent/divider.
>>
>> With above and using the 1 MHz rate I would get something like following,
>> provided I also added some log_debug() calls.
>>
>>    => adc list
>>    invalid divider 24 for prate 24000000, rate 1000000, mask f
>>    unsupported clk: id=193 rate=1000000 ret=-22
>>    - adc@ff4e8000 status: -22
>>
>> In the future I would also like to drop some priv->pll_hz uses and
> 
> We should report what's the configured frequency for a PLL from the 
> registers. I don't know if we can reliably cache it though (hopefully 
> TF-A/OP-TEE doesn't change the ones we're interested in :) ). I don't 
> know how much we would spare in boot time by avoiding reading the 
> registers often and used a cache version instead.

In the clock drivers at [1] and [2] I have changed to fetch all PLL
rates via <soc>_pll_get_rate(), the calls is mostly hidden behind new
macros to keep code cleaner and easier to follow, e.g.:

	con = readl(RK3506_CLKSEL_CON(49));
	sel = FIELD_GET(CCLK_SDMMC_SEL_MASK, con);
	div = FIELD_GET(CCLK_SDMMC_DIV_MASK, con);

	if (sel == CCLK_SDMMC_SEL_24M)
		return DIV_TO_RATE_OSC(div);
	else if (sel == CCLK_SDMMC_SEL_GPLL)
		return DIV_TO_RATE_PLL(PLL_GPLL, div);
	else if (sel == CCLK_SDMMC_SEL_V0PLL)
		return DIV_TO_RATE_PLL(PLL_V0PLL, div);
	else if (sel == CCLK_SDMMC_SEL_V1PLL)
		return DIV_TO_RATE_PLL(PLL_V1PLL, div);
	else
		return -EINVAL;

With something like this we no longer need to pre-cache PLL rates at
probe time, instead PLL rates will be fetched when needed.

The rk3562 branch contains wip commit diffs that step by step transition
current rk3506 clock driver to use above proposed patterns.

Please take a look at the full rk3506 driver to see what you think :-)

Regards,
Jonas

> 
> Cheers,
> Quentin

