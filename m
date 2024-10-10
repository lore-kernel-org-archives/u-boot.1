Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AD9CFC5EB
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 18:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A52E0891D8;
	Thu, 10 Oct 2024 20:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OA0h11kR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E47388FE1; Thu, 10 Oct 2024 20:25:44 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95DFB891E9
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 20:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4603f64ef17so10577171cf.0
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 11:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728584738; x=1729189538; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EV7PZYpLmHioffO+mjdHtaVqVBxWUxhz10zqxOakpgA=;
 b=OA0h11kRRPv8/tEPoj97UPtj9NOR1A7Nl5twBEluUwR0+6+FVQOpPl27C0L8R0fZ0Q
 4lgxUnkobSWwEP8IydVCmpm6hbaWxPMSByV7q7hy467sVrBv7pOViLMGhyoMoq+U/J6h
 hEGin+GN6DOmTRo0V+Nxu+aK5vaS3wZjjGtGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728584738; x=1729189538;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EV7PZYpLmHioffO+mjdHtaVqVBxWUxhz10zqxOakpgA=;
 b=gIUr9MchEVkgCZBEEoG2cl4qHQzi7lbNC/shNjKS9iOwFJNlxBeRhDJvfRzN+sVB5d
 AJ594/30GSf10unD3h6lDkoTaJkgYvqXemduh3g5zbNSnPEFYKep7UjI+JrtmcYxY0kV
 5E/oZOS3degUiZE6yvYK0QD3tQthzlLpllrFYR/Gq8bHOpsbWFaKCiooFOJw9eFT3Q/0
 UVwxzkIFQ7mwV8hg+3PlsgtVnDKWBq1e5embdJcY6OpJ7OBng0qv+apxpl6F+xMEPdkz
 KExc1I9JhCRrl5Jwjbo9E+DVd+rKNxNbDWb1/koQxi9vdql9wjJt0VeAdxbg5+B5aV9n
 sGeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSzhDd078bdYGPMv9SjUMx70NOrQzVUFGPj4UB2TiCuC1vxLeSnZOjiWTSnSenBph8iqS7YMo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8kTXvc5HmkK1A0fPBdnhinoUsxcwF8OiLMGY8vKRLNEPmBUf1
 40SrtIANH8QtJKXrwVMTyBylroMY1oCzOLu6a1V/Pw8I4C0S9F9qthwiteAUvQ0=
X-Google-Smtp-Source: AGHT+IHHvGOyWceEO/cc+/oG8uV/O8mhjXNDWvh+rCnI3UQAdPTjqkAJGzxOp5H0PLEkyEjw4ZI8Aw==
X-Received: by 2002:ac8:5710:0:b0:45c:9c44:ae8e with SMTP id
 d75a77b69052e-4603f6077aamr74753361cf.22.1728584738065; 
 Thu, 10 Oct 2024 11:25:38 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46042892a05sm7697861cf.80.2024.10.10.11.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 11:25:37 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:25:34 -0600
From: Tom Rini <trini@konsulko.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Jaehoon Chung <jh80.chung@samsung.com>, uboot-imx@nxp.com,
 Joy Zou <joy.zou@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] power: regulator: Support pmic pf0900
Message-ID: <20241010182534.GS14210@bill-the-cat>
References: <20240930032244.20286-1-peng.fan@oss.nxp.com>
 <20240930032244.20286-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IM51slTVZIBpG6ld"
Content-Disposition: inline
In-Reply-To: <20240930032244.20286-2-peng.fan@oss.nxp.com>
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


--IM51slTVZIBpG6ld
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 11:22:43AM +0800, Peng Fan (OSS) wrote:

> From: Joy Zou <joy.zou@nxp.com>
>=20
> Add regulator driver for NXP PF0900
>=20
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/power/regulator/Kconfig  |  15 ++
>  drivers/power/regulator/Makefile |   1 +
>  drivers/power/regulator/pf0900.c | 304 +++++++++++++++++++++++++++++++
>  3 files changed, 320 insertions(+)
>  create mode 100644 drivers/power/regulator/pf0900.c

In addition to the MAINTAINERS comment:
CHECK: Macro argument reuse '_range' - possible side-effects?
#280: FILE: drivers/power/regulator/pf0900.c:59:
+#define PCA_DATA(_name, enreg, enmask, vreg, vmask, _range) \
+{ \
+       .name =3D (_name), .enable_reg =3D (enreg), .enablemask =3D (enmask=
), \
+       .volt_reg =3D (vreg), .volt_mask =3D (vmask), .ranges =3D (_range),=
 \
+       .numranges =3D ARRAY_SIZE(_range) \
+}

And it's that last _range that I believe is being noted.

--=20
Tom

--IM51slTVZIBpG6ld
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcIHB4ACgkQFHw5/5Y0
tyz3awwAgbGf1KGUeleZwTXUkNr+EiVc1c3OxNd+GaDPldz0efUPjLI1fmv26T8M
eu6YdUIKNIdC2qFHcDPVRllhpC+HkNbVeHG63HNxcC3cUYvrEl/zbnrrIy5Rjler
DNiVM/DzkF+bAxIcS9jbNuSpzIad6WyNEz+NMaW4LOjn4AZHyd6XA9Q4boMRuOz9
Yoecw+7uDh5FNi6ezjPoxPHLWMypJpIOz9upbZGdEeRpxzXqB4/kvkCQzeXVqUi9
TkespNZcZ1dOFAwcFgProhc/58/uz0Q9D5UPS4jdfOzxnCmaNdcZhUlNCMuD87gm
NNy/qDKLgz+4Ug9LH03e5xIgLEydBAQ96vD4qSWJOxp4V75uEUwTsjh2Z/+TZJm3
4bBSHFQkm/xskNDpGiFT6ZFmUwXrC2v1NbC7+ysYaYLP4lylojgwDHMVSTiUO7hE
lI5go0HLYQg72QrMXpCdXges1164RjrfppJvE9/+koHqSS/B3aYdK/7esCbG+w5L
NsvTtY1Z
=uAyK
-----END PGP SIGNATURE-----

--IM51slTVZIBpG6ld--
