Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85876C46CD2
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 17:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67F5987A05;
	Sat,  6 Jan 2024 18:41:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gf3sjyr0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F4F0879E5; Sat,  6 Jan 2024 18:41:28 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F26FF87A06
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 18:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-67f7bd86cafso5913896d6.0
 for <u-boot@lists.denx.de>; Sat, 06 Jan 2024 09:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704562882; x=1705167682; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y1fazHjnzcXhhSY47h8f3CozLWcEme3Smjhtnc2oqXE=;
 b=gf3sjyr0DOLlQ+c7N3FUFWTJ3qZ4En97DEjpCotk1grRWDSfKQ3Fglc+SvDGtb8OUB
 nc1bvyjYdTKiV7nri4Q1BX1bkRYz+phi1H7HF17LbCyCd7GsDBPCK81LZz1nH0ljFos+
 iXYT6IZIxhNFLC9QkHeOzQh3OCswZtWyCNjS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704562882; x=1705167682;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1fazHjnzcXhhSY47h8f3CozLWcEme3Smjhtnc2oqXE=;
 b=w1z6UHJPfh3QGOpsQyAA8qcE7ulsm3CW0PrscHUe8j0lzeE2HzsCqTwuXPbJ0PCATW
 xot1zNi2dfGitEXaPA9uIzfsTgfpy4m9SKzkVQFwyVzZ2e2CRWbJQBpD3e7U/E9T2kb7
 7aBHiYuTlFw4LTYlGA0wxDBHTWHhpwf8NAEJWcyD12rGFhCzogFa9sMvM22V6cZgLFo3
 ibMO4shN7TQuE5N+sPoGsPkiqFbtoBSiMNZpAi0XiupCdqAY/sumgbbmPlwOWnm3ytB4
 0TiEwfRkBAx2DxzdWabdUkPibAth1M8zGEKIHHBLR24atHxyDwguhIX+/AUJnqjFp8/w
 akYg==
X-Gm-Message-State: AOJu0YxgVt6kqOLXtL3ONPw2egGBkJcANnfFJxmKM/xvTVUQ8zjm+Yhf
 1BGLu+bvINVEdF6LGbQkrmEE/0g93+dicA==
X-Google-Smtp-Source: AGHT+IGIa6tk0CV40McnZ9OkY9vUiuOsXyefsHEqsIq0Ri5JykcGDlKyWfa9X29yDHhlSRlLW/uuJQ==
X-Received: by 2002:a05:620a:849:b0:781:eb46:ace5 with SMTP id
 u9-20020a05620a084900b00781eb46ace5mr1401220qku.73.1704562882082; 
 Sat, 06 Jan 2024 09:41:22 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 k16-20020a05620a07f000b0078168e10166sm1446971qkk.86.2024.01.06.09.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 09:41:21 -0800 (PST)
Date: Sat, 6 Jan 2024 12:41:19 -0500
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: u-boot@lists.denx.de, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] fw_env: rename variables holding env data content
Message-ID: <20240106174119.GA1610741@bill-the-cat>
References: <20231213092344.17024-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UKcMaLqDZGNuF5da"
Content-Disposition: inline
In-Reply-To: <20231213092344.17024-1-zajec5@gmail.com>
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


--UKcMaLqDZGNuF5da
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:23:44AM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> Rename "addr0" and "addr1" to "buf0" and "buf1" accordingly. Name "addr"
> suggests that variable contains a numeric value being some kind of
> address. Name "buf" is de facto a standard name for pointer to allocated
> memory for reading data to.
>=20
> While at it drop redundant checks for NULL before calling free().
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Applied to u-boot/next, thanks!

--=20
Tom

--UKcMaLqDZGNuF5da
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWZkL8ACgkQFHw5/5Y0
tyxvYQv9HCQZQkIM4LVvJNYiPP+IdI9ozC6Zpw/OcQM2F8rwiNpsvR9gZBJ7BCaL
ssE0A5klWWZH3qsVeX/jo3wafYerBCM8aDTx4T9nT87FVx1Xtp4o9eAfyixE8mex
I7lO9FPIE6fy+fMMwQGv7wXfm7gnV0GoWHOE7BWS5DC7DrMqlgk38IFeCgTgPF1T
VBBwfzwBfZLkEsoXla0vAQnZP9cNNuIRTYoWAPILsKvVdNToNNhhdgdjeVuedvJ6
vgiB992e7/f7QsVw7twUySDuCdjRTfUod7WGrdgWKvVAjZoeO3DthmffjtKpWZy3
rxu5IGW3mu2CzzWsBAfUQWJFpvghHiuSS4CQ/rzrWYenDTeuJgh2dGEGloyTF4HZ
NAxd+SN8bSxfiKT+OcC4Bv1kFIEtg6nUjM1wKVE3esScsqKu1EfT/XQgBkt2MY+i
byZXTI+gvpOBW3/rr9gcmU7LVfSardHc07TrsHlWMaeljTcGgnQ7XOQELbtlQKTR
c+WbQzVp
=ZX2a
-----END PGP SIGNATURE-----

--UKcMaLqDZGNuF5da--
