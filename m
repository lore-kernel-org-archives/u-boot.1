Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E1FC36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 15:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D09681F7E;
	Tue,  1 Apr 2025 17:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i5yC8j4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B815181F7E; Tue,  1 Apr 2025 17:48:50 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A902681F69
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 17:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e5e1a38c1aso7710489a12.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743522527; x=1744127327; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZZoPYM4Sb5hhSAv7V4zA3DuJ2sftDL8xaidaGHHE4mc=;
 b=i5yC8j4lXqVPA7tVn2VHrmQH69uVg3oCAGpxeKo8+Ld6RRRcJWkD17i6jwtTwhrGZ6
 kiU2nQqK8e1mjo102oktGMOptOVdpPb0E4BJ/uP7UQzQ61X0XWjNuBHtrLF3vmdDDlbh
 BDUS4ssLzOFROlX8HrjH3x2aukxui1gvJ2b9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743522527; x=1744127327;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZZoPYM4Sb5hhSAv7V4zA3DuJ2sftDL8xaidaGHHE4mc=;
 b=BSK7BHBA6S3NHMe+qPi8OypcjR4MLi9m9QPAQAQwN5PdNiDo268OJOS5Wc6HZ3Xr9h
 Nugc8HtjqVVjetCrDA+0h1Bg5TAz0ceENitimCD9obG87RVspsQDTSH9MV2EaWC5Mgtw
 alzL4D+iELHNoASt+PsPdGWVyI794IWt5pKk+ujMnj+OXYynqElbPSAiGhn5RWv+zUSF
 anDq+nd+zlqWc2viZEJ17rJ5uwOtKsH50olzBY1VutPGoB2dGokSJA5AWMviYuBcUgZ5
 +Gw2oJ08T3qMbjB8s5V8DsmM3FMVISvHHFZDH9K8F8eOxTat8w5M+BqjF8QSOsBSqWhf
 Vgiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTddpc36PmnsSmf2+Vb9FZDMrOJtiQ8jrCywiCu7Z0LPt1OuwOs1GMyLwEgettoDc448TEBIM=@lists.denx.de
X-Gm-Message-State: AOJu0YzmEqqugcWkwzZ9wHvRHuS+vw/t0eXJiyjSnUZzuqjWoR9EHKLS
 /3kc6G7/RHf/0G5lHzHi0+J+tOOQb95WhtZt9YxBMlnglttR6DQJIU3tnGF2rvBS4n+uChNHbpR
 8Swd5da47e9Fx92QnDm/YRDknJYShK0NndG8X
X-Gm-Gg: ASbGncsEPEN72iWClceQ+QxOJdQK071NEWPO4UIzH7vblfs4pQzasM5U5Bz6WQVBcxx
 9TVhW9KhuK3i4xszZrzrc3c/xUdqyTQBZc4mURCU9CKVOjyO1AlqFETFK4yi34y9grWHJraZeJc
 zNDTl77Xj3GECIxUMHzvLLSsIxE7sy
X-Google-Smtp-Source: AGHT+IHEpu9YMSHaW2pZuAQCCatExmgODBFVKK7bA39YHoy6N7hpuvPv8/n9lLT+yIL6t6feL/PX/VxB0fuOKhXA4rg=
X-Received: by 2002:a17:907:fdc6:b0:ac7:7e3e:6d3c with SMTP id
 a640c23a62f3a-ac77e3e6e6amr430871566b.55.1743522527064; Tue, 01 Apr 2025
 08:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250319114947.2188805-1-sjg@chromium.org>
 <0bdf2e32-80f3-415f-a3b8-eecf5a4edd5f@cherry.de>
 <CAFLszThmVOd2G2zSHy8mNHEQ=FW7c+KNTD_XLxiQgbMKM=AxXw@mail.gmail.com>
 <ad07a506-c7a4-43ed-93c1-24626974a2eb@cherry.de>
 <CAFLszTic6gt4fT4pVVthd-3rRy6JZ_28QLXWOYPak=ZJqYH5QQ@mail.gmail.com>
 <ef183d5a-48d3-4068-be11-04edd55febf5@cherry.de>
 <CAFLszTjSeB9BkrV2fmtxof=jiS6NNJ-y6KD8JLzXXoGD=mp++Q@mail.gmail.com>
 <20250327234959.GS93000@bill-the-cat>
 <CAFLszTgqU_h+212y4GcXHrm+N7mUoZAaz+E2v3483wzTwNEWkA@mail.gmail.com>
 <20250330144526.GO93000@bill-the-cat>
In-Reply-To: <20250330144526.GO93000@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 04:48:35 +1300
X-Gm-Features: AQ5f1JqOF4CdTgFQA4cEI3EG0nJyG0WCrPFGojs9XCO6y9vPiKVwhe3cLA3Q6V4
Message-ID: <CAFLszTjNwtmBqiDUQZPChXYMQei2spTMobZvAu3cQeMfJwNkkw@mail.gmail.com>
Subject: Re: [PATCH] log: Add helpers for calling log_msg_ret() et al
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Mon, 31 Mar 2025 at 03:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Mar 28, 2025 at 04:44:53AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 27 Mar 2025 at 17:50, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Mar 26, 2025 at 10:46:57AM -0600, Simon Glass wrote:
> > > > Hi Quentin,
> > > >
> > > > On Tue, 25 Mar 2025 at 04:20, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On 3/20/25 4:26 AM, Simon Glass wrote:
> > > > > > Hi Quentin,
> > > > > >
> > > > > > On Wed, 19 Mar 2025 at 16:31, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > > > > >>
> > > > > >> Hi Simon
> > > > > >>
> > > > > >> On 3/19/25 4:03 PM, Simon Glass wrote:
> > > > > >>> Hi Quentin,
> > > > > >>>
> > > > > >>> On Wed, 19 Mar 2025 at 13:04, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > > > > >>>>
> > > > > >>>> Hi Simon,
> > > > > >>>>
> > > > > >>>> On 3/19/25 12:49 PM, Simon Glass wrote:
> > > > > >>>>> Logging of function return-values is used very frequently in U-Boot now.
> > > > > >>>>> Add a few helper macros to make it less verbose to use.
> > > > > >>>>>
> > > > > >>>>> It turns out that the log_ret() variants are not so useful, since it is
> > > > > >>>>> not obviously where the error is coming from. So only the log_msg_ret()
> > > > > >>>>> variants are worthy of these macros.
> > > > > >>>>>
> > > > > >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >>>>> ---
> > > > > >>>>>
> > > > > >>>>>     include/log.h | 26 ++++++++++++++++++++++++++
> > > > > >>>>>     1 file changed, 26 insertions(+)
> > > > > >>>>>
> > > > > >>>>> diff --git a/include/log.h b/include/log.h
> > > > > >>>>> index 4f6d6a2c2cf..bdda7af570c 100644
> > > > > >>>>> --- a/include/log.h
> > > > > >>>>> +++ b/include/log.h
> > > > > >>>>> @@ -380,6 +380,32 @@ void __assert_fail(const char *assertion, const char *file, unsigned int line,
> > > > > >>>>>     #define log_msg_retz(_msg, _ret) ((void)(_msg), _ret)
> > > > > >>>>>     #endif
> > > > > >>>>>
> > > > > >>>>> +/*
> > > > > >>>>> + * LOGR() - helper macro for calling a function and logging error returns
> > > > > >>>>> + *
> > > > > >>>>> + * Logs if the function returns a negative value
> > > > > >>>>> + *
> > > > > >>>>> + * Usage:   LOGR("abc", my_function(...));
> > > > > >>>>> + */
> > > > > >>>>> +#define LOGR(_msg, _expr)    do {            \
> > > > > >>>>> +     int _ret = _expr;                       \
> > > > > >>>>> +     if (_ret < 0)                           \
> > > > > >>>>> +             return log_msg_ret(_msg, _ret); \
> > > > > >>>>> +     } while (0)
> > > > > >>>>> +
> > > > > >>>>> +/*
> > > > > >>>>> + * LOGZ() - helper macro for calling a function and logging error returns
> > > > > >>>>> + *
> > > > > >>>>> + * Logs if the function returns a non-zero value
> > > > > >>>>> + *
> > > > > >>>>> + * Usage:   LOGZ("abc", my_function(...));
> > > > > >>>>> + */
> > > > > >>>>> +#define LOGZ(_msg, _expr)    do {            \
> > > > > >>>>> +     int _ret = _expr;                       \
> > > > > >>>>> +     if (_ret)                               \
> > > > > >>>>> +             return log_msg_retz(_msg, _ret);        \
> > > > > >>>>> +     } while (0)
> > > > > >>>>> +
> > > > > >>>>
> > > > > >>>> Mmmm not sure this forced return call is a good idea, this would forbid
> > > > > >>>> us from performing some unwinding for example.
> > > > > >>>
> > > > > >>> Yes, it is really only for simple cases. Without the return, there
> > > > > >>> isn't much value and you may as well not use this macro.
> > > > > >>>
> > > > > >>>>
> > > > > >>>> I don't really see how that is better than simply calling
> > > > > >>>>
> > > > > >>>> return log_msg_retz("abc", my_function());
> > > > > >>>
> > > > > >>> That's not the intention. It actually replaces:
> > > > > >>>
> > > > > >>> ret = my_function();
> > > > > >>> if (ret)
> > > > > >>>       return_log_msg_ret("abc", ret);
> > > > > >>>
> > > > > >>> I use this a lot in my code. You can't always just return, since there
> > > > > >>> may not be an error.
> > > > > >>>
> > > > > >>
> > > > > >> I see, I read too fast again. Only return if it's an error.
> > > > > >>
> > > > > >>>>
> > > > > >>>> ?
> > > > > >>>>
> > > > > >>>> If we were to keep this, I would recommend to rename the macro and fix
> > > > > >>>> the docstring because it does not only log if the function returns a
> > > > > >>>> non-zero value. It does actually return.
> > > > > >>>>
> > > > > >>>> So something like
> > > > > >>>>
> > > > > >>>> LOGZ_AND_RETURN(_msg, _expr)
> > > > > >>>>
> > > > > >>>> maybe?
> > > > > >>>
> > > > > >>> Sure, longer names are easier to learn, but then it is so long I doubt
> > > > > >>> anyone would use it.
> > > > > >>>
> > > > > >>> Perhaps LOG_RET() and LOG_RETZ() ? But they might get confused with
> > > > > >>> log_ret() and log_retz(), which I am actually thinking of deleting.
> > > > > >>>
> > > > > >>> I would like the shortest possible name to avoid spilling functions
> > > > > >>> onto the next line all the time.
> > > > > >>>
> > > > > >>
> > > > > >> It should be absolutely obvious from the macro name that this can in
> > > > > >> fact return because missing to unwind code is among the things
> > > > > >> developers typically easily miss already, so with this macro it'll be
> > > > > >> even easier to forget about undoing things.
> > > > > >>
> > > > > >
> > > > > > Yes that's true. We don't have a huge amount of tests for this 'undo'
> > > > > > code either. I would bet that a code-coverage map would show that.
> > > > > >
> > > > >
> > > > > Yeah but that's not a reason to make it even harder to spot issues in
> > > > > the undo code :)
> > > >
> > > > I suspect people will just have to learn the macros, as they have with
> > >
> > > I would ask "What kernel construct have people already learned and we
> > > can adapt inside the macro?".
> >
> > Is there such a thing?
>
> Likely so. This isn't some new and novel problem, and it's likely more
> people have put thought in to this and come up with something well
> reviewed there.

What are you referring to here? I am not seeing anything in Linux
related to this.

Regards,
Simon
