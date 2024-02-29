Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3D7C54E41
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 13:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97164880D2;
	Thu, 29 Feb 2024 14:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MK+3Vxqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87CE687C86; Thu, 29 Feb 2024 14:49:32 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A423F880D3
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 14:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33d38c9ca5bso517523f8f.2
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 05:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709214569; x=1709819369; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qDAeU5qRmCvzKoiOK9dv8N06culZj0OW4RrlWAonaHk=;
 b=MK+3Vxqo22eiYGH2SP2S7GdLSL3P1mCg72A3YfPg9vKBW3EHCBMNcfaVv54NxyfEeL
 znKCvYkXwvDK/ejrnzZC3kP2fNffcRqv9zGXlE8hF2xP4Sib0SQLeafAyK5lPOQJO5VJ
 7QRwSTug/v0ttwEeuwd1C8GCPUq9Q/VlpdWxSJ54O4a1xup4p9nqByi63kni96zi2vd7
 0+clj8UI8fU+Ql25dBiHqQlIjHQhrbmdBzs/LNolMIekPiUY2d1unty1WxgGwKXq0eY9
 z5P6Czk+Dv7SC1JAHmKcymMmPSSGRXXtTi+eTFjwEVJoQT+IP4opv5/ErjnxiSQwlEW3
 HYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709214569; x=1709819369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qDAeU5qRmCvzKoiOK9dv8N06culZj0OW4RrlWAonaHk=;
 b=Lq/bDlyClVvEVIyTJoMn+lex0rW3glfY+6xN08VfgrnFhCwhA0lgZ1XXWh8zJbSgap
 Up/mCEpiisb+hyuPpJXwrAqiyMIbJpQPQ8AGJ+w24j6R7NhFD72XuzG3n+usVl/qIkL1
 YLEnN8x+ArrBUqzuaVFgrJWvMsu4QOrH6w4Tj9zWfES0oDoW4e5oUCejGVALM2Rx2DMk
 lG8PWq3pSH21HmHIDWT6wH/Dqm/osF4F8jZPdRrcmbDal9t9pIqTnZjzLsi1me4GelPy
 qRlFcR63BGROQxDJB6nR/GMJjoiSky+9spp0Z10iEGhHR/ljJIi0WlJouT8mgJDZlhRq
 sV4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0znmOCeYknmA6N9bxJOnpmrDjwzjxRYPg7ARahuoYh+OL35s4Nu+itb5+jhSnK1ILNwBjDPe00uoE5j5YpTlYcRwung==
X-Gm-Message-State: AOJu0Yxk8gkXdzPfqJ26mnP31kN+r95EW5COpSGrF96cAmsehNvn804H
 x5J1y2+rfxhJ1TUFp5L9JWKrsTHkrFUjrMwirsUA5tiFxhkTkrE+d3zG022o1rs=
X-Google-Smtp-Source: AGHT+IFFPs4cRMjk9Fc9LH8vvfPjm0RjMs7fuyn6Y7wuIsKl7TFoR6seRrzb9khDlP7B3j9/3mXXqA==
X-Received: by 2002:a05:6000:11c2:b0:33d:9c3d:f930 with SMTP id
 i2-20020a05600011c200b0033d9c3df930mr1384312wrx.66.1709214568931; 
 Thu, 29 Feb 2024 05:49:28 -0800 (PST)
Received: from [192.168.1.17] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 i8-20020adfb648000000b0033e0ed396bdsm1721171wre.106.2024.02.29.05.49.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 05:49:28 -0800 (PST)
Message-ID: <d46da3fc-614d-4559-b795-aaae4d563d06@linaro.org>
Date: Thu, 29 Feb 2024 13:49:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] arm: clean up v7 and v8 linker scripts for
 bss_start/end
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 trini@konsulko.com, cfsworks@gmail.com
Cc: sumit.garg@linaro.org, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Michal Simek <michal.simek@amd.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
References: <20240228104811.1366694-1-ilias.apalodimas@linaro.org>
 <20240228104811.1366694-3-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240228104811.1366694-3-ilias.apalodimas@linaro.org>
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



On 28/02/2024 10:48, Ilias Apalodimas wrote:
> commit 3ebd1cbc49f0 ("arm: make __bss_start and __bss_end__ compiler-generated")
> and
> commit f84a7b8f54db ("ARM: Fix __bss_start and __bss_end in linker scripts")
> were moving the bss_start/end on c generated variables that were
> injected in their own sections. The reason was that we needed relative
> relocations for position independent code.
> 
> However, the linker documentation pages states that symbols that are
> defined within a section definition will create a relocatable
> type with the value being a fixed offset from the base of a section.
> 
> So let's start cleaning this up starting with the bss_start and bss_end
> variables. Convert them into symbols within the .bss section definition.
> 
> [0] https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_mono/ld.html#SEC13
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # Qualcomm sdm845

This patch and a few others in this series conflict with my patch [1] 
which drops the dragonboard820c linker script. My patch doesn't have any 
external dependencies, so would it be easier for you to take it along 
with this series? Or how best should we avoid the merge conflicts here?

[1]: 
https://lore.kernel.org/u-boot/20240226-b4-qcom-common-target-v5-19-10c8e078befb@linaro.org/

Thanks and regards,
> ---
>   arch/arm/cpu/armv8/u-boot-spl.lds         | 14 +++-----------
>   arch/arm/cpu/armv8/u-boot.lds             | 15 +++------------
>   arch/arm/cpu/u-boot.lds                   | 22 ++++------------------
>   arch/arm/lib/sections.c                   |  2 --
>   arch/arm/mach-rockchip/u-boot-tpl-v8.lds  | 14 +++-----------
>   arch/arm/mach-zynq/u-boot.lds             | 21 +++------------------
>   board/qualcomm/dragonboard820c/u-boot.lds | 15 +++------------
>   7 files changed, 19 insertions(+), 84 deletions(-)
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
> diff --git a/board/qualcomm/dragonboard820c/u-boot.lds b/board/qualcomm/dragonboard820c/u-boot.lds
> index 5251b59fbe76..d3cc5278b610 100644
> --- a/board/qualcomm/dragonboard820c/u-boot.lds
> +++ b/board/qualcomm/dragonboard820c/u-boot.lds
> @@ -87,19 +87,10 @@ SECTIONS
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
> --
> 2.37.2
> 

-- 
// Caleb (they/them)
