Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B184CCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CE3286F14;
	Fri, 13 Oct 2023 18:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="cSAO3rNE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B3A86F1B; Fri, 13 Oct 2023 18:58:20 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C8E486B95
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a7eef0b931so29053857b3.0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697216293; x=1697821093; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u3K+YbABNUAl6+/cSLMT5/lC+SfRKudOMBfcL9udcps=;
 b=cSAO3rNEM/TjW8JWgrwvfnMc5FWN6a4RBVqJ6N4R0HnWEC0kxWdt5vhHbBALJoHGhh
 hjUX4am+0WPwxaGmbI40WmvPLPdbttrEWmOa5BrMKGcmE68bH/ac3RD5OC6EpAF5Ieoa
 0TbyxIdrmdtW/4hyAKURyvoTeQi3vUoC4kx0RSUQvWkixESjUYtDb5nhclXWJFK6WHLl
 4rozzARbgRKcsRk0S1xnpkqEcjNwQrKu+xCam/1s1S6qgnnjJcplyxKw0BDTc2he1biP
 bQlDjWv85HDXyxVXZNOzvlBWasU3/GSTvofsOOBGERrM6+ST2EGUfx97IuSFJrWEVoHK
 1gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697216293; x=1697821093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u3K+YbABNUAl6+/cSLMT5/lC+SfRKudOMBfcL9udcps=;
 b=pdWu8M1fqE6amJ0LSZ7LwEkLSPZd/fFoQVae8EQ/8nOvHCbRoqrReKgjNMh0r1zgMM
 Nbhw3cfeJAxDg9H4V0UN1yBo8mPkHw4eIOaVqxkvAyDL1F/CkhzGkTxzaDgqgPceutdw
 w72VYM6VP6/Xd9mFWA/xYxBg52zQtOD62GYvy65RnvUwh/dglOEa2vwWMzSOVw2U7QIf
 roR4crfLET+S84CUQBGaSguNIPD0snPNyAAABmnw9X/mfxvGfbnNEwayvrbD3NEkGXli
 56WMh4IZw11ZawJtwSNRf/2NZ0po1aZ3trKXKPL7ONec46KbMxZjRAdoc1n7H1oAIV+h
 uRmQ==
X-Gm-Message-State: AOJu0YxJz7L6rx7hcJcnZdhp05aYqiXrXi2xEOh7ZUC1x3VRMU43dKPU
 alCotnpCI7qQbpyi+eEpcB38QQEqM4PXRJcaZmTDs9OohQFJ13Eus24=
X-Google-Smtp-Source: AGHT+IEHC5JySGSbbM1oHoo8iLZE566YMBy3AdXG/FmG9p5Kr3//wRL/XuO/l/kAe5K4wA6LZtfHR+IA0xZFdKXx/5g=
X-Received: by 2002:a81:9255:0:b0:5a7:af97:c787 with SMTP id
 j82-20020a819255000000b005a7af97c787mr13589145ywg.11.1697216292722; Fri, 13
 Oct 2023 09:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231012230359.2005249-1-trini@konsulko.com>
 <20231012230359.2005249-4-trini@konsulko.com>
 <CAPnjgZ1cSJNXZTdRu3LG_Ojo6t_93s+yRfTAoKi+YkJg7_LdFw@mail.gmail.com>
 <20231013151705.GL3119521@bill-the-cat>
In-Reply-To: <20231013151705.GL3119521@bill-the-cat>
From: Simon Glass <sjg@google.com>
Date: Fri, 13 Oct 2023 09:57:32 -0700
Message-ID: <CAPnjgZ1XbnjDQqX49GSvuo7y3mU6Vuq5ghFKp9sAmzATVKD1zw@mail.gmail.com>
Subject: Re: [PATCH 4/7] m68k: Remove common.h usage
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Angelo Dureghello <angelo@kernel-space.org>
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

Hi Tom,

On Fri, 13 Oct 2023 at 08:17, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 13, 2023 at 08:14:57AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 12 Oct 2023 at 16:11, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > We can remove common.h from most cases of the code here, and only a few
> > > places need an additional header instead.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Cc: Angelo Dureghello <angelo@kernel-space.org>
> > > ---
> > >  arch/m68k/cpu/mcf523x/cpu.c         | 1 -
> > >  arch/m68k/cpu/mcf523x/cpu_init.c    | 1 -
> > >  arch/m68k/cpu/mcf523x/interrupts.c  | 1 -
> > >  arch/m68k/cpu/mcf523x/speed.c       | 1 -
> > >  arch/m68k/cpu/mcf52x2/cpu.c         | 1 -
> > >  arch/m68k/cpu/mcf52x2/cpu_init.c    | 3 +--
> > >  arch/m68k/cpu/mcf52x2/interrupts.c  | 1 -
> > >  arch/m68k/cpu/mcf52x2/speed.c       | 1 -
> > >  arch/m68k/cpu/mcf530x/cpu.c         | 1 -
> > >  arch/m68k/cpu/mcf530x/cpu_init.c    | 1 -
> > >  arch/m68k/cpu/mcf530x/interrupts.c  | 1 -
> > >  arch/m68k/cpu/mcf530x/speed.c       | 1 -
> > >  arch/m68k/cpu/mcf532x/cpu.c         | 1 -
> > >  arch/m68k/cpu/mcf532x/cpu_init.c    | 1 -
> > >  arch/m68k/cpu/mcf532x/interrupts.c  | 1 -
> > >  arch/m68k/cpu/mcf532x/speed.c       | 1 -
> > >  arch/m68k/cpu/mcf5445x/cpu.c        | 1 -
> > >  arch/m68k/cpu/mcf5445x/cpu_init.c   | 1 -
> > >  arch/m68k/cpu/mcf5445x/dspi.c       | 1 -
> > >  arch/m68k/cpu/mcf5445x/interrupts.c | 1 -
> > >  arch/m68k/cpu/mcf5445x/speed.c      | 1 -
> > >  arch/m68k/cpu/mcf5445x/start.S      | 1 -
> > >  arch/m68k/include/asm/immap.h       | 1 +
> > >  arch/m68k/include/asm/immap_520x.h  | 1 +
> > >  arch/m68k/include/asm/immap_5235.h  | 1 +
> > >  arch/m68k/include/asm/immap_5272.h  | 1 +
> > >  arch/m68k/include/asm/immap_5275.h  | 1 +
> > >  arch/m68k/include/asm/immap_5282.h  | 1 +
> > >  arch/m68k/include/asm/immap_5301x.h | 1 +
> > >  arch/m68k/include/asm/immap_5307.h  | 2 ++
> > >  arch/m68k/include/asm/immap_5329.h  | 1 +
> > >  arch/m68k/include/asm/immap_5441x.h | 1 +
> > >  arch/m68k/lib/bdinfo.c              | 3 ++-
> > >  arch/m68k/lib/bootm.c               | 1 -
> > >  arch/m68k/lib/cache.c               | 2 +-
> > >  arch/m68k/lib/fec.c                 | 2 +-
> > >  arch/m68k/lib/interrupts.c          | 2 +-
> > >  arch/m68k/lib/time.c                | 1 -
> > >  arch/m68k/lib/traps.c               | 1 -
> > >  39 files changed, 17 insertions(+), 30 deletions(-)
> >
> > I just wondered what we do about '#ifdef CFG_...' which presumably is
> > not included without common.h ? How does that work?
>
> The first header in common.h is config.h which is where many CFG_...
> instances are.

OK, so that comes later...

Regards,
Simon
