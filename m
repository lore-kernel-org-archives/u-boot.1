Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCBFC48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 13:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE04987DF4;
	Thu, 15 Feb 2024 14:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t06clLVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C92787DC5; Thu, 15 Feb 2024 14:13:20 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2284F87DEC
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 14:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6079d44b02bso8333637b3.3
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 05:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708002790; x=1708607590; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U9jprutVfeSZ1LrsSW2N1XeqnUQUWklDTGOfsJ4DhvU=;
 b=t06clLVJprIM6lCkL+me/r+da1P3PQB8IZTFrsb1xdKmoViwbbT3G0vPVWx0oDnk6R
 9xelEc47/ToEULpxVMElmf0gmuVK8IOXY+aEt35fV8CXk15junRXuJzoPMVc3XVc/fHc
 otx65YK1rUoyiVaCstOZnZr03ryXkCnbXbfCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708002790; x=1708607590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U9jprutVfeSZ1LrsSW2N1XeqnUQUWklDTGOfsJ4DhvU=;
 b=kBSavNB1L7neI4CT1PFMPCB4vUijp8jI60F7J6MMeKc/H/nMs/gyBmZNoGFR7OmTtB
 pgkF+Zoou2391E6pv+iOhCIvP31neZ3Nx2nB6M6WyZeYzBP5Qx9ziOCCd9hez0xtYRSx
 F5vlBVWpGMaKy6DM3U9QeDV17ASmV93NUgmSkxAM2wSk/hf4HCNpa8yBpGyWzvCCGigH
 cQvjv9KKA1yaqVxG2zP+o/BmKipy6ZmYO/t97ISsU98QhxXmN0b270RCGt1T9qkpyrXf
 Nn4f3CaGCadkJ+HfveWt7RTKQsMEyiRVM95OiDmPtdc2x1LdUMJjsuydfOhEPqcWC42z
 7GfQ==
X-Gm-Message-State: AOJu0YyBKfc0LUhKI5/GD57MizP9VzMq7mzizfvJA2BcWWY5Yb3gN1Rr
 zOYV55uoUlUOlp5+2u2tB2HtUjMFGicTqR47/5LE5jhBNkfJG3Whc1NoPecL3ERW6/jL1QtKbrn
 x
X-Google-Smtp-Source: AGHT+IH4Fh0unxgciMZ0Jpv9qbdcGoSlS4/eutMZZuo5F8tZl0uawqE7Uz9M0mWG8qVCj8XmHAr1LA==
X-Received: by 2002:a81:ae48:0:b0:607:ec67:401d with SMTP id
 g8-20020a81ae48000000b00607ec67401dmr168969ywk.31.1708002790385; 
 Thu, 15 Feb 2024 05:13:10 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 z134-20020a814c8c000000b00607a957c82dsm117562ywa.3.2024.02.15.05.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 05:13:09 -0800 (PST)
Date: Thu, 15 Feb 2024 08:13:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] xilinx patches for v2024.04-rc3
Message-ID: <20240215131308.GB3040305@bill-the-cat>
References: <ff2b2845-9520-4264-bc49-72075736d3b4@monstr.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2yrgR/gEnyNFYP8q"
Content-Disposition: inline
In-Reply-To: <ff2b2845-9520-4264-bc49-72075736d3b4@monstr.eu>
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


--2yrgR/gEnyNFYP8q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 04:59:52PM +0100, Michal Simek wrote:

> Hi Tom,
>=20
> please pull these patches to your branch. Most of them are related to dev=
ice
> tree and aligning with the latest dt schema for SR certification.
> CI is not reporting any issue too.
>=20
> Thanks,
> Michal
>=20
>=20
> The following changes since commit e8f2404e093daf6cc3ac2b3233e3c6770d13e3=
71:
>=20
>   Merge branch 'master-779h0-r2' of
> https://source.denx.de/u-boot/custodians/u-boot-sh (2024-02-11 12:42:25
> -0500)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2024.04-rc3
>=20
> for you to fetch changes up to c2ad5fb616d4e8aa2ac00e224030589847731fbe:
>=20
>   arm64: versal-net: Setup correct addresses of GICR/GICD (2024-02-14
> 11:23:43 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--2yrgR/gEnyNFYP8q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXODeQACgkQFHw5/5Y0
tyznTwv/RNMYYwRhN6/DIc/N3w2AxPSGWxF4oWi8iEiryzAkCjzNcxfImsCbnugI
1z8isOWUSX23OybFKQCyeiDOAEm7wCHljLLbpmT7fcK69VjY5cK2l1TebaCN/q3k
N52BeymcxPR2HkAKM0lkW3inCVeH8Fu7KLtFez7jPacZKbwhq55Klgr6aKYaXNK2
I/eXj5QsFygmhGsPYH8Upv9aUpUWIrVdAhJOcBaRGISQn2qcLUdE3oA5uYjCh1Qa
YGmVYl1HTiu60dUGM/4/fJZKJumKY5Y+XYbTTuML2KC9BeyE7qZi7TSu8X2OckNR
R7d/bHlInygWlwCyAOJUaizqzYaZPdCFriNIBDQe5H4GY/DF6RJ9Omd4Wi3eXnBW
wjGMa70Z8keeRqvpG5l8L2vicMWSgPb12RqfvqOtksSS5gHZlcCK56IMitXyWmX6
+/asxL1jINrB4QE8wJIercqswet+R19rX1i3bVBl7kern7g6NETQ5K/X/+fWpcyJ
jm311G4R
=DEe2
-----END PGP SIGNATURE-----

--2yrgR/gEnyNFYP8q--
