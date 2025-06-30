Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3EFC83029
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 14:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 957A281D6A;
	Mon, 30 Jun 2025 16:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JfqiWZgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79E8881E13; Mon, 30 Jun 2025 16:30:16 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 399B380B9B
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 16:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-60702d77c60so9128981a12.3
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751293812; x=1751898612; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LkSr1IbXjHdK6oK7+LvpeosYQjQVN8o3Z4VqC386gGQ=;
 b=JfqiWZgXVp2e/cKpoe+/6Gfax8Dm0aH8xPjrIFiH/idBWvTOwHTFFZgUxyaWaMYKp9
 AtKTmqu7r5hKcE2m89x/T/096FS/mR5gGcHA6F1CwoGi77Fyt4uFwkczPUnPfUf5Dd2M
 eWUUFsH7JXICtdNiORF8FO0iDo20tPeo7mktYrK/0xcL5tNl1LrZvShuW9Kt8WjpHvl3
 RowIVgNgYkzb4EjqqJbs6g6YMQPFP3cU3RQgsstGSLb4xlbyq0torZlUWri52+ulEI8d
 TIo0kQnsr0kQ7F3KvaCpkZpBK4PXdo6bgFiPiCQZz+362NUuvJE4heVp5dfQXn44XyC1
 zGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751293812; x=1751898612;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LkSr1IbXjHdK6oK7+LvpeosYQjQVN8o3Z4VqC386gGQ=;
 b=SMCdlU8tdz0t7bMmSui5WT5KrUCczZ8z4ZyvSFWSWub7Ao8epWcOQpx1aTutr1BEXt
 X48rfM+oRX4iphiRmPZlVIYYC2MO91G1eY9EzOLTKZ7VnfUMbjAW2XjIzr4H1MTHGH7x
 Rh7rCa/hGB4Ud86duGH1tuBROXSpwQ039S2FMZpw+ftAT/LydRg7bAXUdMK1ubk7+YnO
 bjz3y+Tnsfm7rmJS4Hse1f+r8nPnapaHpOyDsYdQWwC2EBr+nUrJDtwjzuEGJMSA4fOl
 EOOzfTeDoZ12dQXeF5KCqM072idZbUuW8xFTgu7WvP4C3nbzUXiO1Wp0q7GreZEPyYcc
 +qMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEzb6KAkwqONyInAFOd8JZy3RPxxRJgI/6doaLBt0DM3jgyGwaMWc/o4kw2Cql4MZNGXa+Qpc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4ljCIK9lIbhh7psilhvG+WZfkpSXDDRQ3uPLlbeX+V7hlxQha
 8r6VqTmHOPAGfx7f6C0pN6ah8AqHM2WyIiNnABFBHAx4XwRNYu6r32NpSaRD2Eaqe04=
X-Gm-Gg: ASbGncsffdC6EcddFxrxdrqXdMlNPQkLv60qOXGeJaqnv0lr50+dmyDKGQbD0xgDFwc
 pjBY2MYbfPkENyyMZKBNrFrAkWMnSjhLyHOZRJlg/ivZPS/EdZswIFDbc02xud94pqLFFMmTKQv
 Y29ukRpFSgm2kzWp+FCv4D1eLeIzluRo6BFqiIx6iNRW1Yj1W/hvWuYRd66qHkeYoTld0atEsU8
 rhBINsG22bbUUmv5WF/XAjlQZX9tDIK2OdSbFSryClin2HaLavRB+P1YCNLBqCgg3GGYTOO+v1E
 ar9oH/kDNsax8DEaVswB/YHNMlPE7Jc5TRfFkQpze29V13qMoE52htMoeQX7Rt+sN4ZF
X-Google-Smtp-Source: AGHT+IHeevOOJd1W1hz/QOjzwPzl5z54n/bNliRusonnurUNCW5ODbm1FqH9kQq95Z4apFXlIGu+rg==
X-Received: by 2002:a17:906:c147:b0:ae0:df46:abd1 with SMTP id
 a640c23a62f3a-ae3501518a3mr1344200166b.45.1751293811527; 
 Mon, 30 Jun 2025 07:30:11 -0700 (PDT)
Received: from [10.5.0.2] ([45.11.80.135]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353c0427bsm672835066b.84.2025.06.30.07.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 07:30:10 -0700 (PDT)
Message-ID: <198d53d6-bd1f-480f-86a7-5bd2987cd2a7@linaro.org>
Date: Mon, 30 Jun 2025 16:30:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spl: fit: Add ability to jump to Linux via
 OpTee-OS on ARMv7a
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250630000832.952206-1-marek.vasut@mailbox.org>
 <20250630000832.952206-2-marek.vasut@mailbox.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250630000832.952206-2-marek.vasut@mailbox.org>
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

Hi Marek,

On 6/30/25 02:08, Marek Vasut wrote:
> Add support for jumping to Linux kernel through OpTee-OS on ARMv7a to SPL.

Nitpicking: OP-TEE OS

Regards,
-- 
Jerome

> This is already supported on ARMv8a, this patch adds the ARMv7a support.
> Extend the SPL fitImage loader to record OpTee-OS load address and in case
> the load address is non-zero, use the same bootm-optee.S code used by the
> U-Boot fitImage jump code to start OpTee-OS first and jump to Linux next.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Janne Grunau <j@jannau.net>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Sam Edwards <cfsworks@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: Include armv7.h only on non-ARM64
> ---
>  arch/arm/lib/spl.c   | 10 ++++++++++
>  common/spl/spl_fit.c | 20 ++++++++++++++++++++
>  include/spl.h        |  3 +++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/arch/arm/lib/spl.c b/arch/arm/lib/spl.c
> index c43a63f1819..71e882b1f2c 100644
> --- a/arch/arm/lib/spl.c
> +++ b/arch/arm/lib/spl.c
> @@ -16,6 +16,9 @@
>  #include <asm/global_data.h>
>  #include <linux/compiler.h>
>  #include <asm/mach-types.h>
> +#if defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
> +#include <asm/armv7.h>
> +#endif
>  
>  #ifndef CONFIG_SPL_DM
>  /* Pointer to as well as the global data structure for SPL */
> @@ -72,6 +75,13 @@ void __noreturn jump_to_image_linux(struct spl_image_info *spl_image)
>  	image_entry_arg_t image_entry =
>  		(image_entry_arg_t)(uintptr_t) spl_image->entry_point;
>  	cleanup_before_linux();
> +#if defined(CONFIG_BOOTM_OPTEE) && defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
> +	if (spl_image->optee_addr)
> +		boot_jump_linux_via_optee((void *)(spl_image->entry_point),
> +					  machid,
> +					  (u32)(spl_image->arg),
> +					  spl_image->optee_addr);
> +#endif
>  	image_entry(0, machid, spl_image->arg);
>  }
>  #endif	/* CONFIG_ARM64 */
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index b3824af475f..7f4b780b6dd 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -545,6 +545,23 @@ static int spl_fit_image_is_fpga(const void *fit, int node)
>  	return !strcmp(type, "fpga");
>  }
>  
> +static void spl_fit_image_record_arm32_optee(const void *fit, int node,
> +					     struct spl_image_info *spl_image,
> +					     struct spl_image_info *image_info)
> +{
> +#if defined(CONFIG_BOOTM_OPTEE) && defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
> +	const char *type = fdt_getprop(fit, node, FIT_TYPE_PROP, NULL);
> +
> +	if (!type)
> +		return;
> +
> +	if (strcmp(type, "tee"))
> +		return;
> +
> +	spl_image->optee_addr = image_info->load_addr;
> +#endif
> +}
> +
>  static int spl_fit_image_get_os(const void *fit, int noffset, uint8_t *os)
>  {
>  	if (!CONFIG_IS_ENABLED(FIT_IMAGE_TINY) || CONFIG_IS_ENABLED(OS_BOOT))
> @@ -898,6 +915,9 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
>  		    image_info.entry_point != FDT_ERROR)
>  			spl_image->entry_point = image_info.entry_point;
>  
> +		spl_fit_image_record_arm32_optee(ctx.fit, node, spl_image,
> +						 &image_info);
> +
>  		/* Record our loadables into the FDT */
>  		if (!CONFIG_IS_ENABLED(FIT_IMAGE_TINY) &&
>  		    xpl_get_fdt_update(info) && spl_image->fdt_addr)
> diff --git a/include/spl.h b/include/spl.h
> index 7c10c7f792e..148299a5494 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -288,6 +288,9 @@ struct spl_image_info {
>  	ulong entry_point;
>  #if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
>  	void *fdt_addr;
> +#endif
> +#if defined(CONFIG_BOOTM_OPTEE) && defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
> +	ulong optee_addr;
>  #endif
>  	u32 boot_device;
>  	u32 offset;
