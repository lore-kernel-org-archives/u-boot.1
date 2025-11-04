Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D078CCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 16:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3960D808AF;
	Tue,  4 Nov 2025 17:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lllII0U0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF9582A9E; Tue,  4 Nov 2025 17:38:23 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF5F08003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 17:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c6d13986f8so3168a34.0
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 08:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762274299; x=1762879099; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Kcif2oeaeD6ezpQrmi+BM1w6DzbKruDuCywLVyEvHWA=;
 b=lllII0U0JIUdxoTcDLGCeFlVZ9DbbJtWHkrU+jaVB/a2tgSurM7HJXdLcOfedfN4av
 83kkaKvzCzahY8Yix5QG6OfHqqxtmJuIc8NP1tQQQEWYu/hVdbqURTd/An58HWzpKwni
 7KYwluk92WPa6AlmNLTyewEGt6QX68v28Di8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762274299; x=1762879099;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kcif2oeaeD6ezpQrmi+BM1w6DzbKruDuCywLVyEvHWA=;
 b=Nv79ueCMA8eFS+Oz6/AyKF5gfQlKTAfPNxxCHNujGWpF4cJSxiuoIxJKWMmhKCWZHF
 4u291M5qoxGm7KNc7rXchJ84QUMwVZI2XsDvjZO86CjOJfjw+nKJvuhG5eFz9psQp+34
 kt15nJQA0vmkXxGxYGz+3HcR9pe3DCqK+ufrWAtIUJiFFN6/RUUA8+SwthQZQsi7RZrO
 4GXs+CdKGoGgx8i+d7KYZVT3i7lbVM/h+0U/rKrYiDPKLczH3WEKlzTL++NmkvwUjwjK
 MmMy8OERBJx7rI7rOUrsD0iibgfNwZWog35Hp5T+mWyiNXzuM4Pz8bq/75sUxrL9JW/x
 oY1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+cGR366XtF7lkM9v5wTTKM031F/diGbd7DOqD+/iRHW85BbC5Phigkv6D6eiRIMWPNx6kPzA=@lists.denx.de
X-Gm-Message-State: AOJu0YyoWrQetyzDkhMFpQD+/XeZodD0ceeHxUCqcMXMvZRx9OVJ2jOt
 oFONNuSabipzBV/eo/bq8+3pnM1A4+zmjOUo85BNOyiC9bPVIBTUf/LQIR9H9m9KWAI=
X-Gm-Gg: ASbGncsnOS0uDGVr9nc12+ftVEyqGiRiDdxgS4svsr5aOxDSQAkNhnFv+jiq2s+MUQn
 SEGbIYRxJNWpD2HCXUsySay3+lJbrPqGrfS39tVQmcCeaz/BP2ojADE4vsnqilqDRzUETSW+aT1
 0tTjQlRh921QUXfkCIA+SQtQB/ncpdRpuUA8af5G9Pg0t3zU7ErqqT3so/bAmcJ4o5R2x4qYDCJ
 HMN6lEbhWBbfiMOFXk95qcqGwboNG3RmWkA8BKbllYOXinFO2CS2pNLC54/vmYSNjxQJYs7f7+k
 nACrHZyoBUEXPASQe1Ihy9l8e1wiSzV9woY3jMQZo3HVC93FDtTFJWqVU7j7inky2UURvDCuJLl
 FPvly5g788q73rEl17vaDYHfxQzjO+RfVt2ddttz/Fh5sjOvvaRqBFlBIFMJ+Sf64q8TMQeprx2
 On6H9Xn6z4Yf4rRJc8riMYLjTdo5Wel8nttOtjq88=
X-Google-Smtp-Source: AGHT+IEqHiiUx+RXr0XI0HR1od6umgXunSjpDegHo4jJgtQ5pf5eaeh2hmqLDbhmrgCf3+OXBsaINA==
X-Received: by 2002:a05:6830:1e96:b0:7c6:cbd2:4b56 with SMTP id
 46e09a7af769-7c6cbd24d34mr699557a34.2.1762274299537; 
 Tue, 04 Nov 2025 08:38:19 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6cfb1b496sm152746a34.32.2025.11.04.08.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:38:18 -0800 (PST)
Date: Tue, 4 Nov 2025 10:38:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "Bajjuri, Praneeth" <praneeth@ti.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/2] distro_bootcmd: Add support for customizable
 find_distro_rootpart
Message-ID: <20251104163816.GB6688@bill-the-cat>
References: <20251031-feature_distro_rootpart-v1-0-4e7c465708e8@bootlin.com>
 <20251031-feature_distro_rootpart-v1-1-4e7c465708e8@bootlin.com>
 <CAFLszTicHdtY73+asYQ9NF_uEFg7BsSfN2cW+21FbQoxH9V_JA@mail.gmail.com>
 <20251103115225.381126f1@kmaincent-XPS-13-7390>
 <20251103171630.4df1efdd@kmaincent-XPS-13-7390>
 <20251103161905.GP6688@bill-the-cat>
 <20251104102916.3df33d55@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="87ZnRuxqPSxevaNC"
Content-Disposition: inline
In-Reply-To: <20251104102916.3df33d55@kmaincent-XPS-13-7390>
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


--87ZnRuxqPSxevaNC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 10:29:16AM +0100, Kory Maincent wrote:
> On Mon, 3 Nov 2025 10:19:05 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Mon, Nov 03, 2025 at 05:16:30PM +0100, Kory Maincent wrote:
> > > On Mon, 3 Nov 2025 11:52:25 +0100
> > > Kory Maincent <kory.maincent@bootlin.com> wrote:
> > >  =20
> > > > On Sun, 2 Nov 2025 20:54:02 +0100
> > > > Simon Glass <sjg@chromium.org> wrote:
> > > >  =20
> > > > > Hi Kory,
> > > > >=20
> > > > > On Fri, 31 Oct 2025 at 17:36, Kory Maincent (TI.com) <   =20
> > > > > kory.maincent@bootlin.com> wrote:
> > > > > >
> > > > > > Commit d0ba0ca45a49 ("distro_bootcmd: Set distro_bootpart_uuid =
for
> > > > > > block devices") added support for the distro_boot_part_uuid
> > > > > > environment variable to allow using PARTUUID in the kernel comm=
and
> > > > > > line.
> > > > > >
> > > > > > However, the way it was written only supports the case where th=
e boot
> > > > > >     =20
> > > > > files   =20
> > > > > > and the rootfs are located in the same partition. There are man=
y cases
> > > > > > where the boot partition and rootfs partition are separate.
> > > > > >
> > > > > > Add a customizable find_distro_rootpart command to allow each b=
oard to
> > > > > > define its own logic for locating the rootfs partition. This pr=
ovides
> > > > > > flexibility for boards with custom partition layouts while main=
taining
> > > > > > backward compatibility for the default case where boot and root=
fs
> > > > > > share the same partition.
> > > > > >
> > > > > > Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.co=
m>
> > > > > > ---
> > > > > >  doc/develop/distro.rst          | 11 +++++++++++
> > > > > >  include/config_distro_bootcmd.h | 10 +++++++---
> > > > > >  2 files changed, 18 insertions(+), 3 deletions(-)
> > > > > >     =20
> > > > >=20
> > > > > How about moving to standard boot and look at this there?   =20
> > > >=20
> > > > Ok, I will take a look at it. =20
> > >=20
> > > There is a custom nand boot target [1], and I have not any am335x boa=
rd with
> > > nand memory to test it. I am afraid to break it during the update to
> > > bootstd. Not sure we can accept that. What do you think?
> > >=20
> > > [1]https://elixir.bootlin.com/u-boot/v2025.10/source/include/configs/=
am335x_evm.h#L27
> > > =20
> >=20
> > I think we can risk it. I'd even be OK with not migrating that portion
> > and letting anyone still using those platforms, with NAND only, to just
> > use a custom boot command instead as I have strong doubts there's anyone
> > doing anything other than that currently.
>=20
> Ok.
>=20
> Small questions related to standard boot:
> Why do we have a lot of bootmeth selected by default like BOOTMETH_EFILOA=
DER,
> BOOTMETH_EFI_BOOTMGR, BOOTMETH_VBE ..., but BOOTSTD_DEFAULTS not selected=
 by
> default? Shouldn't it be the contrary?

Hard to say. We got stuck on trying to find the right balance between
features and size growth.

> Moreover it is explicitly described that global bootmeth can be slow:
> https://elixir.bootlin.com/u-boot/v2025.10/source/doc/develop/bootstd/ove=
rview.rst#L103
>=20
> The bootmeths environment variable is never read.
> Changing this environment in the prompt allows to change the bootmeth ord=
er
> thanks to this callback:
> https://elixir.bootlin.com/u-boot/v2025.10/source/boot/bootmeth-uclass.c#=
L459
> But if we set bootmeths in the board environment it doesn't work at all.
> Is it intended?

Standard boot is still in development. We're still in the process of
getting more SoCs migrated and in turn finding and fixing the rough
spots. Global boot meths have changed a bit since v2025.10 as part of
hopefully addressing the feedback Andre P. had as part of migrating
sunxi, but I think there's still the ordering half of his concerns to be
figured out.

--=20
Tom

--87ZnRuxqPSxevaNC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQor9AAKCRAr4qD1Cr/k
CkydAP4l0KMDk2HXQY8kq1YmigZ+hqHirsn7eQjO4ZXidrqlmgD+LZCGgzDRMwwB
9CYlbOlHCsXmNN222bxox1nEURGg5wY=
=7Tus
-----END PGP SIGNATURE-----

--87ZnRuxqPSxevaNC--
