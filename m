Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2ECD3F06D
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C236383F4C;
	Wed, 28 Jan 2026 15:30:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eQevDOwF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C98683F9A; Wed, 28 Jan 2026 15:30:51 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C6B483F2E
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 15:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-66106a2f8d1so2443492eaf.1
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 06:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769610648; x=1770215448; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0SgmcZQR2zsB9NXEmGbzhub5Zjxe+RMJEn/Bp3NV43Q=;
 b=eQevDOwFjUJaUEhYtPASs+OoX+xI02tCGaEYJjPfeqH/QUJ8VK24W4XC1w03PpSiBt
 18gsOenS0CeRLfeHsN0/6BqIkOBJ3Vrmuxbx4NW2SaM9/20L7lRfvhyXzxXDjZgWidU3
 143AOCepHXjmGioyg+V+SH4GBNCXP9u/SQoy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769610648; x=1770215448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0SgmcZQR2zsB9NXEmGbzhub5Zjxe+RMJEn/Bp3NV43Q=;
 b=JvId06sGr2uOONAoTdIrvyl1ugFrlJQf22rczSz7pPRNjxaoheLOf5QacR8xMcnQ2U
 PBCaxusJzcL1nqgh5R3EfwQO1dvU18wSzgXfDHXd1sls2QKq58pl1Ev1BJZZY3ECAHxm
 Z6L8jKB3zbvP4lHJzFUh/Dsvk5/x0u3BTpdZus3FODFy6aDvYqX1BL8LsdgU/UF5/Wm2
 R84vuFg8Agm1NtsHr7afRQOjk+usTimedsxEG0Zf5wTMd8vWSW+hmQgpNDzPFVKt18n6
 yaC3OnCnAPUliaPoU7I1baAh5Pu/pDjXycjw+C27dt8RHmZDTGRlIz8HL64kmPoddl7i
 xlFA==
X-Gm-Message-State: AOJu0YxzFEOgJwYSo7tBmgbWf5yDc794V+stzStP/vBXmC+Np2x/e0MA
 v3uigGW8MADqAP8xoNKd8tYmIVwvlGET0K0V4iEAFSu0kSLGjTG5iZCiTzs/MjMd6Kw=
X-Gm-Gg: AZuq6aKsoTfhq6PieQ3CJxNM2/IFqxctrE3fyZy5H0jXqIEPJDUIXCOSGN7FBBzt2+o
 Fvaq9zhN0creSLUuAX/PjZld+N+n1ARnfUIkwRD4YerhA22CVNvuTHxad1Im4g1unRQydGtRePD
 4Kyk2yLxdA/+YIksABQBp6gSUZB6kqbwfZkT/AMmFOwCcQXm5D8ZDWw0X7qdU9/H/aeUMPzHsLd
 A7xlvfWKgDoN86fB3uzKpBy9PVXA3Ap+c1uDFmLU78XzMOeybaAB0YYidrZqHX1ssGLgB2SImSg
 x1l9riSGmnvhvlujRND75whWFzLzi4biyDfVJiPNpQPEAh0PWipTsIcA9j+1xgVBx9v+AMTtUx/
 x76UWjckaUmor1d/B6J5syHfrda1r4z5Mbgaxzj9rI3ds88Z9Qr14qFSvWHwb8tXJqkac5sUbf0
 as8zoOxHWD/KfJ8gfP0q8g0GIC6h4cZs8lH/Vr9jXiVC88JjsEpoMi9bhyhqy1rsOIRzo7Bk8bA
 mMgXtDTNlgWC4QZhVFyEMceV8gvOWwe64TBNZM=
X-Received: by 2002:a05:6820:1f05:b0:663:42d:6268 with SMTP id
 006d021491bc7-663042d648emr140869eaf.49.1769610647709; 
 Wed, 28 Jan 2026 06:30:47 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662f982703fsm1462749eaf.0.2026.01.28.06.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 06:30:47 -0800 (PST)
Date: Wed, 28 Jan 2026 08:30:44 -0600
From: Tom Rini <trini@konsulko.com>
To: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Message-ID: <20260128143044.GI3416603@bill-the-cat>
References: <20260127213149.1338179-1-trini@konsulko.com>
 <KL1PR0601MB54882F38FB9675D83E1F1D129191A@KL1PR0601MB5488.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="njR9tmzx4LRwo7Xb"
Content-Disposition: inline
In-Reply-To: <KL1PR0601MB54882F38FB9675D83E1F1D129191A@KL1PR0601MB5488.apcprd06.prod.outlook.com>
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


--njR9tmzx4LRwo7Xb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 12:13:12AM +0000, ChiaWei Wang wrote:
> > From: Tom Rini <trini@konsulko.com>
> > Sent: Wednesday, January 28, 2026 5:32 AM
> >=20
> > As of v2026.01, no platforms contain any rel.dyn sections in their xPL =
phase
> > images. Their inclusion in linker scripts initially was an oversight as=
 part of
> > taking the full U-Boot linker scripts and modifying them down. Then in =
commit
> > 8b0ebe054bb3 ("arm: Update linker scripts to ensure appended device tre=
e is
> > aligned") these sections were used to force correct alignment for the d=
evice
> > tree. This however, lead to a different problem.
> >=20
> > That problem is that when we do not have a separate BSS section in SPL =
we
> > instead would overlay the BSS with the rel.dyn section, in the common l=
inker
> > script case. This in turn lead to creating an incorrectly sized BSS "pa=
d" file
> > sometimes (depending on arbitrary changes within the rest of the binary=
 itself).
> > This in turn lead to the dtb being in the wrong location in the binary =
and not
> > found at run time.
> >=20
> > This commit fixes a few things:
> > - Remove the rel.dyn section from all ARM SPL linker scripts.
> > - In turn, this moves the dtb alignment statement in to another section.
> > - For ast2600 which uses CONFIG_POSITION_INDEPENDENT we need to keep
> > the
> >   symbols however.
> >=20
> > Tested-by: Fabio Estevam <festevam@gmail.com>
> > Reported-by: Fabio Estevam <festevam@gmail.com>
> > Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > I sent this off-list to Fabio first to confirm it finally fixed things.
> >=20
> > Cc: "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
> > Cc: Adam Ford <aford173@gmail.com>
> > ---
> >  arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds      |  8 --------
> >  arch/arm/cpu/u-boot-spl.lds                    | 13 ++-----------
> >  arch/arm/mach-aspeed/ast2600/u-boot-spl.lds    | 16 +++++++---------
> >  board/davinci/da8xxevm/u-boot-spl-da850evm.lds |  9 ++-------
> >  4 files changed, 11 insertions(+), 35 deletions(-)
> >=20
> > diff --git a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> > b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> > index b4adae272eba..ac166d1d8526 100644
> > --- a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> > +++ b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> > @@ -33,14 +33,6 @@ SECTIONS
> >  		*(.data*)
> >  	}
> >=20
> > -	. =3D ALIGN(4);
> > -
> > -	.rel.dyn : {
> > -		__rel_dyn_start =3D .;
> > -		*(.rel*)
> > -		__rel_dyn_end =3D .;
> > -	}
> > -
> >  	.bss : {
> >  		. =3D ALIGN(4);
> >  		__bss_start =3D .;
> > diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds =
index
> > d780a5060774..c578c3ebf821 100644
> > --- a/arch/arm/cpu/u-boot-spl.lds
> > +++ b/arch/arm/cpu/u-boot-spl.lds
> > @@ -41,23 +41,14 @@ SECTIONS
> >  		__binman_sym_start =3D .;
> >  		KEEP(*(SORT(.binman_sym*)));
> >  		__binman_sym_end =3D .;
> > -	}
> > -
> > -	. =3D ALIGN(4);
> > -
> > -	__image_copy_end =3D .;
> > -
> > -	.rel.dyn : {
> > -		__rel_dyn_start =3D .;
> > -		*(.rel*)
> > -		__rel_dyn_end =3D .;
> >  		. =3D ALIGN(8);
> >  	}
> >=20
> > +	__image_copy_end =3D .;
> >  	_image_binary_end =3D .;
> >  	_end =3D .;
> >=20
> > -	.bss __rel_dyn_start (OVERLAY) : {
> > +	.bss : {
> >  		__bss_start =3D .;
> >  		*(.bss*)
> >  		 . =3D ALIGN(8);
> > diff --git a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> > b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> > index c9664a6ce566..303ace2f61ca 100644
> > --- a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> > +++ b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> > @@ -49,19 +49,17 @@ SECTIONS
> >  		__binman_sym_start =3D .;
> >  		KEEP(*(SORT(.binman_sym*)));
> >  		__binman_sym_end =3D .;
> > +		. =3D ALIGN(8);
> >  	} > .nor
> >=20
> > -	. =3D ALIGN(4);
> > +	/*
> > +	 * These platforms enable CONFIG_POSITION_INDEPENDENT and so need
> > +	 * these names. The always however hold the same value.
> > +	 */
> > +	__rel_dyn_start =3D .;
> > +	__rel_dyn_end =3D .;
> >=20
> >  	__image_copy_end =3D .;
> > -
> > -	.rel.dyn : {
> > -		__rel_dyn_start =3D .;
> > -		*(.rel*)
> > -		__rel_dyn_end =3D .;
> > -		. =3D ALIGN(8);
> > -	} > .nor
> > -
> >  	_end =3D .;
> >  	_image_binary_end =3D .;
> >=20
>=20
> Thanks for the fix.
> Aspeed enables PIE mainly for the U-Boot execution.
> For SPL, the symbols should be fine to be the same.
>=20
> Reviewed-by: "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>

Thanks. Does SPL really execute from address 0x0 on this platform? What
confused me for a moment when looking in to this is that we have a
non-zero CONFIG_TEXT_BASE but CONFIG_SPL_TEXT_BASE=3D0x0

--=20
Tom

--njR9tmzx4LRwo7Xb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXodlAAKCRAr4qD1Cr/k
ClTuAPwNQbHJwsLuC7s4PC07TbMjFeYId79eUx+A4gMfPYKLkgEAhAeARfjVoe15
Aw8HKj+7807jaNm359Sze2zC0ngTzA8=
=sLTz
-----END PGP SIGNATURE-----

--njR9tmzx4LRwo7Xb--
