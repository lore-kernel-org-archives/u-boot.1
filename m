Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFD5C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 14:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E75887282;
	Sun, 31 Dec 2023 15:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Azgy5GLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 807D987084; Sun, 31 Dec 2023 15:22:29 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0185087084
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 15:22:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-67f9f6ca479so61488706d6.3
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 06:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704032542; x=1704637342; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIuRYb3z05y5Wo/keRNo/JLjYCc3r0qjXYWJJWN8UXk=;
 b=Azgy5GLTahkTv+SHjG0bCM2dztfaHXaJcvL4a2iI0G231u0CWFS6wDFQL8ek061m7v
 SMsJ9XMWXVcgzWysAWKoUdSdyRQsdaz09Su2KPF+QfXtEKuKwsNEl9UJLyi5jArmyFKk
 CegUejjO1+m1F9+u8d5H17FazxkIXm/l432gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704032542; x=1704637342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DIuRYb3z05y5Wo/keRNo/JLjYCc3r0qjXYWJJWN8UXk=;
 b=ZSxbqFvC9HrsEM5gogjdvdV9nI9oTZKAWsDnG3PL9ah4IS2W8TZSn2dJs3joUBHllT
 gxD0F4thUKrVyRIYQIWu19IL1+ozLBDR3oZ/+nSnIgbqNqbE/XpGQLpE3Fy/f+ch1yf/
 +OqL6c9NdL5Vd7/LSntn1VufPZtzlODFCu7Wzik4+I6ZS3WpKpUNS7jhuzZFUn+u5vyz
 qbwBf7u97IicLrD630LM3tDWnW9H3fNvs57R9piB1myvA9cAp44nQ2Vle4hByHWv4lqv
 L/UuoztlVGKjzPQuKGpPG8cJKbs3GwFKN9xrUYDNdvs2JizaDSXtRP/Vjm7SmCw1pBF5
 dg0A==
X-Gm-Message-State: AOJu0Yz40DSCNbY0JtS7LBjhmvJMXkBbpbEFMj3qDXGAeVW1b4OyLmgA
 qFAm1lCYE2pbAEDFqXbkvi3iMacfIcyjXCCifw00+K7UzSpbaUzzRyLPqF0=
X-Google-Smtp-Source: AGHT+IH8wtYAtiagn4zQzBDh8SjhWRxirvMJfjk7Xak+J92wg91tpLVrFmXuF42Uw5OZ/ba7amggJjN3Pn0lno7KBgU=
X-Received: by 2002:a05:6214:248c:b0:67f:63a5:b37f with SMTP id
 gi12-20020a056214248c00b0067f63a5b37fmr23483854qvb.21.1704032541710; Sun, 31
 Dec 2023 06:22:21 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <CAFLszThqH01GOqnTxucVE7s+wJU-dz7uqUtkb4iKxs6GgX6tqw@mail.gmail.com>
 <20231229154307.GS2652760@bill-the-cat>
 <7CDAA354-803C-4AFD-BD38-F432B811DB96@gmx.de>
 <20231229161744.GU2652760@bill-the-cat>
 <871qb4nbtc.fsf@bloch.sibelius.xs4all.nl>
 <20231229175215.GY2652760@bill-the-cat>
 <CAFLszTjXrmhOBeMvGfpy3mfZujNrCu2BKmUbEYz-rmxwyWdg3A@mail.gmail.com>
 <20231231135357.GZ2652760@bill-the-cat>
In-Reply-To: <20231231135357.GZ2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Dec 2023 07:22:10 -0700
Message-ID: <CAFLszTgCSDsobu9ak495vnRP-bjakK5Ytxd5YXro0-7GmYj9vA@mail.gmail.com>
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

Hi Tom,

On Sun, Dec 31, 2023 at 6:54=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sun, Dec 31, 2023 at 05:48:23AM -0700, Simon Glass wrote:
> > Hi,
> >
> > On Fri, Dec 29, 2023 at 10:52=E2=80=AFAM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Fri, Dec 29, 2023 at 06:44:15PM +0100, Mark Kettenis wrote:
> > > > > Date: Fri, 29 Dec 2023 11:17:44 -0500
> > > > > From: Tom Rini <trini@konsulko.com>
> > > > >
> > > > > On Fri, Dec 29, 2023 at 05:05:17PM +0100, Heinrich Schuchardt wro=
te:
> > > > > >
> > > > > >
> > > > > > Am 29. Dezember 2023 16:43:07 MEZ schrieb Tom Rini <trini@konsu=
lko.com>:
> > > > > > >On Fri, Dec 29, 2023 at 05:36:09AM +0000, Simon Glass wrote:
> > > > > > >> Hi,
> > > > > > >>
> > > > > > >> On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM Simon Glass <sjg@chr=
omium.org> wrote:
> > > > > > >> >
> > > > > > >> > Hi,
> > > > > > >> >
> > > > > > >> > This records my thoughts after a discussion with Ilias & H=
einrich re
> > > > > > >> > memory allocation in U-Boot.
> > > > > > >> >
> > > > > > >> > 1. malloc()
> > > > > > >> >
> > > > > > >> > malloc() is used for programmatic memory allocation. It al=
lows memory
> > > > > > >> > to be freed. It is not designed for very large allocations=
 (e.g. a
> > > > > > >> > 10MB kernel or 100MB ramdisk).
> > > > > > >> >
> > > > > > >> > 2. lmb
> > > > > > >> >
> > > > > > >> > lmb is used for large blocks of memory, such as those need=
ed for a
> > > > > > >> > kernel or ramdisk. Allocation is only transitory, for the =
purposes of
> > > > > > >> > loading some images and booting. If the boot fails, then a=
ll lmb
> > > > > > >> > allocations go away.
> > > > > > >> >
> > > > > > >> > lmb is set up by getting all available memory and then rem=
oving what
> > > > > > >> > is used by U-Boot (code, data, malloc() space, etc.)
> > > > > > >> >
> > > > > > >> > lmb reservations have a few flags so that areas of memory =
can be
> > > > > > >> > provided with attributes
> > > > > > >> >
> > > > > > >> > There are some corner cases...e.g. loading a file does an =
lmb
> > > > > > >> > allocation but only for the purpose of avoiding a file bei=
ng loaded
> > > > > > >> > over U-Boot code/data. The allocation is dropped immediate=
ly after the
> > > > > > >> > file is loaded. Within the bootm command, or when using st=
andard boot,
> > > > > > >> > this would be fairly easy to solve.
> > > > > > >> >
> > > > > > >> > Linux has renamed lmb to memblock. We should consider doin=
g the same.
> > > > > > >> >
> > > > > > >> > 3. EFI
> > > > > > >> >
> > > > > > >> > EFI has its own memory-allocation tables.
> > > > > > >> >
> > > > > > >> > Like lmb, EFI is able to deal with large allocations. But =
via a 'pool'
> > > > > > >> > function it can also do smaller allocations similar to mal=
loc(),
> > > > > > >> > although each one uses at least 4KB at present.
> > > > > > >> >
> > > > > > >> > EFI allocations do not go away when a boot fails.
> > > > > > >> >
> > > > > > >> > With EFI it is possible to add allocations post facto, in =
which case
> > > > > > >> > they are added to the allocation table just as if the memo=
ry was
> > > > > > >> > allocated with EFI to begin with.
> > > > > > >> >
> > > > > > >> > The EFI allocations and the lmb allocations use the same m=
emory, so in
> > > > > > >> > principle could conflict.
> > > > > > >> >
> > > > > > >> > EFI allocations are sometimes used to allocate internal U-=
Boot data as
> > > > > > >> > well, if needed by the EFI app. For example, while efi_ima=
ge_parse()
> > > > > > >> > uses malloc(), efi_var_mem.c uses EFI allocations since th=
e code runs
> > > > > > >> > in the app context and may need to access the memory after=
 U-Boot has
> > > > > > >> > exited. Also efi_smbios.c uses allocate_pages() and then a=
dds a new
> > > > > > >> > mapping as well.
> > > > > > >> >
> > > > > > >> > EFI memory has attributes, including what the memory is us=
ed for (to
> > > > > > >> > some degree of granularity). See enum efi_memory_type and =
struct
> > > > > > >> > efi_mem_desc. In the latter there are also attribute flags=
 - whether
> > > > > > >> > memory is cacheable, etc.
> > > > > > >> >
> > > > > > >> > EFI also has the x86 idea of 'conventional' memory, meanin=
g (I
> > > > > > >> > believe) that below 4GB that isn't reserved for the hardwa=
re/system.
> > > > > > >> > This is meaningless, or at least confusing, on ARM systems=
.
> > > > > > >> >
> > > > > > >> > 4. reservations
> > > > > > >> >
> > > > > > >> > It is perhaps worth mentioning a fourth method of memory m=
anagement,
> > > > > > >> > where U-Boot reserves chunks of memory before relocation (=
in
> > > > > > >> > board_init_f.c), e.g. for the framebuffer, U-Boot code, th=
e malloc()
> > > > > > >> > region, etc.
> > > > > > >> >
> > > > > > >> >
> > > > > > >> > Problems
> > > > > > >> > =E2=80=94-------
> > > > > > >> >
> > > > > > >> > There are no urgent problems, but here are some things tha=
t could be improved:
> > > > > > >> >
> > > > > > >> > 1. EFI should attach most of its data structures to driver=
 model. This
> > > > > > >> > work has started, with the partition support, but more eff=
ort would
> > > > > > >> > help. This would make it easier to see which memory is rel=
ated to
> > > > > > >> > devices and which is separate.
> > > > > > >> >
> > > > > > >> > 2. Some drivers do EFI reservations today, whether EFI is =
used for
> > > > > > >> > booting or not (e.g. rockchip video rk_vop_probe()).
> > > > > > >> >
> > > > > > >> > 3. U-Boot doesn't really map arch-specific memory attribut=
es (e.g.
> > > > > > >> > armv8's struct mm_region) to EFI ones.
> > > > > > >> >
> > > > > > >> > 4. EFI duplicates some code from bootm, some of which rela=
tes to
> > > > > > >> > memory allocation (e.g. FDT fixup).
> > > > > > >> >
> > > > > > >> > 5. EFI code is used even if EFI is never used to boot
> > > > > > >> >
> > > > > > >> > 6. EFI allocations can result in the same memory being use=
d as has
> > > > > > >> > already been allocated by lmb. Users may load files which =
overwrite
> > > > > > >> > memory allocated by EFI.
> > > > > > >>
> > > > > > >> 7. We need to support doing an allocation when a file is loa=
ded (to
> > > > > > >> ensure files do not overlap), without making it too difficul=
t to load
> > > > > > >> multiple files to the same place, if desired.
> > > > > > >>
> > > > > > >> >
> > > > > > >> >
> > > > > > >> > Lifetime
> > > > > > >> > --------
> > > > > > >> >
> > > > > > >> > We have three different memory allocators with different p=
urposes. Can
> > > > > > >> > we unify them a little?
> > > > > > >> >
> > > > > > >> > Within U-Boot:
> > > > > > >> > - malloc() space lives forever
> > > > > > >> > - lmb lives while setting out images for booting
> > > > > > >> > - EFI (mostly) lives while booting an EFI app
> > > > > > >> >
> > > > > > >> > In practice, EFI is set up early in U-Boot. Some of this i=
s necessary,
> > > > > > >> > some not. EFI allocations stay around forever. This works =
OK since
> > > > > > >> > large allocations are normally not done in EFI, so memory =
isn't really
> > > > > > >> > consumed to any great degree by the boot process.
> > > > > > >> >
> > > > > > >> > What happens to EFI allocations if the app returns? They a=
re still
> > > > > > >> > present, in case another app is run. This seems fine.
> > > > > > >> >
> > > > > > >> > API
> > > > > > >> > =E2=80=93--
> > > > > > >> > Can we unify some APIs?
> > > > > > >> >
> > > > > > >> > It should be possible to use lmb for large EFI memory allo=
cations, so
> > > > > > >> > long as they are only needed for booting. We effectively d=
o this
> > > > > > >> > today, since EFI does not manage the arrangement of loaded=
 images in
> > > > > > >> > memory. for the most part.
> > > > > > >> >
> > > > > > >> > It would not make sense to use EFI allocation to replace l=
mb and
> > > > > > >> > malloc(), of course.
> > > > > > >> >
> > > > > > >> > Could we use a common (lower-level) API for allocation, us=
ed by both
> > > > > > >> > lmb and EFI? They do have some similarities. However they =
have
> > > > > > >> > different lifetime constraints (EFI allocations are never =
dropped,
> > > > > > >> > unlikely lmb).
> > > > > > >> >
> > > > > > >> > ** Overall, it seems that the existence of memory allocati=
on in
> > > > > > >> > boot-time services has created confusion. Memory allocatio=
n is
> > > > > > >> > muddled, with both U-Boot code and boot-time services call=
ing the same
> > > > > > >> > memory allocator. This just has not been clearly thought o=
ut.
> > > > > > >> >
> > > > > > >> >
> > > > > > >> > Proposal
> > > > > > >> > =E2=80=94-------
> > > > > > >> >
> > > > > > >> > Here are some ideas:
> > > > > > >> >
> > > > > > >> > 1. For video, use the driver model API to locate the video=
 regions, or
> > > > > > >> > block off the entire framebuffer memory, for all devices a=
s a whole.
> > > > > > >> > Use efi_add_memory_map()
> > > > > > >> >
> > > > > > >> > 2. Add memory attributes to UCLASS_RAM and use them in EFI=
, mapping to
> > > > > > >> > the EFI_MEMORY_... attributes in struct efi_mem_desc.
> > > > > > >> >
> > > > > > >> > 3. Add all EFI reservations just before booting the app, a=
s we do with
> > > > > > >> > devicetree fixup. With this model, malloc() and lmb are us=
ed for all
> > > > > > >> > allocation. Then efi_add_memory_map() is called for each r=
egion in
> > > > > > >> > turn just before booting. Memory attributes are dealt with=
 above. The
> > > > > > >> > type (enum efi_memory_type) can be determined simply by th=
e data
> > > > > > >> > structure stored in it, as is done today. For example, SMB=
IOS tables
> > > > > > >> > can use EFI_ACPI_RECLAIM_MEMORY. Very few types are used a=
nd EFI code
> > > > > > >> > understands the meaning of each.
> > > > > > >> >
> > > > > > >> > 4. Avoid setting up EFI memory at the start of U-Boot. Do =
it only when
> > > > > > >> > booting. This looks to require very little effort.
> > > > > > >> >
> > > > > > >> > 5. Avoid calling efi_allocate_pages() and efi_allocate_poo=
l() outside
> > > > > > >> > boot-time services. This solves the problem 6. If memory i=
s needed by
> > > > > > >> > an app, allocate it with malloc() and see 3. There are onl=
y two
> > > > > > >> > efi_allocate_pages() (smbios and efi_runtime). There are m=
ore calls of
> > > > > > >> > efi_allocate_pool(), but most of these seem easy to fix up=
. For
> > > > > > >> > example, efi_init_event_log() allocates a buffer, but this=
 can be
> > > > > > >> > allocated in normal malloc() space or in a bloblist.
> > > > > > >> >
> > > > > > >> > 6. Don't worry too much about whether EFI will be used for=
 booting.
> > > > > > >> > The cost is likely not that great: use bootstage to measur=
e it as is
> > > > > > >> > done for driver model. Try to minmise the cost of its tabl=
es,
> > > > > > >> > particularly for execution time, but otherwise just rely o=
n the
> > > > > > >> > ability to disable EFI_LOADER.
> > > > > > >>
> > > > > > >> 7. Add a flag to the 'load' command:
> > > > > > >>
> > > > > > >> -m <type> - make an lmb allocation for the file
> > > > > > >>    <type> is the image type to use (kernel, ramdisk, flat_dt=
)
> > > > > > >>
> > > > > > >> any existing allocation for that type will be automatically =
freed
> > > > > > >> first. If <type> is "none" then no freeing is possible: any =
loaded
> > > > > > >> images just stack up in lmb.
> > > > > > >>
> > > > > > >> Add an 'lmb' (or memblock) command to allow listing and clea=
ring allocations.
> > > > > > >
> > > > > > >I would really not like to change the user interface and inste=
ad simply
> > > > > > >handle this with flags to whatever mark/allocation function is=
 called.
> > > > > > >You can always overwrite things that are brought in to memory,=
 you
> > > > > > >cannot overwrite U-Boot or our internals. Optionally noting th=
at some
> > > > > > >previous load to memory has been at least partially overwritte=
n could be
> > > > > > >helpful, if it's not too much extra logic.
> > > > > > >
> > > > > >
> > > > > > In most use cases users load exactly one file at  each address.=
 An
> > > > > > unload command would be the cleanest way for a user to indicate=
 that
> > > > > > he wants to reuse the memory.
> > > > >
> > > > > I very much do not want to change the API. There's untold numbers=
 of
> > > > > scripts out there and they should continue to work. I mentioned t=
o Ilias
> > > > > off list just now that I'm not against adding a command to add fl=
ags to
> > > > > these areas, but I don't think it's worthwhile to prevent overwri=
tes the
> > > > > user did early. The biggest long running problem in this space wa=
s that
> > > > > for 32bit ARM we couldn't know where the kernel BSS was going to =
be and
> > > > > so would have ramdisk at the wrong spot and get partially eaten, =
and
> > > > > this was hard to figure out. The current example is "ooops,
> > > > > decompression buffer for Image.gz/etc is too close to other thing=
s"
> > > > > which ends up failing nice and loudly, and in the future once thi=
s
> > > > > proposal is done we can just dynamically find and use a spot, sin=
ce
> > > > > we'll have that ability finally.
> > > >
> > > > In order to keep the existing interfaces we need lmb to keep track =
of
> > > > (at least ) three different states.  I think of those as "free",
> > > > "allocated" and "reserved".  The load command would "reserve" memor=
y
> > > > insteaf "allocate".  And it would pass a flag to lmb when reserving
> > > > memory to indicate that reserving memory that is already reserved i=
s
> > > > ok.  Both "reserved" and "allocated" memory should show up as not f=
ree
> > > > in the EFI memory map (probably as EfiLoaderData).
> > >
> > > Yes, something like this is what I was getting at, thanks.
> >
> > Yes, that is a good way of putting it. There is definitely a distinctio=
n there.
> >
> > If we don't want this flag, we could make U-Boot always do a
> > reservation on load, with a '-f' command to force loading over an
> > existing reservation / releasing it first?
>
> Again, this is an API change and I don't want to change the API.

The flag is only needed to drop a reservation, since we apparently
want the 'load' command to create a permanent reservation. It should
not affect existing boot scripts since they won't load overlapping
images.

Anyway, what do you suggest?

>
> > I'm not sure if we still want the proposed lmb command? Perhaps it is
> > not needed.
>
> Please lets not call it "lmb" because the current lmb isn't what we want
> anymore and it's otherwise probably leading to some of the confusion.
> The kernel evolved it to memblocks, so perhaps that terminology too
> here. And yes, a command for if nothing else debug / investigation would
> be good.

OK, I would prefer memblock too.

Regards,
Simon
