Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386CBCF9C55
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD2868888F;
	Fri, 20 Sep 2024 18:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dKglV5KS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0672688B12; Fri, 20 Sep 2024 18:01:27 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E4488883
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6c548eb3354so15913626d6.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848080; x=1727452880; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HuAviQ+kv3GitaChm4gf5+7yUVI1R4QZgCnm+w8+LP0=;
 b=dKglV5KSOJD82eAefGUpVHT4fGcNhuPAv1eLGznIcw/0A6glghrJeUU7IW6weeSOm0
 zUzVuO9McaxqAjjPWcJiGBJmlur+L6MP7mRsbGwydm6WqMFZows56LPUMVE39yfywkXz
 nike/NOcm1Zsct72wwVLS3BuUjk6lG8su5+Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848080; x=1727452880;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HuAviQ+kv3GitaChm4gf5+7yUVI1R4QZgCnm+w8+LP0=;
 b=WTqP7vmEFs22BQKMpGVXFIG+GoUyFwhMFvjZ9SWz24pwtEGXRGs3t3CDtYNts8d0Gj
 y8i+Ya3fsf5PgWZ4fLtNmuh3eC4Z8Pif3asOeURKr0vZdDBxzB3IXrkCazCXzdC5KQ6t
 2tw2+uo+FNpdQUEExEJi8HO+FosEzUIu5feTqxXRJoUWIekwV0A5ZqHsFNEWvdeyJxHq
 GJEYoJxKkYI0tuBYhZZ0yXjJiyDDc1V/3YQ8J8BpdZr9Lrh/3i7QswG8zroV3mhRYq7N
 KgEvSGEZR7+T4/9DHarMIPkeyp65hCGfOqbWZF2C6miy8tQx2HYK2NpE8y/INhQHso/q
 uz0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXwpvNrUXq6qdi2ZZeJ08vNyaIP8ODtvy6tsUL2JpG5wHmfyxXvQH56x9KFmhO3xCCLXRcteU=@lists.denx.de
X-Gm-Message-State: AOJu0YwKaxE9H5Lvp8GeV9wzILFhKVyeFphFQ8rCrHzzTp5pprGeiw/+
 wsLCuprnv6cZQZ6WZixEBNRsNko8ciaHRcYJkFfg3CwcH9Sw1F+XFwniREciIwVUIRVDnkkrwHX
 v4Dl/Hw8KVfaOyIikD/T7FhG718SN/z5pezmF
X-Google-Smtp-Source: AGHT+IEb3NJ3ygWyLKzd8HiEuQFPOmMRC3sjAfIPERIn5pqWpap4yV+D6q91hIlHGE1BsnK27bqtm7gRDwD2H9ZurIk=
X-Received: by 2002:a05:6214:5241:b0:6c5:73a6:ff37 with SMTP id
 6a1803df08f44-6c7bd4ce116mr48953826d6.5.1726848080499; Fri, 20 Sep 2024
 09:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-15-patrick.rudolph@9elements.com>
 <CAFLszTimAFGocvqbnT=JVsA2bjNa=ZfxP6Sy46a9e6VkhtdojQ@mail.gmail.com>
 <CAC_iWjLASm6U8kC68MJ0uZ14MGFS_SSL3Pcd8hcEH=a=W8gvBQ@mail.gmail.com>
 <CAFLszTgYHO7FgbCgfRwqT_yj4KBm31xKdEUrn0pZkhtLzOh=HQ@mail.gmail.com>
 <CAC_iWjKv+Z4K5xPW6MZhBZ67-rDy9iRVaoqfLKmJRwSG9nKnfA@mail.gmail.com>
 <CAFLszThA5eOM_xiMgDu=B4wAcP7wV9bzfc565rES8z6d1F8fjg@mail.gmail.com>
 <CAC_iWjLqmN0uA85RayC2hnMOJfCqumCpiq=waQwakd6ECfbXkg@mail.gmail.com>
In-Reply-To: <CAC_iWjLqmN0uA85RayC2hnMOJfCqumCpiq=waQwakd6ECfbXkg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:01:10 +0200
Message-ID: <CAFLszTgaVdgPNSC+vxZoH7ko5n_d6F_QnGfgL-biZ19edaUxQQ@mail.gmail.com>
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

On Fri, 20 Sept 2024 at 08:36, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 19 Sept 2024 at 18:36, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, 19 Sept 2024 at 17:20, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Thu, 19 Sept 2024 at 18:00, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > >
> > > [...]
> > >
> > > > > > > +
> > > > > > > +               if (!addr)
> > > > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > > > > +       } else {
> > > > > > > +               pages = efi_size_in_pages(TABLE_SIZE);
> > > > > > > +
> > > > > > > +               ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> > > > > > > +                                        EFI_ACPI_RECLAIM_MEMORY,
> > > > > > > +                                        pages, &new_acpi_addr);
> > > > > > > +               if (ret != EFI_SUCCESS)
> > > > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > > > > +
> > > > > > > +               addr = (void *)(uintptr_t)new_acpi_addr;
> > > > > > > +       }
> > > > > > > +
> > > > > >
> > > > > > The tables should be written regardless of whether EFI_LOADER is enabled.
> > > > >
> > > > > *Why*? How do you expect to hand them over to the OS?
> > > >
> > > > Why - because boards which need ACPI tables to boot should generate
> > > > them;
> > >
> > > Noone argued that.
> > >
> > > > also this happens when U-Boot starts up, in last_stage_init()
> > > > How - it isn't possible, but eventually I suppose it will be, once we
> > > > have a use case for booting with ACPI but without EFI
> > >
> > > Are you aware of such an OS? If not, we can accept the patches when we
> > > have a reason.
> >
> > Which patches? This is how it works today. We set up the tables in
> > last_stage_init(), so they can be examined while in U-Boot.
>
> What I mean, is that until we have a valid use case to store the ACPI
> in a bloblist, I prefer them being allocated with proper EFI memory
> backing

I'm going to assert prior art here. If ARM is to have ACPI in U-Boot,
it should follow the most recent x86 approach and store it in the
bloblist. That is what the blloblist is for. It also avoids using
memory below the U-Boot area, which is not allowed.

>
> >
> > It is the patches to change this which I object to.
> >
> > > I remember patches being hard NAK'ed on using DTs to pass the ACPI
> > > table address in the past.
> >
> > Yes, I believe Bytedance carries a patch locally for that :-)
>
> Exactly
>
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > Can we drop this else clause? We should always use the bloblist.
> > > > >
> > > > > Both Heinrich and I said the exact opposite. Unless there's a
> > > > > perfectly good reason why we should keep them in bloblist memory, I'd
> > > > > like us to do that
> > > >
> > > > The main reason is that we should not be putting things in memory
> > > > between the start of RAM and the bottom of the U-Boot area. That
> > > > region of memory is supposed to be for loading images. Most boards
> > > > hard-code the image-load addresses in environment variables. But even
> > > > if they didn't, we should not be using that memory for U-Boot data.
> > >
> > > EFI allows you to request a specific address to use. We can choose one
> > > that fits the requirements
> >
> > So long as it is in U-Boot's space, that is fine. I just sent a patch
> > about relocation which covers this. It occured to me that this feature
> > of U-Boot, which I have always assumed was common knowledge, may have
> > not been noticed.
> >
> > > >
> > > > Another reason is that the bloblist is designed for this, for keeping
> > > > tables in a small, contiguous area of memory, so that when passed to
> > > > Linux they are not spread all over the place.
> > >
> > > Linux does not and will not read tables from a bloblist though
> >
> > Indeed. There really isn't any point, anyway, since there are other
> > ways of passing the tables along...except for ACPI with FDT but that
> > isn't a valid use case for Linux so far.
>
> What we are trying to do with EFI is to stay as close to the spec and
> the current OS implementations as possible. So again, please allocate
> EFI memory for the ACPI tables. The patches to convert it to bloblist
> allocating them are minimal, so we can do it, once there's an actuall
> need for it.

As it stands today, efi_acpi_register() does not do an EFI allocation,
it just adds the existing allocation to the EFI tables. This works
fine for x86 - see arch/x86/lib/tables.c - so I would like ARM to do
the same. The need for it is (as above) that we should ensure that
memory usage is within the U-Boot area. This is something which
bloblist handles automatically. It is also nice to see all the tables
in one place with 'bloblist list'

Regards,
Simon
