Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A21CE83848
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 01:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A84383B8A;
	Tue, 17 Feb 2026 02:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D635483C61; Tue, 17 Feb 2026 02:19:13 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D18C83AC5
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 02:19:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs9ji-00000000497-17Xu; Tue, 17 Feb 2026 01:18:46 +0000
Date: Tue, 17 Feb 2026 01:18:42 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
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
Message-ID: <aZPB8o9bvkNNpGT6@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <49aa54f6-78a0-4eb4-bd60-d7e17263e586@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49aa54f6-78a0-4eb4-bd60-d7e17263e586@mailbox.org>
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

Hi Marek,

thanks for taking a look at the series!

Let me reply inline below:

On Mon, Feb 16, 2026 at 11:16:24PM +0100, Marek Vasut wrote:
> On 2/16/26 10:21 PM, Daniel Golle wrote:
> 
> Hi,
> 
> > This RFC series adds a new boot method for OpenWrt's "uImage.FIT with
> > embedded rootfs" firmware model, along with the underlying infrastructure
> > to load FIT images on-demand directly from storage devices without copying
> > them entirely to RAM first.
> > 
> > I would like to discuss the design with U-Boot maintainers and fellow
> > OpenWrt developers before submitting a formal patch series.
> 
> [...]
> 
> > 4. On-demand loading: None of the existing methods support loading FIT
> >     subimages directly from storage. OpenWrt's FIT images typically
> >     contain a 5-20 MB squashfs that does NOT need to be copied to RAM —
> >     the kernel maps it directly from flash. The bootloader only needs
> >     to load the kernel and DTB (~5-10 MB), not the entire 20-50 MB
> >     container. This requires a new loading abstraction.
> 
> Isn't this partial loading exactly what SPL does when the fitImage is
> generated with external data (mkimage -E) ? SPL loads and traverses the
> tree, and then loads the remaining chunks (files) only when needed if I
> recall it right ?

Yes, the image_loader abstraction in this series is essentially the
main-U-Boot equivalent of SPL's spl_load_info.read(), adapted for the
richer set of storage backends, byte-addressed, providing an interface
for both "load this to where ever" and "load this to a specific target
address" (image_loader_map() vs. image_loader_map_to()), and the full
fit_image_load() verification pipeline. The integration point in
fit_image_load() (patch 09/20) is ~50 lines of new code gated by if
(images->loader && external_data) - it reuses all existing FIT property
parsing, load address negotiation, and hash verification unchanged.

That said, the image_loader abstraction itself is format-agnostic - it
only deals with byte offsets, lengths, and RAM destinations. The same
three storage backends could be wired into other executable formats with
minimal effort, such as ELF, legacy uImage or UEFI PE.

Likewise, adding a backend based on fs_read() would be trivial,
extending U-Boot's wget to support range requests and using it as
image_loader backend would not be hard either.

> Can that SPL code be reused instead ?

I considered factoring out a shared "FIT external data reader" between
SPL and U-Boot proper, but the two callers want fundamentally different
things: SPL wants minimal code size and populates spl_image_info; U-Boot
proper wants full verification and populates bootm_headers. The shared
part wouldn't be much more than just the two fdt_getprop_u32() calls to
read data-offset and data-size, which didn't seem worth an abstraction
layer.

- SPL doesn't track what's already in RAM. If it needs the same data
  twice (e.g. re-reading the FDT after discovering its full size), it
  reads from storage again.

- No caching - no equivalent of image_loader_lookup() that returns a
  previously-loaded region.

- No allocation tracking - no alloc_ptr bump allocator. SPL code
  manually manages destination addresses.

- No map() / map_to() distinction - SPL always provides an explicit
  destination buffer. There's no "load this somewhere, I don't care where"
  semantic.

- No cleanup - no resource lifetime management, no refcounting of
  underlying devices.

Anyway, I'm happy to reconsider if there's a specific shared interface
you have in mind, or if you believe it's worth (or even possible due
to size constraints) to extend SPL's loader code.
