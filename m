Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96C0D0C614
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 14:28:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C31688FED;
	Fri, 25 Oct 2024 16:27:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="Yp5WJhrQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83F9188BB2; Fri, 25 Oct 2024 16:27:58 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B6CA88FED
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 16:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso290724366b.1
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 07:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1729866471; x=1730471271;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lYjyIQWgeT4Q+wl0ueujBmlZZttW4s3Gg9hapnd5Ls0=;
 b=Yp5WJhrQK0srNw3AT+5YmLr0sgWZsrDGga2NBkFIlfCanJCIzoA4PtoZWmQBLOq+B6
 YK0URXctyJC8muV5ieGQIQxtbsk7bi6/G5MpuK9yzIP16y0BgWcdltCiRBgnxuCTwNLC
 yZ84cVXqYx8ByRyCYrz90k4nR8itkaOhazmdkN0amZHfMcUlLIHDAAap0rCajTqer/Ws
 h3XT5AIMltevLy4XwF6ELb9i8M98sVEEDqpzgMuxqZmw/VY1+BOmP1+Ib+xz33bkk5nu
 MeerO4X13Ipk2kxFfrz40H1n6cVwGNIg+zpDnqwEpbOzFqss3oEE6jpsG48r2sl0jQEm
 t14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729866471; x=1730471271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lYjyIQWgeT4Q+wl0ueujBmlZZttW4s3Gg9hapnd5Ls0=;
 b=MS2zGJHYfNgiu0HhEaI2tEz2sGUUDrmMWxRykDrWwkuCmT6P9ioghyRkKlz6zvgRUV
 k4da2Nlr5dmZTXolLpvzYGH92QsKBOLy9lFulw9zyTbtZALZx/now2S/uIkuHpxipHOx
 L9wDGpCoExH5pUYZ8qHxeogG0EJj6/SVnMIS2VtG/eogFwzIK21SP4x/tZxuoTkSNNQ6
 Lgwi5JdStJVxX/pWKCaSesZmH64nvy6t+m1fmWFRPjA3GvMtHvx0Pm3aPCxjkbQ8kQ1M
 nDLbMwTaxwDJMwxplxHdBBlYBQ+X/KXA787sz9nSO1qkIIxTMPte8OYyrqoZZAlsGtee
 YDkw==
X-Gm-Message-State: AOJu0YzEtOHebC/d2UDGhv/5anUJ2wBEkSRZccDrfQrHwasYkNrqTPq0
 7JVCDyVKrDhAOziq8I8MtNlrIJrm8DyAmTahaCGgBuv31hMPl0s6C9xsslfAseM+njuPXlmjvDE
 Pqd2syByf9uJXm7wsYlxYYNLNKlHgPtLXE52S/A==
X-Google-Smtp-Source: AGHT+IG+ICB0L/0MCw84m4D/oDYWc/NYIToJLzaXjsg3t/uXF/hJJYUYUqtJe85hd+dt4Hv4321LaDd5YGy+keX+bsk=
X-Received: by 2002:a17:907:2d94:b0:a9a:55dd:4d52 with SMTP id
 a640c23a62f3a-a9ad2860077mr462828066b.63.1729866471252; Fri, 25 Oct 2024
 07:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
 <20240918130155.299353-2-lukasz.czechowski@thaumatec.com>
 <22ae3879-e266-440c-8f25-2d46a5676261@rock-chips.com>
 <c72f7799-5748-4602-bfb2-c99ba767a614@cherry.de>
 <076ad029-7788-4f2f-b3fe-58e61fa8cf51@rock-chips.com>
In-Reply-To: <076ad029-7788-4f2f-b3fe-58e61fa8cf51@rock-chips.com>
From: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>
Date: Fri, 25 Oct 2024 16:27:40 +0200
Message-ID: <CABd623v=h5SZPcqvH=uoVHyA09RdxuP+mjNUaisOMj7dAm7uTw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 philipp.tomsich@vrull.eu, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi,

On 2024/10/25 14:30, Kever Yang wrote:
>
> Hi Tom,
>
>      This is regression of "#ifdef CONFIG", is it possible for us to go
> back to use "#ifdef CONFIG" in this case?
>
> Or do you have any other suggestion for this issue?
>
> On 2024/9/30 16:55, Quentin Schulz wrote:
> > Hi Kever,
> >
> > On 9/29/24 3:53 AM, Kever Yang wrote:
> >> Hi Lukasz,
> >>
> >>      I think this will make the error happen like this:
> >>
> >> +common/console.c: In function 'puts':
> >> +common/console.c:746:29: error: unused variable 'ch'
> >> [-Werror=unused- variable]
> >> +  746 |                         int ch = *s++;
> >> +      |                             ^~
> >> +cc1: all warnings being treated as errors
> >> +make[2]: *** [scripts/Makefile.build:257: common/console.o] Error 1
> >>
> >>
> >> The main reason is that below patch removes "#ifdef":
> >>
> >> c04f856822a console: remove #ifdef CONFIG when it is possible
> >>
> >
> > Can you please always share the link to the pipelines that fail so
> > people have an idea on how to reproduce it locally?
> >
> > Here I assume it is:
> > https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/22455
> >
> > A simple way is to apply the patches, build the pine64-lts for example
> > and then you'll see warnings (which aren't failing builds locally I
> > believe but in CI, yes).
> >
> > I think we can fool the compiler with the following:
> >
> > diff --git a/include/debug_uart.h b/include/debug_uart.h
> > index dc0f1aa4c98..b19e44d6d0f 100644
> > --- a/include/debug_uart.h
> > +++ b/include/debug_uart.h
> > @@ -204,12 +204,12 @@ void printdec(unsigned int value);
> >  #define DEBUG_UART_FUNCS \
> >      #warning "DEBUG_UART not defined!"
> >
> > -#define printch(ch) do{}while(0);
> > -#define printascii(str) do{}while(0);
> > -#define printhex2(value) do{}while(0);
> > -#define printhex4(value) do{}while(0);
> > -#define printhex8(value) do{}while(0);
> > -#define printdec(value) do{}while(0);
> > +#define printch(ch) do{ (void)(ch); }while(0);
> > +#define printascii(str) do{ (void)(str); }while(0);
> > +#define printhex2(value) do{ (void)(value); }while(0);
> > +#define printhex4(value) do{ (void)(value); }while(0);
> > +#define printhex8(value) do{ (void)(value); }while(0);
> > +#define printdec(value) do{ (void)(value); }while(0);
> >
> >  #endif
> >
> > Does this make sense?
>
> Hi Quentin,
>
>      Thanks for your information about pipeline and suggestion for code
> change, but this workaround does not looks good :(
>

Thanks for the suggestions. I think this code can be even simplified
to just i.e.:

@@ -204,12 +204,12 @@ void printdec(unsigned int value);
 #define DEBUG_UART_FUNCS \
        #warning "DEBUG_UART not defined!"

-#define printch(ch) do{}while(0);
-#define printascii(str) do{}while(0);
-#define printhex2(value) do{}while(0);
-#define printhex4(value) do{}while(0);
-#define printhex8(value) do{}while(0);
-#define printdec(value) do{}while(0);
+#define printch(ch) (void)ch;
+#define printascii(str) (void)str;
+#define printhex2(value) (void)value;
+#define printhex4(value) (void)value;
+#define printhex8(value) (void)value;
+#define printdec(value) (void)value;

 #endif

That will allow us to get rid of warnings. What do you think? I can't
think of another method besides creating a lot of #ifdefs in every
place debug functions are used, which will look even worse than the
dummy macros.


>
> Thanks,
>
> - Kever
>
> >
> > Cheers,
> > Quentin

Best regards,
Lukasz
