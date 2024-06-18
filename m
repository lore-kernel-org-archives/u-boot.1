Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAFFC2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 09:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C275C88485;
	Tue, 18 Jun 2024 11:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="rhZwNqQ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5248B831A2; Tue, 18 Jun 2024 11:44:18 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4188588485
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 11:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1718703854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGKRmUzsmwX9vmsXgn7y4Mbsxt5kqU/hkBdA+dANk8s=;
 b=rhZwNqQ0lisuqLCyxMZYi/KMZtWipzCn9zeftbOAHxudGpm9ObMQeOxx9GWL85Crt5eySh
 TgL2XsjuH37K+knBicc/TCh/SlBgvEdedN5iogK9wzfqRRCwHi9ITalUchbhs3Pz3nKRhS
 qVs/zCH5Ve0K+d+sR+f1Ju56gIoLcmijKClHJepOkYbvuwDvhrsadmXlEr3iEhj1aXmmTk
 T3LTzopho1Z1pFKmYcwCccRiL8MwYHBgslZTDdpZcUHWlss02ysdIKRwjGMmfjOIvUG96c
 fbtPSzvWSCzMTDWvNnmnWD74J3h7W9vhMOYPqI3iRidwZFfqIZ8pwi4DD4K6pQ==
Date: Tue, 18 Jun 2024 11:44:13 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] usb: informative message if no controller
In-Reply-To: <20240618081632.29995-1-heinrich.schuchardt@canonical.com>
References: <20240618081632.29995-1-heinrich.schuchardt@canonical.com>
Message-ID: <0405e4f048f0cfbfa7f83df2edb82975@manjaro.org>
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

Please see a nitpick below.

On 2024-06-18 10:16, Heinrich Schuchardt wrote:
> The message 'No working controllers found' provides no clue that this
> refers to USB controllers.
> 
> Provide a message that refers to USB.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	add 'found' at end of message
> 	keep printf
> ---
>  drivers/usb/host/usb-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/usb-uclass.c 
> b/drivers/usb/host/usb-uclass.c
> index a1cd0ad2d66..bd861270af3 100644
> --- a/drivers/usb/host/usb-uclass.c
> +++ b/drivers/usb/host/usb-uclass.c
> @@ -388,7 +388,7 @@ int usb_init(void)
> 
>  	/* if we were not able to find at least one working bus, bail out */
>  	if (controllers_initialized == 0)
> -		printf("No working controllers found\n");
> +		printf("No USB controller found\n");

The plural form, "controllers", should be used instead, because it 
sounds
more natural.  I wrote it that way in my earlier response. [1]

[1] 
https://lore.kernel.org/u-boot/f75f053e1fc43307f239451e85dc13fe@manjaro.org/

>  	return usb_started ? 0 : -ENOENT;
>  }
