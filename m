Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1222AC52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C98188B9B;
	Wed,  7 Aug 2024 16:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RGFNWvAC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C28C88A6B; Wed,  7 Aug 2024 16:36:47 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB00A88A5F
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b7a3b75133so10858966d6.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723041404; x=1723646204; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qbsKXfeGM56iQKywuS7tszuGyWSlLls2xz51hebL0NA=;
 b=RGFNWvAChWIDJxRsXeBShBpZe/PXCvvnJn1VxrZTAhtTsE3tfhtIpHAK/ovXJKTvl8
 qzdCRas2Gq7xWzzgh8CBRI3cM2PfEGDll+bLEvY3YXrz2zAIcIca7uIsKCAlGF/ucf2Q
 ThtXM39Fitf4GE3PHdaYBoCTwMrtsa0NqxB7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723041404; x=1723646204;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qbsKXfeGM56iQKywuS7tszuGyWSlLls2xz51hebL0NA=;
 b=hfAkX9tAN4eN+nGrXwO6tUIYN/gCYOdPRi+bsi8X1hvMhhV85y2mdmiFjXcWB3cG3y
 eKP6wD2O1xbthnQwSDZ38rDUsopU1wUIAksY1QESKzbyMrndbKoMEPY/nKc15/WGpFVR
 ZFA2/+dVJ6Pc5H+iOP9jwt7SHCh8iXHWNkDYoxRHVGfcnKGdg7Lg+JyMFMcszxPioNPE
 j37oOLKjowZ6wHE7gYKWgTua3ZIFIz/JzVqX2u6Z38XxMcEBoCEoh1ijvrEg9jB9xZuQ
 nUSfJnP2M7JVKNqj+L8PUBGSQt5NSInKT59vpEvFuy2ycnHzOAxtXGq5X8124V9ddkEf
 USFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcMA2XoVmsRAg7WkYaVB/X8HOwb04joqtzh43y/s43Cu1MMfyzG9Zz/bZgNfz49Lyuu9xAWpflkor1gw+O7OtFffH3cQ==
X-Gm-Message-State: AOJu0YwL52R2FRmOjhGyf9+RgLGcX3YIyVk13AiINN2nN5fo7luzQxUL
 Y+CAgRNp8uZPc9H0ea5lqzo4nwtGdVntzKFr8SuqIBTj0QHWquhvIS37C+trssPj39EgOSdijJi
 uOadMeOg2zvxaLJsvt+wXDGWvP59+MtyjXDUG
X-Google-Smtp-Source: AGHT+IGaLd6NbKPhunRF1kUYfbk3OANOJDlS+GekLhOgJlYrDiko4UhZGE+Tdnd+dyWkonUCsFtv+B2khMbvK8qYTqY=
X-Received: by 2002:a05:6214:45a1:b0:6b7:a9dd:ba58 with SMTP id
 6a1803df08f44-6bb983462e9mr260852856d6.18.1723041403539; Wed, 07 Aug 2024
 07:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-37-sjg@chromium.org>
 <194083b4-07e1-4b3d-906b-6277d1d8cd0c@gmx.de>
In-Reply-To: <194083b4-07e1-4b3d-906b-6277d1d8cd0c@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Aug 2024 08:36:32 -0600
Message-ID: <CAFLszThmhENnEA6jc2q=FRoinv6t9bUWh_PcXTrxvaifJvqY6w@mail.gmail.com>
Subject: Re: [PATCH v2 36/39] efi: Add a test app
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <michal.simek@amd.com>, 
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

On Tue, 6 Aug 2024 at 19:47, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 06.08.24 14:58, Simon Glass wrote:
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
> Please, have a look at chapter 7.4.6,
> "EFI_BOOT_SERVICES.ExitBootServices" of the UEFI specification.
>
> After ExitBootServices() you cannot return anywhere. Boot services are
> not available anymore. You can only invoke the UEFI runtime services
> which include ResetSystem().

Yes, understood, but this is a test, so returning is needed so that
the test can check the output is correct.

Regards,
Simon
