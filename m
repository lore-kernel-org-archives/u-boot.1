Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1017EC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 13:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C73186FD8;
	Fri,  3 Nov 2023 14:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WuBEj4X+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E002686F56; Fri,  3 Nov 2023 14:42:20 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7033086FD8
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 14:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-77774120c6eso113467485a.2
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699018935; x=1699623735; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kZ6d8lvutkBOg8izvY5fRAOnhVN8x6SqifJxJ0HKM6U=;
 b=WuBEj4X+G7yYtbkozjG3Zg+pcmGr89V86nX/ccYwyWTivccBrHeegZ+MZw75ZHS7Pw
 JbEZjP2K5ejeYad6H9xHjVsOK/lTpoyMDJR+54GUntpCtpg+7JkPxHkXdLr7DsokV2gu
 xSaob6DqiaUJFMzeFUyzcUKog5C2Zw5WEGHNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699018935; x=1699623735;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZ6d8lvutkBOg8izvY5fRAOnhVN8x6SqifJxJ0HKM6U=;
 b=ccRr90fys8z26TfT9nut3lwN1Q5HR5/xo/0Er3R5ILmJeFjANfT8UlcZqEbbJLetDI
 FnE9dNMhkiyV4VPmlDEHQN+G9S6NwT5ImUK/40yfTtO8bejtXk6vy3mHTEn1xHaAfNOf
 r4S7r5clFBDRM8fqNzqyOAPYwuxszS+YRAErfpgEEH19tHFt3E6bZoIV4NhFGl85DWGh
 ketCJl+0cXRm3BZwiozlRSbpWA5lRk6h0wvqlVZKGMVA3UmJbrDhfMpXGHuogZcI9Dia
 1yxXXUh2M74M4D34Nl4V9+fYY0olXZ7R/1wpCUj0tnBCmjhZlurqulMFz6v/fuPPyHae
 fIhQ==
X-Gm-Message-State: AOJu0Yw5u9lYBEb1mpwcAai/zYv+4apNJtQlLyj1kSMl8wVlP02mAMFJ
 0f/Ahi552kXtLkYUDLzdKlNx0w==
X-Google-Smtp-Source: AGHT+IEPMS2pe3f0UwV2HgMEq04IEOttrDmgL7Q2w9Qq2NyjZHXwOqQ+RiVwS6VPeMLMssI132oFHg==
X-Received: by 2002:a05:620a:4144:b0:773:f6b6:4085 with SMTP id
 k4-20020a05620a414400b00773f6b64085mr26613299qko.54.1699018935121; 
 Fri, 03 Nov 2023 06:42:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 t6-20020a05620a004600b007743446efd1sm739922qkt.35.2023.11.03.06.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 06:42:14 -0700 (PDT)
Date: Fri, 3 Nov 2023 09:42:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm
Message-ID: <20231103134212.GO496310@bill-the-cat>
References: <CAPnjgZ1QEypD08Py_9k=upHF2SqO3wZ7h5uVT0Pz2qza=a4J1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dJj/PLkcOA3ZTzOM"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1QEypD08Py_9k=upHF2SqO3wZ7h5uVT0Pz2qza=a4J1g@mail.gmail.com>
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


--dJj/PLkcOA3ZTzOM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 10:54:31PM +0000, Simon Glass wrote:

> Hi Tom,
>=20
> Just various bugfixes, apart from the TI one
>=20
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/commit/3227baad05481=
e37d75aeae7c7c1467fd6903f7d
>=20
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D54&view=
=3Dresults
> (not finished yet)
>=20
>=20
> The following changes since commit 07fe79c93c5caba181f37844ca95fbda4db3f6=
13:
>=20
>   Merge tag 'i2cfixes-for-v2024-01-rc2' of
> https://source.denx.de/u-boot/custodians/u-boot-i2c (2023-11-02
> 10:12:33 -0400)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-pull-2nov23
>=20
> for you to fetch changes up to 3227baad05481e37d75aeae7c7c1467fd6903f7d:
>=20
>   u_boot_pylib: Ensure subprocess is closed down (2023-11-02 09:38:54 -06=
00)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--dJj/PLkcOA3ZTzOM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVE+LEACgkQFHw5/5Y0
tyx4pwv/fcIkUYkl/F6yuxR+7/r/2lTjzor52+FdQ7Nbtdhr7Fvd/7LpVDzpaRU/
I5EhK5x8nl5s0cWP5hok84UFJV7xkhcZuVdWpbczDt4+pCQrgH5uLoAiJXjt7taE
aZqztfdyCrNHC6JMWowaJ7Omy5UADotx3g28dGSpcNxZ3vbv30FUFm6K5hnc4hLk
fSKylJp/SJ8g5OhpRugigCSxn42lu7v6AsNIO30yv3murffTO7apctK1q5y2/Qqt
plptnELE0Opgp+xcvyg0FOWdG0q8yPaxQpS24O6FXPeJBRVxAYnv1XpO/JoJW3Xs
jDvR++rMVmqHjzlC/sdij74nOUVZ2LwqNGJlxwtfxvVOfJkTW1UrBrioMqz9TcGg
Y9+xaTtuLriQluojpvgC+800kZc/HAvjzpMSUX/jTIL4I19h+wYLqTOsTVtD17pq
7WYqv0/xl73pRyK2iqzKYi8Y1hfVkNTgFcla/7h5ZeYutXqwWimGecHEMLvV6AlZ
WJB/i0Go
=Z16/
-----END PGP SIGNATURE-----

--dJj/PLkcOA3ZTzOM--
