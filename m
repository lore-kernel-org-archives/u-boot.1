Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3D5CE7A8C
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 15:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1442C86C37;
	Mon, 25 Sep 2023 17:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="hmCLNGuJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9431586C67; Mon, 25 Sep 2023 17:27:30 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3896286C06
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 17:27:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: f2974c59-5bb7-11ee-b453-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id f2974c59-5bb7-11ee-b453-005056994fde;
 Mon, 25 Sep 2023 17:26:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=hMZ99ParijB8L7hl3AkfylIq/n1TjjbPptWsigoEUSw=;
 b=hmCLNGuJD7CqcjZfyvs6Z6wlLWIwc4gfJ0CS3+cC7zBV8jNHy4KRR3l5raMmnc172Ywn9opQb33J+
 xRiP2VsUrSBx62FE8W+mTn6U3v6nSOgNSy+//V68R31z72Mnqa2INdsjutp4egm+QngN9U8+YK917t
 LEOiAW49L+4yCnAoNkaIbgw33WlkurdL+d417Q2/+E/Tfa7m9lC3MLEWDQm3an9N91THKOuKUsu+jo
 MFMtv2ca0ka7+S46o0pAYny4JqgcoTTLekJ+QVDod2wm7bU/sbLZ3y1JUoncplzvalC9CjebW9lQY+
 kotS7R8jTb0mcCsYVc6wPHD/X2JR8Bw==
X-KPN-MID: 33|jWdReFEsBoDhEZtN8HvDPLLb3TmNWXQRG4DXKW5lbsR3RBeMPlmbLouUONdaCWe
 NEiUGo/Z4r9J4EvD8w1rqExfq9qAQHoXC9aBeKw1xpIc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|EzjgluTHO1qVi9ApBoZC9K24gwf3apdF7wkxk2lMII2780qrWEzP0FpyyYHqlAg
 fJS9T+fXs4pn/RQg1L0V69w==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 07fb085c-5bb8-11ee-9dc8-00505699772e;
 Mon, 25 Sep 2023 17:27:26 +0200 (CEST)
Date: Mon, 25 Sep 2023 17:27:26 +0200
Message-Id: <87ttricly9.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: u-kumar1@ti.com, nm@ti.com, vigneshr@ti.com,
 patrick.delaunay@foss.st.com, sjoerd@collabora.com,
 u-boot@lists.denx.de, xypron.glpk@gmx.de,
 michal.simek@amd.com, s-anna@ti.com, dsankouski@gmail.com,
 kettenis@openbsd.org, sumit.garg@linaro.org, sam.shih@mediatek.com
In-Reply-To: <20230925152126.GC305624@bill-the-cat> (message from Tom Rini on
 Mon, 25 Sep 2023 11:21:26 -0400)
Subject: Re: [PATCH] lmb: remove overlapping region with next range
References: <20230924111832.3741245-1-u-kumar1@ti.com>
 <20230925152126.GC305624@bill-the-cat>
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

> Date: Mon, 25 Sep 2023 11:21:26 -0400
> From: Tom Rini <trini@konsulko.com>
> 
> On Sun, Sep 24, 2023 at 04:48:32PM +0530, Udit Kumar wrote:
> 
> > In case of new memory range to be added is coalesced
> > with any already added non last lmb region.
> > 
> > And there is possibility that, then region in which new memory
> > range added is not adjacent to next region. But have some
> > sections are overlapping.
> > 
> > So along with adjacency check with next lmb region,
> > check for overlap should be done.
> > 
> > In case overlap  is found, adjust and merge these two lmb
> > region into one.
> > 
> > Reported-by: Suman Anna <s-anna@ti.com>
> > Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> 
> This is good!  I wonder if this addresses the issue that has caused
> other platforms to need to set CONFIG_LMB_MAX_REGIONS=64 and I'm
> wondering if any of the other maintainers I've cc'd here can drop back
> to the default number of regions and then re-test their failure case?
> Thanks!

Hi Tom,

For the Apple M1 systems I don't think it makes sense to reduce the
number of regions.  These systems don't have TPL or SPL, have plenty
of memory (at least 8GB) and are really fast.  And we anticipate that
the number of memory regions will only grow in the future.

Cheers,

Mark

> > ---
> > logs
> > https://gist.github.com/uditkumarti/5d08c34442235ad270cfa863792ebcdc
> > seqeunce : line 1 to 13
> > without fix : line 96-100
> > with fix : line 199-202
> > 
> >  lib/lmb.c | 37 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 33 insertions(+), 4 deletions(-)
> > 
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index b2c233edb6..2580d01d90 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -74,6 +74,16 @@ static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
> >  	return 0;
> >  }
> >  
> > +static long lmb_regions_overlap(struct lmb_region *rgn, unsigned long r1,
> > +				unsigned long r2)
> > +{
> > +	phys_addr_t base1 = rgn->region[r1].base;
> > +	phys_size_t size1 = rgn->region[r1].size;
> > +	phys_addr_t base2 = rgn->region[r2].base;
> > +	phys_size_t size2 = rgn->region[r2].size;
> > +
> > +	return lmb_addrs_overlap(base1, size1, base2, size2);
> > +}
> >  static long lmb_regions_adjacent(struct lmb_region *rgn, unsigned long r1,
> >  				 unsigned long r2)
> >  {
> > @@ -81,7 +91,6 @@ static long lmb_regions_adjacent(struct lmb_region *rgn, unsigned long r1,
> >  	phys_size_t size1 = rgn->region[r1].size;
> >  	phys_addr_t base2 = rgn->region[r2].base;
> >  	phys_size_t size2 = rgn->region[r2].size;
> > -
> >  	return lmb_addrs_adjacent(base1, size1, base2, size2);
> >  }
> >  
> > @@ -105,6 +114,23 @@ static void lmb_coalesce_regions(struct lmb_region *rgn, unsigned long r1,
> >  	lmb_remove_region(rgn, r2);
> >  }
> >  
> > +/*Assmptuon : base addr of region 1 < base addr of region 2*/
> > +static void lmb_fix_over_lap_regions(struct lmb_region *rgn, unsigned long r1,
> > +				     unsigned long r2)
> > +{
> > +	phys_addr_t base1 = rgn->region[r1].base;
> > +	phys_size_t size1 = rgn->region[r1].size;
> > +	phys_addr_t base2 = rgn->region[r2].base;
> > +	phys_size_t size2 = rgn->region[r2].size;
> > +
> > +	if (base1 + size1 > base2 + size2) {
> > +		printf("This will not be a case any time\n");
> > +		return;
> > +	}
> > +	rgn->region[r1].size = base2 + size2 - base1;
> > +	lmb_remove_region(rgn, r2);
> > +}
> > +
> >  void lmb_init(struct lmb *lmb)
> >  {
> >  #if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> > @@ -249,7 +275,6 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
> >  		phys_size_t rgnflags = rgn->region[i].flags;
> >  		phys_addr_t end = base + size - 1;
> >  		phys_addr_t rgnend = rgnbase + rgnsize - 1;
> > -
> >  		if (rgnbase <= base && end <= rgnend) {
> >  			if (flags == rgnflags)
> >  				/* Already have this region, so we're done */
> > @@ -278,10 +303,14 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
> >  		}
> >  	}
> >  
> > -	if ((i < rgn->cnt - 1) && lmb_regions_adjacent(rgn, i, i + 1)) {
> > -		if (rgn->region[i].flags == rgn->region[i + 1].flags) {
> > +	if (i < rgn->cnt - 1 && rgn->region[i].flags == rgn->region[i + 1].flags)  {
> > +		if (lmb_regions_adjacent(rgn, i, i + 1)) {
> >  			lmb_coalesce_regions(rgn, i, i + 1);
> >  			coalesced++;
> > +		} else if (lmb_regions_overlap(rgn, i, i + 1)) {
> > +			/* fix overlapping area */
> > +			lmb_fix_over_lap_regions(rgn, i, i + 1);
> > +			coalesced++;
> >  		}
> >  	}
> >  
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Tom
> 
> [2:application/pgp-signature Show Save:signature.asc (659B)]
> 
