Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4AFCE7A8B
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 08:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 673D183C54;
	Fri, 14 Nov 2025 09:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="bRQzY5OX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8B2D83E76; Fri, 14 Nov 2025 09:51:13 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67F7F83B8A
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 09:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so12468665e9.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 00:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1763110270; x=1763715070; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ftjS/H0dYiLKk15QPKSpUOQ3EDgAisiysCVSOo/n9Hc=;
 b=bRQzY5OXU4SukweAzDDj3/yuuh1OQL05gbO/ExKZbeTX4S3hmQbxgy6IV6AMK2cJLe
 I7M/eeQsLFtO4gfQximw4yi2WK1rKnRmt9flV6ImHzmLJmZvPMVEBGRcm7acMo38B54p
 zvj+YLmIyTxjW3Cs5Jj6JOEhq/oe0VW6oYhOVBcyMi3TkDQBNuNBlU4/9Ex2yo2ei8gG
 jDdRwe1I2LcudHBO9W+PH2WFCc4Tx5aEMySCAV8kbEKoEv/l7VAxUh0jKIZFFLqI9d6p
 mSDW0pLUXIbHhMSzs6S2K72YLH6HHyY5uTVgn9tL5dXSHdYG43uHR2wFj+3AqePqKo5d
 FmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763110270; x=1763715070;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ftjS/H0dYiLKk15QPKSpUOQ3EDgAisiysCVSOo/n9Hc=;
 b=MgCuocV+GvXYX4y5zoZYC/5MDXAiJmko0LJAJzNZ131H5YeLEFA5fDhhC/WottfnRJ
 /mgGt2ZyFsioshUAgmdd2ep77YgpjE8t6MyKGAG8+5+zPMIQIRG2jktgH5C1FidI62+h
 KGK0TP08bKpwPCJobyYsos7Tr9vvjrsJdjozuA2t5d6E9muFTjKnktvSkTmyt+7awJtH
 BI4KyHggoVsLspDLf0Vnee3VQrnZxaX/nbL2qjjblj2jl4G3noVpE6SgwSmcZakX2HpZ
 /mrzqhHki2KwA8b2eWpNBQrwU4uU3MxoRPncxzyjlLNNjWzHFKE+SNiB/WJCc53HqXTB
 aRBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4PFTcMO0ojoTakETMC2kKBM7QlyOXmErBQ24fI5U0c/C038/cM0sFAcHlkTBBOaFPZtR4AUw=@lists.denx.de
X-Gm-Message-State: AOJu0YxC2tWuThI7E+R2cXtxgca3oZMXe23NB+mWIJkh4aJ63E6Gm+5M
 aWa79jguCY/BB+voJtem+CTlr6V7Pa5IBC5Q2sEkR5VtXWPI5j5dTaKnIA69qkJCG6Mzk3c9ULv
 S2v/0
X-Gm-Gg: ASbGncvDZz9ka6RThqfpRELeJ9oMET3lq2mJQnV/SI8m5BohJJt3LbMaXZVURl+7Aox
 SSHBNUDXEoSMsq4A3LJ5RVcmxKEQ9YD9SzRecv2wzUPL7vM6BhHY5Eh9xHs5CpmRfjAkc5tubx5
 Vaxkun/lOqvVtdu4/BHc5HpEhIsjtueQ4CGmQ4pzWlD9BKWZI4WAfB0Myrsmn2Tx6ErPjESkZLu
 z49GsDyeW6p/E/qUNnBh1XekDUZFQrXwCKSfRbcY1M4fD2ECcDP9o+yd9FBXFEvnRId9+pwJZQE
 czvo7n7BI02hOiHuizN9SBIyQ5bYzgVArb4iXUni0BmwS764G5O4u1LGDppUePzO7ShC3Vezlxn
 pZrxZJB9/SH1BhxFjEBR4FVKtXCLQjTzDV5XIrWFgBRS2Sll9RoTNCRvf1OZofOrU28Qxx+t4zG
 1yS+LqtRr9PtUR2ECqzDSq1qDgTWlfFg==
X-Google-Smtp-Source: AGHT+IHPFNKeE55TymJ/HREjL3qspk8Z6BKYnJlAQlP4jurkEAqxrLVIC8HNFmLLnavdxQoGqp9pgw==
X-Received: by 2002:a05:600c:c4ab:b0:477:8b2e:aa7d with SMTP id
 5b1f17b1804b1-4778feaf8e6mr21351115e9.30.1763110269759; 
 Fri, 14 Nov 2025 00:51:09 -0800 (PST)
Received: from [172.16.156.108] ([195.76.196.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778c88bf2esm77470515e9.10.2025.11.14.00.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 00:51:09 -0800 (PST)
Message-ID: <0ee621ec-ae27-4452-913f-44372b97ca30@suse.com>
Date: Fri, 14 Nov 2025 09:51:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: bcm283x: Add GPIO pull-up/down control for
 BCM2835 and BCM2711
To: Cibil Pankiras <cibil.pankiras@egym.com>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20251113234532.22653-1-cibil.pankiras@egym.com>
Content-Language: en-GB
From: Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <20251113234532.22653-1-cibil.pankiras@egym.com>
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



On 14/11/25 00:45, Cibil Pankiras wrote:
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

We check the brcm,pull byte lenght to be on par with the DT binding. 
That's not something I would expect normally to be done in a driver. But 
as this is also done for brcm,pin in this driver and also done in the 
kernel: let's not bike-shed.

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
> Changes in v2:
> - If brcm,pull contains a single value, apply it to all pins listed in brcm,pins
> ---
>   arch/arm/mach-bcm283x/include/mach/gpio.h  |  10 ++
>   drivers/pinctrl/broadcom/pinctrl-bcm283x.c | 105 ++++++++++++++++++++-
>   2 files changed, 112 insertions(+), 3 deletions(-)
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
> index cf9350c151e..4ecc8bac645 100644
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
> @@ -62,8 +123,10 @@ static int bcm2835_gpio_get_func_id(struct udevice *dev, unsigned int gpio)
>   int bcm283x_pinctrl_set_state(struct udevice *dev, struct udevice *config)
>   {
>   	u32 pin_arr[MAX_PINS_PER_BANK];
> +	u32 pull_arr[MAX_PINS_PER_BANK];
>   	int function;
> -	int i, len, pin_count = 0;
> +	int i, len, pin_count = 0, pull_len = 0, pull_count = 0;
> +	int pull_value;
>   
>   	if (!dev_read_prop(config, "brcm,pins", &len) || !len ||
>   	    len & 0x3 || dev_read_u32_array(config, "brcm,pins", pin_arr,
> @@ -82,8 +145,44 @@ int bcm283x_pinctrl_set_state(struct udevice *dev, struct udevice *config)
>   		return -EINVAL;
>   	}
>   
> -	for (i = 0; i < pin_count; i++)
> +	/* Check if brcm,pull property exists */
> +	if (dev_read_prop(config, "brcm,pull", &pull_len) && pull_len > 0) {
> +		if (pull_len & 0x3) {
> +			debug("Invalid pull array length for pinconfig %s (%d)\n",
> +			      config->name, pull_len);
> +			return -EINVAL;
> +		}
> +
> +		pull_count = pull_len / sizeof(u32);
> +
> +		if (pull_count != 1 && pull_count != pin_count) {
> +			debug("Pull array count (%d) must be 1 or match pin count (%d) for pinconfig %s\n",
> +			      pull_count, pin_count, config->name);
> +			return -EINVAL;
> +		}
> +
> +		if (dev_read_u32_array(config, "brcm,pull", pull_arr, pull_count)) {
> +			debug("Failed reading pull array for pinconfig %s\n", config->name);
> +			return -EINVAL;
> +		}
> +
> +		/* Validate pull values */
> +		for (i = 0; i < pull_count; i++) {
> +			if (pull_arr[i] > 2) {
> +				debug("Invalid pull value %d for pin %d in pinconfig %s\n",
> +				      pull_arr[i], pin_arr[i], config->name);
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	for (i = 0; i < pin_count; i++) {
>   		bcm2835_gpio_set_func_id(dev, pin_arr[i], function);
> +		if (pull_count > 0) {
> +			pull_value = (pull_count == 1) ? pull_arr[0] : pull_arr[i];
> +			bcm283x_gpio_set_pull(dev, pin_arr[i], pull_value);
> +		}
> +	}
>   
>   	return 0;
>   }

