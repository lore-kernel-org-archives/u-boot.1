Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7E2C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8044E885D4;
	Mon, 10 Jun 2024 17:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jOl132Rg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 045E1885CF; Mon, 10 Jun 2024 17:16:04 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04953885A5
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 17:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4217f072531so1999565e9.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718032560; x=1718637360; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWMlOX5Ro+ACiaw7jT4BA6kDrG7u+vqt5UWK9wYKL5Q=;
 b=jOl132RggCjqCcS0+N6Q2oB5SY0PYfC//xtywna4r+3q3cUCrgtStKHwYQ1zOFG5Dl
 je9Je0ose7x13ajecpAVASc3nxEm2pEFTGy/9dVYJlRcEj2Dq5ByJMWpQhNBiRsEY3DK
 jYsIFF7TzLzkDlurUoh6QoFz3nUKX0Q0j4WxfQ+Z2RfvIRFiSAWjpQl4cqq/MFcN944/
 2gGDET/Vm3ZZEzbKi7pwJgMoHNEnknHb7raWw3l2pkIRLbkCHrQKNE/1t60VIBxf8bkm
 A5VToDWrHRr3nZp3SKbYFWbuLqDf3BSItg8AC6wTAz4g2c0eH2IfUWNLDZHOFG1Y6SqN
 drtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718032560; x=1718637360;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWMlOX5Ro+ACiaw7jT4BA6kDrG7u+vqt5UWK9wYKL5Q=;
 b=IbjaWVjxQYo7YSYUZH3/1NKxxNGHyf3npOWCKCQYK8DE17TEFqv+Q7ZNaCOhm2wK4D
 YVEifOAbojqVz/8WA7gV/qym/G/M2MyEGHOZJwLTPFvML+IdB70EI+NSBhFtpCUPW22P
 SDRoqvCKtngV9i+ajsuJ9PAPZ2H3Yd+Mpt4NaA/Q/xDuzIt0rX+ju/wCvewQtijCNHRx
 Ez6jbGTShQFZBpmKL3EptEF8wl2ooMq7FzKKPO8Qx87+CANGzjx5u66fkAqD7rcfMrdi
 qNsccy5C/uqQ6s9jdbr/hMFcko+y7vm4Bx9/JAfUWuc+IcIGKlCsh7S78iHLG0FMHIN7
 SZNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9YQpjiOI6i0tuGu6ElSvrh7+ZUO7oe1i2rSoVNdPdHfAIM5DgEFzPZIsZbjP4okRsvxW77y1T4w8OdN4QpoKSkbmZEg==
X-Gm-Message-State: AOJu0Ywo+HQ/WImCt1aG1pO0z9tziBbqibVyka3LlqGbF80zKJRg8i8V
 Nh6sOwxrBPF3ti1vd6tjATDP6prX2CyLaQ+PvmhoCFioTmUCDkS1BdwjQM+ZJF+yruzGVmpBZv4
 UEOzKYxK09nniYzFmVNHHG9YHhTE=
X-Google-Smtp-Source: AGHT+IGtmwoJweCxfoaIxm1ypSmugG5+7ykH58rgEGJVCVqriYnV1rUqohP7uirXz+4HOk1OgK83jyrioQ1XWTc/IB4=
X-Received: by 2002:a5d:5887:0:b0:35f:247e:fbce with SMTP id
 ffacd0b85a97d-35f247eff08mr2007347f8f.1.1718032560148; Mon, 10 Jun 2024
 08:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com>
 <20240606-bootmeth-android-v1-5-0c69d4457cc5@baylibre.com>
In-Reply-To: <20240606-bootmeth-android-v1-5-0c69d4457cc5@baylibre.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 10 Jun 2024 17:15:48 +0200
Message-ID: <CAByghJbj3T118egMHs3pGMVGkLho5H42qcRBtVJpBNrSSP512g@mail.gmail.com>
Subject: Re: [PATCH 5/6] bootstd: Add a bootmeth for Android
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Mattijs,

On Thu, Jun 6, 2024 at 2:24=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Android boot flow is a bit different than a regular Linux distro.
> Android relies on multiple partitions in order to boot.
>
> A typical boot flow would be:
> 1. Parse the Bootloader Control Block (BCB, misc partition)
> 2. If BCB requested bootonce-bootloader, start fastboot and wait.
> 3. If BCB requested recovery or normal android, run the following:
> 3.a. Get slot (A/B) from BCB
> 3.b. Run AVB (Android Verified Boot) on boot partitions
> 3.c. Load boot and vendor_boot partitions
> 3.d. Load device-tree, ramdisk and boot
>
> The AOSP documentation has more details at [1], [2], [3]
>
> This has been implemented via complex boot scripts such as [4].
> However, these boot script are neither very maintainable nor generic.
> Moreover, DISTRO_DEFAULTS is being deprecated [5].
>
> Add a generic Android bootflow implementation for bootstd.
> For this initial version, only boot image v4 is supported.
>
> [1] https://source.android.com/docs/core/architecture/bootloader
> [2] https://source.android.com/docs/core/architecture/partitions
> [3] https://source.android.com/docs/core/architecture/partitions/generic-=
boot
> [4] https://source.denx.de/u-boot/u-boot/-/blob/master/include/configs/me=
son64_android.h
> [5] https://lore.kernel.org/r/all/20230914165615.1058529-17-sjg@chromium.=
org/
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  MAINTAINERS             |   7 +
>  boot/Kconfig            |  14 ++
>  boot/Makefile           |   2 +
>  boot/bootmeth_android.c | 522 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  boot/bootmeth_android.h |  27 +++
>  doc/develop/bootstd.rst |   6 +
>  6 files changed, 578 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66783d636e3d..6d2b87720565 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -939,6 +939,13 @@ F: include/bootstd.h
>  F:     net/eth_bootdevice.c
>  F:     test/boot/
>
> +BOOTMETH_ANDROID
> +M:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
> +S:     Maintained
> +T:     git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
> +F:     boot/bootmeth_android.c
> +F:     boot/bootmeth_android.h
> +
>  BTRFS
>  M:     Marek Beh=C3=BAn <kabel@kernel.org>
>  R:     Qu Wenruo <wqu@suse.com>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 6f3096c15a6f..5fa6f3b8315d 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -494,6 +494,20 @@ config BOOTMETH_GLOBAL
>           EFI bootmgr, since they take full control over which bootdevs a=
re
>           selected to boot.
>
> +config BOOTMETH_ANDROID
> +       bool "Bootdev support for Android"
> +       depends on X86 || ARM || SANDBOX
> +       select ANDROID_AB
> +       select ANDROID_BOOT_IMAGE
> +       select CMD_BCB
> +       select PARTITION_TYPE_GUID
> +       select PARTITION_UUIDS
> +       help
> +         Enables support for booting Android using bootdevs. Android req=
uires
> +         multiple partitions (misc, boot, vbmeta, ...) in storage for bo=
oting.
> +
> +         Note that only MMC bootdevs are supported at present.
> +
>  config BOOTMETH_CROS
>         bool "Bootdev support for Chromium OS"
>         depends on X86 || ARM || SANDBOX
> diff --git a/boot/Makefile b/boot/Makefile
> index 84ccfeaecec4..75d1cd46fabf 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -66,3 +66,5 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_VBE_REQUEST) +=3D vbe_=
request.o
>  obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_VBE_SIMPLE) +=3D vbe_simple.o
>  obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_VBE_SIMPLE_FW) +=3D vbe_simple_fw.o
>  obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_VBE_SIMPLE_OS) +=3D vbe_simple_os.o
> +
> +obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_ANDROID) +=3D bootmeth_android.o
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> new file mode 100644
> index 000000000000..26d548d2fd6e
> --- /dev/null
> +++ b/boot/bootmeth_android.c
> @@ -0,0 +1,522 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Bootmethod for Android
> + *
> + * Copyright (C) 2024 BayLibre, SAS
> + * Written by Mattijs Korpershoek <mkorpershoek@baylibre.com>
> + */
> +#define LOG_CATEGORY UCLASS_BOOTSTD
> +
> +#include <android_ab.h>
> +#include <android_image.h>
> +#if CONFIG_IS_ENABLED(AVB_VERIFY)
> +#include <avb_verify.h>
> +#endif
> +#include <bcb.h>
> +#include <blk.h>
> +#include <bootflow.h>
> +#include <bootm.h>
> +#include <bootmeth.h>
> +#include <dm.h>
> +#include <image.h>
> +#include <malloc.h>
> +#include <mapmem.h>
> +#include <part.h>
> +#include "bootmeth_android.h"
> +
> +#define BCB_FIELD_COMMAND_SZ 32
> +#define BCB_PART_NAME "misc"
> +#define BOOT_PART_NAME "boot"
> +#define VENDOR_BOOT_PART_NAME "vendor_boot"
> +
> +/**
> + * struct android_priv - Private data
> + *
> + * This is read from the disk and recorded for use when the full Android
> + * kernel must be loaded and booted
> + */
> +struct android_priv {
> +       int boot_mode;
> +       char slot[2];
> +       u32 header_version;
> +};
> +
> +static int android_check(struct udevice *dev, struct bootflow_iter *iter=
)
> +{
> +       /* This only works on mmc devices */
> +       if (bootflow_iter_check_mmc(iter))
> +               return log_msg_ret("mmc", -ENOTSUPP);
> +
> +       /* This only works on whole devices, as multiple
> +        * partitions are needed to boot Android
> +        */
Please use Linux kernel coding style for long comments [1].
Same in all occurrences below

[1] https://www.kernel.org/doc/html/latest/process/coding-style.html#commen=
ting
> +       if (iter->part !=3D 0)
> +               return log_msg_ret("mmc part", -ENOTSUPP);
> +
> +       return 0;
> +}
> +
> +static int scan_boot_part(struct udevice *blk, struct android_priv *priv=
)
> +{
> +       struct blk_desc *desc =3D dev_get_uclass_plat(blk);
> +       struct disk_partition partition;
> +       char partname[PART_NAME_LEN];
> +       ulong num_blks, bufsz;
> +       char *buf;
> +       int ret;
> +
> +       sprintf(partname, BOOT_PART_NAME "_%s", priv->slot);
> +       ret =3D part_get_info_by_name(desc, partname, &partition);
> +       if (ret < 0)
> +               return log_msg_ret("part info", ret);
> +
> +       num_blks =3D DIV_ROUND_UP(sizeof(struct andr_boot_img_hdr_v0), de=
sc->blksz);
> +       bufsz =3D num_blks * desc->blksz;
> +       buf =3D malloc(bufsz);
> +       if (!buf)
> +               return log_msg_ret("buf", -ENOMEM);
> +
> +       ret =3D blk_read(blk, partition.start, num_blks, buf);
> +       if (ret !=3D num_blks) {
> +               free(buf);
> +               return log_msg_ret("part read", -EIO);
> +       }
> +
> +       if (!is_android_boot_image_header(buf)) {
> +               free(buf);
> +               return log_msg_ret("header", -ENOENT);
> +       }
> +
> +       priv->header_version =3D android_image_get_version(buf);
> +
> +       return 0;
Shouldn't we free(buf) also here?

> +}
> +
> +static int scan_vendor_boot_part(struct udevice *blk, const char slot[2]=
)
> +{
> +       struct blk_desc *desc =3D dev_get_uclass_plat(blk);
> +       struct disk_partition partition;
> +       char partname[PART_NAME_LEN];
> +       ulong num_blks, bufsz;
> +       char *buf;
> +       int ret;
> +
> +       sprintf(partname, VENDOR_BOOT_PART_NAME "_%s", slot);
> +       ret =3D part_get_info_by_name(desc, partname, &partition);
> +       if (ret < 0)
> +               return log_msg_ret("part info", ret);
> +
> +       num_blks =3D DIV_ROUND_UP(sizeof(struct andr_vnd_boot_img_hdr), d=
esc->blksz);
> +       bufsz =3D num_blks * desc->blksz;
> +       buf =3D malloc(bufsz);
> +       if (!buf)
> +               return log_msg_ret("buf", -ENOMEM);
> +
> +       ret =3D blk_read(blk, partition.start, num_blks, buf);
> +       if (ret !=3D num_blks) {
> +               free(buf);
> +               return log_msg_ret("part read", -EIO);
> +       }
> +
> +       if (!is_android_vendor_boot_image_header(buf)) {
> +               free(buf);
> +               return log_msg_ret("header", -ENOENT);
> +       }
> +
> +       return 0;
free(buf)?

> +}
> +
> +static int android_read_slot_from_bcb(struct bootflow *bflow, bool decre=
ment)
> +{
> +       struct blk_desc *desc =3D dev_get_uclass_plat(bflow->blk);
> +       struct android_priv *priv =3D bflow->bootmeth_priv;
> +       struct disk_partition misc;
> +       char slot_suffix[3];
> +       int ret;
> +
> +       ret =3D part_get_info_by_name(desc, BCB_PART_NAME, &misc);
> +       if (ret < 0)
> +               return log_msg_ret("part", ret);
> +
> +       ret =3D ab_select_slot(desc, &misc, decrement);
> +       if (ret < 0)
> +               return log_msg_ret("slot", ret);
> +
> +       priv->slot[0] =3D BOOT_SLOT_NAME(ret);
> +       priv->slot[1] =3D '\0';
> +
> +       sprintf(slot_suffix, "_%s", priv->slot);
> +       ret =3D bootflow_cmdline_set_arg(bflow, "androidboot.slot_suffix"=
,
> +                                      slot_suffix, false);
> +       if (ret < 0)
> +               return log_msg_ret("slot", ret);
> +
> +       return 0;
> +}
> +
> +static int configure_serialno(struct bootflow *bflow)
> +{
> +       char *serialno =3D env_get("serial#");
> +
> +       if (!serialno)
> +               return log_msg_ret("serial", -ENOENT);
> +
> +       return bootflow_cmdline_set_arg(bflow, "androidboot.serialno", se=
rialno, false);
> +}
> +
> +static int android_read_bootflow(struct udevice *dev, struct bootflow *b=
flow)
> +{
> +       struct blk_desc *desc =3D dev_get_uclass_plat(bflow->blk);
> +       struct disk_partition misc;
> +       struct android_priv *priv;
> +       char command[BCB_FIELD_COMMAND_SZ];
> +       int ret;
> +
> +       bflow->state =3D BOOTFLOWST_MEDIA;
> +
> +       /* bcb_find_partition_and_load() will print errors to stdout
> +        * if BCB_PART_NAME is not found. To avoid that, check if the
> +        * partition exists first.
> +        */
> +       ret =3D part_get_info_by_name(desc, BCB_PART_NAME, &misc);
> +       if (ret < 0)
> +               return log_msg_ret("part", ret);
> +
> +       ret =3D bcb_find_partition_and_load("mmc", desc->devnum, BCB_PART=
_NAME);
> +       if (ret < 0)
> +               return log_msg_ret("bcb load", ret);
> +
> +       ret =3D bcb_get(BCB_FIELD_COMMAND, command, sizeof(command));
> +       if (ret < 0)
> +               return log_msg_ret("bcb read", ret);
> +
> +       priv =3D malloc(sizeof(struct android_priv));
> +       if (!priv)
> +               return log_msg_ret("buf", -ENOMEM);
> +
> +       bflow->bootmeth_priv =3D priv;
Probably we should do that just before successfully returning from the func=
tion,
otherwise we will end up with a dangling pointer.

> +       if (!strcmp("bootonce-bootloader", command)) {
> +               priv->boot_mode =3D ANDROID_BOOT_MODE_BOOTLOADER;
> +               bflow->os_name =3D strdup("Android (bootloader)");
> +       } else if (!strcmp("boot-fastboot", command)) {
> +               priv->boot_mode =3D ANDROID_BOOT_MODE_RECOVERY;
> +               bflow->os_name =3D strdup("Android (fastbootd)");
> +       } else if (!strcmp("boot-recovery", command)) {
> +               priv->boot_mode =3D ANDROID_BOOT_MODE_RECOVERY;
> +               bflow->os_name =3D strdup("Android (recovery)");
> +       } else {
> +               priv->boot_mode =3D ANDROID_BOOT_MODE_NORMAL;
> +               bflow->os_name =3D strdup("Android");
> +       }
> +       if (!bflow->os_name)
> +               return log_msg_ret("os", -ENOMEM);
> +
> +       if (priv->boot_mode =3D=3D ANDROID_BOOT_MODE_BOOTLOADER) {
> +               /* Clear BCB */
> +               memset(command, 0, sizeof(command));
> +               ret =3D bcb_set(BCB_FIELD_COMMAND, command);
> +               if (ret < 0) {
> +                       free(priv);
> +                       return log_msg_ret("bcb set", ret);
> +               }
> +               ret =3D bcb_store();
> +               if (ret < 0) {
> +                       free(priv);

> +                       return log_msg_ret("bcb store", ret);
> +               }
> +
is free(bflow->bootmeth_priv) handled in functions that call
android_read_bootflow() ?

> +               bflow->state =3D BOOTFLOWST_READY;
> +               return 0;
> +       }
> +
> +       /* For recovery and normal boot, we need to scan the partitions *=
/
> +       ret =3D android_read_slot_from_bcb(bflow, false);
> +       if (ret < 0) {
> +               free(priv);
> +               return log_msg_ret("read slot", ret);
> +       }
> +
> +       ret =3D scan_boot_part(bflow->blk, priv);
> +       if (ret < 0) {
> +               printf("- scan boot failed: err=3D%d\n", ret);
> +               free(priv);
> +               return log_msg_ret("scan boot", ret);
> +       }
> +
> +       if (priv->header_version !=3D 4) {
> +               printf("- Only boot.img v4 is supported\n");
> +               free(priv);
> +               return log_msg_ret("version", -EINVAL);
> +       }
> +
> +       ret =3D scan_vendor_boot_part(bflow->blk, priv->slot);
> +       if (ret < 0) {
> +               printf("- scan vendor_boot failed: err=3D%d\n", ret);
> +               free(priv);
> +               return log_msg_ret("scan vendor_boot", ret);
> +       }
> +
> +       /* Ignoring return code: setting serial number is not mandatory f=
or booting */
> +       configure_serialno(bflow);
> +
> +       if (priv->boot_mode =3D=3D ANDROID_BOOT_MODE_NORMAL) {
> +               ret =3D bootflow_cmdline_set_arg(bflow, "androidboot.forc=
e_normal_boot", "1", false);
> +               if (ret < 0) {
> +                       free(priv);
> +                       return log_msg_ret("normal_boot", ret);
> +               }
> +       }
> +
> +       bflow->state =3D BOOTFLOWST_READY;
> +
> +       return 0;
> +}
> +
> +static int android_read_file(struct udevice *dev, struct bootflow *bflow=
,
> +                            const char *file_path, ulong addr, ulong *si=
zep)
> +{
> +       /* Reading individual files is not supported since we only
> +        * operate on whole mmc devices (because we require multiple part=
itions)
> +        */
> +       return log_msg_ret("Unsupported", -ENOSYS);
> +}
> +
> +static int read_slotted_partition(struct blk_desc *desc, const char *con=
st name,
> +                                 const char slot[2], ulong addr)
> +{
> +       struct disk_partition partition;
> +       char partname[PART_NAME_LEN];
> +       int ret;
> +       u32 n;
> +
> +       /* Ensure name fits in partname it should be: <name>_<slot>\0 */
> +       if (strlen(name) > (PART_NAME_LEN - 2 - 1))
> +               return log_msg_ret("name too long", -EINVAL);
> +
> +       sprintf(partname, "%s_%s", name, slot);
> +       ret =3D part_get_info_by_name(desc, partname, &partition);
> +       if (ret < 0)
> +               return log_msg_ret("part", ret);
> +
> +       n =3D blk_dread(desc, partition.start, partition.size, map_sysmem=
(addr, 0));
> +       if (n < partition.size)
> +               return log_msg_ret("part read", -EIO);
> +
> +       return 0;
> +}
> +
> +#if CONFIG_IS_ENABLED(AVB_VERIFY)
> +static int avb_append_commandline_arg(struct bootflow *bflow, char *arg)
> +{
> +       char *key =3D strsep(&arg, "=3D");
> +       char *value =3D arg;
> +       int ret;
> +
> +       ret =3D bootflow_cmdline_set_arg(bflow, key, value, false);
> +       if (ret < 0)
> +               return log_msg_ret("avb cmdline", ret);
> +
> +       return 0;
> +}
> +
> +static int avb_append_commandline(struct bootflow *bflow, char *cmdline)
> +{
> +       char *arg =3D strsep(&cmdline, " ");
> +       int ret;
> +
> +       while (arg) {
> +               ret =3D avb_append_commandline_arg(bflow, arg);
> +               if (ret < 0)
> +                       return ret;
> +
> +               arg =3D strsep(&cmdline, " ");
> +       }
> +
> +       return 0;
> +}
> +
> +static int run_avb_verification(struct bootflow *bflow)
> +{
> +       struct blk_desc *desc =3D dev_get_uclass_plat(bflow->blk);
> +       struct android_priv *priv =3D bflow->bootmeth_priv;
> +       const char * const requested_partitions[] =3D {"boot", "vendor_bo=
ot"};
> +       struct AvbOps *avb_ops;
> +       AvbSlotVerifyResult result;
> +       AvbSlotVerifyData *out_data;
> +       enum avb_boot_state boot_state;
> +       char *extra_args;
> +       char slot_suffix[3];
> +       bool unlocked =3D false;
> +       int ret;
> +
> +       avb_ops =3D avb_ops_alloc(desc->devnum);
> +       if (!avb_ops)
> +               return log_msg_ret("avb ops", -ENOMEM);.
> +
> +       sprintf(slot_suffix, "_%s", priv->slot);
> +
> +       ret =3D avb_ops->read_is_device_unlocked(avb_ops, &unlocked);
> +       if (ret !=3D AVB_IO_RESULT_OK)
> +               return log_msg_ret("avb lock", -EIO);
> +
> +       result =3D avb_slot_verify(avb_ops,
> +                                requested_partitions,
> +                                slot_suffix,
> +                                unlocked,
> +                                AVB_HASHTREE_ERROR_MODE_RESTART_AND_INVA=
LIDATE,
> +                                &out_data);
> +
> +       if (result !=3D AVB_SLOT_VERIFY_RESULT_OK) {
> +               printf("Verification failed, reason: %s\n",
> +                      str_avb_slot_error(result));
avb_ops_free(avb_ops) ?
> +               return log_msg_ret("avb verify", -EIO);
> +       }
> +
> +       if (unlocked)
> +               boot_state =3D AVB_ORANGE;
> +       else
> +               boot_state =3D AVB_GREEN;
> +
> +       extra_args =3D avb_set_state(avb_ops, boot_state);
> +       if (extra_args) {
> +               ret =3D avb_append_commandline_arg(bflow, extra_args);
> +               if (ret < 0)
> +                       goto free_out_data;
> +       }
> +
> +       ret =3D avb_append_commandline(bflow, out_data->cmdline);
> +       if (ret < 0)
> +               goto free_out_data;
> +
> +       return 0;
> +
> + free_out_data:
> +       if (out_data)
> +               avb_slot_verify_data_free(out_data);
> +
> +       return log_msg_ret("avb cmdline", ret);
> +}
> +#else
> +static int run_avb_verification(struct bootflow *bflow)
> +{
> +       int ret;
> +
> +       /* When AVB is unsupported, pass ORANGE state  */
> +       ret =3D bootflow_cmdline_set_arg(bflow,
> +                                      "androidboot.verifiedbootstate",
> +                                      "orange", false);
> +       if (ret < 0)
> +               return log_msg_ret("avb cmdline", ret);
> +
> +       return 0;
> +}
> +#endif /* AVB_VERIFY */
> +
> +static int boot_android_normal(struct bootflow *bflow)
> +{
> +       struct blk_desc *desc =3D dev_get_uclass_plat(bflow->blk);
> +       struct android_priv *priv =3D bflow->bootmeth_priv;
> +       int ret;
> +
> +       ulong loadaddr =3D env_get_hex("loadaddr", 0);
> +       ulong vloadaddr =3D env_get_hex("vendor_boot_comp_addr_r", 0);
> +
> +       ret =3D run_avb_verification(bflow);
> +       if (ret < 0)
> +               return log_msg_ret("avb", ret);
> +
> +       /* Read slot once more to decrement counter from BCB */
> +       ret =3D android_read_slot_from_bcb(bflow, true);
> +       if (ret < 0)
> +               return log_msg_ret("read slot", ret);
> +
> +       ret =3D read_slotted_partition(desc, "boot", priv->slot, loadaddr=
);
> +       if (ret < 0)
> +               return log_msg_ret("read boot", ret);
> +
> +       ret =3D read_slotted_partition(desc, "vendor_boot", priv->slot, v=
loadaddr);
> +       if (ret < 0)
> +               return log_msg_ret("read vendor_boot", ret);
> +
> +       set_abootimg_addr(loadaddr);
> +       set_avendor_bootimg_addr(vloadaddr);
> +
> +       ret =3D bootm_boot_start(loadaddr, bflow->cmdline);
> +
> +       return log_msg_ret("boot", ret);
> +}
> +
> +static int boot_android_recovery(struct bootflow *bflow)
> +{
> +       int ret;
> +
> +       ret =3D boot_android_normal(bflow);
> +
> +       return log_msg_ret("boot", ret);
> +}
> +
> +static int boot_android_bootloader(struct bootflow *bflow)
> +{
> +       int ret;
> +
> +       ret =3D run_command("fastboot usb 0", 0);
select CMD_FASTBOOT in Kconfig (config BOOTMETH_ANDROID)?
> +       do_reset(NULL, 0, 0, NULL);
> +
> +       return log_msg_ret("boot", ret);
> +}
> +
> +static int android_boot(struct udevice *dev, struct bootflow *bflow)
> +{
> +       struct android_priv *priv =3D bflow->bootmeth_priv;
> +       int ret;
> +
> +       switch (priv->boot_mode) {
> +       case ANDROID_BOOT_MODE_NORMAL:
> +               ret =3D boot_android_normal(bflow);
> +               break;
> +       case ANDROID_BOOT_MODE_RECOVERY:
> +               ret =3D boot_android_recovery(bflow);
> +               break;
> +       case ANDROID_BOOT_MODE_BOOTLOADER:
> +               ret =3D boot_android_bootloader(bflow);
> +               break;
> +       default:
> +               printf("ANDROID: Unknown boot mode %d. Running fastboot..=
.\n",
> +                      priv->boot_mode);
> +               boot_android_bootloader(bflow);
> +               /* Tell we failed to boot since boot mode is unknown */
> +               ret =3D -EFAULT;
> +       }
> +
> +       return ret;
> +}
> +
> +static int android_bootmeth_bind(struct udevice *dev)
> +{
> +       struct bootmeth_uc_plat *plat =3D dev_get_uclass_plat(dev);
> +
> +       plat->desc =3D "Android boot";
> +       plat->flags =3D BOOTMETHF_ANY_PART;
> +
> +       return 0;
> +}
> +
> +static struct bootmeth_ops android_bootmeth_ops =3D {
> +       .check          =3D android_check,
> +       .read_bootflow  =3D android_read_bootflow,
> +       .read_file      =3D android_read_file,
> +       .boot           =3D android_boot,
> +};
> +
> +static const struct udevice_id android_bootmeth_ids[] =3D {
> +       { .compatible =3D "u-boot,android" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(bootmeth_android) =3D {
> +       .name           =3D "bootmeth_android",
> +       .id             =3D UCLASS_BOOTMETH,
> +       .of_match       =3D android_bootmeth_ids,
> +       .ops            =3D &android_bootmeth_ops,
> +       .bind           =3D android_bootmeth_bind,
> +};
> diff --git a/boot/bootmeth_android.h b/boot/bootmeth_android.h
> new file mode 100644
> index 000000000000..411c2f2d15e7
> --- /dev/null
> +++ b/boot/bootmeth_android.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Bootmethod for Android
> + *
> + * Copyright (C) 2024 BayLibre, SAS
> + * Written by Mattijs Korpershoek <mkorpershoek@baylibre.com>
> + */
> +
> +enum android_boot_mode {
> +       ANDROID_BOOT_MODE_NORMAL =3D 0,
> +
> +       /* Android "recovery" is a special boot mode that uses another ra=
mdisk.
> +        * It can be used to "factory reset" a board or to flash logical =
partitions
> +        * It operates in 2 modes: adb or fastbootd
> +        * To enter recovery from Android, we can do:
> +        * $ adb reboot recovery
> +        * $ adb reboot fastboot
> +        */
> +       ANDROID_BOOT_MODE_RECOVERY,
> +
> +       /* Android "bootloader" is for accessing/reflashing physical part=
itions
> +        * Typically, this will launch a fastboot process in U-Boot.
> +        * To enter "bootloader" from Android, we can do:
> +        * $ adb reboot bootloader
> +        */
> +       ANDROID_BOOT_MODE_BOOTLOADER,
> +};
> diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd.rst
> index a07a72581e7a..709fa9e64ff3 100644
> --- a/doc/develop/bootstd.rst
> +++ b/doc/develop/bootstd.rst
> @@ -95,6 +95,7 @@ bootflows.
>
>  Note: it is possible to have a bootmeth that uses a partition or a whole=
 device
>  directly, but it is more common to use a filesystem.
> +For example, the Android bootmeth uses a whole device.
>
>  Note that some bootmeths are 'global', meaning that they select the boot=
dev
>  themselves. Examples include VBE and EFI boot manager. In this case, the=
y
> @@ -277,6 +278,9 @@ script_offset_f
>  script_size_f
>      Size of the script to load, e.g. 0x2000
>
> +vendor_boot_comp_addr_r
> +    Address to which to load the vendor_boot Android image, e.g. 0xe0000=
000
> +
>  Some variables are set by script bootmeth:
>
>  devtype
> @@ -418,6 +422,7 @@ Bootmeth drivers are provided for:
>     - EFI boot using bootefi from disk
>     - VBE
>     - EFI boot using boot manager
> +   - Android bootflow (boot image v4)
>
>
>  Command interface
> @@ -786,6 +791,7 @@ To do
>  Some things that need to be done to completely replace the distro-boot s=
cripts:
>
>  - implement extensions (devicetree overlays with add-on boards)
> +- implement legacy (boot image v2) android boot flow
>
>  Other ideas:
>
>
> --
> 2.45.0
>

Some comments after a quick "scan". Will take a more detailed look a
bit later today/tomorrow.
--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
