Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1607C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6425680762;
	Thu, 23 Jan 2025 15:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hvtsDSMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE7080762; Thu, 23 Jan 2025 15:32:57 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8330807B3
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6dd15d03eacso10108676d6.0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737642773; x=1738247573; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SApbl0/CezUXrvfIXIXiWYFFodK6nZ1Yb0pAacj6WzI=;
 b=hvtsDSMBzOYXZMjsF0MypRRcKiw0AEubiuDn8ibDZ8HmyYJFD26SInoBoE6ThxLb+3
 Npy/IDWaa7H+vh0Q882YqvzM4XqhkZxk+ipgkuuQoq+BJDKnVaVpH8AxW+mP9wMaG5Gl
 XYtH/lkt+1lVWWuwYZ/ItVuzDC1VB/bc+qwUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737642773; x=1738247573;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SApbl0/CezUXrvfIXIXiWYFFodK6nZ1Yb0pAacj6WzI=;
 b=CM8p59/qf1RwQHJGUK6oabtLW2LDZIqrcDei+HvsQvTUKVQZcYdV2lzAyp8XJDNH/C
 msJr8k3Bc23MTwGfCmZ0u5MkGqvgHaMDovlZLbDnZsSBumL7z2Yw+6aUQRRW0urnm/Co
 vZr6bd/dfhMAW/a8THM6E6UQ69CiO1jzr12G0H6YfDaJ2rsyYGNKQMpgaXJqTt+du4oY
 Qsw4LPL0biDr67c4gsWSOvUIYWO73HKoIoCefQ1p8EUaX8Q4DpgjMje3LRkC7Lgo8KOC
 F44hTJaN4/8qy9l1QeongnWfKfHXQ45x1ri24dzLlqImbEWKA1JD9LuUx/Ur8eSp2Crq
 2wMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWToYnuS6e2UA/TcXecjJcM1N/UB6+RMFKbaLxtJAYY/u+FbKkspReQ43xv2LXRylf7V1Jqmeg=@lists.denx.de
X-Gm-Message-State: AOJu0YwIEaquDTED1QwrasmlafJjSi2JASrfpp7zY3Omc/zBnIlDhu/I
 g1axu1/OY77KtWH6oMjN5gyl/6whX6ZnyoVYsG5BgudzGvG4fwBEJUThTIS7dYY=
X-Gm-Gg: ASbGnctId+xwX7cRYZJmqXSzCQ1SsZUKZatafjc1Mb21pNi471Si7NjT54DNaWfoVdW
 BTwGYWQQJWPr89mrc/72KOOcnTG9YE87PMdhAZfT6VKoD1zKN+KtEm1cgJ1Hj7NaXH31+JgWSyT
 x+SXUBO604tXllnYlbhGJp/dUPGIZyZ8vdVlbPUhYlHCZF9OVTld67koDD1SlokHlOAuZQiyWFL
 CbcCzBkuU6mpP9S5rCsgf0AXMtYcSw+fpRcju831ZWpa0UzYDPFXZtrejzm/kBAqGJ/A/OsTHD2
 4MiQ
X-Google-Smtp-Source: AGHT+IFwuR7lufyNipGYX7/jA82O7R1Ml9wAA6iWCFRlOA0xNmrmqzyTiPouTGqxHecZMT/DKzF8WA==
X-Received: by 2002:a05:6214:224d:b0:6e1:a260:2af8 with SMTP id
 6a1803df08f44-6e1f9fb4492mr47979476d6.10.1737642773587; 
 Thu, 23 Jan 2025 06:32:53 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afbf2dccsm71073256d6.15.2025.01.23.06.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 06:32:53 -0800 (PST)
Date: Thu, 23 Jan 2025 08:32:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, John Watts <contact@jookia.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Michal Simek <michal.simek@amd.com>, open list <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] spi: atmel-quadspi: Depend on SPI_MEM
Message-ID: <20250123143250.GG60249@bill-the-cat>
References: <20250123073713.2988293-1-ada@thorsis.com>
 <20250123073713.2988293-3-ada@thorsis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ab4JK2YB8VCVSix6"
Content-Disposition: inline
In-Reply-To: <20250123073713.2988293-3-ada@thorsis.com>
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


--ab4JK2YB8VCVSix6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 08:37:13AM +0100, Alexander Dahl wrote:

> Most other spi-mem drivers also depend on SPI_MEM.  Fixes this build
> error:
>=20
>     arm-v5te-linux-gnueabi-ld.bfd: drivers/spi/atmel-quadspi.o: in functi=
on `atmel_qspi_supports_op':
>     /mnt/data/adahl/src/u-boot/drivers/spi/atmel-quadspi.c:460: undefined=
 reference to `spi_mem_default_supports_op'
>     make[1]: *** [/mnt/data/adahl/src/u-boot/Makefile:1821: u-boot] Error=
 1
>=20
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ab4JK2YB8VCVSix6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeSUxIACgkQFHw5/5Y0
tyy8lQwAsqA5iECccR/fo74JX1m07BmvMdEq/a3Ei7K9iPav/sjibx2ElaaLtArR
N6dcfcK6C6NKHHEkXm6aWynpeIuc6IWT+lHdLhNsbWpgmkaySyoqW34swf4c12cz
JxE+JTFeFp9fmxHCK3dn+7ILtAvkSot5fkN7GkjKeeIEvwVdhKopP23DbT/7d6B7
gECf+XzOdLxiMvsc7r98R2q28QRQeSUcUP8OyX/coJW76ceBJBP5dAF/g2csJb2R
yk/W1xw9ClfMNrBMkC+eeLMaOF7zrlwnmfPC/qoJT58PSSSa3h0pyfXs+bBtagsv
M5cV+qnH2T1gLXNhatPJS8bUNEkJPCgYVXAXo2g3m8IPglzHS9BomCm5MBjUOSdQ
iU7DBAZyW3QfpfonYToDHCucYyPXCYxq7r0Kri5+uR6+bJ8oRV0/fojdguj0y6ba
A0AWNGeAHwjkIgLHX8SVAMd2vxVCLVYy3qIwMGeg/i+gIfi6Gt9GTzngMkS/hwQE
K2CLugE4
=pM5A
-----END PGP SIGNATURE-----

--ab4JK2YB8VCVSix6--
