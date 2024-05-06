Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EE4C10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 15:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9F2C8865B;
	Mon,  6 May 2024 17:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LkPo+8Kb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC7528867D; Mon,  6 May 2024 17:17:48 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 688F788657
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 17:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c61d=MK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1715008646;
 bh=SmM8CCmM36h7XnZ/76zeAlED6Eua2lcbfVvy9mc1J8o=;
 b=LkPo+8KbYZptg4mUPKzVn+hM3QVW2LGLhT/bJi2kA3yvH3suW1W7wa72iNy7r9l8wdM66dA3I
 z0c1mg9YHGAZH3CpXG5++CRJrpplYtgYLg7EEkXYTnKlqIvIc6aGWg98wA428BZjw6LJB9Jg8sZ
 DpJVWUjbJQB00lu+i27XaAhOjHI/a3aVSEgaIM1YS9eL3Hnhimv4JBheti78l0tKGgUSTAETFsc
 KktFl2ZvG6/N3fLnbi/rLwjw3VEGpkBj4dkIOmD6FB3SnB9KNU0pGy0SDfiMhnLPCx7viC1rGlW
 1A3srbfnL74c4n8TmfedYuaYBIWKJ/EH62yLhBkSpkEw==
Message-ID: <baacfde3-e0ee-4bd7-a85e-5945ec2a85e8@kwiboo.se>
Date: Mon, 6 May 2024 17:17:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/22] clk: rockchip: rk3399: Improve support for
 SCLK_PCIEPHY_REF clock
To: Quentin Schulz <quentin.schulz@cherry.de>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Dragan
 Simic <dsimic@manjaro.org>, Christopher Obbard
 <chris.obbard@collabora.com>, Peter Robinson <pbrobinson@gmail.com>,
 u-boot@lists.denx.de
References: <20240501162308.875193-1-jonas@kwiboo.se>
 <20240501162308.875193-4-jonas@kwiboo.se>
 <b0152407-ee06-4c5b-ae5c-210a474ad598@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <b0152407-ee06-4c5b-ae5c-210a474ad598@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6638f4811ab72626380504c9
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

Hi Quentin,

On 2024-05-06 13:07, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 5/1/24 6:22 PM, Jonas Karlman wrote:
>> rk3399-nanopi-4.dtsi try to set parent of and set rate to 100 MHz of the
>> SCLK_PCIEPHY_REF clock.
>>
>> The existing enable/disable ops for SCLK_PCIEPHY_REF currently force
>> use of 24 MHz parent and rate.
>>
>> Add improved support for setting parent and rate of the pciephy refclk
>> to driver to better support assign-clock props for pciephy refclk in DT.
>>
>> This limited implementation only support setting 24 or 100 MHz rate,
>> and expect npll and clk_pciephy_ref100m divider to use default values.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2: Implement partial instead of dummy support for SCLK_PCIEPHY_REF
>> ---
>>   drivers/clk/rockchip/clk_rk3399.c | 59 +++++++++++++++++++++++++++++--
>>   1 file changed, 57 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
>> index 5934771b4096..0b3223611a32 100644
>> --- a/drivers/clk/rockchip/clk_rk3399.c
>> +++ b/drivers/clk/rockchip/clk_rk3399.c
>> @@ -926,6 +926,26 @@ static ulong rk3399_saradc_set_clk(struct rockchip_cru *cru, uint hz)
>>   	return rk3399_saradc_get_clk(cru);
>>   }
>>   
>> +static ulong rk3399_pciephy_get_clk(struct rockchip_cru *cru)
>> +{
>> +	if (readl(&cru->clksel_con[18]) & BIT(10))
>> +		return 100 * MHz;
>> +	else
>> +		return OSC_HZ;
> 
> Could avoid the else since all if blocks return, no other logic than the 
> one matching the else can reach that part of the code.
> 
> Therefore:
> 
> """
> if (readl(&cru->clksel_con[18]) & BIT(10))
>      return 100 * MHz;
> 
> return OSC_HZ;
> """
> 
> works just as well.

I was considering above format at first, but chose to align return
statements for some reason.

I can change to this format in a v3, if needed :-)

> 
> Could also be
> 
> """
> return (readl(&cru->clksel_con[18]) & BIT(10)) ? 100 * MHz : OSC_HZ;
> """
> 
> [...]
>> +static int __maybe_unused rk3399_pciephy_set_parent(struct clk *clk,
>> +						    struct clk *parent)
>> +{
>> +	struct rk3399_clk_priv *priv = dev_get_priv(clk->dev);
>> +	const char *clock_output_name;
>> +	int ret;
>> +
>> +	if (parent->dev == clk->dev && parent->id == SCLK_PCIEPHY_REF100M) {
>> +		rk_setreg(&priv->cru->clksel_con[18], BIT(10));
>> +		return 0;
>> +	}
>> +
>> +	ret = dev_read_string_index(parent->dev, "clock-output-names",
>> +				    parent->id, &clock_output_name);
> 
> Are you sure this works?

It should work for the clk reference I tested, <&xin24m>, where the id
will be 0, it should also work for e.g. <&rk809 1>, id will be 1.

And if a &cru/&pmucru clk is referenced those nodes do not have the
clock-output-names prop, so ret should be -EINVAL (or -ENODATA).

> 
> Considering that parent->id seems to store unique ids, like 167 for 
> SCLK_PCIEPHY_REF100M, I doubt we should be using it for 
> dev_read_string_index????
> 
> As per documentation:
> 
> """
> /**
>   * dev_read_string_index() - obtain an indexed string from a string list
>   *
>   * @dev: device to examine
>   * @propname: name of the property containing the string list
>   * @index: index of the string to return
>   * @outp: return location for the string
>   *
>   * Return:
>   *   length of string, if found or -ve error value if not found
>   */
> int dev_read_string_index(const struct udevice *dev, const char *propname,
> 			  int index, const char **outp);
> """
> 
> So index here means the (index+1)'th string in the list of strings under 
> the "propname" DT property, I doubt we have properties with 167+ strings 
> in them?

I would expect the function to return -EINVAL or -ENODATA if it is called
with an out-of-bounds index value.

> 
> I realize that rk3399_gmac_set_parent also uses this, so I'm a bit 
> puzzled right now...
> 
> Don't you want to use
> 
> dev_read_stringlist_search(parent->dev, "clock-output-names", "xin24m")
> 
> instead?

I think the implementation is correct and is what other rk clk drivers
do for gmac set parent ops.

Using dev_read_stringlist_search() could possible match a name for
"wrong" clock, e.g:

clk_ref: clock {
	#clock-cells = <1>;
	clock-output-names = "xin32k", "xin24m";
};

here only <&clk_ref 1> should match and not <&clk_ref 0>.

Regards,
Jonas

> 
> The rest looks good to me.
> 
> Cheers,
> Quentin

