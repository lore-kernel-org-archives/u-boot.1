Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A7CF4BB82
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 19:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B908683642;
	Tue, 24 Feb 2026 20:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EynPPra4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A3A083D8A; Tue, 24 Feb 2026 20:52:59 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D081882BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 20:52:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-45f10d7eb81so2389118b6e.3
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 11:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771962775; x=1772567575; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VFRVLOjjBUrp1xCaewdrCGXnqMsC2FnBNhkkWn/t0NA=;
 b=EynPPra4d5DDg/P80qUtUubz9hmNU6Bvgl7bqbuLCNH1bItL3KTgzsryaAKEA8+ii9
 WQ1sJVRjaeyxLc2HxPts9iHuBbXjhcWHKQicO9FmDxQbnRrt74jMjnZWa22+bK3ZgoZ2
 XbuhaGDc3Rlu7tleFKeSstQhWE98XttAHej7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771962775; x=1772567575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFRVLOjjBUrp1xCaewdrCGXnqMsC2FnBNhkkWn/t0NA=;
 b=etBUQ+bLHSMLnrrks/Re4UgGPh8GOzSD4u8ThFTErn1+T1g3JnMalSiF5MQGASWoTy
 agEM3btWKWfHeiQxb6+K1myox7Bov2W6Blzrlb5gtUYqvGXUUe3jZGGD9IPEkuJDSlND
 8J0ic4osdfGyficnVXLRzLlFclmPlDMv+NJQDGpP22ZcgsrM7dhwvqnnUOcj2yFvPp1m
 yt5TdT8vn1Ata6LzNyeHTjNviE6l7E4yYZIgW1YsWZDyo5vYC66phpzrCluarpCP/+xt
 TMUpwkS7FbUdSFNCMSSmEemvQ4s4HjYFM0u3xlJgNHVy1gw+QUnOyZa5qwINX8Eii+3h
 FJIA==
X-Gm-Message-State: AOJu0YzTOtaDi068xmF/M8rUAf3EtRPg7OdHX+ScbMOvClGMHTLCkbWr
 znGHF/AgjydrhH+UHQacufF6Nj20dt6ztMtq4xgUgTAYCfZGcWX0mKINx2GvETodPgHTzLIZyAG
 7uqUK7K0=
X-Gm-Gg: AZuq6aJrY+et1WPEOsxmGiBU8+8fZDngS9u91t/qCMlVnZyFHZiCAXPHU33NRD/NIxo
 u0EZnwknVagDf2UKE4o42EUM0025YX6kJvm+e28mcBGFH7DVVDckstMEZmlVBwNnt0K2pRiCMGS
 v/KnYD74CgWREYgjJyAV53ytt3y766NQF0qMdI/MtIvbmEKOupcN1pQLVOlwdx4iad4+OSvqGwg
 yuhGRgJIr3VObcH3pM6UsDvuHQS2r2wv8FuN1wa71WUJs3UpseGymK7twLWu8LNCEylRlOitITF
 C3ev99bVN+ny6hWhTXbW2cnyK3ZP+GYy2Cc8uHBF7gYA1/dbbca+XJ/hpSIlVtcHYWRs1HuUQcd
 A56GhueHqa0NqmjJyde4ooyWLDvSL4sCGxpdm+GLb7CYgs2hiBylqWRkf5RVVgp63MA5ST0karw
 /o9FJyfA3/D7tlnRI+SusAkocqeAPLb3KM9eiglu+43jXpZI6PzzhgTvTpfE3RNeChtzas+vjOK
 IcoUVzwrVn3UKkzJnDwtXqgdTGs6Jg86/gZl4niOUZIkkMiQc4Ow23NvfjhjA==
X-Received: by 2002:a05:6820:4410:b0:662:f759:4eac with SMTP id
 006d021491bc7-679c448de8bmr4836592eaf.32.1771962775307; 
 Tue, 24 Feb 2026 11:52:55 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679c56ec619sm9098923eaf.13.2026.02.24.11.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 11:52:54 -0800 (PST)
Date: Tue, 24 Feb 2026 13:52:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Johannes Krottmayer <krotti83@proton.me>
Cc: u-boot@lists.denx.de
Subject: Re: QEMU: arm64: bloblist not found and alloc space exhausted
Message-ID: <20260224195252.GD3233182@bill-the-cat>
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
 <20260224170908.GZ3233182@bill-the-cat>
 <37429ec3-d174-44d3-b113-bf6ce6d71096@proton.me>
 <20260224193312.GB3233182@bill-the-cat>
 <2e07b2ea-2c5c-40de-ab27-ed1234c3bdab@proton.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HQoxHCSfTfgjqdCz"
Content-Disposition: inline
In-Reply-To: <2e07b2ea-2c5c-40de-ab27-ed1234c3bdab@proton.me>
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


--HQoxHCSfTfgjqdCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 07:51:22PM +0000, Johannes Krottmayer wrote:
> Hello Tom!
>=20
> On 2/24/26 8:33 PM, Tom Rini wrote:
> > On Tue, Feb 24, 2026 at 07:23:54PM +0000, Johannes Krottmayer wrote:
> > > Hello Tom!
> > >=20
> > > On 2/24/26 6:09 PM, Tom Rini wrote:
> > > > On Tue, Feb 24, 2026 at 10:26:35AM +0000, Johannes Krottmayer wrote:
> > > >=20
> > > > > Hello,
> > > > >=20
> > > > > I'm tried to compile U-Boot for an QEMU AArch64 environment, but =
get
> > > > > some error messages in SPL:
> > > > >=20
> > > > > --
> > > > > Bloblist at 0 not found (err=3D-2)
> > > > > alloc space exhausted ptr 400 limit 0
> > > > > Bloblist at 0 not found (err=3D-2)
> > > > >=20
> > > > >=20
> > > > > U-Boot 2026.01 (Feb 24 2026 - 10:22:15 +0100)
> > > > > [...]
> > > > > --
> > > > >=20
> > > > > Started the QEMU instance with the command line:
> > > > > $ qemu-system-aarch64 -m 4G -machine virt -cpu cortex-a53 /
> > > > > bios u-boot.bin
> > > > > $
> > > > >=20
> > > > > Also the same errors when I use TF-A and OP-TEE with enabled
> > > > > EL3 and EL2 in QEMU and "u-boot.bin" as BL33.
> > > > >=20
> > > > > Has somebody noticed the same issue?
> > > > >=20
> > > > > I used the configuration "qemu_arm64_defconfig"
> .
> > > >=20
> > > > That's odd. We run it in CI, but as cortex-a57 not a53 with otherwi=
se
> > > > similar arguments. Running with TF-A/OP-TEE is also in CI, but more
> > > > difficult to configure.
> > > >=20
> > >=20
> > > I have tried it now with the Cortex-A57 but running into the same
> > > issue without OP-TEE and TF-A. Using OP-TEE and TF-A works now
> > > without the issue because I have forgotten to pass the option
> > > TRANSFER_LIST=3D1 to TF-A and CFG_TRANSFER_LIST=3Dy and
> > > CFG_MAP_EXT_DT_SECURE=3Dy to OP-TEE.
> > >=20
> > > Host OS: Debian 13 (Trixie)
> > > QEMU version:
> > > $ qemu-system-aarch64 --version
> > > QEMU emulator version 10.0.7 (Debian 1:10.0.7+ds-0+deb13u1+b1)
> > > Copyright (c) 2003-2025 Fabrice Bellard and the QEMU Project develope=
rs
> > > $
> > >=20
> > > BTW: doc/board/emulation/qemu-arm.rst doesn't mention how to build
> > > U-Boot with OP-TEE and TF-A. Should I include the build steps into the
> > > docs and create a patch for the doc? I think it's also useful for
> > > other users.
> >=20
> > Yes, some doc updates woul
> d be appreciated and please CC the board
> > maintainers as well. And perhaps the question I forgot to ask earlier
> > is, are you seeing those as fatal errors, or just noting they exist?
> >=20
>=20
> My personal opinion:
>=20
> I see the "bloblist not found" personally only as
> warning. But I think the memory allocation issue should be
> investigated and maybe fixed, because I think it could have
> site effects.
>=20
> But I don't know the memory allocation code fully from U-Boot,
> so therefore the "site effects" is only a guess as normal user.

Ah, yes, thank you. Yes, it's a bit scarrier of a message than is
warranted and we should look in to clarifying things. I seem to recall
it's just what happens in the case of having started and no bloblist
found, but not expected. I'll dig around a bit more myself now.

--=20
Tom

--HQoxHCSfTfgjqdCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ4BlAAKCRAr4qD1Cr/k
Cr8xAP9emUFiB2PcQ6sjA6i1lYkiJdNX54p5rqXfRgT3iQWVsAEAiHdRv2CnZTQJ
LKRmN9q0mmr8ozxVy7UvKOJAYdDe+Q0=
=AhJT
-----END PGP SIGNATURE-----

--HQoxHCSfTfgjqdCz--
