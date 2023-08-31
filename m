Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187A6C83F01
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 15:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA67865A2;
	Thu, 31 Aug 2023 17:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YwF6GPZp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C06D865A2; Thu, 31 Aug 2023 17:37:27 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4244F8657F
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 17:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-58fae4a5285so11366767b3.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693496241; x=1694101041; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5ym47uEl51yqeYKw/w1BbIsXLlHxj4d8IJALasiXBQI=;
 b=YwF6GPZpRnQDQPE6A/fuI2OZWik2iBMYgTUBA9OqDviCqVd+JjmhtVWN7BSSlWiN+2
 4+eKRxC6ZjG+EN52QfwoHf9LHD1UgHZ5eJVMltLHoFMx3nkXGhtW4YXRmjnc9EmlVC+v
 34lI/qCWhcUVtOY12DiL8KxsuxFIuWvyvaC88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693496241; x=1694101041;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ym47uEl51yqeYKw/w1BbIsXLlHxj4d8IJALasiXBQI=;
 b=clhuzDbnzPtefB88/WvpO3AhBicmJyYRnSAk/dA1xiaTbVJ5LLwWx9p1NXe9io/Zec
 LayIcz6H1t92t0JVMaBc/bZ/fQpjD/v2fDC8c8GgVXAWBTGc5RWWhvjZwvLaUpQC5zwe
 WjQA0FjaFJRHOSvH4Pb8tjFPlWZV8sUv4g6bkyZWfIWuw6GIiysoeU7Lbq0MsYCr4Y3A
 qh9rzjWwvl0VLWcdgMT3LUexR7joHyZipVaYzL/IG+qzkGfPuyFXyA23/NaIgzePow1l
 cLbUcGEVMc18oYrKS1ZV3ofu4wPALGml7koizWhyjhj1D3bWLHs2mypm2aXq96kyDaIi
 48YA==
X-Gm-Message-State: AOJu0YwfvH1zEALHGbun4Wn09VMBUuB2YfiPjA+t9/X39vx3EIzTcUMZ
 zEm7QDRX0IGdFTE71gZwNDA+YA==
X-Google-Smtp-Source: AGHT+IF0s4hHVB5PbCVeaSKXf79w3uF0QvvAwK4Fw7fUMBAsNReHo0yrP0NuV9rQpREThoRa42022w==
X-Received: by 2002:a0d:ca17:0:b0:58c:8b7e:a1e4 with SMTP id
 m23-20020a0dca17000000b0058c8b7ea1e4mr5514750ywd.23.1693496240953; 
 Thu, 31 Aug 2023 08:37:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 c143-20020a814e95000000b00589dbcf16cbsm477600ywb.35.2023.08.31.08.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 08:37:20 -0700 (PDT)
Date: Thu, 31 Aug 2023 11:37:18 -0400
From: Tom Rini <trini@konsulko.com>
To: Roman Azarenko <roman.azarenko@iopsys.eu>
Cc: "sjg@chromium.org" <sjg@chromium.org>,
 "punit1.agrawal@toshiba.co.jp" <punit1.agrawal@toshiba.co.jp>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "massimo.pegorer@vimar.com" <massimo.pegorer@vimar.com>,
 "marex@denx.de" <marex@denx.de>
Subject: Re: [PATCH v2] tools: ensure zeroed padding in external FIT images
Message-ID: <20230831153718.GY3101304@bill-the-cat>
References: <20230825081014.341987-1-roman.azarenko@iopsys.eu>
 <CAPnjgZ0z2fi1b=+hVDVnz_DfA+ku=+1wP1n6ehxGNmtkO7CCHg@mail.gmail.com>
 <89ab674dc53557f093d42fe4ca54ca4a14f8a276.camel@iopsys.eu>
 <CAPnjgZ0Be-fAjFWNwmuHjEvtDCNypDYtH-8+5Son2_S7LeJe4g@mail.gmail.com>
 <bdab65fe23d334a0f5df076df6c1d793cd4d72ab.camel@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MIMpANnFsGvICIfm"
Content-Disposition: inline
In-Reply-To: <bdab65fe23d334a0f5df076df6c1d793cd4d72ab.camel@iopsys.eu>
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


--MIMpANnFsGvICIfm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 09:39:52AM +0000, Roman Azarenko wrote:
> > On Mon, 28 Aug 2023 at 02:00, Roman Azarenko
> <roman.azarenko@iopsys.eu> wrote:
> > >=20
> > > On Fri, 2023-08-25 at 12:06 -0600, Simon Glass wrote:
> > > > > @@ -564,9 +564,13 @@ static int fit_extract_data(struct
> > > > > image_tool_params *params, const char *fname)
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 /* Pack the FDT and place the data after=
 it */
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 fdt_pack(fdt);
> > > > >=20
> > > > > -=A0=A0=A0=A0=A0=A0 new_size =3D fdt_totalsize(fdt);
> > > > > -=A0=A0=A0=A0=A0=A0 new_size =3D ALIGN(new_size, align_size);
> > > > > +=A0=A0=A0=A0=A0=A0 unpadded_size =3D fdt_totalsize(fdt);
> > > > > +=A0=A0=A0=A0=A0=A0 new_size =3D ALIGN(unpadded_size, align_size);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0 fdt_set_totalsize(fdt, new_size);
> > > >=20
> > > > I didn't know that was allowed...I thought it needed fdt_open_into(=
) ?
> > >=20
> > > The introduction of fdt_set_totalsize() comes from commit ebfe611be91e
> > > ("mkimage: fit_image: Add option to make fit header align"). The comm=
it
> > > message doesn't describe the choice of this function vs fdt_open_into=
().
> > >=20
> > > Personally I'm unable to definitively comment on it. I can only blind=
ly
> > > guess, that because we're only changing the total length of the fdt
> > > struct, and keeping all other fields the same, we don't need to alloc=
ate
> > > a new fdt struct with a different size.
> >=20
> > I am not sure if it would cause problems. I do understand that you
> > didn't write the code. You could copy the people who did (and those
> > that reviewed it) for their input.
> >=20
>=20
> @Kever, @Punit, @Tom, could you please comment on this remark by Simon?
> Thank you!

I assume that we're given an already well-ordered device tree at this
point and so that's why we don't use fdt_open_into to move things and
just handle it ourselves at that point in the tool.

--=20
Tom

--MIMpANnFsGvICIfm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTws6cACgkQFHw5/5Y0
tyyDNQwAjqJ94hg/kXdE3QZcY8JGQFIg3Yh+9sQysdhhTP8O96PON1mmtmn6ZXNy
ChGyf1axYIg9B04VmtPPpBFdqvX89LA038fK44mCqcgNq6Fjownov0YPqUQPcOPR
Q7ZXt+4AKMD9qW47dHsOfXeiL+sAV+lSG7R7WR7x3jCZVWhHr965h+RR+xD5X60/
VxA2y3hTguMAN2Wq3x6P4tQ+OS1egMl6Ev2Nfdfo0HJlnztJq+VBYEMMClhrzd8v
auB6XoS6lxkhOTiXwy5YxRcsS88NYzvC0X3gK3PpDh4G4241sIkNTqlxZaOiCU1w
hF1Wb5+wDoalu/N38gXwkfV1etKsB/JJ/LxNeRtmwiEhvtaRQNub/hlRlnX2UbM5
yg8o+DNFr1lXD+G9c/yPKm6dFpFoIG1K/v2m0AhunNOsYXLZkcDIGFGrwuGdKZIg
qngC+DhkwmQ4OTFuQ65VXbTx2n3Arslqs238sP1Ra6hHb7yudSHbAoYGyK/+NPzB
jlET/n9+
=4sGP
-----END PGP SIGNATURE-----

--MIMpANnFsGvICIfm--
