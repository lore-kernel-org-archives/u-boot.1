Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201DBE9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 16:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D4E083946;
	Thu, 19 Feb 2026 17:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87C2883D0B; Thu, 19 Feb 2026 17:52:32 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 917AD83946
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 17:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vt7G2-000000002OR-2RxY; Thu, 19 Feb 2026 16:52:06 +0000
Date: Thu, 19 Feb 2026 16:52:02 +0000
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
Subject: Re: [RFC PATCH 13/20] boot: bootmeth: add OpenWrt boot method skeleton
Message-ID: <aZc_sh55r2m0QDHS@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <46dcab5fc58e9116ca017a63ed07922ae3093913.1771275704.git.daniel@makrotopia.org>
 <CAFLszTiE82Bo1PbvK7Lx7P4Gq=-z+hhgLcgXORtSrYha4R7sBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTiE82Bo1PbvK7Lx7P4Gq=-z+hhgLcgXORtSrYha4R7sBg@mail.gmail.com>
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

On Thu, Feb 19, 2026 at 06:09:28AM -0700, Simon Glass wrote:
> On Mon, 16 Feb 2026 at 14:23, Daniel Golle <daniel@makrotopia.org> wrote:
> >
> > Add the initial bootmeth_openwrt driver with:
> >
> > - UCLASS_BOOTMETH driver, compatible "u-boot,openwrt"
> > - check(): accept block devices via bootflow_iter_check_blk()
> > - bind(): set BOOTMETHF_ANY_PART so bootstd iterates all partitions
> >   without requiring a filesystem
> > - read_bootflow(): stub returning -ENOENT
> > - boot(): stub returning -ENOSYS
> > - Kconfig: CONFIG_BOOTMETH_OPENWRT depending on FIT, BOOTSTD,
> >   BOOTM_STORAGE
> 
> We don't normally write out this much detail in the code

Yeah, that's Claude does, I'll drop the code description and only keep
the part below.

> 
> >
> > This is the foundation for booting OpenWrt-style uImage.FIT firmware
> > images stored directly on raw storage partitions. The bootmeth will
> > delegate actual image loading to the existing bootm storage path via
> > image_loader.
> >
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  boot/Kconfig            | 13 +++++++++
> >  boot/Makefile           |  1 +
> >  boot/bootmeth_openwrt.c | 65 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 79 insertions(+)
> >  create mode 100644 boot/bootmeth_openwrt.c
> 
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
> 
> 
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index efc06f3cd1a..d8c7b8360ac 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -585,6 +585,19 @@ config BOOTMETH_CROS
> >
> >           Note that only x86 devices are supported at present.
> >
> > +config BOOTMETH_OPENWRT
> > +       bool "Bootdev support for OpenWrt"
> > +       depends on FIT
> > +       depends on BOOTSTD
> > +       depends on BOOTM_STORAGE
> > +       help
> > +         Enables support for booting OpenWrt-style uImage.FIT firmware
> > +         images stored directly on raw storage (block device partitions,
> > +         MTD partitions, or UBI volumes). The boot method loads the FIT
> > +         metadata, selectively reads only the kernel and FDT sub-images
> > +         from storage, and skips filesystem sub-images that Linux maps
> > +         directly from flash.
> > +
> >  config BOOTMETH_EXTLINUX
> >         bool "Bootdev support for extlinux boot"
> >         select PXE_UTILS
> > diff --git a/boot/Makefile b/boot/Makefile
> > index 7d1d4a28106..7b42358eb0c 100644
> > --- a/boot/Makefile
> > +++ b/boot/Makefile
> > @@ -72,6 +72,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_FW) += vbe_simple_fw.o
> >  obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_OS) += vbe_simple_os.o
> >
> >  obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o
> > +obj-$(CONFIG_$(PHASE_)BOOTMETH_OPENWRT) += bootmeth_openwrt.o
> >
> >  obj-$(CONFIG_IMAGE_LOADER) += image-loader.o
> >  obj-$(CONFIG_IMAGE_LOADER_BLK) += image-loader-blk.o
> > diff --git a/boot/bootmeth_openwrt.c b/boot/bootmeth_openwrt.c
> > new file mode 100644
> > index 00000000000..02bf543031b
> > --- /dev/null
> > +++ b/boot/bootmeth_openwrt.c
> > @@ -0,0 +1,65 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Bootmethod for OpenWrt
> > + *
> > + * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
> > + */
> > +
> > +#define LOG_CATEGORY UCLASS_BOOTSTD
> > +
> > +#include <blk.h>
> > +#include <bootdev.h>
> > +#include <bootflow.h>
> > +#include <bootm.h>
> > +#include <bootmeth.h>
> > +#include <dm.h>
> > +#include <image-loader.h>
> > +#include <malloc.h>
> > +#include <mapmem.h>
> > +
> > +static int openwrt_check(struct udevice *dev, struct bootflow_iter *iter)
> > +{
> > +       if (bootflow_iter_check_blk(iter))
> > +               return log_msg_ret("blk", -EOPNOTSUPP);
> > +
> > +       return 0;
> > +}
> > +
> > +static int openwrt_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> > +{
> > +       return log_msg_ret("nyi", -ENOENT);
> > +}
> > +
> > +static int openwrt_boot(struct udevice *dev, struct bootflow *bflow)
> > +{
> > +       return log_msg_ret("nyi", -ENOSYS);
> > +}
> > +
> > +static int openwrt_bootmeth_bind(struct udevice *dev)
> > +{
> > +       struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
> > +
> > +       plat->desc = "OpenWrt";
> > +       plat->flags = BOOTMETHF_ANY_PART;
> > +
> > +       return 0;
> > +}
> > +
> > +static struct bootmeth_ops openwrt_bootmeth_ops = {
> > +       .check          = openwrt_check,
> > +       .read_bootflow  = openwrt_read_bootflow,
> > +       .boot           = openwrt_boot,
> > +};
> > +
> > +static const struct udevice_id openwrt_bootmeth_ids[] = {
> > +       { .compatible = "u-boot,openwrt" },
> > +       { }
> > +};
> > +
> > +U_BOOT_DRIVER(bootmeth_openwrt) = {
> > +       .name           = "bootmeth_openwrt",
> > +       .id             = UCLASS_BOOTMETH,
> > +       .of_match       = openwrt_bootmeth_ids,
> > +       .ops            = &openwrt_bootmeth_ops,
> > +       .bind           = openwrt_bootmeth_bind,
> > +};
> > --
> > 2.53.0
