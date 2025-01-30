Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D313C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 17:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF7D28213D;
	Thu, 30 Jan 2025 18:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dxHgaHkL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F83D8213D; Thu, 30 Jan 2025 18:06:28 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C31E382139
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 18:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2aa17010cbcso412430fac.3
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 09:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738256783; x=1738861583; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSdqOOPxGoFDfxYvxsKTvMhLSTMyR43s07FMOFR1xQM=;
 b=dxHgaHkLJqRTD4MqoKU7Slot248fl7E+RfKcBq9JyzghhC27/IR3uOvnJe0cJH0AR4
 WO7RJ2nAz4qLAcbZNAGltUPU43C832yjRPD2Z5IUrqwG4bUHAzrLBO/abjoFzF56oAZy
 NgRjQ9Da4XyK5Xaf63Sfs3avPSh6xBU6qVT1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738256783; x=1738861583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSdqOOPxGoFDfxYvxsKTvMhLSTMyR43s07FMOFR1xQM=;
 b=NYYT2JuVZOI2Q+0ynlEVgsPkX/nRMVzjyM8s4gbFSG8kDp+k4tga5S3SKaosH5+ch0
 XTNPDlxk77DO/9MALKxxMy8Me9Y93Z1k1UwHil39KlUebpeJ410xMn88GFeuKRuQL7FH
 JGmX8bkkyojRHEY5JGDyeI+v2VlkeRqEcQ0Vjgs6RZK3WKRmPnJMeaGkMYqkaWnC03Zw
 yfNw+rGAmIHbVeMli+W9vbL7cdWw+gm/Ao/DJJ7JnEpZVkRAGNONhbVsw2m3xvyUBMya
 7XgeyrekMMYj557gPNCrprjzxa01iTICDwjowZie7UT/Z5H77SY4mJZsDpmZ38bnHeMY
 e7oQ==
X-Gm-Message-State: AOJu0YxTeJYiSs/fB2bKL73CFLLFdzXtmdV5S4TiAynYp6NQMMYl5+yb
 TXfXAhaxDh6RlX5n6mNXsRRShgmCKzJx34HB2ZSPOnS75Xe1uMZWBB5cR8QR0fU=
X-Gm-Gg: ASbGncsWqm4zwTpRUhLTzHF62PmZd+ooOQ1R/zqTUwsHyVlCAHt8ekFNsUfb6rT4v3b
 KRyv/ESUZH9KbehH4d/tnZkxuQMigSiU4Rz/Zb+OdOilyv3vRMtKTGR5Jy9DCIGHnP39ZNziALx
 PrkavEJKhzoBzeRMsOsZoFyJESPpRUC+6z0ba3aFJJemEjL0hrxbUAYEr/epodWa3AyTuuykGYg
 KgDBXuTr6eWS6RjM6iigLU/72VLYBb1sBDXwD32zAHIEas0G2SEiI1J70NHq05MXNR2EnlkoEVt
 CU73M/4GJu+bpOQ=
X-Google-Smtp-Source: AGHT+IGNHuZVKT2ndeOtk2mr12TYrKXMzZGrmIi1I2RCHZWglvz8Hu2mU+VEY/1NkcJbtLHnp+uRyA==
X-Received: by 2002:a05:6870:6b0b:b0:29e:34ef:bd7d with SMTP id
 586e51a60fabf-2b32ef53eebmr5207840fac.2.1738256783540; 
 Thu, 30 Jan 2025 09:06:23 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b3565b64d1sm494987fac.40.2025.01.30.09.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 09:06:22 -0800 (PST)
Date: Thu, 30 Jan 2025 11:06:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 06/19] spl: Avoid including hash algorithms which are not
 wanted
Message-ID: <20250130170620.GI1233568@bill-the-cat>
References: <20250126184333.4058848-1-sjg@chromium.org>
 <20250126184333.4058848-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hL6V8LjTq+VhsGw3"
Content-Disposition: inline
In-Reply-To: <20250126184333.4058848-7-sjg@chromium.org>
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


--hL6V8LjTq+VhsGw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 11:43:16AM -0700, Simon Glass wrote:

> Update the build rule so that hash algorithms are only included in an
> SPL build if they are requested. This helps to reduce code size.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--hL6V8LjTq+VhsGw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmebsYwACgkQFHw5/5Y0
tyx6kgwAm+Jhi0yxIip7fIgcj2r6MU7wBShfL6M0s3OSpM226qjYkeS4SopndCi1
9D0cJZMLVamru9eSBGdFT5Pch9rsrXVmHEx5hj2WaZWeqWKDGBN/bRqFPffzVwx7
lPYQrnki0CuF2Bnq/FCERcnQFugfBsJFsdjch/VC5RZ6GXbMsglj3MXofm+h2VzW
HwaS7x57jc7xAOPrhyNRzay+MfnR/ZglWph0sO1AsFN0Xu0aKn6wFV6OkDeA+sXu
+ySs+krOyFmYPgOmge6vQNpRRGz1D9h+1jiTZTr/eB8c3isNPd00egKGsU1PN5lh
IIxMCa8nub+mdH1yCupaTRhPHQrXboVC1dyXIZ4wECnlppKDvniUD27e0V+kKtKT
yTbKkHtqBS9BxU6tMaE+ogogR7MDJAS6H3MEKjltBP3MClzJZQC+p5xSmYo8q5/W
wJElt5Int940HLmr8Q1faDVszk/t2jQRYHOh3UtV2aHtWOJAvS8NP+Nr4kiZMFXq
8IdEdDcy
=fXJU
-----END PGP SIGNATURE-----

--hL6V8LjTq+VhsGw3--
