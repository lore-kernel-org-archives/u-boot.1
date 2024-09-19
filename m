Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4EECF3944
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE3FE8921D;
	Thu, 19 Sep 2024 16:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Btjap+WH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DC3B89269; Thu, 19 Sep 2024 16:14:06 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3106D8923F
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2da55ea8163so642257a91.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755237; x=1727360037; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hMspWoc6R91Xwu/f7H9DRF4FWwYyRXab00ZnsjcWVBA=;
 b=Btjap+WHN4P7rDUvmGZrPFGobCEkCAtaPyH9ugMpUXKMoZ6RhZAsqk3Uo+BlKPWmoA
 t9SAvMjFxCQFZkBSd3NCYVgKVbE97ndIrajKQ2eSeueHrvWOElvbT7esUiC6P/8kKnqB
 tdeXLDINzRgftFnXGbtdPWA51KClfbCenB1L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755237; x=1727360037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hMspWoc6R91Xwu/f7H9DRF4FWwYyRXab00ZnsjcWVBA=;
 b=xP14b5NzbZDT5OF6aJhmQYJP0Rn7t+22iyp3PF9ZuJf0V2QnjUpb96JGybcxeOIO/Q
 DqmOS/OKsHosr8SEqyNLowU7FWCYJseM9xOkaxD3X8R8cNV2nAmWsw3VEvvLQbK1IYHL
 T9VRdJw6JmqOlIdV8rvjvfJpXc9WGi7sH1zOrxe5hVb7xFgxD/GNXM/s9Og7SDbQVP/N
 tP45ESZosC75AGHMuVt3U0H4iGYbN5YEl6WAUSbgXbL+HtEhwF5QB+C9Upscm/OL0xWU
 0X49t8WuyHKc/zyM+0LXZMeJVMHAR4g0FCUn51Ksbf8CyF2aEyHfBHmr8bnWWTSUOO+3
 Hm1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEecdTcaLlIfIXJUgHNk45sv+iacwYOkVJSW9CCTMnZfmL4d/4XPv8fNEvJxlYM1OlXGRHChk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzka4WLTSzrtlgUxITTEe7x6kyQbBoKDGt5zpsJAoJF7J6S2GoV
 uLkcQapfcj3ByRadUkTGh1IT9azovQ1nJobPnV82LPkJD/Aden4FJM0R/YuMeM98gdlc+QSb+I9
 QyZOGETk/46KmAdqDvv7Pkx5lKuHjICXuLr3c
X-Google-Smtp-Source: AGHT+IFTvNOYKFai6zF4lk06XERn1RxIp7x2Qlxh25aNQ+KrAMe0MW7qOGbj9h2RnmH5e73LQTwMoMmlW5T7a1p/S3U=
X-Received: by 2002:a17:90b:4a4a:b0:2d3:d398:3c1e with SMTP id
 98e67ed59e1d1-2dba0082fb8mr32000860a91.36.1726755236678; Thu, 19 Sep 2024
 07:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
 <20240812103254.26972-2-ansuelsmth@gmail.com>
In-Reply-To: <20240812103254.26972-2-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:13:44 +0200
Message-ID: <CAFLszTib_uLiGHRo2Gh5V4p8e3TMx=zWzHWQ5YdeW_yh2gWxoA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] led: turn LED ON on initial SW blink
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
> We currently init the LED OFF when SW blink is triggered when
> on_state_change() is called. This can be problematic for very short
> period as the ON/OFF blink might never trigger.
>
> Turn LED ON on initial SW blink to handle this corner case and better
> display a LED blink from the user.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/led/led_sw_blink.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

nit below

>
> diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
> index 9e36edbee47..853278670b9 100644
> --- a/drivers/led/led_sw_blink.c
> +++ b/drivers/led/led_sw_blink.c
> @@ -103,8 +103,11 @@ bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
>                 return false;
>
>         if (state == LEDST_BLINK) {
> +               struct led_ops *ops = led_get_ops(dev);
> +
> +               ops->set_state(dev, LEDST_ON);

Normally in drivers we define functions like led_set_state() in the
uclass, rather than calling things directly like this.

>                 /* start blinking on next led_sw_blink() call */
> -               sw_blink->state = LED_SW_BLINK_ST_OFF;
> +               sw_blink->state = LED_SW_BLINK_ST_ON;
>                 return true;
>         }
>
> --
> 2.45.2
>

Regards,
Simon
