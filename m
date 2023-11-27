Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEC7C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D611E8757E;
	Mon, 27 Nov 2023 14:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UshCAr66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ABDA87515; Mon, 27 Nov 2023 14:11:35 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC9F3875DE
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5c8c8f731aaso42552777b3.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701090691; x=1701695491; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xbXfzVkfKoPcTE1hEY/EVQ/RKynLsqmCGDrFgQ06n1I=;
 b=UshCAr66lZwnOiN5p9hxIFuokm1h90+5CV4ssjWHXC/2xmK2XVTYrj/8JRFEYEJ/gI
 a5/KYQ0DHxrViXBNV9bZVzMhMLUqZPf6AZ2+n3Zn/wTsVGOztKmKPY9Ya18fen7wOorp
 DUemC9lVgK/SbFa6jJ17ARU/h9ZapG5gjOveI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090691; x=1701695491;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbXfzVkfKoPcTE1hEY/EVQ/RKynLsqmCGDrFgQ06n1I=;
 b=OZ01W8nxxwd5Vndl+dSPspjMcGRM/xur3QQsgzC114Rdv4QotzmAS7M0oC4/aMqvv+
 2D+8G4IVD3H8YsZVn8qQoa4IFiahQ+4REcDF7xzontAdAU1VLNgW31NBEToFbhwfp4iD
 Ce63CAN/559KETCNjmM9awT8zGqBKYlBszVnMDswwyonXZKpavjs+uKl7l1LC3dLyHcK
 25E254imioWhrzHNil2nWj8p/Z02avQ9GP0Wo9hbw6/EnZV3gRHitDfz6WuT4JiThUzG
 5WUybNUrzkr+x02gcYTDiy7tiY/lBycB1e9o4FKehHvvBMX2apNEWOmceWKTmlaw6aG6
 L58Q==
X-Gm-Message-State: AOJu0YwtXAZkuN9NAjs/bBHbkkBBvoYHy+U09kiTVQJBAujkqBKGkR54
 MJH3t8+7/ehUmmGfUOuKthwc8A6tSJYaeIBsAmCgVQ==
X-Google-Smtp-Source: AGHT+IHzO8epRyfnVeNaRygl21a8s2I+iFuhli6MXypEzV1H/c7Wg7YoX5VnbQw0PsvoDrDpGc2Kjw==
X-Received: by 2002:a05:690c:2e88:b0:5cb:996d:15ea with SMTP id
 eu8-20020a05690c2e8800b005cb996d15eamr9897470ywb.4.1701090691323; 
 Mon, 27 Nov 2023 05:11:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 er8-20020a05690c2d8800b005d02d6baa1bsm911917ywb.39.2023.11.27.05.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:11:30 -0800 (PST)
Date: Mon, 27 Nov 2023 08:11:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de, Soeren Moch <smoch@web.de>
Subject: Re: [PATHv11 26/43] configs/tbs2910_defconfig inc limit
Message-ID: <20231127131129.GD2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-27-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="edLgQj6At/P6ZtsB"
Content-Disposition: inline
In-Reply-To: <20231127125726.3735-27-maxim.uvarov@linaro.org>
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


--edLgQj6At/P6ZtsB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 06:57:09PM +0600, Maxim Uvarov wrote:

> Increase allowed binary size to fit lwip code.
>=20
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  configs/tbs2910_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configs/tbs2910_defconfig b/configs/tbs2910_defconfig
> index 8fbe84f1d2..ce40efa9ab 100644
> --- a/configs/tbs2910_defconfig
> +++ b/configs/tbs2910_defconfig
> @@ -17,7 +17,7 @@ CONFIG_SYS_MEMTEST_START=3D0x10000000
>  CONFIG_SYS_MEMTEST_END=3D0x2f400000
>  CONFIG_LTO=3Dy
>  CONFIG_HAS_BOARD_SIZE_LIMIT=3Dy
> -CONFIG_BOARD_SIZE_LIMIT=3D392192
> +CONFIG_BOARD_SIZE_LIMIT=3D417792
>  # CONFIG_BOOTSTD is not set
>  CONFIG_SUPPORT_RAW_INITRD=3Dy
>  CONFIG_BOOTDELAY=3D3

This is another case where the binary size is a fairly hard limit. You
forgot to cc the board maintainer here (and I assume the rest of the
series too) for these config changes. I think on this platform it's not
impossible (like it is on am335x where I just replied) but really
difficult. I'll let Soeren comment on if switching the network stack to
lwip is the kind of feature enhancement that warrants the pain of
dealing with the size change here or not.

--=20
Tom

--edLgQj6At/P6ZtsB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVklYEACgkQFHw5/5Y0
tyxGRwv/cfE8cMETjfqPXoZBJvzIKck1Lutgo2QajS++VY2brfzyQqgbEf8ROVEr
g0imICWaPwBJKpp+OzwmTM9YLQ7cth2NqdoRnfwtezp1Rpt9Ix1d8dYm0qRC5GDN
8ke7UunIe5YD20MLfpz/J3liz/5k3PDjJBhCDMu7JllIUHv3weDP2WJMTKEL9vtv
OUpuizceBM/yWSn+gpXlNDsSkK6AiI82fk9wrk/wigsqWCSQEhQ/yJdAZRbau0xe
nJGJPRAmhjgDmiW4KpLJk0DTY6NFfwVFRkykmlLgNQ5MdcPPynEdHsFzotVKmCqD
X1IC4JAX7biHx/m09rJMObm6O/oLyzlS3pC/KfqXzrmu+XkhBl89WbwaI4Eg6nq0
wUzxJdrsNckx2qw/LnLZzpywyi9mcqBCr15WynxBa6lMaoefSMyRvUwVD3yvzpcE
/SthTvggFSmrmv3g4/KxwL1sPnis1ELy/zwbF3fMVthj7ih5PzeOw7caMv5iNCPn
/FmgmOLZ
=3kz7
-----END PGP SIGNATURE-----

--edLgQj6At/P6ZtsB--
