Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17926C83F04
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 13:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD2381FEE;
	Wed,  2 Jul 2025 15:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QSXzhqlu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A7AF82CFA; Wed,  2 Jul 2025 15:45:20 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 142F0800D7
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 15:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-73a5c41a71aso3645010a34.0
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 06:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751463917; x=1752068717; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/QEPz6mSnxHlnj3Z4ozMA29JxuJp8Gx3v00cpX6Z/FU=;
 b=QSXzhqluCx9CfZrNxf2jCQxOylzjBYm/fUKaq4di7KDQMesor06FzQzRhAbssCcCkK
 c88ce2NxBQYcbRQjkIrsjP2yKbVJ4XePnMSGi321j7KWu5ZlCeMCbGmNGnA6AEeUEzli
 n4sW/kV1w8FephSKPNCABGn34c5Ts98GG0Q/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751463917; x=1752068717;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QEPz6mSnxHlnj3Z4ozMA29JxuJp8Gx3v00cpX6Z/FU=;
 b=Gg0pZJ3d8o1p40wuy2jeDlVuadldJ4p9sST1PP87syCw9lzp81dJjbALtjTdNSliUB
 oOCfvXKIuTv/oapWmuYWHIUlXICs+3Z1tnhc2Nn0Lfp+1T+PLzy2Ke1KZHIuZZnlA6ox
 PHqQF9e0/ONXwYP7fefiyGdWXZTmHhg2BWx247tC6OsuGCCbx2azKTLCbi2sGbtWOvGy
 QwM6Pq4KtasOa8AfX+suMLzoOMGvAZIvV9ovS/kfXjhD63ZYBW6b4aDATahDwpC/i+Z7
 +YxnXpoAfbweC0zDRYt2Dux3KsGjS3A5gmCUbNKl55LFxr45l7eTFe3fZHoorzcOVW2k
 61ug==
X-Gm-Message-State: AOJu0YzQzjsfqzMcXyTHyjX15M+LQXdXPMfpo+dyBch7mXoGpfC2jk5H
 YL8C9dG/tFevTlGAcX/Z58YpBPB0XDDV3INP49EE2w4I6WQyuBOZcCPVhgs3gv0fAd12BkghDKJ
 zzDzRjiw=
X-Gm-Gg: ASbGncumPG56MxdUHLv0FtqigX1eIYZW1hyK9lRDBqfdb99t0vYFYxUyFGgsOEtfSFb
 6wffEanguOuZQwlH1nKcrdbGXX48dE3rPrbt/IygJzAqgZ8mdY9V4btNKapXr2Z9CAsgM8fFki8
 k5yph1Z2S4624zIS+IUGR4Gi7/xYK/IrGDLBr1xQBFMFhWGx03N5Uzt2IOhaCU0Q+4YetHhZKOu
 KMPa5mpWEVGYF25Dechp2eWXNc9Ba5DaesziuDSJppK9s4NyLLl39f4WzaCnQxoZK9rIB9wyTPy
 4YPAV64sXen+/3nimelgFM2m/9AklnqwfsOGLOfTr0YupnDiY89mtBZ8AdV5nQ0aEd5PgVO0Xje
 Wf7URP6RRv0Mk+V0AYMIm
X-Google-Smtp-Source: AGHT+IEAoP7QqmaYmsRfjuqxYqghHt/irqou2jn3cS88svRvpo+1meo2TF1WaEqIC6JaI/9VMQsXGg==
X-Received: by 2002:a05:6830:808a:b0:73a:e93c:ec22 with SMTP id
 46e09a7af769-73b4ce3b9b3mr2188965a34.8.1751463916579; 
 Wed, 02 Jul 2025 06:45:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb0e2ed7sm2512870a34.35.2025.07.02.06.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 06:45:15 -0700 (PDT)
Date: Wed, 2 Jul 2025 07:45:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] boot: menu: Do not dereference pointer if pointer is
 NULL
Message-ID: <20250702134514.GB6424@bill-the-cat>
References: <20250630-scene_menu_fix-v2-1-7d9141a45a63@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f3my2O1HOhAmTGjp"
Content-Disposition: inline
In-Reply-To: <20250630-scene_menu_fix-v2-1-7d9141a45a63@linaro.org>
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


--f3my2O1HOhAmTGjp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 02, 2025 at 10:24:16AM +0100, Andrew Goodbody wrote:

> scene_obj_find can return NULL but this is not checked for before
> the return is dereferenced. Add a NULL check.
>=20
> This issue was found by Smatch.
>=20
> Also add a NULL check for str.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--f3my2O1HOhAmTGjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhlN+kACgkQFHw5/5Y0
tywUcAv/SMxr6pAvlfDSq+gL6QbZkXs6KFhbdVLhP4YB51Q5ffZl8NxfO1jHBit/
m8kWkDPgtyjhAHEoDEuPZPzadJ7j3jgixSjoDvtf/AyR2OaaG3UvDRwQ+GPyL8vb
1Cd/Ov/+2VfXeorF0hkh/5qPO5V67I7R5XzPthjUdK6M50i1mrhCOH37mirXUkeO
MPyYXIN6YBBGV3Ftj8QjMmoIN0GZKrcOhhdDcAjWQLdR2VlOO77P5fdjvT1ogjjP
7htQVPYoTEaI5qeFfkgNnR+lTzlb46JVSjtwnDaBOaD+Kpr0+Wps4n1dEMSwg17K
LusDyDXPdWozpnuRdHbooVCRLbcyvwo6PqkdmOiobg7xXggsSNeq2uzvI7FefLcV
hbJPtcp2UKlpL+T5joxT22xfclVFUCoO2c1PH1LmBYmN074Go40qXvpF0jEXwG9e
OWHzCCaPslCkHSv5gIiY+gshyRnLMuFJw9fnoGHbV89mnDhQAWogzk1zd91VkSaF
4n/CpuTc
=5mPI
-----END PGP SIGNATURE-----

--f3my2O1HOhAmTGjp--
