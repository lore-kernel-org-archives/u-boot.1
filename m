Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10CBCAC597
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 20:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F376581E13;
	Thu, 18 Sep 2025 22:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HPnAwXY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE4558206E; Thu, 18 Sep 2025 22:46:02 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D7E080B9B
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 22:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-331e80c3985so1550942fac.3
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 13:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758228359; x=1758833159; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UJqX6c0vhsaoyPX8gc3P8P0YJC6TK1+dm3iymdih8mM=;
 b=HPnAwXY1ifCTE4Rld7CCts0bwgigGazsc+P5Qi/cE7JWvCsgCvjsNvSLSMkn4qlOuN
 M7np7Tz6FqAUy0785krkrrhv1nCcdwYJWfA3SmypRxCWlob8yd93h8kSNXVumd4oObL/
 ki8Pq8N6TMfl36uaLcEY3YZZqNRkmPbMHg9x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758228359; x=1758833159;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJqX6c0vhsaoyPX8gc3P8P0YJC6TK1+dm3iymdih8mM=;
 b=LGeJxgb7xpSEORzhmrnfgPQdnl35daqwO862eSwsY51DehRYhePAil/gqTknFySAiX
 3Q1EtlAj+Fo3GCkGCm2FOBBexkE78vMqMStng0DOdafuPIxZpssvROlIGi6mpwceTtzG
 tup1Nc3mWentC7occyPyOnpYVob3gUs1C8C/TLYA8sHfXAFd9qCecytbuHB8lebnON2w
 WTOsxMb+S3oAdHQSteCghn8tHFneJ+WqZexgujM34d7GIylDc2Td3Fwcdv9qvB+P0g99
 RAKZAXOv3B/l9ZdEXGmGK2fUvBQog7sorR/RW/AvDsTeRbLmCtM63CRfIpZPlqb9p8GC
 HDlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5Rk9sE4TItgeylIVhG2XoM65/4zu0oq9e+juvKqUtnACeQWEeod+UeU5eByJ1znWSs13cFNY=@lists.denx.de
X-Gm-Message-State: AOJu0YzF+a90aNFxHbAlJMBVpgSplQmh+Z8eVu8PpPCWjIeq8cdcnXfu
 k/zjjHjY4DSqBAx8oiMCCNKYwudbGWOEKC3OZaqlxra7I6iAVaFEmPQN8TT+FtUaP7HDwsXLANl
 ypf3DJVU=
X-Gm-Gg: ASbGnctRrFDeCmp7RVYeBG1RWAFMjyQvel3Am67czs3q2wPq0RUemhPqGg50ywtxW2v
 TTryeBedFwHSSGnEurRsCHONqhMNRdhsQqavPkEFKTru8s/NSBCWZsx3a/+85WR8+h+yGXgnFoE
 Bff5VM7RF2TB7b4PsMHOnspcMonCiRC9AY1JY24K4ltQwRyr0pJcNvsfZ4KX5fl2xYdQrzzlaIE
 ugghEjZLb0YdLVQCv6pBvrI1/mQmzLFEJ6xExDKfgUfKXdmsWlgEfJoVqUhhOSymTI1ZmsArbGZ
 tzOnBSPueZU3hSs2ls07oi6SqD5Jha/pXIMMVesp0nQc6Q0uvQcx5oD0ubZCQO3XrYxW2dIZwN6
 ZpsudbyI2g5OgcU0hLH7Sz3lfz36vzbcq+EPAdipfKCjb4vgt3tgDVbq/bygyTpV57dFiwSxOoL
 A=
X-Google-Smtp-Source: AGHT+IEj0tSNQCY2N6dofqVeFg4sqrRZMhMDC8/3hwUBH+M5eVYHRmGB/r2JVKs2ku0H8vOK4ztecA==
X-Received: by 2002:a05:6871:2316:b0:30b:cce6:a5a1 with SMTP id
 586e51a60fabf-33bb619310cmr680877fac.35.1758228359344; 
 Thu, 18 Sep 2025 13:45:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-336e637cad3sm1847365fac.29.2025.09.18.13.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 13:45:58 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:45:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Debbie Horsfall <debbie.horsfall@arm.com>, u-boot@lists.denx.de,
 fenghua@phytium.com.cn, linus.walleij@linaro.org,
 Peter.Hoyes@arm.com, liviu.dudau@foss.arm.com
Subject: Re: [PATCH v2 1/2] vexpress63: Set the DM_RNG property
Message-ID: <20250918204556.GQ124814@bill-the-cat>
References: <20250917162222.1061111-1-debbie.horsfall@arm.com>
 <20250918111934.0b0a9ec0@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OJr5FAe6x0tijIRG"
Content-Disposition: inline
In-Reply-To: <20250918111934.0b0a9ec0@donnerap.manchester.arm.com>
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


--OJr5FAe6x0tijIRG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 11:19:34AM +0100, Andre Przywara wrote:
> On Wed, 17 Sep 2025 17:22:21 +0100
> Debbie Horsfall <debbie.horsfall@arm.com> wrote:
>=20
> Hi Debbie,
>=20
> thanks for the changes, looks good now.
>=20
> > [PATCH v2 1/2] vexpress63: Set the DM_RNG property
>=20
>                          ^^
> It's nice to see new platforms supported ;-)
>=20
> Tom, can you please fix this up when merging? The series looks good to go
> now from my perspective.

I shall endeavour to not forget.

>=20
> > Enable the DM_RNG virtio random number generator driver in order to
> > consume entropy within U-Boot. This allows U-Boot to inject entropy to =
the
> > kernel via UEFI, so the kernel can use that early, for instance for
> > address layout randomisation, or when the kernel does not provide an
> > entropy driver itself.
> >=20
> > Signed-off-by: Debbie Horsfall <debbie.horsfall@arm.com>
>=20
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>=20
> Cheers,
> Andre
>=20
> > ---
> >  board/armltd/vexpress64/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/board/armltd/vexpress64/Kconfig b/board/armltd/vexpress64/=
Kconfig
> > index 7e8709444fe..610ab0ac37d 100644
> > --- a/board/armltd/vexpress64/Kconfig
> > +++ b/board/armltd/vexpress64/Kconfig
> > @@ -21,6 +21,8 @@ config VEXPRESS64_BASE_MODEL
> >  	imply EFI_SET_TIME if DM_RTC
> >  	select LINUX_KERNEL_IMAGE_HEADER
> >  	select POSITION_INDEPENDENT
> > +	imply DM_RNG
> > +	imply RNG_ARM_RNDR
> > =20
> >  choice
> >  	prompt "VExpress64 board variant"
>=20

--=20
Tom

--OJr5FAe6x0tijIRG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMxveAAKCRAr4qD1Cr/k
CsL2AP9c7deoYnTGe0xVu3KLoXaCIk3armAGJ9TRYrBJ89zrGgD/fggzWkLxUI45
9ErgM28Ps+kx1un4GKiZB01cJABa+AE=
=idvP
-----END PGP SIGNATURE-----

--OJr5FAe6x0tijIRG--
