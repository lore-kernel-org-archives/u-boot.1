Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2844DC4829E
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 21:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 365358751B;
	Mon, 12 Feb 2024 22:50:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="L0CgRMtF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B70388751B; Mon, 12 Feb 2024 22:49:59 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8001E87073
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 22:49:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=15da=JW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1707774556;
 bh=kiSpf6l5IBpplUPGQaS3Emahzzz460uUhMCgQ7pIVtI=;
 b=L0CgRMtF5fdqndDj5yhjXkIIy8skmukf7Q9r5W5wao/w4XGEUF5G/Hjk+tLr3ToNw76NAgHSz
 JKBQCTtfNSdMIW6Rqu+zmefztp5ED5Kqokxbl13syJFnTda0sD6JYqlsyb3whdyhnHkfpS5et1L
 PuFNEdKl0mC0gH7blaO0Y4wDu+JoD+0kFMvnC2PnJwU5gJW1IcBTfNR2Ru7jzqBVPLQcSCqRFHb
 1AYyXCt0TjZN/ZBfswwB4SJxdRX3hiLlSXTZZCyXFEgeghp7S+RCaA7EMvwqDxQ3qAFheB9VCxH
 ksVWck8U1sBJ5AN32aRVhJkiy1Xmg5f7m+7N2j97Z8rw==
Message-ID: <e3e87e1c-f1ba-4b07-9b03-f16bea9996f3@kwiboo.se>
Date: Mon, 12 Feb 2024 22:49:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: rk3399: Update stack and bss addresses
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andy Yan
 <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Nick Xie <nick@khadas.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Deepak Das <deepakdas.linux@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>, Xiaobo Tian <peterwillcn@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Levin Du <djw@t-chip.com.cn>, Suniel
 Mahesh <sunil@amarulasolutions.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
References: <20240212005914.3512640-1-jonas@kwiboo.se>
 <20240212005914.3512640-3-jonas@kwiboo.se>
 <d8e10b17-0571-4ebc-9783-2301c429c6b3@theobroma-systems.com>
 <c3f2027d-3d87-4b71-bb13-35090640dc9a@kwiboo.se>
 <3b213c6d-9b97-48d1-8c36-4970dd1c4aa8@theobroma-systems.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <3b213c6d-9b97-48d1-8c36-4970dd1c4aa8@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65ca925cfc130462234ca35c
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

On 2024-02-12 12:51, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 2/12/24 12:08, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 2024-02-12 11:37, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 2/12/24 01:59, Jonas Karlman wrote:
>>>> With the stack and text base used by U-Boot SPL and proper on RK3399
>>>> there is a high likelihood of overlapping when U-Boot proper + FDT nears
>>>> 1 MiB in size.
>>>>
>>>> Currently the following memory layout is used:
>>>> - 0x00000000 (@0 MiB): U-Boot SPL text base
>>>> - 0x00040000 (@256 KiB): TF-A
>>>> - 0x00200000 (@2 MiB): U-Boot proper text base
>>>> - 0x00300000 (@3 MiB): U-Boot proper init stack
>>>> - 0x00400000 (@4 MiB): U-Boot SPL init stack
>>>> - 0x00400000 (@4 MiB): U-Boot SPL bss
>>>> - 0x02000000 (@64 MiB): U-Boot SPL reloc stack
>>>> - 0x08400000 (@132 MiB): optional OPTEE
>>>>
>>>> SPL load TF-A, U-Boot proper and optional OPTEE after SPL stack has
>>>> relocated, meaning that there is room for close to 2 MiB (@2-4 MiB).
>>>> However, the initial stack used by U-Boot proper is limiting the size
>>>> of U-Boot proper + FDT to below 1 MiB (@2-3 MiB).
>>>>
>>>> Instead change to use the following memory layout:
>>>> - 0x00000000 (@0 MiB): U-Boot SPL text base
>>>> - 0x00040000 (@256 KiB): TF-A
>>>> - 0x00200000 (@2 MiB): U-Boot proper text base
>>>> - 0x00400000 (@4 MiB): U-Boot SPL init stack
>>>> - 0x00800000 (@8 MiB): U-Boot proper init stack (changed)
>>>> - 0x02000000 (@32 MiB): U-Boot SPL bss (changed)
>>>> - 0x04000000 (@64 MiB): U-Boot SPL reloc stack
>>>> - 0x08400000 (@132 MiB): optional OPTEE
>>>>
>>>> This should leave room for loading and running a U-Boot proper close
>>>> to 6 MiB (@2-8 MiB) in size. When U-Boot proper has relocated is should
>>>> be possible to use @2-132 MiB and @164 MiB+ for scripts, kernel etc.
>>>>
>>>> With the moved SPL reloc stack it is also possible to use a much larger
>>>> malloc area in SPL, e.g. using default SPL_STACK_R_MALLOC_SIMPLE_LEN.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>
>>> Do we not need to update memory addresses in the environment as well?
>>
>> The addresses in environment is to my knowledge only used in U-Boot
>> proper after relocation. And at that time we should be free to use @2+
>> MiB up to somewhere close to gd ram_top/relocaddr. The optional Rockchip
>> OPTEE blobb may occupy @132-164 MiB, but I do not think loading OPTEE
>> blobs works as-is, so that may not be a big issue.
>>
> 
> Upstream OP-TEE OS seems to support RK3399, c.f. 
> https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/plat-rockchip/platform_rk3399.c
> 
> I cannot say whether it works, I have no knowledge of any of our 
> customers using it (but that predates my joining Theobroma, so maybe 
> long time customers do use it?). However, we do use an upstream-based 
> OP-TEE OS for one of our PX30-based boards, so I would say Rockchip's 
> OP-TEE OS is not the only option so we shouldn't just disregard this 
> location in RAM... especially since ramdisk_addr_r starts at 96MiB. But 
> since we're not changing that location.... people who would have this 
> issue, would have encountered the issue by now already (provided they 
> load a ramdisk bigger than 36MiB). So let's ignore that one actually :)

See my other mail, upstream OP-TEE OS seem to use @768 MiB and should
not cause issues.

Anyone trying to use Rockchip's OP-TEE OS blobs will get an error from
binman, so trying to get that working will already involve customization.

> 
>> So to my knowledge we do not need to update any of the memory addresses
>> in the environment as well.
>>
>>>
>>> scriptaddr=0x00500000
>>>
>>> This is at 5MiB if I'm not mistaken?
>>>
>>> Basically everything in include/configs/rk3399_common.h in
>>> ENV_MEM_LAYOUT_SETTINGS needs to be updated to be located after 164MiB?
>>>
>>> Did I misunderstand something? I find it weird the current values seems
>>> to be located after U-Boot SPL bss and that e.g.
>>>
>>> kernel_addr_r=0x02080000
>>>
>>> is at 32.5MiB, and with U-Boot SPL reloc stack currently at 64MiB... a
>>> 31.5+MiB kernel Image would mess up the data there? (what do we need it
>>> for BTW once in U-boot proper after relocation?).
>>
>> After SPL has jumped to TF-A and U-boot proper any memory used by SPL
>> can be overwritten/used for something else.
>>
>> My understanding is as follow:
>> - SPL always need access to bss
>> - SPL need access to init stack until it has relocated to reloc stack
>> - SPL will load FIT images using the reloc stack, at this time only
>>    SPL code, bss and reloc stack matters
>> - U-boot proper will use its init stack until it has relocated to end
>>    of memory. Until U-Boot proper has relocated it will use init stack
>> - We could use same memory position for init stack for SPL and proper,
>>    e.g. SPL_SHARES_INIT_SP_ADDR=y without any issue
>> - After U-Boot proper has relocated we should be free to use @2+ MiB
>>    up to where U-Boot proper was relocated.
>>
> 
> Not sure how Falcon boot fit in all of this and whether it makes use of 
> the environment variable (likely in the SPL binary itself).

I have never used Falcon boot myself, not sure how to even make Falcon
boot work. Guessing it should work as long as kernel is not loaded to
any offset that is in use by SPL code, bss and reloc stack. Loading to
@64+ MiB should probably be safe.

> 
> Was this from experience and/or is there some literature in U-Boot git 
> repo already? Couldn't find much in the 5min I looked for it :)

This information and insight was all learnt and gathered trying to
understand why trying to boot my ROCK 4SE did not work, yet my ROCK Pi 4
could boot.

Turned out the embedded FDT after u-boot proper overlapped with gd
and/or stack. Activating LOG_DEBUG in malloc_simple.c helped me figure
out what offsets where used at different phases:

TPL uses SRAM as stack and simple malloc area:

  U-Boot TPL 2024.04-rc1 (Feb 12 2024 - 19:41:25)
  size=30, ptr=30, limit=4000: ff8ebff0
  [...]
  size=8, ptr=22c0, limit=4000: ff8ee2a8

SPL initially uses SPL_STACK as stack and simple malloc area:

  Returning to boot ROM...
  size=30, ptr=30, limit=4000: 3fc000
  [...]
  size=8, ptr=15b0, limit=4000: 3fd5a8

Once SPL is loaded it uses SPL_STACK_R_ADDR as stack and malloc area:

  U-Boot SPL 2024.04-rc1 (Feb 12 2024 - 19:41:25 +0000)
  size=a0, ptr=a0, limit=10000: 3ff0000
  [...]
  size=a00, ptr=11c0, limit=10000: aligned to 3ff07c0
  [loading FIT]
  Jumping to U-Boot via ARM Trusted Firmware

U-Boot initially uses CUSTOM_SYS_INIT_SP_ADDR as stack and malloc area:

  INFO:    Entry point address = 0x200000
  INFO:    SPSR = 0x3c9
  size=3c8, ptr=3c8, limit=4000: 7fc000
  [...]
  size=30, ptr=1d80, limit=4000: 7fdd50
  [...]
  U-Boot 2024.04-rc1 (Feb 12 2024 - 19:41:25 +0000)

At this stage U-Boot proper should have fully been relocated.

So a lot of trial and error + guessing + digging into code helped me try
to make sense of above and what different values we can safely use :-)

> 
> Thanks for the taking the time to explain this, much appreciated.
> 
>>>
>>> Side question, what about making those values the default for RK3399
>>> instead of having it in each defconfig? This could grow quickly out of
>>> hands to move this to the Kconfig symbol itself, so not sure it's that
>>> interesting to the project, but raising this anyway.
>>
>> Agree, was trying to define these as defaults in soc Kconfig, but that
>> rearranged some values in other defconfigs so I avoided doing that in
>> this series. Also touching each defconfig helped me ping board
>> maintainers of the change.
>>
>> Hopefully a follow-up series can move these, and other options, into
>> soc Kconfig.
>>
> 
> I was more suggesting adding:
> """
> diff --git a/Kconfig b/Kconfig
> index 00ed1ecc173..b816e536674 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -249,6 +249,7 @@ config HAS_CUSTOM_SYS_INIT_SP_ADDR
>   config CUSTOM_SYS_INIT_SP_ADDR
>   	hex "Static location for the initial stack pointer"
>   	depends on HAS_CUSTOM_SYS_INIT_SP_ADDR
> +	default 0x800000 if ROCKCHIP_RK3399
>   	default TEXT_BASE if TFABOOT
> 
>   config SYS_MALLOC_F
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 6405374bcc1..08b71713b79 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -121,6 +121,7 @@ config SPL_BSS_START_ADDR
>   	default 0x81f80000 if ARCH_SUNXI && MACH_SUNIV
>   	default 0x4ff80000 if ARCH_SUNXI && !(MACH_SUN9I || MACH_SUNIV)
>   	default 0x2ff80000 if ARCH_SUNXI && MACH_SUN9I
> +	default 0x02000000 if ROCKCHIP_RK3399
>   	default 0x1000 if ARCH_ZYNQMP
> 
>   choice
> """
> 
> So that boards could still override it in defconfigs if they really want 
> to. I don't have knowledge of any other way to provide an overridable 
> default?

I was trying to define the defaults similar to how rv1126/Kconfig
currently does it. However, defining a config option with a default that
way may affect the order Kconfig options gets listed in all defconfigs.

Config fragments could possible also be used to define defaults, so I
agree, a topic for another series :-)

Regards,
Jonas

> 
> Anyway, a topic for another series, nothing requiring to block this 
> series, so:
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> Thanks,
> Quentin

