Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF755C3ABA2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 15:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AE5788EE0;
	Mon, 16 Sep 2024 17:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ft1zqVGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C96FA88ED9; Mon, 16 Sep 2024 17:42:19 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A8D5883D4
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 17:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6c35b72f943so39104716d6.0
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726501336; x=1727106136; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w73YKdtd6KYzOt/HzdjZoc81ia3fdWaswgg3euptRdA=;
 b=ft1zqVGEyRyBLNGYjnzPyVVxrvCsSlNKp29PWPAC7X0ea+fJ0EklP1/RtZmtyH9BFD
 9+p6o2USlsbg40a+YjEGnk7QFrNptnBz6sNgdLoxPyXL4dllMes2UItoK8kbf2cpPvCY
 s8tr7WQGlf3LCcg7JWg1O7VwXg0ivgk7N/q64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501336; x=1727106136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w73YKdtd6KYzOt/HzdjZoc81ia3fdWaswgg3euptRdA=;
 b=Na1aLB10DTsl/mF/mClMYE+hwFUyIClHf3TrcROAh3TmJi7+BDBst2YyiYusIQc0wR
 tJKIh5gxwgyxLCgSoi36JpI7rJB5sFMjUCmPzzz5ux4pXQFOR7lthhosV39kN5PBMXNP
 XVtGFExTBoSXPjHl1oDsUedGkQt+SIGTunE1NuMpGjGlQChgTHZtIy/5DO6xwI/hYDFn
 jwljqrA7tuxI1Qe/baWF3pDCr5uHNoUTa2iJisK9h1egyJf5Vb3bQPBG1QMMzXKfKS/i
 5rOAziWJJSH+HGJAljt9dzhjq63WF0z6btESCd/807ZxjfsNrioxWwVQb0fepY48uJ3A
 cF3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJejQwgjjBElxQoSqrRADqMh4WgX04PjI+FePvhe3FfTAmrY05EZMiLb9erWltMEv7/ISNHQw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8VuEbL3eVARRNXovwNHjIDO1+loJRhEek0OwjHwbiqENpO+bF
 x+eeIV2hNekhpnDSxOiheiboofGsl5YYE7pTNm/uxe5hnLaXHUFFBVibSbKaMf61t7JiRtrFW3F
 Qgc6SDCZjmnvGfiNliStpv4m4dhYoKPoKZBsO
X-Google-Smtp-Source: AGHT+IFzjBk6mwXQmA8mZM4wbHMi2EPTzX3Z2MtSHlTb4xfrk3l9eEWL23xXuZN0nkRClzl5loQ93OL8i88zQHf7hew=
X-Received: by 2002:a05:6214:e6f:b0:6c3:69f9:fb49 with SMTP id
 6a1803df08f44-6c554d83afemr384187786d6.16.1726501336473; Mon, 16 Sep 2024
 08:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-12-sjg@chromium.org>
 <fa819278-d099-49c4-ad87-5e97fc31e955@gmx.de>
In-Reply-To: <fa819278-d099-49c4-ad87-5e97fc31e955@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Sep 2024 17:41:59 +0200
Message-ID: <CAFLszTiT3Oq8snR97HN=vuopJVfQMa+FWWCSiqtYfyt0AjGDPw@mail.gmail.com>
Subject: Re: [PATCH v5 11/14] efi_loader: Add a test app
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Thu, 12 Sept 2024 at 08:53, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 02.09.24 03:18, Simon Glass wrote:
> > Add a simple app to use for testing. This is intended to do whatever it
> > needs to for testing purposes. For now it just prints a message and
> > exits boot services.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   lib/efi_loader/Kconfig   | 10 ++++++
> >   lib/efi_loader/Makefile  |  1 +
> >   lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 79 insertions(+)
> >   create mode 100644 lib/efi_loader/testapp.c
> >
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index ab2c1c44364..4de05c6f2d6 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -528,4 +528,14 @@ config BOOTEFI_HELLO_COMPILE
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
> > +     con_out->output_string(con_out, u"Exiting boot sevices\n");
> > +
> > +     /* exit boot services so that this part of U-Boot can be tested */
> > +     boottime->exit_boot_services(handle, map_key);
> > +
> > +     /* now exit for real */
> > +     ret = boottime->exit(handle, ret, 0, NULL);
>
> You cannot call boot services after ExitBootServices().

What do you mean by 'cannot'?  It obviously works fine, so I suspect
you mean that you 'should not'? The point of this test is to test
exit-boot-services and then go back to sandbox so things can continue.
What do you suggest instead?

Regards,
Simon
