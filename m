Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81027C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 103B688C4C;
	Thu, 29 Aug 2024 16:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tbWMj4rZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1272988C4C; Thu, 29 Aug 2024 16:28:41 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FCCC88B31
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4567ec27dd7so4272171cf.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724941717; x=1725546517; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7jA/3MLo75eIMJMEbGdOgrFeeA3C52jldAZdruHC1vE=;
 b=tbWMj4rZRWzWAZVbuVDUj8H2G4yF3CSt9evLAeKzFfEXUqF77MY5FUFL26ikYbjQau
 d96cGPfCBOF5mpgKjcLVzJG0vg+x/T+dvhW/SJAETkN2IcXD9dJkZm4iCO/dQaBTv1rc
 cVeInk93wBzaPlZfqTrBsxK3uPVVgKhXrY7DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724941717; x=1725546517;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jA/3MLo75eIMJMEbGdOgrFeeA3C52jldAZdruHC1vE=;
 b=dL/4pAdCex8YW01K2Z3I/f9aJuJqS7wckvt+CbW9Umj1cUO4c4vZzdO1py4/ywDdO6
 vP7uHlZWd7VR2OEtSCcocw8hhnIVu44pzxT/q+FEAWZUBjXvzZoctLKXlg89IT0y2LOD
 lwiqZABFYDohsAqSgv6f/E4HIPJNHCxsUeaTNs43PXJPhDjhG2JfseWOgUgN3Xac124R
 D496XcwUS4F3UKR2bAVh16Sf4cMjIbDMpV/2jd8745DykftKHoenCqyp0vKWKjkIAA3S
 d9J+p14CP9XH6Gpm67DoX2i2fxgMhKpll9nqLjVKUI7qHrmPerO1aYjwREQZlLvz+aqw
 kiMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWahCJiC9/kqDta48lqn52yRWJD/WxUOCZPcqv6SqSEkQYkkPYeGP/7K9+bp6coFzcuUgfF7MI=@lists.denx.de
X-Gm-Message-State: AOJu0YyIUoWOq2PMS4hXX3XlS0wOe5lmwXwUhzk71lGyB3/4iVldz2ay
 kqA6Xo8oI8xO2eRY3S/KMj/UJwEBz+2XnajWgLm80D0ZytqRQKJRmOb6J8FDiKg=
X-Google-Smtp-Source: AGHT+IEUwiK0r5JFfWie2NKS5G5F5PPb+xx+FVRgLfs9pA/Iw12cVF025JtvNtub4b9zMMvjJm3iyA==
X-Received: by 2002:a05:620a:3f85:b0:7a6:5d48:131f with SMTP id
 af79cd13be357-7a8042734f1mr301412485a.70.1724941716800; 
 Thu, 29 Aug 2024 07:28:36 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340bfa7b4sm5565326d6.28.2024.08.29.07.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:28:36 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:28:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "patrice.chotard@foss.st.com" <patrice.chotard@foss.st.com>,
 "vitor.soares@toradex.com" <vitor.soares@toradex.com>,
 "clamor95@gmail.com" <clamor95@gmail.com>,
 "sbabic@denx.de" <sbabic@denx.de>, "afd@ti.com" <afd@ti.com>,
 "ion@agorria.com" <ion@agorria.com>, "marex@denx.de" <marex@denx.de>,
 "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>,
 "sean.anderson@seco.com" <sean.anderson@seco.com>,
 "noreply@example.com" <noreply@example.com>,
 "Leto, Enrico" <enrico.leto@siemens.com>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>,
 "mk7.kang@samsung.com" <mk7.kang@samsung.com>,
 "devarsht@ti.com" <devarsht@ti.com>,
 "yangshiji66@outlook.com" <yangshiji66@outlook.com>,
 "jonas@kwiboo.se" <jonas@kwiboo.se>,
 "danishanwar@ti.com" <danishanwar@ti.com>,
 "francis.laniel@amarulasolutions.com" <francis.laniel@amarulasolutions.com>,
 "nm@ti.com" <nm@ti.com>,
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "raymond.mao@linaro.org" <raymond.mao@linaro.org>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>
Subject: Re: [PATCH 12/35] global_data: Convert have_console into a flag
Message-ID: <20240829142830.GY2479150@bill-the-cat>
References: <20240724150922.2343249-1-sjg@chromium.org>
 <20240724150922.2343249-13-sjg@chromium.org>
 <c886cdcb395e842d179144e5fa1d8b0de41127d8.camel@siemens.com>
 <CAFLszThiF=rbpCgVEc+D+R2xqP9jX2i_BiaRwdc2MkaNBDf2fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GaHCNdsV/XbbWu7m"
Content-Disposition: inline
In-Reply-To: <CAFLszThiF=rbpCgVEc+D+R2xqP9jX2i_BiaRwdc2MkaNBDf2fQ@mail.gmail.com>
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


--GaHCNdsV/XbbWu7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 08:05:35AM -0600, Simon Glass wrote:
> Hi Alexander,
>=20
> On Fri, 16 Aug 2024 at 07:08, Sverdlin, Alexander
> <alexander.sverdlin@siemens.com> wrote:
> >
> > Hi Simon,
> >
> > On Wed, 2024-07-24 at 09:08 -0600, Simon Glass wrote:
> > > We don't need a full word for this boolean value. Convert it into a f=
lag
> > > to save space in global_data.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  arch/arm/cpu/arm926ejs/mxs/spl_boot.c |  2 +-
> > >  arch/arm/mach-exynos/spl_boot.c       |  2 +-
> > >  arch/arm/mach-k3/common.c             |  2 +-
> > >  arch/arm/mach-k3/r5/sysfw-loader.c    |  2 +-
> > >  board/siemens/common/board_am335x.c   |  2 +-
> > >  common/board_f.c                      |  2 +-
> > >  common/console.c                      | 14 +++++++-------
> > >  common/spl/spl.c                      |  2 +-
> > >  include/asm-generic/global_data.h     | 17 +++++++----------
> > >  9 files changed, 21 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/arch/arm/cpu/arm926ejs/mxs/spl_boot.c b/arch/arm/cpu/arm=
926ejs/mxs/spl_boot.c
> > > index 76a69d7f958..dd748328293 100644
> > > --- a/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
> > > +++ b/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
> >
> > [...]
> >
> > > @@ -219,7 +210,7 @@ struct global_data {
> > >  #endif
> > >  #ifdef CONFIG_TIMER
> > >       /**
> > > -      * @timer: timer instance for Driver Model
> > > +s     * @timer: timer instance for Driver Model
> >
> > an unintentional change?
> >
> > >        */
> > >       struct udevice *timer;
> > >  #endif
> >
> > the rest looks good to me and you can add my
> > Reviewed-by: if you remove the above chunk.
> >
>=20
> Thank you. I'm not sure where that came from, but it seems to be gone now.

I fixed this up manually when applying (and added the tag).

--=20
Tom

--GaHCNdsV/XbbWu7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbQhYoACgkQFHw5/5Y0
tyycRAv/ZuBk3jEpclCWyY2Jvvjc3NnKfF3YVmMhTnRt7qcD0lZOH0ugNyhuiz8b
LzGBYuPGwsa/zzp7+XpyoBs0f4aArJw/N+cAAZcJFlCvGFM0A4zBupc64NYojRgz
BejE4bQdvK5NESzOiReHVq3IqwwjPAdeVrya4az5pDlA03X22T0bu5We7FXIDGIc
dgvVGuGcDAi92Qb6OTlNvgL9HfpfWK0JLkc96VqRLlg7f5Jw0sZP74SE0gTRV8bq
kyf6AIQ0wltdx12aWXvCQ+XeKyuXZg0+1wEkpvEQ0crj5XFhWm8l4SOXluzUM/w6
7bFd9RgU2NnvAoHaGksG6L3bjv4eemMUGrRGJeCVNy9Vycs8PXv1WxOuwTOVIJOO
IaBtRHisCEt4J9ImeyZqWUaoO/KUdDF0fY+buhxqyK1t9IxVe7PJquCZQOIGM2oR
68cLMSGszL/ln4tuSmYcC/wL2X/TzJGet5vlmoyc/Tjti5d8zY5amYwGtylJ+wf0
Op3my/Po
=Y5Jg
-----END PGP SIGNATURE-----

--GaHCNdsV/XbbWu7m--
