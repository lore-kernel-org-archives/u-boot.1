Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB489C54E66
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:39:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FC3287F36;
	Thu, 14 Mar 2024 01:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jR0Nugue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5853587F28; Thu, 14 Mar 2024 01:39:08 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD46787F25
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:39:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-788412a4b78so19790585a.1
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376740; x=1710981540; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0NOLkgvcvmKvxDglsxEX5z+DMSpNbszJEByFU/XohKg=;
 b=jR0Nugue+fhbrlAySptX2CfdQAmo9+srKaDN/UOjKjLnPSximVIx2p3x69wPNIzIDw
 ksCz6LYx25YedxqIizWzU+hODtftB8OKS3urB2Eb2Q9rpZ/a+P3BVUVsFc3XDd9HVrlE
 +p8KKnH4iglhYjlIiQKsNa48B46YhPC/DzthU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376740; x=1710981540;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0NOLkgvcvmKvxDglsxEX5z+DMSpNbszJEByFU/XohKg=;
 b=ngOK8xTTJfO02TqbNy+9xjFTtHNqeFrlWg4RLO7hjckb4YQ09Ye1+pCfffjr+ttSTC
 loDIdAspgigMgv+rTpATeCuRBN/VoqJaV/ds7wqSJqcBK3/PjruRyBj792u7MEjMM8pL
 Aq3NF7fX8DiPAkBCBoZZx+lpkpGMBJnUP9LL0AVSKybFLu3HBZ5WuP+a1q1ItltbQOHA
 KOC9A/yczx7vi9araIoY1TsoM5x0wiQiamQGAjB5SFykRIJ1AGicETi2/yZQr+8u1tYu
 e1yEGuVFytxpesF3iA0ME1EiZZVS7hJMEQWH1mpypT1tmKzPGbURbkq3KpYj7HPje4Vd
 HlNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx/Km069N63tLVJLuRRP25HHq2kFG0TjaanwVNTNSr/ulUDnFZx5l0ywd0rdTIBiVTD1XORTmMSY8ME69hULmwiFRwpQ==
X-Gm-Message-State: AOJu0YyPHvOK2rcxUoQptSjEtwXKu/5ELpGYzzF/9l+dU5HBDLzqZi4/
 TUWnUHZsiOXYs7ObgrTBr6VlhFM5kli1bIOQ+lSVbZqlgXYWyuP+AfDVUtqZym4=
X-Google-Smtp-Source: AGHT+IE3Lk67mLkOV7B8kE5qAwmjtYymtBCtJgf8J+pKpnMW0U3kg4+Ph/X9/bP54Ck5iau4qBR3jQ==
X-Received: by 2002:a05:620a:d48:b0:788:1556:58e6 with SMTP id
 o8-20020a05620a0d4800b00788155658e6mr380900qkl.41.1710376740428; 
 Wed, 13 Mar 2024 17:39:00 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 x27-20020a05620a14bb00b0078874fa5d01sm170350qkj.65.2024.03.13.17.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:38:59 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:38:57 -0400
From: Tom Rini <trini@konsulko.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Andre Przywara <andre.przywara@arm.com>, Bin Meng <bmeng@tinylab.org>,
 Linus Walleij <linus.walleij@linaro.org>, Fabio Estevam <festevam@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] arm64: Enable CONFIG_64BIT for static analysis
Message-ID: <20240314003857.GD3442575@bill-the-cat>
References: <1cb3255b-5ed7-443b-8a02-6e998126d417@moroto.mountain>
 <6a7328b8-eb22-4ad6-a1d6-eaecd2f8a067@moroto.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TdK2V4RQanrRvXjI"
Content-Disposition: inline
In-Reply-To: <6a7328b8-eb22-4ad6-a1d6-eaecd2f8a067@moroto.mountain>
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


--TdK2V4RQanrRvXjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 10:04:29AM +0300, Dan Carpenter wrote:

> In the Makefile there is a line that says this:
>=20
>     # the checker needs the correct machine size
>     CHECKFLAGS +=3D $(if $(CONFIG_64BIT),-m64,-m32)
>=20
> Set CONFIG_64BIT for ARM64 so that we pass -m64 to the static checkers
> instead of -m32.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied to u-boot/next, thanks!

--=20
Tom

--TdK2V4RQanrRvXjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyRyEACgkQFHw5/5Y0
tyz3vwv/Qh5QHlIxYUqn9EQkE4CQu72sOkr0WGhGgIa9HQW8WjnN6Gw1i7sdsSos
9uEevfJGX9ihXqLqQaFDwqlNhd4YkXk5baL7dLwdwYgCzYbdC5fb6VwImi8ZhLq8
M5Khsx+b8tBJcm4CXv2p9SqVHa//bVXht8/BSS4Zlg0mzbKVe9vI1yWa/Ykwz7PN
nkhKssepd+n6tOb1Sr7ag/6675WamOTip/L1kwN68MZp7BXdxDTfY5mMTPlpzCzL
zSyNfzQkHIal/JvmAocfmxMHyKaNIcf3TOlkVm09Plql7ar01Qq2iPqS4GUNYTgl
I/wnEgqZbTgXum3u9CypF7YJf9M4nvJlWAWxLRd7t2w3QZKrqvdv2lU80s6+RG01
4DayNt3vh2SJh2fqfv8EjGymxajJyIf4L2kvHVarktJpzXHX1DkdGOt+PJPOAVj8
7ohkS6xnyNNyjDhVUa/gxN8RdU2Kn1WhDz/xB641u6ZEFklgypDY8DZwtIvEG6an
RCD8u44L
=jM1W
-----END PGP SIGNATURE-----

--TdK2V4RQanrRvXjI--
