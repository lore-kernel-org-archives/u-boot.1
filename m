Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8BEC2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 18:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2EFE88405;
	Wed,  3 Jul 2024 20:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e1dOSvGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBAF988261; Wed,  3 Jul 2024 20:04:02 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB92788851
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 20:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-24c9f6338a4so2994944fac.1
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 11:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720029838; x=1720634638; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIJbNm+5hnoE6Y00TNwrJUGWNIcHqLSMygJWHih1xrk=;
 b=e1dOSvGrL16ypkTGvzRsPhV6zR4s/B/k5Uq7cWFJkIQXEoskJAlT0phypAg1mzpb2+
 r6R9H8jfjC3bjuO9rCBv50u6QW0fyBl97EkjuS8LIDynJyBi1yjE6XEtBmv4kn7XjnYm
 rrAKVACelWmw/USqZpfuO7F12Wax8FfCuanO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720029838; x=1720634638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIJbNm+5hnoE6Y00TNwrJUGWNIcHqLSMygJWHih1xrk=;
 b=h0DPDOTvIL1NMt0NUQr7Dyd1KZgAZR6mmJitMJ6WjXNIWzDu8A2LygfofQv+vRb8wq
 Jy2mBjlMMmQIeYBjsDXXXLM6xERN5XBiResNhzfdY4AGhp2p8EME3KpcX9kCp6VHTO0n
 vX0RGYdeeAELgdLXdHLO5eS/M0lFf1uk2VemoV3sTz0jRrDcnCYbDARtfgFOE4iNnmTF
 r9R6iKxChXwiF+/gdr4Pd5p3GhMITgxRl3hhZTVUaS3jdSQAs1pcDEFzk2cpoKzUH4BU
 v+GOCYc+8lk7h1nI/iQ3y0wR68L1kLb2u7j7eWaw1ILjea1baSZDJLJbesAZZRkVo0BU
 IsFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrGDufDGT9kM6TnzOhVEfLJ5xyMXfXuJh5NNylTEBND/nvtdaWUnjX3dOuypBhY6v+zgSNHIKgKntbLQDHsaCChOEYNw==
X-Gm-Message-State: AOJu0YwFNZ3is2I3B/v4MBv1Meo5fF6EllpwdsNb/QYYB2jatDgmYT4V
 x+9UF1g+9gdXz5SmSyn10lJGp9KX7HXYbCxbU/sKdKD357bKqL0d5TXWh+1QEpoz43B0N6aE/7T
 DIpc=
X-Google-Smtp-Source: AGHT+IE0egHE//AhDUPcMUeY9TXYOdgRZPbftJS/KajnPTVQ1apAoHOmRObQpsHwic13THy+eci1yQ==
X-Received: by 2002:a05:6871:24e0:b0:25d:fb57:db43 with SMTP id
 586e51a60fabf-25dfb57eda0mr3981473fac.12.1720029838316; 
 Wed, 03 Jul 2024 11:03:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25e13e84cc6sm309744fac.41.2024.07.03.11.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 11:03:57 -0700 (PDT)
Date: Wed, 3 Jul 2024 12:03:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: ian.ray@gehealthcare.com, sbabic@denx.de, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] msc_sm2s_imx8mp: Adjust the initrd_addr location
Message-ID: <20240703180355.GB38804@bill-the-cat>
References: <20240703175727.446205-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yu1WeLgMCREqOinV"
Content-Disposition: inline
In-Reply-To: <20240703175727.446205-1-festevam@gmail.com>
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


--yu1WeLgMCREqOinV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 02:57:27PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> Booting an initramfs with the current address may lead to initramfs
> corruption and boot failure.
>=20
> Move it 0x48000000 which avoids initramfs overlap and allows a
> successful initramfs boot.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  include/configs/msc_sm2s_imx8mp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/configs/msc_sm2s_imx8mp.h b/include/configs/msc_sm2s=
_imx8mp.h
> index 3c7d96cb3c0a..2a52455ace34 100644
> --- a/include/configs/msc_sm2s_imx8mp.h
> +++ b/include/configs/msc_sm2s_imx8mp.h
> @@ -39,7 +39,7 @@
>  	"fdt_addr_r=3D0x43000000\0"			\
>  	"boot_fdt=3Dtry\0" \
>  	"fdtfile=3D" CONFIG_DEFAULT_FDT_FILE "\0" \
> -	"initrd_addr=3D0x43800000\0"		\
> +	"initrd_addr=3D0x48000000\0"		\
>  	"bootm_size=3D0x10000000\0" \
>  	"mmcpart=3D1\0" \
>  	"mmcroot=3D/dev/mmcblk1p2 rootwait rw\0" \

Shouldn't fdt_addr_r change too? This is making me suspect the whole map
is too small for safety, how much memory does the platform have at
minimum?

--=20
Tom

--yu1WeLgMCREqOinV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaFkogACgkQFHw5/5Y0
tywoAwv/UaXDPlcupcT87CEGrdrgkXUEmZCg0wMfcJ3l3BeHrM7Coi8wIZJCyCjL
VnXMpQKrVtEm63A4KKvzH0nKm6As9pVWczblkv2uQOmWzTVjE0iF94MlZzjAk2pW
tuWVDE7W6jaaS7+2w3xdPdDrFoCL5eHrlW9UR+SmotguJyqcd68hATu9BIjHJINg
0HbkFqDGJ2kTo8X3gvc18yEdMSP7S67V2b9wDzSmYULQ2FVNznSxGdIPk0w8eC0s
epbdl0h8EzzarYEZwJFVsveARBV6R5YQtM/KYPORWbJZ8SdAiz3ycFoXVQO0UAwj
bJqU5rS8V3kdXJD4R59e46ZEuJLA4uf0DK4WIaTl3jLfyQPAVtwoo8QH/yyStkNw
8/tZDlmevjYAzVby97MCQRjGIg/ZdxmjbteXNEcnH/GnuZemJimEKUHlf5Ze3nXO
2bL6O0Z+jYCuYuws+zYcKrsEqA/yTLTOVI4jT4F93NieltTdz/h1f942KQvctnfr
FzhymSjo
=L60V
-----END PGP SIGNATURE-----

--yu1WeLgMCREqOinV--
