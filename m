Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E85CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 14:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EAE286BB4;
	Tue, 17 Oct 2023 16:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R+miIZbN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A133486BB4; Tue, 17 Oct 2023 16:09:31 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09CBF803AC
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 16:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a7eef0b931so70369517b3.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 07:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697551768; x=1698156568; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ik+AJYi6++J1UOa0R4JtRMHneiOYIy0Sdy2Lans/ow0=;
 b=R+miIZbNZ0DafryXzznX7VFoyHldxSMaVDPn+xhUkFJXPwAwj+4hgbyrJ7NaWupmRX
 U1XQHtpj/6ufL/wU0aYzwTMpacA2ppk2Y6DT1cPbIaCr9OF4ScCNEczxQUDWG6PakQ1Y
 mbYEVeJLJZ+VoNTsJhiCwwHhiZ61YpuD9Gny8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551768; x=1698156568;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ik+AJYi6++J1UOa0R4JtRMHneiOYIy0Sdy2Lans/ow0=;
 b=sfg/qHtvEhGky4qpg7Saxc0o4grvK85nteyQrcjycGOqWkNacFj0Imx0FRe3FBDbBt
 pk5Na/I+ECIHPm2rjNEumrx2tScxxFtjY2Z2adKPZdQTXyUsVNDyEdD+lL7AQMh7aLvq
 /mgrDbB2cNfqukN1XaOGgRmMAmuT8Zd8A+YAQVC/bFHFdwQhavTc/O2yXn6dGniAQkHk
 SZsg07o7hw0neLIE/gT6cjlbgpuxNN7gTmnouY4wb34I4V96sQlXimQG5EXzlEcUCfQ/
 3/QtJprjePSvmDqQ4suywNrYv4udaE94c06jCfz65LJw0P77PQmU7czd2yGJcI7Jary6
 TOFw==
X-Gm-Message-State: AOJu0YwO21hMOpHxvJJPhIY6QHVJSOdshO0HC4DKjDJHFWRFSHk5eJGI
 QMpRIGJjCZ5C3PX07PvSkl0vvA==
X-Google-Smtp-Source: AGHT+IGsID2AiEH4keJPXWcnh5w18FaKzuT9PYF9RDpnOu6ZJhSiwQVWUI2ftscFeshui+7ogvFiuQ==
X-Received: by 2002:a0d:d912:0:b0:5a7:b4ab:9d7d with SMTP id
 b18-20020a0dd912000000b005a7b4ab9d7dmr2221756ywe.20.1697551767821; 
 Tue, 17 Oct 2023 07:09:27 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 y135-20020a81a18d000000b0059be3d854b1sm631370ywg.109.2023.10.17.07.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 07:09:27 -0700 (PDT)
Date: Tue, 17 Oct 2023 10:09:25 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
Message-ID: <20231017140925.GB3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uS12SW+5d+x91WG0"
Content-Disposition: inline
In-Reply-To: <20231016222835.596572-23-sjg@chromium.org>
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


--uS12SW+5d+x91WG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:

> Since efi_device_path.c calls eth_get_dev() and assumes that Ethernet is
> available, add it as an explicit dependency.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v2)
>=20
> Changes in v2:
> - Add new patch to update EFI_LOADER to depend on DM_ETH
>=20
>  lib/efi_loader/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 13cad6342c36..fca4b3eef270 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -11,6 +11,7 @@ config EFI_LOADER
>  	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
>  	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
>  	depends on BLK
> +	depends on DM_ETH
>  	depends on !EFI_APP
>  	default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =3D armv8
>  	select CHARSET

Does this work for you Heinrich, or do you want to clarify the
dependencies (and re-organize the code as needed) around networking?

--=20
Tom

--uS12SW+5d+x91WG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUulZUACgkQFHw5/5Y0
tyykRQv/SMcnc46cre/2YFtyLwU91uMDHXyTtr6rA54nAyeL+khWa0PwV4aw/hWh
9Ia49bUkk8FVNG0Zue7xtnCp9M03WGVkN48ZxYx6w1o2j0HIxec9cTodDrYOUIZ5
49mnIolP1OlrgLCgaL7qfUWEDU84UVRCU9JM9sgGh8HC1vurWSWtyIiZlCKOCdp6
F/j4NQTQ1JcKJfrW5Nbg1k9T9EjX2HddrWzf91oV9C6hTSNdsUeLoHMG2N9dzOZL
L0L1NW8F9yK3efSSWoIh8OpX/sgahFHIRgNVPIzsCitkd/iTZiHdbwRwDfV0VGlB
G5vTjcdELhqgMuir+sezuHBoS9cyEskcXN8xc3t5iLQVwOYOIk+e9SIdK1wFXq9g
u4KZUi0rCmcFg6eYBKGGYb5nc36FtT3v7L9iAYvgojshD3DrxpMQNAySx4dD3wfb
bXJwCmNFzqVuGufPLLNB4so3XvE/X3Xvz2JHmDDeFTs8p0EBc7DGunklYjwafh0i
8TZfgZyg
=Slv3
-----END PGP SIGNATURE-----

--uS12SW+5d+x91WG0--
