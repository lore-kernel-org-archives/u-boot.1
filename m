Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D3EC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 21:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E19C876D7;
	Thu, 21 Dec 2023 22:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BIdqbOJJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32BA786BFA; Thu, 21 Dec 2023 22:07:04 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCA65876C9
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 22:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-67f6739d7acso9083816d6.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 13:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703192819; x=1703797619; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EWG1fCGdvYSgPP0WZrI0FbDLuibn58GTSvH6yPYFjL0=;
 b=BIdqbOJJ0sWoYonVIV6cnuBIqg4zSpF01ZlK4R0KWG80ywwOLZ/8p29ykoezD66ISp
 y8MFe0O+kgwrIzDThMspvZt/R6QbI/QidiuFLOR7Nsy8IrWOnEeGpoTgZ+Jdney5mr4H
 5AfBsG8Vy6YY3YI7QkwLbz7VVxSvqXx3vIMFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703192819; x=1703797619;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWG1fCGdvYSgPP0WZrI0FbDLuibn58GTSvH6yPYFjL0=;
 b=LcHCAP9aEUUttpDkbbD6cuC6zbGKkXvHiS664Kk25v2kmEeeyHRUMYnyVLKs/PveQO
 5lE14sS8GlOONeTHFo0ncWB8C9mR34kM9RPgfIhU+HKk/skgIqI1zBRUQEOMxjAbL8gt
 5xCDjbESJWFpoC01UkFVERjZMg0+vwQhIjs2283+RFH4jlARLtv4iaYtu29yEhHARQSA
 MNlVmelelkDXKstLqnnfRvmWkRERCk7FdDg1mmy2ssuFBqyAAHRoBF7EuVs6i6EsZ4PP
 ZLnUSxRsHOfGppAQmWcrrpRpApwJYFdrjJAAcwG9OkUZMBUgyUJLxqYgojtBtZWv2jgA
 quXw==
X-Gm-Message-State: AOJu0YyyHBmWcEmpTqjvDsFATVkq6iXb7tFdsNI6Fr0lpeBnr2h/f4PK
 YSYisAbAiCufWAWMpo4YYOJV5O8R6JFiN806Tbzka1YT+R4=
X-Google-Smtp-Source: AGHT+IHuzRV0T6s232AGGQcLEZVmwGg2AjI3ut64j7s45a7073GQwbsPxMJJSUoc3vk/uGT0XO5lKg==
X-Received: by 2002:a05:6214:2aa9:b0:67f:65f2:b2bf with SMTP id
 js9-20020a0562142aa900b0067f65f2b2bfmr551352qvb.46.1703192819641; 
 Thu, 21 Dec 2023 13:06:59 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 cs18-20020ad44c52000000b0067f593c4bdcsm858675qvb.104.2023.12.21.13.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 13:06:59 -0800 (PST)
Date: Thu, 21 Dec 2023 16:06:57 -0500
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: m-chawdhry@ti.com, bmeng.cn@gmail.com, sjg@chromium.org, afd@ti.com,
 mkorpershoek@baylibre.com, n-francis@ti.com, nm@ti.com,
 u-boot@lists.denx.de, vigneshr@ti.com, srk@ti.com
Subject: Re: [PATCH] include: env: ti: ti_common: Run
 main_cpsw0_qsgmii_phyinit conditionally
Message-ID: <20231221210657.GO2513409@bill-the-cat>
References: <20231211104209.1078892-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AkrXPGvleA3UTW4L"
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


--AkrXPGvleA3UTW4L
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
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Applied to u-boot/next, thanks!

--=20
Tom

--AkrXPGvleA3UTW4L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWEqPEACgkQFHw5/5Y0
tyztngv/fqQwJoQIWIUHJySZiV7ZtItgyH1/44W8ksFJwp+fDgRdRxzdDbAzOELt
m+g6WE9zi4+AnucIGMmo3Ey19rgYZecI5ZZ0CVJp6K+eQ2+6cuFsVZ/uab3v13bY
46p5YVL+MyhKaaz5MbeekzMGDn5egVBORzb9b2ub5Wl5JbQTc7t3zoz9lzfH/Svx
iwoVt0fIv54q+kBvPgMdukckkeQCJpvKcAnJ6SiOTE/z0F4+QLEax4y/U/XlBKHt
0dPMfm/cv9DkBa5FfX6P4O2qR9GyHjKZQFYBCvxHNaJhVP4Rfo5TR+2wiQ8ZG89f
nouxp4CfJ07CoaZThU4pkbU2R97gVSi9oHpSR9Gsa9yiu5SSFXcCSd3kc/HchAbU
dMuTjzW+3VV1qQ/7TWbmPfJLpmdjpqoXNqzW0phd2rt1Q0pLGYv/3LvvuzO9qzwz
YtNYDNQikQEMNNoeQEYPqyU+0nlVUW99R8jAMfCbdBR9dvBwwZ/1O46mqcRh7pcg
ev/duMBk
=oyJm
-----END PGP SIGNATURE-----

--AkrXPGvleA3UTW4L--
