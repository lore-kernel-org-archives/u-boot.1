Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E33D3A696
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 20:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1880E8918D;
	Tue, 29 Oct 2024 21:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NGRDkdq3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C8F89197; Tue, 29 Oct 2024 21:14:06 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86C3389187
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 21:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b155cca097so21519385a.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 13:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730232843; x=1730837643; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wf7HEYR2kZfj0qeNz4Vo7JdhQ+cA0IpzRLINQqnI63E=;
 b=NGRDkdq3A9JzvpX8wycjL3XfSx79up7KrjUvd+GPfwrJsA74KN5pD/8Gn2NRBktu9v
 oEvngMgjKmlJT7SHj1OnD45Y9SCn3544nxHIXuQFYgaXJ7gG7OBl/G5k1bFQ8FteHFF+
 dJWyGbzi627E3Fvpoa2R1vz1pLbxgE4hjP/Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730232843; x=1730837643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wf7HEYR2kZfj0qeNz4Vo7JdhQ+cA0IpzRLINQqnI63E=;
 b=dDYZWAhJQH5G9YxdCyM18G2e3tCs9bpJGEgRpqeSRSsOby2V5YMh4R+tufsqp7yaah
 I5s9fWJjozEpar+5d9vAtqtO1BzKgG7kGLIVq4rwJ/eskrgqEm5wGlyyV79BNxTgj8mG
 hh5ZkljUhlctvYCneGuWfMKOGL9zbcEhXEefpApWDCA9lVCPZzfkq7EPC6T+v8NROwMP
 jaZ/bUbQG/3G7WnOlOBTTSIrwWMlG7BnR4KCZ6YdjxZN82ZcsGpEyMHjDPmJ7nyoIaCW
 ep+nS36fcqFLrUrfUZHUpZAKokIt3Hlq5jW0z4G0Rbs+rugGsioRazZOOqU2TK3VnFZ9
 x+hA==
X-Gm-Message-State: AOJu0YxT6tnaiix8UnpnJeiUv5jPeoTF7zKp1HjoHBlVFV0cjZqnp3fl
 3TlwzYkC/lMkXbCeTPCD7edLVoacVrGyPPElmaZIHnTHiIEMQQPm+I5I3FpwWNM=
X-Google-Smtp-Source: AGHT+IFOAW5XcJ2P5GTZXYNLxJjBcEz1WSsSVvor3GRv0B66fiGQo1ksrB4c/E74XsDl/1GXU6YPYQ==
X-Received: by 2002:a05:620a:19aa:b0:7ac:9bdd:6e78 with SMTP id
 af79cd13be357-7b1a9cd41c7mr605219785a.14.1730232843315; 
 Tue, 29 Oct 2024 13:14:03 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d35882asm449934585a.127.2024.10.29.13.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 13:14:02 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:14:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v9 03/11] sandbox: Add a -N flag to control on-host
 behaviour
Message-ID: <20241029201400.GJ4959@bill-the-cat>
References: <20241029192222.362445-1-sjg@chromium.org>
 <20241029192222.362445-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RZU40u1HCG54UDK3"
Content-Disposition: inline
In-Reply-To: <20241029192222.362445-4-sjg@chromium.org>
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


--RZU40u1HCG54UDK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 08:22:11PM +0100, Simon Glass wrote:

> Sandbox is its own architecture, but sometimes we want to mimic the host
> architecture, e.g. when running an EFI app not built by U-Boot.
>=20
> Add a -N/--native flag which tells sandbox to reflect the architecture
> of the host.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v8)

I believe Heinrich asked that you invert the logic here and add a flag
for when you need the unexpected behavior.

--=20
Tom

--RZU40u1HCG54UDK3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchQggACgkQFHw5/5Y0
tywP1Qv7Ba2gxqNVNPQDSolx+lmKdJzsAsdWjDXZvaqspGwK3fZYyA6FR1V/cbro
wfY5jCTN30+jJ3VgIFf3xRx0GijEJMb2RlpOZR8cnT5gB0ipbsC1k88L6Dx/d1Y7
p+iMs6jLxaE9JDg51oMNtDumMf5NyZLPvWikd12CoK/evHdc+IIXNuNORQkey3Wj
dCeLUS58a1SVS5LRcr1SccPD75Y5pb4gJgYo6+4BSX2rEVyUZJoVJ5mYdWmpJIIy
UgKLNIw+tQQRi9ruF0Po70KBvlXVBchsp35GF6srYLm+kl2wwLhO6Mkleftv8AX8
ZgNlao0E6NtHGZ7k2ewTTrxvu30DBehr1y73/JFu7NQQFujVyl0U0Gf2rOzJxmmQ
1tlTfZv3+lrWf9KbmK8KLSzDRZv1DRfLNxkLs4ZsPKkzY2vBGi6hL39whkv9wANU
Xkt8Q7hOOttqACWXpWeVTSu9jrivWK16ZNPUplG2xKplupyS+yPW0o0tPdFLUkGS
fq8zxC1u
=8pGf
-----END PGP SIGNATURE-----

--RZU40u1HCG54UDK3--
