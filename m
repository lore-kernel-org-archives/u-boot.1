Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CAEC54E66
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 22:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A58587F0E;
	Wed, 13 Mar 2024 23:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GaIVR8wc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A96187ED3; Wed, 13 Mar 2024 23:58:03 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DEE187EDC
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 23:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-366219c3916so2205065ab.3
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 15:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710370679; x=1710975479; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aNMhoHHwHySBxlm6IAoEVCf3ARvBJACjztGUQemVO08=;
 b=GaIVR8wcdjfG3OAzvbRXmQe4WICmkFSssgwVhQefE22MsLZpVNESdDxKNF/O+b7Joh
 49/aoP6QyVcEyytebSTivDkNp7GAcCE+28F2AuArjP8bhqrAHgluPD9s8UxUN0Qfb1zw
 whmQ9iG8o2Gx8h7An6gQvJI0+LrAo1CBaURw3q1OQW9tij22/+2I1dtW22QWJtyoy7s/
 v8ZiwQ4EpbBAeHbTtW51sEMtEAy3o3wUHt2qbX4rp1r5EAk5OFnKwLZcZJEGsLjOGJl1
 jhGdpsrQhInram67UMC7PJnA2yq2tSRVj+R+Qw0Nf7OWxYtBIRHSV/ONt17Wj/xj6vcq
 Wo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710370679; x=1710975479;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aNMhoHHwHySBxlm6IAoEVCf3ARvBJACjztGUQemVO08=;
 b=ZypsxrUxOa/XxAKK7nSJIgpXRcnicFETS9Ln6Il4YSldwGkYlBQknyMkCENqXEmre5
 8rDGggDAQCK3+jCC8z8B5bZvGLU7l7q7j/7ThAeUS7zdvMzwsYv9B9vSOGddw+u2ZXhc
 ftFCq4DPT75z4bP1LLy5KdwLYwX2Gjx+KtbmsbHsMywK9lNT4sZjFptI7MBLBradPoRE
 PD++ff1KeLW1EJoHvVJzrxWuPEFYa2Mw98MWGXHtVOdSkius2K009AnvJ09LM10oj0mI
 qqmf1Is1a0XN30MSPUbqYpAmztEGMCFVsF26l7uGlgOeM/TddKMUo/xB0qUlJVWqcFWd
 okDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpdLgpPT68WUi75SqCol2MZzkbZ3f6cilhqOlaPcbs5fTjX1woADUpq0Q/46mktiyHCni8bS/htHct5hek2vBn/axAHg==
X-Gm-Message-State: AOJu0YyjBQAMtWYwbRZR7ZRBswrwZV8BzV740VQonu5ReaaS67JlUy4W
 gxyz+0NeZ0lfTvFKO5jUYDHk4LLuW4fu+Pz9GYoeHlSJAX1mAKtT
X-Google-Smtp-Source: AGHT+IEWjW7oBYPtdvc/GGt0KSSl9dcfv3B3M+rZ958tt4dM8GWF+aohEp7+QBwAlCQX/iI3B2SkLA==
X-Received: by 2002:a92:d14b:0:b0:365:fe9f:8037 with SMTP id
 t11-20020a92d14b000000b00365fe9f8037mr8831ilg.25.1710370678805; 
 Wed, 13 Mar 2024 15:57:58 -0700 (PDT)
Received: from ?IPV6:2001:470:42c4:101:4450:4d23:b034:a33d?
 ([2001:470:42c4:101:4450:4d23:b034:a33d])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a92c886000000b00366280c2484sm82476ilo.67.2024.03.13.15.57.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 15:57:58 -0700 (PDT)
Message-ID: <7a6ebdc1-835b-4527-8885-a650242bf295@gmail.com>
Date: Wed, 13 Mar 2024 16:57:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] arm: clean up v7 and v8 linker scripts for
 bss_start/end
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 trini@konsulko.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 richard.henderson@linaro.org, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
References: <20240313162324.2117909-1-ilias.apalodimas@linaro.org>
 <20240313162324.2117909-3-ilias.apalodimas@linaro.org>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20240313162324.2117909-3-ilias.apalodimas@linaro.org>
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



On 3/13/24 10:23, Ilias Apalodimas wrote:
> commit 3ebd1cbc49f0 ("arm: make __bss_start and __bss_end__ compiler-generated")
> and
> commit f84a7b8f54db ("ARM: Fix __bss_start and __bss_end in linker scripts")
> were moving the bss_start/end on c generated variables that were
> injected in their own sections. The reason was that we needed relative
> relocations for position independent code and linker bugs back then
> prevented us from doing so [0].
> 
> However, the linker documentation pages states that symbols that are
> defined within a section definition will create a relocatable type with
> the value being a fixed offset from the base of a section [1].
> So let's start cleaning this up starting with the bss_start and bss_end
> variables. Convert them into symbols within the .bss section definition.
> 
> [0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")
> [1] https://sourceware.org/binutils/docs/ld/Expression-Section.html
> 
> Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # Qualcomm sdm845
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   arch/arm/cpu/armv8/u-boot-spl.lds        | 18 +++++++-----------
>   arch/arm/cpu/armv8/u-boot.lds            | 16 ++++------------
>   arch/arm/cpu/u-boot.lds                  | 22 +++++++---------------
>   arch/arm/lib/sections.c                  |  2 --
>   arch/arm/mach-rockchip/u-boot-tpl-v8.lds | 15 ++++-----------
>   arch/arm/mach-zynq/u-boot.lds            | 22 +++++++---------------
>   6 files changed, 29 insertions(+), 66 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
> index 7cb9d731246d..692414fe46fb 100644
> --- a/arch/arm/cpu/armv8/u-boot-spl.lds
> +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> @@ -63,18 +63,11 @@ SECTIONS
>   
>   	_image_binary_end = .;
>   
> -	.bss_start (NOLOAD) : {
> -		. = ALIGN(8);
> -		KEEP(*(.__bss_start));
> -	} >.sdram
> -
> -	.bss (NOLOAD) : {
> +	.bss : {
> +		__bss_start = .;
>   		*(.bss*)
> -		 . = ALIGN(8);
> -	} >.sdram
> -
> -	.bss_end (NOLOAD) : {
> -		KEEP(*(.__bss_end));
> +		. = ALIGN(8);
> +		__bss_end = .;
>   	} >.sdram
>   
>   	/DISCARD/ : { *(.rela*) }
> @@ -89,3 +82,6 @@ SECTIONS
>   #include "linux-kernel-image-header-vars.h"
>   #endif
>   }
> +ASSERT(CONFIG_SPL_BSS_START_ADDR % 8 == 0, \
> +       "CONFIG_SPL_BSS_START_ADDR must be 8-byte aligned");
> +

Git complains about this added blank line at the end of the file. (My 
personal preference would be a blank line before the ASSERT, if the 
ASSERT is truly necessary.)

But beyond that:
Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical

Still really excited for this to land! I'm going to have to blow the 
dust off of my Clang/LLD support series here soon. :)

Best,
Sam

> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> index fb6a30c922f7..9640cc7a04b8 100644
> --- a/arch/arm/cpu/armv8/u-boot.lds
> +++ b/arch/arm/cpu/armv8/u-boot.lds
> @@ -149,19 +149,11 @@ SECTIONS
>   
>   	_end = .;
>   
> -	. = ALIGN(8);
> -
> -	.bss_start : {
> -		KEEP(*(.__bss_start));
> -	}
> -
> -	.bss : {
> +	.bss ALIGN(8): {
> +		__bss_start = .;
>   		*(.bss*)
> -		 . = ALIGN(8);
> -	}
> -
> -	.bss_end : {
> -		KEEP(*(.__bss_end));
> +		. = ALIGN(8);
> +		__bss_end = .;
>   	}
>   
>   	/DISCARD/ : { *(.dynsym) }
> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> index 7724c9332c3b..0dfe5f633b16 100644
> --- a/arch/arm/cpu/u-boot.lds
> +++ b/arch/arm/cpu/u-boot.lds
> @@ -207,23 +207,15 @@ SECTIONS
>   	}
>   
>   /*
> - * Compiler-generated __bss_start and __bss_end, see arch/arm/lib/bss.c
> - * __bss_base and __bss_limit are for linker only (overlay ordering)
> + * These sections occupy the same memory, but their lifetimes do
> + * not overlap: U-Boot initializes .bss only after applying dynamic
> + * relocations and therefore after it doesn't need .rel.dyn any more.
>    */
> -
> -	.bss_start __rel_dyn_start (OVERLAY) : {
> -		KEEP(*(.__bss_start));
> -		__bss_base = .;
> -	}
> -
> -	.bss __bss_base (OVERLAY) : {
> +	.bss ADDR(.rel.dyn) (OVERLAY): {
> +		__bss_start = .;
>   		*(.bss*)
> -		 . = ALIGN(4);
> -		 __bss_limit = .;
> -	}
> -
> -	.bss_end __bss_limit (OVERLAY) : {
> -		KEEP(*(.__bss_end));
> +		. = ALIGN(4);
> +		__bss_end = .;
>   	}
>   
>   	.dynsym _image_binary_end : { *(.dynsym) }
> diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
> index 857879711c6a..8e8bd5797e16 100644
> --- a/arch/arm/lib/sections.c
> +++ b/arch/arm/lib/sections.c
> @@ -19,8 +19,6 @@
>    * aliasing warnings.
>    */
>   
> -char __bss_start[0] __section(".__bss_start");
> -char __bss_end[0] __section(".__bss_end");
>   char __image_copy_start[0] __section(".__image_copy_start");
>   char __image_copy_end[0] __section(".__image_copy_end");
>   char __rel_dyn_start[0] __section(".__rel_dyn_start");
> diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> index 74618eba591b..712c485d4d0b 100644
> --- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> +++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> @@ -56,18 +56,11 @@ SECTIONS
>   
>   	_image_binary_end = .;
>   
> -	.bss_start (NOLOAD) : {
> -		. = ALIGN(8);
> -		KEEP(*(.__bss_start));
> -	}
> -
> -	.bss (NOLOAD) : {
> +	.bss ALIGN(8) : {
> +		__bss_start = .;
>   		*(.bss*)
> -		 . = ALIGN(8);
> -	}
> -
> -	.bss_end (NOLOAD) : {
> -		KEEP(*(.__bss_end));
> +		. = ALIGN(8);
> +		__bss_end = .;
>   	}
>   
>   	/DISCARD/ : { *(.dynsym) }
> diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
> index 3b7c9d515f8b..3c5008b57392 100644
> --- a/arch/arm/mach-zynq/u-boot.lds
> +++ b/arch/arm/mach-zynq/u-boot.lds
> @@ -103,23 +103,15 @@ SECTIONS
>   	_image_binary_end = .;
>   
>   /*
> - * Compiler-generated __bss_start and __bss_end, see arch/arm/lib/bss.c
> - * __bss_base and __bss_limit are for linker only (overlay ordering)
> + * These sections occupy the same memory, but their lifetimes do
> + * not overlap: U-Boot initializes .bss only after applying dynamic
> + * relocations and therefore after it doesn't need .rel.dyn any more.
>    */
> -
> -	.bss_start __rel_dyn_start (OVERLAY) : {
> -		KEEP(*(.__bss_start));
> -		__bss_base = .;
> -	}
> -
> -	.bss __bss_base (OVERLAY) : {
> +	.bss ADDR(.rel.dyn) (OVERLAY): {
> +		__bss_start = .;
>   		*(.bss*)
> -		 . = ALIGN(8);
> -		 __bss_limit = .;
> -	}
> -
> -	.bss_end __bss_limit (OVERLAY) : {
> -		KEEP(*(.__bss_end));
> +		. = ALIGN(8);
> +		__bss_end = .;
>   	}
>   
>   	/*
