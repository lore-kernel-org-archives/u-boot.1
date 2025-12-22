Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78922E674BE
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 14:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E22F583B99;
	Mon, 22 Dec 2025 15:56:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hE1rEUcs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3824483C28; Mon, 22 Dec 2025 15:56:34 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C18E83B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 15:56:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-45085a4ab72so2309227b6e.1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 06:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766415391; x=1767020191; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XjTzUhpQ5Rn3CyY6dWFEiUOER1B853GPL/kbkEMnntw=;
 b=hE1rEUcsfQeym1hAILhYiM5icJxm9fCljDE+5mpm7hBj3TcFi3RlDFdHB/2Lq9bDeH
 nZbmhNQ5D1Tc6iGbIlm6mc3VkBAwO02fGvZVrbRCfShpEWhW5zvGuXLYK7tUI0uSICcc
 VB5LxRxsFmDoKsk49yRKnYOZYj7Sc7nECE7ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766415391; x=1767020191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XjTzUhpQ5Rn3CyY6dWFEiUOER1B853GPL/kbkEMnntw=;
 b=t8IjAqczRRlm5wxjXbEJqyZzvPNZYFxZskL90zF3eqT/JnlG/c8TwQiyasoNc68jp9
 oPFg7eRp1EcUHpAE17hAR5g+lsRV3gSNpWIP3FaJWow3gh6ejsmK4uS7LA+B426Tehnm
 iUuGgT8TZoRwoIoyUG6KtybNuPR/GZ6cTxCOuQXusjlI4VCKaGzNdrj5cQhtLaBwXscz
 bjLyRdgMGj8LN7uOxmqR5aU19177OwvbHOt/wVG6B23sYcRqy5MFpxKeImwcm9euq4yL
 KdRKM8TLupzEdYliM6JSzyvGyKY3lwrvK9yBX0HbswK+6m5pf9UWl9UAK1jOu4qF1ZJH
 VNDw==
X-Gm-Message-State: AOJu0YzxhC2AbXfeA85eaa0+LTx2oLG0vf0LP9h+QCxf0kCAY7JMaUTC
 nvwYC+hacUh1apNhB8Ejxi826itlSien9LuKXBHnVJu52Hh5Tn67izd2zbjyCiLlirg=
X-Gm-Gg: AY/fxX7EmsyG4stu2WtxHBF++tfrlKfZ0zySvynhrc43GEQSu052zaY3tOB7O4EE5Zf
 qZr+Uqh+YOmCLXQoTMUgbVlQIr4G6Bial9bwpMya8tVIQcKWcOniXN0Dt+g+WFzcOUwx+qtypQX
 JjoE9b+pyyFEi5h4teKErLfizmULzRT2gjWwihmN10zm/30fNZoFjSy9Qf931b/lhNJX5cR7NEo
 HRcKDhD+M4bguhBz3MFBMQKZe3WkbpEVeg0EoKsi9EINeA8+K5vBVf+VVEVzHztJzV+JuEgq5o3
 qME5E+C/StLutgXqC9XzmN1TB17F6hi73fvo6uShYEGUmhrYdqAsNyP0dMFbVdyVjfvTDtI+YZm
 IuQ7s98of/SGj2cbei2B22pi1/FSl0D/ZvbrQQuaymi080BKEAdiXmJyM8cf0P8BO3yAdkVZaRN
 8X3PiZ8u7/Nv/g5cp+2l5o/luLLQ6XY96yuCiYVuL++aUe9X0NdQ==
X-Google-Smtp-Source: AGHT+IES3qi+O6HmJ9k66AXmvRIRfHGnexXvxTyFEObJGRfy2RDCe9BgAJg7Uh+Sc9TjqAU4+8aNog==
X-Received: by 2002:a05:6808:4447:b0:450:4628:e3f2 with SMTP id
 5614622812f47-457b1fc8ff7mr5267827b6e.42.1766415390710; 
 Mon, 22 Dec 2025 06:56:30 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3f1db46sm4900838b6e.21.2025.12.22.06.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 06:56:29 -0800 (PST)
Date: Mon, 22 Dec 2025 08:56:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Brian Sune <briansune@gmail.com>
Cc: u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>
Subject: Re: [PATCH v1] fix PL330 CMD supported target
Message-ID: <20251222145627.GW303283@bill-the-cat>
References: <20251222142744.74707-1-briansune@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P+MWNP99m5JqtOqT"
Content-Disposition: inline
In-Reply-To: <20251222142744.74707-1-briansune@gmail.com>
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


--P+MWNP99m5JqtOqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 10:27:44PM +0800, Brian Sune wrote:

> The config is wrongly written, result
> in only support socdk board.
>=20
> Fixes: 92dcb3ad5d98 ("cmd/dma: implement dmareset command")
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>  cmd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 5b9c13d85e7..5c611fb3016 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1849,7 +1849,7 @@ menu "Shell scripting commands"
> =20
>  config CMD_C5_PL330_DMA
>  	bool "Release Reset DMA Channels for PL330 Handshake"
> -	depends on TARGET_SOCFPGA_CYCLONE5_SOCDK
> +	depends on TARGET_SOCFPGA_CYCLONE5
>  	help
>  	  Provides access to Reset Manager Per2ModRst. Enables DMA
>  	  channels for ARM PrimeCell PL330 via reset release.

Now that I see how mach-socfpga is abusing the TARGET namespace, I get
why this patch is needed, so:

Reviewed-by: Tom Rini <trini@konsulko.com>

But really TARGET_SOCFPGA_CYCLONE5 should be "SOCFPGA_CYCLONE5" or
something as it's not a board to build for.

--=20
Tom

--P+MWNP99m5JqtOqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUlcFwAKCRAr4qD1Cr/k
CpZJAP9NWcNml/e4uHKb110vt8qHmtTENO/QOYr8Ph0CQ8LotQEAsfPQho4kMc7Q
agKVr2bNzNLKFk7ndyVb0T3qjrkBqQ4=
=w03O
-----END PGP SIGNATURE-----

--P+MWNP99m5JqtOqT--
