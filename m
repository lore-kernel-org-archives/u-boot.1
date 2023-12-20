Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88901C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 21:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E28B8784D;
	Wed, 20 Dec 2023 22:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OBupWwci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6957887846; Wed, 20 Dec 2023 22:02:09 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3029F8784D
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 22:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5e745891a69so1454747b3.2
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703106126; x=1703710926; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KgxrZpA5h+dFLt5P6lRKrYhlLif4DNs4JTKfzM+c2Uk=;
 b=OBupWwci1ZqjsQaTiVd+USL6WRj8LgVLzXs2uMrLC1AkZ7FoOOvrSI6y/y7CmDnnD0
 m/eG0i36aJi1GzJYG3reYGep9VkamHSf2Y0OWdZiQEnwK4C5KTmczI0gODQQFb8dPYcW
 imIF2iWgYUow0pVyQXntJWZFBwZHVy+R9GQxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703106126; x=1703710926;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KgxrZpA5h+dFLt5P6lRKrYhlLif4DNs4JTKfzM+c2Uk=;
 b=p5fpUTV8RCnObu7yZjW1v+Um4JsUEEX47EU6RhMJ/bdhbrYMCmpsY1WKjqxsGDsQLO
 AYpKDt/Pza62CrfthYZf4tqMLf9P1W6rHNHh16RDo06NMzJPXtZkCM8Fko7wNaVacx9q
 JqMe0F4cMCGVFt4Ur3U7+87HLjj0rTVdWlua+SmRDuHJARGNrVNWjTJ8n1mEl/SAVazZ
 ZBeRMsAcKMI7CMGqxYCLL7SwgQpZ6YU3QjyVbSaaCj3v41dh6Il7Q7uh1Y4ergShWn6/
 J+sVRlAsWhkkLVVgyVU/FnpTJsh55akd0EnAl/VUNV909TfJey7162yy69PmMv8XV+gL
 KJ6w==
X-Gm-Message-State: AOJu0YxOoUoQacGJWW87haLpRuaeJchXHnCMk6NmxzAdOrYymyfoRA/i
 6CZ6XHhZ0e1SqZtGBP8gh9WeZA==
X-Google-Smtp-Source: AGHT+IEs100ElYep2jVQTnSxMnwDO93Mt3CofQbwOCGyTA2NyLDRGYoShBstkSmohh8UPvxeABZ7zQ==
X-Received: by 2002:a81:4f08:0:b0:5e7:dcb7:37e5 with SMTP id
 d8-20020a814f08000000b005e7dcb737e5mr327010ywb.49.1703106125938; 
 Wed, 20 Dec 2023 13:02:05 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 k190-20020a0dc8c7000000b005e703079702sm231530ywd.87.2023.12.20.13.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 13:02:05 -0800 (PST)
Date: Wed, 20 Dec 2023 16:02:03 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] command: Allocate history buffer using calloc()
Message-ID: <20231220210203.GZ2513409@bill-the-cat>
References: <20231202205255.169670-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tgKuf6iQKvG7pt2k"
Content-Disposition: inline
In-Reply-To: <20231202205255.169670-1-marek.vasut+renesas@mailbox.org>
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


--tgKuf6iQKvG7pt2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 09:52:30PM +0100, Marek Vasut wrote:

> The history buffer is currently a static array which can be some
> 10-40 kiB depending on configuration, and so adds considerably to
> the U-Boot binary size. Allocate it dynamically instead to reduce
> the U-Boot binary size.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--tgKuf6iQKvG7pt2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDVksACgkQFHw5/5Y0
tyx5tQwAtyHOn+vRiJThIXagP6okvlbxi7lCSpAe8jawMjjiuOksHli4hDCROZ4O
lJ90aFcZ/SHPGx46z4QFcb61bpBaETbFtwV27BEkdwDb7ZwMqgGsf9V3zrZerQH4
ERUqHhJdcCepWiRaAsNs+KMeK/P+as3GiSGL87yt7bHAgLYi9S398yzZur8peaTr
Z878+obbqwfus8ht2y/JwWfw+RBmBWkaETdmEBry68dj0IumsptDzwF0Od+WRESK
y5CuZBtW8rt8zQ5eGgRTzqGkl0sMTHKVBTfssaSJwkCGO6G9LcFIzs8AaD3mbKYB
KjC0NPwq1V1mHknABYc/fpaUv/YSAYtt9mJsfpalpEXppGCmupPz+HYXsK+hAZ8B
zHaWxpsDUWnc1Zb9VRgzEPtCOsQgOchIG949M3t/dv4QJWzcoLswMj5NOAKz675q
RYthU144BzrzyaYGbutU6QqwAwvZ2iimA54J1McQBQ6QP9tba68nKzObtqaSW6tV
28mToTdc
=57ku
-----END PGP SIGNATURE-----

--tgKuf6iQKvG7pt2k--
