Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341E8CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 15:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3EAB83BA1;
	Mon, 10 Nov 2025 16:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="LvOESeBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8A483980; Mon, 10 Nov 2025 16:42:46 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C011383C53
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 16:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42b387483bbso1052003f8f.1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 07:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762789363; x=1763394163; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+yk26Aua9dx9EZiQJjb8WWXvJlMXblkKMuTKCeu0Cv0=;
 b=LvOESeBdkplyQ//YNMuZP4zf96ha74IeiRyT1he/KV+LSKre1txGLtn9If5neTW6dX
 fzmzpKl0BIh8qES/33Lq+GtWOSHtVn92M49sp80rtjUASUly7TDYk4ZJsQVZYL1VNKEH
 NLBoU/JSsra7PD7zYpzgTwSflpc7+To60hGd/Z9PjpdwH7lbcdo5gdD89z1CB0cMgVFx
 rpxEKA2cFSwuYi8t7cYdtQ6rLqHOI9O1XnDlpRT1+uN33xjpWrs5ci9gVJ0eMdAfEgre
 bz4Bf5EajbX+OXVtInuqp9/HM0MRcZDohTSiLAmpMDQeGLM2AfIrO4KOGYco3Vpr9fjL
 L2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789363; x=1763394163;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+yk26Aua9dx9EZiQJjb8WWXvJlMXblkKMuTKCeu0Cv0=;
 b=bNpT3xJDXU/3ipSgCWsS6xGVrQsOPS2qfUkAw7JvhXeI1Sl+PhvR1O6QZ7F7inGw/+
 0Hqnp5yWh2yg4ZArU2q9FE7Pr+LGZhWi/hDSxzTsyAq23rdb2LGXUkBTlxAYukl+Ytk9
 GKQ/M42nQT8N6uiM3fD314IPUT3TxAbsyfxzX6xNj92x581/Cm2T4jPkCD9JwGJjMUSt
 gC2nnY1PSQJ5qLefC5RVX7OHSbsQ5iwkMYXIP6t9oiHlm8bRZfdNEYJEcI00rHdz2WMV
 dCOQXYTUYPf0aXo9264jTlUbjbW2wcy85nnzMva/YfxiEfxxi2VINdiPnb9RP91DZPdp
 i+LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWG45udfhidFtSBe2xBgab/4n6GevozYEDfXgcKKL9zeVN57y79cF8dfycMiwJT7D6sDCEyBk=@lists.denx.de
X-Gm-Message-State: AOJu0YyOMhIKlTO9B2+T1LHMncy8KzzaYcZv/bU7l/n5BLOsDKaSvXYh
 qHQhlWC2z4h0TiZDtrw8ydhuF+D1ZiDEl+PySncOd8ga4v4xmF6nOxE+0YH4Yx9Y07rigLIH+xL
 q7f88ua0=
X-Gm-Gg: ASbGncuR5kWsfateniAy6KzaVyDRg8bCS8mWSjIvg9QS7+hPkfvIDZ9/+l7v8K3yo+r
 IcLyUcRXlMajDdoobwr2cvwgsuJjGJHqVcVO8KZF/bHWwFTFuk/TpaNMo0k0fKMPcxJ4D6AWwpW
 Esp9nfH2AVD1DpESwQGhU8GHQrXYJpWmaoVfKPMXolUuu4If/soPVSuJ/zSaq9htU66FSGZ4GWv
 iyR7piEQo8kHmB8YWgCGxBEG1WzuqignIb5nJ3+L13zei9YSNSRoReoHUWegetX8SqbhKoeTHuv
 agH3GPsMrFaMy6RjlObNSZsyVBzEAdq9Inl6lzXmCK95uiY12ywll1WWJxIPIcG3+SVZVtCyuUg
 Mz0OoPE1mCD5gpT4HA0gVVQ7yISvfz2fxlxsq3RcnJlkGo8hhD0eVlqkRai0k822z74OC8OwlVK
 9B3g==
X-Google-Smtp-Source: AGHT+IFl3YYRhcGPTUpTrurnTWPpwkH+pd90m2ZnJgUoK5LBm3lulPvammVgiTmbrv+DnSk4XjezzA==
X-Received: by 2002:a05:6000:64d:b0:429:dc9a:ed35 with SMTP id
 ffacd0b85a97d-42b2dc9f1b5mr5824281f8f.43.1762789363066; 
 Mon, 10 Nov 2025 07:42:43 -0800 (PST)
Received: from [192.168.2.177] ([91.116.220.47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b2dd927c9sm16111944f8f.27.2025.11.10.07.42.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 07:42:42 -0800 (PST)
Message-ID: <b637c777-d4aa-47ad-baf8-1f825dd379b8@suse.com>
Date: Mon, 10 Nov 2025 16:42:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: bcm283x: Add GPIO pull-up/down control for
 BCM2835 and BCM2711
To: Cibil Pankiras <cibil.pankiras@egym.com>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20251110112426.534118-1-cibil.pankiras@egym.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20251110112426.534118-1-cibil.pankiras@egym.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 10/11/2025 12:24, Cibil Pankiras wrote:
> This patch adds support for configuring GPIO pull-up and pull-down
> resistors in the BCM283x pinctrl driver. It implements the brcm,pull
> device tree property to control pin bias settings.
> 
> The implementation follows the hardware-specific pull control
> mechanisms:
> - BCM2835: two-step GPPUD register sequence
> - BCM2711: direct per-pin control registers
> 
> This enables device tree configurations to specify pull-up, pull-down,
> or no bias for individual GPIO pins.
> 
> Tested on Raspberry Pi boards with both BCM2835 and BCM2711 SoCs.
> 
> Signed-off-by: Cibil Pankiras <cibil.pankiras@egym.com>
> ---
>   arch/arm/mach-bcm283x/include/mach/gpio.h  |  10 ++
>   drivers/pinctrl/broadcom/pinctrl-bcm283x.c | 102 ++++++++++++++++++++-
>   2 files changed, 109 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-bcm283x/include/mach/gpio.h b/arch/arm/mach-bcm283x/include/mach/gpio.h
> index 4aeb48eeb20..c54414a012c 100644
> --- a/arch/arm/mach-bcm283x/include/mach/gpio.h
> +++ b/arch/arm/mach-bcm283x/include/mach/gpio.h
> @@ -26,6 +26,16 @@
>   #define BCM2835_GPIO_FSEL_BANK(gpio)	(gpio / 10)
>   #define BCM2835_GPIO_FSEL_SHIFT(gpio)	((gpio % 10) * 3)
>   
> +/* BCM2835 GPIO Pull-up/down register offsets */
> +#define BCM2835_GPPUD		37
> +#define BCM2835_GPPUDCLK0	38
> +
> +/* BCM2711 GPIO Pull-up/down control */
> +#define BCM2711_GPPUD_CNTRL_REG0	57
> +#define BCM2711_PUD_REG_OFFSET(gpio)	((gpio) / 16)
> +#define BCM2711_PUD_REG_SHIFT(gpio)	(((gpio) % 16) * 2)
> +#define BCM2711_PUD_2711_MASK		0x3
> +
>   struct bcm2835_gpio_regs {
>   	u32 gpfsel[6];
>   	u32 reserved1;
> diff --git a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> index cf9350c151e..c588015905d 100644
> --- a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> +++ b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> @@ -21,6 +21,8 @@
>   #include <asm/system.h>
>   #include <asm/io.h>
>   #include <asm/gpio.h>
> +#include <dt-bindings/pinctrl/bcm2835.h>
> +#include <linux/delay.h>
>   
>   struct bcm283x_pinctrl_priv {
>   	u32 *base_reg;
> @@ -54,7 +56,66 @@ static int bcm2835_gpio_get_func_id(struct udevice *dev, unsigned int gpio)
>   }
>   
>   /*
> - * bcm283x_pinctrl_set_state: configure pin functions.
> + * bcm2835_gpio_set_pull: Set GPIO pull-up/down resistor for BCM2835
> + * @dev: the pinctrl device
> + * @gpio: the GPIO pin number
> + * @pull: pull setting (BCM2835_PUD_OFF, BCM2835_PUD_DOWN, BCM2835_PUD_UP)
> + */
> +static void bcm2835_gpio_set_pull(struct udevice *dev, unsigned int gpio, int pull)
> +{
> +	struct bcm283x_pinctrl_priv *priv = dev_get_priv(dev);
> +	u32 bank = BCM2835_GPPUDCLK0 + BCM2835_GPIO_COMMON_BANK(gpio);
> +	u32 bit = BCM2835_GPIO_COMMON_SHIFT(gpio);
> +
> +	/* Set required control signal */
> +	writel(pull & 0x3, &priv->base_reg[BCM2835_GPPUD]);
> +	udelay(1);
> +
> +	/* Clock the control signal into the GPIO pads */
> +	writel(1 << bit, &priv->base_reg[bank]);
> +	udelay(1);
> +
> +	/* Remove the control signal and clock */
> +	writel(0, &priv->base_reg[BCM2835_GPPUD]);
> +	writel(0, &priv->base_reg[bank]);
> +}
> +
> +/*
> + * bcm2711_gpio_set_pull: Set GPIO pull-up/down resistor for BCM2711
> + * @dev: the pinctrl device
> + * @gpio: the GPIO pin number
> + * @pull: pull setting (BCM2835_PUD_OFF, BCM2835_PUD_DOWN, BCM2835_PUD_UP)
> + */
> +static void bcm2711_gpio_set_pull(struct udevice *dev, unsigned int gpio, int pull)
> +{
> +	struct bcm283x_pinctrl_priv *priv = dev_get_priv(dev);
> +	u32 reg_offset;
> +	u32 bit_shift;
> +	u32 pull_bits;
> +
> +	/* Findout which GPIO_PUP_PDN_CNTRL register to use */
> +	reg_offset = BCM2711_GPPUD_CNTRL_REG0 + BCM2711_PUD_REG_OFFSET(gpio);
> +
> +	/* Findout the bit position */
> +	bit_shift = BCM2711_PUD_REG_SHIFT(gpio);
> +
> +	/* Update the 2-bit field for this GPIO */
> +	pull_bits = pull & BCM2711_PUD_2711_MASK;
> +	clrsetbits_le32(&priv->base_reg[reg_offset],
> +			BCM2711_PUD_2711_MASK << bit_shift,
> +			pull_bits << bit_shift);
> +}
> +
> +static void bcm283x_gpio_set_pull(struct udevice *dev, unsigned int gpio, int pull)
> +{
> +	if (device_is_compatible(dev, "brcm,bcm2835-gpio"))
> +		bcm2835_gpio_set_pull(dev, gpio, pull);
> +	else
> +		bcm2711_gpio_set_pull(dev, gpio, pull);
> +}
> +
> +/*
> + * bcm283x_pinctrl_set_state: configure pin functions and pull states.
>    * @dev: the pinctrl device to be configured.
>    * @config: the state to be configured.
>    * @return: 0 in success
> @@ -62,8 +123,9 @@ static int bcm2835_gpio_get_func_id(struct udevice *dev, unsigned int gpio)
>   int bcm283x_pinctrl_set_state(struct udevice *dev, struct udevice *config)
>   {
>   	u32 pin_arr[MAX_PINS_PER_BANK];
> +	u32 pull_arr[MAX_PINS_PER_BANK];
>   	int function;
> -	int i, len, pin_count = 0;
> +	int i, len, pin_count = 0, pull_len = 0, pull_count = 0;
>   
>   	if (!dev_read_prop(config, "brcm,pins", &len) || !len ||
>   	    len & 0x3 || dev_read_u32_array(config, "brcm,pins", pin_arr,
> @@ -82,8 +144,42 @@ int bcm283x_pinctrl_set_state(struct udevice *dev, struct udevice *config)
>   		return -EINVAL;
>   	}
>   
> -	for (i = 0; i < pin_count; i++)
> +	/* Check if brcm,pull property exists */
> +	if (dev_read_prop(config, "brcm,pull", &pull_len) && pull_len > 0) {
> +		if (pull_len & 0x3) {

We should check for arbitrary values, so check should be, pull_len > 0x2

With that change:
Reviewed-by: Matthias Brugger <mbrugger@suse.com>

