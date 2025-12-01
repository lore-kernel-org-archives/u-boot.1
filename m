Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29234D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:05:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BFB683C62;
	Mon,  1 Dec 2025 18:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ar46YInE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 162AD83C65; Mon,  1 Dec 2025 18:05:42 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C781483C29
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:05:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6593155d8d6so2487611eaf.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764608738; x=1765213538; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iOm/McY1P5vb9KvWKT6xoJO0S4z4ZPPtqjrbIGWSZTA=;
 b=Ar46YInEwCa0AUpP/5UydxKxwid3+4L73fgeBIeqENkyBi6WTFGO2+BCQgYQsrzTEQ
 DI9k38GmR95PiPSljXmJCxEflDPzaDT0JIejVxWv1ui03ROXFx59RarF6VIpm53pA/Uc
 9v3Y7daPm5h6iaYRKeJqXZWqUO+rriUt7OgcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764608738; x=1765213538;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iOm/McY1P5vb9KvWKT6xoJO0S4z4ZPPtqjrbIGWSZTA=;
 b=I2Az84tdGXnViMsom+rQCCewyeHwZpl/muK0GLJ0y3NlNOlZD2rZgx3y+H2lhse27P
 Hx7gWqKy5Fgps2k16Z+VaVf/SbepmpptLDIen+NdLAOMKfN3Tp/PC4xFfuF8GxpO6cpG
 14RDKv/zuZjAwktP3dwNW6F2WsglVvUxJ2g1SIrJqHO5hK2iwsCRQhgUTgZkrsPevJLA
 98x/3kY9CMZLAcwFJwK9J4AptQe7iWg92mU+9Mjd17zwZY0zSvjazTdu/2Mz7zbMuC2q
 b2YphK7rqVufBe7O8Snx5ewSqaLYQtSzS72M5joeltZpPc55mVvKOYhgDvHKclu9L7pS
 fnJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9IzUkkqXarI2fgwmTrm/sVNJiwhDFtDVm9qJwWd8QOM/RhSMWUOTFTLB+e41eBIZZWXb0KQM=@lists.denx.de
X-Gm-Message-State: AOJu0YzETjhWC93nMHFO/PAkPvUSmfpHa8cHwcUCjtFHcQ2wOoOUYumQ
 YSCzXgYSm+1bZe8eBqG/Cn6gIKJ8rzpE47CwOB5VetC5xAjWvHMUKSYKfApD3QNYcK8=
X-Gm-Gg: ASbGncvd3i2aVxnF/m14sSl/VU32Ojutuw6Au/tL+2u0O6XYiPq1r3V/pVZ5L+B8Tdz
 Py7PkhiTrGhI0elDRWdPZX16xjK3SB9YdB3I1AXZE/bt1fU256C4K3c8QjrKYXgQJjri3kBjmi1
 MdwYDg6P6voxUdt/cF7IB+ui0ZYcwIiA33G8eOAm7fDDqEjYHWta/6jQkdGJK6HgOoad729uj8V
 DeucMeaCVmCyA787GacYSsO8btLMkEhtDlj3nSYJhgkhmrGnH5lryjXh6V2U6mI309tFKz4WfpI
 3W1w0fOOSqtthnWL0v0/RYNyyQSTCOdxGP4PBldT0EqXMr9QIl8cI2ze9S3ypgNWjMC5zFlV+yr
 of+RNCs0unmheG0AWOzGIWpq3eh3kouTPd8DMYfqskvPGNZcaafdJ+EQil2kgdUzpjXkyYjEjdE
 uUpQc2Hn3FksUlwTgTJFgUOH4lztJyy6rM7gxbLo/wyv2ykSG+Pw==
X-Google-Smtp-Source: AGHT+IFTrr5TmyRoQSGDBIwgum62MdSzJFlBxNcG4g+CsB7BEnlLKXay2wlebzM+1deOpcPsaktq7Q==
X-Received: by 2002:a05:6820:1890:b0:657:4e49:83b7 with SMTP id
 006d021491bc7-6579206444bmr14703319eaf.1.1764608736977; 
 Mon, 01 Dec 2025 09:05:36 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-659332e0031sm2729155eaf.5.2025.12.01.09.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 09:05:36 -0800 (PST)
Date: Mon, 1 Dec 2025 11:05:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 Chee Tien Fong <tienfong.chee@altera.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] Fix socfpga GEN5 boot by spl+u-boot sfp on RAW
Message-ID: <20251201170534.GK303283@bill-the-cat>
References: <20251129064818.1587-1-briansune@gmail.com>
 <20251201165122.GH303283@bill-the-cat>
 <CAN7C2SAGqRqd-TXpp-ALrDzbsgBmLaxywGbw6j9w0MZipEQHnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z3ehL+9MYQI1SEJ3"
Content-Disposition: inline
In-Reply-To: <CAN7C2SAGqRqd-TXpp-ALrDzbsgBmLaxywGbw6j9w0MZipEQHnA@mail.gmail.com>
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


--Z3ehL+9MYQI1SEJ3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 01:01:48AM +0800, Sune Brian wrote:
> Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=97=
=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:51=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Sat, Nov 29, 2025 at 02:48:18PM +0800, Brian Sune wrote:
> >
> > > Thanks to Jan Kiszka had provided info on
> > > u-boot is not able to boot by u-boot-with-spl.sfp.
> > >
> > > All three TYPE, NUM, OFFSET mode methods
> > > are nonfunctional on combined raw boot.
> > >
> > > The major cause is spl+u-boot structure is
> > > defined as 4x[spl+zero_pad] + u-boot.img.
> > > Deal to this configuration since GEN5 is used,
> > > the spl would require to seek by an offset
> > > on top of the spl offset. This means for
> > > each spl=3D0x10000 the offset is 0x40000.
> > >
> > > However latest u-boot do not consider this
> > > major structure on GEN5 socfpga.
> > > Meanwhile, the default include file as Jan
> > > pointed out is completely wrong syntax and
> > > caused issue.
> > >
> > > Combining both concepts, the minimum fix
> > > patch is provide as follows.
> > >
> > > 1) Offset is control and default set to a
> > > proper offset under:
> > > SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET
> > >
> > > 2) Only GEN5 socfpga will be affected and
> > > minimized contamination on other devices.
> > >
> > > 3) Only one compuatation adjustment is made
> > > on spl_mmc_load. And simply introduce the
> > > offset adding by the kconfig offset control.
> > > It should be 0 by default and gate as well.
> > > So no possible harm should be done.
> >
> > This sounds like a tricky problem to solve in a "nice" looking way.
> >
> > The first thing that's unclear to me is, which of
> > SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR,
> > SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION or
> > SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is being used here?
> >
> > --
> > Tom
>=20
> Hi Tom.
>=20
> This issue all happened due to the old "u-boot-with-spl.sfp" structure.
> The old auto generated u-boot-with-spl.sfp that file itself has spl x4 and
> zero padding. then it inserts u-boot.img.
>=20
> All are user dependent and have no restriction from the beginning.
> SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR any sector with A2 type.
> SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION any partition with A2 type.
> All are completely dependent on the user SD MMC setup.
> So users can even use the last sector aka the most end of the SD MMC.
>=20
> That's why it is so tedious. And users even allow to simply use u-boot-sp=
l.sfp
> Then manually use dd  command to an offset that is in the A2 partition and
> load the u-boot.img
>=20
> I didn't even like this idea and that's why I changed to the FAT boot met=
hod
> after 2025.07.
> I simply bypassed the inherent issue that Jan was faced with.
>=20
> So long story short either completely drop this old compatible boot flow =
or
> do it in a very tedious way aka spl offset on top of u-boot.img offset.

Well, wait, this doesn't make sense. The first thing is you pick which
of the three I asked about as to how to find everything else at boot. We
don't need to support all three, we need to support one of them. I
suspect the first thing is we need a default one-of-those if SYMBOL.
This is what we do for MVEBU platforms which have, I suspect at least, a
similar odd constraint.

--=20
Tom

--Z3ehL+9MYQI1SEJ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS3K2gAKCRAr4qD1Cr/k
CmzrAQDwzRErxX9/U3puk/+4c7b+k8PYer3tG++o1LFtypd+CwD+IjjOscyyqeSA
PVXcNMSZASDbuWiV9c4UgRQMl9aUygY=
=BCHg
-----END PGP SIGNATURE-----

--Z3ehL+9MYQI1SEJ3--
