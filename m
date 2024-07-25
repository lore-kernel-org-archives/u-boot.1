Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE450C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 18:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 763DC87E64;
	Thu, 25 Jul 2024 20:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mqKfDxzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBD6E88100; Thu, 25 Jul 2024 20:18:10 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A190831A1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 20:18:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3daf0e73a62so121630b6e.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721931486; x=1722536286; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4FIC5iJOrxlBWSoZbPDWSZ8tr0oB8yLaMvGs4X66NNg=;
 b=mqKfDxzqkkSxwoiC8njSDfv41sOD9f5slmuB8x+p0QdeKtKafS/bawZhzGS3LVlDHO
 NAldZfAf+aDzMGWKN4yTDCr/7V728Z0jvDh+Z/7AWpNzdPMi97SGIkrOHSd+qqte7ie9
 mNcC5xYmDwrv9Xoly/0h/DbAaW18WJ38Ydcec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721931486; x=1722536286;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FIC5iJOrxlBWSoZbPDWSZ8tr0oB8yLaMvGs4X66NNg=;
 b=OygXAt0TsRmWQFr9jG+oS7SW1pBhlIrnRYI/U3mk2VIlrtBwWgKpZKJBoAmoERwECR
 ruoL5H3gMz0Xez7csLUymfeWeBtt/ElOZxCakf4Wvop6j24BQgoAJV1Y/RHHjH7gGIVa
 mxp6VqTVtfgF0Bj78IQIOUcHyhlZiLSPYQOBNLKzh7IBxoKagjYXoviEVpJtbDXgoFNx
 ZfZ6dJDVGHWS69yooRUR9ZUc5+egTUTMWi91XArmYMvDdDEaMAAe0CxjwY+zIm2NvzCY
 ANYTocOa4DVavT1rq7+eIHMCiGnYXF4Q7OyXK5yZ6CrDF+iDZg8YsU6VQV13lSVqvUg0
 Uqjw==
X-Gm-Message-State: AOJu0Yy+jnV14ChlFhz6Cfq+0CxBB+ZaLuADVNvMPxly2CjME/sWxAs5
 sIGBYfkRvlB8SQZoBOGh06Tmq+b2Eqos6GitBV8SlwqSxUGIX/M9uBsYfzBuuCc=
X-Google-Smtp-Source: AGHT+IHG37vjaPQU199lAt55BRPaJKxLrhNdb/LfztPjK325z9gisrgex1oUmTGE8jtkiPqX2uDKdA==
X-Received: by 2002:a05:6808:1911:b0:3db:fe8:f757 with SMTP id
 5614622812f47-3db10f7bc6dmr4023385b6e.22.1721931486258; 
 Thu, 25 Jul 2024 11:18:06 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db13523daesm384017b6e.45.2024.07.25.11.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 11:18:05 -0700 (PDT)
Date: Thu, 25 Jul 2024 12:18:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>, Stefan Roese <sr@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Jason Liu <jason.hui.liu@nxp.com>,
 William Zhang <william.zhang@broadcom.com>
Subject: Re: [PATCH v5 01/20] flash: prefix error codes with FL_
Message-ID: <20240725181803.GB989285@bill-the-cat>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <1b22bbc08cb0841256283114db7ae117d97c0155.1721910373.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zl+v4nizroVo75Vl"
Content-Disposition: inline
In-Reply-To: <1b22bbc08cb0841256283114db7ae117d97c0155.1721910373.git.jerome.forissier@linaro.org>
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


--zl+v4nizroVo75Vl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 02:57:22PM +0200, Jerome Forissier wrote:

> Prefix the flash status codes (ERR_*) with FL_ in order to avoid clashes
> with third-party libraries. Case in point: including the lwIP library
> header file <lwip/err.h> which defines err_enum_t as an enum with values
> being ERR_*.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

This is incomplete as for example 10m50 fails to build due to
drivers/mtd/altera_qspi.c. It might be worth doing a world build with
just this commit applied to check for other problems as well, in v6.

--=20
Tom

--zl+v4nizroVo75Vl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmailtcACgkQFHw5/5Y0
tywAkQv9Hrpgz200Xn9TNEX8AHi4JVB4gybCGMYJD+P/NPcP3jmD5ceAra8zkpf9
zNFHQPmHGFUnKsZv5oTpPOW/MawucREZEzE6Y3s0CMBXmSdQGBEGpRdFO0mo/3RF
QW3LMD9Dg2n3NlXZF3DFcGiJFzIeUZnYCIfKkHE419pwZ7/hWV+fgPMD9G/xffQy
hvD0zlDzqxezuPcYqqrJcNzamRyMhXxFLT1xV+Uz3r1ojDISMyUJe+MeKF9UyDgC
beZSfXK6VcHjeeLXOxg2S+ympMaPMkXaG3Ub7FKA3fLv7zAJYl1Q/nuRnI9pfE9L
35Ly9BBj3P1T0V7UOdIe8DHUAWZrfDNkrxHSbecjOuM3Ybpicg46PzJidLOZg/pf
MyWRDUrbnRhDjFqx+9G7XyoZ4M8p5fp3J30guCgm6gelZxJdNBzqMji72i/G2hn5
nBpkp8aY5vAfnzr1q1BE7I9DnYyrp1BhyxrYBfASM1tBvpPNdlLwgIyjHo6CoOZP
aMKFzwWT
=n/L8
-----END PGP SIGNATURE-----

--zl+v4nizroVo75Vl--
