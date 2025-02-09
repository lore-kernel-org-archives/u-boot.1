Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A0CC0219E
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 17:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB0E180141;
	Sun,  9 Feb 2025 18:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kwBZ3q2d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B791480836; Sun,  9 Feb 2025 18:59:39 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11113800B3
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 18:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e522=VB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1739123975;
 bh=pBAoFVTFhTi76tkKWyxDhE3dGWoRzdxDgDf/3kNxcAE=;
 b=kwBZ3q2d69BypCNJJu5P8pmovEg3nxSRjD9+rMix53ctb8wWfWJ33NfjFKjRdd0ryTQP3S6Fg
 +3ZA3QkcBjyp1ZhCyFjEW7fKtRPJ8HaOp4AmFDuhX03hijboRYzf+UUKb4UfYECQ4D9pL1kJbv9
 dLFzzNnN0SSD4PbDcgMAgUCCN+SCy7fSgLt65lew9czXTSQTB5WxYQwRVC8/I6ATwT8Xzbrewam
 MC5ZCXhHnMxEoimIbmkuYlJSulVXMUKz9OQIcSALMLg+NMeQGZhhDfS8qYwGignXbhEd2NzNeiD
 TD3Ot2F6pphWQiJs1X6cB5lJdU9vQxaz0Bn6BsxzhEtg==
X-Forward-Email-ID: 67a8ed03c8c41b55c9d7cf25
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <2b224b73-c6fc-4a0e-982f-ee268cb80860@kwiboo.se>
Date: Sun, 9 Feb 2025 18:59:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] rockchip: Improve ARMv7 support for
 ROCKCHIP_COMMON_STACK_ADDR
To: Alex Bee <knaerzche@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250126234838.561065-1-jonas@kwiboo.se>
 <20250126234838.561065-3-jonas@kwiboo.se>
 <4e6629cf-9685-4b91-800e-82a9df30d5e3@gmail.com>
 <f52283be-6119-4682-a41d-efff377365ab@kwiboo.se>
 <4fce2690-bb35-4e1e-84fc-91564b7d78e8@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <4fce2690-bb35-4e1e-84fc-91564b7d78e8@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Alex,

On 2025-02-05 20:02, Alex Bee wrote:
> Hi Jonas,
> 
>> Hi Alex,
>>
>> On 2025-01-27 19:59, Alex Bee wrote:
>>> Hi Jonas,
>>>
>>> thanks for working on this.  Please see one comment below.
>>>
>>> Am 27.01.25 um 00:48 schrieb Jonas Karlman:
>>>> A few Rockchip ARMv7 SoCs use 0x60000000 as DRAM base address instead of
>>>> the more common 0x0 DRAM base address used on AArch64 SoCs.
>>>>
>>>> Add default options that should work for these ARMv7 SoCs. Same offsets
>>>> as before are used, just below 64 MiB. Hex values have also been padded
>>>> to improve alignment.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>>    arch/arm/mach-rockchip/Kconfig | 35 +++++++++++++++++++++++-----------
>>>>    1 file changed, 24 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
>>>> index 5aa9e0f1af3b..da20d3233fe3 100644
>>>> --- a/arch/arm/mach-rockchip/Kconfig
>>>> +++ b/arch/arm/mach-rockchip/Kconfig
>>>> @@ -637,40 +637,53 @@ source "arch/arm/mach-rockchip/rv1126/Kconfig"
>>>>    if ROCKCHIP_COMMON_STACK_ADDR && SPL_SHARES_INIT_SP_ADDR
>>>>    
>>>>    config CUSTOM_SYS_INIT_SP_ADDR
>>>> -	default 0x3f00000
>>>> +	default 0x63f00000 if SPL_TEXT_BASE = 0x60000000
>>>> +	default 0x03f00000 if SPL_TEXT_BASE = 0x00000000
>>>>    
>>>>    config SYS_MALLOC_F_LEN
>>>> -	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
>>>> +	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
>>>> +	default 0x10000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>>>>    
>>>>    config SPL_SYS_MALLOC_F_LEN
>>>> -	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
>>>> +	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
>>>> +	default 0x8000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>>>>    
>>>>    config TPL_SYS_MALLOC_F_LEN
>>>> -	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
>>>> +	default 0x0800 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
>>>> +	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>>>>    
>>>>    config TEXT_BASE
>>>> -	default 0x00200000 if ARM64
>>>> +	default 0x60200000 if SPL_TEXT_BASE = 0x60000000
>>>> +	default 0x00200000 if SPL_TEXT_BASE = 0x00000000
>>>>    
>>>>    config SPL_TEXT_BASE
>>>> -	default 0x0 if ARM64
>>>> +	default 0x60000000 if ROCKCHIP_RK3036 || ROCKCHIP_RK3066 || \
>>>> +			      ROCKCHIP_RK3128 || ROCKCHIP_RK3188 || \
>>> I'm not sure if adding RK3036 and RK3188 is correct at this point. Both use
>>> SPL (without TPL) currently for DRAM initialization and thus need their
>>> CFG_IRAM_BASE as SPL_TEXT_BASE.
>> I think it should be safe to add these default values here, any value
>> defined in board defconfig or soc Kconfig will take precedence.
>>
>> The RK3036 and RK3188 boards use SPL back-to-brom to load U-Boot proper,
>> if someone wants to move these board to use similar TPL+SPL+FIT this
>> will prepare for such occasion.
>>
>> Having them included here also prevents a possible issue in case someone
>> in the future where to add a select/imply ROCKCHIP_COMMON_STACK_ADDR for
>> these SoCs, else they may fallback to wrongly use 0x0.
>>
>> Do you want me to drop them in a v2?
>>
>> Regards,
>> Jonas
> it is currently "safe" as it would of course be overwritten by the
> currently existing defconfigs. But if someone dares to use this symbol for
> a downstream/new board for either of these two SoCs, things go south.
> 
> How about adding some "extra security" by making it
>      depends on TPL || ROCKCHIP_EXTERNAL_TPL
> 
> As I mentioned off-list: I'm not sure if any of these
> XXX_ROCKCHIP_COMMON_BORD belong here: I understand the goal of syncing
> configurations for the different SoCs, but I'm not sure if a symbol called
> ROCKCHIP_COMMON_STACK_ADDR is the right place for it (plus the
> XXX_ROCKCHIP_COMMON_BORD symbols (should) have no dependency on using
> ROCKCHIP_COMMON_STACK_ADDR, neither code-wise nor from semantics).

In principle I fully agree, and TPL_ROCKCHIP_COMMON_BOARD was moved away
from being implied in first patch in this series. However, I left the
implied SPL symbol as-is.

Adding the "depends on TPL ..." could be something for a v2.

The original intent of this symbol was to help move boards and SoCs that
use common TPL+SPL to use safer addresses without having to affect all
boards/SoCs all at once.

With this series it should be simple to move the remaining ARMv7 SoCs to
use similar TPL/ROCKCHIP_EXTERNAL_TPL + SPL separation without having
to worry about picking new SPL stack addresses in DRAM.

The Kconfig symbol is hidden from menuconfig so I do not expect end
users to easily break anything by accidentally enabling this symbol.

I was hoping to be able to send a migration series for RK322x this
weekend but unfortunately, I managed to brick the new RK3228A box I
picked up after only a few hours, the box uses an eMCP and I have not
found an exposed mmc clk pin yet, a new box should arrive soon :-)

Regards,
Jonas

> 
> Regards,
> Alex
> 
>>> Regards,
>>>
>>> Alex
>>>
>>>> +			      ROCKCHIP_RK322X || ROCKCHIP_RV1108
>>>> +	default 0x00000000
>>>>    
>>>>    config SPL_HAS_BSS_LINKER_SECTION
>>>>    	default y if ARM64
>>>>    
>>>>    config SPL_BSS_START_ADDR
>>>> -	default 0x3f80000
>>>> +	default 0x63f80000 if SPL_TEXT_BASE = 0x60000000
>>>> +	default 0x03f80000 if SPL_TEXT_BASE = 0x00000000
>>>>    
>>>>    config SPL_BSS_MAX_SIZE
>>>> -	default 0x8000 if SPL_BSS_START_ADDR = 0x3f80000
>>>> +	default 0x8000 if SPL_BSS_START_ADDR = 0x63f80000
>>>> +	default 0x8000 if SPL_BSS_START_ADDR = 0x03f80000
>>>>    
>>>>    config SPL_STACK_R
>>>> -	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
>>>> +	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
>>>> +	default y if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>>>>    
>>>>    config SPL_STACK_R_ADDR
>>>> -	default 0x3e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x3f00000
>>>> +	default 0x63e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x63f00000
>>>> +	default 0x03e00000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
>>>>    
>>>>    config SPL_STACK_R_MALLOC_SIMPLE_LEN
>>>> -	default 0x200000 if SPL_STACK_R_ADDR = 0x3e00000
>>>> +	default 0x200000 if SPL_STACK_R_ADDR = 0x63e00000
>>>> +	default 0x200000 if SPL_STACK_R_ADDR = 0x03e00000
>>>>    
>>>>    endif
>>>>    endif

