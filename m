Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1F7C0032E
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 08:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9562287590;
	Sat, 21 Oct 2023 10:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="WN2pVP3N";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="AjYdmHRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DF57875B5; Sat, 21 Oct 2023 10:37:24 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38F8C87588
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 10:37:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailout.nyi.internal (Postfix) with ESMTP id 5DD9E5C00E6;
 Sat, 21 Oct 2023 04:37:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Sat, 21 Oct 2023 04:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
 1697877433; x=1697963833; bh=FAGsFPew1fKjSZoKYRVYLYPlLFFcloLU1eb
 i48uwvP0=; b=WN2pVP3NChDo46VMKDvoN/8DWE1WNz6a/TCeBhHjTDlL82KDMst
 H4s9wohWrR3dy2zHT1BKo1YZnHBZ+hjHUaaXO0+JfRS2fWu78i6wN9SBI1uOXpK+
 8hRaAqpG9vzbO3fmJlgX6OXjl7IEAgNPv0H1XGO7eHbQGUDXms1gafKYVWx3d64d
 +m0oOrvi2IcghAJQU+0xZCCBaDhoHtIFEIjnckDOYzsFCwsyPH+CqIzY+LUQUwyQ
 svvqsDE3ZXDMYjk5avClrR55aofXJ7iJrGGo9s52hM2AA0Fqq2BfDTxzt1kRHmEm
 TmwZf699k1gcjsmqyFrKNyLEagYstnumBeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1697877433; x=1697963833; bh=FAGsFPew1fKjSZoKYRVYLYPlLFFcloLU1eb
 i48uwvP0=; b=AjYdmHREbTxEGyNL0Zb7xfWrcBhL0hefjocfHpGwY97mZSn3Q9q
 90L33s4cZAwB33CrhJcqyEbMsPFrVE4PYCJlciRfVemuelH5gDL3PU7r0q9bCauv
 nrMQi3RoQPIxpPEHpQFjU5ruIJ9iFt4DD/8WW2YBWoMmML7jGFMhX7GII6R/wXlk
 OHcVw82vaajedpzL059H/Iu/AwLxJcxaWSH7waWflqrxhk0gqJxNzVueM8MmvrzV
 XQKTsf7Ojq7wPQ+e8MUQLermGMDXpMp7MIhy020Q36yJ/HXE+87AY1F4K0Nama2K
 m3gwPXeESNNCrHwSRuYuwXz4y4WZfLrNbCQ==
X-ME-Sender: <xms:uI0zZdAq8zZkHb-Pj6rfSXdHPJ47ZMtCyO3q4veeloIEjsQeDTItnw>
 <xme:uI0zZbg2tv2dpoD6bKB-G5DdIcF3qj7o9xi_LaxiJFC66R_CXHVQeiKIOijNgSQjD
 jsd720wwE50IxGSuQ>
X-ME-Received: <xmr:uI0zZYn0vrSZ4RzsfShuh32zJ7wqPX2Wq0wL_Ohrdz9oVgyDlLc1TJ28F-0Rce0AsPrKAQ08AlujDvFoQaVQFa_yqR-qB_7UKzghioOrxgQM0gWcxEJB46qMxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedtgddtvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeelleef
 tdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:uI0zZXygMAZ5LsATj1ERUgZtrYaprgR7TqTU33wrnkVfkQgGwwpElQ>
 <xmx:uI0zZSSBdwm3HQdVOgdX5sz_OAdMUz9ixNdYrq4AX_lzT-TMfhMq4Q>
 <xmx:uI0zZabw_ithe-Q8443FPYZHJu3H2v-bxjl30fCT-qEQYHfo_SSkfw>
 <xmx:uY0zZVERKMjLrMTxghzC7xcoF02CxfDoJD4jn6HjMqgmsJE3XR6K-w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 04:37:11 -0400 (EDT)
Message-ID: <a34659c9-c761-2dab-45c6-5499f518ae02@sholland.org>
Date: Sat, 21 Oct 2023 03:37:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 06/22] pinctrl: sunxi: remove struct sunxi_gpio
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng
 <uwu@icenowy.me>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sam Edwards <cfsworks@gmail.com>, Okhunjon Sobirjonov
 <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@foss.arm.com, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de
References: <20230928215455.28094-1-andre.przywara@arm.com>
 <20230928215455.28094-7-andre.przywara@arm.com>
From: Samuel Holland <samuel@sholland.org>
In-Reply-To: <20230928215455.28094-7-andre.przywara@arm.com>
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
> So far every Allwinner SoC used the same basic pincontroller/GPIO
> register frame, and just differed by the number of implemented banks and
> pins, plus some special functionality from time to time. However the D1
> and successors use a slightly different pinctrl register layout.
> Use that opportunity to drop "struct sunxi_gpio", that described that
> MMIO frame in a C struct. That approach is somewhat frowned upon in the
> Linux world and rarely used there, though still popular with U-Boot.
> 
> Switching from a C struct to a "base address plus offset" approach allows
> to switch between the two models more dynamically, without reverting to
> preprocessor macros and #ifdef's.
> 
> Model the pinctrl MMIO register frame in the usual "base address +
> offset" way, and replace a hard-to-parse CPP macro with a more readable
> static function.
> All the users get converted over. There are no functional changes at
> this point, it just prepares the stages for the D1 and friends.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/include/asm/arch-sunxi/gpio.h | 40 ++----------
>  drivers/gpio/sunxi_gpio.c              | 88 ++++++++++++++++----------
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c  | 14 ++--
>  3 files changed, 66 insertions(+), 76 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/gpio.h b/arch/arm/include/asm/arch-sunxi/gpio.h
> index 4bc9e8ffcc9..e0fb5b5da63 100644
> --- a/arch/arm/include/asm/arch-sunxi/gpio.h
> +++ b/arch/arm/include/asm/arch-sunxi/gpio.h
> @@ -31,13 +31,6 @@
>  #define SUNXI_GPIO_H	7
>  #define SUNXI_GPIO_I	8
>  
> -/*
> - * This defines the number of GPIO banks for the _main_ GPIO controller.
> - * You should fix up the padding in struct sunxi_gpio_reg below if you
> - * change this.
> - */
> -#define SUNXI_GPIO_BANKS 9
> -
>  /*
>   * sun6i/sun8i and later SoCs have an additional GPIO controller (R_PIO)
>   * at a different register offset.
> @@ -55,32 +48,11 @@
>  #define SUNXI_GPIO_M	12
>  #define SUNXI_GPIO_N	13
>  
> -struct sunxi_gpio {
> -	u32 cfg[4];
> -	u32 dat;
> -	u32 drv[2];
> -	u32 pull[2];
> -};
> -
> -/* gpio interrupt control */
> -struct sunxi_gpio_int {
> -	u32 cfg[3];
> -	u32 ctl;
> -	u32 sta;
> -	u32 deb;		/* interrupt debounce */
> -};
> -
> -struct sunxi_gpio_reg {
> -	struct sunxi_gpio gpio_bank[SUNXI_GPIO_BANKS];
> -	u8 res[0xbc];
> -	struct sunxi_gpio_int gpio_int;
> -};
> -
>  #define SUN50I_H6_GPIO_POW_MOD_SEL	0x340
>  #define SUN50I_H6_GPIO_POW_MOD_VAL	0x348
>  
> -/* GPIO bank sizes */
>  #define SUNXI_GPIOS_PER_BANK	32
> +#define SUNXI_PINCTRL_BANK_SIZE 0x24
>  
>  #define SUNXI_GPIO_NEXT(__gpio) \
>  	((__gpio##_START) + SUNXI_GPIOS_PER_BANK)
> @@ -200,19 +172,19 @@ enum sunxi_gpio_number {
>  #define SUNXI_GPIO_AXP0_GPIO_COUNT	6
>  
>  struct sunxi_gpio_plat {
> -	struct sunxi_gpio	*regs;
> +	void			*regs;
>  	char			bank_name[3];
>  };
>  
>  /* prototypes for the non-DM GPIO/pinctrl functions, used in the SPL */
> -void sunxi_gpio_set_cfgbank(struct sunxi_gpio *pio, int bank_offset, u32 val);
> +void sunxi_gpio_set_cfgbank(void *bank_base, int pin_offset, u32 val);
>  void sunxi_gpio_set_cfgpin(u32 pin, u32 val);
> -int sunxi_gpio_get_cfgbank(struct sunxi_gpio *pio, int bank_offset);
> +int sunxi_gpio_get_cfgbank(void *bank_base, int pin_offset);
>  int sunxi_gpio_get_cfgpin(u32 pin);
>  void sunxi_gpio_set_drv(u32 pin, u32 val);
> -void sunxi_gpio_set_drv_bank(struct sunxi_gpio *pio, u32 bank_offset, u32 val);
> +void sunxi_gpio_set_drv_bank(void *bank_base, u32 pin_offset, u32 val);
>  void sunxi_gpio_set_pull(u32 pin, u32 val);
> -void sunxi_gpio_set_pull_bank(struct sunxi_gpio *pio, int bank_offset, u32 val);
> +void sunxi_gpio_set_pull_bank(void *bank_base, int pin_offset, u32 val);
>  int sunxi_name_to_gpio(const char *name);
>  
>  #if !defined CONFIG_SPL_BUILD && defined CONFIG_AXP_GPIO
> diff --git a/drivers/gpio/sunxi_gpio.c b/drivers/gpio/sunxi_gpio.c
> index a4b336943b6..fe3f6ed0938 100644
> --- a/drivers/gpio/sunxi_gpio.c
> +++ b/drivers/gpio/sunxi_gpio.c
> @@ -29,45 +29,61 @@
>   * =======================================================================
>   */
>  
> -#define BANK_TO_GPIO(bank)	(((bank) < SUNXI_GPIO_L) ? \
> -	&((struct sunxi_gpio_reg *)SUNXI_PIO_BASE)->gpio_bank[bank] : \
> -	&((struct sunxi_gpio_reg *)SUNXI_R_PIO_BASE)->gpio_bank[(bank) - SUNXI_GPIO_L])
> -
>  #define GPIO_BANK(pin)		((pin) >> 5)
>  #define GPIO_NUM(pin)		((pin) & 0x1f)
>  
> +#define GPIO_CFG_REG_OFFSET	0x00
>  #define GPIO_CFG_INDEX(pin)	(((pin) & 0x1f) >> 3)
>  #define GPIO_CFG_OFFSET(pin)	((((pin) & 0x1f) & 0x7) << 2)
>  
> +#define GPIO_DAT_REG_OFFSET	0x10
> +
> +#define GPIO_DRV_REG_OFFSET	0x14
>  #define GPIO_DRV_INDEX(pin)	(((pin) & 0x1f) >> 4)
>  #define GPIO_DRV_OFFSET(pin)	((((pin) & 0x1f) & 0xf) << 1)
>  
> +#define GPIO_PULL_REG_OFFSET	0x1c
>  #define GPIO_PULL_INDEX(pin)	(((pin) & 0x1f) >> 4)
>  #define GPIO_PULL_OFFSET(pin)	((((pin) & 0x1f) & 0xf) << 1)

Now that we've ensured the *_bank functions only get called with pin
numbers in the range 0-31, we don't need the masking anymore. But this
can be a later cleanup.

Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org>

>  
> -void sunxi_gpio_set_cfgbank(struct sunxi_gpio *pio, int bank_offset, u32 val)
> +static void* BANK_TO_GPIO(int bank)
> +{
> +	void *pio_base;
> +
> +	if (bank < SUNXI_GPIO_L) {
> +		pio_base = (void *)(uintptr_t)SUNXI_PIO_BASE;
> +	} else {
> +		pio_base = (void *)(uintptr_t)SUNXI_R_PIO_BASE;
> +		bank -= SUNXI_GPIO_L;
> +	}
> +
> +	return pio_base + bank * SUNXI_PINCTRL_BANK_SIZE;
> +}
> +
> +void sunxi_gpio_set_cfgbank(void *bank_base, int pin_offset, u32 val)
>  {
> -	u32 index = GPIO_CFG_INDEX(bank_offset);
> -	u32 offset = GPIO_CFG_OFFSET(bank_offset);
> +	u32 index = GPIO_CFG_INDEX(pin_offset);
> +	u32 offset = GPIO_CFG_OFFSET(pin_offset);
>  
> -	clrsetbits_le32(&pio->cfg[index], 0xf << offset, val << offset);
> +	clrsetbits_le32(bank_base + GPIO_CFG_REG_OFFSET + index * 4,
> +			0xfU << offset, val << offset);
>  }
>  
>  void sunxi_gpio_set_cfgpin(u32 pin, u32 val)
>  {
>  	u32 bank = GPIO_BANK(pin);
> -	struct sunxi_gpio *pio = BANK_TO_GPIO(bank);
> +	void *pio = BANK_TO_GPIO(bank);
>  
> -	sunxi_gpio_set_cfgbank(pio, pin, val);
> +	sunxi_gpio_set_cfgbank(pio, GPIO_NUM(pin), val);
>  }
>  
> -int sunxi_gpio_get_cfgbank(struct sunxi_gpio *pio, int bank_offset)
> +int sunxi_gpio_get_cfgbank(void *bank_base, int pin_offset)
>  {
> -	u32 index = GPIO_CFG_INDEX(bank_offset);
> -	u32 offset = GPIO_CFG_OFFSET(bank_offset);
> +	u32 index = GPIO_CFG_INDEX(pin_offset);
> +	u32 offset = GPIO_CFG_OFFSET(pin_offset);
>  	u32 cfg;
>  
> -	cfg = readl(&pio->cfg[index]);
> +	cfg = readl(bank_base + GPIO_CFG_REG_OFFSET + index * 4);
>  	cfg >>= offset;
>  
>  	return cfg & 0xf;
> @@ -76,54 +92,56 @@ int sunxi_gpio_get_cfgbank(struct sunxi_gpio *pio, int bank_offset)
>  int sunxi_gpio_get_cfgpin(u32 pin)
>  {
>  	u32 bank = GPIO_BANK(pin);
> -	struct sunxi_gpio *pio = BANK_TO_GPIO(bank);
> +	void *bank_base = BANK_TO_GPIO(bank);
>  
> -	return sunxi_gpio_get_cfgbank(pio, pin);
> +	return sunxi_gpio_get_cfgbank(bank_base, GPIO_NUM(pin));
>  }
>  
> -static void sunxi_gpio_set_output_bank(struct sunxi_gpio *pio,
> -				       int pin, bool set)
> +static void sunxi_gpio_set_output_bank(void *bank_base, int pin, bool set)
>  {
>  	u32 mask = 1U << pin;
>  
> -	clrsetbits_le32(&pio->dat, set ? 0 : mask, set ? mask : 0);
> +	clrsetbits_le32(bank_base + GPIO_DAT_REG_OFFSET,
> +			set ? 0 : mask, set ? mask : 0);
>  }
>  
> -static int sunxi_gpio_get_output_bank(struct sunxi_gpio *pio, int pin)
> +static int sunxi_gpio_get_output_bank(void *bank_base, int pin)
>  {
> -	return !!(readl(&pio->dat) & (1U << pin));
> +	return !!(readl(bank_base + GPIO_DAT_REG_OFFSET) & (1U << pin));
>  }
>  
>  void sunxi_gpio_set_drv(u32 pin, u32 val)
>  {
>  	u32 bank = GPIO_BANK(pin);
> -	struct sunxi_gpio *pio = BANK_TO_GPIO(bank);
> +	void *bank_base = BANK_TO_GPIO(bank);
>  
> -	sunxi_gpio_set_drv_bank(pio, pin, val);
> +	sunxi_gpio_set_drv_bank(bank_base, GPIO_NUM(pin), val);
>  }
>  
> -void sunxi_gpio_set_drv_bank(struct sunxi_gpio *pio, u32 bank_offset, u32 val)
> +void sunxi_gpio_set_drv_bank(void *bank_base, u32 pin_offset, u32 val)
>  {
> -	u32 index = GPIO_DRV_INDEX(bank_offset);
> -	u32 offset = GPIO_DRV_OFFSET(bank_offset);
> +	u32 index = GPIO_DRV_INDEX(pin_offset);
> +	u32 offset = GPIO_DRV_OFFSET(pin_offset);
>  
> -	clrsetbits_le32(&pio->drv[index], 0x3 << offset, val << offset);
> +	clrsetbits_le32(bank_base + GPIO_DRV_REG_OFFSET + index * 4,
> +			0x3U << offset, val << offset);
>  }
>  
>  void sunxi_gpio_set_pull(u32 pin, u32 val)
>  {
>  	u32 bank = GPIO_BANK(pin);
> -	struct sunxi_gpio *pio = BANK_TO_GPIO(bank);
> +	void *bank_base = BANK_TO_GPIO(bank);
>  
> -	sunxi_gpio_set_pull_bank(pio, pin, val);
> +	sunxi_gpio_set_pull_bank(bank_base, GPIO_NUM(pin), val);
>  }
>  
> -void sunxi_gpio_set_pull_bank(struct sunxi_gpio *pio, int bank_offset, u32 val)
> +void sunxi_gpio_set_pull_bank(void *bank_base, int pin_offset, u32 val)
>  {
> -	u32 index = GPIO_PULL_INDEX(bank_offset);
> -	u32 offset = GPIO_PULL_OFFSET(bank_offset);
> +	u32 index = GPIO_PULL_INDEX(pin_offset);
> +	u32 offset = GPIO_PULL_OFFSET(pin_offset);
>  
> -	clrsetbits_le32(&pio->pull[index], 0x3 << offset, val << offset);
> +	clrsetbits_le32(bank_base + GPIO_PULL_REG_OFFSET + index * 4,
> +			0x3U << offset, val << offset);
>  }
>  
>  
> @@ -133,7 +151,7 @@ void sunxi_gpio_set_pull_bank(struct sunxi_gpio *pio, int bank_offset, u32 val)
>  static void sunxi_gpio_set_output(u32 pin, bool set)
>  {
>  	u32 bank = GPIO_BANK(pin);
> -	struct sunxi_gpio *pio = BANK_TO_GPIO(bank);
> +	void *pio = BANK_TO_GPIO(bank);
>  
>  	sunxi_gpio_set_output_bank(pio, GPIO_NUM(pin), set);
>  }
> @@ -141,7 +159,7 @@ static void sunxi_gpio_set_output(u32 pin, bool set)
>  static int sunxi_gpio_get_output(u32 pin)
>  {
>  	u32 bank = GPIO_BANK(pin);
> -	struct sunxi_gpio *pio = BANK_TO_GPIO(bank);
> +	void *pio = BANK_TO_GPIO(bank);
>  
>  	return sunxi_gpio_get_output_bank(pio, GPIO_NUM(pin));
>  }
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index e5102180902..946447e9136 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -35,7 +35,7 @@ struct sunxi_pinctrl_desc {
>  };
>  
>  struct sunxi_pinctrl_plat {
> -	struct sunxi_gpio __iomem *base;
> +	void __iomem *base;
>  };
>  
>  static int sunxi_pinctrl_get_pins_count(struct udevice *dev)
> @@ -86,8 +86,8 @@ static int sunxi_pinctrl_pinmux_set(struct udevice *dev, uint pin_selector,
>  	      sunxi_pinctrl_get_function_name(dev, func_selector),
>  	      desc->functions[func_selector].mux);
>  
> -	sunxi_gpio_set_cfgbank(plat->base + bank, pin,
> -			       desc->functions[func_selector].mux);
> +	sunxi_gpio_set_cfgbank(plat->base + bank * SUNXI_PINCTRL_BANK_SIZE,
> +			       pin, desc->functions[func_selector].mux);
>  
>  	return 0;
>  }
> @@ -102,7 +102,7 @@ static const struct pinconf_param sunxi_pinctrl_pinconf_params[] = {
>  static int sunxi_pinctrl_pinconf_set_pull(struct sunxi_pinctrl_plat *plat,
>  					  uint bank, uint pin, uint bias)
>  {
> -	struct sunxi_gpio *regs = &plat->base[bank];
> +	void *regs = plat->base + bank * SUNXI_PINCTRL_BANK_SIZE;
>  
>  	sunxi_gpio_set_pull_bank(regs, pin, bias);
>  
> @@ -112,7 +112,7 @@ static int sunxi_pinctrl_pinconf_set_pull(struct sunxi_pinctrl_plat *plat,
>  static int sunxi_pinctrl_pinconf_set_drive(struct sunxi_pinctrl_plat *plat,
>  					   uint bank, uint pin, uint drive)
>  {
> -	struct sunxi_gpio *regs = &plat->base[bank];
> +	void *regs = plat->base + bank * SUNXI_PINCTRL_BANK_SIZE;
>  
>  	if (drive < 10 || drive > 40)
>  		return -EINVAL;
> @@ -148,7 +148,7 @@ static int sunxi_pinctrl_get_pin_muxing(struct udevice *dev, uint pin_selector,
>  	struct sunxi_pinctrl_plat *plat = dev_get_plat(dev);
>  	int bank = pin_selector / SUNXI_GPIOS_PER_BANK;
>  	int pin	 = pin_selector % SUNXI_GPIOS_PER_BANK;
> -	int mux  = sunxi_gpio_get_cfgbank(plat->base + bank, pin);
> +	int mux  = sunxi_gpio_get_cfgbank(plat->base + bank * SUNXI_PINCTRL_BANK_SIZE, pin);
>  
>  	switch (mux) {
>  	case SUNXI_GPIO_INPUT:
> @@ -206,7 +206,7 @@ static int sunxi_pinctrl_bind(struct udevice *dev)
>  		if (!gpio_plat)
>  			return -ENOMEM;
>  
> -		gpio_plat->regs = plat->base + i;
> +		gpio_plat->regs = plat->base + i * SUNXI_PINCTRL_BANK_SIZE;
>  		gpio_plat->bank_name[0] = 'P';
>  		gpio_plat->bank_name[1] = 'A' + desc->first_bank + i;
>  		gpio_plat->bank_name[2] = '\0';

