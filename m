Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0D1C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 11:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD3382FC8;
	Thu, 22 May 2025 13:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UBamx+hB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0355383043; Thu, 22 May 2025 13:28:26 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5538282F67
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 13:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id ADFB45C4AA4;
 Thu, 22 May 2025 11:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6154BC4CEEF;
 Thu, 22 May 2025 11:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747913301;
 bh=/yDJlNwb/O3IQPu7S934MubXxpUtqhhPWUXUXM+gvz0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UBamx+hBmyDBcsubIUH6MAYmWkdm9o5nZAwRVcPBesueOqoKTza9Q2II/1n6rxuUl
 KzimCbTEiE+mwBDx/mQG7ohGrNjxr9XNyl259CtHeN3avo3FsxamQ+RxLMJiorXBqU
 Mt3PEAQzICi73EQkHjvtHdMDPN/kxbl6PcsA1IB5Nw2qfvv/7zQAlUYVH/TzMhpKGd
 +d0CPv2NuqYazXUCifCgv3gWEzSHk83IoyouSXN/NI2GyS4nzFgRY8/fbvU/C5qZ9V
 ZJi0S00WP/0KaeJ0DHAUCkVaegXzFFFORhL+5VNRQSJ2anThA/qlnD0bivYjcpdzoG
 9/QhjH1iO2aCw==
Date: Thu, 22 May 2025 12:28:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: Leo Liang <ycliang@andestech.com>, u-boot@lists.denx.de,
 rick@andestech.com, Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20250522-eradicate-clip-538f48710ad7@spud>
References: <aC2hyzxwKzO4k1im@swlinux02>
 <174785279069.2062062.17616710293064147131.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="H8lBA5tS9diVjbc7"
Content-Disposition: inline
In-Reply-To: <174785279069.2062062.17616710293064147131.b4-ty@konsulko.com>
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


--H8lBA5tS9diVjbc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 12:39:50PM -0600, Tom Rini wrote:
> On Wed, 21 May 2025 17:50:03 +0800, Leo Liang wrote:
>=20
> > The following changes since commit a3e09b24ffd4429909604f1b28455b44306e=
dbaa:
> >=20
> >   Merge tag 'mmc-2025-05-20' of https://source.denx.de/u-boot/custodian=
s/u-boot-mmc (2025-05-20 08:35:31 -0600)
> >=20
> > are available in the Git repository at:
> >=20
> >   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> >=20
> > [...]
>=20
> Merged into u-boot/master, thanks!

This PR seems to have made my CI blow up, and I'm not entirely sure if
that's something intentional or not. I've not yet bisected, but since
the error is "Image arch not compatible with host arch", I can only
imagine the patch in question is:
| Subject: [PATCH v2 1/3] riscv: image: Add new image type for RV64
| Date: Fri,  4 Apr 2025 14:48:55 +0000	[thread overview]
| Message-ID: <20250404144859.112313-2-mchitale@ventanamicro.com> (raw)
| In-Reply-To: <20250404144859.112313-1-mchitale@ventanamicro.com>
|=20
| Similar to ARM and X86, introduce a new image type which allows u-boot
| to distinguish between images built for 32-bit vs 64-bit Risc-V CPUs.
|=20
| Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
| Reviewed-by: Maxim Moskalets <maximmosk4@gmail.com>
| ---
|  boot/image.c    | 3 ++-
|  include/image.h | 3 ++-
|  2 files changed, 4 insertions(+), 2 deletions(-)
|=20
| diff --git a/boot/image.c b/boot/image.c
| index 139c5bd035a..45299a7dc33 100644
| --- a/boot/image.c
| +++ b/boot/image.c
| @@ -92,7 +92,8 @@ static const table_entry_t uimage_arch[] =3D {
|  	{	IH_ARCH_ARC,		"arc",		"ARC",		},
|  	{	IH_ARCH_X86_64,		"x86_64",	"AMD x86_64",	},
|  	{	IH_ARCH_XTENSA,		"xtensa",	"Xtensa",	},
| -	{	IH_ARCH_RISCV,		"riscv",	"RISC-V",	},
| +	{	IH_ARCH_RISCV,		"riscv",	"RISC-V 32 Bit",},
| +	{	IH_ARCH_RISCV64,	"riscv64",	"RISC-V 64 Bit",},
|  	{	-1,			"",		"",		},
|  };
| =20
| diff --git a/include/image.h b/include/image.h
| index 07912606f33..411bfcd0877 100644
| --- a/include/image.h
| +++ b/include/image.h
| @@ -138,7 +138,8 @@ enum {
|  	IH_ARCH_ARC,			/* Synopsys DesignWare ARC */
|  	IH_ARCH_X86_64,			/* AMD x86_64, Intel and Via */
|  	IH_ARCH_XTENSA,			/* Xtensa	*/
| -	IH_ARCH_RISCV,			/* RISC-V */
| +	IH_ARCH_RISCV,			/* RISC-V 32 bit*/
| +	IH_ARCH_RISCV64,		/* RISC-V 64 bit*/
| =20
|  	IH_ARCH_COUNT,
|  };
| --=20
| 2.43.0
|=20
since it is changing the existing "riscv" image type to be the 32-bit
image and requiring the new entry for 64-bit. My CI job uses the system
mkimage to create the image that U-Boot is loading, so it doesn't know
about the new define etc. Maybe it's not considered a problem if a new
U-Boot cannot boot an old image, but the comment above the enum reads:
|/*
| * CPU Architecture Codes (supported by Linux)
| *
| * The following are exposed to uImage header.
| * New IDs *MUST* be appended at the end of the list and *NEVER*
| * inserted for backward compatibility.
| */
The overwhelming majority of existing supported boards in U-Boot are
64-bit platforms, and the 64-bit platforms are the ones that have been
supported for longer, so my thought would be that the compatibility of
64-bit platforms should be prioritised over 32-bit? Or even add explicit
32-bit and 64-bit entries and the existing one is a catch-all for
compatibility reasons?

Hopefully my lack of bisection isn't causing me to blame something
incorrect, but I'll go try to replicate now :)

--H8lBA5tS9diVjbc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaC8KUQAKCRB4tDGHoIJi
0pLTAP0QZDnHazr4bmpjpWmvXA/A40z5adBLbHwbjIGbWBrkYQEAktM7GU2DWLLJ
VqwlXmq//Dy+JJI4ZfhcP7kG046qPQM=
=UDYI
-----END PGP SIGNATURE-----

--H8lBA5tS9diVjbc7--
