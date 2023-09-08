Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393A4EEB564
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 17:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6041086997;
	Fri,  8 Sep 2023 19:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fMmcF5IT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9D1886997; Fri,  8 Sep 2023 19:50:04 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23D5D864C4
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 19:50:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52c9be5e6f0so2942458a12.1
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 10:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694195401; x=1694800201; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VBRi1kO/pgl2wy6ePbj6Gf5uQj5Hradl4IEBz59rQoY=;
 b=fMmcF5ITI7+tBIsFznnCbD7JoonoDpfuKtN2PJbWsI4mUEjTi+G5n8kHtDuCOU0IEC
 FhY88FAwrGr+0erQ2wQNL5/EvloNenACQz4AX6+pbhaeFxlPxuCTYkQg+gp1Ru2LKSNa
 FcLSMnBprdLolR4Gn4sgSrAW23GGpdnskB4u9fRATMuIUInxepl+/VZC66AsjFrp1XyN
 2RKyBY8SFTPYXgDpK3+bVNrxCSXfBnfDEliihVLKcAudMsYyQ2MvGxbq9kZp9NiDnkTs
 2mrtFC/ZDTPl3x6hGeKYQJ1GcKWj3gasLQ9b6PKt2DxvDDIFMf8Q3+E/8UrKKuNoWUM7
 BZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694195401; x=1694800201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VBRi1kO/pgl2wy6ePbj6Gf5uQj5Hradl4IEBz59rQoY=;
 b=apGVBnsPDPTRe1E9MVZB0QQ46VVfge0qZ9mv3AlhcIUZuJZYqrIyscALbLLqdT0Y99
 LX1Hj4BooeM0MyWitAenTtjgtvrkRNHBY6fSM5+XdygWlAbCEFFJRqtGQhpSkX68RDBw
 Bqy9Vq6Asnf0gZWCnTM3WMvordIuh1+FWkaBGspmMBVifHcoCeX057ZeBTp/XnkA0e4W
 zJjEQRZxTlFTmx7c1fyQj2Q8CREmJV0yBwSTD7/S6AQUnsviz+98kcVyFCN2B5XjDQ27
 jSAHAmFM+Zql8wFqP5cZyeyaQ/79C2g0KReCC927VE1keLfRpmV+LCJWylm8zjbfH7BS
 xpug==
X-Gm-Message-State: AOJu0YztoJ+oBz0NKuo/E6ZToAlKiBaq8bk1pr9vnb+Rd3PHZdoTWR19
 v03z0NUB+AOj/VT11mjYdd+xMCrka7fhJ8a0OkA=
X-Google-Smtp-Source: AGHT+IFxHFfBmw1VX2xWXw13NOYl0sWQxdky3XV/Npomf48KWrunhGC9S7PnTQAkaS4ypMF0UpTRehwbhdLj7ikEprk=
X-Received: by 2002:a05:6402:3229:b0:525:466c:5fda with SMTP id
 g41-20020a056402322900b00525466c5fdamr2271593eda.28.1694195401464; Fri, 08
 Sep 2023 10:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230907213923.25948-1-mibodhi@gmail.com>
In-Reply-To: <20230907213923.25948-1-mibodhi@gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 8 Sep 2023 10:49:49 -0700
Message-ID: <CAJaLiFzNXpHq==m-OLRO=FAbi3m+fvbohqE14vOZzVFwOw1scg@mail.gmail.com>
Subject: Re: [PATCH v2] bootstd: sata: Add bootstd support for ahci sata
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
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

On Thu, Sep 7, 2023 at 2:39=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrote:
>
> Add ahci sata bootdev and corresponding hunting function.
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
> Changes in v2:
> - set devtype to sata in bootmeth_script for non-scsi SATA device
>
>  boot/bootmeth_script.c     | 12 ++++++--
>  drivers/ata/Makefile       |  1 +
>  drivers/ata/sata.c         | 25 +++++++++++++++
>  drivers/ata/sata_bootdev.c | 62 ++++++++++++++++++++++++++++++++++++++
>  include/sata.h             |  1 +
>  5 files changed, 99 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/ata/sata_bootdev.c
>
> diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
> index a4050c384d..3113183fb0 100644
> --- a/boot/bootmeth_script.c
> +++ b/boot/bootmeth_script.c
> @@ -190,10 +190,18 @@ static int script_boot(struct udevice *dev, struct =
bootflow *bflow)
>         ulong addr;
>         int ret;
>
> -       if (desc->uclass_id =3D=3D UCLASS_USB)
> +       if (desc->uclass_id =3D=3D UCLASS_USB) {
>                 ret =3D env_set("devtype", "usb");
> -       else
> +       } else {
>                 ret =3D env_set("devtype", blk_get_devtype(bflow->blk));
> +
> +               /* If the parent uclass is AHCI, but the driver is ATA
> +                * (not scsi), set devtype to sata
> +                */
> +               if (!ret && IS_ENABLED(CONFIG_SATA) &&
> +                   !strcmp("ahci", env_get("devtype")))
> +                       ret =3D env_set("devtype", "sata");
> +       }
>         if (!ret)
>                 ret =3D env_set_hex("devnum", desc->devnum);
>         if (!ret)
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 6e30180b8b..c1b51b5444 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_DWC_AHSATA) +=3D dwc_ahsata.o
>  obj-$(CONFIG_FSL_SATA) +=3D fsl_sata.o
>  obj-$(CONFIG_LIBATA) +=3D libata.o
>  obj-$(CONFIG_SATA) +=3D sata.o
> +obj-$(CONFIG_BOOTSTD) +=3D sata_bootdev.o
>  obj-$(CONFIG_SATA_CEVA) +=3D sata_ceva.o
>  obj-$(CONFIG_SATA_MV) +=3D sata_mv.o
>  obj-$(CONFIG_SATA_SIL) +=3D sata_sil.o
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
> +       int devnum =3D 0;
> +       int ret;
> +
> +       /* Find and probing the SATA controller */
> +       ret =3D uclass_get_device(UCLASS_AHCI, devnum, &dev);
> +
> +       /* Sanity check */
> +       if (ret)
> +               ret =3D uclass_find_first_device(UCLASS_AHCI, &dev);
> +       if (ret) {
> +               printf("Cannot probe SATA device %d (err=3D%d)\n", devnum=
, ret);
> +               return -ENOSYS;
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
> +       struct bootdev_uc_plat *ucp =3D dev_get_uclass_plat(dev);
> +
> +       ucp->prio =3D BOOTDEVP_4_SCAN_FAST;
> +
> +       return 0;
> +}
> +
> +static int sata_bootdev_hunt(struct bootdev_hunter *info, bool show)
> +{
> +       int ret;
> +
> +       if (IS_ENABLED(CONFIG_PCI)) {
> +               ret =3D pci_init();
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret =3D sata_rescan(true);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +struct bootdev_ops sata_bootdev_ops =3D {
> +};
> +
> +static const struct udevice_id sata_bootdev_ids[] =3D {
> +       { .compatible =3D "u-boot,bootdev-sata" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(sata_bootdev) =3D {
> +       .name           =3D "sata_bootdev",
> +       .id             =3D UCLASS_BOOTDEV,
> +       .ops            =3D &sata_bootdev_ops,
> +       .bind           =3D sata_bootdev_bind,
> +       .of_match       =3D sata_bootdev_ids,
> +};
> +
> +BOOTDEV_HUNTER(sata_bootdev_hunter) =3D {
> +       .prio           =3D BOOTDEVP_4_SCAN_FAST,
> +       .uclass         =3D UCLASS_AHCI,
> +       .hunt           =3D sata_bootdev_hunt,
> +       .drv            =3D DM_DRIVER_REF(sata_bootdev),
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
>
>  #endif
> --
> 2.39.2
>

Sorry, looks like I need to send in the V3 patch to correct this Make
file patch. I was not aware that CONFIG_BOOTSTD is now automatically
enabled.

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
-obj-$(CONFIG_SATA) +=3D sata.o
-obj-$(CONFIG_BOOTSTD) +=3D sata_bootdev.o
+obj-$(CONFIG_SATA) +=3D sata.o sata_bootdev.o

All the best,
Tony
