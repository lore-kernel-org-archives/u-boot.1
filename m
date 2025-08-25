Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B97CA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 09:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FAC4828A2;
	Mon, 25 Aug 2025 11:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="NdwBFEUd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C17FB83043; Mon, 25 Aug 2025 11:43:30 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03108808AF
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 11:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0332a41ace=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8dk4B018397;
 Mon, 25 Aug 2025 11:43:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 LiLa5JnKCYFgEZVlhe4dftpjizLH1/ImZoiAZU5m3lM=; b=NdwBFEUdB/zlyF44
 uK/r+VLAniXLApXSVyGxoRQo18Ox3y6mKff1jfrWhKvgl1gPNwe03UF6P1GPOTKK
 Ij4nYd9qKmSjry5u+VTbZpgVjj0LPCC6n9RD5TEclTRZaOXcUvkT5UKx3Cvg1PwF
 nZeb8W3AEbXgifCbkGkoyLU+RUTZQYsXY1pOflGGAsDft0QAqPe3Y4TqQYgNkhKZ
 33C8KVbjD+aUh1RyfEt7osXO2+TqagT1B1QiILEd0BAhTb8dB/VWM64lP9nylrzA
 Ch9CzLT2hndCKZ9IMnu7U1c47MwEQ82rJodJT+96AKnFU3NimkO4+tVBEd7WEw76
 Zv/mxw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48q626durs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 11:43:21 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B3ED040044;
 Mon, 25 Aug 2025 11:42:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 424B55F062B;
 Mon, 25 Aug 2025 11:42:07 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 25 Aug
 2025 11:42:06 +0200
Message-ID: <01b8e8a6-227e-4788-b081-31f870bc6e07@foss.st.com>
Date: Mon, 25 Aug 2025 11:42:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] video: stm32: STM32 driver support for LVDS
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>, Dillon Min
 <dillon.minfei@gmail.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250820-master-v1-0-fc76f18ab2fd@foss.st.com>
 <20250820-master-v1-3-fc76f18ab2fd@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250820-master-v1-3-fc76f18ab2fd@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_04,2025-08-20_03,2025-03-28_01
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



On 8/20/25 18:17, Raphael Gallais-Pou wrote:
> The LVDS Display Interface Transmitter handles the LVDS protocol:
> it maps the pixels received from the upstream Pixel-DMA (LTDC)
> onto the LVDS PHY.
> 
> The LVDS controller driver supports the following high-level features:
>         • FDP-Link-I and OpenLDI (v0.95) protocols
>         • Single-Link or Dual-Link operation
>         • Single-Display or Double-Display (with the same content
>           duplicated on both)
>         • Flexible Bit-Mapping, including JEIDA and VESA
>         • RGB888 or RGB666 output
>         • Synchronous design, with one input pixel per clock cycle
>         • No resolution limitation.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>  MAINTAINERS                      |   1 +
>  doc/board/st/st-dt.rst           |   1 +
>  drivers/video/stm32/Kconfig      |   9 +
>  drivers/video/stm32/Makefile     |   1 +
>  drivers/video/stm32/stm32_lvds.c | 673 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 685 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3fb163aa1db1dba249e60b40ab3e785db4fde5d3..604ba4ca04c1079b14cd8f4c1fff4c12da0e278d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -728,6 +728,7 @@ F:	drivers/serial/serial_stm32.*
>  F:	drivers/spi/stm32_qspi.c
>  F:	drivers/spi/stm32_spi.c
>  F:	drivers/video/stm32/stm32_ltdc.c
> +F:	drivers/video/stm32/stm32_lvds.c
>  F:	drivers/watchdog/stm32mp_wdt.c
>  F:	include/dt-bindings/clock/stm32fx-clock.h
>  F:	include/dt-bindings/clock/stm32mp*
> diff --git a/doc/board/st/st-dt.rst b/doc/board/st/st-dt.rst
> index 2a285c81807ee26924948d8c2497f11dfe45b6e6..28cada97e72da711408a1aaaa928ad3faa51162e 100644
> --- a/doc/board/st/st-dt.rst
> +++ b/doc/board/st/st-dt.rst
> @@ -25,6 +25,7 @@ kernel binding directory = Documentation/devicetree/bindings/
>  * display
>  	- display/st,stm32-dsi.yaml
>  	- display/st,stm32-ltdc.yaml
> +        - display/st,stm32mp25-lvds.yaml
>  * gpio
>  	- pinctrl/st,stm32-pinctrl.yaml
>  * hwlock
> diff --git a/drivers/video/stm32/Kconfig b/drivers/video/stm32/Kconfig
> index c354c402c288b4c004bd2b5cc74a4d00beef2773..4cb8a841caf51aaba5115b9fcddb967f73a3d9b4 100644
> --- a/drivers/video/stm32/Kconfig
> +++ b/drivers/video/stm32/Kconfig
> @@ -23,6 +23,15 @@ config VIDEO_STM32_DSI
>  	  This option enables support DSI internal bridge which can be used on
>  	  devices which have DSI devices connected.
>  
> +config VIDEO_STM32_LVDS
> +	bool "Enable STM32 LVDS video support"
> +	depends on VIDEO_STM32
> +	select VIDEO_BRIDGE
> +	select VIDEO_DW_MIPI_DSI
> +	help
> +	  This enables Low Voltage Differential Signaling (LVDS) display
> +	  support.
> +
>  config VIDEO_STM32_MAX_XRES
>  	int "Maximum horizontal resolution (for memory allocation purposes)"
>  	depends on VIDEO_STM32
> diff --git a/drivers/video/stm32/Makefile b/drivers/video/stm32/Makefile
> index f8b42d1a4d126a31aa11ce820e829b133ca3bb2d..059d9000c1d7762d06bff36d5408143a34848227 100644
> --- a/drivers/video/stm32/Makefile
> +++ b/drivers/video/stm32/Makefile
> @@ -7,3 +7,4 @@
>  
>  obj-${CONFIG_VIDEO_STM32} = stm32_ltdc.o
>  obj-${CONFIG_VIDEO_STM32_DSI} += stm32_dsi.o
> +obj-${CONFIG_VIDEO_STM32_LVDS} += stm32_lvds.o
> diff --git a/drivers/video/stm32/stm32_lvds.c b/drivers/video/stm32/stm32_lvds.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..1e3e740122dfee0c947819532da64f0d99327bde
> --- /dev/null
> +++ b/drivers/video/stm32/stm32_lvds.c
> @@ -0,0 +1,673 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 STMicroelectronics - All Rights Reserved
> + * Author(s): Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com> for STMicroelectronics.
> + *
> + * This Low Voltage Differential Signal controller driver is based on the Linux Kernel driver from
> + * drivers/gpu/drm/stm/ltdc.c
> + */
> +
> +#define LOG_CATEGORY UCLASS_VIDEO_BRIDGE
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <log.h>
> +#include <media_bus_format.h>
> +#include <panel.h>
> +#include <reset.h>
> +#include <video.h>
> +#include <video_bridge.h>
> +#include <asm/io.h>
> +#include <dm/device_compat.h>
> +#include <dm/ofnode.h>
> +#include <linux/iopoll.h>
> +
> +/* LVDS Host registers */
> +#define LVDS_CR		0x0000  /* configuration register */
> +#define LVDS_DMLCR0	0x0004  /* data mapping lsb configuration register 0	*/
> +#define LVDS_DMMCR0	0x0008  /* data mapping msb configuration register 0	*/
> +#define LVDS_DMLCR1	0x000C  /* data mapping lsb configuration register 1	*/
> +#define LVDS_DMMCR1	0x0010  /* data mapping msb configuration register 1	*/
> +#define LVDS_DMLCR2	0x0014  /* data mapping lsb configuration register 2	*/
> +#define LVDS_DMMCR2	0x0018  /* data mapping msb configuration register 2	*/
> +#define LVDS_DMLCR3	0x001C  /* data mapping lsb configuration register 3	*/
> +#define LVDS_DMMCR3	0x0020  /* data mapping msb configuration register 3	*/
> +#define LVDS_DMLCR4	0x0024  /* data mapping lsb configuration register 4	*/
> +#define LVDS_DMMCR4	0x0028  /* data mapping msb configuration register 4	*/
> +#define LVDS_DMLCR(id)	(LVDS_DMLCR0 + 8U * (id))
> +#define LVDS_DMMCR(id)	(LVDS_DMMCR0 + 8U * (id))
> +#define LVDS_CDL1CR	0x002C  /* channel distrib link 1 configuration register	*/
> +#define LVDS_CDL2CR	0x0030  /* channel distrib link 2 configuration register	*/
> +
> +#define CDL1CR_DEFAULT	0x4321
> +#define CDL2CR_DEFAULT	0x59876
> +
> +/* LVDS Host registers */
> +#define LVDS_PHY_MASTER	0x0
> +#define LVDS_PHY_SLAVE	0x100
> +
> +/* phy parameter can only be one of those two above */
> +#define LVDS_PxGCR(phy)		((phy) + 0x1000)   /* Global Control Register	*/

All define must be in uppercase, you are mixing lower/upper case which is not encouraged.
Same remark below .

> +#define LVDS_PxCMCR1(phy)	((phy) + 0x100C)   /* Current Mode Control Register 1 */
> +#define LVDS_PxCMCR2(phy)	((phy) + 0x1010)  /* Current Mode Control Register 2 */
> +#define LVDS_PxSCR(phy)		((phy) + 0x1020)  /* Serial Control Register	*/
> +#define LVDS_PxBCR1(phy)	((phy) + 0x102C)  /* Bias Control Register 1	*/
> +#define LVDS_PxBCR2(phy)	((phy) + 0x1030)  /* Bias Control Register 2	*/
> +#define LVDS_PxBCR3(phy)	((phy) + 0x1034)  /* Bias Control Register 3	*/
> +#define LVDS_PxMPLCR(phy)	((phy) + 0x1064)  /* Monitor PLL Lock Control Register */
> +#define LVDS_PxDCR(phy)		((phy) + 0x1084)  /* Debug Control Register	*/
> +#define LVDS_PxSSR1(phy)	((phy) + 0x1088)  /* Spare Status Register 1	*/
> +#define LVDS_PxCFGCR(phy)	((phy) + 0x10A0)  /* Configuration Control Register */
> +#define LVDS_PxPLLCR1(phy)	((phy) + 0x10C0)  /* PLL_MODE 1 Control Register	*/
> +#define LVDS_PxPLLCR2(phy)	((phy) + 0x10C4)  /* PLL_MODE 2 Control Register	*/
> +#define LVDS_PxPLLSR(phy)	((phy) + 0x10C8)  /* PLL Status Register	*/
> +#define LVDS_PxPLLSDCR1(phy)	((phy) + 0x10CC)  /* PLL_SD_1 Control Register	*/
> +#define LVDS_PxPLLSDCR2(phy)	((phy) + 0x10D0)  /* PLL_SD_2 Control Register	*/
> +#define LVDS_PxPLLTWGCR1(phy)	((phy) + 0x10D4)  /* PLL_TWG_1 Control Register	*/
> +#define LVDS_PxPLLTWGCR2(phy)	((phy) + 0x10D8)  /* PLL_TWG_2 Control Register	*/
> +#define LVDS_PxPLLCPCR(phy)	((phy) + 0x10E0)  /* PLL_CP Control Register	*/
> +#define LVDS_PxPLLTESTCR(phy)	((phy) + 0x10E8)  /* PLL_TEST Control Register	*/
> +
> +/* LVDS Wrapper registers */
> +#define LVDS_WCLKCR	0x11B0  /* Wrapper clock control register */
> +#define LVDS_HWCFGR	0x1FF0  /* HW configuration register	*/
> +#define LVDS_VERR	0x1FF4  /* Version register	*/
> +#define LVDS_IPIDR	0x1FF8  /* Identification register	*/
> +#define LVDS_SIDR	0x1FFC  /* Size Identification register	*/
> +
> +#define CR_LVDSEN	BIT(0)  /* LVDS PHY Enable */
> +#define CR_HSPOL	BIT(1)  /* HS Polarity (horizontal sync) */
> +#define CR_VSPOL	BIT(2)  /* VS Polarity (vertical sync) */
> +#define CR_DEPOL	BIT(3)  /* DE Polarity (data enable) */
> +#define CR_CI		BIT(4)  /* Control Internal (software controlled bit) */
> +#define CR_LKMOD	BIT(5)  /* Link Mode, for both Links */
> +#define CR_LKPHA	BIT(6)  /* Link Phase, for both Links */
> +#define CR_LK1POL	GENMASK(20, 16)  /* Link-1 output Polarity */
> +#define CR_LK2POL	GENMASK(25, 21)  /* Link-2 output Polarity */
> +
> +#define DMMCRx_MAP0	GENMASK(4, 0)
> +#define DMMCRx_MAP1	GENMASK(9, 5)
> +#define DMMCRx_MAP2	GENMASK(14, 10)
> +#define DMMCRx_MAP3	GENMASK(19, 15)
> +#define DMLCRx_MAP4	GENMASK(4, 0)
> +#define DMLCRx_MAP5	GENMASK(9, 5)
> +#define DMLCRx_MAP6	GENMASK(14, 10)
> +
> +#define CDLCRx_DISTR0	GENMASK(3, 0)
> +#define CDLCRx_DISTR1	GENMASK(7, 4)
> +#define CDLCRx_DISTR2	GENMASK(11, 8)
> +#define CDLCRx_DISTR3	GENMASK(15, 12)
> +#define CDLCRx_DISTR4	GENMASK(19, 16)
> +
> +#define FREF_INDEX	0
> +#define NDIV_INDEX	1
> +#define FPFD_INDEX	2
> +#define MDIV_INDEX	3
> +#define FVCO_INDEX	4
> +#define BDIV_INDEX	5
> +#define FBIT_INDEX	6
> +#define FLS_INDEX	7
> +#define FDP_INDEX	8
> +
> +#define PHY_GCR_BIT_CLK_OUT	BIT(0)
> +#define PHY_GCR_LS_CLK_OUT	BIT(4)
> +#define PHY_GCR_DP_CLK_OUT	BIT(8)
> +#define PHY_GCR_RSTZ		BIT(24)
> +#define PHY_GCR_DIV_RSTN	BIT(25)
> +
> +#define PHY_PxPLLTESTCR_TDIV	GENMASK(25, 16)
> +#define PHY_PxPLLCR2_NDIV	GENMASK(25, 16)
> +#define PHY_PxPLLCR2_BDIV	GENMASK(9, 0)
> +#define PHY_PxPLLSDCR1_MDIV	GENMASK(9, 0)
> +
> +#define PLL_EN		BIT(0)
> +#define PLL_LOCK	BIT(0)
> +#define CM_EN_DL	(BIT(28) | BIT(20) | BIT(12) | BIT(4))
> +#define CM_EN_DL4	BIT(4)
> +#define VM_EN_DL	(BIT(16) | BIT(12) | BIT(8) | BIT(4) | BIT(0))
> +#define EN_BIAS_DL	(BIT(16) | BIT(12) | BIT(8) | BIT(4) | BIT(0))
> +#define EN_DIG_DL	GENMASK(4, 0)
> +#define BIAS_EN		BIT(28)
> +#define POWER_OK	BIT(12)
> +
> +#define WCLKCR_SLV_CLKPIX_SEL	BIT(0)
> +#define WCLKCR_SRCSEL		BIT(8)
> +
> +/* Sleep & timeout for pll lock/unlock */
> +#define SLEEP_US	1000
> +#define TIMEOUT_US	20000000
> +
> +#define PHY_SLV_OFS	0x100
> +
> +struct stm32_lvds {
> +	void __iomem *base;
> +	struct udevice *panel;
> +	u32 refclk;
> +	int dual_link;
> +	int bus_format;
> +};
> +
> +/*
> + * enum lvds_pixels_order - Pixel order of an LVDS connection
> + * @LVDS_DUAL_LINK_EVEN_ODD_PIXELS: Even pixels are expected to be generated
> + *    from the first port, odd pixels from the second port
> + * @LVDS_DUAL_LINK_ODD_EVEN_PIXELS: Odd pixels are expected to be generated
> + *    from the first port, even pixels from the second port
> + */
> +enum lvds_pixels_order {
> +	LVDS_DUAL_LINK_EVEN_ODD_PIXELS = BIT(0),
> +	LVDS_DUAL_LINK_ODD_EVEN_PIXELS = BIT(1),
> +};
> +
> +enum lvds_pixel {
> +	PIX_R_0		= 0x00,
> +	PIX_R_1		= 0x01,
> +	PIX_R_2		= 0x02,
> +	PIX_R_3		= 0x03,
> +	PIX_R_4		= 0x04,
> +	PIX_R_5		= 0x05,
> +	PIX_R_6		= 0x06,
> +	PIX_R_7		= 0x07,
> +	PIX_G_0		= 0x08,
> +	PIX_G_1		= 0x09,
> +	PIX_G_2		= 0x0A,
> +	PIX_G_3		= 0x0B,
> +	PIX_G_4		= 0x0C,
> +	PIX_G_5		= 0x0D,
> +	PIX_G_6		= 0x0E,
> +	PIX_G_7		= 0x0F,
> +	PIX_B_0		= 0x10,
> +	PIX_B_1		= 0x11,
> +	PIX_B_2		= 0x12,
> +	PIX_B_3		= 0x13,
> +	PIX_B_4		= 0x14,
> +	PIX_B_5		= 0x15,
> +	PIX_B_6		= 0x16,
> +	PIX_B_7		= 0x17,
> +	PIX_H_S		= 0x18,
> +	PIX_V_S		= 0x19,
> +	PIX_D_E		= 0x1A,
> +	PIX_C_E		= 0x1B,
> +	PIX_C_I		= 0x1C,
> +	PIX_TOG		= 0x1D,
> +	PIX_ONE		= 0x1E,
> +	PIX_ZER		= 0x1F,
> +};
> +
> +/*
> + * Expected JEIDA-RGB888 data to be sent in LSB format
> + *	    bit6 ............................bit0
> + */
> +const enum lvds_pixel lvds_bitmap_jeida_rgb888[5][7] = {
> +	{ PIX_ONE, PIX_ONE, PIX_ZER, PIX_ZER, PIX_ZER, PIX_ONE, PIX_ONE },
> +	{ PIX_G_2, PIX_R_7, PIX_R_6, PIX_R_5, PIX_R_4, PIX_R_3, PIX_R_2 },
> +	{ PIX_B_3, PIX_B_2, PIX_G_7, PIX_G_6, PIX_G_5, PIX_G_4, PIX_G_3 },
> +	{ PIX_D_E, PIX_V_S, PIX_H_S, PIX_B_7, PIX_B_6, PIX_B_5, PIX_B_4 },
> +	{ PIX_C_E, PIX_B_1, PIX_B_0, PIX_G_1, PIX_G_0, PIX_R_1, PIX_R_0 }
> +};
> +
> +/*
> + * Expected VESA-RGB888 data to be sent in LSB format
> + *	    bit6 ............................bit0
> + */
> +const enum lvds_pixel lvds_bitmap_vesa_rgb888[5][7] = {
> +	{ PIX_ONE, PIX_ONE, PIX_ZER, PIX_ZER, PIX_ZER, PIX_ONE, PIX_ONE },
> +	{ PIX_G_0, PIX_R_5, PIX_R_4, PIX_R_3, PIX_R_2, PIX_R_1, PIX_R_0 },
> +	{ PIX_B_1, PIX_B_0, PIX_G_5, PIX_G_4, PIX_G_3, PIX_G_2, PIX_G_1 },
> +	{ PIX_D_E, PIX_V_S, PIX_H_S, PIX_B_5, PIX_B_4, PIX_B_3, PIX_B_2 },
> +	{ PIX_C_E, PIX_B_7, PIX_B_6, PIX_G_7, PIX_G_6, PIX_R_7, PIX_R_6 }
> +};
> +
> +static inline void lvds_writel(struct stm32_lvds *lvds, u32 reg, u32 val)
> +{
> +	writel(val, lvds->base + reg);
> +}
> +
> +static inline u32 lvds_readl(struct stm32_lvds *lvds, u32 reg)
> +{
> +	return readl(lvds->base + reg);
> +}
> +
> +static inline void lvds_set(struct stm32_lvds *lvds, u32 reg, u32 mask)
> +{
> +	lvds_writel(lvds, reg, lvds_readl(lvds, reg) | mask);
> +}
> +
> +static inline void lvds_clear(struct stm32_lvds *lvds, u32 reg, u32 mask)
> +{
> +	lvds_writel(lvds, reg, lvds_readl(lvds, reg) & ~mask);
> +}
> +
> +/* Integer mode */
> +#define EN_SD		0
> +#define EN_TWG		0
> +#define DOWN_SPREAD	0
> +#define TEST_DIV	70

Put these defines with the others, above first function. 

> +
> +static u32 pll_get_clkout_khz(u32 clkin_khz, u32 bdiv, u32 mdiv, u32 ndiv)
> +{
> +	int divisor = ndiv * bdiv;
> +
> +	/* Prevents from division by 0 */
> +	if (!divisor)
> +		return 0;
> +
> +	return clkin_khz * mdiv / divisor;
> +}
> +
> +#define NDIV_MIN	2
> +#define NDIV_MAX	6
> +#define BDIV_MIN	2
> +#define BDIV_MAX	6
> +#define MDIV_MIN	1
> +#define MDIV_MAX	1023

ditto

> +
> +static int lvds_pll_get_params(u32 clkin_khz, u32 clkout_khz,
> +			       u32 *bdiv, u32 *mdiv, u32 *ndiv)
> +{
> +	u32 i, o, n;
> +	u32 delta, best_delta; /* all in khz */
> +
> +	/* Early checks preventing division by 0 & odd results */
> +	if (clkin_khz <= 0 || clkout_khz <= 0)

clkin_khz and clkout_khz are unsigned, so can't be negative. 

if (clkin_khz = 0 || clkout_khz = 0)  should be engouh 

> +		return -EINVAL;
> +
> +	best_delta = 1000000; /* big started value (1000000khz) */
> +
> +	for (i = NDIV_MIN; i <= NDIV_MAX; i++) {
> +		for (o = BDIV_MIN; o <= BDIV_MAX; o++) {
> +			n = DIV_ROUND_CLOSEST(i * o * clkout_khz, clkin_khz);
> +			/* Check ndiv according to vco range */
> +			if (n < MDIV_MIN || n > MDIV_MAX)
> +				continue;
> +			/* Check if new delta is better & saves parameters */
> +			delta = abs(pll_get_clkout_khz(clkin_khz, i, n, o) - clkout_khz);
> +			if (delta < best_delta) {
> +				*ndiv = i;
> +				*mdiv = n;
> +				*bdiv = o;
> +				best_delta = delta;
> +			}
> +			/* fast return in case of "perfect result" */
> +			if (!delta)
> +				return 0;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int stm32_lvds_pll_enable(struct stm32_lvds *lvds,
> +				 struct display_timing *timings,
> +				 int phy)
> +{
> +	u32 pll_in_khz, bdiv = 0, mdiv = 0, ndiv = 0;
> +	int ret, val, multiplier;
> +
> +	/* Release PHY from reset */
> +	lvds_set(lvds, LVDS_PxGCR(phy), PHY_GCR_DIV_RSTN | PHY_GCR_RSTZ);
> +
> +	/* lvds_pll_config */
> +	/* Set PLL Slv & Mst configs and timings */
> +	pll_in_khz = lvds->refclk / 1000;
> +
> +	if (lvds->dual_link)
> +		multiplier = 2;
> +	else
> +		multiplier = 1;
> +
> +	ret = lvds_pll_get_params(pll_in_khz, timings->pixelclock.typ * 7 / 1000 / multiplier,
> +				  &bdiv, &mdiv, &ndiv);
> +	if (ret)
> +		return ret;
> +
> +	/* Set PLL parameters */
> +	lvds_writel(lvds, LVDS_PxPLLCR2(phy), (ndiv << 16) | bdiv);
> +	lvds_writel(lvds, LVDS_PxPLLSDCR1(phy), mdiv);
> +	lvds_writel(lvds, LVDS_PxPLLTESTCR(phy), TEST_DIV << 16);
> +
> +	/* Disable TWG and SD: for now, PLL just need to be in integer mode */
> +	lvds_clear(lvds, LVDS_PxPLLCR1(phy), EN_TWG | EN_SD);
> +
> +	/* Power up bias and PLL dividers */
> +	lvds_set(lvds, LVDS_PxDCR(phy), POWER_OK);
> +
> +	lvds_set(lvds, LVDS_PxCMCR1(phy), CM_EN_DL);
> +	lvds_set(lvds, LVDS_PxCMCR2(phy), CM_EN_DL4);
> +
> +	lvds_set(lvds, LVDS_PxPLLCPCR(phy), 0x1);

Add a define to replace 0x1, for example #defince PLL_CHARGE_PUMP_CONTROL_DEFAULT 0x1 ?

> +	lvds_set(lvds, LVDS_PxBCR3(phy), VM_EN_DL);
> +	lvds_set(lvds, LVDS_PxBCR1(phy), EN_BIAS_DL);
> +	lvds_set(lvds, LVDS_PxCFGCR(phy), EN_DIG_DL);
> +
> +	/* lvds_pll_enable */
> +	/* PLL lock timing control for the monitor unmask after startup (pll_en) */
> +	/* Adjust the value so that the masking window is opened at start-up */
> +	/* MST_MON_PLL_LOCK_UNMASK_TUNE */
> +	lvds_writel(lvds, LVDS_PxMPLCR(phy), (0x200 - 0x160) << 16);

What are 0x200 and 0x160 ? add a define with a meaningful name for each of these value.

> +
> +	lvds_writel(lvds, LVDS_PxBCR2(phy), BIAS_EN);
> +
> +	lvds_set(lvds, LVDS_PxGCR(phy),
> +		 PHY_GCR_DP_CLK_OUT | PHY_GCR_LS_CLK_OUT | PHY_GCR_BIT_CLK_OUT);
> +
> +	/* TODO hardcoded values for now */
> +	lvds_set(lvds, LVDS_PxPLLTESTCR(phy), BIT(8) /* PLL_TEST_DIV_EN */);

Why hardcoded value for now ? simply add a define PLL_TEST_DIV_EN BIT(8) ?

> +	lvds_set(lvds, LVDS_PxPLLCR1(phy), BIT(8) /* PLL_DIVIDERS_ENABLE */);

ditto

> +
> +	lvds_set(lvds, LVDS_PxSCR(phy), BIT(16) /* SER_DATA_OK */);

ditto

> +
> +	/* Enable the LVDS PLL & wait for its lock */
> +	lvds_set(lvds, LVDS_PxPLLCR1(phy), PLL_EN);
> +	ret = readl_poll_sleep_timeout(lvds->base + LVDS_PxPLLSR(phy),
> +				       val, val & PLL_LOCK, SLEEP_US, TIMEOUT_US);
> +	if (ret)
> +		return ret;
> +
> +	/* Select MST PHY clock as pixel clock for the LDITX instead of FREF */
> +	/* WCLKCR_SLV_CLKPIX_SEL is for dual link */
> +	lvds_writel(lvds, LVDS_WCLKCR, WCLKCR_SLV_CLKPIX_SEL);
> +
> +	lvds_set(lvds, LVDS_PxPLLTESTCR(phy), BIT(0));

add #define PLL_TEST_CLK_EN BIT(0) instead ?

lvds_set(lvds, LVDS_PxPLLTESTCR(phy), PLL_TEST_CLK_EN);


> +
> +	return 0;
> +}
> +
> +static int stm32_lvds_enable(struct udevice *dev,
> +			     const struct display_timing *timings)
> +{
> +	struct stm32_lvds *lvds = dev_get_priv(dev);
> +	u32 lvds_cdl1cr = 0;
> +	u32 lvds_cdl2cr = 0;
> +	u32 lvds_dmlcr = 0;
> +	u32 lvds_dmmcr = 0;
> +	u32 lvds_cr = 0;
> +	int i;
> +
> +	lvds_clear(lvds, LVDS_CDL1CR, CDLCRx_DISTR0 | CDLCRx_DISTR1 | CDLCRx_DISTR2
> +					| CDLCRx_DISTR3 | CDLCRx_DISTR4);
> +	lvds_clear(lvds, LVDS_CDL2CR, CDLCRx_DISTR0 | CDLCRx_DISTR1 | CDLCRx_DISTR2
> +					| CDLCRx_DISTR3 | CDLCRx_DISTR4);
> +
> +	/* Set channel distribution */
> +	lvds_cr &= ~CR_LKMOD;
> +	lvds_cdl1cr = CDL1CR_DEFAULT;
> +
> +	if (lvds->dual_link) {
> +		lvds_cr |= CR_LKMOD;
> +		lvds_cdl2cr = CDL2CR_DEFAULT;
> +	}
> +
> +	/* Set signal polarity */
> +	if (timings->flags & DISPLAY_FLAGS_DE_LOW)
> +		lvds_cr |= CR_DEPOL;
> +
> +	if (timings->flags & DISPLAY_FLAGS_HSYNC_LOW)
> +		lvds_cr |= CR_HSPOL;
> +
> +	if (timings->flags & DISPLAY_FLAGS_VSYNC_LOW)
> +		lvds_cr |= CR_VSPOL;
> +
> +	/* Set link phase */
> +	switch (lvds->dual_link) {
> +	case LVDS_DUAL_LINK_EVEN_ODD_PIXELS: /* LKPHA = 0 */
> +		lvds_cr &= ~CR_LKPHA;
> +		break;
> +	case LVDS_DUAL_LINK_ODD_EVEN_PIXELS: /* LKPHA = 1 */
> +		lvds_cr |= CR_LKPHA;
> +		break;
> +	default:
> +		dev_dbg(dev, "No phase precised, setting default\n");
> +		lvds_cr &= ~CR_LKPHA;
> +		break;
> +	}
> +
> +	/* Set Data Mapping */
> +	switch (lvds->bus_format) {
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG: /* VESA-RGB888 */
> +		for (i = 0; i < 5; i++) {
> +			lvds_dmlcr = ((lvds_bitmap_vesa_rgb888[i][0])
> +				      + (lvds_bitmap_vesa_rgb888[i][1] << 5)
> +				      + (lvds_bitmap_vesa_rgb888[i][2] << 10)
> +				      + (lvds_bitmap_vesa_rgb888[i][3] << 15));
> +			lvds_dmmcr = ((lvds_bitmap_vesa_rgb888[i][4])
> +				      + (lvds_bitmap_vesa_rgb888[i][5] << 5)
> +				      + (lvds_bitmap_vesa_rgb888[i][6] << 10));
> +
> +			/* Write registers at the end of computations */
> +			lvds_writel(lvds, LVDS_DMLCR(i), lvds_dmlcr);
> +			lvds_writel(lvds, LVDS_DMMCR(i), lvds_dmmcr);
> +		}
> +		break;
> +	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA: /* JEIDA-RGB888 */
> +		for (i = 0; i < 5; i++) {
> +			lvds_dmlcr = ((lvds_bitmap_jeida_rgb888[i][0])
> +				      + (lvds_bitmap_jeida_rgb888[i][1] << 5)
> +				      + (lvds_bitmap_jeida_rgb888[i][2] << 10)
> +				      + (lvds_bitmap_jeida_rgb888[i][3] << 15));
> +			lvds_dmmcr = ((lvds_bitmap_jeida_rgb888[i][4])
> +				      + (lvds_bitmap_jeida_rgb888[i][5] << 5)
> +				      + (lvds_bitmap_jeida_rgb888[i][6] << 10));
> +
> +			/* Write registers at the end of computations */
> +			lvds_writel(lvds, LVDS_DMLCR(i), lvds_dmlcr);
> +			lvds_writel(lvds, LVDS_DMMCR(i), lvds_dmmcr);
> +		}
> +		break;
> +	default:
> +		dev_dbg(dev, "Unsupported LVDS bus format 0x%04x\n", lvds->bus_format);
> +	}
> +
> +	/* Turn the output on */
> +	lvds_cr |= CR_LVDSEN;
> +
> +	/* Commit config to registers */
> +	lvds_set(lvds, LVDS_CR, lvds_cr);
> +	lvds_writel(lvds, LVDS_CDL1CR, lvds_cdl1cr);
> +	lvds_writel(lvds, LVDS_CDL2CR, lvds_cdl2cr);
> +
> +	return 0;
> +}
> +
> +static int stm32_lvds_attach(struct udevice *dev)
> +{
> +	struct stm32_lvds *lvds = dev_get_priv(dev);
> +	struct display_timing timings;
> +	int ret;
> +
> +	ret = panel_get_display_timing(lvds->panel, &timings);
> +	if (ret) {
> +		ret = ofnode_decode_display_timing(dev_ofnode(lvds->panel),
> +						   0, &timings);
> +		if (ret) {
> +			dev_err(dev, "decode display timing error %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = stm32_lvds_enable(dev, &timings);
> +
> +	return ret;
> +}
> +
> +static int stm32_lvds_set_backlight(struct udevice *dev, int percent)
> +{
> +	struct stm32_lvds *lvds = dev_get_priv(dev);
> +	int ret;
> +
> +	ret = panel_enable_backlight(lvds->panel);
> +	if (ret) {
> +		dev_err(dev, "panel %s enable backlight error %d\n",
> +			lvds->panel->name, ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static int lvds_handle_pixel_order(struct stm32_lvds *lvds)
> +{
> +	ofnode parent, panel_port0, panel_port1;
> +	bool even_pixels, odd_pixels;
> +	int port0, port1;
> +
> +	/*
> +	 * In case we are operating in single link,
> +	 * there is only one port linked to the LVDS.
> +	 * Check whether we are in this case and exit if yes.
> +	 */
> +	parent = ofnode_find_subnode(dev_ofnode(lvds->panel), "ports");
> +	if (!ofnode_valid(parent))
> +		return 0;
> +
> +	panel_port0 = ofnode_first_subnode(parent);
> +	if (!ofnode_valid(panel_port0))
> +		return -EPIPE;
> +
> +	even_pixels = ofnode_read_bool(panel_port0, "dual-lvds-even-pixels");
> +	odd_pixels = ofnode_read_bool(panel_port0, "dual-lvds-odd-pixels");
> +	if (even_pixels && odd_pixels)
> +		return -EINVAL;
> +
> +	port0 = even_pixels ? LVDS_DUAL_LINK_EVEN_ODD_PIXELS :
> +		LVDS_DUAL_LINK_ODD_EVEN_PIXELS;
> +
> +	panel_port1 = ofnode_next_subnode(panel_port0);
> +	if (!ofnode_valid(panel_port1))
> +		return -EPIPE;
> +
> +	even_pixels = ofnode_read_bool(panel_port1, "dual-lvds-even-pixels");
> +	odd_pixels = ofnode_read_bool(panel_port1, "dual-lvds-odd-pixels");
> +	if (even_pixels && odd_pixels)
> +		return -EINVAL;
> +
> +	port1 = even_pixels ? LVDS_DUAL_LINK_EVEN_ODD_PIXELS :
> +		LVDS_DUAL_LINK_ODD_EVEN_PIXELS;
> +
> +	/*
> +	 * A valid dual-LVDS bus is found when one port is marked with
> +	 * "dual-lvds-even-pixels", and the other port is marked with
> +	 * "dual-lvds-odd-pixels", bail out if the markers are not right.
> +	 */
> +	if (port0 + port1 != LVDS_DUAL_LINK_EVEN_ODD_PIXELS + LVDS_DUAL_LINK_ODD_EVEN_PIXELS)
> +		return -EINVAL;
> +
> +	return port0;
> +}
> +
> +static int stm32_lvds_probe(struct udevice *dev)
> +{
> +	struct stm32_lvds *priv = dev_get_priv(dev);
> +	struct display_timing timings;
> +	struct reset_ctl rst;
> +	struct clk pclk, refclk;
> +	const char *data_mapping;
> +	int ret;
> +
> +	priv->base = dev_read_addr_ptr(dev);
> +	if ((fdt_addr_t)priv->base == FDT_ADDR_T_NONE) {
> +		dev_err(dev, "Unable to read LVDS base address\n");
> +		return -EINVAL;
> +	}
> +

Device tree resources reading must be located in an of_to_plat() function, not in probe().
See for example, see ./drivers/spi/stm32_spi.c

For reference : https://docs.u-boot.org/en/stable/develop/driver-model/design.html#reading-ofdata



> +	ret = clk_get_by_name(dev, "pclk", &pclk);
> +	if (ret) {
> +		dev_err(dev, "Unable to get peripheral clock: %d\n", ret);
> +		return ret;

ditto

> +	}
> +
> +	ret = clk_enable(&pclk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable peripheral clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_get_by_name(dev, "ref", &refclk);
> +	if (ret) {
> +		dev_err(dev, "Unable to get reference clock: %d\n", ret);
> +		goto err_clk;
> +	}

ditto

> +
> +	ret = clk_enable(&refclk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable reference clock: %d\n", ret);
> +		goto err_clk;
> +	}
> +
> +	priv->refclk = (unsigned int)clk_get_rate(&refclk);
> +
> +	ret = reset_get_by_index(dev, 0, &rst);
> +	if (ret) {
> +		dev_err(dev, "Failed to get LVDS reset: %d\n", ret);
> +		goto err_rst;
> +	}
> +

ditto

> +	reset_deassert(&rst);
> +
> +	ret = uclass_get_device_by_driver(UCLASS_PANEL,
> +					  DM_DRIVER_GET(simple_panel), &priv->panel);
> +	if (ret) {
> +		dev_err(dev, "panel device error %d\n", ret);
> +		goto err_rst;
> +	}

ditto
> +
> +	ret = panel_get_display_timing(priv->panel, &timings);
> +	if (ret) {
> +		ret = ofnode_decode_display_timing(dev_ofnode(priv->panel),
> +						   0, &timings);
> +		if (ret) {
> +			dev_err(dev, "decode display timing error %d\n", ret);
> +			goto err_rst;
> +		}
> +	}
> +

ditto 

> +	data_mapping = ofnode_read_string(dev_ofnode(priv->panel), "data-mapping");
> +	if (!strcmp(data_mapping, "vesa-24"))
> +		priv->bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG;
> +	else if (!strcmp(data_mapping, "jeida-24"))
> +		priv->bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA;
> +	else
> +		priv->bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG;

ditto

> +
> +	/* Handle dual link config */
> +	priv->dual_link = lvds_handle_pixel_order(priv);
> +	if (priv->dual_link < 0)
> +		goto err_rst;
> +
> +	if (priv->dual_link > 0) {
> +		ret = stm32_lvds_pll_enable(priv, &timings, LVDS_PHY_SLAVE);
> +		if (ret)
> +			goto err_rst;
> +	}
> +
> +	ret = stm32_lvds_pll_enable(priv, &timings, LVDS_PHY_MASTER);
> +	if (ret)
> +		goto err_rst;
> +
> +	return 0;
> +
> +err_rst:
> +	clk_disable(&refclk);
> +err_clk:
> +	clk_disable(&pclk);
> +
> +	return ret;
> +}
> +
> +static const struct video_bridge_ops stm32_lvds_ops = {
> +	.attach = stm32_lvds_attach,
> +	.set_backlight = stm32_lvds_set_backlight,
> +};
> +
> +static const struct udevice_id stm32_lvds_ids[] = {
> +	{.compatible = "st,stm32mp25-lvds"},
> +	{}
> +};
> +
> +U_BOOT_DRIVER(stm32_lvds) = {
> +	.name		= "stm32-display-lvds",
> +	.id		= UCLASS_VIDEO_BRIDGE,
> +	.of_match	= stm32_lvds_ids,
> +	.ops		= &stm32_lvds_ops,
> +	.probe		= stm32_lvds_probe,
> +	.priv_auto	= sizeof(struct stm32_lvds),
> +};
> 
