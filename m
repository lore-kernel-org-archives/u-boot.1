Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8F7CA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 15:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3311480FA1;
	Tue, 19 Aug 2025 17:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kBBNe68I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 834308211F; Tue, 19 Aug 2025 17:35:29 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17754809A5
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 17:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-30cce5b711bso4314124fac.0
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755617726; x=1756222526; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CSrVbIvqiswwWbOeWda19Y/eSS0DWe8bN5I9kIg1Q4M=;
 b=kBBNe68ILUsvrv9CWnltkDysf435iekMHL+ssplRCSm70OreFhJx6GNE6pPrBn2FAe
 Wds958N0+j5zhzKV9D2XQruAhOV4H89rVZzqW6l2f3CG8mCg3jDRDxiwyvIgXdqeEyUe
 K8Qpit6x0rVJoc5Yo1cSIfXuoo1moV/2M8pk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755617726; x=1756222526;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSrVbIvqiswwWbOeWda19Y/eSS0DWe8bN5I9kIg1Q4M=;
 b=kj41X13LiHv9ZrJZynY5Elz6iv1Sl51g0Ori9KWNPIsFTuooV4/vt4/JS5Myp3F53K
 ajWqqzdvp8VaLR4x2ybvUvlqq60CXsY3QfRXx4QXuIE3reIf/YCMJQ5TgEKjFjr4Icbv
 wPX8S8ZAyCgySjJqI3xxbW6xbGq2hf/rNsugZYUpxcxeUAg3iQH64DpKiBWytFj4R8U9
 fSiQ5MXZ6MRdslN5X7R/ma+UF7Ayrx9Hx9nTC2EZa6Rz5KAhM36EHBbFm7dZhFs9Rd5N
 t3w4oVRzhL3WRfkcNJjodi3TQ8bAGPjbghiy1gSyhxodxDgjJ+3TvpQa2bLBHoi0LvtV
 8HDg==
X-Gm-Message-State: AOJu0Yw01yjZyiTjZQSL6SCh1miUCGUzMY6R7YzaiXpxQUut0Ndib9pA
 1+IP+MgFwIT7PBIwLq4wVmuG0TsFAtj2oCRvo14VVSEwS+sp2codM9Kwe/3RREpVqho=
X-Gm-Gg: ASbGnctlQjoOSLRjtexSoguqfEdh8wQsA9LFohRX4sWIRY/3VNEb3wjnCMYoyZOxSFa
 Fip0phcuhzXb2TTU5xoNsh3VxyaY6AeqhtrnKMH/cQLsU6okt5hkrwz/TiswnL9VcDvi5+xtVxp
 X/iyGaVhpO4+Q4sqy2dmXUAUWAYLxsvLY+c9dnv+gLK4hORDVzAqrxXLte9U+TvliCYpXzpYQ/l
 YWDK0ybqUzCBvqw2Xd5QTezpz3KCcoV1fYdggZTvnB3Ghzli2LOw3BFAwW44UH5KzmGwXvjIGuA
 Y6s1mAtncLMPoPwbow9ptocV2nU2XLYvL2O3RIPqHxdWSVNBk9zVrCtHHzMwzQDncPq1J83eD9w
 dnb3D6RdX0pwi7gVzvhXIKlu/02609bsIOb1zrlMS/kH+Y8xtYr7SUhU4
X-Google-Smtp-Source: AGHT+IHOK+iYtNS6U8GxlfdMgIHP0XbVfzwQhXtzohUZVZ2Uu0RtTAD7X9aieUJq6SDd91N209X6yA==
X-Received: by 2002:a05:6871:eb0e:b0:30b:582a:1a00 with SMTP id
 586e51a60fabf-3110c3ce3c8mr2121384fac.32.1755617725699; 
 Tue, 19 Aug 2025 08:35:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7439203b5c2sm2426291a34.28.2025.08.19.08.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 08:35:24 -0700 (PDT)
Date: Tue, 19 Aug 2025 09:35:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Sascha Silbe <sascha-pgp@silbe.org>
Subject: Re: [PATCH] boot: Add LEGACY_IMAGE_FORMAT to DISTRO_DEFAULTS
Message-ID: <20250819153522.GE124814@bill-the-cat>
References: <20250818165119.3193853-1-trini@konsulko.com>
 <CALeDE9PqJBA9gS+YaNjM605fH011wL1SyT8Odk_k2Lm_V9EHLQ@mail.gmail.com>
 <20250819145737.GB124814@bill-the-cat>
 <CALeDE9PXjSh9kySvOEc-4KDVp7dT+DUUQVYh7JUk2pS+vohe7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XSdJuU5f0fWhYpFZ"
Content-Disposition: inline
In-Reply-To: <CALeDE9PXjSh9kySvOEc-4KDVp7dT+DUUQVYh7JUk2pS+vohe7w@mail.gmail.com>
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


--XSdJuU5f0fWhYpFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 04:33:07PM +0100, Peter Robinson wrote:
> On Tue, 19 Aug 2025 at 15:57, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Aug 19, 2025 at 12:13:31PM +0100, Peter Robinson wrote:
> > > On Mon, 18 Aug 2025 at 17:51, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > At this time there are still major Linux distributions which by def=
ault
> > > > boot using LEGACY_IMAGE_FORMAT type scripts. Add this option to
> > > > DISTRO_DEFAULTS to ensure these platforms can still boot.
> > >
> > > What is the legacy image format exactly? Does select make it non
> > > optional, can we use imply or similar here?
> >
> > In this case "legacy image format" is uImage-style images, rather than
> > FIT images. And no, we can't imply it because then we'd break Debian
> > (which doesn't boot on a handful of platforms now which do have
> > DISTRO_DEFAULTS but don't have this).
>=20
> The distro boot stuff, which if my memory servers, is what the
> DISTRO_DEFAULTS is used for, never used the uImage style kernels.

The same uImage-style header is what's on top of a "boot.scr" type file.

--=20
Tom

--XSdJuU5f0fWhYpFZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKSZtgAKCRAr4qD1Cr/k
CoN+APidfpBqlfLIvEz9rxF3kAmMrrHuhufsaytwBQio5ZTXAQDsSJoXCQWTzgmp
IGDlgAICwfv7wE1UBm6rK/4EFX0XCQ==
=Y96n
-----END PGP SIGNATURE-----

--XSdJuU5f0fWhYpFZ--
