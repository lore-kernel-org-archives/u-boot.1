Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA72D7494F
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 01:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9542F891B2;
	Wed, 30 Oct 2024 02:10:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PFrbcIBE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C65D89198; Wed, 30 Oct 2024 02:10:22 +0100 (CET)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EB86891BB
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 02:10:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dgibson@gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=202410; t=1730250612;
 bh=mx4FL4k2+0M0lWoLfD9V7wM5DYXRUwD2B/rKwAG2H2s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PFrbcIBEPICTXfuaZw3ZW6lS0CszerqWDYNf27734Wp2KCuuUzRpOOX0/C037aKCY
 Cc4iWHqu9oLVKRZVwl8PG6qIjoiYEf78XuZ9XArbhry6SZcz3k5rmZUkRC9e8coEtL
 gG3sCbMGlnC2ffw4ONcrX+QDMtDg57176OjUjIMYkPexAkvBLwt8ka0HXAc64jAXvZ
 6DFnth/5ZEmp4UEQWCjMMGKkvylJy6sFZA3l5mIOWQ6tjpyBuIp3fpLoVXAIfIrsKj
 byIvUzAJBw3ss55HbAr8lGdYI/u9QuD4vDDzYEi12Hxn/ogMNUEkodgCqJ4WZMBL0l
 1TIA6vP4ZBIPQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4XdTZD1J0Mz4xM1; Wed, 30 Oct 2024 12:10:12 +1100 (AEDT)
Date: Wed, 30 Oct 2024 12:08:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Rudi Heitbaum <rudi@heitbaum.com>, u-boot@lists.denx.de,
 devicetree-compiler@vger.kernel.org
Subject: Re: [PATCH] libfdt: Fix build with swig 4.3.0
Message-ID: <ZyGHKJZe4q3ZP5oc@zatzit>
References: <Zxzh0ODFyZnav5JE@74d70d9af7e3>
 <fc3dcef2676252484cfa427ad0197cd9aa697420.camel@xry111.site>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NJ22H3zRfGsbk/tH"
Content-Disposition: inline
In-Reply-To: <fc3dcef2676252484cfa427ad0197cd9aa697420.camel@xry111.site>
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


--NJ22H3zRfGsbk/tH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 08:52:52PM +0800, Xi Ruoyao wrote:
> On Sat, 2024-10-26 at 12:34 +0000, Rudi Heitbaum wrote:
> > Call SWIG_AppendOutput instead of SWIG_Python_AppendOutput so that
> > is_void is handled within swig.
> >=20
> > Link: https://github.com/swig/swig/commit/cd39cf132c96a0887be07c826b808=
04d7677a701
> >=20
> > Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
>=20
> Dtc is a separate project at
> https://git.kernel.org/pub/scm/utils/dtc/dtc.git, so the patch should be
> rebased against it and sent to devicetree-compiler@vger.kernel.org.

Looks like someone independently fixed it upstream:
    https://github.com/dgibson/dtc/pull/154

I'm doing final tests now and expect to merge shortly.

>=20
> > ---
> > =A0scripts/dtc/pylibfdt/libfdt.i_shipped | 6 +++---
> > =A01 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibf=
dt/libfdt.i_shipped
> > index 56cc5d48f4..e4659489a9 100644
> > --- a/scripts/dtc/pylibfdt/libfdt.i_shipped
> > +++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
> > @@ -1037,7 +1037,7 @@ typedef uint32_t fdt32_t;
> > =A0			fdt_string(fdt1, fdt32_to_cpu($1->nameoff)));
> > =A0		buff =3D PyByteArray_FromStringAndSize(
> > =A0			(const char *)($1 + 1), fdt32_to_cpu($1->len));
> > -		resultobj =3D SWIG_Python_AppendOutput(resultobj, buff);
> > +		resultobj =3D SWIG_AppendOutput(resultobj, buff);
> > =A0	}
> > =A0}
> > =A0
> > @@ -1076,7 +1076,7 @@ typedef uint32_t fdt32_t;
> > =A0
> > =A0%typemap(argout) int *depth {
> > =A0=A0=A0=A0=A0=A0=A0=A0 PyObject *val =3D Py_BuildValue("i", *arg$argn=
um);
> > -=A0=A0=A0=A0=A0=A0=A0 resultobj =3D SWIG_Python_AppendOutput(resultobj=
, val);
> > +=A0=A0=A0=A0=A0=A0=A0 resultobj =3D SWIG_AppendOutput(resultobj, val);
> > =A0}
> > =A0
> > =A0%apply int *depth { int *depth };
> > @@ -1092,7 +1092,7 @@ typedef uint32_t fdt32_t;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (PyTuple_GET_SIZE(resultobj) =3D=
=3D 0)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resultobj =3D val;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resultobj =3D SWIG_Python_Appe=
ndOutput(resultobj, val);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resultobj =3D SWIG_AppendOutpu=
t(resultobj, val);
> > =A0=A0=A0=A0=A0=A0=A0=A0 }
> > =A0}
> > =A0
>=20

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--NJ22H3zRfGsbk/tH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmchhycACgkQzQJF27ox
2Gf3XA//dBUPWSn6TrEKuEWFBJ35op9FxWbhL9+2SOY+PaaZW6YqHf6Fe6I0Fv7p
ueCutJG4ckzo3WTILMPlDiLLeT33GndPVjeudCZCamNfDnsbLIEsIOypKCXDcC2g
Xt6ati4x3lCBN6u4kzFlR4KgIqcNgT0UhIT3Q3cky9jtoLvfQgYcEdn9pzZiFO+r
8bb/2dPq4CsNqtw2gN30Y3DiUydk6q1SGeqhOAJ5lcrynaUyz01Q2rt7c2uWmunq
8InfSBdV85PVtWJxV6TzbBCpt73dXU1yJHHp8sgvlcrJ52pLBIApATAU05BEuWpv
GMPSNxbAskus31yj8Jl7JSZANGZDIHnKcfRxRMFwY8vdAo9cwPvSFrAnquWLg4ut
AwbpSeYFxvee6lfXrMJn9Fd8fDGC/KkETblxZTBeUALPXnNxx1xOwWF16G1kHpFm
BquyUxHo6Gv2a4itDgb+jvleFx2dZhPzfbTRmRno4R/0cY/dw9gYW/jcRfN3noft
im816Rf82NE4YPq+h+P8x5wiTz2M/rXkzYOjzAd2sZsSWt07xtIuVCh2g8yDd3LL
d8edkn/YYhqFBrluey3JQ2sTpz6Qw3tQYxC6JdmYEWW1YvBQkjNYnMogmBdxEQb+
05Co37+F9PFWVNOkHZAjhs7PIZJz+KUaLPDjlNk73q5OPCbNMQI=
=GDO4
-----END PGP SIGNATURE-----

--NJ22H3zRfGsbk/tH--
