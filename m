Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971A7C61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 492AA4080C;
	Thu, 27 Aug 2026 19:50:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9NqhtLXMAq84; Thu, 27 Aug 2026 19:50:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860240;
	bh=bilWJIlHktWoEZjHwyNxhF4sv+bJkyHheRkebupSmqk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vEE/kRAzFUa8jjvVXsY8+qRQrIGXinP2f74HnLBqrqdo0DoyKY+8Ut3EieF4iUdx1
	 6K/9LMt2rdI/2U6n1wRNQFAZI27AP/ql1RYOISJA6Jq8kvjm7/hHn4BcmWFXb3/ZD0
	 Wb4tjD8DNs2cndSc7l9zeFs6CbYuAcLrD5T0LmTIlcfPcgC57iaMT4As0rj2eHtydg
	 w2WtqFRlOG3hCLvl6KA2BwVSI5/OvZzttqYPYVPQ8pIS9qfROjqEXMsnriq+gyW2Ih
	 kcHN1RSJrrZc7UCsCI9RPy/R9fOrWmaRxC7ZJaKW65QAqBhVzGdLnJsGq6vvl5mN4x
	 6RdasdIHwVIDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47A0240804;
	Thu, 27 Aug 2026 19:50:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FE03105
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11F4C80E8E
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:51:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QXekH5G0vmKU for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 15:51:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=aSQMDodZ
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AAA7080E7B
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:51:31 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-92ea24a2dbfso318485a.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1787845890; x=1788450690;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bilWJIlHktWoEZjHwyNxhF4sv+bJkyHheRkebupSmqk=;
 b=aSQMDodZDEIMFPymSyK6kk4M8p+ETncp6UR4Le9n4vWl62hhQQly56uV4H8XPDZw0Q
 zDRJVe/5zWs8JGLPIhq/8D0jFroig7BaSLG1Wtsbi7IYbwLCGSEKD5zLY7Bba7nAcv4Q
 TlUyK+XZIw8X1pcPVLs4Dpy8pEN0AFnZrJJuvHmLkSPl/6w2R6UiXiDDCjLt3lYOzVuJ
 ktf+g48aZwUyvX/YenvWm/zmZNHo3xuEYgtwkzm9rCe0MME8Fh16n40Nwj7iVVb25xim
 Cys5XOB69bYuXD5iME+smRpY1BlPvgKy8bSgBdWjP+h6VdoRIc6MEdE349OQY5VfQpTT
 BhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787845890; x=1788450690;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bilWJIlHktWoEZjHwyNxhF4sv+bJkyHheRkebupSmqk=;
 b=KD9azWWyUTC0B9fS0OH7MbiLJHLSpr9h7JIxAjEd/PmQ07HImy/EMd59S1p5phde9X
 u/QoLxluqr3MOktliZ/bA1Udb9W+YdbMn1RqMfxJUwVDKLps4KZOYN7ui1piv+kxPHvc
 LT15RqdnknvyKiBooqqlwpNAeTfAnI4PzlgfLdAH7OibGm3FkJmRGBusw6E5NkCvmD04
 jQYjokPAEe/hRufWQxivlFio6n7MtqBt/YfxZXlvFNcidpaqOl9Mj8z/fKw/bHUj42sv
 +fM1mA49JvAAqMBYWVhwNa4M2b4Fvmdykk46sOUfKM049gB3P88Bl2xMrl2h4pry+0iv
 cC2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVsbXm8sHQNsDK3VskSkpyB1smOlbuyU6dmD4hcyXZfQGNCd3wJUXfKFKewFzBwDf3rdslOs0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nEeqAoe/qSoV26SBOKw44+qNMrMYjMA4sUNDD8B0EPmJ/J6aWQ
 PPGzR7/mMLPj0SK8f/hjAGcg7Xx3R52XHhGv5NfYBOW9lAorH9eJSWMTmzbQIlyW6MBGC/VJVUG
 ZgysAf/fHeApMdzSloX/4WcsN+LQ1iLOrySleBAlzPJLVIIyQv4efDniC3xPq/qP/7DJEQGTddl
 ShH9U=
X-Gm-Gg: AR+sD13hf0ML62oZQqTOQqqK5qfnrDVR/x3CWB7b7qLIBTtbkLo4xUpwm5o0G8Jh+2H
 1wofr+Gta7S/gahFPlz1lHju7TiIpDeSmLbO1c8P21SKFbifAUia8YmTbHQzAaoCO6wxAEbbGZf
 hWg19O0CYpq2y1Xo0Zq6aPujoByEx6lyWz/3O6unvOWhPowGE3qsY3VgvJs9jIk08N6xrAu44pk
 1t9LxjieDUYedWQ2UodK6/mJenZEAmLkGARhN6ASBYre7A5ATKyEbm6EW9dEsa0i2/PoZ9P5ROk
 Vh/niXPhUWhs9TBZFpOuLCUFzRNNoSx5F4N8z5nOBAzxsmdVROURcF9o301EvhissuzOA7v78B1
 Zkjsx0W9ymbUrPde8zYzW9/NUH8hThoDQB5E0rYCgGGnASSeDUG2DEAfelzpEx1Jrf8xwm9ERiX
 tUv++v+dDl2F3RXxPcKpgAPS/SGNzmNk5pAhjbEMk3IRvVFlVoY/Rk6yjIcoiH5fjvSA==
X-Received: by 2002:a05:620a:4f3:b0:936:dbd7:fcb3 with SMTP id
 af79cd13be357-9378019b06cmr1262591985a.21.1787845889677; 
 Thu, 27 Aug 2026 08:51:29 -0700 (PDT)
Received: from [10.200.233.210] ([71.163.254.246])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9377e36955bsm480665085a.19.2026.08.27.08.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 08:51:29 -0700 (PDT)
Message-ID: <d943fdf0-f54f-4103-87ea-beb8179206c0@brivo.com>
Date: Thu, 27 Aug 2026 11:51:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] arm64: meson: Add s4 SoC support
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260817171623.1943847-1-sanderson@brivo.com>
 <20260817171623.1943847-2-sanderson@brivo.com>
 <a05aabf7-9ef2-48a7-be9f-626c49c21a26@linaro.org>
Content-Language: en-US
From: Sean Anderson <sanderson@brivo.com>
In-Reply-To: <a05aabf7-9ef2-48a7-be9f-626c49c21a26@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Aug 2026 19:50:39 +0000
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



On 8/27/26 11:36 AM, Neil Armstrong wrote:
> On 8/17/26 19:15, Sean Anderson wrote:
>> Add support for amlogic s4 (S805X2/S905W2/S905Y4) SoCs. These are very
>> similar to other recent SoCs, with the exception of a workaround for
>> some BL2 (mis)behavior.
>>
>> Signed-off-by: Sean Anderson <sanderson@brivo.com>
>> ---
>>
>>   arch/arm/include/asm/arch-meson/boot0.h | 14 +++++++
>>   arch/arm/mach-meson/Kconfig             |  7 ++++
>>   arch/arm/mach-meson/Makefile            |  1 +
>>   arch/arm/mach-meson/board-s4.c          | 50 +++++++++++++++++++++++++
>>   4 files changed, 72 insertions(+)
>>   create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
>>   create mode 100644 arch/arm/mach-meson/board-s4.c
>>
>> diff --git a/arch/arm/include/asm/arch-meson/boot0.h b/arch/arm/include/asm/arch-meson/boot0.h
>> new file mode 100644
>> index 00000000000..7338171be15
>> --- /dev/null
>> +++ b/arch/arm/include/asm/arch-meson/boot0.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright (C) 2026 Brivo Systems LLC
>> + */
>> +b reset
>> +#if IS_ENABLED(CONFIG_MESON_S4)
>> +/*
>> + * BL2 copies some keys to the start of DRAM, clobbering anything in the first
>> + * 2k aside from the initial instruction. I measured the actual data clobbered
>> + * as 1076 bytes, but I suspect the amount depends on the configuration, so
>> + * just go with what amlogic does.
>> + */
>> +.skip 2048
>> +#endif
> 
> How different is this boot0 with the one posted for T7 at [1] ?
> 
> https://lore.kernel.org/all/20260821084603.25974-3-tanure@linux.com/

Should be identical. Actually, the size is the same, but I couldn't figure out how
the "kernel key" was supposed to work. So using the same boot0.h should be fine.

>> diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
>> index c687ef822a2..91d1e8342e0 100644
>> --- a/arch/arm/mach-meson/Kconfig
>> +++ b/arch/arm/mach-meson/Kconfig
>> @@ -67,6 +67,13 @@ config MESON_A1
>>       help
>>         Select this if your SoC is an A113L
>> +config MESON_S4
>> +    bool "S4"
>> +    select MESON64_COMMON
>> +    select ENABLE_ARM_SOC_BOOT0_HOOK
>> +    help
>> +      Select this if your SoC is an S905Y4/S905W2/S805X2
>> +
>>   endchoice
>>   config SYS_SOC
>> diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
>> index 08a24d4b24f..2157c35c2d5 100644
>> --- a/arch/arm/mach-meson/Makefile
>> +++ b/arch/arm/mach-meson/Makefile
>> @@ -17,3 +17,4 @@ endif
>>   obj-$(CONFIG_MESON_AXG) += board-axg.o
>>   obj-$(CONFIG_MESON_G12A) += board-g12a.o
>>   obj-$(CONFIG_MESON_A1) += board-a1.o
>> +obj-$(CONFIG_MESON_S4) += board-s4.o
>> diff --git a/arch/arm/mach-meson/board-s4.c b/arch/arm/mach-meson/board-s4.c
>> new file mode 100644
>> index 00000000000..7d0bea9924f
>> --- /dev/null
>> +++ b/arch/arm/mach-meson/board-s4.c
>> @@ -0,0 +1,50 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * (C) Copyright 2023 SberDevices, Inc.
>> + */
>> +
>> +#include <asm/armv8/mmu.h>
>> +#include <asm/io.h>
>> +#include <linux/compiler.h>
>> +#include <linux/errno.h>
>> +
>> +void meson_init_reserved_memory(__maybe_unused void *fdt)
>> +{
>> +}
> 
> No reserved memory at all on S4 ?

Well, ATF is signed by amlogic and can't be modified on this platform, so the
reserved memory can't change unless you use a new version of the ATF binary.
meson-s4-s905y4-khadas-vim1s.dts just hard-codes the block of memory.

>> +
>> +int meson_get_boot_device(void)
>> +{
>> +    return -ENOSYS;
>> +}
>> +
>> +static struct mm_region s4_mem_map[] = {
>> +    {
>> +        .virt = 0x00000000UL,
>> +        .phys = 0x00000000UL,
>> +        .size = 0x80000000UL,
>> +        .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>> +            PTE_BLOCK_INNER_SHARE
>> +    }, {
>> +        .virt = 0x80000000UL,
>> +        .phys = 0x80000000UL,
>> +        .size = 0x7FE00000UL,
>> +        .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>> +            PTE_BLOCK_NON_SHARE |
>> +            PTE_BLOCK_PXN | PTE_BLOCK_UXN
>> +    }, {
>> +        /*
>> +         * This mem region contains in/out shared memory with bl31,
>> +         * hence it's marked as NORMAL memory type
>> +         */
>> +        .virt = 0xFFE00000UL,
>> +        .phys = 0xFFE00000UL,
>> +        .size = 0x00200000UL,
>> +        .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>> +            PTE_BLOCK_INNER_SHARE
>> +    }, {
>> +        /* List terminator */
>> +        0,
>> +    }
>> +};
>> +
>> +struct mm_region *mem_map = s4_mem_map;
> 

