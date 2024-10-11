Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA62FD0EE19
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 17:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF51D88FCF;
	Fri, 11 Oct 2024 19:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jCYfD2QW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAFD5893A6; Fri, 11 Oct 2024 19:31:35 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6E0F88966
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 19:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-716a3e50a81so1360422a34.3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728667891; x=1729272691; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TFri9wvnsjLlXJbnB5hi9y1bzVwL1eOv3imEt0wM8lc=;
 b=jCYfD2QWsnf1xdaKOHxVATQu8yag0yhdeQx5RBK6cCFdobIm3bW9867aLElDxigHIw
 bQOmbXRwpY6vwXQQbg6rxLGcFcrNkWfabAUa0IFx/eZeYR4uCUOPWRGEjsTx2n6WFQ2Q
 vscaL9BmqHPRR8huwQwlK5vzFihnrz4y3SUpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728667891; x=1729272691;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TFri9wvnsjLlXJbnB5hi9y1bzVwL1eOv3imEt0wM8lc=;
 b=j07E1OTFY1n00C+jQVqovesGgVIhuf28SB5+iEDCpFybd7cJKjAK/VjfG653J7bzmE
 cnL4EQsKFglVzO4rZWHfnmrb6wQ+d/G0JZp7qdsuefxZ4oJ0yG252qlwmsuPMqoibF04
 jL5gQ/sp0yqBnuqQqqBMD7zkPVB1zkXKemvefDeIjmPk4oNuMbyBSYn7MaE+bczAs9nP
 TrGoh9/t2QadGG+cMhkCJeFOcr4vjpKW569oWsRSY25Nt5nZX0eVxMFlA0NyrfULcHoW
 iVgfjU0zg9JTCrjzTRUHrLrcnTzd9DEsEL1TvoTOWaZicDMrClt+sTNg22R7GSj5+q6J
 2M+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkIjEOWIRJpS3kh9EmJ0kj7H2Pynw++irMgGQQGeH4BZgUNOhHdQV8ftcV5usGwA/Iaypx6f0=@lists.denx.de
X-Gm-Message-State: AOJu0YznQA4pxLIopINVeFkSfNLYKsuFdc8uiVVUj4hz++gZ1umvdO6g
 O0JaxpPRqEC8ivzdJojJFl+Zm+z1jME+kW4OS5+YP41kP4lRh/YYl3Sms5FVS1s=
X-Google-Smtp-Source: AGHT+IF0Yr7q0ALw7dnd3oRRegTSZ6/EezSQNKYxsZ1d1HgBXNTHlwAV9Oz9vVEoe1XbUy0tVqtoQQ==
X-Received: by 2002:a05:6358:63a7:b0:1c3:71:1891 with SMTP id
 e5c5f4694b2df-1c32baa58d5mr210642555d.10.1728667891482; 
 Fri, 11 Oct 2024 10:31:31 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85a5816sm17177586d6.21.2024.10.11.10.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 10:31:30 -0700 (PDT)
Date: Fri, 11 Oct 2024 11:31:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Oliver Gaskell <Oliver.Gaskell@analog.com>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Marek Vasut <marex@denx.de>, Heiko Schocher <hs@denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Stefan Roese <sr@denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, adsp-linux@analog.com,
 20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Subject: Re: [PATCH v2 00/11] drivers: Driver support for ADI SC5xx SoCs
Message-ID: <20241011173125.GA526760@bill-the-cat>
References: <20240925-sc5xx-driver-series-v2-0-ad9287c25c08@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eBgD3FCAOXmeOK3i"
Content-Disposition: inline
In-Reply-To: <20240925-sc5xx-driver-series-v2-0-ad9287c25c08@analog.com>
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


--eBgD3FCAOXmeOK3i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 01:25:10PM +0100, Oliver Gaskell wrote:

> This series adds all of the supported peripheral drivers for the sc5xx
> series of SoCs from Analog Devices and other drivers that are used by
> the evaluation kits, such as a GPIO expander used by the EZLITE carrier
> boards.
>=20
> This series is based on my earlier patch series:
>   "arm: Initial support for Analog Devices SC5xx boards"
>   20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com
> since both that series and this series modify MAINTAINERS.
>=20
> Note that patches 05, 07 had Reviewed-by tags, but have had minor
> changes since v1 so these weren't kept.
>=20
> Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>

Please rebase this on top of current master, thanks. Also check that
each patch is only doing the correct MAINTAINERS change, that's where
trying to apply this by hand failed for me.

--=20
Tom

--eBgD3FCAOXmeOK3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcJYOcACgkQFHw5/5Y0
tyx0sQv+JwqKWs6xjUt43IqkqvRTmNXIq1ETcXIpQAc+Dd57rMd1Ae7O86j+6hkA
jXGU9gO89aUsMUhtK+kQ+EfT/1ky5c96js6RtUrt8jcRBm5aLS8q1hWYk/osJ3bT
5qI/A6gOOhczg3JENa73I6Bf1SbgI+1Zs2Jlbz2vDKgLKG4i16BynkfGqicl+p1a
6GzOJgba0Jsb5wtQEO8oC5M5DA1AtLuHoP6Jn2F5LWLi3vVSO89HXs8u3jy/5QZD
g1It0AO1f4tuhtU7axnvpGMeXoClZZqMWcfbl1Ir7O+WxhVLYIabzQ1jmF4MlwHT
7CHXy7/nLQx16HIUAXnJerXDKZOgVDorNkpiMmWiE09dq1NnoL5USrYaxOtR/Wb9
AkBrVOaqmQJ8ExCG+rACd9Ur7dpkZoHxyy2ZGoazb2/hdNY/lHAvd++rMDO5xOxn
+8dyGC/rNHeBKJQtxQfRRmjnCvlzRICIhKcclB3C6baeoql4gcRonvv/ML51GDuo
I0wjER/q
=zI3Z
-----END PGP SIGNATURE-----

--eBgD3FCAOXmeOK3i--
