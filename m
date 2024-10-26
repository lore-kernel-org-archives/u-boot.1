Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A95D10BE3
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 03:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB23A88E5C;
	Sat, 26 Oct 2024 05:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HySl1eyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F344488E5C; Sat, 26 Oct 2024 05:37:03 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6184988DF8
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 05:36:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cbd00dd21cso15875536d6.3
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 20:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729913817; x=1730518617; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d7TkDZ9VC/B7EISXCuZyymGPYljtq0MBiEK4XmBBB0E=;
 b=HySl1eyBSVv7aRUMydEK2TCUX9SrhKU8eGoa8j2m7lXsv89kHwqV+M9UUkmzKyORJD
 PNPxDLEseOO4HGzTxYxnR8xyk/W/Ki2jQQc3zPdFNZdgi+cK/zK52aZyGLApsESrMdfZ
 d9qVMfgNTcZpVvJNYXYvAdlf/TFHRvzhv+fFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729913817; x=1730518617;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7TkDZ9VC/B7EISXCuZyymGPYljtq0MBiEK4XmBBB0E=;
 b=m7uJ68XIQJXCc6kF1HLwqpN8hhWli/y+JJn/V1NfezIUDvHhtgtLKVxvUq6/3a0iZF
 aIiNF8f2BVaPN0nEtfoasOlLCPuKme+tNGIW4NdEqjUO2yCR6gdog+suzqbaOkpTost5
 Q140hbgtEu1ORzwqcX+jA/d6+o954GWds6l52U9LM19qlH5T6ULPVTcu0J5SbRVj/CgP
 AooO50Qvylw4MEMPrRv5quOx9GdeW2BzkGt96KTjomGS/wvPPhz3KpFLp6nOx7dp5Oq8
 7BEYpuB77zcMHcN3CnKlINy+cVzpqfxDn6KeqCWEb8tKwQ60WJFwopW2J3AWA23BLpaJ
 Swmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtgbGKCBacCPR6Kevb/1wvphNGAzl6Ha3dnDxUjXOOh5Qw1IWZIy3RWDGfbVGUCxA77iBtpRk=@lists.denx.de
X-Gm-Message-State: AOJu0YzgVZm+OfOVF3zGTtpx2Z6U1aoSx/7xVmr3RqtbyjDk5ywQrpJl
 qgpuB9N0yghjU7YqSXzO1aXNvSiZvxdskXdziHFMNshpi6nKw5E2lBa1cfGzvNs=
X-Google-Smtp-Source: AGHT+IFTWHmv9WbvLTIHUqE4Ca+RBIKal5H1H9LMObsFYnBXgRwrT/Eqh8UNk+4F0Ki5c7zA4rVOlQ==
X-Received: by 2002:a05:6214:498b:b0:6c7:50bf:a443 with SMTP id
 6a1803df08f44-6d185840a0dmr25743126d6.30.1729913817147; 
 Fri, 25 Oct 2024 20:36:57 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d179a5576fsm11763936d6.134.2024.10.25.20.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 20:36:56 -0700 (PDT)
Date: Fri, 25 Oct 2024 21:36:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org, ukleinek@debian.org
Subject: Re: [PATCH v2 18/18] board: rockchip: add support for Qnap TS433
 devices
Message-ID: <20241026033653.GE4959@bill-the-cat>
References: <20241013192424.84280-1-heiko@sntech.de>
 <20241013192424.84280-19-heiko@sntech.de>
 <630cc98f-c6df-4773-a9b0-efe7b4d3b9e4@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+9NS6+x+57tfMcMI"
Content-Disposition: inline
In-Reply-To: <630cc98f-c6df-4773-a9b0-efe7b4d3b9e4@rock-chips.com>
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


--+9NS6+x+57tfMcMI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 10:44:59AM +0800, Kever Yang wrote:
> Hi Heiko,
>=20
> On 2024/10/14 03:24, Heiko Stuebner wrote:
> > The Qnap TS433 is a 4-bay NAS based around the RK3568.
> >=20
> > Two SATA bays are connected to the RK3568's own SATA controllers while
> > the other two are connected to a JMicron SATA controller living on the
> > PCIe bus.
> >=20
> > It provides one 2.5Gb and one 1Gb ethernet port as well as 3 usb ports.
> >=20
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >   arch/arm/dts/rk3568-qnap-ts433-u-boot.dtsi |  6 ++
> >   arch/arm/mach-rockchip/rk3568/Kconfig      | 14 ++++
> >   board/qnap/ts433/Kconfig                   | 12 +++
> >   board/qnap/ts433/MAINTAINERS               |  8 ++
> >   configs/qnap-ts433-rk3568_defconfig        | 86 ++++++++++++++++++++
> >   doc/board/qnap/index.rst                   |  9 +++
> >   doc/board/qnap/ts433.rst                   | 91 ++++++++++++++++++++++
>=20
> I got a CI build fail for the doc check:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/jobs/929791
>=20
> checking consistency... failed
> Warning, treated as error:
> /builds/u-boot/custodians/u-boot-rockchip/doc/board/qnap/index.rst:docume=
nt
> isn't included in any toctree
> make[1]: *** [doc/Makefile:70: htmldocs] Error 2
> make: *** [Makefile:2445: htmldocs] Error 2
>=20
>=20
> Hi Tom,
>=20
> =A0=A0=A0 Do you have any suggestion for this kind of error?

Hey, yes, "qnap/index" needs to be listed in doc/board/index.rst

--=20
Tom

--+9NS6+x+57tfMcMI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmccY9EACgkQFHw5/5Y0
tyyf5wv9GXxdXanSHHQON/s0eXI1xE4yXpHDqlOalXOmncZxIv81njj+bWHINrkB
M9Vs+i8Djrr7mzscu2gezvlVpdQ5WB6Mzp53OVEyFk0IA14BNRJOFaahNHf5u4OW
cdM7lu7LykcRS5Wv3CxoLyP848PMJerH3qQcIIwm0+2KE10XL6pp3jnBMuPu/2ic
c4qQDmb1Qcf3dupITuKkLOUIYdq3zSPoAA/q9cxgG8sCJ26Vv1W2stCGyXEiJmLC
i1zViCjLWl/avdbzOAQzXJFrdXqIhYw72xWKdL317B2Lg9aM0RGvx1A2QtA6iiq3
wyt+oe2bzXj2IHdPYMhNydzvhTvGcdO6ObbveqpyWBibVmLihUDjj2cOpLE8IYeu
NiWBaxruJIHY/EO5oSiCQynm1XLjx1ErhD290EyyDYCDWmazDYQIYkRNNKsHDbNz
ERKpRlscWcdRgqe0fxyzSBBrpcKAmrlHDjMBkOs6s1Nr81NyDPzZuu3yz3Qa1D4G
rv2aH2HE
=HFH2
-----END PGP SIGNATURE-----

--+9NS6+x+57tfMcMI--
