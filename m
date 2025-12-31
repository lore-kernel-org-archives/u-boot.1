Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA598EE6458
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 16:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF005840AE;
	Wed, 31 Dec 2025 17:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BY1Im326";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB46E840B5; Wed, 31 Dec 2025 17:33:17 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5013883F69
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 17:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3f11ad6e76fso9164914fac.1
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 08:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767198794; x=1767803594; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u0SgsKTe/aj9qBE01JzEHhoyDejUHgg/mtH6KDsz8cU=;
 b=BY1Im326crUAZqIT+r+04w0f5elCocj83mPdqDevUlphVEsMe8fgAzmOjzqbaxikzd
 H7hxMfVaL1jIlwZfARfKhZO3uiOfWpInx68o0k1i0rirGJrNnXxcLqjDcq1DTaCP+ST1
 I+WwbGTxmnMQvZEVbNxmcILcoyhxKfEzj1J+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767198794; x=1767803594;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u0SgsKTe/aj9qBE01JzEHhoyDejUHgg/mtH6KDsz8cU=;
 b=fbtUUJucdbVd/hfNgBseygQT+Li3+ozD6u4viCKfHqvuXghCp7NZTf/DEc/P2t+KIe
 r2jrkNWB2FA9HRxRErCK2AZsjA90vjJ/8II/h7RqqKgMgFvPRfw7aCEVP7c6n/GssnRK
 NsUqifCMQWDENOGQL5qMH7OgOS9GzFRInUJozXXGOxD0/RPemOs9DEFwbYu/EqOT+eOl
 u9/k17tOOuUN6pAWJCoG19yo80MElIlzl27wMWA7abxK5nBH4swkMbTp9wq0fVGnJL79
 x16qXj9Rpz0YsDrLkeebYY3tdBuTIB0J3C/qx3QfIAibPaHKOiQI8dXmwAkd+rNVO/q3
 vNJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpAMZxQdcdun/ZzZHDAbAyVJ9EY3lCWv8adS2c7QLeelBkQ2fEhmFQMrc1AP6GATEEYNIAfPI=@lists.denx.de
X-Gm-Message-State: AOJu0YwlWn+HwG5CglJLrfou29Rwb+pAmAaWDN3uVmFH4z8hhF5htvQq
 Cz6bBygKNtOSatl43yvVX21Dhb7ZD3d1+xRXIfRkbdBlAo6BRtsViSgsIWcsxNamrs4=
X-Gm-Gg: AY/fxX7bevgAzGLb7HrLmy+7HLA5LKLd+jQhnthZVrQ1IymCca870sfTyOFlO2Ung7s
 J7PVa6Jh2LlQH7sL4G8blc5gSSz2zNlUulOwAPFo/G3BT5rODVMed/8KPdx8wM2gCADFqBuc2cd
 yQ03BBq6aEeb/mkx6OVPDwqqAFwtH6zr8em+vaDTuGnLKmn/0do8bVUcObxADYXzJxjZzS3a0nz
 s+RThWkMSUc6Rm41Z0eGtu5eg3lIRJu/xsZudvkkoaxvJE9rq6TNmK4L5pELCkq2qz8jX7oV6QK
 EjowFyqt/akBjc5F2cLt8+Xb8TYk7ZNrCT3U4L5QuecyuNW5ZyQ+8aToSshZZGfZHBB2gtgQQrk
 gtITwNlvodpj4+q/HVT8QBxvDVH0rD8JFdfaG/cqTqaxqtbh00JNtqX+7kndX7Nl0FaDbZoGkxP
 8Cqekwie8S6ix0zpEAVp9g6W2tRSq+Ckli05aTRYDqc51Es5S1rfTrDVzUOm38c7PfOFk8zNyor
 Zz2obO9RJ8nlYT4krTlAy5up2XS2ZUbuK5HvpA=
X-Google-Smtp-Source: AGHT+IFwsQvJxt1ivIofK9wbxQLk0feC2p6SatbaX6YoOUoKK4QLJFDB8tgBNNr5L5/Qmiicm4Wqow==
X-Received: by 2002:a05:6871:5e18:b0:3ec:a020:4c70 with SMTP id
 586e51a60fabf-3fda523a217mr16292756fac.14.1767198794060; 
 Wed, 31 Dec 2025 08:33:14 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa9370c4sm23030697fac.9.2025.12.31.08.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 08:33:13 -0800 (PST)
Date: Wed, 31 Dec 2025 10:33:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, me@ziyao.cc,
 daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [u-boot-test-hooks][PATCH v2] travis-ci: Add config for QEMU
 m68k virt machine
Message-ID: <20251231163310.GC710860@bill-the-cat>
References: <20251230160651.3049301-1-visitorckw@gmail.com>
 <20251230161545.GU710860@bill-the-cat>
 <aVVP7LjBqbfY1Q5P@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3stapuYOz3MFie3g"
Content-Disposition: inline
In-Reply-To: <aVVP7LjBqbfY1Q5P@google.com>
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


--3stapuYOz3MFie3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 01, 2026 at 12:31:40AM +0800, Kuan-Wei Chiu wrote:
> Hi Tom,
>=20
> On Tue, Dec 30, 2025 at 10:15:45AM -0600, Tom Rini wrote:
> > On Tue, Dec 30, 2025 at 04:06:51PM +0000, Kuan-Wei Chiu wrote:
> >=20
> > > Add the configuration file required to run tests for the QEMU m68k
> > > 'virt' board. This setup uses 'qemu-system-m68k' with the '-M virt'
> > > machine type and '-cpu m68040'.
> > >=20
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Rename to conf.qemu-m68k_na
> > >=20
> > >  bin/travis-ci/conf.qemu-m68k_na | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > >  create mode 100644 bin/travis-ci/conf.qemu-m68k_na
> >=20
> > It would be good, but not a big deal either way, to also leverage
> > py/travis-ci/u_boot_boardenv_M5208EVBE_qemu.py here. And I say "would be
> > good" because really, we need because I'm not sure it will add any
> > coverage over what we have today.
>=20
> I checked py/travis-ci/u_boot_boardenv_M5208EVBE_qemu.py and it appears
> to be primarily for network-related tests. Since I haven't implemented
> virtIO mmio support for network access yet, I think it would be better
> to introduce such tests in future along with the network support?

Indeed, I just assumed networking was present in your patches, so later
here is correct.

--=20
Tom

--3stapuYOz3MFie3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVVQQwAKCRAr4qD1Cr/k
CrHLAQDu7yHIEAJoOM+D8C7h2uYS1yXZPTPlAPQ2shQt8C5f5gD9FY+AUaPaDpN1
vj40wl7oH97ncnSSdz7tXUZxJnLX7w0=
=B11H
-----END PGP SIGNATURE-----

--3stapuYOz3MFie3g--
