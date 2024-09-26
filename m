Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D1ACCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 07:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7170E8857C;
	Thu, 26 Sep 2024 09:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vApv8pKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9935888CB9; Thu, 26 Sep 2024 09:12:30 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 060AF884DB
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 09:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f754d4a6e4so6874691fa.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 00:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727334746; x=1727939546; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KeSRZJnq19jZB2fpb8btbH76oiO+wC9AEzsh8wTV1bk=;
 b=vApv8pKciIA7ncB0jM+E9MsDCGPoqO/lgByj6D47+bbZ3SwljVxDCtvFO9Ck9PTsw4
 A2ZHZLrCNUx9YqzK0SOQS3NvyhwNgZ/V93vaFhxBUhrJI7B7eTHD1KoXsbnxHSSe19Nv
 hVpdp1jAT2DFfi/SZqnyxSW2OkVkWK6HPIWnehdy/z9CqlH3HNrWm+j8s6wxvoNtAAkR
 QuH5TbdEWLgUp/TB5asr4zxy4IGkolpTKX8kica5Vu00bM8+9ASQqORQVbS85lwjexHW
 7BaB0clIAVwsa3Aho+RJ6mQGmHhRMDvq/lTlKN+xTvhZFSyU9hQXA68aWPIAMppeSfTb
 CeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727334746; x=1727939546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KeSRZJnq19jZB2fpb8btbH76oiO+wC9AEzsh8wTV1bk=;
 b=aWNc6Fw09k76jYUIaKBKhyNjnTzQpTBN6B+9oCh8W9OuqLRQxssaBfflka2HpmOPm+
 FKEkqznvvzuIhKRfddUmN6hPy3xCnpFYZxmhjSPcOsaViFRD+ENbE8IR8C16rb/wMKL8
 /1Ub5lq9Q0EpS+1P+o2PvSS+BIcGZZPBs4kXbtoKIsDBQxa1lQhv3ZJrVpstVifn18M5
 4XAkGdDKS7f+4MugyE9GsDrEcxtFxYMZqje8X5xmO495jsRhjf7BP2+E9n+qLO5Gvy7n
 HoiFQvbTWfAZg+HeEyUHOPODZeR+6mtALZ/8v4UrhvVKexjZhtIClfeDzBnBJ2Lmu+Tz
 6imw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEM6ZP2cU+PX8LRkHGCU1V8PHHb/l/IyFTqUFulwxqO0s0nYlYsGPP/NPh9zsmbO/Z8wkYq88=@lists.denx.de
X-Gm-Message-State: AOJu0YxnDvjlqJrUGv1uKcHe8jxMe6s4emPECKzUxeR9SA2zdi29zSQF
 TL39Vinlj+KpVP2V+0g23jVrIRepBN1RI8WhH1IAjrNsWyr2F7SawTZm9Q+ws0oPOuCLnlUcttv
 C4m+O+jcvmmrbSIDrwycocRdDFCvPiqPVi5Nn8g==
X-Google-Smtp-Source: AGHT+IFnaizA3Y1o9l/Pvu57JmfG7sKBMSmh/D566wPqoI+uqrSln79hYtz5D7BRJSHt8Qb6zrYYT50rcyXw+aUlCcY=
X-Received: by 2002:a2e:4a0a:0:b0:2ef:1784:a20 with SMTP id
 38308e7fff4ca-2f91ca68786mr26339011fa.38.1727334746071; Thu, 26 Sep 2024
 00:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-5-sughosh.ganu@linaro.org>
 <0291efc6-86a2-437c-938a-707c46c34f91@gmx.de>
 <CADg8p94TakJXkLs=m6RbvO2T_OmYagf68e4JV655TtQ5DnxtZg@mail.gmail.com>
 <CAC_iWjKFh+g1k=HHKeApJp8OO5G78p0kruz59UUX-yfZcynJyg@mail.gmail.com>
 <CADg8p96-kG4jEd5d_7ah3s2kOzgW4_uvDOJL+wOSzdrDjoMqZg@mail.gmail.com>
 <CAFLszTjD5vLpcu7+_9xuzynLMjim3oPpg2wewug3-6nMs2CHug@mail.gmail.com>
In-Reply-To: <CAFLszTjD5vLpcu7+_9xuzynLMjim3oPpg2wewug3-6nMs2CHug@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 26 Sep 2024 12:42:14 +0530
Message-ID: <CADg8p94_8znKCR=97kCj-ypMdqW59k7PbC42G-xGFr7t9+t9XQ@mail.gmail.com>
Subject: Re: [PATCH 04/16] event: add event to notify lmb memory map changes
To: Simon Glass <sjg@chromium.org>
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

On Wed, 25 Sept 2024 at 18:23, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Fri, 20 Sept 2024 at 13:38, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Fri, 20 Sept 2024 at 14:51, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Tue, 17 Sept 2024 at 15:33, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > On Sat, 14 Sept 2024 at 20:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > >
> > > > > On 9/5/24 10:27, Sughosh Ganu wrote:
> > > > > > Add an event which would be used for notifying changes in the
> > > > > > LMB modules' memory map. This is to be used for having a
> > > > > > synchronous view of the memory that is currently in use, and that is
> > > > > > available for allocations.
> > > > >
> > > > > The synchronous view problem only exists because we are duplicating
> > > > > data. Store the EFI memory type in LMB and the problem vanishes.
> > > >
> > > > The LMB module only concerns itself with RAM memory. If I understand
> > > > correctly, you are proposing maintaining the EFI memory map within the
> > > > LMB module ? That would mean handling memory types other than
> > > > conventional memory in LMB.
> > >
> > > I am pretty sure I've asked this before, but do these *always* need to
> > > be in sync?
> > >
> > > The efi allocators will call LMB now. So when we allocate something
> > > gtom EFI, even if any potential changes from LMB haven't been
> > > published to EFI, we won't have any memory corruptions. Can't we just
> > > opportunistically update the memory map once someone requests it?
> >
> > I have given this a thought. Because what you mention, Simon has a
> > similar comment. But to achieve this, it would require generating a
> > new efi memory map afresh every time such a requirement comes up. This
> > would mean, create a new memory map, put in the conventional memory,
> > and add other memory types that were part of the existing memory map.
> > And then remove the older memory map. This would need to be done every
> > time a memory map is needed to be generated. And that would also
> > include instances when a user enters a command to get the current
> > memory map. I think notifying any changes to the lmb memory map to the
> > efi memory module is easier, and less error prone.
>
> We need to get some agreement on my memory-allocation patches first. I
> don't believe we are on the same page on those, despite some weeks of
> discussion. We need to resolve that issue first. I did try right from
> the start to first agree on the problem to be solved. We skipped that,
> so now we are having to do it now...

These patches are currently under review. But fwiw, I think you are
aware that these patches are not related to what your patch series is
attempting. Your patches are related to the efi_allocate_pool()
function, whereas this series is trying to use LMB as the backend for
allocating pages, as requested from efi_allocate_pages(). So these are
not related. But like I said, you are aware of these details :)

-sughosh

>
> Regards,
> Simon
>
>
> >
> > -sughosh
> >
> > >
> > > Thanks
> > > /Ilias
> > > >
> > > > -sughosh
> > > >
> > > > >
> > > > > The event is only needed to notify EFI_EVENT_GROUP_MEMORY_MAP_CHANGE.
> > > > >
> > > > > Best regards
> > > > >
> > > > > Heinrich
> > > > >
> > > > > >
> > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > ---
> > > > > >   common/event.c  |  2 ++
> > > > > >   include/event.h | 14 ++++++++++++++
> > > > > >   2 files changed, 16 insertions(+)
> > > > > >
> > > > > > diff --git a/common/event.c b/common/event.c
> > > > > > index dda569d447..fc8002603c 100644
> > > > > > --- a/common/event.c
> > > > > > +++ b/common/event.c
> > > > > > @@ -48,6 +48,8 @@ const char *const type_name[] = {
> > > > > >
> > > > > >       /* main loop events */
> > > > > >       "main_loop",
> > > > > > +
> > > > > > +     "lmb_map_update",
> > > > > >   };
> > > > > >
> > > > > >   _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
> > > > > > diff --git a/include/event.h b/include/event.h
> > > > > > index fb353ad623..fce7e96170 100644
> > > > > > --- a/include/event.h
> > > > > > +++ b/include/event.h
> > > > > > @@ -153,6 +153,14 @@ enum event_t {
> > > > > >        */
> > > > > >       EVT_MAIN_LOOP,
> > > > > >
> > > > > > +     /**
> > > > > > +      * @EVT_LMB_MAP_UPDATE:
> > > > > > +      * This event is triggered on an update to the LMB reserved memory
> > > > > > +      * region. This can be used to notify about any LMB memory allocation
> > > > > > +      * or freeing of memory having occurred.
> > > > > > +      */
> > > > > > +     EVT_LMB_MAP_UPDATE,
> > > > > > +
> > > > > >       /**
> > > > > >        * @EVT_COUNT:
> > > > > >        * This constants holds the maximum event number + 1 and is used when
> > > > > > @@ -203,6 +211,12 @@ union event_data {
> > > > > >               oftree tree;
> > > > > >               struct bootm_headers *images;
> > > > > >       } ft_fixup;
> > > > > > +
> > > > > > +     struct event_lmb_map_update {
> > > > > > +             u64 base;
> > > > > > +             u64 size;
> > > > > > +             u8 op;
> > > > > > +     } lmb_map;
> > > > > >   };
> > > > > >
> > > > > >   /**
> > > > >
