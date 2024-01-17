Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED66C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 14:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 542A787B6D;
	Wed, 17 Jan 2024 15:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mFrO1T5v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 562C687B6D; Wed, 17 Jan 2024 15:26:23 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B70987B80
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5ff790d41bdso1644857b3.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 06:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705501580; x=1706106380; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7s08Pf7WB+aEXz6eoROxxSk1wOSo/ybhr5liUda+hbY=;
 b=mFrO1T5vrwJmB6QJyp/XtyQyGxkGLrOJGyTasoaMOomdUM8bn51/ybaSpz91BHVW4w
 am9r5EpacbnM/oOmnjNEKSUAQkGqI4zLwGVrIxzo9UWeIWT7c/xiP00gThJAocPMfCoE
 KH3jCK6or60Eu7T1TNPV17UwM9T1fBCTNPQFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705501580; x=1706106380;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7s08Pf7WB+aEXz6eoROxxSk1wOSo/ybhr5liUda+hbY=;
 b=mi8p/r8BzPq4AzZQo2plf8dZg9eb0gaRhjk5dHjUa3Bh2+WNt0qKJwlItjryAXqVTT
 QhhbpcL4Thw5LVm1u16UWGZYDuxtPuYMfFO8b2Q42jLhNEXQ1EOILnJzaPjwpZURosSq
 1QZE6ttDbItk0oCikCY3puNtCHzXndtmcgcgGGAyX8BoByijJ64cos5DbeKDsjwo9+1L
 cm26OF58K3hcy5RG70Tyo0e+46yfIBxnsv3ltwEE/J09T41HqzdqSZB/qvFr/SckXt3T
 jduyyJXiH8WvMotKN5OezprjhgnIk4BFLuBXkgkCCJpP/jQt3YORGC/IW0UX/diZAFMW
 MS3Q==
X-Gm-Message-State: AOJu0YyEvRk05oS+k4skwjtEwsKIbHcn1igjzkUtgnFu4skZf3U9B3HC
 /KNBxsshlkHKYPFC7Wr99SBcu10y5gbpDw==
X-Google-Smtp-Source: AGHT+IFHYVgWodAj6A5WQhARL4xOo/EsG2lsbO+Goo4dRhhvLG3iBTewmDTq+aZBqZjRv7X6RFydlA==
X-Received: by 2002:a05:690c:b82:b0:5e7:5c66:b9d3 with SMTP id
 ck2-20020a05690c0b8200b005e75c66b9d3mr6347785ywb.96.1705501579800; 
 Wed, 17 Jan 2024 06:26:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 e6-20020a816906000000b005ff70747dcesm315486ywc.114.2024.01.17.06.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:26:19 -0800 (PST)
Date: Wed, 17 Jan 2024 09:26:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v3] test/py: mii: Add tests for mii command
Message-ID: <20240117142617.GJ12635@bill-the-cat>
References: <a6b464aff98b7ddcfa076c2155a1be51beec8583.1704177781.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="APyZvb8Acvmwd+tb"
Content-Disposition: inline
In-Reply-To: <a6b464aff98b7ddcfa076c2155a1be51beec8583.1704177781.git.love.kumar@amd.com>
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


--APyZvb8Acvmwd+tb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 12:14:35PM +0530, Love Kumar wrote:

> Add below test cases for mii commands:
> mii_info -To display MII PHY info
> mii_list - To list MII devices
> mii_set_device - To set MII device
> mii_read - To reads register from MII PHY address
> mii_dump - To display data from MII PHY address
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--APyZvb8Acvmwd+tb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWn44kACgkQFHw5/5Y0
tywujwv/arIdP8ionGw7dSS3XFif9TsIaOWvObYGrAoJscJfG9F5tImiiJmTopmu
nrfElKpawYdpSHFoij5f8MFpzFgZVyMuvcA2fRfauWed+Z6MgaasOlwt092JSwCd
sOPTYNOlz7IoIttxievt8Jie6qVpN684Ywj9zO37Q6CN20pGLo5PWdibnmvDmX5p
gCoYMAB1D2W9war0DDNGgsded0RBRD+G2IVs+k1MH/FBDs7+s199rY9lXk9RW4sP
M3m9UIpePAXDlRJVmeiqreXqCU2xWqLI/hTak/dUsXMeMyASQZ8R3mEbiEs/OrJG
pb+j/ra7aj/5F27b0ul0ZZYEf8/4uVm+Mc15MPUdBoIcMahYPaL51YWa8F+7Je0/
EKPntqpDUdJ0jTT0NaeOFw/epfzYmYhURg8d2fUHHfLT/xVokZP1SXPa1nZK3wJW
iJAdBRN8IrAifs0OIOntVR5eSNWuQD5QcglTjDbrXPYeynfG+6u25+/Z6Bhwr2zM
0ypDFREv
=1eBS
-----END PGP SIGNATURE-----

--APyZvb8Acvmwd+tb--
