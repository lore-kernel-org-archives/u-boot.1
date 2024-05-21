Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3005C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 16:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 798938835E;
	Tue, 21 May 2024 18:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZEdWT4Hv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AFBD881C1; Tue, 21 May 2024 18:38:16 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CBBE88366
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 18:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-792c3741c71so16580785a.0
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716309492; x=1716914292; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=goszrdD+ZJM+VUybgZ9Nk1Hs2xqmqNwPR9kE6Vp8KoQ=;
 b=ZEdWT4HvCKJOuFQp3aHKRh0fXt0biv331U2XzmR2dXTkQAbu6bq4gNOObPT7sm4H9u
 7qN+xHCqE1ag0XYJbuXoeTfsN0pxGGOdZJNwOL3PfGf5p6Na1yx1PpsQK32JGYIipTSc
 ivWcAmlufUEY9ocfXWZIF13wm38WPXBYYN3Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716309492; x=1716914292;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=goszrdD+ZJM+VUybgZ9Nk1Hs2xqmqNwPR9kE6Vp8KoQ=;
 b=E4UJygzucP0/Kbefv132gL1t6E+kJW8qCH0EPGLuYXucNYVjADRxwjwXQ9KXZjf6K6
 tq1leVqKr8yPCH3vxmodLNIES6VgrZ3GxeP5FufD8mZpHDvBOkHaE+nXNl5/ov8y73kN
 odxR2p4IhjATQUYPpcXb6nsPine2XYtUM/JcWC+e9CsHZNRtgiAO5pv8ypN9eq5cZVUJ
 dNpAxVtPLNv1k3s+vynSGq3M86TF7a673A/8VdFFwtf/YbnL836PL6kk+bE7x90kqt0/
 8zCTk6GT26vChZbutt7TnMZU9cAFgcYJBNSKRZ0RIJF2N7YQsutv1E5n+l8hyF8f5zGn
 0j5w==
X-Gm-Message-State: AOJu0Yzr1Ir7utPrbBRxhocF8AVtldr8VhtkKI5+W1IpUqcxyAZVxIr8
 JTpSInPf0Edui9lR17RDjOgHCEciMVyv4524oH/BFcZ576fFB2+VJE4Dr/Egrt3Z5YB7OPYvjuV
 3ot0=
X-Google-Smtp-Source: AGHT+IHeHdGDNdEoGn4tZ1hMNXAo5srfx5pCq5fd6k4uAaKVpPDGNmGRfLjXcPbfbBk0f+Ytu/m2AQ==
X-Received: by 2002:a05:6214:3d99:b0:6a9:c11f:67ba with SMTP id
 6a1803df08f44-6a9c11f6d3cmr73876086d6.30.1716309491875; 
 Tue, 21 May 2024 09:38:11 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f185787sm125083586d6.45.2024.05.21.09.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 09:38:11 -0700 (PDT)
Date: Tue, 21 May 2024 10:38:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [v3 2/2] doc: process.rst: Document device tree resync rules
Message-ID: <20240521163809.GW2568172@bill-the-cat>
References: <20240517174930.1028063-1-trini@konsulko.com>
 <20240517174930.1028063-2-trini@konsulko.com>
 <faf64499-9203-4941-98aa-82e6e529c987@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gp7jsOCT1Wi9zYew"
Content-Disposition: inline
In-Reply-To: <faf64499-9203-4941-98aa-82e6e529c987@cherry.de>
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


--Gp7jsOCT1Wi9zYew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 11:27:36AM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 5/17/24 7:49 PM, Tom Rini wrote:
> > Document the logic of when we do a full resync of the device trees used
> > by OF_UPSTREAM as well as that cherry-picking is allowed as needed.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Changes in v3:
> > - Actually commit the changes I intended for v2
> >=20
> > Changes in v2:
> > - Address Quentin's feedback
> >=20
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Quentin Schulz <quentin.schulz@cherry.de>
> > ---
> >   doc/develop/devicetree/control.rst |  9 ++++++---
> >   doc/develop/process.rst            | 13 +++++++++++++
> >   2 files changed, 19 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetre=
e/control.rst
> > index 4cc1457d4ea8..ca4fb0b5b10f 100644
> > --- a/doc/develop/devicetree/control.rst
> > +++ b/doc/develop/devicetree/control.rst
> > @@ -113,9 +113,12 @@ SoC being used via Kconfig and set `DEFAULT_DEVICE=
_TREE=3D<vendor>/<name>` when
> >   prompted by Kconfig.
> >   However, if `dts/upstream/` hasn't yet received devicetree source fil=
e for your
> > -newly added board support then you can add corresponding devicetree so=
urce file
> > -as `arch/<arch>/dts/<name>.dts`. To select that add `# CONFIG_OF_UPSTR=
EAM is not
> > -set` and set `DEFAULT_DEVICE_TREE=3D<name>` when prompted by Kconfig.
> > +newly added board support then one option is that you can add the corr=
esponding
> > +devicetree source file as `arch/<arch>/dts/<name>.dts`. To select that=
 add `#
> > +CONFIG_OF_UPSTREAM is not set` and set `DEFAULT_DEVICE_TREE=3D<name>` =
when
>=20
> I don't like the wording here because it implies we should modify the
> defconfig by hand, which nobody should ever do.
>=20
> I could suggest:
> """
> To do that, unselect `OF_UPSTREAM` and set `DEFAULT_DEVICE_TREE=3D<name>`
> through a Kconfig tool (e.g. `menuconfig`).
> """
>=20
> In any case, this is wording is not added in this patch, so I guess we co=
uld
> fix it in another patch as well, making this remark not a "blocker".

Yes, I agree that would be a better way to explain things here.

--=20
Tom

--Gp7jsOCT1Wi9zYew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZMzfEACgkQFHw5/5Y0
tyzBXAwAl+7/cfBPcZAspS9hz3drTz0GoSOBW+gShaslEjZZS4Pk0wnaX9GTjax/
Y/9DtwTnxM6BYdih2+gLSIs8gvSF2OgkjHYIvga7j5qIrbfGWaF385sD9OgwUUd7
lQhBUGlCngnxq63Q+yc9sYpK3txsRipM0fsT7CTg9D29Gkc1xxSJ2EEj3EauBPzL
SvoS6ZHCLaJ2watuOaGXqJ/7NqWnXukedO2Bvl5Y5a50QGn8JitMq2QNo+TyJpDP
znV+2oecDHDYdCQRpsZTvAgNFCx3t/GX0THk+CagKPL9RTUcF7+nHCwkmA2R0O2Y
v3NVSJV2QxpF78RFPP89VOY56KgQqiUBFaG2zS2UDuP4PPkK69whC+Pp1c+pSO8k
4ZuoIwba4dzZ84au4XQFDbBJRna3ojgUdlW1ymkmqLgvGBibC0Z/OCds5RBzJnLN
YA5f2fWhwsVZJwCPhXefoSVaxgIFRyXB4AfbnLQEOB7xxj5le0MTyD21viFV9wwk
1Icgz9ng
=II+g
-----END PGP SIGNATURE-----

--Gp7jsOCT1Wi9zYew--
