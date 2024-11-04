Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7499ED132CD
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:56:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE9A388D90;
	Mon,  4 Nov 2024 14:56:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bIli1RnR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B17E88D90; Mon,  4 Nov 2024 14:56:48 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3ACF88F0C
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:56:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b18da94ba9so360382285a.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730728605; x=1731333405; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=phepwJTgfNbhAIoXrt1MTNquKLhGjdLoIIOhsg7ccV0=;
 b=bIli1RnRu9lPnyrGzMPBLr7Vq5rNgjCCVfPIst3x3uVwH05eZypIAVKO0H9+LKeajh
 KXqutgiRRUJKWbcxF+/VBS1giI8rM4S+FUL2W7qfQaH5ghnMQpj7yNpy774k2iN9lqkb
 dooTFvzpY4MxyA9d6uE9LSVnh+xMbmEDurKLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730728605; x=1731333405;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phepwJTgfNbhAIoXrt1MTNquKLhGjdLoIIOhsg7ccV0=;
 b=DoX2Yy9IRIxytOSs5xHgrCbqisn4OZG0gIq6vpuuoBHGYvQs3/MNx3pAHnzubHQ/hp
 +vlhDlMuvugGMskz7NfYehual72OODhbtVyBsnj95RtLchr1igjK9wOs7jK3+bw9HaYk
 QMhId/sbAl+C5EoIFzANAvFXW5TwAP3U+rBYn8tU74Ww4ilzJrngc5LCVFaymBkbK5Ym
 8ukghIOZvPEoMepwr5qsuZju1GbtBItlTHGIEeUUDesZGbQuAo5vcXsTnnTQJZjRc8K2
 TjBs8ZwcqZazPNGKoI6vTZ9P9zKL95n+UKWX+Hg76Ed+bGilSfrerns17IHhqYb7Iitu
 UmWA==
X-Gm-Message-State: AOJu0YxYneKRY2ngXRoaZlVDPfWqMuzVw9gxEQfqLx4/ImFp6PPvNqpl
 Q1OJdU5P1rVJ5aD21C3KLxyXPOxtauVh+2E83f9G6y+lyVveTER98YWA3qGrm/w=
X-Google-Smtp-Source: AGHT+IFtESJGzYcSTAj2+oOuzO3qksCzyhf7w97VnlrNg6pKHog9wDGyhKxHG5Ya/wbK0SaVo9Xuig==
X-Received: by 2002:a05:620a:318b:b0:7a9:ba35:1863 with SMTP id
 af79cd13be357-7b2f3cfd61bmr2369379085a.13.1730728604759; 
 Mon, 04 Nov 2024 05:56:44 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a864f3sm420970585a.118.2024.11.04.05.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:56:43 -0800 (PST)
Date: Mon, 4 Nov 2024 07:56:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm
Message-ID: <20241104135641.GL3600562@bill-the-cat>
References: <CAFLszTj16p8-H1J349FoLowzpO7SNfdwELEDyDmi=U9+gZiCbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gQpHVDybWW/2mbuM"
Content-Disposition: inline
In-Reply-To: <CAFLszTj16p8-H1J349FoLowzpO7SNfdwELEDyDmi=U9+gZiCbw@mail.gmail.com>
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


--gQpHVDybWW/2mbuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2024 at 07:47:46AM -0700, Simon Glass wrote:

> Hi Tom,
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/23152
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=3D71&view=
=3Dresults
>=20
> The following changes since commit e61ea9f2e5d2967826c2c6e3edba961064fbba=
a1:
>=20
>   mtd: spi-nor: Guard SPI_STACKED_PARALLEL with DM_SPI check
> (2024-10-31 13:34:29 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-pull-2nov24
>=20
> for you to fetch changes up to 572b7b0255f9f33002ce7d2a8b2bac30ab49a48e:
>=20
>   sandbox: Fix comment for nomap_sysmem() function (2024-11-02 16:14:55 -=
0600)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--gQpHVDybWW/2mbuM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmco0pkACgkQFHw5/5Y0
tyyxaQv+PU+yy/1nUIxiTgmkcUpwuEQmUGcf6RE5WYzUVzLwtTpcOiG+A5EkX9si
Mfwr4XQvQgf8jjSRiyPs2LKJH2b8e8hlugSWZZNHFlFrjdPFSmQucV3NTmYbAfWo
YDcjeg3lWtQDDt1uqC9jaeRuEAxUlQ3jhyZxmP1KczFqKIlNbea3kmFTpiYz/01C
0trymRaIH55l2bIUC4irBXFvddov7ABxGoZopVGzve6CO9g0anBAxYbxqb2VS6+u
hMyFtjoX5lxM1ms9csMgUEE5QX8QK7ugnzouLb6kmBWN+Q24igILoamQ9g5q1Tum
Gf1T/82FwwskYBttl/VQF/EloonJjhIao4yCZ0nWF1n4gWCCFrxz2hX7NFv22tJd
AlR72gRdlMQ80tkXkYVglhelg1QPgcO2HCvoMQpEdSNRX+lSQVBzi7DDf7lHnavp
PS/s8s8RHS9bSpwLCmVxAJum52sgSGYnCzuig6JhukfjdbqN+NfmJkgGwWoay36D
uq2Izqy2
=/Edm
-----END PGP SIGNATURE-----

--gQpHVDybWW/2mbuM--
