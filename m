Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F152FC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 17:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C5F582B97;
	Thu, 12 Jun 2025 19:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sot5PTLk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 126E782B97; Thu, 12 Jun 2025 19:31:36 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 861CF82B70
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 19:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-400fa6eafa9so878903b6e.1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749749492; x=1750354292; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u0vCpz9y+JzWc3i9+c8dvUElzXcQJhKhbeUuwRXKxCQ=;
 b=Sot5PTLkstJhFDbdybZbJkQDkVfka1VOc7Ao9/lN+W7ssmZZZUUxEk++z3iBLKZaGs
 P4Zn7juPa3WcsfUN6k7sdFCIQ382p6Qlbr3WukccO7wu7nuoJshU/Ic/gNmAnrVHH7CD
 TL/FZLT7AsnAylt63lRTirKxKae73QJhRXb5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749749492; x=1750354292;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u0vCpz9y+JzWc3i9+c8dvUElzXcQJhKhbeUuwRXKxCQ=;
 b=G7/aeGBm+4igOJBD/yFLKSPKCMVmvMr3qvCxQ2uRvLOwYu0ipq95cTmRE5t4DiJgxy
 rg7F+lNDWvWdErHvaeWVrO78No0FqtfDOwK5FXCbdNbRolEEf6482jDMFSvQs3MWhhD6
 rb5DbgbAXDamUfLllRXeuSWxqbZ3Dtxjtmb4yCrXK5NEhA3g8EOk182pDGMOnO4+vTF/
 +uBEdqHP14WLp83i6z/tS4Lp/H/nzlEFvmLvPMc1+inj1OAZ0UEiR3eggyzjfWMHfb7A
 R57HIrpSuURary1HWpvKkiXNUMty30XfqsqQdQa9/RXhfIbQ9TKGekzHU88J8e8YHtjR
 uEPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiFGXJ93xnsRafvyi3IRUAWol6Qjj6ysZ6+QlXlwzE1rCvjFEZ56DYgct3vyrZdkgjJGA5d60=@lists.denx.de
X-Gm-Message-State: AOJu0YxM/f5YJT6t8nRR9CxdsvCGtw3YpNEJQL30FY9O0LtBDdhBraCF
 Xwgd/xOOLIGmTcwThK1APka8cTNBUf7nn3zsBD+XxS36aKAIGRA3tghO8xxxgmn3P/U=
X-Gm-Gg: ASbGncuabs9yVgYwrfwMqLaxoEp8vciCvAh+3r2LmOV1KT6YcAURFqepxXe2Vq4GIog
 FdJPQzFciDr9WbMSlxRvhxa9z2keM4NFtcdkJ86A4OvRcmtKunweX9x6dyokuZAsx57SfWXA6RV
 /HGAVceAiXzCIs7S6B//fbS/RGYUuj46GSkp1wE+H9BBFoDp2+7mNetULw1NftfXII2J/kmHrkt
 TeaEYfh7JsjTg0ymfRI3tXvNMzkiqrJUNbrTSsBcF476DZmuHcIRFAYhcjCx3FTa4SwD8jOuA68
 ge20c8ImUfkbwy3339dSzHda9trqQjOkxIMNIbLH4ZGE+ZzQS6cDPRDQDY7UHoPAd3CBrMbgoyZ
 kTBwoRtF1YwO5jVse/ELrwPc=
X-Google-Smtp-Source: AGHT+IErrPB1Pwm4KPxyRVDAzcYzXiVbf9nG7GVfzeKXoVAVonFRbsBtMJfTj7QWvS8/BD7uuHnZTA==
X-Received: by 2002:a05:6808:1895:b0:404:ed0d:79e5 with SMTP id
 5614622812f47-40a72401581mr130198b6e.30.1749749492200; 
 Thu, 12 Jun 2025 10:31:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a6822f714sm374732b6e.16.2025.06.12.10.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 10:31:31 -0700 (PDT)
Date: Thu, 12 Jun 2025 11:31:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
Cc: vigneshr@ti.com, rfried.dev@gmail.com, jm@ti.com, s-k6@ti.com,
 rogerq@kernel.org, afd@ti.com, sjg@chromium.org, danishanwar@ti.com,
 anshuld@ti.com, n-francis@ti.com, u-boot@lists.denx.de,
 s-vadapalli@ti.com, srk@ti.com
Subject: Re: [PATCH 1/2] pci_endpoint: Add TI K3 Cadence PCIe Endpoint
 Controller driver
Message-ID: <20250612173128.GR1382132@bill-the-cat>
References: <20250612085023.3457117-1-h-salunke@ti.com>
 <20250612085023.3457117-2-h-salunke@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ihluf0mUCGBRzr7C"
Content-Disposition: inline
In-Reply-To: <20250612085023.3457117-2-h-salunke@ti.com>
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


--Ihluf0mUCGBRzr7C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 02:20:22PM +0530, Hrushikesh Salunke wrote:

> Add support for Endpoint mode of operation in the Cadence PCIe
> Controller present on TI's K3 SoCs. This driver is an adaptation of the
> Linux driver.

Please mention what release you're adopting from as it will make future
resyncs easier.

>=20
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> ---
>  drivers/pci_endpoint/Kconfig           |   6 +
>  drivers/pci_endpoint/Makefile          |   1 +
>  drivers/pci_endpoint/pcie_cdns_ti_ep.c | 399 +++++++++++++++++++++++++
>  3 files changed, 406 insertions(+)
>  create mode 100644 drivers/pci_endpoint/pcie_cdns_ti_ep.c
>=20
> diff --git a/drivers/pci_endpoint/Kconfig b/drivers/pci_endpoint/Kconfig
> index 19cfa0aafb5..413556a4982 100644
> --- a/drivers/pci_endpoint/Kconfig
> +++ b/drivers/pci_endpoint/Kconfig
> @@ -22,6 +22,12 @@ config PCIE_CADENCE_EP
>  	  endpoint mode. This PCIe controller may be embedded into many
>  	  different vendors SoCs.
> =20
> +config PCIE_CDNS_TI_EP
> +	bool "TI K3 PCIe EP support"
> +	help
> +		Say Y here to enable support for the Canence PCIe Controller
> +		in Endpoint Mode on TI's K3 Socs.

Spacing is off.

> +
>  config PCI_SANDBOX_EP
>  	bool "Sandbox PCIe endpoint controller"
>  	depends on PCI_ENDPOINT
> diff --git a/drivers/pci_endpoint/Makefile b/drivers/pci_endpoint/Makefile
> index 3cd987259d3..62a865c4463 100644
> --- a/drivers/pci_endpoint/Makefile
> +++ b/drivers/pci_endpoint/Makefile
> @@ -6,3 +6,4 @@
>  obj-y +=3D pci_ep-uclass.o
>  obj-$(CONFIG_PCIE_CADENCE_EP) +=3D pcie-cadence-ep.o
>  obj-$(CONFIG_PCI_SANDBOX_EP) +=3D sandbox-pci_ep.o
> +obj-$(CONFIG_PCIE_CDNS_TI_EP) +=3D pcie_cdns_ti_ep.o
> diff --git a/drivers/pci_endpoint/pcie_cdns_ti_ep.c b/drivers/pci_endpoin=
t/pcie_cdns_ti_ep.c
> new file mode 100644
> index 00000000000..18b9e45911e
> --- /dev/null
> +++ b/drivers/pci_endpoint/pcie_cdns_ti_ep.c
> @@ -0,0 +1,399 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com
> + *
> + * PCIe Endpoint controller driver for TI's K3 SoCs with Cadence PCIe co=
ntroller
> + *
> + * Ported from the Linux driver - drivers/pci/controller/cadence/pci-j72=
1e.c
> + *
> + * Author: Hrushikesh Salunke <h-salunke@ti.com>
> + *
> + */
> +
> +#include <asm/gpio.h>
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <generic-phy.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/log2.h>
> +#include <linux/sizes.h>
> +#include <power-domain.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +#include <pcie-cadence.h>
> +#include <pci_ep.h>

Please audit this include list.

Otherwise seems fine, thanks.

--=20
Tom

--Ihluf0mUCGBRzr7C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhLDu0ACgkQFHw5/5Y0
tyzWiQv7BuggGqdwpJzZMtGKtOCryJfGlHUYgHlBko9nsLVYFq7Eoa83Xejwwma0
RQJ84k1zLpjYjashrMsUqu2waFIRTFozX41AMaLXDjm9kHeQ/wdmDV8G1ZhkAes/
7e/D09TYGJqoJjWDInb3RSprL8lnYF1rW/AmSNlKWUhD95Tf1cBXQLYgFxhSNl7m
AW2/tJ0nm0S0kRj1CPEuQP9NMk826ifh65YuCZsEM6v2nwyKZ6LgC8lF06T8XIhC
SmjXo/EIHCnFEyMRKyS+JzIJRDShT4OVgUGaAympkg6RP3GzMphe9uG26f+b2VKK
JtCAM9qgH/QftORpQ6VaL+zR2vRcVv2Thwd/tcQ4n1T1o7qN6EQ9woGqrdzeA7yl
kRhgvh8A4bKfjCziuSenzUjn6mpWUfz6BOo5vxve+tYHEtH+m6/fHdIPQ4mUJEYt
cGIClo/0MCRMtbsv0IQJJWFDVyATIpmBI5pGlXneBF1nbHwBSQJOFeepwZ+BahId
hB8Q2aab
=90sE
-----END PGP SIGNATURE-----

--Ihluf0mUCGBRzr7C--
