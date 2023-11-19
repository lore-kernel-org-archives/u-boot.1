Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F8DC54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 16:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4CD987135;
	Sun, 19 Nov 2023 16:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RCIdZD70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 729BF871A5; Sun, 19 Nov 2023 16:59:30 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D606874A3
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:59:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-da041ffef81so3642586276.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700409563; x=1701014363; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ojzhIWJCyd1eTgG5zSNTmk81VfNljzoVyPLv1tTbYEE=;
 b=RCIdZD705O7frx25n+e+JS/C/B5c/5zjnTEldxu3yKD8HQSsHHdivAPGQHlFKqf1XK
 0rQUfY27TNHLfzw4gayiQtyAfgcFQcEn4/0J2pRGRcLuK9ffrtps4fD+Zat9SItSCx0W
 zjgHPS9m/CYIiSJPx9C3E3XatIVPR4tyCDzA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700409563; x=1701014363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ojzhIWJCyd1eTgG5zSNTmk81VfNljzoVyPLv1tTbYEE=;
 b=m6pAKjdej8JRpPh6uoJUDWdiqlm194c3jvZ8nD7zz1xEhjUiJt8FGi//bXWflXS3Fh
 xj3NW75jXwQDqbrativhZTQ7t6l15FDBWCwOgvX6LJjywgiEMOCqaWO3dp0oOE+2WXEp
 OraAI+kjE7BvKIBn6g07OQ0vfwHbZyLyfJg82S64ty5J9rmFhxmMAfh1VRU61mM3FvtO
 HovgG6ftv7QMjj9czMFftRfl8B7j3gqJUxXwjRpWZZ+kqlsqyFXKoZKYUkvo1z5doLDi
 Ya7TUe9RnADYIb0M621dae8L/GHUt/zmQYzAcZmIt5/qp3LwXc4zeMPhJPmbM38hJnEj
 b11A==
X-Gm-Message-State: AOJu0YwdS1k2rfdLfdQeXwk7oOPjeyh9q382EXTAfgcunuFxChtyWg3m
 ML76qAfdyrg1hmeSFgjYDhzwcA==
X-Google-Smtp-Source: AGHT+IFYAPYTBgjGrRhHL5Hp9QUgAm8esi5XcjxtxEjvWgJ93UINDTwTwJDTr28HCfCdi/WKy6hvEw==
X-Received: by 2002:a25:e650:0:b0:dae:e973:4da7 with SMTP id
 d77-20020a25e650000000b00daee9734da7mr4951662ybh.45.1700409562999; 
 Sun, 19 Nov 2023 07:59:22 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-af10-dfdb-a5aa-dfc7.res6.spectrum.com.
 [2603:6081:7b00:6400:af10:dfdb:a5aa:dfc7])
 by smtp.gmail.com with ESMTPSA id
 l129-20020a257087000000b00d8168e226e6sm1526020ybc.47.2023.11.19.07.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 07:59:22 -0800 (PST)
Date: Sun, 19 Nov 2023 10:59:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v3 3/4] bootm: Move arm64-image processing later
Message-ID: <20231119155920.GE2513409@bill-the-cat>
References: <20231119144338.630138-1-sjg@chromium.org>
 <20231119074333.v3.3.Ie34b75c75347a1c04bffa780220afe9011b0e2bb@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A9cAtmVYrbsPC9Fz"
Content-Disposition: inline
In-Reply-To: <20231119074333.v3.3.Ie34b75c75347a1c04bffa780220afe9011b0e2bb@changeid>
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


--A9cAtmVYrbsPC9Fz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 07:43:33AM -0700, Simon Glass wrote:

> If the image is compressed, then the existing check fails, since the
> header is wrong.
>=20
> Move the check later in the boot process, after the kernel is
> decompressed. This allows use of bootm with compressed kernels, while
> still permitting an uncompressed kernel to be used.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--A9cAtmVYrbsPC9Fz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVaMNgACgkQFHw5/5Y0
tyyOkQwAnxnHQEloQDfxWIqM6V5Tz9V6OhYDBsmBxZnp7DMVnJ1nUv89dkBaPd+N
19MAMeZRHeRrKjrZTira3oI5i85CUvRfDfm5R/61Yq098y0NSdE0PNdDSk7G3b0a
VWm+TzWa5jZQhs3qAZBhQGy7lgHV+XGCpGT1FzYksc36r6Sa3+89sS4K2IjRUPTi
QPjyaTctFNcBnnp7IRoLragfU6qia4fFArmAJgVzHcosKUjxEthP6VJYE6zxDGNq
Ay9C2Ul5u721suMVA6EZqwDHNL+qwcM9O2wmny5mBh/txcKq9ybFNFufUzO1PcBP
MhlKhOSYcmQiEiPueYel/AA2AWoc4Yep/HeGKO0NFKGdQ5qQl2tgkMpaR3dIT92z
v08R1Ozw/S6M/L9C3irT5Pw+y5Tn9IVgL5X8SuGPNBU47a75w34LH2plsPL76GBn
lktQHOCh10oP3Ah+VkplhDw3M4262zHUYUcmPytzx2PM84mxUautEoUzLOsNJ9SY
VPEmsLIb
=x6s5
-----END PGP SIGNATURE-----

--A9cAtmVYrbsPC9Fz--
