Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB4DE7718C
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 14:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05B218007D;
	Fri, 20 Dec 2024 15:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zr2enmr9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13EA280087; Fri, 20 Dec 2024 15:25:37 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFD0E80077
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 15:25:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6d89a727a19so26973576d6.0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 06:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734704734; x=1735309534; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y9l610mLAvKJVpgQYmjBEinZ2Km8fTmZZnhR1+I2meg=;
 b=Zr2enmr9Sx4q7HPz85VeQn/rghcfNG3huxveBTThAvYUTrzAvWqNxbcnfrFznqrIyS
 CmyVibKghX+LsHCSdktieiH+v5Ad30k4tHDg6g+WUY6W1tkKHw7ApSRkoWEASHQVI3d9
 ea0ox25xhAJw8DC5nXmIvkiw815TNYAEOqHSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734704734; x=1735309534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y9l610mLAvKJVpgQYmjBEinZ2Km8fTmZZnhR1+I2meg=;
 b=qXSqueFGEqMSJGNrfJ5onKH5Ubn1tlinKZvBw/C/+3VucZYxDOcCQkXWETPjo2f8tO
 C7AKLAH0Or2VbTO4PkeqFAnejEj0j+hrAgU9ssg8NhM2KWqeVAhYlMVNw3LI+0gFo/+s
 H9VxMPryYvtwOzMxZKhrSCMovrjsCoIEdDKNK8LzPuuSVnUUieLU31udgcWs/ruvV/H7
 OCrK1GnwCAkhyBvU+AL6A+G4S6sqJCewplkdvuO+0/+/XWTu5uAFFBwLzUWY1FjavChQ
 vRErNAme7WYAMmCJ0oeCNxWaEHo7ADpPRh6viDz5bylAX05gSGzi0trwc6sWl8q/PiWe
 92Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHWaz4Y6hgN79riHBdKZTYPagNU4IyoVDOsW9zgYhagDpYjSzTaVcPwqaVgRUKikq0mjkvkNA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3iQpbkM3uBas/EjTN6om7ZWbNvgZTvToIfYBRFWcXXush34m1
 aN9Fkn/oH0iIE6x5AibGXo6/03YddaIwSS/bKQTixOcnyI+i85igzdqaFXlwSHw=
X-Gm-Gg: ASbGncs46CeXIaeX4LQEXiAmJXAK3lA6e7gS+a0ZpcbwRGcVwSNIQzG2Se7e9m3b/px
 uXoLhV6bu94sHBFnt8fLUGEypPh6H0OIH5y+1hYSB8T2O5f0CIZSaHA0N4bTd/k5hF76Ry/UrVK
 k3QgPi27QMTXgAJ06F2Pem4G4XPTg6EVngWbInKTkT6ZBhrJoNPfaC7BSYXCbdUpH6iK6zTqCo2
 40fpkTJL1g8OD4tAArd0DKYe4p0e2aDHj24drxCDMkZa7qjjpJ0ukAu
X-Google-Smtp-Source: AGHT+IFzi4uoSkdSFu9nTvzY+pYXp52mkazmeHgpwykhOKd2ZjVJ+/hrC5Rm+TpeOyGdDKlxMqULzA==
X-Received: by 2002:a05:6214:29ef:b0:6d4:1c27:e9b1 with SMTP id
 6a1803df08f44-6dd23631f97mr42621856d6.23.1734704733724; 
 Fri, 20 Dec 2024 06:25:33 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd182082f0sm17263086d6.129.2024.12.20.06.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:25:32 -0800 (PST)
Date: Fri, 20 Dec 2024 08:25:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, vigneshr@ti.com, bb@ti.com,
 lukma@denx.de, n-francis@ti.com, mkorpershoek@baylibre.com,
 afd@ti.com, glaroque@baylibre.com, sjoerd@collabora.com,
 martyn.welch@collabora.com, rasmus.villemoes@prevas.dk,
 caleb.connolly@linaro.org, j-humphreys@ti.com, nm@ti.com,
 u-boot@lists.denx.de, srk@ti.com
Subject: Re: [PATCH v2 4/5] arm: dts: k3-am62p5-sk-u-boot: enable USB0 for
 USB DFU boot
Message-ID: <20241220142528.GA1505244@bill-the-cat>
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-5-s-vadapalli@ti.com>
 <e4b23017-375e-4430-aef2-001c1b6402ca@kernel.org>
 <noztdv7z4cwzjwc5sgqvzli36ppm2tlgrpqjgxbkbtojs34jnp@3lhnfx6ol4in>
 <a0dd6878-5f26-47a0-8025-ba9d9d320a31@kernel.org>
 <20241219170044.GX1505244@bill-the-cat>
 <lq5jqpiifhnmdvfqy2wguqklikcpo3hl37p3ojbm6pfsl6supl@opm7xkmql4y7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a9Zu68kd+RCbgQ0y"
Content-Disposition: inline
In-Reply-To: <lq5jqpiifhnmdvfqy2wguqklikcpo3hl37p3ojbm6pfsl6supl@opm7xkmql4y7>
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


--a9Zu68kd+RCbgQ0y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 10:19:31AM +0530, Siddharth Vadapalli wrote:
> On Thu, Dec 19, 2024 at 11:00:44AM -0600, Tom Rini wrote:
>=20
> Hello Tom,
>=20
> > On Thu, Dec 19, 2024 at 11:41:10AM +0200, Roger Quadros wrote:
> > >=20
> > >=20
> > > On 19/12/2024 07:50, Siddharth Vadapalli wrote:
>=20
> [...]
>=20
> > > >=20
> > > > Please let me know if this patch can be merged on the condition tha=
t I
> > > > post the patch for making the same set of changes in the Linux
> > > > device-tree as well.
> > >=20
> > > Tom, what do you suggest?
> >=20
> > I feel like Nishanth will say it if I don't, so, it's blocked until it
> > comes in via OF_UPSTREAM being re-synced. That's the rule to avoid the
> > problems we've had in the past.
>=20
> Thank you for the clarification. If you merge this series partially
> (i.e. this patch is dropped), please drop the next patch for
> documentation as well since the feature will not be functional without
> this patch and hence shouldn't be documented as being functional.

Please post a v3 of this patch with that can be taken now, off-hand I
don't know how well the kernel cycle will sync up with taking the dts
change such that we'll also get it.

--=20
Tom

--a9Zu68kd+RCbgQ0y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdlflUACgkQFHw5/5Y0
tyxSSwv+MVg1rV9GcRWmUmSfiGE5uuAjo5c7hj6un3A9M3v2nhCigZn66dnLpRV/
CtHKLeVb70yWletQChY//USYHNTbfh9G6yX89UghIXRWD68ZDUfentmSPO54Y4BK
pDRVXNz1PSnGYgsyVAgWZxsvgL/ALzv7HsHhQfVtnt/ZC472W7qIxPEwkrCrWB5P
8RnfQ6d8JYNWoCZUZmXpDFmC/AnY6WHlpKu91TATCVs/GAouMS9utZvJra3dwkP+
9JZyoOWenuYeOXjIgDoZ7e797/J0vz2f8v+yfDo2hXMtVJww5fbMSlmaw+tUAJYP
hWD2dfElXNEsU3HcHs1vGToCyj1r7k8LQivgEM5Ui7y4cHvV9hecRrXq2gwQ4oRL
88QidS1OrEIulkOwNYn/Eng0uL746MxF97+fxhP+9TZMMhUEEYvjEifdOUA21QYu
z/ygLLdtDUUrK6HV0OzMucX2MGg8ZmxXi7Cgqvsi7nHiPDMqZtiG9b8UJkmI7W/a
7iUd9e02
=vE6J
-----END PGP SIGNATURE-----

--a9Zu68kd+RCbgQ0y--
