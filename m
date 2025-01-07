Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A6AC02181
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 13:31:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8138801E8;
	Tue,  7 Jan 2025 14:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y13ETZJy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2814B8036D; Tue,  7 Jan 2025 14:31:39 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBCDD8007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 14:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso23366847276.3
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 05:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736256693; x=1736861493; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V/QmBLKngk7+Ji/gtKgMZlaf1tshsaugNh5i0BjDrOw=;
 b=y13ETZJy9JA9HgfO3ajwvaVyIvC6AEiBUEvYniFrhiB/0YdSodlyIcLzVWGZBKb7DP
 QFcQTkYhzQdb7li6GFV1IW3oEUxwIFgZRDd5zKnrgLf1Lgq4K2usXze/uTkhN/ofba87
 d+DYwRVXFh4BqtRQStMt+A4hWHn0fwBpFCj+d9Zsc1bOQ+e5/PYSHLILimPy/FGfTAwY
 nuqtlotM5ANo38Y2dKoGCeZnBFIGtUQp6eGDImjivNocBeUWPAb0ZfCY1Z7Xyv4ZD0rW
 jxKCm2GdnsNTV59MfEYpD8eOsJhxDeoopzw3+QxMo1dfHG/2eHyPbrLwX1Bmd2GXLT6l
 ksdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736256693; x=1736861493;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V/QmBLKngk7+Ji/gtKgMZlaf1tshsaugNh5i0BjDrOw=;
 b=L4A1K8wu8CwfavEpNRhPKIjFWOm9JP4BpdG2PJxoGY08NrMNmFJMNCrGXTG5GSErb+
 ScllJ/5urSRjZQqw16hJZUohGt8orOlpj3MlzUqcgpgeYTi21Em7BrZm5WGfcnoAYKyr
 9d30SVxuyhHt6oM/7QPSxcC6qqi3x/KfTGkOL3MjB0cWDczorNWMnfghq76gCxSzNRfs
 l2TliIU2+es3JP6GKMjoEAcDMrEYCAnbIzsMLOf/WFRiOsUFVrTPXp3wRFI9+k12F6Nd
 Twt0uEbDme0DnK6F8RQcH9kLqJB5SgbGCDlSGpVuoECK0Vodr/oE5MXkCjSORj4i1LKu
 LWGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTHThQSv+RYQtP1Y4de8aH/rq38EMnK01i1+nBT9tmLID4bPApqB3freATcnHXEmTvfCbPpV0=@lists.denx.de
X-Gm-Message-State: AOJu0Yylt415fph6KGbkH/FXiAciVBuErqeNc67J5CCzd/9NhQXn/z4j
 Ud6iy24+U3L6fBL9ZAZ4fhmuVJsCqT6/zVFk0VJOWaBEqXWFNXxy/wc5qSvdDGP3MhbLiGAdkHt
 MSeAgCkPiTnH+NgtS9rpAy1/QiaBa03guadLqog==
X-Gm-Gg: ASbGncuebjFIEMwfFe00I4A3IA6wJs1pFRqc+72Ni2Hbb9uo20jY8bTb9Yi+FRDu5Cc
 7Ly50224iBdkXYFvel0AQBAUCV1Q9J3vK0gdFnA==
X-Google-Smtp-Source: AGHT+IEL6Pmkc7EBgmn6mQ/f6oXNFxEVrDWFZuZKYm+Kz9OL+G/3kgC/xTCGtvLEnGHtTwq7aQTa45bYwrG3ucVeowg=
X-Received: by 2002:a05:6902:2610:b0:e4a:fc25:30cb with SMTP id
 3f1490d57ef6-e538c40c90amr43243573276.46.1736256693445; Tue, 07 Jan 2025
 05:31:33 -0800 (PST)
MIME-Version: 1.0
References: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
 <20250102181133.378867-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250102181133.378867-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 7 Jan 2025 15:30:57 +0200
X-Gm-Features: AbW1kvYGHIkFnE4nYB9_Hkp6U7TJQuRNB5eF_xQ34Vnb5oHE7l852QRoQIb2oeI
Message-ID: <CAC_iWjJhQQrNPyFDTAdo14X+x_CWer05+WVWu71xu_vxUb1iTw@mail.gmail.com>
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

On Thu, 2 Jan 2025 at 20:11, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The debug version of the UEFI shell requires a DXE services table to exist.
>
> Implement the table and let all DXE functions return EFI_UNSUPPORTED.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi_dxe.h          |  54 ++++++++++++
>  include/efi_loader.h       |   7 ++
>  lib/efi_loader/Kconfig     |   7 ++
>  lib/efi_loader/Makefile    |   1 +
>  lib/efi_loader/efi_dxe.c   | 176 +++++++++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_setup.c |   6 ++
>  6 files changed, 251 insertions(+)
>  create mode 100644 include/efi_dxe.h
>  create mode 100644 lib/efi_loader/efi_dxe.c
>
> diff --git a/include/efi_dxe.h b/include/efi_dxe.h
> new file mode 100644
> index 00000000000..5623189de0c
> --- /dev/null
> +++ b/include/efi_dxe.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *  DXE services table
> + *
> + *  Copyright (c) 2025 Heinrich Schuchardt
> + */
> +
> +#ifndef _EFI_DXE_H
> +#define _EFI_DXE_H 1
> +
> +#include <efi.h>
> +
> +/**
> + * define DXE_SERVICES_SIGNATURE - DXE services signature ('DXE_SERV')
> + */
> +#define DXE_SERVICES_SIGNATURE 0x565245535f455844
> +/**
> + * define DXE_SERVICES_REVISION - DXE services revision (1.8)
> + */
> +#define DXE_SERVICES_REVISION 0x00010050
> +
> +/**
> + * define EFI_DXE_SERVICES_TABLE_GUID - GUID of the EFI DXE services table
> + */
> +#define EFI_DXE_SERVICES_TABLE_GUID \
> +       EFI_GUID(0x5ad34ba, 0x6f02, 0x4214, \
> +                0x95, 0x2e, 0x4d, 0xa0, 0x39, 0x8e, 0x2b, 0xb9)
> +
> +struct efi_dxe_services {
> +       struct efi_table_hdr hdr;
> +
> +       efi_status_t (EFIAPI *add_memory_space)(void);
> +       efi_status_t (EFIAPI *allocate_memory_space)(void);
> +       efi_status_t (EFIAPI *free_memory_space)(void);
> +       efi_status_t (EFIAPI *remove_memory_space)(void);
> +       efi_status_t (EFIAPI *get_memory_space_descriptor)(void);
> +       efi_status_t (EFIAPI *set_memory_space_attributes)(void);
> +       efi_status_t (EFIAPI *get_memory_space_map)(void);
> +       efi_status_t (EFIAPI *add_io_space)(void);
> +       efi_status_t (EFIAPI *allocate_io_space)(void);
> +       efi_status_t (EFIAPI *free_io_space)(void);
> +       efi_status_t (EFIAPI *remove_io_space)(void);
> +       efi_status_t (EFIAPI *get_io_space_descriptor)(void);
> +       efi_status_t (EFIAPI *get_io_space_map)(void);
> +       efi_status_t (EFIAPI *dispatch)(void);
> +       efi_status_t (EFIAPI *schedule)(void);
> +       efi_status_t (EFIAPI *trust)(void);
> +       efi_status_t (EFIAPI *process_firmware_volume)(void);
> +       efi_status_t (EFIAPI *set_memory_space_capabilities)(void);
> +};
> +
> +extern efi_guid_t efi_dxe_services_table_guid;
> +
> +#endif /* _EFI_DXE_H */
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index c1258098217..d474866184f 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -663,6 +663,13 @@ efi_status_t efi_smbios_register(void);
>   */
>  efi_status_t efi_hob_list_register(void);
>
> +/**
> + * efi_dxe_services_register() - install DXE services table
> + *
> + * Return:     status code
> + */
> +efi_status_t efi_dxe_services_register(void);
> +
>  struct efi_simple_file_system_protocol *
>  efi_fs_from_path(struct efi_device_path *fp);
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index ec38a0ea352..ed3470508ff 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -384,6 +384,13 @@ config EFI_DT_FIXUP
>           The EFI device-tree fix-up protocol provides a function to let the
>           firmware apply fix-ups. This may be used by boot loaders.
>
> +config EFI_DXE
> +       bool 'DXE services table'
> +       default y
> +       help
> +         Install the DXE services table. The debug version of the UEFI shell
> +         requires it.
> +
>  config EFI_LOADER_HII
>         bool "HII protocols"
>         default y
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 195ed8667fe..4f250f21811 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -33,6 +33,7 @@ obj-y += efi_console.o
>  obj-y += efi_device_path.o
>  obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_device_path_to_text.o
>  obj-$(CONFIG_EFI_DEVICE_PATH_UTIL) += efi_device_path_utilities.o
> +obj-$(CONFIG_EFI_DXE) += efi_dxe.o
>  obj-y += efi_dt_fixup.o
>  obj-y += efi_fdt.o
>  obj-y += efi_file.o
> diff --git a/lib/efi_loader/efi_dxe.c b/lib/efi_loader/efi_dxe.c
> new file mode 100644
> index 00000000000..f8920575b0c
> --- /dev/null
> +++ b/lib/efi_loader/efi_dxe.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  DXE services table
> + *
> + *  Copyright (c) 2025 Heinrich Schuchardt
> + */
> +
> +#include <efi_dxe.h>
> +#include <efi_loader.h>
> +
> +efi_guid_t efi_dxe_services_table_guid = EFI_DXE_SERVICES_TABLE_GUID;
> +
> +static efi_status_t EFIAPI add_memory_space(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static efi_status_t EFIAPI allocate_memory_space(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static efi_status_t EFIAPI free_memory_space(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static efi_status_t EFIAPI remove_memory_space(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static efi_status_t EFIAPI get_memory_space_descriptor(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static efi_status_t EFIAPI set_memory_space_attributes(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static efi_status_t EFIAPI get_memory_space_map(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static efi_status_t EFIAPI add_io_space(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static efi_status_t EFIAPI allocate_io_space(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static efi_status_t EFIAPI free_io_space(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static efi_status_t EFIAPI remove_io_space(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static efi_status_t EFIAPI get_io_space_descriptor(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static efi_status_t EFIAPI get_io_space_map(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static efi_status_t EFIAPI dispatch(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static efi_status_t EFIAPI schedule(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static efi_status_t EFIAPI trust(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static efi_status_t EFIAPI process_firmware_volume(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static efi_status_t EFIAPI set_memory_space_capabilities(void)
> +{
> +       EFI_ENTRY();
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +static struct efi_dxe_services efi_dxe_services = {
> +       .hdr = {
> +               .signature = DXE_SERVICES_SIGNATURE,
> +               .revision = DXE_SERVICES_REVISION,
> +               .headersize = sizeof(struct efi_dxe_services),
> +       },
> +       .add_memory_space = add_memory_space,
> +       .allocate_memory_space = allocate_memory_space,
> +       .free_memory_space = free_memory_space,
> +       .remove_memory_space = remove_memory_space,
> +       .get_memory_space_descriptor = get_memory_space_descriptor,
> +       .set_memory_space_attributes = set_memory_space_attributes,
> +       .get_memory_space_map = get_memory_space_map,
> +       .add_io_space = add_io_space,
> +       .allocate_io_space = allocate_io_space,
> +       .free_io_space = free_io_space,
> +       .remove_io_space = remove_io_space,
> +       .get_io_space_descriptor = get_io_space_descriptor,
> +       .get_io_space_map = get_io_space_map,
> +       .dispatch = dispatch,
> +       .schedule = schedule,
> +       .trust = trust,
> +       .process_firmware_volume = process_firmware_volume,
> +       .set_memory_space_capabilities = set_memory_space_capabilities,

Do we plan on ever implementing those? If not we could use a single
function returning EFI_UNSUPPORTED instead of all of them for code
size reasons

Cheers
/Ilias
> +};
> +
> +efi_status_t efi_dxe_services_register(void)
> +{
> +       struct efi_dxe_services *dxe;
> +
> +       dxe = efi_alloc(sizeof(struct efi_dxe_services));
> +       if (!dxe)
> +               return EFI_OUT_OF_RESOURCES;
> +
> +       memcpy(dxe, &efi_dxe_services, sizeof(struct efi_dxe_services));
> +
> +       return efi_install_configuration_table(&efi_dxe_services_table_guid, dxe);
> +}
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index 393b690c3ee..796da5d5678 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -260,6 +260,12 @@ efi_status_t efi_init_obj_list(void)
>         if (ret != EFI_SUCCESS)
>                 goto out;
>
> +       if (IS_ENABLED(CONFIG_EFI_DXE)) {
> +               ret = efi_dxe_services_register();
> +               if (ret != EFI_SUCCESS)
> +                       goto out;
> +       }
> +
>         if (IS_ENABLED(CONFIG_EFI_ECPT)) {
>                 ret = efi_ecpt_register();
>                 if (ret != EFI_SUCCESS)
> --
> 2.47.1
>
