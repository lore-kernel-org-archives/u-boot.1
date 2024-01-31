Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499B4C47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 16:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8052F87613;
	Wed, 31 Jan 2024 17:28:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rd/F/DH4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F1668798B; Wed, 31 Jan 2024 17:28:12 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2682A875FC
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 17:28:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-42ab7522c75so11209901cf.0
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 08:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706718489; x=1707323289; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XRecwSlU4tfrBlEFxmWwWXAkJm1hm5ZYeXWnscBSGF8=;
 b=rd/F/DH4X4rNuQ4ExdEg8ja8ffAC0vcqIK1q6+UfruABEgBi9FVnvgIgwIEdJV5eNF
 yrTvoOWOw7mCCkgpBGDbqd4IQt5pks5abxjJ950Ww65pogHxr8DhMTSpkqbEP1B9nNK6
 ieXYCX1MIk9Pn0pqDGUQL8HtZpAvOh0hulEXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706718489; x=1707323289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRecwSlU4tfrBlEFxmWwWXAkJm1hm5ZYeXWnscBSGF8=;
 b=L3ljUuKI50LFyHCPJkY3EzrYfBdVqEGccmfBaZLGFSSh3rUocM5oe9HKQ0CO22PPfd
 qnL9inr8rzNuj6MYVm69hIsFirC08VUp0WVcV3ER4jLhJDkWprqwAFvukp5BcU4sMhAa
 MTOlVvLF64zoFVEXApafeQi5/Rk0IAOr3KKj0fPvY6gRXfUWpFEylulGrcqzEqc1vUVz
 zsAneO/CQKlL1OMVuj5Q7LGvi22TMs1a3PeR5hHaKxfsCzLCE/uhDjkh2ofxy3XZck9v
 gFIG/FuMq0kuZN7kfmszXiQFnUZ1qMLZX4wo9sVpWsCAezQam9YnEx1DUgpbA/19JuXs
 BRbw==
X-Gm-Message-State: AOJu0YxwVNDILgFi1PM2a21thoaBkFVS4Ux2lGQjjSh2x9txkltKFdo6
 ldjnN7wBSjBVi2TNPTRJq2fy2T+6evZPGCZKGoVa7bZ2qxKMh1Bw7tLp6yzrWpE=
X-Google-Smtp-Source: AGHT+IFv1dOd01Z38TmQkQfaqlpC5U/LyhVepDnfR4C2A5x062RprBIbpldyeoQr41aBPkkZ3lDRdg==
X-Received: by 2002:a05:622a:598f:b0:42b:e7f2:bbef with SMTP id
 gb15-20020a05622a598f00b0042be7f2bbefmr2928650qtb.22.1706718488923; 
 Wed, 31 Jan 2024 08:28:08 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 cn5-20020a05622a248500b0042a29013f15sm5611711qtb.82.2024.01.31.08.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 08:28:08 -0800 (PST)
Date: Wed, 31 Jan 2024 11:28:06 -0500
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PULL] u-boot-at91-2024.04-a
Message-ID: <20240131162806.GW1152441@bill-the-cat>
References: <3e025444-6116-4898-a718-d718265e233a@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oDc5wQs2EBHcPDRc"
Content-Disposition: inline
In-Reply-To: <3e025444-6116-4898-a718-d718265e233a@collabora.com>
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


--oDc5wQs2EBHcPDRc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 05:43:49PM +0200, Eugen Hristev wrote:

> Hello Tom,
>=20
> Please pull tag u-boot-at91-2024.04-a , the first set of at91 features
> for 2024.04 cycle.
>=20
> This set includes some DT alignments and solves a compile issue for custo=
m nand
> defconfigs.
>=20
> Thanks,
> Eugen
>=20
> The following changes since commit 3c04fcf3137d5f694d52b8f355373e4baabe5f=
78:
>=20
>   Merge patch series "k3-j721e: beagleboneai: Fix USB" (2024-01-20 11:39:=
13 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-at91.git tags/u-boot-at=
91-2024.04-a
>=20
> for you to fetch changes up to a1c6b08274e18e4afc0f78a2f63609880aa7ef08:
>=20
>   mtd: nand: raw: atmel: Remove duplicate definitions (2024-01-22 06:05:2=
6 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--oDc5wQs2EBHcPDRc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW6dRMACgkQFHw5/5Y0
tywcXAv9FVAbvQ4eoxybbsqGF4rySNvp3rDAjZ79n8E4IckWG2LhkY8emKgUbtx7
+Oz41LqkbRmZyyYony7WklxYowT4Kk3wbFVD5/nrLlQG9N8xiUe50+HAMLAUzDUr
IGBgUY0q3DFrxpNGpwEmFfxn3MO8SEwirssBmH2E2EMVkfTzIK4cBSC8wZA+kxTZ
ldxqL6uAT5mptyyz3Bx0abLaOiHDkqzcbq0ZTUruvl6Kk0ZSbJsP5E61GLHDOkLk
MC4IKjy90HCga5ABySrlH6WHamiP+6qoVu7wU8UqSPNSAPe/JY+FbFZ6yTfVX+A2
msQr9veJcO+/cIWORoe9qiXaPhCUTurdIrJgZcRGyL+vuHzVTiiq+UVuEOAHM2aZ
irmXDzdmJ0o7TZ+I+td60E9ompFE/MPUVLWgi26/l0ipfHU5S1YfXLLDSjwq9xZ8
d8UXC4S7qJyBnkFhWqo4SE5lXLFYfnI6dqmgTX4Hj4k09mgxsIsjQ147ebkH6a3C
pUsIjWxY
=YSTg
-----END PGP SIGNATURE-----

--oDc5wQs2EBHcPDRc--
