Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4571CE7A89
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 07:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE24286B4E;
	Mon, 25 Sep 2023 09:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n9lBd9WL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2819E86B3A; Mon, 25 Sep 2023 09:17:38 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B3B086B7A
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 09:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-502a4f33440so9558337e87.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 00:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695626255; x=1696231055; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JKSN/H/aQPJ2wS/BL1lKLGaC+CBFpn3gDtxOluaHpkA=;
 b=n9lBd9WLZzcidiTL8AiHHUZlKZOGXHBLhWgD8ZYC7vmnBpVRFenC1oX6jQgq3jYhPC
 ta+8ReSrhRLzKsN4L5OyMW+X8SyC4rwowjjVWm3LBkdHO6cdsUtn1ckHfp9wvVjwsWvk
 qZQ9G4P9TAvpVl8nLyLV7f62ftF/iDNkPmhiovAX2YFZnY+NS+cUnUJrq1sxnubeaHwa
 2b6OB+6xGkKmT6EQyzh/x02lCvgNnh90X5uujwI6aGNK6FcZ7jqesVZScI0r1n3SQWls
 GfsIkD7Mv3Xhn7X7Qgay7iSyE9VvaVnh48wTM8QANMSEojIiI0zLtVAUXchLkn41Zk3p
 M+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695626255; x=1696231055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JKSN/H/aQPJ2wS/BL1lKLGaC+CBFpn3gDtxOluaHpkA=;
 b=J0YKs4YVQx9eLiz63rmN9thZmlKNYx+4nUN3VuciiEVbUVhumA8Hpo4FxuY4Xzd9dL
 DF5q9TRnUEicoKybtRXzmyFTxXQgZYJ/gGmkSyUFSw2wnXLvLlvL+5ZliOqcvMrH8NRC
 y+FKx12yxEUVWHbgK8ZsSgYi+0TKy0huW9QxZAHbRHD/SMz60q3d3YYPSj8G4Qy4/Lpd
 G2dnnLMVVUF0TTsRQnp29FBeoM0Blqa016ioZiS9Bnr7miE51gwsNREf8NCTmviI+E4J
 XzOQgAXpPmXTgr5BRSPrH1P3heU9fEZ0P6oKjWbJTauacHwI8DAb8CIaFV2Fb2jRfT9U
 rN0A==
X-Gm-Message-State: AOJu0Yw5FSAaDSxmRISMY2W+qUuHODe+3Uezvol4xKB4maVSMjuL1HEI
 zut+mdeT4tCvdMfx+yMRfxV86D26aNQmo8aqCDlcKA==
X-Google-Smtp-Source: AGHT+IHMN/Y7ArEOAhlcit6ugHzcXStmQ04w2nnToEg/aFJzrfH0E1lQC8nyp5zuvKj7qit5osBEdRm3XCeLV7luV7I=
X-Received: by 2002:a05:6512:32cf:b0:500:a6c1:36f7 with SMTP id
 f15-20020a05651232cf00b00500a6c136f7mr5006879lfg.3.1695626255310; Mon, 25 Sep
 2023 00:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230924212306.134568-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230924212306.134568-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 25 Sep 2023 10:16:59 +0300
Message-ID: <CAC_iWjLCnsFSoPzVqt+j1PDSDatyZsQdyQvZEkFj+rb0f_n+9A@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_selftest: BitBlt test
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Mon, 25 Sept 2023 at 00:23, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The BitBlt test leaves the serial console output in disarray.
>
> * Call ClearScreen() where needed.
> * Test CheckEvent() for EFI_SIMPLE_TEXT_INPUT_PROTOCOL.WaitForKey
>   via adding navigation keys
> * Correct timer comment
>
> For testing on the sandbox:
>
>     CONFIG_CMD_BOOTEFI_SELFTEST=y
>     CONFIG_CONSOLE_TRUETYPE=n
>     $ ./u-boot -T -l
>     => setenv efi_selftest block image transfer
>     => bootefi selftest
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_selftest/efi_selftest_bitblt.c | 83 +++++++++++++++++++-------
>  1 file changed, 63 insertions(+), 20 deletions(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_bitblt.c b/lib/efi_selftest/efi_selftest_bitblt.c
> index 1def843505..605078b722 100644
> --- a/lib/efi_selftest/efi_selftest_bitblt.c
> +++ b/lib/efi_selftest/efi_selftest_bitblt.c
> @@ -14,6 +14,12 @@
>  #define HEIGHT 120
>  #define DEPTH   60
>
> +struct pos {
> +       efi_uintn_t x;
> +       efi_uintn_t y;
> +       int redrawn;
> +};
> +
>  static const struct efi_gop_pixel BLACK =      {  0,   0,   0, 0};
>  static const struct efi_gop_pixel RED =                {  0,   0, 255, 0};
>  static const struct efi_gop_pixel ORANGE =     {  0, 128, 255, 0};
> @@ -27,7 +33,7 @@ static efi_guid_t efi_gop_guid = EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID;
>  static struct efi_gop *gop;
>  static struct efi_gop_pixel *bitmap;
>  static struct efi_event *event;
> -static efi_uintn_t xpos;
> +static struct pos pos;
>
>  static void ellipse(efi_uintn_t x, efi_uintn_t y,
>                     efi_uintn_t x0, efi_uintn_t y0,
> @@ -62,31 +68,33 @@ static void rectangle(efi_uintn_t x, efi_uintn_t y,
>   */
>  static void EFIAPI notify(struct efi_event *event, void *context)
>  {
> -       efi_uintn_t *pos = context;
> +       struct pos *pos = context;
>         efi_uintn_t dx, sx, width;
>
>         if (!pos)
>                 return;
>
>         /* Increment position */
> -       *pos += 5;
> -       if (*pos >= WIDTH + gop->mode->info->width)
> -               *pos = 0;
> +       pos->x += 5;
> +       if (pos->x >= WIDTH + gop->mode->info->width)
> +               pos->x = 0;
>
>         width = WIDTH;
> -       dx = *pos - WIDTH;
> +       dx = pos->x - WIDTH;
>         sx = 0;
> -       if (*pos >= gop->mode->info->width) {
> -               width = WIDTH +  gop->mode->info->width - *pos;
> -       } else if (*pos < WIDTH) {
> +       if (pos->x >= gop->mode->info->width) {
> +               width = WIDTH +  gop->mode->info->width - pos->x;
> +       } else if (pos->x < WIDTH) {
>                 dx = 0;
> -               sx = WIDTH - *pos;
> -               width = *pos;
> +               sx = WIDTH - pos->x;
> +               width = pos->x;
>         }
>
>         /* Copy image to video */
> -       gop->blt(gop, bitmap, EFI_BLT_BUFFER_TO_VIDEO, sx, 0, dx, DEPTH,
> +       gop->blt(gop, bitmap, EFI_BLT_BUFFER_TO_VIDEO, sx, 0, dx, pos->y,
>                  width, HEIGHT, WIDTH * sizeof(struct efi_gop_pixel));
> +
> +       pos->redrawn = 1;
>  }
>
>  /*
> @@ -107,7 +115,7 @@ static int setup(const efi_handle_t handle,
>
>         /* Create event */
>         ret = boottime->create_event(EVT_TIMER | EVT_NOTIFY_SIGNAL,
> -                                    TPL_CALLBACK, notify, (void *)&xpos,
> +                                    TPL_CALLBACK, notify, (void *)&pos,
>                                      &event);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error("could not create event\n");
> @@ -247,6 +255,9 @@ static int execute(void)
>                 return EFI_ST_FAILURE;
>         }
>
> +       con_out->set_attribute(con_out, EFI_WHITE | EFI_BACKGROUND_BLUE);
> +       con_out->clear_screen(con_out);
> +
>         /* Fill background */
>         ret = gop->blt(gop, bitmap, EFI_BLT_VIDEO_FILL, 0, 0, 0, 0,
>                        info->width, info->height, 0);
> @@ -281,21 +292,53 @@ static int execute(void)
>                 return EFI_ST_FAILURE;
>         }
>
> -       /* Set 250ms timer */
> -       xpos = WIDTH;
> +       /* Set 25ms timer */
> +       pos.x = WIDTH;
> +       pos.y = DEPTH;
>         ret = boottime->set_timer(event, EFI_TIMER_PERIODIC, 250000);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error("Could not set timer\n");
>                 return EFI_ST_FAILURE;
>         }
>
> -       con_out->set_cursor_position(con_out, 0, 0);
> -       con_out->set_attribute(con_out, EFI_WHITE | EFI_BACKGROUND_BLUE);
>         efi_st_printf("The submarine should have three yellow port holes.\n");
> -       efi_st_printf("Press any key to continue");
> -       efi_st_get_key();
> +       efi_st_printf("UP, DOWN to navigate, any other key to quit");
> +       for (;;) {
> +               struct efi_input_key input_key;
> +
> +               ret = boottime->check_event(con_in->wait_for_key);
> +               if (ret == EFI_NOT_READY)
> +                       continue;
> +               if (ret != EFI_SUCCESS) {
> +                       efi_st_error("CheckEvent failed %x\n",
> +                                    (unsigned int)ret);
> +                       return EFI_ST_FAILURE;
> +               }
> +               ret = con_in->read_key_stroke(con_in, &input_key);
> +               if (ret != EFI_SUCCESS) {
> +                       efi_st_error("Key not available %x\n",
> +                                    (unsigned int)ret);
> +                       return EFI_ST_FAILURE;
> +               }
> +               switch (input_key.scan_code) {
> +               case 0x01: /* UP */
> +                       if (pos.redrawn && pos.y >= 5) {
> +                               pos.y -= 5;
> +                               pos.redrawn = 0;
> +                       }
> +                       continue;
> +               case 0x02: /* DOWN */
> +                       if (pos.redrawn &&
> +                           pos.y + HEIGHT + 5 < gop->mode->info->height) {
> +                               pos.y += 5;
> +                               pos.redrawn = 0;
> +                       }
> +                       continue;
> +               }
> +               break;
> +       }
>         con_out->set_attribute(con_out, EFI_LIGHTGRAY);
> -       efi_st_printf("\n");
> +       con_out->clear_screen(con_out);
>
>         return EFI_ST_SUCCESS;
>  }
> --
> 2.40.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
