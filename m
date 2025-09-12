Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298B1CAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 23:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DEC8833F9;
	Sat, 13 Sep 2025 01:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UieYKJte";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84DFA8341A; Sat, 13 Sep 2025 01:41:25 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065E1833BF
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 01:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-62ecd3c21d3so3006637a12.0
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 16:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1757720482; x=1758325282; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=79zWTKys9C37Th56GSgm3O4Sw5T87FkU4DpxQQvwWsI=;
 b=UieYKJte8jiixCyVO0c+5oMaVrVwIRPITy+DJ9fasQDUP+P5DdAR7ZdeOCul2bpu0m
 peEgAgVGFQEzzdZ2MINUAvQ7Cp20zIZH6uNXoJ8aEfMAhDrLUxmOblBhT6xWv23c7WzH
 FxKDstrxALsXca8DunnAK0agB+AQan/xT/qqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757720482; x=1758325282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=79zWTKys9C37Th56GSgm3O4Sw5T87FkU4DpxQQvwWsI=;
 b=YzLh7jpFTqnDsVT/gt8COqd/cmsTDzsC8eABoH5OUrF03Rsi+Kkj8GBAH5nHXrvbsO
 vIkHMGQIXA0ujm/s4OtFyTbFb26vK2C8NsP9IVLYEmeruHtiLsSSnljYRNx4exJlvmMW
 MHE50S01go4FNA2EJbI8tg7yjtFCTeKocbPEKdzsBPrL2kM6gjYD29h3SNliuyJkXGva
 qT3R+I/5nhaNpRrUa/Tfxe43tIxrU+iU5+hmXa8EE4C5sbfSXKdXQ7EhbfmQu+yxOEHB
 qo43PzCcckxSNxb+MBYwSGIJZ7RqUPPWva9kdgOIwMXwWLUrJflMKz8uYfo1OvVtqfwR
 iAUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxZ3e2BhvFXMWIww+n+kvzDWnsfTwUcoW9NnfFFIm2pEFHWj3ZIdWLiDDaBBeLAT6ljJPQLR8=@lists.denx.de
X-Gm-Message-State: AOJu0YzjcrZn14TEWua69/E+KDFzb8YZfWRiYZh65Z0h26KnoYGPgtxX
 kwd0FCXF1SM6FrsNhC5tdoWvIO3OJsD5latOqnvefBWEPaX2XnzWZlr/Dp5yboStVODtfoRqZmC
 d+6TIOQrCAAJja38nlI3OewMJGmK0lXrEvJ8ME2ms
X-Gm-Gg: ASbGncvw3X65GOSmo5s1nOETDeg2jCkFO+PQRXyOdNSw6onxKqheYiwx4QuH6kMqp83
 w8fBudTUeP27gp32KwA2pKahFNnl3LOsm1nOozTfSlmJlq5zQw5gOzjl8TbVnGgGPkUKhTn0FKt
 Z3hzt9eMib1NZj7QkD4MprgnMdUUIXNEk22Q7Mh0lvNsZc1dB3UH9pEAIfZ+MCU22MBl/w8jRi3
 TM3kuM/A4CEim/G8CBu/qrzyps=
X-Google-Smtp-Source: AGHT+IHXO48+SKSHFsZpdO6xy0evtTY/Vr6qE+/XklBq73RrA1L6ndXzGZUAntriTBvuBugXajD8T5ON8xYJjvpoXEo=
X-Received: by 2002:a17:907:3f94:b0:b04:854b:bced with SMTP id
 a640c23a62f3a-b07c3574f95mr437716166b.20.1757720482439; Fri, 12 Sep 2025
 16:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
 <829fe59a-10e5-4cd2-a032-d293d87f68d1@gmx.de>
 <DCPE9A29ADNG.5XDSJ73VEPCS@postmarketos.org>
 <3875c210-7d29-4bca-b535-0522dc615cc8@canonical.com>
 <DCQ2ZF3T8VMM.1JN4QJ324NFM2@postmarketos.org>
In-Reply-To: <DCQ2ZF3T8VMM.1JN4QJ324NFM2@postmarketos.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Sep 2025 17:41:10 -0600
X-Gm-Features: AS18NWBBJnqHfeUlWOJUyD3_RrGLN53jEh2Tweeeqg5LsClAv1lON7yp3AOgqlY
Message-ID: <CAFLszTjxY6c0unXvdcjC36hhpB-BwxM_FcgpRdkXBa+V3GynvQ@mail.gmail.com>
Subject: Re: [PATCH RFC 4/9] serial: serial_meson: add minimal non-DM driver
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Beniamino Galvani <b.galvani@gmail.com>
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

Hi Ferass,

On Thu, 11 Sept 2025 at 09:37, Ferass El Hafidi
<funderscore@postmarketos.org> wrote:
>
> On Wed Sep 10, 2025 at 8:30 PM UTC, Heinrich Schuchardt wrote:
> > On 9/10/25 22:14, Ferass El Hafidi wrote:
> >> On Wed Sep 10, 2025 at 7:53 PM UTC, Heinrich Schuchardt wrote:
> >>> <...>
> >>>> +static int meson_serial_getc(void)
> >>>> +{
> >>>> +  struct meson_uart *const uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
> >>>> +  uint32_t status = readl(&uart->status);
> >>>> +
> >>>> +  if (status & AML_UART_RX_EMPTY)
> >>>> +          return -EAGAIN;
> >>>> +
> >>>> +  if (status & AML_UART_ERR) {
> >>>> +          u32 val = readl(&uart->control);
> >>>> +
> >>>> +          /* Clear error */
> >>>> +          val |= AML_UART_CLR_ERR;
> >>>> +          writel(val, &uart->control);
> >>>> +          val &= ~AML_UART_CLR_ERR;
> >>>> +          writel(val, &uart->control);
> >>>> +
> >>>> +          /* Remove spurious byte from fifo */
> >>>> +          readl(&uart->rfifo);
> >>>> +          return -EIO;
> >>>> +  }
> >>>> +
> >>>> +  return readl(&uart->rfifo) & 0xff;
> >>>> +}
> >>>> +
> >>>> +static int meson_serial_tstc(void)
> >>>> +{
> >>>> +  struct meson_uart *const uart = (struct meson_uart *)CONFIG_VAL(DEBUG_UART_BASE);
> >>>
> >>> CONFIG_SPL_DEBUG_UART_BASE only exists for CONFIG_DEBUG_UART=y and
> >>> CONFIG_SPL=y. Shall all configurations depend on CONFIG_DEBUG_UART=y?
> >>>
> >>> Creating this dependency does not look right to me.
> >>>
> >>
> >> All Amlogic defconfigs have CONFIG_DEBUG_UART enabled, but I can remove
> >> the dependency on CONFIG_DEBUG_UART_BASE if you think it doesn't look
> >> right.
> >
> > We should avoid the possibility of build failures for changed configuration.
> >
> > Will CONFIG_MESON_SERIAL depend on CONFIG_DEBUG_UART
> > or will CONFIG_ARCH_MESON select CONFIG_DEBUG_UART?
>
> Then it might be best to not use DEBUG_UART_BASE.  I'll fix that for
> next revision.  Thanks!

I've been thinking about doing something about a minimal UART (and
i2c) for a while.

Before driver model we just called serial_putc() and *the* serial
driver would handle it. Can we do something similar here?

My suggestion for an API:

CONFIG_SERIAL_ONE to indicate that driver model is not used for serial

Then in serial-uclass.c update serial_putc() to use that config and
call serial_one_putc(int ch), with that function being defined in the
only serial driver that is compiled in. Update serial_init() to call
serial_one_init().

That way we keep things compatible with driver model and avoid
building on the old serial.c

This is similar to how the debug UART, but the debug UART is special.

Regards,
Simon
