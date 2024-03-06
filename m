Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC29C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 07:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75D90879A0;
	Wed,  6 Mar 2024 08:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D2zk27tr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C07787FA4; Wed,  6 Mar 2024 08:35:39 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D80958795D
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 08:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7c87474f4d7so17221939f.1
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 23:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709710534; x=1710315334; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MM+6hdY3kJqSsjhxqumhaumkicCFI8MwO/H4qShDrrE=;
 b=D2zk27trZ0wCKGlcPk86zF3oLW2Scu239FkbHKsiTL6ZRW8SuhSWaj9wL4HNq6tut2
 5bblD4oJOWDP3PN8yTJBDNzmyV33OYhu7D4rAsPTX/BSQ6+uAUHYx55NSRSpIepSqWvm
 Ta54VJhybm8PkY0t9FHMcMT5eV8zrONbRSa/wk4Tr6j+SlRHo7GXHB6yb7kg2Dwqh0iN
 Ss8aZDFH9gVRZsDUwI3dEtz5OKuMqPpT6IostOcxCq6JqO0GBnTlxGF8t1HxK5dUpi5v
 WLcZWwbDexqvYscDytgUHQ2AWo0xaRWPG9DCJtCO9GLAzc7UiRFK5A5p2VvV//l41Zeo
 5ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709710534; x=1710315334;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MM+6hdY3kJqSsjhxqumhaumkicCFI8MwO/H4qShDrrE=;
 b=joXBbdCQztNoyJR+kS7MMSO2MgTobwpgNzZi5czdJvSrA5ZrdhbHfReQxO8GIY4p37
 lBa2+MVK/SWyRWxe7p3UegTI2yYDYdk1W4S357Drsk7EK4/1xigwop4rgFHfOZ6Bnomv
 5yz8kc4Wnzrt75p5n0hRlHp94FQyufhD6cf6yicYUjaKo3Bvn8w3Egwgr6/Wfmmso0ma
 CBXA+f445h/SOx4LtYzfOHhRnCdML5w/6xgX1ru/rZjkyaC6lAw3wOgyzYsh60nairne
 is8ZCAbBUntm54TUcuuhMnV4eFIctsfyfvTHsZdArhm2vugb7K3QD14Nf47XYOm7BENM
 Ct1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxt/rulgIHwdZYYwal/31U57xNLCgtm2r2sbsD2Zu4JgOad1Pgn+GymNW64v/Ougf5IcblANvKMSgYoum41JevkmkUQg==
X-Gm-Message-State: AOJu0YwH2oPpv3gMqFk4SRoaPty6oVABZv7otq654H+afynSbODvOXQB
 MhSWatAedrZkbUreeHyvrrNK8ipzL+IGjYWqkU1yluziG2LsXEbd
X-Google-Smtp-Source: AGHT+IGzriMLo5DzGi8nmHTfIJ6GjTuQaLwkL+YRZHVpk8gu3I+YZ5+rVSfC0BCTFxCsbDvgLwOLGQ==
X-Received: by 2002:a05:6602:35d:b0:7c8:6125:20d with SMTP id
 w29-20020a056602035d00b007c86125020dmr6285145iou.7.1709710533753; 
 Tue, 05 Mar 2024 23:35:33 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:10f:8bb5:397e:4402?
 ([2001:470:42c4:101:10f:8bb5:397e:4402])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a056638408600b00475014531fcsm802248jam.54.2024.03.05.23.35.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 23:35:33 -0800 (PST)
Message-ID: <d7f5ecbf-3016-4b9b-a175-9e433e343cfa@gmail.com>
Date: Wed, 6 Mar 2024 00:35:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm: fix __efi_runtime_rel_start/end definitions
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
 <20240304090113.1410575-4-ilias.apalodimas@linaro.org>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20240304090113.1410575-4-ilias.apalodimas@linaro.org>
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
> __efi_runtime_rel_start/end are defined as c variables for arm7 only in
> order to force the compiler emit relative references. However, defining
> those within a section definition will do the same thing. On top of that
> the v8 linker scripts define it as a symbol.
> 
> So let's remove the special sections from the linker scripts, the
> variable definitions from sections.c and define them as a symbols within
> the correct section.
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Sam Edwards <CFSworks@gmail.com>
Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical

Thanks for the cleanup,
Sam

> ---
>   arch/arm/cpu/armv8/u-boot.lds  |  4 +---
>   arch/arm/cpu/u-boot.lds        | 16 +++-------------
>   arch/arm/lib/sections.c        |  2 --
>   arch/arm/mach-zynq/u-boot.lds  | 16 +++-------------
>   include/asm-generic/sections.h |  2 ++
>   lib/efi_loader/efi_runtime.c   |  1 +
>   6 files changed, 10 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> index c4ee10ebc3ff..eccb116d3cfa 100644
> --- a/arch/arm/cpu/armv8/u-boot.lds
> +++ b/arch/arm/cpu/armv8/u-boot.lds
> @@ -115,9 +115,7 @@ SECTIONS
>   		KEEP(*(SORT(__u_boot_list*)));
>   	}
>   
> -	. = ALIGN(8);
> -
> -	.efi_runtime_rel : {
> +	.efi_runtime_rel ALIGN(8) : {
>                   __efi_runtime_rel_start = .;
>   		*(.rel*.efi_runtime)
>   		*(.rel*.efi_runtime.*)
> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> index 90d329b1ebe0..70e78ce46672 100644
> --- a/arch/arm/cpu/u-boot.lds
> +++ b/arch/arm/cpu/u-boot.lds
> @@ -152,21 +152,11 @@ SECTIONS
>   		KEEP(*(SORT(__u_boot_list*)));
>   	}
>   
> -	. = ALIGN(4);
> -
> -	.efi_runtime_rel_start :
> -	{
> -		*(.__efi_runtime_rel_start)
> -	}
> -
> -	.efi_runtime_rel : {
> +	.efi_runtime_rel ALIGN(4) : {
> +		__efi_runtime_rel_start = .;
>   		*(.rel*.efi_runtime)
>   		*(.rel*.efi_runtime.*)
> -	}
> -
> -	.efi_runtime_rel_stop :
> -	{
> -		*(.__efi_runtime_rel_stop)
> +		__efi_runtime_rel_stop = .;
>   	}
>   
>   	. = ALIGN(4);
> diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
> index 8e8bd5797e16..ddfde52163fc 100644
> --- a/arch/arm/lib/sections.c
> +++ b/arch/arm/lib/sections.c
> @@ -29,6 +29,4 @@ char __secure_stack_start[0] __section(".__secure_stack_start");
>   char __secure_stack_end[0] __section(".__secure_stack_end");
>   char __efi_runtime_start[0] __section(".__efi_runtime_start");
>   char __efi_runtime_stop[0] __section(".__efi_runtime_stop");
> -char __efi_runtime_rel_start[0] __section(".__efi_runtime_rel_start");
> -char __efi_runtime_rel_stop[0] __section(".__efi_runtime_rel_stop");
>   char _end[0] __section(".__end");
> diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
> index 8d3259821719..66a9e37f9198 100644
> --- a/arch/arm/mach-zynq/u-boot.lds
> +++ b/arch/arm/mach-zynq/u-boot.lds
> @@ -58,21 +58,11 @@ SECTIONS
>   		KEEP(*(SORT(__u_boot_list*)));
>   	}
>   
> -	. = ALIGN(4);
> -
> -	.efi_runtime_rel_start :
> -	{
> -		*(.__efi_runtime_rel_start)
> -	}
> -
> -	.efi_runtime_rel : {
> +	.efi_runtime_rel ALIGN(4) : {
> +		__efi_runtime_rel_start = .;
>   		*(.rel*.efi_runtime)
>   		*(.rel*.efi_runtime.*)
> -	}
> -
> -	.efi_runtime_rel_stop :
> -	{
> -		*(.__efi_runtime_rel_stop)
> +		__efi_runtime_rel_stop = .;
>   	}
>   
>   	. = ALIGN(8);
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> index 1e1657a01673..60949200dd93 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -34,6 +34,8 @@ extern char __priv_data_start[], __priv_data_end[];
>   /* Start and end of .ctors section - used for constructor calls. */
>   extern char __ctors_start[], __ctors_end[];
>   
> +extern char __efi_runtime_rel_start[], __efi_runtime_rel_stop[];
> +
>   /* function descriptor handling (if any).  Override
>    * in asm/sections.h */
>   #ifndef dereference_function_descriptor
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index 18da6892e796..9185f1894c47 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -15,6 +15,7 @@
>   #include <rtc.h>
>   #include <asm/global_data.h>
>   #include <u-boot/crc.h>
> +#include <asm/sections.h>
>   
>   /* For manual relocation support */
>   DECLARE_GLOBAL_DATA_PTR;
