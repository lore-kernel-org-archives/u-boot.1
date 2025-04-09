Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCDCC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 11:56:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 494F183698;
	Wed,  9 Apr 2025 13:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="BGxbvzy+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEF02836A4; Wed,  9 Apr 2025 13:56:18 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 023A38363B
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 13:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6bf1=W3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744199773;
 bh=1YM2FkvFs7Z4EaFjNPJwjY1JbTPIj5H8sEIZCSOYuio=;
 b=BGxbvzy+IbKsIDklRfeik3n7IPY8nKIzqvSeIudkvd2zQxCv9Jk7cHOVcj47F0PZ0mvkHDlfU
 dVyBxQsGiPmpujOQJdhxr0m1mghK7RHzELL9F70etVpQ5NfAhRhPrwj3rg/3oJeNiW2kzYjj1Xo
 /ll/EHfIToNKXov/JnlGDodg6PKNHRAmd1owhD3FL0oW1/p2DFEugdMX4LTeeBI+xMjQwEPKe3e
 kHWVcb/0k/jBLxy57WkGLAL/0cg4FPkZunftexq2QBplUlcvLuqhjqRTrQ3+j+2RwQl6B6Pt3tM
 5YrrxGnFrTJAsm8/d3zb962FeAz4Th/DsrGvZT9CkQUg==
X-Forward-Email-ID: 67f6605b02fba845dcdf2e6f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b833ffb7-9a28-4d74-bcd0-9de43a859690@kwiboo.se>
Date: Wed, 9 Apr 2025 13:56:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] rockchip: binman: Factor out arch and compression
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-3-jonas@kwiboo.se>
 <cc9d923d-2635-41d8-bdf9-9eab0fa78249@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <cc9d923d-2635-41d8-bdf9-9eab0fa78249@cherry.de>
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

On 2025-04-09 11:28, Quentin Schulz wrote:
> Hi Jonas, Simon,
> 
> On 3/29/25 4:06 PM, Jonas Karlman wrote:
>> From: Simon Glass <sjg@chromium.org>
>>
>> Declare arch and compression at the top of the file to avoid needing
>> ifdefs in every usage.
>>
>> Add a few comments to help with the remaining #ifdefs.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Changes in v4:
>> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
>> ---
>>   arch/arm/dts/rockchip-u-boot.dtsi | 44 +++++++++++++++----------------
>>   1 file changed, 22 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
>> index e9ed1d4b5738..2b01dc660562 100644
>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
>> @@ -5,6 +5,20 @@
>>   
>>   #include <config.h>
>>   
>> +#ifdef CONFIG_ARM64
>> +#define ARCH	"arm64"
>> +#else
>> +#define ARCH	"arm"
>> +#endif
>> +
> 
> I would refrain from using ARCH here as it's something we already use to 
> specify the architecture to build (e.g. make ARCH=arm64 CROSS_COMPILE=...).
> 
> Maybe FIT_ARCH?

sunxi-u-boot.dtsi is also using ARCH so I figured it was also safe here,
we can change to FIT_ARCH for a v5.

> 
>> +#if defined(CONFIG_SPL_GZIP)
>> +#define COMP	"gzip"
>> +#elif defined(CONFIG_SPL_LZMA)
>> +#define COMP	"lzma"
>> +#else
>> +#define COMP	"none"
>> +#endif
>> +
> 
> This is specific to the U-Boot proper image node only, maybe we should 
> have this constant named more appropriately, e.g. FIT_PROPER_COMP or 
> something like that?

Sounds good, will change in a v5.

> 
> Reading the symbols also, I believe their help text is misleading or 
> confusing (at least the _GZIP ones, _ZSTD seems okay).
> 
> Also, I'm wondering if it actually makes sense to force a specific 
> U-Boot proper compression algorithm based on a symbol of what 
> decompression algorithms are supported in U-Boot SPL. Like, why should 
> gzip be picked if I also have lzma enabled? In any case, nothing related 
> to this patch.

Agree, use of compressed image should probably be enabled using a
dedicated Kconfig symbol, something for a different series :-)

> 
>>   / {
>>   	binman: binman {
>>   		multiple-images;
>> @@ -51,26 +65,12 @@
>>   					description = "U-Boot";
>>   					type = "standalone";
>>   					os = "u-boot";
>> -#ifdef CONFIG_ARM64
>> -					arch = "arm64";
>> -#else
>> -					arch = "arm";
>> -#endif
>> -#if defined(CONFIG_SPL_GZIP)
>> -					compression = "gzip";
>> -#elif defined(CONFIG_SPL_LZMA)
>> -					compression = "lzma";
>> -#else
>> -					compression = "none";
>> -#endif
>> +					arch = ARCH;
>> +					compression = COMP;
>>   					load = <CONFIG_TEXT_BASE>;
>>   					entry = <CONFIG_TEXT_BASE>;
>>   					u-boot-nodtb {
>> -#if defined(CONFIG_SPL_GZIP)
>> -					compress = "gzip";
>> -#elif defined(CONFIG_SPL_LZMA)
>> -					compress = "lzma";
>> -#endif
>> +					compress = COMP;
>>   					};
>>   #ifdef CONFIG_SPL_FIT_SIGNATURE
>>   					hash {
>> @@ -84,7 +84,7 @@
>>   					fit,operation = "split-elf";
>>   					description = "ARM Trusted Firmware";
>>   					type = "firmware";
>> -					arch = "arm64";
>> +					arch = ARCH;
>>   					os = "arm-trusted-firmware";
>>   					compression = "none";
>>   					fit,load;
>> @@ -103,7 +103,7 @@
>>   					fit,operation = "split-elf";
>>   					description = "TEE";
>>   					type = "tee";
>> -					arch = "arm64";
>> +					arch = ARCH;
>>   					os = "tee";
>>   					compression = "none";
>>   					fit,load;
>> @@ -119,11 +119,11 @@
>>   					};
>>   #endif
>>   				};
>> -#else
>> +#else /* !CONFIG_ARM64 */
>>   				op-tee {
>>   					description = "OP-TEE";
>>   					type = "tee";
>> -					arch = "arm";
>> +					arch = ARCH;
>>   					os = "tee";
>>   					compression = "none";
>>   					load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
> 
> Wondering if we couldn't put some of the Aarch32 and Aarch64 OP-TEE OS 
> node(s) in common?

Sounds like a good idea to maybe put op-tee in a template, personally I
never use op-tee so typically try to minimize any change/impact related
to op-tee.

The RK3506 does use op-tee so I may need to dig more into the op-tee
parts in a future RK3506 enablement series, initially [1] was enough.
Could look more into using a op-tee template in such future series.

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commit/3d683f3b717de010fffeece8712373892a599905

> 
> The change is fine, finding a more appropriate name for COMP and ARCH 
> and it's all good.

I will use different names in a v5.

Regards,
Jonas

> 
> Cheers,
> Quentin

