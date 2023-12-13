Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D263C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 23:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4294F8793A;
	Thu, 14 Dec 2023 00:40:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lXVZaYe5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2DB887949; Thu, 14 Dec 2023 00:40:00 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6936387923
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 00:39:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5e36848f6c6so2882287b3.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 15:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702510797; x=1703115597; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tljEKwgjC4konViJhptxQ7pTNOmy7ODlg98wB1voflk=;
 b=lXVZaYe5h6MrqjFADXufBK4QfsdrqAfY5ncS2MeioV5IwyUO1VfNI+02eqn/gqbaRr
 oEeoS9h6pbs/hE5n7Tddoq7v5sOV5zeMThu5GHOAt4+wgJ+IuwXcrgzP48pPBVMSIbHU
 gDhv2y7Z0zg+kg7FYBFtj5Q5Ai3abXVijY/yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702510797; x=1703115597;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tljEKwgjC4konViJhptxQ7pTNOmy7ODlg98wB1voflk=;
 b=F7bS87FPxfEv3I7mkA8mcBvZq6E3lBOwXiTln/KCfE0qacf/1UMSbhbz5rQfC9aqG8
 dl0NM+Qen5fDyPrVYqTu6HVXtY2O5stkTVC+nPY2iNfEwjO43JxH2NDWr0G5XPbfYjQY
 koSBhajz0C7+ZJ7MC6fMijyRwdVtkzz/VM0u0kBhl9VPFveOqudkeqdpr6Xf81417EFo
 FLvslh7/iXZVH5+UtXe5sD0DIxBl63bigQ2XWH9FJEEcRyMRyXAw2Kgeffw4QHxBeNcb
 7IQBcbjDd4YS7cc+eRF0clMx8rSADwqk7kCSfwxxrwC/q0aZ74oYiLsN9BpxhHBSWJhV
 ZSww==
X-Gm-Message-State: AOJu0YwphcoRArqzYLZDTw6Ja5EDHxD1n8hDvHAqvIhyEyI9POikHNLy
 UF0VSHqMdkI7dYv4eT6J7wa9jw==
X-Google-Smtp-Source: AGHT+IHR1hxn6ossJtZnRwZOcYaIuXkEDsMxAmnyHc9y/nHBr7nEU0n5bwJ9mZcwtr/Lk5drnTHKeA==
X-Received: by 2002:a0d:e84a:0:b0:5e2:9a4d:5b40 with SMTP id
 r71-20020a0de84a000000b005e29a4d5b40mr1858248ywe.59.1702510797130; 
 Wed, 13 Dec 2023 15:39:57 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a81de41000000b005cb3510c8b2sm5027451ywl.96.2023.12.13.15.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 15:39:56 -0800 (PST)
Date: Wed, 13 Dec 2023 18:39:54 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm/next
Message-ID: <20231213233954.GV2513409@bill-the-cat>
References: <CAPnjgZ0s24hmQ+W4NDunJ5UXq0eq28Z=U02gnK54i=5MeoS45A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hWZpqki07y9lQSNH"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0s24hmQ+W4NDunJ5UXq0eq28Z=U02gnK54i=5MeoS45A@mail.gmail.com>
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


--hWZpqki07y9lQSNH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 01:50:57PM -0700, Simon Glass wrote:

> Hi Tom,
>=20
> This is for the -next branch
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/commit/39e7e039b02e1=
cf8b04ea668e2bfe2cd2ef0e14d
>=20
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D56&view=
=3Dresults
>=20
>=20
> The following changes since commit 9565771076c2d4b0193f1741b3990695ac33c1=
f3:
>=20
>   Merge patch series "bootm: Refactoring to reduce reliance on CMDLINE
> (part A)" (2023-12-13 11:51:53 -0500)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-next-13dec23
>=20
> for you to fetch changes up to 39e7e039b02e1cf8b04ea668e2bfe2cd2ef0e14d:
>=20
>   test: vboot: Using variable 'old_dtb' before assignment (2023-12-13
> 13:20:20 -0700)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--hWZpqki07y9lQSNH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6QMcACgkQFHw5/5Y0
tyw0IQv/Xsx1qb0KyrRkBrZRMRPCH9+nTc1VNWrp09vOztqIdMdZqpd9C9d/rdF/
25y8giRCdW5BdJr6HIvrSJOqP1XrLHUA1Y2bVkoojxpofezpPm1Xdaj/riBNsEPN
3Xb3naggu6uxmF9qc7K4Xn0dxnmC6S9tqb6zz1HzD/dUiX/KCMH2tM1+etQj6QVF
qc3M/S3CqIPtzg4ssK/b7M1XiJOp2DIuJR/QvY7Es9IDNNcd8C2grc84+PARhI3Z
dkzT4eD+XsK4vXIkAvitovmzBskQN+hAFMKrha9kRgTrDQimvH2RXlpwpbaZ5fsi
4O+Z0Ykx3DAm6sr1w9inHxH8RtticgJ74hCvsswesAeHMSo6XVZY4cfFTt8PoO6q
lGLQgLg64EQCh9yiogIVedDyjsscH2eEA84IBTVeynbslIGL354kBIcZVgjqOBSc
F7954G8xU8IIysETO8iPehX1yTIM8PyRoOaEnYHadQA62ZpfkwDs3yyf1co4cSf6
j6XNci0L
=nloC
-----END PGP SIGNATURE-----

--hWZpqki07y9lQSNH--
