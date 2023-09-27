Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA7AE80A92
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 06:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 695E086CBC;
	Wed, 27 Sep 2023 08:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="QaoJN5ms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DA5486CC1; Wed, 27 Sep 2023 08:19:37 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BE4886B96
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 08:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=76345cf035=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QLHRhl011037; Wed, 27 Sep 2023 08:19:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=i3L5PM3qyuCQ9X9W/5w/9frSeksph22U8RRnGc6pm8k=; b=Qa
 oJN5ms4rPjacfajkCLtAMO7h02kFTopG8O4ADsyCeb6wjNmBpzxjgEognvOImUY7
 kHRVmE8UQ6BIRXmAnmaDPwDpRvo8cZsz3whPt6J26GxqfecqBqUpCDB/TABSjFH+
 9sYxkTp1T9a53qzKFmR0wB1ae1yufAtz0m2N2BjEnIiEGWK6umE5OTBiLTEmkC4e
 33GsZmQvwE//FhSL7rQ/M2ap7YSSW4wn5ie/E6t6NELhn9GZQY5pdkGt9h8EpLz5
 ZYojQqcHxyLLbhhpRmwzW5Za/GqG4e6SM9SIln+W/keBbhAj1tF61Jecekz2Rtb/
 B4wqcwg9Yn+rZaJpneYg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t9n54gg73-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 08:19:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5EC46100058;
 Wed, 27 Sep 2023 08:19:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 538FB210F74;
 Wed, 27 Sep 2023 08:19:13 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 08:19:12 +0200
Message-ID: <cc943366-406a-463d-cc77-b67e9d258799@foss.st.com>
Date: Wed, 27 Sep 2023 08:19:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 4/5] ARM: dts: stm32: support display on
 stm32f469-disco board
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Anatolij Gustschin <agust@denx.de>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230903205703.662080-1-dario.binacchi@amarulasolutions.com>
 <20230903205703.662080-5-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230903205703.662080-5-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
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



On 9/3/23 22:57, Dario Binacchi wrote:
> Add support to Orise Tech OTM8009A display on stm32f469-disco board.
> 
> It was necessary to retrieve the framebuffer address from the device tree
> because the address returned by the video-uclass driver pointed to a memory
> area that was not usable.
> 
> Furthermore, unlike Linux, the DSI driver requires the LTDC clock to be
> properly probed. Hence, the changes made to the DSI node in
> stm32f469-disco-u-boot.dtsi.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  arch/arm/dts/stm32f469-disco-u-boot.dtsi |  4 +++
>  configs/stm32f469-discovery_defconfig    | 13 +++++++++
>  drivers/video/stm32/stm32_ltdc.c         | 37 +++++++++++++++++++++++-
>  3 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/stm32f469-disco-u-boot.dtsi b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
> index 8e781c5a7b23..47ba9fa4a783 100644
> --- a/arch/arm/dts/stm32f469-disco-u-boot.dtsi
> +++ b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
> @@ -92,7 +92,9 @@
>  
>  &dsi {
>  	clocks = <&rcc 0 STM32F4_APB2_CLOCK(DSI)>,
> +		 <&rcc 0 STM32F4_APB2_CLOCK(LTDC)>,
>  		 <&clk_hse>;
> +	clock-names = "pclk", "px_clk", "ref";
>  };
>  
>  &gpioa {
> @@ -140,6 +142,8 @@
>  };
>  
>  &ltdc {
> +	bootph-all;
> +
>  	clocks = <&rcc 0 STM32F4_APB2_CLOCK(LTDC)>;
>  };
>  
> diff --git a/configs/stm32f469-discovery_defconfig b/configs/stm32f469-discovery_defconfig
> index 35d18d58be6f..9796b8f2d9a5 100644
> --- a/configs/stm32f469-discovery_defconfig
> +++ b/configs/stm32f469-discovery_defconfig
> @@ -21,6 +21,7 @@ CONFIG_CMD_GPT=y
>  # CONFIG_RANDOM_UUID is not set
>  CONFIG_CMD_MMC=y
>  # CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_BMP=y
>  CONFIG_CMD_CACHE=y
>  CONFIG_CMD_TIMER=y
>  # CONFIG_ISO_PARTITION is not set
> @@ -40,3 +41,15 @@ CONFIG_SPI_FLASH_STMICRO=y
>  CONFIG_SPI=y
>  CONFIG_DM_SPI=y
>  CONFIG_STM32_QSPI=y
> +CONFIG_VIDEO=y
> +CONFIG_BACKLIGHT_GPIO=y
> +CONFIG_VIDEO_LCD_ORISETECH_OTM8009A=y
> +CONFIG_VIDEO_STM32=y
> +CONFIG_VIDEO_STM32_DSI=y
> +CONFIG_VIDEO_STM32_MAX_XRES=480
> +CONFIG_VIDEO_STM32_MAX_YRES=800
> +CONFIG_BMP_16BPP=y
> +CONFIG_BMP_24BPP=y
> +CONFIG_BMP_32BPP=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
> index f48badc517a8..428b0addc43c 100644
> --- a/drivers/video/stm32/stm32_ltdc.c
> +++ b/drivers/video/stm32/stm32_ltdc.c
> @@ -494,6 +494,34 @@ static void stm32_ltdc_set_layer1(struct stm32_ltdc_priv *priv, ulong fb_addr)
>  	setbits_le32(priv->regs + LTDC_L1CR, LXCR_LEN);
>  }
>  
> +#if IS_ENABLED(CONFIG_TARGET_STM32F469_DISCOVERY)

We want to avoid this kind of #define specific to a particular target

> +static int stm32_ltdc_get_fb_addr(struct udevice *dev, ulong *base, uint size,
> +				  uint align)
> +{
> +	phys_addr_t cpu;
> +	dma_addr_t bus;
> +	u64 dma_size;
> +	int ret;
> +
> +	ret = dev_get_dma_range(dev, &cpu, &bus, &dma_size);
> +	if (ret) {
> +		dev_err(dev, "failed to get dma address\n");
> +		return ret;
> +	}
> +
> +	*base = bus + 0x1000000 - ALIGN(size, align);

Why adding 0x1000000 ? avoid to insert const whithout any description and use a #define instead.

> +	return 0;
> +}
> +#else
> +static int stm32_ltdc_get_fb_addr(struct udevice *dev, ulong *base, uint size,
> +				  uint align)
> +{
> +	/* Delegate framebuffer allocation to video-uclass */
> +	*base = 0;
> +	return 0;
> +}
> +#endif
> +
>  static int stm32_ltdc_probe(struct udevice *dev)
>  {
>  	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> @@ -504,7 +532,7 @@ static int stm32_ltdc_probe(struct udevice *dev)
>  	struct display_timing timings;
>  	struct clk pclk;
>  	struct reset_ctl rst;
> -	ulong rate;
> +	ulong rate, fb_base;
>  	int ret;
>  
>  	priv->regs = dev_read_addr_ptr(dev);
> @@ -604,6 +632,13 @@ static int stm32_ltdc_probe(struct udevice *dev)
>  	priv->crop_h = timings.vactive.typ;
>  	priv->alpha = 0xFF;
>  
> +	ret = stm32_ltdc_get_fb_addr(dev, &fb_base, uc_plat->size,
> +				     uc_plat->align);
> +	if (ret)
> +		return ret;
> +
> +	uc_plat->base = fb_base;
> +

It breaks display on stm32f746-disco and also on stm32f769-disco.

Thanks
Patrice

>  	dev_dbg(dev, "%dx%d %dbpp frame buffer at 0x%lx\n",
>  		timings.hactive.typ, timings.vactive.typ,
>  		VNBITS(priv->l2bpp), uc_plat->base);
