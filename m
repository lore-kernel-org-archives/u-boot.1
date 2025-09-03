Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784F8CA100B
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 07:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F54833C6;
	Wed,  3 Sep 2025 09:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ycwvRtFp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 473D6832AD; Wed,  3 Sep 2025 09:02:59 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B0DC832AD
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 09:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-71d603acc23so51646237b3.1
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 00:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756882975; x=1757487775; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LPdI3YI0TA1wXwsXS0yxRI8E6fl7s0wPhu068XzOGzw=;
 b=ycwvRtFpcgderwxiNfIJTJOnF/U8vDC1yYlZuZMiPEogHsqeydD3M78dmAZFd3IDHi
 su4r1xL0fqkFBOGfMvEVlEEc/U8e8TV9Q8ksVwL4iftaDWo3gRDiJIGMKA+u0tK+7hx9
 ZtCj+i+A1MT43mmLBnY4ZTiCtCQuEmhgbMyR1qZj1GqrAhgCuvimZTc0Zyy+2eCOMecM
 h1rOzn3dRcYYXIWTa8Gq7CxlO641Nk4SIGg1pVL46NL0dgt3grMQCxONCcQAJFpJmh01
 xeAquZREQ8CnS6DCOn1fzxVFcyv334UlRsiLJLAGfD/ZgErcgYD5UjO9j5fRj51SJhhk
 YkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756882975; x=1757487775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LPdI3YI0TA1wXwsXS0yxRI8E6fl7s0wPhu068XzOGzw=;
 b=XzMWUW1DlFeZMzJCCNOC1Op8AMQQ0kEfP73uLZEhC5iWTwKJxzdhF8oN0E9GszQnsy
 biZBOZjILrEwqr5UGv3lt3P/EFv26dUQbsYwJxRGmTBtjSA9fvlfVWy8Nqjd1B9WzNrt
 lhqaojhymysHhMsMt7mPCXTUT0krKA70wB3GvPyaH2sUpRUQidXcyRI592zaYy7lU1el
 PVlRn2ESXzBaBGXYF8HMf3oiVM12oJxk0378zMon7IwaXDE+Vk8vaE3Za7qPc6lXwa6l
 6RNyXOO87cQCh1DiDEjrRUsTdeK82yRhWJuvPkJhzI7zzC0Ss/RcJTs1O3JRghRJt+CR
 sJSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyrgh3hSewP2Uf7M7TQLp2pgJ+7KN+9AxcVINpXYGDMuO1Avb4U4YJOIY8Jswgkm3zgM7iv3I=@lists.denx.de
X-Gm-Message-State: AOJu0YwHgFdYchEApZECtAIYMUDAUjKcL53Rk8AmolQWEfI6Wqg7WVIq
 wIjoM4iZuYlQE+QQNcr1ZoFl0d8kBt9eo3OgZP/ZClZEBcGxG1Vlit2dDEK0tBVFQbx33WYI7k6
 AqsdDIcRrNDt62wEtCN9E16QV+JtqqTn8NyF69143RXgXfCQ6aVmU
X-Gm-Gg: ASbGnctEME+FF3ALdWKZkqNqCKlVjZGiEZe5sq+vIWLK5gJYRDL79GsdiKkysZS1bHN
 tsJITDHKLSXGq1zr8aZ9chmsSvMgvUPF99Qw/zrgXLhxEInEF1fr4GZMvsJl8t2OC/XM0jonSfT
 b3GHbenili9zXXs+RUgZSwsONLA6W1vQxHR+SLKHtI5mePVVzgUHvgavpT6FjCbvK7ilh/tMvQk
 A1bQ3vcWQ/kl2/+D3BXg5jNGuZcSibySCunAhR6fVtFeF1ZILi9l5VWQ6mLKB0uehGHfED4f2FZ
 6nc4cYAtMHhIShGGuRe5UiIYjsgqadsxvjmSwKrB3qR1wOhHk5kJ/8nI4zSutA==
X-Google-Smtp-Source: AGHT+IH0i5Yos4wHWTWIJ/FLPls+CW0r7wrqWodXnrwsz5tI9FMRltCzFLqR8EB/nEIBep4luaJ7i5Btc6jDqtmZDJw=
X-Received: by 2002:a05:690c:380f:b0:723:aeee:e516 with SMTP id
 00721157ae682-723aeeee7ebmr51053857b3.18.1756882974834; Wed, 03 Sep 2025
 00:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250902060813.2481257-1-ilias.apalodimas@linaro.org>
 <uh5aatnz6vsinpsbturhhrolndxme7d2jdhnsyxqzeubyw34tw@2olttyn4kxah>
In-Reply-To: <uh5aatnz6vsinpsbturhhrolndxme7d2jdhnsyxqzeubyw34tw@2olttyn4kxah>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 3 Sep 2025 10:02:18 +0300
X-Gm-Features: Ac12FXza_7AL-XypdXvM3xU-lTTS6POd7Q7-3rB2GqEVkMAS98Lspj0NoVr3fqs
Message-ID: <CAC_iWjK3BSE9p8w5VU6FkrHDVjzLHfNwtWCzJA31ntpqpOeoXg@mail.gmail.com>
Subject: Re: [PATCH] arm64: Properly clear BSS
To: "brock.zheng" <yzheng@techyauld.com>
Cc: trini@konsulko.com, heinrich.schuchardt@canonical.com, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de
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

Hi Brock

On Tue, 2 Sept 2025 at 09:57, brock.zheng <yzheng@techyauld.com> wrote:
>
> i am glad to see my patch been reviewed.
>
> I can not access the international network easily.
> so any of you can fix / rewrite / change that patch.

No worries, I fixed up the comments.

>
> If I can see the fixup in the offical git repo, I will be very very glad.

Tom, I know this is late in the cycle, but this is an obvious bug fix.
Any chance we can pull it early in -master so people can test?

Thanks
/Ilias
>
>
> On 2025-09-02 09:08:12, Ilias Apalodimas wrote:
> > Date: Tue,  2 Sep 2025 09:08:12 +0300
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > To: trini@konsulko.com
> > Cc: heinrich.schuchardt@canonical.com,  Ilias Apalodimas
> >  <ilias.apalodimas@linaro.org>, brock_zheng <yzheng@techyauld.com>,  Simon
> >  Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
> >   u-boot@lists.denx.de
> > Subject: [PATCH] arm64: Properly clear BSS
> > X-Mailer: git-send-email 2.50.1
> >
> > Brock reports a breakage on an RK3568 SoC. His patch is
> > correct but he never followed up on the requested changes.
> >
> > We currently use ldr to calculate the address of __bss_start and
> > __bss_end. However the absolute addresses of the literal pool are never
> > relocated and we end up clearing the wrong memory section. Use
> > PC-relative addressing instead.
> >
> > Link: https://lore.kernel.org/u-boot/zfknlzcemnnaka5w2er5wjwefwoidrpndc4gjhx6d5xr6nlcjr@pasfayjiutii/
> >
> > Suggested-by: brock_zheng <yzheng@techyauld.com>
> > Reported-by: brock_zheng <yzheng@techyauld.com>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  arch/arm/lib/crt0_64.S | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
> > index f3f279f2c39c..3e7627aa389b 100644
> > --- a/arch/arm/lib/crt0_64.S
> > +++ b/arch/arm/lib/crt0_64.S
> > @@ -158,8 +158,10 @@ relocation_return:
> >  /*
> >   * Clear BSS section
> >   */
> > -     ldr     x0, =__bss_start                /* this is auto-relocated! */
> > -     ldr     x1, =__bss_end                  /* this is auto-relocated! */
> > +     adrp    x0, __bss_start
> > +     add     x0, x0, #:lo12:__bss_start
> > +     adrp    x1, __bss_end
> > +     add     x1, x1, #:lo12:__bss_end
> >  clear_loop:
> >       str     xzr, [x0], #8
> >       cmp     x0, x1
> > --
> > 2.50.1
> >
> >
> >
>
> --
> Brock Zheng <yzheng@techyauld.com>
>
>
