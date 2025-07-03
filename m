Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68086C8303C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 00:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63EAA81FEE;
	Thu,  3 Jul 2025 02:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DfvcsI63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C843782063; Thu,  3 Jul 2025 02:34:10 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A775A80E9A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 02:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7382a999970so3944792a34.3
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 17:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751502847; x=1752107647; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mJLLTKt5uH47gNAiO16KqB3+LA7C9TULBQ5f5gYma2s=;
 b=DfvcsI63t4yRKC86W+DHoYO6bEd25vJ77ax1HWuJAqfLmzFm3KaLe6Plb1WMumjo9H
 Co5bPPEZJciyVpVbnQvWWlQ7FytffRcvMdTe/54ZHDiNZ1nANtzAB66xbifWjR5S/PFb
 WSDiCevrlA0Pi+Uc7rTllUPOq8llt5W3m6LHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751502847; x=1752107647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJLLTKt5uH47gNAiO16KqB3+LA7C9TULBQ5f5gYma2s=;
 b=tVsOtoHGGcVBCHtO5cD5pUelF1APIkyI/gOgcEHo/ojNcC8y2xpXOKWMl+HobIii+y
 GrWx5nRQhfUW4q7y2ucaljiiIRY9PJomOvsJn/3u/8vNw6+eiQOGt/7D08xiJ5+LOJbx
 3JiiQnaCC7RPSmV0n7tYy+qC1YZLrUq5VBX5gJJb0Q09wDAZrC7Hbf8R2qK5L8A6MnBr
 WNWTeUaf76+EvpREa8xJeNdJEzF7uK7rLzorsNjpuLjTVPVfzuUWvZCi/h0byTqHYf63
 O6rTh7qMnZTcoiJdFFEBFnAozjHjryXJsKO0iTXb3GzVikI0sLENquT9IFZ5Sm8dwT2v
 9TAw==
X-Gm-Message-State: AOJu0YwZAC/58e2BHUiNwToxSoaq8CMfRnVGBzCAnxcmAvH3GUdAaCk1
 2ROWbvxCeP3FfwPzrfIHIBBW11H7jbJTeJ7jvT9ndJzatN62n3J2rQo1ylI5OXjz/ck=
X-Gm-Gg: ASbGncugDlYOebFktCfDGfeBh7pFGM6H2isfAeW+fKQXml7j/vRJIjQH0Yqbj6FdVat
 UsQRUxQZXX7MMsiexc04NEAOBH9yZUOeuYWqgXY8HreS6Q0PubAEls7ZjMZ2ZKvm8NIJNDAIhvq
 58QH0YTfEWTF/8eH73yEUgQIU35FfSbN1oezvZ+NB0MF5H1BR8nbL5/i/lilt7DzAYsvwUcJpm6
 AWaJ0SLXEIc6DvvBmz2EwB6JwjrQUZcr6FfVUNMvHDS4y2BwXMx8fYtkwB2AXTcbhCGpBmtaism
 T55K6+Kc9YStpb6Bx5DplnP2R+hm2ghDaAalAlsAXwujmZxe09dBro7Mh1brIF6Anf5W2DMhGfJ
 SkaRFKS936uVSVBO0X7Qd
X-Google-Smtp-Source: AGHT+IED9hIEneBKbpGIZGl++bpohKPUrh0tZer/hmweeqXJGh3I5fXuzpBJGA0HQqfXEguIGc2woQ==
X-Received: by 2002:a05:6830:8088:b0:739:fa45:5918 with SMTP id
 46e09a7af769-73c8c61d47dmr616559a34.28.1751502847052; 
 Wed, 02 Jul 2025 17:34:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73b2c8c1f52sm1450887a34.18.2025.07.02.17.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 17:34:06 -0700 (PDT)
Date: Wed, 2 Jul 2025 18:34:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] cmd/exception: missing include string.h
Message-ID: <20250703003404.GC6424@bill-the-cat>
References: <20250702205818.44188-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Jx46U1za9ceCRuXy"
Content-Disposition: inline
In-Reply-To: <20250702205818.44188-1-heinrich.schuchardt@canonical.com>
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


--Jx46U1za9ceCRuXy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 02, 2025 at 10:58:18PM +0200, Heinrich Schuchardt wrote:

> When building qemu_arm64_defconfig with CMD_EXCEPTION a build error occur=
s:
>=20
>     In file included from cmd/arm/exception64.c:87:
>     include/exception.h: In function =E2=80=98exception_complete=E2=80=99:
>     include/exception.h:41:23: error: implicit declaration of
>     function =E2=80=98strlen=E2=80=99 [-Wimplicit-function-declaration]
>        41 |                 len =3D strlen(argv[1]);
>           |                       ^~~~~~
>=20
> Add the missing include.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Jx46U1za9ceCRuXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhlz/gACgkQFHw5/5Y0
tyyKqwv9Fi3M0ucm+2yBY7APLY+b0q3lfYEocmBE7RRsmRSfPxzQCRphyfnx5mm6
xESwpLa98wf5/c/jL0iGDGOKSobOBqE3gnYFsjqFo1/Q+4NczPb//g1NYXYVHzxF
n2EHZXHhIkWlluiUk4AN4o31vdeXZyjJ/RAHLdAGdU18muuXw6SEjcryvgr14RCW
MgllSLrtp0XIeeE8SwXb7Rxe7Sw0BEJUVb/dxylg7zeUBSlNjyAfTBHoxKtVb1oo
dqosgsDq918r4m3+QPGp6XUxLkAZiJ/9S9Hwkh1B295cfFXzT9e9fv0qOILVk4Zk
SjJIZpT5ujgAlJhFDBWTQxw/tnt+wbGhJKppIIFT2on79x2XliLOvEXy9WT/x1FL
iQsQh+UWxaPv4AQHTZNw5YRA6D7IbMiNVuKPHwU6k4og1VYzF8vdkMk8qYEmoGyp
Ux83FzmC1NW1balVKcjKdQYeZjh1HTea0rQr1m5Ma5BvzY0shqGa9x35lJpj4vZY
qb7QhWVy
=FXU/
-----END PGP SIGNATURE-----

--Jx46U1za9ceCRuXy--
