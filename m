Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FA5C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 08:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F4D87C92;
	Wed,  6 Mar 2024 09:14:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FcoLmxHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B510087CBA; Wed,  6 Mar 2024 09:14:23 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B37287BFD
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 09:14:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7c835cfbff3so153554039f.2
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 00:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709712859; x=1710317659; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CUtu44+TNSMbAK2fc329i31L0Ie3HnS34HH8zKzZabk=;
 b=FcoLmxHcMo5CHceiPpDMbGkAdB7g2jAYkgKHkdoJHGr96JNQf8yrVTXnZZoUkTTj91
 7FyBmfNl0EuoRlUd3tSDlEmHUke9Uh1avHQ3R+j09JTyAISbhwtbgXhrnoyAowiEsUxw
 KEuumPd/DOkPBNPxG1IZSHjpcWoUr5mYD3BlPIniS6cK9IxN6t0UCn+kkUClYzFa4+v2
 5TEz78ZE/Tavy8b7+PsyFHTWQ+89ioe/5JHmRybOuvVqrBQd4CVV4/8vM7cglrlzCI25
 7o/MwFNVFTll0opcV88MU8E6cFpsh/D0ZFL+cLvCOiOoCs0xYqfg7eM5tDKSqCFR5Rhs
 9koA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709712859; x=1710317659;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CUtu44+TNSMbAK2fc329i31L0Ie3HnS34HH8zKzZabk=;
 b=a6xOTowRIYAyNKZrPTIBoHhQn/auPSpUPxUUJFRF4GRn73WOu7AooA/N9/vCTB7PlG
 e0fgWR2nK6ig0OG66BpGRQ4mJC47UnNyXoQVb32xtmYD0a3SVa2w1cSGgsKoS+IzWq+b
 NCzpD4Md49FrhqncKpjDqTMo6Z31+OEkMFXFEKFRaw6//TpRHTIHzK2DcmxmTh7QP/AL
 2N2pSQFGs9546+Z6rbXH/VUDoszTUPMe+H8d6A9R8iU/RlH9XXGKMhROmM09PYBnRlsV
 RIIub9vktC2uGTsxHHtYz0OmVQohLhA8zpypnaI2aZ+l9MSxkCjbLPmqBYE6r10piwve
 u0aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9OQRHBU+zquFRolQE2CRyszYrlpz+Jxo54Yg+O/e78iqUU7iGhKAGgEOBsTIPEbaksn74JeRClkmyFRUbG0WhgWZC8g==
X-Gm-Message-State: AOJu0YzgKYwdPtJ57df0xhR6HU9HoibOodj0zF07zoV3v/UcnKPq9W13
 PQHh6GsXPqXq9fDUr9FCchrERgfYNFFCW4PugyGGJqXjoy+34agn
X-Google-Smtp-Source: AGHT+IFh9fYldRLba/cAIG2o+RCVK2PvDJ7msbJcOQWAiblw/WxUbC35fWXFlhH+f3i6EQV+MU4Kgg==
X-Received: by 2002:a05:6e02:154e:b0:365:a9fd:1a7a with SMTP id
 j14-20020a056e02154e00b00365a9fd1a7amr11992133ilu.26.1709712859178; 
 Wed, 06 Mar 2024 00:14:19 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:10f:8bb5:397e:4402?
 ([2001:470:42c4:101:10f:8bb5:397e:4402])
 by smtp.gmail.com with ESMTPSA id
 gl10-20020a0566386aca00b00474f42be9f7sm1348989jab.91.2024.03.06.00.14.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 00:14:18 -0800 (PST)
Message-ID: <ccfe2f01-765b-4953-b0b5-9122b861d89b@gmail.com>
Date: Wed, 6 Mar 2024 01:14:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm: fix __efi_runtime_start/end definitions
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
 <20240304090113.1410575-6-ilias.apalodimas@linaro.org>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20240304090113.1410575-6-ilias.apalodimas@linaro.org>
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
> __efi_runtime_start/end are defined as c variables for arm7 only in
> order to force the compiler emit relative references. However, defining
> those within a section definition will do the same thing. On top of that
> the v8 linker scripts define it as a symbol.
> 
> So let's remove the special sections from the linker scripts, the
> variable definitions from sections.c and define them as a symbols within
> the correct section.
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical

Thanks for the cleanup,
Sam

> ---
>   arch/arm/cpu/u-boot.lds        | 12 +++---------
>   arch/arm/lib/sections.c        |  2 --
>   arch/arm/mach-zynq/u-boot.lds  | 12 +++---------
>   include/asm-generic/sections.h |  1 +
>   4 files changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> index 7c6e7891d360..df55bb716e35 100644
> --- a/arch/arm/cpu/u-boot.lds
> +++ b/arch/arm/cpu/u-boot.lds
> @@ -43,18 +43,12 @@ SECTIONS
>   	}
>   
>   	/* This needs to come before *(.text*) */
> -	.__efi_runtime_start : {
> -		*(.__efi_runtime_start)
> -	}
> -
> -	.efi_runtime : {
> +	.efi_runtime ALIGN(4) : {

Do we truly require the ALIGN(4)? If I understand correctly, by default, 
the linker calculates the alignment of an output section as the least 
common multiple of the input sections' alignment requirements -- meaning 
most (perhaps all) of our ALIGN()s today are redundant. For the time 
being, I'm in favor of merging existing `. = ALIGN(x)` into each 
following section for clarity and to avoid the testing overhead of 
removing them in the same patch as other changes. However, in the near 
future (perhaps even as "near" as v2 of this series?), I'd also like to 
see a patch that eliminates unnecessary ALIGN()s altogether. Introducing 
additional ALIGN()s where we already know they aren't needed may be a 
step away from that goal.

> +		__efi_runtime_start = .;
>   		*(.text.efi_runtime*)
>   		*(.rodata.efi_runtime*)
>   		*(.data.efi_runtime*)
> -	}
> -
> -	.__efi_runtime_stop : {
> -		*(.__efi_runtime_stop)
> +		__efi_runtime_stop = .;
>   	}
>   
>   	.text_rest :
> diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
> index 1ee3dd3667ba..a4d4202e99f5 100644
> --- a/arch/arm/lib/sections.c
> +++ b/arch/arm/lib/sections.c
> @@ -25,6 +25,4 @@ char __secure_start[0] __section(".__secure_start");
>   char __secure_end[0] __section(".__secure_end");
>   char __secure_stack_start[0] __section(".__secure_stack_start");
>   char __secure_stack_end[0] __section(".__secure_stack_end");
> -char __efi_runtime_start[0] __section(".__efi_runtime_start");
> -char __efi_runtime_stop[0] __section(".__efi_runtime_stop");
>   char _end[0] __section(".__end");
> diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
> index 71dea4a1f60a..fcd0f42a7106 100644
> --- a/arch/arm/mach-zynq/u-boot.lds
> +++ b/arch/arm/mach-zynq/u-boot.lds
> @@ -22,18 +22,12 @@ SECTIONS
>   	}
>   
>   	/* This needs to come before *(.text*) */
> -	.__efi_runtime_start : {
> -		*(.__efi_runtime_start)
> -	}
> -
> -	.efi_runtime : {
> +	.efi_runtime ALIGN(4) : {

Ditto above

> +		__efi_runtime_start = .;
>   		*(.text.efi_runtime*)
>   		*(.rodata.efi_runtime*)
>   		*(.data.efi_runtime*)
> -	}
> -
> -	.__efi_runtime_stop : {
> -		*(.__efi_runtime_stop)
> +		__efi_runtime_stop = .;
>   	}
>   
>   	.text_rest :
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> index 60949200dd93..b6bca53db10d 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -35,6 +35,7 @@ extern char __priv_data_start[], __priv_data_end[];
>   extern char __ctors_start[], __ctors_end[];
>   
>   extern char __efi_runtime_rel_start[], __efi_runtime_rel_stop[];
> +extern char __efi_runtime_start[], __efi_runtime_stop[];
>   
>   /* function descriptor handling (if any).  Override
>    * in asm/sections.h */
