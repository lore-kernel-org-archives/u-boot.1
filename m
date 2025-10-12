Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DB0CCD187
	for <u-boot@archiver.kernel.org>; Sun, 12 Oct 2025 19:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0444C83816;
	Sun, 12 Oct 2025 21:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="grONMubj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 599978381D; Sun, 12 Oct 2025 21:05:41 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3442983775
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 21:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3544c64380eso4616860fac.3
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 12:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760295938; x=1760900738; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8ifVMlCyEHslrMdGPU42WIthSKe3m5rAPOvY4mPU0tY=;
 b=grONMubjcpkTUj3MkJKHlYSIKJ2uGjgODx7/+WMCbdIao8RDKO+uyiIzlLn05+KPsh
 YcD/2raPn3TWPKd/hruRkLwMXtV5yULFT9KgHgOojoaeVqB22Cdu79wwdJkXn//MYkDJ
 DYY8i4QcAD+7c3UaqFCSezS1KinFGLCJ8CcIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760295938; x=1760900738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ifVMlCyEHslrMdGPU42WIthSKe3m5rAPOvY4mPU0tY=;
 b=NmAplqoagnMkn/mAdWiyk8Hl1XasCetL4dukQDZVbIi6ERbYhGsEELTJBmaLjFOvw3
 vI38r9gdOm08XQO9JbfLv+A/SIKf5baM7Is4EVcgXc+RgM1TdFkSUl7rXOBWuI7K/dGi
 8unExGTQhPllg6fATCYurgjjc2ATGRlKSK3G8lw07hz4LXZZVpL2rBLLButGzHIbHoxm
 Da5LLVBIblumZDY1g9Ti9ESDqRN8cyIbdv86iVRWUptI1xMyxf3SFHkHE1LNhFNpoqLo
 O0QRp5j+Q0aKLpBy8HJLMeCVfoqa3BkZUnvNW1ePbpUV3U/FT1NEOGuChCZC5HYVTFoJ
 L78A==
X-Gm-Message-State: AOJu0YzqUMickYPcQSEiGuqQEKGcJ1if5KBgxfFXYGa/JausHMmr2lc7
 wdv/xBE6OF/s64YTiEGurMipiFAdb6msqTXSuqcdUrzCmdnCo8MXAupbnfuG5v+NIhY=
X-Gm-Gg: ASbGncvTj4FJHvux7Qobyi3ys+7y1K7MJ458HnVS9ucTTp1za3q8fdQzd/NxKcwK7IE
 9pp0hGIagORKTyHKgnDlLtlP+f0jfbO9x3bNVxbEWuArunF/avxH39JP+8otgeL2DsIKA4jv+Af
 j11t8j61IC8oR6/lwA2G6Mc9zv2BSWswO6SWqH/l371qbiSsxCgL8jpyWsmf/iSl6eUISjh4Ja8
 fB8bj+Fwf9cboqtlT7h0+nrWeiisQ9ZuXrbUCN8PrE6YIEJdsMGtoXP22D1BatmCHkdqENmkJYp
 AHiKtJM0OcEXpubTuisQ0ktL9WclpwAuusfugwtkLYmFlKrrMGcejKtUKPtvteqCuxc+8sWjyVq
 tO703vZGshrwHcxdfipbnDHCHf4ooFySYnFRS8zjHncJ48+4pGiJ1PF+akMNw1V9IjmKU0828qW
 bjPUVGCQMfPXDS0fA=
X-Google-Smtp-Source: AGHT+IHhBmo2K0ZVjCINm6O0XDom6ZrHhpHRYCywhjUAink0xpm7WCYxr7iKNlRcx6F8ZR+yf6mP5A==
X-Received: by 2002:a05:6870:d611:b0:332:3a47:9a05 with SMTP id
 586e51a60fabf-3c0fa07d954mr8473274fac.26.1760295937912; 
 Sun, 12 Oct 2025 12:05:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8e80a38sm2847167fac.15.2025.10.12.12.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Oct 2025 12:05:36 -0700 (PDT)
Date: Sun, 12 Oct 2025 13:05:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tien.fong.chee@altera.com
Subject: Re: [PATCH] gpio: dwapb: Enable SPL support for DWAPB GPIO driver
Message-ID: <20251012190534.GA6113@bill-the-cat>
References: <20251012185558.23808-1-tanmay.kathpalia@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FJoR+KHoRU2n9Zk+"
Content-Disposition: inline
In-Reply-To: <20251012185558.23808-1-tanmay.kathpalia@altera.com>
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


--FJoR+KHoRU2n9Zk+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 11:55:58AM -0700, Tanmay Kathpalia wrote:
> Add SPL_DWAPB_GPIO configuration option to enable the Designware APB
> GPIO driver in SPL builds.
>=20
> Changes:
> - Add SPL_DWAPB_GPIO Kconfig option with SPL_DM_GPIO dependency
> - Update Makefile to use CONFIG_$(XPL_)DWAPB_GPIO pattern for
>   conditional compilation in both SPL and main U-Boot builds
>=20
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>  drivers/gpio/Kconfig  | 8 ++++++++
>  drivers/gpio/Makefile | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index db077e472a8..00bf974c0f3 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -138,6 +138,14 @@ config DWAPB_GPIO
>  	help
>  	  Support for the Designware APB GPIO driver.
> =20
> +config SPL_DWAPB_GPIO
> +	bool "DWAPB GPIO driver in SPL"
> +	depends on SPL_DM_GPIO
> +	help
> +	  Support for the Designware APB GPIO driver in SPL.
> +
> +	  If unsure, say N.
> +
>  config AT91_GPIO
>  	bool "AT91 PIO GPIO driver"
>  	depends on ARCH_AT91
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 73c94329e36..da2c02b32da 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -4,12 +4,12 @@
>  # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
> =20
>  ifndef CONFIG_XPL_BUILD
> -obj-$(CONFIG_DWAPB_GPIO)	+=3D dwapb_gpio.o
>  obj-$(CONFIG_AXP_GPIO)		+=3D axp_gpio.o
>  obj-$(CONFIG_DM_74X164)		+=3D 74x164_gpio.o
>  endif
>  obj-$(CONFIG_$(PHASE_)DM_GPIO) +=3D gpio-uclass.o
> =20
> +obj-$(CONFIG_$(XPL_)DWAPB_GPIO)		+=3D dwapb_gpio.o

This should be PHASE_ not XPL_.

--=20
Tom

--FJoR+KHoRU2n9Zk+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOv7+wAKCRAr4qD1Cr/k
Ci6KAQDb8UwxThFf0TVAY6LY9O1GXESS6hsf0553EroI/FDIMQD+JhrbYbIqLe6h
vy80FCQabsmYGamwCCagHmpLt2qrVAc=
=7GXm
-----END PGP SIGNATURE-----

--FJoR+KHoRU2n9Zk+--
