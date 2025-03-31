Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F50EC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 14:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D90881F4E;
	Mon, 31 Mar 2025 16:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bNvJ8s6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D0E281F54; Mon, 31 Mar 2025 16:11:22 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C133081EDD
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 16:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2c81fffd523so1407478fac.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743430278; x=1744035078; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S0rphFbO5YbVg9tnCRUL1M635VpftLLmgVVkeKzIfW4=;
 b=bNvJ8s6SL0hjhwws33GeFsNQlwMz3k31I0y0IwuiCscnRJFM1xx+DdnYjh8Unpg3x0
 XyytPLpvrVencxYBzpq4VMhtpJVNOKpzXWozJoSubEVxkeZSquDY+AKD6gK1cb1REPvj
 OMq7I/5ZnmdUDfuNC1abnlsXr6UTL343790aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743430278; x=1744035078;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0rphFbO5YbVg9tnCRUL1M635VpftLLmgVVkeKzIfW4=;
 b=oEYl7XbyTy8jjrRkYOImuCoFw1azskD4O19Lh5wtt/ySqoshRqDfJvdpLvo0PHwTmd
 BHqOMYlYXL8Up56jYddUVY/vrhv5mJRHrTQIQFf7ntteiwgGrbsxTaq4f0n7G3COKg6n
 5XzWtRKRm1GPJ3P2uCDrCmr9U9je4D/uC+AdyeF5CBFQQM/2GvsPSoZOeNm3N8gGx9QA
 aQUlzVlCTAmtHQ7ljbFnMR++OCrZFAlZT4vaPHff2r3sa4dEtOG49WjJit4LJb9XX3CE
 dbc6k7j9QH2uoXX5x6qU5HQymkQZXS827a2PiO+VIo+ZXgU83Ic4pjlXYWZrPagHHAuV
 fhFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURLEVtT66vZTc53MGV7Dr3iZyxvpO4UWyWi17xu23rfTqbM8YW9AsTLF8dghF4ufraFjvIDog=@lists.denx.de
X-Gm-Message-State: AOJu0YxXMKIWFBLTSkvBM/clr4QvjRaWMNFNsx1Z4dO7NYXiUl+KKWjG
 rKFYc6cCRwPLEQDFqQa14ZZhXarRRJnfB3u1jS6ErguGXrY1gBKd4+2x6l5gm7NqlD0mVSZq5Ae
 +
X-Gm-Gg: ASbGncvM5HLzO8xUlktALvnOefclxcyA2tLHwvO/fKlTV4UB72VPj+O2UygRlhPnZt9
 gf9SdgzDO1W9WztX1B9SH3A+EqWaxedY9ElF38Sb5ddWdAd4ZBGyuAmcwyK+/iVzCw1NgjS+yyD
 +cWoJzHJst0ku4OMGIpqCnsHgwhRRWbYZ392LTdjcOmAO7gHdVVRQyDaZEfQyDFDsIxd7J5x/Qz
 C8RtwbemGlaHgY6C8DeDV2dHEG78YyQhqL37uXJd2xaUu2FxOCYq2puaCHSIM1DR9uKHRsi9he9
 LomOdrp3zOt/MSqHOFbk6sOa1Isr+Yw4stgtNgGXGic4jqonZ20yLUcmSGo1gyoIWrGfnzzYxiD
 NVJSfXXYbg3MuQc42
X-Google-Smtp-Source: AGHT+IF+CEB8YC550N1Xyr0FFxNQCzZ9n0vLDZaqo5MKHfYD0OB1+T0STzYy0UQGUNWihEdH2dK18w==
X-Received: by 2002:a05:6871:a112:b0:2c2:371a:2b45 with SMTP id
 586e51a60fabf-2cbcf46f107mr5055214fac.3.1743430278468; 
 Mon, 31 Mar 2025 07:11:18 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c58092602sm1489097a34.8.2025.03.31.07.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 07:11:18 -0700 (PDT)
Date: Mon, 31 Mar 2025 08:11:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: rafael@beims.me, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Rafael Beims <rafael.beims@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] toradex: apalis-imx6: Fix build failure when
 CONFIG_VIDEO_IPUV3 is enabled
Message-ID: <20250331141115.GU93000@bill-the-cat>
References: <20250328102051.2614040-1-rafael@beims.me>
 <20250328160557.GY93000@bill-the-cat>
 <20250330185632.GA6356@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oQpx2azvctqJTv2c"
Content-Disposition: inline
In-Reply-To: <20250330185632.GA6356@francesco-nb>
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


--oQpx2azvctqJTv2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 30, 2025 at 08:56:32PM +0200, Francesco Dolcini wrote:
> On Fri, Mar 28, 2025 at 10:05:57AM -0600, Tom Rini wrote:
> > On Fri, Mar 28, 2025 at 11:20:40AM +0100, rafael@beims.me wrote:
> >=20
> > > From: Rafael Beims <rafael.beims@toradex.com>
> > >=20
> > > If CONFIG_VIDEO_IPUV3 is enabled without also having CONFIG_IMX_HDMI
> > > enabled, the build fails for the Apalis iMX6 board.
> > >=20
> > > Fixes: 592f4aed6db7 ("arm: imx: initial support for apalis imx6")
> > > Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
> > > ---
> > >  board/toradex/apalis_imx6/apalis_imx6.c | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> >=20
> > Is there a reason why this requirement isn't enforced at the Kconfig
> > level? In other words is (CONFIG_VIDEO_IPUV3=3Dy && CONFIG_IMX_HDMI=3Dn=
) an
> > otherwise useful and valid configuration?
>=20
> I would say no. You can have the display output over DPI or LVDS, with
> HDMI non being required at all.

And so yes, it's a useful and valid configuration. OK, thanks.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--oQpx2azvctqJTv2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfqooMACgkQFHw5/5Y0
tyxJlAv+JdHLTYPoeSbgfZgkw6d9NQZy1qeIGQ9eKzAPQ+LbDuEfzXH9KGEaUSkt
UCbpdfhw1a8/U3h04HEW7Xb4WgY+m53uxOJAD2fZB+yFUPEsLxPXSxBCDWwwARcS
QOzFXAq2k+WTSD5hPdrJKkNmZnQH+302ZkAiV7KO+YANBoS5YGIogG5hzJu/EBuB
zYIINzOCUb2B6zHvWtn4Mxr7W095elrMKGTIIb614RLO9PZ0uk16OsEdso723dKy
FdtrhQjKWolqWBnq5MljHmuC35QhrKyFDkjIlsz2+jiZk6l2yTaAB1qIcQ1P5woY
VNZIvpOt9DGvK62lr6FqBbgbrzB+uz9QcFkq/x2Q7prUfv/L2/dwXUuDeZ7yIsWw
Mj38RbT4IlYmof2lfFdIwNEv8Cb/K/HX+96ORHayXJKzTTXIQAQwQCtIRncQJOZt
OIbRpmUjdlRhPmNlVVY/xy5OmKokFaSgU0cZ8bkvnvRmBswY0PtS/b8k/z/Dy9Hg
Y1GOKgIx
=eCzU
-----END PGP SIGNATURE-----

--oQpx2azvctqJTv2c--
