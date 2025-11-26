Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E57D1118E
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 20:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8271A839E8;
	Wed, 26 Nov 2025 21:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bD6oyFKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF33083A26; Wed, 26 Nov 2025 21:29:31 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3C71839D9
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 21:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c76f65feb5so189384a34.0
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 12:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764188968; x=1764793768; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rvtEsFiqhLRuv/JoIWdCZTyf6KFtkjw7xSL6mE5+3dk=;
 b=bD6oyFKebDB9KhDJ9iR2U6Jyx1jp06mMMpI4Xv8v8NFDMiRq/nCAwWKo1n2ADD2g1t
 BPzyDMw6YfFKp77U2g+efsKEaK+MVj4HKB4LSyZlP+QU1BNbzDxGeBo4r0/wifwuxPZ9
 uESC/sw31jas+hoYCW4AVq2p7BTsflS5l1tWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188968; x=1764793768;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvtEsFiqhLRuv/JoIWdCZTyf6KFtkjw7xSL6mE5+3dk=;
 b=jK/c4hEY5dWF3bcS3zrEq6AJsTWkaHYuZ/zSi32yXK7EgJlvf4WZ2QTeOTtuRZvaIE
 g4mN51i2P4GGmWhqhDcJNU0hUNyHbUElEtRWy+RSoBvi1vyiYslJ5Twl/thpOjrQ1Lbr
 MoL+7z3gG2B1NiPZuw2Z2F2LKx2MO9WaZQHly2i1VvZSqEVfYWvaye1zzlhIG8Vw+al9
 m2Yq8ma++vhZLWaIJoHNYfDOesRqtECWGYK3G5uiriMOnsP1AU8KA1ADzzfrSI8tqjIx
 BSQI6iAbysKNo1d2pNSktysjRkRxcfrBJGlrlGwGfsNaunmAV3eUcrxfD/K2vbXlgbQF
 QjHw==
X-Gm-Message-State: AOJu0Yyfi+t2JUZfbuRuK41r5nDIuvK1q80zWtGngiqqlDQH4aFsC0jl
 7caNgTAMw8xdcJMowHkWmjkYcotJ9xr88E3SCnWx+T1bsVbar551ah0X+Wbw7wg3zz4=
X-Gm-Gg: ASbGncsOeb5XBj8exdP6q5N6acm4ruCRR9imbJ2a5a2wuva/tSt9d1R66pvbV38lJch
 grLw6DYstANahXfrbo++QzTHuxtOixFsWE5KFDuVZv0pRhLiaUPc5ZJxk0GDnUESI3aTgkz0Qb2
 dHHgzmdNymhoemruNiRFgVHP91td4AGehaqrfS+DlUb3IxJrJCWxshlwUBBQwW+W5ZxeiVxvW/L
 qH0Ji9szjUSyyfeU8rWPyG+7CQSavxiNvupgxse72GJbOMQil1ksYd5z38j5/KeAu6/ti7hMQQK
 tTBrs86/cFh86XEQi/hY1xMUE6YEDjwCYq5ePz24wCan+CgqGoad8WCSZddz/AtFPqf4VciXnQ1
 xwWTxXUvsR+7dSgfNATnaY1c2p1ofgakYow/vWQVCVuU/P3VsUwjN7QQH/OX0OsKljwnQK5YEau
 83/2qskB9Lgbk62jtAhz8gTyLB26hEG783lCPWi6is395gE/JfYQ==
X-Google-Smtp-Source: AGHT+IG8I9ZNUQtNlu7PNtrNAegaF+KUw50xctG25RPwyp7hMsk7iYtgE+bDSPARZS1HSCif24N+6A==
X-Received: by 2002:a05:6830:3147:b0:7c7:59a1:48d7 with SMTP id
 46e09a7af769-7c798b895f6mr10532935a34.2.1764188968565; 
 Wed, 26 Nov 2025 12:29:28 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9dc21868sm9548183fac.14.2025.11.26.12.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 12:29:28 -0800 (PST)
Date: Wed, 26 Nov 2025 14:29:25 -0600
From: Tom Rini <trini@konsulko.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] configs: am335x_hs_evm_spi_defconfig: Remove duplicate
 symbols
Message-ID: <20251126202925.GU2125796@bill-the-cat>
References: <20251126-topic-am33-hs-evm-remove-duplicate-v2026-01-v1-1-5008cdb30536@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="azeO4BxB70yyrky5"
Content-Disposition: inline
In-Reply-To: <20251126-topic-am33-hs-evm-remove-duplicate-v2026-01-v1-1-5008cdb30536@baylibre.com>
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


--azeO4BxB70yyrky5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 09:25:56PM +0100, Markus Schneider-Pargmann (TI.com=
) wrote:
> Remove symbols already present in the included file.
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  configs/am335x_hs_evm_spi_defconfig | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/configs/am335x_hs_evm_spi_defconfig b/configs/am335x_hs_evm_=
spi_defconfig
> index df009844defad13109adf2523580181b6ed6b5ca..ad1777f2bcb45bd2c8424011a=
dc231f0e7d4ceee 100644
> --- a/configs/am335x_hs_evm_spi_defconfig
> +++ b/configs/am335x_hs_evm_spi_defconfig
> @@ -1,8 +1,5 @@
>  #include <configs/am335x_hs_evm_defconfig>
> =20
> -CONFIG_ARM=3Dy
> -CONFIG_ARCH_OMAP2PLUS=3Dy
> -
>  CONFIG_SPL_SPI_FLASH_SUPPORT=3Dy
>  CONFIG_SPL_SPI_SUPPORT=3Dy

Did you confirm that buildman still works? That's usually the reason we
have this kind of duplication, thanks.

--=20
Tom

--azeO4BxB70yyrky5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSdjIgAKCRAr4qD1Cr/k
CoQQAQCK0kamNEv1AtF2qnBfeXT6FkN30ZaSTFNsAl1Z8kxA5wD/eoUohfsYp7EM
PaCGDDsDJAsoUjn13IFU572VwwkCeQA=
=BnJs
-----END PGP SIGNATURE-----

--azeO4BxB70yyrky5--
