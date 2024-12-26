Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C6EE7718E
	for <u-boot@archiver.kernel.org>; Thu, 26 Dec 2024 15:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D9A7803CA;
	Thu, 26 Dec 2024 16:17:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uNvthz2/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15FDB803D1; Thu, 26 Dec 2024 16:17:56 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2FFE8042F
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 16:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-46769b34cbfso98881901cf.0
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 07:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735226271; x=1735831071; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8eAtbTir811xFMuqYumwxnDKY4vu11M387Gah06a+cc=;
 b=uNvthz2/5dyzgbjW5A82e7+pRFsSyUjb3/lWEMDrARESMGJsk6IOGYSU5YD04KxHw2
 UL/AbExCyEdq35BHwLgZcJd6xKKm1a61lZiBCqJjWIoC/cY0fLLo32e1vJUxAATZNuRp
 YGN//rERyRhk5duSzTzMYI9OxeNfjth8T/6Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735226271; x=1735831071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8eAtbTir811xFMuqYumwxnDKY4vu11M387Gah06a+cc=;
 b=MkJdcK34PHkcy3gGBTkLp5Wpj+aUVLZ0O1saNp+OQCTW96Eij+yo3NImHmspd0aF42
 CmBKki+7E2cC9Q/Hcrwjp3NtxQd4Td8DioBJdXUarGwzWr6cwq90sSe5HuiFh/O7hC+v
 rvkD3POWwc0B7WeeKgXZl32WSWHMeyLIsBhJmebNYY+zDzFhmXrMBHjCu2NYKmLn7ETY
 p6yAGK5FFHkEpgilwq/u5vbGW+boyjMcBj9NuxR3gTiQj3Z5M1PuFA6c1YCfa99pcpDw
 FJGWn5N/4uKiTy1Qidv0Q7gYKzotn3E4SrH1CVlqcr2C9n4l5gmoqMJd/dAjbaqdO6hd
 Rk7g==
X-Gm-Message-State: AOJu0YwTUeQp2BG7Zl+34dQXk4SXkrIDZOSyqTwW6sAz7OwX6GkuG5P/
 4BAnDpiDtoLuu6oEmuoNJYPPQITtC0zOf6YEoLb7t8au0XsiIhwe82qixQK+azk=
X-Gm-Gg: ASbGncvwCplZXS2SR8wpfkJuybMRtkPn07KoP1wT9oEZLy9hwMYUTJ/8APXadvqtYWQ
 uydyQWYQJU1eLFk0ckUef2ecUrLnVUSJMJSiwHGmWTrFJhxHxPUTU1yrgtJheAs3m+zyZgaKhxC
 eRTZYdKikNmQ5GE6R4xXDwPFV16WW7P3xmdM3/+4Qm0g2qHHtCg3YRZTMvNAcfjRysJmIdX8Ayn
 ejEzbtcXnfAObI92GwBIC2ooZxZ6jCJofV46HZoKOz+9vHCUa5xnUMH+Q==
X-Google-Smtp-Source: AGHT+IFaC/ubaRYirPCfLizzndJUkJW9FQH6gig0tlBLeki14qGAjtqA2grqbpmQiYYxUwjqUoq+Xw==
X-Received: by 2002:a05:622a:347:b0:467:70ce:75eb with SMTP id
 d75a77b69052e-46a4a9a3da0mr342624541cf.45.1735226270679; 
 Thu, 26 Dec 2024 07:17:50 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e655432sm71465361cf.9.2024.12.26.07.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Dec 2024 07:17:49 -0800 (PST)
Date: Thu, 26 Dec 2024 09:17:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/next-pinctrl
Message-ID: <20241226151747.GA1505244@bill-the-cat>
References: <20241225183032.5248-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kWxQXP6J+e+3yaNI"
Content-Disposition: inline
In-Reply-To: <20241225183032.5248-1-marek.vasut+renesas@mailbox.org>
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


--kWxQXP6J+e+3yaNI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 25, 2024 at 07:30:02PM +0100, Marek Vasut wrote:

> The following changes since commit 68736cf8e313b74db6a6d32cbd081d1a42dbc0=
21:
>=20
>   Merge tag 'u-boot-imx-next-20241223' of https://gitlab.denx.de/u-boot/c=
ustodians/u-boot-imx into next (2024-12-23 10:28:15 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git next-pinctrl
>=20
> for you to fetch changes up to 545208247d0778c337b913e6663e369842e52ced:
>=20
>   pinctrl: renesas: Minimize R8A779H0 V4M PFC tables (2024-12-25 19:29:47=
 +0100)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--kWxQXP6J+e+3yaNI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdtc5sACgkQFHw5/5Y0
tyzPUgv/SWY8y8+eJiIpKegHYGUjVgc2E4n189eZHd9TXHIs8vMEEkWU6b9pqn5e
Dz5js51pwb+lh9YYoIetrmLos5rS564NI31pje6flb/eBmbBg7xVDfSk08Z7/059
n110hPaC4LrHbipCFz9ZgybDpt8jYy/4urW0cuIxnvXtzMlz6bf6nDLRPXkd7p2v
zv5/gl8ob4YSEIMA7+hU9jAd2cK/yGELVKchL8IKf/RBcn/gGGrCVVHDNuYVvwnf
pJgvLaeLw17/kIemg3aAi/LxbCbhs0LY6DVq8jAjTSGWWL11ITRpJ/NxHNO1TQMM
9mPP8DAYv4zgZzzREdxVpYCw7beuQEOX+Ib5msor6QMFusmhSu7cf0oUvlQI/XWU
/CzJ/rKjByi+y94+hVFAzDEsrOVDm2H4StwoH47Hq9aB7BI2p5RPjssja+QBou6P
l/fRJXbZk5Ll8Zp3ufbnw/1d+KG2lAHr+xpX0o6SVxZDkUitSYI/MkRV75t2e4Ys
41mnXjm/
=VxmI
-----END PGP SIGNATURE-----

--kWxQXP6J+e+3yaNI--
