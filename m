Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B950EC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 13:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08C2887252;
	Tue, 19 Dec 2023 14:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VCjYiqTH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F04C087282; Tue, 19 Dec 2023 14:00:21 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A321D87005
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 14:00:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5e248b40c97so36782427b3.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 05:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702990818; x=1703595618; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wQsELJUcX84CPUKB7i5L+mwivCo1LSqY29OjPTYZdwE=;
 b=VCjYiqTHIWL1eMa7wWapPaXkxbgvRBufwPf//9H8NcnYBiOPnfmfYYjLlddMJ6WKin
 N5nYO1BGNCIzDV+wFShZ0HLBjBEYDPEdhmxcPtXC71Dyu3vMRV3mRNsBjdokAhHXilxP
 o5wFWgUWlkNv83RNyP94X2dhX/zHrrrb31yyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702990818; x=1703595618;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQsELJUcX84CPUKB7i5L+mwivCo1LSqY29OjPTYZdwE=;
 b=DGmymDfjQ+H2u+9hiEz0oOnItNVguS0TtxfKzDzkPGhEG7KUF44yZUj7hpaXt7T7J/
 oH9IC653PSwB193yZFkOQMfIO4MXBmImu3rkNF8AJiro5xqhyKh4i4p68JhkJdmOQm5i
 etBufR011JyRmG4eBRdE2t4YU+2kcb7qBuujEFuW681HCxo1GGJ/V4WMOy4tQLV4VQoz
 JQXsYfmnw8iDND8nu5lyhefm0Pcb9qhcxXQoXrMPNgo2RgmmtOsHm8trk/q6iZuYCEP4
 yYcTjH4LiXU+dlikEZCeh478NJBzollPU/lfpofe8zSIjsQvTAwwiHDrXSbbv9CNRnf6
 NsBw==
X-Gm-Message-State: AOJu0YxitctiVQT+OdOPr4Dqnje2c+niE9I/oOtrL4XYWCN8WUy6UhW4
 VbmD/dhHiF06kTtVsqSh1Oc/8A==
X-Google-Smtp-Source: AGHT+IH5lMZ5/PFVNTsp5+Gcj5emvpFg3UgrSQmUuORnhqJoqCLy5tAkuz2+uhDMOhvsyQHfL5uzlQ==
X-Received: by 2002:a5b:7d0:0:b0:db7:52f8:1381 with SMTP id
 t16-20020a5b07d0000000b00db752f81381mr10800220ybq.52.1702990817974; 
 Tue, 19 Dec 2023 05:00:17 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 n75-20020a25404e000000b00dbd5bb05b16sm235024yba.59.2023.12.19.05.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 05:00:17 -0800 (PST)
Date: Tue, 19 Dec 2023 08:00:15 -0500
From: Tom Rini <trini@konsulko.com>
To: TracyMg_Li@outlook.com
Cc: jagan@amarulasolutions.com, andre.przywara@arm.com, festevam@gmail.com,
 patrick.delaunay@foss.st.com, tharvey@gateworks.com,
 pbrobinson@gmail.com, weichangzheng@phytium.com.cn, hs@denx.de,
 d-gerlach@ti.com, u-boot@lists.denx.de, robh+dt@kernel.org
Subject: Re: [PATCH V3] ARM add initial support for the Phytium Pe2201 Board.
Message-ID: <20231219130015.GT2513409@bill-the-cat>
References: <SEYPR01MB588425FB8D218BF66F13E05DF197A@SEYPR01MB5884.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SEJ7wZxiQ3cc/i1p"
Content-Disposition: inline
In-Reply-To: <SEYPR01MB588425FB8D218BF66F13E05DF197A@SEYPR01MB5884.apcprd01.prod.exchangelabs.com>
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


--SEJ7wZxiQ3cc/i1p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 10:27:27AM +0800, TracyMg_Li@outlook.com wrote:
> From: TracyMg_Li <TracyMg_Li@outlook.com>
>=20
> Add pe2201 platform code and the device tree of pe2201 platform board.
> The initial support comprises the UART and PCIe.
>=20
> Signed-off-by: TracyMg_Li <TracyMg_Li@outlook.com>
> Changes since v1:
> 		fix space corrupt.
> Changes since v2:
> 		switch to bootstd and text environment.

Changes go below "---".  And:

[snip]
> diff --git a/board/phytium/pe2201/pe2201.env b/board/phytium/pe2201/pe220=
1.env
> new file mode 100644
> index 0000000000..46f68ede2f
> --- /dev/null
> +++ b/board/phytium/pe2201/pe2201.env
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023, Phytium Technology Co., Ltd.
> + */
> +
> +/* Initial environment variables */
> +image=3DImage
> +scriptaddr=3D0x90100000
> +kernel_addr_r=3D0x90200000
> +fdt_addr_r=3D0x95000000
> +boot_fit=3Dno
> +fdtfile=3Dphytium-pe2201.dtb

Please see doc/develop/bootstd.rst as there's environment variables you
should be setting and..

[snip]
> +/* BOOT */
> +#define BOOT_TARGET_DEVICES(func)	\
> +	func(SCSI, scsi, 0)	\
> +
> +#include <config_distro_bootcmd.h>

This can be removed.

--=20
Tom

--SEJ7wZxiQ3cc/i1p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWBk9gACgkQFHw5/5Y0
tyypyQv+KZWSg4chNkFEuw+O4NNbSway5c2YCSg8nHd7e7VDgrTcFpioP/7eiH6B
TmGrRVmlfvjWZMA81OcylpRi1hPW1biFWktTrYcXVPTpgk9m86umSgoD02YWkhxy
y0PvqzojdXZLLnd9Xr7lSGC8K+Q5/OqZw6pbN3tW4Vi79Fc1puNsEOwPoNHD9jba
pWxKOo/O34vKAAYWch99FrFSKJXxxDtyBegQQCjHeXV8Y6xeXAEjjdJcUcI4svnP
s7sgnruCix5HcxqHKfaILw/uFGV/yx6XaEUjE+3KGn1+7VSoecMUhNsnvaCU7T4D
+sk32I5fpPL5doG0U1A1Wiyd1AeMJ7pAoPmPkfMXTas85ec1D844Cq1680zRE0vX
ARQkwJekkvFEJAjLrTUroVFiVLy+nOPRyk/QDIVY8Eb8KktdIRLsB0PceTkRQxRg
YsPR/bpZwmkKTWgFBMiZ/nOX312+pfqemmJQS+1iF2lz13LifmEqc0hQG8qVjFwW
zY2NND4c
=267i
-----END PGP SIGNATURE-----

--SEJ7wZxiQ3cc/i1p--
