Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A51C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 08:22:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CBC687D64;
	Wed,  6 Mar 2024 09:22:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mURdKY4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16C6487D9B; Wed,  6 Mar 2024 09:22:14 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF0A87C92
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 09:22:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-365f91e490cso8510265ab.2
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 00:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709713330; x=1710318130; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z+4MQWeYklBZW4G6vs7H7EYw8sA/WiuBbBvigBn3hR8=;
 b=mURdKY4EVADJfweGzD69BXKg+D0+l3/1UcN0jho9z0VtiwJFQ0/km5c+hTnfhcSOlM
 BKKAkPirURchnUSLRY4q3PbJR+BApRMgr03O1aZpj6Zen2CrjZwypyWd+Y+f6jHfO6Gp
 4lY6Agf2WNlegL9iGHC+uS6R/wuYH/ewodXLXNvi8GVx8BlEQK5xPhDCP1l0MZv9A6Dk
 AAKiNwMcdsyTsV6g15VstTX6rMJM1K6r1uFff68Uz0/yDIB+4Fxqi5LvdlLpE38XHHwN
 QXPwwELdliYnISqhOGQzTb9/nLvP6us39lgkdlsNIPkQJKoyHClGSJtHljgqwcLJkOlY
 IMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709713330; x=1710318130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z+4MQWeYklBZW4G6vs7H7EYw8sA/WiuBbBvigBn3hR8=;
 b=Jk+gRh+pGaNJ3jZ6RGI60I0XWgl9+j+MGtOht+x+yZ7aGkgte0WqM4WOOaz7uc4Zew
 T5VHQOQTl6x4lO+JoMHGgCXdguhDkWami5T1hJ7gF76q71Yk+QFjNE49sW107vHTew5D
 GAjlQRLAuAcPqO8vt9hKCYqJaE/YkqAGbqszJcp7pqxDcDq4GDlsRNHgjq/REFzNg4kN
 RongbKFtvowoHOawzw/0NPGyNfS2JF3u3bsMFX7nOKhkZsDcP4PtZ7Isa76PNEc/5fkt
 5mYGZWwhR4LXUsWbnxQd/i7DzeJD5VnKwWVUxyi8kYqg8wSauUemQiT6zjZGYM7yDh6G
 aFdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD8M7jHzgeCrj1+1CdokqUXTvSkldrb9S5WbLqdEf6Xang37ZbuqLlmJciAUgmuPNI6Fttp6SmdrDhUIl72pGFsNkFMg==
X-Gm-Message-State: AOJu0YwNTHuhoh9q3l3a6VlY5JqUYOH4mDNk7E/8B1DTDRoM0qbmQaRX
 iLksVF/gXx1Dadnq13vDRfZHmA8rFX7m3/AGxmtLAXGAqlGbDYUi
X-Google-Smtp-Source: AGHT+IGdg6CSPzmn8FDrswWEg645CzzMAWINa5KyubjF+0cjB3ethfLydLphifD9ur3E0v6ewRGM/Q==
X-Received: by 2002:a05:6e02:2141:b0:365:4e45:543a with SMTP id
 d1-20020a056e02214100b003654e45543amr17897461ilv.23.1709713330238; 
 Wed, 06 Mar 2024 00:22:10 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:10f:8bb5:397e:4402?
 ([2001:470:42c4:101:10f:8bb5:397e:4402])
 by smtp.gmail.com with ESMTPSA id
 dk11-20020a0566384bcb00b00473c05f5d1csm3328108jab.5.2024.03.06.00.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 00:22:09 -0800 (PST)
Message-ID: <6c4f6b76-0828-497f-a45c-e9bc307620bb@gmail.com>
Date: Wed, 6 Mar 2024 01:22:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm: move image_copy_start/end to linker symbols
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
 <20240304090113.1410575-7-ilias.apalodimas@linaro.org>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20240304090113.1410575-7-ilias.apalodimas@linaro.org>
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
> image_copy_start/end are defined as c variables in order to force the compiler
> emit relative references. However, defining those within a section definition
> will do the same thing.
> 
> So let's remove the special sections from the linker scripts, the
> variable definitions from sections.c and define them as a symbols within
> a section.
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical

Since the __image_copy_* symbols are marking boundaries in the whole 
image as opposed to a single section, I'd find it clearer if they were 
loose in the SECTIONS { ... } block, so as not to imply that they are 
coupled to any particular section. Thoughts?

Thanks for the cleanup,
Sam

> ---
>   arch/arm/cpu/armv8/u-boot.lds            | 10 ++--------
>   arch/arm/cpu/u-boot.lds                  | 10 ++--------
>   arch/arm/lib/sections.c                  |  2 --
>   arch/arm/mach-rockchip/u-boot-tpl-v8.lds |  8 ++------
>   arch/arm/mach-zynq/u-boot.lds            |  9 ++-------
>   5 files changed, 8 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> index e737de761a9d..340acf5c043b 100644
> --- a/arch/arm/cpu/armv8/u-boot.lds
> +++ b/arch/arm/cpu/armv8/u-boot.lds
> @@ -23,7 +23,7 @@ SECTIONS
>   	. = ALIGN(8);
>   	.text :
>   	{
> -		*(.__image_copy_start)
> +		__image_copy_start = .;
>   		CPUDIR/start.o (.text*)
>   	}
>   
> @@ -120,13 +120,7 @@ SECTIONS
>   		*(.rel*.efi_runtime)
>   		*(.rel*.efi_runtime.*)
>                   __efi_runtime_rel_stop = .;
> -	}
> -
> -	. = ALIGN(8);
> -
> -	.image_copy_end :
> -	{
> -		*(.__image_copy_end)
> +		__image_copy_end = .;
>   	}
>   
>   	.rela.dyn ALIGN(8) : {
> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> index df55bb716e35..7c4f9c2d4dd3 100644
> --- a/arch/arm/cpu/u-boot.lds
> +++ b/arch/arm/cpu/u-boot.lds
> @@ -37,7 +37,7 @@ SECTIONS
>   	. = ALIGN(4);
>   	.text :
>   	{
> -		*(.__image_copy_start)
> +		__image_copy_start = .;
>   		*(.vectors)
>   		CPUDIR/start.o (.text*)
>   	}
> @@ -151,13 +151,7 @@ SECTIONS
>   		*(.rel*.efi_runtime)
>   		*(.rel*.efi_runtime.*)
>   		__efi_runtime_rel_stop = .;
> -	}
> -
> -	. = ALIGN(4);
> -
> -	.image_copy_end :
> -	{
> -		*(.__image_copy_end)
> +		__image_copy_end = .;
>   	}
>   
>   	.rel.dyn ALIGN(4) : {
> diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
> index a4d4202e99f5..db5463b2bbbc 100644
> --- a/arch/arm/lib/sections.c
> +++ b/arch/arm/lib/sections.c
> @@ -19,8 +19,6 @@
>    * aliasing warnings.
>    */
>   
> -char __image_copy_start[0] __section(".__image_copy_start");
> -char __image_copy_end[0] __section(".__image_copy_end");
>   char __secure_start[0] __section(".__secure_start");
>   char __secure_end[0] __section(".__secure_end");
>   char __secure_stack_start[0] __section(".__secure_stack_start");
> diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> index b7887194026e..4b480ebb0c4d 100644
> --- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> +++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
> @@ -24,7 +24,7 @@ SECTIONS
>   
>   	.text : {
>   		. = ALIGN(8);
> -		*(.__image_copy_start)
> +		__image_copy_start = .;
>   		CPUDIR/start.o (.text*)
>   		*(.text*)
>   	}
> @@ -42,11 +42,7 @@ SECTIONS
>   	__u_boot_list : {
>   		. = ALIGN(8);
>   		KEEP(*(SORT(__u_boot_list*)));
> -	}
> -
> -	.image_copy_end : {
> -		. = ALIGN(8);
> -		*(.__image_copy_end)
> +		__image_copy_end = .;
>   	}
>   
>   	.end : {
> diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
> index fcd0f42a7106..553bcf182272 100644
> --- a/arch/arm/mach-zynq/u-boot.lds
> +++ b/arch/arm/mach-zynq/u-boot.lds
> @@ -16,7 +16,7 @@ SECTIONS
>   	. = ALIGN(4);
>   	.text :
>   	{
> -		*(.__image_copy_start)
> +		__image_copy_start = .;
>   		*(.vectors)
>   		CPUDIR/start.o (.text*)
>   	}
> @@ -57,12 +57,7 @@ SECTIONS
>   		*(.rel*.efi_runtime)
>   		*(.rel*.efi_runtime.*)
>   		__efi_runtime_rel_stop = .;
> -	}
> -
> -	. = ALIGN(8);
> -	.image_copy_end :
> -	{
> -		*(.__image_copy_end)
> +		__image_copy_end = .;
>   	}
>   
>   	.rel.dyn ALIGN(8) : {
