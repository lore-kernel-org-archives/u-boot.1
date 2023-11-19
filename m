Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F53C54FB9
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 20:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 447E487504;
	Sun, 19 Nov 2023 21:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B9XIUm6P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEE08874B1; Sun, 19 Nov 2023 21:28:48 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C275E87174
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 21:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a87ac9d245so41384917b3.3
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 12:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700425717; x=1701030517; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ECEVYv/inhfk8fYng96weCGybGtr1nUXXUVvuQHV5+k=;
 b=B9XIUm6P39RC5oNZLP3SykgYcFApMRwrZCYsSqsFkrfe6EfZrgvlnnpcsaUrgrSuNx
 WOep+r+9HlVXDLZI0j2aLYrY0fINSJqtnqt5FAiRfy8d83x8FxmdEooeY6p4QoSIOkJ5
 sw1WYhVvNpTt12mZu1XTjVFL9BM2JCZz+gGkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700425717; x=1701030517;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ECEVYv/inhfk8fYng96weCGybGtr1nUXXUVvuQHV5+k=;
 b=YEwHiJech8m3ZKLKPHIlutYApP9SV23OfK2RiPBf9nMZyPbphWBvHmt42k7UGuYWJu
 PaqDbczvLdqZ9gModXfZ4FvfN6Fdz/V1nXjUtS4NVc8P3g2TuoUEs/zCA37dDWlUl1bx
 tVqIE7HKfKo3rKahOdb/HXl0nOFIHyg75VPwYFUfguEn4T/mVItg4VJgQ9t8OPPdd6eV
 qKtkRXSDT8ojMRzk2jdY2hPp5x3c5L9y8ExmC6l2iPR1vs8pbsbvDApxEWFADNHWcC1j
 GeAT2//SQbyFuDQe8LL4jDM3D2bBsLKZekvI5D34rMKZPutlvZJvMtLnqsWuEvsTX2Sz
 FnBA==
X-Gm-Message-State: AOJu0YzGiZMaUDOeEAdnynVwD+fmiG/M+AO8gX/AHc7JaOApg3cWYp5a
 SDtsfW8sjPQUsCsJChYpSborXQ==
X-Google-Smtp-Source: AGHT+IGD9Fujs/pLIF2uFx8Og+GxowsRFayzBfmtG9PdmVOa7IfQfHVftZbpQbzerE10o0AKVTdCOQ==
X-Received: by 2002:a0d:e407:0:b0:5a7:baac:7b34 with SMTP id
 n7-20020a0de407000000b005a7baac7b34mr5915438ywe.28.1700425717478; 
 Sun, 19 Nov 2023 12:28:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-af10-dfdb-a5aa-dfc7.res6.spectrum.com.
 [2603:6081:7b00:6400:af10:dfdb:a5aa:dfc7])
 by smtp.gmail.com with ESMTPSA id
 j142-20020a819294000000b0059f802fad40sm1901203ywg.22.2023.11.19.12.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 12:28:36 -0800 (PST)
Date: Sun, 19 Nov 2023 15:28:35 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 3/5] video: Use cyclic to handle video sync
Message-ID: <20231119202835.GG2513409@bill-the-cat>
References: <20231119144700.631322-1-sjg@chromium.org>
 <20231119144700.631322-4-sjg@chromium.org>
 <20231119155914.GD2513409@bill-the-cat>
 <CAPnjgZ2fsudcDFAr-sXhviYCBNwQtJJs3Tvi8yqgx4TUL7h=jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QoSYoyeLg3/qlDr2"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2fsudcDFAr-sXhviYCBNwQtJJs3Tvi8yqgx4TUL7h=jA@mail.gmail.com>
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


--QoSYoyeLg3/qlDr2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 11:23:59AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 19 Nov 2023 at 08:59, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Nov 19, 2023 at 07:46:41AM -0700, Simon Glass wrote:
> > > At present U-Boot flushes the cache after every character written to
> > > ths display. This makes the command-line slower, to the point that
> > > pasting in long strings can fail.
> > >
> > > Add a cyclic function to sync the display every 10ms. Enable this by
> > > default.
> > >
> > > Allow much longer times for sandbox, since the SDL display is quite
> > > slow.
> > >
> > > Avoid size growth if the feature is disabled by making the new init a=
nd
> > > destroy functions dependent on CYCLIC being enabled.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  drivers/video/Kconfig        | 30 +++++++++++++++++++++++
> > >  drivers/video/video-uclass.c | 46 ++++++++++++++++++++++++++++++++--=
--
> > >  2 files changed, 72 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > > index 6f319ba0d544..1742e342f466 100644
> > > --- a/drivers/video/Kconfig
> > > +++ b/drivers/video/Kconfig
> > > @@ -7,6 +7,7 @@ menu "Graphics support"
> > >  config VIDEO
> > >       bool "Enable driver model support for LCD/video"
> > >       depends on DM
> > > +     imply CYCLIC
> > >       help
> > >         This enables driver model for LCD and video devices. These su=
pport
> > >         a bitmap display of various sizes and depths which can be dra=
wn on
> >
> > We should at least expand the help message to say that if you enable
> > cyclic you get some other behavior. In hind sight, cyclic shouldn't be
> > prompted and it should be selected as used. But that's not an issue for
> > this patch set.
>=20
> Yes it is similar to EVENT I think. But note that some boards do use
> it for other purposes.
>=20
> I assume you mean to expand the help for VIDEO

Yes, please expand the help in VIDEO.

--=20
Tom

--QoSYoyeLg3/qlDr2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVab/MACgkQFHw5/5Y0
tyxE6Qv/R7WZYt79YqY0TXBNvn4tPUSA3LC8OD8qOi6twKDWJv9q6r/cc4MzrYkI
SCRVPy0AsBkWvuE5G5U93AIjk4ovWe2fgV4t0Y00OjV/S4PHPWpC5Ap5CuC5PExZ
IOz3Pr4uPDC171gj/fvvj75scoMlBtAuVwILSdJ0e9cGuicAeaCZ25xwnjf8fApe
1ZTuOhtbaSn3RcBxAD/KlCrxnXbpHLQYi5d0No3khg57yxUveIl4cQW7el3kPq5f
LyF9wQyFCFarsLxRy+E8dyye5+dvai7XC+Xj/vzwx2Vb18MS9XJsNTx/qXVSLE4C
pJ0hccxnMAR9bn0Cq6rrNQoTqrB+ZVew2sc//jCUNQ3UheQKa2dfYGCk5amUrZ96
R+chzwMRck8gNu/Vz6LCHvEDWWxYJQym5A8+lWwpjUpbnQOjFO8p5PtehleDzvRT
Yz/lrncEpLYupacsmSoEzs5mcMd/d20cTUsvKkTj14BVV4k9vANiMENOsaRvCZ7Q
R3Mk2mRD
=RzB+
-----END PGP SIGNATURE-----

--QoSYoyeLg3/qlDr2--
