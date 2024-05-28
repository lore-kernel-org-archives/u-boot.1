Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FB1C25B7E
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 06:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66EC6883F2;
	Tue, 28 May 2024 08:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="09y5hhTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57997883F1; Tue, 28 May 2024 08:40:49 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97A8288402
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 08:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1716878444;
 bh=Xdlh3ehJpJwR7ll7YPd/9n4RwZTwNhzEl96ZkdRDhLU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=09y5hhTUdx3QuQzP/DRdd8C6wmToQegQAezYQJMNwKvQEkHQKEmCaNc127iE0JJzm
 7dimTvc9mWMXUF0XUM3IYfxStUuiiwyreglesDR6rSOWlutn1vdobM9bnhCJbvAZ6f
 hBGlgnMGhF3bKWL4LpwajG/1Ny9tUbBaCCiZKr1dYD0VVF+xP3KSQOcC/iUHIUeka1
 LOkpwXHOdFXGLczo0cr1Kj/QiyQdB3zI+CHBVuu+waau9Ollx/lRpfGPYfYGo8YNyZ
 YvYdgAHPov+qINMexzT6C67OKjfNXk6cNyIqqMAG3JS/TnlL68J7UKezc9M19nn9Zg
 EZNeAB6ADsk+Q==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id CC78F3780BFE;
 Tue, 28 May 2024 06:40:42 +0000 (UTC)
Message-ID: <e8082f27-e1e9-406a-84ea-b9f35de077b7@collabora.com>
Date: Tue, 28 May 2024 09:40:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: move _end to linker symbols
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 xypron.glpk@gmx.de, CFSworks@gmail.com, trini@konsulko.com
Cc: sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com,
 BMC-SW@aspeedtech.com, joel@jms.id.au, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, michal.simek@amd.com,
 aford173@gmail.com
References: <20240528061827.183403-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20240528061827.183403-1-ilias.apalodimas@linaro.org>
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

On 5/28/24 09:18, Ilias Apalodimas wrote:
> commit 6e2228fb052b ("Merge patch series "Clean up arm linker scripts")
> was cleaning up linker scripts for armv7 and v8 but was leaving
> _end and __secure_stack_start/end.
> 
> commit d0b5d9da5de2 ("arm: make _end compiler-generated")
> was moving _end to be compiler generated. _end is defined as c variable
> in its own section to force the compiler emit relative a reference.
> However, defining those in the linker script will do the same thing
> since [0].
> 
> So let's remove the special sections from the linker scripts, the
> variable definitions from sections.c and define them as a symbols.
> It's worth noting that _image_binary_end symbol is now redundant and
> can be removed in the future.
> 
> - SPL
> 
> The .end section has been removed from the new binary
> [ 5] .end
>      PROGBITS         00000000fffdf488  000000000002f488  0
>      0000000000000000 0000000000000000  0                 1
>      [0000000000000003]: WRITE, ALLOC
> 
> $~ bloat-o-meter kria_old/spl/u-boot-spl krina_new/spl/u-boot-spl
> add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
> Function                                     old     new   delta
> Total: Before=115980, After=115980, chg +0.00%
> 
> $~ readelf -sW kria_old/u-boot kria_new/u-boot | grep -w _end
>  12047: 000000000813a0f0     0 OBJECT  GLOBAL DEFAULT   11 _end
>  12047: 000000000813a118     0 NOTYPE  GLOBAL DEFAULT   11 _end
> 
> $~ readelf -sW kria_old/spl/u-boot-spl kria_new/spl/u-boot-spl | grep -w _end
>   1605: 00000000fffdf488     0 OBJECT  GLOBAL DEFAULT    5 _end
>   1603: 00000000fffdf498     0 NOTYPE  GLOBAL DEFAULT    4 _end
> 
> $~ readelf -sW old/u-boot new/u-boot | grep -w _end
>   8847: 0000000000103710     0 OBJECT  GLOBAL DEFAULT   11 _end
>   8847: 0000000000103738     0 NOTYPE  GLOBAL DEFAULT   11 _end
> 
> $~ readelf -sW old_v7/u-boot new_v7/u-boot | grep -w _end
>  10638: 000da824     0 OBJECT  GLOBAL DEFAULT   10 _end
>  10637: 000da84c     0 NOTYPE  GLOBAL DEFAULT   10 _end
> 
> - For both QEMU instances
> $~ bloat-o-meter old/u-boot new/u-boot
> add/remove: 0/0 grow/shrink: 1/0 up/down: 20/0 (20)
> Function                                     old     new   delta
> version_string                                50      70     +20
> Total: Before=656915, After=656935, chg +0.00%
> 
> [0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  arch/arm/cpu/arm1136/u-boot-spl.lds            | 6 +-----
>  arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds      | 6 +-----
>  arch/arm/cpu/armv8/u-boot-spl.lds              | 7 +------
>  arch/arm/cpu/u-boot-spl.lds                    | 6 +-----
>  arch/arm/cpu/u-boot.lds                        | 6 +-----
>  arch/arm/lib/sections.c                        | 1 -
>  arch/arm/mach-aspeed/ast2600/u-boot-spl.lds    | 6 +-----
>  arch/arm/mach-at91/arm926ejs/u-boot-spl.lds    | 7 +------
>  arch/arm/mach-at91/armv7/u-boot-spl.lds        | 7 +------
>  arch/arm/mach-omap2/u-boot-spl.lds             | 7 +------
>  arch/arm/mach-rockchip/u-boot-tpl-v8.lds       | 7 +------
>  arch/arm/mach-zynq/u-boot.lds                  | 6 +-----
>  board/davinci/da8xxevm/u-boot-spl-da850evm.lds | 7 +------
>  board/samsung/common/exynos-uboot-spl.lds      | 6 +-----
>  14 files changed, 13 insertions(+), 72 deletions(-)
> 
> diff --git a/arch/arm/cpu/arm1136/u-boot-spl.lds b/arch/arm/cpu/arm1136/u-boot-spl.lds
> index f83988fd7e6a..b7af29183a97 100644
> --- a/arch/arm/cpu/arm1136/u-boot-spl.lds
> +++ b/arch/arm/cpu/arm1136/u-boot-spl.lds
> @@ -33,11 +33,7 @@ SECTIONS
>  	.data : { *(SORT_BY_ALIGNMENT(.data*)) } >.sram
>  	. = ALIGN(4);
>  	__image_copy_end = .;
> -
> -	.end :
> -	{
> -		*(.__end)
> -	}
> +	_end = .;
>  
>  	.bss :
>  	{
> diff --git a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> index 7e20448f8108..7c6309246f8b 100644
> --- a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> +++ b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> @@ -49,11 +49,7 @@ SECTIONS
>  		__bss_end = .;
>  	}
>  
> -	.end :
> -	{
> -		*(.__end)
> -	}
> -
> +	_end = .;
>  	_image_binary_end = .;
>  
>  	.dynsym _image_binary_end : { *(.dynsym) }
> diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
> index ef8af67e11c3..215cedd69a8c 100644
> --- a/arch/arm/cpu/armv8/u-boot-spl.lds
> +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
> @@ -53,12 +53,7 @@ SECTIONS
>  
>  	. = ALIGN(8);
>  	__image_copy_end = .;
> -
> -	.end : {
> -		. = ALIGN(8);
> -		*(.__end)
> -	} >.sram
> -
> +	_end = .;
>  	_image_binary_end = .;
>  
>  	.bss : {
> diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> index 9ed62395a9c5..eee463a1b1c6 100644
> --- a/arch/arm/cpu/u-boot-spl.lds
> +++ b/arch/arm/cpu/u-boot-spl.lds
> @@ -53,12 +53,8 @@ SECTIONS
>  		__rel_dyn_end = .;
>  	}
>  
> -	.end :
> -	{
> -		*(.__end)
> -	}
> -
>  	_image_binary_end = .;
> +	_end = .;
>  
>  	.bss __rel_dyn_start (OVERLAY) : {
>  		__bss_start = .;
> diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
> index 707b19795f08..2f50087f57a9 100644
> --- a/arch/arm/cpu/u-boot.lds
> +++ b/arch/arm/cpu/u-boot.lds
> @@ -166,11 +166,7 @@ SECTIONS
>  		__rel_dyn_end = .;
>  	}
>  
> -	.end :
> -	{
> -		*(.__end)
> -	}
> -
> +	_end = .;
>  	_image_binary_end = .;
>  
>  	/*
> diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
> index db5463b2bbbc..07efabaa7dc8 100644
> --- a/arch/arm/lib/sections.c
> +++ b/arch/arm/lib/sections.c
> @@ -23,4 +23,3 @@ char __secure_start[0] __section(".__secure_start");
>  char __secure_end[0] __section(".__secure_end");
>  char __secure_stack_start[0] __section(".__secure_stack_start");
>  char __secure_stack_end[0] __section(".__secure_stack_end");
> -char _end[0] __section(".__end");
> diff --git a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> index ada6570d9712..9502a7384b53 100644
> --- a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> +++ b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> @@ -61,11 +61,7 @@ SECTIONS
>  		__rel_dyn_end = .;
>  	} > .nor
>  
> -	.end :
> -	{
> -		*(.__end)
> -	} > .nor
> -
> +	_end = .;
>  	_image_binary_end = .;
>  
>  	.bss : {
> diff --git a/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds b/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds
> index 1a8bf94dee0c..09cf838cf96e 100644
> --- a/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds
> +++ b/arch/arm/mach-at91/arm926ejs/u-boot-spl.lds
> @@ -33,12 +33,7 @@ SECTIONS
>  
>  	. = ALIGN(4);
>  	__image_copy_end = .;
> -
> -	.end :
> -	{
> -		*(.__end)
> -	} >.sram
> -
> +	_end = .;
>  	_image_binary_end = .;
>  
>  	.bss :
> diff --git a/arch/arm/mach-at91/armv7/u-boot-spl.lds b/arch/arm/mach-at91/armv7/u-boot-spl.lds
> index 6ca725fc4ce0..460a91d93ec4 100644
> --- a/arch/arm/mach-at91/armv7/u-boot-spl.lds
> +++ b/arch/arm/mach-at91/armv7/u-boot-spl.lds
> @@ -40,12 +40,7 @@ SECTIONS
>  
>  	. = ALIGN(4);
>  	__image_copy_end = .;
> -
> -	.end :
> -	{
> -		*(.__end)
> -	} >.sram
> -
> +	_end = .;

Does this have any kind of consequence in terms of checking the offset of .end vs
the SRAM size ? (.sram)

>  	_image_binary_end = .;
>  
>  	.bss :

