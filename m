Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76A1C47079
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 17:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BAC987A38;
	Tue,  9 Jan 2024 18:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fl1y6RLN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E00BF87A0A; Tue,  9 Jan 2024 18:49:50 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBDAC87942
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 18:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-78314e00337so240237385a.0
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 09:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704822587; x=1705427387; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=INqV2WuyQr7MS2dgarRzTq6q53fXC3goF40zK98J0/Q=;
 b=Fl1y6RLNsCOLYwAhhT3G/SK3JtKbm7twP0oHasc8eHToGyMc151m3UnnCtwCmlQB2x
 wORWX4slYZZqM2M0uS0YyWRzC0AT/I7AnYw6i/30XVUG4H4wpzmUCw1fD5eLZfZbMR0z
 edi2sJEaWuK7Fmzgr4xH9AcANxHLOuUtj04Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704822587; x=1705427387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INqV2WuyQr7MS2dgarRzTq6q53fXC3goF40zK98J0/Q=;
 b=dpIAIN9qKmDuIFnr/LI7P375gqbEQM41Vb429gc5jVOQfH33AybwAOuCCbR4gyAol4
 81rRfcQY/07SEQ7Hfz/Iz4CxhHTLB9aNGrfd6YOkmfA0o6b53b0/Wko1684C2PUW6hTw
 GZOvr/WSMSoOz0fshFodd3CpU5PcRtV/rpOdwfBOG4YBwOb53gcXB5ne1Unr6auR+gVX
 IfydbWueL+VITa6fyB3qVvxyWntGfnGiSIMZKEfPyAU9lUVTNuIlGchX4Yx2BcV8X9g3
 +i0REabTYqkMzyATLcjsVOcnNSylVFCLd28DMVRX3jqcqlWfqLwJztjVv1TVRrSRML99
 AJ1Q==
X-Gm-Message-State: AOJu0Yzg/LI2cwLyMjUb/OkqQzwxiTxinv5RbKk2GkeFyk/8e4DcphrH
 A/q97u5DY+2aZtv5WkR07O1eZPiYADZPIA==
X-Google-Smtp-Source: AGHT+IF/2MTLtYKLIW+u2U1mxs5l/NJYjX0yBnJ0dGPWPd4Ev1lzpUDJrTUL6nnxLhY77vk4BebG+A==
X-Received: by 2002:a05:620a:4251:b0:77d:9c23:46c5 with SMTP id
 w17-20020a05620a425100b0077d9c2346c5mr6955496qko.22.1704822587619; 
 Tue, 09 Jan 2024 09:49:47 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 e9-20020a37ac09000000b00781d3f29215sm965772qkm.91.2024.01.09.09.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 09:49:47 -0800 (PST)
Date: Tue, 9 Jan 2024 12:49:45 -0500
From: Tom Rini <trini@konsulko.com>
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de, promsoft@gmail.com
Subject: Re: Please pull u-boot-samsung master
Message-ID: <20240109174945.GV1610741@bill-the-cat>
References: <CGME20240109015516epcas1p368e48c6d3e2433577bf7d0684966c45b@epcas1p3.samsung.com>
 <0a3d01da429e$e4427ec0$acc77c40$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X0mRMReG20h64Jn+"
Content-Disposition: inline
In-Reply-To: <0a3d01da429e$e4427ec0$acc77c40$@samsung.com>
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


--X0mRMReG20h64Jn+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 10:55:16AM +0900, Minkyu Kang wrote:

> Dear Tom,
>=20
> The following changes since commit 2f0282922b2c458eea7f85c500a948a587437b=
63:
>=20
>   Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)
>=20
> are available in the git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-samsung.git master
>=20
> for you to fetch changes up to 5631d20e2ef1008d55569790f79672ea8cc6894b:
>=20
>   pinctrl: exynos: Convert to use livetree API for fdt access (2023-12-07
> 18:58:48 +0900)
>=20
> ----------------------------------------------------------------
> Sam Protsenko (7):
>       pinctrl: exynos: Improve coding style
>       pinctrl: exynos: Extract pin parsing code into a separate function
>       pinctrl: exynos: Rework pin_to_bank_base() to obtain data by name
>       pinctrl: exynos: Support different register types in pin banks
>       pinctrl: exynos: Refactor handling the pin related dt properties
>       pinctrl: exynos: Reduce variables scope
>       pinctrl: exynos: Convert to use livetree API for fdt access
>=20
> Stefan Bosch (2):
>       common: board_f: change calculation of gd->mon_len to fix s5p4418
> reloc
>       arm: s5p4418: fix relocation of vectors

Taking just the pincttrl changes here (as I know this blocks other work)
I've taken that and I assume Stefan will fix microblaze shortly and then
his work can be picked up.

--=20
Tom

--X0mRMReG20h64Jn+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWdhzkACgkQFHw5/5Y0
tyw8+Av+JHpVzbZbiS2UM6zdvr7S2/86rRC/U1vS1ZkYW1kiB4eFLztft3tQxwb/
XXyKxrX+tkW7SIWZImt1gOUVdmhsaG0sUFIDb7b3yvn+ZFPQ2gHqMqW7xPpNFDne
Pz2OmLBZLWTaVZXUftvvt1D355EFNJg5Xmf74quJf/tSXMAZPC12uZExWimk15zc
5iN2NALTDBUhqNVX9FnlAM9Aw8rnoAXAsOMrvGXH7g8IqtObSDqd/1wbD0yEeJRv
U/sR+7ansuJeQVvUYnWaox9zon4A0Rith8qDA9bejODm+rbPpqNa/P0CThJJbzNP
nvjLyFO/sRwbk3aoBpaTiK7I4USOhf6z8YHsHJJyYEtxmdRiwRZnj/QlzmlvKWQC
v85WYqYa9lsku/9EKaXdjRNx/VB1NR8h4WoF3JSnO9G6OMVwiOMLV5yxRC/O+HrP
ztrIYB6dlJ4AS76CWmRu/VU80alXEG/2LVHgkqBeU9UwOA+Rd400yaO96wcgYU76
N2qVljod
=MEuR
-----END PGP SIGNATURE-----

--X0mRMReG20h64Jn+--
