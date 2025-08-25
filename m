Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9A2CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D999805D7;
	Tue, 26 Aug 2025 00:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MigI4j21";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 866FD805D7; Tue, 26 Aug 2025 00:58:31 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C429803F5
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-30cce8c3afaso3104046fac.1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756162708; x=1756767508; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kuZAe7hOa/5mifswFh6JNnxh9hKR4+1jmVJGjkMkCAE=;
 b=MigI4j21iFASFSm6WzHLMLU57XOutLnGqBb1Q+BVUBuCzTyZudAcUmPGNPhhEsfxir
 BMCorlCVn/rGZ7J+sY6s371WVrVoExDmXqxQ316eycsRHsqR2WASHyaK0y1T+BfD3weW
 ug/jCcve7lVHnYhw7j6/rzgLnboTm8r8MxKfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756162708; x=1756767508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuZAe7hOa/5mifswFh6JNnxh9hKR4+1jmVJGjkMkCAE=;
 b=u830HOgmGfR+nd6C7DfqWpSzfv+FGTThWLAEh9EYHv7MGm+4VnpuQIuEm0XdFxFTYK
 GeF687ii586az54uOGTEK39juIHV3Vp2q4//x0WfeLkVmUY1+zQd38yhsjWntrOMvvCZ
 9D86N4DmbgJDKtns0YjoZ6FUhvQb0OKa1lzi2w7urrWuFMfWO4cVz9gUiJvKwWDyBw8f
 BVHsu6r8WSbQ3OnDi0Gh6HuuG0dOKBc0E28AdcaI6kTn87fSazMbYYHZEDoOK7J0bgEF
 fu9I/yfr0kIPiaRe+GET6l4b7w6WlxlyvXUsmb7bzJNcHXkbcrfT+I11OxsMNGi48wPv
 IqPw==
X-Gm-Message-State: AOJu0YzqU2GXjnVYe4JMOboolMQ20XI/+ch47YHH36NCf10/BCYQo7z8
 fzMOVzrYJW8DE+SPGLiDZTjkgvVvWIhAwBiHmdWmq1riE70jXU16ofWG0+sZOs6B/gI=
X-Gm-Gg: ASbGncvpYgodjsUI8qgzXLBdFx3+EvJspM7vcOenW4+Bs0633davsci0R9JeEHflVCH
 67rd3idlq3rOh5umhd/OJQQcdh2qzemd3DgSM4ZJHhIHwc/F8NJZYvkz1N2MMF2pyc2YPshdz4l
 VmDucv2csDtn3ETKvRSNvTI9ja5e+az/j1bHM2DDMSWEz8/gPkJqVNygCa36F3a11N+Nxuk3gw1
 yIhWxJu8KGxWC0WQPby2qWS6zGumpxsEpBshg6fYVfdY2UjzuxBAHYNH41ufB2wCORy4qeJ2HL/
 sj2aDwTW0T003YajfBAhzV/lt8lCg7pJQ1g6YCHGc1Zo6YP9f18VIo53G3Jh7i2H2yQ1WjexsB5
 kxCdH9BARIy7zfnokpK9ngcpnG0JBNfAiFYnLBA05NOF8zTHm1Lw4yFAO
X-Google-Smtp-Source: AGHT+IHLgnZCu+ouhfqExNWUkABaGXSFYUC/97+UGgQiQMekMd1VaRSFK0ffwrwCnop86qQDVaTpNQ==
X-Received: by 2002:a05:6871:e786:b0:2ff:9224:b1c8 with SMTP id
 586e51a60fabf-314dcdb031cmr7130416fac.36.1756162708143; 
 Mon, 25 Aug 2025 15:58:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-314f79ab6ddsm2066158fac.6.2025.08.25.15.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:58:26 -0700 (PDT)
Date: Mon, 25 Aug 2025 16:58:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH 5/7] doc: make pdfdocs: Update empty SVG file to
 something, otherwise compilation of the *.tex files fails
Message-ID: <20250825225824.GA124814@bill-the-cat>
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
 <20250825224459.682403-6-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MRUhgw6ZzUx3SD9K"
Content-Disposition: inline
In-Reply-To: <20250825224459.682403-6-adrianocarvalho.pt@gmail.com>
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


--MRUhgw6ZzUx3SD9K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 11:44:48PM +0100, Adriano Carvalho wrote:

> There is one SVG file (doc/develop/pics/spl_before_reloc.svg) that is emp=
ty (0-byte) and because of that it is not translated to PDF leading to an e=
rror. See below.
> This commit updates that file to something (i.e., an simple image with "T=
ODO" written on it), solving the problem.
>=20
> The error in docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul=
2025:
>=20
> uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
> [...]
> WARNING: cannot copy image file '/home/uboot/u-boot/doc/output/.doctrees/=
images/spl_before_reloc.pdf': /home/uboot/u-boot/doc/output/.doctrees/image=
s/spl_before_reloc.pdf does not exist
> [...]
> build finished with problems, 1 warning (with warnings treated as errors).
> make[1]: *** [doc/Makefile:84: latexdocs] Error 1
> make: *** [Makefile:2686: pdfdocs] Error 2
>=20
> NOTE: This won't completely fix the pdfdocs target. See next commit(s).
>=20
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> ---
>  doc/develop/pics/spl_before_reloc.svg | Bin 0 -> 239 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)

It's not supposed to be zero byte I assume, so can we please figure out
what patch was misapplied (I have some ideas) and then find the version
where we get the right SVG? Thanks.

--=20
Tom

--MRUhgw6ZzUx3SD9K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKzqkAAKCRAr4qD1Cr/k
Cue+AQCz18f/aPGOVovVNHh449VPlj1GxkefRl4IzQvUl8qwSwD+J928+R9P9lv8
e3znNURhxKIzmlAwVRUNZIr+QyrK+Ao=
=pKt7
-----END PGP SIGNATURE-----

--MRUhgw6ZzUx3SD9K--
