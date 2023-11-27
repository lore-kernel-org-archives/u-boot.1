Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02017C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 11:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 216EC87512;
	Mon, 27 Nov 2023 12:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="en3vzq1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A021A8714A; Mon, 27 Nov 2023 12:58:51 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E8698752E
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 12:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian.gmeiner@gmail.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1f9decb7446so1944170fac.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 03:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701086325; x=1701691125; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BOcG8/rSDljikazEgNQdJUgL7FE4pmh5YeW8IUzL3RQ=;
 b=en3vzq1Ubr8fdirmlec9nk3yKAwLD4PyALRsOlWt2f/94ciDJcG/h0zQ/FxeYrLngM
 fQWa5wgV2MYLSSn3G6GzHJwWx6jzCvbsFygtXmdMYnXFEbMHNL7PpJHUrELItEYIgV7t
 L7ZOd7gBa7k2InnGVBpES1VCIYDUdFCQA4EzLkvy1IPiMA8DjG3Dq6yxfS1FqboUKavy
 WTZ/pSL0tTXJbpyBYxpvZVQDnCHBJ/q07LpjiZtBmp1qp4Upebw/2bCI7moBlkw+E4sL
 o1pH8QrWFgJpOHmJk6vXb6SQ8j6akI79XMOtJe0SG7NiNchRUdTYgjKeMDHAtVbFINaO
 ARMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701086325; x=1701691125;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BOcG8/rSDljikazEgNQdJUgL7FE4pmh5YeW8IUzL3RQ=;
 b=u+MZLeJDI6TDBGx1lL+3cbkkL8ERYD/lP07ia7cKDdgkyi0OWNbJv/YZO+fnb8wzKJ
 snLRyGoEU06Kq3uMiUmyo5UMS6H4ovEFHuG0pjVv9kNjeVtm2kEcpj6zXrDd8x46dHiw
 qVHtWsa/g46/7H9RHMv+jz4oeNWc1dRcB9JKcZmArUFcifl6iUQQjIlBVwpeudCqczfn
 1DlQrHL9B3iaBMgahLXoI9ZN4aFhPNPtGYXUgGS7fNr54+Sbopq4jjG3pI06/ti3Xq6M
 6sHAzRcb30lmZkRRq5GLbiff5GbNGie9w8kp3HT6WYTDVQ9T4q70+zkWN9v429w0SJhD
 DoxA==
X-Gm-Message-State: AOJu0YwLHgUu1eRFndRO3abwVMAladkCrxxn6UXYMnePjzG/bOP3buvH
 NPz7bxiZRTyw9xZCgKB74DkjalVUQSuS8LRwF5n++8ijzgw3dg==
X-Google-Smtp-Source: AGHT+IGcsyAmH+HxzMesjKyO3NBAhyMPQtbHuNdWtgNZpdAyU5kXRsKSgj6zkblP2NHwMyZtwGnJo82lJ7HYoymvbFs=
X-Received: by 2002:a05:6870:b4a2:b0:1fa:3ba8:93d2 with SMTP id
 y34-20020a056870b4a200b001fa3ba893d2mr6159332oap.50.1701086325610; Mon, 27
 Nov 2023 03:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20231117113811.149329-1-rasmus.villemoes@prevas.dk>
 <20231117113811.149329-6-rasmus.villemoes@prevas.dk>
In-Reply-To: <20231117113811.149329-6-rasmus.villemoes@prevas.dk>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 27 Nov 2023 12:58:34 +0100
Message-ID: <CAH9NwWfVk_xav5cW6RcRqgROZ2NHsga2soPLozH7j9KaD1S4nA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] led: led_pwm: use led_bind_generic() helper
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
>  drivers/led/led_pwm.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/led/led_pwm.c b/drivers/led/led_pwm.c
> index 7c8eae9337b..ae6de3087ab 100644
> --- a/drivers/led/led_pwm.c
> +++ b/drivers/led/led_pwm.c
> @@ -9,7 +9,6 @@
>  #include <errno.h>
>  #include <led.h>
>  #include <malloc.h>
> -#include <dm/lists.h>
>  #include <pwm.h>
>
>  #define LEDS_PWM_DRIVER_NAME   "led_pwm"
> @@ -136,18 +135,7 @@ static int led_pwm_of_to_plat(struct udevice *dev)
>
>  static int led_pwm_bind(struct udevice *parent)
>  {
> -       struct udevice *dev;
> -       ofnode node;
> -       int ret;
> -
> -       dev_for_each_subnode(node, parent) {
> -               ret = device_bind_driver_to_node(parent, LEDS_PWM_DRIVER_NAME,
> -                                                ofnode_get_name(node),
> -                                                node, &dev);
> -               if (ret)
> -                       return ret;
> -       }
> -       return 0;
> +       return led_bind_generic(parent, LEDS_PWM_DRIVER_NAME);
>  }
>
>  static const struct led_ops led_pwm_ops = {
> --
> 2.40.1.1.g1c60b9335d
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
