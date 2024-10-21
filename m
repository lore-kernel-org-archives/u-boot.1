Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F15D15DBB
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 16:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5DA388E8A;
	Mon, 21 Oct 2024 18:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YO2YLLQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6EB488F0A; Mon, 21 Oct 2024 18:41:20 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FA7288D54
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 18:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5e5d0a80db4so2409824eaf.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 09:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729528877; x=1730133677; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dlgudqcEzRFeVuA7Xe9whzsxNPMGH0rAJAQcO2IjIwE=;
 b=YO2YLLQJ0tUHlVspZTFlNECbb0OyutyXPzka7W3/7sTH7ptxMLA11FcH5m4AqS9BbL
 XjziSUBfFioPUuhxfIETqOkxJKlLg13H3DTxPx5QP5ayem5TK2WxnntBY3ecB8J521gA
 2WhZu9Z3BVSnDXJTcPl9kJ1SoM54tqXwY1iTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528877; x=1730133677;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dlgudqcEzRFeVuA7Xe9whzsxNPMGH0rAJAQcO2IjIwE=;
 b=My3pLApftoutAyi4FOaaMM5LWJC9aEfLi2/JWknNy6z4UhwlbBB3n0fOl29qIv2a4o
 ggn/e06DI9i/ir3WJMKG3oNi6VNT70jZUn9p3h1C/iOz0yAzqo3uoKF+rko/4l2+Gn4P
 X1H6uYjtRHexM9vSkB+fDUP5UQyG2VYkrh6DOjepGIyG41T1uP+YOdzRe/l6M4NG7g/v
 pS6Cd3/f5HrRUJH79rlGSdQShglmWke4neDbckIy5xQp8A91cCECPp50B5GWuLIMs5Ka
 jOVU4OmOa30LRgF4R4PimRSLctjt4br7pdPd0nCnJEEZ442ekfj4U3LJ8R5uXHXEYBy2
 KYgw==
X-Gm-Message-State: AOJu0Yz381vBWrkfGhzDWOgotx6O5iL83wpSrNdLxxQsUVova2g+1eOw
 9XiRekNYrZqdT3yQpR1tTxuAL4Fr1HK6FfFdNiWY4nu+OlgDAPY7ERP7h2WXC+0=
X-Google-Smtp-Source: AGHT+IGc1GBp0XFwEa1ZBMJ32S16sRj6mCNVVNhTCQeD3JcR9j9JNbd9lZJ1sZRKtQuhjUBpMsid5g==
X-Received: by 2002:a05:6358:7e82:b0:1c3:7d20:373d with SMTP id
 e5c5f4694b2df-1c3cae024b2mr95016555d.13.1729528877269; 
 Mon, 21 Oct 2024 09:41:17 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a73b44sm186719285a.114.2024.10.21.09.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:41:16 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:41:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, u-boot@dh-electronics.com
Subject: Re: [PATCH v2 1/2] ARM: imx: soc: Select default TEXT_BASE for i.MX6
Message-ID: <20241021164112.GI4959@bill-the-cat>
References: <20241020210113.1248062-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CM0CHy+vZXQ8adUP"
Content-Disposition: inline
In-Reply-To: <20241020210113.1248062-1-marex@denx.de>
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


--CM0CHy+vZXQ8adUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 11:00:38PM +0200, Marek Vasut wrote:

> Select default U-Boot and SPL text base for the i.MX6 SoC. The U-Boot
> and SPL text base is picked as the one used by various i.MX6 boards.
> Update all the boards.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Thanks!

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--CM0CHy+vZXQ8adUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcWhCgACgkQFHw5/5Y0
tyxwPAv/cEdwkGPqpKdwQXwjhAAZCKNuYsNLOccYObYDjbXunpV5dbEvzGp0A0HU
tfH0gpLO58err0U0K8sKO0RoEZws6Cp/71i390S3HDk0V0ASBozM0kLK1J4WJgoO
tJt+riRHzDaTuymlj5bnD3umLYh1c4ZzXpJIv0suD5KBO2GoMarmQdI7vQ3DZrQx
OnLdAqLW8Q3vxDiF5lBcIA65bf8uWfOwnV4eQuk/tZvVB/rP2UKZtocBKttD1pvS
o3QbibOBZ1G0ONzT3BakXKyLBj/HK2bYgM38r7AclvECiBcdE1VuUjTG3UJJ7uFG
Ro8XfqSZoXHLfod6N1oYGMBK2Dc4BWSojQgG+mlZGUHIFPFON1caYFT59BukMymn
Xn/kPYK4/hAIYkH/fLy9BlSimch0JSKGOVN3ayvDtKZ7D14ZlhEKgo0UsROJXldd
NV1gv4/f8O+etuL2Q8XUwlMKnzPpPYKZvzoziRzDo+oiaZzGDaCfw8UfbLPeZ2nY
NKjPRX/n
=mxzu
-----END PGP SIGNATURE-----

--CM0CHy+vZXQ8adUP--
