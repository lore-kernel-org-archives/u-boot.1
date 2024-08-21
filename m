Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6109C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 14:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C12288D96;
	Wed, 21 Aug 2024 16:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZaO3hYvI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C7CE88D9B; Wed, 21 Aug 2024 16:00:06 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4208B88D96
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 16:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6c159150ff4so3373516d6.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 07:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724248802; x=1724853602; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RiIHDipaSynYR1aQivjrzt1Z7AW3dv4OU1KQ7cUsBDw=;
 b=ZaO3hYvIkhZCi2qJ3dz0RL6rLxb/dwSCdTJCdLlzEC1bOoyjJ7lyxioQVGK17q4zQd
 zoGCyf6EWK/2iKBPXdxjnrhAJRXxqGN+VBwBsX0NV/Mu9WkX98juuKoNWlFO6ngTbMZF
 C9sB1x+Bo+JtZWWhWyGRQOkbomKXHhJKpULJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724248802; x=1724853602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RiIHDipaSynYR1aQivjrzt1Z7AW3dv4OU1KQ7cUsBDw=;
 b=Gtqil4OjoAXGyzS/w0Q9rf+i0smpTtbWM78euGRgdaGC0LNsJ2rNdCjbX0LrPBTK9U
 XTCqZXt4F0eJZxTq2t1hg2ohGpmz9H/XH/eg74UXiifTVHG4DmkTGbXO9Yr2eT+raomw
 h76JPhbfxWYSTZE0V9pz/jiOPlfaQJqP5kDA7fS1OheM1LPdtGdJhSh7/fHeJxHd9zOU
 LWIW9QTOclRZVIC+UwT28JpSjaLSRJarC6RXc03cJ+vcILX0cxjDegqti2DVxAJIqbz5
 ziM7+Nc2wE6S65t4xKyZZrkcRVP88VwGJqLWzpexQBzmWTZLMr/FqRdozmZjBHuz0hTo
 qljA==
X-Gm-Message-State: AOJu0Yy6yVh+5nLaGo9OebGTle1HEhtKyEuqNEjC/oLJnb9Mvo8Xp2PF
 5BERK2hs/AWnBu1lbBTeaBeIkAB8NJuDjIxP0M7aIUd73tabnZsDiyeHWxbhdbgKxAV/Dg8uiQH
 NdSxXbJlry/rUlWcvDXkB6fYR+5odbZCkJuH3
X-Google-Smtp-Source: AGHT+IF5nol4WxOD5USS/AbxIdlPUSZPAVpArhhq7Q5Xbj0+/9U0jewsYlNDSHDB+vLsy2XUeVPrVI73H2kaIeUVnCg=
X-Received: by 2002:a05:6214:5541:b0:6b2:b9c7:da6a with SMTP id
 6a1803df08f44-6c155df2af5mr34063506d6.41.1724248802016; Wed, 21 Aug 2024
 07:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-15-sughosh.ganu@linaro.org>
 <CAFLszTjMwpW-MRWfJrOja2JGMcTtjYzLqH68hum=yDsXjc6PQQ@mail.gmail.com>
 <CADg8p95k_0CtqD5x8_jjW31YoPOoiLSvDU-M_JtcBU_+V-4hEg@mail.gmail.com>
 <CAFLszTji1FcHNitO+mKJ+uh-Kr5N33ZZjqZJx1Uaianj35Q4vQ@mail.gmail.com>
 <CADg8p94QuMpjP3fU0Rz7Y2gzpM=93RdxFxLM7c7DkpRtnkVL0A@mail.gmail.com>
In-Reply-To: <CADg8p94QuMpjP3fU0Rz7Y2gzpM=93RdxFxLM7c7DkpRtnkVL0A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Aug 2024 07:59:50 -0600
Message-ID: <CAFLszTg6CwCs8bQ7jUaJ0PDHnGvq3sg+0P-c4NTKxCN08OZAsQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/32] lmb: introduce a function to add memory to the
 lmb memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
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

+Bin Meng

Hi Sughosh,

On Tue, 20 Aug 2024 at 23:29, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Wed, 21 Aug 2024 at 07:41, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Tue, 20 Aug 2024 at 02:17, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Fri, 16 Aug 2024 at 02:04, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Wed, 14 Aug 2024 at 12:01, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > Introduce a function lmb_add_memory() to add available memory to the
> > > > > LMB memory map. Call this function during board init once the LMB data
> > > > > structures have been initialised.
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > > Changes since V1:
> > > > > * Call the lmb_add_memory() from lmb_init() instead of
> > > > >   lmb_mem_regions_init().
> > > > >
> > > > >
> > > > >  include/lmb.h | 10 ++++++++++
> > > > >  lib/lmb.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
> > > > >  2 files changed, 52 insertions(+)
> > > > >
> > > >
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > But this should not be weak.
> > >
> > > This is being made weak, as there would be lmb_add_memory()
> > > definitions added for powerpc and x86 arch's in the EFI part of my
> > > patches. Moreover, the lmb_add_memory() function would be called even
> > > in the SPL stage when LMB is enabled for that stage. So I am not sure
> > > how do we get around this. You can check the relevant branch [1] on my
> > > github to check for the specific commits [2][3] that I am referring
> > > to. Thanks.
> >
> > This is really strange.
> >
> > The e820 is different on each x86 board. I'm not sure we want that in
> > the lmb. What is the purpose of that? It is somewhat circular in most
> > cases, since U-Boot sets it up itself. Where it comes from coreboot,
> > it looks like we are mirroring it in the EFI memory map. I'm not sure
> > I understand all this very well.
>
> Yes, me neither. And I want to keep the behaviour same as before the
> patches. You would know that the function efi_add_known_memory() gets
> the memory map from a function install_e820_map() which includes
> conventional memory, which is the ram memory. And I am basically now
> doing this as part of the lmb_add_memory() function instead. Are you
> sure that we can do away with this function, and instead use the
> ram_base and ram_top values from the global data structure instead? I
> believe you have boards which exercise this code? So it will be great
> if you can test this if I remove the function for the e820 module.

We are suffering here from too many ways to do the same thing and too
much confusion about the overall goal here.

Typically the e820 thing is created in U-Boot - see
install_e820_map(). The ISA and PCI ranges needs to be added, so EFI
needs a way to know to do that.

e820 is used for the normal kernel boot flow - the table is passed
directly to Linux.

With EFI the kernel calls back into U-Boot to get the memory map, so
we want to add the same reservations to the EFI tables.

So I would favour having EFI sending an event before booting, to allow
other code to add new reservations. Then we can let e820 do its thing
and not affect EFI. In fact the e820 code will never be called on an
EFI boot.

I say we can clean this up later, so what you have here will do for now.

>
> >
> > For fsl, perhaps copy the #ifdef and handle arch.resv_ram in your code?
>
> This is for adding ram to the lmb memory map, but yes, I can check by
> putting an ifdef in the function. Although the function might look
> ugly and hackish. Thanks.

Again, we can clean this up date. It is just one arch doing strange things.

> >
> > [..]
> >
> > > [1] - https://github.com/sughoshg/u-boot/tree/lmb_efi_sep_apis_nrfc_next_v3
> > > [2] - https://github.com/u-boot/u-boot/commit/077ced7aaa6d495b1b87b324fb1c60658c203ce1
> > > [3] - https://github.com/u-boot/u-boot/commit/d0fa3a89865b796f3bbebffebbe4f7b5b048c140
> > >

Regards,
Simon
