Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D3EC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 23:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 016018792C;
	Thu, 14 Dec 2023 00:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f/9R3d8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 721A387900; Thu, 14 Dec 2023 00:06:28 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95B228790E
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 00:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5b383b4184fso68079667b3.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 15:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702508784; x=1703113584; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W6BaVFcPhanQY5t8GH7IJh1nY7CkHlf+Kf2Xo4cZsB8=;
 b=f/9R3d8OY+76WwxgCktXOCAOQAvzhRjhrzTLKHaFagBWXUExbVNnu0xodeez/+Pm92
 huSoJ62mXtHpB73tS5u5mczWigu6RlTKhqq61WI5HdhVmI2bxrVKhMKNkWb/O/WVIpKE
 4K18xLVpAUzzaMHTF+spnmsdJn5pCRg9oECKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702508784; x=1703113584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6BaVFcPhanQY5t8GH7IJh1nY7CkHlf+Kf2Xo4cZsB8=;
 b=a7otjSckundawMjkEZPI7v+yOmagZhdBb19r9Q7q0vjBkCplQ/XD0iMtdEHLjwUdov
 6HXFa1ylk7p05s6nrqQYBf8Q4MvI2vQtQkTjNgiY+m7bh8AwOTzYaU1xU9eqr+T9k+IG
 kiPJu/Pt5oRZo1ImMFsLW/Rk1dAkUjwNGA3fUBn0RprKxZFNF5Ybg4IwYR4cbs1KR9bk
 SEYHA57NjdptIBl2uW/coN2V2v2bzTimH0Tgg8Enip/lcaidj6r1w2X3zf5WR1PK9iVC
 mhM0j/vNzPb6GhjTj+5dXrmNTxcNzGbJAdVrdKyX2bNIojPLdXPrAUIMH721KLsXWjvo
 asdw==
X-Gm-Message-State: AOJu0YxoXNjfxRh8mtOogyq9G1e7Fmx/Rjghh4CybLP2xuqrPfcio8SX
 mMcK1ptHJOC0KuhRnZDBokDsAyzEeSl3dvsiM6s=
X-Google-Smtp-Source: AGHT+IHs24tCQMqFHqrGFR9nO6gMKioami+DpSz1zVwcxc8YPUMH8ORo3K/hJFWqBHq1u+/C7+1f7g==
X-Received: by 2002:a81:9103:0:b0:5e3:115e:de1e with SMTP id
 i3-20020a819103000000b005e3115ede1emr1100522ywg.18.1702508784374; 
 Wed, 13 Dec 2023 15:06:24 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a816002000000b005d0fea7ad01sm5032509ywb.122.2023.12.13.15.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 15:06:23 -0800 (PST)
Date: Wed, 13 Dec 2023 18:06:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Duncan Hare <DuncanCHare@yahoo.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2] net: wget: Support non-default HTTP port
Message-ID: <20231213230622.GT2513409@bill-the-cat>
References: <20231213211125.279880-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/Crsd3HhFanlF9Cg"
Content-Disposition: inline
In-Reply-To: <20231213211125.279880-1-marex@denx.de>
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


--/Crsd3HhFanlF9Cg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:11:13PM +0100, Marek Vasut wrote:

> Currently the wget command is hard wired to HTTP port 80. This is
> inconvenient, as it is extremely easy to start trivial HTTP server
> as an unprivileged user using e.g. python http module to serve the
> files, but such a server has to run on one of the higher ports:
> "
> $ python3 -m http.server -d $(pwd) 8080
> "
>=20
> Make it possible to configure HTTP server port the same way it is
> possible to configure TFTP server port, using environment variable
> 'httpdstp' (similar to 'tftpdstp'). Retain port 80 as the default
> fallback port. This way, users can start their own trivial server
> and conveniently download whatever files they need into U-Boot.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--/Crsd3HhFanlF9Cg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6OO4ACgkQFHw5/5Y0
tyw5rgwAtBO6x3hwdM+7BRUJIuCxx29iyILX0HC+fFh/5iYXaTIVhkWlsRa4d813
oxCjmKZj2qJkLccR+1UrRhKc3Oq8u/FCgo8+9tiUKNBJDhl8KKK6hOOdAz2Qr/EV
bcYbdHKS09T4yv7ATm0qLjSwjtuV1IkC4rSJe2OgJYkNqNddEOSP5RY8pgGI7woo
RuTtyyJxKXsNVr0ThmuDQtU7QIUUA69oBjXsVuR4DKLgT5mOSy1bjXu/tE4nBWNv
ZDCYCTlELOyC0Sdj3FjKNemPt9PEw8ECr8iF55/WvAkoWKG5/wIuzJ9bWcLOWJF3
LZPhLR0Fr9vSObjSI4Yjj49ovEZ8XAAdY1+dRXsBhPBOn1y99VqrrqFVRaKhEnH4
hMtEhHnZxwWPfRkQTPQF3bmqRWW/CJQSr8ODNr9/8kO07Z8XsZVXp4qypvV6iWEi
CBOCNuisgCrUdT2wLebzP+/TjXjjCZ20P9VEvyS2aFl+qWreD785LIuEnolTQ8gl
0l8jDmUu
=DGkI
-----END PGP SIGNATURE-----

--/Crsd3HhFanlF9Cg--
