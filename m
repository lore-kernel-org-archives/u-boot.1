Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27147C4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 19:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E4F87775;
	Mon, 11 Dec 2023 20:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mTEBBTr0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C3C187784; Mon, 11 Dec 2023 20:15:51 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02C1B87772
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 20:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5e1a3199f6bso3024977b3.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 11:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702322146; x=1702926946; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pimV5mmvwItKBqZ/UycpsBhiVl7QpxWDnCIFxK/CNY4=;
 b=mTEBBTr0tb7xhdSS3Jgp0hWNGX7y8NLi3Rxr6anATOB/uD3IP99pehrFgadg9zYlOx
 h+wzR4dodboOGrcdNzgAhC7EtrTdmRi//p+LZDGbnp6f2Hu6+oC7hku1JPdNRLjop76N
 PExMByZgTttpXv6JixgNx/oWT5iqJFhuJGAcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702322146; x=1702926946;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pimV5mmvwItKBqZ/UycpsBhiVl7QpxWDnCIFxK/CNY4=;
 b=Uq2d8neKWcmMTlvppd7sh2w56eB8A0igQ5VzhlrC5zOhvWCuto9NtRlC4IR3+OFFpb
 z+y28lElwjt33htIpJm6ZXFpwnX6dJ6qdqG5QnjjFuIXFldpX2WYHo1ID/hd3qg5tfL2
 Aa1BryebcX1BIBixF+2ypuY3K/d14zf+HLjHZgsAvqiz+Kzieow+a+wuqbvlp3O1qWeQ
 wE/4lNiTicIDNxiVcjMGAMR93FV8EE7Xn7jZfdhlT+rGn5DKNuSiPUdFqw0NC11zbq+q
 Zk2bcClaIn7aAIHJN4aVcyeaLFqH+Uugt9XE8gZgZip+S2Qny4M+nBgxzSYawS39Qwkh
 OUWg==
X-Gm-Message-State: AOJu0YxctblRFeULfPdcmpX9wTxDcRcfIzc9yheQdwAiWLi1d8J9SgPK
 TGuAnJFVuM4ajQsbbFFIhWwQDw==
X-Google-Smtp-Source: AGHT+IGC49aQXGm/10LLg9TCXp7AYBJyLZvtE9lymcjD9ILQIiMYV++jbaP3XxOLFw6oMemdEzzyHw==
X-Received: by 2002:a25:ad61:0:b0:dbc:af6a:f31f with SMTP id
 l33-20020a25ad61000000b00dbcaf6af31fmr720027ybe.115.1702322145827; 
 Mon, 11 Dec 2023 11:15:45 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fa42-ae3b-3aac-d543.res6.spectrum.com.
 [2603:6081:7b00:6400:fa42:ae3b:3aac:d543])
 by smtp.gmail.com with ESMTPSA id
 j82-20020a252355000000b00db9811e1f92sm2748149ybj.7.2023.12.11.11.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 11:15:45 -0800 (PST)
Date: Mon, 11 Dec 2023 14:15:43 -0500
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: m-chawdhry@ti.com, bmeng.cn@gmail.com, sjg@chromium.org, afd@ti.com,
 mkorpershoek@baylibre.com, n-francis@ti.com, nm@ti.com,
 u-boot@lists.denx.de, vigneshr@ti.com, srk@ti.com
Subject: Re: [PATCH] include: env: ti: ti_common: Run
 main_cpsw0_qsgmii_phyinit conditionally
Message-ID: <20231211191543.GU2513409@bill-the-cat>
References: <20231211104209.1078892-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cQGmqvIwa/qGTAxM"
Content-Disposition: inline
In-Reply-To: <20231211104209.1078892-1-s-vadapalli@ti.com>
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


--cQGmqvIwa/qGTAxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 04:12:09PM +0530, Siddharth Vadapalli wrote:

> From: Manorit Chawdhry <m-chawdhry@ti.com>
>=20
> The main_cpsw0_qsgmii_phyinit command is defined only for certain TI
> SoCs which have the do_main_cpsw0_qsgmii_phyinit variable set.
>=20
> Add a check to ensure that the main_cpsw0_qsgmii_phyinit command is run
> only for such SoCs.
>=20
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--cQGmqvIwa/qGTAxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV3X9wACgkQFHw5/5Y0
tyxMWAwAoBtiJjL9lWP3v7vOxB77Yblpz86OOoPEpYotS0erSoOxKhTkptGJsTY2
VJq8mT0582kMxMK9bB51z8PPqmSSuSoueOw8G1I8Oo68VvuhJ7epnkMs7jdJBRvi
c4KBIcUzLK8ZUrQ9w+921AnHGrluyseFlPs9BD26vZKX3V5l0EsgrUDZPxqqLuAc
fDRZaPFTqcLdH6gqEPF2UA+iaasSIoBZIQfwOg99ZCwj4n00ORIOIs+TgJe1ecE/
GDim+Nt2o8vbuBn5Og3V8MSjYNyzvLxBQv1kehLVj8Gs59b6bKjjDY11kT+uMN/K
EN8ToxQT2i6y8LAUn70S9u321pq/qC06o82vF4Urz1RyQII7f2kv59/NQ1j50Usn
RobndOpOQLOKPX5oyIqU7PMQu2dx7o20h+F7rLUD2gxBfiKjA5nZOWGBa5guslQf
YVvvRpV8N+SGBmrcTtYCqOpio5qLPSawAZiyvW5b2rTwBpTCl8H7pC0gKI2uS3gT
QdVfvmkQ
=9nh1
-----END PGP SIGNATURE-----

--cQGmqvIwa/qGTAxM--
