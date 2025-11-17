Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971F1CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 18:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDB70838CE;
	Mon, 17 Nov 2025 19:16:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C2A6hKbZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 996E483BE1; Mon, 17 Nov 2025 19:16:10 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B56AF838A0
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 19:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-29555b384acso47509235ad.1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 10:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763403365; x=1764008165; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BemjsRx8ZgMWSLR1GjXbRgxmBYb4Gg34C8znYzBTKU0=;
 b=C2A6hKbZbH92fbk8927LY+ZgZjloERGngSv1H29v7APgx1C3PV7z2neAmlSAr/x/hB
 nlFb8IYLbw6scjdHbg0xUN0w+TfG+JExaxN+CrXXqvqdopyowJFFzEW0oCxNYGK7p2sT
 hVS0RNmilZ+AIJok87OGrdKiotyBsy3zHsY7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763403365; x=1764008165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BemjsRx8ZgMWSLR1GjXbRgxmBYb4Gg34C8znYzBTKU0=;
 b=T0yEfCJ6In/Pi8qBc7VVi96pyuGDFKeTQ7qhhaTwkp+T7qJ4d1/m7pBFI35o2jGUbK
 GQMj1x/7h5KkhCZ0L+pU7/DoxM4BtT/JiVqZbykGB2cvz6TCl8lx/OeWB6hKXRrHYGv4
 EvvgUEtr4rkn8K3Vu50p7cF5any/pBx88dQYrKZmO7cKL5FLqh0TioaPdssEyRZ+IF7k
 Tp5q9irYDJRE+4dB89zoqWYhivxgI1KFQwXhXWZCyN46Igh3Bns34ueiIciYvyhQzbi1
 DdG68jE/SRo1TnPS79MlK9plf/RoG0gnQVMaoNiNu6wTZnlpqDz1+6QuR7aEk+nKTZuL
 Qr3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4kr7IHy7xDoeRATePhCSTOCEYnHn5LR/K+6uTu3xtjSWgs32/3PCb1NNutO3QBcUr8in3wOY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7h6JLZbafs2pA/4YIYQKMhAJzL0Fs/ANBSexUnQsJ26bfpcTp
 HPk3JFp0elHxdFfZveF23KezdWeexhU1fHQ6defTNgKuzq4zK+WHiuQl8/yqr9iJ5aoXBSiT+tz
 K0viOtbft1yE+tGvOpHBVQqFMspPqQHe6PifsHhDJ
X-Gm-Gg: ASbGnctlY+w2Wl595FYtWCFgvk+c4KH1NrNIJ7SvC4zdcmPSjbSttM2WcyfP8i4NL5P
 aLRjHV7A26b+ixoEVHfjnuisu+Mk6kWK+lzlw7Z4DNlOzAMMiLKc4jUTBVR3nUNwHPPoMpePk3I
 KFxvcfPsmMVOUxjQTj0bPaPjLb/JG5m2QPaZcpsauewMDZ/VoQjhiJM5ppz/BkAGwP55RmXDhXm
 KQjVc83iC6rQCJFVfQ9I0h9TbSim5P+T1e+NFHqe4NBxulSZXmmjzrGwysra2XZ/SPc2stROHkY
 +77k
X-Google-Smtp-Source: AGHT+IGYle9XIM3VLCz3IWcqow36DpjI0zICnJX0V7AHxu96O5hag+HKZEQM5npBALOVW0EiHbH6b/Q4W0kTuWFXE7c=
X-Received: by 2002:a17:903:ac7:b0:295:557e:746a with SMTP id
 d9443c01a7336-2986a6d04femr131946085ad.13.1763403365021; Mon, 17 Nov 2025
 10:16:05 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTjwpoCwCKKvJX5cZMLK480EK-=BWaFd5A6yLMrfsVWC6g@mail.gmail.com>
 <20251113200527.GQ6688@bill-the-cat>
 <CAFLszTjydNqmo=6qLv--m4fB07QzWd01XHGY3hxgTEbarJF-VA@mail.gmail.com>
 <20251113203654.GR6688@bill-the-cat>
 <385cdc16-cf73-443b-a0a1-440e233d4506@mailbox.org>
 <CAFLszThc4YC6mKp5sNsiuCFfaMNqMWJjVV27d4UkyLU4rPWY6A@mail.gmail.com>
 <bed4a846-6356-463f-a8a9-3d4bf05439a4@mailbox.org>
 <CAFLszTiLZaMkCUxk2_x=gwKBxJeg-02iO-w=JufXEtqhqHZyTA@mail.gmail.com>
 <20251117142105.GG2125796@bill-the-cat>
 <CAFLszThiza12FcSeEVg3xWJcP1zZVrfxDgTDT4mZNfEUKvZpWQ@mail.gmail.com>
 <20251117180215.GL2125796@bill-the-cat>
In-Reply-To: <20251117180215.GL2125796@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Nov 2025 11:15:52 -0700
X-Gm-Features: AWmQ_bk6bKAkXm2iWoUBBtNmYMVYtS-J6L5huY1d-HbG2-HSt9tZf2e_JS8X1Gs
Message-ID: <CAFLszTgUgmDvX7hijZxQxJ-ArNquxHDrZVb7o7OfLOJA5+yc8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de, 
 Aaron Kling <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>, 
 George Chan <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>
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


On Mon, 17 Nov 2025 at 11:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Nov 17, 2025 at 10:04:00AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 17 Nov 2025 at 07:21, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Nov 16, 2025 at 09:07:19AM -0700, Simon Glass wrote:
> > > > Hi Marek,
> > > >
> > > > On Sat, 15 Nov 2025 at 17:20, Marek Vasut <marek.vasut@mailbox.org> wrote:
> > > > >
> > > > > On 11/14/25 1:45 PM, Simon Glass wrote:
> > > > >
> > > > > Hello Simon,
> > > > >
> > > > > >>>>> Which is different from disagreeing with your specific feedback about
> > > > > >>>>> how we get there, to be clear.
> > > > > >>>
> > > > > >>> And again, since your feedback to this patch was "Don't?", I'm saying we
> > > > > >>> need to. But the rest of your feedback was structural on moving towards
> > > > > >>> resolving it and so I assume Marek will respond.
> > > > > >>
> > > > > >> The "blast radius" are these patches, that's all that tripped the tests:
> > > > > >>
> > > > > >>    - boot: android: Always use 8-byte aligned DT with libfdt
> > > > > >>    - test/py: android: Point fdt command to aligned addresses
> > > > > >>    - test/py: Use aligned address for overlays in 'extension' test
> > > > > >>    - sandbox: Fix DT compiler address warnings in sandbox DTs
> > > > > >>    - sandbox: Fix DT compiler pin warnings in sandbox DTs
> > > > > >>    - boot: Assure FDT is always at 8-byte aligned address
> > > > > >>    - arm: qemu: Eliminate fdt_high and initrd_high misuse
> > > > > >>    - efi_loader: Assure fitImage from capsule is used from 8-byte aligned
> > > > > >> address
> > > > > >>    - MIPS: Assure end of U-Boot is at 8-byte aligned offset
> > > > > >>
> > > > > >> Regarding last minute alignment, the problem with this android image
> > > > > >> seems to be in the android image itself, which packs in badly aligned
> > > > > >> FDT. We therefore have to copy it out and realign.
> > > > > >
> > > > > > My request is to implement these checks as part of the boot flow
> > > > > > (bootm, etc.) rather than adding memory allocations in leaf function.
> > > > > > We already support copying the FDT to a different address so we can
> > > > > > expand it and add things. Can we make use of that code?
> > > > > It seems the 'abootomg' command is extracting DTB from a container where
> > > > > the DTB can be at 4-byte aligned address. Thus far, the command
> > > > > internally used that possibly 4-byte aligned address, which is wrong. It
> > > > > also returned that address which was used by further U-Boot commands
> > > > > as-is, which is also wrong.
> > > > >
> > > > > This DTB usage here has nothing to do with any boot flow, this is
> > > > > incorrect DTB alignment during manipulation, which is not part of boot.
> > > > >
> > > > > What exactly do you propose should be changed with this patch ?
> > > >
> > > > Actually this patch seems to adjust code which is just handling a
> > > > command. How about creating a common function which can put an FDT
> > > > into an abuf, either just using it in place, or allocating memory and
> > > > copying it? An abuf is ideal for this. E.g. something like (untested):
> > > >
> > > > /**
> > > >  * fdt_ensure_aligned() - Obtain an abuf with a devicetree, aligning if needed
> > > >  *
> > > >  * @buf: Returns abuf containing FDT on success; caller must abuf_uninit(buf)
> > > >  * @addr: Address of FDT
> > > >  * Return: 0 on success, -EINVAL if not an FDT, -ENOMEM if out of memory
> > > >  */
> > > > int fdt_ensure_aligned(struct abuf *buf, void *fdt)
> > > > {
> > > >    struct fdt_header fdth __aligned(8);
> > > >
> > > >    memcpy(&fdth, fdt, sizeof(struct fdt_header));
> > > >    if (fdt_check_header(&fdth) != 0)
> > > >       return -EINVAL;
> > > >
> > > >    abuf_init_const(buf, fdt, fdt_totalsize(&fdth));
> > > >
> > > >    /* The device tree must be at an 8-byte aligned address */
> > > >    if ((uintptr_t)fdt & 7) {
> > > >       void *fulldt;
> > > >
> > > >       // a function like abuf_realloc_align(struct abuf *buf, int
> > > > align) would help
> > > >       fulldt = memalign(8, buf->size);
> > > >       if (!fulldt)
> > > >          return -ENOMEM;
> > > >
> > > >       memcpy(fulldt, fdt, buf->size);
> > > >       buf->data = fulldt;
> > > >       buf->alloced = true;
> > > >    }
> > > >
> > > >    return 0;
> > > > }
> > > >
> > > > Then you can use this in various places as needed.
> > >
> > > That looks like massively more code than is needed to just ensure that
> > > the thing we deal with today is also correctly aligned? We don't need to
> > > pull abuf into everything.
> >
> > It is 27 lines of code, less than Marek's delta. Plus by the sounds of
> > it, we can call it from more than one place. I think it is better to
> > have a common function than to open-code this stuff in multiple
> > places. I also think separating out the map_sysmem() stuff would make
> > sense, since it is a bit convoluted at present.
> >
> > Re abuf I believe it is a useful abstraction and I wish I had thought
> > of it some years ago. It is particularly good when you may or may not
> > need to allocate something. Should we discuss abuf in one of the
> > U-Boot meetings?
>
> No, I think you've lost the thread on some of the problems
> unfortunately.

That might be a little too cryptic for me to understand. Which problems?

Regards,
Simon
