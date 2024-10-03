Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE886CF854E
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 01:40:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3328988F75;
	Thu,  3 Oct 2024 03:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dUCfMIgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 301A188F5B; Thu,  3 Oct 2024 03:40:53 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 900EA88F75
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 03:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7a9ab721058so127553285a.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 18:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727919649; x=1728524449; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ESA552XbigyntHzkWx/dpCjjQNhEWRrw8jclxt6TObY=;
 b=dUCfMIgXsRw8b8CZTp2veD42c8MdRlr8AM3jW3Xcz9lKI9aRcRiZd8Wj2/Lp6KJYU/
 Dnyx6kpUvjTXyhInlOUpGR1WjOJJLz6lc+IkvzHx8X8MdcSIOCCmyI+Xq3WKvGszHn3J
 kNfaLpJtvkdJsyVAkN3x0IzUipkw0mCaB1Te0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727919649; x=1728524449;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ESA552XbigyntHzkWx/dpCjjQNhEWRrw8jclxt6TObY=;
 b=nSZJkkxysQnrpGnFxCDMwQICQjN8RVrFZASsHb8D89qxcKhf4MwRHR356HQnMj9gIj
 x5SLPlvfbY3WfbqQdILiUWuVcxb/fJsbnZDTi5IRcDRkha7JuqxMWclab57dwlWBna5+
 7Ot3T1JPH8aGfeuzrEzfmnC0/czDC1/kmmG7WTGVZJkNtmR1UqiIFCSjivJE7CLgo38n
 T53Oh2wSouPdX/NDQPT8+yzQrLX4FbTA0M38ZB2IHWJ7o8ME4uTZUNaf6qfbvjUPJ7SC
 yeLjZEs/iD7asy7uLK8+50p50kj6hZElUlMiUWRvMzLE4xFjZYBFUaKYPOr55RqYKOho
 VimQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQBio2BIIF/Sdv3W6VupL28qPJVJkfdgvtioJV7Q3hQTgSaB2X6Atb4LwUPe8jZvfgpxuxccA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6gOQHXGfuwTqq1k90l54EJAmxos/kiXV+u0u3UVfpSGWMtktT
 z1wx3iKUjK1fF5aDj1vYmtASQIbYWbtqfIisLPyP6C2uJ/J4oLQFgh6CGvuvICY=
X-Google-Smtp-Source: AGHT+IG2FmV+3zUN5+NHhmxkcWuJ/qOWUMeV+VlNOQgTcQhi20Y6rE6nuP0f0GUT/NI5fwkC4qKcSA==
X-Received: by 2002:a05:620a:3197:b0:7a9:95f6:e372 with SMTP id
 af79cd13be357-7ae67e2a0f8mr334410485a.2.1727919649342; 
 Wed, 02 Oct 2024 18:40:49 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae6b3dc045sm186885a.122.2024.10.02.18.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 18:40:48 -0700 (PDT)
Date: Wed, 2 Oct 2024 19:40:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 u-boot-amlogic@groups.io, u-boot-qcom@groups.io,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 2/4] power: regulator: Convert
 regulators_enable_boot_on/off() to regulator_post_probe
Message-ID: <20241003014042.GS4737@bill-the-cat>
References: <20240926231457.2933914-1-marex@denx.de>
 <20240926231457.2933914-2-marex@denx.de>
 <CAFLszThbZ5t+siC0Gz_7KaecTTwUA6J2uTdtHEaYoK+V6Rm_7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qc4D5VO3myZMzcuS"
Content-Disposition: inline
In-Reply-To: <CAFLszThbZ5t+siC0Gz_7KaecTTwUA6J2uTdtHEaYoK+V6Rm_7A@mail.gmail.com>
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


--qc4D5VO3myZMzcuS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2024 at 04:55:39PM -0600, Simon Glass wrote:
> Hi,
>=20
> On Thu, 26 Sept 2024 at 17:15, Marek Vasut <marex@denx.de> wrote:
> >
> > Turn regulators_enable_boot_on() and regulators_enable_boot_off() into
> > empty functions. Implement matching functionality in regulator_post_pro=
be()
> > instead. The regulator_post_probe() is called for all regulators after =
they
> > probe, and regulators that have regulator-always-on or regulator-boot-o=
n DT
> > properties now always probe due to DM_FLAG_PROBE_AFTER_BIND being set on
> > such regulators in regulator_post_bind().
> >
> > Finally, fold regulator_unset() functionality into regulator_autoset().
> >
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > ---
> > Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
> > Cc: Caleb Connolly <caleb.connolly@linaro.org>
> > Cc: Chris Morgan <macromorgan@hotmail.com>
> > Cc: Dragan Simic <dsimic@manjaro.org>
> > Cc: Eugen Hristev <eugen.hristev@collabora.com>
> > Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Jaehoon Chung <jh80.chung@samsung.com>
> > Cc: Jagan Teki <jagan@amarulasolutions.com>
> > Cc: Jonas Karlman <jonas@kwiboo.se>
> > Cc: Kever Yang <kever.yang@rock-chips.com>
> > Cc: Matteo Lisi <matteo.lisi@engicam.com>
> > Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > Cc: Max Krummenacher <max.krummenacher@toradex.com>
> > Cc: Neil Armstrong <neil.armstrong@linaro.org>
> > Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> > Cc: Quentin Schulz <quentin.schulz@cherry.de>
> > Cc: Sam Day <me@samcday.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Sumit Garg <sumit.garg@linaro.org>
> > Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> > Cc: Thierry Reding <treding@nvidia.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
> > Cc: u-boot-amlogic@groups.io
> > Cc: u-boot-qcom@groups.io
> > Cc: u-boot@dh-electronics.com
> > Cc: u-boot@lists.denx.de
> > Cc: uboot-stm32@st-md-mailman.stormreply.com
> > ---
> > V2: Rebase on current u-boot/next
> > V3: No change
> > ---
> >  drivers/power/regulator/regulator-uclass.c | 60 +++++++---------------
> >  1 file changed, 19 insertions(+), 41 deletions(-)
> >
> > diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power=
/regulator/regulator-uclass.c
> > index 1a970004540..9fcc4bd85b9 100644
> > --- a/drivers/power/regulator/regulator-uclass.c
> > +++ b/drivers/power/regulator/regulator-uclass.c
> > @@ -314,6 +314,11 @@ int regulator_autoset(struct udevice *dev)
> >                         return ret;
> >         }
> >
> > +       if (uc_pdata->force_off) {
> > +               ret =3D regulator_set_enable(dev, false);
> > +               goto out;
> > +       }
> > +
> >         if (!uc_pdata->always_on && !uc_pdata->boot_on) {
> >                 ret =3D -EMEDIUMTYPE;
> >                 goto out;
> > @@ -518,56 +523,28 @@ static int regulator_pre_probe(struct udevice *de=
v)
> >         return 0;
> >  }
> >
> > -int regulators_enable_boot_on(bool verbose)
> > +static int regulator_post_probe(struct udevice *dev)
> >  {
> > -       struct udevice *dev;
> > -       struct uclass *uc;
> >         int ret;
> >
> > -       ret =3D uclass_get(UCLASS_REGULATOR, &uc);
> > -       if (ret)
> > +       ret =3D regulator_autoset(dev);
> > +       if (ret && ret !=3D -EMEDIUMTYPE && ret !=3D -EALREADY && ret !=
=3D ENOSYS)
> >                 return ret;
> > -       for (uclass_first_device(UCLASS_REGULATOR, &dev);
> > -            dev;
> > -            uclass_next_device(&dev)) {
> > -               ret =3D regulator_autoset(dev);
> > -               if (ret =3D=3D -EMEDIUMTYPE || ret =3D=3D -EALREADY) {
> > -                       ret =3D 0;
> > -                       continue;
> > -               }
> > -               if (verbose)
> > -                       regulator_show(dev, ret);
> > -               if (ret =3D=3D -ENOSYS)
> > -                       ret =3D 0;
> > -       }
> >
> > -       return ret;
> > +       if (_DEBUG)
> > +               regulator_show(dev, ret);
> > +
> > +       return 0;
> >  }
> >
> > -int regulators_enable_boot_off(bool verbose)
> > +int regulators_enable_boot_on(bool verbose)
> >  {
> > -       struct udevice *dev;
> > -       struct uclass *uc;
> > -       int ret;
> > -
> > -       ret =3D uclass_get(UCLASS_REGULATOR, &uc);
> > -       if (ret)
> > -               return ret;
> > -       for (uclass_first_device(UCLASS_REGULATOR, &dev);
> > -            dev;
> > -            uclass_next_device(&dev)) {
> > -               ret =3D regulator_unset(dev);
> > -               if (ret =3D=3D -EMEDIUMTYPE) {
> > -                       ret =3D 0;
> > -                       continue;
> > -               }
> > -               if (verbose)
> > -                       regulator_show(dev, ret);
> > -               if (ret =3D=3D -ENOSYS)
> > -                       ret =3D 0;
> > -       }
> > +       return 0;
> > +}
> >
> > -       return ret;
> > +int regulators_enable_boot_off(bool verbose)
> > +{
> > +       return 0;
> >  }
> >
> >  UCLASS_DRIVER(regulator) =3D {
> > @@ -575,5 +552,6 @@ UCLASS_DRIVER(regulator) =3D {
> >         .name           =3D "regulator",
> >         .post_bind      =3D regulator_post_bind,
> >         .pre_probe      =3D regulator_pre_probe,
> > +       .post_probe     =3D regulator_post_probe,
> >         .per_device_plat_auto   =3D sizeof(struct dm_regulator_uclass_p=
lat),
> >  };
> > --
> > 2.45.2
> >
>=20
> I thought I objected to this patch, but it seems to be in -next? Does
> anyone know what has happened here?

Yes, you missed me noting that this fixes real problems and has been
needing to be fixed for a while. I said you should provide your
alternative approach and we'll get this sorted out in -next and I took
the work-around for master so the release wouldn't be broken.

> I am seeing these errors now when running sandbox 'u-boot -D':
>=20
>        i2c_emul_find() No emulators for device 'sandbox_pmic'
>   sandbox_pmic_write() write error to device: 0000000018c49db0 register: =
0x0!
>        out_set_value() PMIC write failed: -5
>        i2c_emul_find() No emulators for device 'sandbox_pmic'
>   sandbox_pmic_write() write error to device: 0000000018c49db0 register: =
0x0!
>        out_set_value() PMIC write failed: -5

I suppose the good news is that perhaps this is also related to the
problem that Svyatoslav was reporting.

--=20
Tom

--qc4D5VO3myZMzcuS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb99hoACgkQFHw5/5Y0
tyzThQv+Im6I/qpTYIKuSWPpHMaDiZ8wmr1qhQUJIL5Lg2PI+h/rc10L9xvVclXO
yraqCA2hIAEXsE4ZyQ3RDzudkDIo9yA7CGHzSSaPAlTDc7eZqQH88ydVFSBhR1QM
jwojLuk9bev6KhtWyxR+InJS8OYSR7buX/15AR6JegRBYBhAwAd+aqNEljleXJP2
YAspMvX2d5GnmVDy8ZWK8ZzcVtY6oGplk/GhkiIm4PtOb3c/tDHPs8Ta7OmgCBrW
OacFPMtoAaXHPvzx8lg/b45VQ+TiJsNWEbnrjJ+Oj6KmK1A4U2zik3UmWna7VUQ4
O9CBNNhiXLfM0ZtJwNpf37u0FGEU0TGtKtG5cV/9T4yMz+5c7i+og1QYj/vaqa0H
XOpwKpyEAiA6hH+fyqCaKY7WNcfWyR+IoLNRb2103SfLt4/t6xYseGUBHVy899Di
DXNCbI8vBtd4hmpZmNx4JrU7abi4BYqDvdBlEzCTERnePHti3EzRf064IbbdQrK1
5X6W6nMM
=KYFZ
-----END PGP SIGNATURE-----

--qc4D5VO3myZMzcuS--
