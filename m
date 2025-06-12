Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B581C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 19:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E6DF82B97;
	Thu, 12 Jun 2025 21:12:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MGrm7R85";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E88682BD9; Thu, 12 Jun 2025 21:12:24 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6A1882B70
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 21:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55CJCBkt1773470;
 Thu, 12 Jun 2025 14:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749755531;
 bh=n2Pa3EOC2Mez8IsEHmpLua8iMUvGsc4xTxpG9BVSPoo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=MGrm7R85e+Trtqvve6E/uaGVEUC34rvt8WyQYopX1mXARw+rcfQNB8I4NU8f4y3jZ
 FxPhF8sQwcr9hWr/Yia4txK5mMxmvkWSEwwt51um6Z4Y9crezOBthThCG0QXXlOHyF
 zzvYG1aff30WxsXFZefiWDbbW1DKtJ3Cg7050R74=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55CJCBIo2841223
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 12 Jun 2025 14:12:11 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 14:12:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 14:12:11 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55CJCBnW2440213;
 Thu, 12 Jun 2025 14:12:11 -0500
Date: Thu, 12 Jun 2025 14:12:11 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heiko Thiery <heiko.thiery@gmail.com>, <u-boot@lists.denx.de>, Udit Kumar
 <u-kumar1@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Keerthy <j-keerthy@ti.com>, Michael Walle
 <mwalle@kernel.org>, Thomas =?utf-8?Q?Sch=C3=A4fer?=
 <thomas.schaefer@kontron.com>
Subject: Re: [PATCH] mach-k3: j722s: enable caches for the SPL stage
Message-ID: <20250612191211.h6wosk4vd722h7ld@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250612115015.266601-1-heiko.thiery@gmail.com>
 <20250612143808.GM1382132@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250612143808.GM1382132@bill-the-cat>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On June 12, 2025 thus sayeth Tom Rini:
> On Thu, Jun 12, 2025 at 01:50:15PM +0200, Heiko Thiery wrote:
> 
> > This is same as done in 27cd65ca1bf1 ("mach-k3: am62ax: enable caches for the SPL stage").
> > 
> > This is resulting in ~2x speedup in the A53 SPL stage.
> > 
> > Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> > ---
> >  arch/arm/mach-k3/j722s/j722s_init.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
> > index af211377e7c..591aa1d60d5 100644
> > --- a/arch/arm/mach-k3/j722s/j722s_init.c
> > +++ b/arch/arm/mach-k3/j722s/j722s_init.c
> > @@ -162,6 +162,8 @@ static void k3_mem_init(void)
> >  		if (ret)
> >  			panic("DRAM init failed: %d\n", ret);
> >  	}
> > +
> > +	spl_enable_cache();
> >  }
> >  
> >  static __maybe_unused void enable_mcu_esm_reset(void)
> 
> A bit less a comment for you and more a comment for all the TI folks,
> can't we re-architect this a bit to be common? I think I even made that
> point on another patch doing this same thing for another K3 part.
> 

Yeah we're copy and pasting quite a lot of common stuff for each of 
these SoCs. I can take a stab at this and see what I come up with.

~Bryan
