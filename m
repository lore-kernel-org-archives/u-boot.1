Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE79EE14C0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 17:50:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5804486995;
	Wed,  6 Sep 2023 19:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FfrtrCqJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A4B6865A8; Wed,  6 Sep 2023 19:50:22 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4EB5866EC
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 19:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-58d9ba95c78so853587b3.1
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 10:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694022618; x=1694627418; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YTurXsNy3vSZ8JAodlnmzeFVT2IpaOXTAXm3fIAK82A=;
 b=FfrtrCqJRdqokVup6tVyc5FWOTN1AUMvoE5iee0trG7+9lKsgfIaHdq/Oq/hSLReBr
 2QF3zHHKUs0jSVqrEPfIcIYk9C5bSWLnz8qzRxh1A6GdQymCPONFh8jWmp6H26t1TvjO
 4K+VHDghxDs/nbga5JqZS48DXyN0mmMhGQpB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694022618; x=1694627418;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YTurXsNy3vSZ8JAodlnmzeFVT2IpaOXTAXm3fIAK82A=;
 b=JXSns0E7RUPXI9C6y/WMAYUMFEW5q7RSS/UA990jhw7NWWYH/bbGtjaegdpPxoKiHH
 VR6N1TJeb/c7KQmuSaBOHobzEEHd86KdxrKBHnO7xpoMITXT5UiyhIJDj6+nDObA/I2d
 4M/0CglHWqkAShBuCLd6wuUyNHPoSfTGksLk7hXNqbZ6zUGKZs037MWBQyIxjl+DabHI
 ZBel4PmntlBxFNymV96mLDuR+1+uoDEkqWql/xmEGsEGSvfLrFdiqMiwZnRMMQttnA5v
 CFSiPGSl+Gp+DbrY+z03utP6VIKrA0uU5Lw9hW6LYXY6vs1GltfZrFdoOkmagAuvyrN+
 71VA==
X-Gm-Message-State: AOJu0YzHDireznMnlhxae6YcRPMXPAfcGsyJ7r6T8SF5rCRfUw1GIpiK
 fPhvpzquRB+cZtVZ1tQMbkGWzA==
X-Google-Smtp-Source: AGHT+IHac/ONkaTcqworK0ggSwm2g8uNbJrwDf3G11iPBGonIeIUETuvD21y328irfuHpv+FTIk7fg==
X-Received: by 2002:a81:4ecc:0:b0:58d:4d4:bd53 with SMTP id
 c195-20020a814ecc000000b0058d04d4bd53mr16090902ywb.32.1694022618439; 
 Wed, 06 Sep 2023 10:50:18 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-06dc-de6d-386e-5d48.res6.spectrum.com.
 [2603:6081:7b00:6400:6dc:de6d:386e:5d48])
 by smtp.gmail.com with ESMTPSA id
 j78-20020a819251000000b005928ba6806dsm3882150ywg.97.2023.09.06.10.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 10:50:17 -0700 (PDT)
Date: Wed, 6 Sep 2023 13:50:16 -0400
From: Tom Rini <trini@konsulko.com>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Subject: Re: [PULL] please pull u-boot-coldfire/next
Message-ID: <20230906175016.GG305624@bill-the-cat>
References: <4bcf36f4-5297-b635-e60d-2f2baee6ba90@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3aHeOCnUYVJeqRGa"
Content-Disposition: inline
In-Reply-To: <4bcf36f4-5297-b635-e60d-2f2baee6ba90@kernel-space.org>
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


--3aHeOCnUYVJeqRGa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2023 at 01:33:27PM +0200, Angelo Dureghello wrote:

> Hi Tom,
>=20
> The following changes since commit b53ab97150314674edc25508f4fc528be2baa7=
3f:
>=20
>   event.h: Documented some newly added portions better (2023-09-04 11:19:=
50
> -0400)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-coldfire.git next
>=20
> for you to fetch changes up to 26af162ac8f8ab3222d32f00f06a4774a061150a:
>=20
>   arch: m68k: Implement relocation (2023-09-06 13:28:58 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--3aHeOCnUYVJeqRGa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT4u9gACgkQFHw5/5Y0
tyy12QwAuTw9oZNv/IjJdCuc+M/RtJMolE192w6/yw9S8Ld/sccn9mUnq0cGo4tv
3X8BimbcmM6QAtDwdZPc+vIGtBYwOxOnCoUOzWsFoujrXkzCah4gxMKn1tY6lN+Y
hKtuPo5UWuGu1T0g9MPJAAJYU170FKuAg1vFI4NAGMSv/vj2nujBw6QwNSi9U2XQ
cV6is/8GBz8Ml9UUuvtvYMbLH2pcuR0fxhQGggimONHqea2RtrUKZdZnpLkUu/U8
Y4TpvDY11BAPvYP7EO9L+XOPJZUNwwj50hsuEaPNjSnojBN83H/hBz8aMMfbVwel
IuPlx3mMk6+f6yyJBThwlgbczpC9SmjXNgKyUbA78CHmiMyPYbl3kZnoatWyosK1
W+sQOAAHFahp0ZViYldS4nZSUfeKOqbYvKWSw+HKtbOu5gQDfbWb3B8c/cituqDy
baS4Y6xqSgGUEmLCHpBc2abVPKQ0CTBGD6POQju+mGNtxmH1Ic44K46bCQ+QDe6r
xVsw6SPD
=w02h
-----END PGP SIGNATURE-----

--3aHeOCnUYVJeqRGa--
