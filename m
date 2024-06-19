Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB6EC27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 15:07:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC5B387F5C;
	Wed, 19 Jun 2024 17:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cv8RgD5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB138836D; Wed, 19 Jun 2024 17:07:50 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD7787F19
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 17:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2598001aae7so842020fac.2
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 08:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718809667; x=1719414467; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X/OxpNiSjQgGukq18syEyhtvrIe1ebw17Cs66URyp0Y=;
 b=Cv8RgD5DCh2Yf5As7DMUbPssap0Jj/Wn0Bq+EmfZCYMlZxaEhYD1L4nTWJN6yHj60d
 H8uAChvQ54V0y5pTN0hCe2JjVMwMo/yxOnq7ebFf0Y5xBeu/BXe1xFBIooQsU8C/eAHL
 BKhy+hru+5yYjhzPf2nqevzP04+Mt54U5NZ98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718809667; x=1719414467;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X/OxpNiSjQgGukq18syEyhtvrIe1ebw17Cs66URyp0Y=;
 b=BlvcGN5pu+SE9Omdb6nVT9V4UEeuR+jQ7ugYNYswNyQRW8gFVFWgPVRJRtJakmy1Ya
 LhsQ8TIjGaDmvw4V4LKELL2fLbljdRxJirc0m0cEfi6hVKAk4T0IURVa+ULmAuOpkQPR
 MwSAGXH4EKAm9+ZbzAHx6kJsXY3WyHZGn3DdMEGqwCsjlo8GLqqrXMgDd50nzCKizK51
 c87UAE0N5TgmtGmBfFA9pPoF9LFlFNR/ZgmfPVy4/5Nts/OWRZoovXAOfUw/bEq6J7Yf
 H/XU8Q4Z8JOWD3wEjZj76mXp5cWjOY0xiuhYHXzm79aJ1ZfOTO8w5WDvq6ayROrHXKcb
 IOLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDFQM1cFdOBJpyFyYl4cBA0oDErCam0+uJXMl1d6E7Mt3okqY2OPwH3tY35KKFg9TiC9AC4LPWvWoS6bQZj5z0HKsDoA==
X-Gm-Message-State: AOJu0Yxk8mzmsEPwDMnixPJN2vuSH6BPS5pAs/scvR7ay6Vg0Mwo0dkl
 N3PuVnIsJIgnjvCDyKrRyVw65KlG9HdGNxd7qr6xJTcyNpzhp21wrAo3Aks+Z3M=
X-Google-Smtp-Source: AGHT+IFfddxX44uH21qh6MogQ49Qu7amdN7VCUGe3nlaK6tMxbn9YyBVZolUgEEiHCZyGwxoutGAew==
X-Received: by 2002:a05:6870:e0cd:b0:254:b7d9:2de3 with SMTP id
 586e51a60fabf-25c94a0e2e9mr3259996fac.33.1718809667079; 
 Wed, 19 Jun 2024 08:07:47 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cb083ca27sm59417fac.36.2024.06.19.08.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 08:07:46 -0700 (PDT)
Date: Wed, 19 Jun 2024 09:07:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH v4 00/14] Introduce the lwIP network stack
Message-ID: <20240619150744.GA68077@bill-the-cat>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <20240618202123.GW68077@bill-the-cat>
 <CAC_iWjJt=ie4jD2yUbCNXU-WEGUmvo_GToCwfWsOTWot3+r8Vg@mail.gmail.com>
 <e43d7a84-0348-4655-80d8-f91b9232bdbe@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Sj1eneIBGrSuBCS3"
Content-Disposition: inline
In-Reply-To: <e43d7a84-0348-4655-80d8-f91b9232bdbe@linaro.org>
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


--Sj1eneIBGrSuBCS3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 04:47:08PM +0200, Jerome Forissier wrote:
>=20
>=20
> On 6/19/24 09:24, Ilias Apalodimas wrote:
> > Hi Tom
> >=20
> > On Tue, 18 Jun 2024 at 23:21, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Mon, Jun 17, 2024 at 05:32:52PM +0200, Jerome Forissier wrote:
> >>
> >>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lw=
ip
> >>> library for the network stack" [1]. The goal is to introduce the lwIP=
 TCP/IP
> >>> stack [2] [3] as an alternative to the current implementation in net/,
> >>> selectable with Kconfig, and ultimately keep only lwIP if possible. S=
ome
> >>> reasons for doing so are:
> >>> - Make the support of HTTPS in the wget command easier. Javier T. (CC=
'd)
> >>> has some additional lwIP and Mbed TLS patches to do so. With that it
> >>> becomes possible to fetch and launch a distro installer such as Debian
> >>> etc. using a secure, authenticated connection directly from the U-Boot
> >>> shell. Several use cases:
> >>>   * Authentication: prevent MITM attack (third party replacing the
> >>> binary with a different one)
> >>>   * Confidentiality: prevent third parties from grabbing a copy of the
> >>> image as it is being downloaded
> >>>   * Allow connection to servers that do not support plain HTTP anymore
> >>> (this is becoming more and more common on the Internet these days)
> >>> - Possibly benefit from additional features implemented in lwIP
> >>> - Less code to maintain in U-Boot
> >>
> >> So, on a Pi 3 (rpi_3_defconfig) I see this now (and it passes normally=
):
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> ___________________________________ test_efi_helloworld_net __________=
_________________________
> >> test/py/tests/test_efi_loader.py:163: in test_efi_helloworld_net
> >>     assert expected_text in output
> >> E   AssertionError: assert 'Hello, world' in 'No UEFI binary known at =
200000'
> >> ------------------------------------ Captured stdout call ------------=
-------------------------
> >> U-Boot> tftpboot 200000 EFI/arm64/helloworld.efi
> >> Using smsc95xx_eth device
> >> TFTP from server 192.168.1.10; our IP address is 192.168.1.100
> >> Filename 'EFI/arm64/helloworld.efi'.
> >> Load address: 0x200000
> >> Loading:
> >> Bytes transferred =3D 4528 (11b0 hex)
> >> U-Boot> U-Boot> crc32 200000 $filesize
> >> CRC32 for 00200000 ... 002011af =3D=3D> 2b466005
> >> U-Boot> U-Boot> bootefi 200000
> >> No UEFI binary known at 200000
> >> U-Boot>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >> If I disable that test, it moves on to failing the same exact way for
> >> grub. If I disable the grub test too. After that, oh, a bunch of other
> >> tests get skipped because CMD_NET and similar aren't enabled now, and
> >> the tests are wrong. I'll post that as another patch by itself. After
> >> correcting for that, we're seemingly noticeably slower as I need to
> >> increase the timeout for tftp'ing my 83MiB FIT image I use for kernel
> >> testing. We no longer have the estimated speed message, so I can't as
> >> easily say how much slower it is. After increasing the timeout, the
> >> kernel boot test does work.
> >>
> >> I can note that normally it takes ~18ms to get a dhcp reply, but with
> >> lwIP it's now 132ms, and previously the kernel loaded at 2.7MiB/s
> >> (which, not great) but if that has a similar level of slowdown, could
> >> well explain it.
> >>
> >=20
> > Thanks for taking the time. We'll run the pytests before v5. That
> > being said, my wget tests were faster with lwIP last time I checked.
>=20
> The reason for the slower TFTP is the block size. lwIP supports only the
> default (512 bytes), while the legacy stack supports the 'blksize' option
> and sets CONFIG_TFTP_BLOCKSIZE=3D1468 by default.

Ouch. Can we ask if upstream is agreeable to making that configurable
some way, and then we utilize that? I'm not looking forward to lots of
performance hit reports.

But please note that my dhcp request/reply is also taking 10x as long,
and in v3 it wasn't working at all? I feel like there's possibly another
issue lurking here.

--=20
Tom

--Sj1eneIBGrSuBCS3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZy9DUACgkQFHw5/5Y0
tyzfDQv/TfySMMYLxZqZ2aNnvunXs/Lb+xZcO2Ew1D59/tMKc8MbLe/doV20VT7H
GN2dOPQqMC58V7WVJhK8vfL/DgjBDF/5X3daqodJ0MdwYC3kUQz83SYqttqs9GL7
JCMM9L3twJa6sx8/InIXVFdWR9eWQ6MN3DQK5gLtulyg8ZJIfkzRwiTEsdcmDsxa
ecmNnAGWu+BxrFJk8fCx7tJ8j07qw0wEObSEzayh7NOCYZnauUgoRw3scXxVNABT
+wgtodcnCcBEQfRroKVMhkCpT+WGd3SyTgW6qt1Bdd01Krkfo0RCz1fwfnpz6fm+
z749wSQcPoDebHz5U0CX5Sta6PlbPNCpVr0+4sBefmDaY2jSv9xInkiz6IAnwjnA
ZmN+nIb318LQHmj5uyrLRiFF4SexAxkqZmDaBqw8jWud9E+dh011NeLWIRX6Z59K
Irs8yLlJyBEYN4ZsTIGFmwfADaLvYfQoB5Mn0sdkEo2qR88GN4CHkwPetVP7VrHe
A+DNqxTN
=ivaA
-----END PGP SIGNATURE-----

--Sj1eneIBGrSuBCS3--
