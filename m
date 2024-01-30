Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE84C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 15:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A1BE87DF9;
	Tue, 30 Jan 2024 16:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="up/xSvxz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37A1B87E25; Tue, 30 Jan 2024 16:09:12 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1388B87DC8
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 16:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6002317a427so33670777b3.2
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 07:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706627349; x=1707232149; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uzP/PmNuSGwVg1Y0YIKpJZ4Po68koHNaSFqHhUIYdZY=;
 b=up/xSvxzDcrbecuIuMYa9rVZArL2DOT+LCGJ72XobVz6x9LTYvyspUoRJantQ0Qhkd
 NvocWLp3WyH2pE/E7iU6AfwzQMX2H+t8KyVSCbMNWUwkYKfZu3IiFJ9Bjz0rcbV4vYjM
 GFaEYZF4Xsa+b9hF9ykKIytFfUZE7kOuTDmqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706627349; x=1707232149;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzP/PmNuSGwVg1Y0YIKpJZ4Po68koHNaSFqHhUIYdZY=;
 b=OXdazDt5ZEDBi25wqkuPy1SieidKQjOTmcmpRaT+sqArWXWmllhB1BRdp/GzIA/39n
 wlDc9MHHH8NP9qobwm4A38zhUlRtAlt/qqaVxHELtdjxhfal5mEU15pEBjxMWAOSh13D
 jGAFHjR5P2i/jlRTuoKH+1alhLt6wxga3ZNDRycMY0n0tjL+5hBlcxUHu4s4eJS/r6Uz
 HyKgq/8YM/GJ3uafs1I+V4Y6MMr1cdFYz9+OQfhdtY7N2rbe0sXjq1jWnWGxX8Fxz50N
 2Z+JfMRJZT+aGeM12eiqKAf/HMoW7S0pk/7FJclkKkFTTgnKeb3X22iagjLcA8lEMwre
 cPCQ==
X-Gm-Message-State: AOJu0Ywe2hbZE4/xQdKlAlP5RX/28kVNfYmVqArQ7DxLBhbLhIGp8ksf
 z836uPbci208R6GqebBivT4dBDmqRihKs/wlVImxDogwpk9DvmL8PqIX0u+AlBs=
X-Google-Smtp-Source: AGHT+IFwu+2qkjPxw4cUNvrRp72t1EpHk424R1kEIwOC7xgru6g9+OtIvtfTupoQ3KltSNWeC8IjTg==
X-Received: by 2002:a05:690c:f88:b0:602:cd33:533e with SMTP id
 df8-20020a05690c0f8800b00602cd33533emr8105287ywb.25.1706627348680; 
 Tue, 30 Jan 2024 07:09:08 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 q206-20020a815cd7000000b005ffc86f6a04sm3234517ywb.52.2024.01.30.07.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 07:09:08 -0800 (PST)
Date: Tue, 30 Jan 2024 10:09:06 -0500
From: Tom Rini <trini@konsulko.com>
To: Kelly Hung <ppighouse@gmail.com>
Cc: u-boot@lists.denx.de, openbmc@lists.ozlabs.org, kelly_hung@asus.com
Subject: Re: [PATCH] dts: ast2600: add x4tf dts for asus product
Message-ID: <20240130150906.GR1152441@bill-the-cat>
References: <20240130104045.199879-1-Kelly_Hung@asus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kFPOJKzhK0rsrwMO"
Content-Disposition: inline
In-Reply-To: <20240130104045.199879-1-Kelly_Hung@asus.com>
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


--kFPOJKzhK0rsrwMO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 06:40:45PM +0800, Kelly Hung wrote:

> This initial device-tree provides the necessary configuration for
> basic BMC functionality and work on ASUS X4TF production.
>=20
> Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
> ---
>  arch/arm/dts/Makefile         |   3 +-
>  arch/arm/dts/ast2600-x4tf.dts | 239 ++++++++++++++++++++++++++++++++++
[snip]
> diff --git a/arch/arm/dts/ast2600-x4tf.dts b/arch/arm/dts/ast2600-x4tf.dts
> new file mode 100644
> index 00000000..3c478058
> --- /dev/null
> +++ b/arch/arm/dts/ast2600-x4tf.dts
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright 2020 IBM Corp.
> +/dts-v1/;
> +
> +#include "ast2600-u-boot.dtsi"
> +
> +/ {
> +	model =3D "AST2600 ASUS";
> +	compatible =3D "aspeed,ast2600-evb", "aspeed,ast2600";

Compatible should be board unique.

> +&uart5 {
> +	u-boot,dm-pre-reloc;

All of these are bootph* now.

And is there effort being made to upstream the dts files for these
platforms to Linux?

--=20
Tom

--kFPOJKzhK0rsrwMO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW5EQgACgkQFHw5/5Y0
tyzCQAv6A5BHtX8Fdo9rXkw7V0BcSmxCaaeLM29zd8gEzmcjnbE/VZZHocfmittY
PPbcca95jOVFd+5K+H5xGnIMYzpEiNzl+Ctgbe2iolRLqOqo0CK3eevG1chc8dmq
txqCE3JyJZrO+N9HpBbq8F+kJEJgo85/8pUOTxTwr/bYnCewQPETRZWG0nZROhyv
jb0cB7BOq97HqUb1QlWSxR4DOXy4J40LAamcam9U5ODwo+ubkEWBaIP4FtI0ddxt
Fu+KFEppjzTK7D+/HSCzvw0Fi/KpJ+F0T/pYnIz05T/PnWwsj2oJ34rqJKaBL44Z
u83QwJwqn90oDYucIxAIiz70UTsz+CKCg3S9B4nRJ8ez+J/n/72cvuShBFrqemQK
FPVTT5oNkU5TBAH3thFVt2FHMBM9SrhGch7bKk+/yIzcpFr3MMtB1Hzh97EbKieg
mYJZxYbcnoc8p4rOe7kLwfNXi8YrjVDgyTOnSyPda4tR5UVwcVosBaC8rJYPrkvd
UeIJuzRs
=COYR
-----END PGP SIGNATURE-----

--kFPOJKzhK0rsrwMO--
