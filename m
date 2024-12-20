Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2905EE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 14:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9271A80326;
	Fri, 20 Dec 2024 15:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IbYQ6oyw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7A9C80352; Fri, 20 Dec 2024 15:56:16 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8644180243
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 15:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-467a17055e6so19379891cf.3
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 06:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734706573; x=1735311373; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z4BkUecrt4oU5TTQSMEG2bg2pirZPe1WvniZBylKqXA=;
 b=IbYQ6oywTsSlvBisWqBVlyMLUlW5TanKK9D2Lj+//KQ7twpqiR8FUupjRAKp9Ldup0
 pcIwMx0uUm0dapnpfk1Ha/mj/8HQXrVCiP2NYgu+OXl2tkcldK2Udf8eSI/7uslUMMl0
 nmwHiv+OWZH3Dz2JAShbkQD9kFTq3LWf2aQ4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734706573; x=1735311373;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4BkUecrt4oU5TTQSMEG2bg2pirZPe1WvniZBylKqXA=;
 b=K+E+hRA3NkA3/OoOQa70+VAHwTnZvkerGxyrQ/HhPaWyjKxcWwXse3eUWUg7XxzR5v
 cK3ASAiIZ2V8fN9gtwb1z2Qn9igZiHkuXjPRBA4L0M9Skxs1EjStkckVoNjl34DeZlbf
 QyMUfHHRjHr6GsygN8N29pmV7Aj4Vgc6MbtYe6JrnIVIx5kyJDW444O2v6rCi+YMy7xw
 2AENBVOOEP9k4MIB2ZwxnX5Q/FdtaoqyH0lNGj4JKeGKDuTeSvyMR40QCQ329Pm9yhZR
 p7eQ82V5+M2r7ERmSmwxgBrdD6ssN5a8pQ8qKPmOG2rnT1W7xofVeTKrsRpnFO+cIw/S
 zISQ==
X-Gm-Message-State: AOJu0YyPt2na6FP81gdRvYUHD6iO0lbGHzN5M6fl30coGHesAmm8lzD3
 OvpT9TEy8MZhjdXzuZ8oyhkqqFjhI6c/ZR+IW95uHM2vp3DyW6y76dCLPkkVa6o=
X-Gm-Gg: ASbGncueY3qZrsWMZv6dL4LzRhbiPSB7HdZnVPx9uf7wemSjz5Jvd5RUscEg2pfiBF6
 s9HeLHNZ8+hcl2XYtfnBxQhIDI8iMpQQtL+sQHs006mUi5x5eGOTnZgV1h4GcPNpcm3l7fpBXFd
 8pm11qDRjIc4JxPmkGV3wi21QTsuuE8cTkfNORYug8d94lGWttTHQ7gc3oW8ys3JrMrf5mKCmbK
 7VbUa4ML+Bo19g+t/m2XbhIPRr0y4eL49X5oainGVpjeN2C73HBaqsn
X-Google-Smtp-Source: AGHT+IGBK1m3bLt14v5N6wntBWXID8lW3h5pnfMiemTBcn6m9WizXAKRu2PNC1sVKvXe0UPzTZMrZw==
X-Received: by 2002:a05:622a:1818:b0:467:6e87:99ea with SMTP id
 d75a77b69052e-46a4a972786mr53878451cf.44.1734706573408; 
 Fri, 20 Dec 2024 06:56:13 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e6af060sm17417941cf.50.2024.12.20.06.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:56:12 -0800 (PST)
Date: Fri, 20 Dec 2024 08:56:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 4/5] pxe_utils: Support a backup for localboot
Message-ID: <20241220145609.GD1505244@bill-the-cat>
References: <20241220040120.3245610-1-sjg@chromium.org>
 <20241220040120.3245610-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PD9eZRYp4cKAJu4z"
Content-Disposition: inline
In-Reply-To: <20241220040120.3245610-5-sjg@chromium.org>
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


--PD9eZRYp4cKAJu4z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 09:01:19PM -0700, Simon Glass wrote:

> The current localboot implementation assumes that a 'localcmd'
> environment variable is provided, with the instructions to follow. This
> may not be included, so provide a fallback in that case.
>=20
> Add a test image and test as well.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This is a pretty niche feature, I had to dig around a bit to see how
it's specified elsewhere (not really) and how it's used. And I think
that based on how it's used, making up a bootcmd when localcmd is
undefined is the wrong approach. It's the hook for "run what I defined
in the environment", so if not set erroring back out seems appropriate.

--=20
Tom

--PD9eZRYp4cKAJu4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdlhYIACgkQFHw5/5Y0
tyzn0gv+Og9VT32JzZjXq0HrvW5+SRWQMXMJWGbLpjt8UCS8PnB/PDAU7WP9Qsbk
tqcS1XRR9uEJIhPsoU9OSCkBJuWTbY/SKuwFO0h9ltKwMzOPJQeXpcqZWF/PDYec
6X2Dt77kNurUGqgWaxIKcIvHRL6Tpwemzm72xQGhWi8gq7t4NKnDCYdqwZLaWUYk
0zZGjIIsKp/SjDkNXY4EZjfFQFaTWxpsj4Wn0V7GKvrSndq8e+nZEgAoupFPoNBF
d3gDZCtkvh0tmnppaax588LHbn9rp8OMqclapblHH4kRG7wPfMz1Xx5iIIY12dt3
6xfUiex1+p+YTeYZCQ2Fbmp/qCfWNX2QsaBBD57yX+uMDLwc1zcoOCkX+GW1Tn6u
9FXUXBYiOiyfT40pyC4jO2uk+WnvrKQMz5thZR2CySORWH/Xr5Pm4yVktBS5EOcK
q/GnnU1QaoUDHieWNy+wauiqdPVOrhSfkAh2NcVMeGs9jQVP0Et69JpMVmSxF0Zq
ufa1q8EO
=qvdi
-----END PGP SIGNATURE-----

--PD9eZRYp4cKAJu4z--
