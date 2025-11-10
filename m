Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3EACCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 11:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52775839A5;
	Mon, 10 Nov 2025 12:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bYDNyTaZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F6D2839D7; Mon, 10 Nov 2025 12:53:47 +0100 (CET)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0802583980
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-63fbbad0ac3so2680828d50.1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 03:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762775624; x=1763380424; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3NRuyD6RYh6i0NdR9upENUAOkmAbNLoLOmIB1QW8siQ=;
 b=bYDNyTaZ7TEWQzrslPa7kLdA74Bxh1+OfAaJF4ebqrscuXRGwwouD161h7PhGvXftM
 qZn1cnu0fc+ZU6tbPEyhv9+nqXoslMmfdr3M6OfkZdYahmMYnFUSthHWNXryG6lyEsSO
 UrX971JIE3EVVwN5oKF+rzu/rskolQeuCCHyGK5wS364skb1i3XdFhfmmbNS7ngC8lAh
 4sHnV/XH+ZVWSYafXhT9MKmptiNMlUcxwBLjxUnHkwx3KqxXLU2HAveP9J5IVUidpafC
 eXqGg3lJgv5KswG3TqGXFePz7yt1rvhC4tHTaZ2vqpyQZp4dlwPp8tTwgYSLaqA+CSO8
 /L/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762775624; x=1763380424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NRuyD6RYh6i0NdR9upENUAOkmAbNLoLOmIB1QW8siQ=;
 b=APFzWaoX2WEOk3lZE8qL5IWHlARgJqawC9H4V0L4DOXGKFTbx1FjAmd09RRZZbcL/+
 a6xl4PJ2gBFUJSWiQ8+kXW61gItE1HZcA6N7FxuTE0GYaB69OuKV2YEvtCwuaHhi5EkO
 C8x7nAiyM79N2ZsGBMS+11/G7P+TRwIgTGCoYkaQLj8Vbkx2aRLkY3GLtBYp457piiwl
 0YjVON06UDcyYv+m2Q8r8i6aJr0slm1MfQ/Ugw/vRRzYxyn8xDapHQr0YX5jOcZHHcqQ
 EO3pRkbi7kxJJh1K5BbLZc6CFaQMINP06hCyLceyvxKpO8jbTveM/E6F5ttZHheI11Fm
 1pfA==
X-Gm-Message-State: AOJu0Ywz/n+Xk8HIVa7MFls/+Fjn00ox9p4BAKnaGeS6sYJLQX9lDGjm
 LyeSB4LJYbD49FEDgftjitYmhbb78DD7RSznWzD0hE7hQZkZXPmm9p2H28lY8sEktqZ84Yc/BAz
 ipF+w9oyREw4ATNHrWbqckaIhsex31JhytTjSsrqh/qkCsSqSOFO/XQI=
X-Gm-Gg: ASbGncsdA7UQSiGSH9KrZJXYuBT/zUzFCc2QfkKu0PriHDEGOx9vxHjbdm/wtv9ST2s
 rgeQrlgdHwe6QEIkjlmLDxzLox+qKbTLmjRjZ2QqBIukFoJyCssZ2DmYE/3o1yPp3JOkFvT5VEY
 VuIwyOLqYU01/1UCA7uVJnesS4gDUXd/wnCAnDmm9i9Jt4FF/HJtUzyRk96aCV51jbR0YsoXNYq
 NoMkrp7ArqznxvxQnj6Fv5BrJbY3Z/Q3wPp1RfSBOJ1kSAe2XLDM5nAcOCeexgXD0RmPywlIjws
 KBCF17SalseBD8IQRtX/nVTNuhadr4dSEbqs63Mb
X-Google-Smtp-Source: AGHT+IG1n5dnH01o4xyDt5gEBKTerV2av32X+hEWGb7PqIULDht+SqMo1giNMBgwZIjXuRt0E9WNytr8OyXNfYxJTAM=
X-Received: by 2002:a05:690e:d46:b0:640:dda6:e956 with SMTP id
 956f58d0204a3-640dda6ed5emr5417938d50.40.1762775623784; Mon, 10 Nov 2025
 03:53:43 -0800 (PST)
MIME-Version: 1.0
References: <20251104205646.14454-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251104205646.14454-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Nov 2025 13:53:07 +0200
X-Gm-Features: AWmQ_blaVluiJnyrvl7GSGGqMmaoBLlHboBc2rREx0JUoEXjOs9cNiXwLmQc8tw
Message-ID: <CAC_iWj+EqMYuXHCLZ_i4y9UzD=cVosi__AjTHdZKx87cVHhkUw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_selftest: use Sphinx style comments in
 efi_console.c
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

On Tue, 4 Nov 2025 at 22:56, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Convert function comments in efi_selftest_console.c to match
> Sphinx style.
>
> Correct function name in print_uuid() comment.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  lib/efi_selftest/efi_selftest_console.c | 44 ++++++++++++-------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_console.c b/lib/efi_selftest/efi_selftest_console.c
> index fd2b3d09abc..0f8e9d28ef4 100644
> --- a/lib/efi_selftest/efi_selftest_console.c
> +++ b/lib/efi_selftest/efi_selftest_console.c
> @@ -12,12 +12,12 @@
>  struct efi_simple_text_output_protocol *con_out;
>  struct efi_simple_text_input_protocol *con_in;
>
> -/*
> - * Print a MAC address to an u16 string
> +/**
> + * mac() - print a MAC address to an u16 string
>   *
> - * @pointer: mac address
> - * @buf: pointer to buffer address
> - * on return position of terminating zero word
> + * @pointer:   mac address
> + * @buf:       pointer to buffer address,
> + *             on return position of terminating zero word
>   */
>  static void mac(void *pointer, u16 **buf)
>  {
> @@ -43,7 +43,7 @@ static void mac(void *pointer, u16 **buf)
>         *buf = pos;
>  }
>
> -/*
> +/**
>   * printx() - print hexadecimal number to an u16 string
>   *
>   * @p:         value to print
> @@ -71,7 +71,7 @@ static void printx(u64 p, int prec, u16 **buf)
>  }
>
>  /**
> - * print_guid() - print GUID to an u16 string
> + * print_uuid() - print GUID to an u16 string
>   *
>   * @p:         GUID to print
>   * @buf:       pointer to buffer address,
> @@ -92,12 +92,12 @@ static void print_uuid(u8 *p, u16 **buf)
>         }
>  }
>
> -/*
> - * Print an unsigned 32bit value as decimal number to an u16 string
> +/**
> + * uint2dec() - print an unsigned 32bit value as decimal number to an u16 string
>   *
>   * @value:     value to be printed
>   * @prec:      minimum number of digits to display
> - * @buf:       pointer to buffer address
> + * @buf:       pointer to buffer address,
>   *             on return position of terminating zero word
>   */
>  static void uint2dec(u32 value, int prec, u16 **buf)
> @@ -132,13 +132,13 @@ static void uint2dec(u32 value, int prec, u16 **buf)
>         *buf = pos;
>  }
>
> -/*
> - * Print a signed 32bit value as decimal number to an u16 string
> +/**
> + * int2dec() - print a signed 32bit value as decimal number to an u16 string
>   *
>   * @value:     value to be printed
>   * @prec:      minimum number of digits to display
> - * @buf:       pointer to buffer address
> - * on return position of terminating zero word
> + * @buf:       pointer to buffer address,
> + *             on return position of terminating zero word
>   */
>  static void int2dec(s32 value, int prec, u16 **buf)
>  {
> @@ -155,12 +155,12 @@ static void int2dec(s32 value, int prec, u16 **buf)
>         *buf = pos;
>  }
>
> -/*
> - * Print a colored formatted string to the EFI console
> +/**
> + * efi_st_printc() - print a colored message
>   *
> - * @color      color, see constants in efi_api.h, use -1 for no color
> - * @fmt                format string
> - * @...                optional arguments
> + * @color:     color, see constants in efi_api.h, use -1 for no color
> + * @fmt:       printf style format string
> + * @...:       arguments to be printed
>   */
>  void efi_st_printc(int color, const char *fmt, ...)
>  {
> @@ -271,10 +271,10 @@ void efi_st_printc(int color, const char *fmt, ...)
>                 con_out->set_attribute(con_out, EFI_LIGHTGRAY);
>  }
>
> -/*
> - * Reads an Unicode character from the input device.
> +/**
> + * efi_st_get_key() - read an Unicode character from the input device
>   *
> - * Return: Unicode character
> + * Return:     Unicode character
>   */
>  u16 efi_st_get_key(void)
>  {
> --
> 2.51.0
>
