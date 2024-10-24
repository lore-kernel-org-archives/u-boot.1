Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881F1D10376
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 20:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C114588FA5;
	Thu, 24 Oct 2024 22:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OkrsZmJo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A38CF87D1A; Thu, 24 Oct 2024 22:42:49 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A7B688FA0
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 22:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b1539faa0bso88483685a.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 13:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729802560; x=1730407360; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RyiYd14mvK+y0EQ4y2oOYW4kccLnVDOS/XDEIvJrW7U=;
 b=OkrsZmJodzcddYvSJ7uaNkgj7xX9w2jyDEK28ooXPIFTUxyjv2TNy5wjt9m+CFWmEd
 Y+CGAwyfEwPGWpJ+/pRyuXwTSMKOx7iCuamDbLIIurTbjtcEMTLYEr0lKxTmUJ+ghcWM
 KO76DZCu9UHPpkx+dArhqflk6ax0bwgJ/2Ybs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729802560; x=1730407360;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RyiYd14mvK+y0EQ4y2oOYW4kccLnVDOS/XDEIvJrW7U=;
 b=eSOrJxFXZvnrL9sD+Urd6NUTfBJKvLoL3q3flzLW24lwdHJO6FV1jwIoLp3UrqC0At
 XHsEeHkaWid443rnxIphDum0JbYcMRspfV17AAymTCPNtC+qCGyDl8S6cDbihhlcGtbt
 nedIbWN2pnm8Yju29pB9kjpfMJbi/zdySaR1QJUES7oIGgvgdvfMKnIRjSy/6k4JWdtc
 nNXwsKMzMzJjvj0mV6ibpweW+LozSMC3hJGlRjcszFXieVIPt2xgbSo4E7VSxDDiN+RK
 uHkOH0AMOeIsPC2T4qOyUyOK4G4Qu+vUBa86DCikHo0iTJHdU2iiM7UV9Jnt/fHqZD/8
 OigA==
X-Gm-Message-State: AOJu0YzFl+4F+BMzQLTO4M8w0y0JDOuzKjyNEKXn1n5jEVMxWS5GMKYs
 pTMXdp5SAgTdxxU7TlXzDFZ8JTbriOz0oGhpbYHLtK/gLCe7zd/3avfrvs+038A=
X-Google-Smtp-Source: AGHT+IEn+N+aYeO09KelpbXg6ViPJvPFpNcHR450biWUS+uju/NQnHstB6NlE6e0YT1+83+k/YOQ8A==
X-Received: by 2002:a05:620a:46a1:b0:7af:ceed:1a38 with SMTP id
 af79cd13be357-7b17e57a31amr1081613285a.39.1729802560323; 
 Thu, 24 Oct 2024 13:42:40 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a0347asm514572485a.59.2024.10.24.13.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 13:42:39 -0700 (PDT)
Date: Thu, 24 Oct 2024 14:42:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-spi/master
Message-ID: <20241024204236.GV4959@bill-the-cat>
References: <20241024143304.383938-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I9GTmbzw885RmtG2"
Content-Disposition: inline
In-Reply-To: <20241024143304.383938-1-jagan@amarulasolutions.com>
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


--I9GTmbzw885RmtG2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 08:03:04PM +0530, Jagan Teki wrote:

> Hi Tom,
>=20
> Please pull the below PR.
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-spi/-/pipelines/22949
>=20
> thanks,
> Jagan.
>=20
> The following changes since commit 7af813341d5df064aeee764c31ffb50ffcdf4e=
b6:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-watchdog (2024-10=
-23 08:33:56 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-spi.git master
>=20
> for you to fetch changes up to a3384940edf3cf2d2e0e0b78af9541f8be3a15ec:
>=20
>   mtd: spi-nor: Add mt35xu01gbba octal mode SPI NOR flash (2024-10-24 18:=
10:50 +0530)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--I9GTmbzw885RmtG2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcasTUACgkQFHw5/5Y0
tyyGfwv/Q+aAAd3GAQRiDRAKboLVP9/CSRqxwMVU8hAL/nCzULZE3MyqCScI8Rzq
sDtPeeeSFeAEeaBdWT+dsMc/NCIA3B7FWbHZ2XgpAkaJCaeVOfuD9k5j8GRtSe9t
mBcpLLLNesBUp4oDPEHya9be32lH+Xc89k2nCYuhPRnxVHwN/TJRTd5TV4SF7Zpx
CvBPSGQlf2GA75u3CvdJAlFeV0pgFoghgreHSjOqFs4UKSxAHGZX5Y9V+fCG8gSU
1zyiqqtQSIVYYkTOgidLHXGVBSo1McZzd2DZrn6aKORelZvt9hodtMxg2QCoHw90
bYEi4wUCVeSatR94t0KRva3GympEQz4Fx6vwutp+Ri7LBwSPNWWN0FEhVIathoG5
Xlx1yyqLckY9GipGupCTr46hSi0djA45fgrOsFDJeENR001i/f3Itx0/qeRdbK7u
iQ6aZEZqWCTi59sdZxlvT7+TxgMHXq77k9+RZMzyy8NN6qhPmlEkTQ9SgXV/HMuQ
VzSHWKWU
=veFE
-----END PGP SIGNATURE-----

--I9GTmbzw885RmtG2--
