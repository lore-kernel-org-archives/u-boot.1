Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D175C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 14:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D6882045;
	Mon,  2 Jun 2025 16:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cKBZYiO8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 527378205A; Mon,  2 Jun 2025 16:49:22 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E4481FFC
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 16:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2da3c572a0bso2291204fac.3
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 07:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748875759; x=1749480559; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=95j8FqKKO8jkGBrSq4V8EsRmjyyvYwSIGyBOafusy3o=;
 b=cKBZYiO80jzqPQO4BbL+VGXXlo4tdisc3lNUjrNZJcso7RRzUxi3tt3XC8KooMjxc0
 xmXz6Pr/VINEUMoMGn4YmmBSFNntcz3Jg9GagOSUiYTrCfslsocDvvYsL4XARmbOt0zt
 X4JuCNCQKzNv52TGFDcFpElMYbnSMPpstWmLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748875759; x=1749480559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95j8FqKKO8jkGBrSq4V8EsRmjyyvYwSIGyBOafusy3o=;
 b=A55Zrjy2hInf8MWxW1xQfsn9rD7VT3F63ZY3APoSmPyiy6asnS5wa1uetc75HNtlpp
 qBlTrNkjABME/1QJi0WtJ7LIulbKJGnS8ORGCHPQfsFFeALWsXnIsqXbq0gKyVlu0sOf
 lGYmVMhQymPq9WCoTyBD/p8geJr3PTCGV0pwKw5miOWvNauWRFgnKCw0aJqDrTISPUE2
 um8lI69zaPO9YSy8RzXoCizTZJ+RRAElXkJbJyj4lKLAanPx4+yoz1TI/pqpVhisVjaD
 2BBhKB9UMmWp0OVhH2ci6KgT1MMNhJ2v5eYTanlYG7AfFShWxYcP5TOJHwtrvQPLcDfy
 MqjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULnNsDXkbQLAZ3utrdG6Z0knO4BU1vd/1qlmraW5jAA+2C8SKji8AglW73Dg6hQF/S4ZacCQs=@lists.denx.de
X-Gm-Message-State: AOJu0YymRJ41a+pLHt2HCcs7RkYzYMr8trc1GulQscbyhtThgYmCNFRU
 Z4KzOsQoj5LML+7bJms/w6+AMSHia0gLD7IkaCwwB4jMQ+FMl8Qp8wgvpuD/ueAEdiY=
X-Gm-Gg: ASbGncuLMT+Vw42Wq8BKpSbkJl/8vJsk839KA5Eyp5cCo3X/9PfatVXUZ5A/a8AbAq9
 EpF8Mq8tyOxOqVKbTU7w8S47JTyX8wTi1yzSkvPzygsfBE8FucSWlqEmjscXS4npT96emtG3Pjq
 TFODJX2NDqki9sJsXldCTh/ye+2suaRhAkBfTw0dZvkioguSYreg8948ol+HICng8+JgQ0RNzvl
 Vu+C4qJ/+xkPaMdqPduvJLMS9pV1ONF+Zl6+ZAdt7tpTuRWghQZOgHxKqSTA2rjqx1oTDQzaaCw
 O5WwlIxlwowaiu3QDcrzp5GD9gnkwXoyZKTWprAATxsFzaQP355thJh3bg8OJgkjGfMJa0kdhsw
 TPQCRXxyx1EJA
X-Google-Smtp-Source: AGHT+IEJjLygwEFGKHtgTy73+zbvnvyvMmPBJdcPt/0cERYYDcnyf+fviOc+BciOWcmOhMvVF5CRfw==
X-Received: by 2002:a05:6871:7288:b0:2e4:140:4b1f with SMTP id
 586e51a60fabf-2e9212bf665mr7774255fac.17.1748875758791; 
 Mon, 02 Jun 2025 07:49:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e9067b04b6sm1735754fac.19.2025.06.02.07.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 07:49:17 -0700 (PDT)
Date: Mon, 2 Jun 2025 08:49:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com, Simon Glass <sjg@chromium.org>,
 Anshul Dalal <anshuld@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] ARM: imx: mxs: Add support for imx287 based BTT devices
Message-ID: <20250602144915.GW100073@bill-the-cat>
References: <20250531073709.979924-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KkYse8q2fDbjMzUU"
Content-Disposition: inline
In-Reply-To: <20250531073709.979924-1-lukma@denx.de>
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


--KkYse8q2fDbjMzUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 09:37:09AM +0200, Lukasz Majewski wrote:

> The btt[c3] devices are based on imx287 SoC.
>=20
> U-Boot SPL 2025.04-01081-g07e086681d26 (Apr 16 2025 - 12:24:36 +0200)
> Trying to boot from MMC1
>=20
> U-Boot 2025.04-01081-g07e086681d26 (Apr 16 2025 - 12:24:36 +0200)
>=20
> CPU:   Freescale i.MX28 rev1.2 at 454 MHz
> BOOT:  SSP SPI #3, master, 3V3 NOR
> Model: BTT3
> Board: LWE BTT SoM HW rev 0
> DRAM:  256 MiB
> Core:  86 devices, 15 uclasses, devicetree: separate
> MMC:   MXS MMC: 0
> Loading Environment from SPIFlash... SF: Detected is25lp128 with page
>                     size 256 Bytes, erase size 64 KiB, total 16 MiB
> OK
> In:    serial@80074000
> Out:   serial@80074000
> Err:   serial@80074000
> Net:   eth0: ethernet@800f0000
> Hit any key to stop autoboot:  0
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  arch/arm/dts/imx28-btt3-0-u-boot.dtsi |   7 +
>  arch/arm/dts/imx28-btt3-1-u-boot.dtsi |   7 +
>  arch/arm/dts/imx28-btt3-2-u-boot.dtsi |   7 +
>  arch/arm/dts/imx28-btt3-u-boot.dtsi   |  90 ++++++
>  arch/arm/mach-imx/mxs/Kconfig         |   6 +
>  board/liebherr/btt/Kconfig            |  24 ++
>  board/liebherr/btt/MAINTAINERS        |   6 +
>  board/liebherr/btt/Makefile           |   9 +
>  board/liebherr/btt/README             |  11 +

This needs to be under doc/board/ somewhere (and please make sure that
'make htmldocs KDOC_WERROR=3D1' passes), thanks. The rest of this looks
reasonable, especially if we shouldn't more generically change where /
when we call initf_malloc.

--=20
Tom

--KkYse8q2fDbjMzUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg9uegACgkQFHw5/5Y0
tywFRQv7B812EId6BbhFiyVW83CllhWzwEzruzKHMVbep5Rrn0RIXmQBVmIpVfNZ
jHi5okANyQq1cChdSeoRadLIIFEaENho8X8HTZbFehnhWuOJzB6jDX4MY4lHX0OE
BHWFeGBDrLW/6rYq9toWtwRXhmPuX4oppV2/iTQk42N1Udj1dHstfoaf3NSBq32M
6T8klbC1vyw9oj1o7NnBGuZABd3YM9BlcZCGYdPUECTlG7Hy00s0dywzEWBk46Gi
1OI6MZ6CADC1NVGzeWF8WLSTFXX5pLTd212qep+xwtD7NdHtY1TidWaVE8l+E4rH
aajVjcqIKIStH0DBk3dbas5j4CWrTFIJJp0qpRyizcQmuBa+ZA4MKwCwGqalu3eZ
7qq1xvenqPpYCjb0fiLveomuWkROSGHLnSC6iUepudeoyttNlBHyk1SfA8132IP7
7U+geFxZKY+dE5FNBLXLA4Gjr9UUAJq6MI8IduuPcfq5TETMtYgh4VqQ7RHbHf89
K2HkMCAT
=vq9t
-----END PGP SIGNATURE-----

--KkYse8q2fDbjMzUU--
