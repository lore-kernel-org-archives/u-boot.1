Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0A5C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 22:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4730878E2;
	Wed,  6 Mar 2024 23:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fXHo6RfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 843B8878E9; Wed,  6 Mar 2024 23:19:55 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59BF78758B
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 23:19:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7c83fb0fa01so10633039f.1
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 14:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709763592; x=1710368392; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y6o2jL6xOknIFvVgvxl/SLkibMWJc1z1QtFEt44sYfQ=;
 b=fXHo6RfNZCq+0Izvc5GCQ77jip7cizTf5MmNZxb2sy2Tul8jOscm0fSXp1odw4Ecsj
 o3iYrnhmtADP/PbM+rrqwddk64FUOhA8szWeOmR2wFYoHmhd50aQXCsjBJL0GJnpU3X5
 VA9g8m9xswkDklnkUbnw/7rVBIDqLQIVIficVHYFcplnVkT7/KuZS8Z9EpsZIHGe6a7H
 4hW8wYvv0kSvbsE5PkCvBfDjrB7Y/5kfhVk4tSNbJjZ/llP0YLc7uUMDFohxL4PVMQQX
 ttKVR9s+0gG53RL1raLEy5QYeLBpHr1ujLsgWuY00UkybRKle0JyxpgJpVhXBV/LB3ZA
 /olQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709763592; x=1710368392;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y6o2jL6xOknIFvVgvxl/SLkibMWJc1z1QtFEt44sYfQ=;
 b=YsJ99cHjQSLAbDi81nrTVqkusCJv7Q9Vp//NzwPxaS45VgofzXzL+dIRveL1C5S6ul
 M+2Hm2sgr5CipAGsqpYfqVhKylXuyuQJw3k/bptz5DLPBwjIdnMKuocTFh7VNwN0c5Gf
 RRIlRwokdykry43qwoUAwPYrLWyrsvKzmy7ItSwvQb0tOktHDH1SPqTrkOwZZ0e+gWyD
 D38cfI071k16XCKn09yE2cX6nrUTOqXbiamb0gMdyTZ9wOlpOTGxFLrDinS7CxG3wAPg
 M5k/VasqPNYeVXjLkLFxinDxfUz3AA5dy1YymKwHEvfTMl6ZynWH3pDBxFpfdoNTI4eb
 KHnQ==
X-Gm-Message-State: AOJu0YxjWb9lxMsYTb+wG6YZIiQXg1cc3Yjj1JGxn4RO46eZN3HK2v6J
 NZtmHUsc665a8O20XrIIwbXMROIgVB7LFbIIHtm8uLTp2ug+D53W
X-Google-Smtp-Source: AGHT+IGgLbdDvCalBIA+6Ir0gIureXsuhdXIP0V4yco0QjSI9curwRhA5z6IrGrpBkGsS6+9aFjXSQ==
X-Received: by 2002:a6b:dc0e:0:b0:7c8:5742:f4a0 with SMTP id
 s14-20020a6bdc0e000000b007c85742f4a0mr10324173ioc.12.1709763591809; 
 Wed, 06 Mar 2024 14:19:51 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:10f:8bb5:397e:4402?
 ([2001:470:42c4:101:10f:8bb5:397e:4402])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a056638001600b004748175344bsm3661498jao.167.2024.03.06.14.19.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 14:19:51 -0800 (PST)
Message-ID: <73d538d5-f1c0-46d0-9fc1-ff705eed054a@gmail.com>
Date: Wed, 6 Mar 2024 15:19:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm: fix __efi_runtime_start/end definitions
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
 <20240304090113.1410575-6-ilias.apalodimas@linaro.org>
 <ccfe2f01-765b-4953-b0b5-9122b861d89b@gmail.com>
 <CAC_iWjKaaa1vh3BQJGH7obp7MC34QOfSB97R=HEHaj1mSGMpWQ@mail.gmail.com>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <CAC_iWjKaaa1vh3BQJGH7obp7MC34QOfSB97R=HEHaj1mSGMpWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 3/6/24 02:13, Ilias Apalodimas wrote:
> Hi Sam,
> 
> Again thank you for the elaborate review. This really helps a lot.
> 
> On Wed, 6 Mar 2024 at 10:14, Sam Edwards <cfsworks@gmail.com> wrote:
>>
>>
>>
>> On 3/4/24 02:01, Ilias Apalodimas wrote:
>>> __efi_runtime_start/end are defined as c variables for arm7 only in
>>> order to force the compiler emit relative references. However, defining
>>> those within a section definition will do the same thing. On top of that
>>> the v8 linker scripts define it as a symbol.
>>>
>>> So let's remove the special sections from the linker scripts, the
>>> variable definitions from sections.c and define them as a symbols within
>>> the correct section.
>>>
>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical
>>
>> Thanks for the cleanup,
>> Sam
>>
>>> ---
>>>    arch/arm/cpu/u-boot.lds        | 12 +++---------
>>>    arch/arm/lib/sections.c        |  2 --
>>>    arch/arm/mach-zynq/u-boot.lds  | 12 +++---------
>>>    include/asm-generic/sections.h |  1 +
>>>    4 files changed, 7 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
>>> index 7c6e7891d360..df55bb716e35 100644
>>> --- a/arch/arm/cpu/u-boot.lds
>>> +++ b/arch/arm/cpu/u-boot.lds
>>> @@ -43,18 +43,12 @@ SECTIONS
>>>        }
>>>
>>>        /* This needs to come before *(.text*) */
>>> -     .__efi_runtime_start : {
>>> -             *(.__efi_runtime_start)
>>> -     }
>>> -
>>> -     .efi_runtime : {
>>> +     .efi_runtime ALIGN(4) : {
>>
>> Do we truly require the ALIGN(4)? If I understand correctly, by default,
>> the linker calculates the alignment of an output section as the least
>> common multiple of the input sections' alignment requirements -- meaning
>> most (perhaps all) of our ALIGN()s today are redundant.
> 
> I don't think we do. But I preserved those for a few reasons.
> 
>>   For the time
>> being, I'm in favor of merging existing `. = ALIGN(x)` into each
>> following section for clarity and to avoid the testing overhead of
>> removing them in the same patch as other changes. However, in the near
>> future (perhaps even as "near" as v2 of this series?), I'd also like to
>> see a patch that eliminates unnecessary ALIGN()s altogether. Introducing
>> additional ALIGN()s where we already know they aren't needed may be a
>> step away from that goal.
> 
> So as you already mentioned the reason I preserved this is:
> - Reduce the testing overhead by preserving the same layout for now
> - In the future, I am playing around with the idea of mapping U-Boot
> (not SPL but the relocated full U-Boot) in sections with proper memory
> permissions (R), RW^X etc). In that case, we will need a 4k section
> alignment and we can repurpose the ALIGN(4/8) to
> ALIGN(CONSTANT(COMMONPAGESIZE)).
> 
> Thoughts?

Ah, right: I had forgotten for a moment that the ultimate goal was to 
clean up the memory protection bit situation.

Okay, as long as that future cleanup will also remove all unnecessary 
uses of ALIGN() (i.e. any that don't result in an actual change in 
memory layout) then that sounds great to me.

Reviewed-by: Sam Edwards <CFSworks@gmail.com>

Cheers,
Sam

> 
> Thanks
> /Ilias
> 
>>
>>> +             __efi_runtime_start = .;
>>>                *(.text.efi_runtime*)
>>>                *(.rodata.efi_runtime*)
>>>                *(.data.efi_runtime*)
>>> -     }
>>> -
>>> -     .__efi_runtime_stop : {
>>> -             *(.__efi_runtime_stop)
>>> +             __efi_runtime_stop = .;
>>>        }
>>>
>>>        .text_rest :
>>> diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
>>> index 1ee3dd3667ba..a4d4202e99f5 100644
>>> --- a/arch/arm/lib/sections.c
>>> +++ b/arch/arm/lib/sections.c
>>> @@ -25,6 +25,4 @@ char __secure_start[0] __section(".__secure_start");
>>>    char __secure_end[0] __section(".__secure_end");
>>>    char __secure_stack_start[0] __section(".__secure_stack_start");
>>>    char __secure_stack_end[0] __section(".__secure_stack_end");
>>> -char __efi_runtime_start[0] __section(".__efi_runtime_start");
>>> -char __efi_runtime_stop[0] __section(".__efi_runtime_stop");
>>>    char _end[0] __section(".__end");
>>> diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
>>> index 71dea4a1f60a..fcd0f42a7106 100644
>>> --- a/arch/arm/mach-zynq/u-boot.lds
>>> +++ b/arch/arm/mach-zynq/u-boot.lds
>>> @@ -22,18 +22,12 @@ SECTIONS
>>>        }
>>>
>>>        /* This needs to come before *(.text*) */
>>> -     .__efi_runtime_start : {
>>> -             *(.__efi_runtime_start)
>>> -     }
>>> -
>>> -     .efi_runtime : {
>>> +     .efi_runtime ALIGN(4) : {
>>
>> Ditto above
>>
>>> +             __efi_runtime_start = .;
>>>                *(.text.efi_runtime*)
>>>                *(.rodata.efi_runtime*)
>>>                *(.data.efi_runtime*)
>>> -     }
>>> -
>>> -     .__efi_runtime_stop : {
>>> -             *(.__efi_runtime_stop)
>>> +             __efi_runtime_stop = .;
>>>        }
>>>
>>>        .text_rest :
>>> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
>>> index 60949200dd93..b6bca53db10d 100644
>>> --- a/include/asm-generic/sections.h
>>> +++ b/include/asm-generic/sections.h
>>> @@ -35,6 +35,7 @@ extern char __priv_data_start[], __priv_data_end[];
>>>    extern char __ctors_start[], __ctors_end[];
>>>
>>>    extern char __efi_runtime_rel_start[], __efi_runtime_rel_stop[];
>>> +extern char __efi_runtime_start[], __efi_runtime_stop[];
>>>
>>>    /* function descriptor handling (if any).  Override
>>>     * in asm/sections.h */
