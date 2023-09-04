Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9A3C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:46:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38FDF86A3C;
	Mon,  4 Sep 2023 16:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mnGfK23m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6401C86A45; Mon,  4 Sep 2023 16:46:49 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B76D886A34
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-500a398cda5so2626203e87.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838806; x=1694443606; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u0EEnGvp0NJH+Qcu+jvl97IUEnY/JSh3kcdlemIiz6k=;
 b=mnGfK23mft2YS95fenOxcczR6Eu7ioYK0u4FfUU5r7u2baLTUxxI1FOlrxfGdAHgh6
 lb5wsGKnppi9xlu0Jk2GwIU0v2CAlaZy/F3B7tSJrCeDdo0y9+S9F0g6QwovQeF/pfGv
 QpSaaQfiuFZPje75g7N1QxwxbvYZKvR28r66w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838806; x=1694443606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u0EEnGvp0NJH+Qcu+jvl97IUEnY/JSh3kcdlemIiz6k=;
 b=jDg3scvcre0ygQBBxr8wEjXsdd1B/reAiPeHGi1YPe18u2f4c7JbAw2m3yfpvIDLrK
 XsbNKmkMTEQwQANO9ENcradFKa6UGhBBwGNaVri6aA2EVfpFYSK4b3EOHaNhr82ZZ8X9
 LorwMPMK/Ql77WMuSt8L9ukgCXwS+IOwBGo/UiV+GAlowLprE2PyJ3Kn+RRBndo2mVbh
 jZwAATlPHkd7PXkV/y61GL0l7JFrRtblfTssQ6MRxBm66seDWLtEgrCypo8YIn5UbLdJ
 poAmjnzrR8OSVhKM+veWdptabxW8/w9QtLQbxlDkWLRZjSA7CnxZXZmIAYx5Fv3XIgkh
 ZWQA==
X-Gm-Message-State: AOJu0YxJ3h4ohgmH/urB5iQKKxwESZS2S6B4yKhjbCNvhYYEdeqpU9Qe
 r5tCBm+hpQDJwv0kRzljMZN4HxAPzATDBhe903u/Rw==
X-Google-Smtp-Source: AGHT+IHAAmvkxcKYutRlshAGErF+HJ7ZnkEocWnC5yUVoUoYxJvYdjWoVXL2BxIz1PLpaOrHzNZ4dPHor9FfYc+xedM=
X-Received: by 2002:a05:6512:3c8a:b0:500:aec8:cac1 with SMTP id
 h10-20020a0565123c8a00b00500aec8cac1mr8831384lfv.26.1693838805697; Mon, 04
 Sep 2023 07:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230901011357.2482203-1-sjg@chromium.org>
 <20230901011357.2482203-3-sjg@chromium.org>
 <94edeb15-f260-4c88-9527-e58065a470f0@gmx.de>
 <CAPnjgZ1-YLz=SAqO962ih2trf+2HP8Dzuchwn9cjZju+BomLAg@mail.gmail.com>
In-Reply-To: <CAPnjgZ1-YLz=SAqO962ih2trf+2HP8Dzuchwn9cjZju+BomLAg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Sep 2023 08:46:34 -0600
Message-ID: <CAPnjgZ3W0iBbvF4yKjp6VRvn73b3P-5CFKSaYShD9OE+2r34wQ@mail.gmail.com>
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

On Fri, 1 Sept 2023 at 08:29, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Heinrich,
>
> On Fri, 1 Sept 2023 at 00:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 9/1/23 03:13, Simon Glass wrote:
> > > The lmb data structures use the word 'region' to describe the region in
> > > which the allocations happen, as well as the individual allocations in
> > > that region. The interior structure is called lmb_property but is
> > > described as a region.
> > >
> > > This is quite confusing. One of the reviewers in v1 asked why we are using
> > > a property to describe a region!
> >
> > We currently have:
> >
> > struct lmb_region - Description of a set of region.
> > struct lmb_property - Description of one region.
> >
> > The word 'region' implies that it is contiguous, while 'region set'
> > implies that its members might not be contiguous.
>
> From what I can tell, the areas inside a region are contiguous. The
> code is so badly commented that it is hard to know what the intent
> was.
>
> Actually I just looked it up and found it came from Linux, so I
> suppose that explains the lack of comments. There it has been renamed
> memblock.
>
> Could you take a look and see if we could adopt the same naming?

I am waiting for your thoughts on this one.

>
> >
> > Calling a set region is what starts the confusion.
> >
> > Your patch is creating new confusion by calling a member of "a set of
> > regions" "area".
> >
> > Please, rename as follows:
> >
> > lmb_region -> lmb_region_set
>
> That sounds like it sets a region
>
> > lmb_property -> lmb_region
> >
> > The comments below are only valid if you stick with area which I
> > strongly discourage.
>
> Fair enough, I don't like it much either.
>
[..]

Regards,
Simon
