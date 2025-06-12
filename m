Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7454BC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 17:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91CF782B97;
	Thu, 12 Jun 2025 19:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RS/I11/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFA1382B97; Thu, 12 Jun 2025 19:13:44 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 775CD82B70
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 19:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-40905ae04e4so413889b6e.0
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 10:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749748421; x=1750353221; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rcSRF+9EayXkw5Qrb7Nz94QKxS+nnVdI3vXBMm9+Y3g=;
 b=RS/I11/Rqojw7wd15XnJNyisvv0eFCeLfmBLWpjcFBUeo0z9lXAIOQLN5ESIOHXv/b
 wYSXJvCNva2xy3f8GsvJtlQ1Y7lJcl1Mfj1iKX6EyF2ozCawFlW/F9Xu5p5MXctSnO0O
 bvxi9tMFhTdWPbTKKPZ8ax1INo0nlGzZJQzsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749748421; x=1750353221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcSRF+9EayXkw5Qrb7Nz94QKxS+nnVdI3vXBMm9+Y3g=;
 b=FV5GsiWj8AebkVO+e8B+RW83zLVDkpLjw0TqXWqY8uBPXDyOwbXcCjmBgsZU1xqTEc
 E/CEgQ/36jmr9QHHktAnD0E+8oSOkielhLZlMgyzgL50LNFkyocV4R+68AtewWWX9Zbi
 oB2LlnbkjhXWxU5tQxwogJxyV3WWWlCKG7gGsaNSD0ZYl1YRGP4+ox9cICByOm9WEL81
 8iBZRAbXkHgL069PcIJZfrMnY0g2Q3OTYFvmrMj/zuvcS4ffPVDdgnXVtqh26npsMrvk
 eSTRZKPK0k5jMKQsTe6XPEEo4FA8b0sssHzX22eRtemj+DtHEMHFexFBgXMsq4B0oGeM
 wWuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWJlKwtWrXTAg8J/euSjjEwIz0xEoYGY2olyU/IWh/G3iqj6+V1svVl5GqykinjWNuLuGooFI=@lists.denx.de
X-Gm-Message-State: AOJu0YyTxN9wWD/LNlLqGM3OWDpflN0nk2hPkFKrHj0KI/VOCz/n+Fc3
 Q5HX914qvxSLib64ipUDxl8IXZ2B3gCUP5nNsUe3aDvuXQD3OnSKLGDzLe7AMVq6LMM=
X-Gm-Gg: ASbGncuyHaS2rUn3c0cMDkaUklvmIQciYjMiLPpKn68s2et5n+VAo4YMVpLkeS2dGHP
 l2fNTnWE9mP7WvkgmwVFwzWIwfqaLfEWUrIEMUZsg3e93gLz5PzXFvVHYqW2XZgGOp3u7vbRh47
 fIarGLb27lf4quBvm6bgFa0ghZC0WR+ymUU359rZ3MTfDvXYylrL/TmXNYRiJpm2F4SG+Cdgruc
 GrQZywfeuzfS3Gag0XQGNscsgKBAsGIN51Kd2XriuAGn11p1idgrhybqwsKL+xDb3X3aw0e515w
 Vm/SZfc7cAfP+tTc6QqvHBmr6//F+CmGW78D6UKf4pLQBUV4pVm/uII5q39rE5V+A6L/tLFId2D
 jyIHXDWNt3E499QhmOyixM1o=
X-Google-Smtp-Source: AGHT+IH2EnJRO9D82eHl3qpaVV1eRbd6foar5A7XNhHSUfyUGBUroVQcGuGu/6rc1uptzfZWDm+dNQ==
X-Received: by 2002:a05:6808:4485:b0:3f8:b73b:682b with SMTP id
 5614622812f47-40a71d949cbmr79047b6e.7.1749748421185; 
 Thu, 12 Jun 2025 10:13:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a6832ae46sm365697b6e.49.2025.06.12.10.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 10:13:40 -0700 (PDT)
Date: Thu, 12 Jun 2025 11:13:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
Cc: Oliver.Gaskell@analog.com, peng.fan@nxp.com, malysagreg@gmail.com,
 nathan.morrison@timesys.com, twoerner@gmail.com, sjg@chromium.org,
 contact@paulk.fr, marex@denx.de, anshuld@ti.com,
 dario.binacchi@amarulasolutions.com, jerome.forissier@linaro.org,
 michael@amarulasolutions.com, a-dutta@ti.com,
 kever.yang@rock-chips.com, jonas@kwiboo.se, u-boot@lists.denx.de,
 danishanwar@ti.com, s-vadapalli@ti.com, srk@ti.com
Subject: Re: [PATCH] spl: Add support for Device Firmware Upgrade (DFU) over
 PCIe
Message-ID: <20250612171337.GP1382132@bill-the-cat>
References: <20250612084910.3457060-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ClED9Zey6BfV7o2p"
Content-Disposition: inline
In-Reply-To: <20250612084910.3457060-1-h-salunke@ti.com>
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


--ClED9Zey6BfV7o2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 02:19:10PM +0530, Hrushikesh Salunke wrote:

> Introduce support for Device Firmware Upgrade (DFU) over PCIe in
> U-Boot. Traditionally, the DFU protocol is used over USB, where a
> device enters DFU mode and allows a host to upload firmware or binary
> images directly via the USB interface. This is a widely adopted and
> convenient method for updating firmware.

Interesting, glad to see this overall.

> @@ -1328,6 +1336,59 @@ config SPL_RAM_DEVICE
>  	  be already in memory when SPL takes over, e.g. loaded by the boot
>  	  ROM.
> =20
> +config SPL_PCI_DFU
> +	bool "PCIe boot support"

Needs to depend on SPL_PCI_ENDPOINT

> +	help
> +		This config enables support to download bootloaders over PCIe
> +		when device is acting as an PCI endpoint.

Correct the spacing.

> +config PCI_DFU_SPL_LOAD_FIT_ADDRESS
> +	hex "Address to load FIT image when booting via DFU over PCIe"
> +	default 0x00

No default, and then for the rest of these options put it under if
SPL_PCI_DFU ... endif please.

> +config PCI_DFU_VENDOR_ID
> +	hex "PCI Vendor ID for PCI endpoint"
> +	default 0xffff
> +	help
> +		PCI Vendor ID for endpoint device for DFU over PCIe. This should
> +		be set to your assigned 16-bit PCI Vendor ID.
> +
> +config PCI_DFU_DEVICE_ID
> +	hex "PCI Vendor ID for PCI endpoint"
> +	default 0xffff
> +	help
> +		A 16-bit PCI Vendor ID for endpoint device for DFU over PCIe.

No defaults here.

> +config PCI_DFU_BOOT_PHASE
> +	string "Current boot phase for PCI DFU boot"
> +	default "none"

Nor here.

> diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
> index 71b7a8374bb..5bb94d6b972 100644
> --- a/common/spl/spl_ram.c
> +++ b/common/spl/spl_ram.c
> @@ -27,6 +27,9 @@ static ulong spl_ram_load_read(struct spl_load_info *lo=
ad, ulong sector,
>  	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
>  		addr =3D IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
>  				      CONFIG_SPL_LOAD_FIT_ADDRESS);
> +
> +		if (spl_boot_device() =3D=3D BOOT_DEVICE_PCIE)
> +			addr =3D CONFIG_PCI_DFU_SPL_LOAD_FIT_ADDRESS;

Probably need an IS_ENABLED(..) here first? And possibly a few other
places too.

--=20
Tom

--ClED9Zey6BfV7o2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhLCr4ACgkQFHw5/5Y0
tyz9tAv/e5mIr6bBQKNcaH6NLAwMRocmrfLK/kMoFDk0oWwh7yTp3qd1oYU+TWGC
iSdhsdICcXzc4lnbJkNqfoBCEDSM0QCaS49OFUqy4Z58V+zhrb2PHiCRsH6nKGrt
x7pyxG62jjRHSAhLLNeFnkRePn1995jdCOibawhoY+CkOe8+y3XZEDihnKio/wTb
sPRWxCdGetyMW/23ntetBtJ3IQYKKIrYIQ6TqRI5uYM/14vSO30KWXulTOg3e/6L
OMdp9eLyofYSw+LiEGz/j3pSF0xaAtciBuQ2alGKewngajl/TYQairkvjadQBSzs
wXYZ4K3xsR+U64SXP9Y3nwcb0ccaGm8YKzKPNK3gZmxCAwFwwTEJQQrgbU3zBIaQ
cKllBmKeyrgM25f3i9x9k7bc1d8Hjz+hGMevPcKJ9+ip9VzT+LGIprYNSVymEDvS
CGNfwXgNWE+yQ7nGS26Ca4Tad50+PMixhvvoaIBGDxcCe9cmWw8Hg1PbzAf4HFZ4
Hrd2lbQd
=LULr
-----END PGP SIGNATURE-----

--ClED9Zey6BfV7o2p--
