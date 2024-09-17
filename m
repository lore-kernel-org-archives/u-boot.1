Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC319C35FFF
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 12:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD6C888E16;
	Tue, 17 Sep 2024 14:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SyTtHPrr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC74E88E08; Tue, 17 Sep 2024 14:33:40 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FD7F88E3B
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 14:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c3cdba33b0so7096577a12.1
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726576416; x=1727181216; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7YoVWjvoSSf16FWPmMwwlqRvetWNMxA7Ic9l+PLx60w=;
 b=SyTtHPrrAYM9cScZLg7dhv/sGj4liYKU4Z4cSAYnHsNN8QhZZCLnj8Du7dSrLDuf6Y
 4XHUxdyZwRmwBANA+pZKOsqxIUTXxRYyfX8loBWVSAUyUY+PxENElJNZTn1o+qquAUzf
 2Yxd+4KUho8JqC1bewida0Vla/V7R4pZ5a5PdpB3EHGt6pazZlyK+sVmAeaWFSeKvv3/
 loLLSicD0TCH4qjkL8/yVxFdTSBVJAMnvE45VpnsA6dasf9uNIRkIKM0yD4jgRtbMNGW
 E5oYYMWDymjJeon2NgB0wxiOmSflEJTEH6ul/3hkm2sBj7OTVT+QH7kDsRQ8N53QRt43
 1Xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726576416; x=1727181216;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7YoVWjvoSSf16FWPmMwwlqRvetWNMxA7Ic9l+PLx60w=;
 b=QcA0i5LaUmCfUTtkzaPYOiRaMmlYHUhMUQ7Q7YC58desNVuqplm0sJCOLdStvH+Rgh
 FmrtYTSM/rAlrCnfrX8g9DvBdcIqILKGzMOZ/NE3bn4e2fA3pB2KdgApaDxFIJ0TxZ5w
 M8CpkcXjAV2g6+UtxmNnVOrEfjcYyWAHb/xO237N7HIXj9m2FkQwy0CSvNtfbYJFVmIR
 1ye6WcRvTJEifit/La6hOKEZEYzjDEq0nw5ypozVi1hS2d18PTW1dRhFX6n0Jb6W5otx
 HpYnxLbWj38BagjuYhRA2xsxIWg6/h4h1WJOY3kpFWoe5kSwzC1+bbB4j+ig8q53ATDU
 4FlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAC1xxxh3iCb0bWzhk1ziFEZXV6iskLNqismtPAtCEUKo77Z3vwfZuidpwk1hBs9x99cI+dZc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0KDNcozdGeZFH0YknkJ6VH8JTJTrKzqpEj0n6RGq6UUE8jE3o
 ys4BQxFdgNYVxDs9nD/fYC+RToLrNlknfqsXjQE9AzJ75neJCXqJUQccx8JS32ZJe9Adddh3uNX
 8z594+IwGwHf8kT0S4LDRjntk6mThXtN8sOiobQ==
X-Google-Smtp-Source: AGHT+IGjSLPT88YODJGio7SWGuaAdTmVHTu/1cQd3KfYOHZuJqYdkb2isiMkjOQHRIII+mzk6HpwqGHtrVpzc2+zkg0=
X-Received: by 2002:aa7:d5c4:0:b0:5c2:6918:71cb with SMTP id
 4fb4d7f45d1cf-5c413e4faf7mr14861721a12.23.1726576416448; Tue, 17 Sep 2024
 05:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-5-sughosh.ganu@linaro.org>
 <0291efc6-86a2-437c-938a-707c46c34f91@gmx.de>
In-Reply-To: <0291efc6-86a2-437c-938a-707c46c34f91@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 17 Sep 2024 18:03:25 +0530
Message-ID: <CADg8p94TakJXkLs=m6RbvO2T_OmYagf68e4JV655TtQ5DnxtZg@mail.gmail.com>
Subject: Re: [PATCH 04/16] event: add event to notify lmb memory map changes
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
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

On Sat, 14 Sept 2024 at 20:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 9/5/24 10:27, Sughosh Ganu wrote:
> > Add an event which would be used for notifying changes in the
> > LMB modules' memory map. This is to be used for having a
> > synchronous view of the memory that is currently in use, and that is
> > available for allocations.
>
> The synchronous view problem only exists because we are duplicating
> data. Store the EFI memory type in LMB and the problem vanishes.

The LMB module only concerns itself with RAM memory. If I understand
correctly, you are proposing maintaining the EFI memory map within the
LMB module ? That would mean handling memory types other than
conventional memory in LMB.

-sughosh

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
