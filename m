Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7ECC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 16:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17313863F8;
	Thu, 30 Nov 2023 17:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bFZ5m0cp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61631870D5; Thu, 30 Nov 2023 17:11:57 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A8A38269F
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 17:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5d35a952943so7528547b3.3
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 08:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701360711; x=1701965511; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UlENqdL6aYbt1oP4XeUL6efUTYXkGBs8TDWBIIxmsuE=;
 b=bFZ5m0cpMRgk0Volou402xpdAgOYnU+0z9JlqCa3n7BpkAqjp7vBkehY0EXIPjWg5e
 DerDcntcnOZKBIT3skiq79BUKkRGsjc/hrJqqto5DtwfU6dhYt3IuI08wC3btFma3JAS
 tIZGpwSyZ38+Wd9nBQDbGtCbnL5d779QrLic4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701360711; x=1701965511;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UlENqdL6aYbt1oP4XeUL6efUTYXkGBs8TDWBIIxmsuE=;
 b=kNa7Axq7kQR6ic4V8+i2l3PQV5GmQHPst+oOKF3N1RZoiYv2NalyF9lhfCGgoop5ro
 LRhV2fOOm6u7RrQ14Qdu7u/DKUwkRyzgDWMTFQVQ+HOKgE9h2sQBrK8xdR/N2Hc0w206
 2ILCrz/G3j33Djp0SQ4mGo+Spv31EyQ4dBPgYZLfFVb5hgmhbpeLuQoXLJWmn5k69Prv
 XvnXA5/iDpRCUH6Iw9emBA5dI60J/66TrTvPoMk2kPuTtuWcozB2kiPJb9CsjncIkyT8
 z0Z8CiDTTMsgyA/iS7acAkTkqN5m9c/Fm4P4N9t1FuTnBKX+/j4/Q+pCmPcewaqKjVw6
 UosQ==
X-Gm-Message-State: AOJu0YwN/Frh7MRWk64emu4H4dRn5cZQwmU9vXnHdgaouLQTqv68O2JM
 SaYwD3emBKb3m2ojH2ZG3Lbn+g==
X-Google-Smtp-Source: AGHT+IGp3WBAyUwuQ1AZ7/9lxbYDEdObkskSOVSAlZJ1nDuEsfO2xf1ndp91VSZ5uRHfOwWHtkQJYQ==
X-Received: by 2002:a0d:c584:0:b0:5a1:fb1d:740a with SMTP id
 h126-20020a0dc584000000b005a1fb1d740amr21187058ywd.51.1701360711648; 
 Thu, 30 Nov 2023 08:11:51 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-61c1-9eeb-7219-1742.res6.spectrum.com.
 [2603:6081:7b00:6400:61c1:9eeb:7219:1742])
 by smtp.gmail.com with ESMTPSA id
 r20-20020a0de814000000b005d39c874019sm209434ywe.66.2023.11.30.08.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 08:11:50 -0800 (PST)
Date: Thu, 30 Nov 2023 11:11:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Please pull u-boot-tegra staging
Message-ID: <20231130161149.GR2513409@bill-the-cat>
References: <20231130075036.5336-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OBFursw1+FOIdgqE"
Content-Disposition: inline
In-Reply-To: <20231130075036.5336-1-clamor95@gmail.com>
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


--OBFursw1+FOIdgqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 09:50:36AM +0200, Svyatoslav Ryhel wrote:

> Dear Tom,
>=20
> The following changes since commit acae7eb5fe063dcfe2dbdb1e1804cf3e12cc2f=
3f:
>=20
>   i2c: Bugfix in i2c_get_chip_by_phandle() (2023-11-27 18:54:56 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
>=20
> for you to fetch changes up to e22d5799dc86298ad8388ddcb3b759e166c142b7:
>=20
>   ARM: dts: tegra30: enable USB PHY node on some devices (2023-11-28 09:1=
7:18 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--OBFursw1+FOIdgqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVotDwACgkQFHw5/5Y0
tyyi/wv/fdv7WhFIMrv9zLTxNIX6ZFYQPQl9ITMU+qXUCK+6c2Bf5A8LDbqw3608
exO6DsHH/U8ST51cQVUGvQvpGCuO9o+ZMUBNy+xy/cu0E2PNlvwPARt24TBlepCA
Z+KEGljDXwafd+RlHwV5owsvVcuiWrIacrBVssCWOtazu67QHiyvZSOEgYbA8tUh
HG9K27fhBZ01KEPtjzZr/KUMvrDf/JYjUMop5xYppea2QBl+mVssIMhshKGHgkZx
b74em49LVV3ytTgyzT6wDbisVJJRjGuKxWDX31pVgYE9T6dSBiQt/iFGLWdb8RyR
9f0mZnCvt8TtOH6H5/psgFP5V534bxGqmeQLezZcYzWOE0lQYU2fBkZLe+JZqqFH
1/6VsVAwWN24CdxStpCufGOQhR973p3ENnMhc0mpc8KnqJE57B7Ux5eoq/5te1Eh
kOD9WuPIWD3HzO4Y3N5dGzxp1QSWW567kWPaGcKbZnA2NpIhr2+np2RO+HAn6JHh
mhLzm8QC
=Ykav
-----END PGP SIGNATURE-----

--OBFursw1+FOIdgqE--
