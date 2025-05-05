Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E356C369C2
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 06:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A19CA80BAE;
	Mon,  5 May 2025 08:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746427662;
	bh=n5yxC961/wdX1lgtJccLHMNWhf45K8hxYV4uSEMmiJw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GDYODmtb2ph5/Qf7C3W7qoGALEsNe9MVgNkLoMmkZSq1iJaIMUgy30NxVWQj7QgjW
	 kSwYNzP7NN2ojgH2IVhuWDOLLlou/mzmzjaWqJWfTwvliusl5fFMz8+yxFs7SWIAVz
	 RLFMdOtAzfoTRGN+FTIcpASnNDVaUaD9b/z0H+zYNa4yEAzpfBz3eiA012s1EQf7IG
	 OLeOkot5+68O00AQ4pw6wINFuHN76rWVFdJSrzJGuiUVf9oICaDATXevC8xRF5ZrkD
	 GcB4ypWCqBp4Fk73XMRjLBtB+uBy12qpSvg+6SlYD14L/VVkx3g3fOngXNtpY8ipLP
	 QX0RP210b6InA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89AA881F66; Mon,  5 May 2025 08:47:41 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B48805D7
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 08:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4ZrXCF3ZmCz9tK1;
 Mon,  5 May 2025 08:47:37 +0200 (CEST)
Message-ID: <5ba4f07f-d839-4e4e-bf55-fdf55bf06ebe@denx.de>
Date: Mon, 5 May 2025 08:47:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/6] watchdog: at91sam9_wdt: Rename priv to wdt
To: Zixun LI <admin@hifiphile.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250428-wdt-v4-0-bb7d1c7c051a@hifiphile.com>
 <20250428-wdt-v4-3-bb7d1c7c051a@hifiphile.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250428-wdt-v4-3-bb7d1c7c051a@hifiphile.com>
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
> "wdt" is a better name for watchdog rather than generic "priv".
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/watchdog/at91sam9_wdt.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index dab7b6a9b8ca09e6113109391560434ffe1f7cb6..5ca3e5a5fdefb3101c97754f10b65c0acd69a522 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -38,7 +38,7 @@ DECLARE_GLOBAL_DATA_PTR;
>    */
>   static int at91_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   {
> -	struct at91_wdt_priv *priv = dev_get_priv(dev);
> +	struct at91_wdt_priv *wdt = dev_get_priv(dev);
>   	u64 timeout;
>   	u32 ticks;
>   
> @@ -49,7 +49,7 @@ static int at91_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   	ticks = WDT_SEC2TICKS(timeout);
>   
>   	/* Check if disabled */
> -	if (readl(priv->regs + AT91_WDT_MR) & AT91_WDT_MR_WDDIS) {
> +	if (readl(wdt->regs + AT91_WDT_MR) & AT91_WDT_MR_WDDIS) {
>   		printf("sorry, watchdog is disabled\n");
>   		return -1;
>   	}
> @@ -60,31 +60,31 @@ static int at91_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   	 * Since WDV is a 12-bit counter, the maximum period is
>   	 * 4096 / 256 = 16 seconds.
>   	 */
> -	priv->mr = AT91_WDT_MR_WDRSTEN	/* causes watchdog reset */
> +	wdt->mr = AT91_WDT_MR_WDRSTEN	/* causes watchdog reset */
>   		| AT91_WDT_MR_WDDBGHLT		/* disabled in debug mode */
>   		| AT91_WDT_MR_WDD(0xfff)	/* restart at any time */
>   		| AT91_WDT_MR_WDV(ticks);	/* timer value */
> -	writel(priv->mr, priv->regs + AT91_WDT_MR);
> +	writel(wdt->mr, wdt->regs + AT91_WDT_MR);
>   
>   	return 0;
>   }
>   
>   static int at91_wdt_stop(struct udevice *dev)
>   {
> -	struct at91_wdt_priv *priv = dev_get_priv(dev);
> +	struct at91_wdt_priv *wdt = dev_get_priv(dev);
>   
>   	/* Disable Watchdog Timer */
> -	priv->mr |= AT91_WDT_MR_WDDIS;
> -	writel(priv->mr, priv->regs + AT91_WDT_MR);
> +	wdt->mr |= AT91_WDT_MR_WDDIS;
> +	writel(wdt->mr, wdt->regs + AT91_WDT_MR);
>   
>   	return 0;
>   }
>   
>   static int at91_wdt_reset(struct udevice *dev)
>   {
> -	struct at91_wdt_priv *priv = dev_get_priv(dev);
> +	struct at91_wdt_priv *wdt = dev_get_priv(dev);
>   
> -	writel(AT91_WDT_CR_WDRSTT | AT91_WDT_CR_KEY, priv->regs + AT91_WDT_CR);
> +	writel(AT91_WDT_CR_WDRSTT | AT91_WDT_CR_KEY, wdt->regs + AT91_WDT_CR);
>   
>   	return 0;
>   }
> @@ -102,10 +102,10 @@ static const struct udevice_id at91_wdt_ids[] = {
>   
>   static int at91_wdt_probe(struct udevice *dev)
>   {
> -	struct at91_wdt_priv *priv = dev_get_priv(dev);
> +	struct at91_wdt_priv *wdt = dev_get_priv(dev);
>   
> -	priv->regs = dev_remap_addr(dev);
> -	if (!priv->regs)
> +	wdt->regs = dev_remap_addr(dev);
> +	if (!wdt->regs)
>   		return -EINVAL;
>   
>   	debug("%s: Probing wdt%u\n", __func__, dev_seq(dev));
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

