Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4AFC5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 18:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C5A588170;
	Fri,  1 Mar 2024 19:54:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fSTkLT/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D2888165; Fri,  1 Mar 2024 19:54:09 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB1688164
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 19:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-607e54b6cf5so17580767b3.0
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 10:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709319246; x=1709924046; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vVYmupyyVixJYovXd6Da5pcN6I3ioUiO3WHK+U3yc20=;
 b=fSTkLT/wFxrzMBx30CqINGZ9RKO3UP3ch/2k37bxsZC9uTbzFRQ5F5LVzEXShEVJjT
 qk82wdBaszEg8GZb6YIWR4GN1KQWZ6LFfRefUFHUUlos9+8wSk4YKXqXFBrmaHQ+wdu5
 kogRqX0Axvxq+PeU2IuOj+4XOPaayKBm4zFnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319246; x=1709924046;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vVYmupyyVixJYovXd6Da5pcN6I3ioUiO3WHK+U3yc20=;
 b=H3v/1IA9bETcWhATyzdyKjsaR9vmX4Nw0VEUhNgstEOAVLJ1lzP4/cVvGuztOI7tES
 KbTiPzuBNrzkljOcMjuMzxJ5Z20BzxioFPPmWgjHChKNPJbBnCvGZ3US2BjshzfpW15s
 x60JhrFJ/RAw6jTRMGJYJ6pdBrqYmuhZtr5LVOUKKFXaOAr/n/QRG0ymo8qYQg1urSru
 foZe/TDSnLZqxnTz+eO08mWqd0dCE53+uXoGNWgXt3Ip6v6akQYIPHEnVY4ymI33+pok
 6uex0JcTNQZHoXQSP+Dv4FCeC+K2YFst9eLHc/IW8uzmG9tRstcvk86yzchJhR/aZKBn
 6OSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBWleiCoyO/KHNMMcBb/qboI4Fk/mL/tDQyvASPpnPry8U6J8aknUR/WY/SUgkwic5AtN/OH9E08OJv1eotnf1vFgibA==
X-Gm-Message-State: AOJu0YzNrLSwL4NBvDO887mocNRi2YAUEq3Aox9ogrjmuoNooHxwpUq7
 ugxlnlbsA/UUcW9GJvUxHA9yqifBVBgRP7SpX7FtzeSOpKzkEMcYs9m0RIJxXR1nzOJpPG/mOym
 s
X-Google-Smtp-Source: AGHT+IGOBN6hOqH/a7l5HKELH4xFIGCdaSxSC2UV+AZPLggj7ijAYCeEblmgx8xCNxn9nV5L6+K1MA==
X-Received: by 2002:a81:83d2:0:b0:608:2b1:d6c with SMTP id
 t201-20020a8183d2000000b0060802b10d6cmr2365575ywf.19.1709319246559; 
 Fri, 01 Mar 2024 10:54:06 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 dg8-20020a05690c0fc800b00607f86fa184sm1062201ywb.99.2024.03.01.10.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 10:54:06 -0800 (PST)
Date: Fri, 1 Mar 2024 13:54:04 -0500
From: Tom Rini <trini@konsulko.com>
To: Vitor Soares <ivitro@gmail.com>
Cc: marcel.ziswiler@toradex.com, u-boot@lists.denx.de,
 Vitor Soares <vitor.soares@toradex.com>
Subject: Re: [PATCH] arm: dts: k3-am625-verdin-r5: Change CPU frequency to
 1000MHz
Message-ID: <20240301185404.GD3040305@bill-the-cat>
References: <20240219123408.22054-1-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SypBZzslGjtpAfng"
Content-Disposition: inline
In-Reply-To: <20240219123408.22054-1-ivitro@gmail.com>
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


--SypBZzslGjtpAfng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 12:34:08PM +0000, Vitor Soares wrote:

> From: Vitor Soares <vitor.soares@toradex.com>
>=20
> The same U-Boot binary is compatible with multiple Verdin AM62 board
> variants. However, some of the SoC models can only operate at a maximum
> speed of 1 GHz.
>=20
> Previously, the boards with lower-speed grades were running at
> overclocked speeds, leading to kernel complaints about unsupported
> configurations.
>=20
> To resolve this issue, the operating speed has been decreased to the
> maximum allowable value across all Verdin AM62 board variants. As a
> result, there is a regression in overall boot time, increasing by around
> 200 milliseconds for the faster SoC variant.
>=20
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied to u-boot/master, thanks!

--=20
Tom

--SypBZzslGjtpAfng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXiJEwACgkQFHw5/5Y0
tyyFngv9GY/dzFEd8x8p005/abME4xEeo4cHI/Jx/1ijYq/OlJ6kw8Z+jxhbQ5fS
DO1JJPOVLBHnsycse41Ijn6GMt1eqi/0xlz5s6di8TBVbgu/qXPKEnjTaSncp1GV
0EYWcT1vpW4nJVMLqtkA6eS4WLNFSYBfMfFDlVH+Z/GMWzCdqWeJyklDUgvddkHp
kgJUt7eOwY2A39s4nSHHNCDmDi6kpyYeFOt1H++Cuixb6HODC1jaDAYLcgXtIV/O
KosTHKK5l05fIJkzAMxsNqwMEx6aFTLCfhA2AzYEznH6/3xcmTgDAjyA1yGpXhhA
cce9xOUDvaZyaporL6ieWTbIrKimaQl4RiG3zjSxu4z4g8fPrCZhtrQ+vHdjM6a8
Oml8V/6pg1JK6gh/YX4hMunqUwOUOWTKsDzdPrfoUJrQpCONSa2RwjIhABJhqCVQ
rZT5zGdzTmVx80uvcihQq5hm2SZK6te/I+aidevu+hq8B9Uj96U08Uzja+KeAGey
PFxV15/k
=tDrV
-----END PGP SIGNATURE-----

--SypBZzslGjtpAfng--
