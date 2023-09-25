Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EC2CD54BF
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 19:19:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DEA286B4E;
	Mon, 25 Sep 2023 21:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LR0+QEVv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB47086B2E; Mon, 25 Sep 2023 21:19:55 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C9A086C10
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 21:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d81b42a3108so8198896276.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695669591; x=1696274391; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1t23GtF/wbb06GukAzVhYjtdsDs5mtU0kjpweUMnaAA=;
 b=LR0+QEVvDi5MMPRz5/uukLqbt9k9pLiEULgiCjQ+leUR07TmBJFaisC1P55iRlZiYI
 HuZ3W9M8M6IdDVibfmvq5b9SKledFl4VMH6dADViNmBdFDBGTJdOE3/CmmSNUAKB3Eku
 xOXVyc+hAp8RPOq/O617maVj1g0/aUfK4f844=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695669591; x=1696274391;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1t23GtF/wbb06GukAzVhYjtdsDs5mtU0kjpweUMnaAA=;
 b=pjwYMkHWnG8Q0CTbW+VIHcVaXCDZmLBbA2ikfz++IQXjtmJOxCDyap0A2IFryHsJ0V
 X9AEpcvWRBFLoGv1nnQb+fKA81yjSqx7eIY/vvw5g+8mh2tmJMoTT/trPouNrXErN/GU
 JfXcCPMkE0MnMYVBlwvwjf2rfmGp1LIccSU8wKrh03u96sLBzmhBDMZZZJoV3ivOpPdr
 bkPJRp6sJUi2DC5trEwmQrKv2r2t5si5ONSg77vOR5IbFIc3uHXmS6Rfa8XWxQePI+rI
 QYso2hoOGD3RoLobBnfszw/dahliuDgG4jLzwMeSokhgHUZdUdyQu1oRJZsnTV+nhxqu
 +Z6A==
X-Gm-Message-State: AOJu0Ywb9dvGz0yeGvTjpySQyEYq/yQR4Fp0Xbyk8zlGoF/AIvknndmV
 rrOIjClO8DI9XAuqOOCTWBV+bA==
X-Google-Smtp-Source: AGHT+IFqEkD/kzHTm1e/AJeNI49hruOG5TpNhbUOXMGCZcnYocqzpZCeHaI9DQSpVT5kZXhb/va3kw==
X-Received: by 2002:a25:828f:0:b0:d3f:208:b8ea with SMTP id
 r15-20020a25828f000000b00d3f0208b8eamr6568777ybk.11.1695669591031; 
 Mon, 25 Sep 2023 12:19:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a255f07000000b00d86694cec9bsm1200362ybb.15.2023.09.25.12.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 12:19:50 -0700 (PDT)
Date: Mon, 25 Sep 2023 15:19:48 -0400
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, eduard@lionizers.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] smegw01: Fix inverted CONFIG_SYS_BOOT_LOCKED logic
Message-ID: <20230925191948.GJ305624@bill-the-cat>
References: <20230925163259.9442-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Yk0kX1TyuElpsgot"
Content-Disposition: inline
In-Reply-To: <20230925163259.9442-1-festevam@gmail.com>
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


--Yk0kX1TyuElpsgot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 01:32:59PM -0300, Fabio Estevam wrote:

> From: Eduard Strehlau <eduard@lionizers.com>
>=20
> CONFIG_SYS_BOOT_LOCKED means that a restricted boot environment will
> be used. In this case, hab_auth_img_or_fail should be called to prevent
> U-Boot to continue running when the fitImage authentication fails.
>=20
> Fix the logic accordingly.
>=20
> Additionally, select CONFIG_SYS_BOOT_LOCKED by default.
>=20
> Signed-off-by: Eduard Strehlau <eduard@lionizers.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Hi Tom,
>=20
> We have just identified this bug.
>=20
> Could you please pick this one directly for U-Boot 2023.10?

OK.

--=20
Tom

--Yk0kX1TyuElpsgot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUR3U4ACgkQFHw5/5Y0
tyzioQv+JJNd1ER9g/qi8yOWz38p4bwzKo6hso/Y7wciC96u0SUaCUMFXIBlvvt/
2Gb1EXUhu+NXtdgSrdRB4+8vj2Mev9Q7BDrpPfqlfUuaX+GnEqLHk6zOIP8JWSLu
fFmQHFcbwyS1Bpr0mtxoHuYC0dJrQU4UY8i50cEh5lVYLSZOD9u7KzMbU0Y0CGuR
3uW8hfSLIbvJ/lZgfToezE1ONgE57N0YcBxyW24l+4qCpWvIzR/bDjxy1nAE4mYl
JnI0erLYTe525yLbFQSOTVl2MPvR+Dl17Dv12+r/obr21RqUMSHx/0hk0WjgQmUh
NhSkCjfq2r5oSHEixoznUdjGxPCheMgpoRkSCFP8X7gyc+a7ZWGrG3z7cfAxdALE
MqIj8H8vtO2paaax22YFyIXDpRq3eAimmahhddckMQA5/s04fbW59Y4yaa3PF+9Y
fJqlya8+wUo255bP6zm2A6pteKkurw9n9rRrvnHLXCn4t/Cceqbq+so1J2PysXyg
NFPAlNen
=j1Vr
-----END PGP SIGNATURE-----

--Yk0kX1TyuElpsgot--
