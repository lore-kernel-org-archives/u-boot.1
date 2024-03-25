Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03521C54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 13:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E536B87ED9;
	Mon, 25 Mar 2024 14:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uE+OiQ/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EFDE87EE0; Mon, 25 Mar 2024 14:51:42 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8D4B87ED9
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 14:51:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6112a2b0e8eso22949837b3.3
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 06:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711374698; x=1711979498; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OFje8yXuRXdbHfWidDl7c5EtPgIjxfZ5KpCpauIaN1Y=;
 b=uE+OiQ/lbGsLI18m9p5NEa9gGvm3RIEV/EzLQcCdcIw9k5NsoPxFekBsXV9bd0mZR5
 ThAL7aTaqoIsUH/26fGr3swUgMjmuvRpEUFLBKVCBnwOnYac+EkIcOwFQL1YoJbcBuYq
 pQi4fnBEnvjQbVKSi/uPFL1ICvSFHk9xksYaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711374698; x=1711979498;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFje8yXuRXdbHfWidDl7c5EtPgIjxfZ5KpCpauIaN1Y=;
 b=sQoL3chxfbb3qbPONIhFCQKS1302XvEOt7wLkXkPINr+llPBrlsrcXYl9T0UxWJg5n
 OoXUUZnLlhtqXS55mqDr0CzP+6KHSGTPg1PgA/vKe5FFoibKQB9AXLWqxy729RlV4hAa
 9ZHc+qru4YQvpGYMUI2uCfDUYwZDV9eU/ssqXVHkQzIALnBxAbCRXP47tgPcfE9czSP1
 bxBYrpiUT8IlF+08ezldgD9itdLmXkySCMPlpDJ4s+bzCmqxanLeb5B5WDjm80WdgDY4
 XijJlxLWQwW4W6Fg2f0ZLvwuXlso0EJbZUv9CpFHtbAvLhJp2/tRRZJfAyBKlome/PXO
 ftHg==
X-Gm-Message-State: AOJu0YxxNOnIASoNJ4snb1+bhw/yyLBUc/AV+1/ucf8E8673F3FGix+t
 MZYmqCImWDalx+zsIurZUYXAfK2TvM/l6n50HirOSsagbS1SOf1kQnizD6+Ciu0=
X-Google-Smtp-Source: AGHT+IGAxs9S9+rpkvPiu5khR4uSoLsn5Z0YwaT8t4NVJzg98z0YwEO68wvNcC9ccAdoH/fPYZfSyQ==
X-Received: by 2002:a25:bc90:0:b0:dc7:4363:4532 with SMTP id
 e16-20020a25bc90000000b00dc743634532mr4693257ybk.53.1711374698384; 
 Mon, 25 Mar 2024 06:51:38 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 gi6-20020a056214248600b006910b474f4asm4121359qvb.71.2024.03.25.06.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 06:51:37 -0700 (PDT)
Date: Mon, 25 Mar 2024 09:51:36 -0400
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PULL next] u-boot-at91-2024.07-a
Message-ID: <20240325135136.GC3442575@bill-the-cat>
References: <7f50c6db-6ae9-4c1c-b2bf-71c40b86da12@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BUZJyHdru6ZSph97"
Content-Disposition: inline
In-Reply-To: <7f50c6db-6ae9-4c1c-b2bf-71c40b86da12@collabora.com>
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


--BUZJyHdru6ZSph97
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 09:45:44AM +0200, Eugen Hristev wrote:

> Hello Tom,
>=20
>=20
> Please pull tag u-boot-at91-2024.07-a , the first set of at91
> features for the next cycle 2024.07 .
>=20
> This feature set includes a new board named sama7g54 Curiosity.
>=20
> Thanks,
> Eugen
>=20
> The following changes since commit 20a0ce574d6642e0dfe651467159039fac48cc=
4f:
>=20
>   Merge tag 'v2024.04-rc4' into next (2024-03-11 15:27:20 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-at91.git tags/u-boot-at=
91-2024.07-a
>=20
> for you to fetch changes up to a7ba3bf65db264c02a774a59e8febc2ecb095f68:
>=20
>   configs: at91: sama7g54_curiosity: Add initial default configs (2024-03=
-13
> 13:35:16 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--BUZJyHdru6ZSph97
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYBgWgACgkQFHw5/5Y0
tyzniAv+Jz0xek/QiA0Pb6n4lBhBKjGibo73B0dm89cRA/qv6wGMQ6tJI95qCloz
5x2gWCgg3XmnL2LV83UZvbcg2afke/9vvC3ySOxykJhyV0z3fTnLMBmTRVQ6TbxY
iiGboPJ7c9uEcYKKES+zwDbOT79qNTX5RTJ+vuL04lGkKfq0hjtK8YF8rL4qQZd8
BjR3+om38dNEyK48LA+rzq8/kmUaNs2Ir9uBvTARz2N1sTVWtM0zMEJhbk/aBhBt
Z6SULDW+heUkNFKoZXpxXIxC+0UreTWT4uZrCeWJ1uEN+i36TDcm8PGnwWLpqX2Y
tBAxRktdYNCjs6HVC2nmjlO+E9ez1ZbNYhzThT26cKMBVKEjswJbxuU8/nJZKWGK
kgifb5BYRER59qX5U43nvTRW9nQ9e2fX8r5NERrahOEUPjbfMVSt8K/mL4uUwAPx
5Cf66smfs7Ux9EnEO69Qd75Ug1BkmxQ+cdPdDrBtihZaCRnfgHxQdlD/oRHM8ObW
JiOLBSvg
=/yKR
-----END PGP SIGNATURE-----

--BUZJyHdru6ZSph97--
