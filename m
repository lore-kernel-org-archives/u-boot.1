Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A75C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 15:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD77838C1;
	Wed,  9 Apr 2025 17:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ufOoRnJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C596C838C7; Wed,  9 Apr 2025 17:52:21 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 338B2838BF
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 17:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3b7d=W4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744213936;
 bh=PqEgU3tm8B/ZrxG2Mtg41x5wGBQnZpx/RX+sUMHn1cc=;
 b=ufOoRnJMSzCF1pfgSDCNDy40IRlZqFW0KqlzzS2ZCyesVnEMgBmjPiKbeLe3WFofI80ly69zh
 UjZb5A9Dv5Zjq2MFzzWFfMwjnGWuyFZoJjJHPJVwMPoytvq195S/7nRG/IJtzKvJ/o36RQCnU48
 TX9c63jdfdq/YRprNgsCmde6b3vviwpTJ9hjOn/YR/qIEWyylYPyIQ/Wrz/9vdNiC3EzBk7Vxo2
 DdLDsQcpSqI2QJM/TiRMM+Y6TQMxRr3TN9LYV9ddfONO5w4aUgyBGhYmQfKxH9Bx1aSLkFP3nsv
 Vym3NzH2Ny0+oQcM++7Lfd98GXhfKi+xYH5hXRqzBvCg==
X-Forward-Email-ID: 67f697ac1aecaf4e4108eba7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <060cc012-e9fe-4fd4-9e7f-db0016533e37@kwiboo.se>
Date: Wed, 9 Apr 2025 17:52:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] rockchip: binman: Factor out arch and compression
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-3-jonas@kwiboo.se>
 <cc9d923d-2635-41d8-bdf9-9eab0fa78249@cherry.de>
 <b833ffb7-9a28-4d74-bcd0-9de43a859690@kwiboo.se>
 <8b395cb0-4523-4381-b172-ecc378735e3f@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <8b395cb0-4523-4381-b172-ecc378735e3f@cherry.de>
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

On 2025-04-09 14:27, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 4/9/25 1:56 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 2025-04-09 11:28, Quentin Schulz wrote:
>>> Hi Jonas, Simon,
>>>
>>> On 3/29/25 4:06 PM, Jonas Karlman wrote:
>>>> From: Simon Glass <sjg@chromium.org>
>>>>
>>>> Declare arch and compression at the top of the file to avoid needing
>>>> ifdefs in every usage.
>>>>
>>>> Add a few comments to help with the remaining #ifdefs.
>>>>
>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>> Changes in v4:
>>>> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
>>>> ---
>>>>    arch/arm/dts/rockchip-u-boot.dtsi | 44 +++++++++++++++----------------
>>>>    1 file changed, 22 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
>>>> index e9ed1d4b5738..2b01dc660562 100644
>>>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
>>>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
>>>> @@ -5,6 +5,20 @@
>>>>    
>>>>    #include <config.h>
>>>>    
>>>> +#ifdef CONFIG_ARM64
>>>> +#define ARCH	"arm64"
>>>> +#else
>>>> +#define ARCH	"arm"
>>>> +#endif
>>>> +
>>>
>>> I would refrain from using ARCH here as it's something we already use to
>>> specify the architecture to build (e.g. make ARCH=arm64 CROSS_COMPILE=...).
>>>
> 
> Actually you don't need (or even shouldn't?) provide ARCH to the make 
> command, got confused because I'm compiling the kernel right now :)
> 
>>> Maybe FIT_ARCH?
>>
>> sunxi-u-boot.dtsi is also using ARCH so I figured it was also safe here,
>> we can change to FIT_ARCH for a v5.
>>
> 
> Indeed. I would prefer something not clashing with other 
> environment/make variables :)
> 
> [...]
> 
>>>> @@ -84,7 +84,7 @@
>>>>    					fit,operation = "split-elf";
>>>>    					description = "ARM Trusted Firmware";
>>>>    					type = "firmware";
>>>> -					arch = "arm64";
>>>> +					arch = ARCH;
>>>>    					os = "arm-trusted-firmware";
>>>>    					compression = "none";
>>>>    					fit,load;
>>>> @@ -103,7 +103,7 @@
>>>>    					fit,operation = "split-elf";
>>>>    					description = "TEE";
>>>>    					type = "tee";
>>>> -					arch = "arm64";
>>>> +					arch = ARCH;
>>>>    					os = "tee";
>>>>    					compression = "none";
>>>>    					fit,load;
>>>> @@ -119,11 +119,11 @@
>>>>    					};
>>>>    #endif
>>>>    				};
>>>> -#else
>>>> +#else /* !CONFIG_ARM64 */
>>>>    				op-tee {
>>>>    					description = "OP-TEE";
>>>>    					type = "tee";
>>>> -					arch = "arm";
>>>> +					arch = ARCH;
>>>>    					os = "tee";
>>>>    					compression = "none";
>>>>    					load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
>>>
>>> Wondering if we couldn't put some of the Aarch32 and Aarch64 OP-TEE OS
>>> node(s) in common?
>>
>> Sounds like a good idea to maybe put op-tee in a template, personally I
>> never use op-tee so typically try to minimize any change/impact related
>> to op-tee.
>>
>> The RK3506 does use op-tee so I may need to dig more into the op-tee
>> parts in a future RK3506 enablement series, initially [1] was enough.
>> Could look more into using a op-tee template in such future series.
>>
>> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commit/3d683f3b717de010fffeece8712373892a599905
>>
> 
> Interesting, is it required for RK3506? Do they do things in secure 
> world and since it's Aarch32, no TF-A loaded by U-Boot?

To my knowledge the vendor OP-TEE blob implement PSCI for cpu core mgmt
and it also does some sort of initialization for OTP.

Without starting OP-TEE before U-Boot proper, reading from OTP only
return 0x00 for each byte read.

So will probably be much easier to just run OP-TEE similar to what some
other Rockchip ARMv7 SoCs does/require.

> 
> You can play with OP-TEE on RK3588 from master, c.f. 
> https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/plat-rockchip/platform_rk3588.c
> 
> I haven't even built it but there's been some work on it since it was 
> merged early December last year, so possibly people are using it.

Thanks, will take a closer look at some point in future :-)

Regards,
Jonas

> 
> Cheers,
> Quentin

