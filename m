Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A00C369C2
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 06:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C3E80BAE;
	Mon,  5 May 2025 08:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746427761;
	bh=CChT9bBrDNlyXh27SUnS4wh6v92OETxxWHyD3ImOlqk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FVqk3vftAE5cr2q6IppcLna2iaUw4Q44NEChQbg+XBZOBIXbtxRWAOoMbRQfErbm/
	 qbzs++k2r4P9ekwMQLIJgcbXdjxwo7emb4i4vaaAYM3ewe8jg2RFrxHo9Zi5TYH/UL
	 g+Oe+hdY4uwNeRTHrFXBIqULPDQcCL6JE2F5BGiKtoRTlRwf0RRV8mWNqDmaMnmrGF
	 SYnrK4R+uyAcoYfJb8Wf5e2Ud0SBzwlnqa+nlyjyte4vcYPAU+oBYWzFS1sgFu7/RL
	 ZMS4FKCvXd3nvaMHMptKRpNWY3RMGBRuJ1yIEMDNGAbCYsYdVaMj7dkVVK5Cxnwun6
	 9LKVGECh5GMKQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E9C181F7B; Mon,  5 May 2025 08:49:19 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29326805D7
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 08:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4ZrXF66RKRz9sRJ;
 Mon,  5 May 2025 08:49:14 +0200 (CEST)
Message-ID: <4cd4f770-6b0f-42d9-b6c4-9184156a477c@denx.de>
Date: Mon, 5 May 2025 08:49:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/6] watchdog: at91sam9_wdt: Add SAM9X60 support
To: Zixun LI <admin@hifiphile.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
 <20250428-wdt-v4-4-bb7d1c7c051a@hifiphile.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250428-wdt-v4-4-bb7d1c7c051a@hifiphile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ZrXF66RKRz9sRJ
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
> SAM9X60 has a slightly different watchdog implementation:
> - Timer value moved into a new register WLR
> - Some MR register fields have their position changed
> 
> This patch add SAM9X60 support, also adds a compatible
> for SAMA5D4 which is the same as existing SAM9260.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   arch/arm/mach-at91/include/mach/at91_wdt.h | 19 +++++++++++++--
>   drivers/watchdog/at91sam9_wdt.c            | 39 ++++++++++++++++++++++++------
>   2 files changed, 48 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
> index a5accbae52186e99de0b113d6982a4cc54e36095..9a3976d9e970c212d348daeabc14c2fd6c54a8b5 100644
> --- a/arch/arm/mach-at91/include/mach/at91_wdt.h
> +++ b/arch/arm/mach-at91/include/mach/at91_wdt.h
> @@ -19,9 +19,16 @@
>   
>   #else
>   
> +enum {
> +	AT91_WDT_MODE_SAM9260 = 0,
> +	AT91_WDT_MODE_SAM9X60 = 1
> +};
> +
>   struct at91_wdt_priv {
>   	void __iomem *regs;
>   	u32 mr;
> +	u32 wddis;
> +	u8 mode;
>   };
>   
>   #endif
> @@ -33,14 +40,22 @@ struct at91_wdt_priv {
>   
>   /* Watchdog Mode Register*/
>   #define AT91_WDT_MR			0X04
> -#define AT91_WDT_MR_WDV(x)		(x & 0xfff)
> +#define AT91_WDT_MR_WDV(x)		((x) & 0xfff)
> +#define AT91_SAM9X60_MR_PERIODRST	0x00000010
>   #define AT91_WDT_MR_WDFIEN		0x00001000
> +#define AT91_SAM9X60_MR_WDDIS		0x00001000
>   #define AT91_WDT_MR_WDRSTEN		0x00002000
>   #define AT91_WDT_MR_WDRPROC		0x00004000
>   #define AT91_WDT_MR_WDDIS		0x00008000
> -#define AT91_WDT_MR_WDD(x)		((x & 0xfff) << 16)
> +#define AT91_WDT_MR_WDD(x)		(((x) & 0xfff) << 16)
>   #define AT91_WDT_MR_WDDBGHLT		0x10000000
> +#define AT91_SAM9X60_MR_WDIDLEHLT	0x10000000
>   #define AT91_WDT_MR_WDIDLEHLT		0x20000000
> +#define AT91_SAM9X60_MR_WDDBGHLT	0x20000000
> +
> +/* Watchdog Window Level Register */
> +#define AT91_SAM9X60_WLR		0x0c
> +#define AT91_SAM9X60_WLR_COUNTER(x)	((x) & 0xfff)
>   
>   /* Hardware timeout in seconds */
>   #define WDT_MAX_TIMEOUT		16
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index 5ca3e5a5fdefb3101c97754f10b65c0acd69a522..72e13787448e366036dce4a451cc2294e5b60a0d 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -49,7 +49,7 @@ static int at91_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   	ticks = WDT_SEC2TICKS(timeout);
>   
>   	/* Check if disabled */
> -	if (readl(wdt->regs + AT91_WDT_MR) & AT91_WDT_MR_WDDIS) {
> +	if (readl(wdt->regs + AT91_WDT_MR) & wdt->wddis) {
>   		printf("sorry, watchdog is disabled\n");
>   		return -1;
>   	}
> @@ -60,11 +60,21 @@ static int at91_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   	 * Since WDV is a 12-bit counter, the maximum period is
>   	 * 4096 / 256 = 16 seconds.
>   	 */
> -	wdt->mr = AT91_WDT_MR_WDRSTEN	/* causes watchdog reset */
> -		| AT91_WDT_MR_WDDBGHLT		/* disabled in debug mode */
> -		| AT91_WDT_MR_WDD(0xfff)	/* restart at any time */
> -		| AT91_WDT_MR_WDV(ticks);	/* timer value */
> -	writel(wdt->mr, wdt->regs + AT91_WDT_MR);
> +
> +	if (wdt->mode == AT91_WDT_MODE_SAM9260) {
> +		wdt->mr = AT91_WDT_MR_WDRSTEN	/* causes watchdog reset */
> +		    | AT91_WDT_MR_WDDBGHLT	/* disabled in debug mode */
> +		    | AT91_WDT_MR_WDD(0xfff)	/* restart at any time */
> +		    | AT91_WDT_MR_WDV(ticks);	/* timer value */
> +		writel(wdt->mr, wdt->regs + AT91_WDT_MR);
> +	} else if (wdt->mode == AT91_WDT_MODE_SAM9X60) {
> +		writel(AT91_SAM9X60_WLR_COUNTER(ticks),	/* timer value */
> +		       wdt->regs + AT91_SAM9X60_WLR);
> +
> +		wdt->mr = AT91_SAM9X60_MR_PERIODRST /* causes watchdog reset */
> +			| AT91_SAM9X60_MR_WDDBGHLT; /* disabled in debug mode */
> +		writel(wdt->mr, wdt->regs + AT91_WDT_MR);
> +	}
>   
>   	return 0;
>   }
> @@ -74,7 +84,7 @@ static int at91_wdt_stop(struct udevice *dev)
>   	struct at91_wdt_priv *wdt = dev_get_priv(dev);
>   
>   	/* Disable Watchdog Timer */
> -	wdt->mr |= AT91_WDT_MR_WDDIS;
> +	wdt->mr |= wdt->wddis;
>   	writel(wdt->mr, wdt->regs + AT91_WDT_MR);
>   
>   	return 0;
> @@ -96,7 +106,14 @@ static const struct wdt_ops at91_wdt_ops = {
>   };
>   
>   static const struct udevice_id at91_wdt_ids[] = {
> -	{ .compatible = "atmel,at91sam9260-wdt" },
> +	{ .compatible = "atmel,at91sam9260-wdt",
> +	  .data = AT91_WDT_MODE_SAM9260 },
> +	{ .compatible = "atmel,sama5d4-wdt",
> +	  .data = AT91_WDT_MODE_SAM9260 },
> +	{ .compatible = "microchip,sam9x60-wdt",
> +	  .data = AT91_WDT_MODE_SAM9X60 },
> +	{ .compatible = "microchip,sama7g5-wdt",
> +	  .data = AT91_WDT_MODE_SAM9X60 },
>   	{}
>   };
>   
> @@ -108,6 +125,12 @@ static int at91_wdt_probe(struct udevice *dev)
>   	if (!wdt->regs)
>   		return -EINVAL;
>   
> +	wdt->mode = dev_get_driver_data(dev);
> +	if (wdt->mode == AT91_WDT_MODE_SAM9260)
> +		wdt->wddis = AT91_WDT_MR_WDDIS;
> +	else if (wdt->mode == AT91_WDT_MODE_SAM9X60)
> +		wdt->wddis = AT91_SAM9X60_MR_WDDIS;
> +
>   	debug("%s: Probing wdt%u\n", __func__, dev_seq(dev));
>   
>   	return 0;
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

