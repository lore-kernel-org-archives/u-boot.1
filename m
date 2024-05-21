Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FB7C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 17:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D36E8825A;
	Tue, 21 May 2024 19:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UffjUNh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5DA7881C3; Tue, 21 May 2024 19:47:29 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C47E8825A
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 19:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6aa93d19a25so3427756d6.3
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716313645; x=1716918445; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uJrQefT8bqLi50Pncn3af/GP2CYnIgrDIGjICpd5N+M=;
 b=UffjUNh39AT368b/+rH5GGFUT8weQc2B+WYVlC24G82+PfqUt3WuXk3bfQ5XPS5NnT
 cJXq6gZEIoEdMzF0pvoMNoZLWdIUADwHWARgJudQ1dtM7L/ruwFyqNPKop7O6Y3Hjr13
 lp50LQthMhC+PyzteAfhcxMXBIcT3ZVV3lKWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716313645; x=1716918445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJrQefT8bqLi50Pncn3af/GP2CYnIgrDIGjICpd5N+M=;
 b=BZ0l7187X56k0qspUTFQjQQb1X40YfrkDC6xZVRj2Nd3JRt2O330XdMzjwdmfzbSK7
 jU7BzP096iOa0hZwoqpDbwToOk6QLA2glLMJkeEHrV5QK5OviTAE3AnAUAVmVJd/0Vok
 xI1VXiAkPbMz01XrMyn+hCztSqQ9+X/m7dbxWrs5oBAiFBaegQoqSp+/6MP+Mvtyk8w0
 asHpoXog6wyB24bLFaprj/m6z1vzcjZSTAI13oouScG5aXGp8JeBs7UYl4hhtl9zVAJ6
 aY1weaceZ0TyDvBQu+FjYomTS1wPsB6FMfoTqc2mWSceCPWL9VGXUST1tqyH7fe2aNQN
 itDg==
X-Gm-Message-State: AOJu0YxjAm7AOp9+O9BRumK3P1wuRBhqcYmIt0zWkt/axsDwVg07QB5A
 vf3kwzGojCOYNfqLLMbTRzKqshS2r4LboO3RahyS0yJcvGodwD1IanIDW+g914s=
X-Google-Smtp-Source: AGHT+IHYf7jCjrQtEw7+UD/5MmSfQWVg3ltNGnwhgmEAlDogZhtx5XHj9r/mINwpRM9iFuLz6t8Maw==
X-Received: by 2002:a0c:ea83:0:b0:6a3:3433:c759 with SMTP id
 6a1803df08f44-6a33433c786mr231880486d6.5.1716313644866; 
 Tue, 21 May 2024 10:47:24 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a350b9cfdbsm74337196d6.24.2024.05.21.10.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 10:47:24 -0700 (PDT)
Date: Tue, 21 May 2024 11:47:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
Cc: u-boot@lists.denx.de, flavia.caforio@amarulasolutions.com,
 michael@amarulasolutions.com, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH] Add support for am623 from BSH
Message-ID: <20240521174721.GA2568172@bill-the-cat>
References: <20240521111547.106139-1-andrea.calabrese@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9dw+q9WVd25oEl2D"
Content-Disposition: inline
In-Reply-To: <20240521111547.106139-1-andrea.calabrese@amarulasolutions.com>
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


--9dw+q9WVd25oEl2D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 01:15:47PM +0200, Andrea Calabrese wrote:

> Added support for ARM chipsets r5 and a53, part of the am623 board.
> Created the dtsi files, updated the kconfig and makefile and added the
> dts files.
>=20
> AM623-M3 is a low-cost board based on K3 AM623 SoC.
> It supports the following interfaces:
> - 256 MB LPDDR3 RAM
> - x1 USB OTG Connector
> - CC330x SimpleLink=E2=84=A2 Wi-Fi 6 and Bluetooth=C2=AE Low Energy compa=
nion IC
> - 512 Mbit OSPI flash
> - x1 UART through UART-USB bridge
> - x1 eMMC 4GB
>=20
> Add basic support for AM623-M3.
>=20
> Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
> Signed-off-by: Flavia Caforio <flavia.caforio@amarulasolutions.com>

First, when can this use OF_UPSTREAM instead?

Next:
> diff --git a/board/bsh/am623_ccm_m3/am623_ccm_m3.c b/board/bsh/am623_ccm_=
m3/am623_ccm_m3.c
> new file mode 100644
> index 0000000000..5cf6dd48a9
> --- /dev/null
> +++ b/board/bsh/am623_ccm_m3/am623_ccm_m3.c
> @@ -0,0 +1,237 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Board specific initialization for BSH AM62x based platform CCM-M3
> + *
> + * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.=
ti.com/
> + *	Suman Anna <s-anna@ti.com>
> + * Copyright (C) 2023 BSH Hausgeraete GmbH - https://www.bsh.com/
> + *	Bode Michael <michael.bode@bshg.com>
> + *
> + */
> +
> +#include <common.h>

Please rebase on top of current -next, and audit the rest of the
includes in any C file you're adding.

> diff --git a/configs/am62x_bsh-ccm-m3_a53_defconfig b/configs/am62x_bsh-c=
cm-m3_a53_defconfig
> new file mode 100644
> index 0000000000..e927b2ab9a
> --- /dev/null
> +++ b/configs/am62x_bsh-ccm-m3_a53_defconfig

Make sure all of the defconfig files are synced with "make
savedefconfig" unless they're using #include.

> diff --git a/include/configs/am62x_bsh-ccm-m3.h b/include/configs/am62x_b=
sh-ccm-m3.h
> new file mode 100644
> index 0000000000..d97699faa7
> --- /dev/null
> +++ b/include/configs/am62x_bsh-ccm-m3.h
> @@ -0,0 +1,203 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Configuration header file for K3 AM625 SoC family
> + *
> + * Copyright (C) 2020-2022 Texas Instruments Incorporated - https://www.=
ti.com/
> + *	Suman Anna <s-anna@ti.com>
> + */
> +
> +#ifndef __CONFIG_BSH_AM625_EVM_H
> +#define __CONFIG_BSH_AM625_EVM_H
> +
> +#include <config_distro_bootcmd.h>

Please use bootstd.

> +/*
> + * We setup defaults based on constraints from the Linux kernel, which s=
hould
> + * also be safe elsewhere.  We have the default load at 32MB into DDR (f=
or
> + * the kernel), FDT above 128MB (the maximum location for the end of the
> + * kernel), and the ramdisk 512KB above that (allowing for hopefully nev=
er
> + * seen large trees).  We say all of this must be within the first 256MB
> + * as that will normally be within the kernel lowmem and thus visible via
> + * bootm_size and we only run on platforms with 256MB or more of memory.
> + *
> + * As a temporary storage for DTBO blobs (which should be applied into D=
TB
> + * blob), we use the location 15.5 MB above the ramdisk. If someone want=
s to
> + * use ramdisk bigger than 15.5 MB, then DTBO can be loaded and applied =
to DTB
> + * blob before loading the ramdisk, as DTBO location is only used as a t=
emporary
> + * storage, and can be re-used after 'fdt apply' command is done.
> + */
> +
> +#define DEFAULT_LINUX_BOOT_ENV \
> +	"loadaddr=3D0x82000000\0" \
> +	"kernel_addr_r=3D0x82000000\0" \
> +	"fdtaddr=3D0x85000000\0" \
> +	"dtboaddr=3D0x86000000\0" \
> +	"fdt_addr_r=3D0x85000000\0" \
> +	"fdtoverlay_addr_r=3D0x86000000\0" \
> +	"rdaddr=3D0x85080000\0" \
> +	"ramdisk_addr_r=3D0x85080000\0" \
> +	"scriptaddr=3D0x80000000\0" \
> +	"pxefile_addr_r=3D0x80100000\0" \
> +	"bootm_size=3D0x4000000\0" \
> +	"boot_fdt=3Dtry\0"
> +
> +#define DEFAULT_FIT_TI_ARGS \
> +	"boot_fit=3D0\0" \
> +	"addr_fit=3D0x8e000000\0" \
> +	"name_fit=3DfitImage\0" \
> +	"update_to_fit=3Dsetenv loadaddr ${addr_fit}; setenv bootfile ${name_fi=
t}\0" \
> +	"get_overlaystring=3D" \
> +		"for overlay in $name_overlays;" \
> +		"do;" \
> +		"setenv overlaystring ${overlaystring}'#'${overlay};" \
> +		"done;\0" \
> +	"get_fit_config=3Dsetexpr name_fit_config gsub / _ conf-${fdtfile}\0" \
> +	"run_fit=3Drun get_fit_config; bootm ${addr_fit}#${name_fit_config}${ov=
erlaystring}\0" \

And since you have a plain text environment none of this should be
needed. Please audit the rest of the file for other extraneous stuff, I
see other things too. Thanks.

--=20
Tom

--9dw+q9WVd25oEl2D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZM3iMACgkQFHw5/5Y0
tyxB9Qv/ezGSDdSNWOXh0th9OkQknj4Z5lntUe9d/wvr4A/tDjl6mJq7fNihOzI0
vscbL96AYtQDDHN7NdWrTCda7zdU7+5bjbgBWn5ZC4yKydCAA9zIfsxAMIvqhAVC
Zlb+CvvMLiO0u9iI3+T0lkISQzzeuihGiQrmu3kjLjI/3O6TP2NRcLdZzVB0+ul4
aElsAinEsCpEu80QmaHHWSVbcJ+w5fIWdYVPu0JlgxpgBoV+z21HE3t5ciRJEAcl
di08GtRLCSlMe5XR0Mt4cQ/RbqiUI7bbMEdzbjHNBmLw9txiXGrGTIB+46JnDsBI
VWPvKM3h2E5s7IlKmJ2Gc8a7bIM96sKgU4s71oZgXC7cyQZjaMSVzeN7OgIpsi/o
jFg7PwAWg5+3nrEeRogXpMLTcn/V/xyLuRyicGchlaYAoIcK5GuEzzQGCtg2mMNs
XRPjsnOaWl8rHnQONL8PMredEcFj0/+GiP0B0C7Q56krr5qvkqhH0KnqBgwOxokW
8MetXhNC
=pTf7
-----END PGP SIGNATURE-----

--9dw+q9WVd25oEl2D--
