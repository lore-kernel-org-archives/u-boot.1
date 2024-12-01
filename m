Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F00D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0129E880A5;
	Sun,  1 Dec 2024 17:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CtGao2gP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 709DE89637; Sun,  1 Dec 2024 17:12:55 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 663C182BA7
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 17:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa53ebdf3caso667602366b.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 08:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733069568; x=1733674368; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k5FECazy5wYgNGw8gIN7VqU1r+KfvN94S48QNTA3JeQ=;
 b=CtGao2gPskaTY8IMZkBZ0MPwVqGlPdn2GlfNwGBR3aXIin0R6RKN2/jFNa/RsD3k5Z
 UMb4bMYxLpk0j4k7NpwYu4CFo5491rA4+HXy6LtK6CRkVB6s7L4NQ6ye9xlbklrcJpgU
 Fn1TMIFR7MX8HzaKddpLNEjOvNklOO2+KvnPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069568; x=1733674368;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k5FECazy5wYgNGw8gIN7VqU1r+KfvN94S48QNTA3JeQ=;
 b=gfwa1F9R415fLWhKbiQCwdNatvKAvh9oOaAUWCQFY6n8hslTFLx5wTol+ffhWEFJIj
 ziq7maL8STVhvNuR4tId9uORb5zikxx5/K0k8c/3KYlQyo9t3n/Jd4BnBP5pcoDNax8x
 PNDE24/4Y0L2KADt1AF0OeZB4OJxr6cWZ9adEW9hjt0MwVLaB9QFWE8L2GmBxXHwsQyD
 cVU0THIbN/X3CkyIh3wGdnSdghFE/33+h16SThmhSl5ELUaGRRENR2/HkaWdqd6U4hoN
 iGYenQdwEp7fgNjWhsTaP5TpmBcxKzgotjYqrBNTbEEaCBIqN3slRLr3ceD8YRquZ0QK
 tB9A==
X-Gm-Message-State: AOJu0Yw7qwZkwD0nVIGT3p6qGvue20XlGZNg37Ki4fkKrOgt5eamOEgU
 mZIpwNF0TgGK9dyAKag43fMHmNzdvVHNQBjMjpx94FXORmMUUbZlKKbsIhjsusBBMy0g3eGMqyo
 I/PqZuQYNp6qsceq+WplI2rFrEgb0pbbCXbbb
X-Gm-Gg: ASbGnctrv1UyLgv9iZkOHJgfMRX63T/ySeECF9m/vRIOg6pPbhlRo0HdSPVK+b3jxNQ
 5/TUAslpQPRRAXHb4f64VeAOPNC0naw==
X-Google-Smtp-Source: AGHT+IG0p19amCT6VFPzX/mT7rz0FsZY8qtiyZn7rNwN+FhOZCgQhq08/tCp83dlfRMWyrcxzE+y1gAMmZkYg6y7z5g=
X-Received: by 2002:a17:907:7742:b0:aa5:46d3:4d88 with SMTP id
 a640c23a62f3a-aa580f1b949mr1864817766b.15.1733069567757; Sun, 01 Dec 2024
 08:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-3-mjg59@srcf.ucam.org>
In-Reply-To: <20241123195616.305687-3-mjg59@srcf.ucam.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Dec 2024 09:12:35 -0700
Message-ID: <CAFLszTis_2t=hPC9aVQKMtoy5=OyEDQJDS17hqeJG=U3Qdn1hw@mail.gmail.com>
Subject: Re: [PATCH 02/10] Add part_find command
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: u-boot@lists.denx.de, Matthew Garrett <mgarrett@aurora.tech>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>
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

Hi Matthew,

On Sat, 23 Nov 2024 at 12:56, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> From: Matthew Garrett <mgarrett@aurora.tech>
>
> part_find takes a GPT GUID and searches for a partition that matches
> that. It then sets the target_part environment variable to the media
> type, device number and partition number that matched, allowing
> $target_part to be passed directly to bootm and similar commands.
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>  cmd/Kconfig     |  10 ++++
>  cmd/Makefile    |   1 +
>  cmd/part_find.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 167 insertions(+)
>  create mode 100644 cmd/part_find.c

Reviewed-by: Simon Glass <sjg@chromium.org>

Nits below. This needs an update to doc/usage/cmd/part.rst and a test.
There is a ChromeOS bootimage used in the bootflow tests which might
be helpful here, as it uses GPT.

>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 1d7ddb4ed36..ee85928ca21 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1529,6 +1529,16 @@ config CMD_PART
>           Read and display information about the partition table on
>           various media.
>
> +config CMD_PART_FIND
> +       bool "part_find"
> +       depends on PARTITIONS
> +       select HAVE_BLOCK_DEVICE
> +       select PARTITION_UUIDS
> +       select PARTITION_TYPE_GUID
> +       help
> +         Find a partition with a given type GUID and set the target_part
> +         environment variable if located.
> +
>  config CMD_PCI
>         bool "pci - Access PCI devices"
>         help
> diff --git a/cmd/Makefile b/cmd/Makefile
> index d1f369deec0..16fd8dcd723 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -137,6 +137,7 @@ obj-$(CONFIG_CMD_NVEDIT_EFI) += nvedit_efi.o
>  obj-$(CONFIG_CMD_ONENAND) += onenand.o
>  obj-$(CONFIG_CMD_OSD) += osd.o
>  obj-$(CONFIG_CMD_PART) += part.o
> +obj-$(CONFIG_CMD_PART_FIND) += part_find.o
>  obj-$(CONFIG_CMD_PCAP) += pcap.o
>  ifdef CONFIG_PCI
>  obj-$(CONFIG_CMD_PCI) += pci.o
> diff --git a/cmd/part_find.c b/cmd/part_find.c
> new file mode 100644
> index 00000000000..8c071d3c374
> --- /dev/null
> +++ b/cmd/part_find.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Aurora Innovation, Inc. Copyright 2022.
> + *
> + */
> +
> +#include <blk.h>
> +#include <config.h>
> +#include <command.h>
> +#include <dm.h>
> +#include <env.h>
> +#include <part.h>
> +#if defined(CONFIG_EFI) || defined(CONFIG_EFI_APP)

Header files should not be behind #ifdef

> +#include <efi.h>
> +#include <efi_api.h>
> +
> +static bool partition_is_on_device(const struct efi_device_path *device,
> +                                  const struct efi_device_path *part,
> +                                  __u32 *part_no)

u32

> +{
> +       size_t d_len, p_len;
> +       const struct efi_device_path *p, *d;
> +
> +       for (d = device; d->type != DEVICE_PATH_TYPE_END; d = (void *)d + d->length) {
> +       }
> +
> +       d_len = (void *)d - (void *)device;
> +
> +       for (p = part; p->type != DEVICE_PATH_TYPE_END &&
> +                    !(p->type == DEVICE_PATH_TYPE_MEDIA_DEVICE &&
> +                      p->sub_type == DEVICE_PATH_SUB_TYPE_HARD_DRIVE_PATH);
> +            p = (void *)p + p->length) {
> +       }
> +
> +       if (p->type != DEVICE_PATH_TYPE_MEDIA_DEVICE ||
> +           p->sub_type != DEVICE_PATH_SUB_TYPE_HARD_DRIVE_PATH) {
> +               // Not a partition.
> +               return false;
> +       }
> +
> +       p_len = (void *)p - (void *)part;
> +
> +       if (p_len == d_len && !memcmp(device, part, p_len)) {
> +               if (part_no)
> +                       *part_no = ((__u32 *)p)[1];
> +               return true;
> +       }
> +       return false;
> +}
> +#endif
> +
> +static int part_find(int argc, char *const argv[])
> +{
> +#if defined(CONFIG_EFI) || defined(CONFIG_EFI_APP)
> +       efi_guid_t efi_devpath_guid = EFI_DEVICE_PATH_PROTOCOL_GUID;
> +       struct efi_device_path *loaded_image_path = NULL;
> +       struct efi_boot_services *boot = efi_get_boot();
> +       struct efi_priv *priv = efi_get_priv();
> +       bool part_self = false;
> +#endif
> +       struct driver *d = ll_entry_start(struct driver, driver);
> +       const int n_ents = ll_entry_count(struct driver, driver);
> +       struct disk_partition info;
> +       struct blk_desc *desc;
> +       struct driver *entry;
> +       struct udevice *udev;
> +       struct uclass *uc;
> +       int ret;
> +
> +       if (argc != 2)
> +               return CMD_RET_USAGE;
> +
> +#if defined(CONFIG_EFI) || defined (CONFIG_EFI_APP)

Please use if (IS_ENABLED(CONFIG_EFI) || ...

We try to avoid #ifdef in C code

> +       part_self = !strncmp(argv[1], "self", 6);
> +       if (part_self) {
> +               ret = boot->handle_protocol(priv->loaded_image->device_handle,
> +                                       &efi_devpath_guid,
> +                                       (void **)&loaded_image_path);
> +               if (ret)
> +                       log_warning("failed to get device path for loaded image (ret=%d)", ret);
> +       }
> +#endif
> +
> +       ret = uclass_get(UCLASS_BLK, &uc);
> +       if (ret) {
> +               puts("Could not get BLK uclass.\n");
> +               return CMD_RET_FAILURE;
> +       }
> +       for (entry = d; entry < d + n_ents; entry++) {
> +               if (entry->id != UCLASS_BLK)
> +                       continue;
> +               uclass_foreach_dev(udev, uc) {
> +                       int i;
> +
> +                       if (udev->driver != entry)
> +                               continue;

You should be able to do:

struct udevice *dev;

blk_foreach(BLKF_BOTH, dev) {

> +                       desc = dev_get_uclass_plat(udev);
> +#if defined(CONFIG_EFI) || defined(CONFIG_EFI_APP)

if() again

> +                       if (part_self) {
> +                               if (desc->if_type == IF_TYPE_EFI_MEDIA) {
> +                                       struct efi_media_plat *plat =
> +                                               dev_get_plat(udev->parent);
> +                                       __u32 loader_part_no;
> +
> +                                       if (partition_is_on_device(plat->device_path,
> +                                                                  loaded_image_path,
> +                                                                  &loader_part_no)) {
> +                                               char env[256];
> +
> +                                               ret = snprintf(env, sizeof(env), "%s %d:%d", blk_get_if_type_name(desc->if_type), desc->devnum, loader_part_no);

line too long

Perhaps put this whole block in a function?

> +                                               if (ret < 0 || ret == sizeof(env))
> +                                                       return CMD_RET_FAILURE;
> +                                               if (env_set("target_part", env))
> +                                                       return CMD_RET_FAILURE;
> +                                               return CMD_RET_SUCCESS;

We normally write this as 'return 0'

> +                                       }
> +                               }
> +                       } else {
> +#endif
> +                               for (i = 1; i <= MAX_SEARCH_PARTITIONS; i++) {
> +                                       ret = part_get_info(desc, i, &info);
> +                                       if (ret)
> +                                               break;
> +                                       if (strcasecmp(argv[1], info.type_guid) == 0) {
> +                                               char env[256];
> +                                               ret = snprintf(env, sizeof(env), "%s %d:%d", blk_get_if_type_name(desc->if_type), desc->devnum, i);
> +                                               if (ret < 0 || ret == sizeof(env))
> +                                                       return CMD_RET_FAILURE;
> +                                               env_set("target_part", env);
> +                                               debug("Setting target_part to %s\n", env);
> +                                               return CMD_RET_SUCCESS;
> +                                       }
> +                               }
> +#if defined(CONFIG_EFI) || defined(CONFIG_EFI_APP)
> +                       }
> +#endif
> +               }
> +       }
> +
> +       return CMD_RET_FAILURE;
> +}
> +
> +static int do_part_find(struct cmd_tbl *cmdtp, int flag, int argc,
> +                       char *const argv[])
> +{
> +       return part_find(argc, argv);
> +}
> +
> +U_BOOT_CMD(
> +       part_find, 2, 0, do_part_find, "Find a partition",
> +       "<guid>\n"
> +       "- Examine the list of known partitions for one that has a type\n"
> +       "  GUID that matches 'guid', expressed in the standard text format.\n"
> +       "  If successful, the target_part environment variable will be set\n"
> +       "  to the corresponding 'interface dev:part'.\n"
> +);
> --
> 2.47.0
>

Regards,
Simon
