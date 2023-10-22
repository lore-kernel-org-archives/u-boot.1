Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD0FCDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 03:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5962887695;
	Sun, 22 Oct 2023 05:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="f7S7wwEV";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="eDeUUg5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE0CF87696; Sun, 22 Oct 2023 05:31:59 +0200 (CEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF87987691
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 05:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 81D055C02A6;
 Sat, 21 Oct 2023 23:31:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Sat, 21 Oct 2023 23:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
 1697945512; x=1698031912; bh=RS8GcRzDoWTO4KA04fcPqVKAcIO4QyakoBW
 OP1XiQO8=; b=f7S7wwEVAvhxGy0Qy3b1VvBWV6zSqoKzlSi++0ushStS0bm4ed2
 BTyrWI1fR07UTZvSdN5eQHodnFx5z/l6qpx8kAPia8B0dy0uXSR4yrmf0q69YisP
 jDe+RxXJRVtpsKkJKr+PR+hxV5fX5qgIabXNqtRYigmHXlHi2ZLA2clihfjtLsYs
 HiRjtWfsDfbNRuELXRRo5noKuHhJx7vkVOAa6LAoMrE9QGoPFNZyPg11Hc/JeHRZ
 6xQtsa/HUHXFbmcRFpvXqX/kA9pEUcncZYJ5+gbkRGlcR6S/4Mfie7pvV79EH8KH
 NL1i7Fx2Bks93r2HZlqqhqY6hDbYmJGmDog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1697945512; x=1698031912; bh=RS8GcRzDoWTO4KA04fcPqVKAcIO4QyakoBW
 OP1XiQO8=; b=eDeUUg5XZq7r7aqHvMbN1v5+czMVWSJuMF0aM2SR5TiB7QEHXWV
 xtiCFM2m3UvU4EGqFpectcFQOVRBp1zxgkj5Hq3EJbrvg5lzh+1EIXUuUb4PBI1c
 hYwklug6dnwzCGMwwVNK5nN0QB7lg/dy2S+8TOyf9kJ5EJjDSoFVvT8TD/7bQSXW
 6yn+AOuMHa6dy+xlg2m2lEubDulh/y4llnID4v88G3uAKrn5olC0DJgkcHJMNEVM
 6LT9e/k/o2Nk+JezVkF56JO0KlDANLfmvJuKlkdN5RqhcB12KPKCZviIoGOs93Ju
 7HgQd7DXiTxRHPklYp1wzSVxvdRdgEREiyg==
X-ME-Sender: <xms:p5c0ZTMCP6P7RSU16B2abpPDQ3i4Catr-XCoRzfZs6bRGE-Lm47MSw>
 <xme:p5c0Zd_dx6aL7nOJdE0527mHA0oktSa3B3IFwHAcI_yS9_2MOyKYAeiPH66g37ZqU
 QjIxYVLVHmGx41Tfw>
X-ME-Received: <xmr:p5c0ZSQqZHfiN4yBB0OtIGfxcPMkI8gs4foujwizvNydpMl6zoBLKA52iLwgUtPm0TNJyt5-xQ20TrKHXR8iVOf0rkQn0CmLbhijt4wC5E0fUjl2ru-udHz46A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedugdejvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepjefgfffhudejfedtuedugeeutdetgfeiteffffehjeeugfeuvdeh
 jeetfedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:p5c0ZXu1lSm2Axzvd2sci_L9fCZ9uTcZAbn-rHY2D52dmxOYQtwEug>
 <xmx:p5c0ZbeLcmmzypKNY7ATZrS0jYT6eig6LoIR1-FP0Srn2OWwJfQO5w>
 <xmx:p5c0ZT2D5s7xVIpR-0f25810w8DLBLkebGNCW39yhbsZxH_zu7zkBg>
 <xmx:qJc0ZazjwejMNPDKzz_ODdNMD0imnThcbCNhnmZy89CgQ4G9qKZDyQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 23:31:51 -0400 (EDT)
Message-ID: <14f5b1f6-81c4-0bd3-e441-d1d47ee6c207@sholland.org>
Date: Sat, 21 Oct 2023 22:31:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng
 <uwu@icenowy.me>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sam Edwards <cfsworks@gmail.com>, Okhunjon Sobirjonov
 <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@foss.arm.com, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de
References: <20230928215455.28094-1-andre.przywara@arm.com>
 <20230928215455.28094-10-andre.przywara@arm.com>
From: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 09/22] pinctrl: sunxi: add new D1 pinctrl support
In-Reply-To: <20230928215455.28094-10-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Andre,

On 9/28/23 16:54, Andre Przywara wrote:
> For the first time since at least the Allwinner A10 SoCs, the D1 (and
> related cores) use a new pincontroller MMIO register layout, so we
> cannot use our hardcoded, fixed offsets anymore.
> Ideally this would all be handled by devicetree and DM drivers, but for
> the DT-less SPL we still need the legacy interfaces.
> 
> Add a new Kconfig symbol to differenciate between the two generations of
> pincontrollers, and just use that to just switch some basic symbols.
> The rest is already abstracted enough, so works out of the box.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Sam Edwards <CFSworks@gmail.com>
> Tested-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  arch/arm/mach-sunxi/Kconfig |  6 ++++++
>  drivers/gpio/sunxi_gpio.c   | 17 +++++++++++++++--
>  include/sunxi_gpio.h        | 10 ++++++++--
>  3 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index d3ed62add99..d73c5e67050 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -158,6 +158,12 @@ config SUNXI_RVBAR_ALTERNATIVE
>  config SUNXI_A64_TIMER_ERRATUM
>  	bool
>  
> +config SUNXI_NEW_PINCTRL

Please put this in drivers/gpio/Kconfig so it can be selected on RISC-V
(ARCH_SUNXI=n). With that:

Tested-by: Samuel Holland <samuel@sholland.org>

Regards,
Samuel

> +	bool
> +	---help---
> +	The Allwinner D1 and other new SoCs use a different register map
> +	for the GPIO block, which we need to know about in the SPL.
> +
>  # Note only one of these may be selected at a time! But hidden choices are
>  # not supported by Kconfig
>  config SUNXI_GEN_SUN4I
> diff --git a/drivers/gpio/sunxi_gpio.c b/drivers/gpio/sunxi_gpio.c
> index b52569104b7..c50996d0e12 100644
> --- a/drivers/gpio/sunxi_gpio.c
> +++ b/drivers/gpio/sunxi_gpio.c
> @@ -40,10 +40,23 @@
>  #define GPIO_DAT_REG_OFFSET	0x10
>  
>  #define GPIO_DRV_REG_OFFSET	0x14
> -#define GPIO_DRV_INDEX(pin)	(((pin) & 0x1f) >> 4)
> -#define GPIO_DRV_OFFSET(pin)	((((pin) & 0x1f) & 0xf) << 1)
> +
> +/*		Newer SoCs use a slightly different register layout */
> +#ifdef CONFIG_SUNXI_NEW_PINCTRL
> +/* pin drive strength: 4 bits per pin */
> +#define GPIO_DRV_INDEX(pin)	((pin) / 8)
> +#define GPIO_DRV_OFFSET(pin)	(((pin) % 8) * 4)
> +
> +#define GPIO_PULL_REG_OFFSET	0x24
> +
> +#else /* older generation pin controllers */
> +/* pin drive strength: 2 bits per pin */
> +#define GPIO_DRV_INDEX(pin)	((pin) / 16)
> +#define GPIO_DRV_OFFSET(pin)	(((pin) % 16) * 2)
>  
>  #define GPIO_PULL_REG_OFFSET	0x1c
> +#endif
> +
>  #define GPIO_PULL_INDEX(pin)	(((pin) & 0x1f) >> 4)
>  #define GPIO_PULL_OFFSET(pin)	((((pin) & 0x1f) & 0xf) << 1)
>  
> diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
> index c1fdf7ea1d7..30d8879dbd3 100644
> --- a/include/sunxi_gpio.h
> +++ b/include/sunxi_gpio.h
> @@ -62,7 +62,6 @@
>  #define SUN50I_H6_GPIO_POW_MOD_VAL	0x348
>  
>  #define SUNXI_GPIOS_PER_BANK	32
> -#define SUNXI_PINCTRL_BANK_SIZE 0x24
>  
>  #define SUNXI_GPIO_NEXT(__gpio) \
>  	((__gpio##_START) + SUNXI_GPIOS_PER_BANK)
> @@ -102,7 +101,6 @@ enum sunxi_gpio_number {
>  /* GPIO pin function config */
>  #define SUNXI_GPIO_INPUT	0
>  #define SUNXI_GPIO_OUTPUT	1
> -#define SUNXI_GPIO_DISABLE	7
>  
>  #define SUN8I_H3_GPA_UART0	2
>  #define SUN8I_H3_GPA_UART2	2
> @@ -171,6 +169,14 @@ enum sunxi_gpio_number {
>  
>  #define SUN9I_GPN_R_RSB		3
>  
> +#ifdef CONFIG_SUNXI_NEW_PINCTRL
> +	#define SUNXI_PINCTRL_BANK_SIZE	0x30
> +	#define SUNXI_GPIO_DISABLE	0xf
> +#else
> +	#define SUNXI_PINCTRL_BANK_SIZE	0x24
> +	#define SUNXI_GPIO_DISABLE	0x7
> +#endif
> +
>  /* GPIO pin pull-up/down config */
>  #define SUNXI_GPIO_PULL_DISABLE	0
>  #define SUNXI_GPIO_PULL_UP	1

