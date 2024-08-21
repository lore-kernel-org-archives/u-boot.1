Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D259BC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 14:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 495D68843A;
	Wed, 21 Aug 2024 16:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xYb7RYCQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E37DC882BE; Wed, 21 Aug 2024 16:40:02 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9315C88B63
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 16:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5bec4e00978so6091014a12.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 07:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724251200; x=1724856000; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M5PFYdk7VZCbxPvJfdUaTzDipMsbOnOMs8nGbvsQO70=;
 b=xYb7RYCQFTczwrYzQLBJChyf769opz+3yzBYJ9URB4DjlRhVmufq53dLKwGvxkJvDb
 hEbOh49eF3a8MA4llZXmKJ4QSxtv52r4WYKJ1ZqccBPPtWMHsyq/i+NLUUlu5zc0xE8i
 DhENQmgpwn5uIh4p78w+AwkxcHV5//DXtNYoI108N3s8KvnDjcNkJ1A060z24sWI65sS
 Up9gy5Dp+2NnbH8taisaNCY2rzwhaS23U+B0oaPuqKux/DXLwyAWmMVCJ4EuEG7wtttL
 j4GwUzDUX2faFtHMYOK5x4KAKV7K6wv8yyYznDZ+hW3fxtNQZKnrq+6h9+95oDQBTtHk
 kPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724251200; x=1724856000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M5PFYdk7VZCbxPvJfdUaTzDipMsbOnOMs8nGbvsQO70=;
 b=k1px3VDUOZwuKfJNmQvvCmpTrkn4vbeU7ZkiBmwkEchPlye1EPArA2rxVLDJULf0zz
 FydXk9zN1FAhhwX/rvs569s7xWMMezZ1pX0LwBg5VJL79Ec3VlvzPlbzc95xT+VAmhx9
 ckpE0pDXKZx9nerZ1TO8eYhc6KOss0lQvjytEB/FikUL1Bdu/wuZc2uZYSn8PyK0FpfZ
 lhx47Y5xNSKatwk2t6fVxLGIn+fNMKNtjpN6O9w2RGyVi785J55wLmKbjHvZhgn2Wt4L
 AdeJSRBbBM+/nPqzSO/Q8aAYm37LdYp4wL4xDhBRXd/4GKGvHTCWIy1b+J93au92HtDx
 fJBA==
X-Gm-Message-State: AOJu0YyLtCpCYZKeAorzYmmTqM0Kpf/QAr0piyV6hTXJO3+H3SYMGgcs
 XZ+W52SEEY4TMVFif5C9gtD5W9QTjo+kuBaD2HhE3ywLgFrFQItNhP0gsR4NsJ1iO9mS3GmDnld
 2u+x8lTGZQt8hEZtEjbTuaDRNMFyA446nzH8aZg==
X-Google-Smtp-Source: AGHT+IFd88oHMdCbkpXx++44pNwK4YQGJC5V8GV04PQsdnNz8rNHhnndZWUAzGY7XgbpC38BR9P3oqZaAMlrjZMwl5w=
X-Received: by 2002:a05:6402:5107:b0:5a1:e7e6:ce37 with SMTP id
 4fb4d7f45d1cf-5bf1f2321abmr1547847a12.26.1724251199577; Wed, 21 Aug 2024
 07:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-15-sughosh.ganu@linaro.org>
 <CAFLszTjMwpW-MRWfJrOja2JGMcTtjYzLqH68hum=yDsXjc6PQQ@mail.gmail.com>
 <CADg8p95k_0CtqD5x8_jjW31YoPOoiLSvDU-M_JtcBU_+V-4hEg@mail.gmail.com>
 <CAFLszTji1FcHNitO+mKJ+uh-Kr5N33ZZjqZJx1Uaianj35Q4vQ@mail.gmail.com>
 <CADg8p94QuMpjP3fU0Rz7Y2gzpM=93RdxFxLM7c7DkpRtnkVL0A@mail.gmail.com>
 <CAFLszTg6CwCs8bQ7jUaJ0PDHnGvq3sg+0P-c4NTKxCN08OZAsQ@mail.gmail.com>
In-Reply-To: <CAFLszTg6CwCs8bQ7jUaJ0PDHnGvq3sg+0P-c4NTKxCN08OZAsQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 21 Aug 2024 20:09:48 +0530
Message-ID: <CADg8p96NKKO4yzLGxLzkQG_jgvaCcapif5MeCPVhL=O9BQ2QMw@mail.gmail.com>
Subject: Re: [PATCH v2 14/32] lmb: introduce a function to add memory to the
 lmb memory map
To: Simon Glass <sjg@chromium.org>
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

On Wed, 21 Aug 2024 at 19:30, Simon Glass <sjg@chromium.org> wrote:
>
> +Bin Meng
>
> Hi Sughosh,
>
> On Tue, 20 Aug 2024 at 23:29, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Wed, 21 Aug 2024 at 07:41, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Tue, 20 Aug 2024 at 02:17, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > On Fri, 16 Aug 2024 at 02:04, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Sughosh,
> > > > >
> > > > > On Wed, 14 Aug 2024 at 12:01, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > >
> > > > > > Introduce a function lmb_add_memory() to add available memory to the
> > > > > > LMB memory map. Call this function during board init once the LMB data
> > > > > > structures have been initialised.
> > > > > >
> > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > ---
> > > > > > Changes since V1:
> > > > > > * Call the lmb_add_memory() from lmb_init() instead of
> > > > > >   lmb_mem_regions_init().
> > > > > >
> > > > > >
> > > > > >  include/lmb.h | 10 ++++++++++
> > > > > >  lib/lmb.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
> > > > > >  2 files changed, 52 insertions(+)
> > > > > >
> > > > >
> > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > But this should not be weak.
> > > >
> > > > This is being made weak, as there would be lmb_add_memory()
> > > > definitions added for powerpc and x86 arch's in the EFI part of my
> > > > patches. Moreover, the lmb_add_memory() function would be called even
> > > > in the SPL stage when LMB is enabled for that stage. So I am not sure
> > > > how do we get around this. You can check the relevant branch [1] on my
> > > > github to check for the specific commits [2][3] that I am referring
> > > > to. Thanks.
> > >
> > > This is really strange.
> > >
> > > The e820 is different on each x86 board. I'm not sure we want that in
> > > the lmb. What is the purpose of that? It is somewhat circular in most
> > > cases, since U-Boot sets it up itself. Where it comes from coreboot,
> > > it looks like we are mirroring it in the EFI memory map. I'm not sure
> > > I understand all this very well.
> >
> > Yes, me neither. And I want to keep the behaviour same as before the
> > patches. You would know that the function efi_add_known_memory() gets
> > the memory map from a function install_e820_map() which includes
> > conventional memory, which is the ram memory. And I am basically now
> > doing this as part of the lmb_add_memory() function instead. Are you
> > sure that we can do away with this function, and instead use the
> > ram_base and ram_top values from the global data structure instead? I
> > believe you have boards which exercise this code? So it will be great
> > if you can test this if I remove the function for the e820 module.
>
> We are suffering here from too many ways to do the same thing and too
> much confusion about the overall goal here.
>
> Typically the e820 thing is created in U-Boot - see
> install_e820_map(). The ISA and PCI ranges needs to be added, so EFI
> needs a way to know to do that.
>
> e820 is used for the normal kernel boot flow - the table is passed
> directly to Linux.
>
> With EFI the kernel calls back into U-Boot to get the memory map, so
> we want to add the same reservations to the EFI tables.
>
> So I would favour having EFI sending an event before booting, to allow
> other code to add new reservations. Then we can let e820 do its thing
> and not affect EFI. In fact the e820 code will never be called on an
> EFI boot.
>
> I say we can clean this up later, so what you have here will do for now.
>
> >
> > >
> > > For fsl, perhaps copy the #ifdef and handle arch.resv_ram in your code?
> >
> > This is for adding ram to the lmb memory map, but yes, I can check by
> > putting an ifdef in the function. Although the function might look
> > ugly and hackish. Thanks.
>
> Again, we can clean this up date. It is just one arch doing strange things.

Can you please take a look at the branch[1] which I pointed to in my
earlier reply. I believe this caters to your review comment on doing
away with the weak function, as well as providing the option to boards
to define their own memory map. Thanks.

-sughosh

[1] - https://github.com/sughoshg/u-boot/tree/lmb_efi_sep_apis_nrfc_next_noweak_v3

>
> > >
> > > [..]
> > >
> > > > [1] - https://github.com/sughoshg/u-boot/tree/lmb_efi_sep_apis_nrfc_next_v3
> > > > [2] - https://github.com/u-boot/u-boot/commit/077ced7aaa6d495b1b87b324fb1c60658c203ce1
> > > > [3] - https://github.com/u-boot/u-boot/commit/d0fa3a89865b796f3bbebffebbe4f7b5b048c140
> > > >
>
> Regards,
> Simon
