Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFC4CA5FFF
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 09:04:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AC7F406A3;
	Wed,  7 Oct 2026 09:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BR8ngCSViSGR; Wed,  7 Oct 2026 09:04:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1D90C40692
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791363895;
	b=nBz0SnjerXqQ71LzfhbwhxFd5u4oEKaYycTi/90pV3kkqEn2TEAK0yy+Ec9OOm9Lyy71
	 yUciTmnc4TJOc5yMm0oLnWR0YTa6xFFN4z1g5AW2xx/KOAuDfndGJVYZldf0/zYh4U4IO
	 rRUBNZ64kCMbuOxnF50E2C0PAFdbFo+X6UB5hcQMyzwGRkMolD0L+bVEytfeV/67wTlMe
	 eGkNro6J2+Q01vvtwR4SMaTgfpPPgnvDssHZRoNZzvw5odRmlgYkNzwNBJKhWiMhGgszR
	 yWbz0v+ITWLmfrW7J20d3iy19dPlv2Kq8Oty0sZQdT6fgdSs6NPiLMYb0tWSdoZUR/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791363895;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=e8nLlHCFxq5cJ4OAl6TvT8jpJxKcK6cC9Rfd/YrezmM=;
	b=b0mCHc2f/VVhZquSqTtK4Iu1HTVlM016sJN53vXezPO+RFIieh7AeGSvgPkKE2m8Jdqa
	 Qw4PBmkar3PxhhMoEGForVoFnefa16B5kI0+zFwpQAZBfN+lE9uSmylB1Q4RGlhhhIsGs
	 3Uz27/N+9G/6ZaSXD0Ww6/Y4Tk3zzj56T+6/6dxHZlB9YmwTUOF3NykFoJBz9yJlZ9N34
	 PPrORGAXnNBPkHXWvKxJ/dSs5vBucAE96JyO0ALjpfuQSQdLDlZIHAa5Q9DSSilfp7+7c
	 9KmTY5WyrLfwj4OUQVN8XX5U4vnY+VIKX2TZzdOsCbAheUFPvKyGBcXKn7Dbsl/Rl4Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791363895;
	bh=e8nLlHCFxq5cJ4OAl6TvT8jpJxKcK6cC9Rfd/YrezmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZIAHMhbdHFv9zUA3xwwPFVTZqE/tHwzyrSsiEbW3izzjVGeYJRV9ZiRy70sjjfEL/
	 CkrhCAr3gN1oRyWSf9v7mu6ag5AeYzuhPscUC7fIKwvI+uZYEf8OlB3lm0zyuoFG/t
	 pKhGnxHfHnEgkQWX7tGIFJrPJjlKT3HfYjNowx/V+ioFTZ/gYSmL2oy69jktETdBhv
	 ZCJx6hLGnnm1OYy9/QL1Hr9Fma7OjCB4eEY1enlB8yI1dyWPQIqZ9VIF99jjjpYEI1
	 79K5ncyCitoc6GIMGPKl3Nw4/D64rHTYodaFyt3wJS+KKPc4ucJQ500b8fRwS89CP7
	 7RlztS04S40kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D90C40692;
	Wed,  7 Oct 2026 09:04:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EFCD72AA
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 08:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E184080EF9
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 08:59:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4LnmU9zgTcwb for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 08:59:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A668E80EE1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791363559;
 b=BEBq4II32grDsZafOQb9RVEwt+AqXhIp52ZzFwAsEs+umsmSX7x9O2wGPEeS2YNKMLn/
 4dsyZ6cxLRDOY1MIuDlAZT2TCXe7YKxVIHhxGkDo+2mmAhte5YwcKDqPt7jVx7DoPTAMv
 WRgt/i1G2BkrlplUuEKQpcszDTzxCqti/1/A4vmuD9mJXYZrxdDCRdkSff5AfauLW1Hd4
 szhIEnjgfjmm6Y5SpK1XNaVCWqY55FYTHCecMlDNh9xor3UWhpc8DF4mOHkAgl9cqJXNU
 d2eXsd5pMdOwXAxCajVmwDYE5+lXwHQSHdNZ+CNWbpiUumNerTPLtZK/28qiKM03qKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791363559;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=e8nLlHCFxq5cJ4OAl6TvT8jpJxKcK6cC9Rfd/YrezmM=;
 b=KymrRfs+166LhWTnlGmaY6+sLlDa2YUFRefU6OFtzZJloeSaWfJS0K03KQ+rzfqBiWjx
 mwlwx9eucN9aGwdJ80npINqORm9AEkAIcxNvV+9AYyJFf+I1CfkgDWwQjF7fC2mCASRRl
 YU5UnYakAOcJJ7KXxFeLwGQV+NI1nqghbYRa6A11K7aewDU4YMiRadPVyXHg3yt+v31kK
 H2ykbW9NlQFO3VCDPCKesZVRqfkKz9AeXnbOtf02CgemX1vkHeEbdc3t9gNUcA21b6WHc
 KPHT4lZAua7FbrgIOcNfAjnBzeK/hGcKdWyPwAx59l9D0gmSY6/4FDbjfGuZp4i0Ojw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=aLvw7VnI; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=aLvw7VnI
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A668E80EE1
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 08:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791363543;
 bh=e8nLlHCFxq5cJ4OAl6TvT8jpJxKcK6cC9Rfd/YrezmM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aLvw7VnIr50Y5U6RxRxRZ9rXmLmOCPhDR7IOIBUQu65zPU5psnqxYNVjT7hUQeQuA
 Y8Ooxt085IIbbKD8ZpMnYJ6hZXzH/Nker5O7x/wIBQGDJ+qG8vJ11ysHy7EVFV2ULu
 vCr5uQyAtFMXoqCQepMvvVq5To2FAbHjQwR8dIbnhPS1a117c2WAaLeSqLgRMPHOSv
 +ldmrUTPFY60BqvJ1sqJU2EZpEOgoovQ38pSrg+ekd7P/ZHK0vFzfSVwHfRc8rt7t0
 x2AU5QJ11EIZkd7XgY3X+EwT8hghSn1mDJ6d6LuHj306w+09Csa7B8lD2EPKozL3Lq
 ZDxxbKXrW1n8A==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 8EE87B220242;
 Wed,  7 Oct 2026 10:59:02 +0200 (CEST)
Message-ID: <cc2c2867-4a6b-4784-bf30-28b628714e49@freeshell.de>
Date: Wed, 7 Oct 2026 01:58:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: spacemit: add support for K3 SoC
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Johan Jonker <jbx6244@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>
References: <20260822-01-gpio-pinctrl-support-v1-1-6be2f4c71c5d@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260822-01-gpio-pinctrl-support-v1-1-6be2f4c71c5d@kernel.org>
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


On 8/22/26 04:30, Yixun Lan wrote:
> Based on upstream Linux:
>   da64eb51595b ("gpio: spacemit: Add GPIO support for K3 SoC")
> 
> SpacemiT K3 SoC uses different GPIO register and bank layout compared
> to old K1 generation. Refactor the driver by moving hard-coded register
> offsets into per-SoC tables and locating them via driver data.
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  drivers/gpio/Kconfig         | 11 ++---
>  drivers/gpio/spacemit_gpio.c | 97 ++++++++++++++++++++++++++++++--------------
>  2 files changed, 72 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index a11f3043670..78b4b45be87 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -450,12 +450,13 @@ config SANDBOX_GPIO_COUNT
>  	  Select a suitable value depending on your needs.
>  
>  config SPACEMIT_GPIO
> -	bool "Spacemit K1 GPIO driver"
> -	depends on DM_GPIO && TARGET_SPACEMIT_K1
> +	bool "Spacemit K1/K3 GPIO driver"
> +	depends on DM_GPIO && (TARGET_SPACEMIT_K1 || TARGET_SPACEMIT_K3)
>  	help
> -	  Support the GPIO device in Spacemit SoCs. The GPIOs are arranged
> -	  into a number of banks (different for each SoC type) each with 32
> -	  GPIOs.
> +	  Support the GPIO device in Spacemit K1 and K3 SoCs. The GPIOs are
> +	  arranged into a number of banks (different for each SoC type) each
> +	  with 32 GPIOs.
> +
>  
>  config SUNXI_GPIO
>  	bool "Allwinner GPIO driver"
> diff --git a/drivers/gpio/spacemit_gpio.c b/drivers/gpio/spacemit_gpio.c
> index de71880df15..e0716a84dfc 100644
> --- a/drivers/gpio/spacemit_gpio.c
> +++ b/drivers/gpio/spacemit_gpio.c
> @@ -19,37 +19,28 @@
>  #define GPIO_TO_BANK(pin)	((pin) / GPIO_BANK_SIZE)
>  #define GPIO_TO_BIT(pin)	((pin) % GPIO_BANK_SIZE)
>  
> -static inline int gpio_to_reg_offset(unsigned int pin)
> -{
> -	unsigned int bank = GPIO_TO_BANK(pin);
> -
> -	if (bank == 0)
> -		return 0;
> -	else if (bank == 1)
> -		return 4;
> -	else if (bank == 2)
> -		return 8;
> -	else if (bank == 3)
> -		return 0x100;
> -	log_warning("Use default GPIO bank for an invalid GPIO[%d].\n", pin);
> -	return 0;
> -}
> -
> -#define REG_PLR(pin)		(0x00 + gpio_to_reg_offset(pin))
> -#define REG_PDR(pin)		(0x0c + gpio_to_reg_offset(pin))
> -#define REG_PSR(pin)		(0x18 + gpio_to_reg_offset(pin))
> -#define REG_PCR(pin)		(0x24 + gpio_to_reg_offset(pin))
> -#define REG_SDR(pin)		(0x54 + gpio_to_reg_offset(pin))
> -#define REG_CDR(pin)		(0x60 + gpio_to_reg_offset(pin))
> +#define to_spacemit_gpio_regs(priv, reg)	((priv)->data->offsets[reg])
> +
> +enum spacemit_gpio_registers {
> +	SPACEMIT_GPLR,
> +	SPACEMIT_GPDR,
> +	SPACEMIT_GPSR,
> +	SPACEMIT_GPCR,
> +	SPACEMIT_GSDR,
> +	SPACEMIT_GCDR,
> +};
>  
>  struct spacemit_gpio_data {
>  	u16	gpio_base;
>  	u16	gpio_count;
>  	u8	num_banks;
> +	const u16	*bank_offsets;
> +	const u16	*offsets;
>  };
>  
>  struct spacemit_gpio_priv {
>  	void __iomem *regs;
> +	const struct spacemit_gpio_data *data;
>  };
>  
>  static int spacemit_gpio_xlate(struct udevice *dev, struct gpio_desc *desc,
> @@ -85,10 +76,12 @@ static int spacemit_gpio_xlate(struct udevice *dev, struct gpio_desc *desc,
>  static int spacemit_gpio_get_value(struct udevice *dev, unsigned int offset)
>  {
>  	struct spacemit_gpio_priv *priv = dev_get_priv(dev);
> -	void __iomem *addr;
> +	void __iomem *base, *addr;
>  	u32 value, mask;
>  
> -	addr = priv->regs + REG_PLR(offset);
> +	base = priv->regs + priv->data->bank_offsets[GPIO_TO_BANK(offset)];
> +
> +	addr = base + to_spacemit_gpio_regs(priv, SPACEMIT_GPLR);
>  	value = readl(addr);
>  	mask = 1 << GPIO_TO_BIT(offset);
>  	return !!(value & mask);
> @@ -97,10 +90,12 @@ static int spacemit_gpio_get_value(struct udevice *dev, unsigned int offset)
>  static int spacemit_gpio_get_function(struct udevice *dev, unsigned int offset)
>  {
>  	struct spacemit_gpio_priv *priv = dev_get_priv(dev);
> -	void __iomem *addr;
> +	void __iomem *base, *addr;
>  	u32 value, mask;
>  
> -	addr = priv->regs + REG_PDR(offset);
> +	base = priv->regs + priv->data->bank_offsets[GPIO_TO_BANK(offset)];
> +
> +	addr = base + to_spacemit_gpio_regs(priv, SPACEMIT_GPDR);
>  	value = readl(addr);
>  	mask = 1 << GPIO_TO_BIT(offset);
>  	if (value & mask)
> @@ -130,23 +125,25 @@ static int spacemit_gpio_set_flags(struct udevice *dev, unsigned int offset,
>  				   ulong flags)
>  {
>  	struct spacemit_gpio_priv *priv = dev_get_priv(dev);
> -	void __iomem *addr;
> +	void __iomem *base, *addr;
>  	int value;
>  
> +	base = priv->regs + priv->data->bank_offsets[GPIO_TO_BANK(offset)];
> +
>  	value = (flags & GPIOD_IS_OUT_ACTIVE) ? 1 : 0;
>  	if (flags & GPIOD_IS_IN) {
> -		addr = priv->regs + REG_CDR(offset);
> +		addr = base + to_spacemit_gpio_regs(priv, SPACEMIT_GCDR);
>  		writel(1 << GPIO_TO_BIT(offset), addr);
>  	}
>  	if (flags & GPIOD_IS_OUT) {
>  		if (value) {
> -			addr = priv->regs + REG_PSR(offset);
> +			addr = base + to_spacemit_gpio_regs(priv, SPACEMIT_GPSR);
>  			writel(1 << GPIO_TO_BIT(offset), addr);
>  		} else {
> -			addr = priv->regs + REG_PCR(offset);
> +			addr = base + to_spacemit_gpio_regs(priv, SPACEMIT_GPCR);
>  			writel(1 << GPIO_TO_BIT(offset), addr);
>  		}
> -		addr = priv->regs + REG_SDR(offset);
> +		addr = base + to_spacemit_gpio_regs(priv, SPACEMIT_GSDR);
>  		writel(1 << GPIO_TO_BIT(offset), addr);
>  	}
>  	return 0;
> @@ -207,6 +204,7 @@ static int spacemit_gpio_probe(struct udevice *dev)
>  
>  	data = (struct spacemit_gpio_data *)dev_get_driver_data(dev);
>  	priv = dev_get_priv(dev);
> +	priv->data = data;
>  	priv->regs = dev_read_addr_ptr(dev);
>  	if (!priv->regs) {
>  		dev_err(dev, "Fail to get base address\n");
> @@ -232,14 +230,51 @@ out:
>  	return ret;
>  }
>  
> +static const u16 spacemit_gpio_k1_offsets[] = {
> +	[SPACEMIT_GPLR] = 0x00,
> +	[SPACEMIT_GPDR] = 0x0c,
> +	[SPACEMIT_GPSR] = 0x18,
> +	[SPACEMIT_GPCR] = 0x24,
> +	[SPACEMIT_GSDR] = 0x54,
> +	[SPACEMIT_GCDR] = 0x60,
> +};
> +
> +static const u16 spacemit_gpio_k1_bank_offsets[] = {
> +	0x0, 0x4, 0x8, 0x100,
> +};
> +
> +static const u16 spacemit_gpio_k3_offsets[] = {
> +	[SPACEMIT_GPLR] = 0x00,
> +	[SPACEMIT_GPDR] = 0x04,
> +	[SPACEMIT_GPSR] = 0x08,
> +	[SPACEMIT_GPCR] = 0x0c,
> +	[SPACEMIT_GSDR] = 0x1c,
> +	[SPACEMIT_GCDR] = 0x20,
> +};
> +
> +static const u16 spacemit_gpio_k3_bank_offsets[] = {
> +	0x0, 0x40, 0x80, 0x100,
> +};
> +
>  static const struct spacemit_gpio_data k1_gpio_data = {
>  	.num_banks	= 4,
>  	.gpio_count	= 128,
>  	.gpio_base	= 0,
> +	.bank_offsets	= spacemit_gpio_k1_bank_offsets,
> +	.offsets	= spacemit_gpio_k1_offsets,
> +};
> +
> +static const struct spacemit_gpio_data k3_gpio_data = {
> +	.num_banks	= 4,
> +	.gpio_count	= 128,
> +	.gpio_base	= 0,
> +	.bank_offsets	= spacemit_gpio_k3_bank_offsets,
> +	.offsets	= spacemit_gpio_k3_offsets,
>  };
>  
>  static const struct udevice_id spacemit_gpio_ids[] = {
>  	{ .compatible = "spacemit,k1-gpio", .data = (uintptr_t)&k1_gpio_data, },
> +	{ .compatible = "spacemit,k3-gpio", .data = (uintptr_t)&k3_gpio_data, },
>  	{ /* sentinel */ }
>  };
>  
> 
> ---
> base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
> change-id: 20260722-01-gpio-pinctrl-support-87d7b153599b
> 
> Best regards,
> --  
> Yixun Lan <dlan@kernel.org>
> 

Acked-by: E Shattow <e@freeshell.de>
