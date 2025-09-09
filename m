Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6C3CAC583
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 14:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4B2E830B4;
	Tue,  9 Sep 2025 16:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JcrG7lS9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1CF583106; Tue,  9 Sep 2025 16:56:49 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 655AA8309E
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 16:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-746d72028e0so2940282a34.2
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 07:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757429806; x=1758034606; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u1W0TWte5yrg4ha96K3wBgGCMLGFcm6HPvS0hK7NjzY=;
 b=JcrG7lS9V9yUL3Eo/LWSDakCP/KC9/xPdkF+y/qw0zqs7WIq4ouFCzoHqzh6nXHvpr
 ECskF9p8Q9kWgrRBybjbEML2yoeRmC7tVhwUFTljMFgJFFrgrcgFIMmPwX+hT6sk6foO
 q+GIjprSW7Y0UCDUqbJNqK3aGZlU2ZG3zGgio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757429806; x=1758034606;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1W0TWte5yrg4ha96K3wBgGCMLGFcm6HPvS0hK7NjzY=;
 b=wNSoKrCvNhsG9aoNzJRbiHp28ux+rMNmpMk6dzp8Il5fD6nxHdfAM1SRzRQA65bKbO
 KLUO/LLVUZNmjfQSnsnHHUZlWDVIFpJ9rDFIwdr3LKe0Aa6l2mOP1a67+G8FaUFryRtf
 ekb2kqEe7m5Hxlc7sWF8XkfQcq+f+4s6qYawbl1iCCzXkjiEP4rYRtGzzlkoPhsshU5p
 IXP+VG2XMF6CaIPR4ypDFwtCX/+kBVQcDu4K90YCV27PfLD1c0QxToxpdGKg+SO3D4K0
 5X4+S/E2n9GLChJ6kKFrpoBlwJGdbUQRXHrDf2q25wzdk/QeRnyQkDn85ZLRAjJ5b4Kc
 af/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfx1A7a+zVZXVp4Vu9Z0zdNP9U884K0yVHt0BO+JcgQALOovNVGrBdg+0J0f/oYXcbncLxW+M=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+sDbnIM0LmuOxSaeGv5cSYUoPblyZOTTNEyjW4bQnECCzZn0I
 NL5IrH2Yis4uH1FoMMnybMyNBDRUyFIZdGTt4FAWP89DrhVrvMDoNhkJWY7zDYS+2fs=
X-Gm-Gg: ASbGncto2RhM1d8xjV7+Hk2PFhQl8ilUBqhpIkopBPqTS28AGLXrNVcGG1wcwMgveop
 oZWF7FRTuDTTON7mp1dznvt2ifDi9E/fwyrfhLO+TmgOM/r9IY3e+sGjGY4hTtbTHaqVmj2DFz3
 NRDxn9DIG+ApfR7+PNIIRuERD/s7ofoc2jr9ameG69ZfxRAYD6vhnfu1668Di0u/atc3mMAeEu1
 eAaGI1xWKvk9a/on7puDMUopuSMYin0Y82gyx3y/+D+QjMg2NeyKL80jhYuWD0Yd7KLTSfviuUV
 fnhNvIHQQGNrD9oHQnSSO2MyB9ARWVPJVCPQzjgIjAKwGrulMyVSvV3vk82rX1exHmgKwV7eXOf
 XGOh2xjw1NIeHOIXqHX/52utgHnj4PQiY45uOdshx/eK0I2hoY1Tv/VjrWufrIFwc0Xk=
X-Google-Smtp-Source: AGHT+IG+LcItRgP/4FrEbhG7VtCeSQ2NNpOPS6Cw3AaaVjytNmmM7vMqO4/MA1BKYaxpJWr0OWWo4A==
X-Received: by 2002:a05:6808:18a7:b0:438:4312:ab9d with SMTP id
 5614622812f47-43b29b03db4mr6787859b6e.45.1757429805971; 
 Tue, 09 Sep 2025 07:56:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4380005f3d1sm6171794b6e.22.2025.09.09.07.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 07:56:45 -0700 (PDT)
Date: Tue, 9 Sep 2025 08:56:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 1/2] ARM: bootm: Add support for starting Linux
 through OpTee-OS on ARMv7a
Message-ID: <20250909145642.GW124814@bill-the-cat>
References: <20250630000832.952206-1-marek.vasut@mailbox.org>
 <97DFDFA0-80F7-462B-B2A9-BDBAD42A191A@gmx.de>
 <24ae4a7a-103d-49c5-90cb-3ad8ad3e4bab@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V5NiY6FdI3Ng3Of5"
Content-Disposition: inline
In-Reply-To: <24ae4a7a-103d-49c5-90cb-3ad8ad3e4bab@mailbox.org>
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


--V5NiY6FdI3Ng3Of5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 05:02:27AM +0200, Marek Vasut wrote:
> On 6/30/25 7:18 AM, Heinrich Schuchardt wrote:
> > Am 30. Juni 2025 02:08:05 MESZ schrieb Marek Vasut <marek.vasut@mailbox=
=2Eorg>:
> > > Add support for jumping to Linux kernel through OpTee-OS on ARMv7a.
> > > This is only supported if U-Boot runs in PL1 secure. This change adds
> > > two components, one is fitImage OpTee-OS loadable handler, which makes
> > > a note of OpTee-OS being loaded and stores the load address for later
> > > jump to it. The second part is the actual jump to Linux through OpTee=
-OS.
> > > The jump through OpTee-OS requires set up of multiple CPU registers, =
r1
> > > and r2 are passed through, r0 and r3 have to be set to 0, lr is set to
> > > Linux kernel entry point. This setup is done by new assembler function
> > > boot_jump_linux_via_optee().
> > >=20
> > > The boot_jump_linux_via_optee() also includes STM32MP13xx late TZC
> > > configuration write, this cannot be moved easily, hence the ifdef.
> >=20
> > Hello Marek,
> >=20
> > Could you, please, add a documentation change to the series. This would=
 allow reviewers to test your proposal.
>=20
> The fitImage TEE bundling is already documented in the fit spec:
>=20
> https://fitspec.osfw.foundation/
>=20
> This here is an application:
>=20
> "
> /dts-v1/;
> / {
> 	...
> 	images {
> 		...
> 		tee-1 {
> 			description =3D "OP-TEE";
> 			data =3D /incbin/ ("/optee_os/out/arm-plat-stm32mp1/core/tee-raw.bin")=
 ;
> 			type =3D "tee";
> 			arch =3D "arm";
> 			compression =3D "none";
> 			os =3D "tee";
> 			load =3D <0xde000000>;
> 			entry =3D <0xde000000>;
> 			...
> 		};
> 	};
>=20
> 	configurations {
> 		default =3D "conf-1";
> 		conf-1 {
> 			...
> 			loadables =3D "tee-1";
> 			...
> 		};
> 	};
> };
> "
>=20
> "
> $ mkimage -E -f fit-image.its fitImage
> "
>=20
> I can add that part to STM32 board docs ?
>=20
> > Furthermore, please, provide tests on QEMU.
> The test would require booting Linux, how do you propose we test that in =
CI

For this part, it's something we've talked about off-and-on, and part of
the answer is caching in the container some set of very small but still
useful for boot testing stock images. That said, it's still a lot of
effort and a good question as to what is really being tested in each
case there (and in turn how worthwhile it is).

--=20
Tom

--V5NiY6FdI3Ng3Of5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMBAJgAKCRAr4qD1Cr/k
CvexAQD67JxVD/qpp8wrdN9b9wMilxTzsyOMcsTkzhVCBDQ79QD/UD2l4SkAUdci
lEoNSp8564M9B6R0fZXlqzcBg4PGTgM=
=dJ1O
-----END PGP SIGNATURE-----

--V5NiY6FdI3Ng3Of5--
