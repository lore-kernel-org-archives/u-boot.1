Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B568D3F098
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 17:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A790684034;
	Wed, 28 Jan 2026 18:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cVh16CmQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D018408D; Wed, 28 Jan 2026 18:00:11 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 597E68401A
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 18:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-409470ad5bbso18403fac.0
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 09:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769619605; x=1770224405; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z6hh1jaRO2ZVWTx7ogwDl9p32N3tvax1zgUvZszjawg=;
 b=cVh16CmQygHwUVREPNCipMgsVvhomP/vfi/BWrhVC6tiFGmGON58Q0tJt8UAmM5tzI
 qL+/gwlcOO0uPX2D/W+ByPfNSSPNObpoCT2D3ZlFOk9OBiiS4YExBKDApuCHupMmR1Zq
 mL92ltP6ISz5lwaqlDJ+C1iemDCnnTpHk9hEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769619605; x=1770224405;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z6hh1jaRO2ZVWTx7ogwDl9p32N3tvax1zgUvZszjawg=;
 b=LuKL9A9L330Xhmdx3hBUtBGeZXyNeMOQBVd4ICzRecNKM+3PwNFjcNLv6kVZXsUzfa
 RLhn/1IwTFmrP4wc7PLggpLG4v8cYcAhK0Yxez47tDXjUiFz5IOX7QfD1eVuHkAnrwkJ
 u0F+J/e6YEtrnYQspk9FWV90MkG7J2wgpEYsXVWNdJ5BmyFxUFZCR5wlG3HyGjNgsiEp
 1joSl4VN5hrT6rkr4iGgbWNH4CYFJSIYUclfYXkACx3r21OXJ3gsxqg3uk9PkKt5ZrWm
 Vw55tCaSPqvTGIqX5nbOo/IX09Yp+jmPV7ItTT8CR4E5dYg/Qyjsdh4CDAiCcjkz9+dF
 YOOw==
X-Gm-Message-State: AOJu0YySLx9iDcTBbm2qnPidn5Txx5VcixRzBO0fxAfA14xjWDqIU7jO
 XTEb7cwxpsye83HXgfZPk4VqRjw4ANYp0qeKRyvTjr+bHSFMJsD+n9Yr/gK7SecPf5vh6xxpU6z
 iP6uCM+I=
X-Gm-Gg: AZuq6aIR5g6WdKsUC35OmIBIgkEJGYiOF3MiUc6BjChsmfW0B+ikRxcnsoR67KHVl1S
 GcBs6ZZdX1Z/ehMfJH+K7E+h5QZB3ze5ACrmBgTnQthnpjoldqzzBAesCJzNT5kzHhBqhsYX6FT
 Og7YdktaKd5BQlbagBRem3DwKE2VRrvo2nr8EItR6vVqFo+NLR/bI9cG0GXAVVxKiBIUTWv5p+8
 BpN00I0JgJPFBLTICVFztWF6WYY2JQ3rBVznYGd1jA7cIMweBqIiiYT2hjAypsgRjgxG9Z204oS
 fDVgPQ5lt/Jcqi6jE5ZTZiMgs9OD1rq0+ZmmFunIOWfjkqdux9YpY8DFundvXk11gcPbC+bR1eZ
 Kga5wUcSpDOOO4LDZhFxWjOlVxBs0xKqBdHWmcT6WBvFNHl1yG0qA1d5L+Klh5duuHC0m8y9wD+
 EqqUwFnbY0RK8HLys5IfXyknoDYQ8bVkBqQ92D5MXkjI+QOTd4YVRSFIhUUOVZEovC5aC4YdQQm
 cJ+SGCcapoA5/u99TCfmzDwXTqGAPeJeaWvue8=
X-Received: by 2002:a05:6820:4b90:b0:65d:4d4:e7b0 with SMTP id
 006d021491bc7-662f1f3e6ddmr2947055eaf.0.1769619603642; 
 Wed, 28 Jan 2026 09:00:03 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662f99447b5sm1659853eaf.2.2026.01.28.09.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:00:03 -0800 (PST)
Date: Wed, 28 Jan 2026 11:00:01 -0600
From: Tom Rini <trini@konsulko.com>
To: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Message-ID: <20260128170001.GN3416603@bill-the-cat>
References: <20260127213149.1338179-1-trini@konsulko.com>
 <KL1PR0601MB54882F38FB9675D83E1F1D129191A@KL1PR0601MB5488.apcprd06.prod.outlook.com>
 <20260128143044.GI3416603@bill-the-cat>
 <KL1PR0601MB54888B50088BFBFA4364B37B9191A@KL1PR0601MB5488.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LIKznfoTcs+BqLlr"
Content-Disposition: inline
In-Reply-To: <KL1PR0601MB54888B50088BFBFA4364B37B9191A@KL1PR0601MB5488.apcprd06.prod.outlook.com>
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


--LIKznfoTcs+BqLlr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 04:56:07PM +0000, ChiaWei Wang wrote:
>=20
> > From: Tom Rini <trini@konsulko.com>
> > Sent: Wednesday, January 28, 2026 10:31 PM
> >=20
> > On Wed, Jan 28, 2026 at 12:13:12AM +0000, ChiaWei Wang wrote:
> > > > From: Tom Rini <trini@konsulko.com>
> > > > Sent: Wednesday, January 28, 2026 5:32 AM
> > > >
> > > > As of v2026.01, no platforms contain any rel.dyn sections in their
> > > > xPL phase images. Their inclusion in linker scripts initially was an
> > > > oversight as part of taking the full U-Boot linker scripts and
> > > > modifying them down. Then in commit
> > > > 8b0ebe054bb3 ("arm: Update linker scripts to ensure appended device
> > > > tree is
> > > > aligned") these sections were used to force correct alignment for
> > > > the device tree. This however, lead to a different problem.
> > > >
> > > > That problem is that when we do not have a separate BSS section in
> > > > SPL we instead would overlay the BSS with the rel.dyn section, in
> > > > the common linker script case. This in turn lead to creating an
> > > > incorrectly sized BSS "pad" file sometimes (depending on arbitrary =
changes
> > within the rest of the binary itself).
> > > > This in turn lead to the dtb being in the wrong location in the
> > > > binary and not found at run time.
> > > >
> > > > This commit fixes a few things:
> > > > - Remove the rel.dyn section from all ARM SPL linker scripts.
> > > > - In turn, this moves the dtb alignment statement in to another sec=
tion.
> > > > - For ast2600 which uses CONFIG_POSITION_INDEPENDENT we need to
> > keep
> > > > the
> > > >   symbols however.
> > > >
> > > > Tested-by: Fabio Estevam <festevam@gmail.com>
> > > > Reported-by: Fabio Estevam <festevam@gmail.com>
> > > > Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > I sent this off-list to Fabio first to confirm it finally fixed thi=
ngs.
> > > >
> > > > Cc: "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
> > > > Cc: Adam Ford <aford173@gmail.com>
> > > > ---
> > > >  arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds      |  8 --------
> > > >  arch/arm/cpu/u-boot-spl.lds                    | 13 ++-----------
> > > >  arch/arm/mach-aspeed/ast2600/u-boot-spl.lds    | 16 +++++++-------=
--
> > > >  board/davinci/da8xxevm/u-boot-spl-da850evm.lds |  9 ++-------
> > > >  4 files changed, 11 insertions(+), 35 deletions(-)
> > > >
> > > > diff --git a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> > > > b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> > > > index b4adae272eba..ac166d1d8526 100644
> > > > --- a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> > > > +++ b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> > > > @@ -33,14 +33,6 @@ SECTIONS
> > > >  		*(.data*)
> > > >  	}
> > > >
> > > > -	. =3D ALIGN(4);
> > > > -
> > > > -	.rel.dyn : {
> > > > -		__rel_dyn_start =3D .;
> > > > -		*(.rel*)
> > > > -		__rel_dyn_end =3D .;
> > > > -	}
> > > > -
> > > >  	.bss : {
> > > >  		. =3D ALIGN(4);
> > > >  		__bss_start =3D .;
> > > > diff --git a/arch/arm/cpu/u-boot-spl.lds
> > > > b/arch/arm/cpu/u-boot-spl.lds index
> > > > d780a5060774..c578c3ebf821 100644
> > > > --- a/arch/arm/cpu/u-boot-spl.lds
> > > > +++ b/arch/arm/cpu/u-boot-spl.lds
> > > > @@ -41,23 +41,14 @@ SECTIONS
> > > >  		__binman_sym_start =3D .;
> > > >  		KEEP(*(SORT(.binman_sym*)));
> > > >  		__binman_sym_end =3D .;
> > > > -	}
> > > > -
> > > > -	. =3D ALIGN(4);
> > > > -
> > > > -	__image_copy_end =3D .;
> > > > -
> > > > -	.rel.dyn : {
> > > > -		__rel_dyn_start =3D .;
> > > > -		*(.rel*)
> > > > -		__rel_dyn_end =3D .;
> > > >  		. =3D ALIGN(8);
> > > >  	}
> > > >
> > > > +	__image_copy_end =3D .;
> > > >  	_image_binary_end =3D .;
> > > >  	_end =3D .;
> > > >
> > > > -	.bss __rel_dyn_start (OVERLAY) : {
> > > > +	.bss : {
> > > >  		__bss_start =3D .;
> > > >  		*(.bss*)
> > > >  		 . =3D ALIGN(8);
> > > > diff --git a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> > > > b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> > > > index c9664a6ce566..303ace2f61ca 100644
> > > > --- a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> > > > +++ b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> > > > @@ -49,19 +49,17 @@ SECTIONS
> > > >  		__binman_sym_start =3D .;
> > > >  		KEEP(*(SORT(.binman_sym*)));
> > > >  		__binman_sym_end =3D .;
> > > > +		. =3D ALIGN(8);
> > > >  	} > .nor
> > > >
> > > > -	. =3D ALIGN(4);
> > > > +	/*
> > > > +	 * These platforms enable CONFIG_POSITION_INDEPENDENT and so
> > need
> > > > +	 * these names. The always however hold the same value.
> > > > +	 */
> > > > +	__rel_dyn_start =3D .;
> > > > +	__rel_dyn_end =3D .;
> > > >
> > > >  	__image_copy_end =3D .;
> > > > -
> > > > -	.rel.dyn : {
> > > > -		__rel_dyn_start =3D .;
> > > > -		*(.rel*)
> > > > -		__rel_dyn_end =3D .;
> > > > -		. =3D ALIGN(8);
> > > > -	} > .nor
> > > > -
> > > >  	_end =3D .;
> > > >  	_image_binary_end =3D .;
> > > >
> > >
> > > Thanks for the fix.
> > > Aspeed enables PIE mainly for the U-Boot execution.
> > > For SPL, the symbols should be fine to be the same.
> > >
> > > Reviewed-by: "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
> >=20
> > Thanks. Does SPL really execute from address 0x0 on this platform? What
> > confused me for a moment when looking in to this is that we have a non-=
zero
> > CONFIG_TEXT_BASE but CONFIG_SPL_TEXT_BASE=3D0x0
>=20
> Yes, SPL executes from address 0x0.
> This is backed by the configurable bus address decoding.
> Depending on the boot media, ROM will configure the bus setting so
> that 0x0 will be decoded to either SRAM or SPI NOR Flash for XIP.

Ah, neat! It would be nice to have that in the board docs someday ;)

--=20
Tom

--LIKznfoTcs+BqLlr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXpAjQAKCRAr4qD1Cr/k
CjkrAQCPheMFAhobwlprg62WT5Rao5k2kNCM+nRJybFozMT9DQEAsjAorPEYJG8c
qNnNeZVOKq6PleyqGKiD2p4rTOikOg8=
=7A63
-----END PGP SIGNATURE-----

--LIKznfoTcs+BqLlr--
