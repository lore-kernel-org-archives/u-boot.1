Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7388E71D31
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 13:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F6086EE5;
	Fri, 29 Sep 2023 15:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m78M1smX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F53086EE0; Fri, 29 Sep 2023 15:21:40 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98D3586EE3
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 15:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3add37de892so7126304b6e.1
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 06:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695993695; x=1696598495; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9auwyeYSp4zRfs5qvsyjtJBat9bOD+XoNICJq7UPWFs=;
 b=m78M1smXk7Cl0tj9DDf0d2mHmZ1pb94fIn+rFFGzPz6qk5XLBV6yHNPUP5hG082QiN
 QsdXLOa/OBpbcrhuA0ANZhIm9WJlG2c7kIVydqw/4ABT30w8sWeenSh867L10sCfWtCW
 Yb5qny/ytu52dWX9sbtekZv0EajkRXtfVyfhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695993695; x=1696598495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9auwyeYSp4zRfs5qvsyjtJBat9bOD+XoNICJq7UPWFs=;
 b=ZjmZOnfsV1ysZ1ggRvqbMnnElADyFOVMZXhBjXOATooIZlamiYqwnDLABd7M4SrGmH
 Yl+KJ4eJencLX5x0M3bmbjJMhG+00MgI/s7OhYkCQVeEIf5K8pckqSg7+4z422hjffqI
 pKpcwT4dsfPGA6u5QG6sdVmo9/dKcv6z0A5UL5I3moNStfTV6XFErMe+LhL7+mqJFAH7
 rsU7Zt8FHrPEntG44lWp8NrFrXu/yGrKOSbzREUSCa5hifOYZpfkb7CJpjrZG+F1SeMB
 gyPoC7teLSlEChf/0qeOsjVlXFx64PsBK2p746I16geldlnUGcZ0sIpjvzxiV2JBMHAx
 f3AQ==
X-Gm-Message-State: AOJu0YxwaqIrR7eewl7yCzjn4xqLrC/iD+C3Hx0V5TqJpJ4kOCCj0lre
 V7nai8V4mzbiiTEglhlS19Pd7g==
X-Google-Smtp-Source: AGHT+IH9/Gqf/VDemchyf67ugDQJIGO0x0qzbMtGC+07Vzk55LI3UdvviObndKW20EdzDOW0CwRgag==
X-Received: by 2002:a05:6358:342a:b0:12b:e47a:8191 with SMTP id
 h42-20020a056358342a00b0012be47a8191mr4559828rwd.16.1695993695075; 
 Fri, 29 Sep 2023 06:21:35 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a39b-08c7-b2a8-b94f.res6.spectrum.com.
 [2603:6081:7b00:6400:a39b:8c7:b2a8:b94f])
 by smtp.gmail.com with ESMTPSA id
 o2-20020a817302000000b005845e6f9b50sm5448301ywc.113.2023.09.29.06.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 06:21:34 -0700 (PDT)
Date: Fri, 29 Sep 2023 09:21:32 -0400
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, eduard@lionizers.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] smegw01: Fix inverted CONFIG_SYS_BOOT_LOCKED logic
Message-ID: <20230929132132.GL305624@bill-the-cat>
References: <20230925163259.9442-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uaEf5Y7Krcb4x47q"
Content-Disposition: inline
In-Reply-To: <20230925163259.9442-1-festevam@gmail.com>
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


--uaEf5Y7Krcb4x47q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 01:32:59PM -0300, Fabio Estevam wrote:

> From: Eduard Strehlau <eduard@lionizers.com>
>=20
> CONFIG_SYS_BOOT_LOCKED means that a restricted boot environment will
> be used. In this case, hab_auth_img_or_fail should be called to prevent
> U-Boot to continue running when the fitImage authentication fails.
>=20
> Fix the logic accordingly.
>=20
> Additionally, select CONFIG_SYS_BOOT_LOCKED by default.
>=20
> Signed-off-by: Eduard Strehlau <eduard@lionizers.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied to u-boot/master, thanks!

--=20
Tom

--uaEf5Y7Krcb4x47q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUWz1wACgkQFHw5/5Y0
tyx7dAwAkj9JUrYkTxR4IEwqRk+GUvfE0ykapJPMG5UqrbP1XnLw/8cBQeAuZ8Xc
8SRkj6TLqX/X4gd+O625z47lryKzNHa3L6+9HT19r+P6hU0YCq2Y7lfucEEePLv0
wVVaiDFZDfjaxzrDpPlsYGEEoMyUn1c4COS4p4Pc4gTRuPtfPbQwg+H4EASRfsvL
d+GVNGxkE3BFgxBrk1UY/0Pain8ToA4LT3L1lnV2drDcimf35ufU+jkrpgyLzOex
j45A8Qbufe1/Grj76e8bvlLbHpzgQAF+IatlSHRShuOf5RwD4yjS7woUjvJScwMg
zXUXHHVlIZBUokdjYLnDGQ79z9g2mQw65ifIGvR2Vsl69v6SZbGfAY+zsYBGhG9v
23QjZutRWrsvIalii1D+nHZCrJKEUi6Okont27E/+uX0R4Tnmxfy61XR2kwsH90y
gYLnla/wJm8z9wouN1SCFT16EYF/bXcAzLgLzQwfC5t/2n/osH6Gzh9BY4z3GRmS
NFX2mdid
=B6Mw
-----END PGP SIGNATURE-----

--uaEf5Y7Krcb4x47q--
