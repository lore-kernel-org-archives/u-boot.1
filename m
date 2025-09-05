Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ACFCA1010
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 14:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F647838D2;
	Fri,  5 Sep 2025 16:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oRQ14IOL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 021F4838E0; Fri,  5 Sep 2025 16:22:43 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5E38838C5
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 16:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-746d3fd3a04so1425034a34.1
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757082159; x=1757686959; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bsnu7+m1+85OMMqmgEcz3PboxoxKofYXRct0MGY9kkI=;
 b=oRQ14IOLBGwFMGV12TNQtnO2DuKf62d6JDSCilqG+gTFJ5DgQxBwwGfkJ9TPm3L8KT
 2/Ao7BSsCG8L93PwHpIKaoThn9UBwQCUjSOWWlgqIOvkLTA7V7Lq5Ezvt6k2pX+zNvdT
 SqfDtZbxxNlBmuvAqeiDIYmBXakVG/c53yJMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757082159; x=1757686959;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsnu7+m1+85OMMqmgEcz3PboxoxKofYXRct0MGY9kkI=;
 b=p17EqTzSQggNTeVTcutvoHwKDbOem2ps60oylGRgXdEQhfG/M3yJkWhgJ5i70KJzgS
 9W2DxKuV/gYcR9XJEOAPvhz6kwwf3/Y2BC+XGy1VO+XGwCd+UmLbYskvk7fqK5XqGb0J
 v3uk/FjC8rbC9ZFsnNqWkhUzZBXQr1bAvwNnZGDXki0Txd5Xu6ykAP3EBceHva8Kx/Yr
 rIgMN3R3TEscyLfUl70EgCbkysjtsJMXCrC1R+M/o4gxJr5izNZwzMWVoKbZq149G0V8
 5Q+BlEdHvL5OHmzbY3Pe6VPANMclKm2h+YipVoqP2+M8XY1iNaZ9ouVq15U8XERbvBCZ
 4H0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzf6VHruyPEZdOBdo1rxcPDlE8a0gAexbPc9ieMSP0gn87gMst1Xj9yH/nOp1sDxkVYrMU9+4=@lists.denx.de
X-Gm-Message-State: AOJu0YxXwoaI5NimLUgRkTeW4jRLT7E8qdRDbPrRHGrKLTeGK3WXAa2A
 jI1jQgPpfoN4HlnRojz0FX5XVwaJSoV4NHkDV22sf7yVzMmtzlJJUQrb6LLn9n13HTs=
X-Gm-Gg: ASbGncs593bddEnPfgHXJ9uUZGXSRIzy9mmYspw7kmmn59hSoiJAFGnITKf8CEsjfxS
 DN+ZdQPwbNSsvaDIItKKj6+WWip34Hk59eNaX9ENQb9N1foImmvRYrLhKklMc0gz5kSSHsjlkJ9
 wvyrLFZ67mRWNWQD6lhFZjF/T5+9LJWypE9vLCZnMd1o1gakMa8TQZuGkqwGlvvAxMzchsoQSSh
 IaLrTRcxPLFTwNxUcs4jD1VZ1DteigPMCcC0xxHJ+ssSfv0MszdoJ/T8Uf7VqsAOhT9y7sEI807
 h1rQCAaa/qZw7dLZI2necJve38p2lWTR6JjuJLHlJ+iOsAR/+xnu8j6w8Rc8cJSMQFPSmE4nQ1y
 v/z6J1h35bOTQ4h8elAsJLWHY2IJGMZwP46JeHbo4je9GcN2dm1HCRRxMFzsF5rdQwJs=
X-Google-Smtp-Source: AGHT+IGCPD+n2FS57pt3za5hJbOgdF+nDkhVQH44Uh+AZ+3CJsu2Au57ZIg4dbQBvEDNH1AGZ6C8Kg==
X-Received: by 2002:a05:6808:508d:b0:439:b04d:7d9d with SMTP id
 5614622812f47-439b04daf69mr1469057b6e.43.1757082159308; 
 Fri, 05 Sep 2025 07:22:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-438000829ccsm3589142b6e.27.2025.09.05.07.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 07:22:38 -0700 (PDT)
Date: Fri, 5 Sep 2025 08:22:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Philip Oberfichtner <pro@denx.de>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v3 1/5] Image size checks: Move all configs in one place
Message-ID: <20250905142235.GK124814@bill-the-cat>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-2-pro@denx.de>
 <f08b6fca-cb56-4912-b888-74a46c13c6e2@mailbox.org>
 <aLlJ03EV7mK5yiwg@aristophanes>
 <74fea05e-b8a1-479e-9938-a4043501c92c@mailbox.org>
 <aLqbsD6R3ZfAeN86@aristophanes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1fmYvQ/FhgztUrvk"
Content-Disposition: inline
In-Reply-To: <aLqbsD6R3ZfAeN86@aristophanes>
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


--1fmYvQ/FhgztUrvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 05, 2025 at 10:13:36AM +0200, Philip Oberfichtner wrote:
> On Thu, Sep 04, 2025 at 03:54:54PM +0200, Marek Vasut wrote:
> > On 9/4/25 10:12 AM, Philip Oberfichtner wrote:
> > > On Wed, Sep 03, 2025 at 02:50:49PM +0200, Marek Vasut wrote:
> > > > On 9/3/25 12:56 PM, Philip Oberfichtner wrote:
> > > > > How image size limiting works in U-Boot should be easier to grasp=
 if we
> > > > > have all related options in one place.
> > > > >=20
> > > > > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > > > > ---
> > > > >    Kconfig                | 59 ++++++++++++++++++++++++++++++++++=
++++++++
> > > > >    common/spl/Kconfig     | 38 ---------------------------
> > > > >    common/spl/Kconfig.tpl |  7 -----
> > > > >    common/spl/Kconfig.vpl |  7 -----
> > > > >    4 files changed, 59 insertions(+), 52 deletions(-)
> > > > >=20
> > > > > diff --git a/Kconfig b/Kconfig
> > > > > index 70125c4e5a6..f1a6be299e8 100644
> > > > > --- a/Kconfig
> > > > > +++ b/Kconfig
> > > > > @@ -535,6 +535,8 @@ config BUILD_TARGET
> > > > >    	  special image will be automatically built upon calling
> > > > >    	  make / buildman.
> > > > > +menu "Image size limits"
> > > > > +
> > > > >    config HAS_BOARD_SIZE_LIMIT
> > > > >    	bool "Define a maximum size for the U-Boot image"
> > > > >    	depends on !COMPILE_TEST
> > > > > @@ -554,6 +556,63 @@ config BOARD_SIZE_LIMIT
> > > > >    	  include SPL nor TPL, on platforms that use that functionali=
ty, they
> > > > >    	  have separate options to restrict size.
> > > > > +config VPL_SIZE_LIMIT
> > > > > +	depends on VPL
> > > > > +	hex "Maximum size of VPL image"
> > > > > +	default 0x0
> > > > > +	help
> > > > > +	  Specifies the maximum length of the U-Boot VPL image.
> > > > > +	  If this value is zero, it is ignored.
> > > > > +
> > > > > +config TPL_SIZE_LIMIT
> > > > > +	depends on TPL
> > > > > +	hex "Maximum size of TPL image"
> > > > > +	default 0x0
> > > > > +	help
> > > > > +	  Specifies the maximum length of the U-Boot TPL image.
> > > > > +	  If this value is zero, it is ignored.
> > > > The point of separate common/spl/Kconfig.tpl and common/spl/Kconfig=
=2Evpl
> > > > files is to group SPL / TPL / VPL symbols in those files .
> > >=20
> > > There is "config TPL_" definitions literally all over the place. I th=
ink
> > > there might actually even be more of them outside Kconfig.tpl than
> > > inside.
> >=20
> > That does not make it OK to make that situation worse.
>=20
> It doesn't. Someone who stumbles over BOARD_SIZE_LIMIT might be asking
> himself, if there's an analogous option for SPL, too. It'll jump right
> into his eyes, after this patch of mine.
>=20
> And apparently there were other contributers before me who found it
> reasonable to group strongly related options together within one menu,
> instead of spreading them out over many different places. Let me give
> you a few examples (and this list is by far not exhaustive):
>=20
>=20
> 	Kconfig:
> 		config SYS_MALLOC_F
> 		config SPL_SYS_MALLOC_F
> 		config TPL_SYS_MALLOC_F
> 		config VPL_SYS_MALLOC_F
>=20
> 	arch/Kconfig=20
> 		menu "Skipping low level initialization functions"
> 		config SKIP_LOWLEVEL_INIT
> 		config SPL_SKIP_LOWLEVEL_INIT
> 		config TPL_SKIP_LOWLEVEL_INIT
>=20
> 	boot/Kconfig
> 		menuconfig FIT
> 		config SPL_FIT
> 		config VPL_FIT
> 		config TPL_FIT
>=20
>=20
> 	common/Kconfig
> 		menu "Logging"
> 		config LOG
> 		config SPL_LOG
> 		config TPL_LOG
> 		config VPL_LOG
>=20
> 	dts/Kconfig
> 		menu "Device Tree Control"
> 		config OF_CONTROL
> 		config SPL_OF_CONTROL
> 		config TPL_OF_CONTROL
> 		config VPL_OF_CONTROL
>=20
> 	lib/Kconfig
> 		menu "Compression Support"
> 		config LZ4
> 		config SPL_LZ4
> 		config TPL_LZ4
> 		config VPL_LZ4
>=20
>=20
> So how do these and many other cases differ from the SIZE_LIMIT case
> discussed here? Or would it be better to tear all those menus apart?

We are not consistent about this, and it really becomes a stylistic
argument. Roughly speaking, common/spl/Kconfig.* is for things core to a
given phase (SPL, TPL, VPL) which is why often but not always, say
compression algorithms are with the compression algorithms. In this
case, limits are a core part of the phase so I think Marek's point is
valid here.

--=20
Tom

--1fmYvQ/FhgztUrvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLryKwAKCRAr4qD1Cr/k
CioZAQDv+Hz/vUgYsS4CLZC4X5eAgJVHy09yhz0P+q5cDAoD8gD8DeI9EAsqGYuD
GyvKNtWpL9WCEXTXG1W8J0zdKqLLMgk=
=z0bl
-----END PGP SIGNATURE-----

--1fmYvQ/FhgztUrvk--
