Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6693EC83F27
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1E9A88C12;
	Thu, 29 Aug 2024 16:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XFyxGRis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CF0F88B94; Thu, 29 Aug 2024 16:05:15 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB19A88C12
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5d5c7f24372so402070eaf.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724940311; x=1725545111; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2V9c7jDvnRBur3ncojjpCgtbT6Egs8LJ4AZR9x6ldvo=;
 b=XFyxGRisFo2ojPFQUc9xSeoduzEWbM3zjgIXYUyVh2ew6ltCdnFOby95BgQTzDJCz3
 cXwWuelsXEssPkiWU9SmXPWqH0pwxWpysEpj1dsreVDr+e9/g+AJxw5Np7l2Cayw4pYm
 /PvZZG4bGpxOjTygcc3cjF3miDgckuKWHjlaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724940311; x=1725545111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2V9c7jDvnRBur3ncojjpCgtbT6Egs8LJ4AZR9x6ldvo=;
 b=ML1qi38sjYAg+47UW8Ew5/i1i5ZFzgj/rHMDFDM4GJxz+Ez6h2sOPxzTq6Nnl7/ffK
 p9mW+h43CdZgp8xZNruOtYsdk2D9ljrCQWgZhTjmT7yVMV8qMNvAn8CzhShUTTI5DSSK
 DNH7Gmo0zHycJoU4LdOOx2RqH4pKnpW3TPa3kSwZ+e9QEOO3n5g4Jr+HzFn4BAN7H83d
 LiJRvMElsRQqlT1AeT8HBODOaitLNbeXHHk/2HXisSzQt7oVn3o6tnFT1NkXy2u/EC0K
 NFoDIoAnbkQ99j6Cp/tjlZNFb0EoHD/eAegqd5dR+ZtIPZy7eqcDLQq0njrzkt81wOJQ
 MtYw==
X-Gm-Message-State: AOJu0YxhN8GQ7fV/5U7bnfyT73+mINjn9u2e8e8Sucz+2YPH9GJRbgQP
 KLV1ESM+Gjp2QlR0Jm0a8H/OfZVYmAMnqT+5TfhN2KHknZ00oLniSu0DFPrQeuqXa9iu7IpcTgK
 9xxUgVmbvMR0Yt4ujMmY6jWz7C5O+rRMEI3IC
X-Google-Smtp-Source: AGHT+IGguGCXdr/SQbDVgFhYXm7u4Zg55hLaygKZ8N9Man42Gafx+5sczAAkIQeCF+EazIAuZX8AZgAX+58JsYaS0Gs=
X-Received: by 2002:a05:6358:5290:b0:1a4:e0d7:8418 with SMTP id
 e5c5f4694b2df-1b603cb59camr346752755d.23.1724940310731; Thu, 29 Aug 2024
 07:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240827142058.594556-1-lukasz.czechowski@thaumatec.com>
 <20240827142058.594556-2-lukasz.czechowski@thaumatec.com>
In-Reply-To: <20240827142058.594556-2-lukasz.czechowski@thaumatec.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 08:04:58 -0600
Message-ID: <CAFLszTg4WYFXQ6r4trpjjhNb0dHPhf1LuZQRM5T+hj0FNDHNsg@mail.gmail.com>
Subject: Re: [PATCH 1/4] debug_uart: Replace debug functions with dummies if
 CONFIG_DEBUG_UART is not set
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, philipp.tomsich@vrull.eu, 
 kever.yang@rock-chips.com, quentin.schulz@cherry.de
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

On Tue, 27 Aug 2024 at 08:21, Lukasz Czechowski
<lukasz.czechowski@thaumatec.com> wrote:
>
> In case DEBUG UART is not used, define dummy macros replacing
> the actual function implementations that will not be available.
> This allows to compile code and avoid linker errors.
> Because the DEBUG_UART_FUNCS macro should not be used if
> DEBUG UART is not available, redefine it to generate compilation
> warning.
>
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> ---
>  include/debug_uart.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/include/debug_uart.h b/include/debug_uart.h
> index 714b369e6fe..dc0f1aa4c98 100644
> --- a/include/debug_uart.h
> +++ b/include/debug_uart.h
> @@ -128,6 +128,8 @@ void printdec(unsigned int value);
>                         (1 << CONFIG_DEBUG_UART_SHIFT), \
>                 CONFIG_DEBUG_UART_SHIFT)
>
> +#ifdef CONFIG_DEBUG_UART
> +
>  /*
>   * Now define some functions - this should be inserted into the serial driver
>   */
> @@ -197,4 +199,18 @@ void printdec(unsigned int value);
>                 _DEBUG_UART_ANNOUNCE \
>         } \
>
> +#else
> +
> +#define DEBUG_UART_FUNCS \
> +       #warning "DEBUG_UART not defined!"
> +
> +#define printch(ch) do{}while(0);
> +#define printascii(str) do{}while(0);
> +#define printhex2(value) do{}while(0);
> +#define printhex4(value) do{}while(0);
> +#define printhex8(value) do{}while(0);
> +#define printdec(value) do{}while(0);
> +
> +#endif
> +
>  #endif
> --
> 2.43.0
>
