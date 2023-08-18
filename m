Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C59BC7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 16:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F10CD86EA6;
	Fri, 18 Aug 2023 18:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NH360mvF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56CE386E9A; Fri, 18 Aug 2023 18:49:50 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29DCF86E98
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 18:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-58cd9d9dbf5so15885897b3.0
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692377386; x=1692982186;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8HnPpy9JVZ7I/xJ9LHUQw4W58+BWUP1n48phwhn/PSI=;
 b=NH360mvFeogdRVXczgePGr4RZgQv+PGORTgM4/TEMD7JKxhfSQ6G+8tQixb7I0VHMU
 i6J4lKTPy8MEe1ZJ/51HjqWvOFslSDdCMC4znkVfM2ckjmCAJuOlkKUJs5UqmjQq5S0C
 oRo86RjmmXpNCfHJn+WHuTHDiFRHGAgP9FKhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692377386; x=1692982186;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8HnPpy9JVZ7I/xJ9LHUQw4W58+BWUP1n48phwhn/PSI=;
 b=AFQxJWYvWEsHc+jwYB/Qsr5GR1P3ugI32yIYZlWklw9qqwGs9AQ+ylDBdWwuDuUBz7
 v+MNWbBstG9Du91pzp0WvX1epIq1qMIlhw+f0eTx1JP1IIEb/BZ54W+a4EahsPzA9unL
 Yp+wOwEc6lLvKi4lHkdWkICdNPUqbN7L4p7CtezNkRofAoTHTm+d3p/QGIQCI9OfiSHw
 /qIqAjtADjJLTIgaqjZpRWMI4qB+usm6pbL4PbewvahPSDJqKjekGXUJL0kIjOvcgACH
 MU1olV+52ZEwQv4DiEvBcOR9OJjQLGuB5K8TFI+Ts5EI60lvhEciJXZNVTeQWrTG2zNY
 gW2w==
X-Gm-Message-State: AOJu0YyilTL+Ge3z23hKVn2isSOSh+qoAgiDzMOVEPDGQzx0/vwKokmy
 7dotdWurnCcBwM6lykQz3MuIeg==
X-Google-Smtp-Source: AGHT+IHOESz2Mqv+ORSYU4PI7O5zGFtIOQY5rQgJTBZFFF4mxF/DwpM9UGYmYJ68dzMEnF3l+jRHzg==
X-Received: by 2002:a0d:df4f:0:b0:58c:4dcf:78b6 with SMTP id
 i76-20020a0ddf4f000000b0058c4dcf78b6mr3339996ywe.21.1692377385814; 
 Fri, 18 Aug 2023 09:49:45 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a81c203000000b0054f9e7fed7asm596067ywc.137.2023.08.18.09.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 09:49:45 -0700 (PDT)
Date: Fri, 18 Aug 2023 12:49:43 -0400
From: Tom Rini <trini@konsulko.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] ARM: tegra: Changes for v2023.10-rc1
Message-ID: <20230818164943.GZ1515023@bill-the-cat>
References: <20230818133923.286332-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xJY/kL5cP7t1SAfg"
Content-Disposition: inline
In-Reply-To: <20230818133923.286332-1-thierry.reding@gmail.com>
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


--xJY/kL5cP7t1SAfg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 03:39:22PM +0200, Thierry Reding wrote:

> From: Thierry Reding <treding@nvidia.com>
>=20
> Hi Tom,
>=20
> The following changes since commit 68c07fc5fdf34f0926cf06fc0c4ebd6f2f3afe=
19:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2023-06-21 1=
4:42:50 -0400)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-tegra.git tags/tegra-for-20=
23.10-rc1

FYI, in your .git/config you can do:
	url =3D https://source.denx.de/u-boot/custodians/u-boot-tegra.git
	pushurl =3D git@source.denx.de:u-boot/custodians/u-boot-tegra.git

And this part looks "nicer".  Not a big deal, just an FYI.

> for you to fetch changes up to bdf9dead86f06c7d6980c399a4a6339430b531ec:
>=20
>   board: htc: endeavoru: add One X support (2023-06-30 15:20:37 +0200)
>=20
> This passes CI successfully:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tegra/-/pipelines/17411
>=20
> Thanks,
> Thierry
>=20
> ----------------------------------------------------------------
> ARM: tegra: Changes for v2023.10-rc1
>=20
> This adds support for various new Tegra30 boards (ASUS, LG and HTC) and
> has some other minor enhancements, such as enabling the poweroff command
> on several Tegra210 and Tegra186 boards.
>=20
> ----------------------------------------------------------------
> Jonas Schw=F6bel (1):
>       configs: tegra-common-post: make PXE and DHCP boot targets optional
>=20
> Svyatoslav Ryhel (6):
>       configs: tegra-common-post: add GPIO keyboard as STDIN device
>       ARM: tegra: add SoC UID calculation function
>       board: asus: transformer: add ASUS Transformer T30 family support
>       board: asus: grouper: add Google Nexus 7 (2012) support
>       board: lg: x3: add Optimus 4X HD and Optimus Vu support
>       board: htc: endeavoru: add One X support
>=20
> Thierry Reding (2):
>       ARM: tegra: Enable poweroff command on Jetson TX1 and Jetson Nano
>       ARM: tegra: Enable poweroff command on Jetson TX2
>=20
> Tomasz Maciej Nowak (1):
>       ARM: dts: trimslice: sync SPI node with Linux dts

Since I'm not sure if this is v8 or v9, given when v9 was posted, I've
applied this PR now, as I had said I wanted this in.  I do have two
requests for you Svyatoslav, however.  First, if there's changes that
are missing in master, please post those ASAP and we'll get them in, for
v2023.10.  Second, on Monday after I release -rc3 and merge that in to
next, in the next branch we allow for (and encourage!) config fragments
to be in the board directory rather than top-level configs/ directory.
Please make a patch on top of -next that moves the fragments and updates
the MAINTAINERS entries.  Thanks all!

--=20
Tom

--xJY/kL5cP7t1SAfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTfoSEACgkQFHw5/5Y0
tyzywwv/beBoD6YECkIelKvgI8fDNPkNUrcyQ6kgl+s/sg4jl/CHr6hfK6usLLF6
ZSiuKJyDG5lb8A0g50XInwR8afrM01pQHyGGiVWPuCo/TCejpm4R5FfBEr6c5u+t
vBVKHlQ61Ri5XaDKK/ZAA70gqpUi0cO5C7VcEGatArjpZ+NMUin/XbVScqRPG2bb
XezmaMF+8MAH58qRzv2qix7tNg9oI0Oj3j+37vtopMMxYI91MOYdcNOccXlrt+Wu
J+Ge6FvRv1RAdKVnMxaEsrBvAVfU5GQ7fdFuKKnysNof/iW6vsttz9ZWkgerBdC6
pQ18X3EpYmHnEluw5zOV3OU/sJWa3wNgxDIO0S9JmpJHNhndbaFSddy3dUI1uVAW
jOSzJ9eHqgl3ODw7O5cy4SP1qNk8Fm0AreK4fdPMfmbRjs7Az8pOeLZJsXLxN/At
SFPMJQO7fSWU4k/JrxGeHxJVT6JF5kQ1D+cXeBl4YO0HkwC5d22s+N7Kq/tqdNwf
EU7ZQfiC
=y/5j
-----END PGP SIGNATURE-----

--xJY/kL5cP7t1SAfg--
