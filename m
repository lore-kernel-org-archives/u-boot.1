Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D2AC44503
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A00084AF1;
	Thu,  9 Jul 2026 03:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Aq4klBon";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96B0084AF1; Thu,  9 Jul 2026 03:52:53 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 824B184994
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 03:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7eb63dbd229so315875a34.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 18:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783561970; x=1784166770; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SRklGgpSNWxEMRHfLB8EBA82dSxFlILbmSP5Wdyb3x4=;
 b=Aq4klBonuj6PSBGErsQPPKwLy1DJB6PNKO/umRDuwms7q7bAWZqljpyn6A3egL9QvM
 l9iGXMBuceHuv4O5LkfxRIDR2NlFBHisjMm8CEDU118r+FerfmULiQWoV6V3BGlXL1z/
 Ox0x3ltkU5RFuRPSL9ndmR95+xWgn/IGobA34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783561970; x=1784166770;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SRklGgpSNWxEMRHfLB8EBA82dSxFlILbmSP5Wdyb3x4=;
 b=FyhZBdCOx6F++JBv068VqWi4gd7dJpQCkkD8g1jWLLNFxic4wLJXE0WlR2QMkZBKpi
 gLjBdqiCS+MteUtQbcBQHe5/U80rUuIqU8TYlPN4JltsV03Pya5co5FnzSDnwFOet8fZ
 OZhWk8yrcsPzkJ3OWePSzfkAFj1KidmWCraR89ZX2QMlQ5w3GfA8BtLx3xNnj95t26de
 zoSd14oae5OfOzfgvdm/SXFCt2+Ywz9DzIJ/toiNJy9ZVwCScg34bN6kesW2Y5AwMgpx
 4IOS7fcDlJ4v9E3QE+II2+1KUewQEVXddbEhKfwdt2n9uCPbBLWzrERizTkJ9HQQZbK1
 v8gg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sdwzswqSiG3955nHjcrPNliPcTj9JHpJNcIjGh3YJytEp55wR/3qfv4bOZ2EXkS6Eh4agzJQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yxg5LkRX7HLTqHSyqIQoC2/zuU7xJ8/7F+NZFSo0/RC9kw5yA82
 gmjVD+zTzptY42obQRn3tlzZaUYl9B8AAV528b/nzzIg+qgAGzO1F11ef0FdB4AHg4c=
X-Gm-Gg: AfdE7ckjcHfo1mwJcqxgVMXPojkezzb+nr9Z2nUJtb4WB7Jk0jaPCML2ybEA5j3ozsG
 87Z0KzajwTo+ETEtisk2Wr1CGSy1S3pnEaPQpicUJbGialEF9r7gd3MytgzK6lEPDYL4oHbqh3U
 Usukgr4rEpPDTY7tGNrWTU1B1qYMuIy8v1LMxHY+hwwmSaLPMfziJCLLGhBJbLV29voI3VMoq1z
 BuYNscueJEYgHIzdDYD0gYh+PtelhjXTeNm27xlRxe15dKQap4gCfCkvF7Q8IO+zsqU6tzaOkt9
 L5jrbucBz8iJql5ho4p2Ti0uNbHSSr9W4EeArIBMqKGwl3ZqQ0S4qRxE9xKjIqM0SkxFap41pVO
 FwsBUaPffYN90Ne+WvGyBTFrO2hajvxWDBUfScn1SLUqhaTdOYlcTy6b8JdIigj0ubhwPVQEV4Y
 yW6NhfwrVd8v3Ol+OiXrD/qTrcr2UKKdyAvlBmlZSxpGuhMXIpatfHlIBaMSLWpdoDRcbhxBmiC
 jVTfKnsTw8VKkKB5SuLscZdVB15z6ex723zpA==
X-Received: by 2002:a9d:7c8f:0:b0:7e9:dd46:b9f8 with SMTP id
 46e09a7af769-7ebe1fde031mr399963a34.15.1783561970260; 
 Wed, 08 Jul 2026 18:52:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb3f27besm3027760a34.25.2026.07.08.18.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 18:52:49 -0700 (PDT)
Date: Wed, 8 Jul 2026 19:52:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 08/11] Kconfig: i2c: Depend on correct xPL symbol
Message-ID: <20260709015247.GR749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-9-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W8DUYIUlmn0LemlK"
Content-Disposition: inline
In-Reply-To: <20260708220540.3368825-9-jonas@kwiboo.se>
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


--W8DUYIUlmn0LemlK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 10:05:34PM +0000, Jonas Karlman wrote:

> Change to depend on the xPL symbol instead of the SUPPORT_xPL symbol to
> only make the xPL_SYS_I2C_LEGACY symbols available when xPL is enabled.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/i2c/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> index ab5af17858c8..125dc84819e6 100644
> --- a/drivers/i2c/Kconfig
> +++ b/drivers/i2c/Kconfig
> @@ -78,14 +78,14 @@ config SYS_I2C_LEGACY
> =20
>  config SPL_SYS_I2C_LEGACY
>  	bool "Enable legacy I2C subsystem and drivers in SPL"
> -	depends on SUPPORT_SPL && !SPL_DM_I2C
> +	depends on SPL && !SPL_DM_I2C
>  	help
>  	  Enable the legacy I2C subsystem and drivers in SPL.  This is useful
>  	  in some size constrained situations.
> =20
>  config TPL_SYS_I2C_LEGACY
>  	bool "Enable legacy I2C subsystem and drivers in TPL"
> -	depends on SUPPORT_TPL && !SPL_DM_I2C
> +	depends on TPL && !TPL_DM_I2C
>  	help
>  	  Enable the legacy I2C subsystem and drivers in TPL.  This is useful
>  	  in some size constrained situations.

Building on the last email, I think these might need to be
[ST]PL_FRAMEWORK not [ST]PL.

--=20
Tom

--W8DUYIUlmn0LemlK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak7+7wAKCRAr4qD1Cr/k
CiPOAP0TU4tKbJkx3Ef1SlaPAWb7UM9qkD1AGKkFNuvLoZMdswD/f+LZvwr9Oxqj
st9egrK9rOAQAN/rCuce+Op6AgWVTQs=
=iUjp
-----END PGP SIGNATURE-----

--W8DUYIUlmn0LemlK--
