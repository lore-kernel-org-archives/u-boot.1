Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B42D767F2
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B80F892EF;
	Thu, 31 Oct 2024 19:03:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JLHrWc0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 943798931A; Thu, 31 Oct 2024 19:03:10 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E67868924F
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e2e050b1c3so1765261a91.0
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397786; x=1731002586; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B+6OqlGa1SLhBH2ZY5XZeSUt0f7nicRk32D+vyxw6/M=;
 b=JLHrWc0r6GSjCrASnuEnxSYnvWYgedvYTEv4SlvIx8KB84v87xC9eqf+Wynti5822k
 BzSWwfDEig+kAALQNoGrP1+e34l8wdIu0PGjYtvatSKItaoUsLwlofdWAwx5pe7Ns7o1
 HFD0oswOyaANeBBRcxlMGcNLUqDnm/Ovub0QA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397786; x=1731002586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B+6OqlGa1SLhBH2ZY5XZeSUt0f7nicRk32D+vyxw6/M=;
 b=mUC/6sUG93tw+F6ez3ncJRGqt56qkCTg/GzVbqJZ3lrPFrJgw2bLRK4S7PjaD8O+xk
 OfePlMcs6XaE9CxZ35Btp74wtYH+yoOo5zpqhSoht7cW34tIl0fxV2rTe3QZsdPolbjn
 10IfR6Hc2I//DK8KHvoW0na5x8j2KOOg+sutZvkrUzg1c38EkdTw5EknoJueCLtMd4Ic
 mgFurDPUAYNiZ0dImbOjVNRxq2RgRZNyK5f4hJAPfZhV9K0xT7Nkvy7FRFDUiobnduMW
 ANd9XKZrUT7l+G89OuyHPCbzJnhzmhkbFwmNFxul3pKi5v9KE0W5XbHS41Kf1AcoGidz
 e6YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkVa1ym5LcMeWkh8iMWZ8hqNcKOzBILdDCkY5+AgGQW8LEyYAQgscx5lH6MvT71CUkM72TU3I=@lists.denx.de
X-Gm-Message-State: AOJu0YzwxA+rr7359krv6N1ITug5GvdLX3muDbLlnpkwzsCEnIx7qBJ4
 MWb6Vuks1XBTs4iv/J+UyxN4tv1i8aGis5PS8DlI88amSDjBrURXiWdNv9lGvHkDENaS3QJ83uW
 4xyfUGs+ZnQWhycxTSTEQQtZGgUiq3VVGq5FG
X-Google-Smtp-Source: AGHT+IHinIL1QriDsmmdb4PGU/ZlTviQcm66/hdPZPeWftepac0SxFBmS0z8fNnxxuxnHul6fsM9D7z6UWyXJXGVdMw=
X-Received: by 2002:a17:90b:1dc5:b0:2e2:7f8f:3ad5 with SMTP id
 98e67ed59e1d1-2e94bcb6642mr1305587a91.2.1730397786419; Thu, 31 Oct 2024
 11:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241029192222.362445-1-sjg@chromium.org>
 <20241029192222.362445-3-sjg@chromium.org>
 <28e1ac54-c813-4b3d-b301-1bd408f29e28@gmx.de>
 <CAC_iWjL7h0qO3g1hVzqKVmxehR=6zd7jUFV=U5ebN5pOa-di=w@mail.gmail.com>
In-Reply-To: <CAC_iWjL7h0qO3g1hVzqKVmxehR=6zd7jUFV=U5ebN5pOa-di=w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 19:02:49 +0100
Message-ID: <CAFLszTi0gwjS=YhyDFwb+fJPDYSoLr1HAt8eWuu7qv338K1sYg@mail.gmail.com>
Subject: Re: [PATCH v9 02/11] efi_loader: Add a test app
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
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

Hi,

On Wed, 30 Oct 2024 at 18:55, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Heinrich
>
>
>
> On Wed, 30 Oct 2024 at 18:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 10/29/24 20:22, Simon Glass wrote:
> > > Add a simple app to use for testing. This is intended to do whatever it
> > > needs to for testing purposes. For now it just prints a message and
> > > exits boot services.
> > >
> > > There was a considerable amount of discussion about whether it is OK to
> > > call exit-boot-services and then return to U-Boot. This is not normally
> > > done in a real application, since exit-boot-services is used to
> > > completely disconnect from U-Boot. However, since this is a test, we
> > > need to check the results of running the app, so returning is necessary.
> > > It works correctly and it provides a nice model of how to test the EFI
> > > code in a simple way.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v9:
> > > - Update license
> > > - Fix 'sevices' typo
> > >
> > > Changes in v7:
> > > - Update commit message
> > >
> > >   lib/efi_loader/Kconfig   | 10 ++++++
> > >   lib/efi_loader/Makefile  |  1 +
> > >   lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++++++++++++++
> > >   3 files changed, 79 insertions(+)
> > >   create mode 100644 lib/efi_loader/testapp.c
> > >
> > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > index 37572c82f54..44319729bda 100644
> > > --- a/lib/efi_loader/Kconfig
> > > +++ b/lib/efi_loader/Kconfig
> > > @@ -584,6 +584,16 @@ config BOOTEFI_HELLO_COMPILE
> > >         No additional space will be required in the resulting U-Boot binary
> > >         when this option is enabled.
> > >
> > > +config BOOTEFI_TESTAPP_COMPILE
> > > +     bool "Compile an EFI test app for testing"
> > > +     default y
> > > +     help
> > > +       This compiles an app designed for testing. It is packed into an image
> > > +       by the test.py testing frame in the setup_efi_image() function.
> > > +
> > > +       No additional space will be required in the resulting U-Boot binary
> > > +       when this option is enabled.
> > > +
> > >   endif
> > >
> > >   source "lib/efi/Kconfig"
> > > diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> > > index 8ec240cb864..7c8b2dd1ad6 100644
> > > --- a/lib/efi_loader/Makefile
> > > +++ b/lib/efi_loader/Makefile
> > > @@ -20,6 +20,7 @@ apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) += initrddump
> > >   ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
> > >   apps-y += dtbdump
> > >   endif
> > > +apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) += testapp
> > >
> > >   obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
> > >   obj-$(CONFIG_EFI_BOOTMGR) += efi_bootmgr.o
> > > diff --git a/lib/efi_loader/testapp.c b/lib/efi_loader/testapp.c
> > > new file mode 100644
> > > index 00000000000..a28fc17ce5b
> > > --- /dev/null
> > > +++ b/lib/efi_loader/testapp.c
> > > @@ -0,0 +1,68 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * Hello world EFI application
> > > + *
> > > + * Copyright 2024 Google LLC
> > > + * Written by Simon Glass <sjg@chromium.org>
> > > + *
> > > + * This test program is used to test the invocation of an EFI application.
> > > + * It writes a few messages to the console and then exits boot services
> > > + */
> > > +
> > > +#include <efi_api.h>
> > > +
> > > +static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
> > > +
> > > +static struct efi_system_table *systable;
> > > +static struct efi_boot_services *boottime;
> > > +static struct efi_simple_text_output_protocol *con_out;
> > > +
> > > +/**
> > > + * efi_main() - entry point of the EFI application.
> > > + *
> > > + * @handle:  handle of the loaded image
> > > + * @systab:  system table
> > > + * Return:   status code
> > > + */
> > > +efi_status_t EFIAPI efi_main(efi_handle_t handle,
> > > +                          struct efi_system_table *systab)
> > > +{
> > > +     struct efi_loaded_image *loaded_image;
> > > +     efi_status_t ret;
> > > +     efi_uintn_t map_size;
> > > +     efi_uintn_t map_key;
> > > +     efi_uintn_t desc_size;
> > > +     u32 desc_version;
> > > +
> > > +     systable = systab;
> > > +     boottime = systable->boottime;
> > > +     con_out = systable->con_out;
> > > +
> > > +     /* Get the loaded image protocol */
> > > +     ret = boottime->open_protocol(handle, &loaded_image_guid,
> > > +                                   (void **)&loaded_image, NULL, NULL,
> > > +                                   EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> > > +     if (ret != EFI_SUCCESS) {
> > > +             con_out->output_string
> > > +                     (con_out, u"Cannot open loaded image protocol\r\n");
> > > +             goto out;
> > > +     }
> > > +
> > > +     /* UEFI requires CR LF */
> > > +     con_out->output_string(con_out, u"U-Boot test app for EFI_LOADER\r\n");
> > > +
> > > +out:
> > > +     map_size = 0;
> > > +     ret = boottime->get_memory_map(&map_size, NULL, &map_key, &desc_size,
> > > +                                    &desc_version);
> > > +     con_out->output_string(con_out, u"Exiting boot services\n");
> > > +
> > > +     /* exit boot services so that this part of U-Boot can be tested */
> > > +     boottime->exit_boot_services(handle, map_key);
> >
> > Hello Simon,
> >
> > I am not NAKing this patch. But maybe you could rethink if this call
> > tells us anything new about the correct function of ExitBootServices().
> >
> > We already have a test of ExitBootServices() in lib/efi_selftest/ and
> > maybe we should extend that test to check more.
> >
> > By removing ExitBootServices() we could keep U-Boot in a well defined
> > state which will allow us to run any number of bootmeth tests in
> > sequence and keep the EFI sub-system in a consistent state.

In the interests of trying to make some progress, I will drop that
line and worry about it later, when we can come up with follow-on
tests. It is exactly the 'exit-boot-services' call which was stopping
Ubuntu from booting. But since I don't have any test pieces to check
what happens in that situation, we can leave it for now.

>
> FWIW I proposed exactly the same in [0].
>
> [0] https://lore.kernel.org/u-boot/CAC_iWjJYqrh6MS50d6MxdStJFGg2pWnf1PHwQ9muYDPmOBP7Lg@mail.gmail.com/
>
> Thanks
> /Ilias
> >
> > Best regards
> >
> > Heinrich
> >
> >
> > > +
> > > +     /* now exit for real */
> > > +     ret = boottime->exit(handle, ret, 0, NULL);
> > > +
> > > +     /* We should never arrive here */
> > > +     return ret;
> > > +}
> >

Regards,
Simon
