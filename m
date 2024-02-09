Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B947FC4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 20:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09F9087E70;
	Fri,  9 Feb 2024 21:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fMyEuD4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC8B287E7C; Fri,  9 Feb 2024 21:25:41 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DFE087E70
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 21:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3bbbc6b4ed1so907867b6e.2
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 12:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707510338; x=1708115138; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qsdZiLCXOgNoQnYovkBIIAdUzCukepvoHcq3v37Dc4o=;
 b=fMyEuD4psQxPS8ARjbKUt9dL4wNJZFVpE9SjWmc79/+7xZwTf58h4K5DnH272g9QpN
 io7p0Gl23RnTb256RZYKdbQxLTebTrvWa7IpHfwfR5D+QKnFWr9vhtINBz8BxIZ3SFX4
 juu/brCFUeVKgRq2zhqVFXkezyGEZPbc/keKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707510338; x=1708115138;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qsdZiLCXOgNoQnYovkBIIAdUzCukepvoHcq3v37Dc4o=;
 b=fgobsmd68MmkNOXlRXgXl6mXQmeNx6s/wRmNtwE3afJrEE9jCc47N/SncqZSongqRl
 wnDK4MOJaQnlJwWDbiivqtc4uOD0Fx/hPZXASKDdwK4chJ9jEjBHGOvZYEWVz6dg1rYF
 pBn8801rR8Riv5g3Zh3wQm9rpg8bkiJdUkVZIqO3jhhGgjyD2a4xJUY+avCeVFj73T9I
 8YmiE3crbX2VFIL9kpnl6fOjAlQaJ3xFC9ZShmbUV6DPLwwOJaoDRjWvzip73REMhrFG
 jWOsppkkzgw+zfLF9APtRyTI5u6Wy60vB1Er1jiW9dL8iMPXA2i34eToy1xBNBOb3tGO
 GXtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf1uzKzYJQF3Egc+ro0VlI6oO62UqNkyzzaYl89FqEH5A4KzGtLvGzHDCPdvDsAogSrbTeKz7R9ALHLPYlPBYSkENU4w==
X-Gm-Message-State: AOJu0Yz9IiYdvMUSjMKDp95FYkIFfLdSIh96ptgOGaU1SBwhzlZe0iDD
 AmWJr6gu3ZX85bpInREGzXXTMwy2EoHO74pT+aBWE8mnSXWgrafTpNvR6gMuunA=
X-Google-Smtp-Source: AGHT+IGDHu/EYbPyiuztUR4bxQydKtw/QfFt7KvE4pUtq3p5mUuYvzovK+h6Xvv391IYM6w0fmerpA==
X-Received: by 2002:a05:6808:211a:b0:3bf:e5be:316 with SMTP id
 r26-20020a056808211a00b003bfe5be0316mr181745oiw.25.1707510337731; 
 Fri, 09 Feb 2024 12:25:37 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUo87dorgurOa/KALMPW0KJeKp1690IqZ1fibxvy/7A/b9YJpFMgnTWt+rojF9dIlo0Z4BUtgSXwO7YreGoGJhV2fCg/H2KqnVb7xl6O07iFMbnzCoFE1jA628t6A==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 v21-20020a05620a0a9500b007856ed8ff83sm67756qkg.45.2024.02.09.12.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 12:25:35 -0800 (PST)
Date: Fri, 9 Feb 2024 15:25:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <sean.anderson@seco.com>,
 u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20240209
Message-ID: <20240209202533.GR1152441@bill-the-cat>
References: <87jznd21t6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tBEu0L3vqrcve7lP"
Content-Disposition: inline
In-Reply-To: <87jznd21t6.fsf@baylibre.com>
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


--tBEu0L3vqrcve7lP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 02:40:37PM +0100, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Here are some developments for master including:
>=20
> - sparse error checking fix when using raw chunks
> - 2 new additions (AVB, AB) of myself to the MAINTAINERS file
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pi=
pelines/19573
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit a4650bf65e4b7d3ef04c90ba8031374428e4a6=
82:
>=20
>   ti: keystone2: Move common Kconfig selections to under ARCH_KEYSTONE (2=
024-02-08 14:42:56 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20240209
>=20
> for you to fetch changes up to 766f04a297e892d5106f7f7ac8b43c69bd8a6007:
>=20
>   lib: sparse: Fix error checking for write_sparse_chunk_raw (2024-02-09 =
09:42:04 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--tBEu0L3vqrcve7lP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXGij0ACgkQFHw5/5Y0
tyxm5QwAlqhB/81Z3AHNkwZeFpWFN/Z2WNyN48ALVb5QBDjiNrxYCvcaRlovZTVN
7IpVf4SNU6mA8a4uVzodAbp2MMUSV8ZiA05F2mdIHhqd1QtjzZs231xVZ6r87HDJ
ugJjVJDqlYDwwO+zZKJy/Mbd9q3/ktM/H4QIkV2fgBQkMjaB/HiV894situE0xMC
4hHCpM/WLUvhpSBuyX+pisKTn0vMQEaGI1qvLTYY4iVI9bVN0dTISPxnHQZkEc+G
CnCWSkEhVH4lGpXVMBLZP3T3WSSJ4v5gZ+aboearxMyD4zM5HW5+b1ZWbAPCCWZG
Xr/jY3j+oTqP5WC67IxFh6O0CAnohJucXYsNiFCb0l//qXtCcVWxPJLftUGo4/3+
GijR6Dk0LBvABb6t0bnhuuSKthh5n3rte5hFFSzaG5ju11hmkUyj0rocQG1xUqEo
MTPNWY1OE7fyJ1E89P1uh5gooCIcPQa1dA8LhNoKdYnzgjyWL8E3vlv2pJxnTYPG
7fCO5y/3
=82k9
-----END PGP SIGNATURE-----

--tBEu0L3vqrcve7lP--
