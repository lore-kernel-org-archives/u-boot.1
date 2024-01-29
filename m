Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C237C48285
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 17:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D29B287CFF;
	Mon, 29 Jan 2024 18:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qt5o/4Om";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFDD287BDF; Mon, 29 Jan 2024 18:55:07 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EBE587D8C
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 18:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-603e086c05bso9365757b3.3
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 09:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706550904; x=1707155704; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B3hiTplZddOKmpjLV5j9nl0SOpqDow8qwf3PIsuL02Q=;
 b=qt5o/4Om04i48fKru1laVtH/z5B0ONt5F073BZnY+C01WsdWGS202ymOsIQ60KYyWY
 24GnnE8v659PFnIAxNRc7eit5DPhE5cFfA1xKSJbPgcX2x9CZSo5X6Ga5iYHk0qLvj0z
 B+uYHNWQnzoRucndcAm9sLPCR+WxKGHq9SzLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706550904; x=1707155704;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B3hiTplZddOKmpjLV5j9nl0SOpqDow8qwf3PIsuL02Q=;
 b=bqiyAl9FEkoRQzD8D4uHBwrtDGukpDJe6DbJlibThqm98kNAuRdRWbkkpX+qfAhP9n
 hApDpqMqONG8GEGdMUCrhHS6+szQKuAzwUqbprZQuq4uuXyfsthAuX8T84dPCc2Gwizg
 VXeP6gngkhiI5SyKADCVm2h6oZ69PxJLhEEwmSPs465dPKVWGeXlGDWVQG+dUSLtiTwD
 s7lulzMHtQKfHYQE3csjwFLgTuisFsvzBOgoLaxpMS4ucUzx0mNxAWh3gc2noqxn5tdv
 5QZCxxodoZ/B3mCyAR0SYbMZ0sW6H7IKe+3ukM2iWO3bhGTVjOtFlIUj56YN6AN0holg
 zjBg==
X-Gm-Message-State: AOJu0YzUo6yJKRRL051Q1RIA3V6kcsFU0OBMMRVlKbFPnX6l4f8pkoU0
 hxd2RlzGr5/e+FC+LQ5ZOIIwe8jAOgsBb1/1yaKgpPM4PH245FI3YqsLc6BGFeA=
X-Google-Smtp-Source: AGHT+IGUmddxwgLJwGdZu+IbyV5787nf+nzO2Vb6zfQVOm+x6jADk/ppgn3gtaAUwqiicFXlUJLp3g==
X-Received: by 2002:a81:7e08:0:b0:600:2492:e323 with SMTP id
 o8-20020a817e08000000b006002492e323mr4296152ywn.96.1706550904079; 
 Mon, 29 Jan 2024 09:55:04 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 w69-20020a0dd448000000b005f66a83db14sm2607920ywd.131.2024.01.29.09.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 09:55:03 -0800 (PST)
Date: Mon, 29 Jan 2024 12:55:01 -0500
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Nick Alilovic <nickalilovic@gmail.com>,
 Chuanhong Guo <gch981213@gmail.com>, linux-sunxi@lists.linux.dev,
 u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-sunxi/master for v2024.04
Message-ID: <20240129175501.GD1152441@bill-the-cat>
References: <20240129155543.2439451-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h2wZSMKrzrqd1yAk"
Content-Disposition: inline
In-Reply-To: <20240129155543.2439451-1-andre.przywara@arm.com>
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


--h2wZSMKrzrqd1yAk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 03:55:43PM +0000, Andre Przywara wrote:

> Hi Tom,
>=20
> please pull the sunxi/master branch, containing the first part of the
> 2024.04 changes. I had some more (USB regulator) changes queued, but
> found regressions during the final testing, so had to drop some. If I
> can find reasons and simple fixes for those, I would send them later.
>=20
> So for now these are some rather easy changes:
> - Some cleanups in header files: those do not affect the generated
> binaries at all.
> - The usual update of DT files from the kernel repo, mostly adding new
> board files this time. On the wake of this there is one defconfig to
> enable a new board, some H618 TV box branded as "Transpeed".
> - Samuel's series to support SPL FIT image loading for 32-bit SoCs as
> well, so far this was restricted to ARM64 boards. I refrained from
> automatically enabling this everywhere, instead this requires user
> intervention during board configuration. This allows to ship the "crust"
> management processor firmware on H3 boards, which enables better power
> saving.
> - One defconfig for an older H3 board. There was a close-by defconfig for
> a related board, but there are some differences which deserve a separate
> file.
> - Support for the EMAC driver to work with fixed-link PHYs, which allows
> to directly wire the MAC to a switch IC.
>=20
> The branch survived build testing for all 167 sunxi boards, and Linux
> boot testing on some selected boards.
>
> Please pull!
>=20
> Cheers,
> Andre
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The following changes since commit 526a865fe4fea59fb2638726c26e39557eb97f=
dd:
>=20
>   Merge branch 'master-cleanup' of https://source.denx.de/u-boot/custodia=
ns/u-boot-sh (2024-01-27 20:43:20 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master
>=20
> for you to fetch changes up to 539612e27690a8df7f197cd1e9f4c2cf6ee1ac64:
>=20
>   sunxi: Consider SPL size limitations for FIT loading (2024-01-29 14:31:=
00 +0000)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--h2wZSMKrzrqd1yAk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW35nUACgkQFHw5/5Y0
tyz68wwAtHtwkHWVq7eILUQqj2eBMzr8cuKsFf8MtlsoOPRILDVLE08/ftC/7L01
FVjVtwiqW9JSs8z16cksZvX8peTnGsuzsTW0+SOmMWBFZb2L5/s2eqaXQbUR57Oi
fnhIQ0xfwdDASh2yBu921UNiTLyO4k+lJyhfS4ltq0gyRxHvl7cSfFCsY3wkaLYJ
EFn9je20MdxRF5MFLtm2UApyOG+ivD+CJebpFZptCGlmxqG+mEdoFb1jx34g1YRO
DEsRMn0SI5aPvfYIKQZ4aRGjg+VjqoZqU3yHbNDQYshEdjeVd4Pz37Mcuh+7buXc
KCkc+Kz1B8+OfuNM9zdZgPl1Gm7fiKevhe8PqzxVbAyzveGVa+s6Nd9CEixEA/AY
bV082HdICV8leTQm0Xviv0QiIPZ9fSfMcbfdfrRWgY4IhCGk2UWWW+WQisjOmoNO
SW1NyQLgE4ANbsn1Hzi9QtfwCKJYuGU4d8cvAVRWblYsxmixfUHlJYVBzSspQXEn
MadX8vH/
=BTHU
-----END PGP SIGNATURE-----

--h2wZSMKrzrqd1yAk--
