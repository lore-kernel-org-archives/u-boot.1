Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC78CA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 15:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBA6881E13;
	Wed, 20 Aug 2025 17:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K5DCYUmw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13FAD82B07; Wed, 20 Aug 2025 17:17:02 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CBB3801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 17:16:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-30cce90227aso19814fac.1
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755703018; x=1756307818; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N/xBqxD0yx+RwUlF5saVT2sjI3CcW0ourZzp4TxKkJA=;
 b=K5DCYUmwNx1VU9V3GGVuv5FkKuZpE4eP7/NTG05+0f2LlbxsEeLmDAWIO89/Kj9LkJ
 Couugitaef5F5xxF/29JThpyZV5fEvfzurYMjghi+LO7/MKRE1+bdSI6xSD4yvx5PRSz
 wgWbauwcbmh2DbDKBjTQI4IiEk55tYa/ISBp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755703018; x=1756307818;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/xBqxD0yx+RwUlF5saVT2sjI3CcW0ourZzp4TxKkJA=;
 b=Pgc7bB9UWfkbPNrDG09QO8aVO5A6xhzbzbydalbG25B4ijtjb4/z4ewcNYg5BmM7Nl
 JxNpzVt2ywcw63F7eH28p4NUI1jylE9SuvzrVyNPwe+uvQe5fXcUPkS3Kovu9BD+AVmo
 9NicN8L6zCouG9AnwsFYZZdF1d9uqji/AoRZtoZKjJ19dOGiZOt4c+rbrVT3Vg8AcA3z
 GWh6H8WkQOAdii8ZV0I5lubq6KdleeGgvjAvQ8wieCNv2NFQnlZX907rBnm2SDj8MttJ
 0yF58hiof9hCkqW4G20Fm6Eaen/c05pBtlJ1H9eVVRWE1RtcD8kiRMBmTsCWcS7YWko9
 nJAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn5R2W6XSR46rFN518iVti+c3pZd280cDIWFr9GND5JG5B5v8NYXn0JT5BTHZgvcCxBraufEs=@lists.denx.de
X-Gm-Message-State: AOJu0YyzvLKmBa8l3/nvZ8UyTBwqSyhJkQiZCoWWyVIQGJsN8DmGYhBD
 BJvYknOlcYGzh0L+Aopd+u83zGqpPGAhS7CyTXj1m3M03S+HMFePycQ+OX0FsrUvX3w=
X-Gm-Gg: ASbGnctSwS1E5GK93rDAkFp2+xn3aJJ8u9zAO8FR/iOIVJgAjyOaD86NTtSz49vgBo3
 ypffjzKHBAeFdw0Zq0my7gLe5092PUkYh7pEC5ExwYyTI4zOG/0isibdP1hVjPOrfypULkx6xzq
 IzARlp2qVmlDpqUWJfiQLhNfYgRBWjpv9M0B72nlxgQsA1zLAIdFt5GSz+1DKYjKEZLA4I4eNC+
 rxTa0CwXqxtvMpskku+iu0vxh9nFaHoQnYIiiNhPoKQknWv6hZPI3TUKhYIKAqf0MSQshqX84C1
 QZYb7ufsAQoqMArnNfVOcc8xBf7XI3cwlh6Hy2Exi5ivozeUGyhdOch4T89NS3aoq+isT9PtXsa
 +qRAmXCre4IUZ+IVZCPlo4BRP/yy+VIfFB37F/UBfM5coJgnfricWtbWz
X-Google-Smtp-Source: AGHT+IEeNFutuUSJDR7fB1ksn7i7B1/W9TPNfoUCHDhi3Wbqn8xWV/69zY9U5bfkMIAQtnHcnr7BVw==
X-Received: by 2002:a05:6870:289:b0:2d6:72a4:adfa with SMTP id
 586e51a60fabf-31122987efdmr1883774fac.30.1755703018213; 
 Wed, 20 Aug 2025 08:16:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310b6e61351sm3978098fac.0.2025.08.20.08.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 08:16:57 -0700 (PDT)
Date: Wed, 20 Aug 2025 09:16:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: abdellatif.elkhlifi@arm.com, u-boot@lists.denx.de,
 Davidson kumaresan <davidson.kumaresan@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
Subject: Re: [PATCH v4 12/24] efi_loader: fwu_arm_psa: Add set_image and
 get_image_info support
Message-ID: <20250820151654.GI124814@bill-the-cat>
References: <20250725155010.285831-1-abdellatif.elkhlifi@arm.com>
 <20250725155010.285831-13-abdellatif.elkhlifi@arm.com>
 <CAC_iWjK2kuYtt-R7F52zDVTpaFj6=0R1AU+Dni+t+-4+yq3_=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BtscLJHSiK6rFZqI"
Content-Disposition: inline
In-Reply-To: <CAC_iWjK2kuYtt-R7F52zDVTpaFj6=0R1AU+Dni+t+-4+yq3_=w@mail.gmail.com>
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


--BtscLJHSiK6rFZqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 03:28:22PM +0300, Ilias Apalodimas wrote:
> Hi Abdelllatif
>=20
> On Fri, 25 Jul 2025 at 18:50, <abdellatif.elkhlifi@arm.com> wrote:
> >
> > From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> >
> > Implement set_image and get_image_info through RAW functions
> >
> > The implementation is done using efi_firmware_raw_set_image()
> > and efi_firmware_get_image_info()
> >
> > Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > Signed-off-by: Davidson kumaresan <davidson.kumaresan@arm.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Michal Simek <michal.simek@amd.com>
> > Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > Cc: Casey Connolly <casey.connolly@linaro.org>
> > Cc: Adriano Cordova <adrianox@gmail.com>
> >
> > ---
> >
> > Changelog of changes:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >
> > v2:
> >
> > * Following Heinrich comment: The changes at efi_firmware_raw_set_image=
()
> >     simplified by removing the "else" so it is clear we are just adding=
 FWU_ARM_PSA
> >     support and skipping the use of DFU in case of FWU_ARM_PSA
> >
> > v1:
> >
> > * Add set_image and get_image_info support for FWU_ARM_PSA
> >
> >  lib/efi_loader/efi_firmware.c | 35 +++++++++++++++++++++++++++++++----
> >  1 file changed, 31 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmwar=
e.c
> > index 75501e21557..38945b34e7b 100644
> > --- a/lib/efi_loader/efi_firmware.c
> > +++ b/lib/efi_loader/efi_firmware.c
> > @@ -4,6 +4,12 @@
> >   *
> >   *  Copyright (c) 2020 Linaro Limited
> >   *                     Author: AKASHI Takahiro
> > + *
> > + * Copyright 2025 Arm Limited and/or its affiliates <open-source-offic=
e@arm.com>
> > + *
> > + * Authors:
> > + *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > + *   Davidson kumaresan <davidson.kumaresan@arm.com>
>=20
> Copyright updates are usually done on significant contributions. I am
> not this qualifies as such.
> Tom is there a policy for that in U-Boot docs?

We don't have a formal policy, but indeed it's my understanding that
copyright claims need to be for "significant contributions" as well.

--=20
Tom

--BtscLJHSiK6rFZqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKXm4wAKCRAr4qD1Cr/k
CkSOAQCRKXSBIDbV0yJkAURHCWbYTlidVGhdBLGBC6hDGNtxJAEA2zVFumGDCRkV
OD0U3ElsrAA2F0k5KMXk3z7J5GHkowE=
=tMrG
-----END PGP SIGNATURE-----

--BtscLJHSiK6rFZqI--
