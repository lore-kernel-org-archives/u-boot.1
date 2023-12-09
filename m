Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FD8C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 15:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F32D87660;
	Sat,  9 Dec 2023 16:29:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FHFbiXTn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 104C98761B; Sat,  9 Dec 2023 16:29:44 +0100 (CET)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7F8A874CA
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 16:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=laurent.pinchart@ideasonboard.com
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi
 [213.243.189.158])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 15A7E25A;
 Sat,  9 Dec 2023 16:28:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1702135738;
 bh=6hFFvOxTW1/3aaX8jGizMoDG6E623DXFkvEtdM2wg6k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FHFbiXTn7OCz6eGZWAAKCsnzsdPUOmgiE2RC/qUzjEe8w6I54K6l92xZq2dSsjKBI
 B9CQDVr+RhQJ+qN7XOLzN3ZqdzOcisy+LTxGZlOTUMQOgpywLKyQRlgInt0vyjxRQd
 0uUPyZ8UFTDQjVtBV2adaVy0tEIlRybFmoW2Sag0=
Date: Sat, 9 Dec 2023 17:29:46 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Simon Glass <sjg@chromium.org>, linux-arm-kernel@lists.infradead.org,
 Masahiro Yamada <masahiroy@kernel.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Nicolas Schier <nicolas@fjasle.eu>, Tom Rini <trini@konsulko.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>,
 Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
Message-ID: <20231209152946.GC13421@pendragon.ideasonboard.com>
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com>
 <20231207142723.GA3187877@google.com>
 <20231207143814.GD15521@pendragon.ideasonboard.com>
 <CAGXv+5Go_0pEVAOLQmRCc_a9-YUtZEmBfXtMuBupX_nb9iqwbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5Go_0pEVAOLQmRCc_a9-YUtZEmBfXtMuBupX_nb9iqwbw@mail.gmail.com>
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

On Sat, Dec 09, 2023 at 10:13:59PM +0900, Chen-Yu Tsai wrote:
> On Thu, Dec 7, 2023 at 11:38 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > On Thu, Dec 07, 2023 at 10:27:23PM +0800, Chen-Yu Tsai wrote:
> > > On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinchart wrote:
> > > > Hi Simon,
> > > >
> > > > Thank you for the patch.
> > > >
> > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > > > > Add a script which produces a Flat Image Tree (FIT), a single file
> > > > > containing the built kernel and associated devicetree files.
> > > > > Compression defaults to gzip which gives a good balance of size and
> > > > > performance.
> > > > >
> > > > > The files compress from about 86MB to 24MB using this approach.
> > > > >
> > > > > The FIT can be used by bootloaders which support it, such as U-Boot
> > > > > and Linuxboot. It permits automatic selection of the correct
> > > > > devicetree, matching the compatible string of the running board with
> > > > > the closest compatible string in the FIT. There is no need for
> > > > > filenames or other workarounds.
> > > > >
> > > > > Add a 'make image.fit' build target for arm64, as well. Use
> > > > > FIT_COMPRESSION to select a different algorithm.
> > > > >
> > > > > The FIT can be examined using 'dumpimage -l'.
> > > > >
> > > > > This features requires pylibfdt (use 'pip install libfdt'). It also
> > > > > requires compression utilities for the algorithm being used. Supported
> > > > > compression options are the same as the Image.xxx files. For now there
> > > > > is no way to change the compression other than by editing the rule for
> > > > > $(obj)/image.fit
> > > > >
> > > > > While FIT supports a ramdisk / initrd, no attempt is made to support
> > > > > this here, since it must be built separately from the Linux build.
> > > >
> > > > FIT images are very useful, so I think this is a very welcome addition
> > > > to the kernel build system. It can get tricky though: given the
> > > > versatile nature of FIT images, there can't be any
> > > > one-size-fits-them-all solution to build them, and striking the right
> > > > balance between what makes sense for the kernel and the features that
> > > > users may request will probably lead to bikeshedding. As we all love
> > > > bikeshedding, I thought I would start selfishly, with a personal use
> > > > case :-) This isn't a yak-shaving request though, I don't see any reason
> > > > to delay merging this series.
> > > >
> > > > Have you envisioned building FIT images with a subset of DTBs, or adding
> > > > DTBOs ? Both would be fairly trivial extensions to this script by
> > > > extending the supported command line arguments. It would perhaps be more
> > > > difficult to integrate in the kernel build system though. This leads me
> > > > to a second question: would you consider merging extensions to this
> > > > script if they are not used by the kernel build system, but meant for
> > > > users who manually invoke the script ? More generally, is the script
> > >
> > > We'd also be interested in some customization, though in a different way.
> > > We imagine having a rule file that says X compatible string should map
> > > to A base DTB, plus B and C DTBO for the configuration section. The base
> > > DTB would carry all common elements of some device, while the DTBOs
> > > carry all the possible second source components, like different display
> > > panels or MIPI cameras for instance. This could drastically reduce the
> > > size of FIT images in ChromeOS by deduplicating all the common stuff.
> >
> > Do you envision the "mapping" compatible string mapping to a config
> > section in the FIT image, that would bundle the base DTB and the DTBOs ?
> 
> That's exactly the idea. The mapping compatible string could be untied
> from the base board's compatible string if needed (which we probably do).
> 
> So something like:
> 
> config {
>     config-1 {
>         compatible = "google,krane-sku0";
>         fdt = "krane-baseboard", "krane-sku0-overlay";
>     };
> };
> 
> With "krane-sku0-overlay" being an overlay that holds the differences
> between the SKUs, in this case the display panel and MIPI camera (not
> upstreamed) that applies to SKU0 in particular.

The kernel DT makefiles already contain information on what overlays to
apply to what base boards, in order to test the overlays and produce
"full" DTBs. Maybe that information could be leveraged to create the
configurations in the FIT image ?

> Sorry for not giving a more concrete idea.
> 
> > > > meant to be used stand-alone as well, in which case its command line
> > > > arguments need to remain backward-compatible, or do you see it as being
> > > > internal to the kernel ?
> > >
> > > [...]

-- 
Regards,

Laurent Pinchart
