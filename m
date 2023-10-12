Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9032CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 17:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDC8C86B9E;
	Thu, 12 Oct 2023 19:55:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rHK3Dlr3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C00E86C78; Thu, 12 Oct 2023 19:55:16 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C60C86A4C
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 19:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a7af45084eso16534777b3.0
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 10:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697133305; x=1697738105; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9tsarRcW9RkBewLVQ8vwfX86XJ3S30a8ogfzukXN6DI=;
 b=rHK3Dlr3iLrpSbqiu8e6H+7BL3tBSbdJ0d7WHbryRb0yhGPhMIbGyYQ26H/fpl/YRF
 LeoAR0WgvhFo2IFHEXddlr28Fq6hyN50PA/gQaBYIWI24uuaIAj6hTkNMt6EDKvzbk49
 gd98mmRud64T8jyZ359c4UnAkZQch9Qo8bLaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697133305; x=1697738105;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tsarRcW9RkBewLVQ8vwfX86XJ3S30a8ogfzukXN6DI=;
 b=kB2LX1KNXB1tkq8vehltiE7lYdw3i2WMP3e1KQ5ZVwGpH0rXYQXURvP2eYLa4iDkaY
 FVw2niZkN9OpkMX6u7p+Hz6Cr1Te8tsn/NUV8ADbTVETbgOtiv8KPPHhJ2BeWaoBrSyU
 WbIl6kVkCFLhfJXXXAJMxrRgrtvf1bdkZ4eQ/KM0CSNYtiV/KdEChUsfANIi4gqQapNY
 ecieIOPRFuUw7z/5H2mqGkhnfPCxeUmaUIL6ljtiOfwoQoyRONqzIGWW7/vzHSQM1t1H
 ygd0Xw35n7anK4r98DkU0L/zqTSbiqqLR5yv3ISkF03znUlYs193zOP2QRF5sJY9U83S
 lqPA==
X-Gm-Message-State: AOJu0Yx5F+43Foc203aC88sgdJ/KaVSFPmQvGW41rg0jmgYqr3GtH3BH
 IOiq4Gtch5QIsPjFZPQdDAgkiQ==
X-Google-Smtp-Source: AGHT+IF7woRDK4EiX7o3wAGBAocE6xZedPMiP3NjZExm3GuBj90p/huxb62gaY0ZWG87XFJ66p6XUA==
X-Received: by 2002:a81:6e88:0:b0:5a2:15bc:b32c with SMTP id
 j130-20020a816e88000000b005a215bcb32cmr27064418ywc.42.1697133305120; 
 Thu, 12 Oct 2023 10:55:05 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 b63-20020a0dc042000000b005a815346d95sm113594ywd.71.2023.10.12.10.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 10:55:04 -0700 (PDT)
Date: Thu, 12 Oct 2023 13:55:02 -0400
From: Tom Rini <trini@konsulko.com>
To: Apurva Nandan <a-nandan@ti.com>
Cc: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Roger Quadros <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v4 09/16] board: ti: j784s4: Add board support for J784S4
 EVM
Message-ID: <20231012175502.GS3119521@bill-the-cat>
References: <20231001165545.494212-1-a-nandan@ti.com>
 <20231001165545.494212-10-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sO0MYiWBplDnPCXv"
Content-Disposition: inline
In-Reply-To: <20231001165545.494212-10-a-nandan@ti.com>
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


--sO0MYiWBplDnPCXv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 10:25:38PM +0530, Apurva Nandan wrote:

> Add board files for J784S4 EVM.
[snip]
> diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
> new file mode 100644
> index 0000000000..025079c6a8
> --- /dev/null
> +++ b/board/ti/j784s4/evm.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Board specific initialization for J784S4 EVM
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.co=
m/
> + *	Hari Nagalla <hnagalla@ti.com>
> + *
> + */
> +
> +#include <common.h>

Here and elsewhere, do not add common.h and instead add what headers you
need.

> +#include <env.h>
> +#include <fdt_support.h>
> +#include <generic-phy.h>
> +#include <image.h>
> +#include <init.h>
> +#include <log.h>
> +#include <net.h>
> +#include <asm/arch/hardware.h>
> +#include <asm/gpio.h>
> +#include <asm/io.h>
> +#include <spl.h>
> +#include <dm.h>
> +#include <dm/uclass-internal.h>

This is a huge list for such little code, please see what's actually
needed.

> +#include "../common/board_detect.h"
> +
> +#define board_is_j784s4_evm()	board_ti_k3_is("J784S4-EVM")
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int board_init(void)
> +{
> +	return 0;
> +}
> +
> +int dram_init(void)
> +{
> +#ifdef CONFIG_PHYS_64BIT
> +	gd->ram_size =3D 0x100000000;
> +#else
> +	gd->ram_size =3D 0x80000000;
> +#endif
> +
> +	return 0;
> +}
> +
> +phys_size_t board_get_usable_ram_top(phys_size_t total_size)
> +{
> +#ifdef CONFIG_PHYS_64BIT
> +	/* Limit RAM used by U-Boot to the DDR low region */
> +	if (gd->ram_top > 0x100000000)
> +		return 0x100000000;
> +#endif
> +
> +	return gd->ram_top;
> +}
> +
> +int dram_init_banksize(void)
> +{
> +	/* Bank 0 declares the memory available in the DDR low region */
> +	gd->bd->bi_dram[0].start =3D CFG_SYS_SDRAM_BASE;
> +	gd->bd->bi_dram[0].size =3D 0x7fffffff;
> +	gd->ram_size =3D 0x80000000;
> +
> +#ifdef CONFIG_PHYS_64BIT
> +	/* Bank 1 declares the memory available in the DDR high region */
> +	gd->bd->bi_dram[1].start =3D CFG_SYS_SDRAM_BASE1;
> +	gd->bd->bi_dram[1].size =3D 0x77fffffff;
> +	gd->ram_size =3D 0x800000000;
> +#endif
> +
> +	return 0;
> +}
> +
> +int board_late_init(void)
> +{
> +	return 0;
> +}
> +
> +void spl_board_init(void)
> +{
> +}

So, lets split this in to two files, to make life easier on future
J784S4-based platforms.  The basically dummy functions (empty/return 0)
should go in "base.c" and everything that's about the EVM itself should
go in evm.c.  This will make it easier to rm evm.c and add
custom-platform.c that just sets the memory size and anything else
that's really board specific.

--=20
Tom

--sO0MYiWBplDnPCXv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoMvIACgkQFHw5/5Y0
tyzIUgv/dO32gxPRUkc/Lax7n7b8kwqCOsvgxmbIKKSaLfKMvXuM5PUCkFkr+0zG
nzBiyWmevFW6bHRmfnf6fN19vgAww+u+e/Fro7lX6FLEzY4kQNvJARmDpeJWyBgG
qZy480ytshZFuVo/qLE0X5JOzvt6wnuJvxmszQGLLCJtm6qG8Bm6ulbnUTSZSfm6
pgIJOsVSDNoJ6yhFIPaIJyzaTMrAod28Ux2Mz7qjZmPDc4poGijFuzJPSH7sOOvt
htUcr+OZn4enhN4VmKcIyP1zh+hzmLDE0IXlLUT1EIIfnMYwoTw8pXb8nrOWfp/g
Ka31pOIpjsNJeaIZ4smoeh/5riWGLVekeM68HLjPXwStNOm2QjjPn2ufBqSVXwSV
cbAFS9wSNKltLavjdFZEYHrzME8Qrr5QsGjjwhR5YbI2uDt1Yd8k5khTBtCwId8T
1j+QJXhH48sfi3VSwcT2iFubNYHd8dWeFeTlK7IWz0PvpjrGFjQvfAvShnsWxebF
t2xMXaZT
=C3BF
-----END PGP SIGNATURE-----

--sO0MYiWBplDnPCXv--
