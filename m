Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F371C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 19:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F97820E1;
	Fri,  2 May 2025 21:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KyfTAkok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28EEA82102; Fri,  2 May 2025 21:59:26 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F016481FAB
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 21:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-601a8b6c133so1858122eaf.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 12:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746215962; x=1746820762; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s5r0SuKLMgtzanYDgo6nkcAMp5PqltZWqz6QF4EVDJM=;
 b=KyfTAkokWvN3V8DBIq8J5bBI65h6Mc0t3KA9I4VrZEvvA+muH2EaQPwHKkJ2RML8Ea
 jGbehgEgTgWzAt+7pBqwZUdxYufahPu6M2P/1mK+an4eWeD7tQxdOEBgNaoot53M7D9e
 n0qtrfTqcrG1rvJAzsaotkkYY4T330q1bGpGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746215962; x=1746820762;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5r0SuKLMgtzanYDgo6nkcAMp5PqltZWqz6QF4EVDJM=;
 b=BAMYuHlrHN75QsxjLqAzG+JoUOiD8X/ixGOfQEkNr4U4eJKidVJy2rWiCh3xlgSgVk
 L72F4Gx7vK0ZLSYi/Kv2RdKfQxDVRzV0F5Az/6jL8PRBeKw32PJN+49v8XiCxAyaE2d0
 0RBqdRumI6oaFxEkQeHjycU58hMSPo2aD0l7YiK/6g7rFhnvktjJzpAs7Syx0mNXMqFo
 7y1fxZfMzMbUa3ERGBNdFS06F7YVdltVuzl6LazDrMGWUcYjZl6xwQWrfVNzJiluAoGS
 ejBHkjc/DVuJZj0+CWzDUL6YLaYQ6NbjiiaegKAB2xfLJDggD0pOegluKaDw1RqvxKxY
 csSg==
X-Gm-Message-State: AOJu0Yz5yPTPz9GUA0C66oFxcHFgehxiTlJNfD6ydKsWJgZjBYM8oQSu
 vf0ZpRkv19ftzDfarMMPLHPESOpFhb3Hx+Yikly7eULfLONH1bExO2jmdf9OAkY=
X-Gm-Gg: ASbGncsE+1XX9mzDJNLor2jZwFHuO+rdYRKny86Ic9J0uDgUJTzbZfXiseeuQYfSzyU
 LzxQ/Y5Un2I4bikhPeygHNFc5m3cNX2gJU8ftyZgYCur8QmMWwB/CDj72VHV/u8QLZnKQOfMRrC
 QAtaGwCaBqNVeA7l2g9nsbnoVWc6do0g1VUfUJtKSJEricn6I3QGGR1/1UxSqufzTGoWCyN3Xy9
 1NE41DXhyBrJ7Vsf6D/9sXKBJm22BYFG6bJhOGA74T2jiJ20Av/C/GAbRLGGu/qCTk/nIec7h5y
 uCZwRzZC/R9cgeveFv0vbNzuStQjRj23/Z03LNPTjIYFq0R8my+kJFrJPRNTu5S8yyv92zOySSY
 s4A==
X-Google-Smtp-Source: AGHT+IFDATUbkGmyMtL6YksAslNXtI0UGAcfRUhrYXxqJnELMmMqL/t2tWs0CbZc8XDq56YSIKZavg==
X-Received: by 2002:a05:6870:a797:b0:2c1:2262:7941 with SMTP id
 586e51a60fabf-2daafbd69demr2276896fac.16.1746215962693; 
 Fri, 02 May 2025 12:59:22 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0ed89aasm748765fac.17.2025.05.02.12.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 12:59:21 -0700 (PDT)
Date: Fri, 2 May 2025 13:59:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 00/13] video: Enhancements related to truetype and console
Message-ID: <20250502195919.GA1368027@bill-the-cat>
References: <20250401172948.1236000-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zv2MsCGFOYG/8MHg"
Content-Disposition: inline
In-Reply-To: <20250401172948.1236000-1-sjg@chromium.org>
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


--zv2MsCGFOYG/8MHg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 06:29:31AM +1300, Simon Glass wrote:

> This series includes some precursor patches needed for forthcoming expo
> enhancements.
>=20
> - truetype support for multiple lines
> - make white-on-black a runtime option
> - support drawing a rectangle

For the series, applied to u-boot/master, thanks!

--=20
Tom

--zv2MsCGFOYG/8MHg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgVJA0ACgkQFHw5/5Y0
tyzNGQv+NXuCX7TrUJHsofx1VnuRgKE8c5HorKuFZfjEh20S+u4Y9nym2WiAyVFK
pMkyLMtxoLRDNqnKS6wJWzzYd80nDOuSBWoHyhakoinTOBGUde9iO9trsztRw4x1
It7r7EtWxyMwSbcfS8r+IA2QptyAnJI3ItXEVS+fRepjClBoI89N7yhuLKqmD+aN
0YqOlO27YOjzNEzEMnmAgI0AOc2IxcLCNc0Nkz7Y7cr+ub9auIlUxilMuL1IdEVj
+WUcTiuxgYrPjF7sekVPdEJ8hT4Ro5pvWQGa3qxzKn8vsYlMJ2GqDju5eyejMfTf
rNL9UCh0fnLCh9WHBKSde5UJhWtahb8UHSqTUDFuMxz+Po+I2qVJUsaLrZnGNpUX
ZR1nNSSbC/kO8r7bTRT39yt017EwssXREvkzdlGd0/gzmR9jGdv1f2RXg0e18UIf
oYDNEIwBz2FW5rarn86YqPLB5AibSH08WGlnbYcd4y6VwIUeUER97KAz6V3rhd8r
pIregm6U
=T1sh
-----END PGP SIGNATURE-----

--zv2MsCGFOYG/8MHg--
