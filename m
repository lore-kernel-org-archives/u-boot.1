Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A3BC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 19:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37D4D884F9;
	Thu, 27 Jun 2024 21:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LjNSaOkV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6817688549; Thu, 27 Jun 2024 21:36:15 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 543BA88247
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 21:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5b97a9a9b4bso3852015eaf.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719516972; x=1720121772; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W4LKF9YY1TQ8jA3twEMi/2D+1dIIT9f6OeXM7xMm0Q0=;
 b=LjNSaOkVztEyyN9Em1sV9zCf3whBLkbk/I+gv17zCMsRImXVMFnUOuMIdU/Ulv2Vta
 GTVRCKOYLVt6evvSqHnJQ2WzFo+9YDb/8VWnjPkhHfLx1hmuxg2FY0jKthVkhe0BnWHx
 UYyuGbS3euhWRUAbxP5QOKw4dXTBXbmF3F9Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719516972; x=1720121772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4LKF9YY1TQ8jA3twEMi/2D+1dIIT9f6OeXM7xMm0Q0=;
 b=bazR42887gZmFISX/9LD1QWH4nZmBTLHDqDwpiZCwwMsQCeqX+sDQa+R4lkIb0+I5o
 ix86V9jN82xO3SF0sCYjAoc7lpBqcCE9/LnrvrDRS2dpKde6lYToAFbUPB01bgD2+gaq
 OxIqaHsOdSsJdpmJs6Mw6lDeS5cLacIi00vBVK+zfnNC3t/Xi7flC2tDvbN9PKHjZnYO
 hu/TTPCTVuXiIC7FRZmvjR3Auz1VxtAdlpmS68STR19WSu+rtXae0U0g6WnFBkky99N2
 FCczbudDx3WRn1R7wsyy5yZbUbgmJ989QiiezGH/ulb9MPRJDskhTvZTn41eqqDbG/Xy
 +0NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmUp5hqLs062ZyZ0S88wyUgalg5ziMoyqKnTIVBdunkVpgwq2oDO1KxDqV8ja30Um0nfL78LrnsfBBYXz/9NA8xS0ubw==
X-Gm-Message-State: AOJu0YyoZ19SS17BFultY6d2M+t1K6src0ic2m0/5nZNCuxuBYqF+pMG
 uBHyTCEk7wE92AbFs9GDDQ6wN4H4paTmsZE8Ag3hfiImTu6U3xCgBBAtxvDO4SszB1n1hezcDg6
 5hWKLog==
X-Google-Smtp-Source: AGHT+IHYJcI32o/PS01ClbHFyAhky8PXgIXMhgFndS7ZmuZQ6wYe8fdNH8qqTB7sqHS2y8g/DwIFXQ==
X-Received: by 2002:a05:6871:3a20:b0:24c:ac7e:8a5c with SMTP id
 586e51a60fabf-25d0168fecamr14725377fac.21.1719516971901; 
 Thu, 27 Jun 2024 12:36:11 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25d8e33725esm70832fac.35.2024.06.27.12.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 12:36:11 -0700 (PDT)
Date: Thu, 27 Jun 2024 13:36:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Christian Marangi <ansuelsmth@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>
Subject: Re: [PATCH 1/2] led: Implement software led blinking
Message-ID: <20240627193609.GF38804@bill-the-cat>
References: <20240627113114.100083-1-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Dbt6hXwdJJyS2YH1"
Content-Disposition: inline
In-Reply-To: <20240627113114.100083-1-mikhail.kshevetskiy@iopsys.eu>
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


--Dbt6hXwdJJyS2YH1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 02:31:13PM +0300, Mikhail Kshevetskiy wrote:

> From: Michael Polyntsov <michael.polyntsov@iopsys.eu>
>=20
> If hardware (or driver) doesn't support leds blinking, it's
> now possible to use software implementation of blinking instead.
> This relies on cyclic functions.
>=20
> Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/led/Kconfig      |   9 ++
>  drivers/led/led-uclass.c | 190 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 195 insertions(+), 4 deletions(-)

As one of those "well, hunh" kind of moment, I'm cc'ing Christian
Marangi who also just posted patches foor this kind of functionality.

--=20
Tom

--Dbt6hXwdJJyS2YH1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ9vykACgkQFHw5/5Y0
tyy1gAwAkUwLbDqUvezHgzR/jF0ECKYMb/UnTnH2TV7RwsKSNDc/+crBSPs57FLY
A4k685vxalbr0wEEvoGy5MMr/qMOpqzoPL3ju1nqjimRQONXWiz/ySQ5K+SgW8I+
VPEybXnATERagzQnP9VDMjrswUpnBNOIE4hcoP4n5+GC2615m4ITewmMatNkEoZM
l72QZIxVOznWJyZ7Iub7L5G3rkFkoj2Fan/Iv7MdOSsPZdgH7Tknus0LzJ8dUfl9
mQLlbmzQq0LpHoETENTbzy747UbwuVJambKtDyvZjek3xWj+iYaThLPFdEYwXfOl
C0xYWmi76h9WAvU8KlIv3se3TMtDPLOrpFVN/vByonQGDNP5AJh3G8kqPPK74ZO2
7ivbI9Dg77kEJRL/gmUKechlhPsnL4ue9hM6F3hgTXeLP+mpxoI7evkurPzMuoqv
ChKTIvb0i09CH7swbDP784we8zMy/ErP2nteOHmDds7/2p1p4GfvoJsQROQO5WsZ
7oEhjbna
=Eqvn
-----END PGP SIGNATURE-----

--Dbt6hXwdJJyS2YH1--
