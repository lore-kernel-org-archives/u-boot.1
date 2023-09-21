Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223C0E7D0A2
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 19:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 348F886482;
	Thu, 21 Sep 2023 21:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lZBnvbQC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A46A3864DD; Thu, 21 Sep 2023 21:56:16 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 631F386405
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 21:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d85800eb234so1613717276.0
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 12:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695326173; x=1695930973; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tF37pbJ2NH2qpdJUeiH7TpkiYviDxeAVik4KHIqRCg4=;
 b=lZBnvbQCBgJhQRBogs0AIeGYLehzZiactWnZZAa6bY/Np1rl41kK33zFfODv/Vd+Li
 Af5TIHuntxvm2owUQpqfZP8DzhmPUnV4VJNLtZ5MkVTK0+o62RM//ScF112kShviXcfk
 XwdpKKuFXF6xkKqf3VBEqTM5wR+exXfEsNkqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695326173; x=1695930973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tF37pbJ2NH2qpdJUeiH7TpkiYviDxeAVik4KHIqRCg4=;
 b=kBMa4ZfcOAvfcp80aA8q7TaBpZhPcYXA6PKmW+mLb6ZrFJbsnYqlI7AOcKdxtw3kT+
 FPbbhi/vpJwVmtKxZ5JhFMvKvmUrnXGTRnAmDHW28Y0DaEqVhTfo+dO+3bWYEcsn1deL
 IuyCy3OYVcxPBjGSfgB9rorrm4zaMMYbX4YzbIyxhah7zvej9BgOHqXGhjw9LqK7BPzf
 Y6wdh6Q6N2ujqHMiwPw2WVjSGJ0uU9CHB8DX9Nniwl84pW4bN6rzxQInX/GVUAkGIuel
 f3frm+WLpKml0BtuyPEHYfuy6d7bF8r2qnUmB/flGBvbe7dqZCJPiAyH3e/vdD3HorL/
 kIbg==
X-Gm-Message-State: AOJu0Yx60OQAgP6Pe9KXLHJPZyNn0ujKDgwMokD0lgH57YfdgURdVbNC
 fQ99ataurnbU7PjydDwDwqRvL4F9nmnWhph/UAJVnA==
X-Google-Smtp-Source: AGHT+IGmj0JFrln5Evc1S/0f4RA2z7Wr3uqfnhRZPmBA9U9BDpyo9I0MJN7MjSyYzj1V/JgrW8dRaQ==
X-Received: by 2002:a25:8481:0:b0:d85:eb7b:5c74 with SMTP id
 v1-20020a258481000000b00d85eb7b5c74mr2555758ybk.31.1695326173070; 
 Thu, 21 Sep 2023 12:56:13 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-46ac-83a0-07b5-e9a6.res6.spectrum.com.
 [2603:6081:7b00:6400:46ac:83a0:7b5:e9a6])
 by smtp.gmail.com with ESMTPSA id
 4-20020a250d04000000b00d8128f9a46bsm505678ybn.37.2023.09.21.12.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 12:56:12 -0700 (PDT)
Date: Thu, 21 Sep 2023 15:56:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [PULL] u-boot-riscv/next
Message-ID: <20230921195610.GW305624@bill-the-cat>
References: <ZQucTuzK1hvN9NMl@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="REKrcEiVNGoBP88Z"
Content-Disposition: inline
In-Reply-To: <ZQucTuzK1hvN9NMl@swlinux02>
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


--REKrcEiVNGoBP88Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 09:28:46AM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit c58ee1c9946a1550b1f6fee2b25da9ecc89baf=
71:
>=20
>   Merge branch '2023-09-19-tidy-up-some-kconfig-options' into next (2023-=
09-19 17:44:18 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
>=20
> for you to fetch changes up to 90602e779d3ae3bd02faae0eb40b4fcefec419f7:
>=20
>   riscv: dts: starfive: generate u-boot-spl.bin.normal.out (2023-09-20 21=
:05:16 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/17779

Applied to u-boot/next, thanks!

--=20
Tom

--REKrcEiVNGoBP88Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUMn8EACgkQFHw5/5Y0
tyyVIwv/RETIFOYioLGUcIPiMPKayha/fcBmTR0LLGAkNCasxCcFd0ZWSMnfO0rb
Ooyx2wlj6dpkHvBZFotEwD8VKAokeRg9LDCfc81XwRV4V7Fw0nh/qflivZ3rJ4V4
tPJgJVztqGFUUnJgBFz9jglRiKg0xE3bvLHX+iPjShHOg3FBaJLeSem30F1bDzKA
k01Og73Lo91dNgISxJTJX1WxsX/fU1q+jcAceVvuqoISlV6mscJWsKUw5O8fWgxa
W+Nr/09KlUtj2jKtZHA8gWCCBgYF/4RfOwTYmrBmubjIIVg1HW6v86G0zTkK+8Fp
4i14O4TYFl+Wxvsv+MX6znEi+ED81eT9GPgzfOuRSbl0x0NdHUdYqhq/bmKgEg7B
73/AZtknfXd5lT6RpFOHRgB9c8IiBDDpnN1BZ+RRyPFv40GdIzelimJl35gxhhy4
0ptd9/sWjXVjz4o6EztOxPhbrlrcCIniqSEs97Ms8SFzJd9V/dDTGEci7MACGQrp
Sg6m6o/c
=d0rA
-----END PGP SIGNATURE-----

--REKrcEiVNGoBP88Z--
