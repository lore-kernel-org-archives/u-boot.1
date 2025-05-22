Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC01C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 14:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A28EB830B4;
	Thu, 22 May 2025 16:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hU/Mtf8H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C252830E9; Thu, 22 May 2025 16:46:16 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F13AD83082
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 16:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6060167af73so5098188eaf.2
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 07:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747925173; x=1748529973; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=txYzfAYoqgAxbgxWXRSODbhW7OxUYVz/uFGdy7gjqvs=;
 b=hU/Mtf8HKcs2TbxyaxKWEWMul5EEUDrlKeyEucB6X8UhkTakraVaAKTl2Fi98DWQNu
 IxpiVa0sbxT9vegAXAwh2rRM0rsOyJ747r0DPXPAFKTkNGjhvkVFMKQzOtQCeo4860RE
 Q/roCr+7Ga0/3rD3ntVN3+pC6RehCBAHV7HPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747925173; x=1748529973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=txYzfAYoqgAxbgxWXRSODbhW7OxUYVz/uFGdy7gjqvs=;
 b=fjcY+1nVXgzfKgMwFNuA/oILAEIc8Fko7dH3QJw809HJ+/w5WcuttTrkvtSbQ5e335
 jDLrNm5pWPpHMoJ9EDCHphmURr+vRed/t3kENWbW/mslAzIa7d3AvJkgCvGmw6HP0QQh
 +FkAts3x3yH53TKKSRuXKa5vTKcu8DDc4M8yGOD8mCOo09o1VEq3Z1g3OpJWjfMmeEAY
 MuRGnuTMN9BvTmhfxc+M+3Zx3a9dRlRHa6pe/13I7bZ9qLaqWFf0iMOkVJ7vkSWe78aK
 XdDt8aaHrEI6VC39BgUndoC5So7+/r4ljfEZnQFvB/xxb7gp7QBI3QrZ5XOmhBzNkUyG
 RSFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXsIVd8HhKOum2NRNAoPeo7l4ABzahIibg1RNofB0D1QgEnyJoDpHl9k2AW6ynR8Pbt9t3rk4=@lists.denx.de
X-Gm-Message-State: AOJu0YzrCfjDc/nNIpgGVxSVhI7g9JJD8qXULk+Kc7w/DyLgRYLtos5b
 +9142xh6lk2/dFgjDHFVqjDcIecLVX9i06kyOUYjTKI90qxoHIrPCVgfpNQJOSgQ7UAGKUX20eT
 UwgBJM1g=
X-Gm-Gg: ASbGnctGu++bS+yClbFB/OsgMHwoTCJFVBRbIrejIVS1OIoxI1povcU1p8e1TYBfASU
 f5OVok/suRhMB1XDyG2uQ39Peewcw1xSWhKuxnHFGXM1WsaqtA7QDFOyxwOhH+nSENTVk/9UY4n
 2cCm1ao5x1ZUu3aodXxYt8OIej3Dd8JVwpv0J1WJnsClEMti60QYpNMXko4luQ3ntNRXGkd3nvM
 JMVeKVBd37BieQFxUJ7U5649LtD9txgcLF64EePHuo9hpBFTfW0SFVIglwAIkV8GrJeHZQFSSIZ
 jS10GMmVlBLlSjn+JNasVtmUZW545Q6dOX7VeVoExM+GdCzmOzsbmy09JrTICIte+RrAXnF2Ige
 O2Ncb7Q87DUbO
X-Google-Smtp-Source: AGHT+IFI0LQDQl8p3MzfHkvMjolCdL5gLm+40+p38+Pje0JLGnQ8wgok5b6GL8RapVFkhgCz6QXphw==
X-Received: by 2002:a05:6808:3385:b0:3fa:f848:8dfa with SMTP id
 5614622812f47-404d885e2f0mr17922337b6e.30.1747925162392; 
 Thu, 22 May 2025 07:46:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6a9a7a2sm2568012a34.36.2025.05.22.07.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 07:46:01 -0700 (PDT)
Date: Thu, 22 May 2025 08:45:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Conor Dooley <conor@kernel.org>
Cc: Leo Liang <ycliang@andestech.com>, u-boot@lists.denx.de,
 rick@andestech.com, Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20250522144559.GL100073@bill-the-cat>
References: <aC2hyzxwKzO4k1im@swlinux02>
 <174785279069.2062062.17616710293064147131.b4-ty@konsulko.com>
 <20250522-eradicate-clip-538f48710ad7@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3+v3WYz0s9j2uqRa"
Content-Disposition: inline
In-Reply-To: <20250522-eradicate-clip-538f48710ad7@spud>
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


--3+v3WYz0s9j2uqRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 12:28:18PM +0100, Conor Dooley wrote:
> On Wed, May 21, 2025 at 12:39:50PM -0600, Tom Rini wrote:
> > On Wed, 21 May 2025 17:50:03 +0800, Leo Liang wrote:
> >=20
> > > The following changes since commit a3e09b24ffd4429909604f1b28455b4430=
6edbaa:
> > >=20
> > >   Merge tag 'mmc-2025-05-20' of https://source.denx.de/u-boot/custodi=
ans/u-boot-mmc (2025-05-20 08:35:31 -0600)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > >   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> > >=20
> > > [...]
> >=20
> > Merged into u-boot/master, thanks!
>=20
> This PR seems to have made my CI blow up, and I'm not entirely sure if
> that's something intentional or not. I've not yet bisected, but since
> the error is "Image arch not compatible with host arch", I can only
> imagine the patch in question is:
> | Subject: [PATCH v2 1/3] riscv: image: Add new image type for RV64
> | Date: Fri,  4 Apr 2025 14:48:55 +0000	[thread overview]
> | Message-ID: <20250404144859.112313-2-mchitale@ventanamicro.com> (raw)
> | In-Reply-To: <20250404144859.112313-1-mchitale@ventanamicro.com>
> |=20
> | Similar to ARM and X86, introduce a new image type which allows u-boot
> | to distinguish between images built for 32-bit vs 64-bit Risc-V CPUs.
> |=20
> | Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> | Reviewed-by: Maxim Moskalets <maximmosk4@gmail.com>
> | ---
> |  boot/image.c    | 3 ++-
> |  include/image.h | 3 ++-
> |  2 files changed, 4 insertions(+), 2 deletions(-)
> |=20
> | diff --git a/boot/image.c b/boot/image.c
> | index 139c5bd035a..45299a7dc33 100644
> | --- a/boot/image.c
> | +++ b/boot/image.c
> | @@ -92,7 +92,8 @@ static const table_entry_t uimage_arch[] =3D {
> |  	{	IH_ARCH_ARC,		"arc",		"ARC",		},
> |  	{	IH_ARCH_X86_64,		"x86_64",	"AMD x86_64",	},
> |  	{	IH_ARCH_XTENSA,		"xtensa",	"Xtensa",	},
> | -	{	IH_ARCH_RISCV,		"riscv",	"RISC-V",	},
> | +	{	IH_ARCH_RISCV,		"riscv",	"RISC-V 32 Bit",},
> | +	{	IH_ARCH_RISCV64,	"riscv64",	"RISC-V 64 Bit",},
> |  	{	-1,			"",		"",		},
> |  };
> | =20
> | diff --git a/include/image.h b/include/image.h
> | index 07912606f33..411bfcd0877 100644
> | --- a/include/image.h
> | +++ b/include/image.h
> | @@ -138,7 +138,8 @@ enum {
> |  	IH_ARCH_ARC,			/* Synopsys DesignWare ARC */
> |  	IH_ARCH_X86_64,			/* AMD x86_64, Intel and Via */
> |  	IH_ARCH_XTENSA,			/* Xtensa	*/
> | -	IH_ARCH_RISCV,			/* RISC-V */
> | +	IH_ARCH_RISCV,			/* RISC-V 32 bit*/
> | +	IH_ARCH_RISCV64,		/* RISC-V 64 bit*/
> | =20
> |  	IH_ARCH_COUNT,
> |  };
> | --=20
> | 2.43.0
> |=20
> since it is changing the existing "riscv" image type to be the 32-bit
> image and requiring the new entry for 64-bit. My CI job uses the system
> mkimage to create the image that U-Boot is loading, so it doesn't know
> about the new define etc. Maybe it's not considered a problem if a new
> U-Boot cannot boot an old image, but the comment above the enum reads:
> |/*
> | * CPU Architecture Codes (supported by Linux)
> | *
> | * The following are exposed to uImage header.
> | * New IDs *MUST* be appended at the end of the list and *NEVER*
> | * inserted for backward compatibility.
> | */
> The overwhelming majority of existing supported boards in U-Boot are
> 64-bit platforms, and the 64-bit platforms are the ones that have been
> supported for longer, so my thought would be that the compatibility of
> 64-bit platforms should be prioritised over 32-bit? Or even add explicit
> 32-bit and 64-bit entries and the existing one is a catch-all for
> compatibility reasons?
>=20
> Hopefully my lack of bisection isn't causing me to blame something
> incorrect, but I'll go try to replicate now :)

Ugh. No, this is a problem that needs to be fixed and I'm sorry I missed
it during reviews. We need to keep the list compatible.

--=20
Tom

--3+v3WYz0s9j2uqRa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgvOKcACgkQFHw5/5Y0
tyw9yQwAib5fgGX8jqaATC1QEIP7IeJVa47nDE7S54Ti93AxTJnUDnZF7B9StQmj
gMfDytCTEOd4nwBqOCvTJjzOA1S1Mrv6Ook7q6JuVfdrNIx4aP2aez+cuB/s0yYF
2svkIbXdS6D7QviZwTrkqO/vcxf0aNeDg1PRgUOaifrjjFox5FoihgUoW1dHnufu
zTUX6GMSyJUnKz/ALUBRaRVhR5p97hOdqmDuOWl9w5h+EPD/CpI92CPuwMQE8OIF
EpCKVwNlo2JhqvbQ6A2k8i25czR645Gl9smQBAakph5EVD8By8UNvz+3z7gna9HS
fY2KYTld3jYJvog4CFqdrm2s3VV11ajuelgSzrjrXQS2ZXZA4ENC6H02xNj/4geO
QSVg275V3B6nTRdtVKQn5tsl3pw3pslS44vB5sJpIWLqdjyfCj3g/oMfKcqzqk5J
kwfgvQEzslrnake+xwe7m6R9dRyexp+y8fVLf8AdnfS2ScApreiG6K7DNybBese0
hjjKytgt
=HMkm
-----END PGP SIGNATURE-----

--3+v3WYz0s9j2uqRa--
