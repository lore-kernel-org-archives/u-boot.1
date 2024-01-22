Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649D4C47DD9
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 15:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 913FC8743A;
	Mon, 22 Jan 2024 16:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L2BzrzQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E79568743A; Mon, 22 Jan 2024 16:10:17 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D52B986F1A
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 16:10:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5f69383e653so29439697b3.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 07:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705936214; x=1706541014; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rwR05m99KMLs0IEaIx9KArCTa+uNUlqjTePL6uLNIJI=;
 b=L2BzrzQKjr9sSHZHNjfIPgbyVqaaBvOgAu7oY09OeGeJfWfKi8igoYwCv1kRElpmGN
 Cq/wb2F7dhIm6D6aqmqQK6vIA2ZES7JRV4DqIr2NrGb1/KQP+Uqz4iiO83IYlI7L8wo7
 EeK7o0Gkd9NqeG5KnW9CK4pvA46mmJ63YHeoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705936214; x=1706541014;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwR05m99KMLs0IEaIx9KArCTa+uNUlqjTePL6uLNIJI=;
 b=LY3Cr7IZ0ae7mfMLb7XygNrwaeXtXnfm5p0Kp43j+ckddIh2jp6XmftzhgxvxrbjR5
 WYdNfczQrOjgMpKXvXbilS1Pcr3Id2Q6VibB1ZHug+rb6V8EGZOaNP/v9C2h+IuAu01B
 VOXRDVsbwkqJC8/9/JAMqdqeeCE9oK4NRjbqluB5dYFMlJWS9tzn6Pr6twtIlgpGb0sW
 THAk9PTWY/vC0EwL/9DFfrTUJpr7avxYJME8PdeHqGuRsd9xLgKjI/2WfUnfHr5UwMjP
 q+8y0ezFHPvkJWEDW0gunGPoulyZ/kAfN91J7EtRao5MGRSZyT/HLAWNGmHDSRXqTHJJ
 F+8g==
X-Gm-Message-State: AOJu0YwAHEflkQTMq5atjcdYyA2EdJZ7HeTk3DTGdhVKHckUBT6HGLiT
 lULLCNLY/OgSYzfu5Xn0q9Uzgzy2JzaFjF/Tga3VGp/TBTVK5TgM7/cyWmaY4b8=
X-Google-Smtp-Source: AGHT+IFrYZDWJk+VFGF2CUZFtcX5zEgz9OAgnsmR61LYmSLIWXyKAN11vQgTElTk9qKpmrYuzc+3Vw==
X-Received: by 2002:a0d:d84d:0:b0:5ff:9d91:1d9e with SMTP id
 a74-20020a0dd84d000000b005ff9d911d9emr3119969ywe.55.1705936214641; 
 Mon, 22 Jan 2024 07:10:14 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 n4-20020a817204000000b005ff6419ec70sm4382981ywc.109.2024.01.22.07.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 07:10:13 -0800 (PST)
Date: Mon, 22 Jan 2024 10:10:11 -0500
From: Tom Rini <trini@konsulko.com>
To: Enrico Leto <enrico.leto@siemens.com>
Cc: u-boot@lists.denx.de, alexander.sverdlin@siemens.com
Subject: Re: [PATCH v5 0/7] board: siemens: clean up subfolders
Message-ID: <20240122151011.GI3652023@bill-the-cat>
References: <20240122105237.939823-1-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XQrVZkGNjEPwfIhx"
Content-Disposition: inline
In-Reply-To: <20240122105237.939823-1-enrico.leto@siemens.com>
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


--XQrVZkGNjEPwfIhx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:52:30AM +0100, Enrico Leto wrote:

>     The common folder was initialially created for the common parts of
>     the products based on draco-am355x board family. We have the
>     product lines 'pxm2', 'rut' and the base line unfortunately named
>     'draco'! Adding the new capricorn-imx8 board family, the files
>     were enhanced without cleanup.
>=20
>     Simplify first EEPROM probe and access that implements both i2c
>     with & without driver model. Use abstraction functions for this.
>    =20
>     Move all am355x specifics to a new file 'board_am335x'.
>    =20
>     Clean-up includes, config checks, maintainer.

To be clear, the changes to common siemens code here break the siemens
imx8 platforms, so you need to at least build test them too, in v6.

--=20
Tom

--XQrVZkGNjEPwfIhx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWuhVMACgkQFHw5/5Y0
tyyAwQv/T3UcXlbi5yOuBS8EjWhWJ1OPoeLJRhIh5Eht+Kwfglag+rJTA99ms6B6
wuDBO4JMvJXGmHvU3dlzENg5W3idJBLyYksoiB8sSVbB7jnRQhbsunVZ1o2uYLod
S2491ixT1+3346XqX7W2duiStWV6pSqrS/FMAabjvBnomuQSFSakzuA4RgvLjxsc
ztVy9v78dKG2PkHDYnuI17uC1JkMaGGtUPZWP8ODmb0BUcnt93JcB1p2g1fsio+S
gtAHE3uSecNLUOEZu/NZwI0vQ2YSSRWdhgTYBjtE+LFPr+GMyzqjXWBJfxVkNEwa
eLIJVxBGCHyz2DA7flQavAKk11Lx445l9ykj3SFanqThcg4sYcIh8DQ0bsmQ+0/e
OXiwA2+m7NlksZKBFUYaC0Pi+oRrBWzSaFE0Ki+iXr88PTO0b/MqqVI6VhjDaewt
JrmC7PfSr6Lo406+yiNVYP9DUCY1PBBBiIuaTdFB68PEyD4LEbj8Djpc3hz6z5pe
DOSNsxRl
=wJLh
-----END PGP SIGNATURE-----

--XQrVZkGNjEPwfIhx--
