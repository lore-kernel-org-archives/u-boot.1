Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212FACCFA17
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 04:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A94488CA1;
	Thu, 26 Sep 2024 06:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KL0d/JTQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E4CA88363; Thu, 26 Sep 2024 06:07:08 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 554CE88CC3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 06:07:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7a99e8c32c0so51800185a.3
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 21:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727323623; x=1727928423; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=epwMas2a2Y9sPjfgrGwccYvP2TXuIyluKS+osqWWNAM=;
 b=KL0d/JTQS2jDQl29/Y40fR3T3cBRyEZK88i8khpWRHnMx2uxLOknoPu4Vl817L6gIH
 L5mAWvAw/wr3pw0KWr/EtE6vbsesrnyCk6O00S81ZIqO9+vO+IDttHzn8lMZ95lyjvE8
 6qTxP78Pem5NvXzVMxsw0JcGjf7SPKpTic4ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727323623; x=1727928423;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=epwMas2a2Y9sPjfgrGwccYvP2TXuIyluKS+osqWWNAM=;
 b=CTQsHXY20NsTAbOVXdqAdFZqwMSsYWYIaxUcatfx3SmwmPWUOBleXzSPQimK782bK+
 w7ZN+rpIKElzvLNrKIdnUhuBE9vI0ySsSar/CQWIwEr1moROTvrv6JBGyly+24ZklfG2
 swQGkjtuIARYhX9XbSaylOYDwlOUeI2oy3jEJk1BjXpbshrnsowVTDG0++1d6d/9cBju
 bqk2kAfQT0b9nuZ4QJZk0EQi4vR60S1dBVoxHVwCk/j93AG/71oNkLE0v8t848VJwTzO
 6tfV56BkME7uPSrAoytyuR1r2xl7mfo8j5vc/uqrgU7mipFe7m7d89Boj+gwFtdy/5Th
 sE8g==
X-Gm-Message-State: AOJu0YzoYn3nmRzAyKJ7zp7KP1HOFkfqxmdrdpUYeC8mAu9aT0XoG5K2
 cXTNP74sRH49RuljWWYZlnai6yhdLNLMdjhde8TgInyp/DgtEAemgy6fX2o3fHBxgxidvBqz05R
 GXro=
X-Google-Smtp-Source: AGHT+IEzFHp5+kawVwzMcUB+4I0IPw5L05TI3/C+jw9dFEyzJXmiPOsgvzW9FXU3uv7dsxBcUi1aMQ==
X-Received: by 2002:a05:620a:284b:b0:7ac:de0b:88fb with SMTP id
 af79cd13be357-7ace73e37d2mr840454485a.3.1727323623161; 
 Wed, 25 Sep 2024 21:07:03 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acde568633sm237606185a.68.2024.09.25.21.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 21:07:02 -0700 (PDT)
Date: Wed, 25 Sep 2024 22:06:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 06/19] lib: Mark lz4 as relocation code
Message-ID: <20240926040658.GH4252@bill-the-cat>
References: <20240925125622.197915-1-sjg@chromium.org>
 <20240925125622.197915-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7xCzr1wEEfD+vDc4"
Content-Disposition: inline
In-Reply-To: <20240925125622.197915-7-sjg@chromium.org>
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


--7xCzr1wEEfD+vDc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 02:55:32PM +0200, Simon Glass wrote:

> Mark the lz4 decompression code as needed by relocation. This is used to
> decompress the next-phase image.
>=20
> Drop the 'safe' versions from SPL as they are not needed. Change the
> static array to a local one, to avoid link errors when trying to access
> the data.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  lib/lz4.c         | 27 +++++++++++++++------------

Some amount of how you're restructuring here leads to (a number of
platforms):
            puma-rk3399    : all +132 bss +16 rodata -64 text +180
               u-boot: add: 0/-2, grow: 3/0 bytes: 180/-64 (116)
                 function                                   old     new   d=
elta
                 ulz4fn                                    1396    1456    =
 +60
                 LZ4_decompress_safe_partial               1056    1116    =
 +60
                 LZ4_decompress_safe                       1020    1080    =
 +60
                 static.inc32table                           32       -    =
 -32
                 static.dec64table                           32       -    =
 -32

--=20
Tom

--7xCzr1wEEfD+vDc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb03eIACgkQFHw5/5Y0
tyw1wQv+PhKX2RmYCNfjpHj8+0s/soztje3/1FNV6doW5AF4LrRUSE9IzpmSb+W+
vUkBYqJ7y3VI+Kbrf3AtQBfLUNP4PzGuvNxjnzw+6NBtfoMzTT9aOV7bFxdMTVEE
8ZqbRwjSIAz6Jx88sJPxCI6ShSzxg6MjZ/BbPf4u9mUVO4HettZUMU9471DAvGZV
NjxTcLJJqfgp5u+7dRtuHVd7Qchr5Fzz1WeXeKWC2zwt2T2ixPDrP/C2jyi4Vdy4
MUemIawwZGFHXWBMBIIp7042T9eQJUZ7ftNgF9iV9E/ePqutgaMinwrU4bbOFGpi
KX+PZWJw3vcLGyGAJNo4yvtbobeknb4AQdyrTDj09dAH1ojf/1eUXUcCthNrXp5I
uELLGMOrrweRR9xZeHXDdLL0EczqnTfLOaXHP5VAaD6cenPk5bo+TJZfz+NLGFwr
zN4rj/1Vd86wkVvgqJBoWviMoM2DNdWzAcCdH1iU+RCbrJF9/VJrc8+LXhR62EET
D2U5xlJw
=O488
-----END PGP SIGNATURE-----

--7xCzr1wEEfD+vDc4--
