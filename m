Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29FBC4829C
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 23:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5DCD87E5F;
	Sun, 11 Feb 2024 00:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="SGiUH0Zs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54B0A87E98; Sun, 11 Feb 2024 00:04:36 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61E648799D
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 00:04:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707606273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQGF3OMT9SeVeLjef6MLC/gt96wyBdJWn4K100eDjwk=;
 b=SGiUH0ZsBJoPhbv/XImH46twgbHmpacigMrF4ArjDoOHp7DfwycV5K/es/5I7OZMeZzQap
 5CQ0y/IFYmBc0RO0jdYBM4U3FoNpnx2kUNu01tY2sJ9rsQziqHcPMt1EktZp7gPBdIh/Mp
 0zZgi4QNrICVQlcRNkKINEkjZevXFK16s7V+kYVVJHYSvRiew9zK/9pExeaHz4uL2T1qVE
 kvxG9VFfmpgW7xC6u1BRONRk0Wa6rurbcb2xi2pzkBgT7lGFEKdoCrVAKxXShbw8Y/H+hw
 BK7EC6pKXueiNxzOmmTW5FgfIkjV/NsMhwzqU20XJX7xQ9ZLCt0PuS/3ljjoig==
Date: Sun, 11 Feb 2024 00:04:32 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 13/15] rockchip: rk3328: Add support to build bootable SPI
 image
In-Reply-To: <a5c03034-434d-4491-98c9-9999358ccbf1@kwiboo.se>
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-14-jonas@kwiboo.se>
 <72bd1e6d81755da0300a5da9a64b7408@manjaro.org>
 <c32129ba-db25-4b9d-9a4a-032d88dfb9cd@kwiboo.se>
 <1ed1b42cff551e7fda033de5461b0562@manjaro.org>
 <a5c03034-434d-4491-98c9-9999358ccbf1@kwiboo.se>
Message-ID: <e3bebd0e18f56045d00993ccebc816fc@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-02-10 20:30, Jonas Karlman wrote:
> On 2024-02-10 18:18, Dragan Simic wrote:
>> On 2024-02-08 22:54, Jonas Karlman wrote:
>>> On 2024-02-08 04:53, Dragan Simic wrote:
>>>> On 2024-02-07 01:02, Jonas Karlman wrote:
>>>>> Similar to RK35xx the BootRom in RK3328 can read all data and look
>>>>> for
>>>>> idbloader at 0x8000, same as on SD and eMMC.
>>>>> 
>>>>> Use the rksd format and modify the mkimage offset to generate a
>>>>> bootable
>>>>> u-boot-rockchip-spi.bin that can be written to 0x0 of SPI NOR 
>>>>> flash.
>>>>> 
>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> 
>>>> Could you, please, clarify a bit why the "rkspi" format isn't used
>>>> instead of "rksd"?
>>> 
>>> Not really sure how I can clarify this.
>>> 
>>> As stated in commit message, the bootrom will read all bytes and use
>>> same boot offset as the sd/emmc-format. The "legacy" spi-format only
>>> read first 2kb of each 4kb of storage, see tools/rkspi.c.
>>> 
>>> A few bootrom versions:
>>> - rk3288: 320A 20131116 V100
>>> - rk3399: 330C 20160118 V100
>>> - rk3328: 320C 20161117 V100
>>> - rk3308: 330E 20180203 V100
>>> 
>>> I am not sure if the rkspi format must be used for all bootrom prior 
>>> to
>>> and including rk3399 and all versions after that should use the rksd
>>> format. I have only ever used boot from spi flash on rk3399, rk3328 
>>> and
>>> rk35xx. And for those that has been true.
>> 
>> Ah, thank you very much for refreshing my memory.  I somehow forgot
>> about the bug that the RK3399 BROM suffers from.
>> 
>> Please see also one small suggestion below.
>> 
>>>>> ---
>>>>>  arch/arm/dts/rk3328-u-boot.dtsi        | 11 +++++++++++
>>>>>  arch/arm/mach-rockchip/rk3328/rk3328.c |  1 +
>>>>>  2 files changed, 12 insertions(+)
>>>>> 
>>>>> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi
>>>>> b/arch/arm/dts/rk3328-u-boot.dtsi
>>>>> index b90d78878d77..2a5dca97dd4b 100644
>>>>> --- a/arch/arm/dts/rk3328-u-boot.dtsi
>>>>> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
>>>>> @@ -120,3 +120,14 @@
>>>>>  &usb20_otg {
>>>>>  	hnp-srp-disable;
>>>>>  };
>>>>> +
>>>>> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>>>>> +&binman {
>>>>> +	simple-bin-spi {
>>>>> +		mkimage {
>>>>> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
>> 
>> Perhaps there's no need to use CONFIG_SYS_SOC there, because this is 
>> an
>> U-Boot SoC dtsi specific to the RK3328.  Furthermore, I find it much
>> more readable (and grep-able, which is also important) when the exact
>> name of the SoC is specified here.
>> 
>> This note also applies to the other U-Boot SoC dtsi files.
> 
> Consistency is my main concern so I would rather keep using SYS_SOC, it
> is already being used at the two other override locations.

I agree that consistency is good.  Just checking, are you referring
to the use of CONFIG_SYS_SOC in arch/arm/dts/rk356x-u-boot.dtsi and
arch/arm/dts/rk3588s-u-boot.dtsi?  Frankly, I'd much rather see rk3568
and rk3588 there, which would be much more readable.

I mean, is CONFIG_SYS_SOC in each of the U-Boot SoC dtsi files ever
going to be substituted with something else than the already known
"rkxxxx" value?  If so, IMHO there's no valid point in not using the
known value directly.

> If we can get confirmation that it is brom in SoCs chronologically up 
> to
> and including rk3399 that is affected by the read 2kb per 4kb of spi
> issue we should be able to rework this into a more proper and future
> proof way.

It would be nice to have some kind of an official confirmation for that.

>>>>> +			offset = <0x8000>;
>>>>> +		};
>>>>> +	};
>>>>> +};
>>>>> +#endif
>>>>> diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c
>>>>> b/arch/arm/mach-rockchip/rk3328/rk3328.c
>>>>> index b591d38fe412..b82b209de9e2 100644
>>>>> --- a/arch/arm/mach-rockchip/rk3328/rk3328.c
>>>>> +++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
>>>>> @@ -36,6 +36,7 @@
>>>>> 
>>>>>  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>>>>>  	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff520000",
>>>>> +	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff190000/flash@0",
>>>>>  	[BROM_BOOTSOURCE_SD] = "/mmc@ff500000",
>>>>>  };
