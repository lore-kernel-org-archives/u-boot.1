Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0194C369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5513C88BBF;
	Wed, 25 Sep 2024 14:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IukhmUzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 798A188CB9; Wed, 25 Sep 2024 14:53:59 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAD6488363
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7a9acc6f22dso659426885a.0
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727268834; x=1727873634; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zfcFOhYThriLlRowGOHXNxe4RU7KYReq9LnlyxpmpPs=;
 b=IukhmUzcFGxasCAMT6dVS8vHHn45sfGwvVgGLOoyjSER4fR9xgcvkI2xpIytkomK1n
 o22NfGJapXfYKh3KOjTNpb9aSDM6Aa5YpPtJPLmrjZeBU6nBwVsfdbZy1FylclAQillw
 v7FK9HGw5P51+JSXJUQ96Lkbh9ofDOuL3f9qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727268834; x=1727873634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zfcFOhYThriLlRowGOHXNxe4RU7KYReq9LnlyxpmpPs=;
 b=ZLCkceibZZqCx02FyLaS1uWfRY0VXUhRnLB7fJPy77xJ8fxAOtEgzqXKmMkrC1NoNq
 jSH7Slpbi+51+kueIpMysMapDnAJZCqcynZKiXF/hziV9zUynJkbGPGBddgU9VX/Hn4z
 m0qBloDby+35tfvRNbkF7iuhclHI8OiMHR9LbOC61FD2/0PjdoVpcIy7UIGs7w9aUv59
 4cYaWqKOe3yZL7sh24cdEAtRHg4iD2ffY+fqwoey3lHty/9N++pnaf1jhV4SiYpvc01C
 6LqVK/r1B9WJz/ejM54PmyJCWdEt0bdhvX1phXKM9W8uMl6phmXkF/Td7WHCl4ymV2Mv
 Y7fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKpavLeEAJ2wNqNO76QJCIESGDLHqOgoIbju6hWjaHmfLGxym063XJnDwy6iTC5dn4IsvIv5k=@lists.denx.de
X-Gm-Message-State: AOJu0YxLR0w366+0XERKgOPCfbn6XfHBuYNTPA0M42XjVJxKVaejez/1
 n4nKM0QlJRO62GOgwQjDkaUgf01JwtKW5AcSn2DTUsB+ru6kz72gY+0YQUVJ1lvkG7oUk3KQeyy
 M2UMSjVNckvurDb+As3VCuKtHpREMIppWRMwO
X-Google-Smtp-Source: AGHT+IGx0jfw82tnWN5GT/piWbQa2ez0yAO60OCU+bLeBTlWNDuUKuzVEf5k63HFMJn4UHHltox6EK4NGZB08n48nus=
X-Received: by 2002:a05:6214:5704:b0:6c7:c646:25fb with SMTP id
 6a1803df08f44-6cb1dd692ecmr43347826d6.27.1727268834527; Wed, 25 Sep 2024
 05:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-5-sughosh.ganu@linaro.org>
 <0291efc6-86a2-437c-938a-707c46c34f91@gmx.de>
 <CADg8p94TakJXkLs=m6RbvO2T_OmYagf68e4JV655TtQ5DnxtZg@mail.gmail.com>
 <CAC_iWjKFh+g1k=HHKeApJp8OO5G78p0kruz59UUX-yfZcynJyg@mail.gmail.com>
 <CADg8p96-kG4jEd5d_7ah3s2kOzgW4_uvDOJL+wOSzdrDjoMqZg@mail.gmail.com>
In-Reply-To: <CADg8p96-kG4jEd5d_7ah3s2kOzgW4_uvDOJL+wOSzdrDjoMqZg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Sep 2024 14:53:43 +0200
Message-ID: <CAFLszTjD5vLpcu7+_9xuzynLMjim3oPpg2wewug3-6nMs2CHug@mail.gmail.com>
Subject: Re: [PATCH 04/16] event: add event to notify lmb memory map changes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
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

Hi Sughosh,

On Fri, 20 Sept 2024 at 13:38, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 20 Sept 2024 at 14:51, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Tue, 17 Sept 2024 at 15:33, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Sat, 14 Sept 2024 at 20:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >
> > > > On 9/5/24 10:27, Sughosh Ganu wrote:
> > > > > Add an event which would be used for notifying changes in the
> > > > > LMB modules' memory map. This is to be used for having a
> > > > > synchronous view of the memory that is currently in use, and that is
> > > > > available for allocations.
> > > >
> > > > The synchronous view problem only exists because we are duplicating
> > > > data. Store the EFI memory type in LMB and the problem vanishes.
> > >
> > > The LMB module only concerns itself with RAM memory. If I understand
> > > correctly, you are proposing maintaining the EFI memory map within the
> > > LMB module ? That would mean handling memory types other than
> > > conventional memory in LMB.
> >
> > I am pretty sure I've asked this before, but do these *always* need to
> > be in sync?
> >
> > The efi allocators will call LMB now. So when we allocate something
> > gtom EFI, even if any potential changes from LMB haven't been
> > published to EFI, we won't have any memory corruptions. Can't we just
> > opportunistically update the memory map once someone requests it?
>
> I have given this a thought. Because what you mention, Simon has a
> similar comment. But to achieve this, it would require generating a
> new efi memory map afresh every time such a requirement comes up. This
> would mean, create a new memory map, put in the conventional memory,
> and add other memory types that were part of the existing memory map.
> And then remove the older memory map. This would need to be done every
> time a memory map is needed to be generated. And that would also
> include instances when a user enters a command to get the current
> memory map. I think notifying any changes to the lmb memory map to the
> efi memory module is easier, and less error prone.

We need to get some agreement on my memory-allocation patches first. I
don't believe we are on the same page on those, despite some weeks of
discussion. We need to resolve that issue first. I did try right from
the start to first agree on the problem to be solved. We skipped that,
so now we are having to do it now...

Regards,
Simon


>
> -sughosh
>
> >
> > Thanks
> > /Ilias
> > >
> > > -sughosh
> > >
> > > >
> > > > The event is only needed to notify EFI_EVENT_GROUP_MEMORY_MAP_CHANGE.
> > > >
> > > > Best regards
> > > >
> > > > Heinrich
> > > >
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > >   common/event.c  |  2 ++
> > > > >   include/event.h | 14 ++++++++++++++
> > > > >   2 files changed, 16 insertions(+)
> > > > >
> > > > > diff --git a/common/event.c b/common/event.c
> > > > > index dda569d447..fc8002603c 100644
> > > > > --- a/common/event.c
> > > > > +++ b/common/event.c
> > > > > @@ -48,6 +48,8 @@ const char *const type_name[] = {
> > > > >
> > > > >       /* main loop events */
> > > > >       "main_loop",
> > > > > +
> > > > > +     "lmb_map_update",
> > > > >   };
> > > > >
> > > > >   _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
> > > > > diff --git a/include/event.h b/include/event.h
> > > > > index fb353ad623..fce7e96170 100644
> > > > > --- a/include/event.h
> > > > > +++ b/include/event.h
> > > > > @@ -153,6 +153,14 @@ enum event_t {
> > > > >        */
> > > > >       EVT_MAIN_LOOP,
> > > > >
> > > > > +     /**
> > > > > +      * @EVT_LMB_MAP_UPDATE:
> > > > > +      * This event is triggered on an update to the LMB reserved memory
> > > > > +      * region. This can be used to notify about any LMB memory allocation
> > > > > +      * or freeing of memory having occurred.
> > > > > +      */
> > > > > +     EVT_LMB_MAP_UPDATE,
> > > > > +
> > > > >       /**
> > > > >        * @EVT_COUNT:
> > > > >        * This constants holds the maximum event number + 1 and is used when
> > > > > @@ -203,6 +211,12 @@ union event_data {
> > > > >               oftree tree;
> > > > >               struct bootm_headers *images;
> > > > >       } ft_fixup;
> > > > > +
> > > > > +     struct event_lmb_map_update {
> > > > > +             u64 base;
> > > > > +             u64 size;
> > > > > +             u8 op;
> > > > > +     } lmb_map;
> > > > >   };
> > > > >
> > > > >   /**
> > > >
