Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3890CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 19:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E48183E8E;
	Mon, 24 Nov 2025 20:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dLaN2qv3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4E0B83EBA; Mon, 24 Nov 2025 20:46:02 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A298783E62
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 20:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3ec41466a30so3025006fac.0
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 11:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764013559; x=1764618359; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZiKTNwD7Oq24J6+aYtrcJOvJvnYIy/qN7MgQUF/ypNE=;
 b=dLaN2qv3C+j+7d8JPUSnimCc1IZC/8Mrc7sAZn9yGBW/Wu7UjETguJXsxf+UPr5AO1
 r/tyLnLJaLVBWUMJZfzuq0e4AVWo9Zx/ZAA6/FDANx18I1Zfok37iMZ2GgkyfOpo6zyy
 hPGHzA+eWsb/HUNw6gE/Y6vzsZiwnS2dHsvYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764013559; x=1764618359;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZiKTNwD7Oq24J6+aYtrcJOvJvnYIy/qN7MgQUF/ypNE=;
 b=Tjd4SPNko6CEXsWl/Nm3jreu3M+hxngiaVxWioBw10EbcwBY0POnAse3d4fAZB5pi5
 bruRjCiVvQKQyvYC++3Eb/fp88REsXHTDaXWucrggQlwvGxwLWSwHaH9+u2VAW/LsMlG
 KG/CY88PnGYg3D5U7Q3fHbG4oeoA2D069lzouGTwZL25NPe220Q2liuWDYX1wDnmnzia
 cr+bmXSWMIeJvZCr7oYsdADiEfQ6JkGZurPUQ902fWx1vUT+BmSglMj2myF4yva7nf5e
 ldGplp3Jlq/5UmoXwvXC4q1JRUOHaNQOywTNrQSXqLDqdcrhXFDZYnA1lV9lqFopQ/zo
 1nIw==
X-Gm-Message-State: AOJu0YzHicbyzYQbNdAZ+kLAgzIm31Rveqq8jEJXRsf8VgD1e3Orzz/U
 N7jsYbTBbcZ/TyoMr48/zWLpZJcomXe6xFBi+TdHL8T0f879kdpb+1qB7NdVOV152AM=
X-Gm-Gg: ASbGncuiwJaSWSQG0+dLFPD1ZfsYEJuM3a8+lrmbjSl4u7UkzxFWU99ZS62dceeS/No
 f+n6c+l8V68t1XpENdqaPzeWsB3NktDCtQ9Ah5otO0kNw+rQWLUjbde9P224A7rI4EeDR1hvBpd
 YXTg3NxrNL7EOmr85fhDDZIlIK+CKvnx8a0C3hSQl4/t1yEGGkv4mMmXC3lDMzfmfkkQBn95nmR
 cf5Oc1fzVCh0bN/i46XLv76x1aswvnjLSRKxfdfeQ+oOSDLfRdkzPQWaOaRAuHFZorJzgpYPvwk
 X+KiTGywUFTmxOjmtPc9SNt2UyWVSVqrtwWxDKFTcnK+ccVIEFcF7Y/o2Rd9wCXtbG0kjMfpncE
 vl+dYdNQPirVmgA3Elw5Un6NQrhgJ6wn8f6PcCvjBBby3Xh1OGLyfwBmAVN3Juv7bSzXPrsrUrz
 ZbuvWsdqUzKohIZ50rFviC6rXohSfv7Nh3/uj51ExM41R+EVTSc4Hf5DRb1cbt
X-Google-Smtp-Source: AGHT+IGDVRjla+PbU2aVF/f8NOC7sjLF4wAc4vlG8ghonJOjr33r5owozmskHjim8QOQhBkKEGjgvw==
X-Received: by 2002:a05:6871:3a24:b0:3e7:dea2:9607 with SMTP id
 586e51a60fabf-3ecbbc38ee1mr6032255fac.11.1764013559372; 
 Mon, 24 Nov 2025 11:45:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9dcfe28csm6566475fac.22.2025.11.24.11.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 11:45:58 -0800 (PST)
Date: Mon, 24 Nov 2025 13:45:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
Cc: u-boot@lists.denx.de, Leah Rowe <leah@libreboot.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v1] test: correct strlcat license information
Message-ID: <20251124194556.GM2125796@bill-the-cat>
References: <20251124181611.8150-1-GNUtoo@cyberdimension.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dEYs++g7Dy+R2ltz"
Content-Disposition: inline
In-Reply-To: <20251124181611.8150-1-GNUtoo@cyberdimension.org>
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


--dEYs++g7Dy+R2ltz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 07:16:11PM +0100, Denis 'GNUtoo' Carikli wrote:

> The GPL-2.1 isn't a valid license.
>=20
> The copyright header says that "These tests adapted from glibc's
> string/test-strncat.c" and test-strncat.c is under the LGPL-2.1+.
>=20
> This was reported to us by Leah Rowe.
>=20
> Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
> ---
>  test/lib/strlcat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/test/lib/strlcat.c b/test/lib/strlcat.c
> index d1a0293271b..70982d5cd68 100644
> --- a/test/lib/strlcat.c
> +++ b/test/lib/strlcat.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.1+
> +// SPDX-License-Identifier: LGPL-2.1+

Thanks for the report and confirmation on what's correct. Can you please
use the "or-later" syntax and not the deprecated "+" syntax on the tag?

--=20
Tom

--dEYs++g7Dy+R2ltz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSS17QAKCRAr4qD1Cr/k
ClmJAP9lcmxPznXCHK67Cxtt7KjefD6XBjv+dPQx1MDZDEOLdgD+LX0777+FX594
aUe4V3cbh1r2p8ApMyXvjzjU0StAgwM=
=jxK2
-----END PGP SIGNATURE-----

--dEYs++g7Dy+R2ltz--
