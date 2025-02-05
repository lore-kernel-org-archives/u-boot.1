Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45EFC02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 00:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE11805DA;
	Wed,  5 Feb 2025 01:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cS8Agjm6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEDA6806C9; Wed,  5 Feb 2025 01:08:39 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B398B80207
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 01:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2b7f09611a9so355648fac.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 16:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738714116; x=1739318916; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CyXDNA8KNLvPyzSq+d9ebYqFls+i6SIRXXrPjNQgGME=;
 b=cS8Agjm6q7t/6ocygZMXKs5vgDdMQZUntPfUevrk0WkT7lmGd7QmzacWnCzC2czKkH
 Rv/u5SgLCyUMrLh/A+FzDR/a3NN5jhVeQeQtIGTaAp5X0B6d1lXnzbCAYKBDCz4c8QrU
 JKRExhBlBZNYZwuLSjqp/HtpVKoJZwIKIj/Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738714116; x=1739318916;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CyXDNA8KNLvPyzSq+d9ebYqFls+i6SIRXXrPjNQgGME=;
 b=mzEa4QWQ6F4hNAOe4EPneCQJb+/A2uWacP/xCn9FwMETGhkMufYmHprw7oqporzqUa
 r+P/E45bwg6hKVT4IogQhY83zDSIo5Dcwd8Lo5swIJ3TbHsJcx7iEMBpmuLVtCkaF9KW
 R/jucoIeYBB5j0bzWK152Aalk1eTT3jBcZkwvI3VGtC1n6DEtciOROeocFjAAh64IZv5
 XeTRnNQLg1neOTsZ7DWXh3IIpPfZBoJUoyyH1HQyowolsYBjDn4YsdNtnop+2C+tATub
 RTe84AdaRUG37FkLYnirree0PmPq38QpUCZVaiXPOl88EXPZLLrtCo0YINWoX4xZvzhl
 cHEA==
X-Gm-Message-State: AOJu0YzVRS7FFiLMNwPPcJv3CMcl0GaMafjbVGjmas2TWW8n9yGxp67m
 xFXlcjHffwFgy8Ey614BxusKwdyzW2FgGfmRffUPh4ahkNW1JFYs+qMFMNXj1Ps=
X-Gm-Gg: ASbGnct6eOF6Cd2ivHb5viXRO7fo3BJLP06oarhJtHhRccZ8ATgG6/VczNfNqrRnXzS
 mCHJyr2VWXYW9ib5JsFr83e3AEM3Em9tdnuj3RhgcGg8OrcGu//v6+D/YlLxVtG2rY8pMV1B7rz
 pzxezs+hRpM7cRBlu3VIoxMMdqU7WvpUNEfW/5QktHhPZe+5aymCxOtdiF4M2ULquBDmn506qvV
 sLq98rKv1na1GMajLrFdvsCPtYYkR1dd23GLSrLE1GYowiiqiRC5AHyeW7ywoQuHtifwzCBWY7a
 znedg2RvoKNXYFM=
X-Google-Smtp-Source: AGHT+IFANDPf2rFiW4lP8KLI3TOXe5enxazlintOk+y3FuSmoMwNj/neTKy6g3QzFoltLvZvqRi/Xg==
X-Received: by 2002:a05:6870:d10f:b0:29e:32e7:5f1f with SMTP id
 586e51a60fabf-2b805136358mr627196fac.27.1738714116498; 
 Tue, 04 Feb 2025 16:08:36 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b3562131c6sm4365530fac.19.2025.02.04.16.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 16:08:35 -0800 (PST)
Date: Tue, 4 Feb 2025 18:08:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH] buildman: Update tests for newer filelock module
Message-ID: <20250205000833.GK1233568@bill-the-cat>
References: <20250204233355.2293249-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ephlFZTuI9fAPru/"
Content-Disposition: inline
In-Reply-To: <20250204233355.2293249-1-sjg@chromium.org>
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


--ephlFZTuI9fAPru/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2025 at 04:33:53PM -0700, Simon Glass wrote:

> Recent versions of this module call time.perf_counter() so add a patch
> for this also.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reported-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ephlFZTuI9fAPru/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeiq/kACgkQFHw5/5Y0
tyxltwv/YUuoIlHwcp1wW0H43uBd9kw5RQvJKk8F6wM1Gu1TMl6+rbQ3iPDwjBMa
JoObj/2dN0Fg8sEpH4mh2ZvfNv6jh1xO+rlWLhjwWnMHts7O56zkUPmmbJzHXZgA
rCAxtLw/SRfpY++GtpWXZUnOkwiBNW7bxVMmtX3aoK/5Sw9f8DmSn4QkiIdgfUGa
sfVpHVAatyXbiiVdaHe3o7JTMTM/eiYJ31BfSUYJrWuhbEr4cg8xVui8qehsshed
bKQPOj3xS3/qcTcHAEKjZhg8/DvG1tj7Qm9A9RC6dYoHlfdQ4LKGHHzs9JxKNYLE
3BceQ+ZX9yDwp6WrbeqTxAsaOvurz0Qkv8SxgPOYqvk2AtS7tkh/o+oJT+l9XlXP
dJKL+65DG8pyp7dhPda1/karOxeaK9htntlllQyYdkk8mrte9ZhqSaz2Zfk5pd8Y
nlgXPn9vVVNZZTjpciaseuOKyz7Iim1e6TPDWUPfKcDwHkih0ChTD00ypqFtaxaS
zw5jVdsX
=vdp4
-----END PGP SIGNATURE-----

--ephlFZTuI9fAPru/--
