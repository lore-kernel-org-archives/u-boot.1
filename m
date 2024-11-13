Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C63D462B9
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 15:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B297890FD;
	Wed, 13 Nov 2024 16:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WRWdhmvN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC0D89119; Wed, 13 Nov 2024 16:22:51 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F204888FC8
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 16:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-288a90e4394so3131522fac.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 07:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731511368; x=1732116168; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cmqoVf8i/yg+lKwRkOhkccAmi1ucntAoGwmfngJsGKs=;
 b=WRWdhmvNVCBbR5FgU/rURtxTN384MEj9MSl1V/uXhBQlp1LTirLqyiWMlqBYAhxA2M
 CiQdTTiTlcI+t4MSs9R7f1Whu+cus/gvXdtlqAp4UllAJzyKi7LZeb55furQDawHWiWv
 jFE/Cm5PofhCNqCDeeKHXmPHPe6OzcT9XHTFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731511368; x=1732116168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmqoVf8i/yg+lKwRkOhkccAmi1ucntAoGwmfngJsGKs=;
 b=KlOpGFRjYzAcW0MzNW4vgjaCTvFKzkUlzsXKSVRl5coMmjjYo+B+rZ+D3Joncrkt2S
 ceyU81YSO8uWu2IY4KR6RjDN+Wv/ZvRo0WCLTujnV17rfMaEKGcZ51D+XcVagxVO7a5G
 tl3OCpWLhlnqxQv8Z+anJremDfaz/g3NHDpKTqFVj5td+qpbnfyMcpAZKizZL/GUrNMK
 wepzQLE8ePAts7C8QCRWvcY9HhoXV/cg3W+KKxXe3rUOz3ComepXmVYbh+VOg88qEpwm
 EVusJOZ7yTIVI5sL3kW5qKsBLKJpsR8awl4L3x2j1G0fVf0mCKJTDvwtu8MTT0gxgMxa
 ZMyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlwKps2DVxktKHasHADc507yhq+ZhPLVIrJ8UEtN+80zL6+s8kja/5a74yJRa/udlTji9Dg9U=@lists.denx.de
X-Gm-Message-State: AOJu0YwDUdOdMqiM6hpy6YozwuoW8XdrdGShEkjTzLs1oPe1o+fcY5ba
 EtIaEakAwfLkhUomeGrJPDOoOGJzcYVtrIPmopUuFlBXGEeyRenqf65emqf2wqw=
X-Google-Smtp-Source: AGHT+IHko7T2Uai7rWn5gt05BKgSdmqsKUmLCXti4kxER2c2HblmvPGsukbmXru/xCc40KVkljLs2Q==
X-Received: by 2002:a05:6870:b11:b0:278:222c:98c4 with SMTP id
 586e51a60fabf-295cd07f9d2mr7450867fac.21.1731511367679; 
 Wed, 13 Nov 2024 07:22:47 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-295e934977bsm774189fac.51.2024.11.13.07.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:22:46 -0800 (PST)
Date: Wed, 13 Nov 2024 09:22:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: neil.armstrong@linaro.org, Caleb Connolly <caleb.connolly@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tony Dinh <mibodhi@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] cmd: add a fetch utility
Message-ID: <20241113152243.GO3600562@bill-the-cat>
References: <20241113042536.1792150-2-caleb.connolly@linaro.org>
 <4dc079b8-4087-4c50-919b-dc676d38191d@linaro.org>
 <47DE77F8-1EC3-44F6-AB70-2D7599A79FDC@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Uk6QvtcwHUJ/FeP/"
Content-Disposition: inline
In-Reply-To: <47DE77F8-1EC3-44F6-AB70-2D7599A79FDC@gmx.de>
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


--Uk6QvtcwHUJ/FeP/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 03:40:01PM +0100, Heinrich Schuchardt wrote:
> Am 13. November 2024 14:32:57 MEZ schrieb Neil Armstrong <neil.armstrong@=
linaro.org>:
> >On 13/11/2024 05:22, Caleb Connolly wrote:
> >> Add a small utility for displaying some information about U-Boot and t=
he
> >> hardware it's running on in a similar fashion to the popular neofetch
> >> tool for Linux [1].
> >>=20
> >> While the output is meant to be useful, it should also be pleasing to
> >> look at and perhaps entertaining. The ufetch command aims to bring this
> >> to U-Boot, featuring a colorful ASCII art version of the U-Boot logo.
> >>=20
> >> [1]: https://en.wikipedia.org/wiki/Neofetch
> >>=20
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >> Ephemeral screenshot: https://0x0.st/XkQU.png
> >>=20
> >> Changes since v1:
> >>   * Rework storage info to be more dynamic
> >>   * use print_size() helper everywhere
> >>   * manually walk RAM banks to report memory size correctly
> >>   * minor formatting changes and fixes
> >>   * MAINTAINERS entry
> >>   * V1: https://lore.kernel.org/u-boot/20240808163153.2069650-1-caleb.=
connolly@linaro.org
> >> ---
> >>   MAINTAINERS  |   5 ++
> >>   cmd/Kconfig  |   7 ++
> >>   cmd/Makefile |   1 +
> >>   cmd/ufetch.c | 224 +++++++++++++++++++++++++++++++++++++++++++++++++=
++
> >>   4 files changed, 237 insertions(+)
> >>   create mode 100644 cmd/ufetch.c
> >>=20
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 38c714cf46a6..d1eb164ad590 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -1724,8 +1724,13 @@ M:	Heiko Schocher <hs@denx.de>
> >>   S:	Maintained
> >>   T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
> >>   F:	drivers/mtd/ubi/
> >>   +UFETCH
> >> +M:	Caleb Connolly <caleb.connolly@linaro.org>
> >> +S:	Maintained
> >> +F:	cmd/ufetch.c
> >> +
> >>   UFS
> >>   M:	Neil Armstrong <neil.armstrong@linaro.org>
> >>   M:	Bhupesh Sharma <bhupesh.linux@gmail.com>
> >>   M:	Neha Malcom Francis <n-francis@ti.com>
> >> diff --git a/cmd/Kconfig b/cmd/Kconfig
> >> index 4fba9fe67034..da736249a3cf 100644
> >> --- a/cmd/Kconfig
> >> +++ b/cmd/Kconfig
> >> @@ -175,8 +175,15 @@ config CMD_CPU
> >>   	  number of CPUs, type (e.g. manufacturer, architecture, product or
> >>   	  internal name) and clock frequency. Other information may be
> >>   	  available depending on the CPU driver.
> >>   +config CMD_UFETCH
> >> +	bool "U-Boot fetch"
> >> +	depends on BLK
> >> +	help
> >> +	  Fetch utility for U-Boot (akin to neofetch). Prints information
> >> +	  about U-Boot and the board it is running on in a pleasing format.
>=20
> The information is already available in other commands with greater detai=
l.
>=20
> What is your use case?

The use case was outlined in v1 and maybe missed in v2. This is a "toy"
utility, like 2048, to make it easier to show off things like "I just
made U-Boot work on this new platform". So yes, it's going to bloat the
code size, but it's also not going to be enabled in production (or
hopefully, defconfigs when submitted for new boards...).

[snip]
> >
> >Ephemeral screenshot: https://0x0.st/Xk2N.png

The point is to do something like that.

--=20
Tom

--Uk6QvtcwHUJ/FeP/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc0xEMACgkQFHw5/5Y0
tyxYUwv+I0xgpn3umOV7HovXQXW6tHdJg6AadtWuZAqS5PzL8k3u9+nxbELkEtUI
Kkzln+w5EojDLmyX0WzSscbFES4EahAvtjNo/nAvf6mjB+LDx/G6/LJ8CuxiJFKH
xrC9/ktm3fqgVY4uvcXk3pAAelbmm2Pk+jzzGaUZN/afjoiBO3kIBYlveHmYQIlb
3WQK123Ug38SlXNthfNMNoGQi1mCm/Cllw1rVMNWWtLR026sUn5g1rzaH4foEaMQ
ud+68Z2tKFl6VXO/9kV5xmnV1S1ZONcp+Q1EO0I4/E3skRyPz0Zv+DcL1r6Ve5+Z
5W1HH7tDIpiH9InEcdqfyBQjG5+NFPsU9qv6IrKv7887SJf2rJwCewFXkjKbldE2
FJpWM9llPsAkAJPe4R7Uydj7mfpXamt2O2kbruG4HI1RwK6K5IhrZ4tV/4O1jbAI
eRvg161eNrp+wam7Sb58pPEbL7/xul97NUcO2HCKrsYgmfvY0Ml7frZrOW/FZPPy
IKqLX4k/
=613M
-----END PGP SIGNATURE-----

--Uk6QvtcwHUJ/FeP/--
