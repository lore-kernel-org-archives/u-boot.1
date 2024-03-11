Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E382C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F115D87E13;
	Mon, 11 Mar 2024 10:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="kwec9TgM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F0987F17; Mon, 11 Mar 2024 10:30:14 +0100 (CET)
Received: from mail-m127228.xmail.ntesmail.com
 (mail-m127228.xmail.ntesmail.com [115.236.127.228])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DDA787C68
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=kwec9TgMZHPgphGLr5LmMgicRT09P7bF0X7y8SQLAXiDRjYn7dMGV+wg2jzaUUMbmlABfiP7qPT8zdaNzOIyrBulLk16zMevP7v3Qna2/DlaRxI4WlKc4pUaKWSjpssD1Rpo2Wb6g6u2l+dZzYumFmQ8VP3+eLEEs1B7TvhGfFs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=JT1reU3tbSfLg+fzzVH1lKpf+KZD7azuT0uP4xdrfzg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 3D7919003CA;
 Mon, 11 Mar 2024 17:29:57 +0800 (CST)
Message-ID: <dce4b1c1-ce21-41dd-ac93-dbe8b0866707@rock-chips.com>
Date: Mon, 11 Mar 2024 17:29:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] board: rockchip: Add a common ROCK Pi 4 target
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>
Cc: u-boot@lists.denx.de
References: <20240217183610.2621132-1-jonas@kwiboo.se>
 <20240217183610.2621132-5-jonas@kwiboo.se>
 <877adf49-acc1-4f94-a509-45e25cc49f86@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <877adf49-acc1-4f94-a509-45e25cc49f86@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0sfH1ZJTExDGkpLSUgfGkNVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8e2cd8eccd03a9kunm3d7919003ca
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBQ6KRw*QzMJNDAWPCI*HE8W
 LiNPCU1VSlVKTEpLSk9CSEJDS0pDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMTUxLNwY+
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

Hi Jonas,

On 2024/2/19 17:13, Quentin Schulz wrote:
> Hi Jonas,
>
> On 2/17/24 19:35, Jonas Karlman wrote:
>> Move ROCK Pi 4 specific board code from the shared evb_rk3399 target
>> into its own board target and update related defconfigs to use the new
>> TARGET_ROCKPI4_RK3399 option.
>>
>> Also move the call to gpt_capsule_update_setup() from the weak function
>> rk_board_late_init() into the main board_late_init() function.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/mach-rockchip/board.c                | 10 +++---
>>   arch/arm/mach-rockchip/rk3399/Kconfig         |  6 ++++
>>   board/radxa/rockpi4-rk3399/Kconfig            | 15 +++++++++
>>   board/radxa/rockpi4-rk3399/MAINTAINERS        | 29 +++++++++++++++++
>>   .../rockpi4-rk3399}/Makefile                  |  2 +-
>>   .../rockpi4-rk3399/rockpi4-rk3399.c}          | 13 ++------
>>   board/rockchip/evb_rk3399/MAINTAINERS         | 29 -----------------
>>   configs/rock-4c-plus-rk3399_defconfig         |  2 +-
>>   configs/rock-4se-rk3399_defconfig             |  2 +-
>>   configs/rock-pi-4-rk3399_defconfig            |  2 +-
>>   configs/rock-pi-4c-rk3399_defconfig           |  2 +-
>>   include/configs/rk3399_common.h               | 16 ----------
>>   include/configs/rockpi4-rk3399.h              | 32 +++++++++++++++++++
>>   13 files changed, 95 insertions(+), 65 deletions(-)
>>   create mode 100644 board/radxa/rockpi4-rk3399/Kconfig
>>   create mode 100644 board/radxa/rockpi4-rk3399/MAINTAINERS
>>   rename board/{rockchip/evb_rk3399 => radxa/rockpi4-rk3399}/Makefile 
>> (79%)
>>   rename board/{rockchip/evb_rk3399/evb-rk3399.c => 
>> radxa/rockpi4-rk3399/rockpi4-rk3399.c} (79%)
>>   create mode 100644 include/configs/rockpi4-rk3399.h
>>
>> diff --git a/arch/arm/mach-rockchip/board.c 
>> b/arch/arm/mach-rockchip/board.c
>> index 4f666aee706f..dea5805c4665 100644
>> --- a/arch/arm/mach-rockchip/board.c
>> +++ b/arch/arm/mach-rockchip/board.c
>> @@ -34,7 +34,7 @@
>>   #include <asm/arch-rockchip/periph.h>
>>   #include <power/regulator.h>
>>   -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && 
>> defined(CONFIG_EFI_PARTITION)
>> +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && 
>> IS_ENABLED(CONFIG_EFI_PARTITION)
>>     #define DFU_ALT_BUF_LEN            SZ_1K
>>   @@ -185,10 +185,6 @@ static void gpt_capsule_update_setup(void)
>>     __weak int rk_board_late_init(void)
>>   {
>> -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && 
>> defined(CONFIG_EFI_PARTITION)
>> -    gpt_capsule_update_setup();
>> -#endif
>> -
>>       return 0;
>>   }
>>   @@ -196,6 +192,10 @@ int board_late_init(void)
>>   {
>>       setup_boot_mode();
>>   +#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && 
>> IS_ENABLED(CONFIG_EFI_PARTITION)
>> +    gpt_capsule_update_setup();
>> +#endif
>> +
>>       return rk_board_late_init();
>>   }
>>   diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig 
>> b/arch/arm/mach-rockchip/rk3399/Kconfig
>> index d01063ac98b6..bf3600aee2ad 100644
>> --- a/arch/arm/mach-rockchip/rk3399/Kconfig
>> +++ b/arch/arm/mach-rockchip/rk3399/Kconfig
>> @@ -89,6 +89,11 @@ config TARGET_ROCK960_RK3399
>>          * 2x USB 3.0 type A, 2x USB 2.0 type A (host mode only),
>>            1x USB 3.0 type C OTG
>>   +config TARGET_ROCKPI4_RK3399
>> +    bool "Radxa ROCK Pi 4 board"
>> +    help
>> +      Support for ROCK Pi 4 board family by Radxa.
>> +
>>   config TARGET_ROCKPRO64_RK3399
>>       bool "Pine64 Rockpro64 board"
>>       help
>> @@ -174,6 +179,7 @@ source "board/google/gru/Kconfig"
>>   source "board/pine64/pinebook-pro-rk3399/Kconfig"
>>   source "board/pine64/pinephone-pro-rk3399/Kconfig"
>>   source "board/pine64/rockpro64_rk3399/Kconfig"
>> +source "board/radxa/rockpi4-rk3399/Kconfig"
>>   source "board/rockchip/evb_rk3399/Kconfig"
>>   source "board/theobroma-systems/puma_rk3399/Kconfig"
>>   source "board/vamrs/rock960_rk3399/Kconfig"
>> diff --git a/board/radxa/rockpi4-rk3399/Kconfig 
>> b/board/radxa/rockpi4-rk3399/Kconfig
>> new file mode 100644
>> index 000000000000..d82663506b12
>> --- /dev/null
>> +++ b/board/radxa/rockpi4-rk3399/Kconfig
>> @@ -0,0 +1,15 @@
>> +if TARGET_ROCKPI4_RK3399
>> +
>> +config SYS_BOARD
>> +    default "rockpi4-rk3399"
>> +
>> +config SYS_VENDOR
>> +    default "radxa"
>> +
>> +config SYS_CONFIG_NAME
>> +    default "rockpi4-rk3399"
>> +
>> +config BOARD_SPECIFIC_OPTIONS # dummy
>> +    def_bool y
>> +
>> +endif
>> diff --git a/board/radxa/rockpi4-rk3399/MAINTAINERS 
>> b/board/radxa/rockpi4-rk3399/MAINTAINERS
>> new file mode 100644
>> index 000000000000..12d4f35af881
>> --- /dev/null
>> +++ b/board/radxa/rockpi4-rk3399/MAINTAINERS
>> @@ -0,0 +1,29 @@
>> +ROCK-PI-4
>> +M:    Jagan Teki <jagan@amarulasolutions.com>
>> +R:    Jonas Karlman <jonas@kwiboo.se>
>> +S:    Maintained
>> +F:    board/radxa/rockpi4-rk3399/
>> +F:    configs/rock-pi-4-rk3399_defconfig
>> +F:    arch/arm/dts/rk3399-rock-pi-4.dtsi
>> +F:    arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
>> +F:    arch/arm/dts/rk3399-rock-pi-4a.dts
>> +F:    arch/arm/dts/rk3399-rock-pi-4a-u-boot.dtsi
>> +F:    configs/rock-pi-4c-rk3399_defconfig
>> +F:    arch/arm/dts/rk3399-rock-pi-4c.dts
>> +F:    arch/arm/dts/rk3399-rock-pi-4c-u-boot.dtsi
>> +
>
> Probably for a different patch but I think this would benefit from 
> using a glob?
>
> +F:    arch/arm/dts/rk3399-rock-pi-4*


Agree with this suggest.


Thanks,
- Kever
>
> Cheers,
> Quentin
