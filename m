Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C04C36010
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 10:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED9781E6C;
	Fri, 28 Mar 2025 11:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cgtdyK09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA82181F28; Fri, 28 Mar 2025 11:45:09 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A2381F4D
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 11:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5ec9d24acfbso5603064a12.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 03:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743158707; x=1743763507; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b5Lzy1zniDSCPH/3H8TG7JSuXiX5eb0WnpovEhwqI6I=;
 b=cgtdyK09Q5BtMbOmio6am8vlayQ7A7CwAQVQZ7y+Hm8xrcirdsQGFqOdb2JX95/5JR
 0zpH7hPMNQW3i7drRrHQDTZxL1bBGqTg2iPiaCo7659gAtp/BeOPRzszk6r/MRrx3JHp
 iH92sEt5wOSjLxP6Z7q7WZCkmhcUs4pIb8tGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743158707; x=1743763507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b5Lzy1zniDSCPH/3H8TG7JSuXiX5eb0WnpovEhwqI6I=;
 b=Qmt+28TYTIPLgRN2OMaLY/HkOjUtrDznqxE39TRNflWA/zteMBySDANyJdpESiRi/M
 tNQtSO6bIly5D7rWjD8gbETua0+K3iQEVCottXv3HgH+GR7nAN9npw9sr5VmwsMn6T4B
 jQLxhD6cJjg5XfkgRKMDo7cp4TyPrQEa0eY2QRy8ATcuk9yEqcf4nMXU0BQ/GqPhaeoR
 XW/jjwFaS/lI/ppoVZ9WyT+WEDwznzXnuoY58zaL8rpC9/yaqGve8pQpaonxyxYAmpHC
 woO8S7a8lhbslp471/Kx/zywTWmnoFsHTZ6HOh5WtBdo+zrA2+nNnksV8X9BIr6gxcpk
 74HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWasKh2OeR7nJehuwxdCcs0MH+THAMgxvIQc+fOnmmmbGP8Yk7T7EcXSFOJzaj0ygdVvwjpsxU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8ldzMoR8Gs2A6idw/SoyS5dDktTpeP2ts8tlD9v8O8VIDM0Vu
 VixyhXpxD9a1ZlAHRZ4RMa+q3c6bEvUDgBUgbG0Gyn5YPU+pYrRHFF2mVesSKFwzHIJkspqEAlM
 NWN7HVbssEvu1oy50KxV9LlKSpCqLAOaFs00I
X-Gm-Gg: ASbGncvFZznJntX3SLq64Di2N0zdhRi45UscPdtSmVzUeD9GB+v+LutVjkqVGaIkXHS
 jX4GBGbnNalMS/jMOs86m52Q8oYQmGv4lfzeud/dccAHZDDPXZQnQf42RPY91bQFX9rl51HXCvc
 7q5HafMNbUrEfrNRK3sVLSsyPHhBg=
X-Google-Smtp-Source: AGHT+IGC4ud4gB3bOId54OrNI2dUIxEvz4lRJG6AAqLEpxO8oyiUtBXT+y8hvatXVf1+eZIXT55heza2tQg7lVRSUaU=
X-Received: by 2002:a17:907:96a7:b0:ac1:17fe:c74f with SMTP id
 a640c23a62f3a-ac71f4e5b83mr173358666b.21.1743158706640; Fri, 28 Mar 2025
 03:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250319114947.2188805-1-sjg@chromium.org>
 <0bdf2e32-80f3-415f-a3b8-eecf5a4edd5f@cherry.de>
 <CAFLszThmVOd2G2zSHy8mNHEQ=FW7c+KNTD_XLxiQgbMKM=AxXw@mail.gmail.com>
 <ad07a506-c7a4-43ed-93c1-24626974a2eb@cherry.de>
 <CAFLszTic6gt4fT4pVVthd-3rRy6JZ_28QLXWOYPak=ZJqYH5QQ@mail.gmail.com>
 <ef183d5a-48d3-4068-be11-04edd55febf5@cherry.de>
 <CAFLszTjSeB9BkrV2fmtxof=jiS6NNJ-y6KD8JLzXXoGD=mp++Q@mail.gmail.com>
 <20250327234959.GS93000@bill-the-cat>
In-Reply-To: <20250327234959.GS93000@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 04:44:53 -0600
X-Gm-Features: AQ5f1Jpk0fmO-zqlgDH3a5uYcsEFZrDzk9AohmjXTJspG43RWA-IwluiqKkHK1A
Message-ID: <CAFLszTgqU_h+212y4GcXHrm+N7mUoZAaz+E2v3483wzTwNEWkA@mail.gmail.com>
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

On Thu, 27 Mar 2025 at 17:50, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 26, 2025 at 10:46:57AM -0600, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Tue, 25 Mar 2025 at 04:20, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > >
> > > Hi Simon,
> > >
> > > On 3/20/25 4:26 AM, Simon Glass wrote:
> > > > Hi Quentin,
> > > >
> > > > On Wed, 19 Mar 2025 at 16:31, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > > >>
> > > >> Hi Simon
> > > >>
> > > >> On 3/19/25 4:03 PM, Simon Glass wrote:
> > > >>> Hi Quentin,
> > > >>>
> > > >>> On Wed, 19 Mar 2025 at 13:04, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > > >>>>
> > > >>>> Hi Simon,
> > > >>>>
> > > >>>> On 3/19/25 12:49 PM, Simon Glass wrote:
> > > >>>>> Logging of function return-values is used very frequently in U-Boot now.
> > > >>>>> Add a few helper macros to make it less verbose to use.
> > > >>>>>
> > > >>>>> It turns out that the log_ret() variants are not so useful, since it is
> > > >>>>> not obviously where the error is coming from. So only the log_msg_ret()
> > > >>>>> variants are worthy of these macros.
> > > >>>>>
> > > >>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >>>>> ---
> > > >>>>>
> > > >>>>>     include/log.h | 26 ++++++++++++++++++++++++++
> > > >>>>>     1 file changed, 26 insertions(+)
> > > >>>>>
> > > >>>>> diff --git a/include/log.h b/include/log.h
> > > >>>>> index 4f6d6a2c2cf..bdda7af570c 100644
> > > >>>>> --- a/include/log.h
> > > >>>>> +++ b/include/log.h
> > > >>>>> @@ -380,6 +380,32 @@ void __assert_fail(const char *assertion, const char *file, unsigned int line,
> > > >>>>>     #define log_msg_retz(_msg, _ret) ((void)(_msg), _ret)
> > > >>>>>     #endif
> > > >>>>>
> > > >>>>> +/*
> > > >>>>> + * LOGR() - helper macro for calling a function and logging error returns
> > > >>>>> + *
> > > >>>>> + * Logs if the function returns a negative value
> > > >>>>> + *
> > > >>>>> + * Usage:   LOGR("abc", my_function(...));
> > > >>>>> + */
> > > >>>>> +#define LOGR(_msg, _expr)    do {            \
> > > >>>>> +     int _ret = _expr;                       \
> > > >>>>> +     if (_ret < 0)                           \
> > > >>>>> +             return log_msg_ret(_msg, _ret); \
> > > >>>>> +     } while (0)
> > > >>>>> +
> > > >>>>> +/*
> > > >>>>> + * LOGZ() - helper macro for calling a function and logging error returns
> > > >>>>> + *
> > > >>>>> + * Logs if the function returns a non-zero value
> > > >>>>> + *
> > > >>>>> + * Usage:   LOGZ("abc", my_function(...));
> > > >>>>> + */
> > > >>>>> +#define LOGZ(_msg, _expr)    do {            \
> > > >>>>> +     int _ret = _expr;                       \
> > > >>>>> +     if (_ret)                               \
> > > >>>>> +             return log_msg_retz(_msg, _ret);        \
> > > >>>>> +     } while (0)
> > > >>>>> +
> > > >>>>
> > > >>>> Mmmm not sure this forced return call is a good idea, this would forbid
> > > >>>> us from performing some unwinding for example.
> > > >>>
> > > >>> Yes, it is really only for simple cases. Without the return, there
> > > >>> isn't much value and you may as well not use this macro.
> > > >>>
> > > >>>>
> > > >>>> I don't really see how that is better than simply calling
> > > >>>>
> > > >>>> return log_msg_retz("abc", my_function());
> > > >>>
> > > >>> That's not the intention. It actually replaces:
> > > >>>
> > > >>> ret = my_function();
> > > >>> if (ret)
> > > >>>       return_log_msg_ret("abc", ret);
> > > >>>
> > > >>> I use this a lot in my code. You can't always just return, since there
> > > >>> may not be an error.
> > > >>>
> > > >>
> > > >> I see, I read too fast again. Only return if it's an error.
> > > >>
> > > >>>>
> > > >>>> ?
> > > >>>>
> > > >>>> If we were to keep this, I would recommend to rename the macro and fix
> > > >>>> the docstring because it does not only log if the function returns a
> > > >>>> non-zero value. It does actually return.
> > > >>>>
> > > >>>> So something like
> > > >>>>
> > > >>>> LOGZ_AND_RETURN(_msg, _expr)
> > > >>>>
> > > >>>> maybe?
> > > >>>
> > > >>> Sure, longer names are easier to learn, but then it is so long I doubt
> > > >>> anyone would use it.
> > > >>>
> > > >>> Perhaps LOG_RET() and LOG_RETZ() ? But they might get confused with
> > > >>> log_ret() and log_retz(), which I am actually thinking of deleting.
> > > >>>
> > > >>> I would like the shortest possible name to avoid spilling functions
> > > >>> onto the next line all the time.
> > > >>>
> > > >>
> > > >> It should be absolutely obvious from the macro name that this can in
> > > >> fact return because missing to unwind code is among the things
> > > >> developers typically easily miss already, so with this macro it'll be
> > > >> even easier to forget about undoing things.
> > > >>
> > > >
> > > > Yes that's true. We don't have a huge amount of tests for this 'undo'
> > > > code either. I would bet that a code-coverage map would show that.
> > > >
> > >
> > > Yeah but that's not a reason to make it even harder to spot issues in
> > > the undo code :)
> >
> > I suspect people will just have to learn the macros, as they have with
>
> I would ask "What kernel construct have people already learned and we
> can adapt inside the macro?".

Is there such a thing?

Regards,
Simon
