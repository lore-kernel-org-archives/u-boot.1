Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652D4C4706C
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 17:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70A3787946;
	Sat, 13 Jan 2024 18:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VrDOougU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C04FD8794A; Sat, 13 Jan 2024 18:22:43 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6497387930
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 18:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-783137d7fb4so534075185a.2
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 09:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705166560; x=1705771360; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yqpJmjO1X5xiMNkgiYyR18HXAlfd2fdtiwo5b5txMsg=;
 b=VrDOougUi9tji76ZnHhvqX+6zmX7KnP2+OBR7w461s6tic0ojjVQe+l2O7k3B2MsQd
 MgApHy9spYdp2Wy2dAiaO/yclYLtigOCJhWl9nK2hqWX42luySvYKVJROauIR/pivBlB
 lA/UReB8gCLiUVz2cUKZ2QCl+4/eok5RAaPvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705166560; x=1705771360;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqpJmjO1X5xiMNkgiYyR18HXAlfd2fdtiwo5b5txMsg=;
 b=gjOlp13YOZsHMCqKzvBPGxX4aOmFUKZ+Ci10kTTlLfm3etlT5T0k1lF8YXkWbtspT6
 b4x1TeKbhFjrP3iydd3WlorzPaay4AnqOXHqazwUaHofSNWO6nZXkytkRGh+jAcpjFSy
 Clm6/stZkHACV9VLACFfsWBjA+4UahjQHet1mIFyBOPOZ01+i6U24uSCxC6AjlGEw20+
 eMvEjlRF0Lr5WFPG0Qsoirp/vBCerfNPu7rUtirObZ5h+vSKcgpFcasZdNnsRBUOFRkP
 YrD/ed1s0GyPE74EwXjijbKDv/UCcCMJmLmQ7vxL7oDQkSCKa4N3tl5aPB9pC7rhVDD2
 WhaA==
X-Gm-Message-State: AOJu0YwYeJ7MEGZcJAhCTB4FhlyvsXrRENTE6a30cBdhvw7u4mIMpeAg
 mXlRnQK99KRISNCWsC2siEZ5AB8CHHjMrQ==
X-Google-Smtp-Source: AGHT+IEW9M1LTgldRtfyl9fyJ+isEeg7jeMB62PKE68C1LJ5IpyBmMoQWi7iR4/5NzhN9yLDzNHxzg==
X-Received: by 2002:a05:622a:1342:b0:429:cb83:2019 with SMTP id
 w2-20020a05622a134200b00429cb832019mr3197334qtk.47.1705166560080; 
 Sat, 13 Jan 2024 09:22:40 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 t26-20020ac86a1a000000b00419732075b4sm2356933qtr.84.2024.01.13.09.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jan 2024 09:22:39 -0800 (PST)
Date: Sat, 13 Jan 2024 12:22:36 -0500
From: Tom Rini <trini@konsulko.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Dennis Gilmore <dgilmore@redhat.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] arm: mvebu: helios-4: add defconfig for spi booting
Message-ID: <20240113172236.GI1610741@bill-the-cat>
References: <20240113-helios4-spi-v1-0-2a5663a10e6a@solid-run.com>
 <20240113-helios4-spi-v1-3-2a5663a10e6a@solid-run.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oVxlOHfFA4VOJfRj"
Content-Disposition: inline
In-Reply-To: <20240113-helios4-spi-v1-3-2a5663a10e6a@solid-run.com>
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


--oVxlOHfFA4VOJfRj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 05:36:57PM +0100, Josua Mayer wrote:

> Add a new defconfig based on existing helios4_config file to support
> booting from spi flash.
>=20
> Settings for environment location are based on vendor u-boot:
> https://github.com/kobol-io/u-boot/blob/helios4/include/configs/helios4.h=
#L59
>=20
> A separate defconfig is required because the options are not
> intuitive from menuconfig, numeric values in particular.
>=20
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  configs/helios4_spi_defconfig | 81 +++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 81 insertions(+)

So, a super new thing that might be of interest, but please try this
since I'd like to prove/disprove the use-case.  This could instead be:
configs/helios4_spi_defconfig:
#include "configs/helios4_defconfig"
=2E.. enable/disable options specific to the SPI boot use case ...

And so now both boards will otherwise be kept in-sync for general config
changes.  It could further be done as:
configs/helios4_spi_defconfig:
#include "configs/helios4_defconfig"
#include "board/kobol/helios4/spiboot.config"

And have board/kobol/helios4/spiboot.config contain the SPI-boot
specific options.  This path would allow for:
make helios4_defconfig spiboot.config
to be a valid alternative way of configuring a build for spiboot.

--=20
Tom

--oVxlOHfFA4VOJfRj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWixtkACgkQFHw5/5Y0
tywq2Av/SUC4juSuAn5MYLVd3ol2cQL2k7+IZXiwAtKlMdp3S/paJYaY1xO1bNvN
IF4QlXnds7Iv5XtdwlmUAh10+wGBpvafCN78337nUkOcCYrVm8biGxJUYMZDv6rz
20Oni0PYUTl336pspqfv+99IWOtf6mTNNJ8yTsIMwRAim/2hN/gE/AAGwni2xetF
L9lVfWsPVuArePv4WwSWwMgoUzU3s7nba48lO0GxaSkS6L6Y3oFGMut+qKbN6yYY
rOq8vU28relkb9ilhoc7lbNqZo5mlygNKF68G9MhCdzlAtUHip/AeQOmMPYy3LdB
2HB+rCHwqG7yW09EN9r4IYxSQ0urpc5RDPI7NekbkelkAhVXNMexdAQVXsw+RAKc
ZaY6RBwQ6VWHUC7KfQrB82Ej+oV/Neq4TR6U82nAz6E2RRWzXrX9Ygs8pmHXc8rt
e+D9Pwi2q7iJPLapiWGeivR5mX1YEEpvfqQGW/KHDlCEN+RNvY6TxD+9L+CpogLl
t3nlg2Xu
=xz5H
-----END PGP SIGNATURE-----

--oVxlOHfFA4VOJfRj--
