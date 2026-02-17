Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871CDE68171
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 13:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2B58063E;
	Tue, 17 Feb 2026 14:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C6AB83AC5; Tue, 17 Feb 2026 14:02:53 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9CD880325
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 14:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vsKiW-000000006Zp-427T; Tue, 17 Feb 2026 13:02:17 +0000
Date: Tue, 17 Feb 2026 13:02:12 +0000
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
Message-ID: <aZRm1DVkEgUtInqt@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <49aa54f6-78a0-4eb4-bd60-d7e17263e586@mailbox.org>
 <aZPB8o9bvkNNpGT6@makrotopia.org>
 <dd636864-2e3e-4701-9e42-fd32353afe92@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd636864-2e3e-4701-9e42-fd32353afe92@mailbox.org>
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

On Tue, Feb 17, 2026 at 03:04:09AM +0100, Marek Vasut wrote:
> On 2/17/26 2:18 AM, Daniel Golle wrote:
> > Hi Marek,
> > 
> > thanks for taking a look at the series!
> > 
> > Let me reply inline below:
> > 
> > On Mon, Feb 16, 2026 at 11:16:24PM +0100, Marek Vasut wrote:
> > > On 2/16/26 10:21 PM, Daniel Golle wrote:
> > > 
> > > Hi,
> > > 
> > > > This RFC series adds a new boot method for OpenWrt's "uImage.FIT with
> > > > embedded rootfs" firmware model, along with the underlying infrastructure
> > > > to load FIT images on-demand directly from storage devices without copying
> > > > them entirely to RAM first.
> > > > 
> > > > I would like to discuss the design with U-Boot maintainers and fellow
> > > > OpenWrt developers before submitting a formal patch series.
> > > 
> > > [...]
> > > 
> > > > 4. On-demand loading: None of the existing methods support loading FIT
> > > >      subimages directly from storage. OpenWrt's FIT images typically
> > > >      contain a 5-20 MB squashfs that does NOT need to be copied to RAM —
> > > >      the kernel maps it directly from flash. The bootloader only needs
> > > >      to load the kernel and DTB (~5-10 MB), not the entire 20-50 MB
> > > >      container. This requires a new loading abstraction.
> > > 
> > > Isn't this partial loading exactly what SPL does when the fitImage is
> > > generated with external data (mkimage -E) ? SPL loads and traverses the
> > > tree, and then loads the remaining chunks (files) only when needed if I
> > > recall it right ?
> > 
> > Yes, the image_loader abstraction in this series is essentially the
> > main-U-Boot equivalent of SPL's spl_load_info.read(), adapted for the
> > richer set of storage backends, byte-addressed, providing an interface
> > for both "load this to where ever" and "load this to a specific target
> > address" (image_loader_map() vs. image_loader_map_to()), and the full
> > fit_image_load() verification pipeline. The integration point in
> > fit_image_load() (patch 09/20) is ~50 lines of new code gated by if
> > (images->loader && external_data) - it reuses all existing FIT property
> > parsing, load address negotiation, and hash verification unchanged.
> > 
> > That said, the image_loader abstraction itself is format-agnostic - it
> > only deals with byte offsets, lengths, and RAM destinations. The same
> > three storage backends could be wired into other executable formats with
> > minimal effort, such as ELF, legacy uImage or UEFI PE.
> > 
> > Likewise, adding a backend based on fs_read() would be trivial,
> > extending U-Boot's wget to support range requests and using it as
> > image_loader backend would not be hard either.
> > 
> > > Can that SPL code be reused instead ?
> > 
> > I considered factoring out a shared "FIT external data reader" between
> > SPL and U-Boot proper, but the two callers want fundamentally different
> > things: SPL wants minimal code size and populates spl_image_info; U-Boot
> > proper wants full verification and populates bootm_headers.
> 
> I suspect the feature set of each loading stage can be configured e.g. using
> "if (IS_ENABLED(...))" to keep the size under control ?
> 
> I would be very happy if we could have ONE consistent code base used for
> loading in all of TPL/SPL/U-Boot . Custom special loader in U-Boot and
> different special loader in SPL and so on, will only lead to inconsistency
> and increased maintenance burden. Worse, it will lead to obscure bugs which
> will differ between U-Boot and SPL, or bugs being fixed in one and not the
> other.

This implies changing the parameter "ulong sector" to a byte offset,
which means all existing readers and users will have to be changed as
well, and also code to deal with unaligned start offsets will have to be
added. Other than that it's mostly a matter of adding some #ifdef-ery,
conditionally extending struct spl_load_info with
 - a cleanup callback function pointer
 - alloc_ptr for bump allocator
 - the array of already mapped regions

None of that is used by the readers, so the low-level spl_mmc reader
could be reused and extended -- but it's already very messy with many
hacks and special cases, it's own device and partition hunters, ...
and would basically need adding almost all of the code which is currently
in image-loader-blk.c (to handle the unaligned start offset, ...)

The other SPL readers are even more unsuitable:

 - The SPI-NOR and NOR readers lack support for MTD partitions, instead
   they are using a downstream DT property to specify *one* static offset
   ('u-boot,spl-payload-offset')

 - The UBI reader deals only with static UBI volumes, and support for UBI
   in SPL is a light-weight minimal thing incompatible with the full UBI
   implementation in U-Boot proper.

 - The FIT reader in SPL uses a very different approach from the
   image_loader approach I suggested. It is basically a minimal
   implementation of a FIT parser, while I'm suggesting to glue
   support for the image_loader into boot/image-fit.c of U-Boot proper,
   hence keeping and reusing all of its features.
   See patch "boot: fit: support on-demand loading in fit_image_load()".

So there really isn't much overlap other than the fact that there is a
struct with a priv pointer and a .read callback, and even that uses a
different addressing parameter (sectors vs. bytes).

Imho, trying to unite the two "with a hammer" will do more harm than good.
