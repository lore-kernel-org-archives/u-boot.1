Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA104C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 16:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DC6A8842E;
	Tue, 16 Apr 2024 18:06:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CqLTpJnw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C63588842C; Tue, 16 Apr 2024 18:06:34 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9718888438
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 18:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4375b8b4997so1894081cf.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713283588; x=1713888388; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r7m/cuOHJlMuQH+GMS344S8PTUaVWeeoDcWKJEEh0C0=;
 b=CqLTpJnwm6+yIC166SL3du7J2TFdaPwATQR1VwxBK1TWkOgy4eLvMwATlWoeQbQTpT
 nWYAwTfR52DPmticH37LD0+kIKz/EtM7EQxOHsVQC0R2EGte84ycToI6UJgj/uI3jCpn
 ff1EGzTangsWXdQ2ZNIpzie8sCk7YzzOvkUIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713283588; x=1713888388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7m/cuOHJlMuQH+GMS344S8PTUaVWeeoDcWKJEEh0C0=;
 b=mkutj4Iu+6Kb9XAhKTiWYBm9OSnjYb1aGj63WHqL0NcZjgREZa/EBMWDnPH4FRyweD
 Fklk7M1OBSwutp+sRVq4Nc6jPv5oqdK9mCGByiAtG52h/6p6p0rgYlegreaxRJ4gYrqx
 hqgInAuswfTNp1DBq+KJew/UzubzTcdegBavzdXby1M7wGKpl7XWMLOGYGkbsI3dmOxy
 YqhBmKzmcfj/zWgruB1on3lgmoVp+KFR0W+OERHWq6B0u7UM5YNLWhDTfHtUojxZzhUt
 6eaVoIVr9Rj5fx9sPT4Xrwhsv6bovP55QGYH5rB9yBY0gcHvcdttqJKPrmSIZJYfPHMU
 4uiA==
X-Gm-Message-State: AOJu0YzhEC3sQM1G0JYgRAxCflIr2Y0dQNJdHw9dTLhJwV14R2J4NuLQ
 2eM1BZGz+UfYC6MUz3++CCQdjsgdhwIqtDsBIhVtLmfZNwkjw+x7NxA+/tmKIqo=
X-Google-Smtp-Source: AGHT+IGnBhl+SzLOgBhDkBU5hxXm9ElvKaSgKxnuvfhlS0t79CHZmB5gJuqXNRGybB21nLNiKhsDcA==
X-Received: by 2002:ac8:5a54:0:b0:436:a3b1:6d89 with SMTP id
 o20-20020ac85a54000000b00436a3b16d89mr13916287qta.5.1713283588357; 
 Tue, 16 Apr 2024 09:06:28 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 b9-20020ac812c9000000b004374934e6ddsm584790qtj.75.2024.04.16.09.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 09:06:27 -0700 (PDT)
Date: Tue, 16 Apr 2024 18:06:23 +0200
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Andre Przywara <andre.przywara@arm.com>, Dragan Simic <dsimic@manjaro.org>,
 Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tim Lunn <tim@feathertop.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v2 4/5] Kconfig: Make all Kconfig encoding ascii
Message-ID: <20240416160623.GN1054907@bill-the-cat>
References: <cover.1713250508.git.michal.simek@amd.com>
 <1e5b7558d30fa17b08f112e8804c7f4eca25a722.1713250508.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YIiDA9N7xtextE7l"
Content-Disposition: inline
In-Reply-To: <1e5b7558d30fa17b08f112e8804c7f4eca25a722.1713250508.git.michal.simek@amd.com>
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


--YIiDA9N7xtextE7l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 08:55:18AM +0200, Michal Simek wrote:

> Some of Kconfigs are using utf-8 encoding because of used chars. Convert
> all of them to ascii enconging. Based on discussion ASCII should be used =
in
> general with the exception of names.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>
>=20

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--YIiDA9N7xtextE7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYeof8ACgkQFHw5/5Y0
tyxE3Av/a4zXM3x58ob41ggKMF4P7YNdhyHEVlPf3tBz2PUS/X9jS3mFqoJGL5vl
wPaVFnS42vIBMsYS2Jmwl464NX+BXOT+RUPcTsPRSMyuo72sWSzfnrfZo8C0W03T
ks9Kc/484g0U2s0sk+QIiQWBye9nPFEGIDj4EnF9X2DCUEv1NRkEiIbh8Oqweg9f
dgMZg3hLyo0Xh+un4BmNpesKbHlpWrR+3LmORxs/moU348y0fChlGaKX5Q1h+9Ul
DpC4SR605U9WWQi49hXCGdXaQC7ILWGFNdxyc2aitsTzAkn0s9jdUozTMMqgPfaJ
ZlGVhqGjlwb3VUFTVDwpeS6u/q3GcyQtbImsnWkDkgPo5Qyuukxi5P34nn/Re0c5
1RYiZQjoqcNGCz8lH1rR4BwSulkt2aIZ2OJmqz+q4WFAe3ufLrYZPiK4jfAuh7n8
Xyrdt3nBJFVlQ6OlHRMQzwBL3Dzkt2qwlzJzUV+qgQAFoMWGeOOzOVB3Izv/gXJI
qtqmEqV7
=7Ymo
-----END PGP SIGNATURE-----

--YIiDA9N7xtextE7l--
