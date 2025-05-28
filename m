Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678F8C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 18:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 999DC832EB;
	Wed, 28 May 2025 20:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="fa+epxJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 478C283321; Wed, 28 May 2025 20:13:02 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2041832AF
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 20:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1748449448;
 bh=+8lV/pX3sZR8cdygpk3/n85s9qxIcW47LB/z8jtOn+o=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=fa+epxJvvg9f7SIQEXAslZ8vXkyMqtGPald8/DDbYCeS9SenwEXpqNZF/ZKubeJBT
 AqE4+plB3UB4d4tDRELOyO84KMDL2QZhQJK3Uq88YVnA+OtSjSBK+F88mBpDi6SNUM
 sZzHwSWHC4Y0jZFC7Wvlfu9hIY9ZSrreRViOCWb+hpLz9JuArD5/nt1zSpugIjKulf
 tBEFyB3CCey02Bf+Rr+yVEzxhmnjgT5UqLfZGWjeNf/+u6AT8pWqjnUrfDTMJfC75V
 M1fjX94ngbUlGGBeueL20R2yZ6qyZh35dUmZZfpzybnKiAVnBj1bhI2X5xmEkOIplY
 Rpl11U+ISzS8g==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Michael Trimarchi <michael@amarulasolutions.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Peng Fan <peng.fan@nxp.com>, Adam Ford <aford173@gmail.com>, "Lukasz
 Majewski" <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [PATCH v2 1/4] clk: imx: add i.MX6UL clk driver
Thread-Topic: [PATCH v2 1/4] clk: imx: add i.MX6UL clk driver
Thread-Index: AQJDXFZB41jY8Cb3FaUBY8FUWfOc9bMZDOUA
Date: Wed, 28 May 2025 16:24:06 +0000
Message-ID: <c56157288f9341f2bc12eccdaccb4e4d@dh-electronics.com>
References: <20250526194811.1179530-1-michael@amarulasolutions.com>
In-Reply-To: <20250526194811.1179530-1-michael@amarulasolutions.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Michael Trimarchi
Sent: Monday, May 26, 2025 9:48 PM

Hello,

> Subject: [PATCH v2 1/4] clk: imx: add i.MX6UL clk driver
>=20
> Add i.MX6UL clk driver for i.MX6UL CLK driver model usage
>=20
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>=20
> ---
>=20
> Changes in v2:
> - Add review tag
>=20
>  drivers/clk/imx/Kconfig      |   8 ++
>  drivers/clk/imx/Makefile     |   1 +
>  drivers/clk/imx/clk-imx6ul.c | 270 +++++++++++++++++++++++++++++++++++
>  3 files changed, 279 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-imx6ul.c
>=20
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> index d17a54fb9b3..705d4a8e2ac 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -14,6 +14,14 @@ config CLK_IMX6Q
>  	help
>  	  This enables DM/DTS support for clock driver in i.MX6Q platforms.
>=20
> +config CLK_IMX6UL
> +	bool "Clock support for i.MXUL"
> +	depends on ARCH_MX6
> +	select CLK
> +	select CLK_CCF
> +	help
> +	  This enables DM/DTS support for clock driver in i.MX6UL platforms.
> +
>  config CLK_IMX8
>  	bool "Clock support for i.MX8"
>  	depends on ARCH_IMX8
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index a89ee7acb12..b10221a195c 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -4,6 +4,7 @@
>=20
>  obj-$(CONFIG_$(PHASE_)CLK_CCF) +=3D clk-gate2.o clk-pllv3.o clk-pfd.o
>  obj-$(CONFIG_$(PHASE_)CLK_IMX6Q) +=3D clk-imx6q.o
> +obj-$(CONFIG_$(PHASE_)CLK_IMX6UL) +=3D clk-imx6ul.o
>  obj-$(CONFIG_CLK_IMX8) +=3D clk-imx8.o
>=20
>  ifdef CONFIG_CLK_IMX8
> diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
> new file mode 100644
> index 00000000000..941c9352248
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imx6ul.c
> @@ -0,0 +1,270 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Amarula Solutions Software Engineering
> + * Michael Trimarchi, Amarula Solutions Software Engineering,
> michael@amarulasolutions.com
> + */
> +
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <log.h>
> +#include <asm/arch/clock.h>
> +#include <asm/arch/imx-regs.h>
> +#include <dt-bindings/clock/imx6ul-clock.h>
> +
> +#include "clk.h"
> +
> +static int imx6ul_clk_request(struct clk *clk)
> +{
> +	debug("%s: request clk id %ld\n", __func__, clk->id);
> +
> +	if (clk->id < IMX6UL_CLK_DUMMY || clk->id >=3D IMX6UL_CLK_END) {
> +		printf("%s: Invalid clk ID #%lu\n", __func__, clk->id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct clk_ops imx6ul_clk_ops =3D {
> +	.request =3D imx6ul_clk_request,
> +	.set_rate =3D ccf_clk_set_rate,
> +	.get_rate =3D ccf_clk_get_rate,
> +	.enable =3D ccf_clk_enable,
> +	.disable =3D ccf_clk_disable,
> +};
> +
> +static const char *const pll_bypass_src_sels[] =3D { "osc", "dummy", };
> +static const char *const pll3_bypass_sels[] =3D { "pll3", "pll3_bypass_s=
rc", };
> +static const char *const bch_sels[] =3D { "pll2_pfd2_396m", "pll2_pfd0_3=
52m", };
> +static const char *const gpmi_sels[] =3D { "pll2_pfd2_396m", "pll2_pfd0_=
352m", };
> +
> +static const char *const enfc_sels[] =3D { "pll2_pfd0_352m", "pll2_bus",=
 "pll3_usb_otg",
> "pll2_pfd2_396m",
> +					 "pll3_pfd3_454m", "dummy", "dummy", "dummy", };
> +static const char *const usdhc_sels[] =3D { "pll2_pfd2_396m", "pll2_pfd0=
_352m", };
> +static const char *const periph_sels[] =3D { "periph_pre", "periph_clk2"=
, };
> +static const char *const periph2_pre_sels[] =3D { "pll2_bus", "pll2_pfd2=
_396m",
> "pll2_pfd0_352m",
> +						"pll4_audio_div", };
> +static const char *const periph_clk2_sels[] =3D { "pll3_usb_otg", "osc",=
 "pll2_bypass_src",
> };
> +static const char *const periph2_clk2_sels[] =3D { "pll3_usb_otg", "osc"=
, };
> +static const char *const perclk_sels[] =3D { "ipg", "osc", };
> +
> +static const char *const periph_pre_sels[] =3D { "pll2_bus", "pll2_pfd2_=
396m",
> "pll2_pfd0_352m",
> +					       "pll2_198m", };
> +static const char *const uart_sels[] =3D { "pll3_80m", "osc", };
> +static const char *const ecspi_sels[] =3D { "pll3_60m", "osc", };
> +
> +static int imx6ul_clk_probe(struct udevice *dev)
> +{
> +	struct clk osc_clk;
> +	void *base;
> +	int ret;
> +
> +	/* Anatop clocks */
> +	base =3D (void *)ANATOP_BASE_ADDR;
> +
> +	clk_dm(IMX6UL_CLK_DUMMY, clk_register_fixed_rate(NULL, "dummy", 0));

I think you should move your clk_get_by_name of "osc" etc. from below
to this place, because you refer to it in the next lines.

> +	clk_dm(IMX6UL_CLK_PLL2,
> +	       imx_clk_pllv3(dev, IMX_PLLV3_GENERIC, "pll2_bus", "osc",
> +			     base + 0x30, 0x1));
> +	clk_dm(IMX6UL_CLK_PLL3_USB_OTG,
> +	       imx_clk_pllv3(dev, IMX_PLLV3_USB, "pll3_bypass", "osc",
> +			     base + 0x10, 0x3));

From my point of view the line with "pll3_bypass" here looks not correct
and should be removed.

> +	clk_dm(IMX6UL_CLK_PLL3,
> +	       imx_clk_pllv3(dev, IMX_PLLV3_USB, "pll3", "osc",
> +			     base + 0x10, 0x3));

I think you should move your definition of "pll3_bypass_src" and "pll3_bypa=
ss"
from below to this place, because you refer to it in the next lines.

> +	clk_dm(IMX6UL_CLK_PLL3_USB_OTG,
> +	       imx_clk_gate(dev, "pll3_usb_otg", "pll3_bypass", base + 0x10,
> +			    13));
> +	clk_dm(IMX6UL_CLK_PLL3_80M,
> +	       imx_clk_fixed_factor(dev, "pll3_80m", "pll3_usb_otg", 1, 6));
> +	clk_dm(IMX6UL_CLK_PLL3_60M,
> +	       imx_clk_fixed_factor(dev, "pll3_60m", "pll3_usb_otg", 1, 8));
> +	clk_dm(IMX6UL_CLK_PLL2_PFD0,
> +	       imx_clk_pfd("pll2_pfd0_352m", "pll2_bus", base + 0x100, 0));
> +	clk_dm(IMX6UL_CLK_PLL2_PFD1,
> +	       imx_clk_pfd("pll2_pfd1_594m", "pll2_bus", base + 0x100, 1));
> +	clk_dm(IMX6UL_CLK_PLL2_PFD2,
> +	       imx_clk_pfd("pll2_pfd2_396m", "pll2_bus", base + 0x100, 2));
> +	clk_dm(IMX6UL_CLK_PLL2_PFD3,
> +	       imx_clk_pfd("pll2_pfd3_396m", "pll2_bus", base + 0x100, 3));
> +	clk_dm(IMX6UL_CLK_PLL6,
> +	       imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll6", "osc", base + 0xe0,
> +			     0x3));
> +	clk_dm(IMX6UL_CLK_PLL6_ENET,
> +	       imx_clk_gate(dev, "pll6_enet", "pll6", base + 0xe0, 13));
> +	clk_dm(IMX6UL_PLL3_BYPASS_SRC,
> +	       imx_clk_mux(dev, "pll3_bypass_src", base + 0x10, 14, 1,
> +			   pll_bypass_src_sels,
> +			   ARRAY_SIZE(pll_bypass_src_sels)));
> +	clk_dm(IMX6UL_PLL3_BYPASS,
> +	       imx_clk_mux_flags(dev, "pll3_bypass", base + 0x10, 16, 1,
> +				 pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels),
> +				 CLK_SET_RATE_PARENT));
> +
> +	ret =3D clk_get_by_name(dev, "osc", &osc_clk);
> +	if (ret)
> +		return ret;
> +	clk_dm(IMX6UL_CLK_OSC, dev_get_clk_ptr(osc_clk.dev));
> +
> +	/* CCM clocks */
> +	base =3D dev_read_addr_ptr(dev);
> +	if (!base)
> +		return -EINVAL;
> +
> +	clk_dm(IMX6UL_CLK_GPMI_SEL,
> +	       imx_clk_mux(dev, "gpmi_sel", base + 0x1c, 19, 1, gpmi_sels,
> +			   ARRAY_SIZE(gpmi_sels)));
> +	clk_dm(IMX6UL_CLK_BCH_SEL,
> +	       imx_clk_mux(dev, "bch_sel", base + 0x1c, 18, 1, bch_sels,
> +			   ARRAY_SIZE(bch_sels)));
> +	clk_dm(IMX6UL_CLK_USDHC1_SEL,
> +	       imx_clk_mux(dev, "usdhc1_sel", base + 0x1c, 16, 1, usdhc_sels,
> +			   ARRAY_SIZE(usdhc_sels)));
> +	clk_dm(IMX6UL_CLK_USDHC2_SEL,
> +	       imx_clk_mux(dev, "usdhc2_sel", base + 0x1c, 17, 1, usdhc_sels,
> +			   ARRAY_SIZE(usdhc_sels)));
> +	clk_dm(IMX6UL_CLK_ECSPI_SEL,
> +	       imx_clk_mux(dev, "ecspi_sel", base + 0x38, 18, 1, ecspi_sels,
> +			   ARRAY_SIZE(ecspi_sels)));
> +	clk_dm(IMX6UL_CLK_UART_SEL,
> +	       imx_clk_mux(dev, "uart_sel", base + 0x24, 6, 1, uart_sels,
> +			   ARRAY_SIZE(uart_sels)));
> +	clk_dm(IMX6UL_CLK_ENFC_SEL,
> +	       imx_clk_mux(dev, "enfc_sel", base + 0x2c, 15, 3, enfc_sels,
> +			   ARRAY_SIZE(enfc_sels)));
> +	clk_dm(IMX6UL_CLK_PERCLK_SEL,
> +	       imx_clk_mux(dev, "perclk_sel", base + 0x1c, 6, 1, perclk_sels,
> +			   ARRAY_SIZE(perclk_sels)));
> +	clk_dm(IMX6UL_CLK_PERIPH_PRE,
> +	       imx_clk_mux(dev, "periph_pre", base + 0x18, 18, 2,
> +			   periph_pre_sels, ARRAY_SIZE(periph_pre_sels)));
> +	clk_dm(IMX6UL_CLK_PERIPH2_PRE,
> +	       imx_clk_mux(dev, "periph2_pre", base + 0x18, 21, 2,
> +			   periph2_pre_sels, ARRAY_SIZE(periph2_pre_sels)));
> +	clk_dm(IMX6UL_CLK_PERIPH_CLK2_SEL,
> +	       imx_clk_mux(dev, "periph_clk2_sel", base + 0x18, 12, 2,
> +			   periph_clk2_sels, ARRAY_SIZE(periph_clk2_sels)));
> +	clk_dm(IMX6UL_CLK_PERIPH2_CLK2_SEL,
> +	       imx_clk_mux(dev, "periph2_clk2_sel", base + 0x18, 20, 1,
> +			   periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels)));
> +	clk_dm(IMX6UL_CLK_PERIPH,
> +	       imx_clk_busy_mux(dev, "periph", base + 0x14, 25, 1, base + 0x48,
> +				5, periph_sels, ARRAY_SIZE(periph_sels)));
> +	clk_dm(IMX6UL_CLK_AHB,
> +	       imx_clk_busy_divider(dev, "ahb", "periph", base + 0x14, 10, 3,
> +				    base + 0x48, 1));
> +	clk_dm(IMX6UL_CLK_PERIPH_CLK2,
> +	       imx_clk_divider(dev, "periph_clk2", "periph_clk2_sel",
> +			       base + 0x14, 27, 3));
> +	clk_dm(IMX6UL_CLK_PERIPH2_CLK2,
> +	       imx_clk_divider(dev, "periph2_clk2", "periph2_clk2_sel",
> +			       base + 0x14, 0, 3));
> +	clk_dm(IMX6UL_CLK_IPG,
> +	       imx_clk_divider(dev, "ipg", "ahb", base + 0x14, 8, 2));
> +	clk_dm(IMX6UL_CLK_ENFC_PRED,
> +	       imx_clk_divider(dev, "enfc_pred", "enfc_sel", base + 0x2c, 18,
> +			       3));
> +	clk_dm(IMX6UL_CLK_ENFC_PODF,
> +	       imx_clk_divider(dev, "enfc_podf", "enfc_pred", base + 0x2c, 21,
> +			       6));
> +	clk_dm(IMX6UL_CLK_GPMI_PODF,
> +	       imx_clk_divider(dev, "gpmi_podf", "gpmi_sel", base + 0x24, 22,
> +			       3));
> +	clk_dm(IMX6UL_CLK_BCH_PODF,
> +	       imx_clk_divider(dev, "bch_podf", "bch_sel", base + 0x24, 19, 3))=
;
> +	clk_dm(IMX6UL_CLK_PERCLK,
> +	       imx_clk_divider(dev, "perclk", "perclk_sel", base + 0x1c, 0, 6))=
;
> +	clk_dm(IMX6UL_CLK_UART_PODF,
> +	       imx_clk_divider(dev, "uart_podf", "uart_sel", base + 0x24, 0,
> +			       6));
> +	clk_dm(IMX6UL_CLK_USDHC1_PODF,
> +	       imx_clk_divider(dev, "usdhc1_podf", "usdhc1_sel", base + 0x24,
> +			       11, 3));
> +	clk_dm(IMX6UL_CLK_USDHC2_PODF,
> +	       imx_clk_divider(dev, "usdhc2_podf", "usdhc2_sel", base + 0x24,
> +			       16, 3));
> +	clk_dm(IMX6UL_CLK_ECSPI_PODF,
> +	       imx_clk_divider(dev, "ecspi_podf", "ecspi_sel", base + 0x38, 19,
> +			       6));
> +
> +	clk_dm(IMX6UL_CLK_APBHDMA,
> +	       imx_clk_gate2(dev, "apbh_dma", "bch_podf", base + 0x68, 4));
> +	clk_dm(IMX6UL_CLK_ECSPI1,
> +	       imx_clk_gate2(dev, "ecspi1", "ecspi_podf", base + 0x6c, 0));
> +	clk_dm(IMX6UL_CLK_ECSPI2,
> +	       imx_clk_gate2(dev, "ecspi2", "ecspi_podf", base + 0x6c, 2));
> +	clk_dm(IMX6UL_CLK_ECSPI3,
> +	       imx_clk_gate2(dev, "ecspi3", "ecspi_podf", base + 0x6c, 4));
> +	clk_dm(IMX6UL_CLK_ECSPI4,
> +	       imx_clk_gate2(dev, "ecspi4", "ecspi_podf", base + 0x6c, 6));
> +
> +	clk_dm(IMX6UL_CLK_USBOH3,
> +	       imx_clk_gate2(dev, "usboh3", "ipg", base + 0x80, 0));
> +	clk_dm(IMX6UL_CLK_USDHC1,
> +	       imx_clk_gate2(dev, "usdhc1", "usdhc1_podf", base + 0x80, 2));
> +	clk_dm(IMX6UL_CLK_USDHC2,
> +	       imx_clk_gate2(dev, "usdhc2", "usdhc2_podf", base + 0x80, 4));
> +
> +	clk_dm(IMX6UL_CLK_UART3_IPG,
> +	       imx_clk_gate2(dev, "uart3_ipg", "ipg", base + 0x6c, 10));
> +	clk_dm(IMX6UL_CLK_UART3_SERIAL,
> +	       imx_clk_gate2(dev, "uart3_serial", "uart_podf", base + 0x6c,
> +			     10));
> +	clk_dm(IMX6UL_CLK_UART4_IPG,
> +	       imx_clk_gate2(dev, "uart4_ipg", "ipg", base + 0x6c, 24));
> +	clk_dm(IMX6UL_CLK_UART4_SERIAL,
> +	       imx_clk_gate2(dev, "uart4_serial", "uart_podf", base + 0x6c,
> +			     24));

My Console doesn't work with this driver, because it is on UART1.
Could you define all UARTs for imx6UL/i.MX6ULL/i.MX6ULZ here?

clk_dm(IMX6UL_CLK_UART1_IPG,
       imx_clk_gate2(dev, "uart1_ipg", "ipg", base + 0x7c, 24));
clk_dm(IMX6UL_CLK_UART1_SERIAL,
       imx_clk_gate2(dev, "uart1_serial", "uart_podf", base + 0x7c, 24));
clk_dm(IMX6UL_CLK_UART2_IPG,
       imx_clk_gate2(dev, "uart2_ipg", "ipg", base + 0x68, 28));
clk_dm(IMX6UL_CLK_UART2_SERIAL,
       imx_clk_gate2(dev, "uart2_serial", "uart_podf", base + 0x68, 28));
clk_dm(IMX6UL_CLK_UART3_IPG,
       imx_clk_gate2(dev, "uart3_ipg", "ipg", base + 0x6c, 10));
clk_dm(IMX6UL_CLK_UART3_SERIAL,
       imx_clk_gate2(dev, "uart3_serial", "uart_podf", base + 0x6c, 10));
clk_dm(IMX6UL_CLK_UART4_IPG,
       imx_clk_gate2(dev, "uart4_ipg", "ipg", base + 0x6c, 24));
clk_dm(IMX6UL_CLK_UART4_SERIAL,
       imx_clk_gate2(dev, "uart4_serial", "uart_podf", base + 0x6c, 24));
clk_dm(IMX6UL_CLK_UART5_IPG,
       imx_clk_gate2(dev, "uart5_ipg", "ipg", base + 0x74, 2));
clk_dm(IMX6UL_CLK_UART5_SERIAL,
       imx_clk_gate2(dev, "uart5_serial", "uart_podf", base + 0x74, 2));
clk_dm(IMX6UL_CLK_UART6_IPG,
       imx_clk_gate2(dev, "uart6_ipg", "ipg", base + 0x74, 6));
clk_dm(IMX6UL_CLK_UART6_SERIAL,
       imx_clk_gate2(dev, "uart6_serial", "uart_podf", base + 0x74, 6));
clk_dm(IMX6UL_CLK_UART7_IPG,
       imx_clk_gate2(dev, "uart7_ipg", "ipg", base + 0x7c, 26));
clk_dm(IMX6UL_CLK_UART7_SERIAL,
       imx_clk_gate2(dev, "uart7_serial", "uart_podf", base + 0x7c, 26));
clk_dm(IMX6UL_CLK_UART8_IPG,
       imx_clk_gate2(dev, "uart8_ipg", "ipg", base + 0x80, 14));
clk_dm(IMX6UL_CLK_UART8_SERIAL,
       imx_clk_gate2(dev, "uart8_serial", "uart_podf", base + 0x80, 14));

Regards
Christoph
