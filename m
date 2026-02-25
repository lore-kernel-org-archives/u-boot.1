Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAD9F55436
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 00:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 098A683D8A;
	Wed, 25 Feb 2026 01:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UrK53PYS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECBEF83DCB; Wed, 25 Feb 2026 01:48:44 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD5983C39
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 01:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d4c307db9aso3485912a34.3
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 16:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771980521; x=1772585321; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xZO5p+Sisyu0HgMuxifPdGXUoT/7i5Z5lBFBXlE80X4=;
 b=UrK53PYSbnvrcm8JyrOufap+NYUJknTqObKaZCWg8IYPQPtJFceJ2BtITH4uIKqGsc
 3CyXJyY6dpwQMY2uylFzYE/ATdIhlFn8jR12GSMZtDKxaFauwjgOJx0Xtd8a2VrdI3Wo
 EIbnHSZeMLeBwEb8/QaF6oWe+C4RINXX31+Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771980521; x=1772585321;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xZO5p+Sisyu0HgMuxifPdGXUoT/7i5Z5lBFBXlE80X4=;
 b=iDIZyJgT8YjjB+NTxRIadRmqtx9WdExcXdlMR1X/ohTqfse/Ikh9RGQHEYcEssvl68
 MfdFesJEGgvj694AstcbC/iUdeY3of7NfLoHlXIs34e+nuz7KZQ1HdAjF7qQ3PBSEt70
 RD+WNkuy2QHp66kXwG8JdQZH/Ua1zH65mnsP6OaODPX4Mhv3lO6XG8pIknl5IIOFi13p
 N5TwRYsJ+caCabKPUgeo5G5wX+synLp3PFQd7PA3EkddU74W/CSbhEqVGfjvARd+mZtK
 Lf/qiug8SqBmSLUMgm1WjUfarRiM18mr2MGKVly/SW7mmChdg2ivoDUWUM9wncr08U9F
 w2dw==
X-Gm-Message-State: AOJu0YxqrYNz1c03NpmIRckorjJcDQNA0Eu/Ob/MFJIMqCRtiGc5iP/x
 FI623m9lDA4OcraMtExAxa1SgeG8JoU4+AnTtuFI2ZI6r1ddcfz3JObPqFojBsNN9x8=
X-Gm-Gg: AZuq6aKr+MNZZP6qjTO0iz1KEq7SA4qrcAkGtcX8dDDfMb19WqTDc4KfACF+XokfdMl
 fEbP/dBa2WUt/DFyZWR7aPkDZXgmbPPBydeJQgwp25muLeqLK6DJgeNmL3iM1C0oZAa5JUufseD
 OjTDB0qeB0x2qGHuYS0J/ygvkKToROYVVcc4q2/54IYmg3/2/SFVUJF3e73Lxtm2cjsob+aNmAZ
 PCfne0Y4AM88wu9I2iLYBfgfA1tqAOPFo20aRlNqCmTs5Whf04YFlK29L2FV+2njygngKH6DLn9
 XryvqpsVgF719PZtIXEPGCKsEItMB2/rMfP3vzsllS6oylYNecTxL4AycWe15n8cIkB5Xj7Y2dO
 FTcNI2GgNq4ODFXMwzYZdAe9NE81L7M20nbHnijrevYnBs1Q/ymw6PyjihhWI2SmSIIU83Eeoek
 wcycBIbIYifhxdjuyi/pFjw1UvYioem3zgW+MDKNDYLjFdwVXR0HFJxmt1pd8YS1zveZenKO8DZ
 8Bb0oI+iWy7ZGobPNav39rzEkLg71POSxI184tb1k8DenYS99Y=
X-Received: by 2002:a05:6830:4994:b0:7d1:96e1:ddc4 with SMTP id
 46e09a7af769-7d57a295b81mr296351a34.33.1771980520989; 
 Tue, 24 Feb 2026 16:48:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-415e68abeb3sm1368127fac.20.2026.02.24.16.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 16:48:40 -0800 (PST)
Date: Tue, 24 Feb 2026 18:48:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Johannes Krottmayer <krotti83@proton.me>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: QEMU: arm64: bloblist not found and alloc space exhausted
Message-ID: <20260225004838.GA1593142@bill-the-cat>
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
 <20260224170908.GZ3233182@bill-the-cat>
 <37429ec3-d174-44d3-b113-bf6ce6d71096@proton.me>
 <20260224193312.GB3233182@bill-the-cat>
 <02e49242-da72-4bcd-a428-f7e8c9aee742@proton.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QT6GOgaas4wvKSZK"
Content-Disposition: inline
In-Reply-To: <02e49242-da72-4bcd-a428-f7e8c9aee742@proton.me>
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


--QT6GOgaas4wvKSZK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 12:14:39AM +0000, Johannes Krottmayer wrote:
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
> I have created a pre-patch for the doc. As maintainer I see you with the
> script get_maintainer.pl:
>=20
> $ ./scripts/get_maintainer.pl ./doc/board/emulation/qemu-arm.rst
> Tom Rini <trini@konsulko.com> (maintainer:THE REST)
> u-boot@lists.dTuomasenx.de (open list)
> $
>=20
> Created was the file by Tuomas Tynkkynen. Should I send (CC) the patch
> to him too?

Yes please. And Tuomas, can you please update
board/emulation/qemu-arm/MAINTAINERS to list the doc files as well?

--=20
Tom

--QT6GOgaas4wvKSZK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ5G3QAKCRAr4qD1Cr/k
CqMHAP0a/BAphzlfKPa0ESiJgh9uGacv175+yN5YpVfZQ35lVgEAsu4C9qiz/K5x
zCgnBCtWDY7wLu1S/gQ7U74qaPw4QgI=
=VzFU
-----END PGP SIGNATURE-----

--QT6GOgaas4wvKSZK--
