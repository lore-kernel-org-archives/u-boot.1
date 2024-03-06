Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B67FC54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 23:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE3EF875FA;
	Thu,  7 Mar 2024 00:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AlNNPZRc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D737987513; Thu,  7 Mar 2024 00:08:09 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B93D0876BA
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 00:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6e4f8f140c1so145135a34.2
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 15:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709766485; x=1710371285; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3me4Ts6sHP9qqFugrUwbp5k8ANabdK71EXbySdh0m0k=;
 b=AlNNPZRc+3K1Ow+7BUY4UzazXcPJTzc7I7YtyGkwBgpEaP0rdHiiTod3KdADdFB/jj
 B/2TwBYQemk+gfFpZaeLOuWXHLLTEiPg+zu6gvfY3O7trezidWOME+QXdKtCgdZOCOoQ
 gZ9YYsonOIdcPtf+9y149EaMRDRVRDA6/roarb6kYTSWB1wM5heKIClu8f8kEZmymx8w
 6h0tIH1F8v4nI84bthr+8ccDTCPPtxR/xfeNXoAmB62KhEwRtTuoKgA4QEI9NL/Kwv9Y
 cX3HZmHSCfjpTQYGx+/qM9Nz7fS37oC/lrq9n24IYwP4uB84VobMi+KJ+asBYTPFnCHA
 ijjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709766485; x=1710371285;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3me4Ts6sHP9qqFugrUwbp5k8ANabdK71EXbySdh0m0k=;
 b=ik+uNaQtYU3lVWWM6qZ5WI0r9DmoASN868Um3iLNq1Q/OhLtMYdnXbkAfm9RIl1AEV
 PHThi43J9oQiftAgp5err5/Hf76FWKZRradwhfoIXiQmU289gHSY+AHibxgHAqxdCwcL
 tfrIaM59JUJOy3UkAL6/Oa9RgoqCEvSMSXge2Vd3oIDnXDCJ2DP0pwR6qx8r2KswKkq7
 wmQWF8UqIxFlSfkidvjXdbM7wlQ7rwHRDBCMSlDDvk1KS6uE7rKSOGiMn0ynUDgIk4SM
 E2QMzs2X9zMDr1cn7VSnhMTpWKJJ3fxmgp1jCRa0HRcK/6uMeNKOBCA+3KOlCZsvOwkv
 C9xA==
X-Gm-Message-State: AOJu0YxSuBDbyVdXj+b8RxvQ1zEzwaQHA9+e2hRfIfLxaFKdc9UXfFTh
 thSRzGca6jPo/PSSG1Poo9BspVef2/VK/HX/DcotDk1gBibW9+p/
X-Google-Smtp-Source: AGHT+IHPnaHu/5lLqtXbFB796KzI4uvEXXDymIJLsWKRz+dYpWZ86CDldiOh8uO3DYWHow3tRUcZkg==
X-Received: by 2002:a05:6870:889a:b0:21f:9eaa:5f0 with SMTP id
 m26-20020a056870889a00b0021f9eaa05f0mr6920732oam.49.1709766485144; 
 Wed, 06 Mar 2024 15:08:05 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:10f:8bb5:397e:4402?
 ([2001:470:42c4:101:10f:8bb5:397e:4402])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a05687044d100b0021dfca3835asm3689877oai.42.2024.03.06.15.08.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 15:08:04 -0800 (PST)
Message-ID: <b1e34692-5d67-48cd-a895-c18fd6c034fc@gmail.com>
Date: Wed, 6 Mar 2024 16:08:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm: move image_copy_start/end to linker symbols
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, caleb.connolly@linaro.org,
 sumit.garg@linaro.org, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
References: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
 <20240304090113.1410575-7-ilias.apalodimas@linaro.org>
 <6c4f6b76-0828-497f-a45c-e9bc307620bb@gmail.com>
 <CAC_iWj+RGLq1hsYTA8gWxKiNFgWJMzjsfZ62SE-v8xYm0MZYEw@mail.gmail.com>
 <CAC_iWjJaKWjT0LQoqcwt2p765=H1hsXBsbb5AMNBSPO=nPtpUQ@mail.gmail.com>
 <CAC_iWj+VFtJGxiKwX58ZZxrPgu4vMMrqshWH8RYoGR_9BVen_A@mail.gmail.com>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <CAC_iWj+VFtJGxiKwX58ZZxrPgu4vMMrqshWH8RYoGR_9BVen_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 3/6/24 06:23, Ilias Apalodimas wrote:
> On Wed, 6 Mar 2024 at 12:37, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> On Wed, 6 Mar 2024 at 11:35, Ilias Apalodimas
>> <ilias.apalodimas@linaro.org> wrote:
>>>
>>> Hi Sam,
>>>
>>>
>>> On Wed, 6 Mar 2024 at 10:22, Sam Edwards <cfsworks@gmail.com> wrote:
>>>>
>>>> On 3/4/24 02:01, Ilias Apalodimas wrote:
>>>>> image_copy_start/end are defined as c variables in order to force the compiler
>>>>> emit relative references. However, defining those within a section definition
>>>>> will do the same thing.
>>>>>
>>>>> So let's remove the special sections from the linker scripts, the
>>>>> variable definitions from sections.c and define them as a symbols within
>>>>> a section.
>>>>>
>>>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>> Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical
>>>>
>>>> Since the __image_copy_* symbols are marking boundaries in the whole
>>>> image as opposed to a single section, I'd find it clearer if they were
>>>> loose in the SECTIONS { ... } block, so as not to imply that they are
>>>> coupled to any particular section. Thoughts?
>>>
>>> The reason I included it within a section is my understanding of the
>>> ld (way older) manual [0].
>>> Copy-pasting from that:
>>>
>>> " Assignment statements may appear:
>>> - as commands in their own right in an ld script; or
>>> - as independent statements within a SECTIONS command; or
>>> - as part of the contents of a section definition in a SECTIONS command.
>>> The first two cases are equivalent in effect--both define a symbol
>>> with an absolute address. The last case defines a symbol whose address
>>> is relative to a particular section."
>>> So, since we need relocatable entries, I included it within a section.
>>>
>>> Looking at the latest ld [1] the wording has changed a bit it says
>>> "Expressions appearing outside an output section definition treat all
>>> numbers as absolute addresses" and it also has the following example
>>> SECTIONS
>>>    {
>>>      . = 0x100;
>>>      __executable_start = 0x100;
>>>      .data :
>>>      {
>>>        . = 0x10;
>>>        __data_start = 0x10;
>>>        *(.data)
>>>      }
>>>      …
>>>    }
>>> both . and __executable_start are set to the absolute address 0x100 in
>>> the first two assignments, then both . and __data_start are set to
>>> 0x10 relative to the .data section in the second two assignments.
>>> So I assume the same behavior persists?
>>
>> I just tested moving image_binary_end outside the section definition
>> and it's still emitted properly. I'll try to figure this out and on v3
>> I'll move both image_copy_start/end outside the sections.
>> I also noticed that I forgot to change
>> arch/arm/cpu/armv8/u-boot-spl.lds and get rid of the .image_copy_end.
> 
> Reading the manual again, the symbols will be emitted as relocatable
> entries regardless of their placement after that LD bug you mentioned
> is fixed.
> The only thing that will change when moving it outside the section
> definition is that an absolute value will be set, instead of a
> relative one to the start of the section. But that won't change the
> final binary placement in our case.

As far as I know, the linker is smart enough to understand that *any* 
symbol defined in terms of a memory location (e.g. `.` or 
`_other_symname`, ...) cannot be absolute when linking a PIE. The [1] 
documentation excerpt you cited seems to be saying that the exception to 
this rule is when a linker symbol is assigned to a constant value loose 
in the SECTIONS block -- and that apparently within the context of a 
`.section : {...}`, number literals are treated as offsets from the 
section's beginning, not absolute addresses: so we get relative symbols 
once again. This seems to be what your [0] documentation excerpt is also 
trying to say: "numbers in a section definition are relative to the 
section," not "relative symbols must be assigned in a section definition."

> 
> I played around a bit and removed the .image_copy_end section from the
> SPL in favor of a symbol.
> Compiling for xilinx_zynqmp_kria_defconfig which builds u-boot & SPL
> (note that I am building natively on an arm64 box)
> 
> # Before -- image_copy_end is .efi_runtime_rel and spl still has a
> section for .image_copy_end
> $:~/work/u-boot-tpm>readelf -s u-boot | grep image_cop
>    9339: 000000000811f550     0 NOTYPE  GLOBAL DEFAULT   10 __image_copy_end
>   10614: 0000000008000000     0 NOTYPE  GLOBAL DEFAULT    1 __image_copy_start
> $:~/work/u-boot-tpm>readelf -s spl/u-boot-spl | grep image_cop
>       5: 00000000fffe0dc8     0 SECTION LOCAL  DEFAULT    5 .image_copy_end
>    1705: 00000000fffc0000     0 NOTYPE  GLOBAL DEFAULT    1 __image_copy_start
> 
> # After -- image_copy_end moved outside .efi_runtime_rel and
> .image_copy_end  converted to a linker symbol
> $:~/work/u-boot-tpm>readelf -s u-boot | grep image_cop
>    9339: 000000000811f550     0 NOTYPE  GLOBAL DEFAULT   10 __image_copy_end
>   10614: 0000000008000000     0 NOTYPE  GLOBAL DEFAULT    1 __image_copy_start
> $:~/work/u-boot-tpm>readelf -s spl/u-boot-spl | grep image_cop
>    1349: 00000000fffe0dc8     0 NOTYPE  GLOBAL DEFAULT    4 __image_copy_end
>    1705: 00000000fffc0000     0 NOTYPE  GLOBAL DEFAULT    1 __image_copy_start
> 
> Nothing changes in offsets and sizes.
> 
> The only thing I won't do right now is move image_copy_start outside
> the text region since that accounts for the CONFIG_SPL_TEXT_BASE and
> CONFIG_SYS_LOAD_ADDR. Keeping the __image_copy_start in there has an
> obvious caveat -- __image_copy_start will end up in .text and
> __image_copy_end in .rodata, but since we always had that it's fine
> for now.

I see what you're saying: the .text address is specified by -Ttext from 
Makefile.spl, so we don't know it in the linker script, and we can't 
rely on a `__image_copy_start = .;` assignment right before .text 
because the linker isn't going to place .text contiguously.

For what it's worth, `__image_copy_start = ADDR(.text);` *does* work 
(and produces a relative relocation). It might also be preferable to 
call attention to the fact that the .text section's start address is not 
determined/known by the linker script.

Up to you though! I'm fine with either approach, I just want to make 
sure that they're both considered. :)

Cheers,
Sam

> 
> Thanks
> /Ilias
> 
> 
> 
> 
> 
> 
>>
>> Thanks
>> /Ilias
>>
>>
>>>
>>> [0] https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_mono/ld.html#SEC13
>>> [1] https://sourceware.org/binutils/docs/ld/Expression-Section.html
>>>
>>> Thanks
>>> /Ilias
>>>
>>>
>>>>
>>>> Thanks for the cleanup,
>>>> Sam
>>>>
>>>>> ---
>>>>>    arch/arm/cpu/armv8/u-boot.lds            | 10 ++--------
>>>>>    arch/arm/cpu/u-boot.lds                  | 10 ++--------
>>>>>    arch/arm/lib/sections.c                  |  2 --
>>>>>    arch/arm/mach-rockchip/u-boot-tpl-v8.lds |  8 ++------
>>>>>    arch/arm/mach-zynq/u-boot.lds            |  9 ++-------
>>>>>    5 files changed, 8 insertions(+), 31 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
>>>>> index e737de761a9d..340acf5c043b 100644
>>>>> --- a/arch/arm/cpu/armv8/u-boot.lds
>>>>> +++ b/arch/arm/cpu/armv8/u-boot.lds
>>>>> @@ -23,7 +23,7 @@ SECTIONS
>>>>>        . = ALIGN(8);
>>>>>        .text :
>>>>>        {
>>>>> -             *(.__image_copy_start)
>>>>> +             __image_copy_start = .;
>>>>>                CPUDIR/start.o (.text*)
>>>>>        }
>>>>>
>>>>> @@ -120,13 +120,7 @@ SECTIONS
>>>>>                *(.rel*.efi_runtime)
>>>>>                *(.rel*.efi_runtime.*)
>>>>>                    __efi_runtime_rel_stop = .;
>>>>> -     }
>>>>> -
>>>>> -     . = ALIGN(8);
>>>>> -
>>>>> -     .image_copy_end :
>>>>> -     {
>>>>> -             *(.__image_copy_end)
>>>>> +             __image_copy_end = .;
>>>>>        }
>>>>>
>>>>>        .rela.dyn ALIGN(8) : {
>>>>> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
>>>>> index df55bb716e35..7c4f9c2d4dd3 100644
>>>>> --- a/arch/arm/cpu/u-boot.lds
>>>>> +++ b/arch/arm/cpu/u-boot.lds
>>>>> @@ -37,7 +37,7 @@ SECTIONS
>>>>>        . = ALIGN(4);
>>>>>        .text :
>>>>>        {
>>>>> -             *(.__image_copy_start)
>>>>> +             __image_copy_start = .;
>>>>>                *(.vectors)
>>>>>                CPUDIR/start.o (.text*)
>>>>>        }
>>>>> @@ -151,13 +151,7 @@ SECTIONS
>>>>>                *(.rel*.efi_runtime)
>>>>>                *(.rel*.efi_runtime.*)
>>>>>                __efi_runtime_rel_stop = .;
>>>>> -     }
>>>>> -
>>>>> -     . = ALIGN(4);
>>>>> -
>>>>> -     .image_copy_end :
>>>>> -     {
>>>>> -             *(.__image_copy_end)
>>>>> +             __image_copy_end = .;
>>>>>        }
>>>>>
>>>>>        .rel.dyn ALIGN(4) : {
>>>>> diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
>>>>> index a4d4202e99f5..db5463b2bbbc 100644
>>>>> --- a/arch/arm/lib/sections.c
>>>>> +++ b/arch/arm/lib/sections.c
>>>>> @@ -19,8 +19,6 @@
>>>>>     * aliasing warnings.
>>>>>     */
>>>>>
>>>>> -char __image_copy_start[0] __section(".__image_copy_start");
>>>>> -char __image_copy_end[0] __section(".__image_copy_end");
>>>>>    char __secure_start[0] __section(".__secure_start");
>>>>>    char __secure_end[0] __section(".__secure_end");
>>>>>    char __secure_stack_start[0] __section(".__secure_stack_start");
>>>>> diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
>>>>> index b7887194026e..4b480ebb0c4d 100644
>>>>> --- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
>>>>> +++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
>>>>> @@ -24,7 +24,7 @@ SECTIONS
>>>>>
>>>>>        .text : {
>>>>>                . = ALIGN(8);
>>>>> -             *(.__image_copy_start)
>>>>> +             __image_copy_start = .;
>>>>>                CPUDIR/start.o (.text*)
>>>>>                *(.text*)
>>>>>        }
>>>>> @@ -42,11 +42,7 @@ SECTIONS
>>>>>        __u_boot_list : {
>>>>>                . = ALIGN(8);
>>>>>                KEEP(*(SORT(__u_boot_list*)));
>>>>> -     }
>>>>> -
>>>>> -     .image_copy_end : {
>>>>> -             . = ALIGN(8);
>>>>> -             *(.__image_copy_end)
>>>>> +             __image_copy_end = .;
>>>>>        }
>>>>>
>>>>>        .end : {
>>>>> diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
>>>>> index fcd0f42a7106..553bcf182272 100644
>>>>> --- a/arch/arm/mach-zynq/u-boot.lds
>>>>> +++ b/arch/arm/mach-zynq/u-boot.lds
>>>>> @@ -16,7 +16,7 @@ SECTIONS
>>>>>        . = ALIGN(4);
>>>>>        .text :
>>>>>        {
>>>>> -             *(.__image_copy_start)
>>>>> +             __image_copy_start = .;
>>>>>                *(.vectors)
>>>>>                CPUDIR/start.o (.text*)
>>>>>        }
>>>>> @@ -57,12 +57,7 @@ SECTIONS
>>>>>                *(.rel*.efi_runtime)
>>>>>                *(.rel*.efi_runtime.*)
>>>>>                __efi_runtime_rel_stop = .;
>>>>> -     }
>>>>> -
>>>>> -     . = ALIGN(8);
>>>>> -     .image_copy_end :
>>>>> -     {
>>>>> -             *(.__image_copy_end)
>>>>> +             __image_copy_end = .;
>>>>>        }
>>>>>
>>>>>        .rel.dyn ALIGN(8) : {
