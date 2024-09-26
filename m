Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C301CDE006
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 13:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9289E88D72;
	Thu, 26 Sep 2024 15:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="McRf05FP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F9ED88D90; Thu, 26 Sep 2024 15:55:06 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC8688D3A
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20792913262so10236185ad.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727358902; x=1727963702; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QhM7vQL3IVDyVcC1jtBhx9FNs8xAMn9PEU7orbRn3u8=;
 b=McRf05FPqVAoiHduZ0KG4eh5JCU1CLNoR0rwk4PcVM2wZE8or5XQyWeK4zGsTK1HSP
 MZzXuiDweGwD1Rr50mMy6iok4lcM2EJac0uH9JjO195qjGO80NWsnWYGWH2vNOfi7V7i
 O9Zmq4UTElu/9i8sgOV2DAJofpOAhVcBOb22Jzd5s/SUFWB0saWLRziFoSGtHksU8LkL
 FWQmZe90fQbrHuG2dRU/on9p8ZF/GYtKnW1hZvHNRG2W+goch5DnTfezy6kylwqhg0mT
 oXkAiK5XElYLvH7hOsTGP9uz4T/lWe/AbHSXMdiCdTe+0eMA/6B3lgWUfJn6hs8g+ItO
 8qEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727358902; x=1727963702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QhM7vQL3IVDyVcC1jtBhx9FNs8xAMn9PEU7orbRn3u8=;
 b=GOyMrXI5LRiAsInkF2jkBHqF5LlUBB/19GxNanF6JYB5Fr43D5LUexULADE7a65MQS
 Uf2Jfn160PVyC6MjTMTebb5KGSRS0g6aP0kfLmtaXW45v9a1Z9K0mPYBzus9iJ5DJlfg
 bjAGfvY6kC0cwHeHbDSvj7aYl2MGHdP3EFVDBKaD5XU0L4d7/kvs5Clri2xKaUyIQxrI
 ByOHQDEn3Q6fFnp8n9Rgsc6e6YBd8y5dHbbaXF/VcVVvDp5I2AUVuyEI7l0YmNcSlRsy
 7lw7Y0RkHaboZ5Y/5JajaEhXETyWIs5wUYl90P1o2k/GCLJU3xazGJtwsGEHuog5+ST+
 wY0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGQo5rQ8gzuVW0rVjkq8D8qDzolLP+4QLUDvesg2r/QcwADwuV8cN9EgorStOwhulAksvOWOY=@lists.denx.de
X-Gm-Message-State: AOJu0YwLycoehPLugoJRx0PIj/jAYsGRW9+G7W/CqW2C/z42NdNRKBxH
 sV60iQKLqZTmIjPQOU73bUsXYt+sN6uWFERATKf7ryzmcqUI2WkOFvSyd0v7l06FuvuTwSBxFIY
 vQahWqG5vcZQUxJuSCnmsGZEhs0tye8fg/IWqNwfqfqg7DMgf
X-Google-Smtp-Source: AGHT+IHuUQ42nDNQ4w69n9S4kv4BO5kK7i2aTvV/94tmhZmr0wtt6YjskrXsNl17wjngAibgr8RFJtPrFEuRYOlKvYg=
X-Received: by 2002:a17:902:ccc3:b0:207:5ca3:8d23 with SMTP id
 d9443c01a7336-20afc6493bcmr100800495ad.59.1727358902107; Thu, 26 Sep 2024
 06:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-5-sughosh.ganu@linaro.org>
 <0291efc6-86a2-437c-938a-707c46c34f91@gmx.de>
 <CAC_iWjL4jHHfPA63x6hE4cxR9FLDvqkR+TYJh6-qwh3KTzmmcQ@mail.gmail.com>
 <66f42c2b-000e-4109-9899-9bf7568791ea@gmx.de>
In-Reply-To: <66f42c2b-000e-4109-9899-9bf7568791ea@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Sep 2024 16:54:25 +0300
Message-ID: <CAC_iWjLvwxnBhFwV3wKup4-FJCYRXBNy3W5fe_LbUb7waYzwTA@mail.gmail.com>
Subject: Re: [PATCH 04/16] event: add event to notify lmb memory map changes
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>, 
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

Hi Heinrich,

On Thu, 26 Sept 2024 at 16:19, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 26.09.24 14:58, Ilias Apalodimas wrote:
> > Hi Heinrich,
> >
> > On Sat, 14 Sept 2024 at 18:08, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 9/5/24 10:27, Sughosh Ganu wrote:
> >>> Add an event which would be used for notifying changes in the
> >>> LMB modules' memory map. This is to be used for having a
> >>> synchronous view of the memory that is currently in use, and that is
> >>> available for allocations.
> >>
> >> The synchronous view problem only exists because we are duplicating
> >> data. Store the EFI memory type in LMB and the problem vanishes.
> >
> > We could, but I wonder if that would be enough.
> > Apart from the EFI memory types, we plan on fixing the EFI memory
> > attributes. I'll go read the spec again and take look at EDK2 but
> > IIRC, you can't correlate memory types to memory attributes (at least
> > not for all of them).
> >
> > If that's true we'll also need the attributes in LMB + perhaps logic
> > for 64kb page size OSes and 4KB page firmware, which might be a bit
> > too much. In that case, I think the sync is fine, but I really don't
> > see the point of making an event out of it. Perhaps we could just
> > update the efi memory map directly from LMB.
>
> Yes, memory attributes should be stored in LMB too if UEFI is enabled.
>
> I would suggest:
>
> * GetMemoryMap() calls into LMB to generate the map on the fly.
> * The EFI_MEMORY_ATTRIBUTES_TABLE is generated from LMB information.
> * The EFI_MEMORY_ATTRIBUTE_PROTOCOL calls into LMB.
>
> Best regards
>
> Heinrich

That would work. TBH I do have a few doubts on how clean this is going
to be. It seems a bit cleaner to me atm to keep the efi memory map as
is. Especially if we get rid of the event.
Would it make sense to clean this up from the event and merge it close
to its current form? Then we could prototype what you suggest and send
an RFC to decide it it looks cleaner or not.

Thanks
/Ilias

>
> >
> > Thanks
> > /Ilias
> >>
> >> The event is only needed to notify EFI_EVENT_GROUP_MEMORY_MAP_CHANGE.
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >>>
> >>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >>> ---
> >>>    common/event.c  |  2 ++
> >>>    include/event.h | 14 ++++++++++++++
> >>>    2 files changed, 16 insertions(+)
> >>>
> >>> diff --git a/common/event.c b/common/event.c
> >>> index dda569d447..fc8002603c 100644
> >>> --- a/common/event.c
> >>> +++ b/common/event.c
> >>> @@ -48,6 +48,8 @@ const char *const type_name[] = {
> >>>
> >>>        /* main loop events */
> >>>        "main_loop",
> >>> +
> >>> +     "lmb_map_update",
> >>>    };
> >>>
> >>>    _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
> >>> diff --git a/include/event.h b/include/event.h
> >>> index fb353ad623..fce7e96170 100644
> >>> --- a/include/event.h
> >>> +++ b/include/event.h
> >>> @@ -153,6 +153,14 @@ enum event_t {
> >>>         */
> >>>        EVT_MAIN_LOOP,
> >>>
> >>> +     /**
> >>> +      * @EVT_LMB_MAP_UPDATE:
> >>> +      * This event is triggered on an update to the LMB reserved memory
> >>> +      * region. This can be used to notify about any LMB memory allocation
> >>> +      * or freeing of memory having occurred.
> >>> +      */
> >>> +     EVT_LMB_MAP_UPDATE,
> >>> +
> >>>        /**
> >>>         * @EVT_COUNT:
> >>>         * This constants holds the maximum event number + 1 and is used when
> >>> @@ -203,6 +211,12 @@ union event_data {
> >>>                oftree tree;
> >>>                struct bootm_headers *images;
> >>>        } ft_fixup;
> >>> +
> >>> +     struct event_lmb_map_update {
> >>> +             u64 base;
> >>> +             u64 size;
> >>> +             u8 op;
> >>> +     } lmb_map;
> >>>    };
> >>>
> >>>    /**
> >>
>
