Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539C0CAC59D
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 12:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B90B98353A;
	Wed, 17 Sep 2025 14:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="C49dehE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8F1683544; Wed, 17 Sep 2025 14:46:09 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D5BA833ED
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 14:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9DAAE1063CA; Wed, 17 Sep 2025 14:46:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1758113166;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=oyek2XPTtoMMzPUYQHqsPr5vbx9jjk2gTzUelh84geQ=;
 b=C49dehE/ASWoinyEFRSUToXP9OV44h/bTBov8MWWmqrfiUXxBpEctfFhiZkndsg0M4RH7R
 G4vKDtXSNp55XEUePJ1U4Ua1VT/JujfLIKbyLVtn+kzv0MaXLw/fFAY3Wx28YJuR/exVQC
 PLB6MNMyVH3EVqqG4Itf2KwNF9NAMGrC17E0BrdhATXHTjqbRQ2yIpdMukkvN3qQCMLO3c
 S3WBcYjRCMGueL9Zz1yerLKcGgM+GqFm5j5nQllkJk0qOuvoVgbcrljKevMS0onU1Hn2Bp
 Bz9gefk512cGihr4/RQCrokgbid942yyRSUmahOpT2zBBkOzpmkoKYB+lwVdZg==
Date: Wed, 17 Sep 2025 14:46:04 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] timer: tegra: Bind watchdog driver when timer node
 is processed
Message-ID: <20250917144604.49f792b4@wsk>
In-Reply-To: <20250826093936.3521235-1-lukma@nabladev.com>
References: <20250826093936.3521235-1-lukma@nabladev.com>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

Dear Community,

> The Tegra30 SoC is a bit special, as it doesn't have the separate IP
> block to provide watchdog functionality.
> 
> Instead, timer IP block allows such functionality when properly
> configured.
> 
> As in the tegra30.dtsi there is a timer node, which "covers" all
> timers, with 'nvidia,tegra30-timer' compatibility it was necessary to
> manually bind U-Boot's WDT driver (based on WDT_UCLASS).
> 
> Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> ---
>  drivers/timer/tegra-timer.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/timer/tegra-timer.c b/drivers/timer/tegra-timer.c
> index 3545424889d..361539efa43 100644
> --- a/drivers/timer/tegra-timer.c
> +++ b/drivers/timer/tegra-timer.c
> @@ -11,6 +11,8 @@
>  #include <asm/arch/clock.h>
>  #include <asm/arch/tegra.h>
>  
> +#include <dm/lists.h>
> +
>  #define TEGRA_OSC_CLK_ENB_L_SET		(NV_PA_CLK_RST_BASE +
> 0x320) #define TEGRA_OSC_SET_CLK_ENB_TMR	BIT(5)
>  
> @@ -106,6 +108,21 @@ static int tegra_timer_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> +static int tegra_timer_bind(struct udevice *dev)
> +{
> +	/*
> +	 * In Tegra 30 SoC the Watchdog is accomplished
> +	 * by the timer IP block (timer5).
> +	 */
> +	if (CONFIG_IS_ENABLED(WDT_TEGRA))
> +		return device_bind_driver_to_node(dev, "tegra_wdt",
> +						  "tegra-wdt",
> +						  dev_ofnode(dev),
> +						  NULL);
> +
> +	return 0;
> +}
> +
>  static const struct timer_ops tegra_timer_ops = {
>  	.get_count = tegra_timer_get_count,
>  };
> @@ -124,6 +141,7 @@ U_BOOT_DRIVER(tegra_timer) = {
>  	.id		= UCLASS_TIMER,
>  	.of_match	= tegra_timer_ids,
>  	.probe		= tegra_timer_probe,
> +	.bind		= tegra_timer_bind,
>  	.ops		= &tegra_timer_ops,
>  	.flags		= DM_FLAG_PRE_RELOC,
>  };

Are there any new comments regarding this patch set?

-- 
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
