Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72398E9A04E
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 16:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 645DA83946;
	Thu, 19 Feb 2026 17:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD4A83CD3; Thu, 19 Feb 2026 17:48:23 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6EB583936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 17:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vt7Bx-000000002MQ-0FOH; Thu, 19 Feb 2026 16:47:53 +0000
Date: Thu, 19 Feb 2026 16:47:49 +0000
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
Subject: Re: [RFC PATCH 09/20] boot: fit: support on-demand loading in
 fit_image_load()
Message-ID: <aZc-tSa3jkduf9aJ@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <ab7837536e4567b90d7cb662984dd7e637ef4361.1771275704.git.daniel@makrotopia.org>
 <CAFLszTi3r_6VynzrZKkDNbcucntoEW=4nLCV_q8kv3+vQojLBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszTi3r_6VynzrZKkDNbcucntoEW=4nLCV_q8kv3+vQojLBg@mail.gmail.com>
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

On Thu, Feb 19, 2026 at 06:09:26AM -0700, Simon Glass wrote:
> Hi Daniel,
> 
> On Mon, 16 Feb 2026 at 14:22, Daniel Golle <daniel@makrotopia.org> wrote:
> >
> > Add an on-demand loading path to fit_image_load() for use when
> > images->loader is set (storage-backed boot).
> >
> > For external-data FIT images, the new path avoids dereferencing
> > fit + data_offset (which would point into unmapped memory) and
> > instead:
> >
> > 1. Extracts the data offset and size from FDT properties
> >    (data-position / data-offset + data-size) -- metadata only,
> >    no payload access.
> >
> > 2. Returns early for IH_TYPE_FILESYSTEM sub-images, which stay on
> >    storage and are never loaded into RAM (e.g. squashfs rootfs).
> >
> > 3. Determines the RAM destination:
> >    - If the sub-image has a load address, loads directly there
> >      via image_loader_map_to() (zero-copy).
> >    - Otherwise, allocates scratch RAM via image_loader_map().
> >
> > 4. Verifies the hash/signature in-place using
> >    fit_image_verify_with_data(), which is address-agnostic.
> >
> > 5. Jumps to the common tail, skipping the normal
> >    fit_image_get_data() + memcpy() sequence since data is already
> >    at its final location.
> >
> > The entire path is gated by 'if (images->loader && external)' and
> > USE_HOSTCC, so the existing in-memory flow is completely unchanged
> > when no loader is set or when building host tools.
> >
> > For inline-data FIT images (no data-position/data-offset), the FDT
> > structure loaded during format detection already contains all sub-
> > image data, so the existing path handles them correctly.
> >
> > Also adds a 'struct image_loader *loader' member to struct
> > bootm_headers (initialised to NULL).
> >
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  boot/image-fit.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/image.h  |  4 ++
> >  2 files changed, 100 insertions(+)
> >
> > diff --git a/boot/image-fit.c b/boot/image-fit.c
> > index 3ed69b5f7bc..73d3bf7df08 100644
> > --- a/boot/image-fit.c
> > +++ b/boot/image-fit.c
> > @@ -24,6 +24,7 @@ extern void *aligned_alloc(size_t alignment, size_t size);
> >  #include <linux/sizes.h>
> >  #include <errno.h>
> >  #include <log.h>
> > +#include <image-loader.h>
> >  #include <mapmem.h>
> >  #include <asm/io.h>
> >  #include <malloc.h>
> > @@ -2166,6 +2167,100 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
> >
> >         printf("   Trying '%s' %s subimage\n", fit_uname, prop_name);
> >
> > +#if !defined(USE_HOSTCC) && CONFIG_IS_ENABLED(IMAGE_LOADER)
> 
> This function is far too long so this code should go in its own
> function. Also use if() and tools_build()

I have significantly changed this whole part and folded storage access
into fit_image_get_data(). A pre-loading stage in fit_image_load(), much
fewer lines than the current do-it-all storage path, currently still
remains in fit_image_load(). I will present it soon in a (manually...)
reworked RFCv2 once I looked into and adressed all the other comments
received for the initial RFC.

> 
> > +       /*
> > +        * Storage-backed path: when an image_loader is active and the
> > +        * sub-image uses external data, load the payload from storage
> > +        * instead of dereferencing fit + data_offset. The FDT structure
> > +        * (containing all metadata, hashes, and signatures) is already
> > +        * in RAM; only the payload is on storage.
> > +        *
> > +        * Sequence:
> > +        *  1. Print image info (fit_image_select with verify=0)
> > +        *  2. Extract data location from FDT properties (no data access)
> > +        *  3. Skip IH_TYPE_FILESYSTEM sub-images — they stay on storage
> > +        *  4. Determine RAM destination (load address or scratch area)
> > +        *  5. Read payload via image_loader_map_to() / image_loader_map()
> > +        *  6. Verify hash/signature in-place
> > +        *  7. Jump to common tail (FDT validation, output params)
> > +        */
> > +       if (images && images->loader) {
> > +               int data_off = 0, data_sz = 0;
> > +               bool external = false;
> > +               u8 img_type;
> > +
> > +               if (!fit_image_get_data_position(fit, noffset, &data_off)) {
> > +                       external = true;
> > +               } else if (!fit_image_get_data_offset(fit, noffset, &data_off)) {
> > +                       external = true;
> > +                       data_off += ALIGN(fdt_totalsize(fit), 4);
> > +               }
> > +
> > +               if (external && !fit_image_get_data_size(fit, noffset, &data_sz)) {
> > +                       /* Print image info without verifying data */
> > +                       ret = fit_image_select(fit, noffset, 0);
> > +                       if (ret) {
> > +                               bootstage_error(bootstage_id + BOOTSTAGE_SUB_HASH);
> > +                               return ret;
> > +                       }
> > +
> > +                       /* Skip filesystem images — they stay on storage */
> > +                       if (!fit_image_get_type(fit, noffset, &img_type) &&
> > +                           img_type == IH_TYPE_FILESYSTEM) {
> > +                               *datap = 0;
> > +                               *lenp = 0;
> > +                               return noffset;
> 
> Should add a comment here about why you are not doing verification. I
> assume the FS is protected with dm-verify, iwc should the root hash be
> stored in the FIT?

Yes, I agree with that. A single property won't be enough, so what I
came up with and currently test is a node under the image, ie.

dm-verity {
	block-size = <0x1000>;
	data-blocks = <0xdead>;
	algo = "sha256";
	root-hash = "averylonghashasstring";
	salt = "anotherverylonghashasstring";
};

This is sufficient to then let U-Boot generate the dm-mod.create="..."
parameter handed over to the kernel.

Currently I'm just putting this in the its source file, but of course we
could also extend 'mkimage' to call 'veritysetup format ...' and
populate such section like it is done for the hashes.

