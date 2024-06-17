Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB10CC27C6E
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 08:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 225C987D14;
	Mon, 17 Jun 2024 10:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="ZCjXXobi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6689787DC7; Mon, 17 Jun 2024 10:20:59 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C19B87CF8
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1718612457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0NzthycOwLWDjgCSmji+YB+JemWI6UthXwMPMq/+Emo=;
 b=ZCjXXobiNmjSx7EXIL+0Du/NHgNuk4O695rhFyEXWbjFPT2W8tgNK+WyrloebUa9fKl1yr
 15dn1Qm8lpm2B6dT6Os4DwSJ7DCbz3SCuPpvXQrWy9bFysR0HMywrl/Ag+/z/L7mnpqxDz
 D2hWhjQHk4dAN/otK9i8vKLzzi+Q7qRsyLEbD+H0SiohZ3h9pscF3MvOwTHVYo5Je3gud9
 LY0+oxxSLiWLYV8QjLeyLyBwZnohneos56QWTd0oO0/o6JFi5qFCo+ZRIhwqqUGNy0oukT
 zyaW/896/84Lg5/AStaiLEO+biXeDYc5VFaNck7azAVfDWvmbo2DIGlaKLzp5w==
Date: Mon, 17 Jun 2024 10:20:56 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] usb: informative message if no controller
In-Reply-To: <20240617081654.74294-1-heinrich.schuchardt@canonical.com>
References: <20240617081654.74294-1-heinrich.schuchardt@canonical.com>
Message-ID: <f75f053e1fc43307f239451e85dc13fe@manjaro.org>
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

Hello Heinrich,

On 2024-06-17 10:16, Heinrich Schuchardt wrote:
> The message 'No working controllers found' provides no clue that this
> refers to USB controllers.
> 
> Provide a message that refers to USB. Use log_info().
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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
> +		log_info("No USB controller\n");

It would be better to use "No USB controllers found" as the error 
message,
because it reads better and provides additional clues.

>  	return usb_started ? 0 : -ENOENT;
>  }
