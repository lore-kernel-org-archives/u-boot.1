Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8489C25B75
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 10:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FB4F882B8;
	Mon, 13 May 2024 12:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715596833;
	bh=higN6r1Noeqh5OfQXFA3s4LNUKgvayOy/OGmDDYgU4U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E2XS6H2rd9HXEsHOHEloAjr28EXXAGJAsJBgk9BM1+SgluHrCA56SLOxIw+AjuRNt
	 5zsCdsHiNO4jjqi8o/3y3eOzXPip2QzHCKGQuYadyFjsG06Eq69efN4/bNeuyAIP7q
	 SMHPNAuqodQ/wLv5bAscWwK5C0Osjfapqu4q8bMnkNeyHZLolWVQd1RtcNWUXhPYcf
	 oFtZCsbUnWXBJRAnXstqlwzwmNKq9QEwN+o7JPxW3s21RMwdgTcLxFu5asZrbuVR6l
	 bZLRfVovAY438TwS3DrEcf0+D1FN5dDUjfCCA6S22rmQnZMgXGSbhxsi05FUiDUhdB
	 gi858pTaQguAA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A62D87D4F; Mon, 13 May 2024 12:40:32 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B8658644E
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 12:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4VdGGk01J1z9t52;
 Mon, 13 May 2024 12:40:30 +0200 (CEST)
Message-ID: <16a0c385-8293-42da-b56d-0122fea46d2b@denx.de>
Date: Mon, 13 May 2024 12:40:26 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] wdt-uclass: prevent multiple cyclic_register calls
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240509004714.1394547-1-rasmus.villemoes@prevas.dk>
 <20240509004714.1394547-3-rasmus.villemoes@prevas.dk>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240509004714.1394547-3-rasmus.villemoes@prevas.dk>
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

On 5/9/24 02:47, Rasmus Villemoes wrote:
> Currently, the cyclic_register() done in wdt_start() is not undone in
> wdt_stop(). Moreover, calling wdt_start multiple times (which is
> perfectly allowed on an already started device, e.g. to change the
> timeout value) will result in another struct cyclic_info being
> registered, referring to the same watchdog device.
> 
> This can easily be seen on e.g. a wandboard:
> 
> => cyclic list
> function: watchdog@20bc000, cpu-time: 22 us, frequency: 1.01 times/s
> => wdt list
> watchdog@20bc000 (imx_wdt)
> => wdt dev watchdog@20bc000
> => wdt start 50000
> WDT:   Started watchdog@20bc000 with servicing every 1000ms (50s timeout)
> => cyclic list
> function: watchdog@20bc000, cpu-time: 37 us, frequency: 1.03 times/s
> function: watchdog@20bc000, cpu-time: 241 us, frequency: 1.01 times/s
> => wdt start 12345
> WDT:   Started watchdog@20bc000 with servicing every 1000ms (12s timeout)
> => cyclic list
> function: watchdog@20bc000, cpu-time: 36 us, frequency: 1.03 times/s
> function: watchdog@20bc000, cpu-time: 100 us, frequency: 1.04 times/s
> function: watchdog@20bc000, cpu-time: 299 us, frequency: 1.00 times/s
> 
> So properly unregister the watchdog device from the cyclic framework
> in wdt_stop(). In wdt_start(), we cannot just skip the registration,
> as the (new) timeout value may mean that we have to ask the cyclic
> framework to call us more often. So if we're already running,
> first unregister the old cyclic instance.

Thanks again for all your valuable work here. I do have a question
regarding this patch though. AFAIU, it's a valid use-case to enable
2 different watchdog devices. And this patch will prevent such a
setup. Or do I misunderstand this?

Thanks,
Stefan

> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>   drivers/watchdog/wdt-uclass.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
> index 417e8d7eef9..caa1567e0c3 100644
> --- a/drivers/watchdog/wdt-uclass.c
> +++ b/drivers/watchdog/wdt-uclass.c
> @@ -122,10 +122,11 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   		struct wdt_priv *priv = dev_get_uclass_priv(dev);
>   		char str[16];
>   
> -		priv->running = true;
> -
>   		memset(str, 0, 16);
>   		if (IS_ENABLED(CONFIG_WATCHDOG)) {
> +			if (priv->running)
> +				cyclic_unregister(priv->cyclic);
> +
>   			/* Register the watchdog driver as a cyclic function */
>   			priv->cyclic = cyclic_register(wdt_cyclic,
>   						       priv->reset_period * 1000,
> @@ -140,6 +141,7 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   			}
>   		}
>   
> +		priv->running = true;
>   		printf("WDT:   Started %s with%s servicing %s (%ds timeout)\n",
>   		       dev->name, IS_ENABLED(CONFIG_WATCHDOG) ? "" : "out",
>   		       str, (u32)lldiv(timeout_ms, 1000));
> @@ -160,6 +162,9 @@ int wdt_stop(struct udevice *dev)
>   	if (ret == 0) {
>   		struct wdt_priv *priv = dev_get_uclass_priv(dev);
>   
> +		if (IS_ENABLED(CONFIG_WATCHDOG) && priv->running)
> +			cyclic_unregister(priv->cyclic);
> +
>   		priv->running = false;
>   	}
>   

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
