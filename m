Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26968CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A6F287F64;
	Tue,  2 Apr 2024 15:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="oK7b6lHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA6A588339; Tue,  2 Apr 2024 15:37:10 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 384B387D29
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d8ab=LI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1712065015;
 bh=UXMHc5T5yYoYrDva/UqPaDdumoD+tpGibE8Ga4Y2kdw=;
 b=oK7b6lHUerC4u8zmbUdVHlTqqYoPlI6Sq46lFWDIs9E+jbX8tDKZSGaYbZD7XP5sUoUVHHghm
 hwUa3m/6pzW3NlbS2ACV0qefk+7j+2mKNaUAfmZAzeDudPcpcSZnsny7Urk45dPqciTOWCtxNLJ
 IxGBlTfArOWLiubghxzFeBfYVFXC9Rhc7c4CUnlf+PDXzLpuxDdSkwqIJmpk3FC7817Uu0oGU7g
 MriYw6rIPTe6TCT/sUnP7NQ70Zj2Eo13ELQOMScLIgF68NL52eBa4BtAI7ox4AYybDUa7DfQQSR
 jT2ng5lDhJRUKPlxUsZ0r8Q6UhbRVNL69iJzzOYcwOSA==
Message-ID: <e7bf1fbf-782e-41af-af38-82514bd2af82@kwiboo.se>
Date: Tue, 2 Apr 2024 15:36:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] rockchip: rk3588: Update bootph props
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andyshrk@163.com>, John Clark <inindev@gmail.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Joshua Riek <jjriek@verizon.net>,
 u-boot@lists.denx.de
References: <20240329190224.3613471-1-jonas@kwiboo.se>
 <20240329190224.3613471-13-jonas@kwiboo.se>
 <68bbc86e-f412-4e3d-bc5d-d18027edf63f@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <68bbc86e-f412-4e3d-bc5d-d18027edf63f@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 660c09f68f30aa7daaf4d532
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

On 2024-04-02 13:20, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 3/29/24 20:01, Jonas Karlman wrote:
> 
> [...]
> 
>> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
>> index e4171bd24d2a..a502a82fae6a 100644
>> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
>> @@ -121,31 +121,35 @@
>>   };
>>   
>>   &cru {
>> -	bootph-pre-ram;
>> +	bootph-all;
>>   };
>>   
>>   &emmc_bus8 {
>> -	bootph-all;
>> +	bootph-pre-ram;
>>   };
>>   
>>   &emmc_clk {
>> -	bootph-all;
>> +	bootph-pre-ram;
>>   };
>>   
>>   &emmc_cmd {
>> -	bootph-all;
>> +	bootph-pre-ram;
>>   };
>>   
>>   &emmc_data_strobe {
>> -	bootph-all;
>> +	bootph-pre-ram;
>>   };
>>   
>>   &emmc_rstnout {
>> -	bootph-all;
>> +	bootph-pre-ram;
>>   };
>>   
>>   &ioc {
>> -	bootph-pre-ram;
>> +	bootph-all;
>> +};
>> +
>> +&pcfg_pull_down {
>> +	bootph-all;
>>   };
>>   
>>   &pcfg_pull_none {
>> @@ -157,6 +161,10 @@
>>   };
>>   
>>   &pcfg_pull_up_drv_level_2 {
>> +	bootph-pre-ram;
>> +};
>> +
>> +&php_grf {
>>   	bootph-all;
>>   };
>>   
>> @@ -189,19 +197,23 @@
>>   };
>>   
>>   &sdmmc_bus4 {
>> -	bootph-all;
>> +	bootph-pre-ram;
>>   };
>>   
>>   &sdmmc_clk {
>> -	bootph-all;
>> +	bootph-pre-ram;
>>   };
>>   
>>   &sdmmc_cmd {
>> -	bootph-all;
>> +	bootph-pre-ram;
>>   };
>>   
>>   &sdmmc_det {
>> -	bootph-all;
>> +	bootph-pre-ram;
>> +};
>> +
> 
> Please add bootph-some-ram to all nodes related to eMMC/SD card 
> otherwise I assume some boards won't work anymore (e.g. the ones that 
> need to find MMC devices through DT in arch_env_get_location, e.g. 
> Theobroma's Jaguar (and soon Tiger)).

Sure I will add them in a v2.

When I tested your arch_env_get_location() it did not seem to require
any pinctrl nodes at pre-reloc stage.

Ideally we should be able to skip use of DM, env and serial at pre-reloc
stage for Rockchip. Serial and pinctrl already gets configured in SPL, and
use of DM slows down boot by 200-700ms, but that is for another series ;-)

> 
> c.f. 
> https://source.denx.de/u-boot/u-boot/-/commit/70f9212d61fe79c605b805c6eb0764b29f8ae3b6
> 
> It was not easy to have this merged, so I'd prefer to avoid having to go 
> through it again to fix my board(s) :)
> 
> It'd be nice to split this into multiple commits so we can have some 
> individual justification of why such a change is made, so that we know 
> if we need to revert/update it in the future.

Will try to split this in v2.

In summary some pinctrl or nodes referenced was not enabled for SPL
stage, and some was enabled for TPL that should never be needed in TPL,
if U-Boot TPL will be used in future.

TPL: uart node + dmc/ram and any node required/referenced
SPL: TPL + sdmmc/sdhci/spi-flash nodes and related pinctrl
pre-reloc: TPL + sdmmc/sdhci/spi-flash nodes

I created a python script [1] that can check the built tpl/spl/proper
dtb for missing nodes and some config options for all soc targets.

[1] https://gist.github.com/Kwiboo/34c099fb42eb6ae5ed515a04275a7ed7

Regards,
Jonas

> 
> Cheers,
> Quentin

