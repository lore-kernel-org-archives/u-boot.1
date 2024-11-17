Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F988D68BF6
	for <u-boot@archiver.kernel.org>; Sun, 17 Nov 2024 02:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49AB3888BE;
	Sun, 17 Nov 2024 03:54:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iyjE/zNk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6493088901; Sun, 17 Nov 2024 03:54:01 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47CA388875
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 03:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-460c2418e37so16971981cf.0
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 18:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731812038; x=1732416838; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7bB0hXaSpPY1li0x1uIHXuI8syAac8FcQyNLtrPjHak=;
 b=iyjE/zNk2UTqhZws5q5UtQQXwUE+rj6X5Yq9Ea6lluC9g7bPemGI4k8kb9t7LCxbQd
 ONw+xMri9EIUn+ZwF45oncmHyXWnJw4wuQban5WecI9s1eIuWWOVHb8dpGf6zO9TPN6v
 pkLy154V1hrJL3jbuae6K6XPck/RE+c2fnQSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731812038; x=1732416838;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7bB0hXaSpPY1li0x1uIHXuI8syAac8FcQyNLtrPjHak=;
 b=A/j5WW6fvSWsvaE4QThC5UPn9BNA60m4RQgTUmNDtDnR4EjWSiz/OWB7FcfpewHUt5
 R28ur8sEKRpzj33rMXxB3cRlpNlOWjuNq8oSCexQ7yygIKM44DCFcA0zOdWaiaIUUrT7
 aVonP18fVxHXjMcH3eJPpXec16LhGxCh7w0scgVMcNCZcq1b8dhcf6Tj1qfb4WVvtZOj
 +WVNzP7qcI7j7ACmAB4mfsgzK7WhRzUzQaPbuaNgvS72EGKsHaWk/bZQ9/FNqhmcHegZ
 2H4cumvpt9vENUYwlqfKLdXLwuOHBWTi98FA5ihoEEbXkwlyNDN0z187zyo0hfusxMhY
 2VzA==
X-Gm-Message-State: AOJu0Yx9lp1MI2QTlmaeMpyPQt98WevCSr2QTfwqhJRk1lkJrQg86H6b
 m6TvwCWfDwJMCT1Kks/ospZHfmXrKgHoJ6OKeB4V98m0KD8vQ7NygSzqYRfxrVA=
X-Google-Smtp-Source: AGHT+IGVsnXTSSVzp6veiccaL2mZN9eaR2IJBfef16cjxJ7VrYyEV23bgQVd2Lo/jiruYbVCDPLaeg==
X-Received: by 2002:a05:622a:5786:b0:461:686:74b0 with SMTP id
 d75a77b69052e-46363e97f6fmr116873721cf.36.1731812038020; 
 Sat, 16 Nov 2024 18:53:58 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635a9c60b9sm39134631cf.16.2024.11.16.18.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Nov 2024 18:53:56 -0800 (PST)
Date: Sat, 16 Nov 2024 20:53:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Yuri Zaporozhets <yuriz@qrv-systems.net>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] bios_emulator: don't select X86EMU_RAW_IO for
 BIOSEMU and SPL_BIOSEMU
Message-ID: <20241117025353.GA3151182@bill-the-cat>
References: <20241103234437.25639-1-yuriz@qrv-systems.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Vo1K+tON5U6/sL8f"
Content-Disposition: inline
In-Reply-To: <20241103234437.25639-1-yuriz@qrv-systems.net>
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


--Vo1K+tON5U6/sL8f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 12:44:36AM +0100, Yuri Zaporozhets wrote:
> The X86EMU_RAW_IO mode can be used only on x86, so don't select this opti=
on

> always, and allow correct compilation of BIOSEMU on other architectures t=
oo.
>=20
> Signed-off-by: Yuri Zaporozhets <yuriz@qrv-systems.net>
> ---
>  drivers/bios_emulator/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/bios_emulator/Kconfig b/drivers/bios_emulator/Kconfig
> index 3660576772..8f73d077f6 100644
> --- a/drivers/bios_emulator/Kconfig
> +++ b/drivers/bios_emulator/Kconfig
> @@ -1,10 +1,8 @@
>  config BIOSEMU
>  	bool
> -	select X86EMU_RAW_IO
> =20
>  config SPL_BIOSEMU
>  	bool
> -	select X86EMU_RAW_IO
> =20
>  config X86EMU_RAW_IO
>  	bool

This breaks building on chromebox_panther for example and I suspect the
answer is to change from removing the select to making it be "select ...
if X86"

--=20
Tom

--Vo1K+tON5U6/sL8f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc5WrYACgkQFHw5/5Y0
tyxb/AwApQaaS/Qjd+mxh+e/V1j0AlzmQuz4onzWtCp/mSBEJb5XCohSWgEjdW98
58gYMKa2UEaV4xaXYU4QJXrAd0zPPkjzOLrnotqX3TXaWlEUNfdt4apAqbSQ4T7B
8oW/rt06B0FAWT/wWFN4xNOFoibdUiulo3qNV+8BTsgKbGQiq5tZQqcpWeq0gmIg
6gcWAcbheGZ2QS8t4qt4ziILH90Uzr6s1SCdG7KOjO0z2u3SyRgW3SKni/JRUX+V
NXgSORuuQQysk5PQdFE6fVDjqeXrOyiVf81RQgu36Ynmxfo9W9h5E1IEk+ykR/un
fSr/5LT/zq5yW4s6AtC6LYL5MtQYu5WFa+MO+jylOvbNCyWVjLs0Be8LIXte9WcX
S/AL0slBrk0ets2KhHj6coOWZiCHtxxqo5xPOefnz6CWQH7XYT2DlPp3gwh1PVKR
Bl6vjXwz4nHla69AZ1ENKZXUDd6lnD1XPrd7Dl15ibx5pxFPcropfLd2yaa+37Eh
KW8N7Slz
=9K7t
-----END PGP SIGNATURE-----

--Vo1K+tON5U6/sL8f--
