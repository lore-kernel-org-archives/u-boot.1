Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BA9C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 16:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8256681253;
	Wed, 26 Mar 2025 17:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jDENZLoV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E507781951; Wed, 26 Mar 2025 17:47:11 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D7E2810E8
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 17:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e5deb6482cso2276397a12.1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743007629; x=1743612429; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I8ejyMUM0nJW778xXOhLk+J6RftTQvixUs5li4drrSc=;
 b=jDENZLoVDB394xsx9nbZy3ul50ETgRlNxLKQsRjVQBbMTU0c14TC9DoNT+c86WQiZs
 bWPjdB7IJTaynRxwWzOU8oSknFzxFwts5/tQ+J4WzPnCyuZ5ft/FqE/Fd4Wdd2Zt0a9n
 AkPe3mPAtFnZ94hf6GSJt97pNvw/reQmEpokw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743007629; x=1743612429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I8ejyMUM0nJW778xXOhLk+J6RftTQvixUs5li4drrSc=;
 b=UxfKEbC7urzV89n2D0R/FggFF7qyuhkQAkZyJ7jRwLHQL5GXfTGHkoEKJP/wRiBZpJ
 npOs1ho1sowIhD3bA/tWo417WVHOuRLBUu2JUmz7CBHzYAK2F3ghGyDMc7YNcu/5DPJW
 1l4wixpAFRIOoJ8hU4IJlOw8eDCHVMK8ZynvAMZg0Va2uOxEIEA9foadm/w1s7GuCAWJ
 L84QOdDDb4btCmh0FpC4N4AGf5EMFmjSJbyvLpw926X0Bm8IUl1W/WGvIOaxgBiMGNkD
 MY95d4RwC3awGaA/sc0v0r5DX3jUGL+3VIQMk+BJp2ABuPG7s72X8Zrx6MWOQO4c5XLn
 iJHw==
X-Gm-Message-State: AOJu0Yyul4wwiGnrF2V4ww3t7r3R5BkvcK1lUnhmUm+xiJBRDn/PUzgU
 R7XGI5THUP6aBPMa76PPaL9v96xPW/kqhnMTjyUXIIz7H5cXvTK97aF44t04+VQFd6fyuDy+oXa
 DUmyyBLeVF6aEmoWyoCfuK3Bo6ss59rT6U/VhI17Y5BWf7U1Xtg==
X-Gm-Gg: ASbGncuqZ04OoaWGqdS6f6hBo3zNIywnLHvINz0GDRwO4yY2zgKlHBnKVxVbWEGO8/3
 L+mFEgsyjcAmr0Eb+ZF+6+Kz4Hv73brJ7G0FD12VaHxN2GaXaZowqSj+obTHPajhj5p8Hc0ViOM
 T84BSVGxhgKv3QAYv+1M7YtnITLRs=
X-Google-Smtp-Source: AGHT+IEUzgpNGgF6OS98EOdw2fAnC9XGV4DNAq+jIyK/M1j1+z4i17TZlkqRViuaQt9oltgNguuF+aHheMhiEqjcD9o=
X-Received: by 2002:a17:907:961f:b0:abf:6e87:5148 with SMTP id
 a640c23a62f3a-ac6e0d9f82dmr493295666b.23.1743007628758; Wed, 26 Mar 2025
 09:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250319114947.2188805-1-sjg@chromium.org>
 <0bdf2e32-80f3-415f-a3b8-eecf5a4edd5f@cherry.de>
 <CAFLszThmVOd2G2zSHy8mNHEQ=FW7c+KNTD_XLxiQgbMKM=AxXw@mail.gmail.com>
 <ad07a506-c7a4-43ed-93c1-24626974a2eb@cherry.de>
 <CAFLszTic6gt4fT4pVVthd-3rRy6JZ_28QLXWOYPak=ZJqYH5QQ@mail.gmail.com>
 <ef183d5a-48d3-4068-be11-04edd55febf5@cherry.de>
In-Reply-To: <ef183d5a-48d3-4068-be11-04edd55febf5@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 26 Mar 2025 10:46:57 -0600
X-Gm-Features: AQ5f1JqOrSAuEBe43fYYf31r27ZaCHN64_59yAR6JWP1HB6UNpSVlklBRW8xVZY
Message-ID: <CAFLszTjSeB9BkrV2fmtxof=jiS6NNJ-y6KD8JLzXXoGD=mp++Q@mail.gmail.com>
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

On Tue, 25 Mar 2025 at 04:20, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 3/20/25 4:26 AM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Wed, 19 Mar 2025 at 16:31, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Simon
> >>
> >> On 3/19/25 4:03 PM, Simon Glass wrote:
> >>> Hi Quentin,
> >>>
> >>> On Wed, 19 Mar 2025 at 13:04, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>>
> >>>> Hi Simon,
> >>>>
> >>>> On 3/19/25 12:49 PM, Simon Glass wrote:
> >>>>> Logging of function return-values is used very frequently in U-Boot now.
> >>>>> Add a few helper macros to make it less verbose to use.
> >>>>>
> >>>>> It turns out that the log_ret() variants are not so useful, since it is
> >>>>> not obviously where the error is coming from. So only the log_msg_ret()
> >>>>> variants are worthy of these macros.
> >>>>>
> >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>>> ---
> >>>>>
> >>>>>     include/log.h | 26 ++++++++++++++++++++++++++
> >>>>>     1 file changed, 26 insertions(+)
> >>>>>
> >>>>> diff --git a/include/log.h b/include/log.h
> >>>>> index 4f6d6a2c2cf..bdda7af570c 100644
> >>>>> --- a/include/log.h
> >>>>> +++ b/include/log.h
> >>>>> @@ -380,6 +380,32 @@ void __assert_fail(const char *assertion, const char *file, unsigned int line,
> >>>>>     #define log_msg_retz(_msg, _ret) ((void)(_msg), _ret)
> >>>>>     #endif
> >>>>>
> >>>>> +/*
> >>>>> + * LOGR() - helper macro for calling a function and logging error returns
> >>>>> + *
> >>>>> + * Logs if the function returns a negative value
> >>>>> + *
> >>>>> + * Usage:   LOGR("abc", my_function(...));
> >>>>> + */
> >>>>> +#define LOGR(_msg, _expr)    do {            \
> >>>>> +     int _ret = _expr;                       \
> >>>>> +     if (_ret < 0)                           \
> >>>>> +             return log_msg_ret(_msg, _ret); \
> >>>>> +     } while (0)
> >>>>> +
> >>>>> +/*
> >>>>> + * LOGZ() - helper macro for calling a function and logging error returns
> >>>>> + *
> >>>>> + * Logs if the function returns a non-zero value
> >>>>> + *
> >>>>> + * Usage:   LOGZ("abc", my_function(...));
> >>>>> + */
> >>>>> +#define LOGZ(_msg, _expr)    do {            \
> >>>>> +     int _ret = _expr;                       \
> >>>>> +     if (_ret)                               \
> >>>>> +             return log_msg_retz(_msg, _ret);        \
> >>>>> +     } while (0)
> >>>>> +
> >>>>
> >>>> Mmmm not sure this forced return call is a good idea, this would forbid
> >>>> us from performing some unwinding for example.
> >>>
> >>> Yes, it is really only for simple cases. Without the return, there
> >>> isn't much value and you may as well not use this macro.
> >>>
> >>>>
> >>>> I don't really see how that is better than simply calling
> >>>>
> >>>> return log_msg_retz("abc", my_function());
> >>>
> >>> That's not the intention. It actually replaces:
> >>>
> >>> ret = my_function();
> >>> if (ret)
> >>>       return_log_msg_ret("abc", ret);
> >>>
> >>> I use this a lot in my code. You can't always just return, since there
> >>> may not be an error.
> >>>
> >>
> >> I see, I read too fast again. Only return if it's an error.
> >>
> >>>>
> >>>> ?
> >>>>
> >>>> If we were to keep this, I would recommend to rename the macro and fix
> >>>> the docstring because it does not only log if the function returns a
> >>>> non-zero value. It does actually return.
> >>>>
> >>>> So something like
> >>>>
> >>>> LOGZ_AND_RETURN(_msg, _expr)
> >>>>
> >>>> maybe?
> >>>
> >>> Sure, longer names are easier to learn, but then it is so long I doubt
> >>> anyone would use it.
> >>>
> >>> Perhaps LOG_RET() and LOG_RETZ() ? But they might get confused with
> >>> log_ret() and log_retz(), which I am actually thinking of deleting.
> >>>
> >>> I would like the shortest possible name to avoid spilling functions
> >>> onto the next line all the time.
> >>>
> >>
> >> It should be absolutely obvious from the macro name that this can in
> >> fact return because missing to unwind code is among the things
> >> developers typically easily miss already, so with this macro it'll be
> >> even easier to forget about undoing things.
> >>
> >
> > Yes that's true. We don't have a huge amount of tests for this 'undo'
> > code either. I would bet that a code-coverage map would show that.
> >
>
> Yeah but that's not a reason to make it even harder to spot issues in
> the undo code :)

I suspect people will just have to learn the macros, as they have with

>
> > Subce the macro only returns if there is an error,that could be
> > important if we are trying to have a descriptive name. Perhaps the
> > logging bit is less important.
> >
> > How about ERR_RET() or RET_ON_ERR() ? The last one is getting long too.
> >
>
> RET_ON_ERR() would be better.
>
> It doesn't really convey that a log message will be output. I'm
> wondering if we should have a variadic macro?

It doesn't actually output a log message until there is an error and
CONFIG_LOG_ERROR_RETURN is enabled.

Also, now that I look at it again, my suggestion RET_ON_ERR() doesn't
indicate that it has anything to do with logging.

>
> RET_ON_ERR(expr) would return on error but say nothing
> RET_ON_ERR(expr, msg) would return on error but say msg on error too,
> maybe even RET_ON_ERR(expr, msg, vars) with vars to pass to variadic
> log/printf.

We could perhaps add the printf formatting later, but the
log_msg_ret() function is designed to provide a fairly low-overhead*
way to figure out the root cause of an error, after it has propagated
up a dozen levels.

Sample output:

  scene_txt_set_font() find: returning err=-2
             add_val() wvk: returning err=-129
           write_val() swB: returning err=-129
    sstate_write_str() swb: returning err=-129
        simple_start() spi: returning err=-129
Boot failed (err=-129: Unknown error)

* It isn't really low-overhead, since it still emits a log record. We
could perhaps change that so that it only outputs the string and the
error code. Then the cost would be perhaps 10-20 bytes per site, when
enabled.

>
> I assume we could extend that in the future if we need it. I would have
> the expr first and the msg second though, I'm more interested in what
> will run that the message that may be returned.

I initially had the message second, but it gets quite complicated
since it is a lot way from the log statement, sometimes at the end of
various bracket chains, etc.

>
> I'm personally not convinced the macro, function and variable names need
> to be really short, I would rather have them longer than confusing, but
> that's entering very subjective territory :)

The competitor to this macro is basically:

int ret;

ret = func(...);
if (ret)
   return log_msg_ret("abc", ret);

I have found that quite often I can avoid the 'int ret' with this
macro. But if the macro is too long, we end up breaking most lines
just for the macros. So the closer it is to the length of 'ret = ' the
better, IMO. Also people tend to learn macros quickly if they are
common in the code.

So really we should have LOG_RET_ON_ERR(msg, val), but I consider that
too long. I'm not seeing any great options at this point. In priority
order, I believe these are the most important things to be obvious:

- that it returns (RET)
- that it logs (LOG)
- that it only returns on error (ON_ERR)

So how about RET_LOG() ? it indicates that it returns and that it
logs. The 'on error' part you would just have to learn from the docs.
If not, then LOG_RET() would be OK, as both words will be read in one
glance.

Regards,
Simon
