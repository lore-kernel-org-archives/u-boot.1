Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1759EEE6428
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 16:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DBD1840BE;
	Wed, 31 Dec 2025 17:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FlOOCPjp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A794E840C1; Wed, 31 Dec 2025 17:08:12 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9014E83F69
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 17:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4511f736011so6995204b6e.0
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 08:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767197289; x=1767802089; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F9ajNO6EARFiuYd2+g0NCy/Qp4gDgyo9eBuNMk+RYoY=;
 b=FlOOCPjpDYhdnOaGS3hYY0mWvV9lU6+44IaIWPIpvqiigAoL4cOzBHYMT4WPn/7+Kl
 YJgrrx4amm2wrrfYTbFq/GhgcFBVQFm0papGb/kySwcFEXrUcsmaDjsDItTBUNwWtrSV
 b4Ba6wfC0V+dJPB206q8DzlsK/kxjvc/Uoy8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767197289; x=1767802089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9ajNO6EARFiuYd2+g0NCy/Qp4gDgyo9eBuNMk+RYoY=;
 b=mrZIHtFYeoktLIONgpIPEs2MmVr6BmHKuJVPjO9A3//xlZjYn9/h+xohvVoKMW2VsI
 b7VeeihcVPQwMYRNaw0jtpHiCMnVfD6TzctVU/C0/pECObAuKFE36HOIYPOKGXz5XJSZ
 Bqo31yYAfIj23ndR2f+Mg9BlDL1PpvZzzmpn+Gbjgm1MWyq+Rh+p18kW1guZ1uNsULer
 xfCPTaITuAYNXCtl4zC53cOWi6Xvlry7iljwwXSGSvwXhHgsqFjl1DWIMO+YnGPx7s7j
 pLB19z4ReKMROvsQ+wQT60h9qNeXGWoJ2VPWGqzVhl6+LcwrlQ0eJowd54BnJ+YYCmzW
 pXuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN7SkXN+sdy+PceTn+Aici8LC46NIVQydg4ai70PD9x5rJPD9yo+1nxZnBCgZ2I25vsb2Ojgw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywy+hLR8Vc1rOs239at2FXtgXfEEnkvIQrLuM4gabI/1pTq8uQT
 T0KzoiToanJ/9jFTctNquaoir+co2whPJHo8QXCzqR2l4K8ivQQb0+sBCVrCpCQmboY=
X-Gm-Gg: AY/fxX5ByU2N5S0N76vOAPgfomaCSljaMdOTHZvP4yjjyUi2jKSOO2WpSjYJwryZ7fQ
 7o2i8bQ3YLTwXpFXp2v3ymASH9kQWq6xVVv2PTbs4LUm+fh0AE+LWwHQFwRpqA2c/s3qgmJuD6Y
 jD4omnLctaziLqazBAEDdudMlTjkdEOgxPfgvE2qJDD20BHK9TJH+yRR7vTWIIe6VcX7atppXKy
 9CxmKDkQfxPl/wAlkm5f/hUSwQUpyMO2rAO8LwgS086ccW7bZvK/B4+P+xt36zmhYdHk2uxhvih
 DVzQ4+My2DFTaZSLZpvV4YoJ0qqL3y6Epz2ipIRX+CGumj0qk2pLBgG4V0DumYiU6l1AKgTgLv8
 WDtQ2NhNrF71Y0iKH27yMJJsoYZ9chkEL6oXyGYjNOgBiBbR6YpDax+9msck9AEGv19fWyTNTZx
 nEZ7RdVSPL/iDP1AVHtx4A4ZhoG5NdT1LfZbobUXfFobH6Y+1TJmVTe+MpS9e7qsaRvqpxqAMhN
 0+UCeG2Sol8I88h5Ph5wBS0FAmJiyuS/e/+9yxOb5D2XVwOtw==
X-Google-Smtp-Source: AGHT+IEaUr5g2B/Yyxp+HKSTLGpYL8KwgZTI5Phc4wTCze4ySWNx3A3ckkl7JfmAbc0y09GRn4rOPQ==
X-Received: by 2002:a05:6808:690a:b0:450:826e:5df1 with SMTP id
 5614622812f47-457b221e342mr15958654b6e.19.1767197289313; 
 Wed, 31 Dec 2025 08:08:09 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3be18e1sm17716530b6e.6.2025.12.31.08.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 08:08:08 -0800 (PST)
Date: Wed, 31 Dec 2025 10:08:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] video: correct label for cyclic video_idle
Message-ID: <20251231160806.GA710860@bill-the-cat>
References: <20251231153719.84716-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DuckPAMWqINDH+L9"
Content-Disposition: inline
In-Reply-To: <20251231153719.84716-1-heinrich.schuchardt@canonical.com>
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


--DuckPAMWqINDH+L9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 04:37:19PM +0100, Heinrich Schuchardt wrote:

> When the cyclic function video_idle() takes too long a message like the
> following is displaced:
>=20
>    cyclic function video_init took too long: 87707us vs 5000us max
>=20
> The text "video_init" is misleading. Replace it by "video_idle".
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--DuckPAMWqINDH+L9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVVKZgAKCRAr4qD1Cr/k
CvzGAP4m0Ae7jXB/NsIlDFYUzaFrHXDTDZggkRJV3j9jfw9pQwD/bkQuWVCwN0Zu
VWceeTDOPh2yOsbG8/4GtC9Exldz6wM=
=l77F
-----END PGP SIGNATURE-----

--DuckPAMWqINDH+L9--
