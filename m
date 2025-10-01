Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28731CCA474
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 15:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AAAF81D6A;
	Wed,  1 Oct 2025 17:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qWV8pgQF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E18681D6A; Wed,  1 Oct 2025 17:36:04 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EF6F800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 17:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-30cce50dfb4so45899fac.0
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759332960; x=1759937760; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VUEq+LqEg9AclBMwWNscYQwpczmdLx42UoB66h6uSKk=;
 b=qWV8pgQFaK5jpFTO+9xxt4RKZ6H6ApgpeB6f3GU3fptsUeA2L4ZOdVNBkcPePtEgIb
 22XsBI+TOJ1Knw/7xcKxoIkpb5htEsnnqaV+DthdFtv4/dIUUGdTe9XtxE2ZXZ4uQtua
 NltP3APGwyeSO+Kp01YjQ0ANQnZjyc46j/WAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759332960; x=1759937760;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUEq+LqEg9AclBMwWNscYQwpczmdLx42UoB66h6uSKk=;
 b=OaMJRPPr58f3RWmAKKVfdzJLQm7LwTKOy1EMAUhiWqLThogK0qHVyeySRpsVcZQhGh
 gpQAK2//UpRyzKtPSqMQX0Q7hFlbSeLczUslJtGF02OkF753TOGnEcCEMsUMI7hmgaB5
 z6np3rRcueZhI2JM0wZT2fK60gRL2/P6OqCCkblrcIdftWZTcqIUKyfBkjxH65fgOvdH
 JcPXQi8Yn3uzWgoMl1cKXEWFQoO/6/44d4P4ZJIPP9qaDNfi+Atcc/Jx4pX5J3RarrKu
 Tp6Pcz2f81spJ+OkGd8Ip+OrP8ggL9BfOEErcg7IOwMIJJ6OgAtLsMYslGo9uY0ho1ss
 bJjw==
X-Gm-Message-State: AOJu0YwN5vRHOcWe2sREF5DnfcSFce3I5X19ddiC6TMUCUJAlatGHPDT
 lLEw0j35VSswlCMrqd6h2mIkzYBJG8Qi2Iby49i2rs5o80+d0AuVHvxFQE5MYm5W2rs=
X-Gm-Gg: ASbGncurltp3CjAnPXQCD4F6xrRZYvEb3dCg5opznIg6wtR6WY9M/l2OepDU6I9vimh
 UfB3uPSyWfdE7xyq83OMg8KV+Me7m5B/S3tVFBO85xR4UopvpvpUdO7dJDlD1V2blWFSUrB1hXA
 tUgcyKeINANfJJnNWaq/Bku+ZVaiVwQWcslTJQrqT01rPI1onSk9qjCeKSVSyH8CZhE9pDd+09i
 p0aGjTqIvHQt1Px2A7LkpMcvk7iEg7pkSAXST3lwxRWn370ZykheFdY6P9pVvmWvyWLC60J9CH6
 DCsotfn3ZvqrO9CtWAaIVC0y6TlpGlKivuBotfqTSZLNYqqSVBF5jltRtpXlnxXic1p4Q5cWk3g
 qasVDsA8u1im1Fsp99Knok+fyT7GLbQ5nosWWP9hso1AsHOkvvtPNYw85E2cj3fUhRxIdlGlFS9
 Kk4oWG
X-Google-Smtp-Source: AGHT+IHzD2SSgGx/aTMRvNxEvqJnkCnMROFra+ySAN1QwTB072objpBmPxiFlabUiptvQEE+Tov+7Q==
X-Received: by 2002:a05:6871:7a3:b0:366:891:7be4 with SMTP id
 586e51a60fabf-39badea1d58mr2014504fac.15.1759332960147; 
 Wed, 01 Oct 2025 08:36:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab962cbd4asm18550fac.30.2025.10.01.08.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 08:35:59 -0700 (PDT)
Date: Wed, 1 Oct 2025 09:35:57 -0600
From: Tom Rini <trini@konsulko.com>
To: "Chawdhry, Manorit" <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH] clk: ti: Tighten some TI clock driver dependencies
Message-ID: <20251001153557.GJ6093@bill-the-cat>
References: <20250926153132.3680837-1-trini@konsulko.com>
 <99f08016-a451-498d-987c-d392d3e3e29c@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B4RtYIgr3TCX7SKp"
Content-Disposition: inline
In-Reply-To: <99f08016-a451-498d-987c-d392d3e3e29c@ti.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--B4RtYIgr3TCX7SKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2025 at 05:08:46PM +0530, Chawdhry, Manorit wrote:
> Hi Tom,
>=20
> On 9/26/2025 9:01 PM, Tom Rini wrote:
> > A few of the TI clock drivers cannot link without access to TI platform
> > specific drivers and headers.  Express those requirements in Kconfig as
> > well.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Lukasz Majewski <lukma@denx.de>
> > Cc: Sean Anderson <seanga2@gmail.com>
> > Cc: Manorit Chawdhry <m-chawdhry@ti.com>
> > Cc: Andrew Davis <afd@ti.com>
> > Cc: Udit Kumar <u-kumar1@ti.com>
> > ---
> >   drivers/clk/ti/Kconfig | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
> > index e0f15f57f826..ba658c741c4d 100644
> > --- a/drivers/clk/ti/Kconfig
> > +++ b/drivers/clk/ti/Kconfig
> > @@ -18,19 +18,19 @@ config CLK_TI_CTRL
> >   config CLK_TI_DIVIDER
> >   	bool "TI divider clock driver"
> > -	depends on CLK && OF_CONTROL && CLK_CCF
> > +	depends on CLK && OF_CONTROL && CLK_CCF && ARCH_OMAP2PLUS
> >   	help
> >   	  This enables the divider clock driver support on TI's SoCs.
> >   config CLK_TI_GATE
> >   	bool "TI gate clock driver"
> > -	depends on CLK && OF_CONTROL
> > +	depends on CLK && OF_CONTROL && ARCH_OMAP2PLUS
> >   	help
> >   	  This enables the gate clock driver support on TI's SoCs.
> >   config CLK_TI_MUX
> >   	bool "TI mux clock driver"
> > -	depends on CLK && OF_CONTROL && CLK_CCF
> > +	depends on CLK && OF_CONTROL && CLK_CCF && ARCH_OMAP2PLUS
> >   	help
> >   	  This enables the mux clock driver support on TI's SoCs.
>=20
> Do other Kconfigs' work in this file without access to TI platform specif=
ic
> drivers and headers? am wondering that every Kconfig in this file would
> ideally be TI specific only..

Ideally, long term we could build all of this on sandbox with
allyesconfig and get static analysis done to it easily. But also yes,
after this second patch here every driver has a ARCH dependency because
the ones that wouldn't compile without a header caused others to fail to
link. This also tells me that some of these options should be select'd
by others, rather than everything being a question.

--=20
Tom

--B4RtYIgr3TCX7SKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaN1KVgAKCRAr4qD1Cr/k
CqSBAQDOU/kNOrgWmHiyhJDA04nmYfC3sxO0W+o2drGIUvnorgD+P0XSDRHugQmf
9Er/d3X5qX4lpsLgfYgWCopItXuySgw=
=AF2z
-----END PGP SIGNATURE-----

--B4RtYIgr3TCX7SKp--
