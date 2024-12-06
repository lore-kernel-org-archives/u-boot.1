Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B46E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 15:15:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B8A989173;
	Fri,  6 Dec 2024 16:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m5ws4mXr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77F358960E; Fri,  6 Dec 2024 16:15:43 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5FE189173
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 16:15:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-466966d8dbaso24731711cf.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 07:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733498139; x=1734102939; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nO+LEufgWrmznI+XACugkgEAFTUlBR9WfByMkZtrA7Q=;
 b=m5ws4mXrvnfTVudLPD21VofzxCyOGP7uWiw0wi+FN6QZOJ0tswaGcGZY0sht3O2gLS
 5sCpUgXkHV52kb1kUJYv5zbAT2/GfKwwHg3SEuhrzeI9Ane7cGe5twbkwohTXwh5l3ss
 CBqJTOsxSDzHLWJMlxbAs5ixiERPQcCt5QiBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733498139; x=1734102939;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nO+LEufgWrmznI+XACugkgEAFTUlBR9WfByMkZtrA7Q=;
 b=k4jthYyqslTMUogwNGdsqwwOvPKV1dactQhE6D/Q/BcmiyT1iqIv1QeakRvrdRDAMC
 f+8zkXNsSz82gnD/iWgc6lM7VAiXGTU/Rk37bk+fsyA7uaaj9Fe2WsCRZABXnBnN3rOU
 O2evC3Tk+RxXAKP4Kj/ZsfcosYoBF3KAqMlS54+5pF1FPK47zpO/Uou4JH0tsjJHDPAe
 yIpvvAjeT7MQO8e4ULov7GQ0Vl62ITkQb4kb65p4Og2yQv0Srls85DcoB1TqyIsn5G73
 t2BzQ8I98PinXKQhEsbms56pABuXFdDFU+avc/XSU5lNrm/8KTaYCmDecZOmxQcr0y4a
 jBGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR0tSqGFWTctCbJ6hMVuC6acrPzGD7vpN/tW+y8G9I+BDXAqQ8AZaG2Qbo4ddEsmMFUtV+aP8=@lists.denx.de
X-Gm-Message-State: AOJu0YxsKbiBdyxdYWuF6U27tDoth+YPrQgEHQ3WCpgWstkM4pQZDDie
 Xj6Tj/Hy1DryVKxiPf2x7/0qDgl3Frgvda+nVaWYHGRkQaB2D6j0OWXhI0oze1o=
X-Gm-Gg: ASbGncs7ah5GkvCexD1Kq6QH3FcE7E2GEA6xWqZ9/IgzOsFOXk/f8ZA/L2MrETnCpL6
 1gLQ+EihOug9BstL2Pb+sawlZ0T/wMvv7L2olCKPjiWoZjI/hHh22X+uVaxdUBW5bGlS7oGrJCE
 WJOqXic/FuEorMwibFC+cyJwnaUrnWzK0xywYRndb/MsnrWlA5rvzitHsEinIIYkul5CnfM6XD+
 YVCe5mc+FOI9wkWDbw/+z6KxTAjW2Z0KtTUc+EupnfNxx7fCQ==
X-Google-Smtp-Source: AGHT+IHc5pnpPPoXMm4o7+mXIswyAdXU4N0yZ3647VG4gKbeS3otP+buZlFJ8euKxfvdzXU1D7yMoQ==
X-Received: by 2002:a05:6214:b6b:b0:6d8:81cd:a0ce with SMTP id
 6a1803df08f44-6d8e71e7a1amr44522096d6.43.1733498139645; 
 Fri, 06 Dec 2024 07:15:39 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da9feab9sm19750856d6.71.2024.12.06.07.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 07:15:38 -0800 (PST)
Date: Fri, 6 Dec 2024 09:15:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] driver: clk: tegra: init basic clocks on probe
Message-ID: <20241206151536.GR2457179@bill-the-cat>
References: <20241206060115.4346-1-clamor95@gmail.com>
 <20241206060115.4346-2-clamor95@gmail.com>
 <20241206142052.GQ2457179@bill-the-cat>
 <CAPVz0n2mXefetq38_W-Xo8-2xTKUqxLXjz1MupmdaL8brnayxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1wbAVP8rwj4E6vmx"
Content-Disposition: inline
In-Reply-To: <CAPVz0n2mXefetq38_W-Xo8-2xTKUqxLXjz1MupmdaL8brnayxA@mail.gmail.com>
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


--1wbAVP8rwj4E6vmx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 05:09:19PM +0200, Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 6 =D0=B3=D1=80=D1=83=D0=B4. 2024=E2=80=AF=D1=80. =D0=BE 16:=
20 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Fri, Dec 06, 2024 at 08:01:15AM +0200, Svyatoslav Ryhel wrote:
> >
> > > In case DM drivers probe earlier than board clock setup is done
> > > init of basic clocks should be done in CAR driver probe as well.
> > > Add it to avoid possible clock related problems.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/clk/tegra/tegra-car-clk.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/clk/tegra/tegra-car-clk.c b/drivers/clk/tegra/te=
gra-car-clk.c
> > > index 9078253d100..4f8405328a3 100644
> > > --- a/drivers/clk/tegra/tegra-car-clk.c
> > > +++ b/drivers/clk/tegra/tegra-car-clk.c
> > > @@ -111,6 +111,9 @@ static int tegra_car_clk_probe(struct udevice *de=
v)
> > >  {
> > >       debug("%s(dev=3D%p)\n", __func__, dev);
> > >
> > > +     clock_init();
> > > +     clock_verify();
> > > +
> > >       return 0;
> > >  }
> > >
> >
> > Is this called before arch/arm/mach-tegra/board2.c::board_init()?
> > Thanks.
>=20
> It does if the device uses pmic with dm driver and has any of pmic
> regulators set as always-on or boot-on

Ah, OK. I'll wait and see what Simon has to say next, thanks.

--=20
Tom

--1wbAVP8rwj4E6vmx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdTFRAACgkQFHw5/5Y0
tywUBAv/XW4agf8/4pb9OziVy+SPSERHEeGpS4KxpZ8HpdXl+29tS7+yr47mEem8
Xped5DkzLqQpK/z0kbAY7h+CvuQEb6IoT+dJtgaoA79G1JKYNhIFGfBDGd8L8OxO
NB7MybUsoHPlMx6Rn8ROR1cYobnQAlvpCSf0TCfERZUEsiojrCkgmh0APXw+Urmn
TQYrnNxTXEndZMyLeQGRhlqAjs7qcbjPYY4ZZtCUx0CY1DpAiEaYDRMsDhlAwjHb
YsQ6TCRzW/gMaBSXll9EL2JVOYX7HJHnkQCs1Lp5ISLVzB2ZUGSH7wgoTlKaIyXh
dE3MDlEZIIe+cuzftDFIR0a/dmVmuBykaDCFpDIzjrw+TOiWRwYBof2Uz+s47bYQ
KtS8Iu5utncE4Q6hmdI3ITcoipeIBxb2WUi5DbFlWA5fcYI5FuZXgz05lkptH7es
h2rBccRBeBVkw5C3L1nxEwhGiCEwluRPX1e+VDa3qDe/aCIpECxfVgCGi4a0ZT5a
x8ud2/oM
=/Jq5
-----END PGP SIGNATURE-----

--1wbAVP8rwj4E6vmx--
