Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F5AC3ABCB
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 14:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C22A80ADF;
	Sun, 11 May 2025 16:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TIpSrkXu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 118FC80C83; Sun, 11 May 2025 16:39:23 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB32C8091A
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 16:39:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2cc82edcf49so1121346fac.1
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 07:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746974359; x=1747579159; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lb7RyEBnMd+YcyLrT+DbPyQmfGpeUExlg9dxcGWDBtk=;
 b=TIpSrkXuDEcSXZrxdpoweIKQWfiXeznsWbcS717VszofARhdx5SWzgju6EUo+UoDEa
 mBohGnQil9bWJHVfYUHCRMflxqDZgmzIq7qxyLGYM3OmlKw2osi35qrI+Uhwj1V/2oZn
 2xfQrXUZpjxT822DIrvjd/thErWE3PrqDkasc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746974359; x=1747579159;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lb7RyEBnMd+YcyLrT+DbPyQmfGpeUExlg9dxcGWDBtk=;
 b=M5tjs+L33bxCOl+aPd7Za08iBChZchH7Yfy6VbfzwSAe9jbbE1fIuY0KakAkzYIhp5
 yuRFI5BJV6LfC+lZJ4qCVX13H8MUaim+kwSvSy3A9nnXPtd+BF73R7MuafZ5Pfa3/vRw
 mFV0tVlR0v0c0lQyA4pt37tcegPLDbefsqfvyrBaBA2dYAby7nVpJ7SECcQp7x1I00+L
 dJvZz3A+LbVsWKcZZs00Ny+9zKHJ+0phKee1SILxnXGyz3sgLaJ7af9owjXhVNM5plCg
 a+YZ1Vwsn6SEYS0EFEe/n6MyvlplN/KX6Ie2AcnamuuUYpfVisrJ65DmeS6kftKqwdu/
 D2SQ==
X-Gm-Message-State: AOJu0Yx4i9KBEI2Kk72wvBMuaqM4ZpjTF+FYzWiCablqScqxQNzbLxWA
 jx3Z6LUmrzLYO/CfyT+OyZBl3CBaGbNJJcRdNvRRRG0+Yb1B20qqjeM4MkPZuCY=
X-Gm-Gg: ASbGncu+W4POQ/rSASGww32RR+j76GF21iEcYHkbkr6nWawSeGoc3WIttgVLatdrCIt
 1eP9Pe55YsR3xjDhBAMnMn/C76p6yhgUgyBjsrHrbhtrpOa+cGGaCN65bIoAVipc03k+ENdSyph
 vnHyEHIKny988nSzjgsDKVlA2lf0LPBBQMujhJ15lsvxgNNqr1KVBmyo7uO4tow9vhpXcD7KiA5
 pjpiM072iN+uLSlCY4NaLNhL8enON4Q+SjfRP7TfUOMMUY93seEVBAJqlJf4VYzhgotMsevnBW1
 mu+57DCeerACR16tW0q1lSAMHnl8o0gC4C5hv5AZqZ8pMQSALQjdrIW9K39aPatO6x7m9UI8QBk
 k8AnaVKBVuwim
X-Google-Smtp-Source: AGHT+IFqi7+37050H9Q98r7gMQKVayEw7GFL+yBPNlltyfYIm5NHXLZcW05h+H94Dxbc8fjAkxNMDA==
X-Received: by 2002:a05:6870:548c:b0:2c1:bc87:9bd7 with SMTP id
 586e51a60fabf-2dba4551797mr6271823fac.35.1746974359532; 
 Sun, 11 May 2025 07:39:19 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba0af8c1csm1447730fac.39.2025.05.11.07.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 07:39:18 -0700 (PDT)
Date: Sun, 11 May 2025 08:39:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Richard Weinberger <richard@nod.at>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 0/6] script: Improve the QEMU scripts to Python
Message-ID: <20250511143915.GN603748@bill-the-cat>
References: <20250511141828.2367318-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SkeGqp+N0sVymmtG"
Content-Disposition: inline
In-Reply-To: <20250511141828.2367318-1-sjg@chromium.org>
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


--SkeGqp+N0sVymmtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 04:18:15PM +0200, Simon Glass wrote:

> This series updates the two QEMU scripts available in U-Boot:
>=20
> - Converts build-qemu to Python
> - Converts build-efi to avoid sudo (unless SCT is used)
> - Introduces a proper settings file shared between both scripts
>=20
> It also includes a few documentation updates.
>=20
> The next step is to get these scripts running in CI.

This extends the anti-pattern of "one big repository for everything"
while also expanding upon the scripting that I already said I don't want
in mainline and I thought you were going to maintain in the
u-boot-contrib repository instead.

--=20
Tom

--SkeGqp+N0sVymmtG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmggto8ACgkQFHw5/5Y0
tyyTswwAkijFag9Kzcupja0YsFiNTVHj7N9BN3tSBEnc9KE4XpyCaIaIVIxkjAac
BswDOZyPEiGRDIF07FobMChhM73yItKz48tQmRLFJj6yvX+gFSCboTDsLlCIGTv8
JdGbo+uwCkXdiKsg5rlTk3TVgfue9zUza6PTZxGg3vllFbcng8BqAU3HUhTOlJ6T
OqKMSwJ+Zrh80X1DfVVaSKCs5IuUvmcaBDaF0P94ynMW/8rkC1JkbFs4NGFVl/ap
WNNX6khkz5ijf39ucp9porWXtM/5xBO76ONjnquFoQ0j1VwTvFgjoAyXuFzYqON3
lqpvT4Ryo09iTh6rA47fT/OA0TH/L4skS7hL8mCgAu88UKRupsvu30Mwd2bxgZGp
RGjtxkKmXTzQHeB1KbTnw/tMt+yzqyumhLUprZuax2sHGMVkQ3AUADPSuoBqwN/Z
okr8SAJawWJQ4tjmJUsZb8eA/3fY3dkgq1myk6cOeXcYNgWvYzzDqOt4szvoTr81
0iGNbdet
=6k9t
-----END PGP SIGNATURE-----

--SkeGqp+N0sVymmtG--
