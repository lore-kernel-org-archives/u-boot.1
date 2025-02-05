Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB4AC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 18:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C200680562;
	Wed,  5 Feb 2025 19:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OZV22tkN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0299480762; Wed,  5 Feb 2025 19:28:29 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7414080104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 19:28:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9fbe=U5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738780105;
 bh=I5Kgf8Oq9w5+8Pe4XIctt5uLj8CQTwlh2alORrwdEgE=;
 b=OZV22tkNTEC8tM+cotuBHl/GpnOh3VwInlT65j4ZAtSPAvmW46DSBPEtK7YtKZvplEnhcPCmR
 u4/PVYG/8WTEtGDfiKkh8n/W04mUVfF6JrMaas/hveNoPIA9K7ucEjXZDmjcZ5LIMJIrvzT93et
 aIxJMQkIBNJoURI7motaXGwSV85Q5fCpZInE+P2BpiP8aRlrskl3hIKbDwEYcDKZqtSouzH6MRa
 ABhW478z3/frUilB5SokWUYmhNAeUBd581l6hbRe4UUhnkAXmATo//Q2LrJcFQCdSGCN5VL4ej5
 dusEYGOMqQe1GeZyyyWJaNNs6hBvwkJVsIDwwpUVsDFw==
X-Forward-Email-ID: 67a3adc34f7eea50c61f3291
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e217373d-a86c-4bdb-bdb6-7bd9724c394f@kwiboo.se>
Date: Wed, 5 Feb 2025 19:28:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] rockchip: Improve ARMv7 support for
 ROCKCHIP_COMMON_STACK_ADDR
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alex Bee <knaerzche@gmail.com>, u-boot@lists.denx.de
References: <20250126234838.561065-1-jonas@kwiboo.se>
 <20250126234838.561065-3-jonas@kwiboo.se>
 <efe6dd8b-e18f-454e-a93d-53f4ea491307@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <efe6dd8b-e18f-454e-a93d-53f4ea491307@cherry.de>
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

On 2025-02-05 18:07, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/27/25 12:48 AM, Jonas Karlman wrote:
>> A few Rockchip ARMv7 SoCs use 0x60000000 as DRAM base address instead of
> 
> Are there known exceptions? Among the list you provided I see RV1126 is 
> missing but is ARMv7-based. Is it an oversight or done on purpose? I 
> couldn't quickly find the TRM so no clue.

The default if tested SoCs below is the only 6 SoCs that seem to use the
0x60000000 base, both in mainline and vendor U-Boot. RV1126, RK3288 and
incoming RK3506 all use 0x0 as base address.

> 
>> the more common 0x0 DRAM base address used on AArch64 SoCs.
>>
>> Add default options that should work for these ARMv7 SoCs. Same offsets
>> as before are used, just below 64 MiB. Hex values have also been padded
>> to improve alignment.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/mach-rockchip/Kconfig | 35 +++++++++++++++++++++++-----------
>>   1 file changed, 24 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
>> index 5aa9e0f1af3b..da20d3233fe3 100644
>> --- a/arch/arm/mach-rockchip/Kconfig
>> +++ b/arch/arm/mach-rockchip/Kconfig
>> @@ -637,40 +637,53 @@ source "arch/arm/mach-rockchip/rv1126/Kconfig"
>>   if ROCKCHIP_COMMON_STACK_ADDR && SPL_SHARES_INIT_SP_ADDR
>>   
>>   config CUSTOM_SYS_INIT_SP_ADDR
>> -	default 0x3f00000
>> +	default 0x63f00000 if SPL_TEXT_BASE = 0x60000000
>> +	default 0x03f00000 if SPL_TEXT_BASE = 0x00000000
> 
> A bit sad we cannot do arithmetic here in Kconfig :(

That would have been a really nice feature :-)

> 
>>   
>>   config SYS_MALLOC_F_LEN
>> -	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
>> +	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
>> +	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>>   
>>   config SPL_SYS_MALLOC_F_LEN
>> -	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
>> +	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
>> +	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>>   
>>   config TPL_SYS_MALLOC_F_LEN
>> -	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
>> +	default 0x0800 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
>> +	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>>   
>>   config TEXT_BASE
>> -	default 0x00200000 if ARM64
>> +	default 0x60200000 if SPL_TEXT_BASE = 0x60000000
>> +	default 0x00200000 if SPL_TEXT_BASE = 0x00000000
>>   
>>   config SPL_TEXT_BASE
>> -	default 0x0 if ARM64
>> +	default 0x60000000 if ROCKCHIP_RK3036 || ROCKCHIP_RK3066 || \
>> +			      ROCKCHIP_RK3128 || ROCKCHIP_RK3188 || \
>> +			      ROCKCHIP_RK322X || ROCKCHIP_RV1108
> 
> If applicable to all ARMv7 SoCs, maybe
> 
> if CPU_V7A
> 
> would be more future-proof?

Unfortunately that does not seem to be the case, most new RK SoCs seem
to use 0x0 as DRAM base, with RK3576 being the odd one, or possible
start of a new trend.

Following ARMv7 SoCs seem to use 0x0 as DRAM base:
- RK3288
- RK3506
- RV1103B
- RV1106
- RV1126

For the RK3506 I have been playing with recently the OP-TEE (for psci)
is instead placed at start of DRAM and SPL must be put somewhere else,
vendor place it at 63 MiB offset, I decided to put SPL at 0.5 MiB
instead of 0x0, so that could require a few more default lines :-S

Regards,
Jonas

> 
> Cheers,
> Quentin

