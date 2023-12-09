Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AA6C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 18:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65566876A1;
	Sat,  9 Dec 2023 19:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aaR/xbak";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 441D0876A8; Sat,  9 Dec 2023 19:39:41 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A46D876A1
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 19:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5d279bcce64so29049827b3.3
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 10:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702147178; x=1702751978; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cZHIWF+R5LarVCQ7byzr6jAtjIjFXXFL2Yusa7kY4+c=;
 b=aaR/xbaki4ydOCeoWenf0k7qV7NWN5YEllZBYsr87TcJ+Lqs9W4HTOzQa1w9FMLZc2
 bi+TON0JwRyqTc8KDee4R1K+7WWHzLvlenjCN4YwW1bG+Sul+2EXeveDFOkIETsqRNS7
 6mjdqLFoAh0ljrljH4x7QQH+MGqZ2WpWTXwaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702147178; x=1702751978;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZHIWF+R5LarVCQ7byzr6jAtjIjFXXFL2Yusa7kY4+c=;
 b=rJVvjKgsgCTLvpX5lgyEI5XUvbY5VtM+YA4a4S4I6sXYO9PbCfu6Yes2vobC/4+O0o
 yWWdEdwePLI50r/guxlfpIe0QtDd5diQ9f82H3Wn9GjYXdl/s3oQwNYlQbfq3rsAnME0
 gb2lPClyqZ+fEN8iguUi7F2WRtUpSLZvVUMUGARO+RylCgKZYKgyRresi4LEuA6wUfsP
 cKER42STKi/TVwRQGS7+gx0Kz8QUoaCcLldt4B+syDOs/IBJS37XHJqk7Av+7SADZTM5
 HxZ8kYNBNMe25UdIIDGAH+1+phEW2v0hmG7NvuXvIf4pK5vGtF2UuHgbplFaAKjjaZtI
 Py5Q==
X-Gm-Message-State: AOJu0Yy9dErycQbYionFGeO9dgOmcWTwSJsVI79GSfu1sEgsYyuro6Fm
 jQQl6orHiO4m8uAvcHeeRC2P2w==
X-Google-Smtp-Source: AGHT+IHCh0mfp6VajG2nq2x00jgQO9LwcRKHlKDSS+56piWZv/BBquyj44lmiDTUrxki/LwBgjlgwQ==
X-Received: by 2002:a0d:eac9:0:b0:5de:7465:f52e with SMTP id
 t192-20020a0deac9000000b005de7465f52emr1489128ywe.61.1702147177835; 
 Sat, 09 Dec 2023 10:39:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 e3-20020a0dc203000000b005c5a08c5c15sm1630456ywd.136.2023.12.09.10.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 10:39:37 -0800 (PST)
Date: Sat, 9 Dec 2023 13:39:35 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Manuel Traut <manuel.traut@mt.com>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: Re: [PATCH 09/14] pxe: Refactor to reduce the size of label_boot()
Message-ID: <20231209183935.GX2513409@bill-the-cat>
References: <20231204003144.899097-1-sjg@chromium.org>
 <20231203173130.9.I66588a1ea770bbeea0a355c2e533e32344302c80@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LkrM8DUe4P6y+s3k"
Content-Disposition: inline
In-Reply-To: <20231203173130.9.I66588a1ea770bbeea0a355c2e533e32344302c80@changeid>
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


--LkrM8DUe4P6y+s3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 05:31:33PM -0700, Simon Glass wrote:

> This function is far too long and complicated. Split out the part
> which actually calls the boot commands into a separate function.
>=20
> Change a strncpy() to strlcpy() to keep checkpatch happy.
>=20
> No functional change is intended.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Please split strncpy -> strlcpy in to its own patch so it can be
reviewed easily, thanks.

--=20
Tom

--LkrM8DUe4P6y+s3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0tGcACgkQFHw5/5Y0
tyyl+Qv+Klo3m/7tZ5JyiuE3Rwqiz6A1DNs9UA2Zq6Mt3wcjkyQSyTVd57e7vGHB
tEfjywmeiRGy2L1wSZjhrBS5e84mcPQiB4VXP4Y64vfqzo676WIttSvl0PoKIR8I
HNOEa2DRBA20FICKUlPBUet/fVGKFICK5c1tpRUZ1TSEcvazcfuRBZpCGodw7Xok
FG/xmdQvTQJxro5fQbC7wijUT59g7a1UxwpQgEVj62X7ZbkBHT3C+VxwAkqfOuMR
w4AIMAe+Up1K3izHSOgF7+C1Qk8Pckj08+WiPOSl6TXgyA3RiWaMQj6IL4Ylss8a
kSHoQdqOJ9l3Hp1rB/1kGalCSD3OGtYVCjdEogau+rjO5M7fiMzR1UYWXBJfwq94
kRaErd5hjZojFuD5CTxpRqMFeEGlkKmF28cdesumlVGxSevmjsDBksoTd/1HoZ2j
7wTqubnO3kD3YCMJu9hDne3kWfE3HNtLXnlRpqRlGsuaU7h1G4G+sl+OnrHox1Cv
14Ztqilv
=qQaG
-----END PGP SIGNATURE-----

--LkrM8DUe4P6y+s3k--
