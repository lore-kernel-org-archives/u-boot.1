Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FDEC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 18:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C09FD87751;
	Fri, 12 Jan 2024 19:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FMD+ZmlT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A85987933; Fri, 12 Jan 2024 19:54:24 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA39876C6
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 19:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dbf2b5556f9so3369528276.2
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 10:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705085660; x=1705690460; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WOBXSbUysqMoKgGNCrtZ/BpfijunGkFfK/jT4QSGDqc=;
 b=FMD+ZmlTMPs5M5+/V6ns/uc+aKn4hOtRAR5ewIJUCyxowVb5Rx0e0hMPdAKDfYtfyd
 b6d9bOrG4kI+xWmg6oQIWe5U+2BvpX9Xp496J8YONo3uQmeZddtsq7OfcZnc88es0soj
 6yjGkOWipAI4HbB89DVw1kM5iMuc9R4h3Z/vM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705085660; x=1705690460;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WOBXSbUysqMoKgGNCrtZ/BpfijunGkFfK/jT4QSGDqc=;
 b=aX0+Qkw8aQrGW7Pcp2W9TWRONmKqYTW48SPaaQhC8Si/NG1E9HsuDGdHQUGZjRxRTR
 fFs0RzbAx1HfXmPgVWUkS0SaWbtibf/6Aw24mLYusmxWsDp6m1oYT77bLpzQHYitbNfm
 0Kdf2XJuXBMFYwsM3JyFwDz6TOxn762+D3EtK+AfpGZIsjHfCtLr/azvQ7+czfb5mqYp
 BMisLKx+ksbSFcYLmFIgQ322yHoHcK5E4E6SrfKFMdc0LlOoz0jsUvptyUm5N062MpZl
 ORVwTOUzRnZTDl4mbs4+a3CY4raQBn+3pv/1BMmfQOtevx/kVm8q4YWsF501fMlV0rx1
 xbaQ==
X-Gm-Message-State: AOJu0Yxdbur6/T3+D3dWMviyZ3pw11ZRhOQtcQE+QtSlqj+WNHAdX1an
 lv5wcE690yqfW9MDqi/AY9aefr7tODmIBANoXnon+7FCSsQ=
X-Google-Smtp-Source: AGHT+IGBhRM6pRzFKM3UpU4vUz0cN41WpUB4IcOHxfZ5MpNZ0+E+/fTRiNkC/aF6eWFNmrKEerBAjw==
X-Received: by 2002:a25:9cc4:0:b0:dbd:2c5b:8aed with SMTP id
 z4-20020a259cc4000000b00dbd2c5b8aedmr1059674ybo.108.1705085660420; 
 Fri, 12 Jan 2024 10:54:20 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 c15-20020a5b098f000000b00dbf1c6c29c5sm1380017ybq.21.2024.01.12.10.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 10:54:19 -0800 (PST)
Date: Fri, 12 Jan 2024 13:54:18 -0500
From: Tom Rini <trini@konsulko.com>
To: Stefan Bosch <stefan_b@posteo.net>
Cc: mk7.kang@samsung.com, U-Boot <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-samsung master
Message-ID: <20240112185418.GF1610741@bill-the-cat>
References: <CGME20240109015516epcas1p368e48c6d3e2433577bf7d0684966c45b@epcas1p3.samsung.com>
 <0a3d01da429e$e4427ec0$acc77c40$@samsung.com>
 <20240109155909.GS1610741@bill-the-cat>
 <29757fea-207b-53c8-844f-e76829cf04b3@posteo.net>
 <20240111175723.GK1610741@bill-the-cat>
 <32f3aca5-8d5b-2f63-d60e-f8f0451c380c@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xuyck5/4ZM/Yh9Do"
Content-Disposition: inline
In-Reply-To: <32f3aca5-8d5b-2f63-d60e-f8f0451c380c@posteo.net>
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


--Xuyck5/4ZM/Yh9Do
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 06:52:54PM +0000, Stefan Bosch wrote:

> Hi Tom,
>=20
> I have to apologize, unfortunately I haven't built it for microblaze. I w=
ill
> submit a new, fixed version of the patch-series, should I?

Yes please, thanks.

>=20
> Regards
> Stefan
>=20
>=20
> On 11.01.24 18:57, Tom Rini wrote:
> > On Thu, Jan 11, 2024 at 05:52:33PM +0000, Stefan Bosch wrote:
> >=20
> > > Hi Tom,
> > >=20
> > > is there any action required by myself?
> >=20
> > Yes, please rebase the patch and make sure that microblaze builds. Did
> > it before with your patch?
> >=20
> > >=20
> > > Stefan
> > >=20
> > >=20
> > > On 09.01.24 16:59, Tom Rini wrote:
> > > > On Tue, Jan 09, 2024 at 10:55:16AM +0900, Minkyu Kang wrote:
> > > >=20
> > > > > Dear Tom,
> > > > >=20
> > > > > The following changes since commit 2f0282922b2c458eea7f85c500a948=
a587437b63:
> > > > >=20
> > > > >     Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)
> > > > >=20
> > > > > are available in the git repository at:
> > > > >=20
> > > > >     git@source.denx.de:u-boot/custodians/u-boot-samsung.git master
> > > > >=20
> > > > > for you to fetch changes up to 5631d20e2ef1008d55569790f79672ea8c=
c6894b:
> > > > >=20
> > > > >     pinctrl: exynos: Convert to use livetree API for fdt access (=
2023-12-07
> > > > > 18:58:48 +0900)
> > > > >=20
> > > >=20
> > > > The change:
> > > > commit 411094b8afd9553eb34efed258c64bc39b578149
> > > > Author: Stefan Bosch <stefan_b@posteo.net>
> > > > Date:   Mon Nov 27 18:26:08 2023 +0000
> > > >=20
> > > >       common: board_f: change calculation of gd->mon_len to fix s5p=
4418 reloc
> > > >=20
> > > > No longer builds for microblaze.
> > > >=20
> >=20

--=20
Tom

--Xuyck5/4ZM/Yh9Do
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhitMACgkQFHw5/5Y0
tyyqCgv+I2bOGqQ4SDee6GuM814GQ+6D9CSnA+fvIr0PgwbRCuqggk1mSk8DYz9z
JVpuiLa4PCcbXkMTzaMzqwWjT5p7P4p5jrl7FseARhfuMVE51Gk4fWYK3ryd33Q0
84iqEe0NNGG2EAyGw0WLT84txSM00NK6XZjEgsQvImTDETm8Imc94oc152K1y6NG
PYx5QNNvWQ8+k4TxmQ1JllVZpLWAq53npG2DVlH0U4ch9xi5kzU015EfIQQp9TLK
tQbemSNDs+xp7feP/d/rURhodFs8Tw19Vrh3U6e8Rc/han9pHIhe+/6MPMPfyXwI
XQGn+bN5JWKEeQWxJ8Ik5VEYDb4u/phST/geJX4WIVn0vH7qGXt+HB+AsmHZfaFb
q7PMaOiMTw0QoBXnzEwCru2LS6djG7GV5bIRRA2jdAke9qMZdBOnUv18HrBSxJ1E
Tt5rww3N/CIt8WQqgynWDHdQKKLQpeyu7WKUptqUTLYozbxV4+bIdzKcc5iAAwD1
hUMpghuL
=pZgM
-----END PGP SIGNATURE-----

--Xuyck5/4ZM/Yh9Do--
