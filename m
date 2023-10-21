Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20716C0032E
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 08:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F447875DD;
	Sat, 21 Oct 2023 10:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="U2fy3QzK";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="VuRQQhW7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3C1E8756B; Sat, 21 Oct 2023 10:30:56 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2253D8756B
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 10:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 7C6985C006F;
 Sat, 21 Oct 2023 04:30:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Sat, 21 Oct 2023 04:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
 1697877050; x=1697963450; bh=VI1ebVPlyC5IGsmoJtgsFlAzBj75UoYDCVp
 vXh07foQ=; b=U2fy3QzKIdgxRtVT/dseUs6KR/TPOdOYBN8PTE849bg9xu9jw3R
 kQeUvxBn50dy7iEvqqkCYwShzeFCQ7K4Tnnvpj2szlrt7Mhwy12nchsAyoGdA/fd
 kk0pGoFwEy5XGkENz4p3wDoztHfVJAqU28FgWkEm5uvV4CZ/MjzWAlK/2xIyZMyC
 jzOT9IVoRJgNQr7Ftfx5wYlvLYz99uiJ7xE33ptXeVxAbaZ4R8BGx4Xk9U5j+Qrh
 XNdG7awkER/XFLjKo4br0tARJrohbnx4jFfp7Z4AVplEV47ERofSE0uhPUtty23k
 3554LpzbWeaXIrBVFdUuFc4AaQaAHJOAfWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1697877050; x=1697963450; bh=VI1ebVPlyC5IGsmoJtgsFlAzBj75UoYDCVp
 vXh07foQ=; b=VuRQQhW731k7IG0KjHFRdPvn87BgqOHZrR395EBgKNSlED/cdZK
 DvENUPE6+t+ggqVY46KwfpwmyC6ADVf8A0XId3cWbXdkidRViyAnzXOdp6qn0kGP
 YMIlKnDzs2mfoyojMmsaoXnItCBAGBcolHp+iL41TKAPq6yY/rbmuC1J03H9Rc7x
 Rue4ZpKCS7E3563Z04emcX5yo/fGK6Wj5YVYoRsAX0ou1Gx0ASybIppZPQt1wapv
 AiDS15RhO76zcW4uvcnJGWKA8D7f5lrhFo8yTbWE0+UJERcsojb2ed2a8A+kyivc
 cj7LWbIpLILQmdb1vr+2kNexjjvjKvzrQ+Q==
X-ME-Sender: <xms:OYwzZUAp9X_0xECGfkClm2hXvmRliVIwYZYvDt_5rCNzXxiKf7oT3Q>
 <xme:OYwzZWgsaI2LBiqQ1dEnEC810eGdxkx0Ro_wxEHtUoGWU1owngGNfHmxJyICRgZ6F
 V-qxkLvd5qyggReLg>
X-ME-Received: <xmr:OYwzZXmwgOSprzfaNu9iflGOR4WlNxdoj12WJ7Kq8rwfz2XKkZ1Ku6b_Oqsd-snFVd5LflbHCMsHsIq6gwQbtKBCWDE9wJMsD9ObVkhoKl2m3bHkUN4-5I9BKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedtgddtudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepjefgfffhudejfedtuedugeeutdetgfeiteffffehjeeugfeuvdeh
 jeetfedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:OYwzZaxFx8tDg98cee8Iy2FFng5SOsD4k5tnVGnzrXeXq9RJCgdXIA>
 <xmx:OYwzZZT2RGuMtAiNReZZTL1J3es8SxowH3d_Cvl7Apc0Me2pEqjEZg>
 <xmx:OYwzZVaRPMt0UmVhVgGqUn3pCjPg6m0jRnjX83c4EoEnInzB_C9BUw>
 <xmx:OowzZUGpkJS0EcE110H9jTR771sEC9GZ77RGipml4_9eY4IMsKlnqQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 04:30:49 -0400 (EDT)
Message-ID: <62360412-0e23-b35d-b93a-7bebebe83adf@sholland.org>
Date: Sat, 21 Oct 2023 03:30:48 -0500
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
 <20230928215455.28094-6-andre.przywara@arm.com>
From: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 05/22] pinctrl: sunxi: add GPIO in/out wrappers
In-Reply-To: <20230928215455.28094-6-andre.przywara@arm.com>
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
> So far we were open-coding the pincontroller's GPIO output/input access
> in each function using that.
> 
> Provide functions that wrap that nicely, and follow the existing pattern
> (set/get_{bank,}), so users don't need to know about the internals, and
> we can abstract the new D1 pinctrl more easily.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/gpio/sunxi_gpio.c | 55 ++++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpio/sunxi_gpio.c b/drivers/gpio/sunxi_gpio.c
> index 71c3168b755..a4b336943b6 100644
> --- a/drivers/gpio/sunxi_gpio.c
> +++ b/drivers/gpio/sunxi_gpio.c
> @@ -81,6 +81,19 @@ int sunxi_gpio_get_cfgpin(u32 pin)
>  	return sunxi_gpio_get_cfgbank(pio, pin);
>  }
>  
> +static void sunxi_gpio_set_output_bank(struct sunxi_gpio *pio,
> +				       int pin, bool set)
> +{
> +	u32 mask = 1U << pin;
> +
> +	clrsetbits_le32(&pio->dat, set ? 0 : mask, set ? mask : 0);
> +}
> +
> +static int sunxi_gpio_get_output_bank(struct sunxi_gpio *pio, int pin)

"get_output" is a bit misleading when this pin is an input, so maybe
"set_value" and "get_value" would be more accurate.

> +{
> +	return !!(readl(&pio->dat) & (1U << pin));
> +}
> +
>  void sunxi_gpio_set_drv(u32 pin, u32 val)
>  {
>  	u32 bank = GPIO_BANK(pin);
> @@ -117,35 +130,20 @@ void sunxi_gpio_set_pull_bank(struct sunxi_gpio *pio, int bank_offset, u32 val)
>  /* =========== Non-DM code, used by the SPL. ============ */
>  
>  #if !CONFIG_IS_ENABLED(DM_GPIO)
> -static int sunxi_gpio_output(u32 pin, u32 val)
> +static void sunxi_gpio_set_output(u32 pin, bool set)
>  {
> -	u32 dat;
>  	u32 bank = GPIO_BANK(pin);
> -	u32 num = GPIO_NUM(pin);
>  	struct sunxi_gpio *pio = BANK_TO_GPIO(bank);
>  
> -	dat = readl(&pio->dat);
> -	if (val)
> -		dat |= 0x1 << num;
> -	else
> -		dat &= ~(0x1 << num);
> -
> -	writel(dat, &pio->dat);
> -
> -	return 0;
> +	sunxi_gpio_set_output_bank(pio, GPIO_NUM(pin), set);
>  }
>  
> -static int sunxi_gpio_input(u32 pin)
> +static int sunxi_gpio_get_output(u32 pin)
>  {
> -	u32 dat;
>  	u32 bank = GPIO_BANK(pin);
> -	u32 num = GPIO_NUM(pin);
>  	struct sunxi_gpio *pio = BANK_TO_GPIO(bank);
>  
> -	dat = readl(&pio->dat);
> -	dat >>= num;
> -
> -	return dat & 0x1;
> +	return sunxi_gpio_get_output_bank(pio, GPIO_NUM(pin));
>  }
>  
>  int gpio_request(unsigned gpio, const char *label)
> @@ -168,18 +166,21 @@ int gpio_direction_input(unsigned gpio)
>  int gpio_direction_output(unsigned gpio, int value)
>  {
>  	sunxi_gpio_set_cfgpin(gpio, SUNXI_GPIO_OUTPUT);
> +	sunxi_gpio_set_output(gpio, value);
>  
> -	return sunxi_gpio_output(gpio, value);
> +	return 0;
>  }
>  
>  int gpio_get_value(unsigned gpio)
>  {
> -	return sunxi_gpio_input(gpio);
> +	return sunxi_gpio_get_output(gpio);
>  }
>  
>  int gpio_set_value(unsigned gpio, int value)
>  {
> -	return sunxi_gpio_output(gpio, value);
> +	sunxi_gpio_set_output(gpio, value);
> +
> +	return 0;
>  }
>  
>  int sunxi_name_to_gpio(const char *name)
> @@ -231,13 +232,8 @@ int sunxi_name_to_gpio(const char *name)
>  static int sunxi_gpio_get_value(struct udevice *dev, unsigned offset)
>  {
>  	struct sunxi_gpio_plat *plat = dev_get_plat(dev);
> -	u32 num = GPIO_NUM(offset);
> -	unsigned dat;
> -
> -	dat = readl(&plat->regs->dat);
> -	dat >>= num;
>  
> -	return dat & 0x1;
> +	return sunxi_gpio_get_output_bank(plat->regs, offset) & 0x1;

You don't need the "& 0x1" anymore. Otherwise:

Reviewed-by: Samuel Holland <samuel@sholland.org>

>  }
>  
>  static int sunxi_gpio_get_function(struct udevice *dev, unsigned offset)
> @@ -275,9 +271,8 @@ static int sunxi_gpio_set_flags(struct udevice *dev, unsigned int offset,
>  
>  	if (flags & GPIOD_IS_OUT) {
>  		u32 value = !!(flags & GPIOD_IS_OUT_ACTIVE);
> -		u32 num = GPIO_NUM(offset);
>  
> -		clrsetbits_le32(&plat->regs->dat, 1 << num, value << num);
> +		sunxi_gpio_set_output_bank(plat->regs, offset, value);
>  		sunxi_gpio_set_cfgbank(plat->regs, offset, SUNXI_GPIO_OUTPUT);
>  	} else if (flags & GPIOD_IS_IN) {
>  		u32 pull = 0;

