Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A564C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 02:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1558B87536;
	Sat,  9 Dec 2023 03:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iF5hZxko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB3087620; Sat,  9 Dec 2023 03:59:44 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 338B587215
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 03:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-db547d3631fso3112048276.1
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 18:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702090780; x=1702695580; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L5lF7rG5MRWAdFMoWAxOOvr7zm7Bkc6gO2OPJFh3+bo=;
 b=iF5hZxkox55o6P030ZWzL4moB6niQpWGEtoVwuQFJvHL+MXnb998SJOilRgio8AxJ2
 UInHY+kcCP5RUQrUqOB23egOCOcc9giTfuajfrSB80rVp6OEhFFkGuwLADYeTA7hTKet
 QVa1TuKekAaVk8cROC3rWvNEY4iiL3m5Zmfyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702090780; x=1702695580;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5lF7rG5MRWAdFMoWAxOOvr7zm7Bkc6gO2OPJFh3+bo=;
 b=GecaRdAMLxYsLa3u3yH3rnGog97xuKPTqZe/WpKi6IHqgxfGUjaB1rfRrJ9n4R8/iL
 13BO2p8PETrPVxsyDGrjTqQj2mLmYAOYsrbybUF1Ml1x556MoZHVjTw4GWoHNLcaoRJz
 Hi20JwMjkxlR0qkwdTJCeozBjBt3JSBG+nOWPyFV3oGfXoW26k+rOCs1uCZqyAlDtfSG
 NMiwtuYi8sunuvuyrAnZ+v3zOnnrltIN2BdtpF5vBRYrRxORkd5NAwyutLG8uV9Rg3gl
 D2R+zktzPCwNqK0orVN6mF2C8a5eJaei3XQHMo6qKkAOgPtp9H6Svd3hr8uyq6ioWzmg
 T3zA==
X-Gm-Message-State: AOJu0YwZ0kBsUVBzslu6jgSsTjChZnI2e82Lke7n1xJM4rUK2QYEIojj
 AHaKi8mKR0UwVYLYq0iI8jSpZA==
X-Google-Smtp-Source: AGHT+IHSQ0JzXo01eW5+alDQ5pk2KeFWmXbY739pZMl23uTKFsF2lg6BJssnlv1L7HhWtYrdaRzDIQ==
X-Received: by 2002:a25:25c1:0:b0:db7:dad0:60f4 with SMTP id
 l184-20020a2525c1000000b00db7dad060f4mr824005ybl.129.1702090779803; 
 Fri, 08 Dec 2023 18:59:39 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 i20-20020a056902069400b00da076458395sm1006619ybt.43.2023.12.08.18.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 18:59:39 -0800 (PST)
Date: Fri, 8 Dec 2023 21:59:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: Pull request efi-2024-01-rc5
Message-ID: <20231209025937.GZ2513409@bill-the-cat>
References: <90412dba-5f89-4cfd-aee4-05092a81e394@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d3yq16LTCOh6h1mK"
Content-Disposition: inline
In-Reply-To: <90412dba-5f89-4cfd-aee4-05092a81e394@canonical.com>
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


--d3yq16LTCOh6h1mK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 03:43:34AM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 2f0282922b2c458eea7f85c500a948a587437b=
63:
>=20
>   Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-01-rc5
>=20
> for you to fetch changes up to 6805b4dbad72a6e9180426c50f6db6e2681430c0:
>=20
>   efi_loader: Make DisconnectController follow the EFI spec (2023-12-05
> 01:38:56 +0100)
>=20
> Gitlab CI did now show any issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/18800
>=20

Applied to u-boot/master, thanks!

> The following changes since commit 2f0282922b2c458eea7f85c500a948a587437b=
63:
>=20
>   Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git tags/efi-2024-0=
1-rc5
>=20
> for you to fetch changes up to 6805b4dbad72a6e9180426c50f6db6e2681430c0:
>=20
>   efi_loader: Make DisconnectController follow the EFI spec (2023-12-05 0=
1:38:56 +0100)
>=20
> ----------------------------------------------------------------
> Pull request efi-2024-01-rc5
>=20
> Documentation:
>=20
> * Update and correct support notes on clang
> * sandbox: Fix VPL instructions
>=20
> UEFI:
>=20
> * Fix a bug in DisconnectController
> * Provide better error messages for missing CONFIG_EFI_CAPSULE_ESL_FILE
> * Create EFI memory reservations when booting via ACPI
> * Make ACPI tables accessible in EFI app
>=20
> ----------------------------------------------------------------
> Heinrich Schuchardt (1):
>       efi_loader: create memory reservations in ACPI case
>=20
> Ilias Apalodimas (1):
>       efi_loader: Make DisconnectController follow the EFI spec
>=20
> Masahisa Kojima (1):
>       scripts/Makefile.lib: print error when no public key is specified
>=20
> Mattijs Korpershoek (1):
>       doc: sending_patches.rst: s/Superseeded/Superseded
>=20
> Simon Glass (3):
>       sandbox: Fix VPL instructions
>       efi: Collect the ACPI tables in the app
>       efi: Correct display of table GUIDs
>=20
> Tom Rini (1):
>       doc: clang: Update and correct support notes
>=20
>  cmd/bootefi.c                   | 25 +++++++++------------
>  cmd/efi_common.c                |  4 +---
>  doc/arch/sandbox/sandbox.rst    | 50 +++++++++++++++++++++++++++++++++++=
+++---
>  doc/build/clang.rst             | 22 +++++++++---------
>  doc/develop/sending_patches.rst |  4 ++--
>  lib/efi/efi_app.c               | 24 +++++++++++++++++---
>  lib/efi_loader/Makefile         |  2 --
>  lib/efi_loader/efi_boottime.c   | 27 +++++++++-------------
>  scripts/Makefile.lib            |  5 +++++
>  9 files changed, 106 insertions(+), 57 deletions(-)


--=20
Tom

--d3yq16LTCOh6h1mK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVz2BkACgkQFHw5/5Y0
tyxr7AwAuUMjEstKSg6VOmE0iYe9/in6B7mHyE5LdJ82ZFE6iNZG89vu9lXneCxb
pyd4jAMz0Q2TVQXY+b9SL13gODmWJ69iorDIHN5m8c9XDPBn5nDgx/MbAZMc26zB
hUseBbVS+F70db31t6aGtYHu4FgH43MUReCKWP7P4C1pnufSsFYGE8477qcBWIuP
D6Tfk+TZ2/c3mwQWqQ0qTSZ29dJLNefsIomcDy8RbXy3c5915ZZ/oXp9hBfXqDos
be0OgVPLrHfgQxnWoIVYdAhvZNopBgl6/8cpb24QHOyx9X5Uehch391rEnzj6RPC
toKmpTggF1iH4cG1yTsNVeMAegFUS7bpm9Y2x7qGXF4nGE/CrvWLpxpX1P5dkWX8
81y/dgzx4Vmj+UIz9AWEUy13TasviDJNKUe4KQ1hoLoaQNz1N0Bn0dijdEx8JrxK
i00PrQ5tUNb5p0so5pGtUVuQAQAQOstR77FE+WMVGrzj/Hs22AqwBqZuLigS60MM
bZZAePjU
=ul9/
-----END PGP SIGNATURE-----

--d3yq16LTCOh6h1mK--
