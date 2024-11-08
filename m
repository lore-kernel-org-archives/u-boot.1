Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92132D64089
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 20:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A26BE89080;
	Fri,  8 Nov 2024 21:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="clbP03ly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FBBB8926F; Fri,  8 Nov 2024 21:38:53 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04CAE88EF5
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 21:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9ed7d8d4e0so378716966b.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 12:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1731098330; x=1731703130;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWn2uQKuPBTae6HYZhRY2gWasJbppb12xCMrBh7m6SM=;
 b=clbP03lybhUrwUjopB1+/cw+++Y+ts0ELPh7YKArQnd7dhY/pg+KN/HSo9SB4V/Mqf
 b3njzymWS3a+DIwcuwJB3dw0jA0Lo/n9yLNlIhq/VW3ubkkuNkhHmpCixE33mrlnzcrv
 qkJBFUBVVjnqCMBrv75tgm/E0lq2TF1psS69AIBjMhIbdC3crY8sOByF1gNFaoyetOoo
 dkVNmtMfmtCX0DkjnL7UPp+Yoi+3pCswJFwius9vwq/ru1dy5HH/v5Vu17r7FcOI1Jka
 in+zs0rwuuK4iSUa4rLEa1twJR1PnXp4WMstfHMAXczd/Lz+uuxfrlv46yQ/dxuXGvoz
 ywzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731098330; x=1731703130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RWn2uQKuPBTae6HYZhRY2gWasJbppb12xCMrBh7m6SM=;
 b=Aorvknw1fa0tvvCQ5MjiKLQ7ffgUK+LXKQP7aepHU446ZtkJ2WNtcyhPhxiHRWvE5Y
 /F344AQzpzr/qixHH7Bel/XwulOn3/Hey0DXCnsjr8dxZsmAG+beovFja188oWO0THDI
 LEye4niY4D1Q8wtymjC7sS2nGrgOX+DiTMOEA3Cxn2fVHUBtpv0r+WNL1vq5fuQK4ux1
 nJjhmtPIlJKoZef6NtZSldPoH7vJ0XZjIk8sYHxT64Zuc1P4+bMyAR10L9tKImBYtx/7
 jrqGvN1aKRady7/AjW1WedA3CDhwHH92L5A6HyOMlLVge9hf+dEWKUTKY+FRU54QlpJt
 z54Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDHgYCdnkCq1Y2cWo3M1CMiPNz17GL7sKW4iYhAMqC48gFQQ19je4pvSI67Q/edURuODidq80=@lists.denx.de
X-Gm-Message-State: AOJu0Yz16IKB7G9XF6vX7UoGhLBT6VFSESGe+0isIvP8MHgLWLNDBBe3
 kfDa+3IMThwqTQaaMsP56QYmKho17AlpIkGZAwG46BGZoGgpEIW4KUdj3tCFgy5z/Mm1hiF1weK
 tJHE4LlkZ4rYnKv8bj0e9BOO5iXI0QOVxFpSo5Q==
X-Google-Smtp-Source: AGHT+IH2Tk8pjYm84UzHag6hprdHBWW4s0fNLCiu8SnG3PhWPUiagcN/hF06NU5b4sy64YyQbkB0pFfAoUMfpYaGH/g=
X-Received: by 2002:a17:907:9816:b0:a99:5773:3612 with SMTP id
 a640c23a62f3a-a9eeff3a9b5mr370434566b.36.1731098330213; Fri, 08 Nov 2024
 12:38:50 -0800 (PST)
MIME-Version: 1.0
References: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
 <20240918130155.299353-2-lukasz.czechowski@thaumatec.com>
 <22ae3879-e266-440c-8f25-2d46a5676261@rock-chips.com>
 <c72f7799-5748-4602-bfb2-c99ba767a614@cherry.de>
 <076ad029-7788-4f2f-b3fe-58e61fa8cf51@rock-chips.com>
 <CABd623v=h5SZPcqvH=uoVHyA09RdxuP+mjNUaisOMj7dAm7uTw@mail.gmail.com>
 <aafa4ae3-bce7-41bc-a8db-5fe4171634d4@cherry.de>
 <eb9db3bb-069e-41c1-a6b5-8184e7fd7973@rock-chips.com>
 <049bb164-24c1-4840-9ba1-98127680fcf1@rock-chips.com>
In-Reply-To: <049bb164-24c1-4840-9ba1-98127680fcf1@rock-chips.com>
From: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>
Date: Fri, 8 Nov 2024 21:38:39 +0100
Message-ID: <CABd623vVxfkC0Msum=LL=kd9Bi3tG4EXWcvF+-N1y97J8NBozw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu
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

Hi Kever,

On 2024/10/31 10:33 Kever Yang <kever.yang@rock-chips.com> wrote:
>
> Hi Lukasz,
>
> On 2024/10/31 17:01, Kever Yang wrote:
> > Hi Lukasz, Quentin,
> >
> > On 2024/10/25 22:56, Quentin Schulz wrote:
> >> Hi Lukasz,
> >>
> >> On 10/25/24 4:27 PM, =C5=81ukasz Czechowski wrote:
> >>> Hi,
> >>>
> >>> On 2024/10/25 14:30, Kever Yang wrote:
> >>>>
> >>>> Hi Tom,
> >>>>
> >>>>       This is regression of "#ifdef CONFIG", is it possible for us
> >>>> to go
> >>>> back to use "#ifdef CONFIG" in this case?
> >>>>
> >>>> Or do you have any other suggestion for this issue?
> >>>>
> >>>> On 2024/9/30 16:55, Quentin Schulz wrote:
> >>>>> Hi Kever,
> >>>>>
> >>>>> On 9/29/24 3:53 AM, Kever Yang wrote:
> >>>>>> Hi Lukasz,
> >>>>>>
> >>>>>>       I think this will make the error happen like this:
> >>>>>>
> >>>>>> +common/console.c: In function 'puts':
> >>>>>> +common/console.c:746:29: error: unused variable 'ch'
> >>>>>> [-Werror=3Dunused- variable]
> >>>>>> +  746 |                         int ch =3D *s++;
> >>>>>> +      |                             ^~
> >>>>>> +cc1: all warnings being treated as errors
> >>>>>> +make[2]: *** [scripts/Makefile.build:257: common/console.o] Error=
 1
> >>>>>>
> >>>>>>
> >>>>>> The main reason is that below patch removes "#ifdef":
> >>>>>>
> >>>>>> c04f856822a console: remove #ifdef CONFIG when it is possible
> >>>>>>
> >>>>>
> >>>>> Can you please always share the link to the pipelines that fail so
> >>>>> people have an idea on how to reproduce it locally?
> >>>>>
> >>>>> Here I assume it is:
> >>>>> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipeline=
s/22455
> >>>>>
> >>>>>
> >>>>> A simple way is to apply the patches, build the pine64-lts for
> >>>>> example
> >>>>> and then you'll see warnings (which aren't failing builds locally I
> >>>>> believe but in CI, yes).
> >>>>>
> >>>>> I think we can fool the compiler with the following:
> >>>>>
> >>>>> diff --git a/include/debug_uart.h b/include/debug_uart.h
> >>>>> index dc0f1aa4c98..b19e44d6d0f 100644
> >>>>> --- a/include/debug_uart.h
> >>>>> +++ b/include/debug_uart.h
> >>>>> @@ -204,12 +204,12 @@ void printdec(unsigned int value);
> >>>>>   #define DEBUG_UART_FUNCS \
> >>>>>       #warning "DEBUG_UART not defined!"
> >>>>>
> >>>>> -#define printch(ch) do{}while(0);
> >>>>> -#define printascii(str) do{}while(0);
> >>>>> -#define printhex2(value) do{}while(0);
> >>>>> -#define printhex4(value) do{}while(0);
> >>>>> -#define printhex8(value) do{}while(0);
> >>>>> -#define printdec(value) do{}while(0);
> >>>>> +#define printch(ch) do{ (void)(ch); }while(0);
> >>>>> +#define printascii(str) do{ (void)(str); }while(0);
> >>>>> +#define printhex2(value) do{ (void)(value); }while(0);
> >>>>> +#define printhex4(value) do{ (void)(value); }while(0);
> >>>>> +#define printhex8(value) do{ (void)(value); }while(0);
> >>>>> +#define printdec(value) do{ (void)(value); }while(0);
> >>>>>
> >>>>>   #endif
> >>>>>
> >>>>> Does this make sense?
> >>>>
> >>>> Hi Quentin,
> >>>>
> >>>>       Thanks for your information about pipeline and suggestion for
> >>>> code
> >>>> change, but this workaround does not looks good :(
> >>>>
> >>>
> >>> Thanks for the suggestions. I think this code can be even simplified
> >>> to just i.e.:
> >>>
> >>> @@ -204,12 +204,12 @@ void printdec(unsigned int value);
> >>>   #define DEBUG_UART_FUNCS \
> >>>          #warning "DEBUG_UART not defined!"
> >>>
> >>> -#define printch(ch) do{}while(0);
> >>> -#define printascii(str) do{}while(0);
> >>> -#define printhex2(value) do{}while(0);
> >>> -#define printhex4(value) do{}while(0);
> >>> -#define printhex8(value) do{}while(0);
> >>> -#define printdec(value) do{}while(0);
> >>> +#define printch(ch) (void)ch;
> >>> +#define printascii(str) (void)str;
> >>> +#define printhex2(value) (void)value;
> >>> +#define printhex4(value) (void)value;
> >>> +#define printhex8(value) (void)value;
> >>> +#define printdec(value) (void)value;
> >>>
> >>>   #endif
> >>>
> >>> That will allow us to get rid of warnings. What do you think? I can't
> >>> think of another method besides creating a lot of #ifdefs in every
> >>> place debug functions are used, which will look even worse than the
> >>> dummy macros.
> >>>
> >>
> >> You need to surround value/str/ch with parentheses though.
> >>
> >> And we should remove the trailing semi-colon too as we cannot
> >> guarantee it won't be used in contexts in which the semi-colon is not
> >> allowed.
> >>
> >> But I guess that could work? I'm not too verse in C macros so maybe
> >> I'm missing some corner-cases.
> >>
> >> I think Kever is suggesting we revert the commit he linked earlier so
> >> that the functions used by the macros modified in this commit are
> >> always defined, just empty.
> >
> > At first, what I think first is:
> >
> > We go back to use #ifdef in the C code, and then we can apply this
> > patch directly with below change:
> >
> > +++ b/common/console.c
> > @@ -744,7 +744,8 @@ void puts(const char *s)
> >                 return;
> >         }
> >
> > -       if (IS_ENABLED(CONFIG_DEBUG_UART) && !(gd->flags &
> > GD_FLG_SERIAL_READY)) {
> > +#ifdef CONFIG_DEBUG_UART
> > +       if (!(gd->flags & GD_FLG_SERIAL_READY)) {
> >                 while (*s) {
> >                         int ch =3D *s++;
> >
> > @@ -752,6 +753,7 @@ void puts(const char *s)
> >                 }
> >                 return;
> >         }
> > +#endif
> >
> >
> > Since we need to change code in function puts, then below change looks
> > better, :
> >
> > +++ b/common/console.c
> > @@ -745,11 +745,7 @@ void puts(const char *s)
> >         }
> >
> >         if (IS_ENABLED(CONFIG_DEBUG_UART) && !(gd->flags &
> > GD_FLG_SERIAL_READY)) {
> > -               while (*s) {
> > -                       int ch =3D *s++;
> > -
> > -                       printch(ch);
> > -               }
> > +               printascii(s);
> >                 return;
> >         }
> >
> > But I don't know why use 'printch' at the beginning, maybe try to
> > convert "(ch =3D=3D '\n')" to '\r' which later move into  "_printch", s=
o
> > we can use printascii() now.
>
> I have send this change to mailing list[1], if it's accepted, then I
> will apply this patch set directly without change.
>
>
> Thanks,
>
> - Kever
>
> [1]
> https://patchwork.ozlabs.org/project/uboot/patch/20241108163612.1.Ib408a6=
723ba954c932968419678bd45b0767a470@changeid/
>

Thank you, that sounds perfect to me.

Best regards,
Lukasz

> >
> >
> > Thanks,
> >
> > - Kever
> >
> >> Is this something you could test? The downside to this is that we
> >> would have a lot of unnecessary dead-code with loops calling empty
> >> functions instead of just not calling functions at all.
> >>
> >> Cheers,
> >> Quentin
> >>
> >
