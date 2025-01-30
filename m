Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C53AC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 09:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAE2A80C85;
	Thu, 30 Jan 2025 10:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UQMR1Xuy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD1282012; Thu, 30 Jan 2025 10:32:06 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B62AE80AE4
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 10:32:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso3471845e9.1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 01:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738229521; x=1738834321; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d4FrABP7bi3ukq3J5lGGWzS4xKLMw0mn8C9Vgb63fw4=;
 b=UQMR1XuyCrkGNU9fR8KWeBOruFz69qjAvZz3ipExC71BxQ6eAglhnLUYmcD4UIjrKD
 tWxe5d7WKinzzHXAiNMHsJENl7glkEsR1zy9ZIbRE9jsvwEMaCOkaB1xnB2X/3EjP+LG
 tEbdFs+fZCZ5D9g6U8BJyYcKEbwe70sraIviNpgdQRpqvq3mn0dWlGFXlJSS0hgFpLfW
 m/DE+m7d056ifYNQrNaP4FH9/EqBjRmXoMnrFWxHew+4LGdyFirCan4yiKQxdyXm8W5w
 xitKTubzpSPDXvCn0+u8r+fEmVbUfcctG8diLnapw40Jf8qxNe+sfWtBx/YtakSAQXkn
 1Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738229521; x=1738834321;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d4FrABP7bi3ukq3J5lGGWzS4xKLMw0mn8C9Vgb63fw4=;
 b=T1KzIs+VIWtunyjKSpDQD2d7Xo7ZdX8S9Y6akl/qdJVwaCEOx0pfGyPmxTtL0xt5OF
 TQFqdazROISDg+em84HMRKm5NHjxdBm4sn02IGfx827hNvE1W9IeAmcRp5oqKc/u1szu
 nE1/jaK5moqSwHQ0XNYhxcA8Fo2pYMZ3HK4EFCCbDdijXAT75JS9lxi501c4y8b1C9k0
 eW/GGXVqUviHEKevHjWyYu/uismjiejAeizG7VY9rx+Z/wEJbI/bcDegtJ6bBP181bVC
 FRCBhIkpeDi/9AKrX2tMPV4dJ1+vEQrWrnnGCMK+Kjepq9LMkKfIeqWS/6nYR6geIMPW
 IFVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/C+4AlZSBZ6OKzj0aPjgQwOxtblWiozDCW6mGFP9WxMBqScpG1qvznSr65DudDnJPLuB3uso=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/XPVIUH78macg+SJmHGeaeWjv4Z0ZYw3znBNxPPlLN8Nr7xqe
 aMZ8oIXGWnob9d8iEV8DfUeVDGrnOUZlWXm48EhFt2AzCrzvLfATgT3q9KcTvL0=
X-Gm-Gg: ASbGncvYJpXVKhZv/k63QDEfUyh0Cp7C5U1BNXOvGiPuqVsRZbtdi94wU/DKEDDgcuZ
 jQlmRj1la9xTPZ5q6ZkPxwZc+WN1t8sL/XZvYU/Ntxdi2aU0CYwoSql/fC3+tYHrOEMh+3ryw0h
 LKqklvIf108a07y8/VCrK3K5Dv7fdKxKoVOqKrD7QEQJ0VSSDG/9atfhdyFpN+FIOB2budWPihT
 D0iL9a0tYQ6/15E10IUHRp950IIfC1J+nfsbi8B+lnHALTq7/t9l8t1Y7Dc/dmOrOP1f96RAzj6
 xQ39OkHF3khT6Nr9pT2YmX4jNT9m5YTFJqpILQ8kFVnOiTHFDiQ4GY2kJxz1KwxTj3HFQsA=
X-Google-Smtp-Source: AGHT+IH3ROFLWnSbYlyvAkRFOlR3WZv322OPUmDyvmTr5iJYH15bOfHdjerwUdQQIJkgwecO626GyA==
X-Received: by 2002:a7b:c3cd:0:b0:438:e231:d342 with SMTP id
 5b1f17b1804b1-438e231d503mr11744665e9.1.1738229521064; 
 Thu, 30 Jan 2025 01:32:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:14f6:2931:46df:28c5?
 ([2a01:e0a:3cb:7bb0:14f6:2931:46df:28c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e244f403sm16377915e9.25.2025.01.30.01.32.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 01:32:00 -0800 (PST)
Message-ID: <491620d4-5d92-4e16-951c-73765df8bd21@linaro.org>
Date: Thu, 30 Jan 2025 10:31:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] arm64: mmu_change_region_attr() add an option not
 to break PTEs
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?=
 <ptosi@google.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Michal Simek
 <michal.simek@amd.com>, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-4-ilias.apalodimas@linaro.org>
 <2d16982b-1f7e-4fca-817c-d929ec3f598a@linaro.org>
 <CAC_iWjLfc1PLARLAB1sTvi3QRwGY0ZpmNurDWPqNfRa8oajqaQ@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjLfc1PLARLAB1sTvi3QRwGY0ZpmNurDWPqNfRa8oajqaQ@mail.gmail.com>
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



On 1/30/25 10:20, Ilias Apalodimas wrote:
> Hi Jerome,
> 
> On Thu, 30 Jan 2025 at 11:11, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Hi Ilias,
>>
>> On 1/30/25 08:20, Ilias Apalodimas wrote:
>>> The ARM ARM on section 8.17.1 describes the cases where
>>> break-before-make is required when changing live page tables.
>>> Since we can use this function to tweak block and page permssions,
>>> where BBM is not required add an extra argument to the function.
>>>
>>> While at it add a function we can use to change the attributes of normal
>>> memory without breaking the pages tables first
>>>
>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> ---
>>>  arch/arm/cpu/armv8/cache_v8.c           | 27 ++++++++++++++++++++++++-
>>>  arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 ++++-----
>>>  arch/arm/include/asm/system.h           |  3 ++-
>>>  arch/arm/mach-snapdragon/board.c        |  2 +-
>>>  4 files changed, 34 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
>>> index a4ca56c8ed42..60d0870013e8 100644
>>> --- a/arch/arm/cpu/armv8/cache_v8.c
>>> +++ b/arch/arm/cpu/armv8/cache_v8.c
>>> @@ -968,11 +968,14 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
>>>   * The procecess is break-before-make. The target region will be marked as
>>>   * invalid during the process of changing.
>>>   */
>>> -void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
>>> +void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs, bool bbm)
>>>  {
>>>       int level;
>>>       u64 r, size, start;
>>>
>>> +     if (!bbm)
>>> +             goto skip_bbm;
>>> +
>>>       start = addr;
>>>       size = siz;
>>>       /*
>>> @@ -997,6 +1000,7 @@ void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
>>>                          gd->arch.tlb_addr + gd->arch.tlb_size);
>>>       __asm_invalidate_tlb_all();
>>>
>>> +skip_bbm:
>>>       /*
>>>        * Loop through the address range until we find a page granule that fits
>>>        * our alignment constraints, then set it to the new cache attributes
>>> @@ -1020,6 +1024,27 @@ void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
>>>       __asm_invalidate_tlb_all();
>>>  }
>>>
>>> +void mmu_set_attrs(phys_addr_t addr, size_t size, int type)
>>
>> type should be an enum
> 
> yea, I mentioned that in the cover letter.

...which for some reason I did not get :-/ I found it on the ML
archive.

Thanks,
-- 
Jerome

> 
> Thanks!
> /Ilias
>>
>>> +{
>>> +     u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE | PTE_TYPE_VALID;
>>> +
>>> +     switch (type) {
>>> +     case 1:
>>> +     /* RO */
>>> +             attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN | PTE_BLOCK_RO;
>>> +             break;
>>> +     case 2:
>>> +             /* RX */
>>> +             attrs |= PTE_BLOCK_RO;
>>> +             break;
>>> +     case 3:
>>> +             /* RW */
>>> +             attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN;
>>> +     }
>>> +
>>> +     mmu_change_region_attr(addr, size, attrs, false);
>>> +}
>>> +
>>>  #else        /* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
>>>
>>>  /*
>>> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
>>> index d2d3e346a36f..caf1dab05936 100644
>>> --- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
>>> +++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
>>> @@ -1573,7 +1573,7 @@ void update_early_mmu_table(void)
>>>                                       PTE_BLOCK_MEMTYPE(MT_NORMAL)    |
>>>                                       PTE_BLOCK_OUTER_SHARE           |
>>>                                       PTE_BLOCK_NS                    |
>>> -                                     PTE_TYPE_VALID);
>>> +                                     PTE_TYPE_VALID, true);
>>>       } else {
>>>               mmu_change_region_attr(
>>>                                       CFG_SYS_SDRAM_BASE,
>>> @@ -1581,7 +1581,7 @@ void update_early_mmu_table(void)
>>>                                       PTE_BLOCK_MEMTYPE(MT_NORMAL)    |
>>>                                       PTE_BLOCK_OUTER_SHARE           |
>>>                                       PTE_BLOCK_NS                    |
>>> -                                     PTE_TYPE_VALID);
>>> +                                     PTE_TYPE_VALID, true);
>>>  #ifdef CONFIG_SYS_DDR_BLOCK3_BASE
>>>  #ifndef CONFIG_SYS_DDR_BLOCK2_SIZE
>>>  #error "Missing CONFIG_SYS_DDR_BLOCK2_SIZE"
>>> @@ -1594,7 +1594,7 @@ void update_early_mmu_table(void)
>>>                                       PTE_BLOCK_MEMTYPE(MT_NORMAL)    |
>>>                                       PTE_BLOCK_OUTER_SHARE           |
>>>                                       PTE_BLOCK_NS                    |
>>> -                                     PTE_TYPE_VALID);
>>> +                                     PTE_TYPE_VALID, true);
>>>                       mmu_change_region_attr(
>>>                                       CONFIG_SYS_DDR_BLOCK3_BASE,
>>>                                       gd->ram_size -
>>> @@ -1603,7 +1603,7 @@ void update_early_mmu_table(void)
>>>                                       PTE_BLOCK_MEMTYPE(MT_NORMAL)    |
>>>                                       PTE_BLOCK_OUTER_SHARE           |
>>>                                       PTE_BLOCK_NS                    |
>>> -                                     PTE_TYPE_VALID);
>>> +                                     PTE_TYPE_VALID, true);
>>>               } else
>>>  #endif
>>>               {
>>> @@ -1614,7 +1614,7 @@ void update_early_mmu_table(void)
>>>                                       PTE_BLOCK_MEMTYPE(MT_NORMAL)    |
>>>                                       PTE_BLOCK_OUTER_SHARE           |
>>>                                       PTE_BLOCK_NS                    |
>>> -                                     PTE_TYPE_VALID);
>>> +                                     PTE_TYPE_VALID, true);
>>>               }
>>>       }
>>>  }
>>> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
>>> index dbf9ab43e280..0a8ca19e45e9 100644
>>> --- a/arch/arm/include/asm/system.h
>>> +++ b/arch/arm/include/asm/system.h
>>> @@ -287,8 +287,9 @@ void flush_l3_cache(void);
>>>   * @emerg: Also map the region in the emergency table
>>>   */
>>>  void mmu_map_region(phys_addr_t start, u64 size, bool emerg);
>>> -void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs);
>>> +void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs, bool bbm);
>>>
>>> +void mmu_set_attrs(phys_addr_t addr, size_t size, int type);
>>>  /*
>>>   * smc_call() - issue a secure monitor call
>>>   *
>>> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
>>> index 2ef936aab757..13f4e8e640ef 100644
>>> --- a/arch/arm/mach-snapdragon/board.c
>>> +++ b/arch/arm/mach-snapdragon/board.c
>>> @@ -577,7 +577,7 @@ static void carve_out_reserved_memory(void)
>>>               if (i == count || start + size < res[i].start - SZ_2M) {
>>>                       debug("  0x%016llx - 0x%016llx: reserved\n",
>>>                             start, start + size);
>>> -                     mmu_change_region_attr(start, size, PTE_TYPE_FAULT);
>>> +                     mmu_change_region_attr(start, size, PTE_TYPE_FAULT, true);
>>>                       /* If this is the final region then quit here before we index
>>>                        * out of bounds...
>>>                        */
