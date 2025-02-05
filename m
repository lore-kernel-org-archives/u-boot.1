Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11786C02198
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 15:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A225806FE;
	Wed,  5 Feb 2025 16:21:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bLEHSAGx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E457780711; Wed,  5 Feb 2025 16:21:43 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B88380562
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 16:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2f9da2a7004so1990560a91.0
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 07:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738768900; x=1739373700; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7i7CT7u+Ruo+tiIpDDsLdj+AybM7A6hQRQ3peC9Uz5A=;
 b=bLEHSAGxDyFIlRleJL1e/hPr8mFkUl5xElIFdX11l/IJ+fvv19XscrgNu+hVdTy/pC
 Z97s86z+kH8h5kVWbiVl4k6jlOLq1cgq6PoGkN1pySQyhIYWYawB+6JdZOcxXekjVtAz
 b606A4sANpO7rDDaMrAU2c4I3vO+0xH16p7Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738768900; x=1739373700;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7i7CT7u+Ruo+tiIpDDsLdj+AybM7A6hQRQ3peC9Uz5A=;
 b=hbYwulv3jdS5L2YiE5n6PTGyqLPIvPfQFZPzmIfAXHFr3JeC4TCGzdbck9Csh9T2zY
 ui5zeQOeSGJd3XQLLFAawAlPLVUonRvvzOQT9Tge9VVkMIPOMeR4XaejFZAfv+CUY1Ga
 EL9FEwBWkByJUCU9Tq85ihdO0jR2/w51gjY7HRfE0C2XCxkBHPMp7XyQU4mdUxcfJxaZ
 JE8LhXsVX0k3Birj4KLo2YmYNDcGrlljL1hPvWd1n9MvhDZXV1zQCtSd3YTnExm/nVbL
 D+THjbnmIXKFfophjEWacwjABgzTNWt8X7cIRTVtE5ExIdPD3qwpondaqP1JNzATSuJq
 Z+4w==
X-Gm-Message-State: AOJu0YxxCB68LSCGWjTLudVBxB8M9Mo1ld1/WJBs2E5qBYhSM5cP/yE2
 6CmXw00h3ACHHRG89ZrA7u4IkJx8qnFyTXT4JnvircjyCrh3uPJchcM4A+Kvw9M=
X-Gm-Gg: ASbGnctHuRWhwW6KnQtezZtkCrY+7IUsszZz3lMB6YBGLydIOCLewmSlJViT56tazhB
 QllCEqi1QRSs/Xnrp3hxkyxttirv7IaDaUoTMUrQl5pyvG8QYpGpZrkBzytgRm1n5gARsbNofxE
 +ZvHYevdfVeoTTycwyZy6tXwVc5PLL+iuC+0IFakXyeNz4rRDuiv8D1WQew+f8eVi6DhdYOS1Pe
 v8UjQ3jLB4TcWkZy6CxND4vckU20X/0KVATaRGewyP4FpkVgg1gL9xLsDa1WgyycdgRhui9Wz65
 CLTmp7pLgdUFgs4=
X-Google-Smtp-Source: AGHT+IE6kFvdp65Nmv3pLf4pSFl4dvnI9iVvMq6MR7YHgcXxcTZmSurZjL9aBNsVhsKa0WIUzr7kJw==
X-Received: by 2002:a17:90b:2247:b0:2ee:94d1:7a89 with SMTP id
 98e67ed59e1d1-2f9e074d1fdmr4671681a91.1.1738768898550; 
 Wed, 05 Feb 2025 07:21:38 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1d60e88sm1706454a91.10.2025.02.05.07.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 07:21:37 -0800 (PST)
Date: Wed, 5 Feb 2025 09:21:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: Re: [RFC PATCH v1 01/20] include: dt-bindings: clk: introduce
 bindings for rp1 clock
Message-ID: <20250205152135.GV1233568@bill-the-cat>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
 <e6caf0dbfa861eb12e6298efa784a7184e2769c5.1738749764.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0YsCv9Q1AKOCFfIR"
Content-Disposition: inline
In-Reply-To: <e6caf0dbfa861eb12e6298efa784a7184e2769c5.1738749764.git.oleksii_moisieiev@epam.com>
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


--0YsCv9Q1AKOCFfIR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 10:15:41AM +0000, Oleksii Moisieiev wrote:

> Introducing device-tree bindings for the RP1 clocks.
>=20
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
>=20
>  include/dt-bindings/clk/rp1.h | 56 +++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 include/dt-bindings/clk/rp1.h

Has upstream Pi sent these bindings upstream themselves, or are we stuck
in a bad spot here? Thanks!

--=20
Tom

--0YsCv9Q1AKOCFfIR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmejgfsACgkQFHw5/5Y0
tyxaUQv/TYjHMNbXeCiEWknYP0vNlJ8XsU8AQJgQFSoQzvJxEHHDm3mTliN314VE
xGHkJxKnwv+1M+Uf/saXj88wrL5d9Wh1thi8d+U0A8bL8joHmpcdVzZwV7naUxIi
6QbSW++r0Qni4ZBjNjkritvdCCyABrJfXfzFmUjH3DCP4LKEQRXOe9UCcIsMCijn
1uXpEzP1p+eyheVk102wB+hF/qAt0BIF3UKojm+/P6nhKAOxPRNLJ2qWxdbzpc0n
dVjuflG36ujgWKiHsM07Czcelo0Vl7M0mmsevfH00SATgQ25lJB2cTT9OU84/Ns4
7IUIKIkLXCVgvjlGq1DnhQpkp8P7XL3hoqBqrwfEaJSgDphkwl91VM6SsXc635Yn
HYEvnPdrPFGhmbshOUdK6vgAV/k6e5CvE9bD+iZltKIjROHjkEwicQt4/UkNiEEH
CAEjebzSldOSGa+jxMEVL/TES3H8kzF+sr4/9QrRteYX5qK6Y6MfwldKjgOLb7Qm
/9wAmMDW
=95Ch
-----END PGP SIGNATURE-----

--0YsCv9Q1AKOCFfIR--
