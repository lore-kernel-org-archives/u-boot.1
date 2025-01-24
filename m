Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFA4C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 14:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF5C8807FE;
	Fri, 24 Jan 2025 15:14:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TiVT/sbc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E9180977; Fri, 24 Jan 2025 15:14:11 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABE2F807E4
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 15:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6dfbc45355bso24415336d6.2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 06:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737728047; x=1738332847; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FjbrNdw0U0ovxRgVfEUSSeMpf4h1vuvUYgnZoeVVsMg=;
 b=TiVT/sbcjMBmPfOgXnH8LeZJ/lGP06yyIdogKYcrv4LUmhlWM4miUMnghL4oMuee54
 RYhv6K2iEHIAMrWDZtYsuBANmb6mPiAu/o+GInNIdBbl7USY21TDE5xdirrEyrYgLxdV
 j3aBBbeIyHhWlVY9H/kQl/O/SM2m8wgpIGP9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737728047; x=1738332847;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjbrNdw0U0ovxRgVfEUSSeMpf4h1vuvUYgnZoeVVsMg=;
 b=CPNskpbAdTo9tGK1hrkxFTtD2oYcSArczLFmhQ6Tm9dyHh6CNgKgoIUoz7JbiGvxyg
 4L4wrt75rlu/3UY8J0tP0Lt8VNLzv/Egq0E68h/0LR/3y0aB03wOJYHkwojlBhlTV1MF
 6+LSlua6eq+78W7p1XjCscvto8cfYTkPmso+b1VqPSzvt4NeGzzbWC2WVJWcSmaCbzTI
 /6x7mAsycBwzUv9191G8qw/j7gE9TLSeCWASTVFkL9OScswN5irMyGUqSaxMCKG8woYa
 5HuNYG3xagMtwIi3dWj3RDc8eBxPBVrPAz1kE/XFxR9VO7dVZATRq+j6DBh/BEOmnvrM
 cb9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfxWOMv0Q/do8g48LXcRJLRxOu0zMweIWwxsaw1AWMflbOv+oBRh6Ms5CLct+fZUAxAtWVmQw=@lists.denx.de
X-Gm-Message-State: AOJu0YyusotZTdtuT3xwJIxupG4DszJ465wu8SbVtu5rIQ9+uhJuhPUO
 PFXqMYPSd/aZmCvoQ/Sc356LOnqFVj9p9Ob9pLOyhk9JOsWCHehRnSYRi2Ln/MI=
X-Gm-Gg: ASbGncuHpW5M41OcC7pfzVmtgdGrqhlhedF1ekpXBoVnGYpjKw3SjqeUSoEpRXKHWdg
 ygWyPPxaAVhwALiLrxondIBGBB8EaTdfMdBHx22uP4BpZZS2HzpSE+FpUNz7wssK8X62j68qktU
 p5S/3C0Vy9OOSlmGubww/a+c01RkSYpeOpA2oxOAKQi1cPqRLS9fGOLqt003ytmnFFxj6XNfaRl
 tWlPibmX9MNuCK0FSKeyRxvEsrskmXXgLzHPJmjmudYEWHzkdUpjsZbnnnmZvIMhr2BmFoWNd6P
 nhCg
X-Google-Smtp-Source: AGHT+IFqxvT2dUsZcB+lYXlel0sOgft9KpSdztFrOosFUM5DBEBphNydUh70WVJpL4iX2tSAL6B6Pg==
X-Received: by 2002:a05:6214:3d87:b0:6d8:b562:efd7 with SMTP id
 6a1803df08f44-6e1b2229dc0mr523768136d6.31.1737728047337; 
 Fri, 24 Jan 2025 06:14:07 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e205ac400asm8774726d6.118.2025.01.24.06.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 06:14:06 -0800 (PST)
Date: Fri, 24 Jan 2025 08:14:03 -0600
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>, u-boot@lists.denx.de
Cc: "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "rhs@riseup.net" <rhs@riseup.net>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: Re: Pull request: SoCFPGA changes for u-boot-socfpga-next-20250124
Message-ID: <20250124141403.GP60249@bill-the-cat>
References: <DM8PR11MB5592EAEC1756EEA4C573E82ED2E32@DM8PR11MB5592.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LGY8nS5uKDMFlsSk"
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5592EAEC1756EEA4C573E82ED2E32@DM8PR11MB5592.namprd11.prod.outlook.com>
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


--LGY8nS5uKDMFlsSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 03:32:21AM +0000, Chee, Tien Fong wrote:

> Dear Tom,
>=20
> Please pull the SoCFPGA changes for next from u-boot-socfpga, containing:
>=20
>=20
>   1.  Bug fixed for doorbell in secure device manager mailbox driver
>   2.  Enhancement on SoCFPGA dwc_eth_xgmac driver
>   3.  Enhancement on DW MAC driver
>   4.  Improved the error message and status for SoC64 device FPGA configu=
ration driver
>   5.  Updated existing watchdog in system manager to support new SM device
>=20
> Best regards,
> Tien Fong
>=20
> The following changes since commit 2eed5a1ff36217372e19f7513bd07077fc7671=
8a:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-snapdragon (2025-=
01-22 11:23:35 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-socfpga.git tags/u-boot=
-socfpga-next-20250124
>=20
> for you to fetch changes up to 60d96038d7ca9681e926a22789613a983ff9bf9a:
>=20
>   fpga: intel_sdm_mb: add support for query SDM config error and status (=
2025-01-24 09:56:34 +0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--LGY8nS5uKDMFlsSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeToCQACgkQFHw5/5Y0
tywQwwv+MNa07AW7SpU0IuzqEJ6G7t+jNtqZOnRx0my6KjgyJTta+FAdcRQcmk3Z
2lIQRmFZMCuez1ROxKMWE2YqKrEvr35u1qGrgUiLDeGye4/B1F2zSMtec7aQBEUa
5TZNOId9CfWCp4cTD9eOg7YAFE2pcjypC2wvTaAEsa0/93Pey08MIzQfuyxi+nyQ
dSy73SvSfun/4yb2KkBHu81jjnNAjV//xUn0HuZz1hkmT0SHVVM27LZAQxNhPpNw
XCjZQhVvVFAg5lDKGlWWXL2c2b8LJ3fCpgeK+/ZqoUjuFu0l3sDdrEoStZVPhf0F
plqB/8urDjOgTfjfYdZRTHdrj06hN+a21FM8b13TlwB+lQ4SW5Cm9StxEaCinIXK
G32ryst72gEWc5QJpoxUwCjG5L92ZP7/svfWLEIma8A1V4ex2agyC5rZRQSI5CRR
DbpLOFTueOCkLXUMJSJDlsM0piW+D5Hw0z+Efa948661VY0PoH9DmF3LZxEc6rLc
lugSr7jM
=6puW
-----END PGP SIGNATURE-----

--LGY8nS5uKDMFlsSk--
