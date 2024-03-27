Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0A0C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 06:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97A0E87D31;
	Wed, 27 Mar 2024 07:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HmrVHwSg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A1D08803B; Wed, 27 Mar 2024 07:54:42 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B18D8811C
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 07:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian.gmeiner@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-29f749b6667so4621429a91.0
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 23:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711522477; x=1712127277; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RjH8P+yD1zSsIWawoIX8BkH7t01uLsI4cB6bBdOKDBA=;
 b=HmrVHwSgFdHL7qkPaR8ZZArcB9IiiiuKmVrfNOp9KgnKspiJCJfIIVREv0yYLg05ds
 2rfjjZxEvJ39ZLf5d3ZVjWeRxK9lSvduFJLzI+dwL7QygFnEl7XnoJ32ywOck+Js1qgQ
 OLm6ovA76CKjB2y9fc26/27o3WfLjt/wVD/2f4+o4hH+r+N9QY5zPoV8nqUZqdUMqQfM
 0hyU1ERfArp9CmMldPSYDrb85JDQsusD1tRVLtbINvHuEicbGAr185xF7QmzjUnAO+i4
 X3fjz+/xLNN5co9OW0Yx7xj7kXv+dKJYBhfKvG0LOyYoaPgzfgYJl6d4BBOnVRNlwiwW
 IW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711522477; x=1712127277;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RjH8P+yD1zSsIWawoIX8BkH7t01uLsI4cB6bBdOKDBA=;
 b=R0UV1p2uoPqMYMFLYD9K4m/eehdUqB0IHICW2m03SoBsV4ylMeJ/fyYhWXt0/YrAiW
 R3b+wsKUy5c8V/6tmKa74vXzu+O+cu4W+dyMxneVBXqKR9estM1cQLHPpPy+n2C5UtSZ
 lnJfMdsOH3Ke8yDcKfxlObeuKUKEhjPKP5FZRBVotTLFz1WUVxecNoldK/bWE+BhtOVL
 yLpyNqd60DChHYhL1AqhOIyOHPnJt+IVRHh5HQd4WKKc5gOSP7tyN0/91Jm4jN2sPo9L
 f6ZRVfkxaytVbVkK4FIT5ndPV9QLKNNM1yQ4s5gGoIUJUZgfqomfavFZ/Z59GHhZZsAn
 ujtg==
X-Gm-Message-State: AOJu0Yy1i8W72rPGE3zhFcUhEfsq6fjqRsbZBKrcoD3q3KhFTpMCS7bk
 ZKwqfqV9jA0bT752KL/Kr1DcFl4gJvpsejxvDqrTjRYKXftiuC8Rdboltg7bHZ2UHzIy8XrxR1v
 WHsmxc7afbuJojNgB0n5pCRXWoFc=
X-Google-Smtp-Source: AGHT+IGDjGcVaVVdV6IeiDyoh8rOSwbrMRvDlx8RaHQZVvvFgRbb4YkITvxu69FYR+BCSKiz2ij/6TcS8RXjwJJWFqU=
X-Received: by 2002:a17:90a:12c7:b0:29b:95a:baaa with SMTP id
 b7-20020a17090a12c700b0029b095abaaamr269627pjg.47.1711522477470; Tue, 26 Mar
 2024 23:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAH9NwWe1qEo5r0UmdRh9CqFxmJYfHRU1YxoW8b8vTQwDB-227A@mail.gmail.com>
 <CAOMZO5BUibOAqqdtJtjrGwgciJ984ayUu0nPVdLkR_YLOh9bHQ@mail.gmail.com>
 <CAH9NwWdfcOM-q-EBVeZBs7-PRkr87M+pn-dYTzMW5bW7KRTo8g@mail.gmail.com>
 <CAOMZO5C4L2ka3-0xnycwVOfmu2CGqg5b-h1zKERHsah4Mvg9rw@mail.gmail.com>
In-Reply-To: <CAOMZO5C4L2ka3-0xnycwVOfmu2CGqg5b-h1zKERHsah4Mvg9rw@mail.gmail.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Wed, 27 Mar 2024 07:54:25 +0100
Message-ID: <CAH9NwWcQaZ8biFYs6Utu5K10C-N3BVBmWfkL-9QAmBJusBdndw@mail.gmail.com>
Subject: Re: mx6cuboxi: failes to detect model
To: Fabio Estevam <festevam@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, jonas@kwiboo.se,
 josua@solid-run.com, 
 Simon Glass <sjg@chromium.org>, Baruch Siach <baruch@tkos.co.il>
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

Hi Fabio

>
> > It got better but the model is (still) wrong:
> >
> > U-Boot 2024.04-rc5-dirty (Mar 26 2024 - 17:03:41 +0100)
> >
> > CPU:   Freescale i.MX6Q rev1.3 996 MHz (running at 792 MHz)
> > CPU:   Extended Commercial temperature grade (-20C to 105C) at 20C
> > Reset cause: POR
> > Model: SolidRun HummingBoard2 Dual/Quad (1.5som+emmc)
> > Board: MX6 HummingBoard2
> > DRAM:  2 GiB
> > Core:  82 devices, 17 uclasses, devicetree: fit
> > MMC:   FSL_SDHC: 1, FSL_SDHC: 2
> > Loading Environment from MMC... *** Warning - bad CRC, using default environment
>
> It seems to me that there is a mix of DM GPIO and non-DM GPIO.
>
> Does the change below help?
>
> --- a/board/solidrun/mx6cuboxi/mx6cuboxi.c
> +++ b/board/solidrun/mx6cuboxi/mx6cuboxi.c
> @@ -336,20 +336,16 @@ static enum board_type board_type(void)
>          * HB             1     1    x
>          */
>
> -       gpio_direction_input(IMX_GPIO_NR(2, 8));
> -       val3 = gpio_get_value(IMX_GPIO_NR(2, 8));
> +       val3 = !!dm_gpio_get_value(&(board_detect_desc[0]));
>
>         if (val3 == 0)
>                 return HUMMINGBOARD2;
>
> -       gpio_direction_input(IMX_GPIO_NR(3, 4));
> -       val2 = gpio_get_value(IMX_GPIO_NR(3, 4));
> +       val2 = !!dm_gpio_get_value(&(board_detect_desc[1]));
>
>         if (val2 == 0)
>                 return HUMMINGBOARD;
> -
> -       gpio_direction_input(IMX_GPIO_NR(4, 9));
> -       val1 = gpio_get_value(IMX_GPIO_NR(4, 9));
> +       val1 = !!dm_gpio_get_value(&(board_detect_desc[2]));
>
>         if (val1 == 0) {
>                 return CUBOXI;


It does help \o/

When you send out a proper patch feel free to add Tested-by: Christian
Gmeiner <cgmeiner@igalia.com>

Time to look into the next broken thing on the device: network :)
-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
