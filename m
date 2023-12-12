Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCE6C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 07:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 385F5877BF;
	Tue, 12 Dec 2023 08:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="2CbLpUo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AA4A871A7; Tue, 12 Dec 2023 08:29:22 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EEEE877CB
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 08:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=071050359d=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3BC539Ji028096; Tue, 12 Dec 2023 08:29:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=VWAhYx93piWpFzwF1i3IqUUxdLZmwByHC6gLKF39hEU=; b=2C
 bLpUo6tx05t6nGO2cBevqxcQQTOXQJ9LkHoVLL2HJPu4aayM+718vVog7UI39Vbh
 hkw7qty11VjdJ0aZFw4/jN5wu/9S21TvLA5oIyTFsPIVoJCsH/C/d87zYwqRo4gQ
 LQraO05xz/9gu2kGPjsqZde6k81xKn84mxrVWRzGxr/mJLnUEx3id4Yc8EsHMNMb
 G+e5zBUOa60it12C7AeIVd0fbVnGwdVavISMcS7GqVZTzfTUMhXrWoHc3l+D7Ool
 DVZYtU2PjDc9NxYNQGZSVoPnY3GDio60AU5ovUhLUKVG6gCf1tNow2jWYA1XnQbM
 xO3/caWXukjf38CJoxDA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uvg0gssaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Dec 2023 08:29:18 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C858210005A;
 Tue, 12 Dec 2023 08:29:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BED1020F540;
 Tue, 12 Dec 2023 08:29:17 +0100 (CET)
Received: from [10.201.20.54] (10.201.20.54) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Dec
 2023 08:29:17 +0100
Message-ID: <1158658d-ab5a-4da8-82da-e4dba5a0191b@foss.st.com>
Date: Tue, 12 Dec 2023 08:29:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] board: stm32f469-disco: add support to display
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Anatolij Gustschin <agust@denx.de>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231211220643.1073606-1-dario.binacchi@amarulasolutions.com>
 <20231211220643.1073606-6-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20231211220643.1073606-6-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.54]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_02,2023-12-07_01,2023-05-22_02
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



On 12/11/23 23:05, Dario Binacchi wrote:
> Add support to Orise Tech OTM8009A display on stm32f469-disco board.
> 
> It was necessary to retrieve the framebuffer address from the device tree
> because the address returned by the video-uclass driver pointed to a memory
> area that was not usable.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
> Changes in v3:
> - Replace SDRAM_SIZE constant with global data gd->ram_size.
> 
> Changes in v2:
> - Add DRAM_SIZE macro.
> - Fix frame buffer allocation function so that it is backward compatible
>   with boards other than the one it was introduced for (i. e. stm32f469-disco).
>   Tested on stm32f469-disco and stm32mp157f-dk2 boards.
> 
>  configs/stm32f469-discovery_defconfig | 13 +++++++++++
>  drivers/video/stm32/stm32_ltdc.c      | 31 +++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/configs/stm32f469-discovery_defconfig b/configs/stm32f469-discovery_defconfig
> index 21c5498466cd..85e795e83e7d 100644
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
> index 6fd90e33919d..4f60ba8ebeeb 100644
> --- a/drivers/video/stm32/stm32_ltdc.c
> +++ b/drivers/video/stm32/stm32_ltdc.c
> @@ -495,6 +495,33 @@ static void stm32_ltdc_set_layer1(struct stm32_ltdc_priv *priv, ulong fb_addr)
>  	setbits_le32(priv->regs + LTDC_L1CR, LXCR_LEN);
>  }
>  
> +#if IS_ENABLED(CONFIG_TARGET_STM32F469_DISCOVERY)
> +static int stm32_ltdc_alloc_fb(struct udevice *dev)
> +{
> +	u32 sdram_size = gd->ram_size;
> +	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
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
> +	uc_plat->base = bus + sdram_size - ALIGN(uc_plat->size, uc_plat->align);
> +	return 0;
> +}
> +#else
> +static inline int stm32_ltdc_alloc_fb(struct udevice *dev)
> +{
> +	/* Delegate framebuffer allocation to video-uclass */
> +	return 0;
> +}
> +#endif
> +
>  static int stm32_ltdc_probe(struct udevice *dev)
>  {
>  	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
> @@ -605,6 +632,10 @@ static int stm32_ltdc_probe(struct udevice *dev)
>  	priv->crop_h = timings.vactive.typ;
>  	priv->alpha = 0xFF;
>  
> +	ret = stm32_ltdc_alloc_fb(dev);
> +	if (ret)
> +		return ret;
> +
>  	dev_dbg(dev, "%dx%d %dbpp frame buffer at 0x%lx\n",
>  		timings.hactive.typ, timings.vactive.typ,
>  		VNBITS(priv->l2bpp), uc_plat->base);

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
