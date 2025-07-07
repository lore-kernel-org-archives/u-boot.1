Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD23C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 13:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4D348319A;
	Mon,  7 Jul 2025 15:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XYELO+Ga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE8B083164; Mon,  7 Jul 2025 15:12:32 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B1EF830CA
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 15:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4537deebb01so17573055e9.0
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 06:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751893950; x=1752498750; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VOi9kDjeWoIMRgrC1uRCj2lroqORx6Ypr/xE7dZ6SuQ=;
 b=XYELO+Ganfk6iuQLS7Qn7fl1H9QZl0TmlDwMo77SDC6w5nhAMDqTuGOStgFi4Qnvy9
 5ivaiFZQ6eO4n4V12YdwYBA+QHYsgPAUADBuwvKqa2g3cjPGB2t0aRBZv8QTK+Y9aFaO
 dnxNIUelESklX8CvxvOaG/ujQggK/4mttICBJFsbIIjmRDNXTTlKNzNUDvpK8gxLPUiH
 K/PUTxBd60xcq4SveWYF8Ib/Q6zhiPGGfU7lrBckZoR2xrSZp3dguDjJXM0FzQ8Nornm
 Jrn0+jPsX1nkjGUJ3cXCgR8vc74ongyUgYwa440k8fXVk1nuZOzi40Qloc0fHa/M0GyG
 Xm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751893950; x=1752498750;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VOi9kDjeWoIMRgrC1uRCj2lroqORx6Ypr/xE7dZ6SuQ=;
 b=RqtKYZTCRZ3M2u3kChLEg2jm7PyIzUx3xz/RFj+lt94eutd+jvm9BWntKWodHrDD95
 9eOrKYomu+5UGeR/BOljwoGKsboZZiEalNQQEgY2HITm1mPvVmZnp1FajwEBFnfvq76O
 rwxCP70syTvC607XPU9WicHIpzzFtRQCo3skdJYDsT/G8izELYFn3LZ5BDOGwdcI1bEx
 MXE/+/1yMdqk0odKT9RJ2rBjEeS4ddyf0qBvs/1mTzOnL42Gerl2f/eje8JaczRmKJ95
 2ePlhMF9qd3AuhbJzsLqYI/QXr4nqr5JwibBhj6IbmUMNocrhVwct+SKpLI53all4aTj
 wl1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqnrm1niGUkCCOentcBxZ//avOpzW3h371+5QcNjb47m7FL/iTaj1tyhYo0vWz7/7VCZID5rI=@lists.denx.de
X-Gm-Message-State: AOJu0Yya9NSB8IdtngADqbGLnQbO6RAqHgdqKz5CwCPe3ELqZqfgRN/W
 xpLuxmfl8DaDWf8sSjcElEz/RlU6c/x0Naz9ttuWvtrise+0nQP3ni6LLyKHiUZDOoM=
X-Gm-Gg: ASbGncs7rekNL3pc7Xzc93LqkVfdtV3zSZH6TyrZN98qmM9qtTQueXCB9loJ1LyqYhn
 kaELOV7umSvdT7+9Bmha1pV05mBb4CXwB5wTf9rBXACyEmhP04SOGh8xaFG+8C2d1VjyXp2smke
 fEs9uie0vQ0E1OVHtbyHQ9s5YrBxZAyLOprQyIk7xpf4J30GUAyYf3tTYeWxOgdrx9LP13AMv3X
 eyA9wtxPszx40U2mguhSMKHdk9b+xgLNh7V+2t1/Gg9l6WkhI9d8gOEUfBvIYsf3GbZnju1MrZq
 wS9zRBblIyh66gOxBMCk+O57ilOaXkIZJUKovKcz+OOEvgbZsSUfsXuVAuOOiMOXkvNtP/e2cvz
 AonbRoy2CsKHr1OmE5or+xam+0JwtStI=
X-Google-Smtp-Source: AGHT+IF9vtqdM0JEkro30hbv2arMk5NaB2Pp67pka0tzBYJkQokGFk/LNUQIPQ+MolB8/4vNrS52BQ==
X-Received: by 2002:a05:600c:3153:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-454b4ea5f53mr134915915e9.16.1751893949801; 
 Mon, 07 Jul 2025 06:12:29 -0700 (PDT)
Received: from [192.168.1.159] (p4fc3d4fa.dip0.t-ipconnect.de.
 [79.195.212.250]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b49cb46c61sm6162910f8f.63.2025.07.07.06.12.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 06:12:29 -0700 (PDT)
Message-ID: <4a0802d2-ec1e-4602-b48d-4c284381923d@linaro.org>
Date: Mon, 7 Jul 2025 15:12:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: implement printing backtraces
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
References: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
 <20250703051951.43372-4-heinrich.schuchardt@canonical.com>
 <788df6dc-fa00-4462-a61c-5878a5f9ddeb@linaro.org>
 <78c0ab6b-cbc4-4cfe-9144-dfb2b9bba801@canonical.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <78c0ab6b-cbc4-4cfe-9144-dfb2b9bba801@canonical.com>
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



On 7/3/25 14:08, Heinrich Schuchardt wrote:
> On 03.07.25 13:39, Casey Connolly wrote:
>>
>> On 03/07/2025 07:19, Heinrich Schuchardt wrote:
>>> Add a function to print frame pointers depending on symbols
>>> CONFIG_(SPL)_FRAMEPOINTER.
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>>   arch/arm/Makefile            |  9 ++++++-
>>>   arch/arm/lib/interrupts_64.c | 46 ++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 54 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>>> index 5ecadb2ef1b..41e75b5bcb1 100644
>>> --- a/arch/arm/Makefile
>>> +++ b/arch/arm/Makefile
>>> @@ -33,6 +33,13 @@ endif
>>>   # Evaluate arch cc-option calls now
>>>   arch-y := $(arch-y)
>>> +ifeq ($(CONFIG_$(PHASE_)FRAMEPOINTER),y)
>>> +    ARCH_FLAGS += -fno-omit-frame-pointer
>> from my testing, current arm64 builds of U-Boot will make use of a frame
>> pointer, it seems to be the default.
> 
> The built-in defaults may depend on the distro providing the compiler 
> and may be different on LLVM and GCC.

I think you missed the second half of my comment vv>
>>
>> So if CONFIG_FRAMEPOINTER is disabled we should explicitly add the
>> -fomit-frame-pointer flag I think? Or we ignore CONFIG_FRAMEPOINTER for
>> arm64 and accept that we always have a framepointer (I'm not sure how
>> significant the space saving really is here).



>>
>>> +endif
>>> +
>>> +PLATFORM_CPPFLAGS    += $(ARCH_FLAGS)
>>> +CFLAGS_EFI        += $(ARCH_FLAGS)
>>> +
>>>   # This selects how we optimise for the processor.
>>>   tune-$(CONFIG_CPU_ARM720T)    =-mtune=arm7tdmi
>>>   tune-$(CONFIG_CPU_ARM920T)    =
>>> @@ -47,7 +54,7 @@ tune-$(CONFIG_ARM64)        =
>>>   # Evaluate tune cc-option calls now
>>>   tune-y := $(tune-y)
>>> -PLATFORM_CPPFLAGS += $(arch-y) $(tune-y)
>>> +PLATFORM_CPPFLAGS += $(ARCH_FLAGS) $(arch-y) $(tune-y)
>>>   # Machine directory name.  This list is sorted alphanumerically
>>>   # by CONFIG_* macro name.
>>> diff --git a/arch/arm/lib/interrupts_64.c b/arch/arm/lib/interrupts_64.c
>>> index b3024ba514e..970f8b6831f 100644
>>> --- a/arch/arm/lib/interrupts_64.c
>>> +++ b/arch/arm/lib/interrupts_64.c
>>> @@ -98,6 +98,35 @@ void show_regs(struct pt_regs *regs)
>>>       dump_instr(regs);
>>>   }
>>> +/**
>>> + * show_backtrace() - show backtrace using frame pointers
>>> + *
>>> + * @regs - registers
>>> + */
>>> +static void show_backtrace(struct pt_regs *regs)
>>> +{
>>> +    void **fp = (void **)regs->regs[29];
>>> +    unsigned int count = 0;
>>> +    void *lr;
>>> +
>>> +    printf("\nbacktrace:\n");
>> This should be a capital 'B' as with the other headers.
> 
> ok
> 
>>
>> In my series the output looks like:
>>
>> Backtrace:
>>     <0x000001ffdfb344> do_mem_mw+0xbc
>>     <0x000001ffe0f07c> cmd_process+0x130
>>     <0x000001ffe06440> run_list_real+0x6d0
>>     <0x000001ffe065cc> parse_stream_outer+0x14c
>>     <0x000001ffe06b10> parse_file_outer+0x34
>>     <0x000001ffe0e3a4> cli_loop+0x18
>>     <0x000001ffe03b9c> main_loop+0x74
>>     <0x000001ffe07984> board_init_r+0x3c8
> 
> Please, provide a link to your series.

Already sent in a different mail but just for completeness sake

https://lore.kernel.org/u-boot/20240808-arm64-backtrace-v2-0-29665a2265cf@linaro.org/

> 
> Showing function names would be great.
> 
> Best regards
> 
> Heinrich
> 
>>
>> The aim was to match how the kernel backtraces look. I think it makes
>> sense to do that here too.
>>
>>> +
>>> +    while (fp) {
>>> +        lr = fp[1];
>>> +        printf("%3d: fp: %p lr: %p",
>>> +               count, fp, lr);
>> The address of the framepointer isn't so interesting, neither is the
>> index imo. I think the useful info here is the address of the function
>> and the offset from that to lr.
>>
>> Printing the lr pre and post relocation does maybe make sense though, to
>> be useful for interactive debugging or analyzing an objdump.
>>
>> Kind regards,
>>
>>> +
>>> +        if (gd && gd->flags & GD_FLG_RELOC)
>>> +            printf(" - %p (reloc)\n", lr - gd->reloc_off);
>>> +        else
>>> +            printf("\n");
>>> +
>>> +        fp = fp[0];
>>> +        ++count;
>>> +    }
>>> +    printf("\n");
>>> +}
>>> +
>>>   /*
>>>    * Try to "emulate" a semihosting call in the event that we don't 
>>> have a
>>>    * debugger attached.
>>> @@ -149,6 +179,8 @@ void do_bad_sync(struct pt_regs *pt_regs)
>>>       printf("Bad mode in \"Synchronous Abort\" handler, esr 0x%08lx\n",
>>>              pt_regs->esr);
>>>       show_regs(pt_regs);
>>> +    if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>>> +        show_backtrace(pt_regs);
>>>       show_efi_loaded_images(pt_regs);
>>>       panic("Resetting CPU ...\n");
>>>   }
>>> @@ -161,6 +193,8 @@ void do_bad_irq(struct pt_regs *pt_regs)
>>>       efi_restore_gd();
>>>       printf("Bad mode in \"Irq\" handler, esr 0x%08lx\n", pt_regs- 
>>> >esr);
>>>       show_regs(pt_regs);
>>> +    if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>>> +        show_backtrace(pt_regs);
>>>       show_efi_loaded_images(pt_regs);
>>>       panic("Resetting CPU ...\n");
>>>   }
>>> @@ -173,6 +207,8 @@ void do_bad_fiq(struct pt_regs *pt_regs)
>>>       efi_restore_gd();
>>>       printf("Bad mode in \"Fiq\" handler, esr 0x%08lx\n", pt_regs- 
>>> >esr);
>>>       show_regs(pt_regs);
>>> +    if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>>> +        show_backtrace(pt_regs);
>>>       show_efi_loaded_images(pt_regs);
>>>       panic("Resetting CPU ...\n");
>>>   }
>>> @@ -185,6 +221,8 @@ void do_bad_error(struct pt_regs *pt_regs)
>>>       efi_restore_gd();
>>>       printf("Bad mode in \"Error\" handler, esr 0x%08lx\n", pt_regs- 
>>> >esr);
>>>       show_regs(pt_regs);
>>> +    if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>>> +        show_backtrace(pt_regs);
>>>       show_efi_loaded_images(pt_regs);
>>>       panic("Resetting CPU ...\n");
>>>   }
>>> @@ -202,6 +240,8 @@ void do_sync(struct pt_regs *pt_regs)
>>>       dump_far(pt_regs->esr);
>>>       printf("\n");
>>>       show_regs(pt_regs);
>>> +    if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>>> +        show_backtrace(pt_regs);
>>>       show_efi_loaded_images(pt_regs);
>>>       panic("Resetting CPU ...\n");
>>>   }
>>> @@ -214,6 +254,8 @@ void do_irq(struct pt_regs *pt_regs)
>>>       efi_restore_gd();
>>>       printf("\"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
>>>       show_regs(pt_regs);
>>> +    if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>>> +        show_backtrace(pt_regs);
>>>       show_efi_loaded_images(pt_regs);
>>>       panic("Resetting CPU ...\n");
>>>   }
>>> @@ -226,6 +268,8 @@ void do_fiq(struct pt_regs *pt_regs)
>>>       efi_restore_gd();
>>>       printf("\"Fiq\" handler, esr 0x%08lx\n", pt_regs->esr);
>>>       show_regs(pt_regs);
>>> +    if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>>> +        show_backtrace(pt_regs);
>>>       show_efi_loaded_images(pt_regs);
>>>       panic("Resetting CPU ...\n");
>>>   }
>>> @@ -241,6 +285,8 @@ void __weak do_error(struct pt_regs *pt_regs)
>>>       efi_restore_gd();
>>>       printf("\"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
>>>       show_regs(pt_regs);
>>> +    if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>>> +        show_backtrace(pt_regs);
>>>       show_efi_loaded_images(pt_regs);
>>>       panic("Resetting CPU ...\n");
>>>   }
> 
> 

-- 
Casey (she/they)

