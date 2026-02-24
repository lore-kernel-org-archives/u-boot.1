Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E477F3C989
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 15:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFFEB83642;
	Tue, 24 Feb 2026 16:11:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3215B83D17; Tue, 24 Feb 2026 15:36:47 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FC6E82BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 15:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vutWF-000000005Uf-2vTy; Tue, 24 Feb 2026 14:36:11 +0000
Date: Tue, 24 Feb 2026 14:36:04 +0000
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
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand
 FIT loading
Message-ID: <aZ22GIiBF8wkTgis@makrotopia.org>
References: <aZTBQykqCt7H8H4W@makrotopia.org>
 <20260217193534.GI2747538@bill-the-cat>
 <aZTYk8E6r4S5zo_Z@makrotopia.org>
 <20260217211853.GJ2747538@bill-the-cat>
 <aZTqyRfqYe1iJ9EY@makrotopia.org>
 <20260218155839.GC3233182@bill-the-cat>
 <aZX2APcJvmU4XSIy@makrotopia.org>
 <20260218203314.GG3233182@bill-the-cat>
 <aZzyv1sUrnm2PKBc@makrotopia.org>
 <20260224142446.GO3233182@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224142446.GO3233182@bill-the-cat>
X-Mailman-Approved-At: Tue, 24 Feb 2026 16:11:00 +0100
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

On Tue, Feb 24, 2026 at 08:24:46AM -0600, Tom Rini wrote:
> On Tue, Feb 24, 2026 at 12:37:19AM +0000, Daniel Golle wrote:
> > On Wed, Feb 18, 2026 at 02:33:14PM -0600, Tom Rini wrote:
> > > On Wed, Feb 18, 2026 at 05:25:20PM +0000, Daniel Golle wrote:
> > > > On Wed, Feb 18, 2026 at 09:58:39AM -0600, Tom Rini wrote:
> > > > > On Tue, Feb 17, 2026 at 10:25:13PM +0000, Daniel Golle wrote:
> > > > > > [...]
> > > > > > As the existing code expects the whole image to reside in RAM and only
> > > > > > take care of validation, decompression and relocation, I had to extend
> > > > > > image-fit.c to use the image_loader to only load the parts *from
> > > > > > storage* which are actually needed, and if possible, load them directly
> > > > > > to where they are supposed to go. Imho, the code is simple enough to
> > > > > > just look at it:
> > > > > > 
> > > > > > https://patchwork.ozlabs.org/project/uboot/patch/ab7837536e4567b90d7cb662984dd7e637ef4361.1771275704.git.daniel@makrotopia.org/
> > > > > > 
> > > > > > At this stage (because I first wanted to discuss the general approach)
> > > > > > the patch still skips some parts of image-fit.c, which is obviously not
> > > > > > acceptable for upstream inclusion, but good enough to demonstrate the
> > > > > > idea and also try it in practise.
> > > > > > 
> > > > > > Ie. the 'goto storage_loaded' has to go away and all of image-fit.c has
> > > > > > to be changed to equally work on RAM-backed or storage-backed images.
> > > > > 
> > > > > I was talking with Marek to recall some of the details about what we can
> > > > > and can't (easily..) do today with external data and he remidned me of
> > > > > something. So one big concern here is that we have to be care to not
> > > > > re-open things like:
> > > > > https://nvd.nist.gov/vuln/detail/CVE-2023-39902
> > > > > or otherwise allow for mix-and-match type attacks by having some sort of
> > > > > partial reads allowed.
> > > > > 
> > > > > So a specialized partial-read of FIT images, in full U-Boot (not just
> > > > > SPL), is something to figure out, but may also invalidate one of your
> > > > > design goals because you do have to authenticate the whole image, unless
> > > > > there's something both secure and clever I'm missing.
> > > > 
> > > > The idea here is to have one or more IH_TYPE_FILESYSTEM subimages which
> > > > do not have hash-* subnodes at all, hence, if there is anyway nothing to
> > > > validate and they do not need to be loaded to RAM (ie. no load address),
> > > > they can be skipped entirely, even if listed as 'loadable' (which is how
> > > > the parser in the kernel currently knows which filesystem image to map;
> > > > we could introduce a new property different from 'loadables', of course).
> > > > Everything else which is part of the selected configuration node of
> > > > course has to be loaded and authenticated.
> > > > 
> > > > To compensate for the authentication of IH_TYPE_FILESYSTEM subimages not
> > > > done by U-Boot before launching Linux, the dm-verity root hash passed to
> > > > Linux via cmdline should be part of the signed configuration, eg. by
> > > > including an image of IH_TYPE_SCRIPT modifying 'bootargs', or by coming
> > > > up with a new image type specifically for that purpose. Or, even better
> > > > but a bit more involved, include the dm-verity roothash in the ITS spec
> > > > instead of the hash-* nodes.
> > > > 
> > > > In terms of security, anyway only dm-verity makes sense, as there is no
> > > > point in validating the filesystem subimage if what is validated then
> > > > isn't also what is used -- one could quickly swap the storage device
> > > > after U-Boot has launched the kernel and before Linux mounts the rootfs
> > > > (from storage!) ending up with a different rootfs than what U-Boot had
> > > > previously validated when authenticating the image.
> > > 
> > > Right, OK. What I was thinking about, but Marek corrected me on, is
> > > about where we may or may not have problems about authentication. So
> > > long as we start by reading in the whole of the FIT (which excludes
> > > external data, being external) and start the authentication with that,
> > > we should be fine.
> > > 
> > > I have some other questions / concerns still, but there's also still a
> > > number of other emails I sent that're outstanding. So, can you please
> > > link to an itb that would be making use of your proposed feature? Being
> > > able to examine that would help me be more precise in my own questions,
> > > thanks.
> > 
> > I don't have any option at hand to host larger binaries anywhere public.
> > 
> > If you know any service which allows to do this for free without
> > requiring a complicated and personal-data-exposing sign-up procedure,
> > please let me know, I'll use that.
> 
> Can you use https://www.file.io/ perhaps? And split as needed.

Nice, I didn't know that one. Thank you, that's helpful.

https://limewire.com/d/eJwOl#MYQunGl6LF


> 
> > Meanwhile, as the content of the large data blobs probably anyway
> > doesn't matter for this discussion, here is the decompiled FIT structure:
> 
> It doesn't matter but it does help me when poking around. Thanks for the
> dts dump. But please note I had a several other questions still open. I
> tried to not complicate things by sending them as separate replies but
> maybe that made them harder to see? Thanks.

I'll read up on all your questions in patchwork one more time and try
finding what is still unanswered. Expect my replies today ;)
