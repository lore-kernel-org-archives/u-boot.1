Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059E5E9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 16:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F43C83CF2;
	Thu, 19 Feb 2026 17:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18AE983D17; Thu, 19 Feb 2026 17:57:28 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D9783946
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 17:57:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vt7Ko-000000002Q2-00g2; Thu, 19 Feb 2026 16:57:02 +0000
Date: Thu, 19 Feb 2026 16:56:58 +0000
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
Subject: Re: [RFC PATCH 17/20] boot: bootdev: add UBI boot device
Message-ID: <aZdA2ltaV_0chTPd@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <bc1fb5747051cd6462bf3158250a04ea8e83b14e.1771275704.git.daniel@makrotopia.org>
 <CAFLszTjt+F00+-x0yr7i8=MpxDVgrmaJQJqNpUVTA4cd55TRXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjt+F00+-x0yr7i8=MpxDVgrmaJQJqNpUVTA4cd55TRXQ@mail.gmail.com>
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

On Thu, Feb 19, 2026 at 06:09:31AM -0700, Simon Glass wrote:
> On Mon, 16 Feb 2026 at 14:24, Daniel Golle <daniel@makrotopia.org> wrote:
> > [...]
> > +/**
> > + * ubi_bootdev_hunt() - attach UBI and bind a bootdev for it
> > + *
> > + * Walk the DT for the first partition with compatible = "linux,ubi",
> > + * find its MTD device, attach UBI via ubi_part_from_mtd(), then bind
> > + * a ubi_bootdev as a child of the top-level MTD DM device.
> > + */
> > +static int ubi_bootdev_hunt(struct bootdev_hunter *info, bool show)
> > +{
> > +       struct udevice *bdev;
> > +       struct mtd_info *mtd;
> > +       ofnode node;
> > +       int ret;
> > +
> > +       mtd_probe_devices();
> > +
> > +       if (!ubi_devices[0]) {
> > +               ofnode_for_each_compatible_node(node, "linux,ubi") {
> > +                       mtd_for_each_device(mtd) {
> > +                               if (ofnode_equal(mtd->flash_node, node))
> > +                                       goto found;
> > +                       }
> > +               }
> > +               return -ENOENT;
> 
> Eek no we need to find the device, not the node. There must surely be
> a link between the UBI and MTD in the data structures somewhere.

Yes, but only once UBI is already attached. We can move the responsibiltiy
to auto-attach the first suitable UBI volume having the 'linux, ubi'
compatible to the moment the MTD partition devices are created, so UBI
will always already be attached. However, that will then waste time to
do the UBI scanning even on devices not using UBI to boot from (but eg.
only as auxilary storage while booting from NOR flash). Hence I kinda
liked taking care of the UBI attachment in the hunter...

