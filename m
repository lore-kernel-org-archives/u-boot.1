Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5D1C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 10:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F341081FEE;
	Mon, 19 May 2025 12:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="atvgGtTM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 499D782AAF; Mon, 19 May 2025 12:32:27 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 312FF81E72
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 12:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-601f1914993so1008651a12.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1747650744; x=1748255544;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZQ5q91u9oXksk0d0LYxDVT+gIo1565nYnIQaeR5o/U=;
 b=atvgGtTM5f7RKttEcvaJ7RLVNTB0KMEzgubqARkqJDHXxDpMqM0bMvX4ijL+T2FsUA
 nTWjQiibzfI2awWul7SNSKgAi8ZV6yrqVzca/KgLJeBl+7iC5WYl/bvUXJstOOxEGLn6
 XPhtg2kZ5tsqYqJ4ml+irBeXKiK+G12y5V82Hfo3I/Nqtfb4kt6Y7qosipgc84g/eyR3
 ItQRFz9n/6ADrJ/dDlcxJ1bDw0nSZrJOdfjnm49teSKWWmr/lzUkiBr7KVnXTqc8GlY2
 HD5aH1ImyTx6vnnk8vvsCdbK9qxsgVtwnCQdxQdvxsW3/9vfP4ZRkf0JC/b6IInC1LeP
 /EJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747650744; x=1748255544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VZQ5q91u9oXksk0d0LYxDVT+gIo1565nYnIQaeR5o/U=;
 b=I4cNoPHmaOWLhUBkQx83ZmQamdNNEJka/53SPoJl036d9EnHIXeyszr8SD9s9F6b/e
 u9HFi6+00hORhQY2bM7mgJAmgc7krDn1ePBVWazDXDXSFGijnfqMYsCtwAdsjH+IwIBZ
 jKorP8N2fMB2o5Oi1yI1Vb/Bm3lxCpn7Xu7zYoPHEYEjnR7g25k/JgR03RgMOdzmWpmv
 tmClgLfCJzttu+fEzhWfc7wjKxDNEI2i8L9X62Qo3qUcTeyKRI6/wNatXl+kO0FoDU/O
 i5Kzp4zO6iFR8SuK1Ua089sdGqh+0pt1RNWsoKzIHHzIKRWWNAM9H4ISEpATvjyzn4gZ
 pQBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3UvZOubho7EYjx0gxU8fPbpO4dCZOqJF3p+ARJRmsOjQXkoq1Bg3eJU8P0t6izXN96bKiWc4=@lists.denx.de
X-Gm-Message-State: AOJu0YxSpq+vuog74mvZDoFDTWlTa76Ix16gYK8qF1kgv51MVgzJjnp/
 L7tp0ajrvfE6dlV8yHp+8sbV9Z2p7OanCCRVL3zRTtFfW3EH/Vs7MStm27VQ70apcrU+gYbV0gk
 k6XbGVgGn4cpkPwqtojohiMbBu5vt6Kt93unHEyUUYA==
X-Gm-Gg: ASbGncuqGJwew8CCMkcFDn3BDEyEgDPu/vZ3dPfm+ghEGiNIJY5FS5pty5V/rF9TLFW
 x+m+IHUfvlhHbFDE1sakNKHC4bBK/mBMqlf3wY0h0yJsV1T4zgaQ0m0lQgeBSBWE+FI7wCRx3V0
 4nlTdSerVGbY6m0kIY7zLCtEJ6Ka/7MLc=
X-Google-Smtp-Source: AGHT+IG+v4SGMoSA5vk4O7YMEdF43JPMz6nai3Da1K7qOCxL5t3B6JqRV/BC3Y1el4LmCp9AqktsWkxkHTQDZ4fgu6U=
X-Received: by 2002:a17:907:960a:b0:ad2:4bfa:9e1e with SMTP id
 a640c23a62f3a-ad536b81941mr940527266b.20.1747650744627; Mon, 19 May 2025
 03:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
 <20250515-silent_console-v4-2-dec6c8391f01@thaumatec.com>
 <64515b97-1e4f-4e58-86aa-1cd5dc3de9ec@cherry.de>
In-Reply-To: <64515b97-1e4f-4e58-86aa-1cd5dc3de9ec@cherry.de>
From: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>
Date: Mon, 19 May 2025 12:32:13 +0200
X-Gm-Features: AX0GCFssFqL9_yyNn90OfGwo2JLXSJSfX2z8b_beT6nm2M7XzHw5NqwA7D1pLrY
Message-ID: <CABd623t=qZLn35J7BdO9q-AyXHk49cPyf0uDOA7UQ0FL=oxM1g@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
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

Hi Quentin,

pt., 16 maj 2025 o 17:27 Quentin Schulz <quentin.schulz@cherry.de> napisa=
=C5=82(a):
>
> Hi Lukasz,
>
> On 5/15/25 5:55 PM, Lukasz Czechowski wrote:
> > In case DEBUG UART is not used, define dummy macros replacing
> > the actual function implementations that will not be available.
> > This allows to compile code and avoid linker errors.
> > Redefine the DEBUG_UART_FUNCS macro if DEBUG UART is not available,
> > to avoid compilation errors.
> >
> > Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> > ---
> >   include/debug_uart.h | 15 +++++++++++++++
> >   1 file changed, 15 insertions(+)
> >
> > diff --git a/include/debug_uart.h b/include/debug_uart.h
> > index 714b369e6fed..4526dca24ac6 100644
> > --- a/include/debug_uart.h
> > +++ b/include/debug_uart.h
> > @@ -128,6 +128,8 @@ void printdec(unsigned int value);
> >                       (1 << CONFIG_DEBUG_UART_SHIFT), \
> >               CONFIG_DEBUG_UART_SHIFT)
> >
> > +#ifdef CONFIG_DEBUG_UART
> > +
> >   /*
> >    * Now define some functions - this should be inserted into the seria=
l driver
> >    */
> > @@ -197,4 +199,17 @@ void printdec(unsigned int value);
> >               _DEBUG_UART_ANNOUNCE \
> >       } \
> >
> > +#else
> > +
> > +#define DEBUG_UART_FUNCS
> > +
> > +#define printch(ch) (void)(ch)
> > +#define printascii(str) (void)(str)
> > +#define printhex2(value) (void)(value)
> > +#define printhex4(value) (void)(value)
> > +#define printhex8(value) (void)(value)
> > +#define printdec(value) (void)(value)
> > +
>
> There are a few additional functions that aren't redefined here:
>
> _printch
> printhex1
> printhex
> debug_uart_init
>
> any particular reason for not having included them?

Looking at the original code, _printch, printhex1 and printhex functions
seem to be only used internally by other print functions, hence they are
static (there are also no forward declarations of them in linux_uart,h,
and I haven't seen any usage in the U-Boot code).

The debug_uart_init function calls are, in most cases, guarded by
CONFIG_DEBUG_UART, so it didn't trigger compilation errors for me.
Do you think it's worth redefining it for consistency?

>
> Cheers,
> Quentin

Best regards,
Lukasz
