Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10608FF887E
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9402784897;
	Wed, 29 Apr 2026 16:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BBgO0xrF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C4BA848AA; Wed, 29 Apr 2026 16:31:56 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85E3584860
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-4094b31a037so7225052fac.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777473112; x=1778077912; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JHwnicxDZp/P5KSmuttBQSZUznd/EIqDzWFzQs0VMAQ=;
 b=BBgO0xrF8LUPQHH4fz/eiIUyHwbKWjT+X3XnpUhMuNTI8UnfyTOrCKCrr0LqXe6UgK
 X6r6d3z3FeZuo/fw0ACZA6547VYEcjpGTL3NHrIkkzH0k7mhIA8xpLysE1zw5UM8/gUs
 +zkAnv+XC5SQ2PV6C1g/PEVthR4mf2Rd1sHqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473112; x=1778077912;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JHwnicxDZp/P5KSmuttBQSZUznd/EIqDzWFzQs0VMAQ=;
 b=USoX2iS7tZqQPnpSouFaLrhTKnCsvcUlegm9349Tx9h9IndhVHlUcTekw4P8uYZMAm
 jrxiMZZ7zwpQ2a0QTsRhAcIKbJskxabJ7wlntN4E0UXZujMSSOZ+sPL6J4Wf0LGSRKA4
 H92Q1XCsMKPVOynH3FUMtVGLgpVhknmd3k6kSQdlWvdqo1VWtlvzMHmnW9AlmBSDyhrO
 AZYas/zwTINbxPOqkJ3eCjVtmlkAJqPHVefj2MmC5XMd2S0DARVMUvuVgWC7ned+lQPN
 H18j6+0pBtnS3JMURdb719JqT91OduSgKbHIX/ekWnwYIxtjVOhSkOBBT3T01z4lTbE7
 Hq0A==
X-Gm-Message-State: AOJu0YzkbrLzt9cT5B1crccY79zYu5gHTnLkaqYvIIXB5b4frWsKF+Ra
 Osw8Uw+KOXed+esT9mSkazoJ3JLmzniY4+Jlmvtb5OCxrC0ttWdW/7xyz+nqF/G7R0g=
X-Gm-Gg: AeBDiesQloMjqjl0vXptdt6cU+BxOgJnjq153Ej5wqET4cusEp2W3qjybKInH4bbLTw
 QzUaIj43e/eyCnIkaNlNVGZewquew8H8JkJnxtd8A+0kxntp40z8fbgESw96ukGmnAjYzQrmDBd
 w7xttIvA7xs1GxPVT2fDZM//rfZqxMkDlsYlJO5/a04G50u6JCjE9cU90bVHZwFmKj3+f3c7r43
 UuX3J1pSjkUk5UQyIGMjg/fq3RNOLL1UQ2pqBdWE2+RzFQSYfeBHo66uRFxtNq62IZkWhAI+KfF
 caCYTASfAw7gLH8GXSkx5BwrBIz+8hOL1rwOsKa888afHb5gIXdZnbs0kPfh5utKohOBd++eck/
 lIdpsY8E55YYLc0lx0NqxC9TECeMiZzmK8ecU4MFGbWv23cJW/brbKH9+ddNkQI4KIHWLCEevi4
 LBfvLbMG1VhcW7Rghr9yYEepoi7EEvFt9o2jYQaNWO78hiT//Wklkm1C0zEXqRquLO3mg54y8+V
 xsZB1ZwEcN17cRCo9ULkVn6XmdUyNAlD1wVZBsvS8cxGJ/org++OTaU9vPegQ==
X-Received: by 2002:a05:6871:6c11:b0:3ec:3d37:87da with SMTP id
 586e51a60fabf-433f386150emr4040914fac.3.1777473112177; 
 Wed, 29 Apr 2026 07:31:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4340e6b1144sm1982700fac.1.2026.04.29.07.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:31:51 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:31:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Karthikeyan Mitran <kmitran@axiado.com>
Cc: u-boot@lists.denx.de, Siu Ming Tong <smtong@axiado.com>,
 Prasad Bolisetty <pbolisetty@axiado.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Tzu-Hao Wei <twei@axiado.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH 2/2] arm: axiado: Add AX3005 based SCM3005 board support
Message-ID: <20260429143149.GV41863@bill-the-cat>
References: <20260428-ax3005_scm3005-v1-0-7fed19ee6fe0@axiado.com>
 <20260428-ax3005_scm3005-v1-2-7fed19ee6fe0@axiado.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g4GtxCpt76ozeC8u"
Content-Disposition: inline
In-Reply-To: <20260428-ax3005_scm3005-v1-2-7fed19ee6fe0@axiado.com>
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


--g4GtxCpt76ozeC8u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 07:32:37PM -0700, Karthikeyan Mitran wrote:

> From: Siu Ming Tong <smtong@axiado.com>
>=20
> Add U-Boot board support for the Axiado AX3005 based targets, a quad-core
> ARM Cortex-A53 (ARMv8) platform.
>=20
> Board Kconfig introduces ARCH_AX3005, which selects ARM64, driver
> model, GIC-v3, and Zynq UART. TARGET_SCM3005 selects ARCH_AX3005,
> allowing future SoC variants to share the platform configuration.
>=20
> Secondary cores use spin-table boot. ft_board_setup() corrects
> the cpu-release-addr in the FDT, which arch_fixup_fdt() overwrites
> with the post-relocation address. The board linker script pins
> spin_table_v8.o at offset 0x2fa0 from text base to match the
> address declared in the device tree.
>=20
> Tested-by: Siu Ming Tong <smtong@axiado.com>
> Signed-off-by: Siu Ming Tong <smtong@axiado.com>
> Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
> Signed-off-by: Karthikeyan Mitran <kmitran@axiado.com>
> ---
>  MAINTAINERS                      |  10 +++
>  arch/arm/Kconfig                 |  17 ++++
>  board/axiado/scm3005/Kconfig     |  15 ++++
>  board/axiado/scm3005/Makefile    |   5 ++
>  board/axiado/scm3005/scm3005.c   | 128 +++++++++++++++++++++++++++
>  board/axiado/scm3005/u-boot.lds  | 183 +++++++++++++++++++++++++++++++++=
++++++
>  configs/ax3005_scm3005_defconfig |  73 ++++++++++++++++
>  include/configs/ax3005-scm3005.h |  29 +++++++
>  8 files changed, 460 insertions(+)

We're adding a new ARCH symbol, but without a new mach- directory, which
I suspect some of the board code should be in, instead. Also:

> diff --git a/board/axiado/scm3005/u-boot.lds b/board/axiado/scm3005/u-boo=
t.lds
> new file mode 100644
> index 00000000000..8e56535fdf9
> --- /dev/null
> +++ b/board/axiado/scm3005/u-boot.lds
> @@ -0,0 +1,183 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2021-2026 Axiado Corporation (or its affiliates).
> + *
> + * Based on arch/arm/cpu/armv8/u-boot.lds
> + */

What differs here really? Thanks.

--=20
Tom

--g4GtxCpt76ozeC8u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafIWVAAKCRAr4qD1Cr/k
CiPvAQDCjDizZbTE6gL/8/6UqghRsKAd8DOTzx5gFtCbqWw6TAEAq24+LLbPnvtx
PL14mOhQ1qZr/0Y3BP6joLPmC/Ep4gs=
=8bFv
-----END PGP SIGNATURE-----

--g4GtxCpt76ozeC8u--
