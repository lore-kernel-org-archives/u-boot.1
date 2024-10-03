Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE32ECF34B0
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5C3E88E19;
	Thu,  3 Oct 2024 17:05:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y5E71Mdv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 143D788D9F; Thu,  3 Oct 2024 17:05:50 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA14F88DD4
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37cd8972738so839644f8f.3
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727967946; x=1728572746; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PoZRjAzyLV42dbmh6tTvJFMzFGmTF2YZ8Chn0i6KVXc=;
 b=Y5E71MdvggktoWG9XvAHMVaSSCrxUPXTzRzi+EZyPZQpgyYhryjxVQH9wEpd6kKnkY
 rsrWFwxLuaka67AgZB1LkiESt3zJmrShEL5tS9B/4TonVuS3Z01P5Vf9RhNVjnE4DVXf
 bBOhjLrVqRn7q0IJ83tlaNlgacUXld75eaaBV9gor3qSw6G49hcsbLN1eR/ZZVQLpDtP
 fL3MKNXOilQrMcRfAYg0mJvmiFFlH/CXw1+3cU/v76Z+UVbpTF6YdVsM8CQZSgEWn6EX
 RF7l+p4baygKYeZoRBePjg7gAIGn4r9EmDH4veNzgfn8ZparodWTnNxZ8dOykgYtrcak
 GBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727967946; x=1728572746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PoZRjAzyLV42dbmh6tTvJFMzFGmTF2YZ8Chn0i6KVXc=;
 b=eoqhXa/BGnqExMD67Vm2P7/R1UGvKBHaZe8/JAFHIQgcGsv4aI2Cs1tfw5D9gdZNXd
 k+0fol2wsgtUyYVTeS9tKPhrCTIwXuQ62q9DMHwn2lJRRUYOsDJPZF4E/saB6mNNo9fg
 MrZ0XU2rGYenmmewoMwYFl9Zi3QC0qruEAhgE90j6JDRL792r8Lon3YjtKNkkyXEv3a9
 y0XYZhR+qRzyE46SqnUbn29NVxZvSVN38vCsz8wGjNZNBbtZ4fhmU8FU2JJlrVdSuYtn
 JbN484LjORCdGaEZQEAlk8ro6MLwfhiCIIm2pbYJCPdgehT7ia77sKn2sZpq/ED7uFs0
 jmbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN3+Hk6MJMxTfj9sh4CMfsj3dCQgplSJQqju1MP0sMAtGVwq8lSzp8DvHK9z7VrsBw9RlYqds=@lists.denx.de
X-Gm-Message-State: AOJu0YzbHRGG22IN3m4QVMRtiowHEESX7DBaDnTa0XKZU7o8/YyzQk/G
 u1Hvg+OpoiFDsuvmM71EM133uO7+QdWMhsUAcbaicGMD5/Q28jeM4y+kjjEuyNvdNZt4uhpqVvr
 gMzXq0vEOzCGplqvfRf1J/4r7F7E=
X-Google-Smtp-Source: AGHT+IEcWJVWS1+erVM/jK6NIxwluKOTR0nUIOM/eO87CBIT8x35AE6ERRCWn2cnBAT1y7GDHEQycP6dPqqpTPLWIII=
X-Received: by 2002:a5d:5585:0:b0:374:ca16:e09b with SMTP id
 ffacd0b85a97d-37cfb8b5735mr3777463f8f.9.1727967945859; Thu, 03 Oct 2024
 08:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240926231457.2933914-1-marex@denx.de>
 <20240926231457.2933914-2-marex@denx.de>
 <CAFLszThbZ5t+siC0Gz_7KaecTTwUA6J2uTdtHEaYoK+V6Rm_7A@mail.gmail.com>
 <20241003014042.GS4737@bill-the-cat>
 <CAFLszTiawdOfoMx-ZmMLW77dBS11WWVpWHNF-KfPi86xEJB+rQ@mail.gmail.com>
In-Reply-To: <CAFLszTiawdOfoMx-ZmMLW77dBS11WWVpWHNF-KfPi86xEJB+rQ@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 3 Oct 2024 18:05:34 +0300
Message-ID: <CAPVz0n0dYu7pbvEef6zEMrgKHyiRX-DYmD2bxuSVB3p+rrjJjQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] power: regulator: Convert
 regulators_enable_boot_on/off() to regulator_post_probe
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>, 
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sam Day <me@samcday.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Thierry Reding <treding@nvidia.com>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io, u-boot@dh-electronics.com, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D1=87=D1=82, 3 =D0=B6=D0=BE=D0=B2=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 18:03=
 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Tom,
>
> On Wed, 2 Oct 2024 at 19:40, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 02, 2024 at 04:55:39PM -0600, Simon Glass wrote:
> > > Hi,
> > >
> > > On Thu, 26 Sept 2024 at 17:15, Marek Vasut <marex@denx.de> wrote:
> > > >
> > > > Turn regulators_enable_boot_on() and regulators_enable_boot_off() i=
nto
> > > > empty functions. Implement matching functionality in regulator_post=
_probe()
> > > > instead. The regulator_post_probe() is called for all regulators af=
ter they
> > > > probe, and regulators that have regulator-always-on or regulator-bo=
ot-on DT
> > > > properties now always probe due to DM_FLAG_PROBE_AFTER_BIND being s=
et on
> > > > such regulators in regulator_post_bind().
> > > >
> > > > Finally, fold regulator_unset() functionality into regulator_autose=
t().
> > > >
> > > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > > ---
> > > > Cc: Ben Wolsieffer <benwolsieffer@gmail.com>
> > > > Cc: Caleb Connolly <caleb.connolly@linaro.org>
> > > > Cc: Chris Morgan <macromorgan@hotmail.com>
> > > > Cc: Dragan Simic <dsimic@manjaro.org>
> > > > Cc: Eugen Hristev <eugen.hristev@collabora.com>
> > > > Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > > Cc: Jaehoon Chung <jh80.chung@samsung.com>
> > > > Cc: Jagan Teki <jagan@amarulasolutions.com>
> > > > Cc: Jonas Karlman <jonas@kwiboo.se>
> > > > Cc: Kever Yang <kever.yang@rock-chips.com>
> > > > Cc: Matteo Lisi <matteo.lisi@engicam.com>
> > > > Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > > > Cc: Max Krummenacher <max.krummenacher@toradex.com>
> > > > Cc: Neil Armstrong <neil.armstrong@linaro.org>
> > > > Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > > > Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > > > Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> > > > Cc: Quentin Schulz <quentin.schulz@cherry.de>
> > > > Cc: Sam Day <me@samcday.com>
> > > > Cc: Simon Glass <sjg@chromium.org>
> > > > Cc: Sumit Garg <sumit.garg@linaro.org>
> > > > Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > Cc: Thierry Reding <treding@nvidia.com>
> > > > Cc: Tom Rini <trini@konsulko.com>
> > > > Cc: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
> > > > Cc: u-boot-amlogic@groups.io
> > > > Cc: u-boot-qcom@groups.io
> > > > Cc: u-boot@dh-electronics.com
> > > > Cc: u-boot@lists.denx.de
> > > > Cc: uboot-stm32@st-md-mailman.stormreply.com
> > > > ---
> > > > V2: Rebase on current u-boot/next
> > > > V3: No change
> > > > ---
> > > >  drivers/power/regulator/regulator-uclass.c | 60 +++++++-----------=
----
> > > >  1 file changed, 19 insertions(+), 41 deletions(-)
> > > >
> > > > diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/p=
ower/regulator/regulator-uclass.c
> > > > index 1a970004540..9fcc4bd85b9 100644
> > > > --- a/drivers/power/regulator/regulator-uclass.c
> > > > +++ b/drivers/power/regulator/regulator-uclass.c
> > > > @@ -314,6 +314,11 @@ int regulator_autoset(struct udevice *dev)
> > > >                         return ret;
> > > >         }
> > > >
> > > > +       if (uc_pdata->force_off) {
> > > > +               ret =3D regulator_set_enable(dev, false);
> > > > +               goto out;
> > > > +       }
> > > > +
> > > >         if (!uc_pdata->always_on && !uc_pdata->boot_on) {
> > > >                 ret =3D -EMEDIUMTYPE;
> > > >                 goto out;
> > > > @@ -518,56 +523,28 @@ static int regulator_pre_probe(struct udevice=
 *dev)
> > > >         return 0;
> > > >  }
> > > >
> > > > -int regulators_enable_boot_on(bool verbose)
> > > > +static int regulator_post_probe(struct udevice *dev)
> > > >  {
> > > > -       struct udevice *dev;
> > > > -       struct uclass *uc;
> > > >         int ret;
> > > >
> > > > -       ret =3D uclass_get(UCLASS_REGULATOR, &uc);
> > > > -       if (ret)
> > > > +       ret =3D regulator_autoset(dev);
> > > > +       if (ret && ret !=3D -EMEDIUMTYPE && ret !=3D -EALREADY && r=
et !=3D ENOSYS)
> > > >                 return ret;
> > > > -       for (uclass_first_device(UCLASS_REGULATOR, &dev);
> > > > -            dev;
> > > > -            uclass_next_device(&dev)) {
> > > > -               ret =3D regulator_autoset(dev);
> > > > -               if (ret =3D=3D -EMEDIUMTYPE || ret =3D=3D -EALREADY=
) {
> > > > -                       ret =3D 0;
> > > > -                       continue;
> > > > -               }
> > > > -               if (verbose)
> > > > -                       regulator_show(dev, ret);
> > > > -               if (ret =3D=3D -ENOSYS)
> > > > -                       ret =3D 0;
> > > > -       }
> > > >
> > > > -       return ret;
> > > > +       if (_DEBUG)
> > > > +               regulator_show(dev, ret);
> > > > +
> > > > +       return 0;
> > > >  }
> > > >
> > > > -int regulators_enable_boot_off(bool verbose)
> > > > +int regulators_enable_boot_on(bool verbose)
> > > >  {
> > > > -       struct udevice *dev;
> > > > -       struct uclass *uc;
> > > > -       int ret;
> > > > -
> > > > -       ret =3D uclass_get(UCLASS_REGULATOR, &uc);
> > > > -       if (ret)
> > > > -               return ret;
> > > > -       for (uclass_first_device(UCLASS_REGULATOR, &dev);
> > > > -            dev;
> > > > -            uclass_next_device(&dev)) {
> > > > -               ret =3D regulator_unset(dev);
> > > > -               if (ret =3D=3D -EMEDIUMTYPE) {
> > > > -                       ret =3D 0;
> > > > -                       continue;
> > > > -               }
> > > > -               if (verbose)
> > > > -                       regulator_show(dev, ret);
> > > > -               if (ret =3D=3D -ENOSYS)
> > > > -                       ret =3D 0;
> > > > -       }
> > > > +       return 0;
> > > > +}
> > > >
> > > > -       return ret;
> > > > +int regulators_enable_boot_off(bool verbose)
> > > > +{
> > > > +       return 0;
> > > >  }
> > > >
> > > >  UCLASS_DRIVER(regulator) =3D {
> > > > @@ -575,5 +552,6 @@ UCLASS_DRIVER(regulator) =3D {
> > > >         .name           =3D "regulator",
> > > >         .post_bind      =3D regulator_post_bind,
> > > >         .pre_probe      =3D regulator_pre_probe,
> > > > +       .post_probe     =3D regulator_post_probe,
> > > >         .per_device_plat_auto   =3D sizeof(struct dm_regulator_ucla=
ss_plat),
> > > >  };
> > > > --
> > > > 2.45.2
> > > >
> > >
> > > I thought I objected to this patch, but it seems to be in -next? Does
> > > anyone know what has happened here?
> >
> > Yes, you missed me noting that this fixes real problems and has been
> > needing to be fixed for a while. I said you should provide your
> > alternative approach and we'll get this sorted out in -next and I took
> > the work-around for master so the release wouldn't be broken.
>
> OK ta. So long as we can revert/change that is fine.
>
> >
> > > I am seeing these errors now when running sandbox 'u-boot -D':
> > >
> > >        i2c_emul_find() No emulators for device 'sandbox_pmic'
> > >   sandbox_pmic_write() write error to device: 0000000018c49db0 regist=
er: 0x0!
> > >        out_set_value() PMIC write failed: -5
> > >        i2c_emul_find() No emulators for device 'sandbox_pmic'
> > >   sandbox_pmic_write() write error to device: 0000000018c49db0 regist=
er: 0x0!
> > >        out_set_value() PMIC write failed: -5
> >
> > I suppose the good news is that perhaps this is also related to the
> > problem that Svyatoslav was reporting.
>
> OK, I actually never fully understood the problem, but yes, sandbox is
> supposed to work similarly.
>
> Regards,
> Simon

Simon,

Please inform me when you come up with a solution, I would like to
test it. Thanks.
