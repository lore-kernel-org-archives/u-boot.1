Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345DCC52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 18:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 466098882F;
	Tue,  6 Aug 2024 20:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pvo9B6Au";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 764CE8882F; Tue,  6 Aug 2024 20:43:20 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B951885D1
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 20:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3db1657c0fdso606471b6e.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 11:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722969793; x=1723574593; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JArR2yQOZWtc6vxUgeCrolCu9ejWxpad3Heh3R3wDjI=;
 b=Pvo9B6Auza/bFeQ0fjnAKOWF5qPl4M6Jjnn4gXuduMN6IkRiERpqYvHnbFcTQGLkDs
 B4mgCzH9mSdaZ5MojHuE3uutqmbjgHqkndO6aKYXsXPW7oQT+ke/m3E0We9wSMhj5Tdh
 f3bVFOSFwJiOgplLA1eJTgKNhkOkJJ1xO7/r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722969793; x=1723574593;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JArR2yQOZWtc6vxUgeCrolCu9ejWxpad3Heh3R3wDjI=;
 b=c2GP1oZMQFzv2FtEHeCHvj33GoVGUn+MyhMRm0Qa3Xk2ChhTUqEFs02ncI1v16VSfZ
 6OqLx74grLtpMkU3QL7uG0XvFOim9D0C3WTjqv1UYjkIfzRZnaDTTMiLXJT3P/2nLy/z
 tr/gpgHJ5r4lP9hn4n5GGFSvho1kPzzdRUSF4CdRNDFIUp1fdkrXZjcMSPMu4/s5UmFh
 5KfFAkYPUDfhvKDhQJqrcjljuYb/OryJUAkb2imWJfq+o76BCuiXcSYnjcfdF/hqsdIp
 z7eX0rOBDz0VABkwj4pELqzXegKpkmONv4dX2FUPevqRlWNZ35qeU8Sl2YLWwF0qKr9L
 YIzg==
X-Gm-Message-State: AOJu0YzZjVELFMq08+4vDoquPAouGs75AIup3FDo4Jgbtzq4uIOtCHYJ
 JXx9Gw2wr3XEu5zakVXnQyTUxwokTo5e5kuPE/7icAO5O0XY/NjORWU0HW6Dm9Q=
X-Google-Smtp-Source: AGHT+IGH4z1NFL+5pj35HuwxeXjCkiXtwaP8ZeBC5PcUbgMwr+Vk0UtWH6ALxKlaaEqbx5rNs+/40w==
X-Received: by 2002:a05:6808:18a5:b0:3da:b36c:c702 with SMTP id
 5614622812f47-3db5583b1f1mr20397838b6e.46.1722969792904; 
 Tue, 06 Aug 2024 11:43:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db56361a1esm3609750b6e.7.2024.08.06.11.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 11:43:12 -0700 (PDT)
Date: Tue, 6 Aug 2024 12:43:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Michael Walle <mwalle@kernel.org>, linux-sunxi@lists.linux.dev
Subject: Re: Pull request: u-boot-sunxi/master for v2024.10
Message-ID: <20240806184303.GB1626301@bill-the-cat>
References: <20240806143823.1438437-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nmCHRswCGQ601//L"
Content-Disposition: inline
In-Reply-To: <20240806143823.1438437-1-andre.przywara@arm.com>
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


--nmCHRswCGQ601//L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 03:38:23PM +0100, Andre Przywara wrote:

> Hi Tom,
>=20
> please pull the sunxi/master branch, containing some more changes for
> 2024.10.
> This updates the "old style" DTs to that of Linux v6.10, matching what
> OF_UPSTREAM is at now. Hopefully we won't need to do this (manually)
> anymore. Since this brings in the DT for a new board (Tanix TX1), also
> add the defconfig for that, which has just been waiting for that sync.
> There are three more fixes: two for the SPI clock setup, which avoids
> too high frequencies in some cases, and one fix to avoid a build warning
> with GCC 14 for the sunxi TOC0 part of the mkimage tool.
>=20
> The gitlab CI passed, and I tested the SPI flash on the OrangePi Zero 3
> and also booted that into Linux.
>=20
> Please pull!
>=20
> Cheers,
> Andre
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The following changes since commit 6becf9ba1ab82af6f4fcf9f4d0da38f9c75212=
d2:
>=20
>   Merge tag 'u-boot-imx-master-20240802' of https://gitlab.denx.de/u-boot=
/custodians/u-boot-imx (2024-08-02 14:40:59 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master
>=20
> for you to fetch changes up to 541a1649e74787682902d820d0b79e16bad69a4f:
>=20
>   spi: sunxi: fix clock divider calculation for max frequency setting (20=
24-08-06 11:20:10 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--nmCHRswCGQ601//L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaybrQACgkQFHw5/5Y0
tyx22QwAqbxB5nk3vf8GsIGlcujGfqOlUeEuDcjIDhgGuvMLKAiKIjAR6o60qXg7
uUL/mNQ9KOnQrTcvHtWB7vGQMA4hurHe7UtiSfu4L+AsCvboa7XdzTiYwGJtFauc
sUm4aCNl3ftPZ9BKuRtNPaWOchunniMHuTQf4XZCgFlLXmTcMTv925YsbNQ6UAoy
xYdq+X3NrK1RwqcMfbFck1s5MIAFs6KdFWcR+gVg9I2GeBFWRfDG+PeRobwl5aDE
7TZpIeiEtjcfnGlc5WqDRhhufwd5uvTAGzEJqLqGZVSUrfUQ5CBXdudgL1slSrSg
72FSQfM1+UE4wdMs8YWCa2pPG5RQf4C2y03krsiTlZ24hpz8ZkmEXwaX5NWv17zZ
FvZFCK0abgAbFUYhp+XU0AdlRVFut97avdPdDPQoCsUj8XhWLnEwaV8gZwRAQ66p
QpC+Tp6l+s0YfkYup4NEAys0YF0W5O+uQTq5309NpsdoIE3azKuvwfhcimm+W0y0
OyXEe+J9
=Gw/+
-----END PGP SIGNATURE-----

--nmCHRswCGQ601//L--
