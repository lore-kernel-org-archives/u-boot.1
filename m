Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7CECA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 10:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A3D683487;
	Sun, 31 Aug 2025 12:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jFlxjH+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E626836AB; Sun, 31 Aug 2025 12:53:13 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAF5F83447
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 12:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0b89=3L=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1756637589;
 bh=YRei40auBMWYGYsNbAd8lycBq3sFEMQtPnz1ODyZLVU=;
 b=jFlxjH+P9kR0hNHjrynmjR+2OQ7S/Yi1kDLgPyRLHLqOI5NV/C4ZgSUWu2Cjcy5OYWfzEA2p3
 N4HfgOAZsfiy6b8c+7iXrnoZP0S+DMMpSYOkRFYdbq/eWk38xm6ZwFzj0WnwOyWsQqyRkUrJhTM
 v3PLL3Ri1lMhgUHLU5na6Irs0iEwujk2VogFdfijN8r6sJb76ouAfYNd9UGVo0KQev7snaIw9Yb
 eiUJ8grzo4VREzXfNh4771W6hq2pcy7gUmyMo38vFbwBMCqLTAbhHkyUU6jguRXD1nTh583j65Z
 hJgMwGbo4OmOmLndD/AO3gpSHuSwt45U36NjCOxG7HCA==
X-Forward-Email-ID: 68b4299132f03f9a5e907f70
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c7e0f50b-1fb7-4608-99d2-f495b3f420e0@kwiboo.se>
Date: Sun, 31 Aug 2025 12:53:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] rockchip: rk3576: Add SPI Flash boot support
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250801210619.2618622-1-jonas@kwiboo.se>
 <20250801210619.2618622-4-jonas@kwiboo.se>
 <a22ea144-ada6-4520-a7fd-43380f526ee4@cherry.de>
 <ad21e750-5606-422d-842e-23a33772e7b8@kwiboo.se>
 <eba0984a-ee81-4d94-a7d3-7d31b6a23350@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <eba0984a-ee81-4d94-a7d3-7d31b6a23350@cherry.de>
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

Hi Quentin,

On 8/12/2025 10:02 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/12/25 12:02 AM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 8/11/2025 11:59 AM, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 8/1/25 11:06 PM, Jonas Karlman wrote:
>>>> The bootsource ids reported by BootROM of RK3576 for SPI NOR and USB
>>>> differs slightly compared to prior SoCs:
>>>>
>>>> - Booting from sfc0 (ROCK 4D) report the normal bootsource id 0x3.
>>>> - Booting from sfc1 M1 (NanoPi M5) report a new bootsource id 0x23.
>>>> - Booting from sfc1 M0 has not been tested (no board using this config).
>>>> - Booting from USB report a new bootsource id 0x81.
>>>>
>>>> Add a RK3576 specific read_brom_bootsource_id() function to help decode
>>>> the new bootsource id values and the required boot_devices mapping of
>>>> sfc0 and sfc1 to help support booting from SPI flash on RK3576.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>> v2: No change
>>>> ---
>>>>    arch/arm/dts/rk3576-u-boot.dtsi        | 36 ++++++++++++++++++++++++++
>>>>    arch/arm/mach-rockchip/rk3576/rk3576.c | 23 ++++++++++++++++
>>>>    2 files changed, 59 insertions(+)
>>>>
>>>> diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
>>>> index fb5a107f47d9..c7ed09e03eec 100644
>>>> --- a/arch/arm/dts/rk3576-u-boot.dtsi
>>>> +++ b/arch/arm/dts/rk3576-u-boot.dtsi
>>>> @@ -6,6 +6,11 @@
>>>>    #include "rockchip-u-boot.dtsi"
>>>>    
>>>>    / {
>>>> +	aliases {
>>>> +		spi5 = &sfc0;
>>>> +		spi6 = &sfc1;
>>>> +	};
>>>> +
>>>>    	chosen {
>>>>    		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
>>>>    	};
>>>> @@ -16,6 +21,17 @@
>>>>    	};
>>>>    };
>>>>    
>>>> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>>>> +&binman {
>>>> +	simple-bin-spi {
>>>> +		mkimage {
>>>> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
>>>> +			offset = <0x8000>;
>>>
>>> Is this a requirement of the SoC or just a default?
>>>
>>> E.g. on my RK3399 I can flash at offset 0 u-boot-rockchip-spi.bin and
>>> it'll happily boot. Is it still the same on RK3576 but you preferred to
>>> have a similar offset than for eMMC/SD (and/or have space to store a
>>> partition table before?)
>>
>> Not sure if I ever tested using offset 0 for rk3576, will do before v3.
>>
>> If I remember correctly the rk356x/rk3588 (and/or others SoCs) would not
>> boot when using offset 0, so I probably only tested the 32 KiB offset
> 
> Possibly, I only own one board with a bootable SPI, my old RK3399 Puma 
> so that's about the sample size I can get :)
> 
>> that is known working for other rk35xx SoCs. And on RK3326 (probably
>> also PX30) a 64 KiB offset resulted in working boot from SPI flash.
>>
> 
> IIRC, I mistakenly flashed on 32KiB offset for RK3399 as well and it 
> booted (the SPL, then it broke because it's so much space constrained on 
> RK3399 Puma that I cannot afford the 32KiB offset).

I did a quick test of using offset 0 of SPI flash on ROCK 4D and it
booted fine, will however keep the 32 KiB offset in v3 to use consistent
offset with the other RK35xx SoCs/boards.

> 
> I guess this could also be something we could have as default. If you 
> want a different offset, then you can update it in your board 
> -u-boot.dtsi (or have a Kconfig symbol, but IIRC we don't have one for 
> MMC so why have one for SPI only?).

Agree, possible adding use of a Kconfig symbol for offsets could be
something for a future follow-up series.

> 
>>>
>>>> +		};
>>>> +	};
>>>> +};
>>>> +#endif
>>>
>>> Not a blocker for this patch but I think it would make sense to invert
>>> the logic globally now so that we don't need to have to do this for
>>> every new Rockchip SoC we'll support.
>>>
>>> Have -T rksd in rockchip-u-boot.dtsi and all SoCs that have an SPI
>>> controller and do not override this property would have -T rkspi set in
>>> their SoC DTSI, e.g. rk3399-u-boot.dtsi would now get
>>>
>>> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>>> +&binman {
>>> +	simple-bin-spi {
>>> +		mkimage {
>>> +			args = "-n", CONFIG_SYS_SOC, "-T", "rkspi";
>>> +		};
>>> +	};
>>> +};
>>> +#endif
>>
>> I fully agree, there is now a minority using the special rkspi format so
>> a flip to have rksd (and possible also the 32 KiB offset) in
>> rockchip-u-boot.dtsi is a very good idea for a future series.
>>
>>  From a quick grep maybe only rk3288 and rk3399 may need this special
>> rkspi format? Probably also some older SoCs, not sure we really support
>> building working SPI flash images for such older SoCs anyway.
>>
> 
> What we can start with is doing a flip which results in the exact same 
> binary before and after the flip. Then whichever SoC doesn't actually 
> need the rkspi trick can disable it on the SoC level I guess in a later 
> patch?

I think this make sense, and something for a future series :-)

Regards,
Jonas

> 
> Cheers,
> Quentin

