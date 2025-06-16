Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B025FC71155
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 16:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15CBD82A0A;
	Mon, 16 Jun 2025 18:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ucdbaPai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84EC682B18; Mon, 16 Jun 2025 18:21:13 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6330281E18
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 18:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-73a5c1d9d93so343860a34.3
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750090870; x=1750695670; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/JUgfqN+RKeK7+QFtqRfwcsL6MHY8ZUiFVULsD73QRs=;
 b=ucdbaPaiNvJOxUvlfyN5RfT3e5re3wQCCx2AVvfbKulS9BE2bTY7vVLdfAmXL9S7LW
 5bogvc1yK4FkxI3NyVOPqLiOa02EzTOBBBdqsdw3ai1PrzWiEvvxLzkVe6LJV/OAl1Gg
 uwOk1kTJVfDXxybvkB0J0KSJWkGRqR/FcQFG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750090870; x=1750695670;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/JUgfqN+RKeK7+QFtqRfwcsL6MHY8ZUiFVULsD73QRs=;
 b=G9otvttPlTwp5/4n0Dre+v8yopQwmpfZHlWbOCyd4gQ6QQ6iL9cNBSqtxAtHxrHTjb
 l5hY4x6kr+vWx9EUlBlVwrorV3xPekdQDYEQl1RvQ8X+r/Yty628S3nOJLwF2S64YZuV
 /MXPklvRqo/pLlI03qJBPNBoM0lNtkemJZNXzR+GNPdcVATKih9zL2++8IkHkvpAi2T6
 M2aSb1qV/0YgWpxDHqCWYMNMK3SXS843Vpi52D4TycxW7wiS4Mhc2kaoryDsMQimP+H3
 P09wvbPaxU8nemASwlIvR3FRpC7s9nBolrUAtUH2vUA3lGwjyGgt1sgkL6RYAjhPJxlf
 5BmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6b3mTm2yJcpEsb3AcHRb17rDvkliZcaiQEua+/cyXX02kqrJhQ4dTjbS0WiYDzQPHBFWlHp8=@lists.denx.de
X-Gm-Message-State: AOJu0YyxENbXsJgayHq2A29HvdjT9ZodRx0lRtoUFiRyOriP5ge/yUT9
 zi99Vo+mdRw4Te9Slt7AMfCcMbmwk1H90ZaY7KXGgV68J1cEpS9Slwlr0Uv3HZDYAaW0gvJ4Kwd
 AtBzg6DQ=
X-Gm-Gg: ASbGncvGrkMkx4ClzbznjB/W4v1qZ9qveg8/ib7oRomTsXDER6cQsNv7cvslxE7eeYh
 OaYu/id8yRnQG8bvKSJcBsYs+RmKHYjnNpUepf90xbwDKKki64ySGEUmVvgM45vUdBV2clGELuU
 WthowawLZXB6UIdCrxf4bgZM6gg3DioYIvBR0zVAA7uq2nfufBBWId3fiiTD83TmG+RrNyahdm7
 xOyVrvKhNxOeLVE4G5RDlZWjVYsONjpHwv3q8N9Yuty7XgPOgcIhnOAwfYkCzmubFXml2UScNsr
 1zWpkVYLopLHj+RN5h/lHiG+D5s35EOH7AwcnyPaS4mcZnzHytcL1UbSLi6h2VE70ET+m+LnTEt
 3MQ97YR3q4CNNrsD8Ss+JqbY=
X-Google-Smtp-Source: AGHT+IGXQUWndpUm4AFiXIXl4vcBcE+U9YWgMisFgWna4Vf4uvrAJKQbixZgG0nwjqcATK2NIhFLPw==
X-Received: by 2002:a05:6830:710b:b0:72b:940a:a7c9 with SMTP id
 46e09a7af769-73a36470dbemr7226424a34.27.1750090870056; 
 Mon, 16 Jun 2025 09:21:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a285313bbsm1255078a34.45.2025.06.16.09.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 09:21:09 -0700 (PDT)
Date: Mon, 16 Jun 2025 10:21:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Heiko Schocher <hs@denx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH v4 1/9] configs: run savedefconfig on
 qcom_ipq5424_mmc_defconfig
Message-ID: <20250616162107.GG1382132@bill-the-cat>
References: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
 <20250616-geni-load-fw-v4-1-e7df44205505@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="noq6eGrV/AjgmAVW"
Content-Disposition: inline
In-Reply-To: <20250616-geni-load-fw-v4-1-e7df44205505@linaro.org>
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


--noq6eGrV/AjgmAVW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 11:44:43AM +0200, Casey Connolly wrote:

> Regenerate this defconfig since it seems to have been hand-made
> originally. Some options like SCSI were enabled in the defconfig but not
> in the final config, it seems like disabling SCSI is the correct thing
> here, so no functional changes.
>=20
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  configs/qcom_ipq5424_mmc_defconfig | 67 ++++++++++++--------------------=
------
>  1 file changed, 21 insertions(+), 46 deletions(-)

This is fine to do, but also please note that generally I re-generate
all configs from time to time (nominally before each -rc, but I do
forget) so these errors are cleaned up over time. I assume this is
needed for a later part of the series, so JFYI.

--=20
Tom

--noq6eGrV/AjgmAVW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhQRG8ACgkQFHw5/5Y0
tywJIgv/RHA/dvPfhM/BNW9ajtyN78dXllQcbpFnGtFjokR3uUDF6cdHGWDEYILd
81PA4L+2LPEWH+Pgm2BY90cZKF6XMxPSj4atsR5qZYWI/5pQftcmTCbMDkZE4jwv
7MTFZr+SEtCAtVbzFBj34KZSFjBwvFgB5MJ04e1/c/hLLvtlBBYfG+0rGaZEGylF
aU05td+u1wVuPmUPfXl6AmDoJQkOzE7AF1JTfLUEExyh5IjmMNGJwU7ESCeO9J5/
yoSwD3YAuit3YA41/Eim+MvIjnkR2C+hISSWuU+RmUdWCncWDB3LJK01RlUsR+FT
lJcNes2ehSBZq3NvSI2ooPxfx7YPApPObbZQUr0sSttO78fOdJs9riaYT9mHoWQo
nrF5Og/apReauqHjxp5VDBZ8nbrmhtUg/q1LUTu0EfLww7rD1WADn2OAJD335Hch
bpFETvyJyzUnK/L9x5C7YBTigjh+gM5ohSe3wMZ1+L+tqS2brecgC/iN2Zfx84Yk
WZ9h0MvG
=N3y2
-----END PGP SIGNATURE-----

--noq6eGrV/AjgmAVW--
