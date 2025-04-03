Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A1CC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 18:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B07B782139;
	Thu,  3 Apr 2025 20:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hUT83s2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D78A082140; Thu,  3 Apr 2025 20:05:55 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 902338212F
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 20:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so199331666b.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743703553; x=1744308353; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O3ayCeddJrQfmtJw1hGEqlZgEeOafXvB64ZxPrfew0I=;
 b=hUT83s2rAga97g0iHZE2N7/et7ic9/t904cM9FI8bB/H8dGJ1qNwwaAzDT/lAWlLS+
 n9Jf9lE8vY0ubJrCe/6hvZf+usEy6i88mvG3yZk8+cFKe/MRWT104y4l0nHlOu4N1UxJ
 n8uqFI2+piwR2i5fkSldZncCVqYgcIOP2gjGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743703553; x=1744308353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O3ayCeddJrQfmtJw1hGEqlZgEeOafXvB64ZxPrfew0I=;
 b=aj2OFmPcSFy0jtcZr6gZOrlUHrrIoP8rM+y5l9nPk6fg7uwcunKpTEZrqEVxBOoXwB
 uKRFbXGiauOyBAAAVzBzN+HOInGCjhMMfHKHBZUu5SGUzA0GkfOwv4feAilT4aAx+Poz
 3adYJHy6LDoLhcF/1ButXeoU+UjYECR+jcwTDuwp7oCZVCBkGLUrQW7kS4pqeMtPZxEP
 aBpf0rEvs72ujRmJXkeg5O3RTMpqs4mfL/EbqdyMF5MurAtiivFa7TSvJk8TSg4p3KeO
 PlKwA0NkibAYHncO5RnkI8E+YR5dnifIylr4aI8P1If8Jry9TLmuGT242ttK5znVKao6
 lmCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0yRGAu/T5hbaBLLpg5P4OoNONTWsZH8UtOOIIo02k1OSW56SSvhBNpGXtgCKymV/V9JJuAeM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1xVAB0bBYBdeNfP6pLmHnq6YTl4dIheq6grWUGeY2U1+JZQe2
 PrzaEM/IWVKuQtf4cRWRPn00tNyt08Uyl5r4yD7u72CPR815CHAJIjjiqtVQmL7qezYjk0di5CS
 qIY44nY7gAHeANdfJSGw2gB8bb+BTwBZZ6381D4giSFQR2iMZwg==
X-Gm-Gg: ASbGncuMq9F3pRMtRM5QhqTwWTcckbU3dFvGQLFhK0swQN96Ti1GuD7aEB6Yd4CiWn8
 HsqANLphKNJ+lU41RLZsriQ9vpaLPOCwvXLSs8mk4KqLH22MZ48uLC5Lr3YH8uUEAntxZKcPhVB
 XxJ/2lITGKAi19Hw7HG8hODxrIjRIV
X-Google-Smtp-Source: AGHT+IHE59MU7HLQTuoHIPkSMBbmjaQo2bhgxvufQFuOWXHWlhx8/OIKN1kjqkEHujrDij7w6BwsdUjOZn6/IGmMu/g=
X-Received: by 2002:a17:907:60d5:b0:ac7:c585:c3bc with SMTP id
 a640c23a62f3a-ac7d1709da4mr55245666b.19.1743703552569; Thu, 03 Apr 2025
 11:05:52 -0700 (PDT)
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
 <CAFLszTiCYaHC1edV7kHF3rpzmtTvB09U8Z7txP_QAVaHu1=uag@mail.gmail.com>
 <708886d6-ff65-4390-9780-34449678615b@cherry.de>
In-Reply-To: <708886d6-ff65-4390-9780-34449678615b@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 4 Apr 2025 07:05:40 +1300
X-Gm-Features: AQ5f1JpuBYz9I1ddy1L6kD4O3lKr9bBCUL6xzfqLK67rECWE9RTz59nQDwhkbXw
Message-ID: <CAFLszThYMAd6dU+2qFswQrnhw8ZTPjcspvXZ6m2iRVmNHnYR7g@mail.gmail.com>
Subject: Re: [PATCH] log: Add helpers for calling log_msg_ret() et al
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Fri, 4 Apr 2025 at 07:03, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 4/3/25 7:57 PM, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 2 Apr 2025 at 06:19, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Wed, Apr 02, 2025 at 04:48:35AM +1300, Simon Glass wrote:
> >>> Hi Tom,
> >>>
> >>> On Mon, 31 Mar 2025 at 03:45, Tom Rini <trini@konsulko.com> wrote:
> >>>>
> >>>> On Fri, Mar 28, 2025 at 04:44:53AM -0600, Simon Glass wrote:
> >>>>> Hi Tom,
> >>>>>
> >>>>> On Thu, 27 Mar 2025 at 17:50, Tom Rini <trini@konsulko.com> wrote:
> >>>>>>
> >>>>>> On Wed, Mar 26, 2025 at 10:46:57AM -0600, Simon Glass wrote:
> >>>>>>> Hi Quentin,
> >>>>>>>
> >>>>>>> On Tue, 25 Mar 2025 at 04:20, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>>>>>>
> >>>>>>>> Hi Simon,
> >>>>>>>>
> >>>>>>>> On 3/20/25 4:26 AM, Simon Glass wrote:
> >>>>>>>>> Hi Quentin,
> >>>>>>>>>
> >>>>>>>>> On Wed, 19 Mar 2025 at 16:31, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>>>>>>>>
> >>>>>>>>>> Hi Simon
> >>>>>>>>>>
> >>>>>>>>>> On 3/19/25 4:03 PM, Simon Glass wrote:
> >>>>>>>>>>> Hi Quentin,
> >>>>>>>>>>>
> >>>>>>>>>>> On Wed, 19 Mar 2025 at 13:04, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> Hi Simon,
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 3/19/25 12:49 PM, Simon Glass wrote:
> >>>>>>>>>>>>> Logging of function return-values is used very frequently in U-Boot now.
> >>>>>>>>>>>>> Add a few helper macros to make it less verbose to use.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> It turns out that the log_ret() variants are not so useful, since it is
> >>>>>>>>>>>>> not obviously where the error is coming from. So only the log_msg_ret()
> >>>>>>>>>>>>> variants are worthy of these macros.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>>>>>>>>>>> ---
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>      include/log.h | 26 ++++++++++++++++++++++++++
> >>>>>>>>>>>>>      1 file changed, 26 insertions(+)
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> diff --git a/include/log.h b/include/log.h
> >>>>>>>>>>>>> index 4f6d6a2c2cf..bdda7af570c 100644
> >>>>>>>>>>>>> --- a/include/log.h
> >>>>>>>>>>>>> +++ b/include/log.h
> >>>>>>>>>>>>> @@ -380,6 +380,32 @@ void __assert_fail(const char *assertion, const char *file, unsigned int line,
> >>>>>>>>>>>>>      #define log_msg_retz(_msg, _ret) ((void)(_msg), _ret)
> >>>>>>>>>>>>>      #endif
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> +/*
> >>>>>>>>>>>>> + * LOGR() - helper macro for calling a function and logging error returns
> >>>>>>>>>>>>> + *
> >>>>>>>>>>>>> + * Logs if the function returns a negative value
> >>>>>>>>>>>>> + *
> >>>>>>>>>>>>> + * Usage:   LOGR("abc", my_function(...));
> >>>>>>>>>>>>> + */
> >>>>>>>>>>>>> +#define LOGR(_msg, _expr)    do {            \
> >>>>>>>>>>>>> +     int _ret = _expr;                       \
> >>>>>>>>>>>>> +     if (_ret < 0)                           \
> >>>>>>>>>>>>> +             return log_msg_ret(_msg, _ret); \
> >>>>>>>>>>>>> +     } while (0)
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +/*
> >>>>>>>>>>>>> + * LOGZ() - helper macro for calling a function and logging error returns
> >>>>>>>>>>>>> + *
> >>>>>>>>>>>>> + * Logs if the function returns a non-zero value
> >>>>>>>>>>>>> + *
> >>>>>>>>>>>>> + * Usage:   LOGZ("abc", my_function(...));
> >>>>>>>>>>>>> + */
> >>>>>>>>>>>>> +#define LOGZ(_msg, _expr)    do {            \
> >>>>>>>>>>>>> +     int _ret = _expr;                       \
> >>>>>>>>>>>>> +     if (_ret)                               \
> >>>>>>>>>>>>> +             return log_msg_retz(_msg, _ret);        \
> >>>>>>>>>>>>> +     } while (0)
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>
> >>>>>>>>>>>> Mmmm not sure this forced return call is a good idea, this would forbid
> >>>>>>>>>>>> us from performing some unwinding for example.
> >>>>>>>>>>>
> >>>>>>>>>>> Yes, it is really only for simple cases. Without the return, there
> >>>>>>>>>>> isn't much value and you may as well not use this macro.
> >>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> I don't really see how that is better than simply calling
> >>>>>>>>>>>>
> >>>>>>>>>>>> return log_msg_retz("abc", my_function());
> >>>>>>>>>>>
> >>>>>>>>>>> That's not the intention. It actually replaces:
> >>>>>>>>>>>
> >>>>>>>>>>> ret = my_function();
> >>>>>>>>>>> if (ret)
> >>>>>>>>>>>        return_log_msg_ret("abc", ret);
> >>>>>>>>>>>
> >>>>>>>>>>> I use this a lot in my code. You can't always just return, since there
> >>>>>>>>>>> may not be an error.
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> I see, I read too fast again. Only return if it's an error.
> >>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> ?
> >>>>>>>>>>>>
> >>>>>>>>>>>> If we were to keep this, I would recommend to rename the macro and fix
> >>>>>>>>>>>> the docstring because it does not only log if the function returns a
> >>>>>>>>>>>> non-zero value. It does actually return.
> >>>>>>>>>>>>
> >>>>>>>>>>>> So something like
> >>>>>>>>>>>>
> >>>>>>>>>>>> LOGZ_AND_RETURN(_msg, _expr)
> >>>>>>>>>>>>
> >>>>>>>>>>>> maybe?
> >>>>>>>>>>>
> >>>>>>>>>>> Sure, longer names are easier to learn, but then it is so long I doubt
> >>>>>>>>>>> anyone would use it.
> >>>>>>>>>>>
> >>>>>>>>>>> Perhaps LOG_RET() and LOG_RETZ() ? But they might get confused with
> >>>>>>>>>>> log_ret() and log_retz(), which I am actually thinking of deleting.
> >>>>>>>>>>>
> >>>>>>>>>>> I would like the shortest possible name to avoid spilling functions
> >>>>>>>>>>> onto the next line all the time.
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> It should be absolutely obvious from the macro name that this can in
> >>>>>>>>>> fact return because missing to unwind code is among the things
> >>>>>>>>>> developers typically easily miss already, so with this macro it'll be
> >>>>>>>>>> even easier to forget about undoing things.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Yes that's true. We don't have a huge amount of tests for this 'undo'
> >>>>>>>>> code either. I would bet that a code-coverage map would show that.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Yeah but that's not a reason to make it even harder to spot issues in
> >>>>>>>> the undo code :)
> >>>>>>>
> >>>>>>> I suspect people will just have to learn the macros, as they have with
> >>>>>>
> >>>>>> I would ask "What kernel construct have people already learned and we
> >>>>>> can adapt inside the macro?".
> >>>>>
> >>>>> Is there such a thing?
> >>>>
> >>>> Likely so. This isn't some new and novel problem, and it's likely more
> >>>> people have put thought in to this and come up with something well
> >>>> reviewed there.
> >>>
> >>> What are you referring to here? I am not seeing anything in Linux
> >>> related to this.
> >>
> >> Then it's probably more pain than help in getting everyone to write code
> >> that handles wind/unwind/logging consistently and correctly and no we
> >> shouldn't wrap this up in some macro.
> >
> > I don't have my heart set on this patch. Having used it in quite a bit
> > of code I think it has value, but it has drawbacks too.
> >
> > Quentin, what do you think?
> >
>
> I don't think the balance between brevity and potential confusion is
> appropriate here, I would prefer not to have this.

OK, I'll drop it.

Regards,
Simon
