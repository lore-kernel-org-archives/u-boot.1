Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B63C48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 21:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17FD087DDD;
	Thu,  8 Feb 2024 22:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="g9pVzt6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E675587E2B; Thu,  8 Feb 2024 22:54:53 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D07987D63
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 22:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=aba7=JS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1707429282;
 bh=ZcZHm1pB7w/UUEoE1RibhS5dTQ1oNSSCgDSaX7uTc9w=;
 b=g9pVzt6Tsv/B8iOC5ceRR6E2Lu+wVReXwnot76ZmTDgaDsJjpyqIxe/3VGoZXp/evaKdGoT3I
 8tf7ih3+VHm2bhAIPvnsc1kyFsON93Q6abNPJKARBWCzrayib6EW2gNrjXZQ4aToBjWAjVbuvNL
 UcBTVB8dbyOcs7bcoDaU8BAqkj9fzM1GJXVIE8ykb7NUTEFRU+cqK8a3V5x3bZNPZRD/XVaN7bp
 yEuPK6S4/Zl8rC4ry1KuINV6ibvI7Hv6LmFJ7YZhGcpu1GmmfuZwBf73LvPJxxXbDaPLb2CM38e
 WVn1pfQAgiEC3bLNbd+TaiLOsRGej41uiyqUkV5p0f3Q==
Message-ID: <c32129ba-db25-4b9d-9a4a-032d88dfb9cd@kwiboo.se>
Date: Thu, 8 Feb 2024 22:54:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] rockchip: rk3328: Add support to build bootable SPI
 image
To: Dragan Simic <dsimic@manjaro.org>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-14-jonas@kwiboo.se>
 <72bd1e6d81755da0300a5da9a64b7408@manjaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <72bd1e6d81755da0300a5da9a64b7408@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c54da277d3d264c6373cc9
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

Hi Dragan,

On 2024-02-08 04:53, Dragan Simic wrote:
> Hello Jonas,
> 
> On 2024-02-07 01:02, Jonas Karlman wrote:
>> Similar to RK35xx the BootRom in RK3328 can read all data and look for
>> idbloader at 0x8000, same as on SD and eMMC.
>>
>> Use the rksd format and modify the mkimage offset to generate a 
>> bootable
>> u-boot-rockchip-spi.bin that can be written to 0x0 of SPI NOR flash.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> Could you, please, clarify a bit why the "rkspi" format isn't used
> instead of "rksd"?

Not really sure how I can clarify this.

As stated in commit message, the bootrom will read all bytes and use
same boot offset as the sd/emmc-format. The "legacy" spi-format only
read first 2kb of each 4kb of storage, see tools/rkspi.c.

A few bootrom versions:
- rk3288: 320A 20131116 V100
- rk3399: 330C 20160118 V100
- rk3328: 320C 20161117 V100
- rk3308: 330E 20180203 V100

I am not sure if the rkspi format must be used for all bootrom prior to
and including rk3399 and all versions after that should use the rksd
format. I have only ever used boot from spi flash on rk3399, rk3328 and
rk35xx. And for those that has been true.

Regards,
Jonas

> 
>> ---
>>  arch/arm/dts/rk3328-u-boot.dtsi        | 11 +++++++++++
>>  arch/arm/mach-rockchip/rk3328/rk3328.c |  1 +
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi 
>> b/arch/arm/dts/rk3328-u-boot.dtsi
>> index b90d78878d77..2a5dca97dd4b 100644
>> --- a/arch/arm/dts/rk3328-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
>> @@ -120,3 +120,14 @@
>>  &usb20_otg {
>>  	hnp-srp-disable;
>>  };
>> +
>> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>> +&binman {
>> +	simple-bin-spi {
>> +		mkimage {
>> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
>> +			offset = <0x8000>;
>> +		};
>> +	};
>> +};
>> +#endif
>> diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c
>> b/arch/arm/mach-rockchip/rk3328/rk3328.c
>> index b591d38fe412..b82b209de9e2 100644
>> --- a/arch/arm/mach-rockchip/rk3328/rk3328.c
>> +++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
>> @@ -36,6 +36,7 @@
>>
>>  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>>  	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff520000",
>> +	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff190000/flash@0",
>>  	[BROM_BOOTSOURCE_SD] = "/mmc@ff500000",
>>  };

