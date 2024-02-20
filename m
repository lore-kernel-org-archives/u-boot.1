Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09D7C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 18:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C844787FFD;
	Tue, 20 Feb 2024 19:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fbPwkc7L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CD6C87FBB; Tue, 20 Feb 2024 19:15:49 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9017E87F76
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 19:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-607c5679842so56954357b3.2
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 10:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708452943; x=1709057743; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LEWvQK+mg7XceiRgLEPoX6eks6GoBC8AhybVw7b4gdc=;
 b=fbPwkc7LTgB49v1+yN4KU0oirBGYIFkJYvkel8vYQXwYWYr0p5ArSBN5IoNpqIRbek
 bcwOi5DfwmL2gHlxQeuC2f1P4JknjxR/d2wrIHdd4+Qsm93X1IqFSzDQukNUiFoUpT32
 AC+JZkTkeSYPG8+Kztmo2yQZBQKQRUKb4qoE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708452943; x=1709057743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEWvQK+mg7XceiRgLEPoX6eks6GoBC8AhybVw7b4gdc=;
 b=dcUMXQTlRNG4uupy4CpVdxDyW0nOAtNNYO8SXJ+z5geL54O3WWFDK2w8tVs6wrgSVc
 UqnF+WVd/3weF3HTWBb7BEDiyzo73mD1FbPn0akc4zAY74ZOwrFLK2HOV+8gG36Cy/Vo
 CDJZnT5W1QBhzpBvuwCTgiMMbuZj7jP2cVfX1/e/Y4IH/Ggc5pvxUoP0v5RzSOibf1h3
 mkmJAyS8z5SYFJflAuHhqvKzxBES9FMWays+2qmbSuIPcnfbra8ZkVRnMcDGN9Cmp8ND
 RybiUSWGLKh6aWSrDCSLp/Uftn8vzjOvRMdRs1cWqwsTIaEwKRcAg9hQZMERpRUTHIbO
 MXJw==
X-Gm-Message-State: AOJu0Yx2oULDhNnsdoz4elkVQRlnB3je2HCT8DdL51HQQ+vNei81paRM
 xRg8yImn9OCIo4+UD8mE8mhInpcd1WL5WUxnAG7b9f07PnXG0gZeC76JJYYU0Go=
X-Google-Smtp-Source: AGHT+IGQBEvPEY0IylaTuQxw5X1eeoTaz7QTTf+oUa1hvO3O8ggIC0Y8K/KxrLpk3l12G/7OEw5NVQ==
X-Received: by 2002:a81:7606:0:b0:5ff:92f1:8e24 with SMTP id
 r6-20020a817606000000b005ff92f18e24mr13606805ywc.48.1708452941753; 
 Tue, 20 Feb 2024 10:15:41 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 d65-20020a0df444000000b006084e70a443sm711275ywf.44.2024.02.20.10.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 10:15:41 -0800 (PST)
Date: Tue, 20 Feb 2024 13:15:39 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Mathieu Othacehe <othacehe@gnu.org>,
 Shantur Rathore <i@shantur.com>
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20240220181539.GQ3040305@bill-the-cat>
References: <20240220083555.34347-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HgkApwaUVyBYENwe"
Content-Disposition: inline
In-Reply-To: <20240220083555.34347-1-marex@denx.de>
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


--HgkApwaUVyBYENwe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 09:35:43AM +0100, Marek Vasut wrote:

> The following changes since commit 3e6f2a94bfc25f1782ce2d45db27f47ec781fe=
b1:
>=20
>   Merge tag 'u-boot-imx-master-20240219' of https://gitlab.denx.de/u-boot=
/custodians/u-boot-imx (2024-02-19 08:55:17 -0500)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to d9a20fea2ba53db3a999827d3e50e181d5513e09:
>=20
>   usb: ehci-mx6: Add i.MX93 support (2024-02-19 20:08:51 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--HgkApwaUVyBYENwe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXU7EsACgkQFHw5/5Y0
tyxhrgv/QUpWvLNVO87iwWEEwjjghLbJdZ/I9eMW8Cla00AmSKiPn3kFhB+hoKuK
Gna+EsNP8oILXdVvgvFgDfePDDoYzjuUTvFDzA3vIANBkhIYs9fgi7cotDx2ODAP
PPnKJfwn4Fnqg45QqzYmu1DXIbXHAb49YkHYIge2Zz9QSsmG7CG9tRHHzCZ4+DXR
D0Lk2OlaS18vpSSlBTCKey/IhE1SNRCLPUc3ZC/sRTg4gmJIlGOIoAp5wmvmJflV
Vlt+TOAzThkPMtZUn7jcbO55XWvouVEzAAyfvUdaKWfkWcpWHeKYM7Kf13jk0uQk
XR7sHDq3FVanrPmPaNeI/YqYyIEV40R4eSNoq8hCNXPdSzTcLnTwTK5h7yKW3WxD
6KDQ0IsDBjhlCoCgAfLimywNNYkrCXAV5+UdPrARd1Ul5NaBeOTUqwvtRN3CuKnZ
ndUkszaPlX6TEwVuU1wAJ4GgyJtzpkYyaIwXBXU7Kkrph2a9agtthk6tCYJnT5xD
mMpnRk8f
=AIQr
-----END PGP SIGNATURE-----

--HgkApwaUVyBYENwe--
