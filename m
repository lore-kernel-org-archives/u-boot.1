Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6AAC78828
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 11:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13BB089323;
	Fri, 20 Sep 2024 13:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wOEvwd//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B21289325; Fri, 20 Sep 2024 13:38:10 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9FFE8910D
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 13:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c241feb80dso5839636a12.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 04:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726832286; x=1727437086; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rfNMQhm50PB96sNDXB1SRlqgkPfVxPgptcFHVnuY9lg=;
 b=wOEvwd//KYSrrRovNteb9DMUlkMATqFV8Zs96ls+sL+ELJ8d1tWbaxdwmY5d17fzGz
 LVuP/ZWbBxlJBkAUydcDZqUBAa7K+JGY2T3fmoBmcDe5ISM+brnfFg5ZDXzQusjrB6vp
 CK4AxhqJDzj0Pbm1A1bxuimOq7ubVz2Rw5inJqWbMFQJg9lRnxdzZv9iMmCObg79+3sr
 fWhsodemjzHxCU/qObQmCUXeYlgFJpFJLHzxI2auaRHA5AFEHulKrh/PaGyBcy1MeDIX
 ddtBtv1uhlolCl5VfcX51J7pTw9QgZA3En01ZjyXF0tBkixk0p3buGmBQs2jOvInFrd3
 qT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726832286; x=1727437086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rfNMQhm50PB96sNDXB1SRlqgkPfVxPgptcFHVnuY9lg=;
 b=N5xenad6eE2U3C+JT26okAsbbR1WsQXTI+pYWoDkvqAQ9Gt7TxWFv3bwz9/GkfHgqN
 +ntcIhp3J09C7zdcx6fIkbQmbQM7VX8c+0zD7Q2qowG4u1yp/nf+1Qcz1PtoAlUvxQxy
 B/oKDkCagD93tYtokzs3XVcIu4waEiGsKyI1fT50b/N1qYXISSs55o9Q9cMMjUe4eXgo
 dKdKwdie/dro228a+RAJ9A4ac1GOjkQMiH+gauZdWXsAOYwXlwDeOCYL4V8EjFk8wN8x
 heetLq4rfFe8PrDucFd6oDr5QYWaQNx//PBvh6mhqR/HsdFWqxgJxopqlZK1YN8rA5Gw
 Wv/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlXY9SZMtkE8cSLEKSQCvuyvTA9VIabY4LVhyelmEV7uOSLzaB8s4Q2j4YQqXDMk6xiOXrCEo=@lists.denx.de
X-Gm-Message-State: AOJu0YzxT77mv7EZE3oH4mbJ9ITHKICvlFJu8DB+UuyZz1L9Muw4v4O8
 zu4iJayda49WGWSspIWQ+8ExZ0lDMMRJCBQ8dN/+Ea6gdT9kquFX7euX9kYBhM59Zo3mAsEvkka
 DLMSSMyZDvegRZDL2dVgEo8xdzquomeAWbiMC1w==
X-Google-Smtp-Source: AGHT+IHAaywNM16dVF+7GBHySeMvj13h9MbP/YIiLWUza0TmfqDJn5uVYlefAdYBB0vfZi/fgKKxNUmMfJauor8nb8E=
X-Received: by 2002:a05:6402:5194:b0:5c2:1014:295a with SMTP id
 4fb4d7f45d1cf-5c459203469mr6580690a12.2.1726832286062; Fri, 20 Sep 2024
 04:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-5-sughosh.ganu@linaro.org>
 <0291efc6-86a2-437c-938a-707c46c34f91@gmx.de>
 <CADg8p94TakJXkLs=m6RbvO2T_OmYagf68e4JV655TtQ5DnxtZg@mail.gmail.com>
 <CAC_iWjKFh+g1k=HHKeApJp8OO5G78p0kruz59UUX-yfZcynJyg@mail.gmail.com>
In-Reply-To: <CAC_iWjKFh+g1k=HHKeApJp8OO5G78p0kruz59UUX-yfZcynJyg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 20 Sep 2024 17:07:54 +0530
Message-ID: <CADg8p96-kG4jEd5d_7ah3s2kOzgW4_uvDOJL+wOSzdrDjoMqZg@mail.gmail.com>
Subject: Re: [PATCH 04/16] event: add event to notify lmb memory map changes
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

On Fri, 20 Sept 2024 at 14:51, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh,
>
> On Tue, 17 Sept 2024 at 15:33, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Sat, 14 Sept 2024 at 20:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 9/5/24 10:27, Sughosh Ganu wrote:
> > > > Add an event which would be used for notifying changes in the
> > > > LMB modules' memory map. This is to be used for having a
> > > > synchronous view of the memory that is currently in use, and that is
> > > > available for allocations.
> > >
> > > The synchronous view problem only exists because we are duplicating
> > > data. Store the EFI memory type in LMB and the problem vanishes.
> >
> > The LMB module only concerns itself with RAM memory. If I understand
> > correctly, you are proposing maintaining the EFI memory map within the
> > LMB module ? That would mean handling memory types other than
> > conventional memory in LMB.
>
> I am pretty sure I've asked this before, but do these *always* need to
> be in sync?
>
> The efi allocators will call LMB now. So when we allocate something
> gtom EFI, even if any potential changes from LMB haven't been
> published to EFI, we won't have any memory corruptions. Can't we just
> opportunistically update the memory map once someone requests it?

I have given this a thought. Because what you mention, Simon has a
similar comment. But to achieve this, it would require generating a
new efi memory map afresh every time such a requirement comes up. This
would mean, create a new memory map, put in the conventional memory,
and add other memory types that were part of the existing memory map.
And then remove the older memory map. This would need to be done every
time a memory map is needed to be generated. And that would also
include instances when a user enters a command to get the current
memory map. I think notifying any changes to the lmb memory map to the
efi memory module is easier, and less error prone.

-sughosh

>
> Thanks
> /Ilias
> >
> > -sughosh
> >
> > >
> > > The event is only needed to notify EFI_EVENT_GROUP_MEMORY_MAP_CHANGE.
> > >
> > > Best regards
> > >
> > > Heinrich
> > >
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > >   common/event.c  |  2 ++
> > > >   include/event.h | 14 ++++++++++++++
> > > >   2 files changed, 16 insertions(+)
> > > >
> > > > diff --git a/common/event.c b/common/event.c
> > > > index dda569d447..fc8002603c 100644
> > > > --- a/common/event.c
> > > > +++ b/common/event.c
> > > > @@ -48,6 +48,8 @@ const char *const type_name[] = {
> > > >
> > > >       /* main loop events */
> > > >       "main_loop",
> > > > +
> > > > +     "lmb_map_update",
> > > >   };
> > > >
> > > >   _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
> > > > diff --git a/include/event.h b/include/event.h
> > > > index fb353ad623..fce7e96170 100644
> > > > --- a/include/event.h
> > > > +++ b/include/event.h
> > > > @@ -153,6 +153,14 @@ enum event_t {
> > > >        */
> > > >       EVT_MAIN_LOOP,
> > > >
> > > > +     /**
> > > > +      * @EVT_LMB_MAP_UPDATE:
> > > > +      * This event is triggered on an update to the LMB reserved memory
> > > > +      * region. This can be used to notify about any LMB memory allocation
> > > > +      * or freeing of memory having occurred.
> > > > +      */
> > > > +     EVT_LMB_MAP_UPDATE,
> > > > +
> > > >       /**
> > > >        * @EVT_COUNT:
> > > >        * This constants holds the maximum event number + 1 and is used when
> > > > @@ -203,6 +211,12 @@ union event_data {
> > > >               oftree tree;
> > > >               struct bootm_headers *images;
> > > >       } ft_fixup;
> > > > +
> > > > +     struct event_lmb_map_update {
> > > > +             u64 base;
> > > > +             u64 size;
> > > > +             u8 op;
> > > > +     } lmb_map;
> > > >   };
> > > >
> > > >   /**
> > >
