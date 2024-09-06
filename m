Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890D2E6FE2F
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 16:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACD8B88CB6;
	Fri,  6 Sep 2024 18:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M6uGM952";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC48188915; Fri,  6 Sep 2024 18:13:23 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A008088CD8
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 18:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6c35b545b41so31313516d6.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 09:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725639198; x=1726243998; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4aEg/5hWLiWLIXwhZtWSe0+H7X8uI6i8cSkOoK8Mmz8=;
 b=M6uGM952aAkiF0sXQJRJ9TMFAM2rnc0nb7IQKiz15ArOrOVjZETvEZ6+qqUTANEICA
 19HqwNp7Lspj0fQ/dxcztlYXlZDJ5yh7jAYj+fF8XMFM9XDOxosU3X6sJ8AabLy+SDC0
 eySVsWgDglcrxBqgYfSYY4lo5e3FqV8kM4wDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725639198; x=1726243998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4aEg/5hWLiWLIXwhZtWSe0+H7X8uI6i8cSkOoK8Mmz8=;
 b=DtktAmKJnBDHqXErljghHkWLQAmYwMVrt93Yyw0WOdJDkmt5+1VAENbXvdhYJ9hXq8
 zGXv+7/zTLZ9th/pBv/jc6uUMEpPEMRBtY6SgAcrOMDemYQE0iPlM2vPxO0XmjgjsWDU
 y77LlPELK9pUegdHV1nmDnQSmk2337ScSNsw6NsUgP2rg5EwA6V1++Z7EkXVDd0Qvi+b
 07gaUUH012pcSXoSWANuRtuATLgPAOiRN8ZVGXPnR+7uc9O/+gB8CeyQqlPSzOKQb4Zy
 j8biuURiMwoqdg0I485t3ESZuBvzPyFTIZfW89c/az9FiOJh+2MNpI9+XHECNwEpBEnh
 MfeQ==
X-Gm-Message-State: AOJu0Yy2amGfAsKQvqCF45lGd07AgHYiZJEFzbQ1X2h2gdoh09IHMrx+
 w2mLhmLKsH5bWoFQp9M8qVEchuQ0sTHW7SgsBC0bDawAAx+D9FSDvg2s9JRcz1w=
X-Google-Smtp-Source: AGHT+IHUp3psmscEPBkLAxaqbJ+WJWZGBNHqZp4LH0y+7I+64wXarg35E47pIBlOwdbldCmamS9Dsw==
X-Received: by 2002:a05:6214:3da0:b0:6c3:5454:6e1e with SMTP id
 6a1803df08f44-6c52850f35bmr67366006d6.24.1725639198310; 
 Fri, 06 Sep 2024 09:13:18 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5201dedf9sm17643016d6.20.2024.09.06.09.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 09:13:17 -0700 (PDT)
Date: Fri, 6 Sep 2024 10:13:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, sjg@chromium.org, bmeng.cn@gmail.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com
Subject: Re: [PATCH v2 16/28] drivers: usb: Add generic XHCI
Message-ID: <20240906161313.GD3879073@bill-the-cat>
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
 <20240906072231.2531491-17-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qqHnmFWpQaFDbWd4"
Content-Disposition: inline
In-Reply-To: <20240906072231.2531491-17-patrick.rudolph@9elements.com>
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


--qqHnmFWpQaFDbWd4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2024 at 09:22:18AM +0200, Patrick Rudolph wrote:

> Add support for the generic XHCI driver that contains no SoC
> specific code. It can be used on platforms that simply work out
> of the box, like on emulated platforms.
>=20
> TEST: Booted on QEMU sbsa machine using the generic xhci driver.
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Tom Rini <trini@konsulko.com>

Adding Marek..

> ---
>  drivers/usb/host/Kconfig        |  8 +++
>  drivers/usb/host/Makefile       |  1 +
>  drivers/usb/host/xhci-generic.c | 88 +++++++++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+)
>  create mode 100644 drivers/usb/host/xhci-generic.c
>=20
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 6e10b629a3..bb5893d56d 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -68,6 +68,14 @@ config USB_XHCI_MVEBU
>  	  SoCs, which includes Armada8K, Armada3700 and other Armada
>  	  family SoCs.
> =20
> +config USB_XHCI_GENERIC
> +	bool "Generic SoC USB 3.0 support"
> +	depends on OF_CONTROL
> +	default n
> +	help
> +	  Choose this option to add support for USB 3.0 driver for SoCs
> +	  that do not need platform specific code, like on emulated targets.
> +
>  config USB_XHCI_OCTEON
>  	bool "Support for Marvell Octeon family on-chip xHCI USB controller"
>  	depends on ARCH_OCTEON
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index 8dad36f936..9e880195ec 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_USB_XHCI_EXYNOS) +=3D xhci-exynos5.o
>  obj-$(CONFIG_USB_XHCI_FSL) +=3D xhci-fsl.o
>  obj-$(CONFIG_USB_XHCI_MTK) +=3D xhci-mtk.o
>  obj-$(CONFIG_USB_XHCI_MVEBU) +=3D xhci-mvebu.o
> +obj-$(CONFIG_USB_XHCI_GENERIC) +=3D xhci-generic.o
>  obj-$(CONFIG_USB_XHCI_OMAP) +=3D xhci-omap.o
>  obj-$(CONFIG_USB_XHCI_PCI) +=3D xhci-pci.o
>  obj-$(CONFIG_USB_XHCI_RCAR) +=3D xhci-rcar.o
> diff --git a/drivers/usb/host/xhci-generic.c b/drivers/usb/host/xhci-gene=
ric.c
> new file mode 100644
> index 0000000000..8c0341d0c4
> --- /dev/null
> +++ b/drivers/usb/host/xhci-generic.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 9elements GmbH
> + *
> + * GENERIC USB HOST xHCI Controller
> + */
> +
> +#include <asm/io.h>
> +#include <dm.h>
> +#include <fdtdec.h>
> +#include <log.h>
> +#include <usb.h>
> +
> +#include <usb/xhci.h>
> +
> +struct generic_xhci_plat {
> +	fdt_addr_t hcd_base;
> +};
> +
> +/**
> + * Contains pointers to register base addresses
> + * for the usb controller.
> + */
> +struct generic_xhci {
> +	struct xhci_ctrl ctrl;	/* Needs to come first in this struct! */
> +	struct usb_plat usb_plat;
> +	struct xhci_hccr *hcd;
> +};
> +
> +/*
> + * Dummy implementation that can be overwritten by a board
> + * specific function
> + */
> +__weak int board_xhci_enable(fdt_addr_t base)
> +{
> +	return 0;
> +}
> +
> +static int xhci_usb_probe(struct udevice *dev)
> +{
> +	struct generic_xhci_plat *plat =3D dev_get_plat(dev);
> +	struct generic_xhci *ctx =3D dev_get_priv(dev);
> +	struct xhci_hcor *hcor;
> +	int len;
> +
> +	ctx->hcd =3D (struct xhci_hccr *)phys_to_virt(plat->hcd_base);
> +	len =3D HC_LENGTH(xhci_readl(&ctx->hcd->cr_capbase));
> +	hcor =3D (struct xhci_hcor *)((uintptr_t)ctx->hcd + len);
> +
> +	/* Enable USB xHCI in board specific code */
> +	board_xhci_enable(devfdt_get_addr_index(dev, 1));
> +
> +	return xhci_register(dev, ctx->hcd, hcor);
> +}
> +
> +static int xhci_usb_of_to_plat(struct udevice *dev)
> +{
> +	struct generic_xhci_plat *plat =3D dev_get_plat(dev);
> +
> +	/*
> +	 * Get the base address for XHCI controller from the device node
> +	 */
> +	plat->hcd_base =3D dev_read_addr(dev);
> +	if (plat->hcd_base =3D=3D FDT_ADDR_T_NONE) {
> +		debug("Can't get the XHCI register base address\n");
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id xhci_usb_ids[] =3D {
> +	{ .compatible =3D "generic-xhci" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(usb_xhci) =3D {
> +	.name	=3D "xhci_generic",
> +	.id	=3D UCLASS_USB,
> +	.of_match =3D xhci_usb_ids,
> +	.of_to_plat =3D xhci_usb_of_to_plat,
> +	.probe =3D xhci_usb_probe,
> +	.remove =3D xhci_deregister,
> +	.ops	=3D &xhci_usb_ops,
> +	.plat_auto	=3D sizeof(struct generic_xhci_plat),
> +	.priv_auto	=3D sizeof(struct generic_xhci),
> +	.flags	=3D DM_FLAG_ALLOC_PRIV_DMA,
> +};
> --=20
> 2.45.2
>=20

--=20
Tom

--qqHnmFWpQaFDbWd4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbbKhIACgkQFHw5/5Y0
tyxXVQv/QmAKCviFd9stSFinnef1HKifeLFQvLaY+zVeGqaKuWDi+fxEbc+08uag
PyHeUouA75dGFgfcUB4y0p8n1pY62Aq13Ba7m7BveuTipbrhnfUDcvJoIsQnCKev
1kSDpm+ATsBESqhDft6h2AKqQ265oBOJ6hIn7xhx0EW8/COdTQfDqXjNStUMwO2/
KLP/+dLi86rrIkyKnEKvPs/eYbJv9ETSNDwwUYpckeBlk8NfEBnx76nh5K4FBkru
SNFJ7etfu+1sXrnbEaOxF+qRzRutCkcj72sZE4nuHnvlUPBAiQxKrV3AFjK3CXXJ
Ctvi/yTxbFHa01dYBxUBb7ShxkusTx2lE63WAfGHX4fXXVHhKZbCafogUtfWdUrj
lRNNcICgxsriPqJR8ojmffCLDn6YzknrCIoWfnrpMoC+wCsgHYwK+beJanJxyg81
9CkuSFynXkm6MTOwkgFSPihIElPPIeWS8ML1wNzxqrhmkssJ6yiTpz1kEVtjvJCX
Exu9fx1z
=V49t
-----END PGP SIGNATURE-----

--qqHnmFWpQaFDbWd4--
