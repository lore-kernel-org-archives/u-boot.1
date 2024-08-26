Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9A9C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 11:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4796E88770;
	Mon, 26 Aug 2024 13:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PJHU659G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56C1A8891B; Mon, 26 Aug 2024 13:17:12 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A8B888297
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 13:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7163489149eso2497030a12.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 04:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724671028; x=1725275828; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lFEf7xg/uMupMtz4vnqKACO/QZAivXR8VuxKJvlRYhw=;
 b=PJHU659Gqg39z6Ar4zsZE83pUbObnYAGTqRMXROWluWka8ssZUYSUBDuPXiZzHGKeR
 hZDFaMXP2YxbAZm84Tu6BzEva6qpeRbkp0NDG6ZGoZObu+KafsYX6ePE0LeTnuN0/REX
 9jVCZbuhl1HXRWdo6nwdjScCAzYi2e51SFV+Vk+QqDJsOMEPt/Brp7ql2/1FopzSTCmE
 xs1rQ4d+yY6zFRL/R/8E8nV2ULD8pXQ12hXga3SSb/RT14TwxNweu3Nj5uV3CfrfMN96
 pH2rUUqptD/ct+kiIy8UPR1CpPxGNvSJT91HvXc9Wi4VQaZGKkn0eZGcok3wuTx2ABY+
 G6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724671028; x=1725275828;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lFEf7xg/uMupMtz4vnqKACO/QZAivXR8VuxKJvlRYhw=;
 b=IHTgrWOjksPvaimXBrFqee9n0MpVQRZT53M5Ta+jRpyKNCSOihjyssU2dyy5HIBjJD
 OoLLhfYNBwcUGzXxiW7/wtRM3wbbOgGazKfH0c/wjOCDyC57+soyDrsP2uMqKl+ZLfV6
 6lf003mbeQjAPvop4Rg3abDQPySBKhwgszQ1A+3EuDjJa255R02D98cwTqTFNz8q3QH8
 qTd+5MvmF9mZZ/mNXFpfVL+t9tIkScJVsTfXrFUJHsRWhC5TK7CzyAyi8Sjog01d3yg6
 8OcWdPSGtKPaqFa58YEvI3mcVkhGxomYD5RDrTPwUblbvLukvLWh8q9VBZAzXZLWImpU
 8ezA==
X-Gm-Message-State: AOJu0YzMR/WZO1nk+p931HCjrhRzsDVbIIGCbvk0taKop4YAH97KDudX
 8alfv9IO1dsvUrOUPQBymcJBxN9ieDi2Sqy7QqSY/kNTikAEoq1prhDXAyNQg5vH7JvD/5HCLxf
 MRsMggqsH2Iisp2RNatjlk/2PLQMortLKrYkKmQ==
X-Google-Smtp-Source: AGHT+IGsCZWb8EG5gl3rydiooNt+jU976kNY/nAPGSbkMEl0nj0P5I8dSIVQq31VYS9mMirNw3CyG9NfShAhL/r6uz0=
X-Received: by 2002:a05:6a20:d49a:b0:1cc:9f24:42 with SMTP id
 adf61e73a8af0-1cc9f2400f3mr7662967637.20.1724671028302; Mon, 26 Aug 2024
 04:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240815202424.766778-1-sjg@chromium.org>
 <20240815202424.766778-12-sjg@chromium.org>
In-Reply-To: <20240815202424.766778-12-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 14:16:31 +0300
Message-ID: <CAC_iWjL4kkSzX6YEv63gBJk9ruwBCRP+_NFATtBPgk7u3Xa=Yg@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] efi_loader: Add a test app
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

On Thu, 15 Aug 2024 at 23:24, Simon Glass <sjg@chromium.org> wrote:
>
> Add a simple app to use for testing. This is intended to do whatever it
> needs to for testing purposes. For now it just prints a message and
> exits boot services.

We have tests in py and efi selftests, can you explain why you need
another EFI app?
I'd rather skip this and add it when needed

Thanks
/Ilias
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
> index ab2c1c44364..4de05c6f2d6 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -528,4 +528,14 @@ config BOOTEFI_HELLO_COMPILE
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
> +
> +       /* now exit for real */
> +       ret = boottime->exit(handle, ret, 0, NULL);
> +
> +       /* We should never arrive here */
> +       return ret;
> +}
> --
> 2.34.1
>
