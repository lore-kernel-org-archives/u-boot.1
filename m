Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE17CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 17:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5031A83A43;
	Mon, 10 Nov 2025 18:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lLafi/zH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E722C83A5A; Mon, 10 Nov 2025 18:47:50 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C22B883959
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 18:47:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c6da5e3353so2474787a34.3
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 09:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762796867; x=1763401667; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Hs3G1nhtH2Kkmap5pM0vXitZTmroQqXocwc+KMdOJfo=;
 b=lLafi/zH+qddvBKL2uJMMIIHQMA6zV7LufnoiUfTZuCYukZDe/ULqRprM2n7je+VtJ
 8afx1x0u3rB3n2yS3trTf1a76yG/q5ZL2jxUPfoDlrEhh0WEyyXfRL6pcJ1MbXnPpelz
 nLdoYJCEYfs9iWkC3BaxAfn5ap+qyMWZ/aF8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762796867; x=1763401667;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hs3G1nhtH2Kkmap5pM0vXitZTmroQqXocwc+KMdOJfo=;
 b=RcG/8eFXANTJyz7+O+N6xzUdN5zRxp8dWmm26bra35dObmDg9PIo1dJUxhtd0A9lAi
 Kpr9zewWtQaeY6vGE0haTRskouQxgmLLo6LhWrgpHpbakbd1++xKtZ+/ykPFfHtximCC
 LDaNAek50QvfOS4ZYHz2An8PT6pvifJqYlYn1IcA7iwf8PHOAIITL+iIrltvXHEq/uTh
 p53S0N0WCIl3UflgH8MMuE98LDiKO9C2wdfYKWj6u799YZy3j7D2ABZoaPEosUZvF39a
 /H5RFrbE2dFt1VU2m06ShrICm0wbFU02tFh+TUL1ziAl25y3VG9KNqADxPiJPOS3jUMV
 eeJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJcy4W3S3L1CuBVlXH4yNBMh3zqeYC83aPJup0GcDb4JoNSOdyU1gilb1e36AF+OyAkYENwE0=@lists.denx.de
X-Gm-Message-State: AOJu0YzgoABV/6VaVyYI0sXpRNMreDz4xncHPAdsOTbGthqeslpe4ITo
 Pmo5ZvK9aeFlRsmrw9Bit1Nxj12ouIUZEKydNbT4FQOFC4GgswgMUbss4vYDCSkmMFc=
X-Gm-Gg: ASbGncsxpBJmVTp7ZRvFshyWrWsjLr1qVydv8W+A6iWeyu59rS+zcg/EZOx7IZHKYCR
 0iUGMIInzzgY3frZB4stBq4EVvSuWMAJyVIOPB/d8X/6tphv0IuQpsFBmaeeQd/mhHbTvhXqTic
 ni+A2hH0LvL4TMHijLVizuiguF9FTEoTxjHAzPKXv4btEcdXlRcLdThIFH9+HFrqYly0gEQeYu6
 jI4SiTkDZL6YAIGas4YCRfqjYvCiuarMz0OBH7F+dZBhOrXrfUqB1Oq7nblxBtZ6q+qQsISm+mt
 caKeNiGS7uZzBgaZOm29iqR7SiuLEDrzvi7EPRqw30Xh4JsElMPeegPE/7F4zLPsEhDuGTKdDgJ
 wVwcuR1f1jwSZVQDN8e1bWrI1WE+n0vmk2ldrOQX+T+ZZQUbUEP44L66zs/I1Rlzc6DRzdLZTDg
 /1sdYznjlRNmaLIds4bk01ZDqRn/7GJsnn3wrVQ6crRePqyUpbGQ==
X-Google-Smtp-Source: AGHT+IGXJ99pxdUZ00Pz/uo/Wzd6Z1feaVItU99TuhtexAb7fI97bhxd9ddxkPIPbVEUbUR61mOXPQ==
X-Received: by 2002:a05:6830:6744:b0:7c7:b4e:edb4 with SMTP id
 46e09a7af769-7c70b4effd7mr2938629a34.8.1762796867439; 
 Mon, 10 Nov 2025 09:47:47 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f0bb55sm6022265a34.3.2025.11.10.09.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 09:47:46 -0800 (PST)
Date: Mon, 10 Nov 2025 11:47:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
Cc: a-nandan@ti.com, c-vankar@ti.com, u-kumar1@ti.com,
 marek.vasut+renesas@mailbox.org, n-francis@ti.com, peng.fan@nxp.com,
 semen.protsenko@linaro.org, s-vadapalli@ti.com, jm@ti.com,
 m-chawdhry@ti.com, ahalaney@redhat.com, u-boot@lists.denx.de,
 danishanwar@ti.com
Subject: Re: [PATCH 1/5] arm: mach-k3: j784s4: Update SoC autogen data to
 enable PCIe boot
Message-ID: <20251110174744.GM6688@bill-the-cat>
References: <20251110094144.886956-1-h-salunke@ti.com>
 <20251110094144.886956-2-h-salunke@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EexI+L1qDm+yxM+6"
Content-Disposition: inline
In-Reply-To: <20251110094144.886956-2-h-salunke@ti.com>
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


--EexI+L1qDm+yxM+6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 03:11:40PM +0530, Hrushikesh Salunke wrote:

> To enable PCIe boot on J784S4 SoC SERDES0 and PCIE1 should be enabled
> and configured at r5 stage. Add the required clk-data and dev-data
> for SERDES0 and PCIE1.
>=20
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> ---
>  arch/arm/mach-k3/r5/j784s4/clk-data.c | 211 ++++++++++++++++++++++++--
>  arch/arm/mach-k3/r5/j784s4/dev-data.c |  45 +++---
>  2 files changed, 227 insertions(+), 29 deletions(-)
>=20
> diff --git a/arch/arm/mach-k3/r5/j784s4/clk-data.c b/arch/arm/mach-k3/r5/=
j784s4/clk-data.c
> index 24780eb6562..7ea67ce38f5 100644
> --- a/arch/arm/mach-k3/r5/j784s4/clk-data.c
> +++ b/arch/arm/mach-k3/r5/j784s4/clk-data.c
> @@ -1,11 +1,11 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> +// SPDX-License-Identifier: GPL-2.0+

This is wrong, "GPL-2.0-or-later" is the newer SPDX tag. Please go fix
the tooling if needed, thanks.

--=20
Tom

--EexI+L1qDm+yxM+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRIlPAAKCRAr4qD1Cr/k
CinMAP4ww+Ax/Xhue3+0EaPWjeJVu+6fSPNQQ7MCUDxOnM/tegEAlDImpRIyLcbd
plIPiXMv5jHfJjZP5vYTXekgG6cjugY=
=jjiE
-----END PGP SIGNATURE-----

--EexI+L1qDm+yxM+6--
