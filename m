Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFA7CF45C6
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 01:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA2F783700;
	Tue, 13 Jan 2026 02:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BE6183885; Tue, 13 Jan 2026 02:31:26 +0100 (CET)
Received: from smtp.gentoo.org (mail.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E58D836C8
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 02:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 74D0434102E;
 Tue, 13 Jan 2026 01:31:21 +0000 (UTC)
Date: Tue, 13 Jan 2026 09:31:17 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 01/10] sunxi: sun60i: initial support for A733 SoC
Message-ID: <20260113013117-GYB24058@gentoo.org>
References: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
 <20251130-01-a733-soc-support-v2-1-18bdd4376fad@gentoo.org>
 <20260102014019.36db66d4@minigeek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102014019.36db66d4@minigeek.lan>
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

Hi Andre,

On 01:40 Fri 02 Jan     , Andre Przywara wrote:
> On Sun, 30 Nov 2025 21:45:10 +0000
> Yixun Lan <dlan@gentoo.org> wrote:
> 
> Hi Yixun,
> 
> thanks for updating this series, and sorry for the delay in the review.
> 
> As for this patch: it should go to the end of the series, since it
> already introduces the possibility to select the new SoC, even though
> the rest of the code isn't ready yet. And I think we should drop the 
> "select SUPPORT_SPL", since it's not really supported, without the DRAM
see my comment in other thread

> code. If we rely on FEL to load U-Boot anyway, we can much simpler load
> TF-A and U-Boot proper directly, no need for any FIT image.
I haven't went the way to lod TF-A, U-Boot separately even use FEL,
but insted, still follow previous traditionl way - combine all images
together, that's TF-A, SPL, U-Boot..

for this reason I'd just keep configurations of SUPPORT_SPL and FIT..

> And thanks for using the SUNXI_GEN_NCAT2 symbol, btw!
> 
> One small thing below...
> 
> > Add basic support for Allwinner A733 SoC.
> > 
> > - Include some basic register definitions
> > - Introduce a new SUN60I A733 Kconfig option
> > - Ssetup RVBAR register properly according to docs
> > - Config max DDR size 16GB
> > - Config SRAM 0x62000 for TF-A
> > 
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > 
..
> >  config SYS_BOARD
> >  	default "sunxi"
> > @@ -1186,6 +1199,7 @@ config SPL_STACK_R_ADDR
> >  	default 0x4fe00000 if MACH_SUN50I
> >  	default 0x4fe00000 if SUN50I_GEN_H6
> >  	default 0x4fe00000 if SUNXI_GEN_NCAT2
> > +	default 0x4fe00000 if MACH_SUN60I_A733
> 
> This is not needed, since the same address is already selected by NCAT2.
> 
will drop it

-- 
Yixun Lan (dlan)
