Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A82AC61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:38:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F02F40564;
	Wed, 26 Aug 2026 16:38:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jIcaELFk-47K; Wed, 26 Aug 2026 16:38:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787762313;
	bh=UuMi/48cAHbnVh/QP3asa9eAE12hvHO4axx0UASq+Ng=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JChymGXq+f3rovIrLLcadTTxSH5+ei+MK2rEvPKyPNamfC7/B+yWN5CwVkkOEX4lG
	 C/mI7bZi509nm7uevVOCB7O9LbkAcl6sQ9B1xw2NW3MXJpJfN5savYfyAPYVXcofEM
	 znejwCR0YGswDyp2COg9q3olt8YMkV1QS9gfsDPxaevjXZ67W5wanVs5+fGu/VAGUX
	 QrJ2cub4YKs9Fr1PDlDDuRZxtt/CunPUBpluJKARGEud0oneoEBONpAl3SJUWo6RFX
	 cmma3w4WNk3y83PfR+B468RH2ktS5P4EFgQOO+SQ67jDut6inUiXzHBNUDs2xI6gKg
	 O+j/WHff3rmTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 428E44052D;
	Wed, 26 Aug 2026 16:38:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DF8D339E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:38:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D19C340521
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:38:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZYWYq6nvEFir for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:38:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=OK0MuHa7
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 799DE4052D
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:38:30 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4af81963f35so1051198b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787762309; x=1788367109;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UuMi/48cAHbnVh/QP3asa9eAE12hvHO4axx0UASq+Ng=;
 b=OK0MuHa7znmn5cPy5Dhi9HK5hBEoIcOF8i7wss4VWnM/b8QCMIjBggvDox6A7SLrc5
 qYNSc1jMt9xIF/uaGoIfl/LZSdVelN2P81Hj6Y/JEwhNy5bfqZrU4+A5hKiA0jnCCLhL
 vWV1AEkLAf3Jq9DX5RYm8Le2ZlMa7TiuNyz6Y1CMTPRAoKokWHZAo9Cer7YD1zEMcucj
 cZcQ0x4aiuJE9KvNG018UgeVO9eGnap+OIAWuN0CX9IAtjW3/vy7bl2sw0ckw1yQpSDP
 GIojRPvP3SDnOwG+5jqzmn2ivAnpstmUp0nJ4zP/zvGuzrm93Xqm/aYQ95qp0Nz2m86a
 TsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762309; x=1788367109;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UuMi/48cAHbnVh/QP3asa9eAE12hvHO4axx0UASq+Ng=;
 b=nmlBk+mm2QohvlRRlXWnGq4S9QjcJLenoOnWIMNF/84psamRB+DHk9NmtKJ+d11I7R
 Svb3XSS7qZHYcwUup1S85jFCw1BFoqeOHfjc8Pbui1bzb8439wF9kTYIp7XeM5DBGD6Y
 Wt+C7EC+7LjROxG4GzoQ+qgxvG1pgdjA4Msdq0vEwYutInXV4Y9sg8dsZ+dt6tH1re0k
 TTShjenyzUVjZ/TLoq9mz4kMEfwM4Xdv3slFmt6EDpRq3Lr5sMXrBeJuXdrRlFg4vQnq
 b60KMCBtwVQ9uYP4wEgOsSoDg0fD6tpO3LkDW5zFpSqx+jLY17TVBZZhKRls/mtPGXO2
 0r9A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMBwYf9fNsvfUVdLyXirw6PFgCI4fzTOQw568bkPBUiQOM5OnX956vipmEQVFpA7iz9i1s1Qw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mWwPhUgongZLVh0FgOAeFt+p8jSN/LXY+KcnCBAJq4D4rXg5Mc
 a0jqS3TGYn7k6HhVkeFm7PCTCE9Sy1EIcChD0CtOkO0/2eEt2c3Mtv6VCF0p9qLXpJU=
X-Gm-Gg: AR+sD12rroY6K2fnNOw6K2LXqMb+kvArIs4LGi2+HADjLDPvs0v23Qf9YEQBomuvFhN
 FjyjMESrmCZHmYxi/x60j7VlBqcx+6tIYyBytQ4mSStbAsuC2Mw0F6TED/6SczMgs7r3BSDeCzh
 04zuiyKwZeBFLF2IJeW2rhZNAe+hwbAzMKDhoZQbB2GU2S34NoDqHv8FTfMhoEjYkagBZ3PZpjC
 Y7KWt4nz8GFWLKaZ/7yoBqElmzQd6pcM04hnNh3oiSZ109DbHtZPfyawHEJ9/7mKKGmm3R77KB9
 Fcfha8yuE3dZXViAERCJIGjmSZjoFHKzItVFVhWcQ9c8Ii8rG/w58QjqsWNICkI8U50zg+pEZsC
 bOGk03dx7ceNvV7mBWbZsIdlQI/0+dyHhkS6+oBcHMW8cWybcj6Ze0X7uBLyyH6gufKT22Bc/qj
 8FqETbUzVIQd40c3qN4+w2z14fov3HdMBl7opdZSi5DH61Er4JmkWwxLPy2Rf0/GPrucOC0ZCIB
 FfYExOPtq1VcT1ynRKdLIfC5yXV05qfXtaGzso=
X-Received: by 2002:a05:6808:1201:b0:4b1:91e1:6740 with SMTP id
 5614622812f47-4b366a8db07mr7840609b6e.10.1787762308927; 
 Wed, 26 Aug 2026 09:38:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:162c:81fd:da88:2ea6?
 ([2600:8803:e7e4:500:162c:81fd:da88:2ea6])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b36a7b06c2sm2040811b6e.7.2026.08.26.09.38.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 09:38:27 -0700 (PDT)
Message-ID: <6b1d40cc-2c90-4c9d-bc4d-c7044e6f6130@baylibre.com>
Date: Wed, 26 Aug 2026 11:38:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] video: mediatek: add dpi1 component
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
 <20260826-add-genio-510-and-genio-700-hdmi-v2-8-68ebb1bf17df@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-8-68ebb1bf17df@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/26/26 8:09 AM, Julien Stephan wrote:
> DPI is one of the components of the video pipeline on some MediaTek
> SoCs, such as the MT8188: it is the timing generator interface
> feeding the HDMI TX. Sync polarities, porches and the interlace mode
> are taken from the struct display_timing selected from the EDID.
> 

...

> +void mtk_dpi_config(struct udevice *dev, const struct display_timing *timing,
> +		    bool rgb)
> +{
> +	struct mtk_dpintf_yc_limit limit;
> +	struct mtk_dpintf_polarities dpi_pol;
> +	struct mtk_dpintf_sync_param hsync;
> +	struct mtk_dpintf_sync_param vsync_lodd = { 0 };
> +	struct mtk_dpintf_sync_param vsync_leven = { 0 };
> +	struct mtk_dpintf_sync_param vsync_rodd = { 0 };
> +	struct mtk_dpintf_sync_param vsync_reven = { 0 };

nit: these can just be `{ }`.

> +	bool interlaced = timing->flags & DISPLAY_FLAGS_INTERLACED;
> +
> +	limit.c_bottom = 0x0010;
> +	limit.c_top = 0x0FE0;
> +	limit.y_bottom = 0x0010;
> +	limit.y_top = 0x0FE0;
> +
> +	dpi_pol.ck_pol = MTK_DPINTF_POLARITY_FALLING;
> +	dpi_pol.de_pol = MTK_DPINTF_POLARITY_RISING;
> +	dpi_pol.hsync_pol = timing->flags & DISPLAY_FLAGS_HSYNC_HIGH ?
> +			    MTK_DPINTF_POLARITY_RISING :
> +			    MTK_DPINTF_POLARITY_FALLING;
> +	dpi_pol.vsync_pol = timing->flags & DISPLAY_FLAGS_VSYNC_HIGH ?
> +			    MTK_DPINTF_POLARITY_RISING :
> +			    MTK_DPINTF_POLARITY_FALLING;
> +
> +	hsync.sync_width = timing->hsync_len.typ;
> +	hsync.back_porch = timing->hback_porch.typ;
> +	hsync.front_porch = timing->hfront_porch.typ;
> +	hsync.shift_half_line = false;
> +
> +	vsync_lodd.sync_width = timing->vsync_len.typ;
> +	vsync_lodd.back_porch = timing->vback_porch.typ;
> +	vsync_lodd.front_porch = timing->vfront_porch.typ;
> +	vsync_lodd.shift_half_line = false;
> +
> +	if (interlaced) {
> +		vsync_leven = vsync_lodd;
> +		vsync_leven.shift_half_line = true;
> +	}
> +
> +	mtk_dpi_sw_reset(dev, true);
> +	mtk_dpi_config_pol(dev, &dpi_pol);
> +
> +	mtk_dpi_config_hsync(dev, &hsync);
> +	mtk_dpi_config_vsync_lodd(dev, &vsync_lodd);
> +	mtk_dpi_config_vsync_rodd(dev, &vsync_rodd);
> +	mtk_dpi_config_vsync_leven(dev, &vsync_leven);
> +	mtk_dpi_config_vsync_reven(dev, &vsync_reven);
> +
> +	mtk_dpi_config_interface(dev, interlaced);
> +	if (interlaced)
> +		mtk_dpi_config_fb_size(dev, timing->hactive.typ,
> +				       timing->vactive.typ / 2);
> +	else
> +		mtk_dpi_config_fb_size(dev, timing->hactive.typ,
> +				       timing->vactive.typ);
> +
> +	mtk_dpi_config_input_2p(dev, true);
> +	mtk_dpi_config_output_1t1p(dev, true);
> +	mtk_dpi_config_channel_limit(dev, &limit);
> +	mtk_dpi_config_bit_num(dev, MTK_DPINTF_OUT_BIT_NUM_8BITS);
> +	mtk_dpi_config_channel_swap(dev, MTK_DPINTF_OUT_CHANNEL_SWAP_RGB);
> +	mtk_dpi_internal_matrix_sel(dev, !rgb);
> +	mtk_dpi_config_yc_map(dev, MTK_DPINTF_OUT_YC_MAP_RGB);
> +	mtk_dpi_config_swap_input(dev, false);
> +	mtk_dpi_sw_reset(dev, false);
> +}
> +
> +static const struct udevice_id mtk_dpi_ids[] = {
> +	{ .compatible = "mediatek,mt8188-dpi" },

Another one where mt8195 fallback should work.

> +	{}
> +};
> +
> +U_BOOT_DRIVER(mtk_dpi) = {
> +	.name	   = "mtk_dpi",
> +	.id	   = UCLASS_MISC,
> +	.of_match  = mtk_dpi_ids,
> +	.probe	   = mtk_disp_comp_probe,
> +	.priv_auto = sizeof(struct mtk_disp_comp_priv),
> +};
> diff --git a/drivers/video/mediatek/mtk_dpi.h b/drivers/video/mediatek/mtk_dpi.h
> new file mode 100644
> index 00000000000..ccce83ec8d3
> --- /dev/null
> +++ b/drivers/video/mediatek/mtk_dpi.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Mediatek MT8188 DPI Support
> + *
> + * Copyright (c) 2026 BayLibre, SAS.
> + * Author: Julien Stephan <jstephan@baylibre.com>
> + */
> +
> +#ifndef _MTK_DPI_H
> +#define _MTK_DPI_H
> +
> +struct display_timing;
> +struct udevice;
> +
> +void mtk_dpi_hw_enable(struct udevice *dev);
> +void mtk_dpi_hw_disable(struct udevice *dev);
> +void mtk_dpi_config(struct udevice *dev, const struct display_timing *timing,
> +		    bool rgb);
> +
> +#endif
> diff --git a/drivers/video/mediatek/mtk_dpi_regs.h b/drivers/video/mediatek/mtk_dpi_regs.h
> new file mode 100644
> index 00000000000..54e370460f0
> --- /dev/null
> +++ b/drivers/video/mediatek/mtk_dpi_regs.h


Does this really need to be a separate header? Seems like we can just put 
this stuff in the .c file.

> @@ -0,0 +1,113 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2026 MediaTek Inc.
> + * Copyright (c) 2026 BayLibre, SAS
> + */
> +
> +#ifndef __MTK_DPI_REGS_H
> +#define __MTK_DPI_REGS_H
> +
> +#define DPI_EN				0x00
> +#define EN				(0x1 << 0)
> +
> +#define DPI_RST				0x04
> +#define RST				(0x1 << 0)
> +
> +#define DPI_INTEN			0x08
> +#define INT_VSYNC_EN			(0x1 << 0)
> +
> +#define DPI_CON				0x10
> +#define IN_RB_SWAP			(0x1 << 1)
> +#define INTL_EN				(0x1 << 2)
> +#define TDFP_EN				(0x1 << 3)
> +#define YUV422_EN			(0x1 << 5)
> +#define CSC_ENABLE			(0x1 << 6)
> +#define OUTPUT_1T1P_EN			(0x1 << 24)
> +#define INPUT_2P_EN			(0x1 << 25)
> +
> +#define DPI_OUTPUT_SETTING		0x14
> +#define CH_SWAP				0
> +#define CH_SWAP_MASK			(0x7 << 0)
> +#define SWAP_RGB			0x00
> +#define SWAP_GBR			0x01
> +#define SWAP_BRG			0x02
> +#define SWAP_RBG			0x03
> +#define SWAP_GRB			0x04
> +#define SWAP_BGR			0x05
> +#define DE_POL				(0x1 << 12)
> +#define HSYNC_POL			(0x1 << 13)
> +#define VSYNC_POL			(0x1 << 14)
> +#define CK_POL				(0x1 << 15)
> +#define OUT_BIT				18
> +#define OUT_BIT_MASK			(0x3 << 18)
> +#define OUT_BIT_8			0x00
> +#define OUT_BIT_10			0x01
> +#define OUT_BIT_12			0x02
> +#define OUT_BIT_16			0x03
> +#define YC_MAP				20
> +#define YC_MAP_MASK			(0x7 << 20)
> +#define YC_MAP_RGB			0x00
> +#define YC_MAP_CYCY			0x04
> +#define YC_MAP_YCYC			0x05
> +#define YC_MAP_CY			0x06
> +#define YC_MAP_YC			0x07
> +
> +#define DPI_SIZE			0x18
> +#define HSIZE				0
> +#define HSIZE_MASK			(0x1FFF << 0)
> +#define VSIZE				16
> +#define VSIZE_MASK			(0x1FFF << 16)
> +
> +#define DPI_DDR_SETTING			0x1C
> +#define DDR_EN				(0x1 << 0)
> +#define DDR_4PHASE			(0x1 << 2)
> +
> +#define DPI_TGEN_HWIDTH			0x20
> +#define HPW				0
> +#define HPW_MASK			(0xFFF << 0)
> +
> +#define DPI_TGEN_HPORCH			0x24
> +#define HBP				0
> +#define HBP_MASK			(0xFFF << 0)
> +#define HFP				16
> +#define HFP_MASK			(0xFFF << 16)
> +
> +#define DPI_TGEN_VWIDTH			0x28
> +#define DPI_TGEN_VPORCH			0x2C
> +
> +#define VSYNC_WIDTH_SHIFT		0
> +#define VSYNC_WIDTH_MASK		(0xFFF << 0)
> +#define VSYNC_HALF_LINE_SHIFT		16
> +#define VSYNC_HALF_LINE_MASK		(0xFFF << 16)
> +#define VSYNC_BACK_PORCH_SHIFT		0
> +#define VSYNC_BACK_PORCH_MASK		(0xFFF << 0)
> +#define VSYNC_FRONT_PORCH_SHIFT		16
> +#define VSYNC_FRONT_PORCH_MASK		(0xFFF << 16)
> +
> +#define DPI_TGEN_VWIDTH_LEVEN		0x68
> +#define DPI_TGEN_VPORCH_LEVEN		0x6C
> +#define DPI_TGEN_VWIDTH_RODD		0x70
> +#define DPI_TGEN_VPORCH_RODD		0x74
> +#define DPI_TGEN_VWIDTH_REVEN		0x78
> +#define DPI_TGEN_VPORCH_REVEN		0x7C
> +
> +#define DPI_Y_LIMIT			0x98
> +#define Y_LIMINT_BOT			0
> +#define Y_LIMINT_BOT_MASK		(0xFFF << 0)
> +#define Y_LIMINT_TOP			16
> +#define Y_LIMINT_TOP_MASK		(0xFFF << 16)
> +
> +#define DPI_C_LIMIT			0x9C
> +#define C_LIMIT_BOT			0
> +#define C_LIMIT_BOT_MASK		(0xFFF << 0)
> +#define C_LIMIT_TOP			16
> +#define C_LIMIT_TOP_MASK		(0xFFF << 16)
> +
> +#define DPI_MATRIX_SET			0xB4
> +#define INT_MATRIX_SEL_MASK		(0x1F << 0)
> +#define RGB_TO_BT709			0x03
> +
> +#define DPI_PATTERN0			0xF00
> +#define DPI_PATTERN_EN			BIT(0)
> +#define DPI_PATTERN_COLOR_BAR		(0x4 << 4)
> +#endif /* __MTK_DPI_REGS_H */
> 


Also would be nice to use BIT()/GENMASK().

