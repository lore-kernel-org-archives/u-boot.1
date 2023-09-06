Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB4DEE14C3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D17C8655E;
	Wed,  6 Sep 2023 23:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aGVqE+HJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D54865A5; Wed,  6 Sep 2023 23:16:09 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD786868BC
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:16:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4bdso247103a12.3
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 14:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694034966; x=1694639766; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCWxCVN9Pp8L7Eyl/yCPZ+Mv83q3+4n/w3Zf24inyXM=;
 b=aGVqE+HJtJvhLKhUDrxSSRV/U8XgB9SHb33slPYlam9HF8dHNXYzb9cHXXhheMMnKN
 Fejy8n3nJqKNVqM4p64FADGJ6QiQcMicqnXNknXcY8udlwS4+2t/c6sIaO7y2CO94du3
 a4atUkYhAyOQsxXSh90RsSlwQ7Yw9nHuzGyOMlznIYLlyjO9xaeDl0cl2ynm06eAu33J
 LYTlCopoY4kDReS1RS2wm0QpXK8+EMJqnw62iGBmFn90h8yTZVwYvacaR3C9Xgbly91O
 NeDmr9B6M2Zwj2GKLR+iXL1GbOkRapIobBKel4G4w7F5Yjn+t2ldjhuDqDUbrGt5D07c
 Txlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694034966; x=1694639766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SCWxCVN9Pp8L7Eyl/yCPZ+Mv83q3+4n/w3Zf24inyXM=;
 b=i/GX+2UzwRyDyXHepFmTqXz9pbrKx34SHRyh/km+eiFalY+b9/Zzj8MMa7zJOvsbt3
 MF1oIRreiw06HeOTAvCGJgGmB252hlv8c55bK5O3xkC9xA5OH6i/cU9O6UjEVLRXPzQp
 Ef1lf+eYFUC4vC2TYUzBAeFKF50OrW1HAIg+6acIdPlBm6P3ZzHazwNJ3RiPaJ8Eidlb
 Iy4kM+W/iK+lIp/TBzMsZ9EFOyQ8waoqHvPlo5p71f+Kh0wjzrHfVBszBLdSEMOyWfcp
 RdKUWvkDlKXjs8vvm2jKQs6RcZTJwqsVdLxPgzk4JRpRZQYdS1EkoouWg7B2In9Ahspw
 iPlQ==
X-Gm-Message-State: AOJu0YxzHJuXjC8U9CsDOszxtH0/33ZjG7GpKuG5vamcFW6S+3mrTpRp
 VNVnjeGtD2raCWTF36tZ9xu4RzD3JbAvCbGUDCqjm6U6Ma8=
X-Google-Smtp-Source: AGHT+IEtFrmcvX+NM89OwYS8JR34Oc1URVh6EP9pPcp3ia56CD9tZ+kx2cVQ1FdH6YzuoGehfqgp2YmnPW8RCJcYYfE=
X-Received: by 2002:aa7:d65a:0:b0:523:f91:fcce with SMTP id
 v26-20020aa7d65a000000b005230f91fccemr3005003edr.13.1694034966069; Wed, 06
 Sep 2023 14:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230906040002.19267-1-mibodhi@gmail.com>
In-Reply-To: <20230906040002.19267-1-mibodhi@gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 6 Sep 2023 14:15:54 -0700
Message-ID: <CAJaLiFwb=YvM7NqBFMLvYAjUkCmRKD-GjJ0NkoWgG5CK-mayKQ@mail.gmail.com>
Subject: Re: [PATCH] bootstd: sata: Add bootstd support for ahci sata
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Tue, Sep 5, 2023 at 9:00=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrote:
>
> Add ahci sata bootdev and corresponding hunting function.
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
>  drivers/ata/Makefile       |  1 +
>  drivers/ata/sata.c         | 25 +++++++++++++++
>  drivers/ata/sata_bootdev.c | 62 ++++++++++++++++++++++++++++++++++++++
>  include/sata.h             |  1 +
>  4 files changed, 89 insertions(+)
>  create mode 100644 drivers/ata/sata_bootdev.c
>
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

This will need a followup patch. It's about how the distro boot
devtype is currently set to "ahci" after the bootflow scanning,
instead of "sata". For example,

load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} ${uImage}

The non-scsi hdd device it must be identified as sata, like below,

load sata  ${devnum}:${distro_bootpart} ${kernel_addr_r} ${uImage}

All the best,
Tony
