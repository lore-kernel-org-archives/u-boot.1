Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1237AC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 17:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3601080B9E;
	Sun,  9 Feb 2025 18:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sSZsgPFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB3B580BA0; Sun,  9 Feb 2025 18:20:56 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 378B080A0A
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 18:20:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6f666c94285so31002217b3.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 09:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739121653; x=1739726453; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0RUrOC8OsfMAz6BdBTsw21dA94leFaBVTdGezCMxoKA=;
 b=sSZsgPFCuwsh0Gw3uNhbo4upJbwv0K7kpVbalMCXdjQnQZwyOV1txWw6wl5CALJK73
 QCY/XOgOLfyG45VxPW2gLHkOUidjc6GSbp9c6G/JRgEb/p29w3GQDk4mMPWKxoUaHz3p
 0Nw4V0WZkhlz8F6LnuMurla+0rEi/aJ/eC1wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739121653; x=1739726453;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0RUrOC8OsfMAz6BdBTsw21dA94leFaBVTdGezCMxoKA=;
 b=WuHHiu7ahAuncZ6NTrdXK4gdprJMV+zms515WOneCUdgKOpN9HnSee5ftASs9P2cn+
 SaI74hfo9VuXAyWpD9jOCyW04Hk7Ibf5pNIY+aUn1WmXkNfmMufjvItEFxMwpHc+zjbM
 qX4Dq+3nHrfqXHgYjz1mvwxHREpvlRG9yaaE9m4s2dbhZFAG0sU0p6iJri+b3BdZpsD+
 OM6X1Y7jNYUK9TaGJL7X2h/q3BOiuYrOftSeQ/iLYlCkT0UUOsgmKZcFGrGTGMOydKvF
 VOF4Yi9XuhD2aaHRDSXjoXvS8ossN0AbbAmSZsa9gxG43OcoEkCW0T7uzbgiD7TSfbjX
 ptug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzSrqEkQlsBc3c6bMs5c9nC9izvvRfuyiqrZROC+WFTcjdWnt0kOSOLbMz2K0H7INzYjqAc68=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9IBozlADiGW7o3Z+ldek7OolgYmR946FJsLQY/4qPNermOEUa
 1YQUkCzTZ0ZTopdIb9upvBcIX9rdfXIFCcqD2VSCs9P7wOQ6kmi9Kmm4pQp76mI=
X-Gm-Gg: ASbGncsvxNK+KkBNHHEBvrLC2SB+9cegwK0UoONGMJDvMHeotIcEpzN7hX14UR8OcHg
 D5OpZ7TmLHFCqqd/yLmAcdi+4qbkjIig1jsgDVHtbx9+IOLs4BQec/atCfc4qetm5O2zWrqZ1ZL
 R4RSnUGqFSAHFjUaBOnkPHDcsPuvqvk8+yfz6bC4uw4AOQhGpiH6tvoNRSG/Gm78+2uFyBYqIMo
 AhasUSUTFhfZfJfkDPEb3KY2XQaFZz33GPJ5vC0wNjCIShm99zKlzoxGhNP0ufpAEXVw4PCyNMH
 c6t+N9SGNJ8nGEk=
X-Google-Smtp-Source: AGHT+IHwy0tci7PLuKkXAgj1G4WYvas8RRVtT78mSy0rKvZ4fCujj+4SjC+kQr+gHMoZQfry/spAkQ==
X-Received: by 2002:a05:690c:fc4:b0:6f9:4bae:450c with SMTP id
 00721157ae682-6f9b2981b0amr100005137b3.26.1739121653045; 
 Sun, 09 Feb 2025 09:20:53 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ffc071csm12739257b3.102.2025.02.09.09.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 09:20:51 -0800 (PST)
Date: Sun, 9 Feb 2025 11:20:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Anurag Dutta <a-dutta@ti.com>
Cc: afd@ti.com, u-boot@lists.denx.de, a-chavda@ti.com, u-kumar1@ti.com,
 nm@ti.com
Subject: Re: [PATCH 0/2] Remove "saveenv" functionality from am57xx evms
Message-ID: <20250209172049.GP1233568@bill-the-cat>
References: <20250208043938.52832-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ruobyqnsq0J9Ve4n"
Content-Disposition: inline
In-Reply-To: <20250208043938.52832-1-a-dutta@ti.com>
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


--Ruobyqnsq0J9Ve4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 10:09:36AM +0530, Anurag Dutta wrote:

> Previously saved environment introduce discrepancies and may lead to
> incompatibilities without default settings. This series removes the saved
> environment functionality on am57xx evms so that the default configuration
> is always loaded
>=20
> Test result: https://gist.github.com/anuragdutta731/b253ddb0a5538ab6588a3=
535d7bbecf7
>=20
> Anurag Dutta (2):
>   configs: am57xx_hs: Remove saved environments
>   configs: am57xx: Remove saved environments
>=20
>  configs/am57xx_evm_defconfig    | 4 +---
>  configs/am57xx_hs_evm_defconfig | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)

I'm not sure what this is intended to solve. A persistent environment
can be reset to the defaults with "env default -f -a" and telling users
to do this when needed when upgrading is a long standing practice.

--=20
Tom

--Ruobyqnsq0J9Ve4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeo4+0ACgkQFHw5/5Y0
tywLLwv8CEirSFSS2O+oQywIcv5jVj0NuuWXdbZA2QTLaAGLqE8ptGo0T8G1yYTt
Y9CeUjPzq3fhbO7xyvP1vE4sW43tWNAfyDDk7i2BUDWctb7YtVNT5V4TL63Sx2LU
BmJENJdboD9smAs3IjXkcw2o77HoiQn2TWro7vtkKvoAlBj7L7lLiCnb0E0V21QF
Il3bBQBI/HF8JeXDc0bOi22knjL+h2rbwoKBbEnP4LSSjiWUVA/sC0p9ntljGNN2
N9mSiqtvEKRDDrZZfUK7wLNGGWBSy7bf0skw6BoBe4YrPux9qDZVrpaK0lxdR8YQ
gPYiMt9SFDH9OXCWfijNh9Pmd5UUklrUK27xYD7lngjcPSY2hPZnMs/6Yk8hEQzu
ptGCz2AFzt8NMgBcgxqmVAvToXrnmooyO980+SbhSIHEwTfXt0izHEYnsTWZ61T8
j+6i/vC0MTdC8KW4DRippZEYfFSXTzHJPpoDX4z7/ffRTB9o3xIqlRmeJWQpBR7l
c5n/g8SZ
=6rzN
-----END PGP SIGNATURE-----

--Ruobyqnsq0J9Ve4n--
