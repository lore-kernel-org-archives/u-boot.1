Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9973DC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 20:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 155AA87645;
	Sat,  9 Dec 2023 21:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xt0JTouI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD8848764D; Sat,  9 Dec 2023 21:45:13 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6CAE8755D
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 21:45:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5c08c47c055so30898437b3.1
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 12:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702154710; x=1702759510; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qwY9LXSCSjTV/kpkQ2ITC4maNSweBXG1eF9Lt3XSLgY=;
 b=Xt0JTouIAnz5T3bH/csPYP4zKw8bjiI8BAlGPRfgpF+1+KWm9ufS8Mr8VJyEvSvSaD
 C80HCLWJWMr3fW6x1EjodfkaZgPGIWZhiXXwMq5J5+/3eS0VHZmVg7P6/f2A+jAMFiPk
 ld5B518oiTMcK//kzS8uL8BFaZJNJOyG+yS/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702154710; x=1702759510;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qwY9LXSCSjTV/kpkQ2ITC4maNSweBXG1eF9Lt3XSLgY=;
 b=v4W+O4QcwuyvMWFsHsINh3EBkbvIGyZKMtzbxWwWRuNu8Qq+qunTV8+xtnguwf0zlH
 LcX+JTzkJ2pYRQWEvXBYHOfRTPVi8eWYNpsEZ39LXgy74/lswxYJFxAbXGkKKPBoKsH/
 G5q/wf7/7fYeT550cDUgHMb7kJFXuLKFkhCelFFlk/2L2HxZ7NowpSNM6/5pDuFu/l1Y
 i7cbwfNPRTZOrzvD+KESRdeDL6hdaH/7RTo6Q+7VYSMZwepyeP5ZwwWGCwkMy1uqZA3M
 ciVuhYwSd0BHpV0oMh7nSKwXbyh5O+pVe6C4lcgz8SJyRohGl0z8V/VNl7/7KQjoNhh/
 lqug==
X-Gm-Message-State: AOJu0Yw7OFxbHuH2WuAIV4lCgrKzk+FNGpIaxtFwXZnPzCmXByqDkb4A
 tTNI79NcPy0EHOcmuXjLHhgl2w==
X-Google-Smtp-Source: AGHT+IEbUVfMxgWolqB2K/xdZbFxh9HDicJH3Lakdd9aTFwpMh2ljx0IZ+XYvvoPd5tra1pmQzoXAw==
X-Received: by 2002:a81:4894:0:b0:5d7:1940:53f0 with SMTP id
 v142-20020a814894000000b005d7194053f0mr1409275ywa.104.1702154710360; 
 Sat, 09 Dec 2023 12:45:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a814a08000000b005d3b4fce438sm1694179ywa.65.2023.12.09.12.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 12:45:09 -0800 (PST)
Date: Sat, 9 Dec 2023 15:45:07 -0500
From: Tom Rini <trini@konsulko.com>
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
Message-ID: <20231209204507.GH2513409@bill-the-cat>
References: <20231119172310.1307942-1-i@shantur.com>
 <CABEcMwW14BFrA1ZYWTh7iQTsnrXA7LdBPcREKf_QeO71op+Wdw@mail.gmail.com>
 <20231209191853.GA2513409@bill-the-cat>
 <CABEcMwU4C75Xsq9AYdugyPqjPYbrTf3C01gnE+sTM0WDyoMkQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UNzIH910pDMmDNpk"
Content-Disposition: inline
In-Reply-To: <CABEcMwU4C75Xsq9AYdugyPqjPYbrTf3C01gnE+sTM0WDyoMkQg@mail.gmail.com>
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


--UNzIH910pDMmDNpk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2023 at 07:49:04PM +0000, Shantur Rathore wrote:
> On Sat, Dec 9, 2023 at 7:18=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Fri, Dec 08, 2023 at 10:52:02AM +0000, Shantur Rathore wrote:
> >
> > > Hi Tom / Kever
> > >
> > > On Sun, Nov 19, 2023 at 5:24=E2=80=AFPM Shantur Rathore <i@shantur.co=
m> wrote:
> > > >
> > > > Rockchip SoCs can support wide range of bootflows.
> > > > Without full bootflow commands, it can be difficult to
> > > > figure out issues if any, hence enable by default.
> > > >
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > Signed-off-by: Shantur Rathore <i@shantur.com>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  arch/arm/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > index d812685c98..fca6ef6d7e 100644
> > > > --- a/arch/arm/Kconfig
> > > > +++ b/arch/arm/Kconfig
> > > > @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
> > > >         imply CMD_DM
> > > >         imply DEBUG_UART_BOARD_INIT
> > > >         imply BOOTSTD_DEFAULTS
> > > > +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
> > > >         imply FAT_WRITE
> > > >         imply SARADC_ROCKCHIP
> > > >         imply SPL_SYSRESET
> > >
> > > Can this please be merged in ?
> >
> > I wonder if we shouldn't really globally default to BOOTSTD_FULL if
> > BOOTSTD_DEFAULTS for everyone.
> >
>=20
> Its matter of ~21KB in size, unless any platform is really to its
> limits it should be alright.

Maybe I need to re-check things too, since I wonder how much of that
growth is re-enabling things that were removed when dropping the DISTRO
stuff, and so for platforms just migrating over now it would be smaller
in size if much.

--=20
Tom

--UNzIH910pDMmDNpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV00dMACgkQFHw5/5Y0
tyzPTgv/RVBB31jMQvEou3d2eoJIMAygUmTx8pt2JX7/r/Cu6Jgtovv29+7/yfgY
fIV2FkEQzYYeqjaJIEJAEx5WfHmXw/SNsJPzQ6+AMylC0hgz2o3cfrW9h5Ft4Wq1
w8k+iLryg3T7GmAScXwasE5q/4QOerPm36blsm9zm2zalwcGPQIDZw/bwQ2D0h31
jVQYk1YAvxUDYgHG1JuJZSo5IGNpG2NZA8L7WL7O7lbPA0hHFE5xAug9TIau3UEl
Jv0wMX8O1hF733X5e1uQ2L0SmOqv6OKYzgJC1Hx2ESLo3o5wl5Qx5D/h4T3JIuXZ
D236cZ5UAzVyDvNUZU8GdER9pcy90DYJkxQFmpzZhYDBSMDgis+r5bP9f53enkaI
OcNd6AS5Ulzn701AmKRsBfwLsnk9iNqfaAC2qvD08xVA+F/dhkFzRuzr9Y0GLfHi
O6UG7LYn9DDTI7U0OHM6plEy+2AxXMElAQ+lj4l5oqvWy9A1pYr5ogaTTH33/4Zc
RMWAKfQi
=8oXn
-----END PGP SIGNATURE-----

--UNzIH910pDMmDNpk--
