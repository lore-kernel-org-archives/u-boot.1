Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A931C021BB
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 21:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C26F980977;
	Tue, 25 Feb 2025 22:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nm3quji3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 792D480F7B; Tue, 25 Feb 2025 22:06:53 +0100 (CET)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3980180805
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 22:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-86712bc0508so1732044241.2
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 13:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740517610; x=1741122410; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uXLx0w3CZR4jFXfMTJ+2pPWovUQW6ajwyHbk+0GRO6Y=;
 b=nm3quji3yzrbz1qsS/Uy+139QlAUCYVWfcGxs+u82MjrPIBBnSEsa91mV8PHt4zpRt
 JeMpTtGWXoMxtGNWBESLc642JdSKERTi/ioW7CO+/4gDqj7E7a/68Cx4Dlot3PU4qieO
 G0bQ/A7C1sVpunDWgCr7fuz0k4FBkGgBjqx8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740517610; x=1741122410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uXLx0w3CZR4jFXfMTJ+2pPWovUQW6ajwyHbk+0GRO6Y=;
 b=OMaFxOEybzuPRSwtpk61MrS9sirYEpV/6l7jUzrGHtrYtdc5ezxgfVqM95DLqf98vU
 iGcgGcoHY6DyqkTb+58PLXAE+vQyiOEpDF1dRrK5gG+mA6Wu5aRSv4Ae/7iMzPrz+q8V
 Qf6a41dtL19ZBK2mW/AFNuKYZAkRkNv+TyHvdSXUOdYSnv65R9+/V1BbB8eSoGY8LMCA
 KZ1e3l/f2VATBiiYwTtR+Ampog4qA10SQtVO4XLFuMDJ9Xov20WjR4JTLeSEk9uCG3bG
 ws92JpilwWlN5iMQ4PYViraoDA0Q1VmdxKxSJzpaHEK47swcutPEzHU8JTlFQuqj+nOF
 0NwQ==
X-Gm-Message-State: AOJu0YwjlHxv6DvI9Gt3d6IXOQbFGiidSsP9MzCjDWLVlYpRSgr2zEeQ
 cVi6LmBHgP6w+sbTbnDCy0Xaz0eDyh1K+5OjH/0OidZfv1qfKqRXaszvqhN3AcE=
X-Gm-Gg: ASbGncuEXQ36ihRXz2n/eRFZqRUAguwoc14FiFiQ6nJ9QNUvyqrxWb/DnrEQ3sShypY
 4TzJMFliLwv80MsO5xcnZfUuVPiFOgAHSvK/KBgRU4cZJbWw5o/eSRXxpLnuL2MxYCMRc9xuF/8
 /ubfV8pImunLcxiUVyfpu/CRMP+O0/o12wYp/G3drJbSGo0iXYN6jXvSh/39X45pdP9Ye82aMB5
 55VdJa8ZFNWcq9o0bjM/TgKvGISYszw0/5pW/ar4HE8z+ORnVTACtRR5P3fvYnOjDxlFMJLW6PX
 djJw8P8EVi85ZfUplbof16ls
X-Google-Smtp-Source: AGHT+IEalofbGoRX1NzU1xi7ZHzhgrZ2+/oK57D00N4Hv/Y38zvVZVLN5EYKwH/9N0z04aeT5Me3bQ==
X-Received: by 2002:a05:6102:6cb:b0:4bc:de7e:4153 with SMTP id
 ada2fe7eead31-4c01e18b50dmr570316137.3.1740517609980; 
 Tue, 25 Feb 2025 13:06:49 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-86b1ef24a02sm476230241.28.2025.02.25.13.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 13:06:48 -0800 (PST)
Date: Tue, 25 Feb 2025 15:06:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: Re: [PATCH 0/7] binman: Check code-coverage requirements
Message-ID: <20250225210645.GA2640854@bill-the-cat>
References: <20250225200635.3781149-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lY0vlAdWgdxtJvtI"
Content-Disposition: inline
In-Reply-To: <20250225200635.3781149-1-sjg@chromium.org>
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


--lY0vlAdWgdxtJvtI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 01:06:25PM -0700, Simon Glass wrote:

> This series adds a cover-coverage check to CI for Binman. The iMX8 tests
> are still not completed, so a work-around is included for those.
>=20
> A few fixes are included for some other problems.
>=20
>=20
> Jiaxun Yang (1):
>   binman: Workaround lz4 cli padding in test cases
>=20
> Simon Glass (6):
>   binman: Exclude dist-packages and site-packages
>   binman: Drop GetRootSkipAtStart()
>   binman: fit: Drop unused code
>   binman: Drop algo check in CheckSetHashValue()
>   binman: Workaround missing test coverage
>   CI: Run code-coverage test for Binman

While we likely need Jiaxun's fix in order to be able to update to
Ubuntu 24.04, the series itself doesn't apply to -next, please rebase if
you intend for this to be in mainline, thanks.

--=20
Tom

--lY0vlAdWgdxtJvtI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme+MOEACgkQFHw5/5Y0
tywK4gv9G9Pi9gbhGPShd+W/DrsvDe30iBPZkWvB2Xp/beRmXKeukA6LDsOZ/rzM
HjAJPVNBU7NHqoI+7b7guUM0PxvRkRRBM15PljuT0nMxDW5/SvLzGKbMh9hcSADe
qyRlbZLewKN48pDVo1i0M5t3jb5vyRVF/eQwaj/XujNQCsBB/GRxkgYqCXHE7I/S
4R5KY2oz/5kZ0GGevJMsirkmKvRvWKk9phkOiwiE3LuP+LYBGlox/U8w/H3Odayk
oWd+gOfr16AXcpssXHPx2sU63MSHMnB3spjKWrOtttxW7r5QHCPmNRyqt5Mfab9v
Da8QE5Yrz4vIJFhhiNnMjdpddfSnjxNCUZQoKl1r2G/Owz35R40WF6ouhDRmRGPq
CYY7NoYVAHhx6P84Py7bcFZXXGG/MewNVwOJm+/gPpZl75ET51UaDBbAiKXwiNIP
Gi4eLVQ2AsohJPhY4HWU0FiB6VDmtNpf8PM6B4+BchqxaPfhrAplOLfy1NyctJOn
wXf4Klzc
=+8Rq
-----END PGP SIGNATURE-----

--lY0vlAdWgdxtJvtI--
