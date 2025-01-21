Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354F9C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 12:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EC3880326;
	Tue, 21 Jan 2025 13:33:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dnX2gtB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67E44805C5; Tue, 21 Jan 2025 13:33:35 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ED43801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 13:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so782069966b.0
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 04:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737462812; x=1738067612; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WgQcXFUa2gqIWMPBih+nCAmCA/3kLnNEuPbSitKmy9I=;
 b=dnX2gtB4RCjxxxtoJvz70HgEfR+i6mPFDGm3MjrRjRrGJJ2zf/jLT8SzA26XK13dez
 9rXMkq+awW9eHIIy1s+uwd5Ke1vhnOg9DcOR4xx6NVuWQs9Tj7nF6W9ERhYLDW8LjpTA
 vv2LYIkCp8R8AQ5gb9WfHuSWcxeVYD+asMZ2cFLhuIvgZ2UgdSDpIyM7DkzY8lgtZoso
 IYy3zlNGMy89wqX8fh/Ezx01fJQwAZtMZYd372I4aoghBZSs+DMmcQ+aeqqzbSsCs+iE
 UkpYJRsRb+UVmBrqGtQB3zxvT/n8JzVtTsDU1FOcnd+osM3H7tE6Z3qt+r0ll/rliePL
 EHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737462812; x=1738067612;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WgQcXFUa2gqIWMPBih+nCAmCA/3kLnNEuPbSitKmy9I=;
 b=Z4cWf/p2SnICQDI6M5DwIkye6Fhbgs5CPo0q9ot0RzEXaQtpFS4MloHlLt3wv/9YuJ
 Nbj2hm+KbZlX6gr9JyTO7i+KRpE5CcnxxzcSp2D+UHNOcfnbLYL3dbLy+/OflVVu8M8c
 PBCtgK2FxRZ2Yq2PFKhGmAOrAp/DY+nRxlrIFLcML6LziBMOKgH9vnJh1iWApUHNLPOH
 aq7CIJfhvyoNE7oSTRmQBylRCXKL2eSrtncIuIYOC+f51bFYiAyNE0h8xjezZVQ9Ue+L
 9cw7mZvx7nue020QsGzzg0hXJ5X2Jewf9hz6grEep6cfX2aP/tps4qBDapiE/0MQsIas
 C3VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/9DafVpzUXi0JHdk9vZxQown0x/dCPDa9iG0J9xQ5jKBt1s7wX4vjkJ7dDApOwugPKIcEPn0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy06Ydac8hZn3Km8CFYNTQnBSGu+s3kMH/yNMxsBfnXyQ3AFu/c
 cvy+2x8VthG+90B5ZW/y+0WhQQBrsdBjPa6Hs25NoY7NBDMsDub44xQ0sUkzXLQ=
X-Gm-Gg: ASbGncsGaTPU8vraPqRhRy+zEoIP1CaBwnr1UgjKCgFuMkoicBAhO6AuWAjKIMrDlHL
 BOEKtN00Gp38Lb/BSf1yOwj+lNRkmSNIz2NMtyuM2NZCafmBMsXKHvhyOVDA/pAPjfL/0XidoqN
 Fbz/IgXDkSVPALsKThtSss/8ZhbWIeIBP6wnurjFTeRTiltxdjJpiV/DTij0ijBm91ACPbEayBM
 oZX1c5exp1EndQvxnUk1pGCdnZMtaVZ9WuzLcot6UPGm9t4TXxAq1jYa/6IZTaSm2tdp4F3KCVX
 gCUGSWqLeuH43Q043ilDkVcLqRMy75GNqcaNko5SVqChIW3bWtDx
X-Google-Smtp-Source: AGHT+IEfJuafDhV+6WG2Jhrn+NvCZBim6WtB2IzyVzndPH1b+6QxxQGZeOJgJZSzakEY5MephnmUpA==
X-Received: by 2002:a17:907:60d2:b0:aa6:82ea:69d6 with SMTP id
 a640c23a62f3a-ab38b10cfbfmr1500043766b.18.1737462812284; 
 Tue, 21 Jan 2025 04:33:32 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384fcd91asm735398666b.167.2025.01.21.04.33.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 04:33:31 -0800 (PST)
Message-ID: <25dee2fd-e021-46cd-bff5-c0ae989a6c08@linaro.org>
Date: Tue, 21 Jan 2025 13:33:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mach-snapdragon: support parsing memory info from
 external FDT
Content-Language: en-US
To: Sam Day <me@samcday.com>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250120-qcom-parse-memory-updates-v1-0-54a7f0550cff@samcday.com>
 <20250120-qcom-parse-memory-updates-v1-2-54a7f0550cff@samcday.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250120-qcom-parse-memory-updates-v1-2-54a7f0550cff@samcday.com>
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



On 20/01/2025 20:43, Sam Day wrote:
> Prior to this commit, board_fdt_blob_setup would decide which FDT to
> use, either the external one from the previous bootloader, or the
> internal one that was compiled into the binary.
> 
> This commit expands that behaviour a bit further, and introduces a
> (default-enabled) option to always parse the /memory node from the
> external FDT (if it's present and valid), even if we're going to
> continue the boot with an internal one.
> 
> The rationale here is that many (all?) of the upstream DTs for the
> msm8916 + sdm845 (and likely others) socs do not fully specify the /memory
> node(s), since it's typically expected that the bootloader has selected
> one of these from an Android boot.img and then filled in the memory
> info.
> 
> Caleb's original explanation in the commit that introduced
> qcom_parse_memory was dropped into a comment above that function, since
> this part of the early initialization is getting quite nuanced. We don't
> want uninitiated folks to see that code and run away screaming or give
> away all their possessions and move to a monastery or something.

Maaaybe this last sentence isn't super necessary :P
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  arch/arm/mach-snapdragon/Kconfig | 13 +++++++++
>  arch/arm/mach-snapdragon/board.c | 57 +++++++++++++++++++++++++++-------------
>  2 files changed, 52 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 976c0e35fcef29bafecbbd6ea04459de852df275..0feb65a916459160a4da9947a6d7224930d507b4 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -45,4 +45,17 @@ config SYS_CONFIG_NAME
>  	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
>  	  will be used for board configuration.
>  
> +config SYS_MEMORY_FROM_EXTERNAL_FDT
> +	bool "Always parse /memory from external device tree, if it's provided"
> +	default y
> +	help
> +	  When booting with an internal DT, we'll always use that since it's
> +	  expected to be more accurate + up-to-date than whatever the previous
> +	  bootloader hands us.
> +
> +	  The notable exception here is the /memory node. With this config option
> +	  enabled, we'll initialize memory based on the information provided in the
> +	  external DT from the previous bootloader, even if we use the internal DT
> +	  for everything else.

I definitely understand why you made this a config option, but I think
we can make this make sense at runtime (admittedly with a little bit of
complexity).

What if we adjust qcom_parse_memory() to return an int, 0 on success and
-ENODATA IFF (If and only if) the memory node has only a single entry
with a size of 0.

Then we can call it first with the internal fdt, if it returns -ENODATA
and we have a valid external fdt then we can try that next.

This way, your usecase with the msm8916 device will still work as
expected (since it will gracefully fall back to the external fdt), but
if for some reason we have a device where there needs to be an external
fdt but we want to override the memory map we can still do so.

I think we can live with the small overhead here and optimise it in the
future if that becomes desirable, and avoid introducing a
device-specific config option.
> +
>  endif
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 2ef936aab757c7045729a2dd91944f4f9bff917e..f637bce18546fb3a9fe389e07f457346ad5f95c8 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -88,6 +88,29 @@ int dram_init_banksize(void)
>  	return 0;
>  }
>  
> +/**
> + * The generic memory parsing code in U-Boot lacks a few things that we
> + * need on Qualcomm:
> + *
> + * 1. It sets gd->ram_size and gd->ram_base to represent a single memory block
> + * 2. setup_dest_addr() later relocates U-Boot to ram_base + ram_size, the end
> + *    of that first memory block.
> + *
> + * This results in all memory beyond U-Boot being unusable in Linux when booting
> + * with EFI.
> + *
> + * Since the ranges in the memory node may be out of order, the only way for us
> + * to correctly determine the relocation address for U-Boot is to parse all
> + * memory regions and find the highest valid address.
> + *
> + * We can't use fdtdec_setup_memory_banksize() since it stores the result in
> + * gd->bd, which is not yet allocated.

Thanks for adding this!

Kind regards,
> + *
> + * This function requires a pointer to the specific FDT that we should parse
> + * for its /memory block. This is because when SYS_MEMORY_FROM_EXTERNAL_FDT is
> + * enabled, we might be looking at the FDT provided by the previous bootloader,
> + * rather than our internal (gd->fdt_blob) one.
> + */
>  static void qcom_parse_memory(const void *fdt)
>  {
>  	int offset;
> @@ -153,13 +176,13 @@ static void show_psci_version(void)
>   */
>  int board_fdt_blob_setup(void **fdtp)
>  {
> -	struct fdt_header *fdt;
> +	struct fdt_header *external_fdt, *internal_fdt;
>  	bool internal_valid, external_valid;
> -	int ret = 0;
>  
> -	fdt = (struct fdt_header *)get_prev_bl_fdt_addr();
> -	external_valid = fdt && !fdt_check_header(fdt);
> -	internal_valid = !fdt_check_header(*fdtp);
> +	internal_fdt = (struct fdt_header *)*fdtp;
> +	external_fdt = (struct fdt_header *)get_prev_bl_fdt_addr();
> +	external_valid = external_fdt && !fdt_check_header(external_fdt);
> +	internal_valid = !fdt_check_header(internal_fdt);
>  
>  	/*
>  	 * There is no point returning an error here, U-Boot can't do anything useful in this situation.
> @@ -167,24 +190,22 @@ int board_fdt_blob_setup(void **fdtp)
>  	 */
>  	if (!internal_valid && !external_valid)
>  		panic("Internal FDT is invalid and no external FDT was provided! (fdt=%#llx)\n",
> -		      (phys_addr_t)fdt);
> +		      (phys_addr_t)external_fdt);
> +
> +	if (IS_ENABLED(CONFIG_SYS_MEMORY_FROM_EXTERNAL_FDT) && external_valid)
> +		/* Explicitly use the external FDT to configure memory */
> +		qcom_parse_memory(external_fdt);
> +	else
> +		qcom_parse_memory(internal_fdt);
>  
>  	if (internal_valid) {
>  		debug("Using built in FDT\n");
> -		ret = -EEXIST;
> -	} else {
> -		debug("Using external FDT\n");
> -		/* So we can use it before returning */
> -		*fdtp = fdt;
> +		return -EEXIST;
>  	}
>  
> -	/*
> -	 * Parse the /memory node while we're here,
> -	 * this makes it easy to do other things early.
> -	 */
> -	qcom_parse_memory(*fdtp);
> -
> -	return ret;
> +	debug("Using external FDT\n");
> +	*fdtp = external_fdt;
> +	return 0;
>  }
>  
>  void reset_cpu(void)
> 

-- 
// Caleb (they/them)

