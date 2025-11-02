Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DF5CCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 02:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A108307F;
	Sun,  2 Nov 2025 03:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="gcl1Cwuu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E61A8830A0; Sun,  2 Nov 2025 03:00:31 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6214382A9E
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 03:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bfc8=5K=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1762048822;
 bh=H0oWLWRBFdzTIV52o3qsF0/J2S2lSc4yGkQH+pvfDFM=;
 b=gcl1CwuuZHKaIlWdkAfamVIRUpx8dfFYYWyjb/hFN0m1Jhk7d9HJACrAHwUMU3UCFcc14DfJr
 GfODig2R6x8VzJ7FNs87/NYycxuQTI0AbZvThQKSm7IhWR/Q5SZeScYNtm/ozBEE2/0bJF4n6WL
 TD3+yhkT93fdas5j9kZrQpqUYJEZ5d/tGEbLThvSDV+Laz1LEfM3/83+zB06oy4h3eOexK7LsLs
 eUjk32keedO7FfB4xHubA/+cw23+cl4jXDhKChCE4nZQvpH4V/h4hZt8CsZEYNQYMn/sHoIcDGu
 3abvbF7w8SRUXImECmUxRpsRdgQakXsE/jbFHHyIKvCw==
X-Forward-Email-ID: 6906bb3125b744ade9932474
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.4.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3df8e40c-ecdf-4134-aee4-b59deb17de89@kwiboo.se>
Date: Sun, 2 Nov 2025 03:00:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "power: regulator: Add vin-supply for GPIO and
 Fixed regulators"
To: Mark Kettenis <mark.kettenis@xs4all.nl>, Dragan Simic <dsimic@manjaro.org>
Cc: trini@konsulko.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 ye.li@nxp.com, festevam@gmail.com, danct12@riseup.net, u-boot@lists.denx.de
References: <20251101203429.1603832-1-jonas@kwiboo.se>
 <878qgpqwpi.fsf@bloch.sibelius.xs4all.nl>
 <cec3cc0b-0326-4b0b-6832-f5db556c4cf2@manjaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <cec3cc0b-0326-4b0b-6832-f5db556c4cf2@manjaro.org>
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

Hi Mark and Dragan,

On 11/1/2025 10:23 PM, Dragan Simic wrote:
> Hello Mark,
> 
> On Saturday, November 01, 2025 22:17 CET, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>>> From: Jonas Karlman <jonas@kwiboo.se>
>>>
>>> Rockchip boards may depend on a working MMC regulator in SPL to
>>> successfully load FIT payload from MMC. Typically, these boards only
>>> include the vmmc-supply regulator and not its vin-supply in SPL control
>>> FDT.
>>>
>>> The commit f98d812e5353 ("power: regulator: Add vin-supply for GPIO and
>>> Fixed regulators") breaks loading FIT from MMC in SPL on some of these
>>> boards due to now requiring the vin-supply to be included in the SPL
>>> control FDT.
>>
>> I ran into this issue a few days ago.  Unfortunately that means U-Boot
>> 2025.10 is broken on several Rockchip boards :(.
> 
> Sadly, that's true. :(

I do not think the commit was part of 2025.10, it was merged to next and
should currently only be part of master and 2026.01-rc1.

If you experience a similar boot issue on 2025.10 then that will most
likely be a different issue.

Regards,
Jonas

> 
>>> The commit also strangely enables any found vin-supply in
>>> regulator_common_of_to_plat() and not when a regulator is enabled or as
>>> part of regulator_autoset().
>>>
>>> Revert the commit to fix FIT loading in SPL on broken boards.
>>>
>>> If a board needs to have its vin-supply enabled, two options come to
>>> mind:
>>>
>>> - Add regulator-always-on prop to the regulator in the -u-boot.dtsi for
>>>   any board.
>>>
>>> - Implement full support for reference counting of regulators and then
>>>   update the regulator-uclass to enable any found vin-supply when a
>>>   regulator is enabled.
>>
>> I fixed the issue with the diff below instead.  But I don't claim to
>> fully understand how this all is supposed to work...
> 
> Unfortunately, that's just a quick workaround, not a proper fix.
> Basically, the regulator_common_of_to_plat() function is a wrong
> place for such enabling of additional regulators.
> 
>> diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
>> index c80f10c3aa3..f43879a4353 100644
>> --- a/drivers/power/regulator/regulator_common.c
>> +++ b/drivers/power/regulator/regulator_common.c
>> @@ -48,7 +48,7 @@ int regulator_common_of_to_plat(struct udevice *dev,
>>  	ret = device_get_supply_regulator(dev, "vin-supply", &plat->vin_supply);
>>  	if (ret) {
>>  		debug("Regulator vin regulator not defined: %d\n", ret);
>> -		if (ret != -ENOENT)
>> +		if (ret != -ENOENT && ret != -ENODEV)
>>  			return ret;
>>  	}
> 

