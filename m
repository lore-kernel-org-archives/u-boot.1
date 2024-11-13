Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44940D637A4
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 17:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCB1E8904A;
	Wed, 13 Nov 2024 18:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SGVuqnhc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B99B4891E3; Wed, 13 Nov 2024 18:47:16 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B66D88FFC
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 18:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5ee645cf763so2234093eaf.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 09:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731520032; x=1732124832; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Hzf65RUJxn6VmY+v9U38EZWRq/FfNy/7ktQcRO7d0u0=;
 b=SGVuqnhc9wHZT23wBd75FxKqZwPVyvGoXCQ1Niz8MxyXlZSI9CsH2+lzKKfUZ8Ug3a
 CrYD175nlcMAltl2CC5dfLHIs/hOM7gWNO2CxnidOUe09PoU+996fbtQx92OGdn9d90u
 k75rYMv5W8LY6YxB1FSaFCt2Sar5c3FEgg438=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731520032; x=1732124832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hzf65RUJxn6VmY+v9U38EZWRq/FfNy/7ktQcRO7d0u0=;
 b=cTHrZX+4WuS9G0z/rCI/pjojWb2LGxZCaoAr/0d1mzmzUaPLsXi8nStzR+BOHI/tAN
 o83p34BsPa6ArlKPReT4e9h8DesZV6kJRBi6yKd+G22cQwhw2v7TZyL8DtO5NUbNBpUg
 9HGp3uyQ+MsgXaNlEqZxa88YbOG4CuYUmqRzfIkCkvWUfOT0JsEYDbx5KCPe3tJ6zLxk
 1ojE21Dsj/iXq/Z948R3uQgh4YfaaMU09TR8eUolG5e28hpYuQ3LVCbuRuFtSXDKMN6W
 L+DkmXAJzXYC5Gd4tMA4CWiTwOECeS80vhoJmEha5JHlwb6mhC+1qF4afe53ceY6wxx8
 +nlQ==
X-Gm-Message-State: AOJu0Yy51hlaPCbOhJ+f6xTu2du+bPPxQG5jiHQspY40BeI44zDUt47Q
 ArQfm+8E5OSpwRcon3PisyUyuB3p7HG55IP0JW/OlDvJcDd0ULoojc7sFyb5ezI=
X-Google-Smtp-Source: AGHT+IGPrX44A4Rjlu0X9F0j7tNRLXdJ/B24Lejqm/mmUomH6vOTA/5DI1kYzMYgnXTJJDVLQ7vMsQ==
X-Received: by 2002:a05:6820:1805:b0:5eb:c72e:e29c with SMTP id
 006d021491bc7-5ee86a500a2mr5601431eaf.8.1731520032175; 
 Wed, 13 Nov 2024 09:47:12 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ee4970bf48sm3017821eaf.40.2024.11.13.09.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:47:11 -0800 (PST)
Date: Wed, 13 Nov 2024 11:47:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v5 1/8] bootstd: Avoid depending on BLK
Message-ID: <20241113174707.GR3600562@bill-the-cat>
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K5I97ihCXgeRAZsQ"
Content-Disposition: inline
In-Reply-To: <20241113150938.1534931-2-sjg@chromium.org>
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


--K5I97ihCXgeRAZsQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 08:09:31AM -0700, Simon Glass wrote:

> In principle bootstd can work without block devices, even if it does
> require driver model to be enabled in that case.
>=20
> The use of a 'depends on BLK' for BOOTSTD conflicts with the way 'BLK'
> is now defined, producing recursive errors through multiple different
> paths, one of which is this (with Linksprite_pcDuino3 and
> BOOTSTD_DEFAULTS enabled):
>=20
>   arch/arm/Kconfig:7:error: recursive dependency detected!
>   arch/arm/Kconfig:7: symbol ARM64 is selected by ARCH_UNIPHIER_V8_MULTI
>   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
>      part of choice <choice>
>   arch/arm/mach-uniphier/Kconfig:6: choice <choice> contains symbol
>      ARCH_UNIPHIER_V8_MULTI
>   arch/arm/mach-uniphier/Kconfig:17: symbol ARCH_UNIPHIER_V8_MULTI is
>      part of choice SPL
>   arch/arm/mach-stm32mp/Kconfig:3: symbol SPL depends on SUPPORT_SPL
>   common/spl/Kconfig:1: symbol SUPPORT_SPL is selected by ASPEED_AST2600
>   arch/arm/mach-aspeed/Kconfig:26: symbol ASPEED_AST2600 is part of
>      choice <choice>
>   arch/arm/mach-aspeed/Kconfig:12: choice <choice> contains symbol
>      ASPEED_AST2500
>   arch/arm/mach-aspeed/Kconfig:17: symbol ASPEED_AST2500 is part of
>      choice DM_RESET
>   arch/arm/mach-renesas/Kconfig.rcar3:197: symbol DM_RESET is selected
>      by CLK_RCAR_GEN3
>   drivers/clk/renesas/Kconfig:53: symbol CLK_RCAR_GEN3 depends on
>      CLK_RENESAS
>   drivers/clk/renesas/Kconfig:1: symbol CLK_RENESAS depends on CLK
>   drivers/clk/Kconfig:3: symbol CLK is selected by IMX8M_POWER_DOMAIN
>   drivers/power/domain/Kconfig:35: symbol IMX8M_POWER_DOMAIN depends on
>      POWER_DOMAIN
>   drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN is selected by
>      BCM6318_USBH_PHY
>   drivers/phy/Kconfig:83: symbol BCM6318_USBH_PHY depends on PHY
>   drivers/phy/Kconfig:4: symbol PHY is selected by USB_EHCI_MX7
>   drivers/usb/host/Kconfig:211: symbol USB_EHCI_MX7 depends on USB
>   drivers/usb/Kconfig:1: symbol USB is selected by BOOTSTD_DEFAULTS
>   boot/Kconfig:455: symbol BOOTSTD_DEFAULTS depends on BOOTSTD
>   boot/Kconfig:398: symbol BOOTSTD depends on BLK
>   drivers/block/Kconfig:1: symbol BLK is selected by PVBLOCK
>   drivers/xen/Kconfig:1: symbol PVBLOCK depends on XEN
>   Kconfig:176: symbol XEN depends on ARM64
>=20
> We don't want to revert the change to BLK, which has been in place for
> a year now. We don't want to select BLK in BOOTSTD since it should
> support booting without block devices. The only realistic option is to
> remove BOOTSTD's dependency on BLK.
>=20
> Disable standard boot on the one board which fails.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v3)
>=20
> Changes in v3:
> - Drop wip (work-in-progress) comment in commit
>=20
> Changes in v2:
> - Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
>=20
>  boot/Kconfig                                   | 2 +-
>  configs/gardena-smart-gateway-mt7688_defconfig | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 7dd30a030e3..b5433e88f10 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -393,7 +393,7 @@ config BOOT_DEFAULTS
>  menuconfig BOOTSTD
>  	bool "Standard boot"
>  	default y
> -	depends on DM && OF_CONTROL && BLK
> +	depends on DM && OF_CONTROL
>  	help
>  	  U-Boot supports a standard way of locating something to boot,
>  	  typically an Operating System such as Linux, provided by a distro such

This ends up being a massive size bloat on all of the boards which did
not use BOOTSTD before, and still can't (because there's no appropriate
methods). You need to not just disable it on the one board that fails
but on everything not currently enabling it, which now does enable it.

Or you need to better explain what's going on here, exactly and why
depending on BLK here is wrong, for what you're doing.

--=20
Tom

--K5I97ihCXgeRAZsQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc05hcACgkQFHw5/5Y0
tyzVPwv3ei/UeUsYaqkmTsXV6L6QnXtcLBfS5eGVR3MYWoIGFhHrAJOpK+kgVy4w
klBmlr6l9qzYr9NDfKYBr6ZusqNLohAIrHY7WsyGvN57yJb2FakryWFy3mTUhCwX
rnSFpjRc4xmz8jt4n868TTAgHJLpcrs080QcR0v6dHN7Fh8d6CQFEgaaVe7+M76/
OEDJlOfbPGm089SYWAEmMq6g9es99ZWRuGcy+KKs55xMbqzXpck6T5aSKz2uaKky
Wx6uCfVJlWeLwXskDjsPGFEg6KX3qH63EG5ewfoD/8H+L4cS+D05kG7InkAThQAq
YPNwrvKM3ASkWO3FcwSyH6Vwv+SG0nWi8kk3kBDHV1EeHKgXbktLZYPM+wPWj6Yt
olcLcL2a9nh5Gahez93LaH34xXQ6Dr/4J5P863rrxWZbqig4guJR5GtQ5djnhCUr
aJSp7FSnfwi2EPkbgZJsH7czN9XN1vOHaluvkkRTS0tfDaIfy35HeLPIszYGjjPk
yR4Yv0A=
=rUfd
-----END PGP SIGNATURE-----

--K5I97ihCXgeRAZsQ--
