Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE133D6ACF5
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 12:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 575BC83DBD;
	Thu, 18 Dec 2025 13:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="pPOlXcvf";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="dfk907Rr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 109AB83C61; Thu, 18 Dec 2025 05:47:56 +0100 (CET)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 925D283C28
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 05:47:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dang.huynh@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1766033273; bh=DxfCwWAtCpcYUPpSrmb+4FA
 JEoM62k3jq1aoo1lE2y0=; b=pPOlXcvfkFyvwexht1tptmYDlcHSwkyJDeHJfLESF50XgREECT
 5fsHd+WY3EJnCX/9b3/e/wgV3DOBNyCGbzAg2Zvub+SchwojbOffXoX1GTAdDyL1SmYT/1EF4Ww
 v5hnUIVS0jrafG24RsaL6bu0UPAzDzmaBVRKNeFdjSyQ2OJlv875690lLfjx0wgsWntsyjpuWQC
 nDC8egiNmmzaILhT2t3L6WobmUdq6Zfen8SQcB55vlBpH5NjtWkeeZr9R/zNl8xIaD02rrXF9lH
 Kc2Gxv4TXDjclmscPiP1tC6FerIcza1o8CfoSVMe2ixnSAK41pDA8dKiLp3LzUUQk+g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1766033273; bh=DxfCwWAtCpcYUPpSrmb+4FA
 JEoM62k3jq1aoo1lE2y0=; b=dfk907RrtgoQ94NZtTLNMAUtAijBTO5vqAiMpchma934Cagabi
 xL0DjNI8xVWoMjOq3OF9fA6xpGxUc/LIFGDg==;
Date: Thu, 18 Dec 2025 11:47:43 +0700
From: Dang Huynh <dang.huynh@mainlining.org>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Ondrej Jirman <megi@xff.cz>,
 Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dragan Simic <dsimic@manjaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Piotr Zalewski <pZ010001011111@proton.me>, 
 Andy Yan <andy.yan@rock-chips.com>, Sandy Huang <hjc@rock-chips.com>
Subject: Re: [PATCH v6 06/12] video: rockchip: Add VOP2 support
Message-ID: <chchtfgy2g6wvapy2u3t7cbtlwoexqd4ir2u23tq5kxeltcqbb@xo5cmulfjhtv>
References: <20251108-vop2-pt2-v6-0-d04c699262fb@mainlining.org>
 <20251108-vop2-pt2-v6-6-d04c699262fb@mainlining.org>
 <fa8c6acb-5251-4f0c-8b9b-c7f97203903c@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa8c6acb-5251-4f0c-8b9b-c7f97203903c@rock-chips.com>
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:13:57 +0100
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

On Mon, Nov 10, 2025 at 11:24:01AM +0800, Chaoyi Chen wrote:
> On 11/8/2025 1:38 PM, Dang Huynh via B4 Relay wrote:
> 
> > From: Dang Huynh <dang.huynh@mainlining.org>
> > 
> > VOP2 (Video Output Processor v2) is a display controller on Rockchip
> > SoCs. It can be found on RK3566/8 and RK3588.
> > 
> > This commit currently only supports RK3566/8.
> > 
> > Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> > ---
> >   arch/arm/include/asm/arch-rockchip/vop_rk3568.h | 280 +++++++++++++
> >   drivers/video/rockchip/Makefile                 |   3 +-
> >   drivers/video/rockchip/rk3568_vop.c             | 260 ++++++++++++
> >   drivers/video/rockchip/rk_vop2.c                | 520 ++++++++++++++++++++++++
> >   drivers/video/rockchip/rk_vop2.h                |  76 ++++
> >   5 files changed, 1138 insertions(+), 1 deletion(-)
> 
> [...]
> 
> > +
> > +/*
> > + * RK3566 datasheet omits the VP2, even though it exist in the hardware
> > + * so let's not use it.
> > + */
> > +struct rkvop2_platdata rk3566_platdata = {
> > +	.delay = 20,
> > +	.bg_dly = {42, 40, -1},
> > +	/* SMART0, ESMART0 */
> > +	.vp_lyr = {3, 2, -1},
> 
> For RK3566, this should be "SMART0, SMART1" or "ESMART0, ESMART1".
> 
> You can not use esmart and smart layers at the same time. And the two layers need to have the same MST address.
> 
You can use ESMART0 and SMART0 at the same time? That's how Linux 6.18 would configure VOP for both VP0 and VP1.

> 
> > +	.layers = {ROCKCHIP_VOP2_CLUSTER0, ROCKCHIP_VOP2_RESERVED,
> > +		   ROCKCHIP_VOP2_ESMART0, ROCKCHIP_VOP2_SMART0,
> > +		   ROCKCHIP_VOP2_RESERVED, ROCKCHIP_VOP2_RESERVED,
> > +		   ROCKCHIP_VOP2_RESERVED, ROCKCHIP_VOP2_RESERVED},
> > +};
> > +
> > +struct rkvop2_platdata rk3568_platdata = {
> > +	.delay = 20,
> > +	.bg_dly = {42, 40, 40},
> > +	/* SMART0, SMART1, ESMART1 */
> > +	.vp_lyr = {3, 7, 6},
> > +	.layers = {ROCKCHIP_VOP2_CLUSTER0, ROCKCHIP_VOP2_CLUSTER1,
> > +		   ROCKCHIP_VOP2_ESMART0, ROCKCHIP_VOP2_SMART0,
> > +		   ROCKCHIP_VOP2_RESERVED, ROCKCHIP_VOP2_RESERVED,
> > +		   ROCKCHIP_VOP2_ESMART1, ROCKCHIP_VOP2_SMART1},
> > +};
> > +
> > +struct rkvop2_driverdata rk3566_driverdata = {
> > +	.features = VOP_FEATURE_OUTPUT_10BIT,
> > +	.set_pin_polarity = rk3568_set_pin_polarity,
> > +	.enable_output = rk3568_enable_output,
> > +	.platdata = &rk3566_platdata,
> > +};
> > +
> > +struct rkvop2_driverdata rk3568_driverdata = {
> > +	.features = VOP_FEATURE_OUTPUT_10BIT,
> > +	.set_pin_polarity = rk3568_set_pin_polarity,
> > +	.enable_output = rk3568_enable_output,
> > +	.platdata = &rk3568_platdata,
> > +};
> > +
> > +static const struct udevice_id rk3568_vop_ids[] = {
> > +	{ .compatible = "rockchip,rk3566-vop",
> > +	  .data = (ulong)&rk3566_driverdata },
> > +	{ .compatible = "rockchip,rk3568-vop",
> > +	  .data = (ulong)&rk3568_driverdata },
> > +	{ }
> > +};
> > +
> > +static const struct video_ops rk3568_vop_ops = {
> > +};
> > +
> > +U_BOOT_DRIVER(rk3568_vop) = {
> > +	.name	= "rk3568_vop",
> > +	.id	= UCLASS_VIDEO,
> > +	.of_match = rk3568_vop_ids,
> > +	.ops	= &rk3568_vop_ops,
> > +	.bind	= rk_vop2_bind,
> > +	.probe	= rk3568_vop_probe,
> > +	.remove = rk3568_vop_remove,
> > +	.priv_auto = sizeof(struct rk_vop2_priv),
> > +#if CONFIG_IS_ENABLED(VIDEO_REMOVE)
> > +	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_OS_PREPARE,
> > +#else
> > +	.flags = DM_FLAG_PRE_RELOC,
> > +#endif
> > +};
> > diff --git a/drivers/video/rockchip/rk_vop2.c b/drivers/video/rockchip/rk_vop2.c
> > new file mode 100644
> > index 00000000000..992f215d416
> > --- /dev/null
> > +++ b/drivers/video/rockchip/rk_vop2.c
> > @@ -0,0 +1,520 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2024 - 2025 Dang Huynh <dang.huynh@mainlining.org>
> > + *
> > + * Based on rk_vop.c:
> > + *   Copyright (c) 2015 Google, Inc
> > + *   Copyright 2014 Rockchip Inc.
> > + */
> > +
> > +#include <clk.h>
> > +#include <display.h>
> > +#include <dm.h>
> > +#include <dm/device_compat.h>
> > +#include <edid.h>
> > +#include <log.h>
> > +#include <regmap.h>
> > +#include <reset.h>
> > +#include <syscon.h>
> > +#include <video.h>
> > +#include <asm/global_data.h>
> > +#include <asm/gpio.h>
> > +#include <asm/io.h>
> > +#include <asm/arch-rockchip/clock.h>
> > +#include <asm/arch-rockchip/vop_rk3568.h>
> > +#include <dm/device-internal.h>
> > +#include <dm/uclass-internal.h>
> > +#include <efi.h>
> > +#include <efi_loader.h>
> > +#include <linux/bitops.h>
> > +#include <linux/err.h>
> > +#include <power/regulator.h>
> > +
> > +#include "rk_vop2.h"
> > +
> > +DECLARE_GLOBAL_DATA_PTR;
> > +
> > +enum vop_pol {
> > +	HSYNC_POSITIVE = 0,
> > +	VSYNC_POSITIVE = 1,
> > +	DEN_NEGATIVE   = 2,
> > +	DCLK_INVERT    = 3
> > +};
> > +
> > +static void rkvop2_cfg_regdone(struct rk3568_vop_sysctrl *sysctrl, int port)
> > +{
> > +	u32 reg;
> > +
> > +	reg = M_GLOBAL_REGDONE;
> > +
> > +	/*
> > +	 * For RK3588, changes will only take effect when the same bit is
> > +	 * leftshifted by 16.
> > +	 */
> > +	reg |= M_LOAD_GLOBAL(port) | M_LOAD_GLOBAL(port) << 16;
> > +
> > +	writel(reg, &sysctrl->reg_cfg_done);
> > +}
> > +
> > +static int rkvop2_enable(struct udevice *dev, ulong fbbase,
> > +			 int fb_bits_per_pixel, const struct display_timing *edid,
> > +			 int port, int win_id, struct rkvop2_platdata *platdata)
> > +{
> > +	struct rk_vop2_priv *priv = dev_get_priv(dev);
> > +	struct rk3568_vop_overlay *overlay = priv->regs + VOP2_OVERLAY_OFFSET;
> > +	struct rk3568_vop_esmart *esmart;
> > +	bool is_cluster = false;
> > +	u8 layer;
> > +	u32 reg;
> > +	u32 rgb_mode;
> > +	u32 hactive = edid->hactive.typ;
> > +	u32 vactive = edid->vactive.typ;
> > +
> > +	if (platdata->layers[win_id] < 0)
> > +		return -EINVAL;
> > +
> > +	switch (platdata->layers[win_id]) {
> > +	case ROCKCHIP_VOP2_CLUSTER0:
> > +	case ROCKCHIP_VOP2_CLUSTER1:
> > +	case ROCKCHIP_VOP2_CLUSTER2:
> > +	case ROCKCHIP_VOP2_CLUSTER3:
> > +		is_cluster = true;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	layer = platdata->layers[win_id];
> > +
> > +	debug("(%s, %s): win_id = %d - layer = %d - cluster: %d\n",
> > +	      dev_read_name(dev),  __func__, win_id, layer, is_cluster);
> > +
> > +	/* TODO: Support VOP2 CLUSTER */
> > +	if (is_cluster) {
> > +		dev_err(dev, "win_id is a cluster, not supported.\n");
> > +		return -ENOSYS;
> > +	}
> > +
> > +	esmart = priv->regs + VOP2_ESMART_OFFSET(layer - 4);
> > +
> > +	debug("(%s, %s): esmart addr: 0x%p\n", dev_read_name(dev), __func__, esmart);
> > +
> > +	writel(V_ACT_WIDTH(hactive - 1) | V_ACT_HEIGHT(vactive - 1),
> > +	       &esmart->esmart_region0_act_info);
> > +
> > +	/* Set offset to 0,0 */
> > +	writel(0, &esmart->esmart_region0_dsp_offset);
> > +
> > +	writel(V_DSP_WIDTH(hactive - 1) |
> > +			V_DSP_HEIGHT(vactive - 1),
> > +			&esmart->esmart_region0_dsp_info);
> > +
> > +	switch (fb_bits_per_pixel) {
> > +	case 16:
> > +		rgb_mode = RGB565;
> > +		writel(V_RGB565_VIRWIDTH(hactive), &esmart->esmart_region0_vir);
> > +		break;
> > +	case 24:
> > +		rgb_mode = RGB888;
> > +		writel(V_RGB888_VIRWIDTH(hactive), &esmart->esmart_region0_vir);
> > +		break;
> > +	case 32:
> > +	default:
> > +		rgb_mode = ARGB8888;
> > +		writel(V_ARGB888_VIRWIDTH(hactive), &esmart->esmart_region0_vir);
> > +		break;
> > +	}
> > +
> > +	writel(fbbase, &esmart->esmart_region0_mst_yrgb);
> > +
> > +	writel(V_ESMART_REGION0_DATA_FMT(rgb_mode) | M_ESMART_REGION0_MST_EN,
> > +	       &esmart->esmart_region0_mst_ctl);
> > +
> > +	/* Set esmart to the destination video port */
> > +	reg = V_ESMART_SEL_PORT(layer - 4, port);
> > +
> > +	/*
> > +	 * VOP2 requires every port mux to be configured.
> > +	 *
> > +	 * As U-Boot only supports singledisplay, we'll set all
> > +	 * unused ports to set layer to 8 (disabled).
> > +	 */
> > +	for (int i = 0; i < 4; i++) {
> > +		if (i != port)
> > +			reg |= V_PORT_MUX(8, i);
> > +	}
> > +
> > +	writel(reg, &overlay->port_sel);
> > +
> > +	/* Set layer 0 to win_id */
> > +	writel(V_LAYER_SEL(0, win_id), &overlay->layer_sel);
> > +
> > +	reg = readl(&overlay->overlay_ctrl) | M_LAYER_SEL_REGDONE_EN;
> > +	writel(reg, &overlay->overlay_ctrl);
> > +
> > +	priv->layer = layer;
> > +
> > +	return 0;
> > +}
> > +
> > +static void rkvop2_set_pin_polarity(struct udevice *dev,
> > +				    enum vop_modes mode, u32 polarity)
> > +{
> > +	struct rkvop2_driverdata *ops =
> > +		(struct rkvop2_driverdata *)dev_get_driver_data(dev);
> > +
> > +	if (ops->set_pin_polarity)
> > +		ops->set_pin_polarity(dev, mode, polarity);
> > +}
> > +
> > +static void rkvop2_enable_output(struct udevice *dev, enum vop_modes mode, u32 port)
> > +{
> > +	struct rkvop2_driverdata *ops =
> > +		(struct rkvop2_driverdata *)dev_get_driver_data(dev);
> > +
> > +	if (ops->enable_output)
> > +		ops->enable_output(dev, mode, port);
> > +}
> > +
> > +static void rkvop2_mode_set(struct udevice *dev,
> > +			    const struct display_timing *edid,
> > +		enum vop_modes mode, int port,
> > +		struct rkvop2_platdata *platdata)
> > +{
> > +	struct rk_vop2_priv *priv = dev_get_priv(dev);
> > +	struct rk3568_vop_sysctrl *sysctrl = priv->regs + VOP2_SYSREG_OFFSET;
> > +	struct rk3568_vop_post *post = priv->regs + VOP2_POST_OFFSET(port);
> > +	struct rkvop2_driverdata *data =
> > +		(struct rkvop2_driverdata *)dev_get_driver_data(dev);
> > +
> > +	debug("(%s, %s): port addr: 0x%p\n", dev_read_name(dev), __func__, post);
> > +
> > +	u32 hactive = edid->hactive.typ;
> > +	u32 vactive = edid->vactive.typ;
> > +	u32 hsync_len = edid->hsync_len.typ;
> > +	u32 hback_porch = edid->hback_porch.typ;
> > +	u32 vsync_len = edid->vsync_len.typ;
> > +	u32 vback_porch = edid->vback_porch.typ;
> > +	u32 hfront_porch = edid->hfront_porch.typ;
> > +	u32 vfront_porch = edid->vfront_porch.typ;
> > +	int mode_flags;
> > +	u32 pin_polarity;
> > +	u32 reg;
> > +
> > +	pin_polarity = BIT(DCLK_INVERT);
> > +	if (edid->flags & DISPLAY_FLAGS_HSYNC_HIGH)
> > +		pin_polarity |= BIT(HSYNC_POSITIVE);
> > +	if (edid->flags & DISPLAY_FLAGS_VSYNC_HIGH)
> > +		pin_polarity |= BIT(VSYNC_POSITIVE);
> > +
> > +	rkvop2_enable_output(dev, mode, port);
> > +	rkvop2_set_pin_polarity(dev, mode, pin_polarity);
> > +
> > +	mode_flags = 0;  /* RGB888 */
> > +	if ((data->features & VOP_FEATURE_OUTPUT_10BIT) &&
> > +	    mode == VOP_MODE_HDMI)
> > +		mode_flags = 15;  /* RGBaaa */
> 
> You should also set RGBaaa for VOP_MODE_EDP.
> 
Will do in next series.

> 
> > +
> > +	reg = V_DSP_OUT_MODE(mode_flags);
> > +
> > +	debug("(%s, %s): bg_dly: %d\n",
> > +	      dev_read_name(dev), __func__, platdata->bg_dly[port]);
> > +
> > +	if (platdata->bg_dly[port] < 0) {
> > +		dev_err(dev, "bg_dly is zero for vp%d\n", port);
> > +		return;
> > +	}
> > +
> > +	writel(((platdata->bg_dly[port] + (hactive >> 1) - 1) << 16) | hsync_len,
> > +	       &post->prescan_htimings);
> > +
> > +	writel(V_HSYNC(hsync_len) |
> > +			V_HORPRD(hsync_len + hback_porch + hactive + hfront_porch),
> > +			&post->dsp_htotal_hs_end);
> > +
> > +	writel(V_HEAP(hsync_len + hback_porch + hactive) |
> > +			V_HASP(hsync_len + hback_porch),
> > +			&post->dsp_hact_st_end);
> > +
> > +	writel(V_VAEP(vsync_len + vback_porch + vactive) |
> > +			V_VASP(vsync_len + vback_porch),
> > +			&post->dsp_vact_st_end);
> > +
> > +	writel(V_VSYNC(vsync_len) |
> > +			V_VERPRD(vsync_len + vback_porch + vactive + vfront_porch),
> > +			&post->dsp_vtotal_vs_end);
> > +
> > +	writel(V_HEAP(hsync_len + hback_porch + hactive) |
> > +			V_HASP(hsync_len + hback_porch),
> > +			&post->dsp_hact_info);
> > +
> > +	writel(V_VAEP(vsync_len + vback_porch + vactive) |
> > +			V_VASP(vsync_len + vback_porch),
> > +			&post->dsp_vact_info);
> > +
> > +	/* No scaling */
> > +	writel(0x10001000, &post->scl_factor_yrgb);
> > +
> > +	writel(reg, &post->dsp_ctrl);
> > +
> > +	rkvop2_cfg_regdone(sysctrl, port);
> > +}
> > +
> > +/**
> > + * rk_display_init() - Try to enable the given display device
> > + *
> > + * This function performs many steps:
> > + * - Finds the display device being referenced by @ep_node
> > + * - Puts the VOP's ID into its uclass platform data
> > + * - Probes the device to set it up
> > + * - Reads the timing information (from EDID or panel)
> > + * - Sets up the VOP clocks, etc. for the selected pixel clock and display mode
> > + * - Enables the display (the display device handles this and will do different
> > + *     things depending on the display type)
> > + * - Tells the uclass about the display resolution so that the console will
> > + *     appear correctly
> > + *
> > + * @dev:	VOP device that we want to connect to the display
> > + * @fbbase:	Frame buffer address
> > + * @vp_node:	Device tree node to process
> > + * Return: 0 if OK, -ve if something went wrong
> > + */
> > +static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode vp_node)
> > +{
> > +	struct rk_vop2_priv *priv = dev_get_priv(dev);
> > +	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
> > +	struct rkvop2_driverdata *drvdata =
> > +		(struct rkvop2_driverdata *)dev_get_driver_data(dev);
> > +	struct rkvop2_platdata *platdata =
> > +		(struct rkvop2_platdata *)drvdata->platdata;
> > +	ofnode ep_node;
> > +	int vop_id, port_id, win_id;
> > +	struct display_timing timing;
> > +	struct udevice *disp;
> > +	int ret;
> > +	u32 remote_phandle;
> > +	struct display_plat *disp_uc_plat;
> > +	enum video_log2_bpp l2bpp;
> > +	ofnode remote;
> > +	const char *compat;
> > +	char dclk_name[9];
> > +	struct clk dclk;
> > +
> > +	debug("%s(%s, 0x%lx, %s)\n", __func__,
> > +	      dev_read_name(dev), fbbase, ofnode_get_name(vp_node));
> > +
> > +	port_id = ofnode_read_u32_default(vp_node, "reg", -1);
> > +	if (port_id < 0) {
> > +		debug("%s(%s): no video port id\n", __func__, dev_read_name(dev));
> > +		return port_id;
> > +	}
> > +
> > +	ep_node = ofnode_first_subnode(vp_node);
> > +	if (!ofnode_valid(ep_node)) {
> > +		debug("%s(%s): no valid subnode\n", __func__, dev_read_name(dev));
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = ofnode_read_u32(ep_node, "remote-endpoint", &remote_phandle);
> > +	if (ret) {
> > +		debug("%s(%s): no remote-endpoint\n", __func__, dev_read_name(dev));
> > +		return ret;
> > +	}
> > +
> > +	remote = ofnode_get_by_phandle(remote_phandle);
> > +	if (!ofnode_valid(remote))
> > +		return -EINVAL;
> > +
> > +	remote = ofnode_get_parent(remote);
> > +	if (!ofnode_valid(remote))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * The remote-endpoint references into a subnode of the encoder
> > +	 * (i.e. HDMI, MIPI, etc.) with the DTS looking something like
> > +	 * the following:
> > +	 *
> > +	 * hdmi: hdmi@fe0a0000 {
> > +	 *   ports {
> > +	 *     hdmi_in: port {
> > +	 *       hdmi_in_vp0: endpoint { ... };
> > +	 *     }
> > +	 *   }
> > +	 * }
> > +	 *
> > +	 * This isn't any different from how VOP1 works, so we'll adapt
> > +	 * the same method of finding the display from the original code
> > +	 * (find the enclosing device of "UCLASS_DISPLAY")
> > +	 *
> > +	 * We also look for UCLASS_VIDEO_BRIDGE so we can use the existing
> > +	 * DW MIPI DSI driver for Rockchip.
> > +	 */
> > +	while (ofnode_valid(remote)) {
> > +		remote = ofnode_get_parent(remote);
> > +		if (!ofnode_valid(remote)) {
> > +			debug("%s(%s): no UCLASS_DISPLAY for remote-endpoint\n",
> > +			      __func__, dev_read_name(dev));
> > +			return -EINVAL;
> > +		}
> > +
> > +		uclass_find_device_by_ofnode(UCLASS_DISPLAY, remote, &disp);
> > +		if (disp)
> > +			break;
> > +	};
> > +	compat = ofnode_get_property(remote, "compatible", NULL);
> > +	if (!compat) {
> > +		debug("%s(%s): Failed to find compatible property\n",
> > +		      __func__, dev_read_name(dev));
> > +		return -EINVAL;
> > +	}
> > +	if (strstr(compat, "edp")) {
> > +		vop_id = VOP_MODE_EDP;
> > +	} else if (strstr(compat, "mipi")) {
> > +		vop_id = VOP_MODE_MIPI;
> > +	} else if (strstr(compat, "hdmi")) {
> > +		vop_id = VOP_MODE_HDMI;
> > +	} else if (strstr(compat, "rk3588-dp")) {
> 
> Can we directly use "dp" ?
> 
We can, however if the device tree is misconfigured then it'll pick up VP connected devices with "dp" (such
as "rk3588-h*dp*tx-phy") and consider that to be a displayport device.

> 
> > +		vop_id = VOP_MODE_DP;
> > +	} else if (strstr(compat, "lvds")) {
> > +		vop_id = VOP_MODE_LVDS;
> > +	} else {
> > +		debug("%s(%s): Failed to find vop mode for %s\n",
> > +		      __func__, dev_read_name(dev), compat);
> > +		return -EINVAL;
> > +	}
> > +	debug("vop_id=%d - port=%d\n", vop_id, port_id);
> > +
> > +	/* Get the video port clock and enable it */
> > +	snprintf(dclk_name, sizeof(dclk_name), "dclk_vp%d", port_id);
> > +	ret = clk_get_by_name(dev, dclk_name, &dclk);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	disp_uc_plat = dev_get_uclass_plat(disp);
> > +	debug("Found device '%s', disp_uc_priv=%p\n", disp->name, disp_uc_plat);
> > +	if (display_in_use(disp)) {
> > +		debug("   - device in use\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	disp_uc_plat->source_id = vop_id;
> > +	disp_uc_plat->src_dev = dev;
> > +
> > +	ret = device_probe(disp);
> > +	if (ret) {
> > +		debug("%s: device '%s' display won't probe (ret=%d)\n",
> > +		      __func__, dev->name, ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = display_read_timing(disp, &timing);
> > +	if (ret) {
> > +		debug("%s: Failed to read timings\n", __func__);
> > +		return ret;
> > +	}
> > +
> > +	/* Set clock rate on video port to display timings */
> > +	ret = clk_set_rate(&dclk, timing.pixelclock.typ);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to set clock rate: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	debug("%s(%s): %s clkrate %lu\n", __func__, dev_read_name(dev),
> > +	      dclk_name, clk_get_rate(&dclk));
> > +
> > +	/* Set bitwidth for vop display according to vop mode */
> > +	switch (vop_id) {
> > +	case VOP_MODE_EDP:
> > +	case VOP_MODE_MIPI:
> > +	case VOP_MODE_HDMI:
> > +	case VOP_MODE_DP:
> > +	case VOP_MODE_LVDS:
> > +		l2bpp = VIDEO_BPP32;
> > +		break;
> > +	default:
> > +		l2bpp = VIDEO_BPP16;
> 
> It seems that we always end up with VIDEO_BPP32?
> 
U-Boot doesn't support VIDEO_BPP24 format.

> 
> > +	}
> > +
> > +	/*
> > +	 * We'll use the default platform-specific win_id from Linux
> > +	 * so that Linux can take over U-Boot plane when Linux reconfigures
> > +	 * VOP2.
> > +	 */
> > +	win_id = platdata->vp_lyr[port_id];
> > +	if (win_id < 0) {
> > +		dev_err(dev, "win_id is null, don't setup\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = rkvop2_enable(dev, fbbase, 1 << l2bpp, &timing, port_id, win_id, platdata);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	rkvop2_mode_set(dev, &timing, vop_id, port_id, platdata);
> > +
> > +	ret = display_enable(disp, 1 << l2bpp, &timing);
> > +	if (ret)
> > +		return ret;
> > +
> > +	uc_priv->xsize = timing.hactive.typ;
> > +	uc_priv->ysize = timing.vactive.typ;
> > +	uc_priv->bpix = l2bpp;
> > +
> > +	priv->vp = port_id;
> > +
> > +	debug("fb=%lx, size=%d %d\n", fbbase,
> > +	      uc_priv->xsize, uc_priv->ysize);
> > +
> > +	return 0;
> > +}
> > +
> > +int rk_vop2_probe(struct udevice *dev)
> > +{
> > +	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
> > +	struct rk_vop2_priv *priv = dev_get_priv(dev);
> > +	int ret = 0;
> > +	ofnode port, node;
> > +
> > +	/* Before relocation we don't need to do anything */
> > +	if (!(gd->flags & GD_FLG_RELOC))
> > +		return 0;
> > +
> > +	if (IS_ENABLED(CONFIG_EFI_LOADER)) {
> > +		debug("Adding to EFI map %d @ %lx\n", plat->size, plat->base);
> > +		efi_add_memory_map(plat->base, plat->size, EFI_RESERVED_MEMORY_TYPE);
> > +	}
> > +
> > +	priv->regs = dev_read_addr_ptr(dev);
> > +
> > +	/* Try all the ports until we find one that works. */
> > +	port = dev_read_subnode(dev, "ports");
> > +	if (!ofnode_valid(port)) {
> > +		debug("%s(%s): 'port' subnode not found\n",
> > +		      __func__, dev_read_name(dev));
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (node = ofnode_first_subnode(port);
> > +			ofnode_valid(node);
> > +			node = dev_read_next_subnode(node)) {
> > +		ret = rk_display_init(dev, plat->base, node);
> > +		if (ret)
> > +			debug("Device failed: ret=%d\n", ret);
> > +		if (!ret)
> > +			break;
> > +	}
> > +	video_set_flush_dcache(dev, true);
> > +
> > +	return ret;
> > +}
> > +
> > +int rk_vop2_bind(struct udevice *dev)
> > +{
> > +	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
> > +
> > +	plat->size = 4 * (CONFIG_VIDEO_ROCKCHIP_MAX_XRES *
> > +			CONFIG_VIDEO_ROCKCHIP_MAX_YRES);
> > +
> > +	return 0;
> > +}
> > diff --git a/drivers/video/rockchip/rk_vop2.h b/drivers/video/rockchip/rk_vop2.h
> > new file mode 100644
> > index 00000000000..5d668070014
> > --- /dev/null
> > +++ b/drivers/video/rockchip/rk_vop2.h
> > @@ -0,0 +1,76 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2017 Theobroma Systems Design und Consulting GmbH
> > + */
> > +
> > +#ifndef __RK_VOP2_H__
> > +#define __RK_VOP2_H__
> > +
> > +#include <asm/arch-rockchip/vop_rk3568.h>
> > +
> > +struct rk_vop2_priv {
> > +	void *grf;
> > +	void *regs;
> > +	int vp;
> > +	int layer;
> > +};
> > +
> > +enum vop2_features {
> > +	VOP_FEATURE_OUTPUT_10BIT = (1 << 0),
> > +};
> > +
> > +enum vop2_layer {
> > +	ROCKCHIP_VOP2_CLUSTER0 = 0,
> > +	ROCKCHIP_VOP2_CLUSTER1,
> > +	ROCKCHIP_VOP2_CLUSTER2,
> > +	ROCKCHIP_VOP2_CLUSTER3,
> > +	ROCKCHIP_VOP2_ESMART0,
> > +	ROCKCHIP_VOP2_ESMART1,
> > +	ROCKCHIP_VOP2_ESMART2,
> > +	ROCKCHIP_VOP2_ESMART3,
> > +	ROCKCHIP_VOP2_SMART0 = 6,
> 
> Why is it necessary to assign a value?
> 
SMART0/1 shares the same address and map as ESMART2/3.

> 
> > +	ROCKCHIP_VOP2_SMART1,
> > +	ROCKCHIP_VOP2_RESERVED = -1,
> > +};
> > +
> > 
> -- 
> Best,
> Chaoyi
