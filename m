Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5589CF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76A2289270;
	Thu, 19 Sep 2024 16:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KbJRd51l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D72DC89286; Thu, 19 Sep 2024 16:14:30 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B333D891B3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7d666fb3fb9so482484a12.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755267; x=1727360067; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=af7NMf6mRKHYMEQ2H8CqjVGYi56JRt2HtCEshERuDG4=;
 b=KbJRd51lrh/zFsYYNn3k4FPYGS7agxV6NVMaxnWnQa4anms81o8LDVEJLRUQeG3fyW
 KvEZIfUKs30mQwJvZd8yvSdYAd9ti4FPYYYgpnKof4Obu9ZbTF5JlTAXCynQ9euyLkkv
 F9VHHcJPCplEdoz7HwsIs63rM4gMe1r38P54A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755267; x=1727360067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=af7NMf6mRKHYMEQ2H8CqjVGYi56JRt2HtCEshERuDG4=;
 b=Agj4KyRL75VNXtXTGsKGc3NIjWsrpdUJvQIHxuDEdnB1B/MsSVXovg0SGwE8wm6y14
 8D54xS9lCxqJ+jsED5X0nfSkeiMAMP+2tkzHJ6rDkifpni7oaeLTDOSwYVSpg7KqU7qA
 oi1oWkcPbyb+haBnWQOGaVxBSEnnB4XX1Sp+okC6IUZtmLxckDVb4oK5JAEV1+Hgs4k6
 uIQYnzgt8OBMQiFKBfegwCv1RPjibpfr45lVIT82um+pc7IlXZHCMLi/ybVEzGjFPp4B
 FePjCqF2gd80oT0HdUnPudCN3XDytQEXzpoKy1mMkVLzKPPpHVYYJez9rXtAT2mj5nba
 zaTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUekSia/qx49AYnbe2SBz6dlw1+MGBO9dg3MRDHo7nW4WWw0qtk8iynILRsw29jJrHiWuBfm3I=@lists.denx.de
X-Gm-Message-State: AOJu0YwSX6wv6rQGjPYS4lfRYFmqS2XPr681u3e8ycwBsc1ZNp0N1Lnm
 UdVT3Kup3fRhVo4Vf7YnilwCPnJ66JbMKIUPFHDOyQs7ORWUCZPMGxaslDTZ4XfrXILXRDJtQwf
 n/bA2w94ZBKImWScDdrMHMqpm2M7aT5jSQSLx
X-Google-Smtp-Source: AGHT+IHp6LXD0iyO13WlewojoYH37ncyvePjfypTbMdGvtJ9GZR1Cnm2TcLYLgLUI0cSqxBlYLaUCSwem7N2uZxXzu8=
X-Received: by 2002:a05:6a20:6c93:b0:1d2:fad2:a537 with SMTP id
 adf61e73a8af0-1d2fca92f73mr4163621637.18.1726755267295; Thu, 19 Sep 2024
 07:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
 <20240812103254.26972-7-ansuelsmth@gmail.com>
In-Reply-To: <20240812103254.26972-7-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:13:56 +0200
Message-ID: <CAFLszTiE3EzG+HU4yVV7p=kXS_EiLQFsZcqph_CHvwfD2PezVw@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] tftp: implement support for LED activity
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>, 
 Dmitry Dunaev <dunaev@tecon.ru>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
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

Hi Christian,

On Mon, 12 Aug 2024 at 12:33, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Implement support for LED activity. If the feature is enabled,
> make the defined ACTIVITY LED to signal traffic.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  net/tftp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/tftp.c b/net/tftp.c
> index 2e073183d5a..45c2455336a 100644
> --- a/net/tftp.c
> +++ b/net/tftp.c
> @@ -10,6 +10,7 @@
>  #include <efi_loader.h>
>  #include <env.h>
>  #include <image.h>
> +#include <led.h>
>  #include <lmb.h>
>  #include <log.h>
>  #include <mapmem.h>
> @@ -192,6 +193,9 @@ static void new_transfer(void)
>  #ifdef CONFIG_CMD_TFTPPUT
>         tftp_put_final_block_sent = 0;
>  #endif
> +#ifdef CONFIG_LED_ACTIVITY_ENABLE
> +       led_activity_blink();

If you make that an empty static inline when !LED_ACTIVITY_ENABLE and
a real function when CONFIG_LED_ACTIVITY_ENABLE, then you can drop the
#ifdef here.

Also, can you drop the _ENABLE suffix? All CONFIGs enable something.

> +#endif
>  }
>
>  #ifdef CONFIG_CMD_TFTPPUT
> @@ -301,6 +305,9 @@ static void tftp_complete(void)
>                         time_start * 1000, "/s");
>         }
>         puts("\ndone\n");
> +#ifdef CONFIG_LED_ACTIVITY_ENABLE
> +       led_activity_off();
> +#endif
>         if (!tftp_put_active)
>                 efi_set_bootdev("Net", "", tftp_filename,
>                                 map_sysmem(tftp_load_addr, 0),
> --
> 2.45.2
>

Regards,
Simon
