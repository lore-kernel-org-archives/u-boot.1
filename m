Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D457E95A61
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 14:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C574286D29;
	Sat,  7 Oct 2023 16:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n9Cyphv0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E26886C58; Sat,  7 Oct 2023 16:18:05 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABC6486BD1
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 16:17:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d865c441a54so3421630276.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696688275; x=1697293075; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KCkhHv1ypms0KlPBuYkdL1kerAkvdW12tBtJPKVM6ls=;
 b=n9Cyphv0XgkEplORpHrjapZHtnt9NTS+zPfU7E0lNvtgc19AvB39sk1XHim0TjhBp6
 7kRY92XVx1tTvvaej1Ch/+Jgg9DKNQEdaqFTZJ4ORrfi7/i9yltIS4jAJqdUpRboaZst
 gYXBkVc1JqLeIqN+X9ck4DB53N0X+w1GnrcxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696688275; x=1697293075;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KCkhHv1ypms0KlPBuYkdL1kerAkvdW12tBtJPKVM6ls=;
 b=EN6nMPKZRSIhuYqcGL0mp5CQiFF5XoNTHzuOKGg8tz3+mz1darTu4KyEiPGHFdbKyg
 qqMWpsVC1tDglflPMVzQ+mmGsQRTBszDGKoiptZvhEc//9bvK+HnxGRCez6WTWxyfMjB
 2b3pVMztgzCUqIs/CkntI5etEdXcQgAEzD8iweOT/Gs6Z3cNvxZA/s9HRsg6r5bqoW7J
 TJRsm3wYgAbF5VyDLHaXRtCGJBTwILMkx0Yz07Yom+6pYHHjG5Sfnfoseh94Lq7amHKL
 vAV58tFcJeI8AhTNqSJKEMMeqhuxTIsAjXg44VFARTjAxsQ9vbQB87tZm0Pss5+a0LmX
 KlpQ==
X-Gm-Message-State: AOJu0YydY+WvSxs5EgCRxcX9SDfSWO0HT3dFhb1j+vmFklFiTtyDb3lo
 RMOlDB2ENXpiYpVo46AyDpBt4Q==
X-Google-Smtp-Source: AGHT+IGmn+6lrnwfYJ7xJAJbccp5CxCXcqc5RBtm6ADKK2Ag9536t6C6JVTS2UAwPT70b3aDSuRM6A==
X-Received: by 2002:a25:d352:0:b0:d0c:15e8:97af with SMTP id
 e79-20020a25d352000000b00d0c15e897afmr10218216ybf.5.1696688275381; 
 Sat, 07 Oct 2023 07:17:55 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-429b-02e7-f294-8f62.res6.spectrum.com.
 [2603:6081:7b00:6400:429b:2e7:f294:8f62])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a25fe05000000b00d81bb7ef494sm1707781ybe.19.2023.10.07.07.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 07:17:54 -0700 (PDT)
Date: Sat, 7 Oct 2023 10:17:52 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v4 02/44] spl: Use CONFIG_SPL... instead of
 CONFIG_..._SPL_...
Message-ID: <20231007141752.GG2227687@bill-the-cat>
References: <20230926141514.2101787-1-sjg@chromium.org>
 <20230926141514.2101787-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V5vejkwmFdQFOouF"
Content-Disposition: inline
In-Reply-To: <20230926141514.2101787-3-sjg@chromium.org>
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


--V5vejkwmFdQFOouF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 08:14:16AM -0600, Simon Glass wrote:

> We like to put the SPL first so it is clear that it relates to SPL. Rename
> various malloc-related options which have crept in, to stick to this
> convention.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Martyn Welch <martyn.welch@collabora.com>
> Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>

For the series, (and except for the defconfig resync and the single v5
patch), applied to u-boot/master, thanks!

--=20
Tom

--V5vejkwmFdQFOouF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUhaJAACgkQFHw5/5Y0
tyxfFAv9FA5UtVwzBxl3nOmlqBB71LGoABVTAeuH7892qnlfymvtzh1G5g4Zw+hj
WjGmOHSDyMade5YIlmt8aFQPZiQk72drWASWZXVdnDOHcNMWwgnlrDQY7gvr2bp9
1feMZ76i+3ABPUN314XyiY1yTJP0D5YYZb+FqZWhzNwPo2vjbOa48yVr7FRhyEKT
e1Flx1EpHrllU88w6Z5lPDLwUmwwHj/7U4boeeBOt9aKJM6EjI54ADRaCDd2r3tP
GeAPHwPmAOEijz2iWgPmtSNGctGhgdzy/xnk5sk76cU4a13el3UGuEvupquiTGXV
Xwc+ZCRO3Tocdcufr1M0BDhWQPOvlxUyNHbPT+IT4nQzk+lgVJCUH12eFDSVhbL6
HQABEHCU5EkvsizoYXpiISxpSXLGe39ZAA+D+4Nje6LxmB/wtEkd9NyQ7hBaadnb
EUtPyzrMr3z1WcjorcE/XeYbhZ3x9LwNuWPdHzNU2tE65sfLOXxlU5nnzKcPY13N
qDb+3n/j
=OPjt
-----END PGP SIGNATURE-----

--V5vejkwmFdQFOouF--
