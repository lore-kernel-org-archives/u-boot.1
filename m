Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F33C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 17:58:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EA98879D8;
	Thu, 28 Dec 2023 18:57:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WzcioeHJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C53879D8; Thu, 28 Dec 2023 18:57:57 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 420E28775F
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 18:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5eefd0da5c0so10699677b3.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 09:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703786274; x=1704391074; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PoYGhFR14D8O9QJFUF4mVyvudljzreh16hnoRLWP+kE=;
 b=WzcioeHJoHqfFDEZ/0NZ2vYPo1krCLVn6aM7Zwt1n2iSCEs+isyW8D219vfRChFhmD
 Bx5oa7u8Aajf00XbJh/N23mDz8x+e+Aa//0hHUjRgHIM8HE8h1wYWbUdE+iD4MABj+zX
 IPOaaHs98ZuNLf68HqCP7BlPUAQEHg7z4ka2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703786274; x=1704391074;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PoYGhFR14D8O9QJFUF4mVyvudljzreh16hnoRLWP+kE=;
 b=p2d4hcqUL6mp/EnplCnljtKy48Sx0mjqzFQXmhISVgPAhqTrby7jx0XtNYDmRCdSDb
 4nJZbAfNWgS5LuwkJF6FmzsDp8p58G2WbI4FMQi76PtKwYUVha7elfBEg8QCzL/C5bRc
 jc9oLo3XuCJhcqI3L2979gX2jyw4R7g+qze1p4yZkepPSL5nh6N9LPVVbRhXrw6O3xNy
 Z7SiI05SltHXONuReeo17Wgap4+ZeYCcnjGiM9da3EeE3CseXfPVhsJMPfWOYClV4N2E
 9ehiQB4ARfePSuY6AyIVCr7iVgg/uixrY7U8Z9Y75cOG6d42HVxiWQJTSM2TlsG9WFY3
 faNA==
X-Gm-Message-State: AOJu0YwUsRQ2Y6MiXRYBrHR6IbWgLqQor41C7lr6SKWSXdrzUxGDba/D
 Z4Qf/pLNRam5BoBqsvHheMI20eX0lAm/8A==
X-Google-Smtp-Source: AGHT+IEGdPZoJzZ1G+g7/MkqU43GgaWahfFLr+8tZeclt0bjNEf5c3cQ69j3os/g0Nv0jaJITBQsbw==
X-Received: by 2002:a81:5b82:0:b0:5d7:1940:b36e with SMTP id
 p124-20020a815b82000000b005d71940b36emr7713943ywb.58.1703786273964; 
 Thu, 28 Dec 2023 09:57:53 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 u66-20020a818445000000b005e6d6903934sm7699035ywf.9.2023.12.28.09.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 09:57:53 -0800 (PST)
Date: Thu, 28 Dec 2023 12:57:51 -0500
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Simon Glass <sjg@chromium.org>, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de, xypron.glpk@gmx.de, pbrobinson@gmail.com
Subject: Re: [PATCH v4 4/7] smbios: Use SMBIOS 3.0 to support an address
 above 4GB
Message-ID: <20231228175751.GN2652760@bill-the-cat>
References: <20231227074025.2178825-1-sjg@chromium.org>
 <20231227074025.2178825-5-sjg@chromium.org>
 <CAC_iWj+yGhUVFh+vJ14C2htibdd289SrPjz0Y_r3GL4uF4Zdog@mail.gmail.com>
 <CAFLszTgXZ3fMZkuYRJUzSBv-VT659Q5bYLyVkEh4=-36TM3+Bw@mail.gmail.com>
 <87edf6mlla.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k0Amj9e5kA0f+gea"
Content-Disposition: inline
In-Reply-To: <87edf6mlla.fsf@bloch.sibelius.xs4all.nl>
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


--k0Amj9e5kA0f+gea
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 03:46:09PM +0100, Mark Kettenis wrote:
> > From: Simon Glass <sjg@chromium.org>
> > Date: Thu, 28 Dec 2023 13:37:03 +0000
> >=20
> > Hi Ilias,
> >=20
> > On Wed, Dec 27, 2023 at 11:05=E2=80=AFAM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Wed, 27 Dec 2023 at 09:40, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > When the SMBIOS table is written to an address above 4GB a 32-bit t=
able
> > > > address is not large enough.
> > > >
> > > > Use an SMBIOS3 table in that case.
> > >
> > > Maybe I missed this on the previous revisions, but is there a reason
> > > we don't always use SMBIOS3 now?
> >=20
> > I am not sure...there was some comment about it not being supported in
> > some cases, so I have tried to accommodate that.
> >=20
> > >  And perhaps try to install SMBIOS2 if
> > > 1. we fail
> >=20
> > due to?
> >=20
> > > 2. and the address is < 4GB
> >=20
> > We could, I suppose. Effectively we would drop generation of SMBIOS2.
> >=20
> > I really don't mind. This whole SMBIOS thing is a bit ridiculous, if
> > you ask me.
>=20
> Linux added support for the SMBIOS 3.0 64-bit entry point in 2014.  I
> doubt anyone who cares about SMBIOS cares about kernels that old.
>=20
> So if it simplifies things, I'd drop support for the 32-bit SMBIOS
> entry point.

I agree, lets just provide SMBIOS3 tables.

--=20
Tom

--k0Amj9e5kA0f+gea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNtxsACgkQFHw5/5Y0
tyzMOgwAuW+JYXpSRR5tTMHiZuSpd4XagsHtwr227qro1Cr1yqbcyQQnIUdPylnE
gW03U6M0ghUWH4b2wkpLQuzXCLFpQcnEGGwr9OnTT27aCYkQU9IRxM5C1jvTk/dQ
j2Gji2n33Kx3VZ7Cjs8ErlbijgJl7huxdad9Y5M1rSvEzb1XmcyGPpFI0zmESS+p
Zrf4jyEeS0EIHgnP4nZHDPLaXsxmqe8MJtSskGxvSya3wrzEjowuDllBkDDGhv+l
34m2mfz4t0jPZGRE75nl3UcWkIrB97974rGDTJaYN1h/hsywqmS27iV1h99h3RS/
FRVcy1M8S1MvWd9x2jUFEFj5keSJCP/X8lygVsTVUoyRRZy8Ox1Ok/SA9fCsZITk
YXagJJDQc5e0lxkhl5k2HjXFZcGtzcjFMxlr58miu68rERUnYJ9c6ROfbMhpM8Ev
9rveole45fqhwYJcoTBom03xyJeSFPwJP9JxvnaKG1TKZSsJAwB7PfWSrPJfx79k
XRVK2QSn
=RDxm
-----END PGP SIGNATURE-----

--k0Amj9e5kA0f+gea--
