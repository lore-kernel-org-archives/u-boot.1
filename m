Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21E7C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 15:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B4368310F;
	Thu, 22 May 2025 17:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X7mUL1qR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9D27830F4; Thu, 22 May 2025 17:54:45 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C3658310F
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 17:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2da3c572a0bso3946047fac.3
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747929282; x=1748534082; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oKuJXtIVvL5aAKsZaBBXtp2fy0TLYG1ZC+3oh+W0PPY=;
 b=X7mUL1qRfkiWMQHv4cwVwBHbyMYuzOsez7tEYtlAXawbAIwjuxUTj/EwzZ8uNVTnSl
 70HvHUWMeju4rOfYBFs2SLBjPBH6/bhGjkgz1B8hB+esV4JbKQt38DWLVMuPfbO2N37B
 gl85UljYAXrb6kf0z6NZWLhgmH0s9paOY/sns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747929282; x=1748534082;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oKuJXtIVvL5aAKsZaBBXtp2fy0TLYG1ZC+3oh+W0PPY=;
 b=w5Z0H58DTTN4lZLDXqhM3VLwS5mBHMSb/n/D7GaHDScbmF/YqBRFfcY19dEITl8SHj
 K88DzrQ5LMR0+7MMAwXtuO7Azj5Ph3+LyooGRSfVDrtolJLigaH6DxIps2YlbMjByG07
 nFCbULWtGsf9K6mQchnL1S+7sZPKPVC06VnmJbLAWQTx3z0MUyWDcHVXH2oLUH35M2Ow
 50xxJogZf9dyIDWqe67h9u2zEwCX9LdUbfW55s3+NOexrMkdDNB3N4dYqlmzE5iui0fI
 7XdodW/KezPOyxoJsCebr9VFPxcSswf7BsqHAklZtl1N1Du+3NffHYprc+3cGEzthSTQ
 TTYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULku7PWFN9uJSnevSlC6ptuwLVrgHPQRyI6rQ39G7tfvDHbefhDXyGP8aXJXB7N9jBOBzv2KM=@lists.denx.de
X-Gm-Message-State: AOJu0YxETqKAmCKz3NMezT1hpvbQv5mCvXCzuT08x/L09/ToThLsgupH
 CEIol8SrmrbK1reUI1OUhVWXc3x2Q6K6Q+GUXLhpDJJztRunP02oksKxtsFpEe1WnD8=
X-Gm-Gg: ASbGncvuR8t5x/kmT0f/l+c7p+zuaIpSkF2c2X5Qvy46snurmQLYIt6uPM/I+6LyuId
 XAa38WvpCPqTAx78gGDodZkkhAj4jJwLEi4VDdRdg7t82KuKUAoMznvS/j4sZMu2892z2XY3knm
 D0yED+3iMigLDM6cvJHeAHm8/URkS5+OoESDUAbabmIY2mRWbaLWVBOQWskzpFrGBrXsVPprHd9
 NBqDTyun6XOLIvxU5mPv3yUgRB9ITwBS30w8CC16WyosRBKF++WaqkVbqe26CAivqr594/G9fwp
 4CIXMUee5HQoSt++BbXhYGJHV+YLg4BEO/dmanUlR0mq43rzUm0fvgYTSsDt+rkmZReaUNPszCI
 ktvEWlgOKNznL
X-Google-Smtp-Source: AGHT+IE6n2+nPxeL8B7OJNZwBqtREBlash0EClpFFzZUicw5zUdPqerEHW7yzBrscsp6d4mhrDHUbQ==
X-Received: by 2002:a05:6871:6309:b0:2bc:9197:3508 with SMTP id
 586e51a60fabf-2e3c1f8fd61mr16238564fac.34.1747929281813; 
 Thu, 22 May 2025 08:54:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c06bada4sm3074576fac.15.2025.05.22.08.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 08:54:40 -0700 (PDT)
Date: Thu, 22 May 2025 09:54:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: Conor Dooley <conor@kernel.org>, u-boot@lists.denx.de,
 rick@andestech.com, Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20250522155438.GM100073@bill-the-cat>
References: <aC2hyzxwKzO4k1im@swlinux02>
 <174785279069.2062062.17616710293064147131.b4-ty@konsulko.com>
 <20250522-eradicate-clip-538f48710ad7@spud>
 <20250522144559.GL100073@bill-the-cat> <aC9Ejx01_If9pQVP@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bBvVOHdUGl6Kjmvi"
Content-Disposition: inline
In-Reply-To: <aC9Ejx01_If9pQVP@swlinux02>
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


--bBvVOHdUGl6Kjmvi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 11:36:47PM +0800, Leo Liang wrote:
> On Thu, May 22, 2025 at 08:45:59AM -0600, Tom Rini wrote:
> > On Thu, May 22, 2025 at 12:28:18PM +0100, Conor Dooley wrote:
> > > On Wed, May 21, 2025 at 12:39:50PM -0600, Tom Rini wrote:
> > > > On Wed, 21 May 2025 17:50:03 +0800, Leo Liang wrote:
> > > >=20
> > > > > The following changes since commit a3e09b24ffd4429909604f1b28455b=
44306edbaa:
> > > > >=20
> > > > >   Merge tag 'mmc-2025-05-20' of https://source.denx.de/u-boot/cus=
todians/u-boot-mmc (2025-05-20 08:35:31 -0600)
> > > > >=20
> > > > > are available in the Git repository at:
> > > > >=20
> > > > >   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> > > > >=20
> > > > > [...]
> > > >=20
> > > > Merged into u-boot/master, thanks!
> > >=20
> > > This PR seems to have made my CI blow up, and I'm not entirely sure if
> > > that's something intentional or not. I've not yet bisected, but since
> > > the error is "Image arch not compatible with host arch", I can only
> > > imagine the patch in question is:
> > > | Subject: [PATCH v2 1/3] riscv: image: Add new image type for RV64
> > > | Date: Fri,  4 Apr 2025 14:48:55 +0000	[thread overview]
> > > | Message-ID: <20250404144859.112313-2-mchitale@ventanamicro.com> (ra=
w)
> > > | In-Reply-To: <20250404144859.112313-1-mchitale@ventanamicro.com>
> > > |=20
> > > | Similar to ARM and X86, introduce a new image type which allows u-b=
oot
> > > | to distinguish between images built for 32-bit vs 64-bit Risc-V CPU=
s.
> > > |=20
> > > | Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > > | Reviewed-by: Maxim Moskalets <maximmosk4@gmail.com>
> > > | ---
> > > |  boot/image.c    | 3 ++-
> > > |  include/image.h | 3 ++-
> > > |  2 files changed, 4 insertions(+), 2 deletions(-)
> > > |=20
> > > | diff --git a/boot/image.c b/boot/image.c
> > > | index 139c5bd035a..45299a7dc33 100644
> > > | --- a/boot/image.c
> > > | +++ b/boot/image.c
> > > | @@ -92,7 +92,8 @@ static const table_entry_t uimage_arch[] =3D {
> > > |  	{	IH_ARCH_ARC,		"arc",		"ARC",		},
> > > |  	{	IH_ARCH_X86_64,		"x86_64",	"AMD x86_64",	},
> > > |  	{	IH_ARCH_XTENSA,		"xtensa",	"Xtensa",	},
> > > | -	{	IH_ARCH_RISCV,		"riscv",	"RISC-V",	},
> > > | +	{	IH_ARCH_RISCV,		"riscv",	"RISC-V 32 Bit",},
> > > | +	{	IH_ARCH_RISCV64,	"riscv64",	"RISC-V 64 Bit",},
> > > |  	{	-1,			"",		"",		},
> > > |  };
> > > | =20
> > > | diff --git a/include/image.h b/include/image.h
> > > | index 07912606f33..411bfcd0877 100644
> > > | --- a/include/image.h
> > > | +++ b/include/image.h
> > > | @@ -138,7 +138,8 @@ enum {
> > > |  	IH_ARCH_ARC,			/* Synopsys DesignWare ARC */
> > > |  	IH_ARCH_X86_64,			/* AMD x86_64, Intel and Via */
> > > |  	IH_ARCH_XTENSA,			/* Xtensa	*/
> > > | -	IH_ARCH_RISCV,			/* RISC-V */
> > > | +	IH_ARCH_RISCV,			/* RISC-V 32 bit*/
> > > | +	IH_ARCH_RISCV64,		/* RISC-V 64 bit*/
> > > | =20
> > > |  	IH_ARCH_COUNT,
> > > |  };
> > > | --=20
> > > | 2.43.0
> > > |=20
> > > since it is changing the existing "riscv" image type to be the 32-bit
> > > image and requiring the new entry for 64-bit. My CI job uses the syst=
em
> > > mkimage to create the image that U-Boot is loading, so it doesn't know
> > > about the new define etc. Maybe it's not considered a problem if a new
> > > U-Boot cannot boot an old image, but the comment above the enum reads:
> > > |/*
> > > | * CPU Architecture Codes (supported by Linux)
> > > | *
> > > | * The following are exposed to uImage header.
> > > | * New IDs *MUST* be appended at the end of the list and *NEVER*
> > > | * inserted for backward compatibility.
> > > | */
> > > The overwhelming majority of existing supported boards in U-Boot are
> > > 64-bit platforms, and the 64-bit platforms are the ones that have been
> > > supported for longer, so my thought would be that the compatibility of
> > > 64-bit platforms should be prioritised over 32-bit? Or even add expli=
cit
> > > 32-bit and 64-bit entries and the existing one is a catch-all for
> > > compatibility reasons?
> > >=20
> > > Hopefully my lack of bisection isn't causing me to blame something
> > > incorrect, but I'll go try to replicate now :)
> >=20
> > Ugh. No, this is a problem that needs to be fixed and I'm sorry I missed
> > it during reviews. We need to keep the list compatible.
>=20
> Hi Conor, Tom,
>=20
> I am so sorry! I did not catch the compatibility issue as well.
> How do you think we should proceed from here?
> Maybe revert the whole patchset first?
> And then send a fix up patch after?

Can we just do a patch to fix things as they stand now?

--=20
Tom

--bBvVOHdUGl6Kjmvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgvSLoACgkQFHw5/5Y0
tyzolwv/dhYNztWEvz55F6H5Ul1v3CVo+8VyHIWyim6P09ANjYbewV3K7FGXx8BD
esyE9Lq6RwFfpewER8VI7HYsQzVxhBc5GkK5UcRze6KXEG+c4TDDQg/DHpt/MeQN
ly1lLmPZB6qljIrrFx5S6geuuT0S5zmCxmqKEox9PmBsWApG+wMtdMj+5zDGCQJK
i0AN0PKmMpC2DdOZG6GHD8U3l3IJWJLW2goHSXGwcILzRfRDU4FlA/8FK5Cs01yM
2rxzP6j1qcpivVKHWdO9s+IwxU8yteJrtY/SBNPpReYwIvDLCJawn4aewv3qnnj2
0l6ysGNFUQttmA8STBDCncHAIu8hWiRBvFC76x5DHvESmMp29sZFGaFZUxd+BmcQ
gfUS153LN55tx7j1gypZ43h+pfNb15q0Qid3bcj8OfU1gzd0HIAqbrRJK9ZcfzHq
qNmHS0h+ToaCnvPX2v1OZb2UjktbtAiXNPVMd41buue9RtZ8eys+zyVisdTYu+7F
wP7gftpd
=RAVw
-----END PGP SIGNATURE-----

--bBvVOHdUGl6Kjmvi--
