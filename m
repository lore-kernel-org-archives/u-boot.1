Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CEBC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:53:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CD8D87AFD;
	Fri, 15 Dec 2023 14:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ITy/80XM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C316D87AE7; Fri, 15 Dec 2023 14:53:00 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B275C87AFD
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:52:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-77f3d75dafeso48300985a.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702648377; x=1703253177; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8co6AYJF06e7fTzbCVjheNeN/YGgkzTMLaFtqDcw9fI=;
 b=ITy/80XMvBxE77+vxnQ3w2KUkhXwJR4tC2kNL+Bah4hT3+tebkQauboWITj4i1ek64
 rrn/qYub0uodDgeJkiSO//1u9Ltsan5FYgesgSqTN/AFFM9DPKDxrPRnjObBFWXCXhEw
 Es3KiU5oKuC4JQonSKobZ0p+MSOC9Sk5CGIlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702648377; x=1703253177;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8co6AYJF06e7fTzbCVjheNeN/YGgkzTMLaFtqDcw9fI=;
 b=apduUt34UB+29q+0FYzsm1f5cZ1ZL3bpBIaszLlLYD9jWbhV203GXGO7MsVIaaaYZ7
 YyyyICJUN2wOunH2Oy+UcxZ1TwFKs/sdCUvbqzX1g6n1QYBnAtxTjMjkI97fdZmdcANp
 eG97u/cSBF8CsH4RXLy9GVCZQ3ow8tCuZSMQgwZLW8ZLskgg9XpE2cbL1FXnLO6pcC90
 FqO+YkJrcSjLfWg+v+lQV0qfiQPBa5+LThTHhtF/z3Ti4wOBiW+pN5mmMCGDMXzRAamh
 5F4b4IBqUp6r8YjnWgYuzZTitB8FRi5xqUeCaOv/moc1H4K9oPl84g/ToRAK+jNdwtFn
 fJWw==
X-Gm-Message-State: AOJu0Ywg/MEYbH4+QtfLNhYQeOpS79XBWXvqM55Oazj8jeKvcHq7u/Qj
 71gvdVQrclRcKN8Y2msyIFxHvw==
X-Google-Smtp-Source: AGHT+IHCmbf93bJvuulhNpPh62lqbwIMwazPnl7zaSpBW4EZbzx7vB2bCsS+21L87G+MWFC+SaTtaw==
X-Received: by 2002:a05:620a:4103:b0:77f:9e22:fd7b with SMTP id
 j3-20020a05620a410300b0077f9e22fd7bmr4745298qko.65.1702648377344; 
 Fri, 15 Dec 2023 05:52:57 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-faf3-908c-f76f-32dd.res6.spectrum.com.
 [2603:6081:7b00:6400:faf3:908c:f76f:32dd])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a05620a2a0400b0077f7910e857sm2604580qkp.134.2023.12.15.05.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 05:52:56 -0800 (PST)
Date: Fri, 15 Dec 2023 08:52:54 -0500
From: Tom Rini <trini@konsulko.com>
To: TracyMg_Li@outlook.com
Cc: jagan@amarulasolutions.com, andre.przywara@arm.com, festevam@gmail.com,
 patrick.delaunay@foss.st.com, tharvey@gateworks.com,
 pbrobinson@gmail.com, weichangzheng@phytium.com.cn, hs@denx.de,
 d-gerlach@ti.com, u-boot@lists.denx.de, robh+dt@kernel.org
Subject: Re: [patch v2] ARM add initial support for the Phytium Pe2201 Board.
 Add pe2201 platform code and the device tree of pe2201 platform
 board. The initial support comprises the UART and PCIe.
Message-ID: <20231215135254.GX2513409@bill-the-cat>
References: <SEYPR01MB5884AEE0DD200DBAEB95D1D0F193A@SEYPR01MB5884.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5JgEJv8HLd0NkrCw"
Content-Disposition: inline
In-Reply-To: <SEYPR01MB5884AEE0DD200DBAEB95D1D0F193A@SEYPR01MB5884.apcprd01.prod.exchangelabs.com>
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


--5JgEJv8HLd0NkrCw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 03:13:14PM +0800, TracyMg_Li@outlook.com wrote:

> From: TracyMg_Li <TracyMg_Li@outlook.com>
>=20
> Signed-off-by: TracyMg_Li <TracyMg_Li@outlook.com>

You still have the commit message as the first line of the commit and it
needs to be broken up in to the body of the message instead.

[snip]
> +/* BOOT */
> +#define BOOT_TARGET_DEVICES(func)	\
> +	func(SCSI, scsi, 0)	\
> +
> +#include <config_distro_bootcmd.h>
> +
> +/* Initial environment variables */
> +#define CFG_EXTRA_ENV_SETTINGS	\
> +	"image=3DImage\0"	\
> +	"scriptaddr=3D0x90100000\0"	\
> +	"kernel_addr_r=3D0x90200000\0"	\
> +	"fdt_addr_r=3D0x95000000\0"	\
> +	"boot_fit=3Dno\0"	\
> +	"fdtfile=3Dphytium-pe2201.dtb\0"	\
> +	BOOTENV

Please switch to bootstd and plain text environment, thanks.

--=20
Tom

--5JgEJv8HLd0NkrCw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV8WjYACgkQFHw5/5Y0
tyzRtQv/ShMoq1GxdA9Qmun6MTP4oRUwot3ufCKLhGdIulfjnsfLKXnCPd0zs1yM
YvSpjYQD7mSH7br/skPm2DqNFHkvIEjGldBD09UizdHIigF7XrnI9jSV4D54DFvC
Z1ud7TWlAz4W64Ehg5SpyKl84vD2oydaOopccAxov1/4JvCCBrAwoVORjybSt7tk
iIdEnUiWWh8jo2mTh79LjoTGIx8YQcdWEA8Ou9aNIPqCEAJEXNzSfThXga36Y4Nt
Z3N/V616+EaA1DG0ThFPV1yjZ4D0f/gfe+Rg4clT9zoyWFWfxPwypN1QSXr/zM+t
O2RO5c7g6HJoi+WdJ5WtzNLOtwpbvVYTuPhlUl6U5z+g3fkWwIRJ1KrV2AcS2LTx
9lL42+UibI6VbJMh+AyLZqNyc7WAL2S1YGwuDhrsZi9D4Z9VQ2hEMJ2Afzh7voaS
ReqQ1ZDzXxBHiXy/ZG2XD+VFRYiacJX90nBPZecuDahwjPXUGO07Lr0NIy7cmbI1
8Z0gvJAn
=3fAc
-----END PGP SIGNATURE-----

--5JgEJv8HLd0NkrCw--
