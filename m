Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A48C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25526887DB;
	Fri, 19 Apr 2024 18:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MnlkvL7a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F08887D8; Fri, 19 Apr 2024 18:46:26 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13519887DB
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a55911bff66so34148866b.0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713545183; x=1714149983; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qy5UVpIqlMDL8W/IU8HFzu2nxaSzjXElmfNFI3zDnr0=;
 b=MnlkvL7al/+EsPlsYiyEVKi2i7iLjFm5Z7i8rI3gESxy2WgcvTy57XZ9TTy6nqxjVv
 B+AXS1Ue07AYG4jlCoDrTvuspEW2N9Kgeme0uVOZ5mpIPuC+o6vGvHZViAM2/0NbNP+a
 01AphAsI98dIkUB+XjfcOeFphhhgAhxSC0pGnza7//9DizjOU+Ms5eYNbgU1g3pg+8aS
 5RpldQQzAXIALGVfpnwOJgFpiWvI7v03clyuMdSD6Hcgt07FiG73T8qZ8OKVocl9DHwH
 MQPw2ZecUcWxFRxJZuH7bygcbynBd8JBll/R8ZvjcId+lxXuXHeURNvEvKcTHUIlhqam
 bt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713545183; x=1714149983;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qy5UVpIqlMDL8W/IU8HFzu2nxaSzjXElmfNFI3zDnr0=;
 b=qNylqs5vbyMSNH4FP1dBoLy3ljZ1enPvIpXlx5y9lzCDX/xkkpN2Ci1DoRKCh4ms1W
 yah+O+NGa9BXyVHFuVqD9FcG2kyld1VsM/bOR4Zxbo4P++kzMFTj/roHLnLnxbSG9TI9
 lHIVhFU4McKEBAvSYwgodaRSrtiU9VFKrYmQV/PaqEoLgQzHXj3OYqbObh0E2We7TqUM
 Pahp3OMkhaWTEXPjp1qD5HAMkUlF1UzuYuVdEJw4stWTvB+JRUtAE6paiOEvNmR5gbpD
 hMuP0lkjOEebSOBK5D2cAOK75kHR6ied3BnTUpGCBgMf5dnjc+FFl2l/dS7vH2malJm/
 mI+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbYD2mxALZXnVwSN5qbLrMOAgmaxFAds++ceYyhq0wS70c63BSfSJlaD5nhfll/K1EJom/zpzQ4Dvs+nn/8NN2h6w6iQ==
X-Gm-Message-State: AOJu0YxoIB4YiKcqPwLA93iK+KThH20aVqNCZCqDclpOhPgSH0gPoVrE
 TmSeAWDM3wgYjFaQubU3WtIePmuhBVB9RBPXM6+zqM/eU5Cd46lm
X-Google-Smtp-Source: AGHT+IGYXL7SP8+3972ArezYf8sF4lCVCFxVZZx+TcBrQSqZCIEneFHOaNorBpayNYQlyeperkN9fw==
X-Received: by 2002:a17:906:4ed8:b0:a51:af7d:4652 with SMTP id
 i24-20020a1709064ed800b00a51af7d4652mr2228748ejv.32.1713545183252; 
 Fri, 19 Apr 2024 09:46:23 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 b20-20020a170906491400b00a5552c719bcsm2400777ejq.211.2024.04.19.09.46.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:46:22 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=4c46b15aafad30579815bc7b3761ae16d84b5f2bde309b36aec44ce4ec9b;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:46:22 +0200
Message-Id: <D0O92LGLWMLP.34AR1F3WJZQCV@gmail.com>
Cc: "Thierry Reding" <treding@nvidia.com>, "Anatolij Gustschin"
 <agust@denx.de>, "Simon Glass" <sjg@chromium.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 06/18] video: tegra20: dc: add reset support
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-7-clamor95@gmail.com>
 <D0O8720SNXUY.58M29AZIXYVC@gmail.com>
 <CAPVz0n0UX1JOxyGbBgd430oMGUb7vDb5td3oZ2beMTVRa3tktQ@mail.gmail.com>
In-Reply-To: <CAPVz0n0UX1JOxyGbBgd430oMGUb7vDb5td3oZ2beMTVRa3tktQ@mail.gmail.com>
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

--4c46b15aafad30579815bc7b3761ae16d84b5f2bde309b36aec44ce4ec9b
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Apr 19, 2024 at 6:37 PM CEST, Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 19 =D0=BA=D0=B2=D1=96=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 19=
:05 Thierry Reding <thierry.reding@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> > > Implement reset use to discard any changes which could have been
> > > applied to DC before and can interfere with current configuration.
> > >
> > > Tested-by: Agneli <poczt@protonmail.ch> # Toshiba AC100 T20
> > > Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101
> > > Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper =
E1565
> > > Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
> > > Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T1=
14
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/video/tegra20/tegra-dc.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20=
/tegra-dc.c
> > > index 56a23b3c97..35abb6fe46 100644
> > > --- a/drivers/video/tegra20/tegra-dc.c
> > > +++ b/drivers/video/tegra20/tegra-dc.c
> > > @@ -10,7 +10,9 @@
> > >  #include <panel.h>
> > >  #include <part.h>
> > >  #include <pwm.h>
> > > +#include <reset.h>
> > >  #include <video.h>
> > > +#include <linux/delay.h>
> > >  #include <asm/cache.h>
> > >  #include <asm/global_data.h>
> > >  #include <asm/system.h>
> > > @@ -342,6 +344,7 @@ static int tegra_lcd_probe(struct udevice *dev)
> > >       struct video_uc_plat *plat =3D dev_get_uclass_plat(dev);
> > >       struct video_priv *uc_priv =3D dev_get_uclass_priv(dev);
> > >       struct tegra_lcd_priv *priv =3D dev_get_priv(dev);
> > > +     struct reset_ctl reset_ctl;
> > >       int ret;
> > >
> > >       /* Initialize the Tegra display controller */
> > > @@ -349,6 +352,20 @@ static int tegra_lcd_probe(struct udevice *dev)
> > >       funcmux_select(PERIPH_ID_DISP1, FUNCMUX_DEFAULT);
> > >  #endif
> > >
> > > +     ret =3D reset_get_by_name(dev, "dc", &reset_ctl);
> > > +     if (ret) {
> > > +             log_err("reset_get_by_name() failed: %d\n", ret);
> > > +             return ret;
> > > +     }
> > > +
> > > +     clock_disable(priv->dc_clk[0]);
> > > +
> > > +     /* Reset everything set before */
> > > +     reset_assert(&reset_ctl);
> > > +     mdelay(4);
> > > +     reset_deassert(&reset_ctl);
> > > +     mdelay(4);
> >
> > Are you sure this works as intended? It's been a long time since I
> > worked on this, but I seem to recall that most of these resets are
> > actually synchronous, so in order for them to do what they're supposed
> > to the clock needs to be kept running.
> >
> > The Linux driver certainly does this differently.
>
> You have point, but I have tried to mostly adapt Linux tegra dc driver,
> which has same logic in probe. Maybe I have not understood it properly.
> Testing on T20, T30 and T114 passed without issues so far.

Maybe look again. What it does is (basically):

	clock_enable();
	mdelay(4);
	reset_assert();
	mdelay(4);
	clock_disable();

That should ensure that it's completely reset at that point. Now before
any subsequent register accesses happen it will do this:

	clock_enable();
	reset_deassert();

to take it out of reset again. Perhaps that's something you want to keep
doing in probe() in U-Boot. In that case maybe you want something like
this instead:

	clock_enable();
	mdelay(4);
	reset_assert();
	mdelay(4);
	reset_deassert();

Thierry

--4c46b15aafad30579815bc7b3761ae16d84b5f2bde309b36aec44ce4ec9b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYin94ACgkQ3SOs138+
s6EvRA/9GbwLLYGv6tvydnrvCklxwEnrO3RoO3unwtVv7yu+5iHvIMcU0x2Vi51a
RK2R+LB4noQPmfDxrPm81214zxGJy3amEd0JBN8cg10glKkcz4IVEL27qlL3J3yt
Kg0aVlBavYnfeOtCaDW+mey0vWWeupLNQeygtXWCdsnOyDe4qHzKnDRyy+gaUNi/
VlQSrD+SmD7YsPpnFaQT94a3A6lmCbtu7qgf/xJjLvao0Uyf+utzDl6rq7JtDV2e
sNR9RT8u+MsnUevG7iF12QkjJeg56+IwpSCcNt82Ji4BCenk6vWmrAvz2hI8Sz+W
vcQeNjZSr5RH2F2AYMUIzHsndhuNKtb3QwvFKV5F6DhDRpsv+6xjyCiYhRBkxp+E
U5fBnYIE5GLcnkzxyukDSxD6iDooaFKXYSbbqgRSKmOTBIvXoXQWcr/yL8vuyTJv
h7o5Kyk0P/pHLo6+Z28zXpnaByByGN6NaEddFBPi/MvchCHrtJjiJi2vzXM3OQQv
earbhMniJuatFuv1GS+DmS1295B/b4YhN4235b5G2PXBBWa3SZ+Scq6KYZ48+YxS
ZmWwdy+I7ufyMt1NoDNVo3qOGexTFJxNMWEaJPoOpsheseQ17vSd7NoPzp+APqAE
4i29OphZYxJB3wElBaYXZa1MIchJD4a4roqWi8j2SnDwhju3AJY=
=cHN/
-----END PGP SIGNATURE-----

--4c46b15aafad30579815bc7b3761ae16d84b5f2bde309b36aec44ce4ec9b--
