Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D390DC0218D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 15:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E58180824;
	Wed, 22 Jan 2025 16:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xIwEKfDl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E336808A2; Wed, 22 Jan 2025 16:49:30 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93B9C80805
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 16:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5dc0522475eso278726a12.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 07:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737560967; x=1738165767; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K8o2fEi8qWEbnmDF5QwD5o6LqNmwhdr3E1SIcgmU5l8=;
 b=xIwEKfDlx2umIFj4xk18xhL2xgSdWEHMwOsWspMzXS6vs353Fc8/HvrkGLV1q4MAoO
 RrK6uXYPi5jXo78vNQ+L7VLdGOzDSrvHhMiULG0MuiYH6OUnfZwEWoTalQB/j94qh4Ng
 cZNeHEc61b2ccAsz74jIwq0vDDAhcCFTmKuJbr268aEZgdvAZkV8Sv3cBCfgfINR2DCr
 VMyKruREfH2RNTId7hqEAQ/ijt3zovrYtHV9bYm88BZ7ZlCR/9rKG0K59AUdwXX1Od1N
 chXZpzgXcdEHB5Gwx+eahRE5J9MytO4WFaL2r+6vTpikOFT/1l7VvYEhk8DhBcaxbApk
 lMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737560967; x=1738165767;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K8o2fEi8qWEbnmDF5QwD5o6LqNmwhdr3E1SIcgmU5l8=;
 b=Q9VTJIeCTIpcc/bpWI0TN7JajQq+5PYZtzfVSMHKMNA67JUhG+rTihi8Bs5+45ifPj
 n8qw7dDv/UPkaTbstJPpKsTYw33kTIYAtyainOUruCBGHvaG1UCmv7xrLn9SzaT5ahyD
 iosXfEn5P0EpC44UNmyZmL8P+J/HzeV3876zxPi6RSySvAzqP/kCUxfmL/YzzTTAdgY4
 I8X3HjZrvTQxZucKRIHQ/UEG9TPaCFlJg+KL3d7016219ZNse1ApRSU7f9X5ow0NF+Zv
 Gp08EN7NuKfMJNF31LSYLbElMqISGVu17JPVKf0IkBGsDRDqtpMWySBZhVoJ0pWnudMm
 PBlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyLIggCEM3ieEao9+pZLfRjVqWHHTqe6Cl4XrQU007R42DCR5UVZDPVnUUb6FlbtCf8es6QDU=@lists.denx.de
X-Gm-Message-State: AOJu0YykDFIcF2jmoUiMpZWOI0o0KS/Jjg1lYy3sbLdaAZ9FN+uyWAzq
 RjKGpR6vKPLUN8rWKfTYMPx/eOkVvCTw+crUjOnf2oHvP6Z6OpYUvzdsProYGlE=
X-Gm-Gg: ASbGnctgBQE1vofVB5fOEE9L53O9wi37k8ktky0IYe/I75+gBhhRfPv8oYt8KtbAFXk
 UNpQvKzqbffx4UpopRUQmyrEG/j/grR/YI+kjndPvU/w0U0Ur0NIWdA4ir0RmUHmrqREp8U72jb
 k8Gk/EN09cwOZ16sXNeBM+VJIuRxOwQ1QldMM8Dw0531MsyxH6dNoiwAg9AGdNYdwRGuQVPfuTW
 bPvw79qmP5tI4cEgd64X7oMARchpboNqanBnBv8SAiASMrxUeC6MmEIeYnWKHBzjqc2bUmBtkDs
 ipwFbk24JimXFyootJAdr0TKdPlbPlkMoL2zV5M/EIEWDlBdQ9xY
X-Google-Smtp-Source: AGHT+IFT2Trv+GMRtsPkanjHx2t+wzjbK2myz7U3hAOrrIfbVtA2Yk+DBKt3rh5mFukQRcl0QZ8Dmg==
X-Received: by 2002:a05:6402:3551:b0:5d1:1f1:a283 with SMTP id
 4fb4d7f45d1cf-5db7d2dc3f1mr20508435a12.4.1737560966919; 
 Wed, 22 Jan 2025 07:49:26 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73edccd4sm8827056a12.77.2025.01.22.07.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 07:49:26 -0800 (PST)
Message-ID: <32349f10-2fe1-4522-8794-cf512b140038@linaro.org>
Date: Wed, 22 Jan 2025 16:49:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mach-snapdragon: support parsing memory info from
 external FDT
Content-Language: en-US
To: Sam Day <me@samcday.com>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250122-qcom-parse-memory-updates-v2-0-98dfcac821d7@samcday.com>
 <20250122-qcom-parse-memory-updates-v2-2-98dfcac821d7@samcday.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250122-qcom-parse-memory-updates-v2-2-98dfcac821d7@samcday.com>
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

Hi Sam,

Thanks for re-spinning this, one small issue below but otherwise LGTM.

I'm picking up your first patch, so you only need to re-send this one.

On 22/01/2025 11:27, Sam Day wrote:
> qcom_parse_memory is updated to return a -ENODATA error if the passed
> FDT does not contain a /memory node, or that node is incomplete (size=0)
> 
> board_fdt_blob_setup first tries to call qcom_parse_memory with the
> internal FDT (if present+valid). If that fails, it tries again with the
> external FDT (again, if present+valid).
> 
> When booting with an internal FDT from upstream, it's likely that this
> change results in a slight performance hit, since virtually all upstream
> qcom DTs lack a fully specified memory node. The impact should be
> negligible, though.
> 
> qcom_parse_memory was given a detailed docstring adapted from Caleb's
> original commit message that introduced the function.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  arch/arm/mach-snapdragon/board.c | 93 +++++++++++++++++++++++++++-------------
>  1 file changed, 63 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 2ef936aab757c7045729a2dd91944f4f9bff917e..ad3bc4b1a998049cd10e3d3fa032009347d77314 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -88,7 +88,29 @@ int dram_init_banksize(void)
>  	return 0;
>  }
>  
> -static void qcom_parse_memory(const void *fdt)
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
> + *
> + * @fdt: FDT blob to parse /memory node from
> + *
> + * Return: 0 on success or -ENODATA if /memory node is missing or incomplete
> + */
> +static int qcom_parse_memory(const void *fdt)
>  {
>  	int offset;
>  	const fdt64_t *memory;
> @@ -97,16 +119,12 @@ static void qcom_parse_memory(const void *fdt)
>  	int i, j, banks;
>  
>  	offset = fdt_path_offset(fdt, "/memory");
> -	if (offset < 0) {
> -		log_err("No memory node found in device tree!\n");
> -		return;
> -	}
> +	if (offset < 0)
> +		return -ENODATA;
>  
>  	memory = fdt_getprop(fdt, offset, "reg", &memsize);
> -	if (!memory) {
> -		log_err("No memory configuration was provided by the previous bootloader!\n");
> -		return;
> -	}
> +	if (!memory)
> +		return -ENODATA;
>  
>  	banks = min(memsize / (2 * sizeof(u64)), (ulong)CONFIG_NR_DRAM_BANKS);
>  
> @@ -119,7 +137,6 @@ static void qcom_parse_memory(const void *fdt)
>  	for (i = 0, j = 0; i < banks * 2; i += 2, j++) {
>  		prevbl_ddr_banks[j].start = get_unaligned_be64(&memory[i]);
>  		prevbl_ddr_banks[j].size = get_unaligned_be64(&memory[i + 1]);
> -		/* SM8650 boards sometimes have empty regions! */
>  		if (!prevbl_ddr_banks[j].size) {
>  			j--;
>  			continue;
> @@ -127,13 +144,16 @@ static void qcom_parse_memory(const void *fdt)
>  		ram_end = max(ram_end, prevbl_ddr_banks[j].start + prevbl_ddr_banks[j].size);
>  	}
>  
> +	if (!j)
> +		return -ENODATA;

I think this should be
	if (!banks || !prevbl_ddr_banks[0].size)

That way it will properly detect the typical case where the source dts
has a single entry with a 0 size.

With that change:

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Kind regards,
> +
>  	/* Sort our RAM banks -_- */
>  	qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
>  
>  	gd->ram_base = prevbl_ddr_banks[0].start;
>  	gd->ram_size = ram_end - gd->ram_base;
> -	debug("ram_base = %#011lx, ram_size = %#011llx, ram_end = %#011llx\n",
> -	      gd->ram_base, gd->ram_size, ram_end);
> +
> +	return 0;
>  }
>  
>  static void show_psci_version(void)
> @@ -153,13 +173,14 @@ static void show_psci_version(void)
>   */
>  int board_fdt_blob_setup(void **fdtp)
>  {
> -	struct fdt_header *fdt;
> +	struct fdt_header *external_fdt, *internal_fdt;
>  	bool internal_valid, external_valid;
> -	int ret = 0;
> +	int ret = -ENODATA;
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
> @@ -167,24 +188,36 @@ int board_fdt_blob_setup(void **fdtp)
>  	 */
>  	if (!internal_valid && !external_valid)
>  		panic("Internal FDT is invalid and no external FDT was provided! (fdt=%#llx)\n",
> -		      (phys_addr_t)fdt);
> +		      (phys_addr_t)external_fdt);
> +
> +	/* Prefer memory information from internal DT if it's present */
> +	if (internal_valid)
> +		ret = qcom_parse_memory(internal_fdt);
> +
> +	if (ret < 0 && external_valid) {
> +		/* No internal FDT or it lacks a proper /memory node.
> +		 * The previous bootloader handed us something, let's try that.
> +		 */
> +		if (internal_valid)
> +			debug("No memory info in internal FDT, falling back to external\n");
> +
> +		ret = qcom_parse_memory(external_fdt);
> +	}
> +
> +	if (ret < 0)
> +		panic("No valid memory ranges found!\n");
> +
> +	debug("ram_base = %#011lx, ram_size = %#011llx\n",
> +	      gd->ram_base, gd->ram_size);
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

