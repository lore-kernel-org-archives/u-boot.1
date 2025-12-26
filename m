Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0686E8FDA7
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 14:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3329A839E4;
	Fri, 26 Dec 2025 15:57:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cnGdNTz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D7C839E8; Fri, 26 Dec 2025 15:57:55 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2335A83990
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 15:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c78d30649aso4772260a34.2
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 06:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766761072; x=1767365872; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=evFT6Tlsazc8P+HLjoMqis5U15Tux5EPkelX3GAFCu4=;
 b=cnGdNTz970AGDf/g8MBGLmjI0hK+COUxNNhZCME2bo9rs1PwzxG9h/GfgLURo1IUki
 fwscb+e4ls7rmqKiWuppEGa4Hq70dliWhku54uL2F8HKi/leSOVbe3rCrv5JbIoi3Y86
 fkH4RLL06kU34TJoWgF6ntztIaP8laKDgVOis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766761072; x=1767365872;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=evFT6Tlsazc8P+HLjoMqis5U15Tux5EPkelX3GAFCu4=;
 b=aZUwBNo+5C7MdxZxRCzSV6bjaMWUmYIQgFPK51Dbakcmc+WO/n2Ky5h5//JrBN5vvm
 zbdrok+FjtmEbL05HHzHmJiTlUkUUNxerw0hiqmlOstbjXCcNjGMe0VXLNFlU+iVdgkR
 c/X8Zi29hr/73Wb5yvB0/oEIp2ngezrt8Vl5kJaSqvx/SQ3GgjUvONxVfK0zKxS3Y7YR
 PipRmVBlJAqnXnS8s18cctafKpFng5g2pGUY37sUxrYhthZx8zk2cWa1PHo9whwaMeAi
 oi9i5GrRl8XUTNNE7D4JE7vpZj1720pfrG0NuuUvZ4Ilu8IyIx9gMpY7pG9OeoYHlyDq
 8FWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzrJW3DDy0y7am72ojkGmWnVuMZPoxzyaTHaKTy0Bnv/mOA5TC+4rw6jnVLS5A7dfFDDaXAUg=@lists.denx.de
X-Gm-Message-State: AOJu0YwRaH4ro8u5OY3GToCXvn0bB/CHY96t/PpqOXebqtC+S/2sbr4H
 5mR/jgWTW1M2xBnuy4B8vGbjypMpEo5iLT9N1Qz7YVm1EY5tFkXd0++tNm6zcHIzr4E=
X-Gm-Gg: AY/fxX6oo/PyD+V/BJrpamrHI57xnJkC5MMEMRbh8NoIFWagUQdGaLlBZ67ErQaAT2s
 Rr28uz3AVG6Zqu03Sh8W8TuXV+QVWnCmaHSY9bdcF7wKbchJ2MUEonNVUUPWaFNa5HzQUandmog
 92bxvE6siAT6iM9b5adGKczFTVECcnG3/KWJdigQsDCZYo/zcvLX0qaFJgIXqMssF5x8rncHNwH
 OJ5ahVxrUgfJ7ubCRPZ/2m+3mW9QxYY6G3cqELQZQhYt4Uj/j/ZNC0bzx62y84/AtjGsWvNVcn5
 sgjr+Ds67owQKeDggDATpfCX09cGR1UgSp6nkmXgoO0DhKqHICaJRpT0+HFsRiTXY6irYJGW8B0
 w0uWoXWy3iu6b0HjRUEfSupbOCKVTeRA4RBpxRckNwUcbJWjNOaJ6ISfpGXbnPOOYoXxhe3qool
 ZAKDw5ETYS/moSSKlFjeHoOrRVBmIqk2nUdvRQtsvq44fkSzospUWtKI0nQWyp
X-Google-Smtp-Source: AGHT+IGlXw6upzPJaqsuDF7L+zT18R7kkxzxIoIjK8jEpM1GFFqzq8csx3grwWiifxxjRYKJpYBX6w==
X-Received: by 2002:a05:6830:34a8:b0:7c7:6063:8e02 with SMTP id
 46e09a7af769-7cc668a4ba5mr12540798a34.6.1766761071869; 
 Fri, 26 Dec 2025 06:57:51 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667d7f1dsm14994165a34.15.2025.12.26.06.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 06:57:51 -0800 (PST)
Date: Fri, 26 Dec 2025 08:57:48 -0600
From: Tom Rini <trini@konsulko.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Jagan Teki <jagan@amarulasolutions.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Heiko Schocher <hs@nabladev.com>, Alexander Dahl <ada@thorsis.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v2 1/4] spi: nxp_xspi: Add new driver for NXP XSPI
 controller
Message-ID: <20251226145748.GD710860@bill-the-cat>
References: <20251226-xspi-v1-0-4bb116750dba@nxp.com>
 <20251226-xspi-v1-1-4bb116750dba@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vjBfjkIOhHfzAhA0"
Content-Disposition: inline
In-Reply-To: <20251226-xspi-v1-1-4bb116750dba@nxp.com>
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


--vjBfjkIOhHfzAhA0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 10:27:40PM +0800, alice.guo@oss.nxp.com wrote:
> From: Alice Guo <alice.guo@nxp.com>
>=20
> Add new driver to support NXP XSPI controller for NOR and NAND flash.
> XSPI controller also uses a programmable sequence engine to provide
> flexibility to support existing and future memory devices. It supports
> single, dual, quad, octal modes of operation.
>=20
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  MAINTAINERS            |   1 +
>  drivers/spi/Kconfig    |   7 +
>  drivers/spi/Makefile   |   1 +
>  drivers/spi/nxp_xspi.c | 881 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/spi/nxp_xspi.h | 705 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 1595 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6ce0bbce13d..262cd85b1f4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -322,6 +322,7 @@ F:	doc/imx/
>  F:	drivers/mailbox/imx-mailbox.c
>  F:	drivers/remoteproc/imx*
>  F:	drivers/serial/serial_mxc.c
> +F:	drivers/spi/nxp_xspi.c
>  F:	include/imx_container.h
> =20
>  ARM HISILICON
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 2afb15fff1e..f703c880563 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -406,6 +406,13 @@ config NXP_FSPI
>  	  Enable the NXP FlexSPI (FSPI) driver. This driver can be used to
>  	  access the SPI NOR flash on platforms embedding this NXP IP core.
> =20
> +config NXP_XSPI
> +	bool "NXP XSPI driver"
> +	depends on SPI_MEM
> +	help
> +	  Enable the NXP External SPI (XSPI) driver. This driver can be used to
> +	  access the SPI NOR/NAND flash on platforms embedding this NXP IP core.

Does this driver build on sandbox? If yes, great, if not, this needs
more specific "depends on" logic.

--=20
Tom

--vjBfjkIOhHfzAhA0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaU6ibAAKCRAr4qD1Cr/k
ClHfAQCnMG+iigZk07wh/aPDK8wUvWeMDnpo0UiBmL9Yrj2k9AEAhBVSUnoZnkGJ
lHGtWS7RIjCpZJz6fik0s8EK86IBWgM=
=/ewh
-----END PGP SIGNATURE-----

--vjBfjkIOhHfzAhA0--
