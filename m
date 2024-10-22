Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC458D0E6FC
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 11:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B20188DFD;
	Tue, 22 Oct 2024 13:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729595911;
	bh=QYw6GsC3CUO5DBgBMaA3sZMTNesnqJyAtMkwbl4ah2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AFfdz15p12fPhricXjbdobvlv8Cve6mj1z7hBhfA36+bhZEoR0lupnLH7Aa8OHBSc
	 BmjtIiraLt6xbXMbVdvPClMUqYqS5wns5koQv/kKeMEy3J1jR/KUh+01qklNkhL+uH
	 9CCDYaFoLxrvbG/IX/DmdqRKLBWwceMAOdaZ4CdyRD2VGgKHX8BmNZAowAhKovlGzo
	 a77aGjCKEzDf5H7YT+vlbMzKnOXJ0DqK6MxDj0ZrczT5vopCkvZhhkn8BEO4tyOOpR
	 wpS00WLGXCAziX1WvrdJ3QQalT4Wpj3fhsdiiLToN4cGLjkcyAc8kEfsrya5eYcpUw
	 DTXXz81JxX8pg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D11BE88E89; Tue, 22 Oct 2024 13:18:29 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAD308826E
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XXqRj28Zjz9sQc;
 Tue, 22 Oct 2024 13:18:25 +0200 (CEST)
Message-ID: <a95685d3-50fe-4b4d-a6bc-23adac2a33c5@denx.de>
Date: Tue, 22 Oct 2024 13:18:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] watchdog: gpio_wdt: add support for stoppable devices
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Paul Doelle <paaull.git@gmail.com>, Felix Blix <felbe@prevas.dk>
References: <20241002192323.632822-1-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241002192323.632822-1-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Rasmus,

On 10/2/24 21:23, Rasmus Villemoes wrote:
> Back when I added this driver in commit 2ac8490412c9, I wrote
> 
>      The corresponding linux driver apparently has support for some
>      watchdog circuits which can be disabled by tri-stating the gpio, but I
>      have never actually encountered such a chip in the wild;
> 
> That has changed now; I have a board with just such a watchdog on my
> desk currently. Add support for that.
> 
> - For a hw_algo="toggle" device, the gpio is requested as output if the
>    always-running flag is set, otherwise as input.
> 
> - The ->start() method is updated to change the direction to output when
>    required (i.e. it is not always-running).
> 
> - The ->stop() method is implemented, but of course reports failure if
>    always-running.
> 
> As I still haven't met any hw_algo="level" devices, I'm not entirely
> sure how they fit in, but I'm borrowing logic from the corresponding
> linux driver:
> 
> - In ->probe(), such devices always request the gpio as GPIOD_IS_OUT.
> 
> - In ->stop(), the linux driver has an "eternal ping" comment and sets
>    the gpio to (logic) high.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

While running a CI build, I'm seeing some sandbox failures, most likely
related to this change here:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=375&view=logs&j=db15d90c-51e5-5ca3-902e-4c5d558bba82&t=64917d2e-7acb-5ec4-6136-40fc146da71a

Could you please take a look at this?

Thanks,
Stefan

> ---
>   drivers/watchdog/gpio_wdt.c | 27 ++++++++++++++++++++++++---
>   1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index 2920c2c751f..e889861e917 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -45,14 +45,32 @@ static int gpio_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
>   	if (priv->always_running)
>   		return 0;
>   
> -	return -ENOSYS;
> +	dm_gpio_set_dir_flags(&priv->gpio, GPIOD_IS_OUT);
> +	gpio_wdt_reset(dev);
> +
> +	return 0;
> +}
> +
> +static int gpio_wdt_stop(struct udevice *dev)
> +{
> +	struct gpio_wdt_priv *priv = dev_get_priv(dev);
> +
> +	if (priv->always_running)
> +		return -EOPNOTSUPP;
> +
> +	if (priv->hw_algo == HW_ALGO_TOGGLE)
> +		dm_gpio_set_dir_flags(&priv->gpio, GPIOD_IS_IN);
> +	else
> +		dm_gpio_set_value(&priv->gpio, 1);
> +
> +	return 0;
>   }
>   
>   static int dm_probe(struct udevice *dev)
>   {
>   	struct gpio_wdt_priv *priv = dev_get_priv(dev);
> -	int ret;
>   	const char *algo = dev_read_string(dev, "hw_algo");
> +	int ret, flags;
>   
>   	if (!algo)
>   		return -EINVAL;
> @@ -64,7 +82,9 @@ static int dm_probe(struct udevice *dev)
>   		return -EINVAL;
>   
>   	priv->always_running = dev_read_bool(dev, "always-running");
> -	ret = gpio_request_by_name(dev, "gpios", 0, &priv->gpio, GPIOD_IS_OUT);
> +	flags = priv->always_running || priv->hw_algo == HW_ALGO_LEVEL ?
> +		GPIOD_IS_OUT : GPIOD_IS_IN;
> +	ret = gpio_request_by_name(dev, "gpios", 0, &priv->gpio, flags);
>   	if (ret < 0) {
>   		dev_err(dev, "Request for wdt gpio failed: %d\n", ret);
>   		return ret;
> @@ -78,6 +98,7 @@ static int dm_probe(struct udevice *dev)
>   
>   static const struct wdt_ops gpio_wdt_ops = {
>   	.start = gpio_wdt_start,
> +	.stop  = gpio_wdt_stop,
>   	.reset = gpio_wdt_reset,
>   };
>   

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
