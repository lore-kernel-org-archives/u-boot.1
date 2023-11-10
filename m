Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98722C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 12:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76E19876C3;
	Fri, 10 Nov 2023 13:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dc8OYiW7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 612F9876E3; Fri, 10 Nov 2023 13:13:09 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFEB987692
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 13:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AACCvsF060447;
 Fri, 10 Nov 2023 06:12:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699618377;
 bh=jyQ6WFnRll/aDGAYZWFks3TXytTNCBNXZNfj/hFBv7A=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=dc8OYiW7/KIDx2dL3tHG8bSht2APy3DpTC+jjw2ivXKGDKPE+47e/Bt+25Y7dUUCZ
 6Ytfnl9+6Muo9ND3RtOAdgnG6duanTrd2d8VIBgjTlAvgzVAhfUVOR/4N16VHKR+wq
 mVA7RletVM7ccUsgjEiqUdM1hizP+IYs3Ut2OgGs=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AACCvrf014669
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 10 Nov 2023 06:12:57 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Nov 2023 06:12:57 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Nov 2023 06:12:57 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AACCvSw027969;
 Fri, 10 Nov 2023 06:12:57 -0600
Date: Fri, 10 Nov 2023 06:12:57 -0600
From: Nishanth Menon <nm@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>, Joao Paulo
 Goncalves <jpaulo.silvagoncalves@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Suman Anna <s-anna@ti.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, <u-boot@lists.denx.de>
Subject: Re: [RFC PATCH 1/1] arm: mach-k3: Enable icache on am625 to boot
 faster
Message-ID: <20231110121257.vfjjocgfqvvw4vuw@unmindful>
References: <20231109140958.1093235-1-joao.goncalves@toradex.com>
 <20231109173741.cuxbq4rtu4nhvath@pagan>
 <e27d44a1-03c2-44cf-857f-947c5f4c4796@ti.com>
 <20231109185119.GG6601@bill-the-cat>
 <ZU3w+oW5dGI7rGkB@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZU3w+oW5dGI7rGkB@francesco-nb.int.toradex.com>
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

On 09:59-20231110, Francesco Dolcini wrote:
> On Thu, Nov 09, 2023 at 01:51:19PM -0500, Tom Rini wrote:
> > On Thu, Nov 09, 2023 at 12:44:56PM -0600, Andrew Davis wrote:
> > > On 11/9/23 11:37 AM, Nishanth Menon wrote:
> > > > On 11:09-20231109, Joao Paulo Goncalves wrote:
> > > > > Enable the am625 instruction cache on SPL and U-boot earlier for the A53
> > > > > to execute code a bit faster. For normal boot flow, it was possible to
> > > > > gain about 2 seconds on boot time.
> > > > > 
> > > > > Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> > > > > ---
> > > > > Hello all,
> > > > > 
> > > > > We are trying to optimize boot time on our AM62 devices and on TI community
> > > > > forum [1] someone advised to enable ICACHE for am625. We enabled it, tested and got
> > > > > around 2 seconds faster boot on storage media and about 5 seconds with DFU
> > > > > for downloading images from A53 SPL. However, we don't know if this is the correct
> > > > > solution and want more comments on this or why the ICACHE was not enabled by TI in
> > > > > the first place.
> > > > > 
> > > > > [1] https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1217839/am625-boot-time-between-a53-spl-and-a53-u-boot
> > > > > 
> > > > > Regards,
> > > > > Joao Paulo Goncalves
> > > > > 
> > > > >   arch/arm/mach-k3/am625_init.c | 3 +++
> > > > >   1 file changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
> > > > > index 8fa36f7b91..d665d07b0b 100644
> > > > > --- a/arch/arm/mach-k3/am625_init.c
> > > > > +++ b/arch/arm/mach-k3/am625_init.c
> > > > > @@ -210,6 +210,9 @@ void board_init_f(ulong dummy)
> > > > >   			panic("DRAM init failed: %d\n", ret);
> > > > >   	}
> > > > >   	spl_enable_dcache();
> > > > > +
> > > > > +	if (!IS_ENABLED(CONFIG_CPU_V7R) && !IS_ENABLED(CONFIG_SYS_ICACHE_OFF))
> > > > > +		icache_enable();
> > > > >   }
> > > > >   u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
> > > > > -- 
> > > > > 2.34.1
> > > > 
> > > > Just noticed that icache_enable was missed for all of k3 as well - I
> > > > suspect this is a miss rather than anything consciously done. btw
> ...
> > > We enable Icache in SPL for our CPU_V7R case inside setup_mpu_regions()(??)
> > > We also enable Dcache in spl_enable_dcache(), maybe this should be
> > > renamed spl_enable_cache() and it call enable_caches() which enables
> > > both. Just be careful to invalidate the icache when enabling after
> > > relocation.
> > > 
> > > This would be temporary, better solution would be to add it to the
> > > SPL common board_init_r() to match the U-Boot one, that way all these
> > > platforms wouldn't need to do it in their current inconsistent ways.
> > 
> > I will say that part of the reason we don't have a more high-level
> > "enable all the caches in SPL on ARMv7" is that I never could figure out
> > why on earth it locked up my am335x GP EVM, I believe. So yes, I'd be
> > quite happy to see the mach-k3 case cleaned up and made generic to
> > enable (and then disable/flush/enable in full). But we can't easily make
> > it higher-level than that.
> 
> So the plan would be to enable the cache for SPL in mach-k3 and not just
> for AM625, correct?

Yes.

> 
> Andrew: is this something you could do or should we send a patch
> ourselves? We can test only TI AM62.
> 

That would be much appreciated, we can help test the rest of TI K3
platforms.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
