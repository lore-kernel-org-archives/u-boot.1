Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE80C47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 09:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C76A876F4;
	Mon, 22 Jan 2024 10:09:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fpIT/drX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BB24875E9; Mon, 22 Jan 2024 10:09:30 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 745A8876F4
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 10:09:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-681922a61baso24260366d6.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 01:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705914566; x=1706519366; darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BfzGmkGTKM8gWAG/7c40bjzR22FPsiz5Esc6VLkAUgw=;
 b=fpIT/drXB3nmaRt0NL0zl5YoM6veAUu1tAq7yjBv9SylVZzs1znCWXnZtXnTbJUNZ5
 ZrYGL19M1hrbFJnY06hBvlpgoWHgi+l/ItHUhrmO1oxJCnMVuODyQIDZWL//h9UP+QjQ
 T1op09Fd7WhVVys21FJO6FidAj+qVosHpobxARrF5A4Y/q4a3JCNaJynAoYu8hN9H4Zy
 0Wd03r+HQOjcAtFS7JJnsxl5TLWOtPBIgVWoqIPGNLwYoQViR5vFKppS1v+R0QsdIHBZ
 uYFMpWpfoP252j3Znz/40kIR3Fa5mJu2Nhx+aw/mdImYuXSpywBtUXa56jGUAYFh/uAg
 w97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705914566; x=1706519366;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BfzGmkGTKM8gWAG/7c40bjzR22FPsiz5Esc6VLkAUgw=;
 b=E6r8aAzZ8auCMXJ/tbhUjPYVXX1E65ooZlGOvWJQ7HMY72bgNgcJd1/i6DcR2A7EJX
 Gtz2vlXHkEkEA/76TTvHYuxUubEhKr5NaQFjhQ/zkOyzdKpBPxxuopKyHHD3/GjpfSxl
 AdXaCuMOsAcP/mOwxp6ZlCX0mUMw5CXwqt9kLjj0atxOJjKRERDaIH5/Lk7PIIwo7xff
 oy9VUELfCInO0ajorlg+u7c1FR7DFtKItFgDdFEaCqGk7miUJhPMk6OzwIGqc1Jl2Dj3
 TwM8cpLJcKECBrJMwk4jeo6p8ZipJgV1xinJVZUSlTYINayFHuEGsVWKohjVDeQElI+j
 MHDQ==
X-Gm-Message-State: AOJu0Yz9hUnlDpEVR0Mdsoi41u6qOU8jItw96pNgbuF+ZHv287saD3c9
 Ah3b8Oqu4jTtCuC4VQkZ2rMgllGmzcz7rbtVLYJ27WZvPFZS6YmINRFOjmrxFb1K00r3Ub1/dCz
 iP5Balw9USNQKDHpn3CE3xqtsSZT1162l1a4rAg==
X-Google-Smtp-Source: AGHT+IFQ8aevw/oJLZKJtI1V7d+DpMjbbhceH6A7G9P06wwUJDx7BqQ/vLztHIaIdNZ8P7Pk6eioXSQ9tJMRjRgsDnw=
X-Received: by 2002:a05:6214:1946:b0:681:98c8:d584 with SMTP id
 q6-20020a056214194600b0068198c8d584mr7547786qvk.14.1705914566094; Mon, 22 Jan
 2024 01:09:26 -0800 (PST)
MIME-Version: 1.0
References: <20240116123643.563412-1-mchitale@ventanamicro.com>
 <20240116123643.563412-3-mchitale@ventanamicro.com>
 <5d54af9b-205d-4130-868e-0773364446b9@gmx.de>
In-Reply-To: <5d54af9b-205d-4130-868e-0773364446b9@gmx.de>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Mon, 22 Jan 2024 14:38:49 +0530
Message-ID: <CAN37VV4f84s6QOZmO1cEi6s4qie8f-5A8b7wd8OjMmxS3cvkag@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] spl: Add support for booting from ESP
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Sean Anderson <seanga2@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, Marek Vasut <marex@denx.de>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, Jan 16, 2024 at 7:09=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gm=
x.de>
wrote:

> On 16.01.24 13:36, Mayuresh Chitale wrote:
> > Some platforms as described by EBBR specification may store images in
> > the FIRMWARE directory of the UEFI system partition(ESP). Add support
> > to boot from the EFI system partition if it is enabled for a platform.
> >
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
>
> Thank you for respinning this series.
>
> For future submissions it would be preferable to have the changes
> between the versions also in the individual patches.
>
Ok.

>
> > ---
> >   common/spl/Kconfig      |  8 +++++++
> >   common/spl/spl_blk_fs.c | 51 ++++++++++++++++++++++++++++++----------=
-
> >   common/spl/spl_fat.c    | 34 +++++++++++++++++++++++----
> >   3 files changed, 75 insertions(+), 18 deletions(-)
> >
> > diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > index cf7ffc9b112..48e4e43196a 100644
> > --- a/common/spl/Kconfig
> > +++ b/common/spl/Kconfig
> > @@ -1292,6 +1292,14 @@ config SPL_SATA_RAW_U_BOOT_SECTOR
> >         Sector on the SATA disk to load U-Boot from, when the SATA disk
> is being
> >         used in raw mode. Units: SATA disk sectors (1 sector =3D 512
> bytes).
> >
> > +config SPL_ESP_BOOT
> > +     bool "Load next stage boot image from the UEFI system partition"
> > +     default y if BOOT_DEFAULTS
> > +     select SPL_PARTITION_TYPE_GUID
> > +     help
> > +       When enabled, first try to boot from the UEFI system partition =
as
> > +       described in the Ch.4 of the EBBR specification.
> > +
> >   config SPL_NVME
> >       bool "NVM Express device support"
> >       depends on BLK
> > diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
> > index 04eac6f306b..a2e8c2ce910 100644
> > --- a/common/spl/spl_blk_fs.c
> > +++ b/common/spl/spl_blk_fs.c
> > @@ -10,12 +10,15 @@
> >   #include <spl_load.h>
> >   #include <image.h>
> >   #include <fs.h>
> > +#include <part.h>
> >   #include <asm/cache.h>
> >   #include <asm/io.h>
> >
> >   struct blk_dev {
> >       const char *ifname;
> >       const char *filename;
> > +     int devnum;
> > +     int partnum;
> >       char dev_part_str[8];
> >   };
> >
> > @@ -44,6 +47,29 @@ static ulong spl_fit_read(struct spl_load_info *load=
,
> ulong file_offset,
> >       return actlen;
> >   }
> >
> > +static int spl_blk_file_size(struct blk_dev *dev, const char *filename=
,
> > +                          loff_t *filesize)
> > +{
> > +     int ret;
> > +
> > +     snprintf(dev->dev_part_str, sizeof(dev->dev_part_str) - 1, "%x:%x=
",
> > +              dev->devnum, dev->partnum);
>
> Using log functions allows to provide more information if
> CONFIG_SPL_LOG=3Dy otherwise they fall back to printf() and debug().
>
> > +     debug("Loading file %s from %s %s\n", filename, dev->ifname,
> > +           dev->dev_part_str);
>
> log_debug(
>
> > +     ret =3D fs_set_blk_dev(dev->ifname, dev->dev_part_str, FS_TYPE_AN=
Y);
> > +     if (ret) {
> > +             printf("spl: unable to set blk_dev %s %s. Err - %d\n",
>
> SPL binary size is limited on many systems. There is already a message
> telling that we are in SPL. I would suggest to abbreviate the message.
>
> log_err("Can't access %s %s\n", dev->ifname, dev->dev_part_str);
>
> > +                    dev->ifname, dev->dev_part_str, ret);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D fs_size(filename, filesize);
> > +     if (ret)
> > +             printf("spl: unable to get size, file: %s. Err - %d\n",
> > +                    filename, ret);
>
> log_err("File not found %s\n", filename);
>
> Moving to log functions and adjusting the messages can be done in a
> follow up patch. I don't want to stop this series.
>
> Ok.

> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
>
> > +     return ret;
> > +}
> > +
> >   int spl_blk_load_image(struct spl_image_info *spl_image,
> >                      struct spl_boot_device *bootdev,
> >                      enum uclass_id uclass_id, int devnum, int partnum)
> > @@ -53,7 +79,7 @@ int spl_blk_load_image(struct spl_image_info
> *spl_image,
> >       loff_t filesize;
> >       struct blk_dev dev;
> >       struct spl_load_info load;
> > -     int ret;
> > +     int ret, part;
> >
> >       blk_desc =3D blk_get_devnum_by_uclass_id(uclass_id, devnum);
> >       if (!blk_desc) {
> > @@ -65,21 +91,18 @@ int spl_blk_load_image(struct spl_image_info
> *spl_image,
> >
> >       dev.filename =3D filename;
> >       dev.ifname =3D blk_get_uclass_name(uclass_id);
> > -     snprintf(dev.dev_part_str, sizeof(dev.dev_part_str) - 1, "%x:%x",
> > -              devnum, partnum);
> > -     ret =3D fs_set_blk_dev(dev.ifname, dev.dev_part_str, FS_TYPE_ANY)=
;
> > -     if (ret) {
> > -             printf("spl: unable to set blk_dev %s %s. Err - %d\n",
> > -                    dev.ifname, dev.dev_part_str, ret);
> > -             return ret;
> > +     dev.devnum =3D devnum;
> > +     dev.partnum =3D partnum;
> > +     if (IS_ENABLED(CONFIG_SPL_ESP_BOOT)) {
> > +             part =3D part_get_esp(blk_desc);
> > +             if (part)
> > +                     dev.partnum =3D part;
> > +             else
> > +                     return -ENODEV;
> >       }
> > -
> > -     ret =3D fs_size(filename, &filesize);
> > -     if (ret) {
> > -             printf("spl: unable to get file size: %s. Err - %d\n",
> > -                    filename, ret);
> > +     ret =3D spl_blk_file_size(&dev, filename, &filesize);
> > +     if (ret)
> >               return ret;
> > -     }
> >
> >       load.read =3D spl_fit_read;
> >       if (IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN))
> > diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
> > index a52f9e178e6..8c426a3f3e7 100644
> > --- a/common/spl/spl_fat.c
> > +++ b/common/spl/spl_fat.c
> > @@ -60,10 +60,10 @@ static ulong spl_fit_read(struct spl_load_info
> *load, ulong file_offset,
> >       return actread;
> >   }
> >
> > -int spl_load_image_fat(struct spl_image_info *spl_image,
> > -                    struct spl_boot_device *bootdev,
> > -                    struct blk_desc *block_dev, int partition,
> > -                    const char *filename)
> > +int spl_load_image_fat_one(struct spl_image_info *spl_image,
> > +                        struct spl_boot_device *bootdev,
> > +                        struct blk_desc *block_dev, int partition,
> > +                        const char *filename)
> >   {
> >       int err;
> >       loff_t size;
> > @@ -103,6 +103,32 @@ end:
> >       return err;
> >   }
> >
> > +int spl_load_image_fat(struct spl_image_info *spl_image,
> > +                    struct spl_boot_device *bootdev,
> > +                    struct blk_desc *block_dev, int partition,
> > +                    const char *filename)
> > +{
> > +     int err, part;
> > +
> > +     /*
> > +      * First try to boot from EFI System partition. In case of failur=
e,
> > +      * fall back to the configured partition.
> > +      */
> > +     if (IS_ENABLED(CONFIG_SPL_ESP_BOOT)) {
> > +             part =3D part_get_esp(block_dev);
> > +             if (part) {
> > +                     err =3D spl_load_image_fat_one(spl_image, bootdev=
,
> > +                                                  block_dev, part,
> > +                                                  filename);
> > +                     if (!err)
> > +                             return err;
> > +             }
> > +     }
> > +
> > +     return spl_load_image_fat_one(spl_image, bootdev, block_dev,
> > +                                   partition, filename);
> > +}
> > +
> >   #if CONFIG_IS_ENABLED(OS_BOOT)
> >   int spl_load_image_fat_os(struct spl_image_info *spl_image,
> >                         struct spl_boot_device *bootdev,
>
>
