Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604D6C71153
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 22:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEB6C86CFC;
	Mon, 11 Sep 2023 00:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a+mRJpIO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FAB386CF5; Mon, 11 Sep 2023 00:37:09 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD9CC86CD0
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 00:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so10582664a12.0
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 15:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694385426; x=1694990226; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gsGpAVTQDHJTDPCv9ByDMphJhAFi9K8NW1FEbDT8k6I=;
 b=a+mRJpIOv5WxWqTDlQAHsaw/ujNuVoX7eYvYcM75B4StVVCXqVWNFmv3UaJAibmE4x
 b+Rc3y104m+vFN9pFx80i7IR2LP6BtpJ+nPNCYxaoJEt2/lzm7tZPdZy1m1EaObsrujA
 Uw2C8EJpqu6z2G5RssfKIydKjS2YMXoQireII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694385426; x=1694990226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gsGpAVTQDHJTDPCv9ByDMphJhAFi9K8NW1FEbDT8k6I=;
 b=OCH0cn081Y6/WlDNOvKh3/P8OEtrCymY7vkp5348Va8pbzMTN4Sd9UtDNVvAwyKIoB
 uXqPGOudWk5qVZRCwN5f0bFTgq3jLYi5T1gUnOsG4BA5dXjp7ZTvXVHFPHnSU2OVQNZR
 Y8k5YkPGc9tfm9LZZ+7VinBrDpBUVWvNC+itv4wO45NxL3PdGClzOSHxesBo8zXHuT+i
 qn2Jrz/GSO7SkV1YaS8w2Wg4F1cvv7jhjZFZTuU7QlAHEO/OkJMGpM5Cls9MxXrlcbVd
 cFSIVY5JLryG0SZdG+cF4fI4HzOm+yEnLzFYzqf+ayZyCagtZGkm/HZ1sr1t+XAKswzn
 D2kQ==
X-Gm-Message-State: AOJu0Yz1eGbInZaX726xD/rWS+Ec/UokQ3U/o/03I57x3bhWHTZjXkQJ
 sJV6JqEGq8zFP6ucEXzDoT6Fa34GExwVk/dF5zLWwA==
X-Google-Smtp-Source: AGHT+IFHT8t1NQbAUa8XKyz2/ajizYzbS8vaNkrHQtpvq3vEEosj0+Gd8BcuhuVf3B0EpEzGOxIBi6ul1VOvG3xJ8DU=
X-Received: by 2002:a05:6402:5242:b0:51d:b184:efd with SMTP id
 t2-20020a056402524200b0051db1840efdmr13671511edd.20.1694385426319; Sun, 10
 Sep 2023 15:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230908190935.12516-1-mibodhi@gmail.com>
In-Reply-To: <20230908190935.12516-1-mibodhi@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 16:36:51 -0600
Message-ID: <CAPnjgZ1b7mx1fk5rBQ0wWBD4p85-Smw5=KG89KdCSyR+cMx+YA@mail.gmail.com>
Subject: Re: [PATCH v3] bootstd: sata: Add bootstd support for ahci sata
To: Tony Dinh <mibodhi@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>
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

Hi Tony,

On Fri, 8 Sept 2023 at 13:10, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Add ahci sata bootdev and corresponding hunting function.
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
> Changes in v3:
> - Correct drivers/ata/Makefile to compile sata_bootdev only if
> ahci sata is enabled.
>
> Changes in v2:
> - set devtype to sata in bootmeth_script for non-scsi SATA device.
>
>  boot/bootmeth_script.c     | 12 ++++++--
>  drivers/ata/Makefile       |  2 +-
>  drivers/ata/sata.c         | 25 +++++++++++++++
>  drivers/ata/sata_bootdev.c | 62 ++++++++++++++++++++++++++++++++++++++
>  include/sata.h             |  1 +
>  5 files changed, 99 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/ata/sata_bootdev.c
>
> diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
> index 58c57a2d4b..0269e0f9b0 100644
> --- a/boot/bootmeth_script.c
> +++ b/boot/bootmeth_script.c
> @@ -190,10 +190,18 @@ static int script_boot(struct udevice *dev, struct bootflow *bflow)
>         ulong addr;
>         int ret;
>
> -       if (desc->uclass_id == UCLASS_USB)
> +       if (desc->uclass_id == UCLASS_USB) {
>                 ret = env_set("devtype", "usb");
> -       else
> +       } else {
>                 ret = env_set("devtype", blk_get_devtype(bflow->blk));
> +
> +               /* If the parent uclass is AHCI, but the driver is ATA
> +                * (not scsi), set devtype to sata
> +                */
> +               if (!ret && IS_ENABLED(CONFIG_SATA) &&
> +                   !strcmp("ahci", env_get("devtype")))

Can you not use desc->uclass_id to do the right thing here? It seems
odd to compare with the value of the env var you just set up above.

> +                       ret = env_set("devtype", "sata");
> +       }
>         if (!ret)
>                 ret = env_set_hex("devnum", desc->devnum);
>         if (!ret)
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 6e30180b8b..0b6f91098a 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_SCSI_AHCI) += ahci.o
>  obj-$(CONFIG_DWC_AHSATA) += dwc_ahsata.o
>  obj-$(CONFIG_FSL_SATA) += fsl_sata.o
>  obj-$(CONFIG_LIBATA) += libata.o
> -obj-$(CONFIG_SATA) += sata.o
> +obj-$(CONFIG_SATA) += sata.o sata_bootdev.o
>  obj-$(CONFIG_SATA_CEVA) += sata_ceva.o
>  obj-$(CONFIG_SATA_MV) += sata_mv.o
>  obj-$(CONFIG_SATA_SIL) += sata_sil.o
> diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
> index ce3e9b5a40..9da7218564 100644
> --- a/drivers/ata/sata.c
> +++ b/drivers/ata/sata.c
> @@ -15,6 +15,8 @@
>  #include <dm.h>
>  #include <part.h>
>  #include <sata.h>
> +#include <dm/device-internal.h>
> +#include <dm/uclass-internal.h>
>
>  #ifndef CONFIG_AHCI
>  struct blk_desc sata_dev_desc[CONFIG_SYS_SATA_MAX_DEVICE];
> @@ -50,6 +52,29 @@ int sata_scan(struct udevice *dev)
>         return ops->scan(dev);
>  }
>
> +int sata_rescan(bool verbose)
> +{
> +       struct udevice *dev;
> +       int devnum = 0;
> +       int ret;
> +
> +       /* Find and probing the SATA controller */
> +       ret = uclass_get_device(UCLASS_AHCI, devnum, &dev);

This does not actually rescan...if the device has already been probed,
it won't be probed again. You will need to use the logic like in
sata_remove().

Also, please avoid using devnum. You should probably just use
uclass_probe_all(UCLASS_AHCI)

> +
> +       /* Sanity check */
> +       if (ret)
> +               ret = uclass_find_first_device(UCLASS_AHCI, &dev);

That just finds it, but does not probe it. See uclass_first_device_err()

> +       if (ret) {
> +               printf("Cannot probe SATA device %d (err=%d)\n", devnum, ret);
> +               return -ENOSYS;

return ret

> +       }
> +       if (!dev) {
> +               printf("No SATA device found!\n");
> +               return -ENOSYS;
> +       }
> +       return 0;
> +}
> +
>  #ifndef CONFIG_AHCI
>  #ifdef CONFIG_PARTITIONS
>  struct blk_desc *sata_get_dev(int dev)
> diff --git a/drivers/ata/sata_bootdev.c b/drivers/ata/sata_bootdev.c
> new file mode 100644
> index 0000000000..f638493ce0
> --- /dev/null
> +++ b/drivers/ata/sata_bootdev.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Bootdev for sata
> + *
> + * Copyright 2023 Tony Dinh <mibodhi@gmail.com>
> + */
> +
> +#include <common.h>
> +#include <ahci.h>
> +#include <bootdev.h>
> +#include <dm.h>
> +#include <init.h>
> +#include <sata.h>
> +
> +static int sata_bootdev_bind(struct udevice *dev)
> +{
> +       struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
> +
> +       ucp->prio = BOOTDEVP_4_SCAN_FAST;
> +
> +       return 0;
> +}
> +
> +static int sata_bootdev_hunt(struct bootdev_hunter *info, bool show)
> +{
> +       int ret;
> +
> +       if (IS_ENABLED(CONFIG_PCI)) {
> +               ret = pci_init();
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret = sata_rescan(true);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +struct bootdev_ops sata_bootdev_ops = {
> +};
> +
> +static const struct udevice_id sata_bootdev_ids[] = {
> +       { .compatible = "u-boot,bootdev-sata" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(sata_bootdev) = {
> +       .name           = "sata_bootdev",
> +       .id             = UCLASS_BOOTDEV,
> +       .ops            = &sata_bootdev_ops,
> +       .bind           = sata_bootdev_bind,
> +       .of_match       = sata_bootdev_ids,
> +};
> +
> +BOOTDEV_HUNTER(sata_bootdev_hunter) = {
> +       .prio           = BOOTDEVP_4_SCAN_FAST,
> +       .uclass         = UCLASS_AHCI,
> +       .hunt           = sata_bootdev_hunt,
> +       .drv            = DM_DRIVER_REF(sata_bootdev),
> +};
> diff --git a/include/sata.h b/include/sata.h
> index d89f7a8a29..0495744bad 100644
> --- a/include/sata.h
> +++ b/include/sata.h
> @@ -20,5 +20,6 @@ extern struct blk_desc sata_dev_desc[];
>
>  int sata_probe(int devnum);
>  int sata_remove(int devnum);
> +int sata_rescan(bool verbose);

Please add a comment

>
>  #endif
> --
> 2.39.2
>

Regards,
Simon
