Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829C0C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 17:08:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E882582139;
	Thu, 30 Jan 2025 18:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nzwuI3D/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54BB88213D; Thu, 30 Jan 2025 18:08:50 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 273BB82114
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 18:08:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3eb972dd8e5so548414b6e.2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 09:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738256927; x=1738861727; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aR3ZR7LEk4Rs/lnaZiIZ1mEjJoEUcRshYatxGhWqpHc=;
 b=nzwuI3D/BAmM96KZlXiMaU4K+9QKrfAoqlILKICSolvQFYZ/pCTiUjkYL/dBkK8d5u
 9zKgALMaEfQ7NPyStlEv/pHjDNbGTFgcO43qSBLFgZCwdgqkOgXdXZY879ONsqvU3HYd
 bhATnQQp58z/IRuTlZmg63KesLKTiBZlbgwrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738256927; x=1738861727;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aR3ZR7LEk4Rs/lnaZiIZ1mEjJoEUcRshYatxGhWqpHc=;
 b=jR2Znbans4kYjdIA1imbwxWe0VxktEgh7C4ihVWoWN8Wdtf1AC62ab6FbsTLblpcjJ
 JCTc8s8rwUthYfHx5lpqhGGnYlOEZ6nLqxUjVolDCHWSeDwF2HYqCMZADUIWrO/l2dvY
 0lDlSQPEJOFaRte7sjBOWkFF9atBfssQMEKmIIfNonho8XfzgTGBa46Fhd7CAo5mUe7R
 Nvq8jADQRFdxRFJaZQX0FD9zDAHmhg37GMvecQNETOMHkPlr5GuGE/kELpKQK/dbhhmu
 1AK9x9IBkiSKxOjm7loZrUMm0MYNl7rrCeUsZK6xtTpQ43w9zdOM3U8zV/aOYG9hD+QR
 aOnQ==
X-Gm-Message-State: AOJu0YzflTwxiMQd9z+6xAzcTOQ4rFtrXbFRaw0Tsz23VPnAxEoU4o17
 x9QSsVD57DZ0EOtVBCxtjyOF2mEz4BKaOwW4zw+8W6bqFlYVlVilvILm3HmSQik=
X-Gm-Gg: ASbGncvyE/eP0/Xcmr2BZf2mZRHhnNgdcwI63kDlqncJcO/XLSqbshmerM66Nmecpf+
 mJTvG5rr67FIzFTWCM3ygL+RuaH6C2+V8Er1hA9SpQz1LL6aS/pKvA7CKdkL9Pm8nhlOTOkB7n0
 5+VC24PD/l8uyFd1mDS8BS1Bh4vaNPMR2OkPDg3+ntZyUtP1XSnv0k/k0dxYVUHv+Shs2Thk/D3
 QYB/MJJH+boS0JWmBMQ8bCO7MyK3fUMpB+Ci5YI31vrCmy+p+XQZdnqA7R/98uBEEE2ewSB/WxO
 tvfYr+lkjm9Tjn8=
X-Google-Smtp-Source: AGHT+IE1lMC3fJTAbMKAxeWbqWXZVU2v1UmJ8ETGeuZxAsMD0gBKZ0UUuqZBhAjaE7NbBxOgEp9/Fw==
X-Received: by 2002:a05:6808:3319:b0:3ec:d34f:4c73 with SMTP id
 5614622812f47-3f323b40804mr5513980b6e.27.1738256926932; 
 Thu, 30 Jan 2025 09:08:46 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333523e75sm330874b6e.5.2025.01.30.09.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 09:08:46 -0800 (PST)
Date: Thu, 30 Jan 2025 11:08:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Gary Bisson <bisson.gary@gmail.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 15/19] vbe: Support providing a linker script
Message-ID: <20250130170843.GK1233568@bill-the-cat>
References: <20250126184333.4058848-1-sjg@chromium.org>
 <20250126184333.4058848-16-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o2haNE9s5sLVvaeO"
Content-Disposition: inline
In-Reply-To: <20250126184333.4058848-16-sjg@chromium.org>
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


--o2haNE9s5sLVvaeO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 11:43:25AM -0700, Simon Glass wrote:

> Allow a linker script to be provided for VPL as it is for other U-Boot
> phases.
[snip]
> +config VPL_LDSCRIPT
> +	string "Linker script for the VPL stage"
> +	default "arch/arm/cpu/armv8/u-boot-spl.lds" if ARM64
> +	default "arch/\$(ARCH)/cpu/u-boot-spl.lds"
> +	help
> +	  The TPL stage will usually require a different linker-script
> +	  (as it runs from a different memory region) than the regular
> +	  U-Boot stage.  Set this to the path of the linker-script to
> +	  be used for TPL.
> +
> +	  May be left empty to trigger the Makefile infrastructure to
> +	  fall back to the linker-script used for the SPL stage.


This should say VPL not TPL in the help, yes?

--=20
Tom

--o2haNE9s5sLVvaeO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmebshsACgkQFHw5/5Y0
tyyKywv9EMT67XgWP0ezaUbMV8XQwVlSJXj47hh1iHWe0St2J5lD/IVnRpy0qB2b
0+YMAC4pvccwbUVR76e53F8Dbg00D2250rzkIWUrhrcV5ZXuoUMpIi3gMKssS6nC
9OaxjCXCIoF9/TL4qrdJElIyseUnsKwdphaAFGuLbdNLg+tBYrJJFs7Oly63lV86
DKGSgN6xQA1TSi8NSRQCrZPYdXOxrZ6myD/9y5V6rTTqCVFG6JtnDZpHq+IvRdev
duEAzUEyhRDVRsl1zxGWPoMCPKOBI2hT/l7NQ66xk8Wi4TaqQfzs+bo5fXoRxbzk
RAJZPNO/lJ5KsyLibK6s3H0y8PbT1kc8PQ6N++zVKEtCC6TCnNh08+ZefUHe1Kzn
1W1PfHKErOvkH+poaxBczIt8OcooCCA4JOS0y2xEiBiokVwRfohhyRAtcEzfPrXg
VRggAfMQkZ8s4uLtNmEscK/Q8Cdmf216iF3lPCL2+gmifAx6EexF0rTUTTw9fAVz
1cogoZiy
=Eda9
-----END PGP SIGNATURE-----

--o2haNE9s5sLVvaeO--
