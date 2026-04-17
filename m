Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E2FF436B8
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 15:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D90B284258;
	Fri, 17 Apr 2026 17:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ecUxBd/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E40D384286; Fri, 17 Apr 2026 17:44:53 +0200 (CEST)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [IPv6:2a01:4f8:201:9162::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FF6384246
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 17:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arnaud.ferraris@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1776440690;
 bh=VIqQ4w8hO5+TeBIodSY3jMWkZ0QZFwa+5IaoQtdCTk8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ecUxBd/u7822kCt3oak2hItGYzALDXFvmvALediM9igyXXWu2MUT58dL06rbMGU28
 5WonLEM3kNpm1xlsf5KJFX1g0tWdIHUqGVTN+to31fUNzj2ftdoHvBH2tePm15iNHY
 xut8DUDhknXviyDQmhT1PobXlR2/ofDlssNpTXizuLXRl0iRjX5hyk8fsLJa1d+0CK
 OvwmU8j3L2mytJNkO5CD6aqtfUAL6LVElAj+ZAlZA4cC4N50zh2DFh94ULDO9c0Bgf
 CTDymyz27JjlP20AJDr4GaRsDFsiuRDb0OWcjPAJbHTML1gZmmFLwyxnRmJcqqplb5
 tQWRz9BLGCqZA==
Received: from [100.64.1.83] (unknown [100.64.1.83])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: aferraris)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3F47117E1317;
 Fri, 17 Apr 2026 17:44:50 +0200 (CEST)
Message-ID: <61e06e0d-0968-491d-90df-86a69f3c5978@collabora.com>
Date: Fri, 17 Apr 2026 17:44:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] phy: mediatek: new XS-PHY driver
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
References: <20260401-mtk-mt8189-usb-v1-0-a4bf951aa8ad@baylibre.com>
 <20260401-mtk-mt8189-usb-v1-1-a4bf951aa8ad@baylibre.com>
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Content-Language: en-US, fr
Autocrypt: addr=arnaud.ferraris@collabora.com; keydata=
 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
 L9jD4jU=
In-Reply-To: <20260401-mtk-mt8189-usb-v1-1-a4bf951aa8ad@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi David,

Le 01/04/2026 à 23:53, David Lechner a écrit :
> Add a new driver for the Mediatek XS-PHY. This is found on some newer
> Mediatek SoCs.
> 
> Upstream devicetree bindings already exist. MAINTAINERS is already
> covered by drivers/phy/phy-mtk-*.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>   drivers/phy/Kconfig         |  11 +
>   drivers/phy/Makefile        |   1 +
>   drivers/phy/phy-mtk-xsphy.c | 600 ++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 612 insertions(+)
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 09810b62b51..fc4daa00661 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -292,6 +292,17 @@ config PHY_MTK_UFS
>   	  initialization, power on and power off flow of
>   	  specified M-PHYs.
>   
> +config PHY_MTK_XSPHY
> +	bool "MediaTek XS-PHY Driver"
> +	depends on PHY
> +	depends on ARCH_MEDIATEK
> +	select REGMAP
> +	select SYSCON
> +	help
> +	  Enable this to support the SuperSpeedPlus XS-PHY transceiver for
> +	  USB3.1 GEN2 controllers on MediaTek chips. The driver supports
> +	  multiple USB2.0, USB3.1 GEN2 ports.
> +
>   config PHY_NPCM_USB
>   	bool "Nuvoton NPCM USB PHY support"
>   	depends on PHY
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 83102349669..684e9a99af8 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_PHY_DA8XX_USB) += phy-da8xx-usb.o
>   obj-$(CONFIG_PHY_EXYNOS_USBDRD) += phy-exynos-usbdrd.o
>   obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
>   obj-$(CONFIG_PHY_MTK_UFS) += phy-mtk-ufs.o
> +obj-$(CONFIG_PHY_MTK_XSPHY) += phy-mtk-xsphy.o
>   obj-$(CONFIG_PHY_NPCM_USB) += phy-npcm-usb.o
>   obj-$(CONFIG_$(PHASE_)PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
>   obj-$(CONFIG_PHY_IMX8M_PCIE) += phy-imx8m-pcie.o
> diff --git a/drivers/phy/phy-mtk-xsphy.c b/drivers/phy/phy-mtk-xsphy.c
> new file mode 100644
> index 00000000000..d3418ffb101
> --- /dev/null
> +++ b/drivers/phy/phy-mtk-xsphy.c
> @@ -0,0 +1,600 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MediaTek USB3.1 gen2 xsphy Driver
> + *
> + * Copyright (c) 2026 MediaTek Inc.
> + * Copyright (c) 2026 BayLibre, SAS
> + *
> + * Based on Linux mtk-xsphy driver:
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
> + *
> + * And U-Boot mtk-tphy driver:
> + * Copyright (c) 2015 - 2019 MediaTek Inc.
> + * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
> + *	   Ryder Lee <ryder.lee@mediatek.com>
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <generic-phy.h>
> +#include <malloc.h>
> +#include <mapmem.h>
> +#include <regmap.h>
> +#include <syscon.h>
> +
> +#include <asm/io.h>
> +#include <dm/device_compat.h>
> +#include <dm/devres.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +
> +#include <dt-bindings/phy/phy.h>
> +
> +/* u2 phy banks */
> +#define SSUSB_SIFSLV_MISC		0x000
> +#define SSUSB_SIFSLV_U2FREQ		0x100
> +#define SSUSB_SIFSLV_U2PHY_COM		0x300
> +
> +/* u3 phy shared banks */
> +#define SSPXTP_SIFSLV_DIG_GLB		0x000
> +#define SSPXTP_SIFSLV_PHYA_GLB		0x100
> +
> +/* u3 phy banks */
> +#define SSPXTP_SIFSLV_DIG_LN_TOP	0x000
> +#define SSPXTP_SIFSLV_DIG_LN_TX0	0x100
> +#define SSPXTP_SIFSLV_DIG_LN_RX0	0x200
> +#define SSPXTP_SIFSLV_DIG_LN_DAIF	0x300
> +#define SSPXTP_SIFSLV_PHYA_LN		0x400
> +
> +#define XSP_U2FREQ_FMCR0	((SSUSB_SIFSLV_U2FREQ) + 0x00)
> +#define P2F_RG_FREQDET_EN		BIT(24)
> +#define P2F_RG_CYCLECNT			GENMASK(23, 0)
> +
> +#define XSP_U2FREQ_MMONR0	((SSUSB_SIFSLV_U2FREQ) + 0x0c)
> +
> +#define XSP_U2FREQ_FMMONR1	((SSUSB_SIFSLV_U2FREQ) + 0x10)
> +#define P2F_RG_FRCK_EN			BIT(8)
> +#define P2F_USB_FM_VALID		BIT(0)
> +
> +#define XSP_USBPHYACR0		((SSUSB_SIFSLV_U2PHY_COM) + 0x00)
> +#define P2A0_RG_INTR_EN			BIT(5)
> +
> +#define XSP_USBPHYACR1		((SSUSB_SIFSLV_U2PHY_COM) + 0x04)
> +#define P2A1_RG_INTR_CAL		GENMASK(23, 19)
> +#define P2A1_RG_VRT_SEL			GENMASK(14, 12)
> +#define P2A1_RG_TERM_SEL		GENMASK(10, 8)
> +
> +#define XSP_USBPHYACR5		((SSUSB_SIFSLV_U2PHY_COM) + 0x014)
> +#define P2A5_RG_HSTX_SRCAL_EN		BIT(15)
> +#define P2A5_RG_HSTX_SRCTRL		GENMASK(14, 12)
> +
> +#define XSP_USBPHYACR6		((SSUSB_SIFSLV_U2PHY_COM) + 0x018)
> +#define P2A6_RG_BC11_SW_EN		BIT(23)
> +#define P2A6_RG_OTG_VBUSCMP_EN		BIT(20)
> +
> +#define XSP_U2PHYDTM1		((SSUSB_SIFSLV_U2PHY_COM) + 0x06C)
> +#define P2D_FORCE_IDDIG			BIT(9)
> +#define P2D_RG_VBUSVALID		BIT(5)
> +#define P2D_RG_SESSEND			BIT(4)
> +#define P2D_RG_AVALID			BIT(2)
> +#define P2D_RG_IDDIG			BIT(1)
> +
> +#define SSPXTP_PHYA_GLB_00	((SSPXTP_SIFSLV_PHYA_GLB) + 0x00)
> +#define RG_XTP_GLB_BIAS_INTR_CTRL	GENMASK(21, 16)
> +
> +#define SSPXTP_PHYA_LN_04	((SSPXTP_SIFSLV_PHYA_LN) + 0x04)
> +#define RG_XTP_LN0_TX_IMPSEL		GENMASK(4, 0)
> +
> +#define SSPXTP_PHYA_LN_14	((SSPXTP_SIFSLV_PHYA_LN) + 0x014)
> +#define RG_XTP_LN0_RX_IMPSEL		GENMASK(4, 0)
> +
> +#define XSP_REF_CLK_MHZ		26
> +#define XSP_SLEW_RATE_COEF	17
> +#define XSP_SR_COEF_DIVISOR	1000
> +#define XSP_FM_DET_CYCLE_CNT	1024
> +
> +/* PHY switch between pcie/usb3/sgmii */
> +#define USB_PHY_SWITCH_CTRL	0x0
> +#define RG_PHY_SW_TYPE		GENMASK(3, 0)
> +#define RG_PHY_SW_PCIE		0x0
> +#define RG_PHY_SW_USB3		0x1
> +#define RG_PHY_SW_SGMII		0x2
> +
> +struct mtk_xsphy_instance {
> +	void __iomem *port_base;
> +	struct device_node *np;
> +	struct clk ref_clk;	/* reference clock of analog phy */
> +	u32 index;
> +	u32 type;
> +	struct regmap *type_sw;
> +	u32 type_sw_reg;
> +	u32 type_sw_index;
> +	/* only for HQA test */
> +	u32 efuse_intr;
> +	u32 efuse_tx_imp;
> +	u32 efuse_rx_imp;
> +	/* u2 eye diagram */
> +	u32 eye_src;
> +	u32 eye_vrt;
> +	u32 eye_term;
> +};
> +
> +struct mtk_xsphy {
> +	struct udevice *dev;
> +	void __iomem *sif_base;
> +	struct mtk_xsphy_instance **phys;
> +	u32 nphys;
> +	u32 src_ref_clk_mhz; /* reference clock for slew rate calibrate */
> +	u32 src_coef; /* coefficient for slew rate calibrate */
> +};
> +
> +static void mtk_xsphy_u2_slew_rate_calibrate(struct mtk_xsphy *xsphy,
> +					     struct mtk_xsphy_instance *instance)
> +{
> +	void __iomem *pbase = instance->port_base;
> +	u32 calib_val;
> +	u32 fm_out;
> +	u32 tmp;
> +
> +	/* use force value */
> +	if (instance->eye_src)
> +		return;
> +
> +	/* enable USB ring oscillator */
> +	setbits_le32(pbase + XSP_USBPHYACR5, P2A5_RG_HSTX_SRCAL_EN);
> +	/* wait for clock to become stable */
> +	udelay(1);
> +
> +	/* enable free run clock */
> +	setbits_le32(pbase + XSP_U2FREQ_FMMONR1, P2F_RG_FRCK_EN);
> +
> +	/* set cycle count as 1024 */
> +	clrsetbits_le32(pbase + XSP_U2FREQ_FMCR0, P2F_RG_CYCLECNT,
> +			FIELD_PREP(P2F_RG_CYCLECNT, XSP_FM_DET_CYCLE_CNT));
> +
> +	/* enable frequency meter */
> +	setbits_le32(pbase + XSP_U2FREQ_FMCR0, P2F_RG_FREQDET_EN);
> +
> +	/* ignore return value */
> +	readl_poll_sleep_timeout(pbase + XSP_U2FREQ_FMMONR1, tmp,
> +				 (tmp & P2F_USB_FM_VALID), 10, 200);
> +
> +	fm_out = readl(pbase + XSP_U2FREQ_MMONR0);
> +
> +	/* disable frequency meter */
> +	clrbits_le32(pbase + XSP_U2FREQ_FMCR0, P2F_RG_FREQDET_EN);
> +
> +	/* disable free run clock */
> +	clrbits_le32(pbase + XSP_U2FREQ_FMMONR1, P2F_RG_FRCK_EN);
> +
> +	if (fm_out) {
> +		/* (1024 / FM_OUT) x reference clock frequency x coefficient */
> +		tmp = xsphy->src_ref_clk_mhz * xsphy->src_coef;
> +		tmp = (tmp * XSP_FM_DET_CYCLE_CNT) / fm_out;
> +		calib_val = DIV_ROUND_CLOSEST(tmp, XSP_SR_COEF_DIVISOR);
> +	} else {
> +		/* if FM detection fail, set default value */
> +		calib_val = 3;
> +	}
> +	dev_dbg(xsphy->dev, "phy.%u, fm_out:%u, calib:%u (clk:%u, coef:%u)\n",
> +		instance->index, fm_out, calib_val, xsphy->src_ref_clk_mhz,
> +		xsphy->src_coef);
> +
> +	/* set HS slew rate */
> +	clrsetbits_le32(pbase + XSP_USBPHYACR5, P2A5_RG_HSTX_SRCTRL,
> +			FIELD_PREP(P2A5_RG_HSTX_SRCTRL, calib_val));
> +
> +	/* disable USB ring oscillator */
> +	clrbits_le32(pbase + XSP_USBPHYACR5, P2A5_RG_HSTX_SRCAL_EN);
> +}
> +
> +static void mtk_xsphy_u2_instance_init(struct mtk_xsphy *xsphy,
> +				       struct mtk_xsphy_instance *instance)
> +{
> +	void __iomem *pbase = instance->port_base;
> +
> +	/* DP/DM BC1.1 path Disable */
> +	clrbits_le32(pbase + XSP_USBPHYACR6, P2A6_RG_BC11_SW_EN);
> +
> +	setbits_le32(pbase + XSP_USBPHYACR0, P2A0_RG_INTR_EN);
> +}
> +
> +static void mtk_xsphy_u2_instance_power_on(struct mtk_xsphy *xsphy,
> +					   struct mtk_xsphy_instance *instance)
> +{
> +	void __iomem *pbase = instance->port_base;
> +
> +	setbits_le32(pbase + XSP_USBPHYACR6, P2A6_RG_OTG_VBUSCMP_EN);
> +
> +	clrsetbits_le32(pbase + XSP_U2PHYDTM1,
> +			P2D_RG_VBUSVALID | P2D_RG_AVALID | P2D_RG_SESSEND,
> +			P2D_RG_VBUSVALID | P2D_RG_AVALID);
> +
> +	dev_dbg(xsphy->dev, "%s(%u)\n", __func__, instance->index);
> +}
> +
> +static void mtk_xsphy_u2_instance_power_off(struct mtk_xsphy *xsphy,
> +					    struct mtk_xsphy_instance *instance)
> +{
> +	void __iomem *pbase = instance->port_base;
> +
> +	clrbits_le32(pbase + XSP_USBPHYACR6, P2A6_RG_OTG_VBUSCMP_EN);
> +
> +	clrsetbits_le32(pbase + XSP_U2PHYDTM1,
> +			P2D_RG_VBUSVALID | P2D_RG_AVALID | P2D_RG_SESSEND,
> +			P2D_RG_SESSEND);
> +
> +	dev_dbg(xsphy->dev, "%s(%u)\n", __func__, instance->index);
> +}
> +
> +static void mtk_xsphy_u2_instance_set_mode(struct mtk_xsphy *xsphy,
> +					   struct mtk_xsphy_instance *instance,
> +					   enum phy_mode mode)
> +{
> +	u32 tmp;
> +
> +	tmp = readl(instance->port_base + XSP_U2PHYDTM1);
> +
> +	switch (mode) {
> +	case PHY_MODE_USB_DEVICE:
> +		tmp |= P2D_FORCE_IDDIG | P2D_RG_IDDIG;
> +		break;
> +	case PHY_MODE_USB_HOST:
> +		tmp |= P2D_FORCE_IDDIG;
> +		tmp &= ~P2D_RG_IDDIG;
> +		break;
> +	case PHY_MODE_USB_OTG:
> +		tmp &= ~(P2D_FORCE_IDDIG | P2D_RG_IDDIG);
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	writel(tmp, instance->port_base + XSP_U2PHYDTM1);
> +}
> +
> +static void mtk_xsphy_parse_property(struct mtk_xsphy *xsphy,
> +				     struct mtk_xsphy_instance *instance)
> +{
> +	ofnode node = np_to_ofnode(instance->np);
> +
> +	switch (instance->type) {
> +	case PHY_TYPE_USB2:
> +		ofnode_read_u32(node, "mediatek,efuse-intr", &instance->efuse_intr);
> +		ofnode_read_u32(node, "mediatek,eye-src", &instance->eye_src);
> +		ofnode_read_u32(node, "mediatek,eye-vrt", &instance->eye_vrt);
> +		ofnode_read_u32(node, "mediatek,eye-term", &instance->eye_term);
> +
> +		dev_dbg(xsphy->dev, "intr:%u, src:%u, vrt:%u, term:%u\n",
> +			instance->efuse_intr, instance->eye_src,
> +			instance->eye_vrt, instance->eye_term);
> +		return;
> +	case PHY_TYPE_USB3:
> +		ofnode_read_u32(node, "mediatek,efuse-intr", &instance->efuse_intr);
> +		ofnode_read_u32(node, "mediatek,efuse-tx-imp", &instance->efuse_tx_imp);
> +		ofnode_read_u32(node, "mediatek,efuse-rx-imp", &instance->efuse_rx_imp);
> +
> +		dev_dbg(xsphy->dev, "intr:%u, tx-imp:%u, rx-imp:%u\n",
> +			instance->efuse_intr, instance->efuse_tx_imp,
> +			instance->efuse_rx_imp);
> +		return;
> +	case PHY_TYPE_PCIE:
> +	case PHY_TYPE_SGMII:
> +		/* nothing to do */
> +		return;
> +	default:
> +		dev_err(xsphy->dev, "incompatible PHY type\n");
> +		return;
> +	}
> +}
> +
> +static void mtk_xsphy_u2_props_set(struct mtk_xsphy *xsphy,
> +				   struct mtk_xsphy_instance *instance)
> +{
> +	void __iomem *pbase = instance->port_base;
> +
> +	if (instance->efuse_intr)
> +		clrsetbits_le32(pbase + XSP_USBPHYACR1, P2A1_RG_INTR_CAL,
> +				FIELD_PREP(P2A1_RG_INTR_CAL, instance->efuse_intr));
> +
> +	if (instance->eye_src)
> +		clrsetbits_le32(pbase + XSP_USBPHYACR5, P2A5_RG_HSTX_SRCTRL,
> +				FIELD_PREP(P2A5_RG_HSTX_SRCTRL, instance->eye_src));
> +
> +	if (instance->eye_vrt)
> +		clrsetbits_le32(pbase + XSP_USBPHYACR1, P2A1_RG_VRT_SEL,
> +				FIELD_PREP(P2A1_RG_VRT_SEL, instance->eye_vrt));
> +
> +	if (instance->eye_term)
> +		clrsetbits_le32(pbase + XSP_USBPHYACR1, P2A1_RG_TERM_SEL,
> +				FIELD_PREP(P2A1_RG_TERM_SEL, instance->eye_term));
> +}
> +
> +static void mtk_xsphy_u3_props_set(struct mtk_xsphy *xsphy,
> +				   struct mtk_xsphy_instance *instance)
> +{
> +	void __iomem *pbase = instance->port_base;
> +
> +	if (instance->efuse_intr)
> +		clrsetbits_le32(xsphy->sif_base + SSPXTP_PHYA_GLB_00,
> +				RG_XTP_GLB_BIAS_INTR_CTRL,
> +				FIELD_PREP(RG_XTP_GLB_BIAS_INTR_CTRL, instance->efuse_intr));
> +
> +	if (instance->efuse_tx_imp)
> +		clrsetbits_le32(pbase + SSPXTP_PHYA_LN_04, RG_XTP_LN0_TX_IMPSEL,
> +				FIELD_PREP(RG_XTP_LN0_TX_IMPSEL, instance->efuse_tx_imp));
> +
> +	if (instance->efuse_rx_imp)
> +		clrsetbits_le32(pbase + SSPXTP_PHYA_LN_14, RG_XTP_LN0_RX_IMPSEL,
> +				FIELD_PREP(RG_XTP_LN0_RX_IMPSEL, instance->efuse_rx_imp));
> +}
> +
> +/* type switch for usb3/pcie/sgmii */
> +static int mtk_xsphy_type_syscon_get(struct udevice *dev,
> +				     struct mtk_xsphy_instance *instance,
> +				     ofnode dn)
> +{
> +	struct ofnode_phandle_args args;
> +	int ret;
> +
> +	if (!ofnode_read_bool(dn, "mediatek,syscon-type"))
> +		return 0;
> +
> +	ret = ofnode_parse_phandle_with_args(dn, "mediatek,syscon-type",
> +					     NULL, 2, 0, &args);
> +	if (ret)
> +		return ret;
> +
> +	instance->type_sw_reg = args.args[0];
> +	instance->type_sw_index = args.args[1] & 0x3; /* <=3 */
> +	instance->type_sw = syscon_node_to_regmap(args.node);
> +	if (IS_ERR(instance->type_sw))
> +		return PTR_ERR(instance->type_sw);
> +
> +	dev_dbg(dev, "phy-%s.%d: type_sw - reg %#x, index %d\n",
> +		dev->name, instance->index, instance->type_sw_reg,
> +		instance->type_sw_index);
> +
> +	return 0;
> +}
> +
> +static int mtk_xsphy_type_set(struct mtk_xsphy_instance *instance)
> +{
> +	int type;
> +	u32 offset;
> +
> +	if (!instance->type_sw)
> +		return 0;
> +
> +	switch (instance->type) {
> +	case PHY_TYPE_USB3:
> +		type = RG_PHY_SW_USB3;
> +		break;
> +	case PHY_TYPE_PCIE:
> +		type = RG_PHY_SW_PCIE;
> +		break;
> +	case PHY_TYPE_SGMII:
> +		type = RG_PHY_SW_SGMII;
> +		break;
> +	case PHY_TYPE_USB2:
> +	default:
> +		return 0;
> +	}
> +
> +	offset = instance->type_sw_index * BITS_PER_BYTE;
> +	regmap_update_bits(instance->type_sw, instance->type_sw_reg,
> +			   RG_PHY_SW_TYPE << offset, type << offset);
> +
> +	return 0;
> +}
> +
> +static int mtk_xsphy_init(struct phy *phy)
> +{
> +	struct mtk_xsphy *xsphy = dev_get_priv(phy->dev);
> +	struct mtk_xsphy_instance *instance = xsphy->phys[phy->id];
> +	int ret;
> +
> +	ret = clk_enable(&instance->ref_clk);
> +	if (ret) {
> +		dev_err(xsphy->dev, "failed to enable ref_clk\n");
> +		return ret;
> +	}
> +
> +	switch (instance->type) {
> +	case PHY_TYPE_USB2:
> +		mtk_xsphy_u2_instance_init(xsphy, instance);
> +		mtk_xsphy_u2_props_set(xsphy, instance);
> +		break;
> +	case PHY_TYPE_USB3:
> +		mtk_xsphy_u3_props_set(xsphy, instance);
> +		break;
> +	case PHY_TYPE_PCIE:
> +	case PHY_TYPE_SGMII:
> +		/* nothing to do, only used to set type */
> +		break;
> +	default:
> +		dev_err(xsphy->dev, "incompatible PHY type\n");
> +		clk_disable(&instance->ref_clk);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_xsphy_power_on(struct phy *phy)
> +{
> +	struct mtk_xsphy *xsphy = dev_get_priv(phy->dev);
> +	struct mtk_xsphy_instance *instance = xsphy->phys[phy->id];
> +
> +	if (instance->type == PHY_TYPE_USB2) {
> +		mtk_xsphy_u2_instance_power_on(xsphy, instance);
> +		mtk_xsphy_u2_slew_rate_calibrate(xsphy, instance);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_xsphy_power_off(struct phy *phy)
> +{
> +	struct mtk_xsphy *xsphy = dev_get_priv(phy->dev);
> +	struct mtk_xsphy_instance *instance = xsphy->phys[phy->id];
> +
> +	if (instance->type == PHY_TYPE_USB2)
> +		mtk_xsphy_u2_instance_power_off(xsphy, instance);
> +
> +	return 0;
> +}
> +
> +static int mtk_xsphy_exit(struct phy *phy)
> +{
> +	struct mtk_xsphy *xsphy = dev_get_priv(phy->dev);
> +	struct mtk_xsphy_instance *instance = xsphy->phys[phy->id];
> +
> +	clk_disable(&instance->ref_clk);
> +
> +	return 0;
> +}
> +
> +static int mtk_xsphy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> +{
> +	struct mtk_xsphy *xsphy = dev_get_priv(phy->dev);
> +	struct mtk_xsphy_instance *instance = xsphy->phys[phy->id];
> +
> +	if (instance->type == PHY_TYPE_USB2)
> +		mtk_xsphy_u2_instance_set_mode(xsphy, instance, mode);
> +
> +	return 0;
> +}
> +
> +static int mtk_xsphy_xlate(struct phy *phy, struct ofnode_phandle_args *args)
> +{
> +	struct mtk_xsphy *xsphy = dev_get_priv(phy->dev);
> +	struct mtk_xsphy_instance *instance = NULL;
> +	const struct device_node *phy_np = ofnode_to_np(args->node);
> +	u32 index;
> +
> +	if (!phy_np) {
> +		dev_err(phy->dev, "null pointer phy node\n");
> +		return -EINVAL;
> +	}
> +
> +	if (args->args_count != 2) {
> +		dev_err(phy->dev, "invalid number of cells in 'phy' property\n");
> +		return -EINVAL;
> +	}
> +
> +	for (index = 0; index < xsphy->nphys; index++)
> +		if (phy_np == xsphy->phys[index]->np) {
> +			instance = xsphy->phys[index];
> +			break;
> +		}
> +
> +	if (!instance) {
> +		dev_err(phy->dev, "failed to find appropriate phy\n");
> +		return -EINVAL;
> +	}
> +
> +	phy->id = index;
> +	instance->type = args->args[1];
> +	if (!(instance->type == PHY_TYPE_USB2 ||
> +	      instance->type == PHY_TYPE_USB3 ||
> +	      instance->type == PHY_TYPE_PCIE ||
> +	      instance->type == PHY_TYPE_SGMII)) {
> +		dev_err(phy->dev, "unsupported PHY type\n");
> +		return -EINVAL;
> +	}
> +
> +	mtk_xsphy_parse_property(xsphy, instance);
> +	mtk_xsphy_type_set(instance);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops mtk_xsphy_ops = {
> +	.init		= mtk_xsphy_init,
> +	.exit		= mtk_xsphy_exit,
> +	.power_on	= mtk_xsphy_power_on,
> +	.power_off	= mtk_xsphy_power_off,
> +	.set_mode	= mtk_xsphy_set_mode,
> +	.of_xlate	= mtk_xsphy_xlate,
> +};
> +
> +static int mtk_xsphy_probe(struct udevice *dev)
> +{
> +	struct mtk_xsphy *xsphy = dev_get_priv(dev);
> +	fdt_addr_t sif_addr;
> +	ofnode subnode;
> +	int index = 0;
> +
> +	xsphy->nphys = dev_get_child_count(dev);
> +
> +	xsphy->phys = devm_kcalloc(dev, xsphy->nphys, sizeof(*xsphy->phys),
> +				   GFP_KERNEL);
> +	if (!xsphy->phys)
> +		return -ENOMEM;
> +
> +	xsphy->dev = dev;
> +
> +	sif_addr = ofnode_get_addr(dev_ofnode(dev));
> +	/* optional, may not exist if no u3 phys */
> +	if (sif_addr != FDT_ADDR_T_NONE)
> +		xsphy->sif_base = map_sysmem(sif_addr, 0);
> +
> +	xsphy->src_ref_clk_mhz = XSP_REF_CLK_MHZ;
> +	xsphy->src_coef = XSP_SLEW_RATE_COEF;
> +	/* update parameters of slew rate calibrate if exist */
> +	ofnode_read_u32(dev_ofnode(dev), "mediatek,src-ref-clk-mhz",
> +			&xsphy->src_ref_clk_mhz);
> +	ofnode_read_u32(dev_ofnode(dev), "mediatek,src-coef", &xsphy->src_coef);
> +
> +	dev_for_each_subnode(subnode, dev) {
> +		struct mtk_xsphy_instance *inst;
> +		fdt_addr_t addr;
> +		int ret;
> +
> +		inst = devm_kzalloc(dev, sizeof(*inst), GFP_KERNEL);
> +		if (!inst)
> +			return -ENOMEM;
> +
> +		xsphy->phys[index] = inst;
> +
> +		addr = ofnode_get_addr(subnode);
> +		if (addr == FDT_ADDR_T_NONE)
> +			return -EADDRNOTAVAIL;
> +
> +		inst->port_base = map_sysmem(addr, 0);
> +		inst->index = index;
> +		inst->np = ofnode_to_np(subnode);
> +
> +		ret = clk_get_by_name_nodev(subnode, "ref", &inst->ref_clk);
> +		if (ret) {
> +			dev_err(dev, "failed to get ref_clk(id-%d)\n", index);
> +			return ret;
> +		}
> +
> +		ret = mtk_xsphy_type_syscon_get(dev, inst, subnode);
> +		if (ret)
> +			return ret;
> +
> +		index++;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id mtk_xsphy_id_table[] = {
> +	{ .compatible = "mediatek,xsphy" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(mtk_xsphy) = {
> +	.name		= "mtk-xsphy",
> +	.id		= UCLASS_PHY,
> +	.of_match	= mtk_xsphy_id_table,
> +	.ops		= &mtk_xsphy_ops,
> +	.probe		= mtk_xsphy_probe,
> +	.priv_auto	= sizeof(struct mtk_xsphy),
> +};
> 

I came up with a (very) similar driver for this phy, too bad for the 
duplicated work. Anyway, successfully tested on Genio Pro and even a bit 
better than my own version, so feel free to add

Reviewed-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>

Regards,
Arnaud
