Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC53E9A04E
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 16:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2DE683946;
	Thu, 19 Feb 2026 17:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 408C483CEE; Thu, 19 Feb 2026 17:51:47 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31FD683936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 17:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vt7FD-000000002Nc-337v; Thu, 19 Feb 2026 16:51:15 +0000
Date: Thu, 19 Feb 2026 16:51:11 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
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
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: Re: [RFC PATCH 08/20] boot: image-loader: add UBI volume backend
Message-ID: <aZc_f3lrmRdE9c3Z@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <47725c58588200f631c918a56b770454d5721954.1771275704.git.daniel@makrotopia.org>
 <CAFLszThSKbRjufnj4z4xunn-OEUv8kNRngNQ3=EpaNyvyV5ncg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThSKbRjufnj4z4xunn-OEUv8kNRngNQ3=EpaNyvyV5ncg@mail.gmail.com>
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

On Thu, Feb 19, 2026 at 06:09:27AM -0700, Simon Glass wrote:
> Hi Daniel,
> 
> On Mon, 16 Feb 2026 at 14:22, Daniel Golle <daniel@makrotopia.org> wrote:
> >
> > Add a UBI volume storage backend for the image_loader framework.
> >
> > image_loader_init_ubi() takes a volume name, ensures the UBI device
> > is attached (auto-attaching if needed), and installs a .read() callback
> > wrapping ubi_volume_read().
> >
> > Auto-attach works by scanning the device tree for the first MTD
> > partition with compatible = "linux,ubi", then calling ubi_part() on
> > that partition. The partition name is resolved using the same
> > precedence as the MTD partition parser: the "label" property first,
> > then "name", then the node name. Since U-Boot only supports a single
> > attached UBI device at a time, only the first matching partition is
> > used. If a UBI device is already attached, the auto-attach step is
> > skipped.
> >
> > UBI handles bad-block management and wear leveling internally, so the
> > read callback is a straightforward passthrough. Note that
> > ubi_volume_read() returns positive errno values; the wrapper negates
> > them for the image_loader convention.
> >
> > Gated by CONFIG_IMAGE_LOADER_UBI (depends on CMD_UBI && IMAGE_LOADER).
> >
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  boot/Kconfig            |   8 +++
> >  boot/Makefile           |   1 +
> >  boot/image-loader-ubi.c | 112 ++++++++++++++++++++++++++++++++++++++++
> >  include/image-loader.h  |  13 +++++
> >  4 files changed, 134 insertions(+)
> >  create mode 100644 boot/image-loader-ubi.c
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 23848a0f57e..89832014af6 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -1203,6 +1203,14 @@ config IMAGE_LOADER_MTD
> >           parallel NAND, etc.) using the image_loader framework.
> >           NAND bad blocks are skipped transparently.
> >
> > +config IMAGE_LOADER_UBI
> > +       bool "UBI volume backend for image loader"
> > +       depends on IMAGE_LOADER && CMD_UBI
> > +       help
> > +         Allows loading images from UBI volumes using the image_loader
> > +         framework. Auto-attaches the UBI device from the device tree
> > +         if not already attached.
> > +
> >  config DISTRO_DEFAULTS
> >         bool "(deprecated) Script-based booting of Linux distributions"
> >         select CMDLINE
> > diff --git a/boot/Makefile b/boot/Makefile
> > index 1dde16db694..7d1d4a28106 100644
> > --- a/boot/Makefile
> > +++ b/boot/Makefile
> > @@ -76,6 +76,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o
> >  obj-$(CONFIG_IMAGE_LOADER) += image-loader.o
> >  obj-$(CONFIG_IMAGE_LOADER_BLK) += image-loader-blk.o
> >  obj-$(CONFIG_IMAGE_LOADER_MTD) += image-loader-mtd.o
> > +obj-$(CONFIG_IMAGE_LOADER_UBI) += image-loader-ubi.o
> >
> >  obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC) += vbe_abrec.o vbe_common.o
> >  obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC_FW) += vbe_abrec_fw.o
> > diff --git a/boot/image-loader-ubi.c b/boot/image-loader-ubi.c
> > new file mode 100644
> > index 00000000000..64901a13378
> > --- /dev/null
> > +++ b/boot/image-loader-ubi.c
> > @@ -0,0 +1,112 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * UBI volume backend for image_loader
> > + *
> > + * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
> > + */
> > +
> > +#include <dm/ofnode.h>
> > +#include <image-loader.h>
> > +#include <log.h>
> > +#include <malloc.h>
> > +#include <mtd.h>
> > +#include <ubi_uboot.h>
> > +
> > +struct image_loader_ubi_priv {
> > +       char *vol_name;
> > +};
> > +
> > +/**
> > + * ubi_auto_attach() - attach UBI if not already attached
> > + *
> > + * If no UBI device is currently attached, walk the device tree for the
> > + * first MTD partition node with compatible = "linux,ubi", find the
> > + * corresponding MTD device by matching flash_node, and attach UBI to
> > + * it via ubi_part_from_mtd().
> > + *
> > + * Since U-Boot only supports a single attached UBI device at a time,
> > + * only the first matching partition is used.
> > + *
> > + * Return: 0 on success or if already attached, negative errno on failure
> > + */
> > +static int ubi_auto_attach(void)
> > +{
> > +       struct mtd_info *mtd;
> > +       ofnode node;
> > +
> > +       /* Already attached? */
> > +       if (ubi_devices[0])
> > +               return 0;
> > +
> > +       mtd_probe_devices();
> 
> This should be handled by your new ubi driver for your uclass.
> 
> > +
> > +       ofnode_for_each_compatible_node(node, "linux,ubi") {
> > +               mtd_for_each_device(mtd) {
> > +                       if (ofnode_equal(mtd->flash_node, node))
> > +                               goto found;
> > +               }
> > +       }
> 
> Eek this is really strange. There should be a device so you can use
> uclass_first_device(UCLASS_...).

I carefully considered turning UBI devices into a UCLASS, but it would
be a huge major rewrite of how UBI works in U-Boot, and while that would
be a good thing to do, I consider far beyond the scope of supporting a
boot method for OpenWrt.

Or did you mean the to-be-create UCLASS_IMAGE_MAPPER?
