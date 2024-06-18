Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBC3C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 10:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C998B882FE;
	Tue, 18 Jun 2024 12:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="EZMOpbQa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC040880F5; Tue, 18 Jun 2024 12:04:24 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1A9C882FE
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 12:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1718705062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5lx9RoRNpW0f5xoWdbatC9Jia+jTY0yI/WGaVoa9U/E=;
 b=EZMOpbQadil9dbXfp6TJyA7gXLLhF/DU/XrecVa97ZFmpodWuaHi4JH53p7JkdWpQ1+/C3
 9bRrfl6knHWYr0GCVQPv0gCuaP6cOW6FjH1qf25KFX+LxEp59fW0GyPqbtU6vg7ZBqZoeh
 5fmHmICNZva74WUCxXRe4sDANLMoMbyRz3nxevn2IYi1ZRXgsd3m+DK229WX70vy/YRelH
 wgQg6A62wUpFjf6j/wdWZ8jYYm6Ji4RhkUIKD5V9vD2nqD/TM3yF5r3ywMB3AGWR3ke9P8
 GdvBBUnogyC4lu9d4/iXdybrBZkkIJXVqYkY7JTMMPP+3j4dMllbXrMTxA2xeA==
Date: Tue, 18 Jun 2024 12:04:21 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/1] usb: informative message if no controller
In-Reply-To: <20240618095857.58088-1-heinrich.schuchardt@canonical.com>
References: <20240618095857.58088-1-heinrich.schuchardt@canonical.com>
Message-ID: <0a7c5e5c0d75e1ce41227371c78e268e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-06-18 11:58, Heinrich Schuchardt wrote:
> The message 'No working controllers found' provides no clue that this
> refers to USB controllers.
> 
> Provide a message that refers to USB. Use log_info().
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Thanks for rerolling this patch.  Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> v3:
> 	plural controllers
> v2:
> 	add 'found' at end of message
> 	keep printf
> ---
>  drivers/usb/host/usb-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/usb-uclass.c 
> b/drivers/usb/host/usb-uclass.c
> index a1cd0ad2d66..e16432a1516 100644
> --- a/drivers/usb/host/usb-uclass.c
> +++ b/drivers/usb/host/usb-uclass.c
> @@ -388,7 +388,7 @@ int usb_init(void)
> 
>  	/* if we were not able to find at least one working bus, bail out */
>  	if (controllers_initialized == 0)
> -		printf("No working controllers found\n");
> +		printf("No USB controllers found\n");
> 
>  	return usb_started ? 0 : -ENOENT;
>  }
