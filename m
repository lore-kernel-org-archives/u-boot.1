Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C027AC36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 15:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 157C082A76;
	Sat,  5 Apr 2025 17:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gyzzAE+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F3882A7B; Sat,  5 Apr 2025 17:34:33 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC9468215B
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 17:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2c2dc6c30c2so841038fac.2
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 08:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743867269; x=1744472069; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7iCMY7EsKv6eWUNyUl5axus01vVOj3HtQh/GSMCHxx8=;
 b=gyzzAE+xyo99rBMlIHjBIIIwZXKl7kuwAeOzpXEBEhv1NJ/GBr9PEgBiXOFQS3m4zz
 vEjTae6ukFIulDrsjLJaZYkg9FDf9ghfhGvi2RaZdbg7+gsUOr4W6Pk0K7G4tp7pTvLo
 XG26Ku8aed4ncyyuwvPqORgCSz+6G7VzEhcwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743867269; x=1744472069;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7iCMY7EsKv6eWUNyUl5axus01vVOj3HtQh/GSMCHxx8=;
 b=IJjZlKuY+rLvSaDeJHGUggnkbfGS3svbCwqdLKSpyuiHyv3EqeVjiCBgOQAYgyJ8Qa
 bcsIR+dyRDkt36UeTz12v/MvKesmrY7b3+IdGvWOs+jE9vcCL3/VUCa+j6TZTyID5Gp/
 jwhob71TTBfr+fKETeS8xLlc1tYGaITeENxDSTyyJu8m/DRjD9UH65JmNYaT7udl3UNB
 wXEy6o2b8om9g44wewpHmqTnjb09se3muHUGEsy1a13z5dKNK4QRHshYxPOJblAiexJR
 Y0s9meqvtdUC6Y1QiQnsN2ZHKep6/W2J/A9rrdTVuucn5ZLrzMt/D+0FVd/ML+0M94IW
 QvjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW83b8dido/JmdPMKTyTY/eVOdAPOvi5wAzXKXy2kinXMY+kkL2ETd7y4gie/9ZvyN51qq+p9k=@lists.denx.de
X-Gm-Message-State: AOJu0YxxhGX24DKUWzsc1ccV0zqBeQwaKUxjWNSC4WJAM+r8MFVNTCIm
 JXXg2ob1QpTWIf14UjNmmZ98057BrNgVcPLcDGpEOoTsI3Tp6MCa1wODPd05gY4=
X-Gm-Gg: ASbGnctAbtdGePYp9UG9DMa5vPp8tW4bA82LRPteIvbD17ne4bkRdx9GTcMWmdJX3qo
 qYZVTvgvqQbrF+qe3vC5ov6LaqJ6+5cah8C2A1AERYc7Jgp3EhHKoz2Z+dZozAK0AWs0sbrEGWn
 593JuJEN3rilLb1FkveeLV35ocaKor3vt1ovn37tLS6Gx5xyvDsLicAUOyh2GtIT9HNlzZFYZPd
 Jqr1HwTkxQb8qPloPzIOmcfc88v6D/X1Uqjcuri198syg5VrWaWjbYvONvqFUMu6/qIWuw6bhiC
 l+wMm0mQEbr4ZetdYbKDh+evpjnPhYKKHu8gCjfRUUOsBK1A3tJD5qCCjrieZPB8aV8Nibo+t5I
 ErdJjmQ==
X-Google-Smtp-Source: AGHT+IGuhlhg7ww4RTuH3UWjlBfmHz4bTInWpYGhaH81s7GN9mqRAz8v+ErlRb51b6c37aHOX1jcxQ==
X-Received: by 2002:a05:6871:7427:b0:2c2:56f3:1c84 with SMTP id
 586e51a60fabf-2cd3314c223mr1407236fac.25.1743867269629; 
 Sat, 05 Apr 2025 08:34:29 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc84545138sm1222651fac.4.2025.04.05.08.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 08:34:28 -0700 (PDT)
Date: Sat, 5 Apr 2025 09:34:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] arm: mach-k3: Remove undefined Kconfig symbols BOARD
 and SPL_BOARD
Message-ID: <20250405153426.GA5495@bill-the-cat>
References: <20250319192958.276563-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sDHz+EqPe0QHVLPy"
Content-Disposition: inline
In-Reply-To: <20250319192958.276563-1-afd@ti.com>
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


--sDHz+EqPe0QHVLPy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 02:29:56PM -0500, Andrew Davis wrote:

> These are not defined nor used, they seem to be leftover or a typo,
> remove them.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/mach-k3/am62ax/Kconfig | 2 --
>  arch/arm/mach-k3/am64x/Kconfig  | 2 --
>  2 files changed, 4 deletions(-)

Can you please rebase this series on top of current next? Thanks.

--=20
Tom

--sDHz+EqPe0QHVLPy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfxTYIACgkQFHw5/5Y0
tywuTAv9Gclon4xbB0eeNsWQu6mpIbs9VzQR8thCXXwPXE33UNgGUBR0dT5V06XD
dRlhr2KqwAhHcGw0EUbgZE3iBEFYTcuBmHLr5lmFwODjfil5v1UO0s+D5Hl896cI
LVJNK2DM+LwYNKr2j4ZkRXD9YdzMKkPiJYBJfAIFGBhc4vgbN4OcBTLQwCH+Hrqw
xErCYCph6Bbf2ABUsACpOllXdDTctT9AapwacSOUd6N+BzlSr33kmo2ERZVawF56
JWCYSg7KNSfYxk/9aIAJFZS4pC/yEy8B/aev7n4HZDy0za65kXhIm65fxYSdBR7U
O+IZJ31vAGZhRZqFejwJdkBsom28+YLtEwY0mMDdMjXr+ORujmuSlEWgIH1CAtEO
0n6Jo7zf1sPahwpG//y9wb1NwxXRq25kvrS3LHOgjbBtrtGldS3CXtSDd8Q3bKBS
JkqcSx1NbE72hEUbNhKvDDjGZBtf811/enNU8n8NzOgdDIO7mJOCVsMbELkCSaT9
rVaX/IVa
=fgPv
-----END PGP SIGNATURE-----

--sDHz+EqPe0QHVLPy--
