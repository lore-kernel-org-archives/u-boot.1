Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E6BD2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 768B283A6A;
	Tue, 20 Jan 2026 15:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y4kxGASY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 185D283A8D; Tue, 20 Jan 2026 15:54:16 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D47BE83A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:54:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-40467f1514aso2479692fac.2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 06:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768920852; x=1769525652; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sFXTaC8qpZV3wsPagmYYl2TQwtud18XSAQxj7Whk8T4=;
 b=Y4kxGASYM0T7/SAqgQXjesoaMNTBPf7OvQEg42p9txa7f0nu5hrRV5Jk3sYTOGARFT
 JsfVBQOwoQLoMqtiz3SeVibc8rA05w+Qp9X2MV5rEhakb9B18pvVtaZaVTa937YeTfx1
 SzlqNXg8gwqj8kMV3pvoL7qx6wh2uZemnyeZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768920852; x=1769525652;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFXTaC8qpZV3wsPagmYYl2TQwtud18XSAQxj7Whk8T4=;
 b=AHg+8Kwisw+4Yk3fWplyvzn++ewxKTxIiOohSyMeSBr0PwtWQmvup+8cdnP1dqHutw
 cKntNzY+2lQgj3ajrXyxora9zSYoX0UaFg6RpajIbSB0I0gi4si2JV/kIdxtN48E8PWO
 cpa6DH0fC67NNIN8RL/xeQvYoun0ZIx636Vae1T9EKrYVhxk8tz6cY0vcqD76QSXH9HM
 SiPVIWGFJiLdQuDCtjrVosdXgl3FinE9nfWySt+KFNIqAsrnzr6FpNWNK10VdXr1g6np
 1gifTxHGNyr3CRMGtKAmKI93a4/OXi3XZivUZbc/rte3MFMHaKjELavVr9cQGv3a7jVo
 /+PA==
X-Gm-Message-State: AOJu0YzTBG8iKiIqwZfl+W/Yumt0mdgMdAQ6GCqEwEz1oDt9HZNNYvU2
 NnHYH+BdDRwNcPXrkLLfaGuNJuohwlWAb2s2tC8o2EEHaCm97J1lI6LpJrXL+5knLQk=
X-Gm-Gg: AY/fxX4GJ433hGz3oiKOZJzFPzXhqVYnag5SN6E3Qjs6Rdp8QKx+zK3bixefgts6tk6
 k646aC/aEY7RpLICo/0vjMr/jRYw5reug4Acg6x2tioSte+FrKBPxtlof2Myxi2GHHyqo0uBHCm
 NCUaS3mhj/UQi5+UmoUnbkyFZpEiuZgqgvvK7ntvvZHR19+7NLieczZfwfoJGs1IpVm1DjryV7q
 FhYLrqUPzLQV/kTaSLlcEYXKxBfEUfErswsTZ4A9ot3lXUj2PC8oksPt/JeRunBBVv2HejLYf3u
 h5imtmWnhEgcrsUB/05B6JPuFYZa1ywwSi38sZuq9I+jdp4+kllVDHyZYn02IMXbLVwi7KmNGvO
 HE/kptCQPJqIzWLI2YMjdbnjmmBHLtNPM+58fEwm5lrmEQu4REQGxBBS4+rCbD/Fob2AIcm1IZQ
 zeeyunKEeg2eFu5IY8WTUQ49RBrKHRif+U4dc+BgusPZIGQEulhu1wanvIoNSlXCq9V6gcSVJ4V
 rePcwzhGoQOgym0TmFxeJwFJ9uD/xDHAmMMVPU=
X-Received: by 2002:a05:6870:610c:b0:404:3c7c:8201 with SMTP id
 586e51a60fabf-40846aa9d3amr897288fac.8.1768920852552; 
 Tue, 20 Jan 2026 06:54:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bda44f9sm9101751fac.21.2026.01.20.06.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 06:54:12 -0800 (PST)
Date: Tue, 20 Jan 2026 08:54:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Andrew Davis <afd@ti.com>,
 Judith Mendez <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Vignesh R <vigneshr@ti.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
Subject: Re: [PATCH master v4] Kconfig: select
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT for K3
Message-ID: <20260120145409.GL3416603@bill-the-cat>
References: <20260120-am65_dfu_fix-v4-1-36b2dfab3a64@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m+uszmJ1KUkJbYHi"
Content-Disposition: inline
In-Reply-To: <20260120-am65_dfu_fix-v4-1-36b2dfab3a64@ti.com>
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


--m+uszmJ1KUkJbYHi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 10:04:28AM +0530, Anshul Dalal wrote:

> Since the commit 1e24e84db41a ("tiny-printf: Handle formatting of %p
> with an extra Kconfig"), SPL_USE_TINY_PRINTF_POINTER_SUPPORT has been
> made mandatory in order to use %p which would earlier have defaulted to
> a 'long' print.
>=20
> Without this config symbol, k3_sysfw_dfu_download fails to set the
> correct value for the DFU string with:
>=20
>  sprintf(dfu_str, "sysfw.itb ram 0x%p 0x%x", addr,
>    CONFIG_K3_SYSFW_IMAGE_SIZE_MAX);
>=20
> The value we get "sysfw.itb ram 0x? 0x41c29d40" causes a boot failure.
>=20
> Therefore this patch sets SPL_USE_TINY_PRINTF_POINTER_SUPPORT for all K3
> devices since the size impact is less than 100 bytes.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--m+uszmJ1KUkJbYHi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW+XEQAKCRAr4qD1Cr/k
Cl8GAP0XT6xjSdeJVg1pHG1zSGGbKox5zU5BDuXUHtJJ46wFFQEAmdxPS6tWI5rp
b89iLTWuwvvRh6HYAwOLGEr3+QefwQ4=
=F9pn
-----END PGP SIGNATURE-----

--m+uszmJ1KUkJbYHi--
