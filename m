Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A25EC61D92
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 02:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D873C87563;
	Wed, 22 Nov 2023 03:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q59pxnCo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B0C87251; Wed, 22 Nov 2023 03:38:53 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 580DE875A1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 03:38:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b83d207806so73419b6e.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700620730; x=1701225530; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IkePAaR1YdsIC7sU46TTEX/E6zRmE2gIF1VHhFQIZkU=;
 b=q59pxnCoobrUJy9fa/mhxh4QFoAfrHAH/zhWfxXS5pMYAu4ntavcCWTbxaTJQPAQjN
 oqAJvSHldU8fGPxEE4llLq7nPXxRjZrwKGyOn6emolhmoZN1kzL+gxGRcZGW+ZkXpJ7y
 /ZE4vx0eyxIzlC/iu3sWQ1vsLPstJTB+zsjS3XzRjZH9O6QE9EtFWxh5EC1KctH/C4TB
 P+SzMmsibN3WiFGXuDZI+D1FnsDk2TOo/hWVq3MzYxPdIF9ySAd5EPb3vlQS2zwIApjO
 wCmtSjGKYDwrm84tqvw8aPNNwT1SVFPw2hg2syxR0mxUGei1NUWSvBKMKdbOvaFrqRFu
 j4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700620730; x=1701225530;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IkePAaR1YdsIC7sU46TTEX/E6zRmE2gIF1VHhFQIZkU=;
 b=nyfJL+l2yaRqEvStXBIJFjMKUSYkEhPiozfR9JWdZm4LqczGlbe/Au4q2Kfl6h5pDS
 mPANB1JuT5KIelTNIqC4CzuOgvAshw0bjIfp1fgflszEdVI3XGL6Yc1yxfA4LljW6WcA
 Ci8tiphF4qdG+ZHT1xAFc8jPcs0QZhtRMZ0+8GLAh+A5So/Mkrce9F6FlopyhKpiVyug
 xJJMd97U3vjikWvZtpjbl5+URwrmBHcMWj0X46LW3kkHDm6+KzinMUkqZO5Kc3IC/hQO
 XHF2mVlFiU0rX3peijc+QwH/ruDjevQZEY+A8q7Lp4Qf1jQv10tQ/oyo5rCiXUbFICU0
 c4pQ==
X-Gm-Message-State: AOJu0YzoFJ+7I8nabwXDKKTDUh2avmrMBxWd8H+E+RA9YHHzPMfyoFid
 k9eeznQf7JLn1ghv9zYPP97j6g==
X-Google-Smtp-Source: AGHT+IHy1+rIRyHpe60jjdJtXbRcS//GSwgIVQJ1qrPXSmlHrATuKtulNvgPRMmRlMujBF0H48ITYQ==
X-Received: by 2002:a05:6870:6e0a:b0:1f9:790e:2a72 with SMTP id
 qt10-20020a0568706e0a00b001f9790e2a72mr1201978oab.1.1700620729766; 
 Tue, 21 Nov 2023 18:38:49 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:9d12:61d5:f68:d6f0])
 by smtp.gmail.com with ESMTPSA id
 x10-20020aa793aa000000b006cb88e7c005sm5024285pff.203.2023.11.21.18.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 18:38:49 -0800 (PST)
Date: Wed, 22 Nov 2023 11:38:46 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v1 2/3] efi_vars: Implement SPI Flash store
Message-ID: <ZV1ptmAHHLDDOqjt@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20231121235713.1530289-1-i@shantur.com>
 <20231121235713.1530289-3-i@shantur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121235713.1530289-3-i@shantur.com>
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

On Tue, Nov 21, 2023 at 11:57:12PM +0000, Shantur Rathore wrote:
> Currently U-boot uses ESP as storage for EFI variables.
> Devices with SPI Flash are used for storing environment with this
> commit we allow EFI variables to be stored on SPI Flash.
> 
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
> 
>  include/efi_variable.h        | 25 ++++++++++
>  lib/efi_loader/Kconfig        | 18 +++++++
>  lib/efi_loader/Makefile       |  1 +
>  lib/efi_loader/efi_var_sf.c   | 91 +++++++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_variable.c |  4 ++
>  5 files changed, 139 insertions(+)
>  create mode 100644 lib/efi_loader/efi_var_sf.c
> 
> diff --git a/include/efi_variable.h b/include/efi_variable.h
> index ca7e19d514..766dd109f5 100644
> --- a/include/efi_variable.h
> +++ b/include/efi_variable.h
> @@ -188,6 +188,31 @@ efi_status_t efi_var_from_file(void);
>  
>  #endif // CONFIG_EFI_VARIABLE_FILE_STORE
>  
> +#ifdef CONFIG_EFI_VARIABLE_SF_STORE

Not needed as I said.

> +
> +/**
> + * efi_var_from_sf() - read variables from SPI Flash
> + *
> + * EFI variable buffer is read from SPI Flash at offset defined with
> + * CONFIG_EFI_VARIABLE_SF_OFFSET of length CONFIG_EFI_VAR_BUF_SIZE
> + *
> + *
> + * Return:	status code
> + */
> +efi_status_t efi_var_from_sf(void);
> +
> +/**
> + * efi_var_to_sf() - save non-volatile variables to SPI Flash
> + *
> + * EFI variable buffer is saved to SPI Flash at offset defined with
> + * CONFIG_EFI_VARIABLE_SF_OFFSET of length CONFIG_EFI_VAR_BUF_SIZE.
> + *
> + * Return:	status code
> + */
> +efi_status_t efi_var_to_sf(void);
> +
> +#endif // CONFIG_EFI_VARIABLE_SF_STORE
> +
>  /**
>   * efi_var_mem_init() - set-up variable list
>   *
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 4ccd26f94a..1fcc6fabb4 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -54,6 +54,17 @@ config EFI_VARIABLE_FILE_STORE
>  	  Select this option if you want non-volatile UEFI variables to be
>  	  stored as file /ubootefi.var on the EFI system partition.
>  
> +config EFI_VARIABLE_SF_STORE
> +	bool "Store non-volatile UEFI variables in SPI Flash"
> +	depends on SPI_FLASH
> +	help
> +	  Select this option if you want non-volatile UEFI variables to be
> +	  stored in SPI Flash.
> +	  Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to use as
> +	  the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines the space
> +	  needed.
> +
> +
>  config EFI_MM_COMM_TEE
>  	bool "UEFI variables storage service via the trusted world"
>  	depends on OPTEE
> @@ -108,6 +119,13 @@ config EFI_VARIABLE_NO_STORE
>  
>  endchoice
>  
> +config EFI_VARIABLE_SF_OFFSET
> +	hex "EFI variables in SPI flash offset"
> +	depends on EFI_VARIABLE_SF_STORE
> +	default 0x7D0000

The default value is definitely board-specific.
Please add "if TARGET_ROCKPRO64_RK3399(?)".

> +	help
> +	  Offset from the start of the SPI Flash where EFI variables will be stored.
> +
>  config EFI_VARIABLES_PRESEED
>  	bool "Initial values for UEFI variables"
>  	depends on !EFI_MM_COMM_TEE
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 8d31fc61c6..b9b715b1ff 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) += efi_unicode_collation.o
>  obj-y += efi_var_common.o
>  obj-y += efi_var_mem.o
>  obj-y += efi_var_file.o
> +obj-$(CONFIG_EFI_VARIABLE_SF_STORE) += efi_var_sf.o
>  ifeq ($(CONFIG_EFI_MM_COMM_TEE),y)
>  obj-y += efi_variable_tee.o
>  else
> diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
> new file mode 100644
> index 0000000000..e604a2225c
> --- /dev/null
> +++ b/lib/efi_loader/efi_var_sf.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * File interface for UEFI variables

For Spi Flash?

> + *
> + * Copyright (c) 2023, Shantur Rtahore
> + */
> +
> +#define LOG_CATEGORY LOGC_EFI
> +
> +#include <efi_loader.h>
> +#include <efi_variable.h>
> +#include <spi_flash.h>
> +#include <dm.h>
> +
> +efi_status_t efi_var_to_sf(void)
> +{
> +	efi_status_t ret;
> +	struct efi_var_file *buf;
> +	loff_t len;
> +	struct udevice *sfdev;
> +
> +	ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
> +	if (len > EFI_VAR_BUF_SIZE) {
> +		log_err("EFI var buffer length more than target SF size");
> +		ret = EFI_BAD_BUFFER_SIZE;
> +		goto error;
> +	}
> +
> +	debug("%s - Got buffer to write buf->len : %d\n", __func__, buf->length);

log_debug()?

> +
> +	if (ret != EFI_SUCCESS)
> +		goto error;
> +
> +	ret = uclass_get_device(UCLASS_SPI_FLASH, 0, &sfdev);
> +	if (ret)
> +		goto error;
> +
> +	ret = spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, EFI_VAR_BUF_SIZE);
> +	debug("%s - Erased SPI Flash offset %lx\n", __func__, CONFIG_EFI_VARIABLE_SF_OFFSET);
> +	if (ret)
> +		goto error;
> +
> +	ret = spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, len, buf);
> +	debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__, ret);
> +
> +	if (ret)
> +		goto error;
> +
> +	ret = EFI_SUCCESS;
> +error:
> +	if (ret)
> +		log_err("Failed to persist EFI variables in SF\n");
> +	free(buf);
> +	return ret;
> +}
> +
> +efi_status_t efi_var_from_sf(void)
> +{
> +	struct efi_var_file *buf;
> +	efi_status_t ret;
> +	struct udevice *sfdev;
> +
> +	buf = calloc(1, EFI_VAR_BUF_SIZE);
> +	if (!buf) {
> +		log_err("Out of memory\n");

I hope that we see a more specific diag message here.

> +		return EFI_OUT_OF_RESOURCES;
> +	}
> +
> +	ret = uclass_get_device(UCLASS_SPI_FLASH, 0, &sfdev);
> +	if (ret)
> +		goto error;
> +
> +	ret = spi_flash_read_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
> +		EFI_VAR_BUF_SIZE, buf);
> +
> +	debug("%s - read buffer buf->length: %x\n", __func__, buf->length);
> +
> +	if (ret || buf->length < sizeof(struct efi_var_file)) {
> +		log_err("Failed to load EFI variables\n");

I hope that we see a more specific diag message here.

> +		goto error;
> +	}
> +
> +	ret = efi_var_restore(buf, false);
> +	if (ret != EFI_SUCCESS)
> +		log_err("Invalid EFI variables file\n");
> +
> +	ret = EFI_SUCCESS;
> +error:
> +	free(buf);
> +	return ret;
> +}
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index 7fa444451d..0f85962f05 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -360,6 +360,8 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>  	if (attributes & EFI_VARIABLE_NON_VOLATILE) {
>  #ifdef CONFIG_EFI_VARIABLE_FILE_STORE
>  		efi_var_to_file();
> +#elif CONFIG_EFI_VARIABLE_SF_STORE
> +		efi_var_to_sf();

if (CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE))
    efi_var_to_sf();

-Takahiro Akashi

>  #endif
>  	}
>  
> @@ -471,6 +473,8 @@ efi_status_t efi_init_variables(void)
>  
>  #ifdef CONFIG_EFI_VARIABLE_FILE_STORE
>  	ret = efi_var_from_file();
> +#elif CONFIG_EFI_VARIABLE_SF_STORE
> +	ret = efi_var_from_sf();
>  #else
>  	ret = EFI_SUCCESS;
>  #endif
> -- 
> 2.40.1
> 
