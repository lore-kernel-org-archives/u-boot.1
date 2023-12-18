Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064B2C46CA2
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 21:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E126870B4;
	Mon, 18 Dec 2023 22:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B+sOXmwh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F491870B5; Mon, 18 Dec 2023 22:58:18 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C07AF870AB
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 22:58:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5e778e484dbso3773367b3.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 13:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702936694; x=1703541494; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6mpbc68nyB6T3hMgFBp49UvHjrOT+z1w+c5fbNOtM/4=;
 b=B+sOXmwhnVmZdKVSSaVLITVeKXLQueYHTziLqSlNYJdZRito9q352qTA/nE0BCzByD
 6gmOOAnbVHvH7ee2/wqGW0j5Y8C6NmEVgiiQxXKHqc34Z/rreG8wGrop22a7gRw/Econ
 qAO5AB3leDYj5pUdKXtoeLW8nwCULhxVmLLDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702936694; x=1703541494;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mpbc68nyB6T3hMgFBp49UvHjrOT+z1w+c5fbNOtM/4=;
 b=M9AqbNDak/lKQ44YFzgPXX2kC1Jd1mYPjMi655cGnS4b3Ay7b0KwhNZnA7kWmlpQNl
 x/WlRGL/dkCkb/T9Ht2Igo0lKsMqBkvw83OLaAF2gFANHEC039o+BIIYLdRs+qf9REe4
 FllKc4uPmDBJL49+0X3lI1NRul7fxwQoxU3tOORaYf05QFcuAIDI6xMIXWa3xQ6QjGsM
 /jKW0B1RaljHUbP2C9jCRRVEMn8mNEXGe4GFckhZhLWUukrYa23u0MTeyu5Odj2QARub
 W8LBrUuAfXBD1DUOyyHXOLG+BQ0ie8gHvQdey8QhQS8Fdf9lrz7dZKoQ/jDF1dAWYaRO
 2G7Q==
X-Gm-Message-State: AOJu0YxicWYL47edz2J5Dgh4Zd4bFbSfEcMMmdjM0APblN7rkEY9n/U4
 8OpIgmgbJ3C3tYb1wBTZMTXbgV0Gfy3j7fA7nCA=
X-Google-Smtp-Source: AGHT+IEjWMUSMeKRDzutkJG8KCs1kVqm1D143RmhEu7mLFWRpcLJ2lHQDljyDeEp4gVlyTvRxFNoaw==
X-Received: by 2002:a81:6c0e:0:b0:5e1:aa35:2c8b with SMTP id
 h14-20020a816c0e000000b005e1aa352c8bmr9656439ywc.12.1702936694301; 
 Mon, 18 Dec 2023 13:58:14 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 gz9-20020a05690c470900b005e6239d4097sm1545101ywb.21.2023.12.18.13.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 13:58:13 -0800 (PST)
Date: Mon, 18 Dec 2023 16:58:11 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Proposal: U-Boot memory management
Message-ID: <20231218215811.GM2513409@bill-the-cat>
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <a55d0848-c70e-43a9-9223-60515aea8052@gmx.de>
 <CAPnjgZ0r1xM-bky6VQXV4N-FkBC-YFsX1ibJRiJ_17XXAe5ang@mail.gmail.com>
 <D7A16A62-0C71-4374-AAF6-9D021A6C42A2@gmx.de>
 <CAPnjgZ0YBJ9bN4VHbYkR-r3V8winGmm5TA0UXvh-mBLeRgza3g@mail.gmail.com>
 <3A9B3E83-545B-4CAC-9D65-737BD9D6BE0C@gmx.de>
 <CAPnjgZ1=JBEh49G654DfkYM-fcOEhwh=Xuu1scXTLsNkZk2SNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H+8J3/Hg3eVCDOXr"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1=JBEh49G654DfkYM-fcOEhwh=Xuu1scXTLsNkZk2SNQ@mail.gmail.com>
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


--H+8J3/Hg3eVCDOXr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 02:48:43PM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Mon, 18 Dec 2023 at 14:37, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> >
> >
> > Am 18. Dezember 2023 22:03:41 MEZ schrieb Simon Glass <sjg@chromium.org=
>:
> > >Hi Heinrich,
> > >
> > >On Mon, 18 Dec 2023 at 13:00, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
> > >>
> > >>
> > >>
> > >> Am 18. Dezember 2023 19:12:11 MEZ schrieb Simon Glass <sjg@chromium.=
org>:
> > >> >Hi Heinrich,
> > >> >
> > >> >On Sat, 16 Dec 2023 at 12:04, Heinrich Schuchardt <xypron.glpk@gmx.=
de> wrote:
> > >> >>
> > >> >> On 12/16/23 19:01, Simon Glass wrote:
> > >> >> > Hi,
> > >> >> >
> > >> >> > This records my thoughts after a discussion with Ilias & Heinri=
ch re
> > >> >> > memory allocation in U-Boot.
> > >> >> >
> > >> >> > 1. malloc()
> > >> >> >
> > >> >> > malloc() is used for programmatic memory allocation. It allows =
memory
> > >> >> > to be freed. It is not designed for very large allocations (e.g=
=2E a
> > >> >> > 10MB kernel or 100MB ramdisk).
> > >> >> >
> > >> >> > 2. lmb
> > >> >> >
> > >> >> > lmb is used for large blocks of memory, such as those needed fo=
r a
> > >> >> > kernel or ramdisk. Allocation is only transitory, for the purpo=
ses of
> > >> >> > loading some images and booting. If the boot fails, then all lmb
> > >> >> > allocations go away.
> > >> >> >
> > >> >> > lmb is set up by getting all available memory and then removing=
 what
> > >> >> > is used by U-Boot (code, data, malloc() space, etc.)
> > >> >> >
> > >> >> > lmb reservations have a few flags so that areas of memory can be
> > >> >> > provided with attributes
> > >> >> >
> > >> >> > There are some corner cases...e.g. loading a file does an lmb
> > >> >> > allocation but only for the purpose of avoiding a file being lo=
aded
> > >> >> > over U-Boot code/data. The allocation is dropped immediately af=
ter the
> > >> >> > file is loaded. Within the bootm command, or when using standar=
d boot,
> > >> >> > this would be fairly easy to solve.
> > >> >> >
> > >> >> > Linux has renamed lmb to memblock. We should consider doing the=
 same.
> > >> >> >
> > >> >> > 3. EFI
> > >> >> >
> > >> >> > EFI has its own memory-allocation tables.
> > >> >> >
> > >> >> > Like lmb, EFI is able to deal with large allocations. But via a=
 'pool'
> > >> >> > function it can also do smaller allocations similar to malloc(),
> > >> >> > although each one uses at least 4KB at present.
> > >> >> >
> > >> >> > EFI allocations do not go away when a boot fails.
> > >> >> >
> > >> >> > With EFI it is possible to add allocations post facto, in which=
 case
> > >> >> > they are added to the allocation table just as if the memory was
> > >> >> > allocated with EFI to begin with.
> > >> >> >
> > >> >> > The EFI allocations and the lmb allocations use the same memory=
, so in
> > >> >> > principle could conflict.
> > >> >> >
> > >> >> > EFI allocations are sometimes used to allocate internal U-Boot =
data as
> > >> >> > well, if needed by the EFI app. For example, while efi_image_pa=
rse()
> > >> >> > uses malloc(), efi_var_mem.c uses EFI allocations since the cod=
e runs
> > >> >> > in the app context and may need to access the memory after U-Bo=
ot has
> > >> >> > exited. Also efi_smbios.c uses allocate_pages() and then adds a=
 new
> > >> >> > mapping as well.
> > >> >> >
> > >> >> > EFI memory has attributes, including what the memory is used fo=
r (to
> > >> >> > some degree of granularity). See enum efi_memory_type and struct
> > >> >> > efi_mem_desc. In the latter there are also attribute flags - wh=
ether
> > >> >> > memory is cacheable, etc.
> > >> >> >
> > >> >> > EFI also has the x86 idea of 'conventional' memory, meaning (I
> > >> >> > believe) that below 4GB that isn't reserved for the hardware/sy=
stem.
> > >> >> > This is meaningless, or at least confusing, on ARM systems.
> > >> >> >
> > >> >> > 4. reservations
> > >> >> >
> > >> >> > It is perhaps worth mentioning a fourth method of memory manage=
ment,
> > >> >> > where U-Boot reserves chunks of memory before relocation (in
> > >> >> > board_init_f.c), e.g. for the framebuffer, U-Boot code, the mal=
loc()
> > >> >> > region, etc.
> > >> >> >
> > >> >> >
> > >> >> > Problems
> > >> >> > =E2=80=94-------
> > >> >> >
> > >> >> > There are no urgent problems, but here are some things that cou=
ld be improved:
> > >> >> >
> > >> >> > 1. EFI should attach most of its data structures to driver mode=
l. This
> > >> >> > work has started, with the partition support, but more effort w=
ould
> > >> >> > help. This would make it easier to see which memory is related =
to
> > >> >> > devices and which is separate.
> > >> >> >
> > >> >> > 2. Some drivers do EFI reservations today, whether EFI is used =
for
> > >> >> > booting or not (e.g. rockchip video rk_vop_probe()).
> > >> >>
> > >> >> Hello Simon,
> > >> >>
> > >> >> thank you for summarizing our discussion.
> > >> >>
> > >> >> Some U-Boot drivers including rockchip video inform the EFI sub-s=
ystem
> > >> >> that memory is reserved.
> > >> >>
> > >> >> Furthermore drivers like arch/arm/mach-bcm283x/reset.c exist that=
 are
> > >> >> still used after ExitBootServices. mmio addresses have to be upda=
ted
> > >> >> when Linux creates its virtual memory map. Currently this is done=
 via
> > >> >> efi_add_runtime_mmio(). A more UEFI style method would be to regi=
ster an
> > >> >> event handler for ExitBootServices() and use ConvertPointer() in =
the
> > >> >> event handler.
> > >> >>
> > >> >> >
> > >> >> > 3. U-Boot doesn't really map arch-specific memory attributes (e=
=2Eg.
> > >> >> > armv8's struct mm_region) to EFI ones.
> > >> >>
> > >> >> U-Boot fails to set up RWX properties. E.g. the region where a FI=
T image
> > >> >> is loaded should not be executable.
> > >> >>
> > >> >> >
> > >> >> > 4. EFI duplicates some code from bootm, some of which relates to
> > >> >> > memory allocation (e.g. FDT fixup).
> > >> >>
> > >> >> Fixup code is not duplicated but invoked via image_setup_libfdt().
> > >> >>
> > >> >> >
> > >> >> > 5. EFI code is used even if EFI is never used to boot
> > >> >>
> > >> >>
> > >> >> * Only a minimum initialization of the EFI sub-system happens in
> > >> >> efi_init_early().
> > >> >> * Some EFI code is called when probing block devices because we w=
anted
> > >> >> the EFI and the dm part to be integrated.
> > >> >> * The rest of the initialization in efi_init_obj_list() is only i=
nvoked
> > >> >> if an EFI command is invoked.
> > >> >>
> > >> >> >
> > >> >> > 6. EFI allocations can result in the same memory being used as =
has
> > >> >> > already been allocated by lmb. Users may load files which overw=
rite
> > >> >> > memory allocated by EFI.
> > >> >>
> > >> >> The most worrisome issue is that EFI may allocate memory where U-=
Boot
> > >> >> has loaded files like initrd as the EFI sub-system is never infor=
med
> > >> >> which memory is used for files.
> > >> >>
> > >> >> Loading files should not be possible without creating a memory
> > >> >> reservation that becomes visible to the EFI sub-system.
> > >> >>
> > >> >> >
> > >> >> >
> > >> >> > Lifetime
> > >> >> > --------
> > >> >> >
> > >> >> > We have three different memory allocators with different purpos=
es. Can
> > >> >> > we unify them a little?
> > >> >> >
> > >> >> > Within U-Boot:
> > >> >> > - malloc() space lives forever
> > >> >> > - lmb lives while setting out images for booting
> > >> >> > - EFI (mostly) lives while booting an EFI app
> > >> >> >
> > >> >> > In practice, EFI is set up early in U-Boot. Some of this is nec=
essary,
> > >> >> > some not. EFI allocations stay around forever. This works OK si=
nce
> > >> >> > large allocations are normally not done in EFI, so memory isn't=
 really
> > >> >> > consumed to any great degree by the boot process.
> > >> >>
> > >> >> U-Boot can load EFI drivers which stay resident in memory after t=
he
> > >> >> efi_main() method has returned to U-Boot. The next EFI applicatio=
n then
> > >> >> may use the driver. Therefore is essential that the EFI subsystem=
 has
> > >> >> access to a valid memory model at all times.
> > >> >>
> > >> >> >
> > >> >> > What happens to EFI allocations if the app returns? They are st=
ill
> > >> >> > present, in case another app is run. This seems fine.
> > >> >> >
> > >> >> > API
> > >> >> > =E2=80=93--
> > >> >> > Can we unify some APIs?
> > >> >> >
> > >> >> > It should be possible to use lmb for large EFI memory allocatio=
ns, so
> > >> >> > long as they are only needed for booting. We effectively do this
> > >> >> > today, since EFI does not manage the arrangement of loaded imag=
es in
> > >> >> > memory. for the most part.
> > >> >> >
> > >> >> > It would not make sense to use EFI allocation to replace lmb and
> > >> >> > malloc(), of course.
> > >> >> >
> > >> >> > Could we use a common (lower-level) API for allocation, used by=
 both
> > >> >> > lmb and EFI? They do have some similarities. However they have
> > >> >> > different lifetime constraints (EFI allocations are never dropp=
ed,
> > >> >> > unlikely lmb).
> > >> >>
> > >> >> The way lmb is used is a deficiency of U-Boot. E.g. you can load =
an
> > >> >> initrd that overwrites the previously loaded kernel and then try =
to boot.
> > >> >>
> > >> >> What we need is a common memory management library where allocati=
ons are
> > >> >> never dropped and which is used by all file loads.
> > >> >>
> > >> >> >
> > >> >> > ** Overall, it seems that the existence of memory allocation in
> > >> >> > boot-time services has created confusion. Memory allocation is
> > >> >> > muddled, with both U-Boot code and boot-time services calling t=
he same
> > >> >> > memory allocator. This just has not been clearly thought out.
> > >> >> >
> > >> >>
> > >> >> We have to implement what the UEFI specification requires. Some
> > >> >> boot-time services must allocate memory via AllocatePool() or
> > >> >> AllocatePages() because that memory is handed out to the caller o=
f an
> > >> >> API function and it is the callers obligation to free the memory =
via
> > >> >> FreePool() or FreePages().
> > >> >>
> > >> >> >
> > >> >> > Proposal
> > >> >> > =E2=80=94-------
> > >> >> >
> > >> >> > Here are some ideas:
> > >> >> >
> > >> >> > 1. For video, use the driver model API to locate the video regi=
ons, or
> > >> >> > block off the entire framebuffer memory, for all devices as a w=
hole.
> > >> >> > Use efi_add_memory_map()
> > >> >>
> > >> >> When video memory is located higher than the stack the EFI sub-sy=
stem
> > >> >> will not make use of the memory.
> > >> >>
> > >> >> >
> > >> >> > 2. Add memory attributes to UCLASS_RAM and use them in EFI, map=
ping to
> > >> >> > the EFI_MEMORY_... attributes in struct efi_mem_desc.
> > >> >> >
> > >> >> > 3. Add all EFI reservations just before booting the app, as we =
do with
> > >> >> > devicetree fixup. With this model, malloc() and lmb are used fo=
r all
> > >> >> > allocation. Then efi_add_memory_map() is called for each region=
 in
> > >> >> > turn just before booting. Memory attributes are dealt with abov=
e. The
> > >> >> > type (enum efi_memory_type) can be determined simply by the data
> > >> >> > structure stored in it, as is done today. For example, SMBIOS t=
ables
> > >> >> > can use EFI_ACPI_RECLAIM_MEMORY. Very few types are used and EF=
I code
> > >> >> > understands the meaning of each.
> > >> >>
> > >> >> This would require a permanent storage of the reservations. Keep =
it
> > >> >> easy, unify the memory management and make it persistent.
> > >> >>
> > >> >> >
> > >> >> > 4. Avoid setting up EFI memory at the start of U-Boot. Do it on=
ly when
> > >> >> > booting. This looks to require very little effort.
> > >> >>
> > >> >> There is no such thing as EFI memory. We only have one physical m=
emory
> > >> >> that we have to keep track of.
> > >> >>
> > >> >> It is not possible to set up the EFI memory map if you don't keep=
 track
> > >> >> of all memory allocations including all file loads over the whole
> > >> >> lifetime of U-Boot.
> > >> >>
> > >> >> >
> > >> >> > 5. Avoid calling efi_allocate_pages() and efi_allocate_pool() o=
utside
> > >> >> > boot-time services. This solves the problem 6. If memory is nee=
ded by
> > >> >> > an app, allocate it with malloc() and see 3. There are only two
> > >> >> > efi_allocate_pages() (smbios and efi_runtime). There are more c=
alls of
> > >> >> > efi_allocate_pool(), but most of these seem easy to fix up. For
> > >> >> > example, efi_init_event_log() allocates a buffer, but this can =
be
> > >> >> > allocated in normal malloc() space or in a bloblist.
> > >> >>
> > >> >> If we have a unified memory allocation layer, efi_allocate_pages(=
) and
> > >> >> efi_allocate_pool() will be implemented by calls into that layer =
and
> > >> >> issue 6) will vanish.
> > >> >>
> > >> >> >
> > >> >> > 6. Don't worry too much about whether EFI will be used for boot=
ing.
> > >> >> > The cost is likely not that great: use bootstage to measure it =
as is
> > >> >> > done for driver model. Try to minmise the cost of its tables,
> > >> >> > particularly for execution time, but otherwise just rely on the
> > >> >> > ability to disable EFI_LOADER.
> > >> >>
> > >> >> The time intensive part of having EFI enabled is scanning file sy=
stems
> > >> >> for boot files and capsules.
> > >> >
> > >> >Thank you for your thoughts on this.
> > >> >
> > >> >It does not look like my write-up has helped at all with getting
> > >> >aligned on this. Do you have any other ideas?
> > >> >
> > >> >Perhaps we could at least figure out the 'allocation lifetime'
> > >> >approach? It seems clear to me that we have allocations with short
> > >> >lifetimes (e.g. kernel & ramdisk allocations will remain in effect
> > >> >only when booting). Do you agree with that?
> > >>
> > >> We agree that we want to have a unified memory management.
> > >>
> > >> Memory management implies that memory allocations remain in effect u=
ntil the memory is freed.
> > >>
> > >> This must be true for all allocations whether it is for a kernel, a =
ramdisk, for loading a file, for an allocation by an EFI binary, or for any=
thing else.
> > >>
> > >> If boot commands like bootm allocate memory and free it after a fail=
ure, that time will be short.
> > >>
> > >> If a file is loaded and never unloaded that memory allocation must s=
tay until the OS takes over memory management. This is what is missing in U=
-Boot.
> > >
> > >I see that more as a reservation than an allocation. The 'load'
> > >command can never do a useful memory allocation, since the user may
> > >want to load a different file to the same address.
> >
> > We lack an unload command to free the memory.
> >
> > >
> > >We don't 'free' memory reserved for the kernel/ramdisk...the
> > >allocation is only temporary. This is what we need to align on. Those
> > >allocations should be collated and reported to EFI before booting,
> > >then dropped if the boot fails. This in fact works today, with lmb, so
> > >we should not need to change it.
> >
> > Tempory allocations must use a free. This is trivial to implement.
>=20
> I 100% disagree, sorry. We don't want to deal with
> memory-fragmentation issues, etc. This is not an aloc()/free()
> situation. It is an 'image layout' problem.
>=20
> We need to align on this point before we can make any progress.

We may not need the strictness of malloc/free in all cases, but we do
conceptually need to know where things have been shoved in memory that
one might expect to need later.  We may not need to allocate say 10MB of
space up front for a kernel image, but we do need to note that for
later. And we need to consider how good/bad the existing lmb logic is
for "you might be able to overwrite U-Boot, stop!".

--=20
Tom

--H+8J3/Hg3eVCDOXr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWAwGkACgkQFHw5/5Y0
tywLMwv+I15gfpM9hyyKS5zYD1K+Yejsbb1R+PcduvDUMPKH6N4z6l3UJnnhWnHQ
8hQ/4i2kVeo24W0EAGIUDP4nsQ7okTKrz+c6atMdgeKU8Vws3B5Hjc7hDRWZX7x6
I4MWIvvYmWByDpSaKasgu7iT751fw/HIJWG50lWGt81x4Bvor4EAtevm1XSz4xZa
ho3Z+wFuclRciOVT1zAoYa72djLh8kg81XXv3b4Lny/0Cs3duHDiQcYYu/E+xUaQ
aGsTayTUv/rcnaBjDOQaR2xjLEpDept16l66cc7dUKvtSRtpXASYfWFYKXhxTUhl
MJT2y9Dcw1ZIZ1sHWFpB5vGkkTfp83ALseeUNxNkw62BuapLNwb1X1XvwYh046Li
1Hi7CSh5H+DAOgi+kjj4iWjOdQi8f4USjL5IhmSwhuLlWVthL/3RV0eM94npd5j1
0nbyoXRmihwVDWO32oXabwxPGYbOZVMCUNV/z4uRPS1bSqT9aCqv9owxGz1i2ftK
L1EtgKmw
=hZ5Q
-----END PGP SIGNATURE-----

--H+8J3/Hg3eVCDOXr--
