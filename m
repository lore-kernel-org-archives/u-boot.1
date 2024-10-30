Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A478D6B6B7
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 17:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C220189221;
	Wed, 30 Oct 2024 18:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hm8a/RD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 033CD89242; Wed, 30 Oct 2024 18:55:07 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A2FB88F47
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 18:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7205b6f51f3so76835b3a.1
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730310903; x=1730915703; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yLcC2sBUU5z3YanGRDUOV8qP7LxJIDc22NKOL70J2kE=;
 b=hm8a/RD6EhGYJx30UD2ZVhJ10LMDjz1gnyyRad6IfZlDMR787O/2mfFHD5AJN36y/S
 GkKfrsq2itarV7mgHT5NZiI3g5Rm5PF2ckX1/hNhzG7n5kMM7GwJqQguqq2tOQRUb6tn
 4gx0WC9Ym6f2F1fe6mKoTD7TwSTYAItrovLvf+wqGJ9FXoVsRLIQUdk8wQVbP9WsCg9W
 dDg5DBl2LcBefQ4Fz25S6dUyREoaALx9LAd5xL7+CouxKqdUVb8ACnb4nWo0GdyRck4i
 cYpqS1NnT3hf3jglTrZoGbxFWgxYCq7W0MKaxUCUU9dknxx6wPBCjUATLIBvzB6+xhYd
 xvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730310903; x=1730915703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yLcC2sBUU5z3YanGRDUOV8qP7LxJIDc22NKOL70J2kE=;
 b=JS4tRg63j2uAQT8MAaxWFoNUHbFmZ0PE5G7++tCSs0DQ5j7gZTYPjeu9TWsHHxWF0O
 cf5hrs72ygl67fhV1OKbct4S/5hJkxTKkyaPg7em9qTPg/kPB73YwlBxxex1YrxdrZs2
 HeZF+EGBkY0y5AqwLKFiu+AmfBiA5Y5rJdiJtkUG912liUOqr+f237fvPRLqfQY4wQ1n
 Ij/F6r5Jp9GJmfygoratDcAKUqolJ8FkRLeaFFYNZPwOLJ10IQ8/7UCX6J2gB06gRpER
 eddIWXeo8aYo0Nk5S1nw/qhi84FB5nRRIfiTjWDZZ5i8BzaOuLlAUkQWRswco8ZZEY5r
 9vRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx3IImmGfChaQFXl7r9Horx/hb3zbrqueBMg/pu/QnVEQsnqLjLpfl+CM4HwcelxIDEIZ2Cs0=@lists.denx.de
X-Gm-Message-State: AOJu0Yzwn2RUqEF5Pq6xzT2wIgy5QGw4wNo+0EPh9EEpja5BGJeG27jK
 vbO6HmqNi2EoOeD37GrjxWhsLBHXsvmuWJp5RDX0ueRuWuL3RdBzmxq2S/vf50N8tWphVhYU1sq
 QXq7x4yLXXJzF6ZPaXdHdzxEgQ+547iz2l/uMEg==
X-Google-Smtp-Source: AGHT+IH/Qfml4Fmmu7Ct9+A97PrfBZDMSOCrAD+ggbOV0hSkdbHzRBCjWRdQ+5TZPdcK4wtE/ALZBJY1u4dm1jfk03s=
X-Received: by 2002:a05:6a00:3cc8:b0:71e:e3:608 with SMTP id
 d2e1a72fcca58-7206306ebb4mr21579940b3a.26.1730310902743; Wed, 30 Oct 2024
 10:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241029192222.362445-1-sjg@chromium.org>
 <20241029192222.362445-3-sjg@chromium.org>
 <28e1ac54-c813-4b3d-b301-1bd408f29e28@gmx.de>
In-Reply-To: <28e1ac54-c813-4b3d-b301-1bd408f29e28@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 30 Oct 2024 19:54:25 +0200
Message-ID: <CAC_iWjL7h0qO3g1hVzqKVmxehR=6zd7jUFV=U5ebN5pOa-di=w@mail.gmail.com>
Subject: Re: [PATCH v9 02/11] efi_loader: Add a test app
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
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

Hi Heinrich



On Wed, 30 Oct 2024 at 18:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/29/24 20:22, Simon Glass wrote:
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
> > Changes in v9:
> > - Update license
> > - Fix 'sevices' typo
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
> > index 37572c82f54..44319729bda 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -584,6 +584,16 @@ config BOOTEFI_HELLO_COMPILE
> >         No additional space will be required in the resulting U-Boot binary
> >         when this option is enabled.
> >
> > +config BOOTEFI_TESTAPP_COMPILE
> > +     bool "Compile an EFI test app for testing"
> > +     default y
> > +     help
> > +       This compiles an app designed for testing. It is packed into an image
> > +       by the test.py testing frame in the setup_efi_image() function.
> > +
> > +       No additional space will be required in the resulting U-Boot binary
> > +       when this option is enabled.
> > +
> >   endif
> >
> >   source "lib/efi/Kconfig"
> > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> > index 8ec240cb864..7c8b2dd1ad6 100644
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
> > index 00000000000..a28fc17ce5b
> > --- /dev/null
> > +++ b/lib/efi_loader/testapp.c
> > @@ -0,0 +1,68 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Hello world EFI application
> > + *
> > + * Copyright 2024 Google LLC
> > + * Written by Simon Glass <sjg@chromium.org>
> > + *
> > + * This test program is used to test the invocation of an EFI application.
> > + * It writes a few messages to the console and then exits boot services
> > + */
> > +
> > +#include <efi_api.h>
> > +
> > +static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
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
> > +                     (con_out, u"Cannot open loaded image protocol\r\n");
> > +             goto out;
> > +     }
> > +
> > +     /* UEFI requires CR LF */
> > +     con_out->output_string(con_out, u"U-Boot test app for EFI_LOADER\r\n");
> > +
> > +out:
> > +     map_size = 0;
> > +     ret = boottime->get_memory_map(&map_size, NULL, &map_key, &desc_size,
> > +                                    &desc_version);
> > +     con_out->output_string(con_out, u"Exiting boot services\n");
> > +
> > +     /* exit boot services so that this part of U-Boot can be tested */
> > +     boottime->exit_boot_services(handle, map_key);
>
> Hello Simon,
>
> I am not NAKing this patch. But maybe you could rethink if this call
> tells us anything new about the correct function of ExitBootServices().
>
> We already have a test of ExitBootServices() in lib/efi_selftest/ and
> maybe we should extend that test to check more.
>
> By removing ExitBootServices() we could keep U-Boot in a well defined
> state which will allow us to run any number of bootmeth tests in
> sequence and keep the EFI sub-system in a consistent state.

FWIW I proposed exactly the same in [0].

[0] https://lore.kernel.org/u-boot/CAC_iWjJYqrh6MS50d6MxdStJFGg2pWnf1PHwQ9muYDPmOBP7Lg@mail.gmail.com/

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
>
> > +
> > +     /* now exit for real */
> > +     ret = boottime->exit(handle, ret, 0, NULL);
> > +
> > +     /* We should never arrive here */
> > +     return ret;
> > +}
>
