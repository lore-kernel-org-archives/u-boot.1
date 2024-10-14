Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F59D1813F
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 20:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13D0D8912A;
	Mon, 14 Oct 2024 22:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JiaCARrQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EF33890D1; Mon, 14 Oct 2024 22:20:11 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23E9789018
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 22:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cbce9e4598so31035226d6.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728937207; x=1729542007; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eGcnc1AHZ0Mr7EARLAbwwCExvgtJNbx0bPJjQWUIfs4=;
 b=JiaCARrQG54H2/BZ9ZvYeKwXiUwMJN8kmwahGplaHhiVKaunNPh3ROHidgV2p7izEJ
 zRqYJYfSbxdEqTXvqo/pDUN72FJijlHaIU3xk2str0fvfgh44IIHucwzYr6JOFPw2vbm
 PiMemww+WXWoOAg2P87F45bf6XDPoIVY62oGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728937207; x=1729542007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eGcnc1AHZ0Mr7EARLAbwwCExvgtJNbx0bPJjQWUIfs4=;
 b=JveHWz+pDUdsgCDEfGMUIwZyTmU5eFjaAOtIf2mrE2heG0VI6QPjGEf8VYxJHMRjeU
 DtBV9qMu/P+ONAzMk6qP/+BJCHgLndQQTbKOwAxe57rjpYiz41LFucMbpur3G4Fbib5N
 zLnsGvdeW+ICVzdLT4birE7IbTGnXsXY2Nxz1O+4+l0pEB/eMEL1ZAAuViNviqtKyyim
 nszrMDoUHUV/OcPBuEnXC+1j4MzopbWL7iNKz5OW5FxAVsm/pA/sOzOvgQikxd2mDl+d
 StpnuPlRdNq7U7ECMcpWTGCU78OGLbYH9ACqLqwsXudIfmjaA1yUBToxeKG6LJrxEyHB
 iKxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlf6deP7qSRbvA328qIMgxUCXfdhhdoswir8fLd9GcJ+zwX7a2oJa5d0EJWuWefGMEj8mkf6o=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6mRM1ym2UF5W2X7BaF4olGEmVsd9XBRrV5gSfS48lvuwi2Xxf
 6/gkRxiJlqNq3gFhwthMr4imRRM0wt7HcKUBcbfQE0DLq7PonbefvMRpq7/eOPIx9KDpqgla2JB
 7AyVI44pLqtyHnHI5wzYLKSmV64uZX2HQF5vx
X-Google-Smtp-Source: AGHT+IGpZe4Y5ff6YYfHg0uSSTp/f4QTrPUBLWtBOeAjLhgDGQIONeVbd+c8Ij6W3FSyohRj3xpGbwwkz47orxB84Rg=
X-Received: by 2002:a05:6214:4489:b0:6cb:ee38:1bf8 with SMTP id
 6a1803df08f44-6cbf9d1f81emr158976946d6.13.1728937206994; Mon, 14 Oct 2024
 13:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-5-sjg@chromium.org>
 <71ECC011-77EC-4308-AFE5-0E301BC27F84@gmx.de>
 <20241012012716.GE14210@bill-the-cat>
 <CAC_iWjL_YQ24ZecbN7oC-37PRR6iuUiiui-a0VPqSSVRunepdQ@mail.gmail.com>
In-Reply-To: <CAC_iWjL_YQ24ZecbN7oC-37PRR6iuUiiui-a0VPqSSVRunepdQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 14:19:56 -0600
Message-ID: <CAFLszTjzHBtR8vzk0wT-nNiwbsotqskVhVEX0ibh-Uea1+Da6Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] efi: Reserve some memory for initial use
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>
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

Hi,

On Fri, 11 Oct 2024 at 23:47, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Tom
>
> On Sat, 12 Oct 2024 at 04:27, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Oct 12, 2024 at 12:01:54AM +0200, Heinrich Schuchardt wrote:
> > >
> > >
> > > Am 11. Oktober 2024 23:21:25 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > > >The 'point of cooperation' is where U-Boot starts allowing EFI to use
> > > >memory outside of the U-Boot region. Until that point, it is desirable
> > > >to keep more below U-Boot free for loading images.
> > > >
> > > >Reserve a small region for this purpose.
> > >
> > > Your commit message provides no clue why this should be needed.

Yes, I hadn't realised that people didn't understand what I was
getting at. Tom asked the same question on irc.

It allows us to separate the lmb allocations from the EFI allocations,
so we don't need to have them both in sync. We use lmb for loading
images, then EFI takes over and does what it likes, respecting the
existing lmb reservations.

> >
> > The alternative here would be a patch to doc/develop/memory.rst saying
> > something to the effect of:
> >
> > EFI pool allocations start at ... U-Boot stack pointer +
> > CONFIG_STACK_SIZE and grow downwards from there. These are done by ... a
> > brief description of how the pool allocations work ... Nominally, this
> > will extend for only a few pages worth of memory but depending on
> > requests made by EFI applications can grow larger. All of this is
> > covered by the LMB that covers U-Boot itself and is considered part of
> > the U-Boot memory map. It may be broken down in to further detail to the
> > memory map provided to the OS, in some cases.
>
> I'll send a patch to update that next week. Perhaps even fold it in
> the LMB series

Before we know we are booting an EFI app? No, thank you. EFI should
not be growing downwards like a stack while U-Boot is running...

Regards,
SImon
