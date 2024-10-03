Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53BBCF34CA
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5339488CC5;
	Thu,  3 Oct 2024 23:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tlyjJYLs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D72C788C6D; Thu,  3 Oct 2024 23:57:33 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 905E588CC5
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-458320b30e7so10130481cf.0
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 14:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727992649; x=1728597449; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eP6tAoGNLQiwRiFBYhm7anbQzway19ERcmkcQNK664Y=;
 b=tlyjJYLsRQWSjh8QC6+NXqjbDSNKXFdxgKNw+7Rdqt7khz91UBXTY1jH+B1ypvopGq
 ZpsMPOtLfi27phL/S9V0exAgKduAZd6bNVlHsVHvXfZ4rO4b5XflEWM7oPVxR5vu3OXC
 XCHPNd/WjAonT24ncPxY+WxbbZOqcMPD+UZlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727992649; x=1728597449;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eP6tAoGNLQiwRiFBYhm7anbQzway19ERcmkcQNK664Y=;
 b=m2ZF88yH9qK/fPROW9+dKfmqbUqzzthRdApKs7aX3vCPAIF13DP3ps0b5oBSlmlAgl
 fqNFw0P1WNUSMVx0XpQwONngOndRAWUkLIbdvM2WQP00c4Z8pJZJTRLx3M8D9tfazye6
 uxev2WDlrxonIZ5XNDOYvRwVTlesDmKw+8Z2Fyi3T4QmYBIzZ2dhAyZX4eoMjs3PBfmA
 qMtXSYwArVbfqV4z9QiEYdMX4Ht6ZiYhmpS8UkJMWtNm1ABCm6f96ztKADnaD563NLzv
 vUp1Jor2YM/ATvEsppVK7rCXV/s7vCkvbKNcopdd7rSj6qYc2n4ggo/bsTRkxMmicVyE
 8agw==
X-Gm-Message-State: AOJu0Yy8u+IY/6ETH5ddhLEdgaWubhloBBmdvPRN7/TxRFE3dsW0F9uu
 htoH7r5OkxroFOCUOlgOSibMl+10yT1LS5wAMm4VMpsXwA1MthTPyy7DjjfnMH0=
X-Google-Smtp-Source: AGHT+IFyLGgs41arfGB9yzGZG1mBrFJHNbhDjL20Hz4soMHg8+4Vy7wQ9ePIrt0lclrwTCSSfFhwAQ==
X-Received: by 2002:a05:622a:3ce:b0:458:532c:1e27 with SMTP id
 d75a77b69052e-45d9bb7fa90mr8176511cf.56.1727992649349; 
 Thu, 03 Oct 2024 14:57:29 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45d92f059acsm9069101cf.89.2024.10.03.14.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 14:57:27 -0700 (PDT)
Date: Thu, 3 Oct 2024 15:57:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v2 13/18] mmc: Add more debugging for SPL
Message-ID: <20241003215724.GA2107876@bill-the-cat>
References: <20240920072444.134997-1-sjg@chromium.org>
 <20240920072444.134997-14-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W4VLqohF0Sxxn8tt"
Content-Disposition: inline
In-Reply-To: <20240920072444.134997-14-sjg@chromium.org>
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


--W4VLqohF0Sxxn8tt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 09:24:37AM +0200, Simon Glass wrote:

> When MMC booting fails it is sometimes hard to figure out what went
> wrong as there is no error code. It isn't even clear which MMC device
> was chosen, since SPL can have its own numbering.
>=20
> Add some debugging to help with this.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> @@ -76,6 +77,12 @@ static int spl_mmc_find_device(struct mmc **mmcp, int =
mmc_dev)
>  	int ret;
> =20
>  #if CONFIG_IS_ENABLED(DM_MMC)
> +	struct udevice *dev;
> +	struct uclass *uc;
> +
> +	log_debug("Selecting MMC dev %d; seqs:\n", mmc_dev);
> +	uclass_id_foreach_dev(UCLASS_MMC, dev, uc)
> +		log_debug("%d: %s\n", dev_seq(dev), dev->name);
>  	ret =3D mmc_init_device(mmc_dev);
>  #else
>  	ret =3D mmc_initialize(NULL);

For the record, this change, even with debugging not enabled (and LOG
not enabled) is not size change free and does not get optimized away by
the compiler. I'm not sure off-hand if there's a clever way to fix that,
so I'm not blocking the series on this.

--=20
Tom

--W4VLqohF0Sxxn8tt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb/E0AACgkQFHw5/5Y0
tyyWeAv/Rr6l7of8l8mr/9YjSmnhUx+WAR6ltZCdRB4SvVSC/6jwsievXNO/6t7C
voaDfgLi1lmwpRSoH4yeXAJusawCSXyF2h5ntuic9FxMARpUUEFITINyh1QOf/+Q
weQlveooaYiTCfllv/25yfzP9sZ81TTcK5d6Ybwd1wHZnrl8QvOFp1SsG+U0wVFU
j1R7GriqFmWtPn5CY/n+oClHoZhE8E1zcXMldA1X1uNu1cAwy+7Gf4Fy4Yi2SJBB
LBONjQgHeV/TCuEYES8Lg9y3wE2BxKQ7mzV19x6Q+9mifyve9S3boF0jK8UIfe1P
RsmZVMsex2sqwfaf7YC4Mb89MKv1JpAzeioBUYxKPKBLKZYjHVg+/IpzWV3nzt0G
KLOmv6IE8qmiJRMyFnMxdaNV/tUGUUxLOxo8fN1wTaGyL3qgnEFkIOdRPKKxbCHj
zGk5Sq8F6ZRpTO15ihckioH61Sw+BPOpB7v5Ts/HREBjs2VxBLldUL5hjp64EPZf
RsgrNoI0
=t3mv
-----END PGP SIGNATURE-----

--W4VLqohF0Sxxn8tt--
