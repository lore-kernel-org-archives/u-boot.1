Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805B9FD3774
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D247E84201;
	Wed, 25 Feb 2026 17:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lKdlxF9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F33A84205; Wed, 25 Feb 2026 17:34:35 +0100 (CET)
Received: from mail-oi1-x236.google.com (unknown [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13624841FF
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4648447c899so1520957b6e.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772037203; x=1772642003; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1WNfFxsEMJDIH3GQafSto9Vr8NRCWgsyUzyB/CR82gA=;
 b=lKdlxF9oCtgyJZnzg8HuOKoscGWH1gOMLzUui7ohnkkYVSxOKZRq2TMS8vmt0uhe5k
 aQRSHY+xEQPqoI64JE4Zaa1iZAaFm/myfDrB9G0whde5536g1M+c6lDqXlOHEJJm+ksU
 OGpAyOK3RgrZSXRtXUsof7kbA2m5DSwE+OU+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772037203; x=1772642003;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1WNfFxsEMJDIH3GQafSto9Vr8NRCWgsyUzyB/CR82gA=;
 b=VvvLkgj8nR6Dm4VcOPNYaMjr0Tx4If2UinTCSzZiUMyPSh6vX7flNFyMhKBzdVXk4r
 b1qrI8xyJifliIxj2T2vljJgXHEFYzaWoHCve8Oku3PiNuYsVH6b09tX7xDGRCrMPXne
 1sfZOHhjm3pfI/AcFayPnS7y7h4UFZ5MVcfloZ5R6LNvRkTNGDx92XZXgsiC8ltaiBbv
 mqMGlXb0W2oTMjne48H/1TY4qQDevh8/lIcUiaU5RDz5qEMX5uXOhn1mytnhthPtYWzm
 Pd1uuQeH8B0kcjfBjmdsy+vp5x6ErOB8r2NqpBNUOXoxG+l4rEkP9U7J3pJXFIuV4fKB
 tnvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMT8n4303DE76jvsshivC7WH7/OwvFB8adn4a5qwlwyCmKYyEBJm2O1VPjxY++apcm4J945io=@lists.denx.de
X-Gm-Message-State: AOJu0YxU7F6GCkYp73m273p9B0f7shge0sZpgwptgj/ZNfuD+Ui02w/V
 tIWUBQRM0hmyW7YmJYfPMUZiwpH9Qb9knxcrOBVTh6dG0sq602+t8Z/OWSpXU0QBnnQ=
X-Gm-Gg: ATEYQzxC26KqH0pO7EUYABdLjuXXlnL8LSAzvdTOos+pB9/9aTpaMymhdhvI5HX7/Ii
 xIPQneaoxDNppw1jltVnj/iROz3fFNYZE06HJh+FbNz2nurz3X8l8M9CtfU9iv2uehHIkNQzhlV
 D2z4zlnXnJuMPIBWh1F38WxxVn149AcNI4BZXEAhOF+ujCLcOrg3a4DnyexrDkdeDUe0Wr/1hGh
 eHqqyGDlRUQiEa+59GkkZyQRBenUPf9s8y5bfZfkwGd5Rj2cxBQMwU2v7YDJqfM/zIjkw6ikE6S
 mCy7n7OyFyvrIGE4zfEDdC814djgdxgHZABEOA9KUcZcnSWUjbQDs/jTM/rIDOjLQF1c80GEE9P
 lwkCtMna5Xx7+sVOWFZNrXp2YugvhmIaxPJgIT7EzsY3R829KX77l4t9YuIlTnflTIi1eJzgQC4
 ZAYPlbagUCkkZSLuhVBRIc87I2WX21yHpd/6FfRqjsyj6wSgEUUpHeGTE0hPzdFW1IvCAJKiLrW
 Sncdk2P6olCfYMgiK/VnyExHHyhql8Tqzv8tZ4Ve2fcTvJfqXQ=
X-Received: by 2002:a05:6808:4f4f:b0:45c:832a:cf43 with SMTP id
 5614622812f47-464461d7739mr9335079b6e.14.1772037202586; 
 Wed, 25 Feb 2026 08:33:22 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cfa6624sm15408702fac.8.2026.02.25.08.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:33:22 -0800 (PST)
Date: Wed, 25 Feb 2026 10:33:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com, git@amd.com, John Toomey <john.toomey@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [RFC PATCH v2] cmd: part: add dupcheck command to detect
 duplicate PARTUUIDs
Message-ID: <20260225163319.GO1593142@bill-the-cat>
References: <20260222070957.2756719-1-padmarao.begari@amd.com>
 <c1ae91ae-61f3-4a05-b975-2dc8feb41f70@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EaK6FrfQp4MyA1c/"
Content-Disposition: inline
In-Reply-To: <c1ae91ae-61f3-4a05-b975-2dc8feb41f70@cherry.de>
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


--EaK6FrfQp4MyA1c/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 05:27:45PM +0100, Quentin Schulz wrote:
> Hi Padmarao,
>=20
> On 2/22/26 8:07 AM, Padmarao Begari wrote:
> > Add a 'part dupcheck' subcommand that scans all block devices for
> > duplicate partition UUIDs. This helps detect situations where the
> > same disk image has been flashed to multiple boot devices (e.g.,
> > USB stick and UFS), which can lead to unpredictable boot behavior
> > when using PARTUUID-based root filesystem specifications. It
> > iterates all block devices using blk_foreach_probe() and checks
> > partition UUIDs via part_get_info().
> >=20
> > When duplicates are found, a warning is printed for each occurrence:
> >=20
> > Warning: duplicate PARTUUID 20c5fba5-0171-457f-b9cd-f5129cd07228
> >    first seen on usb_mass_storage.lun0:3
> >    also on ufs_scsi.id0lun0:3
> >=20
> > Add Kconfig option `CMD_PART_DUPCHECK` and update the `part` help
> > text accordingly.
> >=20
> > Signed-off-by: John Toomey <john.toomey@amd.com>
> > Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> > ---
> > Changes in v2:
> > -Add own kconfig symbol for dupcheck subcommand and guard it.
> > ---
> >   cmd/Kconfig |   7 ++++
> >   cmd/part.c  | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >   2 files changed, 110 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 322ebe600c5..73d27fe2e28 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -1663,6 +1663,13 @@ config CMD_PART
> >   	  Read and display information about the partition table on
> >   	  various media.
> > +config CMD_PART_DUPCHECK
> > +	bool "part dupcheck"
> > +	depends on CMD_PART
> > +	help
> > +	  Enable the 'part dupcheck' sub-command under 'part' to scan the
> > +	  current partition table and report any duplicate partition UUIDs.
> > +
> >   config CMD_PCI
> >   	bool "pci - Access PCI devices"
> >   	help
> > diff --git a/cmd/part.c b/cmd/part.c
> > index 975a0a08a99..c4df5053936 100644
> > --- a/cmd/part.c
> > +++ b/cmd/part.c
> > @@ -15,9 +15,12 @@
> >    * Pavel Bartusek <pba@sysgo.com>
> >    */
> > +#include <blk.h>
> >   #include <config.h>
> >   #include <command.h>
> > +#include <dm.h>
> >   #include <env.h>
> > +#include <malloc.h>
>=20
> Can you check the size impact of adding those three include files if we
> aren't enabling CMD_PART_DUPCHECK? I'm wondering if we shouldn't guard th=
ose
> includes with the Kconfig symbol as well?

Headers shouldn't have a size impact. If they do, that's a problem to
figure out.

--=20
Tom

--EaK6FrfQp4MyA1c/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ8kTAAKCRAr4qD1Cr/k
Cni8AP9IHPXxntT9xejQJ43/fheqzJxjlUH1wV4Z5GlSr6brKQD9Fh1gnIHx2jnF
mblezR/B6NII2gGqFG98J7rVq0+JUw8=
=S5/S
-----END PGP SIGNATURE-----

--EaK6FrfQp4MyA1c/--
