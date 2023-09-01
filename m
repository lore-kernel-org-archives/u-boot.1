Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3808DCA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 14:30:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 970A584698;
	Fri,  1 Sep 2023 16:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DNHkK0l5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5EDD847D3; Fri,  1 Sep 2023 16:30:00 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A921E84003
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 16:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50091b91a83so3501057e87.3
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693578597; x=1694183397; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+Lry9cP7CDphs0HV6TJftpVHhn92cOaEwENYpvWwtGI=;
 b=DNHkK0l5B/jUa+6vf1Zroqqx3BfqZvI++hxH72hWmuE5WCavTvWfj4epox6OofcPNy
 a6HLK58XP0BnFtgc9nySNPN6zU3MqvD/64y1droz2rfCb5TjbPfr2/Egp+yAQXoonlxA
 0SzpKG7AWS7naRW4+dNlPRSSVayg+nGhbwbBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693578597; x=1694183397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Lry9cP7CDphs0HV6TJftpVHhn92cOaEwENYpvWwtGI=;
 b=Yf6pWIGejp6rMnjSRP6Y7PgX8ZmnWm/Cp//dsE/0SxRA/kvL5xlyxCE7co84wX7kZe
 wPQqbJR3No+2cJ4xY45yGQs8yT/B9KEcHCkyfuVUJv8DuNCn8K3prcPW9I0W+TjgBIq+
 1eZ9YEhpPS7hVu4CdZor1JQv9YJYcNqMwZV/3CFPp0/kd4KY4XtBlJ9XP4TOUiyQE6Rd
 6CEmlaIkjdeIt389ZZMJKWip36enbqONKFRtjzUP1qsPdsgevlwyJIt904DAYk9JY3+a
 xPceZ9FTY0/RQL4naJrSKXxWvf933+uiNkTSDxAL3SuIENA32PX8lmhCtDUlNFi96XLd
 Exbw==
X-Gm-Message-State: AOJu0YwEOcSMTv07vhRc8X4p89hA0DPqJ8TVXvlGajpe3Ns+PiWmk1XP
 E8m4M517pJITT2KDusiWV2hJny30V6BsQ6Ro5H19ZQ==
X-Google-Smtp-Source: AGHT+IE/AQLC+qbubPqY+Ku8BTZwq1fqPIwoJiaIm7iaqToOtIO0l8EXY9qfKFVT4wMwDiOqChadl9URyiHAe8nV4FY=
X-Received: by 2002:a19:4315:0:b0:500:c010:2540 with SMTP id
 q21-20020a194315000000b00500c0102540mr1516543lfa.58.1693578596525; Fri, 01
 Sep 2023 07:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230901011357.2482203-1-sjg@chromium.org>
 <20230901011357.2482203-3-sjg@chromium.org>
 <94edeb15-f260-4c88-9527-e58065a470f0@gmx.de>
In-Reply-To: <94edeb15-f260-4c88-9527-e58065a470f0@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Sep 2023 08:29:37 -0600
Message-ID: <CAPnjgZ1-YLz=SAqO962ih2trf+2HP8Dzuchwn9cjZju+BomLAg@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] lmb: Rename interior piece to area
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
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

Hi Heinrich,

On Fri, 1 Sept 2023 at 00:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 9/1/23 03:13, Simon Glass wrote:
> > The lmb data structures use the word 'region' to describe the region in
> > which the allocations happen, as well as the individual allocations in
> > that region. The interior structure is called lmb_property but is
> > described as a region.
> >
> > This is quite confusing. One of the reviewers in v1 asked why we are using
> > a property to describe a region!
>
> We currently have:
>
> struct lmb_region - Description of a set of region.
> struct lmb_property - Description of one region.
>
> The word 'region' implies that it is contiguous, while 'region set'
> implies that its members might not be contiguous.

From what I can tell, the areas inside a region are contiguous. The
code is so badly commented that it is hard to know what the intent
was.

Actually I just looked it up and found it came from Linux, so I
suppose that explains the lack of comments. There it has been renamed
memblock.

Could you take a look and see if we could adopt the same naming?

>
> Calling a set region is what starts the confusion.
>
> Your patch is creating new confusion by calling a member of "a set of
> regions" "area".
>
> Please, rename as follows:
>
> lmb_region -> lmb_region_set

That sounds like it sets a region

> lmb_property -> lmb_region
>
> The comments below are only valid if you stick with area which I
> strongly discourage.

Fair enough, I don't like it much either.

>
> >
> > It seems better to adopt the word 'area' for the internal pieces, since an
> > area is smaller than a region.
> >
> > As a first step to improve this, rename struct lmb_property to lmb_area.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   include/lmb.h  | 12 ++++++------
> >   test/lib/lmb.c |  2 +-
> >   2 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/lmb.h b/include/lmb.h
> > index 231b68b27d91..4b7664f22c1d 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -23,13 +23,13 @@ enum lmb_flags {
> >   };
> >
> >   /**
> > - * struct lmb_property - Description of one region.
> > + * struct lmb_area - Description of one region.
>
> %s/region/memory area/
>
> For struct lmb_area we need a long text explaining what it describes.
>
> >    *
> >    * @base:   Base address of the region.
> >    * @size:   Size of the region
> >    * @flags:  memory region attributes
> >    */
> > -struct lmb_property {
> > +struct lmb_area {
> >       phys_addr_t base;
> >       phys_size_t size;
> >       enum lmb_flags flags;
> > @@ -64,9 +64,9 @@ struct lmb_region {
> >       unsigned long cnt;
> >       unsigned long max;
> >   #if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
>
> %s/MAX_REGIONS/MAX_AREAS/
>
> > -     struct lmb_property region[CONFIG_LMB_MAX_REGIONS];
> > +     struct lmb_area region[CONFIG_LMB_MAX_REGIONS];
>
> This is really confusing: An area called region and indexed by something
> related to regions not areas.
>
> >   #else
> > -     struct lmb_property *region;
> > +     struct lmb_area *region;
>
> ditto
>
> Best regards
>
> Heinrich
>
> >   #endif
> >   };
> >
> > @@ -87,8 +87,8 @@ struct lmb {
> >       struct lmb_region memory;
> >       struct lmb_region reserved;
> >   #if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> > -     struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGIONS];
> > -     struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
> > +     struct lmb_area memory_regions[CONFIG_LMB_MEMORY_REGIONS];
> > +     struct lmb_area reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
> >   #endif
> >   };
> >
> > diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> > index 162887503588..59b140fde4ce 100644
> > --- a/test/lib/lmb.c
> > +++ b/test/lib/lmb.c
> > @@ -12,7 +12,7 @@
> >   #include <test/test.h>
> >   #include <test/ut.h>
> >
> > -static inline bool lmb_is_nomap(struct lmb_property *m)
> > +static inline bool lmb_is_nomap(struct lmb_area *m)
> >   {
> >       return m->flags & LMB_NOMAP;
> >   }
>

Regards,
Simon
