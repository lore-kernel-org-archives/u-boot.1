Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6ECCDD1AE
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 13:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A311589114;
	Fri, 27 Sep 2024 15:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TScTcVMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DF8F89110; Fri, 27 Sep 2024 15:51:11 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 033EF89117
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 15:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71b0722f221so1664696b3a.3
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 06:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727445067; x=1728049867; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rXlfRDVGR/En93nHO9ehbFgEumHN1V+rRE23ELYy+j4=;
 b=TScTcVMf1KeOjP9+I+fo7li2PSvkS9Q0+V1c/7oRyBsfAKIsSqXVM/pAYDY+MD0R2I
 RH9xv9n2EzoiEwsx4/rAqB4++cGGkk1x6d7GmgmgFTfcDMA842HoQyTr7AZATOD06GjS
 qP6d6i6UA61afSN4U6VK4W2/cyxIit5YvHsVlNlexQ3MFGD2uYUXnl9w3V4OWyLy5PFA
 tFWlMDZV8DeyFhvrfROH6+cqJeJinEg6FXgdOm6OXIsgO6hPjyXvbcLKdBNaO4/44XVd
 gRT+hqwVXJmR46VWnq2R9u5FyJtTo11IEGm2ThVPkPJWgf7Jk9KLL3LicHDCT0P0dE1f
 rd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727445067; x=1728049867;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rXlfRDVGR/En93nHO9ehbFgEumHN1V+rRE23ELYy+j4=;
 b=nj0NAP5t3Jw4ZHfMsAixZO/v73QxGLBYbTJG/RAGSoHnXK7cBEutOTSLpOQJ4l+Re3
 BusBPjQoJtxWzkmsASf5q/kiqbPt+gKA0Z/LzlmJX+m6FqkDMkNUe4ruxALxL/wB/Esh
 fU6rUbnZBviTWeQjuIVpMU2pPcgk2BESuOSWG7ulH5LaJrTLjVTEdaKr53GEnJMeYeoC
 GWqFN++LLJMoNiRV9ywR4DJxt0lpa5l1zBUyi0er5FK3Mwp+2zw0zoQQGGzyBL8DiZWl
 A0s24/lac1KEJYAWtReKdiq/I9u/hEV7Hao/1Pyu5Nl2YVf+mEupMPbA+bPMNGZRMLA3
 Eogg==
X-Gm-Message-State: AOJu0YwGIp5u65BNSQxtwivWI6N58dqVNT/Y/v/1G1DnZNye29i8na1A
 PWEoXsJTpDz7SndYwg9ESldtqNnxbQdIEC8/OLZMdJMTAcQKVG0mLDJLrg/ML+83qPqTH2pbm9y
 oGPBW2sJcKIkqTkqQ68oTneZaX7ZwGv/9bdYbyA==
X-Google-Smtp-Source: AGHT+IGF74qidLsVb3nNEEPsjfrS+pkrrzuXxK9BE7GqChVXgR49EECaWIX0QkFYI2FlObeq8IkwCeESb38gD43+NQw=
X-Received: by 2002:a05:6a00:929f:b0:717:8ac9:6585 with SMTP id
 d2e1a72fcca58-71b2607eb7fmr4523309b3a.26.1727445067339; Fri, 27 Sep 2024
 06:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240926220226.1265965-9-sjg@chromium.org>
 <20240926220226.1265965-10-sjg@chromium.org>
In-Reply-To: <20240926220226.1265965-10-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Sep 2024 16:50:31 +0300
Message-ID: <CAC_iWj+-Y5XCs1byoGzxqkL2PQoaEHA9UUhwU7_v5i2omPvmtQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/12] efi_loader: Add a test app
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
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

Hi Simon,

On Fri, 27 Sept 2024 at 01:04, Simon Glass <sjg@chromium.org> wrote:
>
> Add a simple app to use for testing. This is intended to do whatever it
> needs to for testing purposes. For now it just prints a message and
> exits boot services.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/Kconfig   | 10 ++++++
>  lib/efi_loader/Makefile  |  1 +
>  lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 79 insertions(+)
>  create mode 100644 lib/efi_loader/testapp.c
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 6f6fa8d629d..41083e7c137 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -564,6 +564,16 @@ config BOOTEFI_HELLO_COMPILE
>           No additional space will be required in the resulting U-Boot binary
>           when this option is enabled.
>
> +config BOOTEFI_TESTAPP_COMPILE
> +       bool "Compile an EFI test app for testing"
> +       default y
> +       help
> +         This compiles an app designed for testing. It is packed into an image
> +         by the test.py testing frame in the setup_efi_image() function.
> +
> +         No additional space will be required in the resulting U-Boot binary
> +         when this option is enabled.
> +
>  endif
>
>  source "lib/efi/Kconfig"
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 00d18966f9e..87131ab911d 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -20,6 +20,7 @@ apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) += initrddump
>  ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
>  apps-y += dtbdump
>  endif
> +apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) += testapp
>
>  obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
>  obj-$(CONFIG_EFI_BOOTMGR) += efi_bootmgr.o
> diff --git a/lib/efi_loader/testapp.c b/lib/efi_loader/testapp.c
> new file mode 100644
> index 00000000000..feb444c92e9
> --- /dev/null
> +++ b/lib/efi_loader/testapp.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hello world EFI application
> + *
> + * Copyright 2024 Google LLC
> + * Written by Simon Glass <sjg@chromium.org>
> + *
> + * This test program is used to test the invocation of an EFI application.
> + * It writes a few messages to the console and then exits boot services
> + */
> +
> +#include <efi_api.h>
> +
> +static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
> +
> +static struct efi_system_table *systable;
> +static struct efi_boot_services *boottime;
> +static struct efi_simple_text_output_protocol *con_out;
> +
> +/**
> + * efi_main() - entry point of the EFI application.
> + *
> + * @handle:    handle of the loaded image
> + * @systab:    system table
> + * Return:     status code
> + */
> +efi_status_t EFIAPI efi_main(efi_handle_t handle,
> +                            struct efi_system_table *systab)
> +{
> +       struct efi_loaded_image *loaded_image;
> +       efi_status_t ret;
> +       efi_uintn_t map_size;
> +       efi_uintn_t map_key;
> +       efi_uintn_t desc_size;
> +       u32 desc_version;
> +
> +       systable = systab;
> +       boottime = systable->boottime;
> +       con_out = systable->con_out;
> +
> +       /* Get the loaded image protocol */
> +       ret = boottime->open_protocol(handle, &loaded_image_guid,
> +                                     (void **)&loaded_image, NULL, NULL,
> +                                     EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +       if (ret != EFI_SUCCESS) {
> +               con_out->output_string
> +                       (con_out, u"Cannot open loaded image protocol\r\n");
> +               goto out;
> +       }
> +
> +       /* UEFI requires CR LF */
> +       con_out->output_string(con_out, u"U-Boot test app for EFI_LOADER\r\n");
> +
> +out:
> +       map_size = 0;
> +       ret = boottime->get_memory_map(&map_size, NULL, &map_key, &desc_size,
> +                                      &desc_version);
> +       con_out->output_string(con_out, u"Exiting boot sevices\n");
> +
> +       /* exit boot services so that this part of U-Boot can be tested */
> +       boottime->exit_boot_services(handle, map_key);

What Heinrich keeps repeating here, is that after you call EBS, boot
services must not be called again.

> +
> +       /* now exit for real */
> +       ret = boottime->exit(handle, ret, 0, NULL);

IOW this is wrong. It might happen to work because not much has run
and the memory will still be there. But you certainly should not rely
on that

Thanks

/Ilias
> +
> +       /* We should never arrive here */
> +       return ret;
> +}
> --
> 2.43.0
>
