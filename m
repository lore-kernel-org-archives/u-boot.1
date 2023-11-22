Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CC7C61D92
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 06:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5237A875A1;
	Wed, 22 Nov 2023 07:58:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RH//YRGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D00E875A1; Wed, 22 Nov 2023 07:58:31 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 676FB86F38
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 07:58:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c503da4fd6so80690301fa.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 22:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700636307; x=1701241107; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hs5ZtNnmzwyU2AykP/KPwTjBeB5Ur8dYIQb7PbjsZBc=;
 b=RH//YRGTXCLeXQ2EpN9qGIZtfb4DvNdDJkRO4eOXBkm5EOB7GFsMa+chQxBYZRNMQp
 03XhDReVE8vyJXCLdeixJsjKj4aJ+2bPrRQYKHHKoaMAXOlLDX/tXwjVAPtqAmYXeghL
 yz7UyOkza+rhapOD77LpS54wS3XQ8xMiujmvNe53/vSwcW2J6WcyHC7CSvYZSok+8yHv
 eueeOKz1yccGUkREf1ZuD6eSuhM0TNjI4pywcIMkJWInH2XycPlWjBR6XuvuyRoHSvot
 JLidXerjUm1M3qp3GVvMRGWWiO3oJCCAEDdvNFeSKHpA6Giz0zU1EqwZcRz2BAjilmba
 e8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700636307; x=1701241107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hs5ZtNnmzwyU2AykP/KPwTjBeB5Ur8dYIQb7PbjsZBc=;
 b=YJChLzF+U1qHc+lKpx1yQYIsoI3+lhBpoQR0NVok/3yK688sG3sIZ6QtyIvhJRKXbG
 3o2q/v6EEK6oKbJc8ld+6Le07i5Pzl9A74WtueX7mKBG8ojSC44+Xl66X4vJdDx1ilAm
 /iym1BfhJiRcqSYJp3U0MD7Zhqm2Tn/HdwumB40UWHITwqm0NTSQU/ip9d9wpUlb+yqQ
 TLMbuCAmvIheZSLxS6EnPwIuabj0N6cIky2aSkGhk4gOMgjH3P7Jt9Lhj4DrwrFYgPty
 3lkqQQTnwUoNc+0wBeLgTDqj5noHvySomfeZvACVto9z2xr5qbtOvJBeS5idqjfVrFH/
 Ixcg==
X-Gm-Message-State: AOJu0YxQ3iKM600akB/eR6BlDy7UTn3dk+q9RSSOKi0SayMTnuz2+TEk
 GWvUREGV1UktZf5RgzjH5hoOcKisCzveyERticPyrudDkvvxuJPYSkc=
X-Google-Smtp-Source: AGHT+IFtMsjqoc959EUJe4beuH71x52kXlJwpNJ6AhostC53nGS8YfwzZdaREMHVLnnzl5rv7p2PICb9YExMcgn7HlM=
X-Received: by 2002:a05:651c:157:b0:2c5:14d1:a303 with SMTP id
 c23-20020a05651c015700b002c514d1a303mr774275ljd.25.1700636306599; Tue, 21 Nov
 2023 22:58:26 -0800 (PST)
MIME-Version: 1.0
References: <20231121235713.1530289-1-i@shantur.com>
 <20231121235713.1530289-3-i@shantur.com>
In-Reply-To: <20231121235713.1530289-3-i@shantur.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 22 Nov 2023 08:57:50 +0200
Message-ID: <CAC_iWjKxyRWd+bf==mO0tLQEG843J631xNQRo0_ueGXpdNCokg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] efi_vars: Implement SPI Flash store
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Shahtur

On Wed, 22 Nov 2023 at 01:58, Shantur Rathore <i@shantur.com> wrote:
>
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
> +
> +/**
> + * efi_var_from_sf() - read variables from SPI Flash
> + *
> + * EFI variable buffer is read from SPI Flash at offset defined with
> + * CONFIG_EFI_VARIABLE_SF_OFFSET of length CONFIG_EFI_VAR_BUF_SIZE
> + *
> + *
> + * Return:     status code
> + */
> +efi_status_t efi_var_from_sf(void);
> +
> +/**
> + * efi_var_to_sf() - save non-volatile variables to SPI Flash
> + *
> + * EFI variable buffer is saved to SPI Flash at offset defined with
> + * CONFIG_EFI_VARIABLE_SF_OFFSET of length CONFIG_EFI_VAR_BUF_SIZE.
> + *
> + * Return:     status code
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
>           Select this option if you want non-volatile UEFI variables to be
>           stored as file /ubootefi.var on the EFI system partition.
>
> +config EFI_VARIABLE_SF_STORE
> +       bool "Store non-volatile UEFI variables in SPI Flash"
> +       depends on SPI_FLASH
> +       help
> +         Select this option if you want non-volatile UEFI variables to be
> +         stored in SPI Flash.
> +         Define CONFIG_EFI_VARIABLE_SF_OFFSET as offset in SPI Flash to use as
> +         the storage for variables. CONFIG_EFI_VAR_BUF_SIZE defines the space
> +         needed.
> +
> +
>  config EFI_MM_COMM_TEE
>         bool "UEFI variables storage service via the trusted world"
>         depends on OPTEE
> @@ -108,6 +119,13 @@ config EFI_VARIABLE_NO_STORE
>
>  endchoice
>
> +config EFI_VARIABLE_SF_OFFSET
> +       hex "EFI variables in SPI flash offset"
> +       depends on EFI_VARIABLE_SF_STORE
> +       default 0x7D0000
> +       help
> +         Offset from the start of the SPI Flash where EFI variables will be stored.
> +
>  config EFI_VARIABLES_PRESEED
>         bool "Initial values for UEFI variables"
>         depends on !EFI_MM_COMM_TEE
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
> + *
> + * Copyright (c) 2023, Shantur Rtahore

Name is misspelled

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
> +       efi_status_t ret;
> +       struct efi_var_file *buf;
> +       loff_t len;
> +       struct udevice *sfdev;
> +
> +       ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
> +       if (len > EFI_VAR_BUF_SIZE) {
> +               log_err("EFI var buffer length more than target SF size");
> +               ret = EFI_BAD_BUFFER_SIZE;

The UEFI spec doesn't define this return code for SetVariable.
Instead, EFI_OUT_OF_RESOURCES is used when the available storage isn't
enough to hold the variable and its data.

> +               goto error;
> +       }
> +
> +       debug("%s - Got buffer to write buf->len : %d\n", __func__, buf->length);
> +
> +       if (ret != EFI_SUCCESS)
> +               goto error;
> +
> +       ret = uclass_get_device(UCLASS_SPI_FLASH, 0, &sfdev);

This is a bit weird. Do we always want to use the first available SPI
on the system to store the variables?
I don't remember if the driver model has a mechanism to define one of
the SPI flashes, but if it doesn't perhaps we should use a Kconfig for
it?

> +       if (ret)
> +               goto error;
> +
> +       ret = spi_flash_erase_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, EFI_VAR_BUF_SIZE);
> +       debug("%s - Erased SPI Flash offset %lx\n", __func__, CONFIG_EFI_VARIABLE_SF_OFFSET);
> +       if (ret)
> +               goto error;
> +
> +       ret = spi_flash_write_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET, len, buf);
> +       debug("%s - Wrote buffer to SPI Flash : %ld\n", __func__, ret);
> +
> +       if (ret)
> +               goto error;
> +
> +       ret = EFI_SUCCESS;
> +error:
> +       if (ret)
> +               log_err("Failed to persist EFI variables in SF\n");
> +       free(buf);
> +       return ret;
> +}
> +
> +efi_status_t efi_var_from_sf(void)
> +{
> +       struct efi_var_file *buf;
> +       efi_status_t ret;
> +       struct udevice *sfdev;
> +
> +       buf = calloc(1, EFI_VAR_BUF_SIZE);
> +       if (!buf) {
> +               log_err("Out of memory\n");
> +               return EFI_OUT_OF_RESOURCES;
> +       }

You don't want normal memory for the variables.  Instead, you want EFI
memory which is marked for EFI runtime services data. U-Boot already
has code to support Get/GetNextvariableRT, you just need to use
efi_var_mem_init().
If you need hints have a look at lib/efi_loader/efi_variable_tee.c
which implements variables stored in an RPMB, but still uses the
memory backend for runtime services.

> +
> +       ret = uclass_get_device(UCLASS_SPI_FLASH, 0, &sfdev);
> +       if (ret)
> +               goto error;
> +
> +       ret = spi_flash_read_dm(sfdev, CONFIG_EFI_VARIABLE_SF_OFFSET,
> +               EFI_VAR_BUF_SIZE, buf);
> +
> +       debug("%s - read buffer buf->length: %x\n", __func__, buf->length);
> +
> +       if (ret || buf->length < sizeof(struct efi_var_file)) {
> +               log_err("Failed to load EFI variables\n");
> +               goto error;
> +       }
> +
> +       ret = efi_var_restore(buf, false);
> +       if (ret != EFI_SUCCESS)
> +               log_err("Invalid EFI variables file\n");
> +
> +       ret = EFI_SUCCESS;
> +error:
> +       free(buf);
> +       return ret;
> +}
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index 7fa444451d..0f85962f05 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -360,6 +360,8 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>         if (attributes & EFI_VARIABLE_NON_VOLATILE) {
>  #ifdef CONFIG_EFI_VARIABLE_FILE_STORE
>                 efi_var_to_file();
> +#elif CONFIG_EFI_VARIABLE_SF_STORE
> +               efi_var_to_sf();
>  #endif
>         }
>
> @@ -471,6 +473,8 @@ efi_status_t efi_init_variables(void)
>
>  #ifdef CONFIG_EFI_VARIABLE_FILE_STORE
>         ret = efi_var_from_file();
> +#elif CONFIG_EFI_VARIABLE_SF_STORE
> +       ret = efi_var_from_sf();
>  #else
>         ret = EFI_SUCCESS;
>  #endif
> --
> 2.40.1
>

Thanks
/Ilias
