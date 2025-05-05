Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D608DC369C2
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 06:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B84C81F7B;
	Mon,  5 May 2025 08:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746427643;
	bh=fc73kLVtWsRer+yC10B5h4l+cwfHaorpBhCX0Es1Y3g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Us1/xa95OGacH1+BVssp+pCtFpVwjlRkBLmcwJNwa5lyd+qDg3gGq6/e0ERForfGb
	 RctLziKDxkGY2m0jvlkDcGbQSYxQhVrNEBhtkuztj9p+UnTAwpZtp/AjLztRiEXdeb
	 KBmkvSrIFePAqF5t+aQnRYH6TrE2RoKOKU87jXyEuGwTcJ1ws+Mvbubg4UcAHKfCLV
	 bxVFHnkShtyYvxBxGGZ9lPuw9FvyzMOkqJTTL3/RSqQ9ujYceqJY1hFn2snTQnyvlU
	 IEZmNQophW8/eO8GMWHILTkdWX9MPn06aQWnHsB1Xmb8p6y1wgNYecNX9UZWy4izci
	 3wYvlAP7+7d5Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0663D81F7E; Mon,  5 May 2025 08:47:22 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18CDA805D7
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 08:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4ZrXBs6gfhz9sbr;
 Mon,  5 May 2025 08:47:17 +0200 (CEST)
Message-ID: <433ec39a-49c9-47a2-9df5-382b907e02fd@denx.de>
Date: Mon, 5 May 2025 08:47:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/6] arm: at91: wdt: Rename regval in priv data to mr
To: Zixun LI <admin@hifiphile.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
 <20250428-wdt-v4-2-bb7d1c7c051a@hifiphile.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250428-wdt-v4-2-bb7d1c7c051a@hifiphile.com>
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

On 28.04.25 11:16, Zixun LI wrote:
> Use the name "mr" since we are referring to timer mode register.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   arch/arm/mach-at91/include/mach/at91_wdt.h | 2 +-
>   drivers/watchdog/at91sam9_wdt.c            | 8 ++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
> index 78ad0453fd9eb3e42674d10cb11ce3da820cdc6a..a5accbae52186e99de0b113d6982a4cc54e36095 100644
> --- a/arch/arm/mach-at91/include/mach/at91_wdt.h
> +++ b/arch/arm/mach-at91/include/mach/at91_wdt.h
> @@ -21,7 +21,7 @@
>   
>   struct at91_wdt_priv {
>   	void __iomem *regs;
> -	u32 regval;
> +	u32 mr;
>   };
>   
>   #endif
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index c809a8936b8968c3322db4c86bc0571fbdfe3ae2..dab7b6a9b8ca09e6113109391560434ffe1f7cb6 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -60,11 +60,11 @@ static int at91_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   	 * Since WDV is a 12-bit counter, the maximum period is
>   	 * 4096 / 256 = 16 seconds.
>   	 */
> -	priv->regval = AT91_WDT_MR_WDRSTEN	/* causes watchdog reset */
> +	priv->mr = AT91_WDT_MR_WDRSTEN	/* causes watchdog reset */
>   		| AT91_WDT_MR_WDDBGHLT		/* disabled in debug mode */
>   		| AT91_WDT_MR_WDD(0xfff)	/* restart at any time */
>   		| AT91_WDT_MR_WDV(ticks);	/* timer value */
> -	writel(priv->regval, priv->regs + AT91_WDT_MR);
> +	writel(priv->mr, priv->regs + AT91_WDT_MR);
>   
>   	return 0;
>   }
> @@ -74,8 +74,8 @@ static int at91_wdt_stop(struct udevice *dev)
>   	struct at91_wdt_priv *priv = dev_get_priv(dev);
>   
>   	/* Disable Watchdog Timer */
> -	priv->regval |= AT91_WDT_MR_WDDIS;
> -	writel(priv->regval, priv->regs + AT91_WDT_MR);
> +	priv->mr |= AT91_WDT_MR_WDDIS;
> +	writel(priv->mr, priv->regs + AT91_WDT_MR);
>   
>   	return 0;
>   }
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

