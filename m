Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4253CC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 15:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C08088675F;
	Thu, 24 Aug 2023 17:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5F5286795; Thu, 24 Aug 2023 17:52:24 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 428558609B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 17:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch
 [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id 62F8520395;
 Thu, 24 Aug 2023 17:52:21 +0200 (CEST)
Date: Thu, 24 Aug 2023 17:52:17 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>, u-boot@lists.denx.de,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1 2/2] board: verdin-am62: fix check for minimum memory
 size
Message-ID: <ZOd8sW83t7M2Cmyt@francesco-nb.int.toradex.com>
References: <20230824080850.1755724-1-ghidoliemanuele@gmail.com>
 <20230824080850.1755724-3-ghidoliemanuele@gmail.com>
 <20230824121412.vxgvwo5g2ozk62xt@evergreen>
 <ZOdrQzhxGVYyYobd@francesco-nb.int.toradex.com>
 <20230824145856.qppuhw6kjfr4bkwr@sandbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824145856.qppuhw6kjfr4bkwr@sandbox>
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

On Thu, Aug 24, 2023 at 09:58:56AM -0500, Nishanth Menon wrote:
> On 16:37-20230824, Francesco Dolcini wrote:
> > Hello Nishanth,
> > 
> > On Thu, Aug 24, 2023 at 07:14:12AM -0500, Nishanth Menon wrote:
> > > On 10:08-20230824, Emanuele Ghidoli wrote:
> > > > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > > > 
> > > > verdin am62 SKUs comes in multiple memory configuration, check that
> > > > the detected memory is at least 512MB since we have some
> > > > reserved memory just before this threshold and therefore
> > > > the module cannot work with less memory.
> > > > 
> > > > Fixes: 7d1a10659f5b ("board: toradex: add verdin am62 support")
> > > > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > > > ---
> > > >  board/toradex/verdin-am62/verdin-am62.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
> > > > index a3d1d07a0cbf..d09dda5bccc9 100644
> > > > --- a/board/toradex/verdin-am62/verdin-am62.c
> > > > +++ b/board/toradex/verdin-am62/verdin-am62.c
> > > > @@ -28,8 +28,8 @@ int dram_init(void)
> > > >  {
> > > >  	gd->ram_size = get_ram_size((long *)CFG_SYS_SDRAM_BASE, CFG_SYS_SDRAM_SIZE);
> > > >  
> > > > -	if (gd->ram_size < SZ_64M)
> > > > -		puts("## WARNING: Less than 64MB RAM detected\n");
> > > > +	if (gd->ram_size < SZ_512M)
> > > > +		puts("## WARNING: Less than 512MB RAM detected\n");
> > > 
> > > Have you considered fdtdec_setup_mem_size_base
> > > fdtdec_setup_memory_banksize  - in which case the reserved memory
> > > regions can be changed in dt (will need corresponding custom binaries
> > > ofcourse)..
> > 
> > I would say that custom binaries is not something we want. Our goal is
> > to rely on whatever TI is providing and to not deviate from it unless
> > required. Luckily enough for the moment it works since our
> > minimum memory size is 512MB.
> 
> Sure - you will still benefit using fdtdec_setup_mem_size_base and
> fdtdec_setup_memory_banksize, but really, your call.

What would be the actual benefit? Never used it and looking at the code
I do not think it works for us.

We have a range of SKUs with different memory sizes (512MB to 2GB), we
do have a single device tree and a single U-Boot binary for all of the
variants, the memory node in the source dts file is just a default.

The DT memory node is updated dynamically by U-Boot, and the actual memory
size is detected by U-Boot using get_ram_size().

(and all of that just works fine).

Francesco

