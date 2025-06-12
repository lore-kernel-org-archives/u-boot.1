Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF22C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 16:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E55182B97;
	Thu, 12 Jun 2025 18:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H4ZTz3eh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8BCB82BD9; Thu, 12 Jun 2025 18:49:45 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABF282B70
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 18:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2db2149ffceso819690fac.1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749746982; x=1750351782; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JFZnSs0PWfM+aHSg9cdxdak+XiLJmabFpxAw2Uzbw1E=;
 b=H4ZTz3ehq3t2pPipx6h7AwOZE4jUYW9fpyWGNWXGkabbM/DUvf3guk/WXN9irXF3dj
 HmkHDf+bqdM5ysv1tiLU026aOHI6Z3P+tjb9OTKSEcZpuGmJffnFoms62+lMpfSUeZLs
 Cv8iBKGmG3o2EndS/HMmM194Es41oUowg0akQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749746982; x=1750351782;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JFZnSs0PWfM+aHSg9cdxdak+XiLJmabFpxAw2Uzbw1E=;
 b=RgA+DUTOJoB2LtUF3fGyRclGZJ5LaKzdx2HcrbtN6Y5n75ZQbOLQ7qcWWGR0ezvi8n
 Bd6JTT0UeuGcLbBz503UA5bzIHp1R8/YRmCjAAPv8C62nS9uBW4jByVgt2xtyPrYBZuR
 2AivqxJ8B1heFFGXOIU71Hz65WyK64pSJmf7B7OszBJ8dtfboVJYYNmAn7nL1fhrTjan
 f+KXqvcOvllRMl03XLs20YIdOLmuCd3CEBs3TFNvOidjUGMg7Pb/vb2PfGlCyBnwbkwN
 APRpxLrFSh1R6sFlGVXtD+y+CMrwYi3+lqwV+MmtUnU0+lXTB3tABIlee2f1aL83wCkK
 S3IA==
X-Gm-Message-State: AOJu0Yyob/feWpIxfLg6X0/jULJ+sf0jE4c6ZSPQtW6QY49HENF8E9TN
 IriI1JAUt11PQJop1bGiEDGtBX24hvzniEVnDLRA8U0/Hp2P6es7VX3SBn7+pIHZ3ak=
X-Gm-Gg: ASbGncsDDyiNa256dzxzioSLr4/tDZVtIVjLQT25ETldavbsC+eNxH1kWc5/DNXsreH
 s7tRM2iZYpL1FOQzM3OdZ7/tUHzIZaPmADKx9pF+VRfF80WVj7/rf5ZI0xSb/4fXq5gDoleiiRs
 UUS/V7/zZxs0zt31DFuR6b2kl1gEO6tMJz0jfwcfR2dnezOmxePrgxW8NLyzelgypkP9gRqvnXf
 g1YOXMlNihUFqpeqK5698PtK+ku22eiD6UtQ+vphWtk//FShkCRLtXYkA9wWrnCGajoI8TD1XVy
 2jMA0MybzTUVvBYAFBSQFNM9n2Pcx8EG9G/pwx2jRksGgSu44JBfLBRPJhO964ejqH0GGTXNr2v
 y0uEgwPvpZ6vBR3zRND+yDM8=
X-Google-Smtp-Source: AGHT+IHLHu2HQ4r3ARSwRrGJbqeEnVwyOppiJRz9IymDxGF0OuyEawBtelg6k4NK7QN2PEBPDrfyyQ==
X-Received: by 2002:a05:6871:4385:b0:2c2:c92a:5789 with SMTP id
 586e51a60fabf-2ead0162cf8mr449335fac.5.1749746982201; 
 Thu, 12 Jun 2025 09:49:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eab8decea3sm357510fac.28.2025.06.12.09.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 09:49:41 -0700 (PDT)
Date: Thu, 12 Jun 2025 10:49:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH] tools: zynqmp: add build script and documentation
 for ZynqMP KV260
Message-ID: <20250612164939.GO1382132@bill-the-cat>
References: <20250612153311.2379944-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1R3eS9Ml3i8k7Mzf"
Content-Disposition: inline
In-Reply-To: <20250612153311.2379944-1-jerome.forissier@linaro.org>
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


--1R3eS9Ml3i8k7Mzf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 05:32:41PM +0200, Jerome Forissier wrote:

> Add a script to help build a functional U-Boot binary for the ZynqMP
> Kria KV260. Also add some documentation.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>=20
>  doc/board/xilinx/index.rst        |  1 +
>  doc/board/xilinx/zynqmp-kv260.rst | 27 +++++++++
>  tools/zynqmp_kv260_build.sh       | 43 ++++++++++++++
>  tools/zynqmp_pmufw_elf_convert.py | 96 +++++++++++++++++++++++++++++++
>  4 files changed, 167 insertions(+)
>  create mode 100644 doc/board/xilinx/zynqmp-kv260.rst
>  create mode 100755 tools/zynqmp_kv260_build.sh
>  create mode 100755 tools/zynqmp_pmufw_elf_convert.py

Helper build scripts don't belong in the tools directory. If they're
super helpful, I don't object to adding them to
u-boot-extras/contrib/<you>/ directory. But there's a number of
documented examples already on checkout and build TF-A then do ... for
your platform.

> diff --git a/tools/zynqmp_pmufw_elf_convert.py b/tools/zynqmp_pmufw_elf_c=
onvert.py
> new file mode 100755
> index 00000000000..b4eb2695831
> --- /dev/null
> +++ b/tools/zynqmp_pmufw_elf_convert.py
> @@ -0,0 +1,96 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (C) 2025 Linaro Ltd.
> +#
> +# Written by Gemini (Google AI) then reviewed and edited to remove some =
comments

I'm glad this calls out where it's from. I'm not comfortable for a
number of ethical reasons on taking LLM-generated code. I'm also a
little surprised we don't already have something like this with binman
today?

--=20
Tom

--1R3eS9Ml3i8k7Mzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhLBR8ACgkQFHw5/5Y0
tyy12Qv9GOitWi1AnYAZNaLtvsbRnA+MhLTrRUsHKlYse7/XkC4IaUlKOMp3M/AT
rSbhRWzvPGJpGJveBdiJ90pQkn96dq+Gf+bZm7kJ0yJwYHTqFAH5OpJcJzo1mGLy
LxeKCITcakueW2U8lAX03ZTw2DHtA0oJshttG8+6mGDDx6IP6T9Thckra361/5TO
lgTQIz7W1hP83RPF61FtZaQbjPcY7sJy0KTpqKeDJc1PGDPv7ADxAQ4JWLBo+Lhc
qnWfV2LLdp3gXFYNDFeOL5L2yNTH5U02cfIWWjJBj9y4OWBdTyOMH/Xtbt4sMfbO
CtoVBbs5l0224d7qnA/MHmowcHJjhwoEdxMPxhY6u1V/d88q5rFYy+HaYmEp0WhU
jipSy+HDXpop3AvBpYEcj+Lw4ZR7dmvEbtLAo15CFe1KUHOzhlYY9jkRizhciVze
G2aUNL7cqW4LHmuy0a/RUpf2Z+XlGPPn8G2OagkNMPiNsVgsQk1+Ok+AoXXYmurJ
HokVmuWr
=kSn+
-----END PGP SIGNATURE-----

--1R3eS9Ml3i8k7Mzf--
