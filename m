Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92919C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 05:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC4FC80548;
	Sat, 22 Feb 2025 06:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fsPfH72O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39B21806FE; Fri, 21 Feb 2025 21:45:41 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D53A0800C1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 21:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-221057b6ac4so50153585ad.2
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 12:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740170737; x=1740775537; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aHu89kEWIP4ux7IRGl1SmphIhLQGgAoBnkaVFkGkzIc=;
 b=fsPfH72OIGTyn9fpLMAR1HkyD9SNGndkM6UBud6pTpjoAOEbmu6JL0SPKpdvtGXjnP
 2hdHNCx21WWR/Ct0RTpbdx8Vs/+Pnx4DpHJXfuIdlgAb7Er2SbLgQCg8ZHTlstAl/yBT
 Q738O8D7WeKlblWU8RU9n2ezcbIAyE927pgvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740170737; x=1740775537;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aHu89kEWIP4ux7IRGl1SmphIhLQGgAoBnkaVFkGkzIc=;
 b=WQchVBoJgvanM7cGrFpDO4P804gxMAM0HrLq9tkL5FSivg8Cd9WHkkBD8r++9sXrUC
 8NjfXuumqNc3OSwBohNUW6Mt3brSWKeL2c/TRZ9U95tGb/AZPOTpELENwB30bvmZSA0q
 PV/9hCfL75j2UnZOf0axsR3nbJxbItDhrEF+jtwLxo5uyCUIt4+7SBE0YNsfJARQExrK
 HPiPB9HZmSAbeGKIdqjBCo8XNAwahlQ4SYyrU3Pul+NNoTKsOwMTDAlocm+cDSztQ0IV
 gAWeTOFSgehfozNlg66lh89Z7iv74XNAiUeNOI9LirNQeA+T+d+CnTpzi2uULnbC8VCq
 1Qgg==
X-Gm-Message-State: AOJu0Yw5Z/AhHA9kaH9PODuyCDNSeEsN+gn2prbUElc6rbrEOHWOMiIb
 w7C9na0fhdoGjxvL5ppafXHKgP0ndRQByW1U2K9M9IQVlQIzrXoHkwsMsJwOMc0=
X-Gm-Gg: ASbGncuvPtk697gCe19YcByzW8EezgBo3lCdCLFrFCYew7f466imRm8mQxLQFOytgTn
 xTy0CtZ1N1Il23jVff4qf3rVi0CCYSNDrBC2csJj0tUJ5SzCZXRheoORgwP8GQXvnE6of41xDeL
 YdhvvgHwl86xpvBv7F8/oOHGIxI+7EPs+OgcHf7mWReIye8og4gq+QtE17iMYCrspcFrCPNWOFh
 ywWWa7cEieIrTc28da01lABInj1IzugSAWhS2Hp+vcp5IFxBpbz3CfEErwOyGBKcAPh20DbMi1K
 iavY4QwkSwGFi71m6w/MA9+y
X-Google-Smtp-Source: AGHT+IGRZRrJEENORt2j/XGgXIpeZELYncjzIEriAiVbSIBOW92m++q0gmnxGjm2aXFM/B3qzGRH8w==
X-Received: by 2002:a17:902:ea0a:b0:216:393b:23d4 with SMTP id
 d9443c01a7336-221a0ec9a77mr64291445ad.11.1740170737378; 
 Fri, 21 Feb 2025 12:45:37 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm93617055ad.182.2025.02.21.12.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 12:45:36 -0800 (PST)
Date: Fri, 21 Feb 2025 14:45:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Anton Bambura <jenneron@protonmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>, Janne Grunau <j@jannau.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Masahiro Yamada <masahiroy@kernel.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Weinberger <richard@nod.at>, Rick Chen <rick@andestech.com>,
 Sam Edwards <CFSworks@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Trevor Woerner <twoerner@gmail.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v4 00/29] arm: Support building as an EFI app
Message-ID: <20250221204531.GS1233568@bill-the-cat>
References: <20250215032254.4121030-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OxvZB89BWlQo200Z"
Content-Disposition: inline
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sat, 22 Feb 2025 06:35:05 +0100
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


--OxvZB89BWlQo200Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 08:22:21PM -0700, Simon Glass wrote:

> The original x86 EFI-app was written back in 2015, about a year before
> the EFI-loader was introduced. At that point, ARM mostly used U-Boot and
> FIT (Flat Image Tree).
>=20
> Today, sadly, there are a few efforts to re-invent FIT poorly, to cater
> to more primitive boot-environments than U-Boot. One justification for
> this re-invetion has been that EDK2 did not support FIT.
>=20
> EDK2 does now support FIT but only for the firmware stage. Even then,
> vendors tend to use their own forks, so any new features are slow to
> make it into the market.
>=20
> EDK2 also supports the ext4 filesystem, but many devices don't include
> that feature, so most distros make use of FAT for storing their boot
> files. Since FAT is not journalled, it is not particularly reliable in
> the face of reset, power failure, etc.
>=20
> As an interim measure, we can use U-Boot as an EFI app running on top of
> whatever EDK2 fork is in use. This allows use of modern features such as
> FIT and filesystems other than FAT. So far this only supports x86, but
> recent ARM laptops are making use of EFI too.
>=20
> So this series adds an EFI app for 64-bit ARM.
>=20
> Note: Since U-Boot does not support EFI's GOP 'blt-only' mode, the
> vidconsole does not operate, but it can still be used, since EDK2
> handles drawing instead of U-Boot. As a result, the U-Boot logo is not
> shown.

You did miss some of the tags I provided against v3, fwiw.

--=20
Tom

--OxvZB89BWlQo200Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme45ecACgkQFHw5/5Y0
tyy2TQv/VTjQ1tpZQKh9xTb6W7I2x0jHKtixunSKO5VdD+cOKnmzTkbvtxLU2bBm
M8I/rP1Ohmltegqh+134IO98sKaUg17Hl+huevDS5qdvDyBuUePoG88JXYJ27Z4g
JjUTBxv4X4Kbi0DinOUB/WVbHNdkriOFDU6seLXqlX8jR/BmV5Pme98OU1jTfYo3
BmYPUG6eUQfB+S+yL7I9/9nmurNNB77S4VlQhysHnaYc8o1wruBHUl6Aiwsuz7vM
d6L5oO8iAN7J4POIniOmr9GQrjQvUsyxMxrUCsJ2UBBBA7TXWYYwEQFDtNVNL5+z
3ZmEGOxDdCW9RS3GWJKP+ZFziWXwHUX2dap7aBEJRDQrRGmivjqIkKxxZxFNkGMP
ElyzT4PGHMCo0Z/MB3vs1O9PdEW8qJ8dom1EK7I1VcWNH1zISYl026B/D7qmQ1yR
JS+kK9w333F3hqObqvy/gxlHdzkgVhbJN43N+2sldHo7Law67HZrFmqsrPNJ51Z1
RsTzr6bV
=WaYg
-----END PGP SIGNATURE-----

--OxvZB89BWlQo200Z--
