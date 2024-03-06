Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BD5C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 07:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9E6587FC2;
	Wed,  6 Mar 2024 08:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DLi77o0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C1587FC8; Wed,  6 Mar 2024 08:36:07 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0BA887E63
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 08:36:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7c7476a11e0so345119339f.3
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 23:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709710560; x=1710315360; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EbuGNlJzrofB2z1MVZRG+JGomamGCTJK+Gey+yeuEKU=;
 b=DLi77o0jwpV9QTHPVKJvmbQdJ7CkPCIrXV0cJaV7YRu7SzxUbJk1yea/J2BkSkiowJ
 8zn3dVwEhDYlBJ/qejscXwBdXVy/DhlMBs4PJjhbv8qV6QlgtJVMPgu2AzP1abXMwolc
 gdYXkrVW4IZQWnrDX8yJ9ePmYEburVmUUJO8V16pmu1FfpDVjLryJaPxhUghTiaSHPyr
 gFhkWsPzwNHlLCRkkbXDSUDpochZ6kdUygne+399rZNjL3+Qg2zPuiMaKTJNp7pZkZRF
 jlxU/61ht5tk4x5E1EyHfxu4ikEikC0EBk5O0+Xo2qV7fMt0yww3qEmHTUjkd28fq21P
 t0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709710560; x=1710315360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EbuGNlJzrofB2z1MVZRG+JGomamGCTJK+Gey+yeuEKU=;
 b=YGpvGWUy4tO+FVXfgPMz5y+cozLXojnIWqgB9s9aJjpIn5ZbwW+McLAT7ukKUYLd9n
 qyVkZz/wCbrtqkAq8JCDfUevZqReaZ0PZqcn2HnAyT1UdwXmLSD9bQL9mVfavDc0opZw
 ITjxn7DCcrtN6cTefhniY2Z95KlTlE9LocM0RRt6pq91Vzs7/dCawIxnqoH76aoIz2hG
 GwGDXPanRX7uYGJaxi0snA6CD3wUPCnaJvDLORqNZQNNpyy34fPVK1ry4BWoi6je5Rx2
 EwBG4uhFYXjflnRKyqp2FMHhwOM17v0j2YYWPwIhIW+ZxW/o8BRUTTQPZbQ2AtIQkfxE
 luFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVVTVwyfaejmlFy/X8S4YQigI5XOZDUAqJhHisUe73ocGsP+BQ8Aoce1usMgDM050ygdhvYNC/WaAVQi26aRjUoX2PmA==
X-Gm-Message-State: AOJu0YxOE9QQ4pMxXGaFmT2t/zGvxXgBbMa5/xPGEsuwexpA5nP6tvLJ
 DSqOZltX9fH24S1z8vck9WQrHFyxuFfHLhmhW16fJCbNUxPI/U7p
X-Google-Smtp-Source: AGHT+IHRu0XoaMJODzOPR8Y8dhYs2/f5GK5m2IzqOV8imr1ZP8tdKmGbjuSRZ9BtsPsEv7T18h24sA==
X-Received: by 2002:a5e:9908:0:b0:7c8:74b1:a1fa with SMTP id
 t8-20020a5e9908000000b007c874b1a1famr1642549ioj.2.1709710560477; 
 Tue, 05 Mar 2024 23:36:00 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:10f:8bb5:397e:4402?
 ([2001:470:42c4:101:10f:8bb5:397e:4402])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a056638408600b00475014531fcsm802248jam.54.2024.03.05.23.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 23:36:00 -0800 (PST)
Message-ID: <6ddfaa6f-1cc5-4f5c-ac54-6a2d33b3dc20@gmail.com>
Date: Wed, 6 Mar 2024 00:35:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] arm: clean up v7 and v8 linker scripts for
 __rel_dyn_start/end
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
 <20240304090113.1410575-5-ilias.apalodimas@linaro.org>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20240304090113.1410575-5-ilias.apalodimas@linaro.org>
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
> commit 47bd65ef057f ("arm: make __rel_dyn_{start, end} compiler-generated")
> were moving the __rel_dyn_start/end on c generated variables that were
> injected in their own sections. The reason was that we needed relative
> relocations for position independent code and linker bugs back then
> prevented us from doing so.
> 
> However, the linker documentation pages states that symbols that are
> defined within a section definition will create a relocatable
> type with the value being a fixed offset from the base of a section [0].
> This have been fixed since 2016 [1]
> 
> [0] https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_mono/ld.html#SEC13
> [1] commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Sam Edwards <CFSworks@gmail.com>
Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical

Thanks for the cleanup,
Sam

> ---
>   arch/arm/cpu/armv8/u-boot.lds | 16 +++-------------
>   arch/arm/cpu/u-boot.lds       | 14 +++-----------
>   arch/arm/lib/sections.c       |  2 --
>   arch/arm/mach-zynq/u-boot.lds | 14 +++-----------
>   4 files changed, 9 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.lds
> index eccb116d3cfa..e737de761a9d 100644
> --- a/arch/arm/cpu/armv8/u-boot.lds
> +++ b/arch/arm/cpu/armv8/u-boot.lds
> @@ -129,20 +129,10 @@ SECTIONS
>   		*(.__image_copy_end)
>   	}
>   
> -	. = ALIGN(8);
> -
> -	.rel_dyn_start :
> -	{
> -		*(.__rel_dyn_start)
> -	}
> -
> -	.rela.dyn : {
> +	.rela.dyn ALIGN(8) : {
> +		__rel_dyn_start = .;
>   		*(.rela*)
> -	}
> -
> -	.rel_dyn_end :
> -	{
> -		*(.__rel_dyn_end)
> +		__rel_dyn_end = .;
>   	}
>   
>   	_end = .;
> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> index 70e78ce46672..7c6e7891d360 100644
> --- a/arch/arm/cpu/u-boot.lds
> +++ b/arch/arm/cpu/u-boot.lds
> @@ -166,18 +166,10 @@ SECTIONS
>   		*(.__image_copy_end)
>   	}
>   
> -	.rel_dyn_start :
> -	{
> -		*(.__rel_dyn_start)
> -	}
> -
> -	.rel.dyn : {
> +	.rel.dyn ALIGN(4) : {
> +		__rel_dyn_start = .;
>   		*(.rel*)
> -	}
> -
> -	.rel_dyn_end :
> -	{
> -		*(.__rel_dyn_end)
> +		__rel_dyn_end = .;
>   	}
>   
>   	.end :
> diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
> index ddfde52163fc..1ee3dd3667ba 100644
> --- a/arch/arm/lib/sections.c
> +++ b/arch/arm/lib/sections.c
> @@ -21,8 +21,6 @@
>   
>   char __image_copy_start[0] __section(".__image_copy_start");
>   char __image_copy_end[0] __section(".__image_copy_end");
> -char __rel_dyn_start[0] __section(".__rel_dyn_start");
> -char __rel_dyn_end[0] __section(".__rel_dyn_end");
>   char __secure_start[0] __section(".__secure_start");
>   char __secure_end[0] __section(".__secure_end");
>   char __secure_stack_start[0] __section(".__secure_stack_start");
> diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
> index 66a9e37f9198..71dea4a1f60a 100644
> --- a/arch/arm/mach-zynq/u-boot.lds
> +++ b/arch/arm/mach-zynq/u-boot.lds
> @@ -71,18 +71,10 @@ SECTIONS
>   		*(.__image_copy_end)
>   	}
>   
> -	.rel_dyn_start :
> -	{
> -		*(.__rel_dyn_start)
> -	}
> -
> -	.rel.dyn : {
> +	.rel.dyn ALIGN(8) : {
> +		__rel_dyn_start = .;
>   		*(.rel*)
> -	}
> -
> -	.rel_dyn_end :
> -	{
> -		*(.__rel_dyn_end)
> +		__rel_dyn_end = .;
>   	}
>   
>   	.end :
