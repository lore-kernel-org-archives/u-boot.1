Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E840C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 11:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1F482E08;
	Thu,  3 Jul 2025 13:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v75Yxt33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CB7682EA9; Thu,  3 Jul 2025 13:39:09 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37F7782103
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 13:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so43764905e9.3
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 04:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751542745; x=1752147545; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cHP3TDFD+sX7WtStvLV2mnSRvgr4yMHrKL+p09sotBE=;
 b=v75Yxt33RKGbNwQbzKwRF3qsSvih7/R80CIwA06uzREye/pADzYYDgq9RY7Z9GnNU+
 JvnVf8ESuA0yB5Nxhskd4yoGHBKOiE4nO3Md8xwuVv/Bczdv73+7wf5+Dc4ouw2+sVC1
 4NbFPvuSylAAQ/AhVc0aaSgGpySggNBaOhXh+E1EXCNvCkfQJNrhZoejiT0U6giO2m7b
 lzjEtHQxDkdIC0lotZU7ajMTLFYDJR59PAzWbeei9ukJdaACnUVmN/SCjIcnT6HpNR1l
 LzQRp/0Ds9YnyZY3PkaaY51ac/aBQnP6HQr5PwvgVivRg+dFFd/w6VSnFLdsCoSAFfQt
 0o1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751542745; x=1752147545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cHP3TDFD+sX7WtStvLV2mnSRvgr4yMHrKL+p09sotBE=;
 b=L92mOShgEh4ctN5qRsVi2Ntxh3uMushslRZyl7fCf16FV89bGuIflRwdsfyk9vd6r1
 Q4dM3GMr8ekcpgIZBNxxzuoiEspkEY5R2cUjco+7a5isHI6RFXeACXBCNzzCJYrlRaJs
 tfxrCcCNjDrF5Af2GBzG6VlJBa7dy0Vj8wsuxDvK4Fsgsb5KsMZ6W3QP6EGfpi7ZGX/6
 ZKkS2lbKmdG62vG4aADx6G7ZTjZMyYamK+M9h67fInWojBUjmqaEPaZYh3KQrTCLN1kA
 02tgX1/pXyfcsJB2whEmz8AsauT1WwNVKglKLIpwTW0Gj21/5PxNZ8e3cvHPOyKYpHqh
 giKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsYm9a2t89gwprZPCtQBTY82TkSiAxK9bhQtDr5N5haSZA2ZWQjzJFN3pDUeWD/VhqKPya0U4=@lists.denx.de
X-Gm-Message-State: AOJu0YwPhaHwiUMmFHTFMJ3GTVzq1gbBKOx4xRWHzb43sgyVbWHvwWmG
 o4PHnlpxS1Vs8HviIG4luTceNz2LvmyhbWceuKjJOPssnbhohaSRZ066AI8lwCveZ5o=
X-Gm-Gg: ASbGncvuxj5BevfrDqgB0juVpa9MV7NeD0h46laYkSIipGscNoako5zK0zt+ZHs8dyI
 ho8h7UJS+JfBz1UskcwHAXQIXB5HaJp2K/UyGBg9Pnt1Ng2KaTEM0UTEiR6TVloQIJRelt3sQdv
 3tTVaI346ZnqZQ/8mhBjJzayXmJ221fhx7GkAgnoXBYpNfyDZrPgdpc3mAomLs4y4hva3/b0Kyr
 6doqjQDeyz1ZbeYDiXVRlvFKrIvrMCoM7qKX1J44+vIgWK+HIdWZDji6htrHioGOPyz5+eQVih3
 mLI+idszNxf5ysb+2tQvfR4fM+bXOF+LsiOt5DdCUtvXAi6NWMG5d3NZtilQQbQyqZM2wqYCTjf
 M0K6GgpTTsQ2FantanqGdHQfEVZpEePsLDwNSVS0=
X-Google-Smtp-Source: AGHT+IEkTZCKHkDHROD3wmg1cN36thgy+tYhh9GoyBrYnEjNjeClwF+7ovL0PPR33jOD2nUlj/OTYg==
X-Received: by 2002:a05:600c:638e:b0:453:59c2:e4f8 with SMTP id
 5b1f17b1804b1-454a36d80d6mr58229225e9.1.1751542745327; 
 Thu, 03 Jul 2025 04:39:05 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3d084.dip0.t-ipconnect.de. [79.195.208.132])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bde8c8sm24753235e9.31.2025.07.03.04.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 04:39:04 -0700 (PDT)
Message-ID: <788df6dc-fa00-4462-a61c-5878a5f9ddeb@linaro.org>
Date: Thu, 3 Jul 2025 13:39:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: implement printing backtraces
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
References: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
 <20250703051951.43372-4-heinrich.schuchardt@canonical.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250703051951.43372-4-heinrich.schuchardt@canonical.com>
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



On 03/07/2025 07:19, Heinrich Schuchardt wrote:
> Add a function to print frame pointers depending on symbols
> CONFIG_(SPL)_FRAMEPOINTER.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/arm/Makefile            |  9 ++++++-
>  arch/arm/lib/interrupts_64.c | 46 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 5ecadb2ef1b..41e75b5bcb1 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -33,6 +33,13 @@ endif
>  # Evaluate arch cc-option calls now
>  arch-y := $(arch-y)
>  
> +ifeq ($(CONFIG_$(PHASE_)FRAMEPOINTER),y)
> +	ARCH_FLAGS += -fno-omit-frame-pointer

from my testing, current arm64 builds of U-Boot will make use of a frame
pointer, it seems to be the default.

So if CONFIG_FRAMEPOINTER is disabled we should explicitly add the
-fomit-frame-pointer flag I think? Or we ignore CONFIG_FRAMEPOINTER for
arm64 and accept that we always have a framepointer (I'm not sure how
significant the space saving really is here).

> +endif
> +
> +PLATFORM_CPPFLAGS	+= $(ARCH_FLAGS)
> +CFLAGS_EFI		+= $(ARCH_FLAGS)
> +
>  # This selects how we optimise for the processor.
>  tune-$(CONFIG_CPU_ARM720T)	=-mtune=arm7tdmi
>  tune-$(CONFIG_CPU_ARM920T)	=
> @@ -47,7 +54,7 @@ tune-$(CONFIG_ARM64)		=
>  # Evaluate tune cc-option calls now
>  tune-y := $(tune-y)
>  
> -PLATFORM_CPPFLAGS += $(arch-y) $(tune-y)
> +PLATFORM_CPPFLAGS += $(ARCH_FLAGS) $(arch-y) $(tune-y)
>  
>  # Machine directory name.  This list is sorted alphanumerically
>  # by CONFIG_* macro name.
> diff --git a/arch/arm/lib/interrupts_64.c b/arch/arm/lib/interrupts_64.c
> index b3024ba514e..970f8b6831f 100644
> --- a/arch/arm/lib/interrupts_64.c
> +++ b/arch/arm/lib/interrupts_64.c
> @@ -98,6 +98,35 @@ void show_regs(struct pt_regs *regs)
>  	dump_instr(regs);
>  }
>  
> +/**
> + * show_backtrace() - show backtrace using frame pointers
> + *
> + * @regs - registers
> + */
> +static void show_backtrace(struct pt_regs *regs)
> +{
> +	void **fp = (void **)regs->regs[29];
> +	unsigned int count = 0;
> +	void *lr;
> +
> +	printf("\nbacktrace:\n");

This should be a capital 'B' as with the other headers.

In my series the output looks like:

Backtrace:
	<0x000001ffdfb344> do_mem_mw+0xbc
	<0x000001ffe0f07c> cmd_process+0x130
	<0x000001ffe06440> run_list_real+0x6d0
	<0x000001ffe065cc> parse_stream_outer+0x14c
	<0x000001ffe06b10> parse_file_outer+0x34
	<0x000001ffe0e3a4> cli_loop+0x18
	<0x000001ffe03b9c> main_loop+0x74
	<0x000001ffe07984> board_init_r+0x3c8

The aim was to match how the kernel backtraces look. I think it makes
sense to do that here too.

> +
> +	while (fp) {
> +		lr = fp[1];
> +		printf("%3d: fp: %p lr: %p",
> +		       count, fp, lr);

The address of the framepointer isn't so interesting, neither is the
index imo. I think the useful info here is the address of the function
and the offset from that to lr.

Printing the lr pre and post relocation does maybe make sense though, to
be useful for interactive debugging or analyzing an objdump.

Kind regards,

> +
> +		if (gd && gd->flags & GD_FLG_RELOC)
> +			printf(" - %p (reloc)\n", lr - gd->reloc_off);
> +		else
> +			printf("\n");
> +
> +		fp = fp[0];
> +		++count;
> +	}
> +	printf("\n");
> +}
> +
>  /*
>   * Try to "emulate" a semihosting call in the event that we don't have a
>   * debugger attached.
> @@ -149,6 +179,8 @@ void do_bad_sync(struct pt_regs *pt_regs)
>  	printf("Bad mode in \"Synchronous Abort\" handler, esr 0x%08lx\n",
>  	       pt_regs->esr);
>  	show_regs(pt_regs);
> +	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> +		show_backtrace(pt_regs);
>  	show_efi_loaded_images(pt_regs);
>  	panic("Resetting CPU ...\n");
>  }
> @@ -161,6 +193,8 @@ void do_bad_irq(struct pt_regs *pt_regs)
>  	efi_restore_gd();
>  	printf("Bad mode in \"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
>  	show_regs(pt_regs);
> +	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> +		show_backtrace(pt_regs);
>  	show_efi_loaded_images(pt_regs);
>  	panic("Resetting CPU ...\n");
>  }
> @@ -173,6 +207,8 @@ void do_bad_fiq(struct pt_regs *pt_regs)
>  	efi_restore_gd();
>  	printf("Bad mode in \"Fiq\" handler, esr 0x%08lx\n", pt_regs->esr);
>  	show_regs(pt_regs);
> +	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> +		show_backtrace(pt_regs);
>  	show_efi_loaded_images(pt_regs);
>  	panic("Resetting CPU ...\n");
>  }
> @@ -185,6 +221,8 @@ void do_bad_error(struct pt_regs *pt_regs)
>  	efi_restore_gd();
>  	printf("Bad mode in \"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
>  	show_regs(pt_regs);
> +	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> +		show_backtrace(pt_regs);
>  	show_efi_loaded_images(pt_regs);
>  	panic("Resetting CPU ...\n");
>  }
> @@ -202,6 +240,8 @@ void do_sync(struct pt_regs *pt_regs)
>  	dump_far(pt_regs->esr);
>  	printf("\n");
>  	show_regs(pt_regs);
> +	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> +		show_backtrace(pt_regs);
>  	show_efi_loaded_images(pt_regs);
>  	panic("Resetting CPU ...\n");
>  }
> @@ -214,6 +254,8 @@ void do_irq(struct pt_regs *pt_regs)
>  	efi_restore_gd();
>  	printf("\"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
>  	show_regs(pt_regs);
> +	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> +		show_backtrace(pt_regs);
>  	show_efi_loaded_images(pt_regs);
>  	panic("Resetting CPU ...\n");
>  }
> @@ -226,6 +268,8 @@ void do_fiq(struct pt_regs *pt_regs)
>  	efi_restore_gd();
>  	printf("\"Fiq\" handler, esr 0x%08lx\n", pt_regs->esr);
>  	show_regs(pt_regs);
> +	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> +		show_backtrace(pt_regs);
>  	show_efi_loaded_images(pt_regs);
>  	panic("Resetting CPU ...\n");
>  }
> @@ -241,6 +285,8 @@ void __weak do_error(struct pt_regs *pt_regs)
>  	efi_restore_gd();
>  	printf("\"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
>  	show_regs(pt_regs);
> +	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> +		show_backtrace(pt_regs);
>  	show_efi_loaded_images(pt_regs);
>  	panic("Resetting CPU ...\n");
>  }
-- 
// Casey (she/her)

