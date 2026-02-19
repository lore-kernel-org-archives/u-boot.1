Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C16AE9A053
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 18:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FD1283CF2;
	Thu, 19 Feb 2026 19:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bU8DQ673";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20D2F83CF5; Thu, 19 Feb 2026 19:07:35 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC40C83CEE
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 19:07:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso1056503a34.0
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 10:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771524451; x=1772129251; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZuOXfqaSRnKKiF5IDfvN3TXIslT+ns37oPm9UpSdb64=;
 b=bU8DQ673iSr39zatXlpOwcFW+93R6X1eqsN7QosWBREKIgkwrpk7RX7KYJZhRA609c
 u0W1Q8uRoo3au7/DEtZ21bHnzO8fDXX4J62PYMfJY4UsMWBzHjQ5ZIb4D9D3/DrD0uJF
 r5caaDvhXJhvLSflS8PY+X6nYHOF2a4cw5uio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771524451; x=1772129251;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZuOXfqaSRnKKiF5IDfvN3TXIslT+ns37oPm9UpSdb64=;
 b=BvxaN27FpuSlrB1Ty/h/YL/7AUwPCE5TDDrLPhZ/w2fhAeLN/a8RFoWfx6VqB853Ax
 +bEWdn2ztvjnPq9YlFCDqT3geU6vmjNbS7kXUAQGFSNtJfHD8KmGANwgz5s1KIZYijVC
 v/hFsfa4ugQvv0Hit3o1m/jSvqis3EYhCMnBiU+weQ2L47jSSYYdgBumwg+b+yKWX2hv
 CVhTu3tQYgBuijuzdgXwSVvzwwKC/ztA2EAeXX8gVePi3bi4rb5bQ/DMMfAitt67xtIP
 4rvPJNdUyUiZuurehbO4ZkqKawfjeEx0lpgqBa+HGo6rLr+GZ7k2+nC2mH3JdcRR2GuP
 HiEQ==
X-Gm-Message-State: AOJu0YyhBa1GhrT35yTGQ6BcrZioxmmfrTGHm/jiGoc8m8N2GtVsL6gT
 V1PgZXh790xeWfKIv/OdjtcndpDzKTBg3tV/ikoDvbc2Y1JEGHruMxM+sybEYDan7HQ=
X-Gm-Gg: AZuq6aLJyuXqi/PuTeorcQ8bd5WfJRuF/3YEDHo0CJWU7ddGOl7i5JkId/yYTF2fPQJ
 RjgV7n+XGjk+bzF+nlELFPTThSqZOJ/HPr6/NZK5qfrpDYSqrDDHmjXhLHU7J1ehtvZ4fvxy5QX
 8PTO/H9E2rT6osBaCAm0hQILFTLKx8pMJUojxNVfyrszDB+SIOo+BEDyisTgdnEx09lhH5f6UQV
 oxJaW2pusqzjd/ztP5zBO/T8eKHBsiQJZ/xvh7eK7AfF0/dJ/y5TNI8uyoa4glMFCS9r3YN7oZj
 2+/Hf8LH/FNMxPg69CK6nKiHmO2+rn1n0mqCWdTavE/PiCijluzWqU1zKYqWVA76OBr39CZwjD6
 4z4rG0coKzwt6MtLoYWPoQvBpHnkKEJ/tKOEwo1EBx/ChrulsX6gHWOEKT9LtwbslUSazRIt8Gu
 VCYqiguullu9Kwf3dfMZ1A8uKY4LV5lzb8cWaMAYP0XLLH1YOmZob9GeapOJj3m7flRyEd1Q2bW
 S2cqVrA25uiANgF9+LXlg2GmFiJPYTQZqOtO+4jB+ZzNNw6lOT5a93teIWmKw==
X-Received: by 2002:a05:6830:4904:b0:7cf:ce25:e38d with SMTP id
 46e09a7af769-7d5128791c7mr2347223a34.24.1771524451582; 
 Thu, 19 Feb 2026 10:07:31 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76f98cesm20937815a34.22.2026.02.19.10.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 10:07:30 -0800 (PST)
Date: Thu, 19 Feb 2026 12:07:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <simon.glass@canonical.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH 8/8] video: support Rocktech RK050HR345-CT106A panel
Message-ID: <20260219180728.GO3233182@bill-the-cat>
References: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
 <20260219175130.2839234-9-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4pNRpcsfCRCHz4AD"
Content-Disposition: inline
In-Reply-To: <20260219175130.2839234-9-dario.binacchi@amarulasolutions.com>
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


--4pNRpcsfCRCHz4AD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 06:51:19PM +0100, Dario Binacchi wrote:

> Add support for the Rocktech RK050HR345-CT106A RGB panel. This model
> uses an Ilitek ILI9806E controller over the SPI bus for initialization
> and register configuration only.
>=20
> The driver is designed to be easily extensible to support other panels
> with different sequences and timings by providing a specific descriptor
> structure for each model.
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>=20
>  drivers/video/Kconfig           |   8 +
>  drivers/video/Makefile          |   1 +
>  drivers/video/ilitek-ili9806e.c | 354 ++++++++++++++++++++++++++++++++
>  3 files changed, 363 insertions(+)
>  create mode 100644 drivers/video/ilitek-ili9806e.c
>=20
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 08c9b0207884..c78d6540855a 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -552,6 +552,14 @@ config VIDEO_LCD_HIMAX_HX8394
>  	Say Y here if you want to enable support for Himax HX8394
>  	dsi 4dl panel.
> =20
> +config VIDEO_LCD_ILITEK_ILI9806E
> +	tristate "Ilitek ILI9806E-based panels"

"tristate" is wrong for U-Boot, it should be bool.

--=20
Tom

--4pNRpcsfCRCHz4AD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZdRWAAKCRAr4qD1Cr/k
ChXgAP9a1/+QK1xf0taN2huZCoIRq9/tt0Y5apz9VHVM/gqKLQEAtM1/aUkgzUMi
NK7ecRmO5P0j4GfMzzgXHlQ1EbzPzAw=
=TdT9
-----END PGP SIGNATURE-----

--4pNRpcsfCRCHz4AD--
