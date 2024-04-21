Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52101C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 18:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 681AC882E0;
	Sun, 21 Apr 2024 20:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CNoUm4C5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D338E8826D; Sun, 21 Apr 2024 20:22:02 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90D8881B7
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 20:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78efd533a00so256598485a.0
 for <u-boot@lists.denx.de>; Sun, 21 Apr 2024 11:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713723719; x=1714328519; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0qL+XZoDdpoaxLHGvzPLtdDTMvZZabLhLQkrHUlnojs=;
 b=CNoUm4C5ps7YlYjCXnNS4hiOWzu69rgEqQZ5FLddpmM02YH3AUDdq5VNWBYknblMHd
 mSjvSOiKdVpj3FBnJCid3diA1IfSpMen6EdxU7OcX3QScHbiTAcXk/luovrFfqJyh8x6
 tW9twVyNp6tHpxGQNl/1lkAjWtEXwUDsXzRqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713723719; x=1714328519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qL+XZoDdpoaxLHGvzPLtdDTMvZZabLhLQkrHUlnojs=;
 b=u0mvoIAftL2PPq3I+ZlT+HFm9E3+FG8ON7LC+S9Z2z3spzmr9rts0kh1l9hW94LEsM
 VEGucpQ5azcnB5ZWFQbV13zjmujCGUmQvnwejMgg+3t3nsjrR3gjMAzJtzR63rYf+vGp
 botAiBrwDpx6pVK+lv7ArGlj5n6dvYe1Uix9KP0WJjEKjJpF3aKK9jQ+pgviLnRBk/dl
 Rjum3PMUbZScKdxt44Z9sC0tYd6apbOGTzKp+6gcpzbChxG1VqdOWxdSaXN7tt3K7SsT
 Y3Z9io5sHEqRQMiGAj0fWfgXnRi3D+6x/lT8yndv6JG6BVqfiXZs1Vf2Lzdqn3YeaQCr
 PONQ==
X-Gm-Message-State: AOJu0YxpbXcZ68g/nBWmaCJQ84dWdC+5uTcvzzRRar8dCFtNJiWIEi3W
 J4tee9GJprSU3hMYulD9scKWCbWnhl++lNWxfF9OEGq2n8vSvLo6UnvVzGbVS96jjbBNQqGvGxU
 kEKuXiA==
X-Google-Smtp-Source: AGHT+IHvcXXikoAQ4HB1ERMcrzwDglDb16vcWvyVs7hV22qlMKnsQVUpDOF5IQPP6S3IM3A9xy0REw==
X-Received: by 2002:ad4:480f:0:b0:699:4bcf:7d5b with SMTP id
 qd15-20020ad4480f000000b006994bcf7d5bmr9962312qvb.56.1713723718768; 
 Sun, 21 Apr 2024 11:21:58 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a0c9c45000000b0069b27dad8c7sm3538303qve.101.2024.04.21.11.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Apr 2024 11:21:57 -0700 (PDT)
Date: Sun, 21 Apr 2024 12:21:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] u-boot-video/video-20240421
Message-ID: <20240421182153.GS1054907@bill-the-cat>
References: <20240421155213.7b8625af@crub>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uj6ENOQC6dQ1qE9Q"
Content-Disposition: inline
In-Reply-To: <20240421155213.7b8625af@crub>
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


--uj6ENOQC6dQ1qE9Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 03:52:13PM +0200, Anatolij Gustschin wrote:

> Hi Tom,
>=20
> please pull video driver updates for v2024.07-rc1.
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-video/-/pipelines/204=
66
>=20
> Thanks,
> Anatolij
>=20
> The following changes since commit af04f37a78c7e61597fb9ed6db2c8f8d7f8b0f=
92:
>=20
>   Merge tag 'u-boot-stm32-20240419' of https://source.denx.de/u-boot/cust=
odians/u-boot-stm (2024-04-19 14:25:04 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-video.git tags/video-20=
240421
>=20
> for you to fetch changes up to efe1ceec7ef0c2ce2344dbe066fca0d389a0b4f3:
>=20
>   boot: Move framebuffer reservation to separate helper (2024-04-21 09:07=
:02 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--uj6ENOQC6dQ1qE9Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYlWT4ACgkQFHw5/5Y0
tywsIwv8C73tWzY44R359GYCqxC5UcK1d6x+9hcudvRTA1jfFmWGN/zDNX10NN3R
VewraN6udqk6ajJEFTZlFKKltyaFPASE4msbIszdyWhvEgOGGP9Pq/Qou8ssYC/m
f0RBA2zULwZ5Z0Ny9o/Cjrvf4K2XLLb6L5chK4aV4iLagda9WU5h88QlXh4B175G
NBDE4bXvfAwlX5hotpGufcselSEr8aVXLV9E5E79Jx1hL1fEDOzEx4WPu0OTLqpN
AQngXRJI2UDcj7exBigir+72SfPpoM0FRQFQ7i9lGU0KGJdLiUzDXh4SkCU7dxnY
AhEq0av756hHtEVKRJLIfBDgUqq0l9xa+c+UrQi/9MIVTCTm1FKVboirbtGUo9zp
jek9iWnBUypU/ID6Y4SEhCZoqxcKEovb914CXxp9gGWRu5zpQ8y50PIr9AySScyI
yGUYqDOy9DWFaRJIzexDf+YcX9f8K7YBIsBUd8Cy998u1A0P+P+a+FbTA/2OYQml
UZ6vh5Eo
=6l8e
-----END PGP SIGNATURE-----

--uj6ENOQC6dQ1qE9Q--
