Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1462C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 20:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D2F1405BE;
	Mon, 20 Jul 2026 20:45:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AiH-fiCmZmFd; Mon, 20 Jul 2026 20:45:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 366CF405C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784580338;
	bh=q8PDVq2pddiHMmIKq8G+xt1Ch+iqvXwdz/K2VhMIqso=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=CgAlgx1cgu10SI9qEofLJEg5+ANx716a66XNDrIe82QdVWSGjyBbzMg632I5ugh3q
	 8JYQZBfr04EJsNrUjEmAErHPhehjDSkOnFPVxfiGpfkYkQRsQwHVxnsDrZ6t06xZ+g
	 s8d4FPSxILHX4vJi8rJNHDOt2RehHfE+59PYYcv8U6o5xTeQOH2OPcdsSVfx9yYO9E
	 I+bSr00cu8E1E+yK+aa9zDv3fcIpW3wzHMj5RkEL9Smx7Hs19wgCogobipCYGUR777
	 ZlKm8Is5S++gcIbpaBddCDD+iuK7uaXb7BowAjPy/5sJu1bUnbB5c35yalmvyxWk4P
	 h30m2593tzinw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 366CF405C2;
	Mon, 20 Jul 2026 20:45:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E98B224
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3BB4580AEF
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:45:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hKdy5iRdzDIA for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 20:45:36 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EDB5680AE6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDB5680AE6
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EDB5680AE6
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:45:35 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AA18842FC; Mon, 20 Jul 2026 22:45:34 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4F3B82991
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 22:45:31 +0200 (CEST)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7eb545db3afso4350878a34.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 13:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784580330; x=1785185130;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q8PDVq2pddiHMmIKq8G+xt1Ch+iqvXwdz/K2VhMIqso=;
 b=mNKNIeyYDDWtIegpkd0Gaa76dmvbYbfX8c9ICB7v3wjD8rGkxO+VYJYAFNyCys+b3B
 HowARNdxcft768iDmO4kfOen/GNEB/aALLoWG6T1kgdFVlQ+hMQo1SKhh89knW0psVWz
 W1KLZChLT42K12r55lRX0eDPll72106ceuBUHFHM6O2ht7No8xZnC9W8N3vcWdq6VpyK
 peigBmYHkpgfNVjyjsndC7ZcLRxIRx9KNzFjhP8AQpDr+8gEjZ9KUukPQJBBi0gDt0Mh
 gYW5E/hKi0++Rq26EZdSceyL8HlAs4jrM1ZlxofSUoNs35NwRu++aoVudXr87GJW6tQ2
 SNQA==
X-Gm-Message-State: AOJu0YzDcesgg9RkdP9W5cGOHNKfkCzM+vJ9ktjMA0A6f9zmpyPMGiLc
 hZmeNJmKJRxpj2ffE0qOR1DJgscIHf0G5GSXqVYDGeTjoVSuRYmps6JNFxSLFwO9dCI=
X-Gm-Gg: AfdE7cnZgTtprv0I6fVDnHAW1b94ea4YAqwHZf6QHMRBT5D7XUNG9Bv3Zn5/mcbSY78
 cm8Qx572r+9Hz0m7QBKWSMc9ZNWIOv+OPlN/cFJUHzTh9YD7CXgGX1woaMuQJPVWJVdU7zxncc2
 qRLy0a+gWZ3c/fDA3IidShtN0kvLLklVtoO5CdcciWu8DXQXRbf1i651aORsCckeZTGd3pA+zx+
 htxZMLN/A3dlFfRgCRjhKIRAbsCX9iO84qaG8JCUhEajCAULfnx6aqLCrmifT5HR1EVxMmt5kR9
 2+KirCF42hbiny0dQh/nB0FBMXbWk7unxbPFeH/roedMnMmQIWE1jwLnf1caa6xhWe1aZJLOSmA
 xc8EaV7X7FBTcS4f/vzz959wEJhAyJLFIphIUnK+uKKHKOvI2eyBwsK5eZBCW5T5IgRuufr8x4G
 VCDBs1LMgOyO1p0w+aej97FIazjN3Ygo+8uWLrRLwRpYe41h3hw6OpIP0sn3ZKcVKlE3PuWEF8a
 yLGmLO6l0UZ9iLRDGvlhHZxwg4=
X-Received: by 2002:a05:6820:4cc1:b0:6a3:e177:d939 with SMTP id
 006d021491bc7-6a536ab9552mr8025468eaf.52.1784580330643; 
 Mon, 20 Jul 2026 13:45:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568e0bddefsm9577813fac.4.2026.07.20.13.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 13:45:29 -0700 (PDT)
Date: Mon, 20 Jul 2026 14:45:27 -0600
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v2] mmc: sunxi: support DM MMC in SPL
Message-ID: <20260720204527.GJ749385@bill-the-cat>
References: <20260717210148.3391816-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nDxbu2MoBHTuReNH"
Content-Disposition: inline
In-Reply-To: <20260717210148.3391816-1-james.hilliard1@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784580330; x=1785185130; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q8PDVq2pddiHMmIKq8G+xt1Ch+iqvXwdz/K2VhMIqso=;
 b=tHN84KTR+/KhvVghor0Typ4ZYxzkyKSf52fjbgKro9WW1796F6voi+3PhIcTGSUEr9
 dLid0P3sKinPK3eDaT85thS9yoK2tMANUcOO4+zPQcZB9nkyRmKXjQw0dtOZRJ+Vd3jK
 YS9b+wsuVk4GqjmK567Eif9I1AQbozxCt6W1U=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=tHN84KTR
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tHN84KTR";
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--nDxbu2MoBHTuReNH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 03:01:41PM -0600, James Hilliard wrote:

> sunxi SPL normally uses the legacy MMC interface while U-Boot proper
> uses the driver-model path. When SPL_DM_MMC is enabled, the existing
> DM probe depends on the devicetree, clock and pinctrl providers being
> available in SPL.
>=20
> Select the required SPL clock, OF control, pinctrl and pin configuration
> support from MMC_SUNXI. Retain the main CCU and PIO nodes when their SPL
> frameworks are enabled, and retain the MMC0 controller and pin
> configuration when SPL_DM_MMC is enabled.
>=20
> This reuses the existing DM path unchanged and leaves the legacy SPL path
> untouched when SPL_DM_MMC is disabled.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>   - select the required SPL dependencies in Kconfig  (suggested by Tom)
>   - retain the common CCU, PIO, MMC0 and pin configuration nodes in the
>     SPL devicetree
>   - drop the new preprocessor fallback paths  (suggested by Andre)
>   - reuse the existing DM MMC probe unchanged
>   - drop the no-devicetree platform-data path and controller reinit hook
>   - reduce the driver change to four Kconfig selections
>   - validate an H616 SD boot through SPL FIT verification and U-Boot prop=
er
> ---
>  arch/arm/dts/sunxi-u-boot.dtsi | 22 ++++++++++++++++++++++
>  drivers/mmc/Kconfig            |  4 ++++
>  2 files changed, 26 insertions(+)
>=20
> diff --git a/arch/arm/dts/sunxi-u-boot.dtsi b/arch/arm/dts/sunxi-u-boot.d=
tsi
> index e1a9a7f5d4c..fdd8c78c8bf 100644
> --- a/arch/arm/dts/sunxi-u-boot.dtsi
> +++ b/arch/arm/dts/sunxi-u-boot.dtsi
> @@ -19,6 +19,28 @@
>  	};
>  };
> =20
> +#ifdef CONFIG_SPL_CLK
> +&ccu {
> +	bootph-pre-ram;
> +};
> +#endif
> +
> +#ifdef CONFIG_SPL_PINCTRL
> +&pio {
> +	bootph-pre-ram;
> +};
> +#endif
> +
> +#ifdef CONFIG_SPL_DM_MMC
> +&mmc0_pins {
> +	bootph-pre-ram;
> +};
> +
> +&mmc0 {
> +	bootph-pre-ram;
> +};
> +#endif
> +
>  /* Let U-Boot be the firmware layer that controls the watchdog. */
>  #ifdef CONFIG_MACH_SUN8I_R528
>  &wdt {
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index 6c513328de2..40b6e6882aa 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -806,6 +806,10 @@ config MMC_SUNXI
>  	bool "Allwinner sunxi SD/MMC Host Controller support"
>  	depends on ARCH_SUNXI
>  	default y
> +	select SPL_CLK if SPL_DM_MMC
> +	select SPL_OF_CONTROL if SPL_DM_MMC
> +	select SPL_PINCONF if SPL_DM_MMC
> +	select SPL_PINCTRL if SPL_DM_MMC
>  	help
>  	  This selects support for the SD/MMC Host Controller on
>  	  Allwinner sunxi SoCs.

This seems like a much more reasonable path, thank you.

--=20
Tom

--nDxbu2MoBHTuReNH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal6I4wAKCRAr4qD1Cr/k
CiifAQCw/5Qv4v9P11hUaFNG1hcvzBuQ69LUYzuqB6+D326brgD/aJqIwj+GUKz4
pfbi4/9L87YSIFhLTLc+Fq1JbB2wsA4=
=vDLU
-----END PGP SIGNATURE-----

--nDxbu2MoBHTuReNH--
