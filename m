Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC836E9A03B
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 21:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAFBB83AC5;
	Tue, 17 Feb 2026 22:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEC3083B99; Tue, 17 Feb 2026 22:08:05 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9697083981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 22:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vsSIC-000000000Mq-47dT; Tue, 17 Feb 2026 21:07:37 +0000
Date: Tue, 17 Feb 2026 21:07:31 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
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
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand
 FIT loading
Message-ID: <aZTYk8E6r4S5zo_Z@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <20260217181358.GE2747538@bill-the-cat>
 <aZTBQykqCt7H8H4W@makrotopia.org>
 <20260217193534.GI2747538@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260217193534.GI2747538@bill-the-cat>
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

On Tue, Feb 17, 2026 at 01:35:34PM -0600, Tom Rini wrote:
> On Tue, Feb 17, 2026 at 07:28:03PM +0000, Daniel Golle wrote:
> > On Tue, Feb 17, 2026 at 12:13:58PM -0600, Tom Rini wrote:
> > > On Mon, Feb 16, 2026 at 09:21:14PM +0000, Daniel Golle wrote:
> > > > Hi all,
> > > >=20
> > > > This RFC series adds a new boot method for OpenWrt's "uImage.FIT wi=
th
> > > > embedded rootfs" firmware model, along with the underlying infrastr=
ucture
> > > > to load FIT images on-demand directly from storage devices without =
copying
> > > > them entirely to RAM first.
> > > >=20
> > > > I would like to discuss the design with U-Boot maintainers and fell=
ow
> > > > OpenWrt developers before submitting a formal patch series.
> > > [snip]
> > > > Three storage backends:
> > > >=20
> > > >   - Block device (eMMC, SD, SATA, NVMe, USB mass storage, virtio)
> > > >   - MTD (SPI-NOR, raw NOR, raw NAND with bad block skipping)
> > > >   - UBI volume (SPI-NAND, raw NAND)
> > > >=20
> > > > The "bootm" command is extended to accept a storage device specific=
ation
> > > > instead of a RAM address:
> > > >=20
> > > >   bootm mmc 0:4         # boot FIT from eMMC partition 4
> > > >   bootm mtd recovery    # boot FIT from MTD partition "recovery"
> > > >   bootm ubi recovery    # boot FIT from UBI volume "recovery"
> > > >=20
> > > > This infrastructure is independently useful beyond the OpenWrt boot
> > > > method. Any board that stores a FIT image directly in a partition
> > > > (rather than as a file on a filesystem) can benefit from on-demand
> > > > subimage loading.
> > >=20
> > > For the user interface portion of this, since this is implementing
> > > bootmeths, this should all be handled under bootflow/bootdev/etc
> > > commands, and not adding further options to bootm.
> >=20
> > I thought it would be useful independently of bootmeth/bootflow/bootdev
> > for `bootm` to have these options, as it will allow to gradually migrate
> > a large number of our downstream boards. Many of them at this point
> > still require scripts to handle things like extracting MAC addresses
> > from flash (in ways the original vendor has decided to store them),
> > updating U-Boot or TF-A blobs, ... and migrating all of that to use
> > bootmeth/bootflow/... will take time.
> >=20
> > In the meantime, already getting rid of (duplicate) scripts "read
> > firmware from mmc/ubi/mtd" would be feasible, is less of a burden and
> > easy to test for people who got the respective board at hand.
> >=20
> > Also, testing loading (partial) images directly from storage outside
> > of bootmeth has been very useful during development.
> >=20
> > Would it be an option to hide the new bootm cmdline features behind an
> > additional Kconfig option maybe?
>=20
> I worry that if we add this to bootm upstream, it'll be another
> interface that can't ever go away. Building off of another bit of
> feedback I sent after this message here, I think the testing side of
> this support should be handled with CMD_something.._GENERIC, similar to
> CMD_FS_GENERIC.

Hm... The tricky part is kinda not the "load from somewhere" as that
just ends up calling the .read() op, which usually is more or less
identical to what some existing commands are already doing, hence easy
to use 'mmc read ...', 'mtd read ...', 'ubi read ...' for testing.
Seeing that all the steps in 'bootm' are working, sub-images are
correctly loaded (or skipped), verification steps (hashes, signature,
=2E..) are all working was the more difficult part...

> But perhaps not as one other part of this I wanted to ask about is,
> does this only support reading FIT images which set their load
> address? Or is there a call somewhere to lmb_alloc to grab an arbitrary
> hunk of memory somewhere?

In order to kinda do the same as was happening previously when first
loading the whole image from flash to $loadaddr, I've implemented a
trivial allocator for chunks with no defined load address in FIT.
In this case, image_loader_map() is called and loads to alloc_ptr,
which points to $loadaddr on init, and is then bumped by the
size loaded. I can use the lmb allocator instead, it's cleaner than
open-coding this.
In case of known load address (ie. specified for that sub-image in FIT)
and compression being IH_COMP_NONE, image_loader_map_to() is called
which directly loads that sub-image to the specified target address, no
allocation what-so-ever.

>=20
> > > Since you're also talking about an A/B mechanism, looking at the RAUC
> > > support may also be helpful as that's another widely deployed
> > > methodology we support now via standard boot.
> >=20
> > Yes, I've looked into RAUC and it has (more or less) recently gained
> > support for UBI, which indeed brings it closer to being useful in the
> > context of OpenWrt.
>=20
> To be clear, I just meant in terms of how to implement a bootmeth that
> is not just EFI or distro boot but instead something else also aimed at
> real world end user devices. Lots of people have a Steam Deck and a
> router built on top of OpenWrt :)

+1
