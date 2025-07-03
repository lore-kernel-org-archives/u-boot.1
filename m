Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8D3C83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 12:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 065A282103;
	Thu,  3 Jul 2025 14:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="o8M0LDB9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB3A2822D7; Thu,  3 Jul 2025 14:08:39 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7846580E9A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 14:08:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B9F263F849
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 12:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1751544515;
 bh=P/bw7CNoYy0azPIP62FgIcZDyqXUgELI9Z7YoQPkkkc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=o8M0LDB9z4JXpD35NqNGlzbtaUT18hNGlEz79Mzs41VGi+MVOeNS1vxb1GUfYagG8
 pD1V0hs6l1VubaGmDrW9WU4PomkrB9Zy1HqpdW40l+Bk/j4LhK7H0Mzv4VcLVpNcyY
 WmKjKsdjGuMIeiPR0Qern1cYJ/7Oiw+eEaYwasar7gRFboBg5BtPXFDzQ5+EusdzKI
 bfgYw7noEh7v2W0hlAKBensoY61pB138FFjfXC46/Oyodb0kIVaQS/wT00psw9214m
 9fr9lAqEU4XBfbevQi4DuM06LkIzDfZPc18yrVLvuhzObMl8UrlouocqlCS20+7YjA
 H88kjI5cj+nhQ==
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-60c3a8f370aso6809465a12.3
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 05:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751544515; x=1752149315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P/bw7CNoYy0azPIP62FgIcZDyqXUgELI9Z7YoQPkkkc=;
 b=Ux+SPsn7oymihz2sEPB/CjP7O+wjMTxZkFYGbwfSbIbwRzkL6H2N8ds58va5neTHnd
 AFu2RNG4+domBrjpjKScyyLWp46kZ3ucMHAFO0fDDrGhUD2kIP3QZsUtKg9JMa1gUY7H
 pmzLao8Hz/FK/VOp7WFdItNcXxFg0k+ChLvT/vLC4Zy0QOn6q/wT/Xkp9+zP83YmWKU+
 rJ9Y+0X4Frbb11mxgs/HNO2Xab+o4TQkeqifbma5CAn8DmUyU3IX5c1rgOoFvK8kh7O+
 1Iz0HrY4JlUCPHMQaRaIOI2GeOD0zrrz8zVIAmzT5LBzTgGiH6hwolBbkk3nre1wQXsi
 Tn3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXER6b1om0HSKhvIdS61iajS7+q8vfEqWkqQea/xry7wjANtkfzSf9HkTU1+hYTejNlitUO3VI=@lists.denx.de
X-Gm-Message-State: AOJu0YzuHn7eIXXIaTsboQ391ndHet/j+O7YX2lZGo4jk3oOphy17IIX
 zEGvdFCS+PTnpkzX8cMUbqE441d+dSfdaRHax9S8tnkLPrLrd52Lnzj8J9Tm51XpEDlBpoNiTak
 t0kTI3JFXDZUBdF+2ozGCRH7LoDXV6fDdK3pJH/RZRBEUjZxCpw+oN6qkNewUnN6eqXm4eFo=
X-Gm-Gg: ASbGnctztm4yc1HBempevvV2blVZTX24wPe4E/dST7CUI1qbHSCcHB4eorTWk63xyMY
 nadCiVFqpBYNjzgjB0ysJ+aXap0PN5N7uszRGJREufuLMgDpSseiIL28NKITbtxQUMdmncbdKKJ
 Pmnlvgu6834j0Z3mauUYzd26HbrqmAqRm76hrM/hXINcMMa7RYsHweQnhEoNk98eqjnvtUSHa6L
 ie3xdq3DZCqA/07jdNDyTPAuD4JhGrxjNfSdC6aOp7ZhJOS1QS+Q8TKGyRiSbeJCMWBJUMiqG2e
 /6XzxXOJrayR+Np9xw93oIy5QHotng1tKM3PR+OpOwB1jinCiMqm+b4W3bxeNcyN0fAcn6h4Udk
 WmTkDYkPW4yUY64btYd0=
X-Received: by 2002:a05:6402:4415:b0:606:9211:e293 with SMTP id
 4fb4d7f45d1cf-60e52cfb659mr5622696a12.9.1751544514850; 
 Thu, 03 Jul 2025 05:08:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSdepBAecaQK7VsvhAUzZwCM45wnvJ0lmeStu+/iTnWn3ynHdOokYsrSeYckJkW+j3E5Jznw==
X-Received: by 2002:a05:6402:4415:b0:606:9211:e293 with SMTP id
 4fb4d7f45d1cf-60e52cfb659mr5622643a12.9.1751544514207; 
 Thu, 03 Jul 2025 05:08:34 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60c831d25cdsm10670918a12.64.2025.07.03.05.08.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 05:08:33 -0700 (PDT)
Message-ID: <78c0ab6b-cbc4-4cfe-9144-dfb2b9bba801@canonical.com>
Date: Thu, 3 Jul 2025 14:08:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: implement printing backtraces
To: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
References: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
 <20250703051951.43372-4-heinrich.schuchardt@canonical.com>
 <788df6dc-fa00-4462-a61c-5878a5f9ddeb@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <788df6dc-fa00-4462-a61c-5878a5f9ddeb@linaro.org>
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

On 03.07.25 13:39, Casey Connolly wrote:
>
> On 03/07/2025 07:19, Heinrich Schuchardt wrote:
>> Add a function to print frame pointers depending on symbols
>> CONFIG_(SPL)_FRAMEPOINTER.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   arch/arm/Makefile            |  9 ++++++-
>>   arch/arm/lib/interrupts_64.c | 46 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 54 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>> index 5ecadb2ef1b..41e75b5bcb1 100644
>> --- a/arch/arm/Makefile
>> +++ b/arch/arm/Makefile
>> @@ -33,6 +33,13 @@ endif
>>   # Evaluate arch cc-option calls now
>>   arch-y := $(arch-y)
>>   
>> +ifeq ($(CONFIG_$(PHASE_)FRAMEPOINTER),y)
>> +	ARCH_FLAGS += -fno-omit-frame-pointer
> from my testing, current arm64 builds of U-Boot will make use of a frame
> pointer, it seems to be the default.

The built-in defaults may depend on the distro providing the compiler 
and may be different on LLVM and GCC.

>
> So if CONFIG_FRAMEPOINTER is disabled we should explicitly add the
> -fomit-frame-pointer flag I think? Or we ignore CONFIG_FRAMEPOINTER for
> arm64 and accept that we always have a framepointer (I'm not sure how
> significant the space saving really is here).
>
>> +endif
>> +
>> +PLATFORM_CPPFLAGS	+= $(ARCH_FLAGS)
>> +CFLAGS_EFI		+= $(ARCH_FLAGS)
>> +
>>   # This selects how we optimise for the processor.
>>   tune-$(CONFIG_CPU_ARM720T)	=-mtune=arm7tdmi
>>   tune-$(CONFIG_CPU_ARM920T)	=
>> @@ -47,7 +54,7 @@ tune-$(CONFIG_ARM64)		=
>>   # Evaluate tune cc-option calls now
>>   tune-y := $(tune-y)
>>   
>> -PLATFORM_CPPFLAGS += $(arch-y) $(tune-y)
>> +PLATFORM_CPPFLAGS += $(ARCH_FLAGS) $(arch-y) $(tune-y)
>>   
>>   # Machine directory name.  This list is sorted alphanumerically
>>   # by CONFIG_* macro name.
>> diff --git a/arch/arm/lib/interrupts_64.c b/arch/arm/lib/interrupts_64.c
>> index b3024ba514e..970f8b6831f 100644
>> --- a/arch/arm/lib/interrupts_64.c
>> +++ b/arch/arm/lib/interrupts_64.c
>> @@ -98,6 +98,35 @@ void show_regs(struct pt_regs *regs)
>>   	dump_instr(regs);
>>   }
>>   
>> +/**
>> + * show_backtrace() - show backtrace using frame pointers
>> + *
>> + * @regs - registers
>> + */
>> +static void show_backtrace(struct pt_regs *regs)
>> +{
>> +	void **fp = (void **)regs->regs[29];
>> +	unsigned int count = 0;
>> +	void *lr;
>> +
>> +	printf("\nbacktrace:\n");
> This should be a capital 'B' as with the other headers.

ok

>
> In my series the output looks like:
>
> Backtrace:
> 	<0x000001ffdfb344> do_mem_mw+0xbc
> 	<0x000001ffe0f07c> cmd_process+0x130
> 	<0x000001ffe06440> run_list_real+0x6d0
> 	<0x000001ffe065cc> parse_stream_outer+0x14c
> 	<0x000001ffe06b10> parse_file_outer+0x34
> 	<0x000001ffe0e3a4> cli_loop+0x18
> 	<0x000001ffe03b9c> main_loop+0x74
> 	<0x000001ffe07984> board_init_r+0x3c8

Please, provide a link to your series.

Showing function names would be great.

Best regards

Heinrich

>
> The aim was to match how the kernel backtraces look. I think it makes
> sense to do that here too.
>
>> +
>> +	while (fp) {
>> +		lr = fp[1];
>> +		printf("%3d: fp: %p lr: %p",
>> +		       count, fp, lr);
> The address of the framepointer isn't so interesting, neither is the
> index imo. I think the useful info here is the address of the function
> and the offset from that to lr.
>
> Printing the lr pre and post relocation does maybe make sense though, to
> be useful for interactive debugging or analyzing an objdump.
>
> Kind regards,
>
>> +
>> +		if (gd && gd->flags & GD_FLG_RELOC)
>> +			printf(" - %p (reloc)\n", lr - gd->reloc_off);
>> +		else
>> +			printf("\n");
>> +
>> +		fp = fp[0];
>> +		++count;
>> +	}
>> +	printf("\n");
>> +}
>> +
>>   /*
>>    * Try to "emulate" a semihosting call in the event that we don't have a
>>    * debugger attached.
>> @@ -149,6 +179,8 @@ void do_bad_sync(struct pt_regs *pt_regs)
>>   	printf("Bad mode in \"Synchronous Abort\" handler, esr 0x%08lx\n",
>>   	       pt_regs->esr);
>>   	show_regs(pt_regs);
>> +	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>> +		show_backtrace(pt_regs);
>>   	show_efi_loaded_images(pt_regs);
>>   	panic("Resetting CPU ...\n");
>>   }
>> @@ -161,6 +193,8 @@ void do_bad_irq(struct pt_regs *pt_regs)
>>   	efi_restore_gd();
>>   	printf("Bad mode in \"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
>>   	show_regs(pt_regs);
>> +	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>> +		show_backtrace(pt_regs);
>>   	show_efi_loaded_images(pt_regs);
>>   	panic("Resetting CPU ...\n");
>>   }
>> @@ -173,6 +207,8 @@ void do_bad_fiq(struct pt_regs *pt_regs)
>>   	efi_restore_gd();
>>   	printf("Bad mode in \"Fiq\" handler, esr 0x%08lx\n", pt_regs->esr);
>>   	show_regs(pt_regs);
>> +	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>> +		show_backtrace(pt_regs);
>>   	show_efi_loaded_images(pt_regs);
>>   	panic("Resetting CPU ...\n");
>>   }
>> @@ -185,6 +221,8 @@ void do_bad_error(struct pt_regs *pt_regs)
>>   	efi_restore_gd();
>>   	printf("Bad mode in \"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
>>   	show_regs(pt_regs);
>> +	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>> +		show_backtrace(pt_regs);
>>   	show_efi_loaded_images(pt_regs);
>>   	panic("Resetting CPU ...\n");
>>   }
>> @@ -202,6 +240,8 @@ void do_sync(struct pt_regs *pt_regs)
>>   	dump_far(pt_regs->esr);
>>   	printf("\n");
>>   	show_regs(pt_regs);
>> +	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>> +		show_backtrace(pt_regs);
>>   	show_efi_loaded_images(pt_regs);
>>   	panic("Resetting CPU ...\n");
>>   }
>> @@ -214,6 +254,8 @@ void do_irq(struct pt_regs *pt_regs)
>>   	efi_restore_gd();
>>   	printf("\"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
>>   	show_regs(pt_regs);
>> +	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>> +		show_backtrace(pt_regs);
>>   	show_efi_loaded_images(pt_regs);
>>   	panic("Resetting CPU ...\n");
>>   }
>> @@ -226,6 +268,8 @@ void do_fiq(struct pt_regs *pt_regs)
>>   	efi_restore_gd();
>>   	printf("\"Fiq\" handler, esr 0x%08lx\n", pt_regs->esr);
>>   	show_regs(pt_regs);
>> +	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>> +		show_backtrace(pt_regs);
>>   	show_efi_loaded_images(pt_regs);
>>   	panic("Resetting CPU ...\n");
>>   }
>> @@ -241,6 +285,8 @@ void __weak do_error(struct pt_regs *pt_regs)
>>   	efi_restore_gd();
>>   	printf("\"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
>>   	show_regs(pt_regs);
>> +	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>> +		show_backtrace(pt_regs);
>>   	show_efi_loaded_images(pt_regs);
>>   	panic("Resetting CPU ...\n");
>>   }


