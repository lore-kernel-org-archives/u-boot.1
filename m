Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A050CF9C7E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 12:58:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9969B88D6A;
	Thu, 26 Sep 2024 14:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rDIc+jTd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76B3388D66; Thu, 26 Sep 2024 14:58:51 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33113880F4
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20570b42f24so10067225ad.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 05:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727355528; x=1727960328; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FSRAiFNlUoWzniZzk3ij6rE1y0hZTPzQEJ66xcEEhY0=;
 b=rDIc+jTdm0LvWVSiCtxZgidajzg00Ykw3V0h+1yzpMW/8a6sYvtoQWiQ2hZjIHbYx6
 H9KAb+KsxD5C2G7S3BrcYOAA61Xme3zBkxIUKxdLD5JjQOSWvMRm7Y6crxRYJ+1w6Pnh
 v7f4bfov9xZl7jpTzlm5EluBQlS8wC8zsLcvy+FSYwpJ0Kd5qREvNnq9RrpK1LFN11rN
 M4miqsczCHptVk7DbKgb2labDvqMj0cI/Oop1c1mcOftRwBwgrxKWoE6PTLysIWA3bDX
 pV6m91Mx4kze+fE8mVdpoENV4Q/lTUbfgnyd8TDOKi0DsuZREeiDeWXDQRymGQaG3OxU
 U7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727355528; x=1727960328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FSRAiFNlUoWzniZzk3ij6rE1y0hZTPzQEJ66xcEEhY0=;
 b=q2iEQcyy36hJJgTX/beVDzcn3iBzhxgLFW1yJnsCnKVFYuClrNzeMAhGxSQ3MRvreU
 H3iAQBiKXnce1jwXsO2Nc4DdfS1qaSAY3Dmm/rpJogKgUle4yfbybDw5ZEZcKYtcSU0e
 MPWNRylUMcuD6U2dyJXqn0rF3xlX1aL3lSIJSw+fQHGRuNSvRq0YuyjYOp8jJACjLChy
 BtqLx9mIfWpMJqR9220se/6fKrMGWkEMYJtZAe2zyPavLgxIG/sSlsE800Q5Jz7off0t
 GqTtUQrf+OFk9NDtQmO8EBUwI6mdKnEhSYKn/rI+zqOyXPu9XhIUAMzv6quDTahABq8E
 ArYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWceT+YeRYa8rd/dAWhrFclsQsc8jSUjpGfP1PFx58alPeRmCp/XVgsgs9Y31d9UJ2X9CG/B1I=@lists.denx.de
X-Gm-Message-State: AOJu0Ywzf9HPBAPCCvRau5bR/tnrSi6TTXCKv+a+3Ld4YRvpK5RPc3BK
 /bbUrDrPIipNpNGG4zAOeZuSPoQbfr3uDa5nOxIb8ToYGi2f8jA6XJO7MvxkFLI/uUBJ+fU/MJS
 7G636rl41T07nWWzMBagg2CDBME0WT4+6lio9fg==
X-Google-Smtp-Source: AGHT+IHjS7OK0tEvnayMzqepV/fsC+AadrmWfvfZx1n4uAfQQ8xPVYP8UbTxJK4ZFNyq92LlqTXWeVmlidnkZ4Pyvcg=
X-Received: by 2002:a17:903:2352:b0:205:68a4:b2d8 with SMTP id
 d9443c01a7336-20afc4004demr89983605ad.11.1727355527685; Thu, 26 Sep 2024
 05:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-5-sughosh.ganu@linaro.org>
 <0291efc6-86a2-437c-938a-707c46c34f91@gmx.de>
In-Reply-To: <0291efc6-86a2-437c-938a-707c46c34f91@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Sep 2024 15:58:10 +0300
Message-ID: <CAC_iWjL4jHHfPA63x6hE4cxR9FLDvqkR+TYJh6-qwh3KTzmmcQ@mail.gmail.com>
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

On Sat, 14 Sept 2024 at 18:08, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 9/5/24 10:27, Sughosh Ganu wrote:
> > Add an event which would be used for notifying changes in the
> > LMB modules' memory map. This is to be used for having a
> > synchronous view of the memory that is currently in use, and that is
> > available for allocations.
>
> The synchronous view problem only exists because we are duplicating
> data. Store the EFI memory type in LMB and the problem vanishes.

We could, but I wonder if that would be enough.
Apart from the EFI memory types, we plan on fixing the EFI memory
attributes. I'll go read the spec again and take look at EDK2 but
IIRC, you can't correlate memory types to memory attributes (at least
not for all of them).

If that's true we'll also need the attributes in LMB + perhaps logic
for 64kb page size OSes and 4KB page firmware, which might be a bit
too much. In that case, I think the sync is fine, but I really don't
see the point of making an event out of it. Perhaps we could just
update the efi memory map directly from LMB.

Thanks
/Ilias
>
> The event is only needed to notify EFI_EVENT_GROUP_MEMORY_MAP_CHANGE.
>
> Best regards
>
> Heinrich
>
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   common/event.c  |  2 ++
> >   include/event.h | 14 ++++++++++++++
> >   2 files changed, 16 insertions(+)
> >
> > diff --git a/common/event.c b/common/event.c
> > index dda569d447..fc8002603c 100644
> > --- a/common/event.c
> > +++ b/common/event.c
> > @@ -48,6 +48,8 @@ const char *const type_name[] = {
> >
> >       /* main loop events */
> >       "main_loop",
> > +
> > +     "lmb_map_update",
> >   };
> >
> >   _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
> > diff --git a/include/event.h b/include/event.h
> > index fb353ad623..fce7e96170 100644
> > --- a/include/event.h
> > +++ b/include/event.h
> > @@ -153,6 +153,14 @@ enum event_t {
> >        */
> >       EVT_MAIN_LOOP,
> >
> > +     /**
> > +      * @EVT_LMB_MAP_UPDATE:
> > +      * This event is triggered on an update to the LMB reserved memory
> > +      * region. This can be used to notify about any LMB memory allocation
> > +      * or freeing of memory having occurred.
> > +      */
> > +     EVT_LMB_MAP_UPDATE,
> > +
> >       /**
> >        * @EVT_COUNT:
> >        * This constants holds the maximum event number + 1 and is used when
> > @@ -203,6 +211,12 @@ union event_data {
> >               oftree tree;
> >               struct bootm_headers *images;
> >       } ft_fixup;
> > +
> > +     struct event_lmb_map_update {
> > +             u64 base;
> > +             u64 size;
> > +             u8 op;
> > +     } lmb_map;
> >   };
> >
> >   /**
>
