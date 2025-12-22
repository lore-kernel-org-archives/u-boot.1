Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44691D711D5
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 08:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7400F83BF1;
	Mon, 22 Dec 2025 09:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uwTqZ0Av";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C54783C28; Mon, 22 Dec 2025 09:54:31 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 385C283AAE
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 09:54:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dZX4z2BTKz9tG4;
 Mon, 22 Dec 2025 09:54:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766393667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pBUEGxXvVigvp/KRTsk9rX/7m3tyyKMGK5XuUm/hY0k=;
 b=uwTqZ0AvWBORiYx0geHFlbN1MNcFPZgk0zjV1pm8qOTaBZG44bPi+WCICQfxFAL7dr5TTe
 fc75owpEQU9D/GzCEpizmYKbG+7fFFZfaAn/aeFark9aw3Uj/EPROLN95bUOvJdcL5khdY
 Mk52I1QcqeMNir/GbjeZTsi2XCfjH0xTcxmDMba5rHg0KFN1loHdKV9wzCSSO5Lx1nsVbD
 F4ZecaLPor/Np+6dcwz7/5WF0BJ1Xg6wXWpEJPi6m7T53Syd8VgtBn/0IDJFR0IlWLvuHz
 ZlE4TlMte925et82GNLvtYQCHjIUZRlsAoehI8qr08uVhZsfR8ZWvoHyAYTudg==
Message-ID: <158c0ef8-a5fb-474b-805e-a85c4ff4447c@mailbox.org>
Date: Mon, 22 Dec 2025 09:54:26 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] watchdog: orion_wdt: Add support for armada-xp
To: Chris Packham <judge.packham@gmail.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20251216041438.1945123-1-judge.packham@gmail.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20251216041438.1945123-1-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: o1duzjcr66t6wqdr7qnoswnx6bmob6zf
X-MBO-RS-ID: 7f52731bc6c20bbb9c3
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

Hi Chris,

On 12/16/25 05:14, Chris Packham wrote:
> Update the orion_wdt.c to support armada-xp and similar SoCs. The WDT
> block used in armada-xp is fairly close to the armada-380 with just a
> few differences that can be handled based on the compatible property.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> ---
>   drivers/watchdog/orion_wdt.c | 99 +++++++++++++++++++++++++++++++++---
>   1 file changed, 93 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 4562b2a37e34..3b76c0fd2ea1 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -43,8 +43,14 @@ struct orion_wdt_priv {
>   #define TIMER_A370_STATUS		0x04
>   
>   #define WDT_AXP_FIXED_ENABLE_BIT	BIT(10)
> +#define TIMER1_FIXED_ENABLE_BIT	BIT(12)
>   #define WDT_A370_EXPIRED		BIT(31)
>   
> +struct orion_watchdog_data {
> +	int (*plat_start)(struct udevice *dev, u64 timeout, ulong flags);
> +	int (*plat_stop)(struct udevice *dev);
> +};
> +
>   static int orion_wdt_reset(struct udevice *dev)
>   {
>   	struct orion_wdt_priv *priv = dev_get_priv(dev);
> @@ -56,7 +62,59 @@ static int orion_wdt_reset(struct udevice *dev)
>   	return 0;
>   }
>   
> -static int orion_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
> +static int armadaxp_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
> +{
> +	struct orion_wdt_priv *priv = dev_get_priv(dev);
> +	u32 reg;
> +
> +	priv->timeout = DIV_ROUND_UP(timeout_ms, 1000);
> +
> +	/* Fix the wdt and timer1 clock freqency to 25MHz */
> +	reg = readl(priv->reg + TIMER_CTRL);
> +	reg |= (WDT_AXP_FIXED_ENABLE_BIT | TIMER1_FIXED_ENABLE_BIT);
> +	writel(reg, priv->reg + TIMER_CTRL);
> +
> +	/* Set watchdog duration */
> +	writel(priv->clk_rate * priv->timeout,
> +	       priv->reg + priv->wdt_counter_offset);
> +
> +	/* Clear the watchdog expiration bit */
> +	reg = readl(priv->reg + TIMER_A370_STATUS);
> +	reg &= ~WDT_A370_EXPIRED;
> +	writel(reg, priv->reg + TIMER_A370_STATUS);
> +
> +	/* Enable watchdog timer */
> +	reg = readl(priv->reg + TIMER_CTRL);
> +	reg |= WDT_ENABLE_BIT;
> +	writel(reg, priv->reg + TIMER_CTRL);
> +
> +	/* Enable reset on watchdog */
> +	reg = readl(priv->rstout);
> +	reg |= RSTOUT_ENABLE_BIT;
> +	writel(reg, priv->rstout);
> +
> +	return 0;
> +}
> +
> +static int armadaxp_wdt_stop(struct udevice *dev)
> +{
> +	struct orion_wdt_priv *priv = dev_get_priv(dev);
> +	u32 reg;
> +
> +	/* Disable reset on watchdog */
> +	reg = readl(priv->rstout);
> +	reg &= ~RSTOUT_ENABLE_BIT;
> +	writel(reg, priv->rstout);
> +
> +	/* Disable watchdog timer */
> +	reg = readl(priv->reg + TIMER_CTRL);
> +	reg &= ~WDT_ENABLE_BIT;
> +	writel(reg, priv->reg + TIMER_CTRL);

Does it make sense to use some helper functions to clear or set some
bits in those registers above?

#define clrbits_le32(addr, clear) clrbits(le32, addr, clear)
#define setbits_le32(addr, set) setbits(le32, addr, set)
#define clrsetbits_le32(addr, clear, set) clrsetbits(le32, addr, clear, set)

Other than this:

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> +
> +	return 0;
> +}
> +
> +static int armada380_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   {
>   	struct orion_wdt_priv *priv = dev_get_priv(dev);
>   	u32 reg;
> @@ -94,7 +152,7 @@ static int orion_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   	return 0;
>   }
>   
> -static int orion_wdt_stop(struct udevice *dev)
> +static int armada380_wdt_stop(struct udevice *dev)
>   {
>   	struct orion_wdt_priv *priv = dev_get_priv(dev);
>   	u32 reg;
> @@ -116,6 +174,22 @@ static int orion_wdt_stop(struct udevice *dev)
>   	return 0;
>   }
>   
> +static int orion_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
> +{
> +	struct orion_watchdog_data *data =
> +			(struct orion_watchdog_data *)dev_get_driver_data(dev);
> +
> +	return data->plat_start(dev, timeout_ms, flags);
> +}
> +
> +static int orion_wdt_stop(struct udevice *dev)
> +{
> +	struct orion_watchdog_data *data =
> +			(struct orion_watchdog_data *)dev_get_driver_data(dev);
> +
> +	return data->plat_stop(dev);
> +}
> +
>   static inline bool save_reg_from_ofdata(struct udevice *dev, int index,
>   					void __iomem **reg, int *offset)
>   {
> @@ -144,8 +218,10 @@ static int orion_wdt_of_to_plat(struct udevice *dev)
>   	if (!save_reg_from_ofdata(dev, 1, &priv->rstout, NULL))
>   		goto err;
>   
> -	if (!save_reg_from_ofdata(dev, 2, &priv->rstout_mask, NULL))
> -		goto err;
> +	if (device_is_compatible(dev, "marvell,armada-380-wdt")) {
> +		if (!save_reg_from_ofdata(dev, 2, &priv->rstout_mask, NULL))
> +			goto err;
> +	}
>   
>   	return 0;
>   err:
> @@ -176,9 +252,20 @@ static const struct wdt_ops orion_wdt_ops = {
>   	.stop = orion_wdt_stop,
>   };
>   
> +static struct orion_watchdog_data armada380_data = {
> +	.plat_start = armada380_wdt_start,
> +	.plat_stop = armada380_wdt_stop,
> +};
> +
> +static struct orion_watchdog_data armadaxp_data = {
> +	.plat_start = armadaxp_wdt_start,
> +	.plat_stop = armadaxp_wdt_stop,
> +};
> +
>   static const struct udevice_id orion_wdt_ids[] = {
> -	{ .compatible = "marvell,armada-380-wdt" },
> -	{}
> +	{ .compatible = "marvell,armada-380-wdt", .data = (ulong)&armada380_data},
> +	{ .compatible = "marvell,armada-xp-wdt", .data = (ulong)&armadaxp_data},
> +	{ }
>   };
>   
>   U_BOOT_DRIVER(orion_wdt) = {

