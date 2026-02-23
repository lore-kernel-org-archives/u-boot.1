Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBBEEC1116
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA7783C6E;
	Mon, 23 Feb 2026 18:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UPaSimQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CBFE83DEB; Mon, 23 Feb 2026 18:51:44 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A7CF83D17
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:51:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9047e72201so669970566b.2
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:51:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869100; cv=none;
 d=google.com; s=arc-20240605;
 b=Pb9/CiA6iaOgSptnhnW2m3NvaATE186ICLyAJk6bF3j/KGnlQPWU2MOS+T0u/m63LP
 eQdAbY6x8rR0297bMiCfO5++d0gai2lOIeEvdvbc7coxZCYMkYqxP5fOSw6cfEwtDGYi
 NK+4pZqD6NuwW+f6SvKH45cgDTGSSSBrn8G5gKWaOVId8HXEBscnW/c8DWEWn0t4ldjb
 f8s7omX5ry1Wn9CvHAKQ933gnuGjFs3cSuKL7H71JV9yVr3N6XWpFYvIIeqTPuZAchWE
 PkmxHrjvE76uoWwxGL/7wvVmuWpa5iuxQMHj3dw8W8cujNNlz442qSeRddcbAMqzSBVy
 L+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MtTyZlZLAEW0NLcFWS3FORVXRCOcviY/2XuOora/meU=;
 fh=a54gvFBOlj0GW1jkGePVaevyAMF+vBMMVMr8skdDUes=;
 b=LFrKaTMwqqtrSsIcyGLBvb4CqlQNtSN3aPH6YLN54lruEOfppL+KWLLFondyRzVzCQ
 8w/zL6faocaJrsAtWQxnyRH1HE4CDmaLPseuudZ0BnRCcJI9EKe+zQKtPzR/kzhc7xTc
 J0sJnApf7wDxIZafwaley4lUvw4K1Kgqwe2/X/Uc6rrOLL0ETWpslWA3/OcJHcpmvYHM
 B8TKFS+jA6/eWA0V8og2evAJI8FVQs58LfeOvJYTnphN8792D/W4fwZdO1gIsGzH0g+P
 aMHt+4pJOTpSdYoJcmeRgtIsNS6Hpp9oo3tBnil2DL1JteidFgx8Ofgclnp3/ieSyXw7
 0DMw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771869100; x=1772473900; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MtTyZlZLAEW0NLcFWS3FORVXRCOcviY/2XuOora/meU=;
 b=UPaSimQVNfQI8yM1ySMdHxSM2IoYr3SFfx14Q9QtCSE3lKr+rjWI5UsiQkrFv/884I
 tXuRx7w2DsoQIPkpqkMoIGG2dSEGrzSN2uvv31a1V7qwIgGJfiqFblLo3Lbo4qWlFgBh
 yv9IFcgzYh6jnYq8i4G0YMrlV+VhEoJEfU7uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771869100; x=1772473900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MtTyZlZLAEW0NLcFWS3FORVXRCOcviY/2XuOora/meU=;
 b=gWTftbhejqdXpKqf73WSBsnAh+M0QgVrQ/fxflfyqbhpiCBc9jDB8Hl1fZvvmZhKVB
 c+mo24Me/2ur035gE5TTKKq7v8n2y0Zki4c1klz3cKVlOI+hOaeHeFgzCxQuv4OzCbM0
 rz1fi2cDXkh9bfMZ7A4biHI6+T3JYsWQzZ2cZR/MZ7qWuPNt4LaBYzZwDrQ8HpJ1JEe9
 TdNZSWw1iOUBpjz1H/X3+xB3dw7A+nQbE8D6sXwUKtOREvzr3MiJpHH9RmzH2FEgGqcT
 ozDn/XMeSHmcHSJpyjQH5+Hl7EYZJeSuTayg2THIEOfTW8QoIdHZr91BYCTNZ2uRimkn
 kdVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtxo7+r2LOZc73f1S9GU54AcaueIapd5qXI/0XfcAE1r33l6pRcVCh8H2G3hvgbryPTJEP5SA=@lists.denx.de
X-Gm-Message-State: AOJu0YypjVOsgO6S2k2s/v94C65iS3S95KgENWmF3JsLsBrW/3aqOBr9
 FY5TXeN0aLsaWpmOnpsl/KMOCB/TiHaMSlSHV7O86FoJtQVxBo/1w2ERD3cRoRalFGliO7l0AHT
 toNxpZzD6vXa4JZy9K2y1kJsNhqA/RGVBOtcgtMiM
X-Gm-Gg: ATEYQzwg8jZXruiWWb6LEeRguEb9pZxp0JBC3tapA5wnvoZ8k1oU5yB2D5M/K2LD4c8
 R8dssW3qwdBxiNI8CsrwV8LQzEJPbRuY+q4BtFq7CCUgao93Q/GOpoCnSP32VPCsEkupwAYs8S5
 8JzG9//hGUNUCbxzAgRbF6W586Zr3ZwQTdMuhh4EKvGnA32zhHlUAgufv4MKhWPVftUx/5v2vWD
 Kufn+QuIrA+w1BNUZtDrtggc6VOc/X47TdxsKd38NqsaVSOIBK15RbuPgJ+GLIJ3aujYVHt9XYf
 tel9a/ZJ2y3J4FYN
X-Received: by 2002:a17:907:3e16:b0:b8f:b3c4:1e2 with SMTP id
 a640c23a62f3a-b9081af3169mr520814766b.39.1771869099641; Mon, 23 Feb 2026
 09:51:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <47725c58588200f631c918a56b770454d5721954.1771275704.git.daniel@makrotopia.org>
 <CAFLszThSKbRjufnj4z4xunn-OEUv8kNRngNQ3=EpaNyvyV5ncg@mail.gmail.com>
 <aZc_f3lrmRdE9c3Z@makrotopia.org>
In-Reply-To: <aZc_f3lrmRdE9c3Z@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Feb 2026 10:51:09 -0700
X-Gm-Features: AaiRm51Ju0FqnkZtJAdpbBW-8sKTg-ON2XgWQd1kYuhJkThugCW_DzL9WB4oc5o
Message-ID: <CAFLszTgxMeFvKx8nkVUa_PADiVFnv1UB69SyD+C3OiLY_7ku8w@mail.gmail.com>
Subject: Re: [RFC PATCH 08/20] boot: image-loader: add UBI volume backend
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

On Thu, 19 Feb 2026 at 09:51, Daniel Golle <daniel@makrotopia.org> wrote:
>
> On Thu, Feb 19, 2026 at 06:09:27AM -0700, Simon Glass wrote:
> > Hi Daniel,
> >
> > On Mon, 16 Feb 2026 at 14:22, Daniel Golle <daniel@makrotopia.org> wrote:
> > >
> > > Add a UBI volume storage backend for the image_loader framework.
> > >
> > > image_loader_init_ubi() takes a volume name, ensures the UBI device
> > > is attached (auto-attaching if needed), and installs a .read() callback
> > > wrapping ubi_volume_read().
> > >
> > > Auto-attach works by scanning the device tree for the first MTD
> > > partition with compatible = "linux,ubi", then calling ubi_part() on
> > > that partition. The partition name is resolved using the same
> > > precedence as the MTD partition parser: the "label" property first,
> > > then "name", then the node name. Since U-Boot only supports a single
> > > attached UBI device at a time, only the first matching partition is
> > > used. If a UBI device is already attached, the auto-attach step is
> > > skipped.
> > >
> > > UBI handles bad-block management and wear leveling internally, so the
> > > read callback is a straightforward passthrough. Note that
> > > ubi_volume_read() returns positive errno values; the wrapper negates
> > > them for the image_loader convention.
> > >
> > > Gated by CONFIG_IMAGE_LOADER_UBI (depends on CMD_UBI && IMAGE_LOADER).
> > >
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > ---
> > >  boot/Kconfig            |   8 +++
> > >  boot/Makefile           |   1 +
> > >  boot/image-loader-ubi.c | 112 ++++++++++++++++++++++++++++++++++++++++
> > >  include/image-loader.h  |  13 +++++
> > >  4 files changed, 134 insertions(+)
> > >  create mode 100644 boot/image-loader-ubi.c
> > >
> > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > index 23848a0f57e..89832014af6 100644
> > > --- a/boot/Kconfig
> > > +++ b/boot/Kconfig
> > > @@ -1203,6 +1203,14 @@ config IMAGE_LOADER_MTD
> > >           parallel NAND, etc.) using the image_loader framework.
> > >           NAND bad blocks are skipped transparently.
> > >
> > > +config IMAGE_LOADER_UBI
> > > +       bool "UBI volume backend for image loader"
> > > +       depends on IMAGE_LOADER && CMD_UBI
> > > +       help
> > > +         Allows loading images from UBI volumes using the image_loader
> > > +         framework. Auto-attaches the UBI device from the device tree
> > > +         if not already attached.
> > > +
> > >  config DISTRO_DEFAULTS
> > >         bool "(deprecated) Script-based booting of Linux distributions"
> > >         select CMDLINE
> > > diff --git a/boot/Makefile b/boot/Makefile
> > > index 1dde16db694..7d1d4a28106 100644
> > > --- a/boot/Makefile
> > > +++ b/boot/Makefile
> > > @@ -76,6 +76,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o
> > >  obj-$(CONFIG_IMAGE_LOADER) += image-loader.o
> > >  obj-$(CONFIG_IMAGE_LOADER_BLK) += image-loader-blk.o
> > >  obj-$(CONFIG_IMAGE_LOADER_MTD) += image-loader-mtd.o
> > > +obj-$(CONFIG_IMAGE_LOADER_UBI) += image-loader-ubi.o
> > >
> > >  obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC) += vbe_abrec.o vbe_common.o
> > >  obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC_FW) += vbe_abrec_fw.o
> > > diff --git a/boot/image-loader-ubi.c b/boot/image-loader-ubi.c
> > > new file mode 100644
> > > index 00000000000..64901a13378
> > > --- /dev/null
> > > +++ b/boot/image-loader-ubi.c
> > > @@ -0,0 +1,112 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * UBI volume backend for image_loader
> > > + *
> > > + * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
> > > + */
> > > +
> > > +#include <dm/ofnode.h>
> > > +#include <image-loader.h>
> > > +#include <log.h>
> > > +#include <malloc.h>
> > > +#include <mtd.h>
> > > +#include <ubi_uboot.h>
> > > +
> > > +struct image_loader_ubi_priv {
> > > +       char *vol_name;
> > > +};
> > > +
> > > +/**
> > > + * ubi_auto_attach() - attach UBI if not already attached
> > > + *
> > > + * If no UBI device is currently attached, walk the device tree for the
> > > + * first MTD partition node with compatible = "linux,ubi", find the
> > > + * corresponding MTD device by matching flash_node, and attach UBI to
> > > + * it via ubi_part_from_mtd().
> > > + *
> > > + * Since U-Boot only supports a single attached UBI device at a time,
> > > + * only the first matching partition is used.
> > > + *
> > > + * Return: 0 on success or if already attached, negative errno on failure
> > > + */
> > > +static int ubi_auto_attach(void)
> > > +{
> > > +       struct mtd_info *mtd;
> > > +       ofnode node;
> > > +
> > > +       /* Already attached? */
> > > +       if (ubi_devices[0])
> > > +               return 0;
> > > +
> > > +       mtd_probe_devices();
> >
> > This should be handled by your new ubi driver for your uclass.
> >
> > > +
> > > +       ofnode_for_each_compatible_node(node, "linux,ubi") {
> > > +               mtd_for_each_device(mtd) {
> > > +                       if (ofnode_equal(mtd->flash_node, node))
> > > +                               goto found;
> > > +               }
> > > +       }
> >
> > Eek this is really strange. There should be a device so you can use
> > uclass_first_device(UCLASS_...).
>
> I carefully considered turning UBI devices into a UCLASS, but it would
> be a huge major rewrite of how UBI works in U-Boot, and while that would
> be a good thing to do, I consider far beyond the scope of supporting a
> boot method for OpenWrt.

Oh, I just assumed it supports driver model. But surely it must have a
UCLASS_BLK device?

>
> Or did you mean the to-be-create UCLASS_IMAGE_MAPPER?

No I was talking about ubi.

Regards,
Simon
