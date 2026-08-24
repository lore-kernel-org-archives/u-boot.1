Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108CAC5DF9D
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:00:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7682A80C72;
	Mon, 24 Aug 2026 16:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K2hXf7EU3Ajy; Mon, 24 Aug 2026 16:00:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787587207;
	bh=lK7JkeMdQPTAWbX+uZQahSjqiKllJMZ8jd2sPBAfb0c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n/K5edB+xxlB75Emaewy2LxZmrxW6HGyQLu/6r/0oBJDI4q4z/b6tSsVBDeHiMHHo
	 8EXXBsK6X0bns2+mI/vA0xcE/iydk9sXkh2haWwsxs4y+wS3P7nGzQ0cFguBjPmDBD
	 CB06DK5O66FaMB+2a++MPYoB8p0SGgcue42h6qmSDMopjZkhXB9WT3v1Y7HfetSNeY
	 oBMt2ZPLgK46UDRnduA6s2TMZd+SFcZmU90NlC+vooh5UszmTY+fymdDzd71ozQZZo
	 6ikdoQk4j0u1tPdIm/hCT3A5ambWnPKqUuf4/aGvaxW86/8iLeD0yqIHjUCa8U7lbY
	 THhGovPEizVKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E664B80BA8;
	Mon, 24 Aug 2026 16:00:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BC838396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A23C6060B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:00:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A0VRPs8WEb7d for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 16:00:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=d786=gs=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=f0X7K/te
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A3A5605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1787587201;
 bh=lK7JkeMdQPTAWbX+uZQahSjqiKllJMZ8jd2sPBAfb0c=;
 b=f0X7K/teLFtpcF74In+Th4SpszQq29cJXS0AY/t7PT5RGz/I5FJlGPoK5ktpAVlsQwCd2ERL9
 7A16vq42TCpDt9zBXslKJT1g58Y1cDyowguj9iQWViZFOToJc5ugAdMVEV3ZAThuTV7QuQ12VAR
 vg5UWdObYFMztSEoTWkjx/JQc50bORHJfzagUOm82+FIbTFOMRkSua2dhZHFtbNlwQlIxWkMgRM
 KKESOYMyKGbaaxV/PK96qeOuWSw0tyKqT9s4z+JIaeD+kffBX7qX8g3KYW69JFrwm7ZEeThdR1j
 dnZYD3kVzFtV32mIDQ/2FHE+HI6ODN1N8sa0EJA93JqQ==
X-Forward-Email-ID: 6a8c6a7dc8ed151058ca49ba
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.13.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <89b693b4-ac18-4807-8f1d-59e4338bae5a@kwiboo.se>
Date: Mon, 24 Aug 2026 17:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
References: <20260810211405.2837550-1-jonas@kwiboo.se>
 <a0ac40ac-1716-4451-a585-a1bdec39ce84@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <a0ac40ac-1716-4451-a585-a1bdec39ce84@0leil.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Quentin,

On 8/24/2026 3:45 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/10/26 11:14 PM, Jonas Karlman wrote:
>> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
>> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
>>
>> SRAM addressing only seems to use 14 bits, meaning that reading from
>> 0xff0e4000+ wraps around and instead reads back data at 0xff0e0000+.
>>
>> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
>> reserved region for its global data, malloc area and runtime stack.
>>
> 
> This should be its own commit.

The main purpose of this patch is to fix the overflow of TPL into lower
4 KiB of SRAM, i.e. the area used as BootROMs stack and state. Returning
to BootROM to load next image (SPL) could possible be affected depending
on TPLs use of malloc and/or its stack usage.

All changes have been kept in a single patch to make changes safe for
bisect. If we just change TPL_STACK and keep malloc size, or just change
malloc size TPL may start to accidentally overwrite areas in the BootROM
reserved area that affects BootROMs ability to load next image or the
TPL stack may start to overwrite end of TPL image.

E.g. if we only change TPL_STACK we end up with 136 byte free for
stack usage before stack can start to overwrite TPL BSS/code:

    [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
      [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
      [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
        [0xff0e1000, 0xff0e3800)      10 KiB    code
        [0xff0e3800, 0xff0e3848)      72 bytes  BSS
        [0xff0e38d0]                            stack pointer
          [0xff0e3848, 0xff0e38d0]   136 bytes  stack area
        [0xff0e38d0, 0xff0e3ed0)    1536 bytes  malloc area (unused)
        [0xff0e3ed0, 0xff0e4000)     304 bytes  global data

And if we change malloc size the TPL stack likely move closer to
BootROMs own stack. Current combo of TPL_STACK, GD_SIZE and MALLOC_F_LEN
seem to not affect BootROM but that could change if any one of them
changes independently.

> 
>> TPL on PX30/RK3326 does not have any use for the malloc area, the
>> generated GD_SIZE is typically around 304 bytes and BSS around 72 bytes.
>>
> 
> As far as I understood, this is space/size optimization and not a bug 
> fix, so should therefore be its own commit.

The only part that possible safely can be moved to its own commit is the
increase to 11 KiB for code size. Mostly wanted to keep this together
to help for future references as this patch then have all details on why
such size change was possible and could be considered safe.

> 
>> Current memory layout possibly looks something like:
>>
>>    [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>>      [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>>        [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (unused)
>>        [0xff0e08c0, 0xff0e09f0)     304 bytes  global data
>>        [0xff0e08c0]                            stack pointer
>>      [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>>        [0xff0e1000, 0xff0e3800)      10 KiB    code
>>        [0xff0e3800, 0xff0e3848)      72 bytes  BSS
>>
>> Update TPL_STACK to use the top of SRAM address and reduce MALLOC_F_LEN
>> to 0x0 to avoid overflowing global data and stack into BootROM reserved
>> region.
>>
> 
> Aren't we then missing a build-time check to make sure this is not possible?

Not sure how we could build-time check this without a guesstimate on how
deep runtime stack is needed.

> 
>> After those changes the memory layout looks something like:
>>
>>    [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>>      [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>>      [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>>        [0xff0e1000, 0xff0e3800)      10 KiB    code
>>        [0xff0e3800, 0xff0e3848)      72 bytes  BSS
>>        [0xff0e3ed0, 0xff0e4000)     304 bytes  global data
>>        [0xff0e3ed0]                            stack pointer
>>          [0xff0e3848, 0xff0e3ed0)  1672 bytes  stack area
>>
>> With these changes the TPL_MAX_SIZE can safely be extended to 11 KiB,
>> leaving enough for the stack to grow down around 648 bytes before it
>> starts to overlap into TPL or BSS.
>>
>> And with all changes the memory layout looks something like:
>>
>>    [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>>      [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>>      [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>>        [0xff0e1000, 0xff0e3c00)      11 KiB    code
>>        [0xff0e3c00, 0xff0e3c48)      72 bytes  BSS
>>        [0xff0e3ed0, 0xff0e4000)     304 bytes  global data
>>        [0xff0e3ed0]                            stack pointer
>>          [0xff0e3c48, 0xff0e3ed0)   648 bytes  stack area
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>> The overflow/wrapping was runtime validated on a RK3326 ODROID-GO Super
>> by printing out content of [0xff0e0000, 0xff0e5000] and comparing the
>> initial 4 KiB with the 16-20 KiB and the data matched 1:1.
>>
> 
> How did you test that? md.l on either address results in a Synchronous 
> Abort on my PX30 without your patch. We could also just write a random 
> pattern only at one address, and if it appears at the other address as 
> well, then you've discovered an address wrap indeed.

I used something like following to dump content as early as possible
from TPL. I used something that printed multiple columns, and compared
the output for 0x0-0x1000 and 0x4000-0x5000. Think I also tried to write
something and could see the values being reflected in both places.

void tpl_board_init(void)
{
	for (int i = 0; i < 0x5000 / sizeof(u32); i++) {
		ulong addr = SRAM_BASE + i * sizeof(u32);
		u32 val = readl(addr);
		if (!val)
			continue;
		printascii("SRAM ");
		printhex8(addr);
		printascii(": ");
		printhex8(val);
		printascii("\n");
	}
}

> 
>> Changes in v2:
>> - Mention BSS in commit message
>> - Update spelling in commit message
>> - Collect r-b tag
>>
>> With the patch "global_data: Only include driver model fields when DM is
>> enabled" [1], the stack area can grow down an additional 48 bytes before
>> it starts to overlap into TPL or BSS.
>>
>> [1] https://patch.msgid.link/20260810204828.2836359-1-jonas@kwiboo.se/
>> ---
>>   arch/arm/mach-rockchip/px30/Kconfig | 4 ++--
>>   common/spl/Kconfig.tpl              | 2 +-
>>   tools/rkcommon.c                    | 2 +-
>>   3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
>> index adba1b49a52b..cc0632cf7b2d 100644
>> --- a/arch/arm/mach-rockchip/px30/Kconfig
>> +++ b/arch/arm/mach-rockchip/px30/Kconfig
>> @@ -81,10 +81,10 @@ config TPL_TEXT_BASE
>>   	default 0xff0e1000
>>   
>>   config TPL_STACK
>> -	default 0xff0e4fff
>> +	default 0xff0e4000
>>   
>>   config TPL_SYS_MALLOC_F_LEN
>> -	default 0x600
>> +	default 0x0
> 
> Disable malloc in TPL on PX30 instead, that's actually what you want to 
> be doing and not "reserve 0 bytes for malloc". That's gated by 
> TPL_SYS_MALLOC_F.

Ideally we should disable TPL_SYS_MALLOC_F, but I thought it was too
obtrusive to change the default value for TPL_SYS_MALLOC_F as part of
this fix, so opted to just use 0x0 as size limit as there was no
difference in code for the resulting TPL binary. The only benefit of
TPL_SYS_MALLOC_F being disabled, beside being schematically more correct,
is that GD_SIZE could be around 24 bytes smaller.

I can set the TPL_SYS_MALLOC_F_LEN to 0x200 and fully drop the 10 to 11
KiB code change in a v3 if you prefer that over this?

> 
>>   
>>   config DEBUG_UART_CHANNEL
>>   	int "Mux channel to use for debug UART2/UART3"
>> diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
>> index a535b61ecd35..cdb9cb188c7c 100644
>> --- a/common/spl/Kconfig.tpl
>> +++ b/common/spl/Kconfig.tpl
>> @@ -129,7 +129,7 @@ config TPL_MAX_SIZE
>>   	default 0x2e000 if ROCKCHIP_RK3399
>>   	default 0x8000 if ROCKCHIP_RK3288 || ROCKCHIP_RV1126
>>   	default 0x7000 if ROCKCHIP_RK322X || ROCKCHIP_RK3328 || ROCKCHIP_RK3368
>> -	default 0x2800 if ROCKCHIP_PX30
>> +	default 0x2c00 if ROCKCHIP_PX30
>>   	default 0x0
>>   	help
>>   	  The maximum size (in bytes) of the TPL stage.
>> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
>> index b39777fc0607..872fc21c039d 100644
>> --- a/tools/rkcommon.c
>> +++ b/tools/rkcommon.c
>> @@ -137,7 +137,7 @@ struct spl_info {
>>   };
>>   
>>   static struct spl_info spl_infos[] = {
>> -	{ "px30", "RK33", 0x2800, false, RK_HEADER_V1 },
>> +	{ "px30", "RK33", 0x2c00, false, RK_HEADER_V1 },
> 
> Downstream actually has 0x3000 there with the justification that SRAM is 
> 16KiB and BootROM has 4KiB reserved for the stack, c.f. 3bbe0d2f9129 
> ("tools: rkcommon: add rk3326 and correct spl size for px30"), why are 
> we still 0x400 below?

I actually tried to change to use 0x3000 value in a prior patch, but
dropped the change due to a response from Kever [1].

For most RK SoCs mkimage use a hard size limit and only exclude the BROM
reserved area, and for some reason on PX30 the size limit also likely
leave room for U-Boot TPL runtime needs, e.g. BSS/malloc/stack use.

In my opinion the mkimage tool should not try to impose any limit on
what the packaged image does or require during runtime, it should just
be a simple tool that packages binary images into bootable idblock
format and only apply hard limits.

[1] https://lore.kernel.org/u-boot/c53380e2-1770-9f38-86b2-1671199e4780@rock-chips.com/

Regards,
Jonas

> 
> Cheers,
> Quentin

