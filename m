Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89B9CCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 16:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33D288331F;
	Mon,  3 Nov 2025 17:19:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JNCR7Ms+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32D5F836D1; Mon,  3 Nov 2025 17:19:12 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84ED280050
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 17:19:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3d357d115dfso3183556fac.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 08:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762186748; x=1762791548; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rTGwV5gwRaZvJDkh5M2zRvywOKd1SsGfUgmXw8FqjXY=;
 b=JNCR7Ms+oS9L5aDb+JiTTmEwMSqasItTv1tgY1mEUUbYG39D/ERd0sG+CsFfYcC9Ys
 j476RltpTW3r7Us1F+iqBiR5fHBEQuCXxp5h5Kcmn+17aHHBjGrxw9baZtvxnEgyO1Er
 jP5DoOnuiVe4etnKPiHQW9KXcM9+qFWX+dWDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762186748; x=1762791548;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTGwV5gwRaZvJDkh5M2zRvywOKd1SsGfUgmXw8FqjXY=;
 b=LoNgVPABSZE5mQzRZ2ppNmvghazLKG0rqPlvWmAChCL9e57N6NSIkgU8ugY5CRKCNs
 UrJuHHV4SFzjNsq6O9A7PjebJ5WG9kt6wflSpPXwO4GE6Q/8UyOC4xHgO+Bsq2VpnMxB
 IAMANe0hoBQW3MCtzebX1Np7sxIyxYrkjC/OE967mJv51UTSDxj825C2UH/7hyCXTKuV
 2OhcNe3rPUN17EB2A53D6tvVUgjIQnQjrC+zi5mFRCbvdl/Mj7xtN9O+MArerhVlOB+r
 izq9/mzQUdWAF9CDMdn13S3COPC1ZcQI/+s7xAA6COJVuvhDlgq46OqWOXmvQ7l8eg45
 +R3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2cjz2dzrEmwZtfUoZYRlsSD98wBmKmOtfRSxDdI7iMQclJK5wEdEcCNdDbEQRfjGAdZFLD0c=@lists.denx.de
X-Gm-Message-State: AOJu0Yyd9YXRjnVVH7+ro7HtyLSjKgdq2tj5TyuXbEWw08Dmx996B2cC
 jdFMRv/wvdfHWmajTyLhy0JsSMrFrAYgaf6MP42hVGv0YFx7uqgt+p+wL9roCIoITGVP0m2kzga
 Oy/nZsFWOWQ==
X-Gm-Gg: ASbGncuXES8LKixy5L3qRUG1W8wxde1GAWo3fx7fOdY60xePStl65l2QD8nw59xr/c6
 2LsWF05k8uQrh8QFyF967Cu8888ocidSnZkQaiJ4KPZ/wv+tcND4aqXut64V2rNegPNWleJ8nb1
 /NPgm5DQQ2VKv4E2wBi2Jl9ytY7+BDXVnHcl/MGVmxeOd9U063gNPNUGTS3ClfAf7+Hw3fkJdDM
 sdqmH37OsqWv9YSJtfcmqqbREOpzmzRNdYEk5rPqJ7MoNWMAhnkQWGMe9C2owRZtmpjzyHu04h0
 kUG+YtMf/ZYomNlmNCXHdZeODy54+gZRdnogPqJWQn6d8X6XHAxPu9Y+VG/AI5ivSaqKTSfKAnA
 wzCMWciHpevUn7yg+EEvakyXIZbMXgJwPMkChtjVokJKO/x30ahZWy++ynFtOG0DMoMb3kcGTRo
 hv5ht0541/9cti5A99G9mOGje4qXS2bYqrQjTHwxI=
X-Google-Smtp-Source: AGHT+IElbKkRGCP+/AdFW2dZyhKyaoy25k896YNlRr+orFP7U7dj6Nd+P+bNN1R6XIkS1NpvCtMjjg==
X-Received: by 2002:a05:6870:1694:b0:3d4:3658:edf6 with SMTP id
 586e51a60fabf-3dacc1c39d6mr5173292fac.18.1762186748111; 
 Mon, 03 Nov 2025 08:19:08 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3dff73616b8sm178043fac.16.2025.11.03.08.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:19:07 -0800 (PST)
Date: Mon, 3 Nov 2025 10:19:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "Bajjuri, Praneeth" <praneeth@ti.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/2] distro_bootcmd: Add support for customizable
 find_distro_rootpart
Message-ID: <20251103161905.GP6688@bill-the-cat>
References: <20251031-feature_distro_rootpart-v1-0-4e7c465708e8@bootlin.com>
 <20251031-feature_distro_rootpart-v1-1-4e7c465708e8@bootlin.com>
 <CAFLszTicHdtY73+asYQ9NF_uEFg7BsSfN2cW+21FbQoxH9V_JA@mail.gmail.com>
 <20251103115225.381126f1@kmaincent-XPS-13-7390>
 <20251103171630.4df1efdd@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZgCIyxUDohzo9mjB"
Content-Disposition: inline
In-Reply-To: <20251103171630.4df1efdd@kmaincent-XPS-13-7390>
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


--ZgCIyxUDohzo9mjB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2025 at 05:16:30PM +0100, Kory Maincent wrote:
> On Mon, 3 Nov 2025 11:52:25 +0100
> Kory Maincent <kory.maincent@bootlin.com> wrote:
>=20
> > On Sun, 2 Nov 2025 20:54:02 +0100
> > Simon Glass <sjg@chromium.org> wrote:
> >=20
> > > Hi Kory,
> > >=20
> > > On Fri, 31 Oct 2025 at 17:36, Kory Maincent (TI.com) < =20
> > > kory.maincent@bootlin.com> wrote:
> > > >
> > > > Commit d0ba0ca45a49 ("distro_bootcmd: Set distro_bootpart_uuid for =
block
> > > > devices") added support for the distro_boot_part_uuid environment v=
ariable
> > > > to allow using PARTUUID in the kernel command line.
> > > >
> > > > However, the way it was written only supports the case where the bo=
ot   =20
> > > files =20
> > > > and the rootfs are located in the same partition. There are many ca=
ses
> > > > where the boot partition and rootfs partition are separate.
> > > >
> > > > Add a customizable find_distro_rootpart command to allow each board=
 to
> > > > define its own logic for locating the rootfs partition. This provid=
es
> > > > flexibility for boards with custom partition layouts while maintain=
ing
> > > > backward compatibility for the default case where boot and rootfs s=
hare
> > > > the same partition.
> > > >
> > > > Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> > > > ---
> > > >  doc/develop/distro.rst          | 11 +++++++++++
> > > >  include/config_distro_bootcmd.h | 10 +++++++---
> > > >  2 files changed, 18 insertions(+), 3 deletions(-)
> > > >   =20
> > >=20
> > > How about moving to standard boot and look at this there? =20
> >=20
> > Ok, I will take a look at it.
>=20
> There is a custom nand boot target [1], and I have not any am335x board w=
ith
> nand memory to test it. I am afraid to break it during the update to boot=
std.
> Not sure we can accept that. What do you think?
>=20
> [1]https://elixir.bootlin.com/u-boot/v2025.10/source/include/configs/am33=
5x_evm.h#L27

I think we can risk it. I'd even be OK with not migrating that portion
and letting anyone still using those platforms, with NAND only, to just
use a custom boot command instead as I have strong doubts there's anyone
doing anything other than that currently.

--=20
Tom

--ZgCIyxUDohzo9mjB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQjV9AAKCRAr4qD1Cr/k
CrkcAQCfTex1gIpDlLremM6/oBQIGH846+v0OfJhPebC3iEC6wD/VISgvvv2x/cp
DvqFuReP/yBn5bkYdbt7UEaoSnDDKA0=
=eBiP
-----END PGP SIGNATURE-----

--ZgCIyxUDohzo9mjB--
