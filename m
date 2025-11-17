Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389D8CE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 17:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F8C83BE1;
	Mon, 17 Nov 2025 18:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OCRr0j0c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 701F083BEB; Mon, 17 Nov 2025 18:04:16 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58A6683B9D
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 18:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-640860f97b5so7349187a12.2
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 09:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763399054; x=1764003854; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fLUJFyyAgHy0N8keiwpEMZcW36VLlhbeZLHmC6E23CI=;
 b=OCRr0j0cJJXxpealpfb+m/YVrSF4raFyfxx8rgbyagpaKIhd6N1fVC6BMnjZd040dJ
 YKgsib4LUz6DQDdvYg8YdMW96KKPLsfkLejI7riJRIn0obZH1kgyHVQOeyCcw8ZwKgcb
 nAPYUQFOp5qkLp5MwFq2akloyXmE0S74+wbZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763399054; x=1764003854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLUJFyyAgHy0N8keiwpEMZcW36VLlhbeZLHmC6E23CI=;
 b=X9fPqWsSXadcRKNztaWU4A2iDS26imcfF1iX68b78s18xbIAXVsQ+T8YQ9yMNmtjS5
 U/J4EHn5dLLb9PEIJaQIf2dOSUw7+WDY/tYgdJuGiQEkLiNS7MNcYiDEYm84zdNViG7G
 51gb34BMlrBI2Hgl/Ach2LlhG7ue1YfO9C6LCX/+ta5+Ot33FGBJkXhd2Qm+QuOWxyFE
 kqu4lFTAda76gf190jJ83RMNV6rAtxcFXTeR9Fccw4XuIQ8F1GMAU4vKBiUZLLBkksUp
 eNGXoAUlKm6JB4DpuTIv9vhxnKU4lHp/mVTgjxuC1KKLO9qStND3JD2Ai6VMA7KJuBVT
 prYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWcf+va/JjqcCenIqxKh56g2KJGmPsxRP/3U+bKMzT6SMVmScTTvK3UoYJZnl/qDP1IDZqaDs=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0InrjwMu2K47gtnN7bfkwn6mFhMcjx4KTkkOupvW+VvXBOLTf
 G7idvtCsjUJlwkRLkJSDH/71nO79lJ0kIrVpNTsPGQe2ETyy3y0EfIG9kpycVCTckuRieLSQ7rR
 zNut2GSybGSll4bCMdYUG+qEMwSLcuwulZjY5Nt83
X-Gm-Gg: ASbGncvYSFB9kI+9cha27OMKHUXNxwoY5n3nncn8WAji8J9DMeiHXOGyGsirzV015if
 CsKuqMHVwyi6noksye7PWfuQL1Pu6In6VDZx/KyqJh1V6RojWICsRNP2TfV1tr9qDU9a4EQzNfy
 sByhSiltVreirt/m1drCttB6z1Aw/ZaPxEyalT+GAW5VxFuPK1pOGPA8IsFqWsrglzT/M25W7FN
 4pDrWN0AJ7/fMut00ujuctJLOnvMzOyNFhK3NRp4hwh3LuLBMk/+tmVQGIxT52KdpRgpA==
X-Google-Smtp-Source: AGHT+IGuG2gLP3RyJzXfcxu4gjOQCRqwBAPwsnfe8519v7ySG+618kSwp976bFC70yg7MH2rhtoHAsUr4GD/pk0+VHM=
X-Received: by 2002:a17:906:6a08:b0:b40:da21:bf38 with SMTP id
 a640c23a62f3a-b736793d321mr1358854566b.36.1763399053686; Mon, 17 Nov 2025
 09:04:13 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTjofjQ_zmwJrGZ-sLejQ=x=-8tyqr4SBPYgt3683GVAbQ@mail.gmail.com>
 <20251113193816.GP6688@bill-the-cat>
 <CAFLszTjwpoCwCKKvJX5cZMLK480EK-=BWaFd5A6yLMrfsVWC6g@mail.gmail.com>
 <20251113200527.GQ6688@bill-the-cat>
 <CAFLszTjydNqmo=6qLv--m4fB07QzWd01XHGY3hxgTEbarJF-VA@mail.gmail.com>
 <20251113203654.GR6688@bill-the-cat>
 <385cdc16-cf73-443b-a0a1-440e233d4506@mailbox.org>
 <CAFLszThc4YC6mKp5sNsiuCFfaMNqMWJjVV27d4UkyLU4rPWY6A@mail.gmail.com>
 <bed4a846-6356-463f-a8a9-3d4bf05439a4@mailbox.org>
 <CAFLszTiLZaMkCUxk2_x=gwKBxJeg-02iO-w=JufXEtqhqHZyTA@mail.gmail.com>
 <20251117142105.GG2125796@bill-the-cat>
In-Reply-To: <20251117142105.GG2125796@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Nov 2025 10:04:00 -0700
X-Gm-Features: AWmQ_bmgNB0yBf08E0XYbu1HM4kvIRNa29SsH0ea6M5n6446t6sRyQTbCEsYo8k
Message-ID: <CAFLszThiza12FcSeEVg3xWJcP1zZVrfxDgTDT4mZNfEUKvZpWQ@mail.gmail.com>
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

On Mon, 17 Nov 2025 at 07:21, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Nov 16, 2025 at 09:07:19AM -0700, Simon Glass wrote:
> > Hi Marek,
> >
> > On Sat, 15 Nov 2025 at 17:20, Marek Vasut <marek.vasut@mailbox.org> wrote:
> > >
> > > On 11/14/25 1:45 PM, Simon Glass wrote:
> > >
> > > Hello Simon,
> > >
> > > >>>>> Which is different from disagreeing with your specific feedback about
> > > >>>>> how we get there, to be clear.
> > > >>>
> > > >>> And again, since your feedback to this patch was "Don't?", I'm saying we
> > > >>> need to. But the rest of your feedback was structural on moving towards
> > > >>> resolving it and so I assume Marek will respond.
> > > >>
> > > >> The "blast radius" are these patches, that's all that tripped the tests:
> > > >>
> > > >>    - boot: android: Always use 8-byte aligned DT with libfdt
> > > >>    - test/py: android: Point fdt command to aligned addresses
> > > >>    - test/py: Use aligned address for overlays in 'extension' test
> > > >>    - sandbox: Fix DT compiler address warnings in sandbox DTs
> > > >>    - sandbox: Fix DT compiler pin warnings in sandbox DTs
> > > >>    - boot: Assure FDT is always at 8-byte aligned address
> > > >>    - arm: qemu: Eliminate fdt_high and initrd_high misuse
> > > >>    - efi_loader: Assure fitImage from capsule is used from 8-byte aligned
> > > >> address
> > > >>    - MIPS: Assure end of U-Boot is at 8-byte aligned offset
> > > >>
> > > >> Regarding last minute alignment, the problem with this android image
> > > >> seems to be in the android image itself, which packs in badly aligned
> > > >> FDT. We therefore have to copy it out and realign.
> > > >
> > > > My request is to implement these checks as part of the boot flow
> > > > (bootm, etc.) rather than adding memory allocations in leaf function.
> > > > We already support copying the FDT to a different address so we can
> > > > expand it and add things. Can we make use of that code?
> > > It seems the 'abootomg' command is extracting DTB from a container where
> > > the DTB can be at 4-byte aligned address. Thus far, the command
> > > internally used that possibly 4-byte aligned address, which is wrong. It
> > > also returned that address which was used by further U-Boot commands
> > > as-is, which is also wrong.
> > >
> > > This DTB usage here has nothing to do with any boot flow, this is
> > > incorrect DTB alignment during manipulation, which is not part of boot.
> > >
> > > What exactly do you propose should be changed with this patch ?
> >
> > Actually this patch seems to adjust code which is just handling a
> > command. How about creating a common function which can put an FDT
> > into an abuf, either just using it in place, or allocating memory and
> > copying it? An abuf is ideal for this. E.g. something like (untested):
> >
> > /**
> >  * fdt_ensure_aligned() - Obtain an abuf with a devicetree, aligning if needed
> >  *
> >  * @buf: Returns abuf containing FDT on success; caller must abuf_uninit(buf)
> >  * @addr: Address of FDT
> >  * Return: 0 on success, -EINVAL if not an FDT, -ENOMEM if out of memory
> >  */
> > int fdt_ensure_aligned(struct abuf *buf, void *fdt)
> > {
> >    struct fdt_header fdth __aligned(8);
> >
> >    memcpy(&fdth, fdt, sizeof(struct fdt_header));
> >    if (fdt_check_header(&fdth) != 0)
> >       return -EINVAL;
> >
> >    abuf_init_const(buf, fdt, fdt_totalsize(&fdth));
> >
> >    /* The device tree must be at an 8-byte aligned address */
> >    if ((uintptr_t)fdt & 7) {
> >       void *fulldt;
> >
> >       // a function like abuf_realloc_align(struct abuf *buf, int
> > align) would help
> >       fulldt = memalign(8, buf->size);
> >       if (!fulldt)
> >          return -ENOMEM;
> >
> >       memcpy(fulldt, fdt, buf->size);
> >       buf->data = fulldt;
> >       buf->alloced = true;
> >    }
> >
> >    return 0;
> > }
> >
> > Then you can use this in various places as needed.
>
> That looks like massively more code than is needed to just ensure that
> the thing we deal with today is also correctly aligned? We don't need to
> pull abuf into everything.

It is 27 lines of code, less than Marek's delta. Plus by the sounds of
it, we can call it from more than one place. I think it is better to
have a common function than to open-code this stuff in multiple
places. I also think separating out the map_sysmem() stuff would make
sense, since it is a bit convoluted at present.

Re abuf I believe it is a useful abstraction and I wish I had thought
of it some years ago. It is particularly good when you may or may not
need to allocate something. Should we discuss abuf in one of the
U-Boot meetings?

Regards,
Simon
