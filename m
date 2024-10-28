Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72FAD3399B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 17:01:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55C1C89099;
	Mon, 28 Oct 2024 18:01:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NZV4Go5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD46890A9; Mon, 28 Oct 2024 18:01:05 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 270DB89098
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 18:01:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a998a5ca499so611628766b.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 10:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730134861; x=1730739661; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZWG0GWFAIwv6H0SBwI5F1QQpQlM5waYXflwNTu+VMy0=;
 b=NZV4Go5TbilaMX7fGgZut/56l09GLDqTcNbGpfZb4y5Jn5A1WyGx8WKKXPsPARupdG
 T51O5rTfudfMkpoEBsCXjWEnkdcKN+BAG7euleeS9cH0cw5j0vDuG4uydzxE8fgaEwEN
 8nlUS1xcW8k/SaN4FApTPG68F83zMDT8glXK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730134861; x=1730739661;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZWG0GWFAIwv6H0SBwI5F1QQpQlM5waYXflwNTu+VMy0=;
 b=UZxV1ExRpqpu/sEc9AoaZngjDrz0nSs+TBMrkFSh1j8JxAy9REEGEP0jh/0E7RXCTR
 vrhvXDD3j0rXht8txLqF+AQ18KP0B4Hy7P5AKR+tXqdMO2/9VjH9OS2CCtUwHaaQg+e7
 Z2Qv6P+PETH+dV8pk30ZBskPGx8geHdseeuP5z67j2z6U/yRJanLZ6zTOerrmYr50jN8
 hg6oQyP34n5KMc9p2L11MoIn44tHI0iHKANB287ZjFLKbuHXK88bmBZSbIZIXdBJcaCZ
 FHbg8FMo2irfxsWkz5cZJBAlp2ejJJKs9EC0IlkiERauveWASvA0LYntDKglJQX2maiW
 ouKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz14Bj07zb97aVbq2V96nEUZGHKCKGWjFiUC4izZyW/0h3DA2uTvvvuwEjX0Jb/vVyyg8+OTI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0CyzBWr4Q+d1YRYxp2YGnAcaS1jBldAzyAWolxYyZbR/80MYE
 IMkacWeGYdBb0t2f9wN0X+2YozjdRp8Jdjwii8sQJNb9TJGh7a9o4YN8efstLyWGmD8pwKmJGo0
 oSR9uFY5ilb/Xal03h7qs+RaI96QJ5PKZvcV0
X-Google-Smtp-Source: AGHT+IH9iXm+3Ug3hrlEF+jJ1bQYb1ByRHA+VXVku/4U8mtbdPWGM5vF6+9Owl3nrJEPnaTWIW9ihC6DI/iIcvLFZ2A=
X-Received: by 2002:a17:907:940f:b0:a7d:c148:ec85 with SMTP id
 a640c23a62f3a-a9de62f44c1mr908128266b.62.1730134861473; Mon, 28 Oct 2024
 10:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-3-sjg@chromium.org>
 <9f322139-ad6d-494d-879b-eab3211b874b@gmx.de>
In-Reply-To: <9f322139-ad6d-494d-879b-eab3211b874b@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Oct 2024 18:00:49 +0100
Message-ID: <CAFLszTgHvUo+0g+SBhC=Xbd_aFxdP_DF=wg_G3ZRTRP-k-2qVg@mail.gmail.com>
Subject: Re: [PATCH v8 2/8] efi_loader: Add a test app
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Heinrich,

On Mon, 28 Oct 2024 at 07:11, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:
>
> On 10/22/24 14:00, Simon Glass wrote:
> > Add a simple app to use for testing. This is intended to do whatever it
> > needs to for testing purposes. For now it just prints a message and
> > exits boot services.
> >
> > There was a considerable amount of discussion about whether it is OK to
> > call exit-boot-services and then return to U-Boot. This is not normally
> > done in a real application, since exit-boot-services is used to
> > completely disconnect from U-Boot. However, since this is a test, we
> > need to check the results of running the app, so returning is necessary.
> > It works correctly and it provides a nice model of how to test the EFI
> > code in a simple way.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v7)
> >
> > Changes in v7:
> > - Update commit message
> >
> >   lib/efi_loader/Kconfig   | 10 ++++++
> >   lib/efi_loader/Makefile  |  1 +
> >   lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 79 insertions(+)
> >   create mode 100644 lib/efi_loader/testapp.c
> >
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 69b2c9360d8..6ced29da719 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -565,6 +565,16 @@ config BOOTEFI_HELLO_COMPILE
> >         No additional space will be required in the resulting U-Boot
binary
> >         when this option is enabled.
> >
> > +config BOOTEFI_TESTAPP_COMPILE
> > +     bool "Compile an EFI test app for testing"
> > +     default y
> > +     help
> > +       This compiles an app designed for testing. It is packed into an
image
> > +       by the test.py testing frame in the setup_efi_image() function.
> > +
> > +       No additional space will be required in the resulting U-Boot
binary
> > +       when this option is enabled.
> > +
> >   endif
> >
> >   source "lib/efi/Kconfig"
> > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> > index 00d18966f9e..87131ab911d 100644
> > --- a/lib/efi_loader/Makefile
> > +++ b/lib/efi_loader/Makefile
> > @@ -20,6 +20,7 @@ apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) += initrddump
> >   ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
> >   apps-y += dtbdump
> >   endif
> > +apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) += testapp
> >
> >   obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
> >   obj-$(CONFIG_EFI_BOOTMGR) += efi_bootmgr.o
> > diff --git a/lib/efi_loader/testapp.c b/lib/efi_loader/testapp.c
> > new file mode 100644
> > index 00000000000..feb444c92e9
> > --- /dev/null
> > +++ b/lib/efi_loader/testapp.c
> > @@ -0,0 +1,68 @@
> > +// SPDX-License-Identifier: GPL-2.0+
>
> This is not a valid SPDX identifier. Please, use GPL-2.0-or-later.
>
> > +/*
> > + * Hello world EFI application
> > + *
> > + * Copyright 2024 Google LLC
> > + * Written by Simon Glass <sjg@chromium.org>
> > + *
> > + * This test program is used to test the invocation of an EFI
application.
> > + * It writes a few messages to the console and then exits boot services
> > + */
> > +
> > +#include <efi_api.h>
> > +
> > +static const efi_guid_t loaded_image_guid =
EFI_LOADED_IMAGE_PROTOCOL_GUID;
> > +
> > +static struct efi_system_table *systable;
> > +static struct efi_boot_services *boottime;
> > +static struct efi_simple_text_output_protocol *con_out;
> > +
> > +/**
> > + * efi_main() - entry point of the EFI application.
> > + *
> > + * @handle:  handle of the loaded image
> > + * @systab:  system table
> > + * Return:   status code
> > + */
> > +efi_status_t EFIAPI efi_main(efi_handle_t handle,
> > +                          struct efi_system_table *systab)
> > +{
> > +     struct efi_loaded_image *loaded_image;
> > +     efi_status_t ret;
> > +     efi_uintn_t map_size;
> > +     efi_uintn_t map_key;
> > +     efi_uintn_t desc_size;
> > +     u32 desc_version;
> > +
> > +     systable = systab;
> > +     boottime = systable->boottime;
> > +     con_out = systable->con_out;
> > +
> > +     /* Get the loaded image protocol */
> > +     ret = boottime->open_protocol(handle, &loaded_image_guid,
> > +                                   (void **)&loaded_image, NULL, NULL,
> > +                                   EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> > +     if (ret != EFI_SUCCESS) {
> > +             con_out->output_string
> > +                     (con_out, u"Cannot open loaded image
protocol\r\n");
> > +             goto out;
> > +     }
> > +
> > +     /* UEFI requires CR LF */
> > +     con_out->output_string(con_out, u"U-Boot test app for
EFI_LOADER\r\n");
> > +
> > +out:
> > +     map_size = 0;
> > +     ret = boottime->get_memory_map(&map_size, NULL, &map_key,
&desc_size,
> > +                                    &desc_version);
> > +     con_out->output_string(con_out, u"Exiting boot sevices\n");
>
> %s/sevices/services/g
>
> > +
> > +     /* exit boot services so that this part of U-Boot can be tested */
> > +     boottime->exit_boot_services(handle, map_key);
> > +
> > +     /* now exit for real */
> > +     ret = boottime->exit(handle, ret, 0, NULL);
>
> As written before boot services are not available after
> ExitBootServices(). Please, call the ResetSystem() service.

I already explained this. If I call reset then U-Boot exits and the console
output cannot be checked by the C test. If I tell sandbox's reset-driver to
ignore the reset request, then it also doesn't come back to the test.

>
>
> > +
> > +     /* We should never arrive here */
> > +     return ret;
>
> After ExitBootServices() you must not return.
>
> You can just do an endless loop if ResetSystem() fails:
>
> for (;;);

No, because I need to check the output of the app. Please can you try to
run this test so you can see what it is doing?

Regards,
Simon
