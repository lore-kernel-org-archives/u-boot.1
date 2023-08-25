Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE76EE49AB
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 21:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03DA186A91;
	Fri, 25 Aug 2023 23:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MtgpAgZ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15E5486AA6; Fri, 25 Aug 2023 23:51:54 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C41586A77
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 23:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59254e181a2so16543107b3.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 14:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693000310; x=1693605110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zcubOx06qvsxfY9X8k+UlCzx6JtZcDnnSCnwgofGmWE=;
 b=MtgpAgZ7xoTm8XoNQxaCASD3hwPQEZKKdSJ1OaBlKa+PQC3D8xnTF48zT4uNl9XNO3
 /MAYGtgFl4Ci/MEQ6BuxqDtPm0BPw+I5SzmLQuDfcyG1R/9OAxWUfgBoYO9/rOlWqRip
 g0XZ8uHzGH/C6NLBQCmvkOYwiqUNjfHwHRec0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693000310; x=1693605110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcubOx06qvsxfY9X8k+UlCzx6JtZcDnnSCnwgofGmWE=;
 b=iYyJ+fpdHN5LNChjnM8xS4Xg/2TlByRE6Zk7/gsNwLHP+cRI2oL72P6dnJ2JQLeqom
 230LRbM46ZNcicFAlPZCsRMFks9LFf/6kwpQ68HYM2wt1YnhmM2agmd7fOVs3ZIaKypK
 CrkOgaqrUL+hGLPVDF1Lr59MF8baVEKPnwE2c3v+Nhw8nJaLwk8T8obkCF8OJf7DVsRx
 ZcJc2BoEZkt3W8tErb2u1rvdm6n84DbgS1zCPJOeI6z4c89bmyhnDL92xAw3kPrfLTv4
 92T7ZChb0QjFYMmPmFv4gwjazm2WXk+B2BA2o059Kt4GtvOIzjZqmGbWn1FgUp9F3nFJ
 d8bQ==
X-Gm-Message-State: AOJu0YwjE+x9sIelz8Aiyd7j8Mt/7u5dvT/XpeM7Ak5XVebIKvjYvOa6
 dQiuGNQdBMArCwVra6/ws86/9g==
X-Google-Smtp-Source: AGHT+IHbjFYK3OzIZsy/odx2Q+1WeWSRXObkBSvWFPJgMfMP5KNpFiCSNt048zzlbApQdvOflciYkg==
X-Received: by 2002:a0d:d956:0:b0:592:8147:b576 with SMTP id
 b83-20020a0dd956000000b005928147b576mr5800392ywe.34.1693000310093; 
 Fri, 25 Aug 2023 14:51:50 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fcb7-366a-fd11-1c19.res6.spectrum.com.
 [2603:6081:7b00:6400:fcb7:366a:fd11:1c19])
 by smtp.gmail.com with ESMTPSA id
 x144-20020a81a096000000b00589f4021f84sm728628ywg.37.2023.08.25.14.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 14:51:48 -0700 (PDT)
Date: Fri, 25 Aug 2023 17:51:46 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V6 01/20] include: env: ti: mmc: envboot/mmcboot: Check
 result of mmc dev before proceeding
Message-ID: <20230825215146.GP3953269@bill-the-cat>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VNgdwNGl1K4nBeRe"
Content-Disposition: inline
In-Reply-To: <20230825180305.69515-2-nm@ti.com>
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


--VNgdwNGl1K4nBeRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 01:02:46PM -0500, Nishanth Menon wrote:

> If mmc dev reports that the device is not present, there is no point in
> proceeding further to attempt to load the files.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--VNgdwNGl1K4nBeRe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTpIm8ACgkQFHw5/5Y0
tyzz/Av+LrQrzobcGrTMRSiPXovlLgP3AJ5O73FX8tdBISSaT+PrhprxphHfrxwn
WPknp9VI+Vgo9VnKaZx49o6JRrZtJ6dVpzhq/Q7mn2dm41j8e1q1f8fbFE7RHW+y
PyR4q6hAPbkdRfMBPFrJvBHOkK6nPz+euAoXErbuSPttF2nnI09oAeQ6sYmeel4N
QqoaatSSA6mMwSy/CdtLwizzh0bAl6OZQQKpyNGJovTDxFx4kSE/P2jJQ+Ni2AQl
9AqgPcWQ66649Hd4TiS2LuYIULchCTZ//xK2yyUzsiO/fVkL07CSk3kI0jyHymtZ
32c9SEG6rTyZfg+cTqLWpEJhjYqxxUzcWDz/RoN4f1jp1B7sUe1o1aXoVWpuejSV
OU/2nto/aJDSIFZn29QT5kux7edaM13wnR0+VtbpurVdLxK54C+ui54C/p5w40/0
bZToBxfOYuT3dyvla5lXyFUUk3Cj/K3e6FHgFE1eZ1t8mvMQlBvOwtucROhSh9Uc
rAR6t44C
=z5vY
-----END PGP SIGNATURE-----

--VNgdwNGl1K4nBeRe--
