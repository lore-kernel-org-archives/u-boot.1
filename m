Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44E0C87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 11:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 641D9846DD;
	Fri,  8 Aug 2025 13:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uAxuEZR2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 470CE846E2; Fri,  8 Aug 2025 13:57:32 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB92846CC
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 13:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bz2Zw36nrz9tJV;
 Fri,  8 Aug 2025 13:57:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754654248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IhPT3GeytCUB9ry5jyA0wHgTh6zEw23MHtDybMPPVyo=;
 b=uAxuEZR2Furz0mx+Vu+pqHYsv8LKBq9OkMS7RSrHmEd2JrHTAh7luUQO8z89flnBSZ+9yh
 d4v+3wWIfUAwKIix+KDsBhsRNwl4h9S/fXyrjuYPEDOxg4+bObx2gFpziqML2JjOLKbBR3
 59c6q2aFal4TNG0FzEUZ98kjwr1dM5q8kJjLcKABpNQPHFMpHlV5ALS9XKog2EIwE6+ag8
 33DmkhSg8Giva18tjhHqSbr5MXtvOdsGInBZHxQ9YW5BEBgcEdsXdlk/v46aaEwro1QbMK
 QDqnt3pGjtzW9dwmr9rm6xWOtKUir8WU32UexslZKrv34Cg//PQO6+KH5yXlnw==
Message-ID: <bf71ed1c-b18a-489e-a9ad-ec14a5577667@mailbox.org>
Date: Fri, 8 Aug 2025 13:57:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] watchdog: Tighten some watchdog driver dependencies
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250806145637.1664675-1-trini@konsulko.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20250806145637.1664675-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: q6gyarzydszfwu9uz79cb9g5synkek85
X-MBO-RS-ID: 6f4b615affa50fc8657
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

On 06.08.25 16:56, Tom Rini wrote:
> A few watchdog drivers cannot build without access to some platform
> specific header files. Express those requirements in Kconfig as well.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Stefan Roese <stefan.roese@mailbox.org>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/watchdog/Kconfig | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index e9ea874d0e3d..463f9249c611 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -43,6 +43,7 @@ config HW_WATCHDOG
>   
>   config IMX_WATCHDOG
>   	bool "Enable Watchdog Timer support for IMX and LSCH2 of NXP"
> +	depends on MACH_IMX
>   	select HW_WATCHDOG if !WDT
>   	help
>   	  Select this to enable the IMX and LSCH2 of Layerscape watchdog
> @@ -64,6 +65,7 @@ config OMAP_WATCHDOG
>   
>   config ULP_WATCHDOG
>   	bool "i.MX7ULP watchdog"
> +	depends on MACH_IMX
>   	help
>   	  Say Y here to enable i.MX7ULP watchdog driver.
>   
> @@ -116,8 +118,8 @@ config WDT_ARMADA_37XX
>   
>   config WDT_ASPEED
>   	bool "Aspeed ast2400/ast2500 watchdog timer support"
> -	depends on WDT
> -	default y if ARCH_ASPEED
> +	depends on WDT && ARCH_ASPEED
> +	default y
>   	help
>   	  Select this to enable watchdog timer for Aspeed ast2500/ast2400 devices.
>   	  The watchdog timer is stopped when initialized. It performs reset, either
> @@ -127,8 +129,8 @@ config WDT_ASPEED
>   
>   config WDT_AST2600
>   	bool "Aspeed AST2600 watchdog timer support"
> -	depends on WDT
> -	default y if ASPEED_AST2600
> +	depends on WDT && ASPEED_AST2600
> +	default y
>   	help
>   	  Select this to enable watchdog timer for Aspeed ast2500/ast2400 devices.
>   	  The watchdog timer is stopped when initialized. It performs reset, either
> @@ -136,7 +138,7 @@ config WDT_AST2600
>   
>   config WDT_AT91
>   	bool "AT91 watchdog timer support"
> -	depends on WDT
> +	depends on WDT && ARCH_AT91
>   	help
>   	  Select this to enable Microchip watchdog timer, which can be found on
>   	  some AT91 devices.
> @@ -173,7 +175,7 @@ config WDT_CDNS
>   
>   config WDT_CORTINA
>   	bool "Cortina Access CAxxxx watchdog timer support"
> -	depends on WDT
> +	depends on WDT && TARGET_PRESIDIO_ASIC
>   	help
>   	  Cortina Access CAxxxx watchdog timer support.
>   	  This driver support all CPU ISAs supported by Cortina
> @@ -219,7 +221,7 @@ config WDT_MAX6370
>   
>   config WDT_MCF
>   	bool "ColdFire family watchdog timer support"
> -	depends on WDT
> +	depends on WDT && M68K
>   	help
>   	  Select this to enable ColdFire watchdog timer,
>   	  which supports mcf52x2 mcf532x mcf523x families.
> @@ -303,7 +305,7 @@ config WDT_OMAP3
>   
>   config WDT_ORION
>   	bool "Orion watchdog timer support"
> -	depends on WDT
> +	depends on WDT && ARCH_MVEBU
>   	select CLK
>   	help
>   	  Select this to enable Orion watchdog timer, which can be found on some

