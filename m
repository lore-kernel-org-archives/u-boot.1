Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A455CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 14:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C427483DAE;
	Fri,  7 Nov 2025 15:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="J7yiW3Eh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E295D83DB6; Fri,  7 Nov 2025 15:25:39 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DB5183D90
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 15:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bd30=5Q=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1762525536;
 bh=GtvdHmgpUGMt7wz1UhdI3uVbV4Dw4iPttH5ljh0ypcA=;
 b=J7yiW3EhqCp8iQ+KUu9cqeVEXpT/3fUbtHmvpirOVtDihEDygnFntJkQ5EvK50S9zn5bHNHV3
 o6VeRLe3efawZRojexbwIvHU9drCTQzea56vhIMD5QbH53a6c8GzuPhU/YFCfd4qabJPS7aoGXT
 bzuhaqZwJxn2vpe5gTFhkkwR7Smligqf+msMbtzUmQZmnmVCri1VpGzlCmoljyUscoUAIaSj2U+
 GAOR7FJVBwHjiw86mzTJRB9Prl+/a0iQGyipKkwV29ZldRIV0jUJ+majdjZv0eZxOmlwRQbAI/P
 GN448JSqosWVETsExH3hr+NB2sSVEixNDut+GhAkSSTA==
X-Forward-Email-ID: 690e015607551ffa40a0e002
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.4.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3ea35154-4cc0-48f3-be7e-cb25f6447864@kwiboo.se>
Date: Fri, 7 Nov 2025 15:25:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "power: regulator: Add vin-supply for GPIO and
 Fixed regulators"
To: Ye Li <ye.li@oss.nxp.com>, Peng Fan <peng.fan@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Dang Huynh <danct12@riseup.net>,
 u-boot@lists.denx.de
References: <20251101203429.1603832-1-jonas@kwiboo.se>
 <20251103085135.GB1698@nxa18884-linux.ap.freescale.net>
 <9039b700-16cf-44c9-8e32-dfdbe73f29b8@kwiboo.se>
 <4beb982e-c07a-499f-848b-e88b8effea24@oss.nxp.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <4beb982e-c07a-499f-848b-e88b8effea24@oss.nxp.com>
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

Hi Ye Li,

On 11/7/2025 8:31 AM, Ye Li wrote:
> Hi Jonas,
> 
> On 11/3/2025 6:36 PM, Jonas Karlman wrote:
>> Hi Peng,
>>
>> On 11/3/2025 9:51 AM, Peng Fan wrote:
>>> On Sat, Nov 01, 2025 at 08:34:26PM +0000, Jonas Karlman wrote:
>>>> Rockchip boards may depend on a working MMC regulator in SPL to
>>>> successfully load FIT payload from MMC. Typically, these boards only
>>>> include the vmmc-supply regulator and not its vin-supply in SPL control
>>>> FDT.
>>>>
>>>> The commit f98d812e5353 ("power: regulator: Add vin-supply for GPIO and
>>>> Fixed regulators") breaks loading FIT from MMC in SPL on some of these
>>>> boards due to now requiring the vin-supply to be included in the SPL
>>>> control FDT.
>>>>
>>>> The commit also strangely enables any found vin-supply in
>>>> regulator_common_of_to_plat() and not when a regulator is enabled or as
>>>> part of regulator_autoset().
>>>>
>>>> Revert the commit to fix FIT loading in SPL on broken boards.
>>>>
>>>> If a board needs to have its vin-supply enabled, two options come to
>>>> mind:
>>>>
>>>> - Add regulator-always-on prop to the regulator in the -u-boot.dtsi for
>>>>   any board.
>>>>
>>>> - Implement full support for reference counting of regulators and then
>>>>   update the regulator-uclass to enable any found vin-supply when a
>>>>   regulator is enabled.
>>>>
>>>> This reverts commit f98d812e5353408ef77a46bad1f1cdc793ff8a03.
>>>>
>>>> Reported-by: Dang Huynh <danct12@riseup.net>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>> drivers/power/regulator/regulator_common.c | 10 ----------
>>>> drivers/power/regulator/regulator_common.h |  1 -
>>>> 2 files changed, 11 deletions(-)
>>>>
>>>> diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
>>>> index 3ed713ce5019..685d8735fa5c 100644
>>>> --- a/drivers/power/regulator/regulator_common.c
>>>> +++ b/drivers/power/regulator/regulator_common.c
>>>> @@ -44,16 +44,6 @@ int regulator_common_of_to_plat(struct udevice *dev,
>>>> 			dev_read_u32_default(dev, "u-boot,off-on-delay-us", 0);
>>>> 	}
>>>>
>>>> -	ret = device_get_supply_regulator(dev, "vin-supply", &plat->vin_supply);
>>>> -	if (ret) {
>>>> -		debug("Regulator vin regulator not defined: %d\n", ret);
>>>> -		if (ret != -ENOENT)
>>>
>>> I understand it might be not proper to enable vin-supply in
>>> function regulator_common_of_to_plat().
>>> But I have a question, there is -ENOENT check in the original patch. If the
>>> board does not have vin-supply, there should be no issue. Or I miss something?
>>
>> As mentioned in the commit message the SPL control FDT does not contain
>> the regulator references as a vin-supply, this result in -ENODEV to be
>> returned. I.e. following where the vcc_io is not included in SPL control
>> FDT.
>>
>>    vcc_io: regulator@ {
>>    }
>>    vcc_sd: regulator@ {
>>    	bootph-pre-ram;
>>    	vin-supply = <&vcc_io>;
>>    }
>>    sdmmc: mmc@ {
>>    	bootph-pre-ram;
>>    	vmmc-supply = <&vcc_sd>;
>>    }
>>
>> With the change introduced in this commit the core gpio/fixed regulator
>> behavior changed and this now result in unbootable boards.
>>
>> Other reasons why I prefer a full revert instead of a workaround:
>> - The implementation changed core gpio/fixed regulator function without
>>    any review-by or acked-by.
>> - The patch was quickly merged after only being on the list for 1 week,
>>    the imx pull-request that included this did not even mention regulator
>>    changes.
>> - The implementation is not optimal, looking up vin-supply could be okay
>>    but not failing because it is missing, and enabling it during probe
>>    when we already have working enable count and regulator autoset to
>>    handle any needed auto-enable.
>> - The commit message does not give any insights on why this is needed.
>>
>> My suggestion is that this is reverted and if needed it should can be
>> submitted as a separated patch/series with a proper implementation.
>>
>> Regards,
>> Jonas
> 
> Shouldn't the reason be the broken SPL FDT? When one node is used in SPL 
> FDT, the nodes referred by its properties should also add 
> bootph-pre-ram. In your case, it is obviously missed for vcc_io. You 
> can't assume driver never use this property.

Please note that my example above was not from a real board only for
illustration purposes.

The vin-supply used for Rockchip devices on affected boards are
typically only fixed-regulator that are always-on and cannot be
controlled, e.g. dc-in or some always-on step-down converter.
These are included in the DT for more accurate description of HW.

For those boards, including vin-supply regulators in the SPL control FDT
serve no purpose beside wasting space and boot time for udevice binding
and probing, because of this they been left out on purpose since U-Boot
did not require or cared about a vin-supply prior to this patch.

If and how a vin-supply should be flagged with bootph-pre-ram or if the
vin-supply prop is scrubbed from SPL control FDT is not related to the
revert of this commit, it was just the main issue that help discover a
change in behavior that deserve discussion on ML before being merged.

> 
> If a new change for vin-supply is submitted in future, how can it avoid 
> ubootable with these broken FDT?  It is appropriate for current 
> implementation to get the vin_supply in probe and only check ENOENT. The 
> ENODEV means a explicit problem that can't be ignored.

Personally I do not think there is a need to fail at probe time because
a regulator-uclass udevice for a referenced vin-supply cannot be
resolved. A debug message could be printed if that is the case, however
require a working driver for the vin-supply is a change in behavior that
should really be documented in the commit message of a patch.

> The contentious 
> point is if the vin-supply enablement should move to set enable. I agree 
> with this proposal, but it is not related with the boot failure.

Agreed, the main issue with the original patch what that it changed
probe behavior and also force-enabled any regulator that happened to 
be referenced as a vin-supply regardless if such regulator is even
probed or enabled.

This revert has now landed in master, please send a new series if you
have need for proper vin-supply handling by fixed/gpio-regulators.

Regards,
Jonas

> 
> Best regard,
> Ye Li>
>>>
>>> Thanks,
>>> Peng
>>>
>>>> -			return ret;
>>>> -	}
>>>> -
>>>> -	if (plat->vin_supply)
>>>> -		regulator_set_enable_if_allowed(plat->vin_supply, true);
>>>> -
>>>> 	return 0;
>>>> }
>>>>
>>>> diff --git a/drivers/power/regulator/regulator_common.h b/drivers/power/regulator/regulator_common.h
>>>> index 799c968d0b66..d4962899d830 100644
>>>> --- a/drivers/power/regulator/regulator_common.h
>>>> +++ b/drivers/power/regulator/regulator_common.h
>>>> @@ -14,7 +14,6 @@ struct regulator_common_plat {
>>>> 	unsigned int startup_delay_us;
>>>> 	unsigned int off_on_delay_us;
>>>> 	unsigned int enable_count;
>>>> -	struct udevice *vin_supply;
>>>> };
>>>>
>>>> int regulator_common_of_to_plat(struct udevice *dev,
>>>> -- 
>>>> 2.51.0
>>>>
>>
> 

