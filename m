Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA9ACA0ECD
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 03:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3187B86D93;
	Tue, 12 Sep 2023 05:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V5MroIeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 649C0868D0; Tue, 12 Sep 2023 05:09:11 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8D5B86DFF
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 05:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5280ef23593so6135316a12.3
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 20:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694488146; x=1695092946; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nItppIezGsfNnAuOw52hilDvjlhS1cAMVtFZZbUrCc=;
 b=V5MroIeEeGx5uLRG+9Zma7Zqp/lgu3Tbd4hOfgDqnjnHaDrWkI0pGom5Y5MtATIW6r
 uaF29Iq5hu04QyPFL3zu1ZO3zV7XuWzLxgVVl/a+3Rx03enpZT0zv+5SgGXF4AriaLHH
 0kKb2hFPGzdDmuCqat+1QcrB0DBGcqcfvaiXelfVJCO8ug96epclXXJ8Hrav/ejytNIx
 DJXVV+XStyy37w7PXhnax8o6wX+eFXCyTIcAMD0ziN9osdXdc+3Yy5kxNFKGT8g3s9Q2
 mf3Eq5uAxUlMGkS8o80bHj0CHJkxtle3MW1AF5VmjwjiGm+Sm2hJCL1V2VBBEOki8Zpk
 wu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694488146; x=1695092946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/nItppIezGsfNnAuOw52hilDvjlhS1cAMVtFZZbUrCc=;
 b=d/eGwgoOvbBHUtu+NO6frcxXE5mQyizJYv3l8NsVCTzsv20Wb9vroAYiC47NaO9biN
 VNHUhmVIih7Wwzeh76egqF2cBfT3Fie5jb862YhJpCqs7O8vx2DFW7s0c5HL7ETOOKlR
 fr4HGyKeJDulVafvq66EVLZaVoZ4sK3qq1tX3nPI/+8DnVw5VhAGGpEDPYiDwnyGF2WD
 4Ko5rrb8FuR2vwoozCTU+RBK+GeawuVSTHvxOHNCxgqwz1mbjWwkOkqtEhi6+S57NiA4
 nCd6Y9SRK10VlFoKI5X90wI3fLCmvLujpAiSGNp9AQuFgUBNw55EBS0aMUnCc02X2OUA
 XrMw==
X-Gm-Message-State: AOJu0Yyx0pZ2dAozHKrC1DiaQMAnfOaiKm5sEXgJJYC3JZjoVGHg/k6T
 oP/RotmrnBjRgFc3kuKP9d6y7+BlKuR1neNp9Tw=
X-Google-Smtp-Source: AGHT+IGjVurMXE8fGH726GTXWCzls7t34k8Qq6as/WD+elIjgKXjABZdmWyGUCyqAN5A6tsUn+gzf6nPIT5D+gp75/Q=
X-Received: by 2002:a05:6402:88d:b0:52c:9f89:4445 with SMTP id
 e13-20020a056402088d00b0052c9f894445mr9077277edy.21.1694488145922; Mon, 11
 Sep 2023 20:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230908190935.12516-1-mibodhi@gmail.com>
 <CAPnjgZ1b7mx1fk5rBQ0wWBD4p85-Smw5=KG89KdCSyR+cMx+YA@mail.gmail.com>
In-Reply-To: <CAPnjgZ1b7mx1fk5rBQ0wWBD4p85-Smw5=KG89KdCSyR+cMx+YA@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 11 Sep 2023 20:08:54 -0700
Message-ID: <CAJaLiFy9Jw6626FtZO1qbYop0CAjTHA+aORQ9QKiVkMwthwAjg@mail.gmail.com>
Subject: Re: [PATCH v3] bootstd: sata: Add bootstd support for ahci sata
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>
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

On Sun, Sep 10, 2023 at 3:37=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Tony,
>
> On Fri, 8 Sept 2023 at 13:10, Tony Dinh <mibodhi@gmail.com> wrote:
> >
> > Add ahci sata bootdev and corresponding hunting function.
> >
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > ---
> >
> > Changes in v3:
> > - Correct drivers/ata/Makefile to compile sata_bootdev only if
> > ahci sata is enabled.
> >
> > Changes in v2:
> > - set devtype to sata in bootmeth_script for non-scsi SATA device.
> >
> >  boot/bootmeth_script.c     | 12 ++++++--
> >  drivers/ata/Makefile       |  2 +-
> >  drivers/ata/sata.c         | 25 +++++++++++++++
> >  drivers/ata/sata_bootdev.c | 62 ++++++++++++++++++++++++++++++++++++++
> >  include/sata.h             |  1 +
> >  5 files changed, 99 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/ata/sata_bootdev.c
> >
> > diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
> > index 58c57a2d4b..0269e0f9b0 100644
> > --- a/boot/bootmeth_script.c
> > +++ b/boot/bootmeth_script.c
> > @@ -190,10 +190,18 @@ static int script_boot(struct udevice *dev, struc=
t bootflow *bflow)
> >         ulong addr;
> >         int ret;
> >
> > -       if (desc->uclass_id =3D=3D UCLASS_USB)
> > +       if (desc->uclass_id =3D=3D UCLASS_USB) {
> >                 ret =3D env_set("devtype", "usb");
> > -       else
> > +       } else {
> >                 ret =3D env_set("devtype", blk_get_devtype(bflow->blk))=
;
> > +
> > +               /* If the parent uclass is AHCI, but the driver is ATA
> > +                * (not scsi), set devtype to sata
> > +                */
> > +               if (!ret && IS_ENABLED(CONFIG_SATA) &&
> > +                   !strcmp("ahci", env_get("devtype")))
>
> Can you not use desc->uclass_id to do the right thing here? It seems
> odd to compare with the value of the env var you just set up above.

Indeed, I must have been too caught up with the env :)

>
> > +                       ret =3D env_set("devtype", "sata");
> > +       }
> >         if (!ret)
> >                 ret =3D env_set_hex("devnum", desc->devnum);
> >         if (!ret)
> > diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> > index 6e30180b8b..0b6f91098a 100644
> > --- a/drivers/ata/Makefile
> > +++ b/drivers/ata/Makefile
> > @@ -10,7 +10,7 @@ obj-$(CONFIG_SCSI_AHCI) +=3D ahci.o
> >  obj-$(CONFIG_DWC_AHSATA) +=3D dwc_ahsata.o
> >  obj-$(CONFIG_FSL_SATA) +=3D fsl_sata.o
> >  obj-$(CONFIG_LIBATA) +=3D libata.o
> > -obj-$(CONFIG_SATA) +=3D sata.o
> > +obj-$(CONFIG_SATA) +=3D sata.o sata_bootdev.o
> >  obj-$(CONFIG_SATA_CEVA) +=3D sata_ceva.o
> >  obj-$(CONFIG_SATA_MV) +=3D sata_mv.o
> >  obj-$(CONFIG_SATA_SIL) +=3D sata_sil.o
> > diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
> > index ce3e9b5a40..9da7218564 100644
> > --- a/drivers/ata/sata.c
> > +++ b/drivers/ata/sata.c
> > @@ -15,6 +15,8 @@
> >  #include <dm.h>
> >  #include <part.h>
> >  #include <sata.h>
> > +#include <dm/device-internal.h>
> > +#include <dm/uclass-internal.h>
> >
> >  #ifndef CONFIG_AHCI
> >  struct blk_desc sata_dev_desc[CONFIG_SYS_SATA_MAX_DEVICE];
> > @@ -50,6 +52,29 @@ int sata_scan(struct udevice *dev)
> >         return ops->scan(dev);
> >  }
> >
> > +int sata_rescan(bool verbose)
> > +{
> > +       struct udevice *dev;
> > +       int devnum =3D 0;
> > +       int ret;
> > +
> > +       /* Find and probing the SATA controller */
> > +       ret =3D uclass_get_device(UCLASS_AHCI, devnum, &dev);
>
> This does not actually rescan...if the device has already been probed,
> it won't be probed again. You will need to use the logic like in
> sata_remove().
>
> Also, please avoid using devnum. You should probably just use
> uclass_probe_all(UCLASS_AHCI)

OK.

>
> > +
> > +       /* Sanity check */
> > +       if (ret)
> > +               ret =3D uclass_find_first_device(UCLASS_AHCI, &dev);
>
> That just finds it, but does not probe it. See uclass_first_device_err()
>
> > +       if (ret) {
> > +               printf("Cannot probe SATA device %d (err=3D%d)\n", devn=
um, ret);
> > +               return -ENOSYS;
>
> return ret
>
> > +       }
> > +       if (!dev) {
> > +               printf("No SATA device found!\n");
> > +               return -ENOSYS;
> > +       }
> > +       return 0;
> > +}
> > +
> >  #ifndef CONFIG_AHCI
> >  #ifdef CONFIG_PARTITIONS
> >  struct blk_desc *sata_get_dev(int dev)
> > diff --git a/drivers/ata/sata_bootdev.c b/drivers/ata/sata_bootdev.c
> > new file mode 100644
> > index 0000000000..f638493ce0
> > --- /dev/null
> > +++ b/drivers/ata/sata_bootdev.c
> > @@ -0,0 +1,62 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Bootdev for sata
> > + *
> > + * Copyright 2023 Tony Dinh <mibodhi@gmail.com>
> > + */
> > +
> > +#include <common.h>
> > +#include <ahci.h>
> > +#include <bootdev.h>
> > +#include <dm.h>
> > +#include <init.h>
> > +#include <sata.h>
> > +
> > +static int sata_bootdev_bind(struct udevice *dev)
> > +{
> > +       struct bootdev_uc_plat *ucp =3D dev_get_uclass_plat(dev);
> > +
> > +       ucp->prio =3D BOOTDEVP_4_SCAN_FAST;
> > +
> > +       return 0;
> > +}
> > +
> > +static int sata_bootdev_hunt(struct bootdev_hunter *info, bool show)
> > +{
> > +       int ret;
> > +
> > +       if (IS_ENABLED(CONFIG_PCI)) {
> > +               ret =3D pci_init();
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       ret =3D sata_rescan(true);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return 0;
> > +}
> > +
> > +struct bootdev_ops sata_bootdev_ops =3D {
> > +};
> > +
> > +static const struct udevice_id sata_bootdev_ids[] =3D {
> > +       { .compatible =3D "u-boot,bootdev-sata" },
> > +       { }
> > +};
> > +
> > +U_BOOT_DRIVER(sata_bootdev) =3D {
> > +       .name           =3D "sata_bootdev",
> > +       .id             =3D UCLASS_BOOTDEV,
> > +       .ops            =3D &sata_bootdev_ops,
> > +       .bind           =3D sata_bootdev_bind,
> > +       .of_match       =3D sata_bootdev_ids,
> > +};
> > +
> > +BOOTDEV_HUNTER(sata_bootdev_hunter) =3D {
> > +       .prio           =3D BOOTDEVP_4_SCAN_FAST,
> > +       .uclass         =3D UCLASS_AHCI,
> > +       .hunt           =3D sata_bootdev_hunt,
> > +       .drv            =3D DM_DRIVER_REF(sata_bootdev),
> > +};
> > diff --git a/include/sata.h b/include/sata.h
> > index d89f7a8a29..0495744bad 100644
> > --- a/include/sata.h
> > +++ b/include/sata.h
> > @@ -20,5 +20,6 @@ extern struct blk_desc sata_dev_desc[];
> >
> >  int sata_probe(int devnum);
> >  int sata_remove(int devnum);
> > +int sata_rescan(bool verbose);
>
> Please add a comment

Will do. And thanks for the review! I will send in the v4 patch.

All the best,
Tony

>
> >
> >  #endif
> > --
> > 2.39.2
> >
>
> Regards,
> Simon
