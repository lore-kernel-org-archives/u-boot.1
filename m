Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD8FCF58F4
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 09:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D67B893C4;
	Fri, 20 Sep 2024 11:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MDPh47Bc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67AAB893E0; Fri, 20 Sep 2024 11:21:27 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DF9D893B8
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 11:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2d8a7c50607so1300528a91.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 02:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726824082; x=1727428882; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KZ0ksgWCH5XaMRHfU2JFRW1dG8sGMOiNqrz54f7JLJM=;
 b=MDPh47BcotublAZf4SubCOYBrI47dzjRD1DeRyXwmxuxYzlKoeeQNBgPvn/3MKTMky
 aJ8+tXmJ/2iWycHSxuLYS7ZvjmVGvDbAodyrGffoQOyM/ydRf2wkdTI/JXyCQYiuB5WP
 PLoTDnyjqsuKIvnp/IH/mO/dzmbKXZgTBebRYPzUOXh/6PiUe59n1ozKSR2ukW2XMu5s
 4zwgTVoxZioOOLuEyqj+SeMPhDt6pe/u5DYpzMsBbttHwzoQTsi7WDriBpvkxirWLsoD
 8QrFMwNz0CR9GA/HEeC5eFiLILCNPXablzLde8zyY93UPWjxKVgt40Qgk/q2Ne5bo6mz
 MQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726824082; x=1727428882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KZ0ksgWCH5XaMRHfU2JFRW1dG8sGMOiNqrz54f7JLJM=;
 b=Tc3wz4xvVCaRLSB7PmvSslCQ1ong1EVXo5AnFDAlIyTb4dDmvmOo3uJhYKVtt7EVVW
 2pJMmZtVZee7OqaCQiOT0FSYvhqO6S/KRn+7PDawsCaCi+AtYwGq2sCbhBgZXpN17Sz4
 Qh8W9LD4bvFwTr+VO7JcAl9aLL8h713Lp0rfkeo9CIIz2dJfSy3QYXcfKt6CJyWDvoy3
 J9fZPAGBnTSwt1WR4ar/khgouNADkvxNQpBKFUluv9js/4AINI7wHRyGNLTBz4ZIOca+
 +4Q1l6pl/VNpF3rzCvBVxqO/phpwXoZyWJVkVcdV+KMOnsDTvOt89THprZvlBYqu+P0H
 w5sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNYvkODzyYyfBdpGQxKy/OeXv4bCdIOkF1NMpEudwpJTyE4u4Q5zV/GlosX9vUk/ciyT2Caw8=@lists.denx.de
X-Gm-Message-State: AOJu0YyBC9tifTX+5mDQV1pLxQaijh8YAAhaZl/n/WopeGkqtyO8s0Xn
 hZpb/XD4mMyzmj4Hs9XMhr8o5mFZrsai7C6Pz0fObgbgj3K12j/PPcHlZuv1iRRTIRbKXVptGPA
 Urk8LLJn0GxTG5lTkEqXsCRtE397qfqWy07qf9g==
X-Google-Smtp-Source: AGHT+IE8gyHwCGoOhX3K4qPriZQTFKu9QFmEjsfDzahh/x8oAKc08BSMkdLDXL4SZaI9VmorhVUTOaN6yY3fdUefrAg=
X-Received: by 2002:a17:90b:384a:b0:2d3:c664:e253 with SMTP id
 98e67ed59e1d1-2dd80c15c04mr2456781a91.10.1726824082041; Fri, 20 Sep 2024
 02:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-5-sughosh.ganu@linaro.org>
 <0291efc6-86a2-437c-938a-707c46c34f91@gmx.de>
 <CADg8p94TakJXkLs=m6RbvO2T_OmYagf68e4JV655TtQ5DnxtZg@mail.gmail.com>
In-Reply-To: <CADg8p94TakJXkLs=m6RbvO2T_OmYagf68e4JV655TtQ5DnxtZg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 20 Sep 2024 12:20:46 +0300
Message-ID: <CAC_iWjKFh+g1k=HHKeApJp8OO5G78p0kruz59UUX-yfZcynJyg@mail.gmail.com>
Subject: Re: [PATCH 04/16] event: add event to notify lmb memory map changes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Sughosh,

On Tue, 17 Sept 2024 at 15:33, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Sat, 14 Sept 2024 at 20:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 9/5/24 10:27, Sughosh Ganu wrote:
> > > Add an event which would be used for notifying changes in the
> > > LMB modules' memory map. This is to be used for having a
> > > synchronous view of the memory that is currently in use, and that is
> > > available for allocations.
> >
> > The synchronous view problem only exists because we are duplicating
> > data. Store the EFI memory type in LMB and the problem vanishes.
>
> The LMB module only concerns itself with RAM memory. If I understand
> correctly, you are proposing maintaining the EFI memory map within the
> LMB module ? That would mean handling memory types other than
> conventional memory in LMB.

I am pretty sure I've asked this before, but do these *always* need to
be in sync?

The efi allocators will call LMB now. So when we allocate something
gtom EFI, even if any potential changes from LMB haven't been
published to EFI, we won't have any memory corruptions. Can't we just
opportunistically update the memory map once someone requests it?

Thanks
/Ilias
>
> -sughosh
>
> >
> > The event is only needed to notify EFI_EVENT_GROUP_MEMORY_MAP_CHANGE.
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >   common/event.c  |  2 ++
> > >   include/event.h | 14 ++++++++++++++
> > >   2 files changed, 16 insertions(+)
> > >
> > > diff --git a/common/event.c b/common/event.c
> > > index dda569d447..fc8002603c 100644
> > > --- a/common/event.c
> > > +++ b/common/event.c
> > > @@ -48,6 +48,8 @@ const char *const type_name[] = {
> > >
> > >       /* main loop events */
> > >       "main_loop",
> > > +
> > > +     "lmb_map_update",
> > >   };
> > >
> > >   _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
> > > diff --git a/include/event.h b/include/event.h
> > > index fb353ad623..fce7e96170 100644
> > > --- a/include/event.h
> > > +++ b/include/event.h
> > > @@ -153,6 +153,14 @@ enum event_t {
> > >        */
> > >       EVT_MAIN_LOOP,
> > >
> > > +     /**
> > > +      * @EVT_LMB_MAP_UPDATE:
> > > +      * This event is triggered on an update to the LMB reserved memory
> > > +      * region. This can be used to notify about any LMB memory allocation
> > > +      * or freeing of memory having occurred.
> > > +      */
> > > +     EVT_LMB_MAP_UPDATE,
> > > +
> > >       /**
> > >        * @EVT_COUNT:
> > >        * This constants holds the maximum event number + 1 and is used when
> > > @@ -203,6 +211,12 @@ union event_data {
> > >               oftree tree;
> > >               struct bootm_headers *images;
> > >       } ft_fixup;
> > > +
> > > +     struct event_lmb_map_update {
> > > +             u64 base;
> > > +             u64 size;
> > > +             u8 op;
> > > +     } lmb_map;
> > >   };
> > >
> > >   /**
> >
