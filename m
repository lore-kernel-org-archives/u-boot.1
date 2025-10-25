Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19266CCF9E3
	for <u-boot@archiver.kernel.org>; Sat, 25 Oct 2025 13:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 338D4836A3;
	Sat, 25 Oct 2025 15:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cabY3HCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD33F838BB; Sat, 25 Oct 2025 15:52:34 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F48183677
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 15:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-44da31ecc16so138463b6e.3
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761400351; x=1762005151; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vscXvKmB4a7icsm4ma44R4pB8VhNFJ8FPBauvuiOfSs=;
 b=cabY3HCFT2xbIAy/TK6V+Qx7cQzF0IONB9DLy8AcweiQAZh3eiQXM+wpinbdao9yHn
 qIwTl1D6Zd/AhFt/XS6tRX4ZBe8Y3TP77zSxMlmmQJfpKyMErp39hWQ3XK0fIXHquBzu
 Zmg/DGSOPjJyRZgLP3BoUsb3vQV7BkU8UL/Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761400351; x=1762005151;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vscXvKmB4a7icsm4ma44R4pB8VhNFJ8FPBauvuiOfSs=;
 b=urmlHFXZoV7cyw24E3npq7Gehhps2ROd5c9OfjNf1jpIyBkY/kftGbOZaox9mdmGE3
 Ubd1E5dINhNVN/6biUR2hMwccN0dG69jBmUQGmG0QW7GYmFc0XnbvtsQl3Lbk6jkMu9D
 29YV/FMrCwsM9T4NvZEcqXgmXuO1o0HpGOWFblelI2/9341iPrA1eduxxCSnLStfjKYi
 ugSj0bY1zjiNe3q54sP/uZYKg09dI0BOeZbflT0ST0hHhcBpfzIvUlW9QadOcMCOs6/L
 jc5zZtBjRhRFiekhf/gCprN+dr9g0ROBgEAbYxUdGjKTxF8HKuIeCRyXUwIW3LUwPtKF
 v4vA==
X-Gm-Message-State: AOJu0YwbmGUOt5FtJ4Q7vj2jM5pLDgu0ARRKXddJtxVArDbYBGhMg+Ko
 Yj2lNw7BecKk+LHeY70lULJibaxZ/BDS3AiZrSFBAp4RnuPpRzMMfGKgMH64OqIOduA=
X-Gm-Gg: ASbGnct0jkO3+rP2xfmaEO+7ffz2LOHHzdi9WCN60VgxuLNPSvIRzUsxVO+BS9hV3fR
 zY0EEqqgOKblbKNLUlLOilwmeXpoaFcjhF9Bc9h2FGWj793CI6e8PffrHZxiR4wl2hk0vlwGSoN
 uJKnNdtZPhtUlhBkLWB5fmD+lYFs4dJ75HTSXy7smPihxcCdX5JUI7mcoTVIaaScPN5EXGytI/D
 xcdItgg3cv4GHSrlDasim0DBCvK0AkDlwx8IR1EHKDG+I9ebOMdVFLhHzNPFdN0YwMhXK6BJLLt
 dz93hKGU5z3VFO39+IC7yNFRLTrAhNcfdg2iuyTPZfLo2mZBH3mBg12XpYsbaO4HMuMk8g8l0YZ
 r93quA/O87rOcacKKtT6KUrSjlJVgAhHxARFPBQv58mm/SO/52V1AfSo6vwTEc4u33K9F1iUuhD
 Y7vH9Ps1dV6ZCQ60XJ8sfETsgvRrqJkICBoQ2LZT0=
X-Google-Smtp-Source: AGHT+IEn387Sg0Pqvazt7+XxIBTjgu5C6uSsaDWiFpADrfufYHr6pI4NqnsAmTm2e2uR5WBmoqlGhw==
X-Received: by 2002:a05:6808:2f13:b0:43f:5716:aac9 with SMTP id
 5614622812f47-443a2fb210fmr11827485b6e.37.1761400351142; 
 Sat, 25 Oct 2025 06:52:31 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3eb60d5sm468810b6e.21.2025.10.25.06.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Oct 2025 06:52:30 -0700 (PDT)
Date: Sat, 25 Oct 2025 07:52:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v9 1/2] spl: remove usage of CMD_BOOTx from image parsing
Message-ID: <20251025135227.GU6688@bill-the-cat>
References: <20251025-fix_cmd_bootx-v9-0-dccf0aa0587f@ti.com>
 <20251025-fix_cmd_bootx-v9-1-dccf0aa0587f@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CAu5So+9qzQIfbyv"
Content-Disposition: inline
In-Reply-To: <20251025-fix_cmd_bootx-v9-1-dccf0aa0587f@ti.com>
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


--CAu5So+9qzQIfbyv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 02:38:37PM +0530, Anshul Dalal wrote:
> Using CMD_* configs from spl doesn't make logical sense. Therefore
> this patch replaces the checks for CMD_BOOTx with newly added library
> symbols LIB_BOOT[IMZ] and SPL_LIB_BOOT[IMZ] which are enabled by their
> respective CMD_* or SPL_* counterparts.
>=20
> SPL_BOOTZ is enabled by default for 32-bit ARM systems and SPL_BOOTI is
> enabled by default for 64-bit ARM and RISCV.
>=20
> The respective C files (image.c/zimage.c) are compiled based on library
> symbols BOOTx instead which are in turn selected by both CMD_BOOTx and
> SPL_BOOTx as required.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/lib/Makefile   | 13 +++++++------
>  arch/riscv/lib/Makefile |  4 ++--
>  boot/Kconfig            | 18 ++++++++++++++++++
>  cmd/Kconfig             |  5 +++++
>  common/spl/Kconfig      | 16 ++++++++++++++++
>  common/spl/spl.c        |  5 +++--
>  6 files changed, 51 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index ade42d0ca4370b7df3aec59615f12e28a96874cd..3ea94709dfcdc2c9fd057ad5e=
129e041c59d6716 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -7,6 +7,13 @@ lib-$(CONFIG_USE_PRIVATE_LIBGCC) +=3D ashldi3.o ashrdi3.=
o lshrdi3.o \
>  				    lib1funcs.o uldivmod.o div0.o \
>  				    div64.o muldi3.o
> =20
> +obj-$(CONFIG_$(PHASE_)LIB_BOOTI) +=3D image.o
> +obj-$(CONFIG_$(PHASE_)LIB_BOOTZ) +=3D zimage.o
> +
> +ifndef CONFIG_XPL_BUILD
> +obj-$(CONFIG_$(PHASE_)LIB_BOOTM) +=3D bootm.o
> +endif

I wasn't clear enough, sorry. When you use $(PHASE_) you don't need
CONFIG_XPL_BUILD. And if we select SPL_LIB_BOOTM we want bootm.o in SPL,
yes?

--=20
Tom

--CAu5So+9qzQIfbyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPzWGAAKCRAr4qD1Cr/k
CsVdAQCxo4qg3Ku4jTXzwXancL7DHYZ9zDQR81Cvr7HggVcm5QD9FbxkZEZvH/GG
WU8WYv5mLB2S0aC6ODlkCwu8RIJlDwM=
=SNEM
-----END PGP SIGNATURE-----

--CAu5So+9qzQIfbyv--
