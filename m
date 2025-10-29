Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E253ACCF9EB
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 19:11:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27C1E8004F;
	Wed, 29 Oct 2025 20:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Io4LYlBI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3361A800B6; Wed, 29 Oct 2025 20:11:37 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16F1B8003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 20:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3d29e5fce5aso194089fac.2
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 12:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761765094; x=1762369894; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vntrDsF69jSJ8xWjvEErNiqZLWITZawCuplo8QnN5GU=;
 b=Io4LYlBIl1xaagXtsIpRa8XMiic/xZAYCa4iVgn3A00r7KJPXHdNnOUl5NXH97GhcJ
 T0V9Um+W2aaRPbXRFiasf/IYrNeCNaw1PA0EVz4FL6hHBWrI+RH51sFEh6yjGleHetDr
 ZyJREYh0b2Bme7ShyMXsar9j57jAMNVuK8vHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761765094; x=1762369894;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vntrDsF69jSJ8xWjvEErNiqZLWITZawCuplo8QnN5GU=;
 b=H47SzibcWnL5Xc8VTDzk0wuqM9tPh8bIpFAp4i0Y22C8s/TflfAa9IhVFz48gs6GZ7
 9nc62RBenYC61rV0ZRHUshWlMnWxnlxT/AmQMDdFga655q9KsmRb5N3rwSa2KGyrECGu
 swiRrcHR9Qglr/9L6awFBVDiy5std5R7H2uxrJCm66DMFdgpC16vTjqGcg6hkb0u7Rgl
 nFy1ibN+xpGkxTnwzEGsxtaaQqKictHkLNLEQDjhC/FQECUyilnWCArEEfexhiA/o57h
 LzpCkP0+/49Y3gsFSh6hEeYvbhgSy4wLkol/SskErnmI08TyXrQEHuOaykbHbm+ex3lk
 pVMg==
X-Gm-Message-State: AOJu0YwwsirxOeQxs4sDtkbnzl3EJIaDGvJz5/ERK+6DFvymeC3TMTGR
 mb2gf96nSq37AVtrDQFULIzECNMWQUbCovNEbl44pfc5wIYmpMX4FV8o1LL/M/1tn8E=
X-Gm-Gg: ASbGncvIjOvovEzXVRmBU6O86E9coUe9praEiKAUyobvGnQp2HXH0prC+EEX5m2OXm9
 UDuPPafSqyDxBs85rJ+Jkuu93e7KIm1uOoapQjClYNdgkUFUutts3mte2PuwbKxYEKVGIY7o28J
 0WJMvSNMWWrAbpdJ5QGexRfaILfgmg5QWijK+ROXAuQUab+NYU15o94WvWmZ3LY91rIRjmlg3h/
 KwOBP3IIChxOjgNpkSKtU+Pum9TbGptc9FwvydUg1oomRWd4GlxV4YBYvinXq6119Q+4nQsVXaN
 DFAklTqKtTsNoyO6rNFQ+ACe7pA7GYgyxxf03tZptUUwTfPnqd3s37Wp38iv7Uraler69Bs/H6q
 dsh8Cmq7Ryiymqt4ydoc6XckCOfGfhWjVJWDWtpxjXRygXUboiSeE8gbnuIv3Yfh0WYygwwYbYC
 UPxBAjLqkbon8YCs0HqlvtK/fnM2e0NU2sCIevUtU=
X-Google-Smtp-Source: AGHT+IFNUrbuWtLwFdlUtE2KHdtmphJ4Xqd5FfZJiqWzWt+24TGViOKqV/jVDe7fyFRXqGvfbN5PNw==
X-Received: by 2002:a05:6870:f28c:b0:375:270b:ea56 with SMTP id
 586e51a60fabf-3d74792287fmr1743400fac.42.1761765093774; 
 Wed, 29 Oct 2025 12:11:33 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5301e39a0sm4401830a34.22.2025.10.29.12.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 12:11:32 -0700 (PDT)
Date: Wed, 29 Oct 2025 13:11:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
Cc: u-boot@lists.denx.de, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, festevam@gmail.com
Subject: Re: [PATCH 1/3] bsh: update readme with instructions to build M2B
Message-ID: <20251029191130.GK6688@bill-the-cat>
References: <20251029104901.3810649-1-andrea.calabrese@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y9Oy2Yi+uI8vxHlT"
Content-Disposition: inline
In-Reply-To: <20251029104901.3810649-1-andrea.calabrese@amarulasolutions.com>
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


--Y9Oy2Yi+uI8vxHlT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 11:48:59AM +0100, Andrea Calabrese wrote:

> readme was missing instructions to build M2B. Now added.
>=20
> Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
>=20
> diff --git a/board/bsh/imx6ulz_smm_m2/README b/board/bsh/imx6ulz_smm_m2/R=
EADME
> index 03d01325a97..3007180cc47 100644
> --- a/board/bsh/imx6ulz_smm_m2/README
> +++ b/board/bsh/imx6ulz_smm_m2/README

This should get converted and updated as doc/board/bsh/ (and various
index files updated), thanks.

--=20
Tom

--Y9Oy2Yi+uI8vxHlT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQJm3gAKCRAr4qD1Cr/k
CjG3APwJxpctkZUdNZxMga+wViz/LvS12g62C7WO4pq2uFdu8QD/Vxy2zGQ299TM
Qh65RRCfp7QnXYV08PyCBLXrpefueAk=
=XYtQ
-----END PGP SIGNATURE-----

--Y9Oy2Yi+uI8vxHlT--
