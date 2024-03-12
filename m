Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1855C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 22:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF00B87E57;
	Tue, 12 Mar 2024 23:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qwZmImFN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CC4587E6A; Tue, 12 Mar 2024 23:14:02 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FD1987DFF
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 23:13:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=03ce=KT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1710281627;
 bh=8RO8vhTIawAQ5dVJWbU3LXpS76KmnevcZM4STso1pJk=;
 b=qwZmImFNgGVofU82ZKdn+tu1uyI3FjhqXv53txoE8VR5VJkTXdL9KaJ28YmGbvsrBUVWIyLfr
 heHKUmiVwvOJdtVmlwMKMGqMKr7CB4yY9a+3PgInoIVcVF7vZ9lsoMuyoUxxM99CPTMtfwJMNiR
 MmO+Cvoyj6udTxtHM5jlrPX284wvE6tkiPvHbQAih86jKlb6iT/siFalIj0S8BN2n5xRxg4HNVj
 rNS0/la1587eX6OZx/jR56Uv2sz5VfLgWJKQrzyYu1vbIrrf/2JAQvD8fxw33YV5xsdRqfMCQ0s
 nvPNDY3rv5LkjitvAkarx9njlNOHMuzS3wCtK7Gn/OgA==
Message-ID: <dafe17ce-b4bd-48d4-afa7-c4a949650a21@kwiboo.se>
Date: Tue, 12 Mar 2024 23:13:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] board: rockchip: Add a common ROCK Pi 4 target
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini
 <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, FUKAUMI
 Naoki <naoki@radxa.com>, Christopher Obbard <chris.obbard@collabora.com>,
 u-boot@lists.denx.de
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-5-jonas@kwiboo.se>
 <877adf49-acc1-4f94-a509-45e25cc49f86@theobroma-systems.com>
 <dce4b1c1-ce21-41dd-ac93-dbe8b0866707@rock-chips.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <dce4b1c1-ce21-41dd-ac93-dbe8b0866707@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f0d39a0d94024497359692
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

Hi Kever,

On 2024-03-11 10:29, Kever Yang wrote:
> Hi Jonas,
> 
> On 2024/2/19 17:13, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 2/17/24 19:35, Jonas Karlman wrote:
>>> Move ROCK Pi 4 specific board code from the shared evb_rk3399 target
>>> into its own board target and update related defconfigs to use the new
>>> TARGET_ROCKPI4_RK3399 option.
>>>
>>> Also move the call to gpt_capsule_update_setup() from the weak function
>>> rk_board_late_init() into the main board_late_init() function.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>   arch/arm/mach-rockchip/board.c                | 10 +++---
>>>   arch/arm/mach-rockchip/rk3399/Kconfig         |  6 ++++
>>>   board/radxa/rockpi4-rk3399/Kconfig            | 15 +++++++++
>>>   board/radxa/rockpi4-rk3399/MAINTAINERS        | 29 +++++++++++++++++
>>>   .../rockpi4-rk3399}/Makefile                  |  2 +-
>>>   .../rockpi4-rk3399/rockpi4-rk3399.c}          | 13 ++------
>>>   board/rockchip/evb_rk3399/MAINTAINERS         | 29 -----------------
>>>   configs/rock-4c-plus-rk3399_defconfig         |  2 +-
>>>   configs/rock-4se-rk3399_defconfig             |  2 +-
>>>   configs/rock-pi-4-rk3399_defconfig            |  2 +-
>>>   configs/rock-pi-4c-rk3399_defconfig           |  2 +-
>>>   include/configs/rk3399_common.h               | 16 ----------
>>>   include/configs/rockpi4-rk3399.h              | 32 +++++++++++++++++++
>>>   13 files changed, 95 insertions(+), 65 deletions(-)
>>>   create mode 100644 board/radxa/rockpi4-rk3399/Kconfig
>>>   create mode 100644 board/radxa/rockpi4-rk3399/MAINTAINERS
>>>   rename board/{rockchip/evb_rk3399 => radxa/rockpi4-rk3399}/Makefile 
>>> (79%)
>>>   rename board/{rockchip/evb_rk3399/evb-rk3399.c => 
>>> radxa/rockpi4-rk3399/rockpi4-rk3399.c} (79%)
>>>   create mode 100644 include/configs/rockpi4-rk3399.h
>>>
>>> diff --git a/arch/arm/mach-rockchip/board.c 
>>> b/arch/arm/mach-rockchip/board.c
>>> index 4f666aee706f..dea5805c4665 100644
>>> --- a/arch/arm/mach-rockchip/board.c
>>> +++ b/arch/arm/mach-rockchip/board.c
>>> @@ -34,7 +34,7 @@
>>>   #include <asm/arch-rockchip/periph.h>
>>>   #include <power/regulator.h>
>>>   -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && 
>>> defined(CONFIG_EFI_PARTITION)
>>> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && 
>>> IS_ENABLED(CONFIG_EFI_PARTITION)
>>>     #define DFU_ALT_BUF_LEN            SZ_1K
>>>   @@ -185,10 +185,6 @@ static void gpt_capsule_update_setup(void)
>>>     __weak int rk_board_late_init(void)
>>>   {
>>> -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && 
>>> defined(CONFIG_EFI_PARTITION)
>>> -    gpt_capsule_update_setup();
>>> -#endif
>>> -
>>>       return 0;
>>>   }
>>>   @@ -196,6 +192,10 @@ int board_late_init(void)
>>>   {
>>>       setup_boot_mode();
>>>   +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && 
>>> IS_ENABLED(CONFIG_EFI_PARTITION)
>>> +    gpt_capsule_update_setup();
>>> +#endif
>>> +
>>>       return rk_board_late_init();
>>>   }
>>>   diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig 
>>> b/arch/arm/mach-rockchip/rk3399/Kconfig
>>> index d01063ac98b6..bf3600aee2ad 100644
>>> --- a/arch/arm/mach-rockchip/rk3399/Kconfig
>>> +++ b/arch/arm/mach-rockchip/rk3399/Kconfig
>>> @@ -89,6 +89,11 @@ config TARGET_ROCK960_RK3399
>>>          * 2x USB 3.0 type A, 2x USB 2.0 type A (host mode only),
>>>            1x USB 3.0 type C OTG
>>>   +config TARGET_ROCKPI4_RK3399
>>> +    bool "Radxa ROCK Pi 4 board"
>>> +    help
>>> +      Support for ROCK Pi 4 board family by Radxa.
>>> +
>>>   config TARGET_ROCKPRO64_RK3399
>>>       bool "Pine64 Rockpro64 board"
>>>       help
>>> @@ -174,6 +179,7 @@ source "board/google/gru/Kconfig"
>>>   source "board/pine64/pinebook-pro-rk3399/Kconfig"
>>>   source "board/pine64/pinephone-pro-rk3399/Kconfig"
>>>   source "board/pine64/rockpro64_rk3399/Kconfig"
>>> +source "board/radxa/rockpi4-rk3399/Kconfig"
>>>   source "board/rockchip/evb_rk3399/Kconfig"
>>>   source "board/theobroma-systems/puma_rk3399/Kconfig"
>>>   source "board/vamrs/rock960_rk3399/Kconfig"
>>> diff --git a/board/radxa/rockpi4-rk3399/Kconfig 
>>> b/board/radxa/rockpi4-rk3399/Kconfig
>>> new file mode 100644
>>> index 000000000000..d82663506b12
>>> --- /dev/null
>>> +++ b/board/radxa/rockpi4-rk3399/Kconfig
>>> @@ -0,0 +1,15 @@
>>> +if TARGET_ROCKPI4_RK3399
>>> +
>>> +config SYS_BOARD
>>> +    default "rockpi4-rk3399"
>>> +
>>> +config SYS_VENDOR
>>> +    default "radxa"
>>> +
>>> +config SYS_CONFIG_NAME
>>> +    default "rockpi4-rk3399"
>>> +
>>> +config BOARD_SPECIFIC_OPTIONS # dummy
>>> +    def_bool y
>>> +
>>> +endif
>>> diff --git a/board/radxa/rockpi4-rk3399/MAINTAINERS 
>>> b/board/radxa/rockpi4-rk3399/MAINTAINERS
>>> new file mode 100644
>>> index 000000000000..12d4f35af881
>>> --- /dev/null
>>> +++ b/board/radxa/rockpi4-rk3399/MAINTAINERS
>>> @@ -0,0 +1,29 @@
>>> +ROCK-PI-4
>>> +M:    Jagan Teki <jagan@amarulasolutions.com>
>>> +R:    Jonas Karlman <jonas@kwiboo.se>
>>> +S:    Maintained
>>> +F:    board/radxa/rockpi4-rk3399/
>>> +F:    configs/rock-pi-4-rk3399_defconfig
>>> +F:    arch/arm/dts/rk3399-rock-pi-4.dtsi
>>> +F:    arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
>>> +F:    arch/arm/dts/rk3399-rock-pi-4a.dts
>>> +F:    arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
>>> +F:    configs/rock-pi-4c-rk3399_defconfig
>>> +F:    arch/arm/dts/rk3399-rock-pi-4c.dts
>>> +F:    arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
>>> +
>>
>> Probably for a different patch but I think this would benefit from 
>> using a glob?
>>
>> +F:    arch/arm/dts/rk3399-rock-pi-4*
> 
> 
> Agree with this suggest.

I will change to use glob where it does not match files listed under
under boards in v2.

Regards,
Jonas

> 
> 
> Thanks,
> - Kever
>>
>> Cheers,
>> Quentin

