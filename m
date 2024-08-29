Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87612C83F27
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0485488C15;
	Thu, 29 Aug 2024 16:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CQlRvp2o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DE0988C2E; Thu, 29 Aug 2024 16:05:26 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97A0788C1B
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:05:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-201fba05363so5938485ad.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724940322; x=1725545122; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUIwpqpR0lAxddJyst40wd6eSJFQx9tVRlNvfprohF0=;
 b=CQlRvp2oisU4kuJqabt5ad9yW3RTbiXUIPzhCGyd/vPJ2+toL5XU0QDcIp7/iD9fUx
 /ZQk0ebAb9AzZOMbvl1bHwasefnwuS47ydIz+nnkCHu1JSwk5EhwJR0eEYSyE4RDm49/
 8LtwXfjqTcYddp2sy/uXcrnnALZE9kZgLLf08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724940322; x=1725545122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZUIwpqpR0lAxddJyst40wd6eSJFQx9tVRlNvfprohF0=;
 b=huivwNJwRzKVUh00zuzNd46doZA2gNAwmx6mlT64LpBOKKpZUie0WCGA3TapkI1Asd
 8KEIFDXI6ATAyvAvRwNZAoHxvVgBj8vNLVBzv/knsVOr3qkV5b467ck/mXSQCXa04gs9
 vjnv90SovOQGVa87WnUSfkYrpeg13wEOolcFevUXLrVLLSGYidhokLWruazBlmVtuL6M
 JAFBHzbYT7f84l4KGUAt1bXAcXT4BUEB1WDGnSwGFbu8lveUQSb5je+kPL8TCFfdeTZ7
 ROsUABgyNFXJKkGwRUVD4+nXWQ6jqfW0hntoIzl4+mFnfUU/b3BSZi72W9irggQmPT08
 Ks6Q==
X-Gm-Message-State: AOJu0Yw8yVIV4sWb7i7ZEjkRzwMnfpQXH7wvJ7uGt/nrGhdQUp4FU17Y
 VCUD8uz3lyMTwGnKCdXuXneDZyZ/P7ZkkAT+XkA/J3jFxdl9TREdGtDqFdqJvKQJ0KIwPwl1bRR
 JF6g5NqbjSvngdf9qT/mxHXIR795v6mlSeLek
X-Google-Smtp-Source: AGHT+IGTRTYd4jAXBuC4JxIlmjOLGrLvCsWZySm/2nu/txvpSTRmIWcqBBzhWZs/qGgYEo8iki0dCCr9Ob7b0CHOg9k=
X-Received: by 2002:a17:903:41c3:b0:202:3e52:e124 with SMTP id
 d9443c01a7336-2050c3a732fmr33762725ad.31.1724940321902; Thu, 29 Aug 2024
 07:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-15-sughosh.ganu@linaro.org>
 <CAFLszTjMwpW-MRWfJrOja2JGMcTtjYzLqH68hum=yDsXjc6PQQ@mail.gmail.com>
 <CADg8p95k_0CtqD5x8_jjW31YoPOoiLSvDU-M_JtcBU_+V-4hEg@mail.gmail.com>
 <CAFLszTji1FcHNitO+mKJ+uh-Kr5N33ZZjqZJx1Uaianj35Q4vQ@mail.gmail.com>
 <CADg8p94QuMpjP3fU0Rz7Y2gzpM=93RdxFxLM7c7DkpRtnkVL0A@mail.gmail.com>
 <CAFLszTg6CwCs8bQ7jUaJ0PDHnGvq3sg+0P-c4NTKxCN08OZAsQ@mail.gmail.com>
 <CADg8p96NKKO4yzLGxLzkQG_jgvaCcapif5MeCPVhL=O9BQ2QMw@mail.gmail.com>
In-Reply-To: <CADg8p96NKKO4yzLGxLzkQG_jgvaCcapif5MeCPVhL=O9BQ2QMw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 08:05:06 -0600
Message-ID: <CAFLszTjha7MzH+emoTXMr6MPTtSZAWDiuFGKwpUNZbb6DK08ow@mail.gmail.com>
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

Hi Sughosh,

On Wed, 21 Aug 2024 at 08:40, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Wed, 21 Aug 2024 at 19:30, Simon Glass <sjg@chromium.org> wrote:
> >
> > +Bin Meng
> >
> > Hi Sughosh,
> >
> > On Tue, 20 Aug 2024 at 23:29, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Wed, 21 Aug 2024 at 07:41, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Tue, 20 Aug 2024 at 02:17, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > On Fri, 16 Aug 2024 at 02:04, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Sughosh,
> > > > > >
> > > > > > On Wed, 14 Aug 2024 at 12:01, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > > >
> > > > > > > Introduce a function lmb_add_memory() to add available memory to the
> > > > > > > LMB memory map. Call this function during board init once the LMB data
> > > > > > > structures have been initialised.
> > > > > > >
> > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > ---
> > > > > > > Changes since V1:
> > > > > > > * Call the lmb_add_memory() from lmb_init() instead of
> > > > > > >   lmb_mem_regions_init().
> > > > > > >
> > > > > > >
> > > > > > >  include/lmb.h | 10 ++++++++++
> > > > > > >  lib/lmb.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
> > > > > > >  2 files changed, 52 insertions(+)
> > > > > > >
> > > > > >
> > > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > >
> > > > > > But this should not be weak.
> > > > >
> > > > > This is being made weak, as there would be lmb_add_memory()
> > > > > definitions added for powerpc and x86 arch's in the EFI part of my
> > > > > patches. Moreover, the lmb_add_memory() function would be called even
> > > > > in the SPL stage when LMB is enabled for that stage. So I am not sure
> > > > > how do we get around this. You can check the relevant branch [1] on my
> > > > > github to check for the specific commits [2][3] that I am referring
> > > > > to. Thanks.
> > > >
> > > > This is really strange.
> > > >
> > > > The e820 is different on each x86 board. I'm not sure we want that in
> > > > the lmb. What is the purpose of that? It is somewhat circular in most
> > > > cases, since U-Boot sets it up itself. Where it comes from coreboot,
> > > > it looks like we are mirroring it in the EFI memory map. I'm not sure
> > > > I understand all this very well.
> > >
> > > Yes, me neither. And I want to keep the behaviour same as before the
> > > patches. You would know that the function efi_add_known_memory() gets
> > > the memory map from a function install_e820_map() which includes
> > > conventional memory, which is the ram memory. And I am basically now
> > > doing this as part of the lmb_add_memory() function instead. Are you
> > > sure that we can do away with this function, and instead use the
> > > ram_base and ram_top values from the global data structure instead? I
> > > believe you have boards which exercise this code? So it will be great
> > > if you can test this if I remove the function for the e820 module.
> >
> > We are suffering here from too many ways to do the same thing and too
> > much confusion about the overall goal here.
> >
> > Typically the e820 thing is created in U-Boot - see
> > install_e820_map(). The ISA and PCI ranges needs to be added, so EFI
> > needs a way to know to do that.
> >
> > e820 is used for the normal kernel boot flow - the table is passed
> > directly to Linux.
> >
> > With EFI the kernel calls back into U-Boot to get the memory map, so
> > we want to add the same reservations to the EFI tables.
> >
> > So I would favour having EFI sending an event before booting, to allow
> > other code to add new reservations. Then we can let e820 do its thing
> > and not affect EFI. In fact the e820 code will never be called on an
> > EFI boot.
> >
> > I say we can clean this up later, so what you have here will do for now.
> >
> > >
> > > >
> > > > For fsl, perhaps copy the #ifdef and handle arch.resv_ram in your code?
> > >
> > > This is for adding ram to the lmb memory map, but yes, I can check by
> > > putting an ifdef in the function. Although the function might look
> > > ugly and hackish. Thanks.
> >
> > Again, we can clean this up date. It is just one arch doing strange things.
>
> Can you please take a look at the branch[1] which I pointed to in my
> earlier reply. I believe this caters to your review comment on doing
> away with the weak function, as well as providing the option to boards
> to define their own memory map. Thanks.

Yes your latest patch looks fine thank you.

Regards,
Simon



>
> -sughosh
>
> [1] - https://github.com/sughoshg/u-boot/tree/lmb_efi_sep_apis_nrfc_next_noweak_v3
>
> >
> > > >
> > > > [..]
> > > >
> > > > > [1] - https://github.com/sughoshg/u-boot/tree/lmb_efi_sep_apis_nrfc_next_v3
> > > > > [2] - https://github.com/u-boot/u-boot/commit/077ced7aaa6d495b1b87b324fb1c60658c203ce1
> > > > > [3] - https://github.com/u-boot/u-boot/commit/d0fa3a89865b796f3bbebffebbe4f7b5b048c140
> > > > >
> >
> > Regards,
> > Simon
