Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71680C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 17:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6CB582153;
	Thu,  3 Apr 2025 19:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J5sSgA3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C51E82724; Thu,  3 Apr 2025 19:58:07 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FFEE8216C
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 19:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac25520a289so201668766b.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 10:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743703085; x=1744307885; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Dkfl7GQFgzb+lxmmJsbmGgszIuU3+tn0pChTTjQBKE=;
 b=J5sSgA3/Qn0VgaZccyXxUUWs0TXYhyezjeokE5DgQRpLix+9VCtP8TPiCYe29y2pyU
 3Pt80gPQcz5TnLuVkuJH9p3o4qZpIOMUMDe/c23qeKiOuYAwy2sG5BYEFodaiVTlnURE
 PtY0MrWXXRw7RPD2G/ZtgVQC4sSJoJerP1ops=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743703085; x=1744307885;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Dkfl7GQFgzb+lxmmJsbmGgszIuU3+tn0pChTTjQBKE=;
 b=CS5f3HPh31YvetzQpyc8RjTVXiWzRiollypxt0v0mBtTCJSopRFMMM2TfrlXuBsYWC
 oIo8F3ZrkFb39CHtrLSJswYnlYXqiny+pQRhJ0JJY8mm2WznEWoBPadVIQodAETZg2Uw
 2+1wlwIdogUi3TSXcDTETml3X6/VA8767YSQWv+l8sqj6Gv39Wf0i0e64OOgSB8ODvhe
 LOrYkaZRh9L9e8/VeTWUavlI4sizgctF83mSkq5Lw2EYqPDSi5cNJ7/bD+Lu/YLIkI6J
 F+8aS5yZo6/Cd+PYLB3QEcAtC0PaUPVqBIrm+907DxjBpQbXMNnG5/3tk3lOAwGTiKwv
 1Q6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWla4sQ3iUYpm4tFhuzZCFjXmRpKb7utZ4SipPxMv7ZLno8b/l0UTy23g3R6/DVggvdefo22wk=@lists.denx.de
X-Gm-Message-State: AOJu0YwX9CB8JM1NQw45G8dLdiqDloZc/haZ5M084D1aFGz9jcorEtBf
 AH8MK3EGxaOo1WOE8Gc2nORyz0i+3FV1NhUwXziJxgrc0+HcTSRal6RP9gCqZs/MHZJIfmA2aHX
 /j6bxdrJKWz5p4jG1eNAWHBCv8yq/KHaTkaIDkGFINFEY+I49Wg==
X-Gm-Gg: ASbGncv8h8kjbZUiZv1M7Q8Fchf9juqSSbip5wB16d24tXiQS1EtRAlNytGdDNGWi/K
 Hw+RTzHYF5eTRqpTQ3qBlWkGbCWypx5WrfO8tLIdCB5Ey8srn0hhV3SIgY5GGQ7hKpS3GeNI0VW
 ZDlfNOeQq0YmKILTYz2SN4d4YsVnlV
X-Google-Smtp-Source: AGHT+IEeeJrNQPUIChbIU0qKSANSpN/AmxLRip8jUF2ZlbDmdDgQWBjWJBgcBA1M9WoK62gT5wYAM9QKb5S/vy57Jm8=
X-Received: by 2002:a17:907:6d0c:b0:abf:63fa:43d4 with SMTP id
 a640c23a62f3a-ac7d1bef006mr37449166b.44.1743703084487; Thu, 03 Apr 2025
 10:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <0bdf2e32-80f3-415f-a3b8-eecf5a4edd5f@cherry.de>
 <CAFLszThmVOd2G2zSHy8mNHEQ=FW7c+KNTD_XLxiQgbMKM=AxXw@mail.gmail.com>
 <ad07a506-c7a4-43ed-93c1-24626974a2eb@cherry.de>
 <CAFLszTic6gt4fT4pVVthd-3rRy6JZ_28QLXWOYPak=ZJqYH5QQ@mail.gmail.com>
 <ef183d5a-48d3-4068-be11-04edd55febf5@cherry.de>
 <CAFLszTjSeB9BkrV2fmtxof=jiS6NNJ-y6KD8JLzXXoGD=mp++Q@mail.gmail.com>
 <20250327234959.GS93000@bill-the-cat>
 <CAFLszTgqU_h+212y4GcXHrm+N7mUoZAaz+E2v3483wzTwNEWkA@mail.gmail.com>
 <20250330144526.GO93000@bill-the-cat>
 <CAFLszTjNwtmBqiDUQZPChXYMQei2spTMobZvAu3cQeMfJwNkkw@mail.gmail.com>
 <20250401171933.GN5495@bill-the-cat>
In-Reply-To: <20250401171933.GN5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 4 Apr 2025 06:57:49 +1300
X-Gm-Features: AQ5f1JrQcwC4HtfF0PhSsPBf4h-GBZ4VZXIjNBS1e-MyV796BXU6aLoMghNG-gc
Message-ID: <CAFLszTiCYaHC1edV7kHF3rpzmtTvB09U8Z7txP_QAVaHu1=uag@mail.gmail.com>
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

On Wed, 2 Apr 2025 at 06:19, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Apr 02, 2025 at 04:48:35AM +1300, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 31 Mar 2025 at 03:45, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Mar 28, 2025 at 04:44:53AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 27 Mar 2025 at 17:50, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Mar 26, 2025 at 10:46:57AM -0600, Simon Glass wrote:
> > > > > > Hi Quentin,
> > > > > >
> > > > > > On Tue, 25 Mar 2025 at 04:20, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On 3/20/25 4:26 AM, Simon Glass wrote:
> > > > > > > > Hi Quentin,
> > > > > > > >
> > > > > > > > On Wed, 19 Mar 2025 at 16:31, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > > > > > > >>
> > > > > > > >> Hi Simon
> > > > > > > >>
> > > > > > > >> On 3/19/25 4:03 PM, Simon Glass wrote:
> > > > > > > >>> Hi Quentin,
> > > > > > > >>>
> > > > > > > >>> On Wed, 19 Mar 2025 at 13:04, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > > > > > > >>>>
> > > > > > > >>>> Hi Simon,
> > > > > > > >>>>
> > > > > > > >>>> On 3/19/25 12:49 PM, Simon Glass wrote:
> > > > > > > >>>>> Logging of function return-values is used very frequently in U-Boot now.
> > > > > > > >>>>> Add a few helper macros to make it less verbose to use.
> > > > > > > >>>>>
> > > > > > > >>>>> It turns out that the log_ret() variants are not so useful, since it is
> > > > > > > >>>>> not obviously where the error is coming from. So only the log_msg_ret()
> > > > > > > >>>>> variants are worthy of these macros.
> > > > > > > >>>>>
> > > > > > > >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > >>>>> ---
> > > > > > > >>>>>
> > > > > > > >>>>>     include/log.h | 26 ++++++++++++++++++++++++++
> > > > > > > >>>>>     1 file changed, 26 insertions(+)
> > > > > > > >>>>>
> > > > > > > >>>>> diff --git a/include/log.h b/include/log.h
> > > > > > > >>>>> index 4f6d6a2c2cf..bdda7af570c 100644
> > > > > > > >>>>> --- a/include/log.h
> > > > > > > >>>>> +++ b/include/log.h
> > > > > > > >>>>> @@ -380,6 +380,32 @@ void __assert_fail(const char *assertion, const char *file, unsigned int line,
> > > > > > > >>>>>     #define log_msg_retz(_msg, _ret) ((void)(_msg), _ret)
> > > > > > > >>>>>     #endif
> > > > > > > >>>>>
> > > > > > > >>>>> +/*
> > > > > > > >>>>> + * LOGR() - helper macro for calling a function and logging error returns
> > > > > > > >>>>> + *
> > > > > > > >>>>> + * Logs if the function returns a negative value
> > > > > > > >>>>> + *
> > > > > > > >>>>> + * Usage:   LOGR("abc", my_function(...));
> > > > > > > >>>>> + */
> > > > > > > >>>>> +#define LOGR(_msg, _expr)    do {            \
> > > > > > > >>>>> +     int _ret = _expr;                       \
> > > > > > > >>>>> +     if (_ret < 0)                           \
> > > > > > > >>>>> +             return log_msg_ret(_msg, _ret); \
> > > > > > > >>>>> +     } while (0)
> > > > > > > >>>>> +
> > > > > > > >>>>> +/*
> > > > > > > >>>>> + * LOGZ() - helper macro for calling a function and logging error returns
> > > > > > > >>>>> + *
> > > > > > > >>>>> + * Logs if the function returns a non-zero value
> > > > > > > >>>>> + *
> > > > > > > >>>>> + * Usage:   LOGZ("abc", my_function(...));
> > > > > > > >>>>> + */
> > > > > > > >>>>> +#define LOGZ(_msg, _expr)    do {            \
> > > > > > > >>>>> +     int _ret = _expr;                       \
> > > > > > > >>>>> +     if (_ret)                               \
> > > > > > > >>>>> +             return log_msg_retz(_msg, _ret);        \
> > > > > > > >>>>> +     } while (0)
> > > > > > > >>>>> +
> > > > > > > >>>>
> > > > > > > >>>> Mmmm not sure this forced return call is a good idea, this would forbid
> > > > > > > >>>> us from performing some unwinding for example.
> > > > > > > >>>
> > > > > > > >>> Yes, it is really only for simple cases. Without the return, there
> > > > > > > >>> isn't much value and you may as well not use this macro.
> > > > > > > >>>
> > > > > > > >>>>
> > > > > > > >>>> I don't really see how that is better than simply calling
> > > > > > > >>>>
> > > > > > > >>>> return log_msg_retz("abc", my_function());
> > > > > > > >>>
> > > > > > > >>> That's not the intention. It actually replaces:
> > > > > > > >>>
> > > > > > > >>> ret = my_function();
> > > > > > > >>> if (ret)
> > > > > > > >>>       return_log_msg_ret("abc", ret);
> > > > > > > >>>
> > > > > > > >>> I use this a lot in my code. You can't always just return, since there
> > > > > > > >>> may not be an error.
> > > > > > > >>>
> > > > > > > >>
> > > > > > > >> I see, I read too fast again. Only return if it's an error.
> > > > > > > >>
> > > > > > > >>>>
> > > > > > > >>>> ?
> > > > > > > >>>>
> > > > > > > >>>> If we were to keep this, I would recommend to rename the macro and fix
> > > > > > > >>>> the docstring because it does not only log if the function returns a
> > > > > > > >>>> non-zero value. It does actually return.
> > > > > > > >>>>
> > > > > > > >>>> So something like
> > > > > > > >>>>
> > > > > > > >>>> LOGZ_AND_RETURN(_msg, _expr)
> > > > > > > >>>>
> > > > > > > >>>> maybe?
> > > > > > > >>>
> > > > > > > >>> Sure, longer names are easier to learn, but then it is so long I doubt
> > > > > > > >>> anyone would use it.
> > > > > > > >>>
> > > > > > > >>> Perhaps LOG_RET() and LOG_RETZ() ? But they might get confused with
> > > > > > > >>> log_ret() and log_retz(), which I am actually thinking of deleting.
> > > > > > > >>>
> > > > > > > >>> I would like the shortest possible name to avoid spilling functions
> > > > > > > >>> onto the next line all the time.
> > > > > > > >>>
> > > > > > > >>
> > > > > > > >> It should be absolutely obvious from the macro name that this can in
> > > > > > > >> fact return because missing to unwind code is among the things
> > > > > > > >> developers typically easily miss already, so with this macro it'll be
> > > > > > > >> even easier to forget about undoing things.
> > > > > > > >>
> > > > > > > >
> > > > > > > > Yes that's true. We don't have a huge amount of tests for this 'undo'
> > > > > > > > code either. I would bet that a code-coverage map would show that.
> > > > > > > >
> > > > > > >
> > > > > > > Yeah but that's not a reason to make it even harder to spot issues in
> > > > > > > the undo code :)
> > > > > >
> > > > > > I suspect people will just have to learn the macros, as they have with
> > > > >
> > > > > I would ask "What kernel construct have people already learned and we
> > > > > can adapt inside the macro?".
> > > >
> > > > Is there such a thing?
> > >
> > > Likely so. This isn't some new and novel problem, and it's likely more
> > > people have put thought in to this and come up with something well
> > > reviewed there.
> >
> > What are you referring to here? I am not seeing anything in Linux
> > related to this.
>
> Then it's probably more pain than help in getting everyone to write code
> that handles wind/unwind/logging consistently and correctly and no we
> shouldn't wrap this up in some macro.

I don't have my heart set on this patch. Having used it in quite a bit
of code I think it has value, but it has drawbacks too.

Quentin, what do you think?

Regards,
Simon
