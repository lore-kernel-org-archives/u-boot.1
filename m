Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D421DD0C5F8
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 09:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE7BD88F47;
	Fri, 25 Oct 2024 11:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CanrcNFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7FB788F47; Fri, 25 Oct 2024 11:49:46 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 638B188DB7
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 11:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7ea8de14848so1020619a12.2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 02:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729849775; x=1730454575; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VMnM2uHbdRzRZdjjqvzWkEdn+H13APIMWwFwuY+coPM=;
 b=CanrcNFRDC1WThMMCXY7+e4aB+wHc4aeRxFAuXTjgYspWwJhLBUPyixeNBeX/3aYw4
 wdzJyhWgfV1E14a8v/NJag8uwPpIloRJGKDKqE4pRq1k4m+aRcgbokAyHJX8vXHoFy+7
 ZdNvEEdNd8OxzxDlWsxQJdRp4zzNZ1T+vzAb9EHLz0v33n0xlDfExqxYalexBFREnZnP
 KKGk1nPCRaKIGgraLHygCLtJuUbdzxHbxu50cBqFiVJmdjWCzRAiWyTjLdm94AjwSG+O
 tj1mtuAvCtLxKrDYyHWnRLT3kqbBIG2YicEF3r1FAhK5brnKkZEVOAPS7wrFtvDs3fd1
 6iUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729849775; x=1730454575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VMnM2uHbdRzRZdjjqvzWkEdn+H13APIMWwFwuY+coPM=;
 b=JVuAk7tiViAqU3dCpZ0KWtR0UU+aypLJfpj4DvayK14n4kYIVpq/2+gJ1MfUxod1d6
 OZdvefbPPJepQhYCGw1KbkPgjwgOVnap3D1s9kpsUcO7p43DIP26QU+pU/ze0SG0Vy0N
 4EwHMd9LedEj7iwWhE6LJyxt4Pk2zZddh4KeTre9OxC0OZRb+bBXOnF6E/rMFhtwuvVu
 VP0Qq5wEw6G7lIPL4XSSBv/xrfA5yV+n73/7DT2XEi+EhV4MwCDORu91UecgZmToNSGt
 P5RMIlxHBc3QPxUPltwtHUm9qJBFGhT6PFGlq2HEGKwz4Zm1lr0lVRclvWDqeAAIW2zv
 QV9g==
X-Gm-Message-State: AOJu0YysU7W9hhk5KlTdlibTRthOXWYwNJLxp3+9VMiPAWIBdTKNt9de
 6K1DAnIBIJhRdA/7mspMMbRPHaaUaNwEf1xIrpm93D4bBA+FJ6czwdyjt4p2SGW40RfimWvv9Sv
 /UvNhi6ozkptMF2aElF23EyANaIpEI2caizCgjQ==
X-Google-Smtp-Source: AGHT+IHZMgK9VXgv/sPP1uAfaPMEMpJPtdazaNZMBJXSwnIb69X9onf9wQW7i9MN78yNktPOjXk0lk6GyeSP5Zmqdjo=
X-Received: by 2002:a05:6a20:9f43:b0:1d9:275b:4ee1 with SMTP id
 adf61e73a8af0-1d978b3db08mr11344252637.24.1729849774744; Fri, 25 Oct 2024
 02:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-3-sjg@chromium.org>
In-Reply-To: <20241022120032.196311-3-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 25 Oct 2024 12:48:58 +0300
Message-ID: <CAC_iWjJYqrh6MS50d6MxdStJFGg2pWnf1PHwQ9muYDPmOBP7Lg@mail.gmail.com>
Subject: Re: [PATCH v8 2/8] efi_loader: Add a test app
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>
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

On Tue, 22 Oct 2024 at 15:00, Simon Glass <sjg@chromium.org> wrote:
>
> Add a simple app to use for testing. This is intended to do whatever it
> needs to for testing purposes. For now it just prints a message and
> exits boot services.
>
> There was a considerable amount of discussion about whether it is OK to
> call exit-boot-services and then return to U-Boot. This is not normally
> done in a real application, since exit-boot-services is used to
> completely disconnect from U-Boot. However, since this is a test, we
> need to check the results of running the app, so returning is necessary.
> It works correctly and it provides a nice model of how to test the EFI
> code in a simple way.

Yes, I haven't had time to look at that whole discussion, but since
this is a test app I don't care too much if it violates the EFI spec
or not.

OTOH we have lib/efi_selftest/efi_selftest_exitbootservices.c to test
EBS. So why can't you just remove that call, exit normally and check
the results you want?

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v7)
>
> Changes in v7:
> - Update commit message
>
>  lib/efi_loader/Kconfig   | 10 ++++++
>  lib/efi_loader/Makefile  |  1 +
>  lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 79 insertions(+)
>  create mode 100644 lib/efi_loader/testapp.c
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 69b2c9360d8..6ced29da719 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -565,6 +565,16 @@ config BOOTEFI_HELLO_COMPILE
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

Please add a comment and a print that U-Boot needs to reboot from that
point onwards to continue testing

Thanks
/Ilias
> +       boottime->exit_boot_services(handle, map_key);
> +
> +       /* now exit for real */
> +       ret = boottime->exit(handle, ret, 0, NULL);
> +
> +       /* We should never arrive here */
> +       return ret;
> +}
> --
> 2.43.0
>
