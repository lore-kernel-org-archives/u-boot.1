Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D807BC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 12:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6744287721;
	Sun, 31 Dec 2023 13:48:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f1Boh6l5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AEA8877DE; Sun, 31 Dec 2023 13:48:38 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E85C1875FC
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 13:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-67f962cf6c9so53292436d6.0
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 04:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704026914; x=1704631714; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2laNnDMWaTVjsUSiZxZFhpCb4+m/LahwfL5Wiob4r0=;
 b=f1Boh6l5r195DJRDfhMK60L9GlG/IEjW2vcW0XNrtctJfuzmd0oeUXymyKr7Pn65lo
 yEkgd6iP1rNJEka4zQULnhlVAOZBBNZrzAnJOEc60DYFwYXFJGbtL+uXdX6ixmhXX/Nd
 lURT7Fb916eKroz8Ajm2+nG1DExgksFO3xdkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704026914; x=1704631714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2laNnDMWaTVjsUSiZxZFhpCb4+m/LahwfL5Wiob4r0=;
 b=FaXZj+YDvCr8iPQHXHZDSBIPuDIq1ybYEamoMrYBUgTy9+Hy9lTnHm7bu8huLJCCHU
 aNplK15IHTgeGOpeFqLMIfyl0bkGcecmKSvN44WgCYQNH01yXc+2G+38Dkikb8u4WtJz
 MSLmBYPZlxmYqHak7ouyxMNQhqI9GPDGnKzsvYWb5UHUxH6UNA/5tDaO/4RpIGSlAR0o
 sVQT+EwBVtLyDWTwYxyk1/e9uICYbeW7fQXQdhqnru0RN/AAAV1nrKZGypmNRTu3erCl
 UhbVKj32E3WZsjh0/1YwXFO+ruTO5JGE5dBl9u/zTdhlUp8youczstCr+hY/ZrZs7Sim
 tz3g==
X-Gm-Message-State: AOJu0YzYjiM01i9uA8Xew9ezzvvCpg8HahqrRh9GpDATyJkB7X6LEYRe
 G22vXVunYbnhLQQxpWhI7WLY4W1ZRNuxA+0/yQdaHZN9Qorr
X-Google-Smtp-Source: AGHT+IGbcpm2gxH1MSww+kWw4Qw0ImMsLxjaoAPSI/t7N+hQ1lGWeRPiMb5iPDGCHcgEmthRkcaKoBB6ZfhjLzhaJQ4=
X-Received: by 2002:a05:6214:2422:b0:670:b327:c86f with SMTP id
 gy2-20020a056214242200b00670b327c86fmr23875846qvb.17.1704026914701; Sun, 31
 Dec 2023 04:48:34 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <CAFLszThqH01GOqnTxucVE7s+wJU-dz7uqUtkb4iKxs6GgX6tqw@mail.gmail.com>
 <20231229154307.GS2652760@bill-the-cat>
 <7CDAA354-803C-4AFD-BD38-F432B811DB96@gmx.de>
 <20231229161744.GU2652760@bill-the-cat>
 <871qb4nbtc.fsf@bloch.sibelius.xs4all.nl>
 <20231229175215.GY2652760@bill-the-cat>
In-Reply-To: <20231229175215.GY2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Dec 2023 05:48:23 -0700
Message-ID: <CAFLszTjXrmhOBeMvGfpy3mfZujNrCu2BKmUbEYz-rmxwyWdg3A@mail.gmail.com>
Subject: Re: Proposal: U-Boot memory management
To: Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, xypron.glpk@gmx.de,
 u-boot@lists.denx.de, ilias.apalodimas@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Dec 29, 2023 at 10:52=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Fri, Dec 29, 2023 at 06:44:15PM +0100, Mark Kettenis wrote:
> > > Date: Fri, 29 Dec 2023 11:17:44 -0500
> > > From: Tom Rini <trini@konsulko.com>
> > >
> > > On Fri, Dec 29, 2023 at 05:05:17PM +0100, Heinrich Schuchardt wrote:
> > > >
> > > >
> > > > Am 29. Dezember 2023 16:43:07 MEZ schrieb Tom Rini <trini@konsulko.=
com>:
> > > > >On Fri, Dec 29, 2023 at 05:36:09AM +0000, Simon Glass wrote:
> > > > >> Hi,
> > > > >>
> > > > >> On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM Simon Glass <sjg@chromiu=
m.org> wrote:
> > > > >> >
> > > > >> > Hi,
> > > > >> >
> > > > >> > This records my thoughts after a discussion with Ilias & Heinr=
ich re
> > > > >> > memory allocation in U-Boot.
> > > > >> >
> > > > >> > 1. malloc()
> > > > >> >
> > > > >> > malloc() is used for programmatic memory allocation. It allows=
 memory
> > > > >> > to be freed. It is not designed for very large allocations (e.=
g. a
> > > > >> > 10MB kernel or 100MB ramdisk).
> > > > >> >
> > > > >> > 2. lmb
> > > > >> >
> > > > >> > lmb is used for large blocks of memory, such as those needed f=
or a
> > > > >> > kernel or ramdisk. Allocation is only transitory, for the purp=
oses of
> > > > >> > loading some images and booting. If the boot fails, then all l=
mb
> > > > >> > allocations go away.
> > > > >> >
> > > > >> > lmb is set up by getting all available memory and then removin=
g what
> > > > >> > is used by U-Boot (code, data, malloc() space, etc.)
> > > > >> >
> > > > >> > lmb reservations have a few flags so that areas of memory can =
be
> > > > >> > provided with attributes
> > > > >> >
> > > > >> > There are some corner cases...e.g. loading a file does an lmb
> > > > >> > allocation but only for the purpose of avoiding a file being l=
oaded
> > > > >> > over U-Boot code/data. The allocation is dropped immediately a=
fter the
> > > > >> > file is loaded. Within the bootm command, or when using standa=
rd boot,
> > > > >> > this would be fairly easy to solve.
> > > > >> >
> > > > >> > Linux has renamed lmb to memblock. We should consider doing th=
e same.
> > > > >> >
> > > > >> > 3. EFI
> > > > >> >
> > > > >> > EFI has its own memory-allocation tables.
> > > > >> >
> > > > >> > Like lmb, EFI is able to deal with large allocations. But via =
a 'pool'
> > > > >> > function it can also do smaller allocations similar to malloc(=
),
> > > > >> > although each one uses at least 4KB at present.
> > > > >> >
> > > > >> > EFI allocations do not go away when a boot fails.
> > > > >> >
> > > > >> > With EFI it is possible to add allocations post facto, in whic=
h case
> > > > >> > they are added to the allocation table just as if the memory w=
as
> > > > >> > allocated with EFI to begin with.
> > > > >> >
> > > > >> > The EFI allocations and the lmb allocations use the same memor=
y, so in
> > > > >> > principle could conflict.
> > > > >> >
> > > > >> > EFI allocations are sometimes used to allocate internal U-Boot=
 data as
> > > > >> > well, if needed by the EFI app. For example, while efi_image_p=
arse()
> > > > >> > uses malloc(), efi_var_mem.c uses EFI allocations since the co=
de runs
> > > > >> > in the app context and may need to access the memory after U-B=
oot has
> > > > >> > exited. Also efi_smbios.c uses allocate_pages() and then adds =
a new
> > > > >> > mapping as well.
> > > > >> >
> > > > >> > EFI memory has attributes, including what the memory is used f=
or (to
> > > > >> > some degree of granularity). See enum efi_memory_type and stru=
ct
> > > > >> > efi_mem_desc. In the latter there are also attribute flags - w=
hether
> > > > >> > memory is cacheable, etc.
> > > > >> >
> > > > >> > EFI also has the x86 idea of 'conventional' memory, meaning (I
> > > > >> > believe) that below 4GB that isn't reserved for the hardware/s=
ystem.
> > > > >> > This is meaningless, or at least confusing, on ARM systems.
> > > > >> >
> > > > >> > 4. reservations
> > > > >> >
> > > > >> > It is perhaps worth mentioning a fourth method of memory manag=
ement,
> > > > >> > where U-Boot reserves chunks of memory before relocation (in
> > > > >> > board_init_f.c), e.g. for the framebuffer, U-Boot code, the ma=
lloc()
> > > > >> > region, etc.
> > > > >> >
> > > > >> >
> > > > >> > Problems
> > > > >> > =E2=80=94-------
> > > > >> >
> > > > >> > There are no urgent problems, but here are some things that co=
uld be improved:
> > > > >> >
> > > > >> > 1. EFI should attach most of its data structures to driver mod=
el. This
> > > > >> > work has started, with the partition support, but more effort =
would
> > > > >> > help. This would make it easier to see which memory is related=
 to
> > > > >> > devices and which is separate.
> > > > >> >
> > > > >> > 2. Some drivers do EFI reservations today, whether EFI is used=
 for
> > > > >> > booting or not (e.g. rockchip video rk_vop_probe()).
> > > > >> >
> > > > >> > 3. U-Boot doesn't really map arch-specific memory attributes (=
e.g.
> > > > >> > armv8's struct mm_region) to EFI ones.
> > > > >> >
> > > > >> > 4. EFI duplicates some code from bootm, some of which relates =
to
> > > > >> > memory allocation (e.g. FDT fixup).
> > > > >> >
> > > > >> > 5. EFI code is used even if EFI is never used to boot
> > > > >> >
> > > > >> > 6. EFI allocations can result in the same memory being used as=
 has
> > > > >> > already been allocated by lmb. Users may load files which over=
write
> > > > >> > memory allocated by EFI.
> > > > >>
> > > > >> 7. We need to support doing an allocation when a file is loaded =
(to
> > > > >> ensure files do not overlap), without making it too difficult to=
 load
> > > > >> multiple files to the same place, if desired.
> > > > >>
> > > > >> >
> > > > >> >
> > > > >> > Lifetime
> > > > >> > --------
> > > > >> >
> > > > >> > We have three different memory allocators with different purpo=
ses. Can
> > > > >> > we unify them a little?
> > > > >> >
> > > > >> > Within U-Boot:
> > > > >> > - malloc() space lives forever
> > > > >> > - lmb lives while setting out images for booting
> > > > >> > - EFI (mostly) lives while booting an EFI app
> > > > >> >
> > > > >> > In practice, EFI is set up early in U-Boot. Some of this is ne=
cessary,
> > > > >> > some not. EFI allocations stay around forever. This works OK s=
ince
> > > > >> > large allocations are normally not done in EFI, so memory isn'=
t really
> > > > >> > consumed to any great degree by the boot process.
> > > > >> >
> > > > >> > What happens to EFI allocations if the app returns? They are s=
till
> > > > >> > present, in case another app is run. This seems fine.
> > > > >> >
> > > > >> > API
> > > > >> > =E2=80=93--
> > > > >> > Can we unify some APIs?
> > > > >> >
> > > > >> > It should be possible to use lmb for large EFI memory allocati=
ons, so
> > > > >> > long as they are only needed for booting. We effectively do th=
is
> > > > >> > today, since EFI does not manage the arrangement of loaded ima=
ges in
> > > > >> > memory. for the most part.
> > > > >> >
> > > > >> > It would not make sense to use EFI allocation to replace lmb a=
nd
> > > > >> > malloc(), of course.
> > > > >> >
> > > > >> > Could we use a common (lower-level) API for allocation, used b=
y both
> > > > >> > lmb and EFI? They do have some similarities. However they have
> > > > >> > different lifetime constraints (EFI allocations are never drop=
ped,
> > > > >> > unlikely lmb).
> > > > >> >
> > > > >> > ** Overall, it seems that the existence of memory allocation i=
n
> > > > >> > boot-time services has created confusion. Memory allocation is
> > > > >> > muddled, with both U-Boot code and boot-time services calling =
the same
> > > > >> > memory allocator. This just has not been clearly thought out.
> > > > >> >
> > > > >> >
> > > > >> > Proposal
> > > > >> > =E2=80=94-------
> > > > >> >
> > > > >> > Here are some ideas:
> > > > >> >
> > > > >> > 1. For video, use the driver model API to locate the video reg=
ions, or
> > > > >> > block off the entire framebuffer memory, for all devices as a =
whole.
> > > > >> > Use efi_add_memory_map()
> > > > >> >
> > > > >> > 2. Add memory attributes to UCLASS_RAM and use them in EFI, ma=
pping to
> > > > >> > the EFI_MEMORY_... attributes in struct efi_mem_desc.
> > > > >> >
> > > > >> > 3. Add all EFI reservations just before booting the app, as we=
 do with
> > > > >> > devicetree fixup. With this model, malloc() and lmb are used f=
or all
> > > > >> > allocation. Then efi_add_memory_map() is called for each regio=
n in
> > > > >> > turn just before booting. Memory attributes are dealt with abo=
ve. The
> > > > >> > type (enum efi_memory_type) can be determined simply by the da=
ta
> > > > >> > structure stored in it, as is done today. For example, SMBIOS =
tables
> > > > >> > can use EFI_ACPI_RECLAIM_MEMORY. Very few types are used and E=
FI code
> > > > >> > understands the meaning of each.
> > > > >> >
> > > > >> > 4. Avoid setting up EFI memory at the start of U-Boot. Do it o=
nly when
> > > > >> > booting. This looks to require very little effort.
> > > > >> >
> > > > >> > 5. Avoid calling efi_allocate_pages() and efi_allocate_pool() =
outside
> > > > >> > boot-time services. This solves the problem 6. If memory is ne=
eded by
> > > > >> > an app, allocate it with malloc() and see 3. There are only tw=
o
> > > > >> > efi_allocate_pages() (smbios and efi_runtime). There are more =
calls of
> > > > >> > efi_allocate_pool(), but most of these seem easy to fix up. Fo=
r
> > > > >> > example, efi_init_event_log() allocates a buffer, but this can=
 be
> > > > >> > allocated in normal malloc() space or in a bloblist.
> > > > >> >
> > > > >> > 6. Don't worry too much about whether EFI will be used for boo=
ting.
> > > > >> > The cost is likely not that great: use bootstage to measure it=
 as is
> > > > >> > done for driver model. Try to minmise the cost of its tables,
> > > > >> > particularly for execution time, but otherwise just rely on th=
e
> > > > >> > ability to disable EFI_LOADER.
> > > > >>
> > > > >> 7. Add a flag to the 'load' command:
> > > > >>
> > > > >> -m <type> - make an lmb allocation for the file
> > > > >>    <type> is the image type to use (kernel, ramdisk, flat_dt)
> > > > >>
> > > > >> any existing allocation for that type will be automatically free=
d
> > > > >> first. If <type> is "none" then no freeing is possible: any load=
ed
> > > > >> images just stack up in lmb.
> > > > >>
> > > > >> Add an 'lmb' (or memblock) command to allow listing and clearing=
 allocations.
> > > > >
> > > > >I would really not like to change the user interface and instead s=
imply
> > > > >handle this with flags to whatever mark/allocation function is cal=
led.
> > > > >You can always overwrite things that are brought in to memory, you
> > > > >cannot overwrite U-Boot or our internals. Optionally noting that s=
ome
> > > > >previous load to memory has been at least partially overwritten co=
uld be
> > > > >helpful, if it's not too much extra logic.
> > > > >
> > > >
> > > > In most use cases users load exactly one file at  each address. An
> > > > unload command would be the cleanest way for a user to indicate tha=
t
> > > > he wants to reuse the memory.
> > >
> > > I very much do not want to change the API. There's untold numbers of
> > > scripts out there and they should continue to work. I mentioned to Il=
ias
> > > off list just now that I'm not against adding a command to add flags =
to
> > > these areas, but I don't think it's worthwhile to prevent overwrites =
the
> > > user did early. The biggest long running problem in this space was th=
at
> > > for 32bit ARM we couldn't know where the kernel BSS was going to be a=
nd
> > > so would have ramdisk at the wrong spot and get partially eaten, and
> > > this was hard to figure out. The current example is "ooops,
> > > decompression buffer for Image.gz/etc is too close to other things"
> > > which ends up failing nice and loudly, and in the future once this
> > > proposal is done we can just dynamically find and use a spot, since
> > > we'll have that ability finally.
> >
> > In order to keep the existing interfaces we need lmb to keep track of
> > (at least ) three different states.  I think of those as "free",
> > "allocated" and "reserved".  The load command would "reserve" memory
> > insteaf "allocate".  And it would pass a flag to lmb when reserving
> > memory to indicate that reserving memory that is already reserved is
> > ok.  Both "reserved" and "allocated" memory should show up as not free
> > in the EFI memory map (probably as EfiLoaderData).
>
> Yes, something like this is what I was getting at, thanks.

Yes, that is a good way of putting it. There is definitely a distinction th=
ere.

If we don't want this flag, we could make U-Boot always do a
reservation on load, with a '-f' command to force loading over an
existing reservation / releasing it first?

I'm not sure if we still want the proposed lmb command? Perhaps it is
not needed.

Regards,
Simon
