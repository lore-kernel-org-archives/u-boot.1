Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DB4CEBF8F
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 10:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF194890CA;
	Fri, 27 Sep 2024 12:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UP3h3G2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B8EA890D4; Fri, 27 Sep 2024 12:51:51 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5386688FAF
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 12:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7a9af813f6cso171734085a.3
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727434308; x=1728039108; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2WFeG6EpH6INp8QjkS1P6NY9GNTFmhZfWvPGHvT1pts=;
 b=UP3h3G2I8XaHybxbSZPmJCzf0SwXhmBCZgkzT2gg6xnzUgyvAGH5WcFbfp88inQaX8
 CZSPG6Tq1F8Q1tkFdDjRpwJpbGdtBSS/zkTy8E6XPlC5WN+C/Q8qeJ9PqaOck518i36L
 +28kp6I/MijD3teB8PekAuRzCXoFJ4TC/9jrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727434308; x=1728039108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2WFeG6EpH6INp8QjkS1P6NY9GNTFmhZfWvPGHvT1pts=;
 b=u8VtmFbtx3gLGVGvuYLzLh6GVWfXQfYmBnC+Rn5AChUFSc/hYj0XRyVs6Wu6S5srSi
 3xMTXg9UyIRAWJOw+WnielXKfOMnzEKyvm6jS+ZRsHKlMOxLuqhBVJfliq+PtKD8WSIh
 uUCiBpvwRGqxrrQZzrdTeFSp0YqnOIZvrHw+K/BrXmPXtStu2zCZUGEfXIYm7nbJpOrJ
 BbDi1D/X+FEH/iNXzcfQ9r4vOK1OA+NhdMGjvynYLXuoao+QFXhVziWuXTNEtWpqhTlz
 JXofFoO0GnPgLo90gy0eNfF574Moi17D8RV09sg0Tzu9IV1EExk1wn4DXe6EnNFgeZBZ
 a4fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgUj4pyrr7JVs6iPIvxzFi8pcHQiBn9jKyx3V4ofTTHF2QauhEokcfe5zVJ+wAHn2hnnSmx8E=@lists.denx.de
X-Gm-Message-State: AOJu0YwjX+raM4C12m7b97I+fR3raNUZIodiHZhwKvGevlc5HkG0Ut84
 KTNYR2uiwJr7s3MI4ZMU5aTW6awzViC9jeqGHT9jglhR004lTFtQPvdyj5EzaQWUxW1RbBLIfeM
 ul+zo7wotNCqpydj0iAU5YCTfOGP/5eWwzspK
X-Google-Smtp-Source: AGHT+IEZezvknRgZDqnjQT4TC4WRN+mFzbMliDefJQj3hT4ci36g6HN1/qLopnu6SqaHIwGYv+2Pb8Mu5RklQl2OI84=
X-Received: by 2002:a05:6214:4885:b0:6cb:4713:9dee with SMTP id
 6a1803df08f44-6cb47139f80mr7796476d6.4.1727434308121; Fri, 27 Sep 2024
 03:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-15-patrick.rudolph@9elements.com>
 <CAFLszTimAFGocvqbnT=JVsA2bjNa=ZfxP6Sy46a9e6VkhtdojQ@mail.gmail.com>
 <CAC_iWjLASm6U8kC68MJ0uZ14MGFS_SSL3Pcd8hcEH=a=W8gvBQ@mail.gmail.com>
 <CAFLszTgYHO7FgbCgfRwqT_yj4KBm31xKdEUrn0pZkhtLzOh=HQ@mail.gmail.com>
 <CAC_iWjKv+Z4K5xPW6MZhBZ67-rDy9iRVaoqfLKmJRwSG9nKnfA@mail.gmail.com>
 <CAFLszThA5eOM_xiMgDu=B4wAcP7wV9bzfc565rES8z6d1F8fjg@mail.gmail.com>
 <CAC_iWjLqmN0uA85RayC2hnMOJfCqumCpiq=waQwakd6ECfbXkg@mail.gmail.com>
 <CAFLszTgaVdgPNSC+vxZoH7ko5n_d6F_QnGfgL-biZ19edaUxQQ@mail.gmail.com>
 <CAC_iWj+a+HCBr7A1HCcntZW7rvriTm1PvgVDcpbWCjBdRb7NzA@mail.gmail.com>
In-Reply-To: <CAC_iWj+a+HCBr7A1HCcntZW7rvriTm1PvgVDcpbWCjBdRb7NzA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Sep 2024 04:51:37 -0600
Message-ID: <CAFLszTgudikVATnjZgHtavRqnNY_tU7GtimjWnbM-5nV1vJ2BA@mail.gmail.com>
Subject: Re: [PATCH v4 14/35] efi_loader: Allocate and write ACPI tables
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Thu, 26 Sept 2024 at 13:26, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 20 Sept 2024 at 19:01, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Fri, 20 Sept 2024 at 08:36, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Thu, 19 Sept 2024 at 18:36, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Thu, 19 Sept 2024 at 17:20, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Thu, 19 Sept 2024 at 18:00, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Ilias,
> > > > > >
> > > > >
> > > > > [...]
> > > > >
> > > > > > > > > +
> > > > > > > > > +               if (!addr)
> > > > > > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > > > > > > +       } else {
> > > > > > > > > +               pages = efi_size_in_pages(TABLE_SIZE);
> > > > > > > > > +
> > > > > > > > > +               ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> > > > > > > > > +                                        EFI_ACPI_RECLAIM_MEMORY,
> > > > > > > > > +                                        pages, &new_acpi_addr);
> > > > > > > > > +               if (ret != EFI_SUCCESS)
> > > > > > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > > > > > > +
> > > > > > > > > +               addr = (void *)(uintptr_t)new_acpi_addr;
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > >
> > > > > > > > The tables should be written regardless of whether EFI_LOADER is enabled.
> > > > > > >
> > > > > > > *Why*? How do you expect to hand them over to the OS?
> > > > > >
> > > > > > Why - because boards which need ACPI tables to boot should generate
> > > > > > them;
> > > > >
> > > > > Noone argued that.
> > > > >
> > > > > > also this happens when U-Boot starts up, in last_stage_init()
> > > > > > How - it isn't possible, but eventually I suppose it will be, once we
> > > > > > have a use case for booting with ACPI but without EFI
> > > > >
> > > > > Are you aware of such an OS? If not, we can accept the patches when we
> > > > > have a reason.
> > > >
> > > > Which patches? This is how it works today. We set up the tables in
> > > > last_stage_init(), so they can be examined while in U-Boot.
> > >
> > > What I mean, is that until we have a valid use case to store the ACPI
> > > in a bloblist, I prefer them being allocated with proper EFI memory
> > > backing
> >
> > I'm going to assert prior art here. If ARM is to have ACPI in U-Boot,
> > it should follow the most recent x86 approach and store it in the
> > bloblist. That is what the blloblist is for. It also avoids using
> > memory below the U-Boot area, which is not allowed.
>
> By prior art you mean [0], which was none of the EFI maintainers got involved?

Yes. I should point out that I wrote the original EFI app support and
am maintainer for that. I also reviewed the original EFI_LOADER
support over quite a few revisions. I have a pretty-good understanding
of the implementation and issues.

>
> >
> > >
> > > >
> > > > It is the patches to change this which I object to.
> > > >
> > > > > I remember patches being hard NAK'ed on using DTs to pass the ACPI
> > > > > table address in the past.
> > > >
> > > > Yes, I believe Bytedance carries a patch locally for that :-)
> > >
> > > Exactly
> > >
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Can we drop this else clause? We should always use the bloblist.
> > > > > > >
> > > > > > > Both Heinrich and I said the exact opposite. Unless there's a
> > > > > > > perfectly good reason why we should keep them in bloblist memory, I'd
> > > > > > > like us to do that
> > > > > >
> > > > > > The main reason is that we should not be putting things in memory
> > > > > > between the start of RAM and the bottom of the U-Boot area. That
> > > > > > region of memory is supposed to be for loading images. Most boards
> > > > > > hard-code the image-load addresses in environment variables. But even
> > > > > > if they didn't, we should not be using that memory for U-Boot data.
> > > > >
> > > > > EFI allows you to request a specific address to use. We can choose one
> > > > > that fits the requirements
> > > >
> > > > So long as it is in U-Boot's space, that is fine. I just sent a patch
> > > > about relocation which covers this. It occured to me that this feature
> > > > of U-Boot, which I have always assumed was common knowledge, may have
> > > > not been noticed.
> > > >
> > > > > >
> > > > > > Another reason is that the bloblist is designed for this, for keeping
> > > > > > tables in a small, contiguous area of memory, so that when passed to
> > > > > > Linux they are not spread all over the place.
> > > > >
> > > > > Linux does not and will not read tables from a bloblist though
> > > >
> > > > Indeed. There really isn't any point, anyway, since there are other
> > > > ways of passing the tables along...except for ACPI with FDT but that
> > > > isn't a valid use case for Linux so far.
> > >
> > > What we are trying to do with EFI is to stay as close to the spec and
> > > the current OS implementations as possible. So again, please allocate
> > > EFI memory for the ACPI tables. The patches to convert it to bloblist
> > > allocating them are minimal, so we can do it, once there's an actuall
> > > need for it.
> >
> > As it stands today, efi_acpi_register() does not do an EFI allocation,
> > it just adds the existing allocation to the EFI tables. This works
> > fine for x86 - see arch/x86/lib/tables.c -
>
> Yes and I've already mentioned that in my original response.

OK good.

>
> > so I would like ARM to do
> > the same. The need for it is (as above) that we should ensure that
> > memory usage is within the U-Boot area. This is something which
> > bloblist handles automatically. It is also nice to see all the tables
> > in one place with 'bloblist list'
>
> Unless bloblist is not compiled.... in which case you still need to
> malloc and align.

For Arm, ACPI depends on BLOBLIST. It is also required on recent x86 platforms.

> I am just putting this out there, because your next email is going to
> be "oh look bloblist is mandatory now".
> For the last time, bloblist make zero sense to allocate data that
> arent going to be handed across loaders.

Sorry, I don't agree. It makes a lot of sense, since it keeps the
tables together, and keeps them within the memory space that U-Boot
uses for itself.

I have suggested we arrange a meeting to discuss this and I am still
happy to do so.

>
> Patrick, my suggestion is to either use efi_allocate_pages() as you do
> or malloc a properly aligned buffer since we set the memory type in
> efi_acpi_register().

I don't expect to change my mind on this. The efi_allocate_pages()
call should not be used before the app starts. That is the error which
has laid latent for years without anyone knowing. I still haven't seen
a clear acknowledgement of a problem, from the EFI folks. This is not
just about images and lmb, it is about following U-Boot's memory
practices.

> IIRC the reason we set that in efi_acpi_register() is for QEMU which
> hands us over ACPI tables, so we can't do much. I would personally
> prefer efi allocated memory.

It is used on x86 as well, e.g. chromebook_coral. Also QEMU tables are
munged somewhat during the copy, so I believe we can place them where
we wish. That probably needs a clean-up too. Bear in mind though, that
the tables are sometimes placed at f0000 on x86, i.e. below any memory
used by U-Boot itself.

Regards,
Simon
