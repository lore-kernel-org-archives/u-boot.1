Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45AECA0EED
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 14:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53F5F86E70;
	Tue, 12 Sep 2023 16:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="OIaKcgjr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9285486CC0; Tue, 12 Sep 2023 16:41:34 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C39B86E73
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 16:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4c0so12335620a12.0
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 07:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1694529689; x=1695134489; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LAkOngPf48B4PBhUiAYbgegoVzNL6sCv/HGKlrQNq84=;
 b=OIaKcgjrmCGtCbJw9KfOESPHTrCfk9fFRA9i4SlvPt93OCb0Zpgo/bPUCHji0hjQsO
 HhBQK/RzUtb7oNozmF0k/qkh0lsmCGLK7ddJMlSx/IlU7uZbPAEd6UNXxP18yvqPM+iw
 e1uazQn/15wLQLPnkcrmfgjTSE8BZVtGVB8XQzsveBvdrujvaNATpyGv00uv0Cp3VpG1
 tBrIvLsp54z/TKlm8S4otAkvCO6odCiiQY/A0hPeAURRXRjl65KHfBOGXs/eEGtKPIo1
 3svSxfdaPGoOXhVYXdghmMNNxPgL8udwVe1ktOVoDDj6mTtnF5md25QnH+nSF05nSt9A
 TBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694529689; x=1695134489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LAkOngPf48B4PBhUiAYbgegoVzNL6sCv/HGKlrQNq84=;
 b=LmF7uKyvMlaP6u5nIHRAnlQ9opz6qZowDz4HloMVw94+GaueFf/axeygLugg7z0UzZ
 kmUFy1EuyZQDYep6zqZOUd9711Te7ah4ebVAhfa4s5ZReEFYzULhl9jaQCSShEW6nTUx
 73QrNZ9PiQmDX36LCdCYh8Ih61NKeVYosO05Wr+HQgNUvh4GEN5zEJC7Eu2OMcOZGbsa
 di/lDoFLqQguVZZ354pViDsCMBVEwBWIFrBw3peyu7KTb8c3AgFJj06ZtLa1e6juXJR5
 znPKw7qrUqnv5vM9oR3LnXQ6KbBCMXBoVSJO9gmvVJoXUc/FxTJBpyfzYpSK1JlKMD7Z
 +u/g==
X-Gm-Message-State: AOJu0Yyi3omXPxWF/Nk0eNoB+CH6HWw+Zd5CJ/Gudq0PcJBLw7eAx/EA
 IPdx0SlXFHnZ/WUpaXG78hDQ7m/NYZ5NPu9Hq7ZlSA==
X-Google-Smtp-Source: AGHT+IHTuRV5mus+s2c8BwZfNm8vLnatvHNBQN+HNxLfZ4P66hbTZ9pJsDl1FVF8fF776YmzJGI+sL/BPIqesbFXlpo=
X-Received: by 2002:aa7:d992:0:b0:523:3e27:caa7 with SMTP id
 u18-20020aa7d992000000b005233e27caa7mr4165490eds.20.1694529689514; Tue, 12
 Sep 2023 07:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230906-apple_t6022_m2_ultra-v1-1-7d28623285bc@jannau.net>
 <CAPnjgZ0aDxNsqKzWcTDOq++4vC4j_VRQNqC0=LiL3As0d0H7Bg@mail.gmail.com>
 <87r0n4foeq.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87r0n4foeq.fsf@bloch.sibelius.xs4all.nl>
From: Simon Glass <sjg@google.com>
Date: Tue, 12 Sep 2023 08:41:10 -0600
Message-ID: <CAPnjgZ3D9Q_tSR1hvMLDr9mE-2WzXs2yP6TgVg+3nF1PXVci=A@mail.gmail.com>
Subject: Re: [PATCH] arm: apple: Add initial Apple M2 Ultra support
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: j@jannau.net, kettenis@openbsd.org, trini@konsulko.com, 
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

Hi Mark,

On Mon, 11 Sept 2023 at 14:25, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Simon Glass <sjg@google.com>
> > Date: Sun, 10 Sep 2023 16:36:48 -0600
> >
> > Hi,
> >
> > On Wed, 6 Sept 2023 at 15:50, Janne Grunau <j@jannau.net> wrote:
> > >
> > > Apple's M2 Ultra SoC are somewhat similar to the M1 Ultra but needs
> > > a tweaked memory map as the M2 Pro/Max SoCs.  USB, NVMe, UART, WDT
> > > and PCIe are working with the existing drivers.
> > >
> > > Signed-off-by: Janne Grunau <j@jannau.net>
> > > ---
> > >  arch/arm/mach-apple/board.c | 183 ++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 183 insertions(+)
> > >
> > > diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> > > index d50194811843..47393babbc62 100644
> > > --- a/arch/arm/mach-apple/board.c
> > > +++ b/arch/arm/mach-apple/board.c
> > > @@ -444,6 +444,187 @@ static struct mm_region t6020_mem_map[] = {
> > >         }
> > >  };
> > >
> > > +/* Apple M2 Ultra */
> > > +
> > > +static struct mm_region t6022_mem_map[] = {
> > > +       {
> > > +               /* I/O */
> > > +               .virt = 0x280000000,
> > > +               .phys = 0x280000000,
> > > +               .size = SZ_1G,
> > > +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> > > +                        PTE_BLOCK_NON_SHARE |
> > > +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> > > +       }, {
> >
> > Is there no devicetree binding for this information?
>
> Not directly.  The device tree does contain the addresses of the
> devices of course.  But what we want here is a memory map that uses a
> few big ranges that cover all the devices in the device tree rather
> than lots of small ranges that cover the individual devices.

OK I see.

>
> But yes, it sucks that every time Apple produces a new SoC we need to
> add another memory map.

Regards,
Simon
