Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83950C25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 09:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EFDF876D4;
	Fri, 27 Oct 2023 11:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bAGYU69S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB28B876E0; Fri, 27 Oct 2023 11:47:30 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35D5C876DA
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 11:47:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so1372342f8f.3
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 02:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698400047; x=1699004847; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j7dcZAGspIVMbGeJuvHx0O1gLhtY3cOVMCJfhe9TEO0=;
 b=bAGYU69S2lU2dgp4hPaNEzoPdJvPjdk44mf4LjO9q5R908xmXzOqMnu3e4//zWS8Nc
 AT2Qzz3+U0zl4qR0MX/USwCzgVq6Ny2aA3Vwe4Vmh+nAZ3uZYAZPDgl/OZwva3+kxxPr
 UoTtas0oNI9pCgS858WL9jan2E/e/qREODrfRHdPfVboSJBlv5WPXskurFqoh1xp2mJi
 F3tHbywt99gy928rYucxUFrmdaxyQI7IOqUaITSUj+t8Hd/c8yHduRBGfDSKPTsg0bZM
 okRNy0q4RB4lSk2mIFNzQ95DE3gSmBGPPRIhXhWt/8pf6/cC4/dHiG2Sd5KENGuWy0Q9
 i3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698400047; x=1699004847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j7dcZAGspIVMbGeJuvHx0O1gLhtY3cOVMCJfhe9TEO0=;
 b=fZqQYZVhb0Y2YRnGHKOPWJqaMyasOipD9PZS2+Qfw45XWBCDTsE9wNhDrjnDwKg08z
 XsmnMoqa1U6mj/a6IIgbD+mlCtcjZftpJc59w5vnUK8bqG9/IsEVGhsl8ijqkEGGRo8d
 7xBCfQS5Y2UxBXLKuaA5N66jtn6WvLJraaQupfaHZ86bUx6hU+wIAKUP7jbNER5IuZ/0
 +KqTOM/BBH3tsAIcSFcLRGtlFMJJug2fquBm7bW6cOHzT+x9iJk+LMbRvvhzDPRGFDUL
 QJ8vCQGAZG3U3RooKzGiGQIbNlZhs18n6hwz3jKq6If9rKfLAJdQE0I8bxKOgu9Yvd1C
 mrWg==
X-Gm-Message-State: AOJu0Yz8AP1jsAPiILHdvx9+EvWH00HwEV2E5jSetqpvaKHkhVZXfWJ9
 6RI0B6ukF2QJb9TP8HeO2AgJ55bKJFY=
X-Google-Smtp-Source: AGHT+IGKd9rzmXYcMq9RY+DU1OgHn1/z3DWfTh9ngSScIhAjiTJhkgcNCIPb1eoul+GjrvW55xx/+A==
X-Received: by 2002:adf:f4d1:0:b0:32d:a2c4:18bf with SMTP id
 h17-20020adff4d1000000b0032da2c418bfmr1676279wrp.59.1698400047183; 
 Fri, 27 Oct 2023 02:47:27 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a5d4fcb000000b00317a04131c5sm1386476wrw.57.2023.10.27.02.47.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 02:47:26 -0700 (PDT)
Message-ID: <d058e2a4-15fa-c38e-2a35-d5476cc0c8f5@gmail.com>
Date: Fri, 27 Oct 2023 11:47:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH v2] rockchip: include: asm: fix entering download
 mode rk3066
To: Tom Rini <trini@konsulko.com>, sjg@chromium.org
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
References: <decbd275-3171-89a3-abf5-cb0caae0f2b7@gmail.com>
 <2745d73f-ecd4-4d3c-8ee9-5c0aed9e5c40@rock-chips.com>
Content-Language: en-US
From: Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <2745d73f-ecd4-4d3c-8ee9-5c0aed9e5c40@rock-chips.com>
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

Hi Tom, Simon,

The test for my patch ends with an error that is reported on various locations on the internet.
My knowledge is limited here. Could you have a look?

Thanks,

Johan

====

rockchip: include: asm: fix entering download mode rk3066 
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/18283

Error log:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/jobs/720456

Error message:
Cleaning up project directory and file based variables 00:03
ERROR: Job failed: exit code 100

===

Reported examples elsewhere:

Runner stops at random place with "Cleaning up project directory and file based variables" even if there is no error
https://gitlab.com/gitlab-org/gitlab/-/issues/373265

Gitlab CI/CD fails while "Cleaning up project directory and file based variables" with "ERROR: Job failed: exit code 1"
https://stackoverflow.com/questions/69411379/gitlab-ci-cd-fails-while-cleaning-up-project-directory-and-file-based-variables

On 10/24/23 11:16, Kever Yang wrote:
> Hi Johan,
> 
>     I don't have a detail build error message, but this patch do cause the 32bit ARM platforms build fail in[1];
> 
> Hi Tom,
> 
>     Could you help the take a look, what's the error happen in this case?
> 
> 
> Thanks,
> - Kever
> 
> [1] https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/jobs/719987
> 
> On 2023/9/19 23:28, Johan Jonker wrote:
>> Keep track of the re-entries with help of the lr register.
>> This binary can be re-used and called from various BROM functions.
>> Only when it's called from the part that handles SPI, NAND or EMMC
>> hardware it needs to early return to BROM ones.
>> In download mode when it handles data on USB OTG and UART0
>> this section must be skipped.
>>
>> Unlike newer Rockchip SoC models the rk3066 BROM code does not have built-in
>> support to enter download mode on return to BROM. This binary must check
>> the boot mode register for the BOOT_BROM_DOWNLOAD flag and reset if it's set.
>> It then returns to BROM to the end of the function that reads boot blocks.
>> >From there the BROM code goes into a download mode and waits for data
>> on USB OTG and UART0.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>
>> Note:
>>    Normal boot flow is OK.
>>    In download mode this binary hangs after return to BROM for unknown reasons.
>>    Replace CODE471_OPTION with 30_LPDDR2_300MHz_DD.bin for now.
>>
>>    Could Rockchip disclose what further conditions must be met
>>    in rk3066 download mode?
>>
>> Changed V2:
>>    Move file to rk3066 specific location
>>    Replace retry_counter by LR check
>>    Add DNL mode return address
>>    Restyle
>>    Reword
>> ---
>>   arch/arm/include/asm/arch-rk3066/boot0.h | 77 +++++++++++++++++++++++-
>>   arch/arm/mach-rockchip/Kconfig           | 17 +++++-
>>   arch/arm/mach-rockchip/rk3066/Kconfig    |  6 ++
>>   3 files changed, 98 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/arch-rk3066/boot0.h b/arch/arm/include/asm/arch-rk3066/boot0.h
>> index 28c0fb9a4c6b..1af4b9c1d7ba 100644
>> --- a/arch/arm/include/asm/arch-rk3066/boot0.h
>> +++ b/arch/arm/include/asm/arch-rk3066/boot0.h
>> @@ -3,6 +3,81 @@
>>   #ifndef __ASM_ARCH_BOOT0_H__
>>   #define __ASM_ARCH_BOOT0_H__
>>
>> -#include <asm/arch-rockchip/boot0.h>
>> +#include <asm/arch-rockchip/boot_mode.h>
>>
>> +/*
>> + * Execution starts on the instruction following this 4-byte header
>> + * (containing the magic 'RK30'). This magic constant will be written into
>> + * the final image by the rkimage tool, but we need to reserve space for it here.
>> + */
>> +#ifdef CONFIG_SPL_BUILD
>> +    b    1f  /* if overwritten, entry-address is at the next word */
>> +1:
>> +#endif
>> +
>> +#if CONFIG_IS_ENABLED(ROCKCHIP_EARLYRETURN_TO_BROM)
>> +/*
>> + * Keep track of the re-entries with help of the lr register.
>> + * This binary can be re-used and called from various BROM functions.
>> + * Only when it's called from the part that handles SPI, NAND or EMMC
>> + * hardware it needs to early return to BROM ones.
>> + * In download mode when it handles data on USB OTG and UART0
>> + * this section must be skipped.
>> + */
>> +    ldr    r3, =CONFIG_ROCKCHIP_BOOT_LR_REG
>> +    cmp    lr, r3          /* if (LR != CONFIG_ROCKCHIP_BOOT_LR_REG)        */
>> +    bne    reset           /*     goto reset;                               */
>> +/*
>> + * Unlike newer Rockchip SoC models the rk3066 BROM code does not have built-in
>> + * support to enter download mode on return to BROM. This binary must check
>> + * the boot mode register for the BOOT_BROM_DOWNLOAD flag and reset if it's set.
>> + * It then returns to BROM to the end of the function that reads boot blocks.
>> + * From there the BROM code goes into a download mode and waits for data
>> + * on USB OTG and UART0.
>> + */
>> +    ldr    r2, =BOOT_BROM_DOWNLOAD
>> +    ldr    r3, =CONFIG_ROCKCHIP_BOOT_MODE_REG
>> +    ldr    r0, [r3]        /* if (readl(CONFIG_ROCKCHIP_BOOT_MODE_REG) !=   */
>> +    cmp    r0, r2          /*     BOOT_BROM_DOWNLOAD) {                     */
>> +    bne    early_return    /*     goto early_return;                        */
>> +                /* } else {                                      */
>> +    mov    r0, #0
>> +    str    r0, [r3]        /*     writel(0, CONFIG_ROCKCHIP_BOOT_MODE_REG); */
>> +
>> +    ldr    r3, =CONFIG_ROCKCHIP_BOOT_RETURN_REG
>> +    bx    r3              /*     return to CONFIG_ROCKCHIP_BOOT_RETURN_REG;*/
>> +
>> +early_return:
>> +    bx    lr              /*  return to LR in BROM                         */
>> +
>> +SAVE_SP_ADDR:
>> +    .word 0
>> +
>> +    .globl save_boot_params
>> +save_boot_params:
>> +    push    {r1-r12, lr}
>> +    ldr    r0, =SAVE_SP_ADDR
>> +    str    sp, [r0]
>> +    b    save_boot_params_ret
>> +
>> +    .globl back_to_bootrom
>> +back_to_bootrom:
>> +    ldr    r0, =SAVE_SP_ADDR
>> +    ldr    sp, [r0]
>> +    mov    r0, #0
>> +    pop    {r1-r12, pc}
>> +#endif
>> +
>> +#if (defined(CONFIG_SPL_BUILD))
>> +/* U-Boot proper of armv7 does not need this */
>> +    b reset
>> +#endif
>> +
>> +/*
>> + * For armv7, the addr '_start' will be used as vector start address
>> + * and is written to the VBAR register, which needs to aligned to 0x20.
>> + */
>> +    .align(5), 0x0
>> +_start:
>> +    ARM_VECTORS
>>   #endif
>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
>> index 07b5595dac8c..84a2f0d5ff48 100644
>> --- a/arch/arm/mach-rockchip/Kconfig
>> +++ b/arch/arm/mach-rockchip/Kconfig
>> @@ -402,7 +402,7 @@ config SPL_ROCKCHIP_BACK_TO_BROM
>>   config TPL_ROCKCHIP_BACK_TO_BROM
>>       bool "TPL returns to bootrom"
>>       default y
>> -    select ROCKCHIP_BROM_HELPER
>> +    select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
>>       select TPL_BOOTROM_SUPPORT
>>       depends on TPL
>>       help
>> @@ -448,6 +448,21 @@ config ROCKCHIP_BOOT_MODE_REG
>>         The Soc will enter to different boot mode(defined in asm/arch-rockchip/boot_mode.h)
>>         according to the value from this register.
>>
>> +config ROCKCHIP_BOOT_LR_REG
>> +    hex "Rockchip boot early return LR address"
>> +    depends on TPL_ROCKCHIP_EARLYRETURN_TO_BROM || SPL_ROCKCHIP_EARLYRETURN_TO_BROM
>> +    help
>> +      With ROCKCHIP_EARLYRETURN_TO_BROM enabled this LR address is
>> +      used to keep track of the re-entries.
>> +
>> +config ROCKCHIP_BOOT_RETURN_REG
>> +    hex "Rockchip download mode return address"
>> +    depends on TPL_ROCKCHIP_EARLYRETURN_TO_BROM || SPL_ROCKCHIP_EARLYRETURN_TO_BROM
>> +    help
>> +      Rockchip SoC models without built-in support to enter
>> +      download mode after early return to BROM code use a SoC
>> +      specific return address in BROM.
>> +
>>   config ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON
>>       bool "Disable device boot on power plug-in"
>>       depends on PMIC_RK8XX
>> diff --git a/arch/arm/mach-rockchip/rk3066/Kconfig b/arch/arm/mach-rockchip/rk3066/Kconfig
>> index 95d7fc8a2917..3721f7469a9e 100644
>> --- a/arch/arm/mach-rockchip/rk3066/Kconfig
>> +++ b/arch/arm/mach-rockchip/rk3066/Kconfig
>> @@ -10,6 +10,12 @@ config TARGET_MK808
>>   config ROCKCHIP_BOOT_MODE_REG
>>       default 0x20004040
>>
>> +config ROCKCHIP_BOOT_LR_REG
>> +    default 0x00001058
>> +
>> +config ROCKCHIP_BOOT_RETURN_REG
>> +    default 0x00001100
>> +
>>   config SYS_SOC
>>       default "rk3066"
>>
>> -- 
>> 2.39.2
>>
