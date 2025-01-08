Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F92E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 07:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22A578006D;
	Wed,  8 Jan 2025 08:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ly3QneKK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25BB5801E8; Wed,  8 Jan 2025 08:11:46 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 487B08001F
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 08:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e39f43344c5so21769603276.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 23:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736320302; x=1736925102; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Al3NffFubdwcdjCyagFBJOkH+U19GjDUFdJpjKkJjuc=;
 b=ly3QneKKQAmIEfviEKIcb3mH8nm5LcJNNuolkBY6FyC49u13FGldZeBEXkk5SnliGA
 r9lcp1OokwRtqHwG2B+mMjGHLc12YYU4CpckpUrVTAHxRfIFIGK1g2wWgc/uCtpc1mgi
 M/hl1RbvGX5BzaKM9DDvLffoCp2gdaaXCwD73rLdk5Ev21F/MGwNlWBuwjbQlIzNeMRx
 ggSJ7PiNPcuHlphsTNKxa5TyryJhKwPZfMc2UPQ+e2CNUySSXWN5B1t3p58F7yy097BX
 byIlaF4KFlB/0q5CuOm+Z2S/uz78Q3pb+eKtm0cUtnfOwt+7FTUauUSni4ZO4ZRVakbc
 roWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736320302; x=1736925102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Al3NffFubdwcdjCyagFBJOkH+U19GjDUFdJpjKkJjuc=;
 b=EcjOhDKDyS7+MkK4Ga6KJ8GcBJkO674Mm/gMX/aDci2N9arz0XQe/nPo6butdxkBzh
 5ea5hHDzkwSkEMtaxFnqbgB1oQ7M21meIPTDjslwFtrgd3UfJdawdPB3ih20ObZbT9nd
 B8PW5DPIrOPQia2s+pr4TwO29dKWhNArGC5dGtC5ipn/C+xs9eJpoPZ7gSTtPTg4JY4B
 h0QtQBAzleiyksrTPo+iyVtC/FJn5OT3cDIUJ34C5dx4yKsm1hPWdyQ/1hq7iDvBGqXO
 2e+Rbszz4A+uFj5teyWCTEeBGA8WfLa9xW/qrMhWDuYIb+7rAyvWBy0NcMNtgQSRR1o8
 rfGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL9+PVQgYWWWAciC18bhlQbmr6G+ks0XUDgtibjH4CMiCscmy522IMFFCcnz9ogA19aJXtEG4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz72moanaBM/y0B4Z4TWZlZutCy2l1gMIgHtc9LRd93LQxo3P1A
 UMD8OncR6UkRhKedc43pljztklNRPKGoHOYj47ONfqRVk+6xwA0EONu6Qc6/+bahkI9n44drX9t
 ypwoHyPhFaQeEtgNCkpJf5drewA/DNQujxvWAHQ==
X-Gm-Gg: ASbGncsJUDYqD9RNtu111T5/YeM2QeAuMHwWYu5NZ4i7OUr5AyMQVaKZYwMcQ4S4CFn
 hD666LA98OxRfUHqbuk/CmF6ID+LFfpIwwsuylA==
X-Google-Smtp-Source: AGHT+IFrFkeytasKOKv/fOvQCfp403av7RxOzBB67ZiyTsxHEouFJHz5izqMUoHN/8e1Gh6hfUnft4JX3/Ehk2gbXZA=
X-Received: by 2002:a05:6902:1b8d:b0:e38:b34d:121f with SMTP id
 3f1490d57ef6-e54ee15ca25mr1258225276.15.1736320302081; Tue, 07 Jan 2025
 23:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
 <20250102181133.378867-4-heinrich.schuchardt@canonical.com>
 <CAC_iWjJhQQrNPyFDTAdo14X+x_CWer05+WVWu71xu_vxUb1iTw@mail.gmail.com>
 <05ffa461-d4ae-4522-b9db-b7ee34e20737@canonical.com>
In-Reply-To: <05ffa461-d4ae-4522-b9db-b7ee34e20737@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 Jan 2025 09:11:06 +0200
X-Gm-Features: AbW1kvbTjQQBCZZctURz3e-Nak8TpeV21bU9oKUkMRA3D26N_q9B0YsyatupCqA
Message-ID: <CAC_iWjKrr0rKi7SVN2rzSvkhCwOH+dTErdOEPJ2yuMQ-A1eDBg@mail.gmail.com>
Subject: Re: [PATCH 3/4] efi_loader: install DXE services table
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.denx.de
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

On Tue, 7 Jan 2025 at 19:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 07.01.25 14:30, Ilias Apalodimas wrote:
> > On Thu, 2 Jan 2025 at 20:11, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> The debug version of the UEFI shell requires a DXE services table to exist.
> >>
> >> Implement the table and let all DXE functions return EFI_UNSUPPORTED.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   include/efi_dxe.h          |  54 ++++++++++++
> >>   include/efi_loader.h       |   7 ++
> >>   lib/efi_loader/Kconfig     |   7 ++
> >>   lib/efi_loader/Makefile    |   1 +
> >>   lib/efi_loader/efi_dxe.c   | 176 +++++++++++++++++++++++++++++++++++++
> >>   lib/efi_loader/efi_setup.c |   6 ++
> >>   6 files changed, 251 insertions(+)
> >>   create mode 100644 include/efi_dxe.h
> >>   create mode 100644 lib/efi_loader/efi_dxe.c
> >>
> >> diff --git a/include/efi_dxe.h b/include/efi_dxe.h
> >> new file mode 100644
> >> index 00000000000..5623189de0c
> >> --- /dev/null
> >> +++ b/include/efi_dxe.h
> >> @@ -0,0 +1,54 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >> +/*
> >> + *  DXE services table
> >> + *
> >> + *  Copyright (c) 2025 Heinrich Schuchardt
> >> + */
> >> +
> >> +#ifndef _EFI_DXE_H
> >> +#define _EFI_DXE_H 1
> >> +
> >> +#include <efi.h>
> >> +
> >> +/**
> >> + * define DXE_SERVICES_SIGNATURE - DXE services signature ('DXE_SERV')
> >> + */
> >> +#define DXE_SERVICES_SIGNATURE 0x565245535f455844
> >> +/**
> >> + * define DXE_SERVICES_REVISION - DXE services revision (1.8)
> >> + */
> >> +#define DXE_SERVICES_REVISION 0x00010050
> >> +
> >> +/**
> >> + * define EFI_DXE_SERVICES_TABLE_GUID - GUID of the EFI DXE services table
> >> + */
> >> +#define EFI_DXE_SERVICES_TABLE_GUID \
> >> +       EFI_GUID(0x5ad34ba, 0x6f02, 0x4214, \
> >> +                0x95, 0x2e, 0x4d, 0xa0, 0x39, 0x8e, 0x2b, 0xb9)
> >> +
> >> +struct efi_dxe_services {
> >> +       struct efi_table_hdr hdr;
> >> +
> >> +       efi_status_t (EFIAPI *add_memory_space)(void);
> >> +       efi_status_t (EFIAPI *allocate_memory_space)(void);
> >> +       efi_status_t (EFIAPI *free_memory_space)(void);
> >> +       efi_status_t (EFIAPI *remove_memory_space)(void);
> >> +       efi_status_t (EFIAPI *get_memory_space_descriptor)(void);
> >> +       efi_status_t (EFIAPI *set_memory_space_attributes)(void);
> >> +       efi_status_t (EFIAPI *get_memory_space_map)(void);
> >> +       efi_status_t (EFIAPI *add_io_space)(void);
> >> +       efi_status_t (EFIAPI *allocate_io_space)(void);
> >> +       efi_status_t (EFIAPI *free_io_space)(void);
> >> +       efi_status_t (EFIAPI *remove_io_space)(void);
> >> +       efi_status_t (EFIAPI *get_io_space_descriptor)(void);
> >> +       efi_status_t (EFIAPI *get_io_space_map)(void);
> >> +       efi_status_t (EFIAPI *dispatch)(void);
> >> +       efi_status_t (EFIAPI *schedule)(void);
> >> +       efi_status_t (EFIAPI *trust)(void);
> >> +       efi_status_t (EFIAPI *process_firmware_volume)(void);
> >> +       efi_status_t (EFIAPI *set_memory_space_capabilities)(void);
> >> +};
> >> +
> >> +extern efi_guid_t efi_dxe_services_table_guid;
> >> +
> >> +#endif /* _EFI_DXE_H */
> >> diff --git a/include/efi_loader.h b/include/efi_loader.h
> >> index c1258098217..d474866184f 100644
> >> --- a/include/efi_loader.h
> >> +++ b/include/efi_loader.h
> >> @@ -663,6 +663,13 @@ efi_status_t efi_smbios_register(void);
> >>    */
> >>   efi_status_t efi_hob_list_register(void);
> >>
> >> +/**
> >> + * efi_dxe_services_register() - install DXE services table
> >> + *
> >> + * Return:     status code
> >> + */
> >> +efi_status_t efi_dxe_services_register(void);
> >> +
> >>   struct efi_simple_file_system_protocol *
> >>   efi_fs_from_path(struct efi_device_path *fp);
> >>
> >> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> >> index ec38a0ea352..ed3470508ff 100644
> >> --- a/lib/efi_loader/Kconfig
> >> +++ b/lib/efi_loader/Kconfig
> >> @@ -384,6 +384,13 @@ config EFI_DT_FIXUP
> >>            The EFI device-tree fix-up protocol provides a function to let the
> >>            firmware apply fix-ups. This may be used by boot loaders.
> >>
> >> +config EFI_DXE
> >> +       bool 'DXE services table'
> >> +       default y
> >> +       help
> >> +         Install the DXE services table. The debug version of the UEFI shell
> >> +         requires it.
> >> +
> >>   config EFI_LOADER_HII
> >>          bool "HII protocols"
> >>          default y
> >> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> >> index 195ed8667fe..4f250f21811 100644
> >> --- a/lib/efi_loader/Makefile
> >> +++ b/lib/efi_loader/Makefile
> >> @@ -33,6 +33,7 @@ obj-y += efi_console.o
> >>   obj-y += efi_device_path.o
> >>   obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_device_path_to_text.o
> >>   obj-$(CONFIG_EFI_DEVICE_PATH_UTIL) += efi_device_path_utilities.o
> >> +obj-$(CONFIG_EFI_DXE) += efi_dxe.o
> >>   obj-y += efi_dt_fixup.o
> >>   obj-y += efi_fdt.o
> >>   obj-y += efi_file.o
> >> diff --git a/lib/efi_loader/efi_dxe.c b/lib/efi_loader/efi_dxe.c
> >> new file mode 100644
> >> index 00000000000..f8920575b0c
> >> --- /dev/null
> >> +++ b/lib/efi_loader/efi_dxe.c
> >> @@ -0,0 +1,176 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/*
> >> + *  DXE services table
> >> + *
> >> + *  Copyright (c) 2025 Heinrich Schuchardt
> >> + */
> >> +
> >> +#include <efi_dxe.h>
> >> +#include <efi_loader.h>
> >> +
> >> +efi_guid_t efi_dxe_services_table_guid = EFI_DXE_SERVICES_TABLE_GUID;
> >> +
> >> +static efi_status_t EFIAPI add_memory_space(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static efi_status_t EFIAPI allocate_memory_space(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static efi_status_t EFIAPI free_memory_space(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static efi_status_t EFIAPI remove_memory_space(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static efi_status_t EFIAPI get_memory_space_descriptor(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static efi_status_t EFIAPI set_memory_space_attributes(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static efi_status_t EFIAPI get_memory_space_map(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static efi_status_t EFIAPI add_io_space(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static efi_status_t EFIAPI allocate_io_space(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static efi_status_t EFIAPI free_io_space(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static efi_status_t EFIAPI remove_io_space(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static efi_status_t EFIAPI get_io_space_descriptor(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static efi_status_t EFIAPI get_io_space_map(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static efi_status_t EFIAPI dispatch(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static efi_status_t EFIAPI schedule(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static efi_status_t EFIAPI trust(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static efi_status_t EFIAPI process_firmware_volume(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static efi_status_t EFIAPI set_memory_space_capabilities(void)
> >> +{
> >> +       EFI_ENTRY();
> >> +
> >> +       return EFI_EXIT(EFI_UNSUPPORTED);
> >> +}
> >> +
> >> +static struct efi_dxe_services efi_dxe_services = {
> >> +       .hdr = {
> >> +               .signature = DXE_SERVICES_SIGNATURE,
> >> +               .revision = DXE_SERVICES_REVISION,
> >> +               .headersize = sizeof(struct efi_dxe_services),
> >> +       },
> >> +       .add_memory_space = add_memory_space,
> >> +       .allocate_memory_space = allocate_memory_space,
> >> +       .free_memory_space = free_memory_space,
> >> +       .remove_memory_space = remove_memory_space,
> >> +       .get_memory_space_descriptor = get_memory_space_descriptor,
> >> +       .set_memory_space_attributes = set_memory_space_attributes,
> >> +       .get_memory_space_map = get_memory_space_map,
> >> +       .add_io_space = add_io_space,
> >> +       .allocate_io_space = allocate_io_space,
> >> +       .free_io_space = free_io_space,
> >> +       .remove_io_space = remove_io_space,
> >> +       .get_io_space_descriptor = get_io_space_descriptor,
> >> +       .get_io_space_map = get_io_space_map,
> >> +       .dispatch = dispatch,
> >> +       .schedule = schedule,
> >> +       .trust = trust,
> >> +       .process_firmware_volume = process_firmware_volume,
> >> +       .set_memory_space_capabilities = set_memory_space_capabilities,
> >
> > Do we plan on ever implementing those? If not we could use a single
> > function returning EFI_UNSUPPORTED instead of all of them for code
> > size reasons
>
> Currently I don't plan to implement these. But I wanted to be able to add
>
>      #define _DEBUG 1
>
> to find out which of the functions is possibly used.
>
> On x86 and sandbox I don't think our memory restrictions are very tight.
>
> Best regards
>
> Heinrich

Fair enough
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> >
> > Cheers
> > /Ilias
> >> +};
> >> +
> >> +efi_status_t efi_dxe_services_register(void)
> >> +{
> >> +       struct efi_dxe_services *dxe;
> >> +
> >> +       dxe = efi_alloc(sizeof(struct efi_dxe_services));
> >> +       if (!dxe)
> >> +               return EFI_OUT_OF_RESOURCES;
> >> +
> >> +       memcpy(dxe, &efi_dxe_services, sizeof(struct efi_dxe_services));
> >> +
> >> +       return efi_install_configuration_table(&efi_dxe_services_table_guid, dxe);
> >> +}
> >> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> >> index 393b690c3ee..796da5d5678 100644
> >> --- a/lib/efi_loader/efi_setup.c
> >> +++ b/lib/efi_loader/efi_setup.c
> >> @@ -260,6 +260,12 @@ efi_status_t efi_init_obj_list(void)
> >>          if (ret != EFI_SUCCESS)
> >>                  goto out;
> >>
> >> +       if (IS_ENABLED(CONFIG_EFI_DXE)) {
> >> +               ret = efi_dxe_services_register();
> >> +               if (ret != EFI_SUCCESS)
> >> +                       goto out;
> >> +       }
> >> +
> >>          if (IS_ENABLED(CONFIG_EFI_ECPT)) {
> >>                  ret = efi_ecpt_register();
> >>                  if (ret != EFI_SUCCESS)
> >> --
> >> 2.47.1
> >>
>
