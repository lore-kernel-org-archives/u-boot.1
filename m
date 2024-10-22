Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E8FD2C55A
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 14:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D82EF891E9;
	Tue, 22 Oct 2024 16:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oFaefCxn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A0468905F; Tue, 22 Oct 2024 16:01:58 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA10188E89
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 16:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b152a923a3so376855285a.3
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729605713; x=1730210513; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=16pnc4Xs9hzhXKq4ISCPrg3SyS5RHdjDbKGPd191Ajg=;
 b=oFaefCxncoVJe2QStgo4R/jh9wcT9hzh0zwJrqPqBm81agKv+X5ZvcyEI9CGWNsuq5
 SpQbZKoLhcNKtxYAjrC3+yn89/ki2/YG8Rr0gjDJGLfTx7k6VNRQmKL1vz+vySlkMTQu
 NqSXJPN0zxCqxkybkLy8praWsK8uvxyV5ecOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729605713; x=1730210513;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=16pnc4Xs9hzhXKq4ISCPrg3SyS5RHdjDbKGPd191Ajg=;
 b=NW7VJkgKFVDToZn/H0bc4xOpA587JT3T21LU/5TwIJ71tTMfw5j6LTfZF2kzOdz222
 K4EGFc3euOw56waNkgoEw61lgkzQ2jDvBFV1k9HTzcifpkyhyJys9zeQbKnN5vTKMFXr
 VyhWdApcld0VFyNmd/zROmcp5Q88fHsR5dX78Puzast4uv+qKZSjlK/3P0KTbrRCvczG
 k8+F3xGtzxrujnLeteCEMZlGVgoR1mU58AcL1aJ1isHIepJqdhlZYqzpwysQQYbYIsBV
 VXmMC0nYIPqmqKrYgl1qnfGFU0kvHBOJY1MivLJuCaXJDN+CGilAECMentT5fonRLKYt
 mmUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeCJT7FgZ4o9KwXZ3EKeAOBhRDtq3cliv7DQD9Y2Qsr1UCjOaXWmCf3Z/WoyW8rfR0FQFTnpY=@lists.denx.de
X-Gm-Message-State: AOJu0YxxvmCsfbAw3eEt8X9hsOxUhOWgPfoc+oum++22mtN65ISUDlQF
 tGD6evJcA1Wu15243djq+He5qXI30Wsztq/RHGkxXJtTW99XnXc61GK/nnUnjV4=
X-Google-Smtp-Source: AGHT+IGjbqnCoRXj7jjJcvNtSGh52Z1SVnWcJxbvY1O7MqRlgkSBFlhw8RkY3o3E1kYBmZ2/yw3C2Q==
X-Received: by 2002:a05:620a:29d2:b0:7b1:4a0b:88a with SMTP id
 af79cd13be357-7b17670323fmr295748185a.4.1729605713470; 
 Tue, 22 Oct 2024 07:01:53 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a7624csm283008185a.108.2024.10.22.07.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 07:01:52 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:01:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Andrew Davis <afd@ti.com>, u-boot@lists.denx.de,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>
Subject: Re: [PATCH 3/6] memory: ti-aemif: Add ARCH_DAVINCI to architectures
 that uses TI_AEMIF
Message-ID: <20241022140149.GX4959@bill-the-cat>
References: <20241021151330.1860929-1-bastien.curutchet@bootlin.com>
 <20241021151330.1860929-4-bastien.curutchet@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W2rN/vvpTT9sLyvL"
Content-Disposition: inline
In-Reply-To: <20241021151330.1860929-4-bastien.curutchet@bootlin.com>
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


--W2rN/vvpTT9sLyvL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 05:13:27PM +0200, Bastien Curutchet wrote:

> TI_AEMIF configuration doesn't depend on ARCH_DAVINCI while the AEMIF
> controller is present in the DaVinci SoCs.
>=20
> Add ARCH_DAVINCI to the potential users of the TI_AEMIF driver
> Add <asm/io.h> to driver's includes to fix build issue on ARCH_DAVINCI
>=20
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--W2rN/vvpTT9sLyvL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcXsE0ACgkQFHw5/5Y0
tywk1gwAlTigA8Ai4HZsdhUQAD3QvgPv02UpUw6EikdlL13fSvmpRz+YwNxJihC2
ZSE80sBnaX/Yvq++6WQE8gGytufqCjt0bFiqKHcLjB+uZMq2O0ZKjuQxxmi4V9f8
XzAj16U7FwUenhn3HYLOsO/7455CFYDCL2xA6NcgWgqPdHan6ykNSpixdL5bP5Kn
LelPEWAKH76Y9Y5/r1/IfPHRFEGta8XRfdMmYnQ2d7cDsXLO9ypbMNkKMa1fnM3j
QB99853lL93zeBmoJpeXgHjdxEYH/rJar/neaRaENhvm5Iyi9y0Ekor7j5eCuimx
DWVXdh7JBiX8gZtGsCmdEn5vaX6zbYSZVjkZ3y99gBRZVG3mnt9T97IyHdpZyQJt
eJmDmtJZAhIrc8PMiW91Zzfftaw3HIBfdJzUSn8eroLby/0GeR+jBiFNlVv+5UW+
+4wZU8QKxP0FXZ9WTh4AwHqPc2psQhtttsIU4pJlCLb+5s0eGkV8TUQpEQsnwOof
dTpgglMj
=FcQ4
-----END PGP SIGNATURE-----

--W2rN/vvpTT9sLyvL--
