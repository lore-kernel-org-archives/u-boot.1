Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5342E77188
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 00:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEB078022B;
	Thu, 19 Dec 2024 01:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PZYJe2iY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C501B80241; Thu, 19 Dec 2024 01:51:27 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34EBA8021D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 01:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4678cce3d60so1855031cf.2
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 16:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734569484; x=1735174284; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kbHat80x3P6YNRy+cLcWhuTctvJAOkfiHBEv79+Rgys=;
 b=PZYJe2iYzVJMHQm8pC6RTVTCTTsK20kkdvKMzeW4ApUUMm1ql0Jc3OHMl76LxR2caE
 dDgOUMAqzqKsh+2bOHdl9PNyYXSf5WdixKJaZI7tI2DqJII4tMlv5CkS74ejmq51p6NJ
 Dw6KIlXpp3yzLXWUEUj0UPYLn0ifDrLznKE8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734569484; x=1735174284;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kbHat80x3P6YNRy+cLcWhuTctvJAOkfiHBEv79+Rgys=;
 b=dvI8M9UCmMp2YpeYsNBhbGUuGbv/tE5g9p/RLb6e/6/t3DjQp+nVMrR8TfZ4wjZZti
 xMc4gDgWf/prWu9TmbEbowmAyo+VlUd2jMrN9yVdjHun9/jXl+gLP7PisZ7rBM3JA5QL
 jQMawL1k/kBgNwgsccg6YvaAKHI4h61cJn+GrGBvR0UR7WJLqu2Zi1fSIN1ij/GZoSZk
 OXfjUBt+iUpyzHC183OqdQ1Qbq9geBTijQmHdYW7LmewooHA31OA/tgMmFaftr4Gd9wc
 /0cpzcSarYUnwCSZ4u4JJk/hLLrGyZbTPzdGfJA+KpaCvQdKNoLshQsH6SDJtgPsnm7I
 fXJA==
X-Gm-Message-State: AOJu0YyzD7AX9kAAbJvIV/hMVojgAc3W3MTqrVycQQOhCkCjgM3CG11i
 F01UR13WbiAJIPT6nnfELRSTKvKld4m8g+LzfPPE8Xgao+co+cE9wB4CxDR1cJw=
X-Gm-Gg: ASbGncs4IVUPQg6z72MA3nmMZ6WEy5RejkRM04nRJLm6espuIYwxEsOU2y+VD3C5N9P
 2Po/CVXZcpGlNwReoJsz7VpbFKhJo27ZJS/xb4nXg6OiPAD7P8sGoC/lTgcfjzyBeVuzD3THSvs
 aoF2QRuPTAfxb61YmgcTxPJ01/MQAnmfQ2Z9Sge83Y4CcxmMbGjKjU4TFni29W8CpinNI8mIPrL
 ebERV9dq1noAFsph/2U/OIjEQmJxN6XNcPtFCljJlj6f0LhrqnfvsLe
X-Google-Smtp-Source: AGHT+IFftJY5lDOUAssO2BOui0S9JH9CkAAw2vWNgFp/MqqdNX/XWu7x9gse+7ecil5swoEJNTPizw==
X-Received: by 2002:ac8:5d93:0:b0:467:6b20:e0b1 with SMTP id
 d75a77b69052e-46908db2398mr76189281cf.6.1734569484048; 
 Wed, 18 Dec 2024 16:51:24 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e6a6d1dsm819391cf.45.2024.12.18.16.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 16:51:22 -0800 (PST)
Date: Wed, 18 Dec 2024 18:51:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, paul.henrysd+nodisclaimer@gmail.com,
 sjg@chromium.org, al.kochet@gmail.com
Subject: Re: [PATCH v4 3/3] tools: binman: Add tests for FIT with data
 encrypted by mkimage
Message-ID: <20241219005119.GA3555833@bill-the-cat>
References: <20241125174717.1181452-1-paul.henrys_ext@softathome.com>
 <20241125174717.1181452-3-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G/ut75ZOHJzNj1tX"
Content-Disposition: inline
In-Reply-To: <20241125174717.1181452-3-paul.henrys_ext@softathome.com>
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


--G/ut75ZOHJzNj1tX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 06:47:17PM +0100, Paul HENRYS wrote:

> Test the property 'fit,encrypt' to encrypt FIT data.
>=20
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes for v4:
> - Update the tests to use 'fit,encrypt'
>=20
>  tools/binman/ftest.py                         |  45 +++++++++++++++
>  tools/binman/test/343_fit_encrypt_data.dts    |  53 ++++++++++++++++++
>  .../test/344_fit_encrypt_data_no_key.dts      |  53 ++++++++++++++++++
>  tools/binman/test/aes256.bin                  | Bin 0 -> 32 bytes
>  4 files changed, 151 insertions(+)
>  create mode 100644 tools/binman/test/343_fit_encrypt_data.dts
>  create mode 100644 tools/binman/test/344_fit_encrypt_data_no_key.dts
>  create mode 100644 tools/binman/test/aes256.bin

This fails in CI:
https://source.denx.de/u-boot/u-boot/-/jobs/980030
or
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10169&view=3Dl=
ogs&j=3Dc59aff74-743b-5f08-f408-4a608a489153&t=3Df2ea3536-b291-5a39-ad92-02=
20c9b8101a&l=3D300
Please see https://docs.u-boot.org/en/latest/develop/ci_testing.html for
how to trigger Azure yourself to resolve these, thanks!

--=20
Tom

--G/ut75ZOHJzNj1tX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdjbfUACgkQFHw5/5Y0
tyxAtQwAh8boB9AW2ts0TO0ahvGbu8rilP+CUovWiLdRNSFKlCUvPpVwOiUQM3Gt
C2Kq+UZdigmXgkx0mFHY4lZCUgrzqIGT50acqpbp5HKBOiD/pbcF+HXitZ2srQWB
JetTmiqfpp7A/a4AwYlBiSyX5coT1CjiUDZcC1GUlrpJ684/9y+AXHZLeW5fipvg
ForQW7f/oTHq6UXCdqe9kJ0RkuUIE/p/hZw42mG1xsp+n7xELNgQad6aij2AIWCD
Qv5HBHsfQmZ92klSYNdgErehkSek4cFLAK/Thps/t9IXlZp9Q1/D+ZVA7BVWMaZc
GtK3l4/QtTub6toZxfN+JkNyKSinM0U+VKKA+CvnC4zYw2Z0WmngtpxtPHJ/U6uk
CVeKGFq6sXA0AQsTqg4O5pCbE2QPegmaa3/QiqGUFDS3VQtA2s8zOqb6lSTGdtzM
M0JUganHDNKSkBxJBzbBbPmvLtoGJGdXcYRmllegdgue9cyZDfX0B3bBkbSRFam9
ohV1ZCHg
=GBul
-----END PGP SIGNATURE-----

--G/ut75ZOHJzNj1tX--
