Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE49C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:30:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F218749F;
	Wed, 13 Dec 2023 21:30:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JtuYTlMp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE5BB8743A; Wed, 13 Dec 2023 21:29:58 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6DBA877F4
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:29:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5e2bd289172so10879017b3.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702499394; x=1703104194; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UjTHyiKWchZDloYPONFEeu6JxhhS036P0CEL2z9ODj0=;
 b=JtuYTlMpYP4eG4qVywLuZRWvdR4uQhkdTXgNinbMjLL6/dkoeEhNNrB1Ds83z3A5fz
 YV17fkpFNxEU3f0RE6lBH9saN+curJn/buMHB9PN5hhGh/xRW6lAEOm3ptsVplculmr1
 BuvT0kWXLt3PJuJLKzTxGFyQyUfOaJcGeS+9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499394; x=1703104194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UjTHyiKWchZDloYPONFEeu6JxhhS036P0CEL2z9ODj0=;
 b=PD7uGui25Vie+kpzVbDxMNfP8KxNxAQHJ9MjqU7Z5r/0CcBKl1syHKicwn8gxmlAlg
 B4PevadGkK5UMeaz0Kq5uBKg9OXOAT8+DaCaKn3wXPt1JhdVRbYFAsiOF2ZDbXIX2NIk
 38774vZNXkvJ/e3Mp8mQX76t/2MBhxz1OyNbQzN+57c0U5r3J/jI6M8MetR8Nrbopmll
 3KXolWl7ynC9OA2JaiXga+bIB+d0FqGzLuxO+o9PbG18N0QZFOP5Q9hwGsTqjhJN/gSL
 Fc5+YGRttLEHeYyC9WBOSlVxU6/vhPw4cCu1CtaRD3WX2h34MtDtJIdL6Lh7dh5MGD0K
 BnQw==
X-Gm-Message-State: AOJu0YzmmwxaSqIgKxIZt941T1RdpI4omfXAhNAt54E2IN0zMbZcw+ps
 fjaFqCKkNv/jw+93HdykFu9nfQ==
X-Google-Smtp-Source: AGHT+IGtRK53jpDwFC8KpfXvjlxMdR4Ji1QKnXlBoDTmfeWNDhzViD30Dzv4fYO7rplRfGeGMU3blA==
X-Received: by 2002:a0d:cc14:0:b0:5e2:cbb3:7b02 with SMTP id
 o20-20020a0dcc14000000b005e2cbb37b02mr1347571ywd.42.1702499394254; 
 Wed, 13 Dec 2023 12:29:54 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d78a-ada8-3cce-fa3d.res6.spectrum.com.
 [2603:6081:7b00:6400:d78a:ada8:3cce:fa3d])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a814a08000000b005d3b4fce438sm4881004ywa.65.2023.12.13.12.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 12:29:53 -0800 (PST)
Date: Wed, 13 Dec 2023 15:29:51 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 jagan@amarulasolutions.com
Subject: Re: [PATCH v4] arm: dts: rockpro64: Add RockPro64 smbios
Message-ID: <20231213202951.GH2513409@bill-the-cat>
References: <cfad9ff8b9263104cc48aaabe4e1eddb@manjaro.org>
 <20231113112309.730323-1-i@shantur.com>
 <CABEcMwUwDypY090MOYSEtBGMRZOBnTk6hKuM2-OcJW-n+M7OHg@mail.gmail.com>
 <20231211205326.GX2513409@bill-the-cat>
 <CAPnjgZ23x6dAwq8UDvTXBikRgC3mbTfH5PV=KVF45pFPXY3cQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="67xNW4HmKn6kvAH7"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ23x6dAwq8UDvTXBikRgC3mbTfH5PV=KVF45pFPXY3cQA@mail.gmail.com>
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


--67xNW4HmKn6kvAH7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 12:50:06PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 11 Dec 2023 at 13:53, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Dec 11, 2023 at 08:42:19PM +0000, Shantur Rathore wrote:
> > > Hi,
> > >
> > > On Mon, Nov 13, 2023 at 11:24=E2=80=AFAM Shantur Rathore <i@shantur.c=
om> wrote:
> > > >
> > > > Add smbios information for Pine64 RockPro64 board and enable in
> > > > config
> > > >
> > > > Signed-off-by: Shantur Rathore <i@shantur.com>
> > > > ---
> > > >  Changes
> > > >  v4: Change PINE64 to Pine64
> > > >  v3: Enable SYSINFO and SYSINFO_SMBIOS in defconfig
> > > >
> > > >  arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 22 +++++++++++++++++++=
+++
> > > >  configs/rockpro64-rk3399_defconfig        |  2 ++
> > > >  2 files changed, 24 insertions(+)
> > > >
> > > > diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm/d=
ts/rk3399-rockpro64-u-boot.dtsi
> > > > index 732727d9b0..089732524a 100644
> > > > --- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> > > > +++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> > > > @@ -9,6 +9,28 @@
> > > >         chosen {
> > > >                 u-boot,spl-boot-order =3D "same-as-spl", &spi_flash=
, &sdmmc, &sdhci;
> > > >         };
> > > > +
> > > > +        smbios {
> > > > +                compatible =3D "u-boot,sysinfo-smbios";
> > > > +                smbios {
> > > > +                        system {
> > > > +                                manufacturer =3D "Pine64";
> > > > +                                product =3D "RockPro64";
> > > > +                        };
[snip]
> > Yes, we should just defer this and pickup the SMBIOS series that Ilias
> > has posted.
>=20
> I don't think it is a suitable substitute, it is just a fallback.
>=20
> So I believe this patch should be applied.

Please note that this patch is adding _less_ details than the top-level
model field contains today for the platform.  The only difference is
"Pine64" vs "pine64".

--=20
Tom

--67xNW4HmKn6kvAH7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6FDUACgkQFHw5/5Y0
tyxWeAwArX5p/7ctxnd5q6Vw8RtSHpbPz0Jh1Dc6Zh18DYMz3Y2sKINHqFFyCYxL
qOtP3XAPKLgbgfW98QWT8OcvDfiLaI1kl91Jeiza/Fm2Od1wsgRIBobSHrqQFmsT
IjxQJy1cobJjiA8d5gxzMjmO6UgeUrmCC77ypOxt4GBQ9ttzJ4HxIlFjqS4r86AO
csZya+0wf44BakRlxw3EzXs6iFTEgpxwPiK/Urn3Dj+kl/OW1fLg6UPBf3toSsdQ
Od/dMW6LEOKaJgW6uU7xAuuWys/WC0cod763adJikc8O/gP5dOumVfdEVAXOFDco
dINri+leoNHxcFPFR/HHYEBXxM4nmyVTiOfIN3MyLZILwdDW5an0NGsUMPpoRltW
BdunEiLbhi90k4mkUhqloA0n7dwCU3j3juBk5KoZ9uyb48LO0v+AvAzezoYARQfU
GyCePnSfR1Iv7nb/daOuj1xjRHLMnWAdbma2C6tpRX9zyGJadT7WtrKq+yjc8UUQ
fq3n7cJr
=6DNF
-----END PGP SIGNATURE-----

--67xNW4HmKn6kvAH7--
