Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC03C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 08:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 439488716D;
	Fri, 10 Nov 2023 09:59:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B94BA8718C; Fri, 10 Nov 2023 09:59:45 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AA0C8709A
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 09:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 9AB4F20641;
 Fri, 10 Nov 2023 09:59:42 +0100 (CET)
Date: Fri, 10 Nov 2023 09:59:38 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>,
 Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Suman Anna <s-anna@ti.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de
Subject: Re: [RFC PATCH 1/1] arm: mach-k3: Enable icache on am625 to boot
 faster
Message-ID: <ZU3w+oW5dGI7rGkB@francesco-nb.int.toradex.com>
References: <20231109140958.1093235-1-joao.goncalves@toradex.com>
 <20231109173741.cuxbq4rtu4nhvath@pagan>
 <e27d44a1-03c2-44cf-857f-947c5f4c4796@ti.com>
 <20231109185119.GG6601@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109185119.GG6601@bill-the-cat>
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

On Thu, Nov 09, 2023 at 01:51:19PM -0500, Tom Rini wrote:
> On Thu, Nov 09, 2023 at 12:44:56PM -0600, Andrew Davis wrote:
> > On 11/9/23 11:37 AM, Nishanth Menon wrote:
> > > On 11:09-20231109, Joao Paulo Goncalves wrote:
> > > > Enable the am625 instruction cache on SPL and U-boot earlier for the A53
> > > > to execute code a bit faster. For normal boot flow, it was possible to
> > > > gain about 2 seconds on boot time.
> > > > 
> > > > Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> > > > ---
> > > > Hello all,
> > > > 
> > > > We are trying to optimize boot time on our AM62 devices and on TI community
> > > > forum [1] someone advised to enable ICACHE for am625. We enabled it, tested and got
> > > > around 2 seconds faster boot on storage media and about 5 seconds with DFU
> > > > for downloading images from A53 SPL. However, we don't know if this is the correct
> > > > solution and want more comments on this or why the ICACHE was not enabled by TI in
> > > > the first place.
> > > > 
> > > > [1] https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1217839/am625-boot-time-between-a53-spl-and-a53-u-boot
> > > > 
> > > > Regards,
> > > > Joao Paulo Goncalves
> > > > 
> > > >   arch/arm/mach-k3/am625_init.c | 3 +++
> > > >   1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
> > > > index 8fa36f7b91..d665d07b0b 100644
> > > > --- a/arch/arm/mach-k3/am625_init.c
> > > > +++ b/arch/arm/mach-k3/am625_init.c
> > > > @@ -210,6 +210,9 @@ void board_init_f(ulong dummy)
> > > >   			panic("DRAM init failed: %d\n", ret);
> > > >   	}
> > > >   	spl_enable_dcache();
> > > > +
> > > > +	if (!IS_ENABLED(CONFIG_CPU_V7R) && !IS_ENABLED(CONFIG_SYS_ICACHE_OFF))
> > > > +		icache_enable();
> > > >   }
> > > >   u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
> > > > -- 
> > > > 2.34.1
> > > 
> > > Just noticed that icache_enable was missed for all of k3 as well - I
> > > suspect this is a miss rather than anything consciously done. btw
...
> > We enable Icache in SPL for our CPU_V7R case inside setup_mpu_regions()(??)
> > We also enable Dcache in spl_enable_dcache(), maybe this should be
> > renamed spl_enable_cache() and it call enable_caches() which enables
> > both. Just be careful to invalidate the icache when enabling after
> > relocation.
> > 
> > This would be temporary, better solution would be to add it to the
> > SPL common board_init_r() to match the U-Boot one, that way all these
> > platforms wouldn't need to do it in their current inconsistent ways.
> 
> I will say that part of the reason we don't have a more high-level
> "enable all the caches in SPL on ARMv7" is that I never could figure out
> why on earth it locked up my am335x GP EVM, I believe. So yes, I'd be
> quite happy to see the mach-k3 case cleaned up and made generic to
> enable (and then disable/flush/enable in full). But we can't easily make
> it higher-level than that.

So the plan would be to enable the cache for SPL in mach-k3 and not just
for AM625, correct?

Andrew: is this something you could do or should we send a patch
ourselves? We can test only TI AM62.

Francesco

