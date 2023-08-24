Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7ECFC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 16:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF8F08082A;
	Thu, 24 Aug 2023 18:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nhMUfj6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F388077D; Thu, 24 Aug 2023 18:18:53 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1C12867EA
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 18:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37OGIhpp121025;
 Thu, 24 Aug 2023 11:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692893923;
 bh=qbnA/B7252Mod+Xz7mHjtUxLxLxpXEgLhDabNhzkkng=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=nhMUfj6xQJ/gI1OkGEITkPKU1XE4PSBYmgmi7ok6cemgmPiH49//7334fKHXINxtX
 xUK0YEBlZjm3N7CMiYRsyP7oJMZ7tifQW+/i7relfHi0ZgapP3l49NTn15oj71vHNs
 gaArgcKRaT0ujbsHtnQ1cC7LAykFtHovYttVohMI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37OGIgSa009354
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Aug 2023 11:18:43 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 11:18:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 11:18:42 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37OGIge6077572;
 Thu, 24 Aug 2023 11:18:42 -0500
Date: Thu, 24 Aug 2023 11:18:42 -0500
From: Nishanth Menon <nm@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Emanuele Ghidoli <ghidoliemanuele@gmail.com>, <u-boot@lists.denx.de>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Neha Malcom Francis
 <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1 2/2] board: verdin-am62: fix check for minimum memory
 size
Message-ID: <20230824161842.yd43zoq6s54an2k2@trombone>
References: <20230824080850.1755724-1-ghidoliemanuele@gmail.com>
 <20230824080850.1755724-3-ghidoliemanuele@gmail.com>
 <20230824121412.vxgvwo5g2ozk62xt@evergreen>
 <ZOdrQzhxGVYyYobd@francesco-nb.int.toradex.com>
 <20230824145856.qppuhw6kjfr4bkwr@sandbox>
 <ZOd8sW83t7M2Cmyt@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZOd8sW83t7M2Cmyt@francesco-nb.int.toradex.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 17:52-20230824, Francesco Dolcini wrote:
> On Thu, Aug 24, 2023 at 09:58:56AM -0500, Nishanth Menon wrote:
> > On 16:37-20230824, Francesco Dolcini wrote:
> > > Hello Nishanth,
> > > 
> > > On Thu, Aug 24, 2023 at 07:14:12AM -0500, Nishanth Menon wrote:
> > > > On 10:08-20230824, Emanuele Ghidoli wrote:
> > > > > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > > > > 
> > > > > verdin am62 SKUs comes in multiple memory configuration, check that
> > > > > the detected memory is at least 512MB since we have some
> > > > > reserved memory just before this threshold and therefore
> > > > > the module cannot work with less memory.
> > > > > 
> > > > > Fixes: 7d1a10659f5b ("board: toradex: add verdin am62 support")
> > > > > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > > > > ---
> > > > >  board/toradex/verdin-am62/verdin-am62.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
> > > > > index a3d1d07a0cbf..d09dda5bccc9 100644
> > > > > --- a/board/toradex/verdin-am62/verdin-am62.c
> > > > > +++ b/board/toradex/verdin-am62/verdin-am62.c
> > > > > @@ -28,8 +28,8 @@ int dram_init(void)
> > > > >  {
> > > > >  	gd->ram_size = get_ram_size((long *)CFG_SYS_SDRAM_BASE, CFG_SYS_SDRAM_SIZE);
> > > > >  
> > > > > -	if (gd->ram_size < SZ_64M)
> > > > > -		puts("## WARNING: Less than 64MB RAM detected\n");
> > > > > +	if (gd->ram_size < SZ_512M)
> > > > > +		puts("## WARNING: Less than 512MB RAM detected\n");
> > > > 
> > > > Have you considered fdtdec_setup_mem_size_base
> > > > fdtdec_setup_memory_banksize  - in which case the reserved memory
> > > > regions can be changed in dt (will need corresponding custom binaries
> > > > ofcourse)..
> > > 
> > > I would say that custom binaries is not something we want. Our goal is
> > > to rely on whatever TI is providing and to not deviate from it unless
> > > required. Luckily enough for the moment it works since our
> > > minimum memory size is 512MB.
> > 
> > Sure - you will still benefit using fdtdec_setup_mem_size_base and
> > fdtdec_setup_memory_banksize, but really, your call.
> 
> What would be the actual benefit? Never used it and looking at the code
> I do not think it works for us.
> 
> We have a range of SKUs with different memory sizes (512MB to 2GB), we
> do have a single device tree and a single U-Boot binary for all of the
> variants, the memory node in the source dts file is just a default.
> 
> The DT memory node is updated dynamically by U-Boot, and the actual memory
> size is detected by U-Boot using get_ram_size().
> 
> (and all of that just works fine).

Understood - we just use dt to determine the DDR sizes.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
