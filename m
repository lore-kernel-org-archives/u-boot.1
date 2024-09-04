Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56B2CD4F21
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 18:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03EA888BC1;
	Wed,  4 Sep 2024 20:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hnk7nQch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5D6B88BC1; Wed,  4 Sep 2024 20:14:41 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40B7688C0C
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 20:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a7fe683c99so371419285a.1
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 11:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725473677; x=1726078477; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LAoy79ryMGjpc+T3QyfZp3ujzqdnDJ5l2rQh67II+A0=;
 b=Hnk7nQchsdooyecpsq/+AmUUdcyTGkuFQp40HvJrenpX/c8oA7gpN3qHejxtls73Vo
 +Td7mLkijU9bwzkxxeiSaEp0iP/JghI/4TnLUj45UGbOz7fFvziY6BA9733Ag861nwmY
 +mpQ8NhTLO3WmGn/HOrejlYiiZk0unOKVdpV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725473677; x=1726078477;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LAoy79ryMGjpc+T3QyfZp3ujzqdnDJ5l2rQh67II+A0=;
 b=f2haBkS7LP0HI1H015KctO6WoiNG4NGJIp+I9ej1fQdiKSq1pzM/QnzrVL07L6SXDB
 TWKZxeIROZTo2P6dyIN5CVD206ABfYs3RUv8WAhLNi8vquQADnjyBrnBVCYSv/f71ZHz
 dMG1ZHtJJajLqfgbB2Sm6Cy/UG1vhuDpCTnBbn0y6fJ3x+sUd4esGTg27nExgnb/KPnG
 cxpbfOOgCSjGjiOcKxWIsTFkRcpaOQ3TyNA8dBTHVDQw3okJonZO7agNxpWROSIroUR3
 DNxx2JTqozvLlSszIOWSipubBazDniJbrc9/L9y7wOmNkBhCfpzNX8N52TQvAzF3Bi6Q
 ZPrQ==
X-Gm-Message-State: AOJu0Yxk+cGZgcO6OAbNXaxpd0yn7gDHvXsO+94YsAh7N2g36QE7h//T
 FqSY4lhhPG4soJ81Pa8gXCLjdQ4gWOWLf8SlChx25qqY53Pvi9o7N7NvdpQ103o=
X-Google-Smtp-Source: AGHT+IHUVxRoz2ezADqQIUqfxebEoY/f7J+ixAJxJBz0CcB5I7/YN9cboGUaHoSmNI6n/sIGnl8A8A==
X-Received: by 2002:a05:620a:40d0:b0:7a7:f809:9f3f with SMTP id
 af79cd13be357-7a81d67fd03mr1914218285a.16.1725473677098; 
 Wed, 04 Sep 2024 11:14:37 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98efed697sm3993285a.81.2024.09.04.11.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 11:14:36 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:14:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 12/18] mmc: Support driver model in TPL
Message-ID: <20240904181433.GW2479150@bill-the-cat>
References: <20240828014538.3322013-1-sjg@chromium.org>
 <20240828014538.3322013-13-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SC2iDxmmM3rdtZym"
Content-Disposition: inline
In-Reply-To: <20240828014538.3322013-13-sjg@chromium.org>
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


--SC2iDxmmM3rdtZym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 07:45:31PM -0600, Simon Glass wrote:

> Some boards want to use DM_MMC in TPL so add an option for that.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  drivers/mmc/Kconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index 982e84dc3bc..2b55ddb7af2 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -61,6 +61,18 @@ config SPL_DM_MMC
>  	  appear as block devices in U-Boot and can support filesystems such
>  	  as EXT4 and FAT.
> =20
> +config TPL_DM_MMC
> +	bool "Enable MMC controllers using Driver Model in TPL"
> +	depends on TPL_DM && DM_MMC
> +	default y

This shouldn't be "default y" as it's adding 128 bytes to TPL on a lot
of platforms.

--=20
Tom

--SC2iDxmmM3rdtZym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbYo4kACgkQFHw5/5Y0
tyw2qQv/V/5i2x8K0RiLlwWWkM2/WfKWUvUtuY50pW8+aFdkaWyO5A11CXYtfyRB
Ww5Z+lNh0qLyOkJDMmw/AHE8VS/mXXzfFmnA/6TQx9GChglDy5iysy+qXOn9HrWk
AZsMmKTSQyAXRBHFhFA/ZFt0562ZUWxsp/KQsZgK1o5YRuWaK65XqVIoOOfZUyVC
4NnVcn5qAEszbPINSLKczuZGIuYH4bLCroY/b1F0QAMxy8AaY3jj1hfHOSPw6M1E
ZHQ2JisXdKFRBwYRdIt4zX+eoq5ZNmuL53tYwE/FqHZYoVxYZq6dLVPPh9Ap6+RD
N2GSDexsG+4SEcyuJjjoygZopqaqHjUUf5iXLR4Ng0OTH8yBCmZVt5jKJnjVCEXk
qg484zPtjy3tZveZCUqYiw3gHEkS3nJkeAZqFOuNGXjVxoTLsePKpw4/Hu66z4v3
ZctdK23ojJoj5V2WFjD2tWzdRWCaugMqB3zp3RS9j+DbrbsOuzwPUOUgJL4f78su
nsMXk+W3
=oZqP
-----END PGP SIGNATURE-----

--SC2iDxmmM3rdtZym--
