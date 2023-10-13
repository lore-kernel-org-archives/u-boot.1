Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02495CDB482
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 08:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD7F886E9F;
	Fri, 13 Oct 2023 10:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XmUiYlNR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 869FE86E4B; Fri, 13 Oct 2023 10:02:38 +0200 (CEST)
Received: from mail-m121146.qiye.163.com (mail-m121146.qiye.163.com
 [115.236.121.146])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 189C186EAF
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 10:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=XmUiYlNRtwv/QItMuaLay2BqPh9JvBeWml7ysa4xMWdCraq+2vcOTFIPh0Yy1QnAvvma1F4Kd3jvYlJWGdxnWEMzyaMInXpJYYTLhZjYF/dhc6CJRNI56M1RgNY6Hl31Ek+aZf4t93LLrqAFlhBLm7G+CivCpdNoF0FvzfwI3sA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=/DoaJGwcc4ts7PkUYXz+WC9Nb+DQINKfc1EfzOahgQo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 04A37400338;
 Fri, 13 Oct 2023 16:01:49 +0800 (CST)
Message-ID: <49a711bc-e542-290a-0e48-964598847223@rock-chips.com>
Date: Fri, 13 Oct 2023 16:01:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RESEND PATCH v2] rockchip: include: asm: fix entering download
 mode rk3066
Content-Language: en-US
To: Johan Jonker <jbx6244@gmail.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
References: <decbd275-3171-89a3-abf5-cb0caae0f2b7@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <decbd275-3171-89a3-abf5-cb0caae0f2b7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxMQlYfQk0aSE8ZQk9CTRpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b280e561a2eb3kusn04a37400338
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PEk6Ezo6OTw4DAkTQy4eOS0e
 K08KCghVSlVKTUJMSkNPSkpLQ0xJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDSkhLNwY+
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


On 2023/9/19 23:28, Johan Jonker wrote:
> Keep track of the re-entries with help of the lr register.
> This binary can be re-used and called from various BROM functions.
> Only when it's called from the part that handles SPI, NAND or EMMC
> hardware it needs to early return to BROM ones.
> In download mode when it handles data on USB OTG and UART0
> this section must be skipped.
>
> Unlike newer Rockchip SoC models the rk3066 BROM code does not have built-in
> support to enter download mode on return to BROM. This binary must check
> the boot mode register for the BOOT_BROM_DOWNLOAD flag and reset if it's set.
> It then returns to BROM to the end of the function that reads boot blocks.
> >From there the BROM code goes into a download mode and waits for data
> on USB OTG and UART0.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> Note:
>    Normal boot flow is OK.
>    In download mode this binary hangs after return to BROM for unknown reasons.
>    Replace CODE471_OPTION with 30_LPDDR2_300MHz_DD.bin for now.
>
>    Could Rockchip disclose what further conditions must be met
>    in rk3066 download mode?
>
> Changed V2:
>    Move file to rk3066 specific location
>    Replace retry_counter by LR check
>    Add DNL mode return address
>    Restyle
>    Reword
> ---
>   arch/arm/include/asm/arch-rk3066/boot0.h | 77 +++++++++++++++++++++++-
>   arch/arm/mach-rockchip/Kconfig           | 17 +++++-
>   arch/arm/mach-rockchip/rk3066/Kconfig    |  6 ++
>   3 files changed, 98 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/arch-rk3066/boot0.h b/arch/arm/include/asm/arch-rk3066/boot0.h
> index 28c0fb9a4c6b..1af4b9c1d7ba 100644
> --- a/arch/arm/include/asm/arch-rk3066/boot0.h
> +++ b/arch/arm/include/asm/arch-rk3066/boot0.h
> @@ -3,6 +3,81 @@
>   #ifndef __ASM_ARCH_BOOT0_H__
>   #define __ASM_ARCH_BOOT0_H__
>
> -#include <asm/arch-rockchip/boot0.h>
> +#include <asm/arch-rockchip/boot_mode.h>
>
> +/*
> + * Execution starts on the instruction following this 4-byte header
> + * (containing the magic 'RK30'). This magic constant will be written into
> + * the final image by the rkimage tool, but we need to reserve space for it here.
> + */
> +#ifdef CONFIG_SPL_BUILD
> +	b	1f  /* if overwritten, entry-address is at the next word */
> +1:
> +#endif
> +
> +#if CONFIG_IS_ENABLED(ROCKCHIP_EARLYRETURN_TO_BROM)
> +/*
> + * Keep track of the re-entries with help of the lr register.
> + * This binary can be re-used and called from various BROM functions.
> + * Only when it's called from the part that handles SPI, NAND or EMMC
> + * hardware it needs to early return to BROM ones.
> + * In download mode when it handles data on USB OTG and UART0
> + * this section must be skipped.
> + */
> +	ldr	r3, =CONFIG_ROCKCHIP_BOOT_LR_REG
> +	cmp	lr, r3          /* if (LR != CONFIG_ROCKCHIP_BOOT_LR_REG)        */
> +	bne	reset           /*     goto reset;                               */
> +/*
> + * Unlike newer Rockchip SoC models the rk3066 BROM code does not have built-in
> + * support to enter download mode on return to BROM. This binary must check
> + * the boot mode register for the BOOT_BROM_DOWNLOAD flag and reset if it's set.
> + * It then returns to BROM to the end of the function that reads boot blocks.
> + * From there the BROM code goes into a download mode and waits for data
> + * on USB OTG and UART0.
> + */
> +	ldr	r2, =BOOT_BROM_DOWNLOAD
> +	ldr	r3, =CONFIG_ROCKCHIP_BOOT_MODE_REG
> +	ldr	r0, [r3]        /* if (readl(CONFIG_ROCKCHIP_BOOT_MODE_REG) !=   */
> +	cmp	r0, r2          /*     BOOT_BROM_DOWNLOAD) {                     */
> +	bne	early_return    /*     goto early_return;                        */
> +				/* } else {                                      */
> +	mov	r0, #0
> +	str	r0, [r3]        /*     writel(0, CONFIG_ROCKCHIP_BOOT_MODE_REG); */
> +
> +	ldr	r3, =CONFIG_ROCKCHIP_BOOT_RETURN_REG
> +	bx	r3              /*     return to CONFIG_ROCKCHIP_BOOT_RETURN_REG;*/
> +
> +early_return:
> +	bx	lr              /*  return to LR in BROM                         */
> +
> +SAVE_SP_ADDR:
> +	.word 0
> +
> +	.globl save_boot_params
> +save_boot_params:
> +	push	{r1-r12, lr}
> +	ldr	r0, =SAVE_SP_ADDR
> +	str	sp, [r0]
> +	b	save_boot_params_ret
> +
> +	.globl back_to_bootrom
> +back_to_bootrom:
> +	ldr	r0, =SAVE_SP_ADDR
> +	ldr	sp, [r0]
> +	mov	r0, #0
> +	pop	{r1-r12, pc}
> +#endif
> +
> +#if (defined(CONFIG_SPL_BUILD))
> +/* U-Boot proper of armv7 does not need this */
> +	b reset
> +#endif
> +
> +/*
> + * For armv7, the addr '_start' will be used as vector start address
> + * and is written to the VBAR register, which needs to aligned to 0x20.
> + */
> +	.align(5), 0x0
> +_start:
> +	ARM_VECTORS
>   #endif
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 07b5595dac8c..84a2f0d5ff48 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -402,7 +402,7 @@ config SPL_ROCKCHIP_BACK_TO_BROM
>   config TPL_ROCKCHIP_BACK_TO_BROM
>   	bool "TPL returns to bootrom"
>   	default y
> -	select ROCKCHIP_BROM_HELPER
> +	select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
>   	select TPL_BOOTROM_SUPPORT
>   	depends on TPL
>   	help
> @@ -448,6 +448,21 @@ config ROCKCHIP_BOOT_MODE_REG
>   	  The Soc will enter to different boot mode(defined in asm/arch-rockchip/boot_mode.h)
>   	  according to the value from this register.
>
> +config ROCKCHIP_BOOT_LR_REG
> +	hex "Rockchip boot early return LR address"
> +	depends on TPL_ROCKCHIP_EARLYRETURN_TO_BROM || SPL_ROCKCHIP_EARLYRETURN_TO_BROM
> +	help
> +	  With ROCKCHIP_EARLYRETURN_TO_BROM enabled this LR address is
> +	  used to keep track of the re-entries.
> +
> +config ROCKCHIP_BOOT_RETURN_REG
> +	hex "Rockchip download mode return address"
> +	depends on TPL_ROCKCHIP_EARLYRETURN_TO_BROM || SPL_ROCKCHIP_EARLYRETURN_TO_BROM
> +	help
> +	  Rockchip SoC models without built-in support to enter
> +	  download mode after early return to BROM code use a SoC
> +	  specific return address in BROM.
> +
>   config ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON
>   	bool "Disable device boot on power plug-in"
>   	depends on PMIC_RK8XX
> diff --git a/arch/arm/mach-rockchip/rk3066/Kconfig b/arch/arm/mach-rockchip/rk3066/Kconfig
> index 95d7fc8a2917..3721f7469a9e 100644
> --- a/arch/arm/mach-rockchip/rk3066/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3066/Kconfig
> @@ -10,6 +10,12 @@ config TARGET_MK808
>   config ROCKCHIP_BOOT_MODE_REG
>   	default 0x20004040
>
> +config ROCKCHIP_BOOT_LR_REG
> +	default 0x00001058
> +
> +config ROCKCHIP_BOOT_RETURN_REG
> +	default 0x00001100
> +
>   config SYS_SOC
>   	default "rk3066"
>
> --
> 2.39.2
>
