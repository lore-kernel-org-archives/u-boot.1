Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4AEC67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 07:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DDD28846B;
	Fri,  5 Apr 2024 09:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BAmWZW3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2C2F88471; Fri,  5 Apr 2024 09:37:14 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D6738846A
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 09:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B903D3F594
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 07:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712302631;
 bh=bN4thyh9QNBwmVXvxbaJu0KT2vQYjlSn5sS+Y2Ow9Pc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=BAmWZW3J+Ucj2Kqcg++d5o+DMInpbS+T1J8VM91ToGF9vY7HPRovhqbpEfDjocXjz
 TUk5ncYpWAiJP+5yZ/ndhtmg/d4nKJ2NYTycc8/jyo+zfo/nIBaBttPcCuAGWf8519
 WC3GXRVreSWKnXG23FPy6z53+6I+DYz0N7ebeH/NQ3gbTO+gAe9oQLMbsFqhtv+kW+
 zUEk43YaPgcUMk31F35LwP0WvER8BuzE4G2WPIq11JLrQCC35O51RGweGhhLFk2LSc
 AihU3zfsShvt82ameUnWN/yEWJWWeWn+2rUghRiLOLWLXHzO23cMllm6Y3Q9rcYRRK
 o1HAmn7R33PBg==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-414042da713so14946715e9.0
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 00:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712302631; x=1712907431;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bN4thyh9QNBwmVXvxbaJu0KT2vQYjlSn5sS+Y2Ow9Pc=;
 b=lSFgrdPAD84XYm96fYFrr8gAMYiLT+wFXYndfGf2gRRABYXJzLNP+Au77soZn/BpZi
 sSfJRZ2Dc22yUVbmjJ7GG9VvHVOkPDxxBwRXflBUG4zBywxNnHTdzhBk5J2HuHMDgNMW
 91CeW/DctagxMhIhSjxqR2iFtsuR0hhoLI18Zw/QYRfkOhdBGwF5FmQjM5hDAVndqfRM
 tUox2PxcGePvdrSroMTC/qs3nFelWJnPWg5CjpsK6nbECDK4pFnuBsX5h53EF2R/zUHO
 vSXtFnoZ4tkyEwJqYm4lSLMP2KXTNQpwLus5TCcAA/TxvXpwa8ES/0ihH0F7xELG6sjF
 eBAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQXaMoP0rWGs2CT7WGFNxJpwJuNKkbpPxzHK/EF+cz31Zl0Y9Xb5kEyl7LMAkyfDhl663ofrYjtaeNXn5QXczoCUISaA==
X-Gm-Message-State: AOJu0Yw+0uPBr0M2JqVo1GMeZgqU6Wved2k8kk/I756qtnrsMo2Di+C3
 04WOSuual4c0aY+SJdUjNQ/Ax09SoqKhxG5prKZqB5CYfFVCnLi8/j02Ix2alrRn8DA4HS5DtVH
 p+3y5AWvDQHGUovHzH9KGPi5tIGwHGQN0h69swsQTWw5VSqrLRFpXNco0IFXuzBs0zyg=
X-Received: by 2002:a05:600c:3502:b0:416:1b17:ba4 with SMTP id
 h2-20020a05600c350200b004161b170ba4mr1487313wmq.16.1712302631370; 
 Fri, 05 Apr 2024 00:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUx53/TQECGtye5zfhRwxhunKjxXWHF3KjHNkje8BAuVRbqRK5C8x8/V78GOlzDZmrzsIBmQ==
X-Received: by 2002:a05:600c:3502:b0:416:1b17:ba4 with SMTP id
 h2-20020a05600c350200b004161b170ba4mr1487289wmq.16.1712302630977; 
 Fri, 05 Apr 2024 00:37:10 -0700 (PDT)
Received: from [192.168.123.161]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b00343e01d3f6dsm1212921wrp.3.2024.04.05.00.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 00:37:10 -0700 (PDT)
Message-ID: <c32e4a59-ed4a-4f6d-ad69-bf861c21f76e@canonical.com>
Date: Fri, 5 Apr 2024 09:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi_loader: move efi_var_collect to common functions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ilias Apalodimas <apalos@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro
 <takahiro.akashi@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
References: <20240405065058.591452-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240405065058.591452-1-ilias.apalodimas@linaro.org>
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

On 4/5/24 08:50, Ilias Apalodimas wrote:
> From: Ilias Apalodimas <apalos@gmail.com>
> 
> efi_var_collect() was initially placed in efi_var_file.c, since back
> then we only supported efi variables stored in a file. Since then we
> support variables stored in an RPMB as well and use that function to
> collect variables that should be present at runtime.
> 
> So let's move it around in efi_var_common.c which makes more sense
> 
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Ilias Apalodimas <apalos@gmail.com>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
> Changes since v1:
> - Clean up the makefile as well
> - fix checkpatch error
> 
>   lib/efi_loader/Makefile         |  2 +-
>   lib/efi_loader/efi_var_common.c | 74 +++++++++++++++++++++++++++++++++
>   lib/efi_loader/efi_var_file.c   | 64 ----------------------------
>   3 files changed, 75 insertions(+), 65 deletions(-)
> 
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index fcb0af7e7d6d..6a0ce6c32c88 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -72,11 +72,11 @@ obj-y += efi_string.o
>   obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) += efi_unicode_collation.o
>   obj-y += efi_var_common.o
>   obj-y += efi_var_mem.o
> -obj-y += efi_var_file.o
>   ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
>   obj-y += efi_variable_tee.o
>   else
>   obj-y += efi_variable.o
> +obj-y += efi_var_file.o
>   obj-$(CONFIG_EFI_VARIABLES_PRESEED) += efi_var_seed.o
>   endif
>   obj-y += efi_watchdog.o
> diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
> index d528747f3fb4..4268850990f5 100644
> --- a/lib/efi_loader/efi_var_common.c
> +++ b/lib/efi_loader/efi_var_common.c
> @@ -9,6 +9,7 @@
>   #include <efi_loader.h>
>   #include <efi_variable.h>
>   #include <stdlib.h>
> +#include <u-boot/crc.h>
> 
>   enum efi_secure_mode {
>   	EFI_MODE_SETUP,
> @@ -416,3 +417,76 @@ void *efi_get_var(const u16 *name, const efi_guid_t *vendor, efi_uintn_t *size)
> 
>   	return buf;
>   }
> +
> +/**
> + * efi_var_collect() - Copy EFI variables mstching attributes mask
> + *
> + * @bufp:	buffer containing variable collection
> + * @lenp:	buffer length
> + * @attr_mask:	mask of matched attributes
> + *
> + * Return:	Status code
> + */
> +efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *lenp,
> +					    u32 check_attr_mask)
> +{
> +	size_t len = EFI_VAR_BUF_SIZE;
> +	struct efi_var_file *buf;
> +	struct efi_var_entry *var, *old_var;
> +	size_t old_var_name_length = 2;
> +
> +	*bufp = NULL; /* Avoid double free() */
> +	buf = calloc(1, len);
> +	if (!buf)
> +		return EFI_OUT_OF_RESOURCES;
> +	var = buf->var;
> +	old_var = var;
> +	for (;;) {
> +		efi_uintn_t data_length, var_name_length;
> +		u8 *data;
> +		efi_status_t ret;
> +
> +		if ((uintptr_t)buf + len <=
> +		    (uintptr_t)var->name + old_var_name_length)
> +			return EFI_BUFFER_TOO_SMALL;
> +
> +		var_name_length = (uintptr_t)buf + len - (uintptr_t)var->name;
> +		memcpy(var->name, old_var->name, old_var_name_length);
> +		guidcpy(&var->guid, &old_var->guid);
> +		ret = efi_get_next_variable_name_int(
> +				&var_name_length, var->name, &var->guid);
> +		if (ret == EFI_NOT_FOUND)
> +			break;
> +		if (ret != EFI_SUCCESS) {
> +			free(buf);
> +			return ret;
> +		}
> +		old_var_name_length = var_name_length;
> +		old_var = var;
> +
> +		data = (u8 *)var->name + old_var_name_length;
> +		data_length = (uintptr_t)buf + len - (uintptr_t)data;
> +		ret = efi_get_variable_int(var->name, &var->guid,
> +					   &var->attr, &data_length, data,
> +					   &var->time);
> +		if (ret != EFI_SUCCESS) {
> +			free(buf);
> +			return ret;
> +		}
> +		if ((var->attr & check_attr_mask) == check_attr_mask) {
> +			var->length = data_length;
> +			var = (struct efi_var_entry *)ALIGN((uintptr_t)data + data_length, 8);
> +		}
> +	}
> +
> +	buf->reserved = 0;
> +	buf->magic = EFI_VAR_FILE_MAGIC;
> +	len = (uintptr_t)var - (uintptr_t)buf;
> +	buf->crc32 = crc32(0, (u8 *)buf->var,
> +			   len - sizeof(struct efi_var_file));
> +	buf->length = len;
> +	*bufp = buf;
> +	*lenp = len;
> +
> +	return EFI_SUCCESS;
> +}
> diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
> index 532b6b40eefe..413e1794e88c 100644
> --- a/lib/efi_loader/efi_var_file.c
> +++ b/lib/efi_loader/efi_var_file.c
> @@ -52,70 +52,6 @@ static efi_status_t __maybe_unused efi_set_blk_dev_to_system_partition(void)
>   	return EFI_SUCCESS;
>   }
> 
> -efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *lenp,
> -					    u32 check_attr_mask)
> -{
> -	size_t len = EFI_VAR_BUF_SIZE;
> -	struct efi_var_file *buf;
> -	struct efi_var_entry *var, *old_var;
> -	size_t old_var_name_length = 2;
> -
> -	*bufp = NULL; /* Avoid double free() */
> -	buf = calloc(1, len);
> -	if (!buf)
> -		return EFI_OUT_OF_RESOURCES;
> -	var = buf->var;
> -	old_var = var;
> -	for (;;) {
> -		efi_uintn_t data_length, var_name_length;
> -		u8 *data;
> -		efi_status_t ret;
> -
> -		if ((uintptr_t)buf + len <=
> -		    (uintptr_t)var->name + old_var_name_length)
> -			return EFI_BUFFER_TOO_SMALL;
> -
> -		var_name_length = (uintptr_t)buf + len - (uintptr_t)var->name;
> -		memcpy(var->name, old_var->name, old_var_name_length);
> -		guidcpy(&var->guid, &old_var->guid);
> -		ret = efi_get_next_variable_name_int(
> -				&var_name_length, var->name, &var->guid);
> -		if (ret == EFI_NOT_FOUND)
> -			break;
> -		if (ret != EFI_SUCCESS) {
> -			free(buf);
> -			return ret;
> -		}
> -		old_var_name_length = var_name_length;
> -		old_var = var;
> -
> -		data = (u8 *)var->name + old_var_name_length;
> -		data_length = (uintptr_t)buf + len - (uintptr_t)data;
> -		ret = efi_get_variable_int(var->name, &var->guid,
> -					   &var->attr, &data_length, data,
> -					   &var->time);
> -		if (ret != EFI_SUCCESS) {
> -			free(buf);
> -			return ret;
> -		}
> -		if ((var->attr & check_attr_mask) == check_attr_mask) {
> -			var->length = data_length;
> -			var = (struct efi_var_entry *)ALIGN((uintptr_t)data + data_length, 8);
> -		}
> -	}
> -
> -	buf->reserved = 0;
> -	buf->magic = EFI_VAR_FILE_MAGIC;
> -	len = (uintptr_t)var - (uintptr_t)buf;
> -	buf->crc32 = crc32(0, (u8 *)buf->var,
> -			   len - sizeof(struct efi_var_file));
> -	buf->length = len;
> -	*bufp = buf;
> -	*lenp = len;
> -
> -	return EFI_SUCCESS;
> -}
> -
>   /**
>    * efi_var_to_file() - save non-volatile variables as file
>    *
> --
> 2.43.0
> 

