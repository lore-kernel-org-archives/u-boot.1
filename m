Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110A6C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 14:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FEF083095;
	Thu, 22 May 2025 16:40:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E4VNkOD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83107830B4; Thu, 22 May 2025 16:40:04 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4492D83082
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 16:40:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72a4793d4e2so5770582a34.2
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747924801; x=1748529601; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fc+ofZqrwaCUSqFojyyur41haHLG7SjKdjwcxQELQgI=;
 b=E4VNkOD1pH5mKwaDmmIhh7GvwEHElm2LX/dMW4HGMNOdyvkEM2Tgx/FYTDKJyrViBW
 qNABpJNTInmqqwE/szWO6bed1aRo7XIY+YGxxOrohS5ZL0ByY3vq9aiA0nzswAv3dsU0
 48te8eT1Uxj+cXDw9Flxwm0wW5W3XuzPGwhU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747924801; x=1748529601;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fc+ofZqrwaCUSqFojyyur41haHLG7SjKdjwcxQELQgI=;
 b=nB/Bt0Zl5nvPmyWhTmOjhQkPI3zYD8FOKMaaXlS2oohq2WZXlpILwgln8mCR6CrEv5
 DGcCXxgAx5zFpK7oS9XTqFiksKIleGadrHN/EPJ4vySGnwAjHwvk+29M8BB7DUo+zO/M
 03zwWEjz5rwhYJCT9U1Ll9zHQXTHB3qCS4tDD2o2bd0snnfKsO9jiHWORCmNfBVvPllG
 vFqiuqfzdXYGqmyq/lX8JFV6gtSP+1+TyH7hvFdyVOyUgBHj4237gNwstzSSxcdJpOhk
 v2rZSfYnStylp21LbCMn8Aow6WvqyueADZ2yLo0cOOn5rNZsBbcuVMaPw8APZT1HJ/Wa
 WLeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCSWYuBWJDiPmO5sR+T4o17VUey+utkuxoKFTK8e/p93E+JisL9mcS573HCT+fOd9W76kSzY8=@lists.denx.de
X-Gm-Message-State: AOJu0YwtsAZRHr6dZgl3K5xoAM5oyHIUEhmiaT0FYe6NhB0ckfMY76jw
 XaFfanQZyG66LxXVzZrRJKcx1YdrpwKWf6eMYcU6kKzEPS97poowjD1oW125o7ZMwEA=
X-Gm-Gg: ASbGncs2fcjU92Z5rVpkyFJiAPiYQiAEKtzKyXqp54Wy/rabrxTGT112ia1QL4WJd0x
 iZhQNYx8J1WEO+f1WW4UkdQKcJ/ob2JtqNdW9/mUwlcpEYhFA41uM9qeKX9LVBeGDFU2AIONCvm
 5hSEITFAtIRQz6xbAsV/t3h+i4O4PtDGPVgiKwTww4pyM3aBOwO5rzWPnH1EMeng7aiKBcIXgZQ
 peeEIuL7PpGlugDIT/xaD+QPB1oVm+BPcOmKisJqCOVX/fakze2FDqpTW5OJp3XsOkD0YxZ4mlt
 fFHr/ykSyv98Yv5aw4SxCPYaGPgU/nwp1l2G0X1Rb+MF6TH5hCi9xTW67+baTVQ6B9jWYK0Y3KV
 FLfyDq3Iy6FLW
X-Google-Smtp-Source: AGHT+IGkeVTeZ7YO63/eENKSzJ5lCqnsjyGo6gmRFxAcp0lKOPovZwrd1WHTpcjGn9P5P58H31sMiQ==
X-Received: by 2002:a05:6830:3984:b0:72b:8aec:fbd4 with SMTP id
 46e09a7af769-734f6ac5737mr17654518a34.3.1747924800945; 
 Thu, 22 May 2025 07:40:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6a9a7adsm2506520a34.30.2025.05.22.07.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 07:39:59 -0700 (PDT)
Date: Thu, 22 May 2025 08:39:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Dmitrii Merkurev <dimorinny@google.com>
Subject: Re: [PATCH RFT v4 3/3] fastboot: integrate block flashing back-end
Message-ID: <20250522143958.GJ100073@bill-the-cat>
References: <20250522-topic-fastboot-blk-v4-0-af7f7f30564d@linaro.org>
 <20250522-topic-fastboot-blk-v4-3-af7f7f30564d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hcFQcPIs1DlkJ50l"
Content-Disposition: inline
In-Reply-To: <20250522-topic-fastboot-blk-v4-3-af7f7f30564d@linaro.org>
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


--hcFQcPIs1DlkJ50l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 02:37:07PM +0200, Neil Armstrong wrote:

> From: Dmitrii Merkurev <dimorinny@google.com>
>=20
> 1. Get partition info/size
> 2. Erase partition
> 3. Flash partition
> 4. BCB
>=20
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/fastboot/Kconfig      | 29 +++++++++++++++++++++++++++++
>  drivers/fastboot/Makefile     |  1 +
>  drivers/fastboot/fb_command.c |  8 ++++++++
>  drivers/fastboot/fb_common.c  | 22 ++++++++++++++++++----
>  drivers/fastboot/fb_getvar.c  |  8 +++++++-
>  5 files changed, 63 insertions(+), 5 deletions(-)

I know this was posted before I replied with more feedback moments ago.

[snip]
> @@ -193,6 +197,31 @@ config FASTBOOT_MMC_USER_NAME
>  	  defined here.
>  	  The default target name for erasing EMMC_USER is "mmc0".
> =20
> +config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
> +	string "Define FASTBOOT block interface name"
> +	depends on FASTBOOT_FLASH_BLOCK
> +	default ""
> +	help
> +	  The fastboot "flash" and "erase" commands support operations
> +	  on any Block device, this should specify the block device name
> +	  like ide, scsi, usb, sata, nvme, virtio, blkmap, mtd...
> +	  The mmc block device type can be used but most of the features
> +	  available in the FASTBOOT_MMC will be missing.
> +	  Consider using FASTBOOT_MMC on a MMC block device until all
> +	  features are migrated.

A default like "" in order to un-stick configs that are now here and
enabling the option is wrong. If we're enabling new functionality for
platforms, it needs to be configured correctly. This leads to building
code on platforms that won't be used on the platform so we've likely
added run-time bloat for no benefit.

> +config FASTBOOT_FLASH_BLOCK_DEVICE_ID
> +	int "Define FASTBOOT block device identifier"
> +	depends on FASTBOOT_FLASH_BLOCK
> +	default 0
> +	help
> +	  The fastboot "flash" and "erase" commands support operations
> +	  on any Block device, this should specify the block device
> +	  identifier on the system, as a number.
> +          The device identifier should be 0 for first device on the
> +	  interface type specified in FLASH_BLOCK_INTERFACE_NAME config,
> +	  1 the second, etc...

This help should be one paragraph and note something along the lines of:
- Device identifiers are numbered starting from 0.
- The most common case is to use the first controller.

And then yes, "default 0" is fine here because it is a reasonable
default when configuring the system to use the functionality.

--=20
Tom

--hcFQcPIs1DlkJ50l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgvNz0ACgkQFHw5/5Y0
tyxyhgwAtc+scWoUQQHKD5F54GALpOgSJh2Vu1PyjDCxhvc3JgkJ2UsE83NjSuVw
QIkI0tLio6cBbUTKPV/WdX0/kyoBCq4WM9zQBpd7wnKT4PrPbgGj6FtFzchTL7qX
Y5s/X135Ri5Ens+SlmALIAyx/apUo3RE0oyUxtxt0NX60RgNoqd6Ax2yGUhWpMI0
qaXCwJO7Iy9LYJE6KsrBnHJ+VvihzEpIwZX2ir2pa2eaMI+0fsTs4LAkyTJRrv4J
xwH46oBSaJ0fUgUxZhdcYpTQQ2fMKJVRUvrY1jjZYjpcxvMqxtODt0xjhjJ/e0hp
hWkd4iXj8f7SnKoxQmz54jLONzo7Tq1ibxYqZI1P2X/2XDYk5+YOocjgLhxupRBH
L0l/qfxT7W2ZNjnbge/6LIx+Tr+eADwYxgoD3p2Czo4aSfQdrCBOEW6SukgT7omp
ZyT8vYyOf57oyx+hz4qboFyj+GqPpTNJRFXlUIABbBW/7crH07vNaOki+8B51xpL
EEiooc54
=cJIA
-----END PGP SIGNATURE-----

--hcFQcPIs1DlkJ50l--
