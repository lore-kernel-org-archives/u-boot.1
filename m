Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180C7FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 13:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86D2B83BC4;
	Mon, 27 Apr 2026 15:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="DOptDG6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A570A83FDB; Mon, 27 Apr 2026 15:15:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7E49583AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 15:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4731C1684;
 Mon, 27 Apr 2026 06:15:37 -0700 (PDT)
Received: from [10.41.150.145] (e142021.arm.com [10.41.150.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8109F3F763;
 Mon, 27 Apr 2026 06:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777295742; bh=ud+VoXW7exiWVQdTnFOTOfW8Q/YftQpXGEvSuj8f2ro=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DOptDG6alAAIb+kAi7HQD3EtRs91tb2oyt2zCTwdvaoh47jm5+V6IoPrTT7/CKVWP
 BrrkjjROXDRaMieV8+QByKEGbrqWTLt7n41EBR2CoOE9GUPam2ZtKT6+eROch+qJU7
 bP7CPv7VNCqHnIL8kxn5wwKprmXM4k4UhRshnqu4=
Message-ID: <0f12a51e-db97-4d2d-81a6-723e49c1304d@arm.com>
Date: Mon, 27 Apr 2026 15:15:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sunxi: H616: dram: fix LPDDR3 TRP6 parsing
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: Mikhail Kalashnikov <iuncuim@gmail.com>,
 Philippe Simons <simons.philippe@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>, Samuel Holland
 <samuel@sholland.org>, u-boot@lists.denx.de
References: <20260407164717.7356-1-simons.philippe@gmail.com>
 <f78d23da-0e61-4a06-ae48-22cadd7ac24d@gmail.com> <adfBW5aKiDm6TRzZ@shepard>
 <20260409233304.2eeaa3fc@ryzen.lan> <adkdQlPDTruj3OcI@shepard>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <adkdQlPDTruj3OcI@shepard>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Paul,

On 4/10/26 17:54, Paul Kocialkowski wrote:
> Hi Andre,
> 
> On Thu 09 Apr 26, 23:34, Andre Przywara wrote:
>> On Thu, 9 Apr 2026 17:10:19 +0200
>> Paul Kocialkowski <contact@paulk.fr> wrote:
>>
>> Hi Paul, Mikhail,
>>
>> thanks for the reply!
>>
>>> Hi,
>>>
>>> On Thu 09 Apr 26, 13:48, Mikhail Kalashnikov wrote:
>>>> On 4/8/26 00:47, Philippe Simons wrote:
>>>>> From: Jernej Skrabec <jernej.skrabec@gmail.com>
>>>>>
>>>>> Allwinner's BSP DRAM code uses parameter TPR6, presumably containing
>>>>> some "Vref" parameter, to encode the values for *all* four supported DRAM
>>>>> types. The code selects one byte based on the DRAM type used at runtime.
>>>>> To allow copying DRAM parameters from vendor firmware, we used this value
>>>>> and its encoding, but wrongly: the proper order of bytes is DDR3, DDR4,
>>>>> LPDDR3, LPDDR4, from LSB to MSB, cf. the A523 and A133 DRAM code.
>>>>>
>>>>> Correct the masking for LPDDR3 to fix DRAM operation on some boards
>>>>> using this DRAM type.
>>>>>
>>>>> With LPDDR3 TRP6 parsing fixed, adapt default DRAM_SUNXI_TPR6 value.
>>>>> Also change LPDDR4 default value to 0x38 used by A523 boards.
>>>>>
>>>>> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>>>>> [adjusted commit message, update default value]
>>>>> Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
>>>>> ---
>>>>>    arch/arm/mach-sunxi/Kconfig            | 2 +-
>>>>>    arch/arm/mach-sunxi/dram_sun50i_h616.c | 2 +-
>>>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
>>>>> index e979ee4a2cc..a1ddc6a1fc8 100644
>>>>> --- a/arch/arm/mach-sunxi/Kconfig
>>>>> +++ b/arch/arm/mach-sunxi/Kconfig
>>>>> @@ -144,7 +144,7 @@ config DRAM_SUNXI_TPR3
>>>>>    config DRAM_SUNXI_TPR6
>>>>>    	hex "DRAM TPR6 parameter"
>>>>> -	default 0x3300c080
>>>>> +	default 0x38c00080
>>>> I don't think this will be a good solution. The changes in this series
>>>> were originally made to improve compatibility with the vendor driver,
>>>> but now you are introducing an additional inconsistency by closing the
>>>> previous one. The default values are not just arbitrary values — they
>>>> are part of the vendor code that was obtained through binary analysis.
>>>> https://lore.kernel.org/all/20231018172109.085cce24@donnerap.manchester.arm.com/
>>>
>>> I tend to agree with you, it feels like the default value was taken from the
>>> reference code while the field parsing was just an issue that was introduced
>>> with the h616 code. So it should not affect the defaut value, which was likely
>>> mistakenly parsed before.
>>
>> Yes, that Tanix TX1 uses a wrong value because of this, but that's
>> about the only effect, I'd say.
>>
>> It seems like at this point the "default" value is just a convenience
>> value we introduced to avoid naming the same repeated TPR6 value in
>> every defconfig, as per my email. But it's a pure mainline U-Boot
>> technicality at this point, and we could easily just provide an
>> explicit value in each defconfig. I came up with this table, for the
>> currently mainline supported boards:
>>
>> board name		SoC	TPR6 value	type	Vref value
>> ------------------------------------------------------------------
>> liontron-h-a133l	A133	0x48000000	LPDDR4  48xxxxxx
>> anbernic_rg35xx_h700	H616	0x40808080      LPDDR4  40xxxxxx
>> orangepi_zero2		H616	0x3300c080 d	DDR3    xxxxxx80
>> orangepi_zero2w		H616	0x48808080	LPDDR4  48xxxxxx
>> orangepi_zero3		H616	0x44000000	LPDDR4  44xxxxxx
>> tanix_tx1		H616	0x2fb08080	LPDDR3  xxb0xxxx
>> transpeed-8k618-t	H616	0x3300c080 d	DDR3    xxxxxx80
>> x96_mate		H616	0x3300c080 d	DDR3    xxxxxx80
>> x96q			H616	0x3300c080 d	DDR3    xxxxxx80
>> yuzukihd-chameleon	H616	0x33808080	DDR3    xxxxxx80
>> avaota-a1		A523	0x38000000	LPDDR4  38xxxxxx
>> orangepi_4a		A523	0x38000000	LPDDR4  38xxxxxx
>> radxa-cubie-a5e		A523	0x38000000	LPDDR4  38xxxxxx
>> x96q_pro_plus		A523	0x3380807e	DDR3    xxxxxx7e
> 
> A few more entries for board I could get running (not submitted yet):
> 
> board name		SoC	TPR6 value	type	Vref value
> ------------------------------------------------------------------
> baijie-helperboard-a133	A133	0x48000000	LPDDR4	48xxxxxx
> logicom-la-tab-129	A133	0x2fb88080	LPDDR3	xxb8xxxx
> kickpi-k5c		A133	0x33808080	DDR3	xxxxxx80
> dshanpi-rosx		R818	0x48000000	LPDDR4	48xxxxxx

Ah, many thanks for that, good to have more examples.
And looking forward to the support patches for those boards ;-)

>> So the default value is just used for the old H616 DDR3 boards, where
>> only the LSB matters.
>>
>> So what about dropping the default completely, since now it spans three
>> SoCs already, and finding some reasonable default for all of them will
>> become more complicated?
> 
> Yes honestly this is the only DRAM TPR value that has a non-zero default in
> Kconfig and it feels a bit weird. I'm in favor of explicitly defining all the
> board-specific parameters in the configs and using zero as Kconfig default.

Cool, I will do that!

>> And maybe you can confirm: this should not affect compatibility with
>> vendor parameters at all, I think they always contain an explicit TPR6
>> value, and "no TPR6 value provided" is not a thing?
> 
> Yes I've always seen an explicit value defined, and since it's part of the
> dram_para array, there has to be something. However the A133 code has fallback
> values when it gets a zero from dram_para:
> https://source.denx.de/u-boot/custodians/u-boot-sunxi/-/blob/master/arch/arm/mach-sunxi/dram_sun50i_a133.c?ref_type=heads#L598
> 
> This doesn't seem to be the case in the H616 and A523 code. The default is 0x80
> for DDR3/DDR4/LPDDR3 and 0x33 for LPDDR4. I'm not sure this is really a thing
> that boards might actually rely on though. I would rather be in favor of
> removing it too to avoid confusion.

 From what I'have seen, it looks like the LPDDR4 value is always a 
multiple of 8, at least no board uses 0x33.
But I'd say leave the A133 code in for now, it doesn't hurt either and 
mimics the BSP.

>>>> There are several options here:
>>>> 1. If our goal is to improve compatibility, then we should not change
>>>> the default values for LPDDR4, and only keep the changes for LPDDR3.
>>
>> Fair, I don't really care about the MSB, the new value I suggested
>> seemed just like the most common value (see the table above). But it's
>> pointless, since those boards provide an explicit value, and don't use
>> the default.
>>
>>>> 2. Add the changes from option 2, and additionally introduce the default
>>>> values for the A523 platform that I made during the initial binary
>>>> analysis but for some reason did not get merged into mainline.
>>>> (https://github.com/iuncuim/u-boot/blob/b17c5c8911a4fce328b01e6332632a9ccd88ebc6/arch/arm/mach-sunxi/Kconfig#L102)
>>
>> Sorry, but this value doesn't seem right: The LPDDR4 boards use 0x38,
>> not 0x33, and the DDR3 board uses 0x7e, not 0x80. I don't know about
>> other boards, but this value don't seem to help - and it's unneeded
>> anyway, as the A523 board already provide an explicit TPR6 - and new
>> boards could do as well.
> 
> I think we should just drop the default value instead of trying to make sense
> of what that default should be for different platforms.

Yes, will do that.

>>> It would be good to have different defaults for different platforms yes.
>>> Note that the a133 code has some fallback with defaults when the extracted
>>> field in tpr6 is zero. Maybe they should be used as default value for a133.
>>> We probably still need to keep these fallbacks in the code in case some
>>> board-specific tpr6 value does have zeroes and relies on this behavior.
>>>
>>>> 3. If we accept the incompatibility between the vendor driver and
>>>> the mainline driver, then this patch series is unnecessary because
>>>> they introduce additional inconsistency with the vendor driver.
>>>
>>> We definitely want to be able to take the dram parameter values straight from
>>> the BSP and put them directly into our Kconfig. Changing the order of fields
>>> would make porting new boards very painful so it should be avoided.
>>
>> Yes, I agree, we should take the DRAM parameters values verbatim. But
>> as explained above, I think the Kconfig default is a different matter.
>> For simplicity, I'd say we drop it and add TPR6 values into the
>> affected defconfigs. Providing separate defaults for different SoC just
>> makes things more complicated - for no reason.
> 
> Agreed.

Thanks, will send a v3 to that effect.

Cheers,
Andre

> 
> All the best,
> 
> Paul
> 
>>>
>>>> I think option two is the most correct, but option one is also suitable,
>>>> since the DRAM driver for the A523 only supports DDR3 and LPDDR4,
>>>> and the default values in this case are the same as for the H616
>>>> (A523 is 0x33808080, H616 is 0x33c00080).
>>>
>>> I suggest we keep the current default (without moving the lpddr3 bits) for h616
>>> and add new defaults in Kconfig for a523 and a133.
>>>
>>>>>    	help
>>>>>    	  TPR6 value from vendor DRAM settings.
>>>>> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
>>>>> index 3345c9b8e82..42a0550e015 100644
>>>>> --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
>>>>> +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
>>>>> @@ -975,7 +975,7 @@ static bool mctl_phy_init(const struct dram_para *para,
>>>>>    		val = para->tpr6 & 0xff;
>>>>>    		break;
>>>>>    	case SUNXI_DRAM_TYPE_LPDDR3:
>>>>> -		val = para->tpr6 >> 8 & 0xff;
>>>>> +		val = para->tpr6 >> 16 & 0xff;
>>>
>>> This change is definitely necessary though.
>>
>> Yes, absolutely.
>>
>>
>> Cheers,
>> Andre
>>
>>>
>>>>>    		break;
>>>>>    	case SUNXI_DRAM_TYPE_LPDDR4:
>>>>>    		val = para->tpr6 >> 24 & 0xff;
>>>
>>> All the best,
>>>
>>> Paul
>>>
>>
> 

