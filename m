Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099C9C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D54B888D5;
	Sun, 11 Aug 2024 16:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LvyPI1iz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FF4C888C2; Sun, 11 Aug 2024 16:50:31 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 225CC88100
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5d82eb2c4feso2358016eaf.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387828; x=1723992628; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=se5V1rUHegC81HLBZlumXFiQbQwisJB4TbJQbs0S8B8=;
 b=LvyPI1izbDxgEQlH9YyZIn754pvhYhc0wRwW9FV6IfpxnoSx3isOfINkW8ZTP2NcVl
 +50dgN2u1nJdWdfqDdC+MDdSwJ2YrFfGc0asHYW+H9LMZwUcBvq4wekj6Ri/GfRE+5GV
 fBG2AAROnMghRqxUI05MpQsxm/BH+pbQFcl6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387828; x=1723992628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=se5V1rUHegC81HLBZlumXFiQbQwisJB4TbJQbs0S8B8=;
 b=WNsiP0UfQj7bVbNuAsimh4qXumjCoyJWWuH5ZfZNFz+cXKURVjwXMivNGe0CU0dRTQ
 tMtSuKK2IOSZ5jEEU7zP60EQ/Y62P+GWXCrq404tCWVwOBCX9qPskz9yxzR3UZtKc9Lv
 Eeteagubw4EhKOYgQoJAal4jpUGRKBU1JTKM+HRPqMEJ2gQS1XiY2ZnDfcTAB8v3v0hh
 lTnmAFuCFAhQK40+xA1fP37EwprMV6ZFPXiYbnKJIkgJkNJrf2eNTy/qgVNzs1XnToiZ
 txaJdC3M5FYBcH87K2mjf/J00c7QuCNV/Djn1rIOTVPSQAxy5krXfqXvzKlo3Sc04x1o
 23hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPYMgOVb45Apmz9e1MQCA5zkFxWDWPskhddU1ToC9QyYNYCQ2MwkjJbh36L5Bw6WLhHXqectRpaIXz/oS7/p/++GoS8A==
X-Gm-Message-State: AOJu0Yx1f4qBGo5L2699gWxJHl28G7luX85jqyPD2mSkdmiTjnWVxm19
 MOKCJptoVlt8KdUJAewMc8MwGSklYp51YqBmSIUkU/T1q1XPaGsqXYsYywuCnE+A3JIDorBKHip
 UuDJS5zXrrjQ25gkEuuoOexm+x24Vh0RdS2FT
X-Google-Smtp-Source: AGHT+IEmlTsIEB9gcOcJy51+VrlRo97b+7qzyYwqxP4j4VEdGIJMbvUOBQ79hzwOZt/DQkyttlAoD1TPA+vu75iqM5I=
X-Received: by 2002:a05:6358:893:b0:1a5:cb16:bc40 with SMTP id
 e5c5f4694b2df-1b176f131e3mr912919655d.7.1723387827927; Sun, 11 Aug 2024
 07:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-37-sjg@chromium.org>
 <194083b4-07e1-4b3d-906b-6277d1d8cd0c@gmx.de>
 <CAFLszThmhENnEA6jc2q=FRoinv6t9bUWh_PcXTrxvaifJvqY6w@mail.gmail.com>
 <b8409d9e-58d6-4b2e-b0df-9b77cdded67f@gmx.de>
In-Reply-To: <b8409d9e-58d6-4b2e-b0df-9b77cdded67f@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Aug 2024 08:50:17 -0600
Message-ID: <CAFLszTh_HY8eBmhiVst-rFcB+Yo930Axf-wYNA-ZNuQjab9-Mg@mail.gmail.com>
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

On Thu, 8 Aug 2024 at 15:17, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 07.08.24 16:36, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Tue, 6 Aug 2024 at 19:47, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 06.08.24 14:58, Simon Glass wrote:
> >>> Add a simple app to use for testing. This is intended to do whatever it
> >>> needs to for testing purposes. For now it just prints a message and
> >>> exits boot services.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>> (no changes since v1)
> >>>
> >>>    lib/efi_loader/Kconfig   | 10 ++++++
> >>>    lib/efi_loader/Makefile  |  1 +
> >>>    lib/efi_loader/testapp.c | 68 ++++++++++++++++++++++++++++++++++++++++
> >>>    3 files changed, 79 insertions(+)
> >>>    create mode 100644 lib/efi_loader/testapp.c
> >>>
> >>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> >>> index ab2c1c44364..4de05c6f2d6 100644
> >>> --- a/lib/efi_loader/Kconfig
> >>> +++ b/lib/efi_loader/Kconfig
> >>> @@ -528,4 +528,14 @@ config BOOTEFI_HELLO_COMPILE
> >>>          No additional space will be required in the resulting U-Boot binary
> >>>          when this option is enabled.
> >>>
> >>> +config BOOTEFI_TESTAPP_COMPILE
> >>> +     bool "Compile an EFI test app for testing"
> >>> +     default y
> >>> +     help
> >>> +       This compiles an app designed for testing. It is packed into an image
> >>> +       by the test.py testing frame in the setup_efi_image() function.
> >>> +
> >>> +       No additional space will be required in the resulting U-Boot binary
> >>> +       when this option is enabled.
> >>> +
> >>>    endif
> >>> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> >>> index 00d18966f9e..87131ab911d 100644
> >>> --- a/lib/efi_loader/Makefile
> >>> +++ b/lib/efi_loader/Makefile
> >>> @@ -20,6 +20,7 @@ apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) += initrddump
> >>>    ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
> >>>    apps-y += dtbdump
> >>>    endif
> >>> +apps-$(CONFIG_BOOTEFI_TESTAPP_COMPILE) += testapp
> >>>
> >>>    obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
> >>>    obj-$(CONFIG_EFI_BOOTMGR) += efi_bootmgr.o
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
> >>> + * @handle:  handle of the loaded image
> >>> + * @systab:  system table
> >>> + * Return:   status code
> >>> + */
> >>> +efi_status_t EFIAPI efi_main(efi_handle_t handle,
> >>> +                          struct efi_system_table *systab)
> >>> +{
> >>> +     struct efi_loaded_image *loaded_image;
> >>> +     efi_status_t ret;
> >>> +     efi_uintn_t map_size;
> >>> +     efi_uintn_t map_key;
> >>> +     efi_uintn_t desc_size;
> >>> +     u32 desc_version;
> >>> +
> >>> +     systable = systab;
> >>> +     boottime = systable->boottime;
> >>> +     con_out = systable->con_out;
> >>> +
> >>> +     /* Get the loaded image protocol */
> >>> +     ret = boottime->open_protocol(handle, &loaded_image_guid,
> >>> +                                   (void **)&loaded_image, NULL, NULL,
> >>> +                                   EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> >>> +     if (ret != EFI_SUCCESS) {
> >>> +             con_out->output_string
> >>> +                     (con_out, u"Cannot open loaded image protocol\r\n");
> >>> +             goto out;
> >>> +     }
> >>> +
> >>> +     /* UEFI requires CR LF */
> >>> +     con_out->output_string(con_out, u"U-Boot test app for EFI_LOADER\r\n");
> >>> +
> >>> +out:
> >>> +     map_size = 0;
> >>> +     ret = boottime->get_memory_map(&map_size, NULL, &map_key, &desc_size,
> >>> +                                    &desc_version);
> >>> +     con_out->output_string(con_out, u"Exiting boot sevices\n");
> >>> +
> >>> +     /* exit boot services so that this part of U-Boot can be tested */
> >>> +     boottime->exit_boot_services(handle, map_key);
> >>> +
> >>> +     /* now exit for real */
> >>> +     ret = boottime->exit(handle, ret, 0, NULL);
> >>
> >> Please, have a look at chapter 7.4.6,
> >> "EFI_BOOT_SERVICES.ExitBootServices" of the UEFI specification.
> >>
> >> After ExitBootServices() you cannot return anywhere. Boot services are
> >> not available anymore. You can only invoke the UEFI runtime services
> >> which include ResetSystem().
> >
> > Yes, understood, but this is a test, so returning is needed so that
> > the test can check the output is correct.
> >
>
> ExitBootServices() calls dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL).
> You cannot print anything afterwards as all devices are gone.

That only removes activate devices, i.e. those which use DMA, etc. So
for example the serial port will still be present.

>
> But you can check if a reboot occurs. This is enough to verify that a
> ResetSystem() call placed after ExitBootServices() was executed.
>
> We already have
>
> * lib/efi_selftest/efi_selftest_exitbootservices.c
> * lib/efi_selftest/efi_selftest_variables_runtime.c
> * lib/efi_selftest/efi_selftest_set_virtual_address_map.c
>
> which test different aspects of ExitBootServices() on the sandbox.
>
> There is no need to duplicate these.

Ilias asked that I not put my stuff into HelloWorld, which is why I
added a new app. I can then use it how I please!

Actually none of the examples you list does what my new test does,
which is to boot an app from a bootflow. This was the subject of a
nasty bug, so I do what to add a test for it.

I don't want to reboot, since then it cannot be a unit test. I may
have mentioned this before...but the EFI approach to testing is quite
poor in this respect. We need to test specific regions of the code and
avoid these large, slow and complicated tests.

Regards,
Simon
