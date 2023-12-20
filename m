Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A23C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 14:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 128AB87536;
	Wed, 20 Dec 2023 15:42:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X5Atm3IC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8BC08755C; Wed, 20 Dec 2023 15:42:46 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 521D287509
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 15:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5e266e8d39eso48392827b3.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 06:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703083363; x=1703688163; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VXh7j7HAGsiQRq6+tsB7AD52vte5LkfJb7K9j/HmfXQ=;
 b=X5Atm3ICIrUgyDcaMXzlJy2YNHVi4mSYZI9rjR7zkp2ZLwZ8YMdHUOXoQzjA4Q9LH6
 MejRW7tu5ZHDkz6dwpYubbecA3sDLdy7o2I2e0MxG7yxwwDD8nHklOk2ixJHQIgwZH0K
 +MWDvyL9F4zvmUYuoLs02uXdk6NjC5AlVQ3NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703083363; x=1703688163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXh7j7HAGsiQRq6+tsB7AD52vte5LkfJb7K9j/HmfXQ=;
 b=KbHN28JVNKugcML0xZmW9/+Y0TJDGk6VN4nCTMiSuIIDgl0aDj6JocAoLraQUxJ3ur
 dR0u6I3LvvXQXA0wy13jRnQaAqERmfRAvp+1piDNs0jhLFltSQFUAmXkaKHNynnMosyq
 p0zPc55Apwzxcxmf50xw6/MJooCYh4Oei6g8/yPp7t3rI96QhYD+mPLBA4KHbzxXuglO
 AT11j7n31W0NmrSjuP0aneK+wkMfwnE+5Mhwl3pk5L5Qv7QpNs5mOKIER++tOBBdUmKK
 ErszD6vbDRJClyF3mnEMgcE7MTAXjSOCkUoFjhC2jSy5DQu4AZbWkxUkxIxm2u+smLV2
 526A==
X-Gm-Message-State: AOJu0YzHjkA7X1hwDN2UlxDAjFmtanN7iK0lMQeJxU+MxoXrts9AOawP
 qSppR5VYeumQ2pIPtpPjopVpkg==
X-Google-Smtp-Source: AGHT+IFDtLGVm+mloAt+DzlE1plA647vvZ2tObsfJ63ZZS9F1Fn+hHjK8ufoKWQV2MvHY+XdOff/bA==
X-Received: by 2002:a81:4f91:0:b0:5e6:c3d7:6c4a with SMTP id
 d139-20020a814f91000000b005e6c3d76c4amr3472521ywb.50.1703083363010; 
 Wed, 20 Dec 2023 06:42:43 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 f63-20020a81a842000000b005e82879d18esm1036538ywh.53.2023.12.20.06.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 06:42:42 -0800 (PST)
Date: Wed, 20 Dec 2023 09:42:40 -0500
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20231220
Message-ID: <20231220144240.GM2513409@bill-the-cat>
References: <8c32e92f-810f-434b-ba77-3074490458bd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ALWufgPkcTGaydJE"
Content-Disposition: inline
In-Reply-To: <8c32e92f-810f-434b-ba77-3074490458bd@linaro.org>
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


--ALWufgPkcTGaydJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 11:43:51AM +0100, Neil Armstrong wrote:

> Hi Tom,
>=20
> Please pull into next branch support for the new GXL MDIO mux along
> with a Linux v6.4 DT sync, this will permit using upstream Linux DT
> as-is on GXL & GXM based boards.
>=20
> Thanks,
> Neil
>=20
> The following changes since commit a6f86132e30a407c7f96461df53c62fbe52e2b=
54:
>=20
>   Merge branch 'next' of https://source.denx.de/u-boot/custodians/u-boot-=
riscv into next (2023-12-18 09:56:58 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-next-20231220
>=20
> for you to fetch changes up to 4d4fbf04158a5b2d4fff5a35ea0a2d6c18d250cb:
>=20
>   ARM: dts: sync Amlogic GX DT to Linux v6.4 (2023-12-19 11:24:38 +0100)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--ALWufgPkcTGaydJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWC/V0ACgkQFHw5/5Y0
tyyE4gv+LQ0DiXu4uyOg1qPDqD0D4n3OrqFGJ2sSyDL415OaSaeGav81Fx+UCHA7
Ey1r8IxVHrqkXW4uv79SjC1xUsb+BfvSoDtyKyCO9I9uNd5HscWu5On+VVEX4vrl
NmqZui3Z2DdwP6uaBstDCVuQwbts7XOZfCGJ1ajXoATmS4zPKLBLc9XUJcGYDVi5
3EtNzMgzB2+wp9T/zbZICoaUfGnabY+OR7/25tf7uNDxjJqRB+tbJVOhbA1ga3cF
FllDXRqnEMppscFsm8+SMRJmFxHGxEXkok1ML0ZQw252wo+yA8ZfZKoDD018fDXW
kVMaZtDnaHkALTk0B1LAElDj/UpKR6jbRQRMjM6sDzhePk9t0qiLhDtd/oLexPS1
ltXfIy+2iMAOfqtTpR+w3DI7Grs5Pmi0xLeaByU+3s639wgk/Mr+zbY8hMAEIjp0
Q7f6GzdFcK0SFxydJ6C6XYwD57kHCFKJxri19+Kf5f5HJPHrGCAeCUjbVWDuGJk9
f0+bTExF
=2tgD
-----END PGP SIGNATURE-----

--ALWufgPkcTGaydJE--
