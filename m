Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBD8D637A4
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 17:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72F1388FFC;
	Wed, 13 Nov 2024 18:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MuhgbQdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB00891E3; Wed, 13 Nov 2024 18:50:24 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97FF388D56
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 18:50:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7181285c7c4so3788031a34.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 09:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731520220; x=1732125020; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LKwziRZvD+J/iXYTBJ3FczttEeM8pjnzwoTfIvBMLsw=;
 b=MuhgbQdJ2h8X8E6PK00BhDo60L9IqsAKR43J52EIkeH7MgQpJ7plPXQeJirIy3JIBO
 f5y6id0TOFdniliOHuBlFEtRMqRmoKfPPyqcXJhGnwBVqrvFddZyWyJ+IvGZucbgf5Aw
 hXnyyOhlVC7csFBu5luQqwkBnSELdyBE+RbZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731520220; x=1732125020;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKwziRZvD+J/iXYTBJ3FczttEeM8pjnzwoTfIvBMLsw=;
 b=H3Nv6w/vl8DQizUyTBFOQNIKL1aCCk44Gky8J7Zb85JJcuspMqaiGnGvQGslRqmuTv
 nddeWSh/XkjhW5sKj1ATeWk1XZA1YHC7KAZXyqNwNtHH2Y8u10oRWCXdNhPx39qu4NMe
 HyX2lMXdSiwlZnwo1Eh5YAyT4LTFEkFf+pS6P+VxbcsnBGMuPMZK+V6VEjrDrSH7ETKL
 jrLUQrfkhhit5i+ybBL3gIKv7iELeqvPK5NKDLmAq6BwwcUx87yrh6jCZ88HJ0UWxQ58
 9nUoN4RBw2reBawHdVcTyTaGYlSzlyM0l6wzyU5zDG8DHUhVSrqp5oMgd/6UUa2Dj6zm
 w0+w==
X-Gm-Message-State: AOJu0Yy4hNcJcQqF0Ds/GLbqaYMvHqH27a4D2Agky0PlVRTMv4LIwp8F
 DGdZhWr9buUVgkW5mBDhQZgAgFoD1GA3S7T9pSHW5n908IO4J5y40S227cKeGPU=
X-Google-Smtp-Source: AGHT+IEO7GpK+iF5ip3haYWUvVmC94FptV8h6NrB4YASwuA/DqOQJc0FvUw0qTaQoaPgUfSMl8hl6g==
X-Received: by 2002:a05:6830:3c0e:b0:715:4a9c:a7f2 with SMTP id
 46e09a7af769-71a1c28adb6mr19389642a34.24.1731520220355; 
 Wed, 13 Nov 2024 09:50:20 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71a5fe8eb32sm785658a34.26.2024.11.13.09.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:50:19 -0800 (PST)
Date: Wed, 13 Nov 2024 11:50:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v5 3/8] efi_loader: bootstd: Drop bootmgr for sunxi
Message-ID: <20241113175017.GS3600562@bill-the-cat>
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mbbmCgdKfKHOULEm"
Content-Disposition: inline
In-Reply-To: <20241113150938.1534931-4-sjg@chromium.org>
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


--mbbmCgdKfKHOULEm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 08:09:33AM -0700, Simon Glass wrote:

> This causes problems with the boot order, so drop it until we can figure
> out a better way to know when bootmgr should be used.
>=20
> Link: https://lore.kernel.org/u-boot/20241112171205.4e80548d@donnerap.man=
chester.arm.com/
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

I would really prefer a short summary of the contents of the link in the
commit message. I'm not NAK'ing the patch as-is, but it would be helpful
when revisiting this if there was a short explanation of the problem to
solve here and not just "problems with the boot order". Thanks.

--=20
Tom

--mbbmCgdKfKHOULEm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc05tkACgkQFHw5/5Y0
tyw3rAv8DJX8Yk3B4iHfjlsVqmdHUV3EYmFccjDxh3qBdOweUd5pe4idXjgvpVRp
YLkiO3S4j/80l+YvXOqI+L7M3y6V3EMQIOnFVe6qxH+OpGxuZqewuGjRF2/XbzVy
AeOnzQxd1qxhZI6VT67Ytf+0jbTtqyk1o3Jsq/YRxa+4T95StAO7iBM9dcs4eFFg
+PEebptIrt7+p8haC99Oyw6GnsoFUwbVQnDhW/rkPa5juwO6F12NVNJhXnF52rEX
ppI7IyeD48sdzLw+ZO2UIxrW8pV826dtKy+oojN4Cd2jCxI5yahX5mdtI1hvKkO1
s2RqN6MObDKIITXIagpnyNfZt4pk46vwMsbKO33x6QDEFYyJJjM7BypbXBnDLNLG
xJH+n3ZPAfoEBZnIcPok+9ZZmvJlo4HHHFLgX7ycl2sT7GPdWnq8Zx+KCtqRcu08
4nM5LkIjapESbARCpjSkwxN/MSLmXy+VvKKK37AF4+D0HQ+Yqx/i8hYeEXZ1Db8l
d2jJtz0b
=6AZX
-----END PGP SIGNATURE-----

--mbbmCgdKfKHOULEm--
