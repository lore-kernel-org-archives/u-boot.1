Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B3CC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 20:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC97A88C19;
	Wed,  7 Aug 2024 22:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nk6q9ADq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 300AD88C1C; Wed,  7 Aug 2024 22:53:51 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E52A388113
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 22:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-70930f8eabbso96252a34.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 13:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723064027; x=1723668827; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e+zquPoBIU3vsQ7u8SEDzL7XNOtxEXxO2sGRNqS5IA4=;
 b=nk6q9ADqnfERcbnzvezRjUkcQtfyD086JYn+Q7L0MyOOE0CZBycHAbC5gbDMhm9Zq6
 +QxDcLGIJboNRtrUonNxVOPKBm+Pasrit8OhMR/dtSv9TTBS5DnuMHbht6afmlTTDsaj
 TCLGY6fba6mvDGwMd+C46fVLOt/zoMEZ6eJwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723064027; x=1723668827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e+zquPoBIU3vsQ7u8SEDzL7XNOtxEXxO2sGRNqS5IA4=;
 b=CrrLEpmioPoGH8dJxUcpldzidgVBp22JRfsS51u2QE4Xz6AcaAR40DPhr+/Bpnem/M
 DufiLrIbbzMWOKxzEtDB+f/HebvO5I7hYU8lcmLoz6cZZavSsYv8ueH6GftT034znKau
 Rw3cqMg1pN5j53EacP+keCHBvxSK6vZp2kR6NOYcFY8yWHG0j9R92FA68FF/qWjHFu1Z
 sDzjANdSF+AhcaGcOvPmOk3+9kfFZ8pfqK8h0AJM9MLGKkZsVacw9LxUNuNqMag8YB1j
 A+Gdy3uAyXh1zVIYhiwcmzJr1epfubruZA8WLZu2IQeisfpTuCXwFnfb5XOcYxrkJRUa
 hW/Q==
X-Gm-Message-State: AOJu0Yx5/1g2H0Yhb/wHar4IRSiZhhbHDGqm9HdvAU6DN4UAn5itXxQK
 KZ+xozpMtCapuXI386s4Xyo4mLuXtNo4bUcLoZhdMaqSSsxHB30YH0fhnQ2oBbPnmsYrUIwLXSB
 yaOn3BpRqEgbB6Fj99WK9ZZuKXmlvydPSlG7T
X-Google-Smtp-Source: AGHT+IHi0hWKcXUKbOp+aVHIvuM+59ShaAfEgrE0I6q/sz3RzePdrhfWMir8XIE22UR3HgP4VDwVt4xGf3oSRrU/+D8=
X-Received: by 2002:a05:6830:6f04:b0:709:472d:f35a with SMTP id
 46e09a7af769-709b31fef99mr26115720a34.2.1723064027649; Wed, 07 Aug 2024
 13:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240806120659.686073-1-prasad.kummari@amd.com>
 <CAFLszTgAiRBih1JOtqvBEi8QbVc4-yV7Mq3kam=_FRgw58mtjg@mail.gmail.com>
 <SJ0PR12MB66851EC7FDDD9A61A63E4DE982B82@SJ0PR12MB6685.namprd12.prod.outlook.com>
 <CAFLszTg9VemEeiHkOzh+jnQ84y34V3A+EPU2_YaOJgZwhn=7GQ@mail.gmail.com>
 <SJ0PR12MB668508ED115E8ED8DB3CF57582B82@SJ0PR12MB6685.namprd12.prod.outlook.com>
In-Reply-To: <SJ0PR12MB668508ED115E8ED8DB3CF57582B82@SJ0PR12MB6685.namprd12.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Aug 2024 14:53:37 -0600
Message-ID: <CAFLszTjKnZoz2GYkrELYzzgZX90xjijKcXUXh_GbQtYe-ZK_gg@mail.gmail.com>
Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
To: "Kummari, Prasad" <Prasad.Kummari@amd.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "git (AMD-Xilinx)" <git@amd.com>, 
 "Simek, Michal" <michal.simek@amd.com>, "Abbarapu,
 Venkatesh" <venkatesh.abbarapu@amd.com>, 
 "git@xilinx.com" <git@xilinx.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, 
 "n-francis@ti.com" <n-francis@ti.com>, "d-gole@ti.com" <d-gole@ti.com>
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

Hi Prasad,

On Wed, 7 Aug 2024 at 08:46, Kummari, Prasad <Prasad.Kummari@amd.com> wrote:
>
> Hi Simon,
>
> > -----Original Message-----
> > From: Simon Glass <sjg@chromium.org>
> > Sent: Wednesday, August 7, 2024 8:06 PM
> > To: Kummari, Prasad <Prasad.Kummari@amd.com>
> > Cc: u-boot@lists.denx.de; git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> > <michal.simek@amd.com>; Abbarapu, Venkatesh
> > <venkatesh.abbarapu@amd.com>; git@xilinx.com;
> > jagan@amarulasolutions.com; n-francis@ti.com; d-gole@ti.com
> > Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > Hi Prasad,
> >
> > On Tue, 6 Aug 2024 at 23:05, Kummari, Prasad <Prasad.Kummari@amd.com> wrote:
> > >
> > > Hi Glass,
> > >
> > > > -----Original Message-----
> > > > From: Simon Glass <sjg@chromium.org>
> > > > Sent: Wednesday, August 7, 2024 3:21 AM
> > > > To: Kummari, Prasad <Prasad.Kummari@amd.com>
> > > > Cc: u-boot@lists.denx.de; git (AMD-Xilinx)
> > <git@amd.com>; Simek,
> > > > Michal <michal.simek@amd.com>; Abbarapu,
> > Venkatesh
> > > > <venkatesh.abbarapu@amd.com>; git@xilinx.com;
> > > > jagan@amarulasolutions.com; n-francis@ti.com; d-gole@ti.com
> > > > Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved
> > > > memory
> > > >
> > > > Caution: This message originated from an External Source. Use proper
> > > > caution when opening attachments, clicking links, or responding.
> > > >
> > > >
> > > > Hi Prasad,
> > > >
> > > > On Tue, 6 Aug 2024 at 06:08, Prasad Kummari <prasad.kummari@amd.com> wrote:
> > > > >
> > > > > Added LMB API to prevent SF command from overwriting reserved
> > > > > memory areas. The current SPI code does not use LMB APIs for
> > > > > loading data into memory addresses. To resolve this, LMB APIs were
> > > > > added to check the load address of an SF command and ensure it
> > > > > does not overwrite reserved memory addresses. Similar checks are
> > > > > used in TFTP, serial load, and boot code to prevent overwriting reserved
> > memory.
> > > >
> > > > The SPI flash may be used to load other things, not just an OS. What
> > > > is your use case or problem here?
> > >
> > > [Prasad]:  We have observed that SF command can overwrite the reserved
> > area without throwing any errors or warnings.
> > >  This issue was noticed when the TF-A area is reserved in the Device
> > > Tree at address 0xf000000. The sf command is  corrupting the reserved
> > area,  and U-Boot relocation address too.
> > >
> > > EX: TF-A reserved at ddr address 0xf000000
> > >
> > >       Versal NET> sf read 0x0f000000 0x0 0x100     ----> Overwriting reserved
> > area.
> > >       device 0 offset 0x0, size 0x100
> > >       SF: 256 bytes @ 0x0 Read: OK
> > >
> > >      U-boot relocation address relocaddr   = 0x000000007fec2000
> > >
> > >       Versal NET> sf write 0x0000000077ec2000 0x0 0x100   --> Overwriting
> > reserved area.
> > >       device 0 offset 0x0, size 0x100
> > >       SF: 256 bytes @ 0x0 Written: OK
> >
> > Yes. There are many things which can overwrite memory, e.g. the mw
> > command. It is a boot loader so this is normal.
> >
> > What image are you loading here?
>
> [Prasad] : We are loading TF-A(bl31.elf) at ddr address 0xf000000.

I mean what image are you loading which overwrites TF-A?

Regards,
Simon
