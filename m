Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E0FC4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 13:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3724F87CDC;
	Wed,  7 Feb 2024 14:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="ypOx1ic7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF90A87CDC; Wed,  7 Feb 2024 14:14:57 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2C5D87CBC
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 14:14:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707311694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DRs42LT8wLiujIRH57OvE3/vLbjDmYb5tRQW1IHY2ZI=;
 b=ypOx1ic72tWlxE8+vKL6JcrIS0qe24+Qiw0umh1mOLNe1ps/o3/q18lTZnqDp5SjI8EWEt
 7ak7pWGjbEwQfKIoSHL1UaQDVGj3AdXO3XbsjHvmPw5AxLlohQ2DSQafv6khs6DQx71mAf
 cOn9wSA3JgxlAObzKiiUZVpFTyTTfIRck2ZboQtlAEop0RkFrzTnAhGlMNabX9z7gg9MuE
 noR1It8/AZxGEgjVaEdqCkhvPwLKqP4FvAT9tfKLb6JPrGEfnXkGFRzPJclzC4S3z06U6a
 QKr6JWALCMw6vkWhxiWjSM5C5XdP+uV334pmBLSv1JLvCTq0PXnPzVU35xQ9jA==
Date: Wed, 07 Feb 2024 14:14:53 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, andre.przywara@arm.com, Hector Martin
 <marcan@marcan.st>, Marek Vasut <marex@denx.de>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [FIX PATCH v1] Fix: common: usb_hub: Reset only USB3.0 hub
In-Reply-To: <20240207102327.35125-1-i@shantur.com>
References: <20240207102327.35125-1-i@shantur.com>
Message-ID: <76674885ff74d02d96e49d41759eaa85@manjaro.org>
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

Hello Shantur,

Please see my notes below.

On 2024-02-07 11:23, Shantur Rathore wrote:
> USB 3.0 spec requires hub to reset device while
> enumeration. Some USB 2.0 hubs / devices don't
> handle this well and after implementation of
> reset some USB 2.0 disks weren't detected on
> Allwinner based boards.
> 
> Resetting only when hub is USB 3.0 fixes it.
> 
> Tested-by: Andre Przywara <andre.przywara@arm.com>
> 
> Signed-off-by: Shantur Rathore <i@shantur.com>

Please, add the "Fixes" line available below, reformat the patch
description to the usual 78-character width, and remove unnecessary
"FIX " from the patch subject prefix.

Fixes: 33e06dcbe57a ("common: usb-hub: Reset hub port before scanning")

As a side note, such tags can be produced very easily by running
"git log --max-count=1 --pretty=fixes <commit>".  I have an alias
like that defined in my ~/.gitconfig.

With these changes applied, please feel free to also add:

Reviewed-by: Dragan Simic <dsimic@anjaro.org>

> ---
> 
>  common/usb_hub.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/common/usb_hub.c b/common/usb_hub.c
> index 3fb7e14d10..2e054eb935 100644
> --- a/common/usb_hub.c
> +++ b/common/usb_hub.c
> @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct usb_hub_device 
> *hub)
> 
>  	debug("enabling power on all ports\n");
>  	for (i = 0; i < dev->maxchild; i++) {
> -		usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
> -		debug("Reset : port %d returns %lX\n", i + 1, dev->status);
> +		if (usb_hub_is_superspeed(dev)) {
> +			usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
> +			debug("Reset : port %d returns %lX\n", i + 1, dev->status);
> +		}
>  		usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
>  		debug("PowerOn : port %d returns %lX\n", i + 1, dev->status);
>  	}
