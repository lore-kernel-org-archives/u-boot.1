Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72D1C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 21:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22ABC87850;
	Wed, 20 Dec 2023 22:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kw6Gkhcl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B77F98784A; Wed, 20 Dec 2023 22:01:33 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DBF08783A
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 22:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5e734251f48so894707b3.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703106090; x=1703710890; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nEqSzoCpz0qmsgbSJUjE4CkwbMajanUtXY6CNFtmbeQ=;
 b=kw6GkhcluZSnJzRiTs44fgn8pAjzZEsFx1sPXmpQwRgR06TPPjNO+OTHhJXG1rDnbY
 JUR6oi0sMCzMqo9gM/2zGzKXGfOYKWrXyIPFReUWl2izKk4dh0MExHzZCMGRJCk7d8dl
 HeYAYImj7z22iEtg10DwADIMKL8X4EbLzRCmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703106090; x=1703710890;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nEqSzoCpz0qmsgbSJUjE4CkwbMajanUtXY6CNFtmbeQ=;
 b=qiUMWCdpmONhZFoeC8A2GZDBaj224xQj1r1sjreeX6SXfBBuZsjJjxOzzEiZHtryBZ
 c9Ap/ALLl7QwMT4stTyNIIpnn9uhDmJB1W9a2NEfGAFnyYRaEp8brTqsYBQZM5RqUots
 l0jMd9OqA+YicxBF+TMuZZRSxeaGJzqY/9e/uDEjVdAqS1JjbQnO4h6z7HomPhyA+RUy
 8fnYsK2WNG0XEfULotNPrrgnohd3SpHRYtNhf5lOVH7fTnFpObP06wHRV32wNT8occ7O
 T1AdNrQ1h7F0rL6nLnbyvs6LWg5Az/31FEBXxaMlNehEBYcz981Kgs/2Ggg+hksDXs6+
 Zuhg==
X-Gm-Message-State: AOJu0YwYxHmhKcCHAFS3DXrdPgub4J901xUFmyVXAbYpFuvkEKtTkKsu
 iGeTJo5Sq+c24RYiY25Mdp6XSg==
X-Google-Smtp-Source: AGHT+IFG6M/Sj6FuGM4f8na5zEFW1sTpPHyjPXf48/SP7Qwp44EIzMQd2STzxUJV+GLOOXb85iS75w==
X-Received: by 2002:a81:a241:0:b0:5e4:d68a:310 with SMTP id
 z1-20020a81a241000000b005e4d68a0310mr240720ywg.36.1703106090107; 
 Wed, 20 Dec 2023 13:01:30 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a0dc602000000b005e85a52ac20sm235326ywd.55.2023.12.20.13.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 13:01:28 -0800 (PST)
Date: Wed, 20 Dec 2023 16:01:26 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, marex@denx.de, u-boot@lists.denx.de
Subject: Re: Pull request: Please pull u-boot-imx-master-20231220
Message-ID: <20231220210126.GR2513409@bill-the-cat>
References: <20231220184213.1448425-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1SCsqEh8xPmsTE0y"
Content-Disposition: inline
In-Reply-To: <20231220184213.1448425-1-festevam@gmail.com>
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


--1SCsqEh8xPmsTE0y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 03:42:13PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull these fixes from u-boot-imx, thanks.
>=20
> The following changes since commit 3ac22891cfc0dc6d8eec25d2b0fbdd2eb8f3d3=
ed:
>=20
>   Merge tag 'u-boot-imx-20231214' of https://gitlab.denx.de/u-boot/custod=
ians/u-boot-imx (2023-12-15 08:22:31 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20231220
>=20
> for you to fetch changes up to 1f25c75619d7fdacbaa8c2c9c152ebc9aec807b3:
>=20
>   ARM: dts: imx: Power off display output on Data Modul i.MX8M Mini/Plus =
eDM SBC (2023-12-18 20:25:57 -0300)
>=20
> u-boot-imx-master-20231220

Applied to u-boot/master, thanks!

--=20
Tom

--1SCsqEh8xPmsTE0y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDViMACgkQFHw5/5Y0
tywsjAv/VXe6lQJmD9BKneuCiRO1TXc949W3LwnTz7Ib0azcHAzrFFKkmH6pAMtj
82e8akEdlssbAVk4xpBGsxIsh4IeznLRbAoWNs1F1cGv3lRJwh1b0qCeFKgrdNsa
0lrz/hb6ytPN/vk56uuOAtZGBBQZFRBLgLFfWDgvt+tUZotbbKQtv6/0hwWqDxXI
8pRlm2qn3HrM57PvVzqj5oHd/3lo0dKSlVkfpjDY9lC3I2gawZPL0BO0vgqF3hkf
HUhOlZTNKo0hAZLo6QojqJIC6b9dGkPB6lExJApwEJK8Q2qEUJQvl6VqkVdfXBdd
PjAbRILJZrZAx7Ulb5a5HM5jPx+5CSa2YYCrc9Otv5V7SrWDQqTz2Xij85/aGULu
Ftmuw6HtlTvkVyWboS/Jn7QM79edXhrzfsxSm+gwpvLURYxx/CE3KuT7XnIEBHKH
slSlb7Q8R9UaaMj1h8STzFg6BByiEnKqAaoSxgr9oO8kOLiE5ahT+++TKZC4Uq7h
PTebUV0J
=fmH+
-----END PGP SIGNATURE-----

--1SCsqEh8xPmsTE0y--
