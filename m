Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43599C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 16:15:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B593C81417;
	Mon, 27 Jan 2025 17:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rSt6UucG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B201F81436; Mon, 27 Jan 2025 17:15:07 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D87812C8
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 17:15:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b6f53c12adso425597085a.1
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 08:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737994504; x=1738599304; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qg4/DM1ya9pEZO/04nwzRK0CVN/TXkInZBMVTA1F0is=;
 b=rSt6UucGYWt6SVAJNtIeTTrH5vKkpeBVo8XPiUm/Exn9bj9s5y2gRZyYxxmcFwlZvv
 BZi6+o/U5sr2ydHbmWUQA5OsHQ/l1+SAPWSW59++d096tsze7RS+TlJp+EBLiJKnS8q6
 Ot3i2kNnAJmMef8cqRBYugQH4bOZFx0WK7u5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737994504; x=1738599304;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qg4/DM1ya9pEZO/04nwzRK0CVN/TXkInZBMVTA1F0is=;
 b=U/Grdq174vQnF7j+1FrBT0rNYZwRuucCmAA+pceeraHX9nYIKwCNShSI+GTeZSa19i
 y8iAQutYSB2pRqyM4tTU4xFO58eBi5V+7tnGb4NvJHmLyL5jRKWnNpwvdHTq9zbfYr5v
 97FXkRLk8T7dGOyo0Vn+HEoY5ZYEYLolGEc3hsKkoh+qIwHRfMK15wQOnuN6F3DWL1qD
 qmZ12H2ZbyCA9XxN4Zl7b2zBEihL8ztA+UU7KibZfUUqoUH1U3l+Ln3++wObNcioxF0B
 W6NqGlQqX/q/4SipwwUVArKvfSJ2Dihlzu1PektsrXEyPCt+m97/5vfbbigtCxqKyhDK
 ohQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6k/i8MjnQasXnsmI4zfwerwu9J1/tw5iV9mlLJkZbYC0fRJqm4etO8Axwlt5/ogX71xhf14Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwZFsWiAchzXW6NidB14KQjx9JSvmXmAgqAIH2QtU2kjmMVfK08
 AMS9fnA7PyhQLzDk4098O0eKnAuoirNjU4CZJQIajNnkjSP0rjxjWhMQUsbiM8o=
X-Gm-Gg: ASbGncuTevU/v4DTrBQ/lYfiOq6lUnA7L/EztkL9qOpaAWb+7QRNivk5ep5e+MpGHf4
 KFtnBEppEi0ysiRXHcQ89RUBXq40eIUZuBMECReUq7MJgEklpXOA1GrVk/CpkIJa56Z/NFBx7Kf
 YEZr0Ft0GoJPOWh/DDa8GN5cn/xTbnnDz5tK9AetYdWTi88AfTwHyOauzl7mvfMAMrfwg/x3tEd
 ZAgCFCGFyb+SsZani24aOlij16YCvIlnwAxcOWl1sUh6NBkSi7LbiA0LdBoV8LxTWovYs2bpiLN
 3SVEWiDga2FVhAo=
X-Google-Smtp-Source: AGHT+IFETy2xKP750EHHn1ov75gP9N2roZ/hzrVoWl/xxd+KKl3wuMecxXw5cKigbfGa2vlaLzA02A==
X-Received: by 2002:a05:620a:2b47:b0:7b6:f595:7550 with SMTP id
 af79cd13be357-7be6325fba1mr8693048285a.36.1737994504274; 
 Mon, 27 Jan 2025 08:15:04 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9af109c7sm402517185a.111.2025.01.27.08.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 08:15:03 -0800 (PST)
Date: Mon, 27 Jan 2025 10:15:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] board: starfive: Update the maintainer file for
 VisionFive 2 board
Message-ID: <20250127161500.GF1233568@bill-the-cat>
References: <20250127083814.67839-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dNLHMdBJebYT3Gsn"
Content-Disposition: inline
In-Reply-To: <20250127083814.67839-1-hal.feng@starfivetech.com>
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


--dNLHMdBJebYT3Gsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 04:38:14PM +0800, Hal Feng wrote:
> Update maintainers for StarFive VisionFive 2 board and add the
> missing drivers to the file list.
>=20
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  board/starfive/visionfive2/MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visi=
onfive2/MAINTAINERS
> index d7f638f9b41..14fe8368548 100644
> --- a/board/starfive/visionfive2/MAINTAINERS
> +++ b/board/starfive/visionfive2/MAINTAINERS
> @@ -1,8 +1,16 @@
>  STARFIVE JH7110 VISIONFIVE2 BOARD
>  M:	Minda Chen <minda.chen@starfivetech.com>
> +M:	Hal Feng <hal.feng@starfivetech.com>
>  S:	Maintained
> +F:	arch/riscv/cpu/jh7110/
> +F:	arch/riscv/dts/jh7110*
>  F:	arch/riscv/include/asm/arch-jh7110/
>  F:	board/starfive/visionfive2/
> +F:	doc/board/starfive/visionfive2.rst
>  F:	include/configs/starfive-visionfive2.h
>  F:	configs/starfive_visionfive2_defconfig
> +F:	drivers/clk/starfive/clk-jh7110*
>  F:	drivers/pci/pcie_starfive_jh7110.c
> +F:	drivers/pinctrl/starfive/pinctrl-jh7110*
> +F:	drivers/ram/starfive/
> +F:	drivers/reset/reset-jh7110.c

This would be a good place to do something like:
N:	jh7110

As that will catch all files/directories with jh7110 in their name.

--=20
Tom

--dNLHMdBJebYT3Gsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeXsQQACgkQFHw5/5Y0
tyzwdAv/fIjIjsLD8BrCzROOTJcHXSM22S0frOpf2Cq6+u7e89AtIVyPkIhxvNAx
rcfsubve1jUgjVILpyOiMCoLCTSYaM2b/RdRgz8oM3OiHNpWtAAO2SU3esNRzsGu
kdDGeoOyzAUPQBjKQhU4dnKtRqxTEtTpjz0fQKDFDK4Jbumm5Cx3V0ty8gangB22
Wc0Mkr5ImR/Csb9IitMvlnjDUbDCEFceArsZqAO1K0dU22d/iWsooxS5EMqsN9gv
KSZUcWLqPa2oURGYn4XdzKxcyaKFQUVNGhBjV2KoqoFsPig/HBW2s+V0RIoWHwuI
gJYefMeD3se0qrD7XCETR6MdICx7MixUBAdz+kQhSwrliUmgbifc/ouRgvTSuuP1
e952g3A9EVir0+2uG1imwUbN4p0ZtTeSRhZxJo6dcqLxt+4/Y4+633LiLu9c9A4M
H6W+8x+nHU9PgUWgaUNR+jv79EOq2s8QSV3sptEAcAgAPpnkUMGAZiAKEwTyddCZ
RnFiJRyf
=eo2W
-----END PGP SIGNATURE-----

--dNLHMdBJebYT3Gsn--
