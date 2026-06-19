Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E379CD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 14:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD3FF849E0;
	Fri, 19 Jun 2026 16:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="jT/YbhiE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92C41849F0; Fri, 19 Jun 2026 16:50:37 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 71B31849CA
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 16:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C1D326B9;
 Fri, 19 Jun 2026 07:50:29 -0700 (PDT)
Received: from [10.1.26.191] (e142021.arm.com [10.1.26.191])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1F393F62B;
 Fri, 19 Jun 2026 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781880633; bh=xkeTN0idoqNVUgzIK5XLtbG4MKIjUrD7HtzFFf2iWH4=;
 h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
 b=jT/YbhiENLBam+PERa1Jw1bhJ0SYdSU7IUMRl1ENXf/ssozAJ+37QFmuAi6b2FQwa
 NTOK8IWAwV501mwQ2nCR146ocrnOgT2rY9DPQ4eOVEdNQ8ItE2vqcFaIHY+W3A8hx2
 xsHAXgadVhxWDzO/P0P2DP61oRtszk3gKcp8YfjA=
Message-ID: <2e9b4819-de5c-49ca-a42a-241cf11ef62b@arm.com>
Date: Fri, 19 Jun 2026 15:50:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: axp: Add support for devicetree
To: Denis Burkov <hitechshell@mail.ru>, u-boot@lists.denx.de
References: <20260121115437.31406-1-hitechshell@mail.ru>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi@lists.linux.dev
In-Reply-To: <20260121115437.31406-1-hitechshell@mail.ru>
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

Hi Denis,

thanks for sending this patch!

On 1/21/26 12:54, Denis Burkov wrote:

I am afraid you need to put some commit message in here. You can refer 
to the comment you are removing, so that there *is* now DT support for 
the AXP GPIOs. But also please mention what this fixes - why do we need 
this patch? If you can provide an example usage, it would be easier to 
take this patch.

> Signed-off-by: Denis Burkov <hitechshell@mail.ru>
> ---
>   board/sunxi/board.c     |  4 ----
>   drivers/gpio/axp_gpio.c | 28 +++++++++++-----------------
>   2 files changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index 2929bc17f08..3c61bfb8822 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -226,10 +226,6 @@ int board_init(void)
>   	}
>   #endif /* !CONFIG_ARM64 && !CONFIG_MACH_SUNIV */
>   
> -	ret = axp_gpio_init();
> -	if (ret)
> -		return ret;
> -
>   	eth_init_board();
>   
>   	return 0;
> diff --git a/drivers/gpio/axp_gpio.c b/drivers/gpio/axp_gpio.c
> index 181c53bfe72..1c5882a25d4 100644
> --- a/drivers/gpio/axp_gpio.c
> +++ b/drivers/gpio/axp_gpio.c
> @@ -98,35 +98,29 @@ static const struct dm_gpio_ops gpio_axp_ops = {
>   
>   static int gpio_axp_probe(struct udevice *dev)
>   {
> +	int ret;
>   	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
>   
>   	/* Tell the uclass how many GPIOs we have */
>   	uc_priv->bank_name = AXP_GPIO_PREFIX;
>   	uc_priv->gpio_count = AXP_GPIO_COUNT;
>   
> +	ret = pmic_bus_init();
> +	if (ret)
> +		return ret;
> +
>   	return 0;
>   }
>   
> +static const struct udevice_id gpio_axp_match[] = {
> +	{ .compatible = "x-powers,axp209-gpio" },

Why is it only this compatible string? What about the others? I guess 
the driver was just not enabled on newer AXPs before?
Can you maybe look what it takes to support the other PMICs? If you look 
at the Linux driver, that's mostly about what pins each AXP supports.

And peeking into the driver here, there are some #ifdef's in there 
(AXP_GPIO[23]_CTRL), I think now collides with the DT description, and 
whatever this was doing should be detected at runtime, potentially by 
supporting multiple compatible strings.

Cheers,
Andre

> +	{ }
> +};
> +
>   U_BOOT_DRIVER(gpio_axp) = {
>   	.name	= "gpio_axp",
>   	.id	= UCLASS_GPIO,
> +	.of_match = gpio_axp_match,
>   	.ops	= &gpio_axp_ops,
>   	.probe	= gpio_axp_probe,
>   };
> -
> -int axp_gpio_init(void)
> -{
> -	struct udevice *dev;
> -	int ret;
> -
> -	ret = pmic_bus_init();
> -	if (ret)
> -		return ret;
> -
> -	/* There is no devicetree support for the axp yet, so bind directly */
> -	ret = device_bind_driver(dm_root(), "gpio_axp", "AXP-gpio", &dev);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}

