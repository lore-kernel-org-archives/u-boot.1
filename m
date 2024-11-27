Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46661D6ACCD
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 13:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A699B897D6;
	Wed, 27 Nov 2024 14:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M+vM62ph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ED19897DF; Wed, 27 Nov 2024 14:08:40 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57873897D6
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5ceb03aadb1so8919009a12.0
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 05:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732712918; x=1733317718; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZHHqhmcSLkJiR1mj+K/Nn/YfM2qcc3bY0mMgKkkftXo=;
 b=M+vM62phPEw50TgzkkpOZtjYUDRi1EGq+Q9tYYSCBP+1lax8ueR7lPceo/QaJJlo44
 kYuEDmKyzgQzqSuwdXJtG5uxH1XOevXcWuj3QBAzvBifhrainvwZGrRBWpGVr7wOAX0t
 ubjoY+NDVufIDG3nhzFAv5uE0hutSqyCffDPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732712918; x=1733317718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZHHqhmcSLkJiR1mj+K/Nn/YfM2qcc3bY0mMgKkkftXo=;
 b=cPcFbYke79z05WAweRAIps/bwc7YcHKap7SKg4SzFPnVJASY5E9FO/oa6NwdYn9EO0
 /IJIS868V6HCMqnik0FZcI8+kQfahuxI3FDVuqKzeDqhEXsC6yYk5dHd/lNLFSmV6wG8
 G+GtvTtinxoIqJE4xXsLVwE+IFzjal59JyMcZ3qbrHNjFxAUZ4Xed0jzfkON04ZmXwBD
 ybTNn5Bdb5fid6M/SFIRcXIHui3OAi5oPcJPYlqAIwYnOTDDMGQNLXEeMb0rbwKwStNy
 jeVgN8zmXidJAYnK6a4NmFKV775SvcwUxmPQU20he5M7ybhFVGPY3RP6jp1I3cOi556i
 +yzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG/1YMwGl/7u6A6t2CzDkX+f26Vjm6pHoMZnXilnH/cM1rkKhP6J3qpxDZDZ1W0LAQCmp3bUg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyz8+nTGwlleqNzP+Rd2J2Iz7egI0SHfJoauSdJMU1vLmDrb4vi
 eHO0OPWLldnSrx3kzRFtsSjVYj4uq8h3zzCKhwv5fkSsWt6nLOGDJsOtdkfqUx1dtncsLqC2I4b
 zm1DqbNj+UffLk1yu4gv1dIrmS1ZFg6NjiMSGtPvo5LnmI1o=
X-Gm-Gg: ASbGncsqDGCSdJzvCs5T3XmKHYNMTzqinPtwCqu77jC0oCQlAyJpAxNLRJJx4gcYmu9
 zF3P4nIv+f/dPue6T3aP7/Bwa5w5geM4=
X-Google-Smtp-Source: AGHT+IEmC3FQfSt+GWF76Z92mj1NlqypycM3IgUjDJLj2wW0euJkMbv9IYB49uWWK40txXhYf1Gwavk96EmiMeYziJo=
X-Received: by 2002:a17:906:cd2:b0:aa5:2575:e75d with SMTP id
 a640c23a62f3a-aa580edfbd0mr192225866b.2.1732712917671; Wed, 27 Nov 2024
 05:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20241124183832.2476928-1-caleb.connolly@linaro.org>
 <CAFLszThqtA_WBxOU-EnEvw956ZMN9KErx_C4gTzW_+p_tGu9qw@mail.gmail.com>
 <cd43db10-4939-4958-97f2-9a2046d82160@linaro.org>
 <CAFLszTgEhfbk4ug=JoU_jTgdzSkF-fXuqamGmPJHpdogwocbRA@mail.gmail.com>
 <a8cd7895-7968-4ef9-bc5f-dd36c04d9db8@linaro.org>
In-Reply-To: <a8cd7895-7968-4ef9-bc5f-dd36c04d9db8@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Nov 2024 06:08:25 -0700
Message-ID: <CAFLszThuqGKt+j9y+JgPpwKYe-2f_MJ4DHh=wzWzOjWv715xUw@mail.gmail.com>
Subject: Re: [PATCH] common/board_f: init malloc earlier
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io,
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

Hi Caleb,

On Tue, 26 Nov 2024 at 09:15, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Simon,
>
> On 26/11/2024 16:38, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Tue, 26 Nov 2024 at 05:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 26/11/2024 01:32, Simon Glass wrote:
> >>> Hi Caleb,
> >>>
> >>> On Sun, 24 Nov 2024 at 11:38, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>>>
> >>>> Currently the early malloc initialisation is done partially in
> >>>> board_init_f_init_reserve() (on arm64 at least), which configures
> >>>> gd->malloc_base. But it isn't actually usable until initf_malloc() is
> >>>> called which doesn't happen until after fdtdec_setup().
> >>>>
> >>>> This causes problems in a few scenarios:
> >>>>
> >>>> 1. when using MULTI_DTB_FIT as this needs a working malloc (especially
> >>>>    for compressed FIT).
> >>>
> >>> Hmmm, how does this work today?
> >>
> >> I honestly have no idea, I assume boards that make use of it do some
> >> custom board_f.
> >
> > OK.
> >
> >>>
> >>>> 2. Some platforms may need to allocate memory as part of memory map
> >>>>    initialisation (e.g. Qualcomm will need this to parse the memory map
> >>>>    from SMEM).
> >>>
> >>> That really needs to be tidied up. When does this fixup need to be
> >>> done? I imagine it is somewhere prior to setup_dest_addr() ? Perhaps
> >>
> >> It's necessary in order to figure out gd->ram_base/ram_size. We do it in
> >> board_fdt_blob_setup() so that we can support another use-case where
> >> U-Boot has an internal FDT (which it should use) but the memory layout
> >> is provided via an external FDT which is unavailable (although this
> >> usecase isn't enabled upstream yet).
> >>
> >>> we could introduce an event to do 'memory map' stuff?
> >>
> >> We could, but considering that on most platforms the pre-relocation
> >> malloc is fixed at build time and at a known location relative to U-Boot
> >> there is no reason for us to arbitrary decide that some codepaths at the
> >> start of board_f aren't allowed to use malloc().
> >>
> >> Just moving the malloc initialization earlier ensures malloc() is
> >> consistently available and greatly simplifies things.
> >
> > I'd like to see a more generic solution to this problem...I think we
> > discussed this before?
>
> I think so. I'm not sure I follow with "more generic solution"?

Using an event to set the RAM location, rather than repurposing the
FDT-setup function.

> >
> > To my eye it looks like if we called an event in setup_dest_addr() we
> > could allow ram_base to be set.
>
> Right, it's possible/likely that we could clean up how mach-snapdragon
> currently does memory parsing.
>
> I do think this patch would still be justified even if we ignore the
> Qualcomm case.

It does put malloc() outside the purview of trace. There is always
going to be a race between which subsystem wants to be first and we
have certainly changed it several times. But until we have an actual
need, I think it is better to wait.

> >
> >>
> >> fwiw, I had another variation of this patch which dropped initf_malloc()
> >> entirely and just set up gd->malloc_limit/malloc_ptr in
> >> board_init_f_init_reserve() since that's where we set malloc_base
> >> anyways. But after digging some more there seem to be quite a few other
> >> entrypoints into U-Boot that don't go through
> >> board_init_f_init_reserve() (e.g. sandbox, EFI app) and it seemed more
> >> error prone to duplicate the implementation there.
> >
> > Fair enough.
> >
> > One more thing I notice in your board_fdt_blob_setup() implementation
> > in arch/arm/mach-snapdragon/board.c :
> >
> > It seems to be using either an built-in or external devicetree. It
> > seems that we should show this in dm_announce(), i.e. with the call to
> > fdtdec_get_srcname() ?
>
> Yes, the way it's implemented currently assumes that if CONFIG_OF_BOARD
> is set that we'd never use the built-in DT and mach-snapdragon doesn't
> fit this assumption. It's not a high priority but for sure something I'd
> like to see fixed.

I'm not even sure that assumption is right, actually...

[..]

REgards,
Simon
