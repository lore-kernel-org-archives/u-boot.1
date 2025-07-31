Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491B3C87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 12:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72E47838AA;
	Thu, 31 Jul 2025 14:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sb5i7JBv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05D5D838CC; Thu, 31 Jul 2025 14:14:17 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EC9B838A0
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 14:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CB69C3FCDD
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1753964051;
 bh=x6KGoevk1DNlZa7nzHnskae2ZihyDzS39lv+0p6uj2Q=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=sb5i7JBvTqHpCmC1ngcjJQyuAeOSVFprOosjc8zDJ6a2R1QU2YzAPfnL0EtjFc3so
 wHZkU1OFTnpBcJwsA/cGNVpYwJA/BPgrNO0ETtqOVYhMnIO/WDsmw54EdZ2oN7xkmF
 GnhnQE7lDm+aNaoS670R94tD/18i0QurdSgHQFtgZUxOIvEQJzG11dCyYSxssWfBWy
 Dxnd3j6QwvElIOqUcYVR7NZnWipBFYaWe3YJRkewSEhe3kaKy/K98YG6AcaMo0I3bj
 /dYhAIX0RJbGJxRuf+jnIF5xgQIydg07iCQXqe8sFsT+FwNce6FQuJxeTegRXxXFSH
 1mnahOVdgfc3g==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-456175dba68so5903125e9.2
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 05:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753964050; x=1754568850;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x6KGoevk1DNlZa7nzHnskae2ZihyDzS39lv+0p6uj2Q=;
 b=YsRRD6Ff+6JWWIvI6o33AKL1ELADFp4TPyk/sPnInakd92otyUESXEIyvCReCY3e/X
 IUm1+CWmfpMB/6Gowvqe15xcLWPbhKPuNcASPEUkdu/8SpURR9ZzfQBikR9Ost9UrFz8
 /xeDEF/DOhDufbp7u32HNC1/8xkkbWf8I/5CVxPxNQ7VoBPlBV+VjUXHWSc3kGRV2uWt
 smxRgPFrjBCE+1Pz4mYGkNzECEsAbXJOYdAopOvIlSeorF3qGhNu0x2ZupcqvVol+5DB
 0hhuGYLrGT5s47WSsKm5G4gYd3jQQ4nMGM01O/0U/Gu/IuJcL6fM5XnfBK/mrhNTYm63
 73dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURMHyYxV0yQMBN4zTigNsu/4emwgomTaKviANFMR+vTnNKPK5ZNo/0R+ZauPGTlHXk6sNdoRI=@lists.denx.de
X-Gm-Message-State: AOJu0YxyBshTjwIvZdWBXR+UEe2plGxXK6AqXFsyoRZbh/k06BUx+A+K
 DqPDLJiP7M44z5vSy5qBaZNWcvltCiKr+Lv0BHvjeVuajdn9oP5g4kK7nRnfuW2y+/+wga800fI
 3KjCzVRORhKfwE7/rbefS5a+dgN9lxAJz7XjeygSIuoqxNlGtYqPkNocec3Uj3fU4LMk6DJQ=
X-Gm-Gg: ASbGncso0HNSGmKKPM/Hq6HRbsujX9yZmagPZ+6wkuu34RmxxyvWAIGszhmP9ndvAFT
 GkFzx5nIGvH6gc8hEjK9/KiENsOM32sYWsQpb9C5mE4OzN3PrWSg0qW6+bHOMU+BHAs+CjGpRj0
 6AJ3CGcJInw8rAUEd6mdE+UJ84xCF3/nJAZuXJx1oMcuz8cqMid31mH0oG/MoaRbOSfDJiHh376
 lPJwOwk+kS/UDvZjFHGKacblv0F2bhd7EdA1Amlsi0n6SqCgufxNJF/Ve3cnI/8E9Mlx6pnPCSL
 4iM5F+sumNIsOlYWV19YhIiv+HpyjmL2JXLrM22wNCixW9gRepyE9QZICqL9TCfjJddWpumuYzj
 H2DNf7kHaNFWIKIzXU2JED5f4s99bB3DuXZqi
X-Received: by 2002:a05:600c:4752:b0:456:1a87:a6ba with SMTP id
 5b1f17b1804b1-45892ce74edmr57388805e9.33.1753964050415; 
 Thu, 31 Jul 2025 05:14:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHcftMEZi/EJ12+Jz7Y8f8EwPcErdacbJd+lo2FBL4pnctV9gQHwXxyrgY+QUEIL1FwqZfug==
X-Received: by 2002:a05:600c:4752:b0:456:1a87:a6ba with SMTP id
 5b1f17b1804b1-45892ce74edmr57388415e9.33.1753964049896; 
 Thu, 31 Jul 2025 05:14:09 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953cfcadsm67512145e9.18.2025.07.31.05.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 05:14:09 -0700 (PDT)
Message-ID: <290dd3f1-1850-4bc5-aa97-e19740f46934@canonical.com>
Date: Thu, 31 Jul 2025 14:14:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/3] Image size checks: Move all configs in one
 place
To: Philip Oberfichtner <pro@denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Gary Bisson <bisson.gary@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>, u-boot@lists.denx.de
References: <20250731114044.264745-1-pro@denx.de>
 <20250731114044.264745-4-pro@denx.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250731114044.264745-4-pro@denx.de>
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

On 31.07.25 13:40, Philip Oberfichtner wrote:
> How image size limiting works in U-Boot should be easier to grasp if we
> have all related options in one place.
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
>   Kconfig                | 59 ++++++++++++++++++++++++++++++++++++++++++
>   common/spl/Kconfig     | 38 ---------------------------
>   common/spl/Kconfig.tpl |  7 -----
>   common/spl/Kconfig.vpl |  7 -----
>   4 files changed, 59 insertions(+), 52 deletions(-)
> 
> diff --git a/Kconfig b/Kconfig
> index d0c0a6a1d53..6435a4c3bcc 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -535,6 +535,8 @@ config BUILD_TARGET
>   	  special image will be automatically built upon calling
>   	  make / buildman.
>   
> +menu "Image size limits"
> +
>   config BOARD_SIZE_LIMIT
>   	int "Maximum size of the U-Boot image in bytes"
>   	default 0
> @@ -546,6 +548,63 @@ config BOARD_SIZE_LIMIT
>   	  include SPL nor TPL, on platforms that use that functionality, they
>   	  have a separate option to restict size.

When reposting, please, rebase on by patch to fix the 'restict' typo.

>   
> +config SPL_SIZE_LIMIT
> +	depends on SPL
> +	hex "Maximum size of SPL image"
> +	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
> +	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB

This can be simplified:

	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
	default 0x11000 if ARCH_MX6

Best regards

Heinrich

> +	default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
> +	default 0x0
> +	help
> +	  Specifies the maximum length of the U-Boot SPL image.
> +	  If this value is zero, it is ignored.
> +
> +config SPL_SIZE_LIMIT_SUBTRACT_GD
> +	bool "SPL image size check: provide space for global data"
> +	depends on SPL_SIZE_LIMIT > 0
> +	help
> +	  If enabled, aligned size of global data is reserved in
> +	  SPL_SIZE_LIMIT check to ensure such an image does not overflow SRAM
> +	  if SPL_SIZE_LIMIT describes the size of SRAM available for SPL when
> +	  pre-reloc global data is put into this SRAM, too.
> +
> +config SPL_SIZE_LIMIT_SUBTRACT_MALLOC
> +	bool "SPL image size check: provide space for malloc() pool before relocation"
> +	depends on SPL_SIZE_LIMIT > 0
> +	help
> +	  If enabled, SPL_SYS_MALLOC_F_LEN is reserved in SPL_SIZE_LIMIT check
> +	  to ensure such an image does not overflow SRAM if SPL_SIZE_LIMIT
> +	  describes the size of SRAM available for SPL when pre-reloc malloc
> +	  pool is put into this SRAM, too.
> +
> +config SPL_SIZE_LIMIT_PROVIDE_STACK
> +	hex "SPL image size check: provide stack space before relocation"
> +	depends on SPL_SIZE_LIMIT > 0
> +	default 0x0
> +	help
> +	  If set, this size is reserved in SPL_SIZE_LIMIT check to ensure such
> +	  an image does not overflow SRAM if SPL_SIZE_LIMIT describes the size
> +	  of SRAM available for SPL when the stack required before reolcation
> +	  uses this SRAM, too.
> +
> +config TPL_SIZE_LIMIT
> +	depends on TPL
> +	hex "Maximum size of TPL image"
> +	default 0x0
> +	help
> +	  Specifies the maximum length of the U-Boot TPL image.
> +	  If this value is zero, it is ignored.
> +
> +config VPL_SIZE_LIMIT
> +	depends on VPL
> +	hex "Maximum size of VPL image"
> +	default 0x0
> +	help
> +	  Specifies the maximum length of the U-Boot VPL image.
> +	  If this value is zero, it is ignored.
> +
> +endmenu
> +
>   config SYS_CUSTOM_LDSCRIPT
>   	bool "Use a custom location for the U-Boot linker script"
>   	depends on !COMPILE_TEST
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index ab05536bd02..87a56bd8f8a 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -36,44 +36,6 @@ config SPL_FRAMEWORK_BOARD_INIT_F
>   	  - initialize the serial (preloader_console_init)
>   	  Unless you want to provide your own board_init_f, you should say Y.
>   
> -config SPL_SIZE_LIMIT
> -	hex "Maximum size of SPL image"
> -	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
> -	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
> -	default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
> -	default 0x0
> -	help
> -	  Specifies the maximum length of the U-Boot SPL image.
> -	  If this value is zero, it is ignored.
> -
> -config SPL_SIZE_LIMIT_SUBTRACT_GD
> -	bool "SPL image size check: provide space for global data"
> -	depends on SPL_SIZE_LIMIT > 0
> -	help
> -	  If enabled, aligned size of global data is reserved in
> -	  SPL_SIZE_LIMIT check to ensure such an image does not overflow SRAM
> -	  if SPL_SIZE_LIMIT describes the size of SRAM available for SPL when
> -	  pre-reloc global data is put into this SRAM, too.
> -
> -config SPL_SIZE_LIMIT_SUBTRACT_MALLOC
> -	bool "SPL image size check: provide space for malloc() pool before relocation"
> -	depends on SPL_SIZE_LIMIT > 0
> -	help
> -	  If enabled, SPL_SYS_MALLOC_F_LEN is reserved in SPL_SIZE_LIMIT check
> -	  to ensure such an image does not overflow SRAM if SPL_SIZE_LIMIT
> -	  describes the size of SRAM available for SPL when pre-reloc malloc
> -	  pool is put into this SRAM, too.
> -
> -config SPL_SIZE_LIMIT_PROVIDE_STACK
> -	hex "SPL image size check: provide stack space before relocation"
> -	depends on SPL_SIZE_LIMIT > 0
> -	default 0x0
> -	help
> -	  If set, this size is reserved in SPL_SIZE_LIMIT check to ensure such
> -	  an image does not overflow SRAM if SPL_SIZE_LIMIT describes the size
> -	  of SRAM available for SPL when the stack required before reolcation
> -	  uses this SRAM, too.
> -
>   config SPL_MAX_SIZE
>   	hex "Maximum size of the SPL image, excluding BSS"
>   	default 0x30000 if ARCH_MX6 && MX6_OCRAM_256KB
> diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
> index a535b61ecd3..515bbeec685 100644
> --- a/common/spl/Kconfig.tpl
> +++ b/common/spl/Kconfig.tpl
> @@ -1,13 +1,6 @@
>   menu "TPL configuration options"
>   	depends on TPL
>   
> -config TPL_SIZE_LIMIT
> -	hex "Maximum size of TPL image"
> -	default 0x0
> -	help
> -	  Specifies the maximum length of the U-Boot TPL image.
> -	  If this value is zero, it is ignored.
> -
>   config TPL_BINMAN_SYMBOLS
>   	bool "Support binman symbols in TPL"
>   	depends on TPL_FRAMEWORK && BINMAN
> diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
> index 434562443ac..739f2805315 100644
> --- a/common/spl/Kconfig.vpl
> +++ b/common/spl/Kconfig.vpl
> @@ -220,13 +220,6 @@ config VPL_SERIAL
>   	  Enable support for serial in VPL. See SPL_SERIAL for
>   	  details.
>   
> -config VPL_SIZE_LIMIT
> -	hex "Maximum size of VPL image"
> -	default 0x0
> -	help
> -	  Specifies the maximum length of the U-Boot VPL image.
> -	  If this value is zero, it is ignored.
> -
>   config VPL_SPI
>   	bool "Support SPI drivers"
>   	help

