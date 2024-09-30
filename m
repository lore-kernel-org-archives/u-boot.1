Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24063CE8347
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 14:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96C1F88E1A;
	Mon, 30 Sep 2024 16:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rl9AqWIp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC05488E3C; Mon, 30 Sep 2024 16:12:42 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F2A188D9B
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 16:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cb2f344dbbso35971926d6.3
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727705559; x=1728310359; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gADvwDOizmb3r6ZBXFeAg2P1DXhSoLRz6IEGB8oZ7Jc=;
 b=Rl9AqWIp3vmUMaJVzDcmteSKQs6Y8FdzWDJqGX+LseLEaCWWMetoBn1L8h4icN7hFn
 AguRziFGJlaXFvRYdbRtyfGYOdaQ8Iij4KA+oKlGRoQ4NHCfCjRjPBntyWilPkKfhjhL
 BUe887U9iHijUnF9COOiaJ8JT1aMvr2Q5DEkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727705559; x=1728310359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gADvwDOizmb3r6ZBXFeAg2P1DXhSoLRz6IEGB8oZ7Jc=;
 b=duanKngrOT7qHXtm1HuOd5p21CNDOG7SdJR8WN1XugpUXG53UHyfjyeAlUxl6LIUgA
 xNQr/ZkFy5basHYVPX+8Y8e+3fLXFWndPvyl5LUZEqxDDXcsgE0uNR2FExYLqYDWuySp
 AW4z+YDN9iYPCNuHASh33BUWQ/FXPvgGiLuX1iDjKZu1Ge8+qmcSTEMkvNJPJvkcpjU6
 z7woB4ptXckBsthO8OaXbtZOETayOK+4cq8RDa1Q8rfOyzZNDOg9nvcFIdUzAcG9BaDK
 CaeokizTrpzS9naJZ5dj1x4o97YZ+adG/DFhmFOZ8ZJ73fFJXwWaWXlW+ZMnxY0Vk3PL
 RMYw==
X-Gm-Message-State: AOJu0YztO1c0AJ3O6bms+woDX46sqPTkzSgzMdEXNMAjpkxlVuLS6wdk
 fFSXcgdPvfWCOW6CQ5VSNLlBOXw0USI2RZlGzIHOZHHOTSyELnGwikKAeY2dLW0XTCgK+RA9aF+
 E2AQxC7fS7Vf+XQTJJeVOmQT0dX2iXGlewqBK
X-Google-Smtp-Source: AGHT+IFhNzt8aP12FieLo1JA0+CBw6hA8wNE+VKchvZLGQoEtb2oY+g3hY05xQTmQtzwu7ivfe6dOMevQtpBGoLk6hI=
X-Received: by 2002:a05:6214:33c5:b0:6cb:4def:4ce4 with SMTP id
 6a1803df08f44-6cb4def4dd3mr126396156d6.32.1727705559256; Mon, 30 Sep 2024
 07:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240926220226.1265965-9-sjg@chromium.org>
 <20240926220226.1265965-10-sjg@chromium.org>
 <CAC_iWj+-Y5XCs1byoGzxqkL2PQoaEHA9UUhwU7_v5i2omPvmtQ@mail.gmail.com>
 <CAFLszTjeNUJ88aCLVS1d6Ekki0ekv3zkOxpB2nGmp=tM0stLfA@mail.gmail.com>
 <7ff9fb46-40c9-47dd-880b-5ecf898de68e@gmx.de>
In-Reply-To: <7ff9fb46-40c9-47dd-880b-5ecf898de68e@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 30 Sep 2024 08:12:28 -0600
Message-ID: <CAFLszThA71PkH9JZYjF+pFO7wrwT5xf2POo0vp6ULFUWyZ9Qkg@mail.gmail.com>
Subject: Re: [PATCH v6 09/12] efi_loader: Add a test app
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Mon, 30 Sept 2024 at 06:05, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 27.09.24 18:50, Simon Glass wrote:
> > Hi Ilias,
> >
> > On Fri, 27 Sept 2024 at 07:51, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi Simon,
> >>
> >> On Fri, 27 Sept 2024 at 01:04, Simon Glass <sjg@chromium.org> wrote:
> >>>
> >>> Add a simple app to use for testing. This is intended to do whatever it
> >>> needs to for testing purposes. For now it just prints a message and
> >>> exits boot services.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>> (no changes since v1)
> >>>
> >>>   lib/efi_loader/Kconfig   | 10 ++++++
> >>>   lib/efi_loader/Makefile  |  1 +
> >>>   lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++++++++++++++
> >>>   3 files changed, 79 insertions(+)
> >>>   create mode 100644 lib/efi_loader/testapp.c
> >>>
> >>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> >>> index 6f6fa8d629d..41083e7c137 100644
> >>> --- a/lib/efi_loader/Kconfig
> >>> +++ b/lib/efi_loader/Kconfig
> >>> @@ -564,6 +564,16 @@ config BOOTEFI_HELLO_COMPILE
> >>>            No additional space will be required in the resulting U-Boot binary
> >>>            when this option is enabled.
> >>>
> >>> +config BOOTEFI_TESTAPP_COMPILE
> >>> +       bool "Compile an EFI test app for testing"
> >>> +       default y
> >>> +       help
> >>> +         This compiles an app designed for testing. It is packed into an image
> >>> +         by the test.py testing frame in the setup_efi_image() function.
> >>> +
> >>> +         No additional space will be required in the resulting U-Boot binary
> >>> +         when this option is enabled.
> >>> +
> >>>   endif
> >>>
> >>>   source "lib/efi/Kconfig"
> >>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> >>> index 00d18966f9e..87131ab911d 100644
> >>> --- a/lib/efi_loader/Makefile
> >>> +++ b/lib/efi_loader/Makefile
> >>> @@ -20,6 +20,7 @@ apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) += initrddump
> >>>   ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
> >>>   apps-y += dtbdump
> >>>   endif
> >>> +apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) += testapp
> >>>
> >>>   obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
> >>>   obj-$(CONFIG_EFI_BOOTMGR) += efi_bootmgr.o
> >>> diff --git a/lib/efi_loader/testapp.c b/lib/efi_loader/testapp.c
> >>> new file mode 100644
> >>> index 00000000000..feb444c92e9
> >>> --- /dev/null
> >>> +++ b/lib/efi_loader/testapp.c
> >>> @@ -0,0 +1,68 @@
> >>> +// SPDX-License-Identifier: GPL-2.0+
> >>> +/*
> >>> + * Hello world EFI application
> >>> + *
> >>> + * Copyright 2024 Google LLC
> >>> + * Written by Simon Glass <sjg@chromium.org>
> >>> + *
> >>> + * This test program is used to test the invocation of an EFI application.
> >>> + * It writes a few messages to the console and then exits boot services
> >>> + */
> >>> +
> >>> +#include <efi_api.h>
> >>> +
> >>> +static const efi_guid_t loaded_image_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
> >>> +
> >>> +static struct efi_system_table *systable;
> >>> +static struct efi_boot_services *boottime;
> >>> +static struct efi_simple_text_output_protocol *con_out;
> >>> +
> >>> +/**
> >>> + * efi_main() - entry point of the EFI application.
> >>> + *
> >>> + * @handle:    handle of the loaded image
> >>> + * @systab:    system table
> >>> + * Return:     status code
> >>> + */
> >>> +efi_status_t EFIAPI efi_main(efi_handle_t handle,
> >>> +                            struct efi_system_table *systab)
> >>> +{
> >>> +       struct efi_loaded_image *loaded_image;
> >>> +       efi_status_t ret;
> >>> +       efi_uintn_t map_size;
> >>> +       efi_uintn_t map_key;
> >>> +       efi_uintn_t desc_size;
> >>> +       u32 desc_version;
> >>> +
> >>> +       systable = systab;
> >>> +       boottime = systable->boottime;
> >>> +       con_out = systable->con_out;
> >>> +
> >>> +       /* Get the loaded image protocol */
> >>> +       ret = boottime->open_protocol(handle, &loaded_image_guid,
> >>> +                                     (void **)&loaded_image, NULL, NULL,
> >>> +                                     EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> >>> +       if (ret != EFI_SUCCESS) {
> >>> +               con_out->output_string
> >>> +                       (con_out, u"Cannot open loaded image protocol\r\n");
> >>> +               goto out;
> >>> +       }
> >>> +
> >>> +       /* UEFI requires CR LF */
> >>> +       con_out->output_string(con_out, u"U-Boot test app for EFI_LOADER\r\n");
> >>> +
> >>> +out:
> >>> +       map_size = 0;
> >>> +       ret = boottime->get_memory_map(&map_size, NULL, &map_key, &desc_size,
> >>> +                                      &desc_version);
> >>> +       con_out->output_string(con_out, u"Exiting boot sevices\n");
> >>> +
> >>> +       /* exit boot services so that this part of U-Boot can be tested */
> >>> +       boottime->exit_boot_services(handle, map_key);
> >>
> >> What Heinrich keeps repeating here, is that after you call EBS, boot
> >> services must not be called again.
> >>
> >>> +
> >>> +       /* now exit for real */
> >>> +       ret = boottime->exit(handle, ret, 0, NULL);
> >>
> >> IOW this is wrong. It might happen to work because not much has run
> >> and the memory will still be there. But you certainly should not rely
> >> on that
> >
> > Well, not much has run because it is running the test program. So we
> > know it will be OK.
> >
> > One of the challenges we have is that we need to design things for
> > testing, i.e. to make testing easy and practical. The call to exit()
> > happily returns back to sandbox and all is well. It serves the purpose
> > of the test, which is all the app is wanting to do.
> >
> > So I have to ask, what problem are you seeing?
>
> We write tests to see if our firmware conforms to the UEFI
> specification. This requires that our tests are conformant.
>
> Please, call the ResetSystem() runtime service here.
>
> I would prefer if you could at least consider suggestions.

I have not seen any suggestions about the boottime-exit() prior to
this one. Did I miss something? Anyway, I will give it a try.

Reegards,
Simon
