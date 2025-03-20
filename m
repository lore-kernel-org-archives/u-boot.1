Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A41CC35FFF
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 03:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8ECC809D4;
	Thu, 20 Mar 2025 04:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bby53f9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E003C80FF0; Thu, 20 Mar 2025 04:27:13 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 377478083E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 04:27:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac29af3382dso57799966b.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 20:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742441230; x=1743046030; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cjIazI9UdpDAZTUsDvpKLZK3DV71xz1pHSnMewgtS+Q=;
 b=Bby53f9iwJQrTmc7jE6AMGVk9gtpEVGY3MofMsK7zS9AzW7XoKGOi+Rc6f1GN43gbV
 FyUPHtb/wiFRHLz9UGqwlk0LkQk/pnv5sWApP4xyb22e4rNsheKfZA3WcqG1g8FpTmsP
 2HtOdJp5xAvKF7Rs0Ky4Il6t0roWUiq1yUqNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742441230; x=1743046030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cjIazI9UdpDAZTUsDvpKLZK3DV71xz1pHSnMewgtS+Q=;
 b=cIkAtUdrydtDc2qVhigJU6jtAfiljD20uNI/tXqPWQXMF+n0YVaqiTwrnHqrlPfPvC
 Rgx1BXiyO1GVjwWf4q4RXP3FmW+BdUJYy0awB5cMYWj+i8Fj+8NaOmy8nKl5tQSJKdFT
 Ha8hrkZYc7qaCKO10fsAs28Vw2y3ilkk9WvhjN0Es8Du2MoBAhYPcD6I8K6lCZIiBKVc
 +wT3OgXebESvQnzMsUzPNCh4WPkuPLQH4+ovuZbrXNggoC1O/x8K580Y8YmjNnhy3q0f
 dRTf2mKGRwTmlUpIbThVM6qoRTpGz8SdV8EpOtRnu22Tej/R7K7RNf4P0zeYW+wAgm5g
 6/5g==
X-Gm-Message-State: AOJu0Yz+bUGMNuB3YwxcYDSvscacJ53WmVrCD4ZfWtEJm6WKzzSjApeS
 QRH9niNkmGOR5wzIv/cLr61tNBYT/JAyrlgAmDkCJ9QcqHYwkQIuDZneWKhoTKo+ANFBqdlugjP
 Mjf4Pz1dYIIb0p2IlZ83DtqwbufEsBzWhLCui0qHppoPw9Ow=
X-Gm-Gg: ASbGncuJUsjbMJzKcVVSUchnF1zRGC2kE5U1BmartH28q9tr5ukhbCtNaZchy98nlER
 2zYFN4DIUr2HyRxumqSar3JRlZ+0KO+QmIcFeFoW2ocmRqwk3tsGhdTEQUl/sfWamGgDWiZ2NZO
 QXyoioQ/5m04N/BHCeC5F1EJSQtMg=
X-Google-Smtp-Source: AGHT+IFWmWa8YUO6PB5NU/Zog4H8MbTMOuYa8SRv1RQQmP/rTCeljvsvnyTKuj4PSP9vsM4oJBemWI9SHoxnCvdB4do=
X-Received: by 2002:a17:906:d54e:b0:ac3:bcaa:3320 with SMTP id
 a640c23a62f3a-ac3cdf8e393mr217989366b.11.1742441230498; Wed, 19 Mar 2025
 20:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250319114947.2188805-1-sjg@chromium.org>
 <0bdf2e32-80f3-415f-a3b8-eecf5a4edd5f@cherry.de>
 <CAFLszThmVOd2G2zSHy8mNHEQ=FW7c+KNTD_XLxiQgbMKM=AxXw@mail.gmail.com>
 <ad07a506-c7a4-43ed-93c1-24626974a2eb@cherry.de>
In-Reply-To: <ad07a506-c7a4-43ed-93c1-24626974a2eb@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Mar 2025 03:26:58 +0000
X-Gm-Features: AQ5f1JqWOeU9otjRIN20aEWgasIW3VU3k1g1X8PC8yVCHz8yjGxPA15kL14O4P4
Message-ID: <CAFLszTic6gt4fT4pVVthd-3rRy6JZ_28QLXWOYPak=ZJqYH5QQ@mail.gmail.com>
Subject: Re: [PATCH] log: Add helpers for calling log_msg_ret() et al
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Quentin,

On Wed, 19 Mar 2025 at 16:31, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon
>
> On 3/19/25 4:03 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Wed, 19 Mar 2025 at 13:04, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 3/19/25 12:49 PM, Simon Glass wrote:
> >>> Logging of function return-values is used very frequently in U-Boot now.
> >>> Add a few helper macros to make it less verbose to use.
> >>>
> >>> It turns out that the log_ret() variants are not so useful, since it is
> >>> not obviously where the error is coming from. So only the log_msg_ret()
> >>> variants are worthy of these macros.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>>    include/log.h | 26 ++++++++++++++++++++++++++
> >>>    1 file changed, 26 insertions(+)
> >>>
> >>> diff --git a/include/log.h b/include/log.h
> >>> index 4f6d6a2c2cf..bdda7af570c 100644
> >>> --- a/include/log.h
> >>> +++ b/include/log.h
> >>> @@ -380,6 +380,32 @@ void __assert_fail(const char *assertion, const char *file, unsigned int line,
> >>>    #define log_msg_retz(_msg, _ret) ((void)(_msg), _ret)
> >>>    #endif
> >>>
> >>> +/*
> >>> + * LOGR() - helper macro for calling a function and logging error returns
> >>> + *
> >>> + * Logs if the function returns a negative value
> >>> + *
> >>> + * Usage:   LOGR("abc", my_function(...));
> >>> + */
> >>> +#define LOGR(_msg, _expr)    do {            \
> >>> +     int _ret = _expr;                       \
> >>> +     if (_ret < 0)                           \
> >>> +             return log_msg_ret(_msg, _ret); \
> >>> +     } while (0)
> >>> +
> >>> +/*
> >>> + * LOGZ() - helper macro for calling a function and logging error returns
> >>> + *
> >>> + * Logs if the function returns a non-zero value
> >>> + *
> >>> + * Usage:   LOGZ("abc", my_function(...));
> >>> + */
> >>> +#define LOGZ(_msg, _expr)    do {            \
> >>> +     int _ret = _expr;                       \
> >>> +     if (_ret)                               \
> >>> +             return log_msg_retz(_msg, _ret);        \
> >>> +     } while (0)
> >>> +
> >>
> >> Mmmm not sure this forced return call is a good idea, this would forbid
> >> us from performing some unwinding for example.
> >
> > Yes, it is really only for simple cases. Without the return, there
> > isn't much value and you may as well not use this macro.
> >
> >>
> >> I don't really see how that is better than simply calling
> >>
> >> return log_msg_retz("abc", my_function());
> >
> > That's not the intention. It actually replaces:
> >
> > ret = my_function();
> > if (ret)
> >      return_log_msg_ret("abc", ret);
> >
> > I use this a lot in my code. You can't always just return, since there
> > may not be an error.
> >
>
> I see, I read too fast again. Only return if it's an error.
>
> >>
> >> ?
> >>
> >> If we were to keep this, I would recommend to rename the macro and fix
> >> the docstring because it does not only log if the function returns a
> >> non-zero value. It does actually return.
> >>
> >> So something like
> >>
> >> LOGZ_AND_RETURN(_msg, _expr)
> >>
> >> maybe?
> >
> > Sure, longer names are easier to learn, but then it is so long I doubt
> > anyone would use it.
> >
> > Perhaps LOG_RET() and LOG_RETZ() ? But they might get confused with
> > log_ret() and log_retz(), which I am actually thinking of deleting.
> >
> > I would like the shortest possible name to avoid spilling functions
> > onto the next line all the time.
> >
>
> It should be absolutely obvious from the macro name that this can in
> fact return because missing to unwind code is among the things
> developers typically easily miss already, so with this macro it'll be
> even easier to forget about undoing things.
>

Yes that's true. We don't have a huge amount of tests for this 'undo'
code either. I would bet that a code-coverage map would show that.

Subce the macro only returns if there is an error,that could be
important if we are trying to have a descriptive name. Perhaps the
logging bit is less important.

How about ERR_RET() or RET_ON_ERR() ? The last one is getting long too.

> I'm not sure this downside outweighs the benefits to be honest, but I
> also don't write a lot of code these days so /me shrugs

I am thinking of the code here:

https://elixir.bootlin.com/u-boot/v2024.10/source/boot/bootflow_menu.c#L61

Regards,
Simon
