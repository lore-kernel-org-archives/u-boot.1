Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DB2C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 22:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C81F889C1;
	Thu, 25 Jul 2024 00:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JUDyvnrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCADC889C1; Thu, 25 Jul 2024 00:47:25 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81EBA8899C
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 00:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-260dde65a68so145305fac.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 15:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721861242; x=1722466042; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mlY0nsf1+fnqiVkHlV9npJJEf5/9yNWWYhc7/VdSFh0=;
 b=JUDyvnrUMqJDnCJpK1Ey+/+ObD0nIFeSqBcHZQgRg7Vd3vxhfF8yFMtu3Y1ejHWFqX
 ShJJgMDlJXsow2IOOFNqYkoCP1z6H5OfOEHmOMkgMaLpwbn9tdkqNse+Nzv3F3Zej1ET
 rmHMtSZOXCw5v9Xbel9XOLJH3TcpG++fjY/ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721861242; x=1722466042;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlY0nsf1+fnqiVkHlV9npJJEf5/9yNWWYhc7/VdSFh0=;
 b=YHgbOnwNjozLLpKu98r2ooAAYCOXHNyafCRD6XbL/TIudExsBMCFvkk+vTQINTxCVb
 EB09VnsW9OD+pLlJh9urkOp4AKKArzc83puv6p8VlzK/aXhFFV88i88lSyt1HRAQGZp8
 HjZmqD5VUZ31XP/mTWazrPJciNbHXzUZO8wCdILtt45+c5W+CHVHrP1sxYbVuyViiPSq
 RCG4UxL5eJFofKXSVMP8XtdQtQmcHW9zYPlZZCdUgEGsoEy1q3jeRtjJPQ+HKUg4UzNd
 x9ZGUSnK9lwMEkNv43ftRbWQuQRuTGuIWNFLTTFwvSxBxGVV+8oTS8xYDdNZUJlyhJ7i
 3ceg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAlBsQc9z+gKDdRaVAxGZ9FDwLt0SvlOt1fWm79A6LKemJNcwCtspXCr1H7jCQDEF00oYRmYgXUC2m1B8Qac7+hM+oPQ==
X-Gm-Message-State: AOJu0Yx4BoJpn2XboxbbheHltlzsd5IkGJTvgYhXRzGWYu3bEUvlJ0K8
 Hj9jFFt5KEIuWpe5TbGVfKiyPHoMvBe7D5sHKYDmNwLmhN1+M66qhWbS685naMRxsE++hdD2HRc
 lzRj76A==
X-Google-Smtp-Source: AGHT+IFRHa9zBm2sLBqL4xRMwjMKAsNgtdDRJphZ9SCMkORUgJD8i4PL7LOuG8+nGUb4MClDfr+6vA==
X-Received: by 2002:a05:6870:910b:b0:24f:c31a:5c29 with SMTP id
 586e51a60fabf-264a0f5e5b0mr793376fac.43.1721861242250; 
 Wed, 24 Jul 2024 15:47:22 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2653e7563b6sm62557fac.24.2024.07.24.15.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 15:47:21 -0700 (PDT)
Date: Wed, 24 Jul 2024 16:47:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH v2 38/48] lib: Kconfig: add a config symbol for
 getting lmb memory map updates
Message-ID: <20240724224719.GR989285@bill-the-cat>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-39-sughosh.ganu@linaro.org>
 <20240705195057.GP38804@bill-the-cat>
 <CAC_iWjJDwFLMaP=S=z_OMnnQb=q32QMEPoywxPWwjixMSbJ84Q@mail.gmail.com>
 <CADg8p946kVK_BfrSvEgFcvQh95MCRMBKJ+48syCnCSvrpJQ0-w@mail.gmail.com>
 <CAFLszTiYALCrgBUBJ=g_BoQtOzHGx2OhuTxCioCHdXNuJb850w@mail.gmail.com>
 <20240723142055.GG989285@bill-the-cat>
 <CAFLszTgG9WuzYp97ANm=k3iju-DH+c5A2HfgwmUznti9tQyzpw@mail.gmail.com>
 <20240724145201.GL989285@bill-the-cat>
 <CAFLszTgoh6aLQ0BiHjkHYyzE9v0LP5d10Abq-k875kO7kP3ATA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ca07zDr8TDi+iBzC"
Content-Disposition: inline
In-Reply-To: <CAFLszTgoh6aLQ0BiHjkHYyzE9v0LP5d10Abq-k875kO7kP3ATA@mail.gmail.com>
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


--Ca07zDr8TDi+iBzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 09:40:35AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 24 Jul 2024 at 08:52, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jul 24, 2024 at 08:37:14AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 23 Jul 2024 at 08:20, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Jul 23, 2024 at 01:42:59PM +0100, Simon Glass wrote:
> > > > > Hi Sughosh,
> > > > >
> > > > > On Mon, 22 Jul 2024 at 13:59, Sughosh Ganu <sughosh.ganu@linaro.o=
rg> wrote:
> > > > > >
> > > > > > On Mon, 22 Jul 2024 at 18:00, Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > On Fri, 5 Jul 2024 at 22:51, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Thu, Jul 04, 2024 at 01:05:34PM +0530, Sughosh Ganu wrot=
e:
> > > > > > > >
> > > > > > > > > Add a Kconfig symbol to enable getting updates on any mem=
ory map
> > > > > > > > > changes that might be done by the LMB module. This notifi=
cation
> > > > > > > > > mechanism can then be used to have a synchronous view of =
allocated and
> > > > > > > > > free memory.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > > > ---
> > > > > > > > > Changes since V1:
> > > > > > > > > * Change the description to highlight only LMB notificati=
ons.
> > > > > > > > > * Add a separate line for dependencies.
> > > > > > > > >
> > > > > > > > >  lib/Kconfig | 10 ++++++++++
> > > > > > > > >  1 file changed, 10 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > > > > > > > index 7eea517b3b..b422183a0f 100644
> > > > > > > > > --- a/lib/Kconfig
> > > > > > > > > +++ b/lib/Kconfig
> > > > > > > > > @@ -74,6 +74,16 @@ config HAVE_PRIVATE_LIBGCC
> > > > > > > > >  config LIB_UUID
> > > > > > > > >       bool
> > > > > > > > >
> > > > > > > > > +config MEM_MAP_UPDATE_NOTIFY
> > > > > > > > > +     bool "Get notified of any changes to the LMB memory=
 map"
> > > > > > > > > +     depends on EVENT && LMB && EFI_LOADER
> > > > > > > > > +     default y
> > > > > > > > > +     help
> > > > > > > > > +       Enable this option to get notification on any cha=
nges to the
> > > > > > > > > +       memory that is allocated or freed by the LMB modu=
le. This will
> > > > > > > > > +       allow different modules that allocate memory or m=
aintain a memory
> > > > > > > > > +       map to have a synchronous view of available and a=
llocated memory.
> > > > > > > >
> > > > > > > > This needs to be select'd when it's going to be used, optin=
g out of
> > > > > > > > making sure memory reservations are obeyed isn't a good ide=
a.
> > > > > > >
> > > > > > > +1 which begs the question, do we need the config option at a=
ll ?
> > > > > >
> > > > > > The config symbol can be used for removing the code for platfor=
ms
> > > > > > which do not support EFI ?
> > > > >
> > > > > I am still of the so-far firm opinion that this can be done once,
> > > > > before booting, rather than maintaining two separate tables as we=
 go.
> > > >
> > > > Did you see the part in the thread where he explained the multiple =
entry
> > > > points that would need to be kept in sync?
> > >
> > > Yes, but I'm not sure what they are, nor why a shared function cannot
> > > be called twice from two different places.
> >
> > Because we don't want to miss the third or fourth entry point down the
> > road. That's why going the other direction makes more sense I believe,
> > we won't have a future problem here because we designed with that in
> > mind.
>=20
> You might be right, but I don't even know what we are referring to
> here...what are the two 'entry points'?

I would have to refer back to Sughosh's explanation to repeat it, sorry.

> My current belief is that we can set up the EFI memory table before
> booting, with a single pass through the table. Maintaining two
> independent tables as we go doesn't seem very useful. It is harder to
> test too.

You seem to be fixated on "booting" when at least part of the issue is
re-entering the EFI_LOADER. And since EFI_LOADER needs X/Y/Z as well, we
had much earlier rejected "make EFI_LOADER's memory model what
everything else uses".

--=20
Tom

--Ca07zDr8TDi+iBzC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmahhHcACgkQFHw5/5Y0
tyxwpwv/f3ePjickEXOHaAX7IGmzhhc01u4CE8OlflBI6NEyPvC870mEremYcSvU
C2SWkHnRkHFrYw94D76C9gDrKayzKO/SL1qI4t9IL3+FiUIK7O9OIahnYkk1xpsn
uxlQDHx/cxAmJu+jZ38dS4mExhViuUJc28DyiZgKOCaAZ0NaawHQ7P7R3Upbby6d
ZInYqFsiXOOHcWQVQpos3igcKQoBt82wMkGhERy+aR1IG4lmIqymtQr1RkE49hxd
vwf1lbiVLHuJE8O3jRhBvP8mc/QSFaHcjJuGAPRY+jaJ14v5vFYChbSKvHj5BKlD
I/ZoJ+uIWzptBgT+kfnBkkFdxEKwD2h7gytxkcEqcTRLZf3WxT0bjDUKDLP1wH6n
FIGYQisGOyd4ZXTxDjzmy/ExRSd/Da+xjBCu7VPSZk6qqNjRes4w4jTIheK9xyp3
XgyRQRM9I4LZKxr9zs0hTc6qvDUIrOcku6rOMRf0RcT8pAqHIuU/i5EEI7N/UB2X
AsCuUlOr
=5rAX
-----END PGP SIGNATURE-----

--Ca07zDr8TDi+iBzC--
