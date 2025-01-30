Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B84C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 09:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08ACB80C85;
	Thu, 30 Jan 2025 10:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="juKfMJaM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51F3881F69; Thu, 30 Jan 2025 10:27:33 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4182780AE4
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 10:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3863703258fso1032652f8f.1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 01:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738229251; x=1738834051; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nsei6gwsnugr/ZHdbFiOs8bnqsmRZ35XSEuzp0p/BcA=;
 b=juKfMJaMpQXlKI5VUZaeojHLY52uoJjcBbgEcM3DZz46mrpkFnrNQkHbMSgMLscep8
 2a1X0BZPCpfv0lWzcfKxDgE/b2hmidsPU+wYc+Z54bw8LPrZpccRpBMOkE3dpzPpqYvK
 HOtytlYy6FtP0QDEziVPRsJBpoP1BPxoZAoqbhFiwhvI7S3hOHvvvv4fb3korbelzIx8
 DbhqukSArQ5Mk4wC0t3wgp+5Fgqj78z9lqDJ0nBhTdqTHN1tgdQkGcKhWbBDF0uiCYAh
 dCa03KYLtA+4HeEu+4+9UNRhVww5SQrLJWnLit3nLBDgQrGfcvxGZIZUEfAPwVj/x2ar
 EJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738229251; x=1738834051;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nsei6gwsnugr/ZHdbFiOs8bnqsmRZ35XSEuzp0p/BcA=;
 b=q6idPskSW1xeVZv6Vl+2bHXgqzWqBKOGzgoEF02pEZI5R5Ko9IHQY/F5+fPHR8wBPp
 Vg+Xp0HUIJVhAFoYWHvJgVn9LB+qSZmJ8nf7oSwtS5ldIcOKE7jEGsj8u4XTzmfedZsI
 2X91pYRaYguQ12/0bYBET/86NVrHZrLrNL21wQt5Ev6KdHBmFCyDI1ge/hixiI11N8lC
 NqYBbc90Tz1gW0Ca0JDVwPth9uSmiI/ncD2UgxMXQejzjbR/rzsFSIpdPXXhokPVSxax
 EoeyPi0QcAZp3hENOrQRbvI+twneu9+gbw0DcacNZPzUjljNFiQe58C94WqWqieiIwgi
 Ba6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFhQ+DIrK02tbfkdhdX3J1mh9i2Njs6WHfQ2qgdFuy2NOhxoODwf6gM6v3OdVeECYdFTyex6c=@lists.denx.de
X-Gm-Message-State: AOJu0YyL9stNsrWdesNu3NsNRoL1QQuYDusBARyfFiimpTrQunSj6OLN
 RLbQZjta4FBJ20gK72/JzriWFcsm7z8rmxqqgG5ZjgYW/oIhfz0EbCF4LQUoAS4=
X-Gm-Gg: ASbGncvBPEsLqbMwZjMz3mOB6ugLg/ZdIfpqJeXQlwmb7xG4pLojZskFbYdOnT2e0NY
 tfV+u6DySF5Ekse4EYg6unT6db1S68F7fOIxXa/SCVme96FHhPGc0q/79vgK6FA9iqzNDi/eD2u
 +UGAWKEftqkTUiXH9NrMeXRj+OpXP2liPdhTURfyY55e0KtAHvEHExA/lDmEiMuPxkoCJ/9W91O
 pe0VhXtdMElZlcC6OCZFqr9AHIsCUKNYzLcugjpNEAf1meTLa5ZsbE4sMSLMxYuXzQB37Do5dD4
 6cAy043y4r3IMWMfKJ+ZpIgtx0OBMi50YBQJgcEkqliDa99cKLa8TnEeXEruYyjmyTyWLB4=
X-Google-Smtp-Source: AGHT+IGI4CQxoYLgBRidTfH9zjYJLbeEmEiXFcp2gZ0c3wkqm1TBqvT38uQhNw2wjsCFTNYWJ4wrvw==
X-Received: by 2002:a5d:47ca:0:b0:386:3afc:14a7 with SMTP id
 ffacd0b85a97d-38c5a96b714mr1720425f8f.7.1738229250583; 
 Thu, 30 Jan 2025 01:27:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:14f6:2931:46df:28c5?
 ([2a01:e0a:3cb:7bb0:14f6:2931:46df:28c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c12193asm1398059f8f.49.2025.01.30.01.27.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 01:27:30 -0800 (PST)
Message-ID: <df385767-247a-48e8-a465-041a349afe6e@linaro.org>
Date: Thu, 30 Jan 2025 10:27:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] arm: Prepare linker scripts for memory permissions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>, Christian Marangi
 <ansuelsmth@gmail.com>, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-3-ilias.apalodimas@linaro.org>
 <21b86615-7538-4a65-b12d-1ef86f4861de@linaro.org>
 <CAC_iWj+0rYANKZRSxDe6GYEdJmQOfERZcE6rAcOxk-3HPzB_Qg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWj+0rYANKZRSxDe6GYEdJmQOfERZcE6rAcOxk-3HPzB_Qg@mail.gmail.com>
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



On 1/30/25 10:19, Ilias Apalodimas wrote:
> On Thu, 30 Jan 2025 at 11:09, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Hi Ilias,
>>
>> On 1/30/25 08:20, Ilias Apalodimas wrote:
>>> Upcoming patches are switching the memory mappings to RW, RO, RW^X page
>>> permissions after the U-Boot binary and its data are relocated. Add
>>> annotations in the linker scripts to and mark text, data, rodata etc
>>> sections and align them to a page boundary
>>>
>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> ---
>>>  Makefile                       | 15 +++++++++------
>>>  arch/arm/cpu/armv8/u-boot.lds  | 32 +++++++++++++++++++-------------
>>>  include/asm-generic/sections.h |  2 ++
>>>  lib/efi_loader/efi_runtime.c   |  2 ++
>>>  4 files changed, 32 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 33bb86343c5b..8d7c062ec830 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -2176,13 +2176,16 @@ System.map:   u-boot
>>>  # ARM relocations should all be R_ARM_RELATIVE (32-bit) or
>>>  # R_AARCH64_RELATIVE (64-bit).
>>>  checkarmreloc: u-boot
>>> -     @RELOC="`$(CROSS_COMPILE)readelf -r -W $< | cut -d ' ' -f 4 | \
>>> +     @RELOCS="`$(CROSS_COMPILE)readelf -r -W $< | cut -d ' ' -f 4 | \
>>>               grep R_A | sort -u`"; \
>>> -     if test "$$RELOC" != "R_ARM_RELATIVE" -a \
>>> -              "$$RELOC" != "R_AARCH64_RELATIVE"; then \
>>> -             echo "$< contains unexpected relocations: $$RELOC"; \
>>> -             false; \
>>> -     fi
>>> +     for reloc in $$RELOCS; do \
>>> +             if [ "$$reloc" != "R_ARM_RELATIVE" -a \
>>> +                  "$$reloc" != "R_AARCH64_RELATIVE" -a \
>>> +             "$$reloc" != "R_AARCH64_NONE" ]; then \
>>> +                     echo "$< contains unexpected relocations: $$reloc"; \
>>> +                     false; \
>>
>> s/false/exit 1/ otherwise the loop won't break and make won't get a
>> failure status unless the error is on the last reloc.
>>
>>> +             fi; \
>>> +     done
>>
>> This Makefile change seems unrelated to the current patch. Should it
>> go into a separate fixup patch?
>>
>>>  tools/version.h: include/version.h
>>>       $(Q)mkdir -p $(dir $@)
>>> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
>>> index 857f44412e07..18e168e27135 100644
>>> --- a/arch/arm/cpu/armv8/u-boot.lds
>>> +++ b/arch/arm/cpu/armv8/u-boot.lds
>>> @@ -22,7 +22,7 @@ SECTIONS
>>>
>>>       . = ALIGN(8);
>>>       __image_copy_start = ADDR(.text);
>>> -     .text :
>>> +     .text ALIGN(4096):
>>>       {
>>>               CPUDIR/start.o (.text*)
>>>       }
>>> @@ -36,9 +36,12 @@ SECTIONS
>>>                  __efi_runtime_stop = .;
>>>       }
>>>
>>> -     .text_rest :
>>> +     .text_rest ALIGN(4096) :
>>>       {
>>> +             __text_start = .;
>>>               *(.text*)
>>> +             . = ALIGN(4096);
>>> +             __text_end = .;
>>>       }
>>>
>>>  #ifdef CONFIG_ARMV8_PSCI
>>> @@ -98,27 +101,30 @@ SECTIONS
>>>       }
>>>  #endif
>>>
>>> -     . = ALIGN(8);
>>> -     .rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
>>> +     .rodata ALIGN(4096): {
>>> +         __start_rodata = .;
>>> +         *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
>>> +         . = ALIGN(4096);
>>> +         __end_rodata = .;
>>> +     }
>>>
>>> -     . = ALIGN(8);
>>> -     .data : {
>>> +     .data ALIGN(4096) : {
>>> +         __start_data = .;
>>>               *(.data*)
>>> +         . = ALIGN(4096);
>>> +         __end_data = .;
>>>       }
>>>
>>> -     . = ALIGN(8);
>>> -
>>> -     . = .;
>>> -
>>>       . = ALIGN(8);
>>>       __u_boot_list : {
>>>               KEEP(*(SORT(__u_boot_list*)));
>>>       }
>>>
>>> -     .efi_runtime_rel : {
>>> +     .efi_runtime_rel ALIGN(4096) : {
>>>                  __efi_runtime_rel_start = .;
>>>               *(.rel*.efi_runtime)
>>>               *(.rel*.efi_runtime.*)
>>> +             . = ALIGN(4096);
>>>                  __efi_runtime_rel_stop = .;
>>>       }
>>>
>>> @@ -136,10 +142,10 @@ SECTIONS
>>>       /*
>>>        * arch/arm/lib/crt0_64.S assumes __bss_start - __bss_end % 8 == 0
>>>        */
>>> -     .bss ALIGN(8) : {
>>> +     .bss ALIGN(4096) : {
>>>               __bss_start = .;
>>>               *(.bss*)
>>> -             . = ALIGN(8);
>>> +             . = ALIGN(4096);
>>>               __bss_end = .;
>>>       }
>>>
>>> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
>>> index b6bca53db10d..5626df796f33 100644
>>> --- a/include/asm-generic/sections.h
>>> +++ b/include/asm-generic/sections.h
>>> @@ -23,6 +23,7 @@ extern char __kprobes_text_start[], __kprobes_text_end[];
>>>  extern char __entry_text_start[], __entry_text_end[];
>>>  extern char __initdata_begin[], __initdata_end[];
>>>  extern char __start_rodata[], __end_rodata[];
>>> +extern char __start_data[], __end_data[];
>>>  extern char __efi_helloworld_begin[];
>>>  extern char __efi_helloworld_end[];
>>>  extern char __efi_var_file_begin[];
>>> @@ -63,6 +64,7 @@ static inline int arch_is_kernel_data(unsigned long addr)
>>>
>>>  /* Start of U-Boot text region */
>>>  extern char __text_start[];
>>> +extern char __text_end[];
>>>
>>>  /* This marks the text region which must be relocated */
>>>  extern char __image_copy_start[], __image_copy_end[];
>>> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
>>> index 35eb6a777665..c10a79301a92 100644
>>> --- a/lib/efi_loader/efi_runtime.c
>>> +++ b/lib/efi_loader/efi_runtime.c
>>> @@ -742,6 +742,8 @@ void efi_runtime_relocate(ulong offset, struct efi_mem_desc *map)
>>>                     rel->info, *p, rel->offset);
>>>
>>>               switch (rel->info & R_MASK) {
>>> +             case 0:
>>> +                     break;
>>
>> It looks like this may need to go into the same fixup patch as the
>> Makefile changes above.
>>
>>>               case R_RELATIVE:
>>>  #ifdef IS_RELA
>>>               newaddr = rel->addend + offset - CONFIG_TEXT_BASE;
>>
>> For the linker script changes:
> 
> All of these are needed in a single patch. The alignment changes
> trigger the emitted R_AARCH64_NONE relocs.

Got it. I suggest mentioning this in the commit description.

Please do not forget my comment about the "exit 1" though ;)

Thanks,
-- 
Jerome

> 
> Cheers
> /Ilias
>>
>> Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
