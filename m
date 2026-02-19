Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9076E9A049
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3422083D0F;
	Thu, 19 Feb 2026 14:10:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CG2yXlzk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3641B83D3D; Thu, 19 Feb 2026 14:10:27 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BCFF83CF2
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:10:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-354c19bf64bso430374a91.1
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:10:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506623; cv=none;
 d=google.com; s=arc-20240605;
 b=g5hv5pH+Mr9bKS3dMxkNM9KZMPXWcub9+S+1anMWzeXvAlKX3RwdAHHIcZWaOR09Mp
 vDDTqkWZWhKjjGLbPYLwgMGNkJIebWJFHoTDA6lbjJ4xBCyb78hDKLrOS3pUCyv/OKM1
 5zaB32P2054N+DZhj9cHsrlOSGzkigy5KWRkln8VVJtlCIHz9SS9AVTF61kNpbylLJV5
 k9H/OjPP08z0+p3X/HZ2q+84r5XNzhl7WBDkS9fZjRSCPiW6aC93pcLeHZecJ0dIyEwP
 sgtXlXIa3ZjN0aJbKA4i/30oZM8WIc01UQyvW/ljQpEzhlOKqIK7fpeVPGo2iw6smoq7
 2G4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UD6Urv2uL49bUTX+vWX0Gxn4CX3IunYiCdkfuYz61H0=;
 fh=M1mguO2NKL67GmY1MFEcbuizCnr7eTpVMANZSarrQS0=;
 b=MLEJ29M99dWG8wssyyRkJBBhE7IssUm3h1t1jzTpNLVxEfNhQYQ+quMJvA6Z2uP81U
 ZTlCkKmuAldwmkk2IS7EVReaN6dFbc2WJkYxW00sZ+7SBgZvNNlVFNGf4tCf9kXzq+pM
 DLAc+8FZ4Sh7spzPwSMb+aSwrIY7mcUoW9IW6AwmSPPZEUUacRDExZk5KT8utcReEnLZ
 J5Xly+nNlnyM8ruSfpzbMu6vmXn1mXD/XoJgEgCMxTt+3UjXoGYGSzGJhZMRB0wMtlGR
 izPa4w9Pnh3ctGFTt50C+qhiBLLb5XujHAcDocmyKRaAG0LiPKCKwkS/iZagB3Om4Jxz
 iv8Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506623; x=1772111423; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UD6Urv2uL49bUTX+vWX0Gxn4CX3IunYiCdkfuYz61H0=;
 b=CG2yXlzk+5/IPGjnCJwVR9UV3ta0RE9PfUoWjdD1SBp/XI4eV2MaN39OZunNnGxv4/
 U7+rQC9WUiQFBRbaYsO1b8ydPMgxoB9fktrT2r41ixvFISphAz3esmwo3rpAb4fuyU/N
 02/1xgYl0fJbmPoB7xk8fuuxL++4E9G3SgVG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506623; x=1772111423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UD6Urv2uL49bUTX+vWX0Gxn4CX3IunYiCdkfuYz61H0=;
 b=XYLOxvI30rEh1gE9pqTjjXpembqFjbEsn7fk+ZjORTMG4g/unh3a7HHH2dH2oBWOiL
 w2xMKxv65S1vC/pn+4szJoqs3AVp1Z61DfEW2XM4TIaZ+KbeqyZ/k/lUC/B/QSKotEP1
 vcfCqRN0soZ/z9yuxZ5XK+oW8bseYFjVCxmKZBluunVl+cNr1MeNl6L4KzVyHNCLgt3v
 jpty8THEzOYQwH4PR6IHUfQf3SVE6O4hQc0kpEzMa5Neu/rVbO3jVb3O5iHBt46Uw1SE
 LSOQ1h9DwrAH3+jycuJRKDaPHHxm1RpqeiiKHMC/iLJVUoYFYHuEMh63LqnBdeBFeMCK
 tECA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ8IslCwYJueCzgXFKGrrq4ObhJ0J+fZA9WIYl+Zfs9wFjS+MpAh+LfizgniJhGs7bcxb8Upw=@lists.denx.de
X-Gm-Message-State: AOJu0YzqF7SqIJWi0NPg8nQQhhEjHgZV5bnOfC2ek2tPhurPt4YObr2f
 mO7qQd1/FRUCv3wkIrNMHeMyLdukhyadYY5g4GTgacZML7zUNEqn5RffEYoU/8cdv2N0VG0eiK1
 Xdt2vkm6/Q0lmdIC2szNvzLu4IWIcUhGT9wXKvXg5
X-Gm-Gg: AZuq6aLUuvywR2kZVQo66dB8xYayIHnHBsuviwzBq4nx+nRaZgtY48OPieZQAfDjCWu
 df4MhbBohQBsszoWEoflUGm9nlFZgdY9YkFY8eC52vPZXKQu/CDVyglhv/xghkCSCYzynExQXy+
 iXOf/KZqDrwYVETciLMJt6dZHw0TI6E4ozosFSu/xQebCARK76GJgAtv6rIHD0CQTBoAMZ5c3HG
 izRF1WOvahzBD6HrdUThrvCoHkwoGK4N2h7Coqz3oIRlAg4m/wRt5JfZeWs54tZVYK14eqLmoTu
 BlZq8A==
X-Received: by 2002:a17:90b:4cc7:b0:34c:718c:5448 with SMTP id
 98e67ed59e1d1-358984ea764mr1318208a91.4.1771506622699; Thu, 19 Feb 2026
 05:10:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <01cc9fe77706bfec2c7806f95d93c84678d06a91.1771275704.git.daniel@makrotopia.org>
In-Reply-To: <01cc9fe77706bfec2c7806f95d93c84678d06a91.1771275704.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:09:30 -0700
X-Gm-Features: AaiRm51SEwKsREL3WmjpqOnTZBvL9TRLL_YwREgdgL3mb6ynFLc6uEwA57JkXS8
Message-ID: <CAFLszTg7ofy26E=12fgxTAvhd05Xb-p9ZhYe6uzdf_1zdVdULg@mail.gmail.com>
Subject: Re: [RFC PATCH 16/20] boot: bootdev: add MTD boot device
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de, 
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
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

Hi Daniel,

On Mon, 16 Feb 2026 at 14:23, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Add a boot device driver for MTD (Memory Technology Devices) that
> enables bootstd to scan MTD partitions for FIT images.
>
> Add a mtd_bootdev_hunt() callback that:
> - Calls mtd_probe_devices() once to probe all MTD devices (both
>   UCLASS_MTD and UCLASS_SPI_FLASH) and parse their partitions
> - Iterates the MTD subsystem device list and binds an mtd_bootdev for
>   any top-level MTD device that has partitions but is not in UCLASS_MTD
>   (those already get their bootdev from mtd_post_bind)
> - Uses bootdev_bind() directly since sf_bootdev may already occupy the
>   standard bootdev child slot
>
> The MTD bootdev calls bootmeth_check() at the start of get_bootflow()
> so that only compatible bootmeths (those that accept MTD bootdevs)
> produce bootflows. Until bootmeth_openwrt's check() is extended to
> accept MTD bootdevs, this driver is inert =E2=80=94 each commit compiles =
and
> introduces no regressions independently.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  boot/Kconfig             |   9 +++
>  boot/Makefile            |   1 +
>  boot/mtd_bootdev.c       | 150 +++++++++++++++++++++++++++++++++++++++
>  drivers/mtd/mtd-uclass.c |  15 ++++
>  4 files changed, 175 insertions(+)
>  create mode 100644 boot/mtd_bootdev.c
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>

nits below

> diff --git a/boot/Kconfig b/boot/Kconfig
> index d8c7b8360ac..63e373cc62d 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -585,6 +585,15 @@ config BOOTMETH_CROS
>
>           Note that only x86 devices are supported at present.
>
> +config BOOTDEV_MTD
> +       bool "MTD bootdev support"
> +       depends on DM_MTD
> +       depends on BOOTSTD
> +       help
> +         Enable a boot device for MTD (Memory Technology Devices).
> +         This scans MTD partitions for uImage.FIT firmware images,
> +         enabling raw-flash boot via the OpenWrt boot method.
> +
>  config BOOTMETH_OPENWRT
>         bool "Bootdev support for OpenWrt"
>         depends on FIT
> diff --git a/boot/Makefile b/boot/Makefile
> index 7b42358eb0c..feeed4924dd 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -72,6 +72,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_FW) +=3D vbe_=
simple_fw.o
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_OS) +=3D vbe_simple_os.o
>
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) +=3D bootmeth_android.o
> +obj-$(CONFIG_$(PHASE_)BOOTDEV_MTD) +=3D mtd_bootdev.o
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_OPENWRT) +=3D bootmeth_openwrt.o
>
>  obj-$(CONFIG_IMAGE_LOADER) +=3D image-loader.o
> diff --git a/boot/mtd_bootdev.c b/boot/mtd_bootdev.c
> new file mode 100644
> index 00000000000..8a3304be988
> --- /dev/null
> +++ b/boot/mtd_bootdev.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MTD boot device
> + *
> + * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
> + */
> +
> +#define LOG_CATEGORY UCLASS_BOOTSTD
> +
> +#include <bootdev.h>
> +#include <bootflow.h>
> +#include <bootmeth.h>
> +#include <dm.h>
> +#include <malloc.h>
> +#include <mtd.h>
> +#include <linux/libfdt.h>
> +
> +static int mtd_bootdev_get_bootflow(struct udevice *dev,
> +                                   struct bootflow_iter *iter,
> +                                   struct bootflow *bflow)
> +{
> +       struct udevice *parent =3D dev_get_parent(dev);
> +       struct mtd_info *mtd, *part;
> +       u8 buf[40];
> +       size_t retlen;
> +       char dname[60];
> +       int n =3D 0;
> +       int ret;
> +
> +       ret =3D bootmeth_check(bflow->method, iter);
> +       if (ret)
> +               return log_msg_ret("chk", ret);
> +
> +       /* Find the top-level MTD device matching our parent */
> +       mtd_for_each_device(mtd) {
> +               if (!mtd_is_partition(mtd) && mtd->dev =3D=3D parent)
> +                       break;
> +       }
> +       if (!mtd || mtd->dev !=3D parent)
> +               return log_msg_ret("mtd", -ESHUTDOWN);
> +
> +       /* Count partitions so the scanning framework knows the bound */
> +       list_for_each_entry(part, &mtd->partitions, node)
> +               n++;
> +       if (n)
> +               iter->max_part =3D n - 1;
> +
> +       n =3D 0;
> +
> +       /* Walk to the iter->part'th sub-partition */
> +       list_for_each_entry(part, &mtd->partitions, node) {
> +               if (n =3D=3D iter->part)
> +                       goto found;
> +               n++;
> +       }

blank line here

> +       return -ESHUTDOWN;
> +
> +found:
> +       ret =3D mtd_read(part, 0, sizeof(buf), &retlen, buf);
> +       if (ret || retlen < sizeof(buf))
> +               return log_msg_ret("rd", -EIO);
> +
> +       if (fdt_check_header(buf))
> +               return log_msg_ret("fdt", -ENOENT);
> +
> +       /* Device-style name and partition index for bootflow list displa=
y */
> +       snprintf(dname, sizeof(dname), "%s.part_%x", dev->name, iter->par=
t);
> +       bflow->name =3D strdup(dname);
> +       bflow->part =3D iter->part;
> +       bflow->fname =3D strdup(part->name);
> +       bflow->bootmeth_priv =3D strdup(part->name);
> +       bflow->state =3D BOOTFLOWST_MEDIA;
> +
> +       return bootmeth_read_bootflow(bflow->method, bflow);
> +}
> +
> +static int mtd_bootdev_bind(struct udevice *dev)
> +{
> +       struct bootdev_uc_plat *ucp =3D dev_get_uclass_plat(dev);
> +
> +       ucp->prio =3D BOOTDEVP_4_SCAN_FAST;
> +
> +       return 0;
> +}
> +
> +struct bootdev_ops mtd_bootdev_ops =3D {
> +       .get_bootflow   =3D mtd_bootdev_get_bootflow,
> +};
> +
> +static const struct udevice_id mtd_bootdev_ids[] =3D {
> +       { .compatible =3D "u-boot,bootdev-mtd" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(mtd_bootdev) =3D {
> +       .name           =3D "mtd_bootdev",
> +       .id             =3D UCLASS_BOOTDEV,
> +       .ops            =3D &mtd_bootdev_ops,
> +       .bind           =3D mtd_bootdev_bind,
> +       .of_match       =3D mtd_bootdev_ids,
> +};
> +
> +/**
> + * mtd_bootdev_hunt() - probe MTD devices and bind bootdevs
> + *
> + * Call mtd_probe_devices() to ensure all MTD devices (including SPI NOR
> + * flash via CONFIG_SPI_FLASH_MTD) are probed and their partitions parse=
d.
> + *
> + * UCLASS_MTD devices already get an mtd_bootdev via mtd_post_bind().
> + * This creates mtd_bootdev instances for other MTD devices (e.g. SPI NO=
R
> + * in UCLASS_SPI_FLASH) that have partitions but would otherwise lack on=
e.
> + * bootdev_bind() is used directly because sf_bootdev may already occupy
> + * the standard bootdev child slot.
> + */
> +static int mtd_bootdev_hunt(struct bootdev_hunter *info, bool show)
> +{
> +       struct mtd_info *mtd;
> +       struct udevice *bdev;
> +
> +       mtd_probe_devices();
> +
> +       mtd_for_each_device(mtd) {
> +               /* Only top-level MTD devices, not partitions */
> +               if (mtd_is_partition(mtd))
> +                       continue;
> +
> +               /* Must have a DM device */
> +               if (!mtd->dev)
> +                       continue;
> +
> +               /* UCLASS_MTD devices already have mtd_bootdev from post_=
bind */
> +               if (device_get_uclass_id(mtd->dev) =3D=3D UCLASS_MTD)
> +                       continue;
> +
> +               /* Only interested in MTD devices that have partitions */
> +               if (list_empty(&mtd->partitions))
> +                       continue;
> +
> +               bootdev_bind(mtd->dev, "mtd_bootdev", "mtdbootdev", &bdev=
);

Check error

> +       }
> +
> +       return 0;
> +}
> +
> +BOOTDEV_HUNTER(mtd_bootdev_hunter) =3D {
> +       .prio           =3D BOOTDEVP_4_SCAN_FAST,
> +       .uclass         =3D UCLASS_MTD,
> +       .drv            =3D DM_DRIVER_REF(mtd_bootdev),
> +       .hunt           =3D mtd_bootdev_hunt,
> +};
> diff --git a/drivers/mtd/mtd-uclass.c b/drivers/mtd/mtd-uclass.c
> index 720bd824c4d..0c637d3f5ec 100644
> --- a/drivers/mtd/mtd-uclass.c
> +++ b/drivers/mtd/mtd-uclass.c
> @@ -5,11 +5,25 @@
>
>  #define LOG_CATEGORY UCLASS_MTD
>
> +#include <bootdev.h>
>  #include <dm.h>
>  #include <dm/device-internal.h>
>  #include <errno.h>
>  #include <mtd.h>
>
> +static int mtd_post_bind(struct udevice *dev)
> +{
> +       if (CONFIG_IS_ENABLED(BOOTDEV_MTD)) {
> +               int ret;
> +
> +               ret =3D bootdev_setup_for_dev(dev, "mtd_bootdev");
> +               if (ret)
> +                       return log_msg_ret("bd", ret);
> +       }
> +
> +       return 0;
> +}
> +
>  /*
>   * Implement a MTD uclass which should include most flash drivers.
>   * The uclass private is pointed to mtd_info.
> @@ -18,5 +32,6 @@
>  UCLASS_DRIVER(mtd) =3D {
>         .id             =3D UCLASS_MTD,
>         .name           =3D "mtd",
> +       .post_bind      =3D mtd_post_bind,
>         .per_device_auto        =3D sizeof(struct mtd_info),
>  };
> --
> 2.53.0

Regards,
Simon
