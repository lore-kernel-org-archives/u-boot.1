Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1331BE9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:11:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 108EB83E13;
	Thu, 19 Feb 2026 14:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gSoVj4HF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2402883E23; Thu, 19 Feb 2026 14:11:08 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF67E83936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-65be78011c8so1158516a12.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:11:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506655; cv=none;
 d=google.com; s=arc-20240605;
 b=dBqbNJZxMK7toyXol/SB32W8T/Z6Wr8TCcl7PAviXrtQhrLv6r+wqX2D9dUY/EkJow
 Pxkx+TINQubkiNMsBfvuOkzuXLsYx7VIdX5dcMO8wQ3B5LEo0fTo4Zw89xdXvGUGG1RI
 QceqlWpEcIJd5QwMKqPKE6RZDLfSeWngHmN+AcsYodGKFNRMwnHbYPST7x2n81d3Dx2u
 WM+FEmZ7Vf93PRCyrdZgSYRlTUWtEOdK9g796lb2anIwrw+8evfXrMsCj7B6Hpp1MDb3
 JzuXorDsgvuGLCs5y8TFLzo+j2CZkPkPoqGE5Nr1JtHhONiHgoHQRVqRhrrZEujjm57d
 0d4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T3IT2McOSf+7svJwZOCjUdVxskF2Ih7+6UPIg4JkHO8=;
 fh=m0XD7afJlXzpMhek3B6RkWP5tZe4EHTGa+d4LCEQCE4=;
 b=EeKp31HtpUJqeqqApe1irqw3LhD0d4Y1vQfTR1h+PtusqemeVU+NYnAxm2+MacyEgr
 PRRnLBJQ5ZGaySJ9fGUSH8voMh99xIiVL+cBF4i4Aj0tAJqffb4FjI5dnnDwm1TBJzhb
 kxuZU15DilSPbWAZzEqPTiqBbD1ToIQxiGh68otoeAJ//DQb5bZQ6DXUE7l+iXnswmpn
 ZmD7622ccOkek4oOKtvSv/IqdswNqawUZYPk4qcDZhZ4X96/gG33ttEshmpVF5wZPxIM
 +UxEijTcfICPkcLc/aC3C9dmPBs9JbgrKZjiqD/c1E4hpkAgEah7JIY1VvezIt/SEcgd
 94Xg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506655; x=1772111455; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3IT2McOSf+7svJwZOCjUdVxskF2Ih7+6UPIg4JkHO8=;
 b=gSoVj4HFdQNMfxXN/16jYR9s9j2MAh5tgrV7O10ENgC9AK+rdUpKhF/LbrmG6pSGox
 YNaVuTHeylik4zzsRXie2sOO1wn60gHL0JFoEre91mnfob9FOQF8jgxrutK40rFlFZ7L
 pSiN4uTmuK/QwOWP92yxSfNjzMKXqGVeKzR+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506655; x=1772111455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T3IT2McOSf+7svJwZOCjUdVxskF2Ih7+6UPIg4JkHO8=;
 b=XpXkTYOnLVA0M4185W3MfVvLng+Fo/Tcmrh4g6uyVkK22PN5hRyquzREEiHl/O9V+E
 Nhw3I1aGfUEUx9geC6b9cyMERN01qiadaM+4bnLUeT3RQ+ZEJD3iZx7G7IVdk1ARbtoV
 e5RqW8SZC+rgfg4jomnWwpUXlZ/tVkxTfCHi5TZTcsk31+ro8GT7XSawx6+G1QLAYaUl
 OCs9PwnOJQ6+CHgiO+vCuMbePtZWop1Hm+AGhKjPDBN0/Npt/p0cwxG7TjkLJBvXKCT9
 vVWXQ4rGStQNP09ysrL4c0uQxNNSRG2RW8fruAFaGKQMRvx2H9f8PRjSn0uYzPeYVwoU
 gN4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgW6vwP9UFr3OehfweQFoHokGdumqrGk2thL7e6Apsm3EfmgDR8yXjAEkB9X8eg4D+asKF0GU=@lists.denx.de
X-Gm-Message-State: AOJu0YyGev5w0ImhCC3x5g+ba4oTPA505ON9YkZeVDbzQD+0usnls1HY
 Um8pHKc0m4cnh8X7Lva80KuLOH9MY9nXHBe3qcDrVo5A9/3k7orRJXge+kVtRVIrk9SUKfjH8/n
 21nhy2FWWKG8ZjTPVWNoYG+c0eWIIQD+g+kclmASc
X-Gm-Gg: AZuq6aLjdx9tFqwsM+IzvLwWP1e+HiIEGPhw5AEM5Y4j2D8LWMq00glOgO8e3IYl4c/
 VBnvZE6MB10zmOxTz0UWkXMrLc2sx1BysKUBSOhdGCayCsgAA9sF1yBvWM8sF8rxfF7iVjo9eMM
 PmC8lCXMBBnQ5j/bSVWjR5MNpyitLTXwsSP1GRw93LeJxAQuXcK84er6E2HpIhdbrwAxClIkMq0
 ZyE5aQg91y9+lpZLlNUCJFWAAo6VFN5F/+xlxiPA/pA/8BrHTKE4JbJj2RGo5I56x6G8ApQxayU
 tHMa2flhi2fckVwP
X-Received: by 2002:a05:6402:278b:b0:658:d1b0:9970 with SMTP id
 4fb4d7f45d1cf-65bacce9358mr11442036a12.5.1771506654686; Thu, 19 Feb 2026
 05:10:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <bc1fb5747051cd6462bf3158250a04ea8e83b14e.1771275704.git.daniel@makrotopia.org>
In-Reply-To: <bc1fb5747051cd6462bf3158250a04ea8e83b14e.1771275704.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:09:31 -0700
X-Gm-Features: AaiRm5178oQR_Rye0WSuJQqt0AfCsUgJ6BQBWXqVriTD_dZDB4A_ArCLEenjO5o
Message-ID: <CAFLszTjt+F00+-x0yr7i8=MpxDVgrmaJQJqNpUVTA4cd55TRXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 17/20] boot: bootdev: add UBI boot device
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

On Mon, 16 Feb 2026 at 14:24, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Add a boot device driver for UBI (Unsorted Block Images) that enables
> bootstd to scan UBI volumes for FIT images.
>
> The driver:
> - Has a hunt callback that auto-attaches UBI: walks the DT for the
>   first partition with compatible =3D "linux,ubi", finds the matching
>   MTD device, and calls ubi_part_from_mtd() to attach
> - Binds directly via bootdev_bind() as a child of the top-level MTD
>   device, using a distinct name ("ubibootdev") to coexist with the
>   MTD bootdev
> - Iterates UBI volumes using iter->part as an index
> - Reads the first bytes of each volume and checks for a valid FDT
>   header via fdt_check_header()
> - Stores the UBI volume name in bflow->bootmeth_priv for the
>   bootmeth's boot() to pass to image_loader_init_ubi()
> - Returns -ESHUTDOWN when all volumes are exhausted
>
> Like the MTD bootdev, calls bootmeth_check() first so that only
> compatible bootmeths produce bootflows. Inert until bootmeth_openwrt
> is extended to accept UBI bootdevs.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  boot/Kconfig       |   9 +++
>  boot/Makefile      |   1 +
>  boot/ubi_bootdev.c | 180 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 190 insertions(+)
>  create mode 100644 boot/ubi_bootdev.c
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 63e373cc62d..75d40744e69 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -594,6 +594,15 @@ config BOOTDEV_MTD
>           This scans MTD partitions for uImage.FIT firmware images,
>           enabling raw-flash boot via the OpenWrt boot method.
>
> +config BOOTDEV_UBI
> +       bool "UBI bootdev support"
> +       depends on CMD_UBI
> +       depends on BOOTSTD
> +       help
> +         Enable a boot device for UBI (Unsorted Block Images).
> +         This scans UBI volumes for uImage.FIT firmware images,
> +         enabling raw-flash boot via the OpenWrt boot method.
> +
>  config BOOTMETH_OPENWRT
>         bool "Bootdev support for OpenWrt"
>         depends on FIT
> diff --git a/boot/Makefile b/boot/Makefile
> index feeed4924dd..aa7968c3932 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -73,6 +73,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_OS) +=3D vbe_=
simple_os.o
>
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) +=3D bootmeth_android.o
>  obj-$(CONFIG_$(PHASE_)BOOTDEV_MTD) +=3D mtd_bootdev.o
> +obj-$(CONFIG_$(PHASE_)BOOTDEV_UBI) +=3D ubi_bootdev.o
>  obj-$(CONFIG_$(PHASE_)BOOTMETH_OPENWRT) +=3D bootmeth_openwrt.o
>
>  obj-$(CONFIG_IMAGE_LOADER) +=3D image-loader.o
> diff --git a/boot/ubi_bootdev.c b/boot/ubi_bootdev.c
> new file mode 100644
> index 00000000000..03131a4ee1b
> --- /dev/null
> +++ b/boot/ubi_bootdev.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * UBI boot device
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
> +#include <dm/ofnode.h>
> +#include <malloc.h>
> +#include <mtd.h>
> +#include <ubi_uboot.h>
> +#include <linux/libfdt.h>
> +
> +static int ubi_bootdev_get_bootflow(struct udevice *dev,
> +                                   struct bootflow_iter *iter,
> +                                   struct bootflow *bflow)
> +{
> +       struct ubi_device *ubi;
> +       struct ubi_volume *vol;
> +       struct mtd_info *ubi_mtd, *top_mtd, *part;
> +       char buf[40];
> +       char dname[60];
> +       int ubi_part_idx =3D 0;
> +       int n =3D 0;
> +       int i, ret;
> +
> +       ret =3D bootmeth_check(bflow->method, iter);
> +       if (ret)
> +               return log_msg_ret("chk", ret);
> +
> +       ubi =3D ubi_devices[0];
> +       if (!ubi)
> +               return log_msg_ret("ubi", -ENODEV);
> +
> +       /* Count volumes so the scanning framework knows the bound */
> +       for (i =3D 0; i < ubi->vtbl_slots; i++) {
> +               if (ubi->volumes[i])
> +                       n++;
> +       }
> +       if (n)
> +               iter->max_part =3D n - 1;

This can just be done once, when !iter->part, since it cannot change.

> +
> +       n =3D 0;
> +
> +       /* Walk to the iter->part'th UBI volume */
> +       for (i =3D 0; i < ubi->vtbl_slots; i++) {
> +               vol =3D ubi->volumes[i];
> +               if (!vol)
> +                       continue;
> +               if (n =3D=3D iter->part)
> +                       goto found;
> +               n++;
> +       }
> +       return -ESHUTDOWN;
> +
> +found:

The above code need tightening up a bit!

> +       ret =3D ubi_volume_read(vol->name, buf, 0, sizeof(buf));
> +       if (ret)
> +               return log_msg_ret("rd", -EIO);
> +
> +       if (fdt_check_header(buf))
> +               return log_msg_ret("fdt", -ENOENT);
> +
> +       /*
> +        * Find the MTD partition index hosting UBI so we can display
> +        * a meaningful partition number in the bootflow listing.
> +        */
> +       ubi_mtd =3D ubi->mtd;
> +       top_mtd =3D ubi_mtd;
> +       while (top_mtd->parent)
> +               top_mtd =3D top_mtd->parent;
> +
> +       n =3D 0;
> +       list_for_each_entry(part, &top_mtd->partitions, node) {
> +               if (part =3D=3D ubi_mtd) {
> +                       ubi_part_idx =3D n;
> +                       break;
> +               }
> +               n++;
> +       }
> +
> +       /* Device-style name and partition index for bootflow list displa=
y */
> +       snprintf(dname, sizeof(dname), "%s.part_%x", dev->name, ubi_part_=
idx);
> +       bflow->name =3D strdup(dname);
> +       bflow->part =3D ubi_part_idx;
> +       bflow->fname =3D strdup(vol->name);
> +       bflow->bootmeth_priv =3D strdup(vol->name);
> +       bflow->state =3D BOOTFLOWST_MEDIA;
> +
> +       return bootmeth_read_bootflow(bflow->method, bflow);
> +}
> +
> +static int ubi_bootdev_bind(struct udevice *dev)
> +{
> +       struct bootdev_uc_plat *ucp =3D dev_get_uclass_plat(dev);
> +
> +       ucp->prio =3D BOOTDEVP_4_SCAN_FAST;
> +
> +       return 0;
> +}
> +
> +/**
> + * ubi_bootdev_hunt() - attach UBI and bind a bootdev for it
> + *
> + * Walk the DT for the first partition with compatible =3D "linux,ubi",
> + * find its MTD device, attach UBI via ubi_part_from_mtd(), then bind
> + * a ubi_bootdev as a child of the top-level MTD DM device.
> + */
> +static int ubi_bootdev_hunt(struct bootdev_hunter *info, bool show)
> +{
> +       struct udevice *bdev;
> +       struct mtd_info *mtd;
> +       ofnode node;
> +       int ret;
> +
> +       mtd_probe_devices();
> +
> +       if (!ubi_devices[0]) {
> +               ofnode_for_each_compatible_node(node, "linux,ubi") {
> +                       mtd_for_each_device(mtd) {
> +                               if (ofnode_equal(mtd->flash_node, node))
> +                                       goto found;
> +                       }
> +               }
> +               return -ENOENT;

Eek no we need to find the device, not the node. There must surely be
a link between the UBI and MTD in the data structures somewhere.

> +found:
> +               ret =3D ubi_part_from_mtd(mtd);
> +               if (ret)
> +                       return log_msg_ret("att", -ENOENT);
> +       }
> +
> +       /* Find the top-level MTD device for the attached UBI */
> +       mtd =3D ubi_devices[0]->mtd;
> +       while (mtd->parent)
> +               mtd =3D mtd->parent;
> +
> +       if (!mtd->dev)
> +               return log_msg_ret("dev", -ENODEV);
> +
> +       /*
> +        * Bind directly =E2=80=94 bootdev_setup_for_dev() cannot be used=
 here
> +        * because the MTD bootdev may already occupy the single bootdev
> +        * child slot.
> +        */
> +       ret =3D bootdev_bind(mtd->dev, "ubi_bootdev", "ubibootdev", &bdev=
);
> +       if (ret)
> +               return log_msg_ret("bd", ret);
> +
> +       return 0;
> +}
> +
> +struct bootdev_ops ubi_bootdev_ops =3D {
> +       .get_bootflow   =3D ubi_bootdev_get_bootflow,
> +};
> +
> +static const struct udevice_id ubi_bootdev_ids[] =3D {
> +       { .compatible =3D "u-boot,bootdev-ubi" },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(ubi_bootdev) =3D {
> +       .name           =3D "ubi_bootdev",
> +       .id             =3D UCLASS_BOOTDEV,
> +       .ops            =3D &ubi_bootdev_ops,
> +       .bind           =3D ubi_bootdev_bind,
> +       .of_match       =3D ubi_bootdev_ids,
> +};
> +
> +BOOTDEV_HUNTER(ubi_bootdev_hunter) =3D {
> +       .prio           =3D BOOTDEVP_4_SCAN_FAST,
> +       .uclass         =3D UCLASS_MTD,
> +       .drv            =3D DM_DRIVER_REF(ubi_bootdev),
> +       .hunt           =3D ubi_bootdev_hunt,
> +};
> --
> 2.53.0

Regards,
Simon
