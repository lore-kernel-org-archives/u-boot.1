Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809BFC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 06:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1938888356;
	Thu,  1 Aug 2024 08:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="iWz6VM2g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79C75880A7; Thu,  1 Aug 2024 08:42:03 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E40388ADB
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 08:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4C6BE1484E09; Thu,  1 Aug 2024 08:41:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1722494520; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=MAp8SBu68cDlNssLPNH2mevoVdVFjkJap8zg6AK4OHw=;
 b=iWz6VM2gh+OIuVnxe4X31TY2GCAoy6VzREOSiEOxr3w1k0sPIWMIlsHfDzJQw3V9nIFsPF
 x4Mpk9s63B/8dkPbcxFoI9iwKQACr9p9CijkB9HZOQjngwVdka43xHx7k4Xzt5Wdk3dzPi
 XmXdUCQHt3x3V2iGtIMw5NkIpFV3ahk0CmCbY3vCga2VP3eUdnJe78NzI2CJ+H59f+S4tZ
 OOn7+u0d4UmZcH+qeBAyx/nDSErd7FpwirPMEUPDfiENuWDQsT54f+I9kaSBmuODKtQyQT
 a6C23P0R9MGCYxuOeixvtZ8BehYSdbSueo8hmy6fHKMooHADWYFuTr0Dh4ai2w==
Date: Thu, 1 Aug 2024 08:41:52 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] cmd: led: fix led command usage for the LED_SW_BLINK
 enabled case
Message-ID: <20240801-semifinal-unselfish-9a93420501f9@thorsis.com>
Mail-Followup-To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20240731145613.48440-1-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731145613.48440-1-mikhail.kshevetskiy@iopsys.eu>
User-Agent: Mutt/2.2.12 (2023-09-09)
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

Hello Mikhail,

Am Wed, Jul 31, 2024 at 06:56:13PM +0400 schrieb Mikhail Kshevetskiy:
> CONFIG_LED_BLINK and CONFIG_LED_SW_BLINK can be defined independently.
> Led blinking works if any (or both) of them is enabled. Unfortunately
> the led command help does not display blinking option if only
> CONFIG_LED_SW_BLINK is enabled. This is definitely wrong.
> 
> This patch fix an issue.
> 
> Changes v2:
>  * patch description added

The changelog usually is not part of the commit message, but added
below three dashes ---

> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  cmd/led.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/led.c b/cmd/led.c
> index 2f786f34c67..91fb856ee59 100644
> --- a/cmd/led.c
> +++ b/cmd/led.c
> @@ -118,7 +118,7 @@ int do_led(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  	return 0;
>  }
>  
> -#ifdef CONFIG_LED_BLINK
> +#if defined(CONFIG_LED_BLINK) || defined(CONFIG_LED_SW_BLINK)

This looks fine.

Acked-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex

>  #define BLINK "|blink [blink-freq in ms]"
>  #else
>  #define BLINK ""
> -- 
> 2.39.2
> 
