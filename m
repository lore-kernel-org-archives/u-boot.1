Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5D6CAC587
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 15:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF7F9830B4;
	Tue,  9 Sep 2025 17:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cmtEcCI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5BD383106; Tue,  9 Sep 2025 17:39:54 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5EA58309E
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 17:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-621a3c43df3so161579eaf.0
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757432391; x=1758037191; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ur1NAjLhrhArQz/Tt5QMj3YW6r8IgYuAdmd64jpFdNA=;
 b=cmtEcCI7TtNJUfNNSJ/brg1+yCZ2th7WjKughaRFXjTD1hGWABiiTbZuOFYB4sEY2r
 AqKYYl3EzTjyslo26FUVrENCpx3T2Ah9DKUylqHHom2sZ8O2JQ3iBZRTF5HlwoLqIYwc
 zIZGbxITY/C42sDX/j+HKhSs+mYTGiA9LiVKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757432391; x=1758037191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ur1NAjLhrhArQz/Tt5QMj3YW6r8IgYuAdmd64jpFdNA=;
 b=HqbVKil5hE0jkSlFk33oFtsCY4nM0GJuOnwepPN3CXVOPAjDv6gqwZnaxcCbFgg1fo
 a7kWSO4aWLz9bN/cSnaFXJTAZdo5GFLF4ZME6hIporEisOcQbV987NrpqxE1M9JLHPk2
 QZwO1AU1z7o+mmksNaevj5pabzxETnptOtLNQvHCpIUf+6ksULcECdlMIwxOBwF2ZgSA
 GfnUZh0LdqmDECSp3jENyyhI7EQfwuS4wopg3GY9/wbudOIylVwBpIhJ0BIGdUPjFrCH
 q5n6NRuthC5ywo+jvJO7ST/0HROXxOIVVaHp3faenQa/RMJ9SAAr99hMauNCqG+6V/1h
 6Tnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnWXyAqJn6251RDRyfAZeEx6jkAJ596RIYPByWDk6pxtogVxIx7XIoGBdzjCnh+tnkJRPLUgE=@lists.denx.de
X-Gm-Message-State: AOJu0YwE/o6nC8L4MOIO068hfIL9q6D9EObxiXKodVegHVaHSDjMVtYH
 xIC5lJJ8MBEnmA9PWELSVOoUKjjMXqfdZ0tr33Qo8KGcHe0gVrKgEPR40eJ8lZQKxAc=
X-Gm-Gg: ASbGncv4KmxN6Mr+Pc/PtEs+fxsZ8tH0JucEeHIOx0HTSkaqe8kqAM8F3oKyS50av8Z
 BJbjRAyFuY71YvYTz8tH8vd7iWOAlmfknR/33pYziDKEdeQp6K01eCW3qGjI4dk0svf4YmTg9Dv
 kaTDx/XqedQ5QIDW12fHytXuaDdOQ/rl0tKyy5dg6R/Gv1yElR9vYZvasAONm54QQEZjULbNv/N
 0WKxjiXIQPnNMtstXFbHG/da/d0Oao2Oi+sLc6Tzg/DGmfDL0R0SzbR0mcuzEasFvyla7jMeGrg
 w4rcTqcsqeQG9WR/yS5I/Px5ob8p/60FnEc6TeJP0ZiCX/VHFb2O+LT/ceYfi/taMvgI/biqiD7
 kQMBGgIXcw3g075nb8QC47eVLGcYl6s3HfkL7c8LxZ+h1p4kus1+CbtF9
X-Google-Smtp-Source: AGHT+IEV6mElxIuVKOtp0xe2uPO7TQYl3Xb0/hbDhW2ENHKurdolxpFXFcwAx+uZuc8a3PTKDVA4Kw==
X-Received: by 2002:a05:6808:2190:b0:439:adcd:9eb6 with SMTP id
 5614622812f47-43b29859a99mr5711879b6e.0.1757432391279; 
 Tue, 09 Sep 2025 08:39:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4380001d11asm6132111b6e.16.2025.09.09.08.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 08:39:50 -0700 (PDT)
Date: Tue, 9 Sep 2025 09:39:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>,
 Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de,
 Tom Warren <twarren@nvidia.com>, Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 1/2] timer: tegra: Bind watchdog driver when timer node
 is processed
Message-ID: <20250909153948.GY124814@bill-the-cat>
References: <20250826093936.3521235-1-lukma@nabladev.com>
 <CAPVz0n3wpLtXB=1ZS4WiihVkDPTza75dXDKMjD63OyeSQwACRQ@mail.gmail.com>
 <20250908144107.10bcb8a1@wsk>
 <CAPVz0n3XoeMmGO7YpVPrej-R2m-vR1T_D1GsEbxJM+iJVGhAfQ@mail.gmail.com>
 <20250909121537.1c2a95b1@wsk>
 <CAPVz0n3M-GQCO=bpD9pMBsaW90xSqYRZZjsFpZp4p7-BF5MrTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RG35JxilbDsAIaBv"
Content-Disposition: inline
In-Reply-To: <CAPVz0n3M-GQCO=bpD9pMBsaW90xSqYRZZjsFpZp4p7-BF5MrTw@mail.gmail.com>
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


--RG35JxilbDsAIaBv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 02:26:19PM +0300, Svyatoslav Ryhel wrote:
> =D0=B2=D1=82, 9 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:15 =C5=
=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hi Svyatoslav,
> >
> > > =D0=BF=D0=BD, 8 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 15:41=
 =C5=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > Hi Svyatoslav,
> > > >
> > > > > =D0=B2=D1=82, 26 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =
=D0=BE 12:39 Lukasz Majewski <lukma@nabladev.com>
> > > > > =D0=BF=D0=B8=D1=88=D0=B5:
> > > > > >
> > > > > > The Tegra30 SoC is a bit special, as it doesn't have the
> > > > > > separate IP block to provide watchdog functionality.
> > > > > >
> > > > > > Instead, timer IP block allows such functionality when properly
> > > > > > configured.
> > > > > >
> > > > > > As in the tegra30.dtsi there is a timer node, which "covers" all
> > > > > > timers, with 'nvidia,tegra30-timer' compatibility it was
> > > > > > necessary to manually bind U-Boot's WDT driver (based on
> > > > > > WDT_UCLASS).
> > > > > >
> > > > > > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > > > > > ---
> > > > > >  drivers/timer/tegra-timer.c | 18 ++++++++++++++++++
> > > > > >  1 file changed, 18 insertions(+)
> > > > > >
> > > > >
> > > > > What is the practical application for this diver in therms of
> > > > > Tegra and U-Boot overall?
> > > >
> > > > You have the WDT functionality working. It uses the same DTS
> > > > bindings as ones used in Linux.
> > >
> > > Why do we need WDT for Tegra in U-Boot at all?
> >
> > Can you correct me if I draw wrong conclusion - you ask why Tegra needs
> > to support watchdog in u-boot bootloader ?
> >
> > > It is not used and has
> > > no practical application.
> > >
> >
> > Yes, it has ...
> >
> > Customer has number of Tegra30 colibri modules in the field. They want
> > to switch to u-boot + linux kernel BSP.
> >
> > For their application - it would be welcome if the device could reboot
> > and start emergency procedure in the case of not being able to start
> > Linux.
> >
> > The procedure is that we start Watchdog at very early boot - then we do
> > have for example 30 seconds to "feed" the Watchdog in Linux
> >
> > When we fail, after watchdog reboot, we can switch to another rootfs
> > partition (the A/B scheme of booting) or start emergency system.
> >
>=20
> So when are you going to submit this board variant? If driver has no
> users, it is removed.

I assume it would be enabled on colibri_t30_defconfig.

--=20
Tom

--RG35JxilbDsAIaBv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMBKQQAKCRAr4qD1Cr/k
CtW/AP4qPU94CyZaMLR1e9z+4439hD//gG1zTdFqSNKkoOlAawD9Gzu8xGpKZk6s
x30v4/V92aAxakkLebOUKyGRiezAsAE=
=g51j
-----END PGP SIGNATURE-----

--RG35JxilbDsAIaBv--
