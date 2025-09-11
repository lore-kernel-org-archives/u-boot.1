Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448E2CAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 17:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD411833BF;
	Thu, 11 Sep 2025 19:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jdKFrftO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3D6A833C6; Thu, 11 Sep 2025 19:29:41 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CAF983390
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 19:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-32170a988a1so767230fac.1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 10:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757611778; x=1758216578; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Uwg03w/95QZx7VDsyuc8z1GhdJlqWub71bkaAQ8uhx4=;
 b=jdKFrftO0H8N2hBIre060yWYinpkYDwkP/1yjWXeVCMJTKEGQcCvxjFs0HoNV2bIX9
 J46KGqyv4+Hp8kOWSIfALRT7ekDANnK0FiikZSVRyoIPDVW+TUc1fQq/8NN3giC0JShr
 22wz+FCVIUyh/Gs/3k+vcLqucD/K32G/SCg7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757611778; x=1758216578;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uwg03w/95QZx7VDsyuc8z1GhdJlqWub71bkaAQ8uhx4=;
 b=mxevcW4dordZrQdw0LFSXqLRMrakt4RXI5XMtUJmyDUtVoBKJyRMRYp3PpC0Bx4XO0
 hR/RSdTTThaOVAgUuPCVHRqIrbclyHiXyzz7YTl6rheY3vnoe+6HX3PNAHGRAbIKFCYd
 W5UnkQsr3OE0YngKvsmYRzYeRzck9h1kdSh/vPbYlL2JaWRDH4J3bV9gWTmWva0GRhBc
 LbqseL1zzS6HTB/rM94bfG5nT6sUipp9RjmTChsvkUQgmPq2113Gix5tqOP4c2taipys
 BEPG19jpFy/YAJlBM5edDgKnIPbzCS5BAIXH6v9PpFIrZGbT495Tq/cHTCM/hw2r6rX9
 Pv+A==
X-Gm-Message-State: AOJu0YzvMVRLlMOTdSm0RtMXLRegZbXO2UcNvjuARypNghZQ/ZUeFd5m
 DaNE6+oZj7ihg2w+jVJk5ooA+olon7WbupqLLBjoVcx9dw7vFtM8ydJ/uLjLANhkOsw=
X-Gm-Gg: ASbGncvIX9wUdpcRNJb39g9Ec7Tf30p5CzcnCX/aM/FGN6oBABwKxGaYu3Va3uEIoAK
 FiKYmLqO/BGc1gq4WreWB6/JMxKZUrPsn2kHDt9dobiYLCchIsx+mjY2Vd5rDJ483M+Qb0Y4d5p
 tY3cmVNq5Aw/wcu/CLqSfP2mH6cHnZbVVM8r844qTWqksx9Izw+I2StSqQdv9lxqTdu/sPfef70
 w06cvD4Y66Cy/H95kCAcmn95k4lVeOCWdhE14BCgUGYJzdcRi6muZnD/X2t6xonB4rU5FEESTri
 cvANXWi4WW5LbLop+P1qzmY7W9uDeYhhPGGIRS/R9/YGjQG7cV/N0PSOkaryOBM9NddfYYMtSGq
 vZUaZjXj8ydhomctjqn6tmbuKDAsodMCI9gl6sBymLI7wAzq+6T3NkcnUvPEY8LipRyTbpLV1/5
 Ak9Q==
X-Google-Smtp-Source: AGHT+IEBOzAAMEw83HzK3bobZyCLij69ju+lBCtgrbYOZiBfqL5Ak8IOV3iREIljFBsGso14ruEU4Q==
X-Received: by 2002:a05:6871:a70c:b0:307:434:1aed with SMTP id
 586e51a60fabf-32e55189e00mr24490fac.18.1757611778081; 
 Thu, 11 Sep 2025 10:29:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7524c356860sm452824a34.45.2025.09.11.10.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 10:29:37 -0700 (PDT)
Date: Thu, 11 Sep 2025 11:29:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH RFT v1 15/17] env: Kconfig: disable external env in
 secure os boot
Message-ID: <20250911172935.GY124814@bill-the-cat>
References: <20250911131414.3296697-1-anshuld@ti.com>
 <20250911131414.3296697-16-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z8ox0VN0nHronoxw"
Content-Disposition: inline
In-Reply-To: <20250911131414.3296697-16-anshuld@ti.com>
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


--Z8ox0VN0nHronoxw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 06:44:11PM +0530, Anshul Dalal wrote:

> Falcon mode uses falcon_image_file from the env during mmc fs boot, but
> external env can be compromised. Therefore disable access to external
> env by setting SPL_ENV_IS_NOWHERE when SPL_OS_BOOT_SECURE is set.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  env/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/env/Kconfig b/env/Kconfig
> index 03c189b7266..d68cb90f3a4 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -827,6 +827,7 @@ if SPL_ENV_SUPPORT
>  config SPL_ENV_IS_NOWHERE
>  	bool "SPL Environment is not stored"
>  	default y if ENV_IS_NOWHERE
> +	default y if SPL_OS_BOOT_SECURE
>  	help
>  	  Similar to ENV_IS_NOWHERE, used for SPL environment.

You're going to need to do a bit more here on the symbols, this is the
right default but you could still select other locations (so all of the
SPL_ENV_... locations need a test on depends on .. &&
!SPL_OS_BOOT_SECURE too).

--=20
Tom

--Z8ox0VN0nHronoxw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMMG/gAKCRAr4qD1Cr/k
CmqXAP9694dAmr8WsfOHnzyKpvvkD3zC2Fo3H+zv2d23kmOEAwD/Qk74Q+UjErY8
lhtkrhSdky+eVDJ2fQvpK/9QD1+H3gw=
=fl6j
-----END PGP SIGNATURE-----

--Z8ox0VN0nHronoxw--
