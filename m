Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63541C4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 18:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D41F487D6A;
	Sat, 13 Apr 2024 20:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UwPY1kgq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B49C88228; Sat, 13 Apr 2024 20:20:08 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4CD28785F
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 20:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-69629b4ae2bso17100836d6.3
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 11:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713032404; x=1713637204; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+aMJkVrHEf/a/IKaC3J6uzjZRBCcuR4IP+8iJHQUHQA=;
 b=UwPY1kgqwEMqg8HI+CStIfCCm/L8aUkO8So4EFkKi2jWavQ8rdmKOrNikxcWNLKlwQ
 PUl+pl76R36elRKpUWKHXABNShh5u8FxmeyNqTPV9tMhipRjXBZ7/OCH7NZw+QZ6x0CV
 f6EdNtrEaPrr6KRB9Wb0mEbSNBw3IFQVo3oWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713032404; x=1713637204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+aMJkVrHEf/a/IKaC3J6uzjZRBCcuR4IP+8iJHQUHQA=;
 b=sLB4sRSaDI5keQQKIXcx1QI8C7TGwJrNjtNaSsX5ktS62tLIIujrWyOTjnExbJmF+A
 IXd1ygE3BjQTIEQsQPCEI1Bg6vdUghgf3JZN/Xnof+c+Q+8249CnqrVbvMdBeqx7MZMC
 71JwCLe5S3a7uR1z7yrPzM9cgYpMTehs1hux4iGFO5+qgvwFhFlFlMup4iag3z/GouJn
 GciQUJY6bzIUJF5VUnZM8D5TcNDXZcUjB7fpkX81wWe0x6sMNieWM/PYOijpXiSLNl0x
 1zsvrTucdlK/LO5pqz5zkAZt5I8lIOCeMdsOMs4uFLyfrIVDqfTDy7WFmcD/bJUNmidk
 JSkw==
X-Gm-Message-State: AOJu0YyEUToBintoCjN4gej9PylH5IucyFzwki/6osNA+zpoXev8bSmW
 Cve35aErAV7gDDFKRExPY7veL0BMcechrwo6vfiziTVxDvue7Uiv0izHOQ10eTE=
X-Google-Smtp-Source: AGHT+IG7x4GujClMDJTSOQl0V53aLK1JsMd1nvzyHJqwQlpfw9nf43o6suxv2h6sohMlkYOtBf2dVw==
X-Received: by 2002:a0c:f548:0:b0:69b:3661:6d39 with SMTP id
 p8-20020a0cf548000000b0069b36616d39mr5619071qvm.24.1713032404557; 
 Sat, 13 Apr 2024 11:20:04 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 g13-20020ad4514d000000b0069b601f23f6sm1739455qvq.127.2024.04.13.11.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Apr 2024 11:20:04 -0700 (PDT)
Date: Sat, 13 Apr 2024 12:20:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Weizhao Ouyang <o451686892@gmail.com>
Subject: Re: Pull request efi-2024-07-rc1-2
Message-ID: <20240413182001.GA1054907@bill-the-cat>
References: <c17cb6a7-2c98-4408-9b29-27f766edafac@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1/1Itu0dsB0O1Ugc"
Content-Disposition: inline
In-Reply-To: <c17cb6a7-2c98-4408-9b29-27f766edafac@gmx.de>
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


--1/1Itu0dsB0O1Ugc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 12:28:34PM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 13c1100335e40acb1066e074eb061387fd103c=
36:
>=20
>   net: designware: Pass all multicast frames in designware driver
> (2024-04-12 13:59:12 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-07-rc1-2
>=20
> for you to fetch changes up to f1f4b0e6f37d801f01d043a1ed44b88e7fdd1d92:
>=20
>   doc/sphinx: Bump idna to 3.7 (2024-04-13 11:16:14 +0200)
>=20
> Gitlab CI showed not issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20322
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--1/1Itu0dsB0O1Ugc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYazM4ACgkQFHw5/5Y0
tywDRQv/btivE9ll1gm+gywQsndpZjiARDmqYQL6OsLN3VAJUo8YqtkQukS+yTT6
OSJ5QOOQJbevy1LYJL92YrzYyiKz1vcnOn8kaO3XQMB0jJDbcOITTNNbUdLvfLWI
0JEWkI7CFENSUCMcS+z2hfbwlHFNxxJKBBq/+HuSDQgINrIH3RFZVZ4ZXJA4V0vx
dRJCcgJBjwRnl+RO6vUdqRCHcLiAj8ylJb5gOjtYko91l00OJ5+JrURxI6Lk7rZ0
Iglye8aPenBTXzInK3f0mbaR5LXTYKhJXmHeYuPnw2U11UJWjeIU4oJxuDT7iZuB
g20yWRAw1nWay2aFmqEChm5Ui8qDTv8lUkhpTd3/jYmDmdoxp2DQD5Z4Pdb7fEW1
pZSWQSvMMhraeC2Io9Rvw3np0lBo6QMT9Xy8cmW1CwmVu2Ayap/TXa0DbvXGPQuN
BW04G/VHh/70sb795Cnwcf0WBZBkQEW1z2m0gru3dxI5gKoDbOziCBLnSTKos6Q9
OgkA6ICY
=Un5S
-----END PGP SIGNATURE-----

--1/1Itu0dsB0O1Ugc--
