Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8FBC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 11:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AFAA87534;
	Mon, 27 Nov 2023 12:58:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QWLAQ8Ns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DAC18714A; Mon, 27 Nov 2023 12:58:33 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2355B87539
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 12:58:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian.gmeiner@gmail.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1fa0885e1c2so1538741fac.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 03:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701086307; x=1701691107; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xN/gPpoyIZWVoU9g4K/8XD72++LaJbLzPEnItw+gsOg=;
 b=QWLAQ8NsOppkr2uwuIcVz+FSaJ3oIBTk+quV8YMEk1j6eMnH1sGCwS6PmT6th9bVXc
 jvdHGboY6aLPZzqsHS7Vim9EmPBjXM/GzbEpEta7lQUIaYzefbsU2XKKWGjEELFEXfkb
 CscxFqS2V7O9qdnc9U/Rr57mQulkEe0n+5XdoPQiDjCb3bhacC6HeDKSwtZ+Xt5UcvnB
 ZIsUCxoOALCPduomT8s7TrNoVlQXwLIAEtTEhgBVNf4DkQyq/MKApPYSSdpownGAJ0kH
 L8LYAvKLeUDYsSlKwW4eSNYOs3i4AA1/8aI3Rw85+0Cfg2qYmyH2THdkvN4Qhi51P7QN
 ZQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701086307; x=1701691107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xN/gPpoyIZWVoU9g4K/8XD72++LaJbLzPEnItw+gsOg=;
 b=Tz2qmuhYff5XxXdcO8hBDtCPjR79lIz5KzW6mv78932EPFx4VCrBbOA79ogcR0mEof
 mUqgg+lhKNoEko2f0F5ILjE4go9EVo/J9KMTKINU7YwmsNbQ42r/3fH1+zvH6B0MrxIU
 nmqSfgacKws2dVXfNbcdmEPlIPwKyoujz4Q0+gRzEKXLwV7RB8Bue7yV3KBxpi5AK34M
 5QThBzQ26roj4tFHZctm6TiJQMmLRDEaStaoL72mJpj7mfZl7Y4lZWfwxpPvhYRS3oWr
 i5Qcgnoptdm6TbMPGmYzs79AlX8k9IF1gqMetKTEWfrQ43i33gfmOovMiS98zpDb/5US
 RyLA==
X-Gm-Message-State: AOJu0Yw6FM1y93pWBSmPNT6dtlR9ZTJErXEPuFB6GjuErTAOWUCYYRwo
 K9CHoiOAR4DmfnvLbwLm4Qte/4cfSe1Yobf0sWg=
X-Google-Smtp-Source: AGHT+IGnux8fGVCJBpfkap5vAea6G0WgjTstyM8hBGdhw7mKuPH7XKT4FCdQSuWzZRsnYUUYbAmxjafIDHHXbWyqtRk=
X-Received: by 2002:a05:6870:aa86:b0:1f5:ef27:9c0c with SMTP id
 gr6-20020a056870aa8600b001f5ef279c0cmr16269845oab.36.1701086307639; Mon, 27
 Nov 2023 03:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20231117113811.149329-1-rasmus.villemoes@prevas.dk>
 <20231117113811.149329-5-rasmus.villemoes@prevas.dk>
In-Reply-To: <20231117113811.149329-5-rasmus.villemoes@prevas.dk>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 27 Nov 2023 12:58:16 +0100
Message-ID: <CAH9NwWdkG9LrTps38aZ+MRnn7VN=FAD3fqpWOA4F0KX935TwOw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] led: led_gpio: use led_bind_generic() helper
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

>
> Use the helper led_bind_generic() to reduce code duplication.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>

> ---
>  drivers/led/led_gpio.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/drivers/led/led_gpio.c b/drivers/led/led_gpio.c
> index fbed151b5d9..71421de628c 100644
> --- a/drivers/led/led_gpio.c
> +++ b/drivers/led/led_gpio.c
> @@ -11,7 +11,6 @@
>  #include <log.h>
>  #include <malloc.h>
>  #include <asm/gpio.h>
> -#include <dm/lists.h>
>
>  struct led_gpio_priv {
>         struct gpio_desc gpio;
> @@ -80,19 +79,7 @@ static int led_gpio_remove(struct udevice *dev)
>
>  static int led_gpio_bind(struct udevice *parent)
>  {
> -       struct udevice *dev;
> -       ofnode node;
> -       int ret;
> -
> -       dev_for_each_subnode(node, parent) {
> -               ret = device_bind_driver_to_node(parent, "gpio_led",
> -                                                ofnode_get_name(node),
> -                                                node, &dev);
> -               if (ret)
> -                       return ret;
> -       }
> -
> -       return 0;
> +       return led_bind_generic(parent, "gpio_led");
>  }
>
>  static const struct led_ops gpio_led_ops = {
> --
> 2.40.1.1.g1c60b9335d
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
