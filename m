Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D21AC3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 13:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C12B829A1;
	Mon,  5 May 2025 15:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZmC0oKal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BE4E8219D; Mon,  5 May 2025 15:48:49 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31EFE8212B
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 15:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-40331f302f1so2745085b6e.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 06:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746452926; x=1747057726; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1Ni84EtVKBmvjOBtpf4RtqjM/9jkhFKrZM5MSemVFaQ=;
 b=ZmC0oKal5eOaMfXwL74h55H1fB7rtS+SdsQAPQ9+izZPPqev3Kbkz5H0FiK4trS/8O
 zmsFvB83wCYi0xpfJlkDP6aQvZaeVRH6YNLMj2Kq9c+rWlryxr9ICSK2RHMnTsb9yIXW
 5Nzf7a9lieFtOLlCbvUbvDE31IJ5+uJNuXXkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746452926; x=1747057726;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Ni84EtVKBmvjOBtpf4RtqjM/9jkhFKrZM5MSemVFaQ=;
 b=PRkujtC+8m2kKnV24DYpsfYAUyDjX3bNa6WkBkaBazl0inixVKke561QMTb07tF/wh
 9p/12r0VOL4VmZCRh0uYDi793+6I5qHL98csxOIr2VFk4i0HSGUeNJwenhIzrKsYgWYq
 CZlaK4bS6HYdbDdQQOumvlDAyTaUDbY7BwYG3BKycDQIyAGCV+khs8xV3rcyT6ZAcQ9V
 UZOXLb+4hIQxtbHwyQtCVoTm8d2iYW75sIveiNa+u8+pksuxlxt62G/qtvaTsi09X842
 VNGQ7a8EHU9CqIhWvDVYT8bIBSBwwX6r3UUW4j7CTgHMpdLqF/U+bxCTR6x1Q5BYElrx
 Dt1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBgrHhCNt2x6GgYvKJQz1OM6H8/ekeUIJ+/pEnEfJaIyZcoi/hWdMRcACWS0PDhGjYkLj3Op4=@lists.denx.de
X-Gm-Message-State: AOJu0Yzv+6SVzRvhOeHSmgr0EIq23h8stRiLCmFOIeALRsqS9W4aeLNn
 pWhdZ9CFUnOVH1JIF5oNuNkfYSyrqN1OKbCJBpack+UeccovSDzBLkKaEz6zvJW8PrYR1pmogmN
 oWDQ=
X-Gm-Gg: ASbGncvhOENG+7LWK2xOuVPTOS7OatL++bbgCbWYa4jtJgIXlVwfBraXIFVG9X1wo7Y
 X09Kp5xX+/RPt0kDlG+b2vJlujPfCW2rO5OMtj305uAHzxITIcnSrlur4Xzedi6ZvKffJMgnPzr
 4E4E30XdvSJ00i9L7jfKI/f87mJp23CkAJlmq6D+8AGcupGmjiQauOU69v9b7GgPa267jFKtmLB
 2VvpYVJj4yF2CsiKpoI9wQfpl4A5wSk3d3mIZGOW001NeI2JlFj2qS91iNYxvZsuOkGM0O7iVog
 vJVqBG9msnSIs9Co3tYdc0ib93sYib9sbGPl6jekVY+CBmZ83YNHcPi3+d2PGKzn5ySB6eA9/5P
 +nQ==
X-Google-Smtp-Source: AGHT+IEoku4ZIGNd4OB6YAfMsHU5BRLeOQpeGkliYqaZ3v0uOFNNQKiG9mXuzgjKNjSVI/U2kB8lmg==
X-Received: by 2002:a05:6808:1686:b0:403:3370:4768 with SMTP id
 5614622812f47-4035364ad62mr4957333b6e.5.1746452925911; 
 Mon, 05 May 2025 06:48:45 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4033dae4381sm1844844b6e.23.2025.05.05.06.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 06:48:45 -0700 (PDT)
Date: Mon, 5 May 2025 07:48:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Bruno Leite <brunosampaioleite@gmail.com>, u-boot@lists.denx.de,
 probinson@gmail.com, Matthias Brugger <mbrugger@suse.com>,
 clast@prevas.dk, Bruno Leite <brule@prevas.dk>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH 0/2] Add rpi5 specific defconfig
Message-ID: <20250505134843.GK1261075@bill-the-cat>
References: <20250502113556.134731-1-brunosampaioleite@gmail.com>
 <20250502144031.GT1261075@bill-the-cat> <87frhj5r32.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0w2XIOz0m4BimKTO"
Content-Disposition: inline
In-Reply-To: <87frhj5r32.fsf@prevas.dk>
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


--0w2XIOz0m4BimKTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 11:45:05AM +0200, Rasmus Villemoes wrote:
> On Fri, May 02 2025, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Fri, May 02, 2025 at 01:34:33PM +0200, Bruno Leite wrote:
> >
> >> From: Bruno Leite <brule@prevas.dk>
> >>=20
> >>=20
> >> Currently rpi5 uses a generic rpi_arm64_defconfig file that builds rpi4
> >> devicetree. Add a defconfig that is specific to the rpi5 building the
> >> now available upstream dts for that board. The defconfig makes use of
> >> defconfig including that is now available and only changes the DTS
> >> related config.
> >>=20
> >> It is also necessary to add a more specific u-boot.dtsi to rpi5, since
> >> due to the ARCH_BCM283X config it will try to build the
> >> bcm283x-u-boot.dtsi and break.
> >
> > My question is, can we not adjust rpi_arm64_defconfig to be generic
> > enough and not have a problem on Pi 5 due to the default device tree?
>=20
> Not really.
>=20
> What we want is to have CONFIG_DEFAULT_DEVICE_TREE to point at the
> rpi5's .dts file, because we really want to build that and not some
> "random" dts file that doesn't have anything to do with the hardware. I
> know that kinda works for the setups where the .dtb built in U-Boot is
> not used for anything, but in our case, we really do want to use the
> .dtb from the U-Boot build - we inject various U-Boot specific stuff via
> the EXTRA_DTSI mechanism, e.g. public key for kernel verification.
>=20
> And due to CONFIG_SYS_SOC being bcm283x, and bcm283x-u-boot.dtsi
> referencing nodes that simply don't exist when building
> bcm2712-rpi-5-b.dts, the build breaks.
>=20
> Perhaps the real problem is CONFIG_SYS_SOC being bcm283x for rpi5? I
> don't really know why rpi4 is both bcm2711 and bcm2835 and what the
> difference is, but rpi5 only seems to include a bcm2712.dtsi which does
> not include further dtsi files.
>=20
> If rpi5 has nothing to do with bcm283x, then perhaps a better approach
> is to ensure that CONFIG_SYS_SOC is bcm2712 when building for
> rpi5. Something like adding a CONFIG_TARGET_RPI_5 choice and adding a
> 'default "bcm2712" if TARGET_RPI_5' ?

OK, so I guess my next question is, is rpi_arm64 useful enough in the
end for Pi 3 and Pi 4? I would have expected that it doesn't matter what
tree we build in to U-Boot as we would be using the one passed to us by
the prior stage firmware, and then update that at run-time as needed.

--=20
Tom

--0w2XIOz0m4BimKTO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgYwbsACgkQFHw5/5Y0
tywt9gv9EY46Gmsfq/6jfIwR8nKY2xxRRPQZvdx/DiByptwCrlR/wdYCIpmuanbw
GY9JDFdCNp3RuiZiANaVwvOcNTaAIjMWKY+oU7FjJU/E/nBK35+2sB3xFqH1N6bp
YnrT5bG+zxpHnqCFyTnOGRu0kc7LmmrFEYCI/tAnhW9P9PiSVKYkSlSLaOo9qGvR
oyA0AfLVrIkv6sp4leQFsyksGS3H1f8Pscb+PRofmakSxEuE3Eu1DAxCuVubdjan
6oHfBEwtZCLmPd2MQMuNWp9cKazCLbOoAXGCqzeOrr5tb0goZzny2j0Tamg2Abi7
GCpv1oqCmZF4tpRtbyTNoUB1TbMua1ROLrnGWY2wg8EGiNTssfxSdMlaFZw4wT0p
bxEGJiA/VFeF32H0HxguJwRsBksqivtPIGCZmZRXF0mRRQvvHrG9J3dfk2ir9mfi
50sLunCGqWJFgjwqlTkYL9doiJhjuVFVtTRFxuGKvlvvJh53DULteGoQJDYhtISU
L9SGG1qe
=GfWY
-----END PGP SIGNATURE-----

--0w2XIOz0m4BimKTO--
