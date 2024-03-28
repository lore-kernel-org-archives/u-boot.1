Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724C6C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D338881C1;
	Thu, 28 Mar 2024 16:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iEt1B9yo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF73881BE; Thu, 28 Mar 2024 16:09:41 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FCD9881BC
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 16:09:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-696147fb5a7so8942456d6.0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711638578; x=1712243378; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I2lh8q2YWYvuVsNb3dn7SJHD+zkjRSWTkdwxidhw0h0=;
 b=iEt1B9yoldka2Z2Mmw1yIiXZrYxp4xWBjJkjtJC25Lf5qAwghXmOEwMiiAFFZlY5f4
 0JrIToJk7pFWE4pldN18qzApI2OWOucfFVSGKaInpwxrV21ItMPqfiOdf+2mWwJovC4a
 Ha168RimWGFrKgmFEYsbZEbkSdrs2oorGxVAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638578; x=1712243378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2lh8q2YWYvuVsNb3dn7SJHD+zkjRSWTkdwxidhw0h0=;
 b=TcNpUPxiSFpvoWLnzq9zcZyZmJ5r8VzYCh5hZspodKCmxPiD/2xQMyFVhwYwYOtRfB
 PD3Migje4cOhvsQa33hWM1VaStMFDcAYS9AyNEEZOOk8753mfGpFF9udErRWl2DZzLfp
 oPBS/h5uz6oC0qxyaPCr6NMjgmPc8yhHWLl2FLqJVg1Gt+bJ08TQ9s8XLcY4mZ2FwoBj
 WSRh5BoZ9P3eDzE99icQi2FmCMURpj64K5Xigps9SkcwW9+Sxt67G/aEFAWhkierddp4
 YhP2ybQMhI8iRDLpKBlMFGVEBhU/jsnCHHtd9Kzt92PAK4fakSeEuzk530qsENkMoNL+
 MIHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVfJpaHBUHXEBjwjdrECsrvZVhwpiaRhS0qW3LE9fXWFFHSTg8gHQqis+o9vR7BL8ev2Ag6I5M7ZBkQT/T6tspHeATQg==
X-Gm-Message-State: AOJu0YzsCc9+ULaJObmkY0++9k+xG92lshkOacFJeAbCu0SLbtieF0Dq
 b0BBWLu7sTVER0dk+PerMUxts18jP03x1KIagbS6oYN49dvEh6lzgenAPEOFPr0=
X-Google-Smtp-Source: AGHT+IEOgxkSQIMmCCpbZYqz8Jpr7B5Ba+CnS8HpZVhW6B5UwS9/S7zTqvWEuPWuKsWNAm1cZImTwA==
X-Received: by 2002:a0c:f704:0:b0:696:93f3:7cb3 with SMTP id
 w4-20020a0cf704000000b0069693f37cb3mr1971188qvn.51.1711638577908; 
 Thu, 28 Mar 2024 08:09:37 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 t1-20020a05621421a100b0069682be3e86sm717211qvc.125.2024.03.28.08.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:09:37 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:09:35 -0400
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>, srk@ti.com, s-vadapalli@ti.com,
 vigneshr@ti.com, r-gunasekaran@ti.com, danishanwar@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/5] configs/am62x_beagleplay_a53_defconfig: enable
 DM_ETH_PHY
Message-ID: <20240328150935.GC3442575@bill-the-cat>
References: <20240305-for-2024-07-beagleplay-eth-v1-0-e1294a575cc1@kernel.org>
 <20240305-for-2024-07-beagleplay-eth-v1-2-e1294a575cc1@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="76cLybKAkQV337qa"
Content-Disposition: inline
In-Reply-To: <20240305-for-2024-07-beagleplay-eth-v1-2-e1294a575cc1@kernel.org>
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


--76cLybKAkQV337qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 03:24:54PM +0200, Roger Quadros wrote:

> Reset GPIO handling is done in ETH PHY Class driver.
> Enable DM_ETH_PHY.
>=20
> We don't use Fixed PHY so disable PHY_FIXED.
>=20
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Applied to u-boot/next, thanks!

--=20
Tom

--76cLybKAkQV337qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYFiC8ACgkQFHw5/5Y0
tyx8SQv+LQLbFgyQHOPd7KedY+xJHkOCsy9c8XlVi7FtrC5XhQWMR3iMdhfj3xVP
cy86fe31InLHjx9dXUbgG4JE/ueodW4kokCZH1lFk53M13PShtf1DGDjF5FoKjAb
QMtxF4wZS3oYGARCCP7eiZk8gLe1vdXkNRVy+SUqZF9RGaog+1BFT9a6/oHbYHMI
YFoTWDvUN/63ScPdWJbhASo/yMjwDNxQOvSF+JbFolrZr8FvIEdvSFukKtT50I+U
ewdf/56CjdLTptQuJUtk1cw+H/Oyt1oyuEE0VkKpb/Hkc+p44B8TsUBk9QfyNaCC
mWld8lzm6SCkRUeukXZhhwUwN+HUUBgw+iaVoDgD2Jm0dxeRf53gHRvDkZKcEhKw
bWoIWUcLMqHBIGx8Dlbxa/wXwmtm7H7B7/e6dQ7Q01bZTo8nHoDMsPalLoCBkgAH
uHWOOrUuxoGT+vvfj1vpXHo2JxU7gtqp1AAbItu/PsPpBDpVqfq9BdT9FIS8nV3a
a7S3/0/d
=3qJS
-----END PGP SIGNATURE-----

--76cLybKAkQV337qa--
