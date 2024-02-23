Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10370C54798
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 20:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C07D6863D3;
	Fri, 23 Feb 2024 21:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zz6w8lSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CCD487BF1; Fri, 23 Feb 2024 21:38:41 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7381087C60
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 21:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-dc742543119so1315157276.0
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 12:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708720692; x=1709325492; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y0Oy9OkCzC2kSqoNXbREZmiRkGSqqztausV0h3OnZnI=;
 b=Zz6w8lSUexnQSiMAdcY9B49qw44v4UjpUj4c2xAiBUK7hnNZ0uSv4ryBCGkqpDwSBk
 aDHY8FJtC8Xugs7SjBGuYy0SYL0YCQLuax1qzi1Q9KCJdO0wstmjSJfuQw1ycOs5oMS1
 p7+ts05rEDz95JQPHr0Hx+4bKy+krLaJPgiqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708720692; x=1709325492;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y0Oy9OkCzC2kSqoNXbREZmiRkGSqqztausV0h3OnZnI=;
 b=fSFdYCzOxsZuzWeQObFO/qao6pn9gn1jwlc3tyv2vywsZrPvLL6/bDdUcOwdOL8B+v
 J3jAR7EmegojnSN383SEzTpCQmnKFnLFFR6hJk9DmTxg+aUkESRZXzx2MTDfSH3R/UsX
 P2H1Tt9TLZ3RDyG2TgbUErlGVx1e/8K7aAnWJi4C12gTiAOBKPf2meK0LJGB8Eodan7K
 f6q5xPFXjwEQVxHL/ZDa6OsTrlRkFC8IpAqxKVPCEXvVt6Ui1gH/YjodTqmlhF6UHziB
 lcEGwqcHTi78puBrpS6Nk1f913X6S2X9Wa0N6pq3sLVt+oBWGe4ITI20p2H5IHy73jU7
 nSNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNDIdSyNEHNmbamq5PWMIhE1fGIXVBrffMDPfG3A4BZ4agK4uJzs5ShHSqavgISlCNnJwwLAyxQBcHTx4YDbfCj5nf7g==
X-Gm-Message-State: AOJu0Yx1OhT0fpSYKK9Yi4caJjQZWQB0cOFDNlFGPyvsfV9nQtAZc2gK
 E161xChRsQS7FZ/PC3WZe4aiUj/qj7a7J+ydyeGXCj3Ob1iZdenBebK09rYM3JdLd4+GT22ttlI
 s
X-Google-Smtp-Source: AGHT+IFYgRg6QzPTdLVs5yjJbg05/YEoJFfvbcAp/mzljUe4XVw4dKlzCE/lqV08X+vEWnTEH4Ig3A==
X-Received: by 2002:a25:9d8f:0:b0:dc7:48f8:ce2e with SMTP id
 v15-20020a259d8f000000b00dc748f8ce2emr959620ybp.37.1708720692230; 
 Fri, 23 Feb 2024 12:38:12 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 r15-20020a25844f000000b00dc6f1cdd45csm3294976ybm.22.2024.02.23.12.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 12:38:11 -0800 (PST)
Date: Fri, 23 Feb 2024 15:38:09 -0500
From: Tom Rini <trini@konsulko.com>
To: neil.armstrong@linaro.org
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [PULL] Please pull u-boot-amlogic-fixes-20240223
Message-ID: <20240223203809.GA3040305@bill-the-cat>
References: <20240223174124.866683-1-neil.armstrong@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pep3pf2wKffG6CFZ"
Content-Disposition: inline
In-Reply-To: <20240223174124.866683-1-neil.armstrong@linaro.org>
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


--pep3pf2wKffG6CFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 06:41:24PM +0100, neil.armstrong@linaro.org wrote:

> From: Neil Armstrong <neil.armstrong@linaro.org>
>=20
> Please pull this simple config fixes for the Khadas VIM3 Android
> setup to fix an Out Of Memory error for AVB.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit 5e4a0c7f4a2c9d4670b75a6a2056243b1a5651=
2b:
>=20
>   Merge branch 'qcom-fixes-2024.04' of https://gitlab.denx.de/u-boot/cust=
odians/u-boot-snapdragon (2024-02-22 11:34:59 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-fixes-20240223
>=20
> for you to fetch changes up to fc0a7431e1729f456690468f2e9570fcc2c18175:
>=20
>   configs: khadas-vim3*_android: fix AVB oom error (2024-02-23 18:22:50 +=
0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--pep3pf2wKffG6CFZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXZAjEACgkQFHw5/5Y0
tyxh3wv/dGSeKWlK7PEPp8tE6P4o4C1MIPKatVFxpXMbKNOGMv6y3l6CtmGm0m7u
tbdprDPjspv/XI4lxAUbio+v2VsCj0K+7LBwpgZAYUPOfJ3135WxXPBoZra0RtNh
Z8gqoDmkON2efwwxlfo55ZzRRhR7q8FhfGBHHT+l1oJqBO89ddCNab5Fw6aX862t
/yZn+LePCY/+qCniBNtdPgXLvo2Kf2scbcyDmmR9hE/LTd7O0TIHylaijOD2tTOZ
eeWsq1+evt3PM3fD3rDmx+8INpONqRtXWzRPhE1vKszMJytTbb5RwpSqwdAzc8GV
t8YnxgNTvTe3FBRkv3pbXNljXFWbLvAs4v/U57So2X+UYssao++/mRnhKZMdCTFk
/trOZoGt7c2McYZxBauO1yvKTIE1aGECU5RonGOPuQlc4i441KOhMmE0fqhfRZre
8ZZlSgadqlJGffjufQgh/UXhX8Kf0jnuI1xY3OUE8Iycg13iabgCWDhMZTjobIg/
+t3ZyWYp
=zKeU
-----END PGP SIGNATURE-----

--pep3pf2wKffG6CFZ--
