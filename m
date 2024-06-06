Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A19C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 940D488266;
	Thu,  6 Jun 2024 14:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PrJ8jj3a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E32B85B66; Thu,  6 Jun 2024 10:22:21 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1DCC87D9B
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 10:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2e73359b900so7366651fa.2
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 01:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717662137; x=1718266937; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cAsxX/elzOe1XcClK8A7xpzg0t+9W39ZnnAzl2gIm1Q=;
 b=PrJ8jj3aTBJ8wxz0dVTXnOxM2mCWC1D60D06UQ3h4ZoMGj0fzLHwnGfBJGQGUNaxn/
 PEVYha5/rKdiTjW8jCqA+f/Zjr7+AgdBVw0cYDbNFyiNnJNzxvXMjY2754v3SqAy8QPQ
 jfgmXJliSBn7yxUftJ2pi63bTlLvMdJizkZ1WrerNm27zVwjDAzuDOlwKGDfcvsviMbJ
 G/B0ddOzzXZDL+Mr3Z3S3FlICGo8ZVDRuSS+4IDk0r1uim47LbqN6du40LLiGq7KATgH
 nNEeEyWaAKOLrd4m6AZQXErbC/T+Pz/cKXWGtgbfDFQQu2FsvLZmJbCzY4tCfWWdCtZi
 xhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717662137; x=1718266937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cAsxX/elzOe1XcClK8A7xpzg0t+9W39ZnnAzl2gIm1Q=;
 b=FLHUf0I05J8XSQaW1RSxQpEnOU5VBTKHMogMmwFRZstZ5wMmIwOcvcMebLgixj5Ijw
 2g2h1UoK001kcNsLUDQd3sPXIHtX2p/7/hsZTI8ucTM7sLx8CCPATJNY7arXxqDUYgER
 yzLhwGn9op9XJKTLd/x53wEcRRhm5QnhTuaYgfgkLdeDzoCjliuiiwFLhYwmhhJhWlHT
 Rh8IWVbYGdV8CdF996P3EAOfGMhgoOomKcIHY/GruIHi+IqBqKwzK1QQ9wI1kdhCLbgC
 +qe55UifggBFlz/2BLAVfr7OIg6fU9FAs57nMhHXCKY4L55ZNhKr7Ydn0TfKWz2cP2hT
 +4Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZUX5X900sB8QoAN4tNZ7/dUSgDoi9g6SkhZGfZW1Xi5Nu5aDZ6qGv1siIvY3SKtsziHE4hIU+Tjr21mdDcqR2ckwRvQ==
X-Gm-Message-State: AOJu0YwDiy/HrOcuYoFeOU67uXsmwk6BrQXvLbpyIRA4BDH8uw/K1Dlh
 N7aFeV09vmA4mkAlk2MdFML/3xLSUR1OPlWhoW0o33Mdyf7xtgrfg6CD1fz8aWtmsSZ53+qS1MR
 2KVua4R4fR7TgpH1RJLqgXRbX+UY=
X-Google-Smtp-Source: AGHT+IEgF7/TLvtUrAmD5gjgUpeyBRcz/YBRX5h1uRgozjtPnTvQNRtkdgpBSJGpTAZXlTk/C0O3OiDJ69thC9Dwwus=
X-Received: by 2002:a2e:3802:0:b0:2e9:8a0a:ea05 with SMTP id
 38308e7fff4ca-2eac7a12757mr28422251fa.17.1717662136931; Thu, 06 Jun 2024
 01:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240605192146.19052-1-ansuelsmth@gmail.com>
 <20240605192146.19052-6-ansuelsmth@gmail.com>
In-Reply-To: <20240605192146.19052-6-ansuelsmth@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 6 Jun 2024 09:22:05 +0100
Message-ID: <CALeDE9Pa8362N_HBKk6Z1Rjn+nTa_pQky8Cur-ABB9NpySwULw@mail.gmail.com>
Subject: Re: [PATCH 5/7] tftp: implement support for LED status activity
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Vignesh R <vigneshr@ti.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Dmitry Dunaev <dunaev@tecon.ru>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Eugene Uriev <eugeneuriev@gmail.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Doug Zobel <douglas.zobel@climate.com>,
 William Zhang <william.zhang@broadcom.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>, 
 Bruce Suen <bruce_suen@163.com>, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Pratyush Yadav <p.yadav@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 06 Jun 2024 14:31:15 +0200
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

On Wed, 5 Jun 2024 at 20:51, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Implement support for LED status activity. If the feature is enabled,
> make the defined ACTIVITY LED to signal traffic.

Would this not just duplicate the activity on the NIC LED?

> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  net/tftp.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/net/tftp.c b/net/tftp.c
> index 2e335413492..07dea321bb4 100644
> --- a/net/tftp.c
> +++ b/net/tftp.c
> @@ -19,6 +19,7 @@
>  #include <asm/global_data.h>
>  #include <net/tftp.h>
>  #include "bootp.h"
> +#include <status_led.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> @@ -193,6 +194,10 @@ static void new_transfer(void)
>  #ifdef CONFIG_CMD_TFTPPUT
>         tftp_put_final_block_sent = 0;
>  #endif
> +#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
> +       status_led_set(CONFIG_LED_STATUS_ACTIVITY,
> +                      CONFIG_LED_STATUS_BLINKING);
> +#endif
>  }
>
>  #ifdef CONFIG_CMD_TFTPPUT
> @@ -228,6 +233,10 @@ static void show_block_marker(void)
>  {
>         ulong pos;
>
> +#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
> +       status_led_activity(CONFIG_LED_STATUS_ACTIVITY);
> +#endif
> +
>  #ifdef CONFIG_TFTP_TSIZE
>         if (tftp_tsize) {
>                 pos = tftp_cur_block * tftp_block_size +
> @@ -290,6 +299,9 @@ static void tftp_complete(void)
>         /* Print hash marks for the last packet received */
>         while (tftp_tsize && tftp_tsize_num_hash < 49) {
>                 putc('#');
> +#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
> +               status_led_activity(CONFIG_LED_STATUS_ACTIVITY);
> +#endif
>                 tftp_tsize_num_hash++;
>         }
>         puts("  ");
> @@ -302,6 +314,10 @@ static void tftp_complete(void)
>                         time_start * 1000, "/s");
>         }
>         puts("\ndone\n");
> +#ifdef CONFIG_LED_STATUS_ACTIVITY_ENABLE
> +       status_led_set(CONFIG_LED_STATUS_ACTIVITY,
> +                      CONFIG_LED_STATUS_OFF);
> +#endif
>         if (!tftp_put_active)
>                 efi_set_bootdev("Net", "", tftp_filename,
>                                 map_sysmem(tftp_load_addr, 0),
> --
> 2.43.0
>
