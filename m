Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79039C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 15:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 059E982B63;
	Tue, 10 Jun 2025 17:35:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nz3y7ZgB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F16982B70; Tue, 10 Jun 2025 17:35:50 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4430C82B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 17:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2e541e0b974so3899260fac.1
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 08:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749569743; x=1750174543; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QXk4Mgg7+JdDZBU9O+7osQCmxiBQvkvP6sWOO8TzT2w=;
 b=Nz3y7ZgBjote5+ALXI4IhSXXhfQ3Qcb4T4QzwHYNLfCG6J2+Qp16dMIW9VGf+3efQq
 mO4PkBe7Y6srQw9alaPXBe2Xg4HZX8ODeC4MMH8XPuVSj97Zqm2o+ctcjU/BM3yJoiHy
 yMbnyy/PNir7yG/ozDVCjoGrU2vBptDrK69Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749569743; x=1750174543;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXk4Mgg7+JdDZBU9O+7osQCmxiBQvkvP6sWOO8TzT2w=;
 b=OozA1AsG4XRWEFQnKRQ07a1i0MLc18uOHl0Sz3FJXd9CojnjtpMP6wG0Fj/l76ZEh+
 VdWAf/nqPqFvHkcweOBl3pZnevJzE9UK+O2ojwnw1gWxmjuEx+kUO8lZ1zl3RjFKbmnK
 9nVQ3/CwHcp2Q8Csyn6HZqWpPHwRju/vQ7qxWiR0Offij3pIksFteSck3JmWcZ5vHooH
 Fxxu+HXrcUje4DQ5+l8nYWZYjJJd2Q1QVC4LHEWLCFrNzk6whz7PWkeb6X7lRefCHncC
 GWo1Tu+wnjWFSNPyjs6TY4QwLXyi0qg518C3YU55KXXDkLsR3mjg3Ly7PPNcx+w4/q1e
 qAGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpzYrJh9d68nPzyLPdbOjj2OWfzz91xA7NY6XEJJ0J4WJh3YMFPOV2EiHhFkGSx8C8aEQXj3w=@lists.denx.de
X-Gm-Message-State: AOJu0YwM6e5ZedD5F1WJGed+KaGSK96Zv0XOZAvyzc5ZnyGy2jh1kBfu
 ldi03rKhQNtL84c61QT1kkXgMt7q8JwhbkrWpCC55B/fDwnJa+aMJhZSdkn9Se9usJ8=
X-Gm-Gg: ASbGnctREy6AIoAI+xfYABFQrITXS4NmdnQWsst9fq1qkf2j3RZu5oxGXJRXLf/1aVd
 j0Wcf+Gisb4jEt/ZyXrxg8iaFid5oSrylenZgnUYt3bUuH2wsJs9r+gHbaWDFhrBdQL+OwJVaLI
 nlBHwLuLy6axJu6kDiZ90x7e3ULYz+PibwqGKkJ4y9pAgp/lf2MQonvkM6oJV8nO/l+5L0kS9Cv
 eaJkpsBe0vU9VnqYst2YR7IAHO3TeKTnMVeT2Ltc+LpvtTt3ACooV/3YQ+phIyJdkLK8w9nKlt2
 fVkw3FT5kGUbn9b3pOU+bTd9o7KMeA46IRB8RJ2KYEVajNmql2JQdMYEVvMHnkepUP4nKF+aTRI
 pn6oKwGWFUkxkkV4gh55TrXSRLmYWTRpjeg==
X-Google-Smtp-Source: AGHT+IFtkwvkyW6sAXiDj6mP2CF3iUuV5Xq+wOknfGcucs80tzmjyu01t3A1T7OESE2m3y1U0g41Rw==
X-Received: by 2002:a05:6870:3c0c:b0:2c1:44a9:fc16 with SMTP id
 586e51a60fabf-2ea01566271mr11129131fac.38.1749569742904; 
 Tue, 10 Jun 2025 08:35:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea072e46fbsm2464704fac.23.2025.06.10.08.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 08:35:42 -0700 (PDT)
Date: Tue, 10 Jun 2025 09:35:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: rick@andestech.com, ycliang@pr-suspensions-neuweb-biz.expedrion.biz,
 u-boot@lists.denx.de, nazar.kazakov@codethink.co.uk,
 joseph.baker@codethink.co.uk, fran.redondo@codethink.co.uk,
 lawrence.hunter@codethink.co.uk
Subject: Re: [PATCH 1/2] riscv: add build support for big-endian
Message-ID: <20250610153540.GD1382132@bill-the-cat>
References: <20250610151850.1673111-1-ben.dooks@codethink.co.uk>
 <20250610151850.1673111-2-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JI8FMkfN3Nl1mgRz"
Content-Disposition: inline
In-Reply-To: <20250610151850.1673111-2-ben.dooks@codethink.co.uk>
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


--JI8FMkfN3Nl1mgRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 04:18:49PM +0100, Ben Dooks wrote:
> Add support to build code big-endian if the board supports
> it. Updates the makefile to pass the correct compiler and
> elf flags.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/riscv/config.mk | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/riscv/config.mk b/arch/riscv/config.mk
> index 9f16dda92a0..2eeeb433748 100644
> --- a/arch/riscv/config.mk
> +++ b/arch/riscv/config.mk
> @@ -10,19 +10,29 @@
>  # Rick Chen, Andes Technology Corporation <rick@andestech.com>
>  #
> =20
> -32bit-emul		:=3D elf32lriscv
> -64bit-emul		:=3D elf64lriscv
> +ifdef CONFIG_SYS_BIT_ENDIAN

Typo, should be BIG not BIT.

> +small-endian		:=3D b
> +large-endian		:=3D big
> +else
> +small-endian		:=3D b
> +large-endian		:=3D big
> +PLATFORM_CPPFLAGS       +=3D -mbig-endian
> +KBUILD_LDFLAGS          +=3D -mbig-endian
> +endif

And then fix it so we can go back to little, too :)

--=20
Tom

--JI8FMkfN3Nl1mgRz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhIUMwACgkQFHw5/5Y0
tyxLnwv/RTHCy8gVcIPfzA2tfSW7gKLDSTr+N9gLpXiZMcY8Fj52xwGifefTOiSr
X3ass3ZinHx0r4Hlj8C+cC8U/o5m4RHRXi9G9RZtHJSp0pbe+o67zlThKwDNFUnu
wZcXdJixrU3MvMFhks7ufTvcdIzEEg2T+9onmPB69cniObLfm+A9BEyYBcVE5Cak
07lXGmftN/fnvPoPl02Da8ya7k7zXCWymA9Bhtecu00dtSDQLQk8uG48z74oWnXD
1x7TEoIXRUgtKBCY5peomQPCaF3t/ps+/AkKOhx/LfwEb03XWCtnZZR2Ih9m85TH
LnAlUUGhrVkKhBiuygluy2gM+mqJq0W0/DeSZUkYvFzZT97kDQaB2ZeTsmC/Y51l
UNXzZwiPyQ0LzotJr+hfzx332XRDTe4MwYFJfoCVtqlx7xMsIq+//VuxGieLJCbW
Db6u4iTyhqBvUUPkXMFedN+sSIlAPdUy7NbZN4hUPN4L5kt2v/kjUS/kZCK9oNbT
hACCurMJ
=f/+O
-----END PGP SIGNATURE-----

--JI8FMkfN3Nl1mgRz--
