Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14606C02190
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 09:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99E0781FEE;
	Thu, 30 Jan 2025 10:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ijsZQPC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5829481FF1; Thu, 30 Jan 2025 10:09:41 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6286280B9B
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 10:09:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso5528085e9.0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 01:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738228179; x=1738832979; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AnKzjbSduxxJZZJF3bXYvYWVsULE0+glw27YN22LLkk=;
 b=ijsZQPC6M4j/LLOoKZHPRgLaCV5CeTVIpSh/gOVWXmwvoDtSgG2oEttFy91BxKndAi
 9aQjAaqWyaDp+auye7waEf7XwiAV28pZSHNtsGOzGHTmuO3twVZWkPXmUoLmXDNgEke+
 rXr06vPWCx+CebvUgXWk6vaeFdx2D1/U8dejNd4ijPYJvJrvHcCdRcgONNDGgZrcI1BG
 ZbdlngMFlJycHWi1uauWWIWYmXs5of27vn3KE5jd9o0hzGwOKyVq5i7bgCyW6xlUILBs
 Bwoo96+PhoGMoEuyaI9u+PLp5F1mbBHKl2HPew2b3bS/mEa//nVPsRt7pj0uBLWK2dgi
 BJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738228179; x=1738832979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AnKzjbSduxxJZZJF3bXYvYWVsULE0+glw27YN22LLkk=;
 b=UoVCue3ifT+FWVI9ui0C6+3R95JpRb3/N2ja1dso0RPuin50mHJIK/XQ4tO43JPq0z
 sAA8O4nqkrbVnGOzOn/X5nAFSHalripGo5uaFFt89awKBaGOEMnKtBx6iERAV8OOrr3B
 A3fSjfqA3p0Ff1OyI25BN8t5aAWbiqFW/HKe8/wBSoKz1nbd7c13K2tTv+RMkkw7lRB4
 3JwbnNbgapm3jEbUVSdlaEQpSfB9J8ZLvXEmJKPmTGcvxWxyin7O1jcerHCfu7qTUk+6
 bfaMNeJ4nrmMgXw6EYq8ThoIdVpf5FfbN5eMMf1g/wINax5am0yHFMyVo8u/Y/O11XPO
 ym/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjb8dpjBItT39haok0L+82H1Qt2sU0ahsRJonuZKj3YWylm1rX4d9Aw6nZmDJPbUqjKp2C80M=@lists.denx.de
X-Gm-Message-State: AOJu0YyIZH13a0wpcDDbmz0zrxXsczcms9xQfPSGAzc35uF+379qPlKK
 /win7JQ9aHXjwX7zaQTFry6brthJ0rESUyrEk/F64AAquNqOHdrqvwEf13p5d3c=
X-Gm-Gg: ASbGncsRdfVwVJ/HFL+tnMQwnKoPKvv8U28QS/E//Qs3M8tOtC+y5yGpen8Uq91BhJ4
 v5Oz1t2mqjXAfAaUrqj2oJnhST33jk3LFlH1UNAcJVqQsG5QliJQGCBhLa3ZtNuIaiIlkhSyucM
 77vGEio8T435FXxIEKIxP/ud1pWEkBZERIbGpEwf5JOn7NCzZY5nvNma8GzrzDniKtj1VULKIIy
 ApdvjOcvGQW6IujlJn2b0tJic7rlRad95T6toF87URjgliKyAKF+YjYg6OxxBnGirrVgqx49juP
 1xXtJIaeSXYcVEeh2vSqVq7BST5wDkcUJy6ohZiInSVMJcl13DaFiuGnoJhaQCs1NPEDep4=
X-Google-Smtp-Source: AGHT+IFXa36/p9LrBfRv1Ewz8Y1lxas1+/f1Xb5v7in8fjLRnXhrBvJMKyf5217gzh3t6tBjBlp9PQ==
X-Received: by 2002:a5d:4311:0:b0:38b:f074:214c with SMTP id
 ffacd0b85a97d-38c5195e234mr3968193f8f.30.1738228178730; 
 Thu, 30 Jan 2025 01:09:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:14f6:2931:46df:28c5?
 ([2a01:e0a:3cb:7bb0:14f6:2931:46df:28c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0ecc80sm1392985f8f.16.2025.01.30.01.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 01:09:38 -0800 (PST)
Message-ID: <21b86615-7538-4a65-b12d-1ef86f4861de@linaro.org>
Date: Thu, 30 Jan 2025 10:09:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] arm: Prepare linker scripts for memory permissions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, maz@kernel.org,
 trini@konsulko.com, CFSworks@gmail.com
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
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
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250130072100.27297-3-ilias.apalodimas@linaro.org>
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

Hi Ilias,

On 1/30/25 08:20, Ilias Apalodimas wrote:
> Upcoming patches are switching the memory mappings to RW, RO, RW^X page
> permissions after the U-Boot binary and its data are relocated. Add
> annotations in the linker scripts to and mark text, data, rodata etc
> sections and align them to a page boundary
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  Makefile                       | 15 +++++++++------
>  arch/arm/cpu/armv8/u-boot.lds  | 32 +++++++++++++++++++-------------
>  include/asm-generic/sections.h |  2 ++
>  lib/efi_loader/efi_runtime.c   |  2 ++
>  4 files changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 33bb86343c5b..8d7c062ec830 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2176,13 +2176,16 @@ System.map:	u-boot
>  # ARM relocations should all be R_ARM_RELATIVE (32-bit) or
>  # R_AARCH64_RELATIVE (64-bit).
>  checkarmreloc: u-boot
> -	@RELOC="`$(CROSS_COMPILE)readelf -r -W $< | cut -d ' ' -f 4 | \
> +	@RELOCS="`$(CROSS_COMPILE)readelf -r -W $< | cut -d ' ' -f 4 | \
>  		grep R_A | sort -u`"; \
> -	if test "$$RELOC" != "R_ARM_RELATIVE" -a \
> -		 "$$RELOC" != "R_AARCH64_RELATIVE"; then \
> -		echo "$< contains unexpected relocations: $$RELOC"; \
> -		false; \
> -	fi
> +	for reloc in $$RELOCS; do \
> +		if [ "$$reloc" != "R_ARM_RELATIVE" -a \
> +		     "$$reloc" != "R_AARCH64_RELATIVE" -a \
> +		"$$reloc" != "R_AARCH64_NONE" ]; then \
> +			echo "$< contains unexpected relocations: $$reloc"; \
> +			false; \

s/false/exit 1/ otherwise the loop won't break and make won't get a
failure status unless the error is on the last reloc.

> +		fi; \
> +	done

This Makefile change seems unrelated to the current patch. Should it
go into a separate fixup patch?
 
>  tools/version.h: include/version.h
>  	$(Q)mkdir -p $(dir $@)
> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> index 857f44412e07..18e168e27135 100644
> --- a/arch/arm/cpu/armv8/u-boot.lds
> +++ b/arch/arm/cpu/armv8/u-boot.lds
> @@ -22,7 +22,7 @@ SECTIONS
>  
>  	. = ALIGN(8);
>  	__image_copy_start = ADDR(.text);
> -	.text :
> +	.text ALIGN(4096):
>  	{
>  		CPUDIR/start.o (.text*)
>  	}
> @@ -36,9 +36,12 @@ SECTIONS
>                  __efi_runtime_stop = .;
>  	}
>  
> -	.text_rest :
> +	.text_rest ALIGN(4096) :
>  	{
> +		__text_start = .;
>  		*(.text*)
> +		. = ALIGN(4096);
> +		__text_end = .;
>  	}
>  
>  #ifdef CONFIG_ARMV8_PSCI
> @@ -98,27 +101,30 @@ SECTIONS
>  	}
>  #endif
>  
> -	. = ALIGN(8);
> -	.rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
> +	.rodata ALIGN(4096): {
> +	    __start_rodata = .;
> +	    *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
> +	    . = ALIGN(4096);
> +	    __end_rodata = .;
> +	}
>  
> -	. = ALIGN(8);
> -	.data : {
> +	.data ALIGN(4096) : {
> +	    __start_data = .;
>  		*(.data*)
> +	    . = ALIGN(4096);
> +	    __end_data = .;
>  	}
>  
> -	. = ALIGN(8);
> -
> -	. = .;
> -
>  	. = ALIGN(8);
>  	__u_boot_list : {
>  		KEEP(*(SORT(__u_boot_list*)));
>  	}
>  
> -	.efi_runtime_rel : {
> +	.efi_runtime_rel ALIGN(4096) : {
>                  __efi_runtime_rel_start = .;
>  		*(.rel*.efi_runtime)
>  		*(.rel*.efi_runtime.*)
> +		. = ALIGN(4096);
>                  __efi_runtime_rel_stop = .;
>  	}
>  
> @@ -136,10 +142,10 @@ SECTIONS
>  	/*
>  	 * arch/arm/lib/crt0_64.S assumes __bss_start - __bss_end % 8 == 0
>  	 */
> -	.bss ALIGN(8) : {
> +	.bss ALIGN(4096) : {
>  		__bss_start = .;
>  		*(.bss*)
> -		. = ALIGN(8);
> +		. = ALIGN(4096);
>  		__bss_end = .;
>  	}
>  
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> index b6bca53db10d..5626df796f33 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -23,6 +23,7 @@ extern char __kprobes_text_start[], __kprobes_text_end[];
>  extern char __entry_text_start[], __entry_text_end[];
>  extern char __initdata_begin[], __initdata_end[];
>  extern char __start_rodata[], __end_rodata[];
> +extern char __start_data[], __end_data[];
>  extern char __efi_helloworld_begin[];
>  extern char __efi_helloworld_end[];
>  extern char __efi_var_file_begin[];
> @@ -63,6 +64,7 @@ static inline int arch_is_kernel_data(unsigned long addr)
>  
>  /* Start of U-Boot text region */
>  extern char __text_start[];
> +extern char __text_end[];
>  
>  /* This marks the text region which must be relocated */
>  extern char __image_copy_start[], __image_copy_end[];
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index 35eb6a777665..c10a79301a92 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -742,6 +742,8 @@ void efi_runtime_relocate(ulong offset, struct efi_mem_desc *map)
>  		      rel->info, *p, rel->offset);
>  
>  		switch (rel->info & R_MASK) {
> +		case 0:
> +			break;

It looks like this may need to go into the same fixup patch as the
Makefile changes above.

>  		case R_RELATIVE:
>  #ifdef IS_RELA
>  		newaddr = rel->addend + offset - CONFIG_TEXT_BASE;

For the linker script changes:

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
