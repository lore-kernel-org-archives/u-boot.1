Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566AAC4829A
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 17:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A22587E5F;
	Sat, 10 Feb 2024 18:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="cLtWNV/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C79E87E7E; Sat, 10 Feb 2024 18:18:30 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7362987E46
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 18:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707585507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NxCMdFrbO7oxVsWq6xFPWqm03dkVwDTRz0pNoqqX//I=;
 b=cLtWNV/z3oGlwUYfNNiotVaZJqml/21xnkOhX8jAZVMxEmfv0nt4ABOvq4FUpNJ6eseN2P
 vF4urzJfrkYK7idnWQd45+8a9D3zAwWemIyU1YbZBPtQ1vGf75j+RppYN6KdSBud8oXGEF
 muSF05JYw84tU/b6QsAy9vf0/Eh4A9f9wQv/WI4U7b60LepHFXozYAxSRU6e64/uRbk8Qc
 FwYxDA8d7XcZjjCCV17gjyTlwL6AcEpenadtTtF0rPf4/zuEXMBxEfsLvZAUhqoZ1N2b0/
 Ckusjohl9jWvlSsb0XCUCDUwihbqJ3BmUUdt7iErAnRBUdvVWLVyhHn9VazcNw==
Date: Sat, 10 Feb 2024 18:18:27 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 13/15] rockchip: rk3328: Add support to build bootable SPI
 image
In-Reply-To: <c32129ba-db25-4b9d-9a4a-032d88dfb9cd@kwiboo.se>
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-14-jonas@kwiboo.se>
 <72bd1e6d81755da0300a5da9a64b7408@manjaro.org>
 <c32129ba-db25-4b9d-9a4a-032d88dfb9cd@kwiboo.se>
Message-ID: <1ed1b42cff551e7fda033de5461b0562@manjaro.org>
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

Hello Jonas,

On 2024-02-08 22:54, Jonas Karlman wrote:
> On 2024-02-08 04:53, Dragan Simic wrote:
>> On 2024-02-07 01:02, Jonas Karlman wrote:
>>> Similar to RK35xx the BootRom in RK3328 can read all data and look 
>>> for
>>> idbloader at 0x8000, same as on SD and eMMC.
>>> 
>>> Use the rksd format and modify the mkimage offset to generate a
>>> bootable
>>> u-boot-rockchip-spi.bin that can be written to 0x0 of SPI NOR flash.
>>> 
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> 
>> Could you, please, clarify a bit why the "rkspi" format isn't used
>> instead of "rksd"?
> 
> Not really sure how I can clarify this.
> 
> As stated in commit message, the bootrom will read all bytes and use
> same boot offset as the sd/emmc-format. The "legacy" spi-format only
> read first 2kb of each 4kb of storage, see tools/rkspi.c.
> 
> A few bootrom versions:
> - rk3288: 320A 20131116 V100
> - rk3399: 330C 20160118 V100
> - rk3328: 320C 20161117 V100
> - rk3308: 330E 20180203 V100
> 
> I am not sure if the rkspi format must be used for all bootrom prior to
> and including rk3399 and all versions after that should use the rksd
> format. I have only ever used boot from spi flash on rk3399, rk3328 and
> rk35xx. And for those that has been true.

Ah, thank you very much for refreshing my memory.  I somehow forgot 
about
the bug that the RK3399 BROM suffers from.

Please see also one small suggestion below.

>>> ---
>>>  arch/arm/dts/rk3328-u-boot.dtsi        | 11 +++++++++++
>>>  arch/arm/mach-rockchip/rk3328/rk3328.c |  1 +
>>>  2 files changed, 12 insertions(+)
>>> 
>>> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi
>>> b/arch/arm/dts/rk3328-u-boot.dtsi
>>> index b90d78878d77..2a5dca97dd4b 100644
>>> --- a/arch/arm/dts/rk3328-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
>>> @@ -120,3 +120,14 @@
>>>  &usb20_otg {
>>>  	hnp-srp-disable;
>>>  };
>>> +
>>> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>>> +&binman {
>>> +	simple-bin-spi {
>>> +		mkimage {
>>> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";

Perhaps there's no need to use CONFIG_SYS_SOC there, because this is an
U-Boot SoC dtsi specific to the RK3328.  Furthermore, I find it much 
more
readable (and grep-able, which is also important) when the exact name of
the SoC is specified here.

This note also applies to the other U-Boot SoC dtsi files.

>>> +			offset = <0x8000>;
>>> +		};
>>> +	};
>>> +};
>>> +#endif
>>> diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c
>>> b/arch/arm/mach-rockchip/rk3328/rk3328.c
>>> index b591d38fe412..b82b209de9e2 100644
>>> --- a/arch/arm/mach-rockchip/rk3328/rk3328.c
>>> +++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
>>> @@ -36,6 +36,7 @@
>>> 
>>>  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>>>  	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff520000",
>>> +	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff190000/flash@0",
>>>  	[BROM_BOOTSOURCE_SD] = "/mmc@ff500000",
>>>  };
