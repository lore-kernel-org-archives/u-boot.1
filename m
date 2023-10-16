Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595B9CDB483
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04FC686DFD;
	Mon, 16 Oct 2023 23:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pbVq8RrD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8684B86D65; Mon, 16 Oct 2023 23:32:02 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE95686D4A
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5a7af45084eso64381357b3.0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697491914; x=1698096714; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+EKBXNE7FHc0xYJyR+X7jNQv+jfiqB+nE56/cO7ty64=;
 b=pbVq8RrD2o65rvpD13s+MMEcCrFSb25YwDUIVP0tSGOD7nJwGv7jN+SQl6NTI2jj07
 0ImyJhm885uHehigzPYHWKVd62MJ9LIK/Z0s9jr0Ub2Uqoj43x7dLjAE+EtJlle2KIJi
 6hbGB3r8cnV9+iptpM/FWIEjaV7u47WZkWojs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697491914; x=1698096714;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+EKBXNE7FHc0xYJyR+X7jNQv+jfiqB+nE56/cO7ty64=;
 b=DAGtsEN/5w7OMqa1HTuHm8KDOUd7QHXnjYNoaq1HaKzunQPdKFY54X14SN+xoDTxYn
 KOCyCoayiHEdZqqOizwpqhpOrFQIBiifTVCb7gV8tb+97QtXwKQyAVYV2HRQcqVF03b6
 /OxiJFTa2gvc/1zztR2WKC9jL0Q67Pm7hPw+PhOTAQ5ZE4oxoZblT1ItzjlU4DxIDp7j
 6h9euMdwTbSmzgh6QRYtVb6751iHyCNB0LsCLVSO11g1MUy+LVDdytJpJzY/bQRwegth
 UVl5uycjUu6KxhHQ1n+jGAReH8KfhzEAf/DX+PouU2+n0RBLVij/FrqhMkDEfLcIq/3w
 ixIg==
X-Gm-Message-State: AOJu0YxFF6AptM29Av50Xqb52fLIzdk+Ci4YBDs61pBRpiZXNREsvfif
 taQh62qWFIsdgbFal144eYfU+w==
X-Google-Smtp-Source: AGHT+IG2BbbKBK+3ILKkyr7JzWhA9LpfwcAQCr/KnUd451HKiq7EO+DgJ5sEJnLUoWw0GL35ExivGg==
X-Received: by 2002:a0d:d74c:0:b0:5a7:c01d:268 with SMTP id
 z73-20020a0dd74c000000b005a7c01d0268mr423554ywd.18.1697491914006; 
 Mon, 16 Oct 2023 14:31:54 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 r19-20020a81c313000000b005a7bfec6c34sm33687ywk.46.2023.10.16.14.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 14:31:53 -0700 (PDT)
Date: Mon, 16 Oct 2023 17:31:51 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Knecht <rknecht@pm.me>, Neil Armstrong <neil.armstrong@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Dzmitry Sankouski <dsankouski@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 5/6] eeprom: starfive: raw dump if unsupported data version
Message-ID: <20231016213151.GL3119521@bill-the-cat>
References: <20230930120147.59482-1-heinrich.schuchardt@canonical.com>
 <20230930120147.59482-6-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VWGIqU9F5EmQ2Gz4"
Content-Disposition: inline
In-Reply-To: <20230930120147.59482-6-heinrich.schuchardt@canonical.com>
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


--VWGIqU9F5EmQ2Gz4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 30, 2023 at 02:01:46PM +0200, Heinrich Schuchardt wrote:

> If the data version field of the EEPROM is not supported, provide a hexdu=
mp
> of the data.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--VWGIqU9F5EmQ2Gz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUtq8cACgkQFHw5/5Y0
tyxZbQwAnqsZwfGxnSmmEPR+DmsZhghQVLp+o1056pXx4RXtWxYOz6Z2gwZyeS1r
LEmlkxK+N+ykOtV5+w9NshhSKVECo5zGoZ9EK0O6RbXYdjkwzQqQn3/a6BTE4Fi6
MJpCDwG2BJw9SP5SAnvHrs3FaDPiIDc9BBY/XMTwhmcISm2zQaej85GSz5qx4b8S
Gjm4m7HII/Y5f2xeYpiOxdCbnMcswEmwa1K/EtCBvhm/RN4kF5/S1a+RMDWg666n
PKpZdE1HIfpL2wyj0MoP8iZ4GKfV4FO/V77ZIRAaB1y90qh5iybxUpJzCmJMYsFa
dR3s/2emSZYCCqdxPDElBtIKwsehvIH1NEPt6IhPQQcbNCtlBURzXf4Sre6dqmL6
EAwCEPhSeWaiMHmQmU0FLJphuBj2i1reFFpkyuykemLJaU3toC6fuxZR8PElOSiS
EAXLrJl9d0y6zPBm7T97BwQ04g0mgcr4aUxHfmXtoxufSG2T15HbJgmyLBbJO5hx
W2ljsUSM
=BvT/
-----END PGP SIGNATURE-----

--VWGIqU9F5EmQ2Gz4--
