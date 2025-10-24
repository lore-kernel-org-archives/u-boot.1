Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C88CCD1A5
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 11:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D15A835FE;
	Fri, 24 Oct 2025 13:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yvs5nEQ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE35883621; Fri, 24 Oct 2025 13:59:11 +0200 (CEST)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CB1382E34
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 13:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-63b710f276fso1984627d50.1
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 04:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761307148; x=1761911948; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2+RJR17JH62QWSwq91s62ryZMq6BYhQJdx9ja90EpXM=;
 b=Yvs5nEQ0eOGhBZd9FCCa5nq+q4FcE8IApBDnxhaRnPKtkRwuTBZDA2ZqWuLsPoQzLW
 EagUKnwDwPNB4TS/9PltotV4FJieBH9JJWhzZfMjHlLhyHEedhSTsH7AJuJlVMbpR9lt
 9KtOBrzy7dQKQ/KTfRms4KOb+hPSFlZKTazV81MPTMAVNXIBv9AsvReSY7wmA5WLRNus
 7/PAszsjdcdVmGj2BmFr6593Z9UVEFyUa/7hQ4atfPx2Sj7xbzddgorGc2ZD37asy/xG
 +92nEkjh8pJEz/ahFLKCmQN28w/mJMub+ABnfdAQ90vRJByMRpe5q6bJcPg5y0qRMiox
 QOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761307148; x=1761911948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2+RJR17JH62QWSwq91s62ryZMq6BYhQJdx9ja90EpXM=;
 b=wEryGgcy4LE3afBKyukIFaWIeiOzROMYOQQS6V5d1AnAUNygLkO000G2ldq+aUTvKW
 LWd1qanWdVdLe1XrmCI0iy5yOK4W5grarrXze7HgMwGHR3YXOmROmEIoN0mwbeAHa1EV
 5zF0IWrBe5bpbUcA4Dfn9YBQCt0bjMbotytlFbPgJa7QQOcCuVqFFkusoFvquPoXq+ZB
 iyGcpcip30RQg9PNfTtpoy1kELJgHqf7cyj0AUg5AWL1VSPJOq6dYnmbkox/8cI8a5ge
 Ijq7MeUtRAZZyHEddcdE5HEQkRyke69ndLiZjrnMg8Lm3ehEGEHz4fnzJ4VrfDHjm9ca
 H1NQ==
X-Gm-Message-State: AOJu0Yzi4IaajsfZ09Ug58SKeeYZ8esuSgZSvwkQMHpa8Bu+Dc9KYi+/
 alaEMLgNaLMcEo+zNnoSUSc3OCtUDDvgJcUEnjb52CteV+gwy3pOW+e7Mq01yLO1TdVp6BoOh4U
 27q3DyuzbsnZUaAKnNuAsbrN9H6KV/UcdsDuzaWz3AA==
X-Gm-Gg: ASbGncsot6it2WZmj4tXb5SSS0kL9ZWMbzVyaexspWio8kO+XXSm7Pt5u172dahJ/Bn
 oZnrSowSxlfUZ8r37hU2Buy6/XP4DIC/iGkXuqbm2S/faGEJl06gE2MQZVFhsB+VqTLdo3lotbB
 usdZs203K7N9BwTtb2mvyeyzsF2zqkr8hNNwvyuGmSiEGgiCMLH1ND0fsZQsbFSPIYY5jFP8NPv
 dLC8C64vvzjUOL3W0cJ+pbObmHlqKchdutodo1K5LRPhQg7TVxrxWqxFs9NJLwqMKnE9DUBMm91
 QF0w3V6S3yO53cLh5dvaVxAFeaXYYME3nDIIaE2FimjsCLZteyC04RIjcoI1Xg==
X-Google-Smtp-Source: AGHT+IGAjqyqUZYH4OE3FNRfvaF3Mnf6juL+/ztFe0XCwlhVHs3UcjM3rhAB3UqeMClFxmb6u28L/dHeoz7CmyeClpA=
X-Received: by 2002:a05:690e:1c1c:b0:63e:3099:e27d with SMTP id
 956f58d0204a3-63e3099f5d9mr13509568d50.58.1761307148236; Fri, 24 Oct 2025
 04:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20251023-eficonfig-ux-improvements-v1-0-f5fc93b126ed@linaro.org>
 <20251023-eficonfig-ux-improvements-v1-1-f5fc93b126ed@linaro.org>
In-Reply-To: <20251023-eficonfig-ux-improvements-v1-1-f5fc93b126ed@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 24 Oct 2025 14:58:32 +0300
X-Gm-Features: AS18NWCfXhYmN3s-lN76KkSZ2Zr7McZKxCODDCRH9yzb4jHRS3wOp_YDjfDleFU
Message-ID: <CAC_iWjLQ0bvV2D+vtgwe+VF-0PbozWo7_+mOuBBAC+gU=O7aFg@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi_loader: efi_console: support editable input fields
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
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

On Thu, 23 Oct 2025 at 17:26, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> When editing eficonfig "optional data" (typically cmdline arguments)
> it's useful to be able to edit the string rather than having to re-type
> the entire thing. Implement support for editing buffers to make this a
> whole lot nicer. Specifically, add support for moving the cursor with
> the arrow keys and End key as well as deleting backwards with the delete
> key.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  cmd/eficonfig.c              |  2 ++
>  lib/efi_loader/efi_console.c | 52 ++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 45 insertions(+), 9 deletions(-)
>
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index 8ac0fb98e02e..d8d946c87ac8 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -973,8 +973,10 @@ static efi_status_t handle_user_input(u16 *buf, int buf_size,
>         tmp = calloc(1, buf_size * sizeof(u16));
>         if (!tmp)
>                 return EFI_OUT_OF_RESOURCES;
>
> +       /* Populate tmp so user can edit existing string */
> +       u16_strcpy(tmp, buf);
>         ret = efi_console_get_u16_string(cin, tmp, buf_size, NULL, 4, cursor_col);
>         if (ret == EFI_SUCCESS)
>                 u16_strcpy(buf, tmp);
>
> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> index 953f6831466e..7bfd18233feb 100644
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -1383,36 +1383,61 @@ efi_status_t efi_console_get_u16_string(struct efi_simple_text_input_protocol *c
>                                         efi_console_filter_func filter_func,
>                                         int row, int col)
>  {
>         efi_status_t ret;
> -       efi_uintn_t len = 0;
> +       efi_uintn_t len;
> +       efi_uintn_t cursor;
> +       efi_uintn_t i;
>         struct efi_input_key key;
>
>         printf(ANSI_CURSOR_POSITION
>                ANSI_CLEAR_LINE_TO_END
>                ANSI_CURSOR_SHOW, row, col);
>
>         efi_cin_empty_buffer();
>
> +       len = u16_strlen(buf);
> +       cursor = len;
>         for (;;) {
> +               printf(ANSI_CURSOR_POSITION "%ls"
> +                      ANSI_CLEAR_LINE_TO_END ANSI_CURSOR_POSITION,
> +                      row, col, buf, row, col + (int)cursor);
>                 do {
>                         ret = EFI_CALL(cin->read_key_stroke(cin, &key));
>                         mdelay(10);
>                 } while (ret == EFI_NOT_READY);
>
>                 if (key.unicode_char == u'\b') {
> -                       if (len > 0)
> -                               buf[--len] = u'\0';
> -
> -                       printf(ANSI_CURSOR_POSITION
> -                              "%ls"
> -                              ANSI_CLEAR_LINE_TO_END, row, col, buf);
> +                       if (cursor > 0) {
> +                               if (cursor == len) {
> +                                       buf[--cursor] = u'\0';
> +                               } else {
> +                                       for (i = cursor - 1; i < len; i++)
> +                                               buf[i] = buf[i + 1];
> +                                       cursor--;
> +                               }
> +                               len--;
> +                       }
> +                       continue;
> +               } else if (key.scan_code == 8) { /* delete */
> +                       for (i = cursor; i <= len; i++)
> +                               buf[i] = buf[i + 1];
> +                       len--;
>                         continue;
>                 } else if (key.unicode_char == u'\r') {
>                         buf[len] = u'\0';
>                         return EFI_SUCCESS;
>                 } else if (key.unicode_char == 0x3 || key.scan_code == 23) {
>                         return EFI_ABORTED;
> +               } else if (key.scan_code == 3) { /* Right arrow */
> +                       cursor += (cursor < len) ? 1 : 0;
> +                       continue;
> +               } else if (key.scan_code == 4) { /* Left arrow */
> +                       cursor -= (cursor > 0) ? 1 : 0;
> +                       continue;
> +               } else if (key.scan_code == 6) { /* End */
> +                       cursor = len;
> +                       continue;
>                 } else if (key.unicode_char < 0x20) {
>                         /* ignore control codes other than Ctrl+C, '\r' and '\b' */
>                         continue;
>                 } else if (key.scan_code != 0) {
> @@ -1427,9 +1452,18 @@ efi_status_t efi_console_get_u16_string(struct efi_simple_text_input_protocol *c
>
>                 if (len >= (count - 1))
>                         continue;
>
> -               buf[len] = key.unicode_char;
> +               /*
> +                * Insert the character into the middle of the buffer, shift the
> +                * characters after the cursor along. The check above ensures we
> +                * will never overflow the buffer.
> +                * If the cursor is at the end of the string then this will
> +                * do nothing.
> +                */
> +               for (i = len + 1; i > cursor; i--)
> +                       buf[i] = buf[i - 1];
> +               buf[cursor] = key.unicode_char;
> +               cursor++;
>                 len++;
> -               printf(ANSI_CURSOR_POSITION "%ls", row, col, buf);
>         }
>  }
>
> --
> 2.51.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
