Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425E6CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 08:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE05584836;
	Mon, 11 May 2026 10:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Vt/GcnUX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E084684837; Mon, 11 May 2026 10:30:40 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6619884706
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 10:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cde5=DI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1778488235;
 bh=PmINEgrP4ljJ72w7Jag9wjkSyGUWqZmFXAoSIFtHVLw=;
 b=Vt/GcnUXvq0y9iKRFXuvFTtPYtIJvogajAh5IXiLRV6aQhTuiaN/0nvTwG1UB4ouadf7mhHV1
 +JNdzAD0nZ26u89ar8d1ViydqWeRx0w8J+QijP8w3ml+gdwbp1g4H12H3qTF4fgXj+2uF+RJrhb
 hFs2mhqSwobx28CHRQDlo7Np4RqyZl/9U1DWt7nu+wd+G8N3wLCkGgWTcUWCIWYRnq9OybVpDvl
 F3KqF2JH81BY0BmEs0XYFqs72xuqALwVLQHlvCi/ld+oqCbtoApWIm0DhvJ1e3o4Ev2oXNj4P58
 GtEHskgVwEOgDmJ0AITXQnsxOGFQUdUCz1OZLxQvN3Lw==
X-Forward-Email-ID: 6a01939cc267fa079be75585
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c60ea578-30e9-49c2-8d45-0731b9fd74b0@kwiboo.se>
Date: Mon, 11 May 2026 10:30:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: regulator: Fix power on/off delay issue
To: Ye Li <ye.li@nxp.com>, ye.li@oss.nxp.com
Cc: jh80.chung@samsung.com, peng.fan@nxp.com, festevam@gmail.com,
 uboot-imx@nxp.com, u-boot@lists.denx.de
References: <20260511074953.3777767-1-ye.li@nxp.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260511074953.3777767-1-ye.li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

On 5/11/2026 9:49 AM, Ye Li wrote:
> SD initialization failure happens with some UHS-I SD cards on
> iMX8MM/iMX93/iMX91 EVK after
> commit 4fcba5d556b4 ("regulator: implement basic reference counter").
> When sending operation condition to SD card, the OCR does not return
> correct status. The root cause is regulator on/off delay is missed
> in MMC power cycle with above commit, so SD card is not completely
> power off.
> 
> When SD startup, the sequence of MMC power cycle is:
> mmc_power_init(get vmmc_supply dev) -> mmc_power_off -> udelay(2000)
> -> mmc_power_on
> 
> Before above commit, as a fixed regulator, the GPIO is set as:
>   GPIO inactive (in mmc_power_init) ->
>   GPIO inactive and delay off-on-delay-us (in mmc_power_off) ->
>   udelay(2000) ->
>   GPIO active (in mmc_power_on)
> 
> After the commit:
>   GPIO inactive (in mmc_power_init) ->
>   enable_count is 0, regulator_set_enable returns -EALREADY immediately,
>       so GPIO is inactive but No off-on-delay-us (in mmc_power_off) ->
>   udelay(2000) ->
>   GPIO active (in mmc_power_on)
> 
> Add the on/off delay and startup delay after GPIO request in
> regulator_common_of_to_plat which is called in regulator device probing.
> So in mmc_power_init, after GPIO is set to default inactive, the
> off-on-delay-us is applied.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> ---
>  drivers/power/regulator/regulator_common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
> index 85af8d599ad..158284a3309 100644
> --- a/drivers/power/regulator/regulator_common.c
> +++ b/drivers/power/regulator/regulator_common.c
> @@ -46,6 +46,12 @@ int regulator_common_of_to_plat(struct udevice *dev,
>  			dev_read_u32_default(dev, "u-boot,off-on-delay-us", 0);
>  	}
>  
> +	if ((flags & GPIOD_IS_OUT_ACTIVE) && plat->startup_delay_us)
> +		udelay(plat->startup_delay_us);
> +
> +	if (!(flags & GPIOD_IS_OUT_ACTIVE) && plat->off_on_delay_us)
> +		udelay(plat->off_on_delay_us);

regulator_common_of_to_plat() is for parsing the values, no udelay()
should be applied here.

regulator_common_set_enable() applies udelay() when the regulator is
enabled.

Does your regulator .get_enable() ops not being called or does it not
implement its own udelay() based on parsed values?

Regards,
Jonas

> +
>  	return 0;
>  }
>  

