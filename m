Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CC3C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2F6F8039E;
	Mon,  3 Feb 2025 21:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TZSjNcnr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F2C80762; Mon,  3 Feb 2025 21:09:53 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2BA680243
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6e1a36b3684so57203486d6.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613390; x=1739218190; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3unFDY0Urcag5DCL6FeVEPhYAruNoCqVzjSap6SRzLk=;
 b=TZSjNcnrKYOb10dQUMMo0iXrH2js62yM7YrFlx+EoDrwK1FAdksmN01yry25afmXtS
 wIEF0mBuZd+3buHmGUhV64VTz4rHIFVRBa29SnD9WifICDrBgangVwD3sds9dlHJs4fl
 Tf4C4aAq64kkdwxbwWVnUiSFd+QrL0UdMidj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613390; x=1739218190;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3unFDY0Urcag5DCL6FeVEPhYAruNoCqVzjSap6SRzLk=;
 b=izWa+Q9Qa38xXsCAoJUt5MRHD7nlGa3Xq9Uk72RPKVe9y7990Xq1yqolMUkp38DkPj
 JqQcmfTdts9one8iZ3zmojKMKXw8xts2rZtYHS39DRI4MwRK1AxiaBv2zsGY2tpMHfeT
 UN9kaF9MxF7mulBRs7s+nyIfKcveY8t6FPAc/313br2utlS/BYHpdQzXmm9KpoU5j54+
 ER2UyY1UMcWIF9mejmHLij9ziowE/Z2yI6mzmlrDfXEF99ExOG4tPkQ1EsvJBnUWmS3h
 z975qmcFr1HGeyBl6YspDR4blDmQMnM2tIkcKlrhrqvxBC0PR/dqsaC5WTuWb2EN9JJm
 9sKw==
X-Gm-Message-State: AOJu0Yx2XGKF7iTZIffJx2W811BAOinO7D3N53IVMpKmuNwV40GUGBLD
 8HaDJlShofKg2aDr10JB89ZEY1OZVwkqMYYov7HUAdpudri1wpOXtEtjWXFZz74=
X-Gm-Gg: ASbGncvE5Wrh7Im4R9C3vozNJQ8Fw+JawqsT5opWVU0JO5q32JPHmzrF0e/yEcKVn6l
 lhpE5/AOBDmUG7wmo0kFHcpjcGCPXShmHdrJ+7FT3iah31ilg3y4ACwmUvR3LeBT21z7xiWK+xg
 p+ZoVKzCQj4f9TxD/MgkeE8JVXXkJe+X2J8V0AYRs26nnuySUW5ipTY0cPVOl8wBPZQ0F8fmr9I
 vLDBQcUhR8aKA1B5xcYdxvcrhennW4iuloFKbHO+pAlwwZeansaQtwESG+4+sdeOsQ8sGoBLSvr
 zoPzVMrKG51Yf6I=
X-Google-Smtp-Source: AGHT+IFoIcT9NGzjRGcbX3pkwIz40Em/6MJudzOEiEgeWnMnyRCmgMTIg1HeVy7QhFRQH6dhqghO5g==
X-Received: by 2002:a05:6214:f2a:b0:6d8:7ed4:336c with SMTP id
 6a1803df08f44-6e243b912a9mr304691106d6.9.1738613389610; 
 Mon, 03 Feb 2025 12:09:49 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2547f2bbesm53839136d6.12.2025.02.03.12.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:09:48 -0800 (PST)
Date: Mon, 3 Feb 2025 14:09:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>
Subject: Re: [PATCH 23/32] efi: arm: Disable --gc-sections for the app
Message-ID: <20250203200946.GM1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-24-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GbUvlFQMm3AaZQT3"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-24-sjg@chromium.org>
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


--GbUvlFQMm3AaZQT3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:16AM -0700, Simon Glass wrote:

> This option cannot be used with a shared library, since it results in
> everything being removed. Disable it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--GbUvlFQMm3AaZQT3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIooACgkQFHw5/5Y0
tyxOMQv/eVyzjvujYCNd/ZuTBzalYsUh0j7dXTtVsx9GhhaV5Rvr1ovn9yjRUphL
RlU9LxiG2dKCNAPBjoRhB0ZuhOmE7WQ/P4szT7hq+uAMEUI/G1XlCGA1f6LJFujB
JCvx4vy0z6uGOtE/cGn2QYjk4sfmbMd9xdts301hPMYu1a0FC4dblD/UnCgwUqIB
Bsm0yR86WR4Z5tDpJX5vsNG4CZS32zsq5JDsn6cSToW5355FDBnjoaIYHAgUCd4e
HQt6TUGzWVsK/NMppGiOLu4/zBKkirJyItPN0a62Hx6FFKCTKDCJNmnDwBbPYGoh
DY5wAW3EdWZn1so7aoGKuyk5Mgl9vrw1MXDX251LZmXDg7KutYnqIDUSVSMUJWXM
zgcdZEINM8EUjB59Vlm79f2EVzM+UunAJhTs/1LmhKsBS+atufhQA0Igf0DWxzSy
oap6HjOiiEH3lHdEH2skc+WQh0m0DivAZTc5zsBLp9aEyk7RkxYzF/EAVEaQ8raX
iIrjl0f1
=TIMm
-----END PGP SIGNATURE-----

--GbUvlFQMm3AaZQT3--
