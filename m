Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59281CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 16:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D19E483FCB;
	Fri, 10 Oct 2025 18:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mik799j0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D282684040; Fri, 10 Oct 2025 18:03:31 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5087C83FA7
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 18:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-43f988447b4so494440b6e.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760112208; x=1760717008; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d4JabLE28NSyd/eo1ly37Rr5ftGH7Nqp+pLHd7E70K0=;
 b=Mik799j0VCv7h3B56kttJdeDY+Up/hA2VfyA2z8xIMV8rJuS8GTsrprw/eqkFI3EVA
 JcxYRSS67RUv0/Zj1HqNVfnA1888FILULYsFJw/lE6wIfNB/dOZM0ZVrSliHWNXFJn50
 sIyIY+whn3yuLpY586i1A+IUExdfzQqLvp4NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760112208; x=1760717008;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d4JabLE28NSyd/eo1ly37Rr5ftGH7Nqp+pLHd7E70K0=;
 b=sRNMIhGMjN5X0vdmKkMsVv2qJHuLsOkE7DllEJT9GJfAk5cacYMSc8Wnjh0B690koD
 gtm3QaEkQr5XkClQtbFrBmbBn4ciqEJAy3lRzrZMspeJu75lsdqJmTXewjIjK1gxba/7
 k/sZ3J3bd1dg9hM9dFQyiEAZOaBHQcPZz0XvdSCKbnuj5s6FB6IZz/HGEFc9mJTlAimL
 pCjxxx+9Po6LEZtVaq4G2PdZJNRFxQqshr/PvKYUD3klIpMdaNKqlJgyQ6Mi3ZU0sPbm
 kVNyTJsJYV52U4rlEeACC2vqipoYrJqlhBp5/gj0DjAS8ovEZnZkaj/Ym+aaxrWTrzhs
 wUGQ==
X-Gm-Message-State: AOJu0Yyqs4JU0/Ur3+v+Kl07VnzTQO8h8YjfljliFrS06bQ0c68K/hCV
 CvTdG7UK1JXn7rO+MkDvGOWCDoDW0ZYu9292q1eIaT+KiRX32ZDCBNyKizSKLwgrbwY=
X-Gm-Gg: ASbGncsdl6APuEGBRxzsi33CcsLy5zBa2SIiLgGLfMrHRzhn2O35odSmhusprUZ7JOb
 h8YJMsBYhmuOAae/ZipASOL1hE/ALg+7mlMsbI5MhbIgjfLHAKXVYyhMfzWeFUuLmlmbtY8i99P
 7XUr8SCTsWrbw1hvmpbb9KKh+CxLmuzmgVfx7T6WKFnNWp50uYI6EXlUeaYi8O4MWvqd19PUGGp
 MA1WKu7JRHRavJMaW20w8L/6BRoV3Vw0b0XIUwiomifweKMoz31i4a88vZ3BSnvNxDFdmnq74rh
 4dLhTaeWaPN6Gk7h8B9e5JH+sIwSZTGBAibtLv1TCu6K07nVeUnUQJfDti4uFIu4kvdUD6zfYFE
 SXeSdqbbjFV6IrMhzx1xt8KsSXWm16cRxIl2ER0qJ58DVfo6zrHUZZAI1O3R29DQyvvBt4dFKG+
 X8h5Jw
X-Google-Smtp-Source: AGHT+IEhwuQrY8PDp3Wr68kStci9qv89q9oL3ZdVIHgg4eM5yHKEwb23hXaDc9oaBBHc/vJ7c7BuKA==
X-Received: by 2002:a05:6808:138e:b0:43f:7dee:46b1 with SMTP id
 5614622812f47-4417b38bdb2mr4892235b6e.29.1760112207715; 
 Fri, 10 Oct 2025 09:03:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419889cb88sm717185b6e.7.2025.10.10.09.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 09:03:27 -0700 (PDT)
Date: Fri, 10 Oct 2025 10:03:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH v1 2/5] board: ti: common: Kconfig: add CMD_SPL
Message-ID: <20251010160324.GD298503@bill-the-cat>
References: <20251010131829.3737258-1-anshuld@ti.com>
 <20251010131829.3737258-3-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BN6ncNV4/sezsZnz"
Content-Disposition: inline
In-Reply-To: <20251010131829.3737258-3-anshuld@ti.com>
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


--BN6ncNV4/sezsZnz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 06:48:24PM +0530, Anshul Dalal wrote:
> Add CMD_CACHE to list of configs implied by TI_COMMON_CMD_OPTIONS. This
> allows the use of 'spl export'[1] command for preparing a device-tree
> for falcon boot.
>=20
> [1]: https://docs.u-boot.org/en/v2025.10/develop/falcon.html#using-spl-co=
mmand
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  board/ti/common/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
> index f481812247c..fa8260e3fa4 100644
> --- a/board/ti/common/Kconfig
> +++ b/board/ti/common/Kconfig
> @@ -53,6 +53,7 @@ config TI_COMMON_CMD_OPTIONS
>  	imply CMD_REGULATOR if DM_REGULATOR
>  	imply CMD_SF if SPI_FLASH
>  	imply CMD_SPI
> +	imply CMD_SPL
>  	imply CMD_TIME
>  	imply CMD_USB if USB

Commit message says adding CMD_CACHE, content is adding CMD_SPL.

--=20
Tom

--BN6ncNV4/sezsZnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOkuTAAKCRAr4qD1Cr/k
Co+gAP41ENHOQWRvtsHpdHmGhVDgnQiu+3oIatb+NeullaYvCwD9F4s3xcIb+Vpp
R2TPc6Hl9mYakOXQvRZcwFwTZCtbNwU=
=Nh0K
-----END PGP SIGNATURE-----

--BN6ncNV4/sezsZnz--
