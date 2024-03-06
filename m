Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F45CC5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 07:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50617879A0;
	Wed,  6 Mar 2024 08:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MjIuBO+K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AE5E8795D; Wed,  6 Mar 2024 08:33:02 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D331D87D7E
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 08:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3660132bf15so7437795ab.1
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 23:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709710378; x=1710315178; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oVRnZxbB9ioSV0KmQDqzGQDT4A9IVVeh/Z28ApM/HXs=;
 b=MjIuBO+KciuPQEroGzf87XdqSJdOipwv4E1D0Wils6TuP7rYENLPm3dF0S+XEbv4mp
 3iXqE8Xi3GWnVAj681lwG+iIrw1dDl7TAmHN21bvxHukPiM1eNzOhOD0LKculLyg7zZ6
 UF/SOi+cyIlJ5XJVhWASOOPTdHRlPjZz/tUXAk2pm8iIxby4t1mKMErF3UvLYrrSRiGo
 DDJ/YU3cHWIiNRlahmZMJzDqpdSPgc5Z9/gtjFGc+MM8ioqaeKsfovpubiexi0OJ+FQ/
 fnxhPKu/1OdCMRRk/kB6KR2iFfH7EVgUp8BKEUSKgr50Hzzxpu6bj4xkviJ2dGm1prZB
 Ct+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709710378; x=1710315178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oVRnZxbB9ioSV0KmQDqzGQDT4A9IVVeh/Z28ApM/HXs=;
 b=wvYlEctaXOTj5IWAXHlX2uJJfw7/Ji0NBr1G/r2sHtgpBpPRs1y9mTu2CHpUGPsJBt
 5wiF2zXxLemz9Ms7XuAdpQrZ7SvnkLN/clte5sYS3ARDe/1Ysy1zZLHZ+KvD8GMnI8jc
 MeRKOmcNB4GqEoXcvy1Zza46+Z+kQMoltwcRlaRrDZGyG15+ktDAxnlWwHonjZgYgicV
 GO0bHUNlh+WbBm5aF9lEzdEh7gZ2c5ULM0ac7tztjJBNBorfpdkcWHXKD894Wk36VTlw
 r4pjBEHNMwlJCvb/ZedI4SlOX1H+vK1d+RULCpEnKZxy7SpZp3B0As7asoQgVBAeDpf4
 B2Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwsSC1KgOMMqG3Y7LmE8TA0OlyNPHSWykB0xsb4tahypw2qgdkD+vObyuyWAFH5LA74W5WCcXcPtGrObRJDXpzJHqmSA==
X-Gm-Message-State: AOJu0YzOvlf9KRrC/E+JSn9s0QLRZKjOuYrhxhJ6iHr/Nei7vLd824Wk
 zE7wUz7ZdnqYZFw/GFwwuw0t6cDoI2b6um8heeH7eLL4deFV2yXj
X-Google-Smtp-Source: AGHT+IEIynurI+9CgE+Q+lg861tAAK4QaRiL2+cBgBuwZEMX4LT4gj7OM/YHrvrhRDIT+xPCbI1MAQ==
X-Received: by 2002:a05:6e02:1d18:b0:365:3d96:4b98 with SMTP id
 i24-20020a056e021d1800b003653d964b98mr15811006ila.2.1709710378311; 
 Tue, 05 Mar 2024 23:32:58 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:10f:8bb5:397e:4402?
 ([2001:470:42c4:101:10f:8bb5:397e:4402])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a92cf47000000b003642a638341sm3475015ilr.86.2024.03.05.23.32.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 23:32:57 -0800 (PST)
Message-ID: <6c502584-df1c-44e4-9fa4-70d73a4ae07e@gmail.com>
Date: Wed, 6 Mar 2024 00:32:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] arm: clean up v7 and v8 linker scripts for
 bss_start/end
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 trini@konsulko.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
References: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
 <20240304090113.1410575-3-ilias.apalodimas@linaro.org>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20240304090113.1410575-3-ilias.apalodimas@linaro.org>
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

On 3/4/24 02:01, Ilias Apalodimas wrote:
> commit 3ebd1cbc49f0 ("arm: make __bss_start and __bss_end__ compiler-generated")
> and
> commit f84a7b8f54db ("ARM: Fix __bss_start and __bss_end in linker scripts")
> were moving the bss_start/end on c generated variables that were
> injected in their own sections. The reason was that we needed relative
> relocations for position independent code and linker bugs back then
> prevented us from doing so.
> 
> However, the linker documentation pages states that symbols that are
> defined within a section definition will create a relocatable
> type with the value being a fixed offset from the base of a section.
> This have been fixed since 2016 [1]. So let's start cleaning this up
> starting with the bss_start and bss_end variables. Convert them into
> symbols within the .bss section definition.
> 
> [0] https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_mono/ld.html#SEC13
> [1] commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # Qualcomm sdm845
> ---
>   arch/arm/cpu/armv8/u-boot-spl.lds        | 14 +++-----------
>   arch/arm/cpu/armv8/u-boot.lds            | 15 +++------------
>   arch/arm/cpu/u-boot.lds                  | 22 ++++------------------
>   arch/arm/lib/sections.c                  |  2 --
>   arch/arm/mach-rockchip/u-boot-tpl-v8.lds | 14 +++-----------
>   arch/arm/mach-zynq/u-boot.lds            | 21 +++------------------
>   6 files changed, 16 insertions(+), 72 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
> index 7cb9d731246d..16fddb46e9cb 100644
> --- a/arch/arm/cpu/armv8/u-boot-spl.lds
> +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> @@ -63,18 +63,10 @@ SECTIONS
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
> +		__bss_end = .;
>   	} >.sdram
>   
>   	/DISCARD/ : { *(.rela*) }
> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> index fb6a30c922f7..c4ee10ebc3ff 100644
> --- a/arch/arm/cpu/armv8/u-boot.lds
> +++ b/arch/arm/cpu/armv8/u-boot.lds
> @@ -149,19 +149,10 @@ SECTIONS
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
> +		__bss_end = .;
>   	}
>   
>   	/DISCARD/ : { *(.dynsym) }
> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> index 7724c9332c3b..90d329b1ebe0 100644
> --- a/arch/arm/cpu/u-boot.lds
> +++ b/arch/arm/cpu/u-boot.lds
> @@ -206,27 +206,13 @@ SECTIONS
>   		*(.mmutable)
>   	}
>   
> -/*
> - * Compiler-generated __bss_start and __bss_end, see arch/arm/lib/bss.c
> - * __bss_base and __bss_limit are for linker only (overlay ordering)
> - */
> -
> -	.bss_start __rel_dyn_start (OVERLAY) : {
> -		KEEP(*(.__bss_start));
> -		__bss_base = .;
> -	}
> -
> -	.bss __bss_base (OVERLAY) : {
> +	.bss ALIGN(4): {

Hi Ilias,

I have been reviewing this patchset by diffing output binaries and 
linker maps between successive patches. Most of the patches in this 
series result in no change to the output binary whatsoever (which also 
means, no regressions!) but this one does have a change: .bss is being 
moved after .mmutable. You should be able to see this yourself by 
comparing `u-boot.map` after a successful build, before and after 
applying this patch.

Since the current u-boot.lds puts .bss right after __image_copy_end 
(which makes sense) and uses OVERLAY to overlap .rel.dyn (which... I 
guess makes sense, if U-Boot zero-initializes .bss after applying 
relocations), perhaps this patch should be moving the .bss section up 
there in the .lds, putting (OVERLAY) back, and adding a comment to the 
effect of "These sections occupy the same memory, but their lifetimes do 
not overlap: U-Boot initializes .bss only after applying relocations and 
therefore after it doesn't need .rel.dyn any more."

We might also decide that the overlay memory-saving trick isn't actually 
all that important anymore and that .bss should have a new home. Someone 
far more seasoned than I should be the one to make that decision though.

The rest of the patchset looks great! I'll add my tags to those in a bit.

Cheers,
Sam

> +		__bss_start = .;
>   		*(.bss*)
> -		 . = ALIGN(4);
> -		 __bss_limit = .;
> -	}
> -
> -	.bss_end __bss_limit (OVERLAY) : {
> -		KEEP(*(.__bss_end));
> +		__bss_end = .;
>   	}
>   
> -	.dynsym _image_binary_end : { *(.dynsym) }
> +	.dynsym  : { *(.dynsym) }
>   	.dynbss : { *(.dynbss) }
>   	.dynstr : { *(.dynstr*) }
>   	.dynamic : { *(.dynamic*) }
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
> index 74618eba591b..b7887194026e 100644
> --- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> +++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> @@ -56,18 +56,10 @@ SECTIONS
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
> +		__bss_end = .;
>   	}
>   
>   	/DISCARD/ : { *(.dynsym) }
> diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
> index 3b7c9d515f8b..8d3259821719 100644
> --- a/arch/arm/mach-zynq/u-boot.lds
> +++ b/arch/arm/mach-zynq/u-boot.lds
> @@ -102,26 +102,11 @@ SECTIONS
>   
>   	_image_binary_end = .;
>   
> -/*
> - * Compiler-generated __bss_start and __bss_end, see arch/arm/lib/bss.c
> - * __bss_base and __bss_limit are for linker only (overlay ordering)
> - */
> -
> -	.bss_start __rel_dyn_start (OVERLAY) : {
> -		KEEP(*(.__bss_start));
> -		__bss_base = .;
> -	}
> -
> -	.bss __bss_base (OVERLAY) : {
> +	.bss ALIGN(4): {
> +		__bss_start = .;
>   		*(.bss*)
> -		 . = ALIGN(8);
> -		 __bss_limit = .;
> -	}
> -
> -	.bss_end __bss_limit (OVERLAY) : {
> -		KEEP(*(.__bss_end));
> +		__bss_end = .;
>   	}
> -
>   	/*
>   	 * Zynq needs to discard these sections because the user
>   	 * is expected to pass this image on to tools for boot.bin
