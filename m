Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E582BC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 13:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13F46877DA;
	Sun, 31 Dec 2023 14:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sNWWTzZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E799787687; Sun, 31 Dec 2023 14:54:04 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B3A587687
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 14:54:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7815aad83acso280669485a.0
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 05:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704030840; x=1704635640; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4AeFQPXZotDVx+T6LUzf/5Nbt4gAKRubpK5a35R4Ibs=;
 b=sNWWTzZ4FVzoeKrSb+Oix95SqCmVO78mviXA/O1wYian+p7KZFfVoghJKt6gt7Ecu4
 hoDXvg2+ZtjKva1giBqRDW1uFzuUl8V7Fgm8wtQQ+X2Hn2El8boGmWXucxOb5cnTBlqB
 9GXJYT2j5HMIaic+0nBuJrNiV3wUMlrtAzl4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704030840; x=1704635640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4AeFQPXZotDVx+T6LUzf/5Nbt4gAKRubpK5a35R4Ibs=;
 b=UPOWfFLsktBhjwMEv2zQ+R5N3L9sQQKlT2D6Ny/eoyRSZLHVq6v03k8i4JX9VedQRk
 87BosgkgfNPM8PIG4bHytnRm42h93fKLpSgivhPIGfZhjuaxaf1KGlULurDBLUpIW5Zu
 L/x3FRh/NKLr6nw+ccn2ZGgrGgLZIv/oSCxXMYj3XoDNEIY8POtdU31ZQcRyS/Jws4uD
 i6t02x3ALIkml0uON/GjHvGwc8FgYYHxEjCbARwuDJw5rIPvFxETaLgQh7W3VutwSMzX
 0bPpm0YknHzG3uqS7kXpkgl7ePzqMim7tM9NPk95Rw/Ns9UPig0VUIRvLmFas3I5nUvg
 ZDGg==
X-Gm-Message-State: AOJu0YwKZyeYI9HBtduZXGMlNdgZppVbk8aetfZzxzS2sgDdX3ZDitN8
 XJdvqYa4MdJUNj7LWvTvy80Lygxg6zIFRA==
X-Google-Smtp-Source: AGHT+IHBJ5J4xVewJjJo0dcw9wz9m1TvW9Vpvv6rEWn7J5+mVTDySCpb7izc+3Bo1TavS063YJbAGw==
X-Received: by 2002:a05:620a:6227:b0:781:3f7f:54c2 with SMTP id
 ou39-20020a05620a622700b007813f7f54c2mr16140948qkn.25.1704030840096; 
 Sun, 31 Dec 2023 05:54:00 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 mh11-20020a056214564b00b0067f64c06bcesm8521306qvb.102.2023.12.31.05.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 05:53:59 -0800 (PST)
Date: Sun, 31 Dec 2023 08:53:57 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, xypron.glpk@gmx.de,
 u-boot@lists.denx.de, ilias.apalodimas@linaro.org
Subject: Re: Proposal: U-Boot memory management
Message-ID: <20231231135357.GZ2652760@bill-the-cat>
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <CAFLszThqH01GOqnTxucVE7s+wJU-dz7uqUtkb4iKxs6GgX6tqw@mail.gmail.com>
 <20231229154307.GS2652760@bill-the-cat>
 <7CDAA354-803C-4AFD-BD38-F432B811DB96@gmx.de>
 <20231229161744.GU2652760@bill-the-cat>
 <871qb4nbtc.fsf@bloch.sibelius.xs4all.nl>
 <20231229175215.GY2652760@bill-the-cat>
 <CAFLszTjXrmhOBeMvGfpy3mfZujNrCu2BKmUbEYz-rmxwyWdg3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FMsE56JzCJXCCoSz"
Content-Disposition: inline
In-Reply-To: <CAFLszTjXrmhOBeMvGfpy3mfZujNrCu2BKmUbEYz-rmxwyWdg3A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--FMsE56JzCJXCCoSz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023 at 05:48:23AM -0700, Simon Glass wrote:
> Hi,
>=20
> On Fri, Dec 29, 2023 at 10:52=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Fri, Dec 29, 2023 at 06:44:15PM +0100, Mark Kettenis wrote:
> > > > Date: Fri, 29 Dec 2023 11:17:44 -0500
> > > > From: Tom Rini <trini@konsulko.com>
> > > >
> > > > On Fri, Dec 29, 2023 at 05:05:17PM +0100, Heinrich Schuchardt wrote:
> > > > >
> > > > >
> > > > > Am 29. Dezember 2023 16:43:07 MEZ schrieb Tom Rini <trini@konsulk=
o.com>:
> > > > > >On Fri, Dec 29, 2023 at 05:36:09AM +0000, Simon Glass wrote:
> > > > > >> Hi,
> > > > > >>
> > > > > >> On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM Simon Glass <sjg@chrom=
ium.org> wrote:
> > > > > >> >
> > > > > >> > Hi,
> > > > > >> >
> > > > > >> > This records my thoughts after a discussion with Ilias & Hei=
nrich re
> > > > > >> > memory allocation in U-Boot.
> > > > > >> >
> > > > > >> > 1. malloc()
> > > > > >> >
> > > > > >> > malloc() is used for programmatic memory allocation. It allo=
ws memory
> > > > > >> > to be freed. It is not designed for very large allocations (=
e.g. a
> > > > > >> > 10MB kernel or 100MB ramdisk).
> > > > > >> >
> > > > > >> > 2. lmb
> > > > > >> >
> > > > > >> > lmb is used for large blocks of memory, such as those needed=
 for a
> > > > > >> > kernel or ramdisk. Allocation is only transitory, for the pu=
rposes of
> > > > > >> > loading some images and booting. If the boot fails, then all=
 lmb
> > > > > >> > allocations go away.
> > > > > >> >
> > > > > >> > lmb is set up by getting all available memory and then remov=
ing what
> > > > > >> > is used by U-Boot (code, data, malloc() space, etc.)
> > > > > >> >
> > > > > >> > lmb reservations have a few flags so that areas of memory ca=
n be
> > > > > >> > provided with attributes
> > > > > >> >
> > > > > >> > There are some corner cases...e.g. loading a file does an lmb
> > > > > >> > allocation but only for the purpose of avoiding a file being=
 loaded
> > > > > >> > over U-Boot code/data. The allocation is dropped immediately=
 after the
> > > > > >> > file is loaded. Within the bootm command, or when using stan=
dard boot,
> > > > > >> > this would be fairly easy to solve.
> > > > > >> >
> > > > > >> > Linux has renamed lmb to memblock. We should consider doing =
the same.
> > > > > >> >
> > > > > >> > 3. EFI
> > > > > >> >
> > > > > >> > EFI has its own memory-allocation tables.
> > > > > >> >
> > > > > >> > Like lmb, EFI is able to deal with large allocations. But vi=
a a 'pool'
> > > > > >> > function it can also do smaller allocations similar to mallo=
c(),
> > > > > >> > although each one uses at least 4KB at present.
> > > > > >> >
> > > > > >> > EFI allocations do not go away when a boot fails.
> > > > > >> >
> > > > > >> > With EFI it is possible to add allocations post facto, in wh=
ich case
> > > > > >> > they are added to the allocation table just as if the memory=
 was
> > > > > >> > allocated with EFI to begin with.
> > > > > >> >
> > > > > >> > The EFI allocations and the lmb allocations use the same mem=
ory, so in
> > > > > >> > principle could conflict.
> > > > > >> >
> > > > > >> > EFI allocations are sometimes used to allocate internal U-Bo=
ot data as
> > > > > >> > well, if needed by the EFI app. For example, while efi_image=
_parse()
> > > > > >> > uses malloc(), efi_var_mem.c uses EFI allocations since the =
code runs
> > > > > >> > in the app context and may need to access the memory after U=
-Boot has
> > > > > >> > exited. Also efi_smbios.c uses allocate_pages() and then add=
s a new
> > > > > >> > mapping as well.
> > > > > >> >
> > > > > >> > EFI memory has attributes, including what the memory is used=
 for (to
> > > > > >> > some degree of granularity). See enum efi_memory_type and st=
ruct
> > > > > >> > efi_mem_desc. In the latter there are also attribute flags -=
 whether
> > > > > >> > memory is cacheable, etc.
> > > > > >> >
> > > > > >> > EFI also has the x86 idea of 'conventional' memory, meaning =
(I
> > > > > >> > believe) that below 4GB that isn't reserved for the hardware=
/system.
> > > > > >> > This is meaningless, or at least confusing, on ARM systems.
> > > > > >> >
> > > > > >> > 4. reservations
> > > > > >> >
> > > > > >> > It is perhaps worth mentioning a fourth method of memory man=
agement,
> > > > > >> > where U-Boot reserves chunks of memory before relocation (in
> > > > > >> > board_init_f.c), e.g. for the framebuffer, U-Boot code, the =
malloc()
> > > > > >> > region, etc.
> > > > > >> >
> > > > > >> >
> > > > > >> > Problems
> > > > > >> > =E2=80=94-------
> > > > > >> >
> > > > > >> > There are no urgent problems, but here are some things that =
could be improved:
> > > > > >> >
> > > > > >> > 1. EFI should attach most of its data structures to driver m=
odel. This
> > > > > >> > work has started, with the partition support, but more effor=
t would
> > > > > >> > help. This would make it easier to see which memory is relat=
ed to
> > > > > >> > devices and which is separate.
> > > > > >> >
> > > > > >> > 2. Some drivers do EFI reservations today, whether EFI is us=
ed for
> > > > > >> > booting or not (e.g. rockchip video rk_vop_probe()).
> > > > > >> >
> > > > > >> > 3. U-Boot doesn't really map arch-specific memory attributes=
 (e.g.
> > > > > >> > armv8's struct mm_region) to EFI ones.
> > > > > >> >
> > > > > >> > 4. EFI duplicates some code from bootm, some of which relate=
s to
> > > > > >> > memory allocation (e.g. FDT fixup).
> > > > > >> >
> > > > > >> > 5. EFI code is used even if EFI is never used to boot
> > > > > >> >
> > > > > >> > 6. EFI allocations can result in the same memory being used =
as has
> > > > > >> > already been allocated by lmb. Users may load files which ov=
erwrite
> > > > > >> > memory allocated by EFI.
> > > > > >>
> > > > > >> 7. We need to support doing an allocation when a file is loade=
d (to
> > > > > >> ensure files do not overlap), without making it too difficult =
to load
> > > > > >> multiple files to the same place, if desired.
> > > > > >>
> > > > > >> >
> > > > > >> >
> > > > > >> > Lifetime
> > > > > >> > --------
> > > > > >> >
> > > > > >> > We have three different memory allocators with different pur=
poses. Can
> > > > > >> > we unify them a little?
> > > > > >> >
> > > > > >> > Within U-Boot:
> > > > > >> > - malloc() space lives forever
> > > > > >> > - lmb lives while setting out images for booting
> > > > > >> > - EFI (mostly) lives while booting an EFI app
> > > > > >> >
> > > > > >> > In practice, EFI is set up early in U-Boot. Some of this is =
necessary,
> > > > > >> > some not. EFI allocations stay around forever. This works OK=
 since
> > > > > >> > large allocations are normally not done in EFI, so memory is=
n't really
> > > > > >> > consumed to any great degree by the boot process.
> > > > > >> >
> > > > > >> > What happens to EFI allocations if the app returns? They are=
 still
> > > > > >> > present, in case another app is run. This seems fine.
> > > > > >> >
> > > > > >> > API
> > > > > >> > =E2=80=93--
> > > > > >> > Can we unify some APIs?
> > > > > >> >
> > > > > >> > It should be possible to use lmb for large EFI memory alloca=
tions, so
> > > > > >> > long as they are only needed for booting. We effectively do =
this
> > > > > >> > today, since EFI does not manage the arrangement of loaded i=
mages in
> > > > > >> > memory. for the most part.
> > > > > >> >
> > > > > >> > It would not make sense to use EFI allocation to replace lmb=
 and
> > > > > >> > malloc(), of course.
> > > > > >> >
> > > > > >> > Could we use a common (lower-level) API for allocation, used=
 by both
> > > > > >> > lmb and EFI? They do have some similarities. However they ha=
ve
> > > > > >> > different lifetime constraints (EFI allocations are never dr=
opped,
> > > > > >> > unlikely lmb).
> > > > > >> >
> > > > > >> > ** Overall, it seems that the existence of memory allocation=
 in
> > > > > >> > boot-time services has created confusion. Memory allocation =
is
> > > > > >> > muddled, with both U-Boot code and boot-time services callin=
g the same
> > > > > >> > memory allocator. This just has not been clearly thought out.
> > > > > >> >
> > > > > >> >
> > > > > >> > Proposal
> > > > > >> > =E2=80=94-------
> > > > > >> >
> > > > > >> > Here are some ideas:
> > > > > >> >
> > > > > >> > 1. For video, use the driver model API to locate the video r=
egions, or
> > > > > >> > block off the entire framebuffer memory, for all devices as =
a whole.
> > > > > >> > Use efi_add_memory_map()
> > > > > >> >
> > > > > >> > 2. Add memory attributes to UCLASS_RAM and use them in EFI, =
mapping to
> > > > > >> > the EFI_MEMORY_... attributes in struct efi_mem_desc.
> > > > > >> >
> > > > > >> > 3. Add all EFI reservations just before booting the app, as =
we do with
> > > > > >> > devicetree fixup. With this model, malloc() and lmb are used=
 for all
> > > > > >> > allocation. Then efi_add_memory_map() is called for each reg=
ion in
> > > > > >> > turn just before booting. Memory attributes are dealt with a=
bove. The
> > > > > >> > type (enum efi_memory_type) can be determined simply by the =
data
> > > > > >> > structure stored in it, as is done today. For example, SMBIO=
S tables
> > > > > >> > can use EFI_ACPI_RECLAIM_MEMORY. Very few types are used and=
 EFI code
> > > > > >> > understands the meaning of each.
> > > > > >> >
> > > > > >> > 4. Avoid setting up EFI memory at the start of U-Boot. Do it=
 only when
> > > > > >> > booting. This looks to require very little effort.
> > > > > >> >
> > > > > >> > 5. Avoid calling efi_allocate_pages() and efi_allocate_pool(=
) outside
> > > > > >> > boot-time services. This solves the problem 6. If memory is =
needed by
> > > > > >> > an app, allocate it with malloc() and see 3. There are only =
two
> > > > > >> > efi_allocate_pages() (smbios and efi_runtime). There are mor=
e calls of
> > > > > >> > efi_allocate_pool(), but most of these seem easy to fix up. =
For
> > > > > >> > example, efi_init_event_log() allocates a buffer, but this c=
an be
> > > > > >> > allocated in normal malloc() space or in a bloblist.
> > > > > >> >
> > > > > >> > 6. Don't worry too much about whether EFI will be used for b=
ooting.
> > > > > >> > The cost is likely not that great: use bootstage to measure =
it as is
> > > > > >> > done for driver model. Try to minmise the cost of its tables,
> > > > > >> > particularly for execution time, but otherwise just rely on =
the
> > > > > >> > ability to disable EFI_LOADER.
> > > > > >>
> > > > > >> 7. Add a flag to the 'load' command:
> > > > > >>
> > > > > >> -m <type> - make an lmb allocation for the file
> > > > > >>    <type> is the image type to use (kernel, ramdisk, flat_dt)
> > > > > >>
> > > > > >> any existing allocation for that type will be automatically fr=
eed
> > > > > >> first. If <type> is "none" then no freeing is possible: any lo=
aded
> > > > > >> images just stack up in lmb.
> > > > > >>
> > > > > >> Add an 'lmb' (or memblock) command to allow listing and cleari=
ng allocations.
> > > > > >
> > > > > >I would really not like to change the user interface and instead=
 simply
> > > > > >handle this with flags to whatever mark/allocation function is c=
alled.
> > > > > >You can always overwrite things that are brought in to memory, y=
ou
> > > > > >cannot overwrite U-Boot or our internals. Optionally noting that=
 some
> > > > > >previous load to memory has been at least partially overwritten =
could be
> > > > > >helpful, if it's not too much extra logic.
> > > > > >
> > > > >
> > > > > In most use cases users load exactly one file at  each address. An
> > > > > unload command would be the cleanest way for a user to indicate t=
hat
> > > > > he wants to reuse the memory.
> > > >
> > > > I very much do not want to change the API. There's untold numbers of
> > > > scripts out there and they should continue to work. I mentioned to =
Ilias
> > > > off list just now that I'm not against adding a command to add flag=
s to
> > > > these areas, but I don't think it's worthwhile to prevent overwrite=
s the
> > > > user did early. The biggest long running problem in this space was =
that
> > > > for 32bit ARM we couldn't know where the kernel BSS was going to be=
 and
> > > > so would have ramdisk at the wrong spot and get partially eaten, and
> > > > this was hard to figure out. The current example is "ooops,
> > > > decompression buffer for Image.gz/etc is too close to other things"
> > > > which ends up failing nice and loudly, and in the future once this
> > > > proposal is done we can just dynamically find and use a spot, since
> > > > we'll have that ability finally.
> > >
> > > In order to keep the existing interfaces we need lmb to keep track of
> > > (at least ) three different states.  I think of those as "free",
> > > "allocated" and "reserved".  The load command would "reserve" memory
> > > insteaf "allocate".  And it would pass a flag to lmb when reserving
> > > memory to indicate that reserving memory that is already reserved is
> > > ok.  Both "reserved" and "allocated" memory should show up as not free
> > > in the EFI memory map (probably as EfiLoaderData).
> >
> > Yes, something like this is what I was getting at, thanks.
>=20
> Yes, that is a good way of putting it. There is definitely a distinction =
there.
>=20
> If we don't want this flag, we could make U-Boot always do a
> reservation on load, with a '-f' command to force loading over an
> existing reservation / releasing it first?

Again, this is an API change and I don't want to change the API.

> I'm not sure if we still want the proposed lmb command? Perhaps it is
> not needed.

Please lets not call it "lmb" because the current lmb isn't what we want
anymore and it's otherwise probably leading to some of the confusion.
The kernel evolved it to memblocks, so perhaps that terminology too
here. And yes, a command for if nothing else debug / investigation would
be good.

--=20
Tom

--FMsE56JzCJXCCoSz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWRcm4ACgkQFHw5/5Y0
tywPMQwAkEC+L6aJVuokw5/Jp45vRT637egZiW42emhWLSsFpJMN+HldI2zDe8Tb
saikkebHRjVeZPMRNQsxoUaRU//MouIiI56VGZMde57/5/sphJ/h4bjM7BrolHBi
ax6UA3PyTs9Clx4Cwidb1KcZig0GqUju8Ql8boO+5tq2mqlzohzq2j9CaVLVR4+y
WpILMmr6653E1EQIKw5K7SOhtVuRb935urnnYNN/7Ljk1quI7pmtFVt4oYtW/9Vu
iP2S22r4xNFHGJ4pM0MA0ownXj3stRFuZK7eU6RS7sOkD6YMr/hLXqXA4uQoVbXG
bWdINFBzZZmi5W39Vebvj8hxhOX9yT5z5y5h6PombqP6extBtkzseKcrvTnGlVKn
XJ6wdSAf/2kyNGaO6VwAI52/X6OB3m4leXgg479qTMRfObkeo2Ui6ZOCtpo618jT
Y/IFOVfkB6RGAl7xEDUOIiNiWLSzTNCQV2H6cw5IDKtwV5YifdNjUJnHj/WyTsk1
k6HwBWH6
=A6OU
-----END PGP SIGNATURE-----

--FMsE56JzCJXCCoSz--
