Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4510EC54749
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 02:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94110886AF;
	Wed, 28 Aug 2024 04:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c+JIH5o5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D816987FA7; Wed, 28 Aug 2024 04:17:03 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8C78886AF
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 04:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53343bf5eddso8152281e87.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 19:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724811420; x=1725416220; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M87sS2AEvYAJaZ8GfRUg7yNLJWChjXfM8iG/Zgdiju4=;
 b=c+JIH5o5RbrFacNKXEZxqSe48FRUGt6u7vwlG8Td2S0cl6USF+eiSXqJSsjZpQpf0T
 W8E0Ts6e2jyaKl9TVK3KfB6ZBPnHmOf5OcHPHgSNNDJIWhhbyQ19EsnzWLSgor3+8qRk
 UtcqBgIgQqxZRwed9sV5HXpQ0u7V9hP2p3vyjQpMwJrPBNUfoeHe4EgBG2o49Yz8DX2v
 yN3nIzhr/Rw21eRm6qgcJd59TReDnhn6ASOkoSIeeAnMJvj9U46tVnRTT2OgmJYgEv/j
 PsAKbsDtczByRHR3n646W+ty4eYYdNOrPpPcNBSqHljZuh5KDyWdKdEXtCLAwzZjj3d/
 yewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724811420; x=1725416220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M87sS2AEvYAJaZ8GfRUg7yNLJWChjXfM8iG/Zgdiju4=;
 b=H7uo7GBya/vDC6zH3Of7PoK5TCLEXHlXqs3bh2G6UgeiFlgBAiJrWQsBYoLYlCSfQd
 YKMnNCkZN6WmntyOG5RLJX8ahTMJejyf5x2UTc1nLVNna287YigbgIkkKhmU3yzFwJ0v
 U5Bz/9bwXFYibPCrLeBeg16Mb2oooACN6lBTEY7KDeABhL1W9BpujazYVuGUXbwR3CbD
 24CUJjThI71cL3XInQBsZYnl3Y+70+HCeRaiLWdiumH3fAnwxxjRYncPm3KN2J31PFfO
 BCNhhlQ9n6KUCM83pbQf+ErbCG5ws2JcfsOmj82dgFCLLMlrTqQXQG4Tv+/MJ7mwrOQC
 1MBw==
X-Gm-Message-State: AOJu0YyfC3Xix/ZkGNEjtGucDgpTeFEuIhcQD6MBfmOiKXKzVVOUr3Sq
 zuhtJYUfyROwXQc27dBVDe2IBr1ic6xfDVagjvIxZqzhW82o0ZUqNoHmaE0iSY8XJwuwFvZtMsl
 sxBGPgbdFyLq5CVSYFgWE7GhZ8fo=
X-Google-Smtp-Source: AGHT+IE/pq00wvPcUfSxF2q/rz9/gYpqCkj5WwjgaFGfZR2+jZOrVhJ3VE9fK6YT/zbickjb9O3iMkbZ6RtLakrKlXQ=
X-Received: by 2002:a05:6512:3b2c:b0:52c:c5c4:43d4 with SMTP id
 2adb3069b0e04-534750c2a51mr304030e87.53.1724811419575; Tue, 27 Aug 2024
 19:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <Mn.Zbvh.7W8POzTA8pZ.1cpeVN@seznam.cz>
In-Reply-To: <Mn.Zbvh.7W8POzTA8pZ.1cpeVN@seznam.cz>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 27 Aug 2024 23:16:48 -0300
Message-ID: <CAOMZO5BGStCUYDipoiNo3z_EEVW9W9cGDKLk-08m6Tur3rOKBQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: mxc_gpio: fix reading state of GPIO pins in
 output mode
To: Tomas Paukrt <tomaspaukrt@email.cz>
Cc: u-boot@lists.denx.de, trini@konsulko.com, Marek Vasut <marex@denx.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tim Harvey <tharvey@gateworks.com>, 
 Adam Ford <aford173@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Adding more folks on Cc to help review it.


On Tue, Aug 27, 2024 at 11:13=E2=80=AFPM Tomas Paukrt <tomaspaukrt@email.cz=
> wrote:
>
> The PSR register works correctly for GPIO pins in input mode,
> but always returns 0 for GPIO pins in output mode unless the SION
> bit is set. The DR register works correctly in both modes without
> the need to set the SION bit.
>
> Please note that the Linux gpio-mxc driver already uses
> the DR register for all GPIO pins in output mode:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D442b2494b17d1a4f0a14721580271eb23ebffd42
>
> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
> ---
>  drivers/gpio/mxc_gpio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/mxc_gpio.c b/drivers/gpio/mxc_gpio.c
> index cac6b32..5cd7681 100644
> --- a/drivers/gpio/mxc_gpio.c
> +++ b/drivers/gpio/mxc_gpio.c
> @@ -133,7 +133,7 @@ int gpio_get_value(unsigned gpio)
>
>         regs =3D (struct gpio_regs *)gpio_ports[port];
>
> -       val =3D (readl(&regs->gpio_psr) >> gpio) & 0x01;
> +       val =3D (readl(&regs->gpio_dr) >> gpio) & 0x01;
>
>         return val;
>  }
> @@ -210,7 +210,7 @@ static void mxc_gpio_bank_set_value(struct gpio_regs =
*regs, int offset,
>
>  static int mxc_gpio_bank_get_value(struct gpio_regs *regs, int offset)
>  {
> -       return (readl(&regs->gpio_psr) >> offset) & 0x01;
> +       return (readl(&regs->gpio_dr) >> offset) & 0x01;
>  }
>
>  /* set GPIO pin 'gpio' as an input */
> --
> 2.7.4
>
