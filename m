Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CA2C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 21:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06FD5870B7;
	Mon, 18 Dec 2023 22:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qpvuJYGK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A60D2870D4; Mon, 18 Dec 2023 22:46:19 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BDA5870B5
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 22:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-77f8dd477fcso250136185a.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 13:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702935976; x=1703540776; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CRc1L9s1Pn8Vw/vYbrz2HeAj3jYb7YDPSA2sBR/qvaM=;
 b=qpvuJYGKgpA16hU0GEQIblEfFKVhVH6I+c3Y7Fw0ybrKpAUCT5tfiwWzajIoHa+wlT
 UMPWzf6LCBHkVyCiDYDAIU7sxtroXuG00IeI0IQxlOYKDKfvUNv4oLkQd7tOjHWS9pvg
 bTxd0wgAVUELFETRnF0by33fxV8NogXmVgd4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702935976; x=1703540776;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRc1L9s1Pn8Vw/vYbrz2HeAj3jYb7YDPSA2sBR/qvaM=;
 b=FcKIdlWVKPyjUW0S50MEwGRA5OPMtkSXmeOn7vvA8LjvipijvkK2TUDnbAMHwN6wfH
 aCWxqRZ8avDPzeWIJe5a86t4mehDhgjw6s+soZv/X90M7q9zw7eUqtPYOsNahjFg55TA
 rFt/I4soyFDZt5Jv7hsFn4xvfrlHBIBlu3Zhfr4cfkpJUoHewj3gLfZ/bUjJ+Qeo/NN8
 5ErdIBTE9OgCeWMe7U5S0R6SaRUCgVqO1pUHkDrgsudjKpZOYeMBjHggTyg7QbPB8yT5
 DrC545MvcNAVM2mpbEI8dmGB9ea7aI0qyXsqB4faq6MLy8hz6t22d/veS3pTtablXI3W
 F53g==
X-Gm-Message-State: AOJu0YwO9NDvafKK9QA4qxpqBdXQ8KaSMm8WDLd4iEVBChl4sl83GH2q
 +dAPlFP2CZdrTtb8L/nAV68UBQ==
X-Google-Smtp-Source: AGHT+IEve5NFMtsQ4Daad6u2rE2izWCTzH/+zGi4azaKS8QgLEvhDcR4TMYbew8xlyHicgT2HpqSLQ==
X-Received: by 2002:a05:620a:268b:b0:77f:6128:a9c6 with SMTP id
 c11-20020a05620a268b00b0077f6128a9c6mr21743788qkp.104.1702935975784; 
 Mon, 18 Dec 2023 13:46:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 eb10-20020a05620a480a00b0077f38324d84sm8645632qkb.109.2023.12.18.13.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 13:46:15 -0800 (PST)
Date: Mon, 18 Dec 2023 16:46:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Proposal: U-Boot memory management
Message-ID: <20231218214613.GL2513409@bill-the-cat>
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <a55d0848-c70e-43a9-9223-60515aea8052@gmx.de>
 <CAPnjgZ0r1xM-bky6VQXV4N-FkBC-YFsX1ibJRiJ_17XXAe5ang@mail.gmail.com>
 <D7A16A62-0C71-4374-AAF6-9D021A6C42A2@gmx.de>
 <CAPnjgZ0YBJ9bN4VHbYkR-r3V8winGmm5TA0UXvh-mBLeRgza3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C0AHZtqMUHJftfxz"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0YBJ9bN4VHbYkR-r3V8winGmm5TA0UXvh-mBLeRgza3g@mail.gmail.com>
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


--C0AHZtqMUHJftfxz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 02:03:41PM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Mon, 18 Dec 2023 at 13:00, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> >
> >
> > Am 18. Dezember 2023 19:12:11 MEZ schrieb Simon Glass <sjg@chromium.org=
>:
> > >Hi Heinrich,
> > >
> > >On Sat, 16 Dec 2023 at 12:04, Heinrich Schuchardt <xypron.glpk@gmx.de>=
 wrote:
> > >>
> > >> On 12/16/23 19:01, Simon Glass wrote:
> > >> > Hi,
> > >> >
> > >> > This records my thoughts after a discussion with Ilias & Heinrich =
re
> > >> > memory allocation in U-Boot.
> > >> >
> > >> > 1. malloc()
> > >> >
> > >> > malloc() is used for programmatic memory allocation. It allows mem=
ory
> > >> > to be freed. It is not designed for very large allocations (e.g. a
> > >> > 10MB kernel or 100MB ramdisk).
> > >> >
> > >> > 2. lmb
> > >> >
> > >> > lmb is used for large blocks of memory, such as those needed for a
> > >> > kernel or ramdisk. Allocation is only transitory, for the purposes=
 of
> > >> > loading some images and booting. If the boot fails, then all lmb
> > >> > allocations go away.
> > >> >
> > >> > lmb is set up by getting all available memory and then removing wh=
at
> > >> > is used by U-Boot (code, data, malloc() space, etc.)
> > >> >
> > >> > lmb reservations have a few flags so that areas of memory can be
> > >> > provided with attributes
> > >> >
> > >> > There are some corner cases...e.g. loading a file does an lmb
> > >> > allocation but only for the purpose of avoiding a file being loaded
> > >> > over U-Boot code/data. The allocation is dropped immediately after=
 the
> > >> > file is loaded. Within the bootm command, or when using standard b=
oot,
> > >> > this would be fairly easy to solve.
> > >> >
> > >> > Linux has renamed lmb to memblock. We should consider doing the sa=
me.
> > >> >
> > >> > 3. EFI
> > >> >
> > >> > EFI has its own memory-allocation tables.
> > >> >
> > >> > Like lmb, EFI is able to deal with large allocations. But via a 'p=
ool'
> > >> > function it can also do smaller allocations similar to malloc(),
> > >> > although each one uses at least 4KB at present.
> > >> >
> > >> > EFI allocations do not go away when a boot fails.
> > >> >
> > >> > With EFI it is possible to add allocations post facto, in which ca=
se
> > >> > they are added to the allocation table just as if the memory was
> > >> > allocated with EFI to begin with.
> > >> >
> > >> > The EFI allocations and the lmb allocations use the same memory, s=
o in
> > >> > principle could conflict.
> > >> >
> > >> > EFI allocations are sometimes used to allocate internal U-Boot dat=
a as
> > >> > well, if needed by the EFI app. For example, while efi_image_parse=
()
> > >> > uses malloc(), efi_var_mem.c uses EFI allocations since the code r=
uns
> > >> > in the app context and may need to access the memory after U-Boot =
has
> > >> > exited. Also efi_smbios.c uses allocate_pages() and then adds a new
> > >> > mapping as well.
> > >> >
> > >> > EFI memory has attributes, including what the memory is used for (=
to
> > >> > some degree of granularity). See enum efi_memory_type and struct
> > >> > efi_mem_desc. In the latter there are also attribute flags - wheth=
er
> > >> > memory is cacheable, etc.
> > >> >
> > >> > EFI also has the x86 idea of 'conventional' memory, meaning (I
> > >> > believe) that below 4GB that isn't reserved for the hardware/syste=
m.
> > >> > This is meaningless, or at least confusing, on ARM systems.
> > >> >
> > >> > 4. reservations
> > >> >
> > >> > It is perhaps worth mentioning a fourth method of memory managemen=
t,
> > >> > where U-Boot reserves chunks of memory before relocation (in
> > >> > board_init_f.c), e.g. for the framebuffer, U-Boot code, the malloc=
()
> > >> > region, etc.
> > >> >
> > >> >
> > >> > Problems
> > >> > =E2=80=94-------
> > >> >
> > >> > There are no urgent problems, but here are some things that could =
be improved:
> > >> >
> > >> > 1. EFI should attach most of its data structures to driver model. =
This
> > >> > work has started, with the partition support, but more effort would
> > >> > help. This would make it easier to see which memory is related to
> > >> > devices and which is separate.
> > >> >
> > >> > 2. Some drivers do EFI reservations today, whether EFI is used for
> > >> > booting or not (e.g. rockchip video rk_vop_probe()).
> > >>
> > >> Hello Simon,
> > >>
> > >> thank you for summarizing our discussion.
> > >>
> > >> Some U-Boot drivers including rockchip video inform the EFI sub-syst=
em
> > >> that memory is reserved.
> > >>
> > >> Furthermore drivers like arch/arm/mach-bcm283x/reset.c exist that are
> > >> still used after ExitBootServices. mmio addresses have to be updated
> > >> when Linux creates its virtual memory map. Currently this is done via
> > >> efi_add_runtime_mmio(). A more UEFI style method would be to registe=
r an
> > >> event handler for ExitBootServices() and use ConvertPointer() in the
> > >> event handler.
> > >>
> > >> >
> > >> > 3. U-Boot doesn't really map arch-specific memory attributes (e.g.
> > >> > armv8's struct mm_region) to EFI ones.
> > >>
> > >> U-Boot fails to set up RWX properties. E.g. the region where a FIT i=
mage
> > >> is loaded should not be executable.
> > >>
> > >> >
> > >> > 4. EFI duplicates some code from bootm, some of which relates to
> > >> > memory allocation (e.g. FDT fixup).
> > >>
> > >> Fixup code is not duplicated but invoked via image_setup_libfdt().
> > >>
> > >> >
> > >> > 5. EFI code is used even if EFI is never used to boot
> > >>
> > >>
> > >> * Only a minimum initialization of the EFI sub-system happens in
> > >> efi_init_early().
> > >> * Some EFI code is called when probing block devices because we want=
ed
> > >> the EFI and the dm part to be integrated.
> > >> * The rest of the initialization in efi_init_obj_list() is only invo=
ked
> > >> if an EFI command is invoked.
> > >>
> > >> >
> > >> > 6. EFI allocations can result in the same memory being used as has
> > >> > already been allocated by lmb. Users may load files which overwrite
> > >> > memory allocated by EFI.
> > >>
> > >> The most worrisome issue is that EFI may allocate memory where U-Boot
> > >> has loaded files like initrd as the EFI sub-system is never informed
> > >> which memory is used for files.
> > >>
> > >> Loading files should not be possible without creating a memory
> > >> reservation that becomes visible to the EFI sub-system.
> > >>
> > >> >
> > >> >
> > >> > Lifetime
> > >> > --------
> > >> >
> > >> > We have three different memory allocators with different purposes.=
 Can
> > >> > we unify them a little?
> > >> >
> > >> > Within U-Boot:
> > >> > - malloc() space lives forever
> > >> > - lmb lives while setting out images for booting
> > >> > - EFI (mostly) lives while booting an EFI app
> > >> >
> > >> > In practice, EFI is set up early in U-Boot. Some of this is necess=
ary,
> > >> > some not. EFI allocations stay around forever. This works OK since
> > >> > large allocations are normally not done in EFI, so memory isn't re=
ally
> > >> > consumed to any great degree by the boot process.
> > >>
> > >> U-Boot can load EFI drivers which stay resident in memory after the
> > >> efi_main() method has returned to U-Boot. The next EFI application t=
hen
> > >> may use the driver. Therefore is essential that the EFI subsystem has
> > >> access to a valid memory model at all times.
> > >>
> > >> >
> > >> > What happens to EFI allocations if the app returns? They are still
> > >> > present, in case another app is run. This seems fine.
> > >> >
> > >> > API
> > >> > =E2=80=93--
> > >> > Can we unify some APIs?
> > >> >
> > >> > It should be possible to use lmb for large EFI memory allocations,=
 so
> > >> > long as they are only needed for booting. We effectively do this
> > >> > today, since EFI does not manage the arrangement of loaded images =
in
> > >> > memory. for the most part.
> > >> >
> > >> > It would not make sense to use EFI allocation to replace lmb and
> > >> > malloc(), of course.
> > >> >
> > >> > Could we use a common (lower-level) API for allocation, used by bo=
th
> > >> > lmb and EFI? They do have some similarities. However they have
> > >> > different lifetime constraints (EFI allocations are never dropped,
> > >> > unlikely lmb).
> > >>
> > >> The way lmb is used is a deficiency of U-Boot. E.g. you can load an
> > >> initrd that overwrites the previously loaded kernel and then try to =
boot.
> > >>
> > >> What we need is a common memory management library where allocations=
 are
> > >> never dropped and which is used by all file loads.
> > >>
> > >> >
> > >> > ** Overall, it seems that the existence of memory allocation in
> > >> > boot-time services has created confusion. Memory allocation is
> > >> > muddled, with both U-Boot code and boot-time services calling the =
same
> > >> > memory allocator. This just has not been clearly thought out.
> > >> >
> > >>
> > >> We have to implement what the UEFI specification requires. Some
> > >> boot-time services must allocate memory via AllocatePool() or
> > >> AllocatePages() because that memory is handed out to the caller of an
> > >> API function and it is the callers obligation to free the memory via
> > >> FreePool() or FreePages().
> > >>
> > >> >
> > >> > Proposal
> > >> > =E2=80=94-------
> > >> >
> > >> > Here are some ideas:
> > >> >
> > >> > 1. For video, use the driver model API to locate the video regions=
, or
> > >> > block off the entire framebuffer memory, for all devices as a whol=
e.
> > >> > Use efi_add_memory_map()
> > >>
> > >> When video memory is located higher than the stack the EFI sub-system
> > >> will not make use of the memory.
> > >>
> > >> >
> > >> > 2. Add memory attributes to UCLASS_RAM and use them in EFI, mappin=
g to
> > >> > the EFI_MEMORY_... attributes in struct efi_mem_desc.
> > >> >
> > >> > 3. Add all EFI reservations just before booting the app, as we do =
with
> > >> > devicetree fixup. With this model, malloc() and lmb are used for a=
ll
> > >> > allocation. Then efi_add_memory_map() is called for each region in
> > >> > turn just before booting. Memory attributes are dealt with above. =
The
> > >> > type (enum efi_memory_type) can be determined simply by the data
> > >> > structure stored in it, as is done today. For example, SMBIOS tabl=
es
> > >> > can use EFI_ACPI_RECLAIM_MEMORY. Very few types are used and EFI c=
ode
> > >> > understands the meaning of each.
> > >>
> > >> This would require a permanent storage of the reservations. Keep it
> > >> easy, unify the memory management and make it persistent.
> > >>
> > >> >
> > >> > 4. Avoid setting up EFI memory at the start of U-Boot. Do it only =
when
> > >> > booting. This looks to require very little effort.
> > >>
> > >> There is no such thing as EFI memory. We only have one physical memo=
ry
> > >> that we have to keep track of.
> > >>
> > >> It is not possible to set up the EFI memory map if you don't keep tr=
ack
> > >> of all memory allocations including all file loads over the whole
> > >> lifetime of U-Boot.
> > >>
> > >> >
> > >> > 5. Avoid calling efi_allocate_pages() and efi_allocate_pool() outs=
ide
> > >> > boot-time services. This solves the problem 6. If memory is needed=
 by
> > >> > an app, allocate it with malloc() and see 3. There are only two
> > >> > efi_allocate_pages() (smbios and efi_runtime). There are more call=
s of
> > >> > efi_allocate_pool(), but most of these seem easy to fix up. For
> > >> > example, efi_init_event_log() allocates a buffer, but this can be
> > >> > allocated in normal malloc() space or in a bloblist.
> > >>
> > >> If we have a unified memory allocation layer, efi_allocate_pages() a=
nd
> > >> efi_allocate_pool() will be implemented by calls into that layer and
> > >> issue 6) will vanish.
> > >>
> > >> >
> > >> > 6. Don't worry too much about whether EFI will be used for booting.
> > >> > The cost is likely not that great: use bootstage to measure it as =
is
> > >> > done for driver model. Try to minmise the cost of its tables,
> > >> > particularly for execution time, but otherwise just rely on the
> > >> > ability to disable EFI_LOADER.
> > >>
> > >> The time intensive part of having EFI enabled is scanning file syste=
ms
> > >> for boot files and capsules.
> > >
> > >Thank you for your thoughts on this.
> > >
> > >It does not look like my write-up has helped at all with getting
> > >aligned on this. Do you have any other ideas?
> > >
> > >Perhaps we could at least figure out the 'allocation lifetime'
> > >approach? It seems clear to me that we have allocations with short
> > >lifetimes (e.g. kernel & ramdisk allocations will remain in effect
> > >only when booting). Do you agree with that?
> >
> > We agree that we want to have a unified memory management.
> >
> > Memory management implies that memory allocations remain in effect unti=
l the memory is freed.
> >
> > This must be true for all allocations whether it is for a kernel, a ram=
disk, for loading a file, for an allocation by an EFI binary, or for anythi=
ng else.
> >
> > If boot commands like bootm allocate memory and free it after a failure=
, that time will be short.
> >
> > If a file is loaded and never unloaded that memory allocation must stay=
 until the OS takes over memory management. This is what is missing in U-Bo=
ot.
>=20
> I see that more as a reservation than an allocation. The 'load'
> command can never do a useful memory allocation, since the user may
> want to load a different file to the same address.
>=20
> We don't 'free' memory reserved for the kernel/ramdisk...the
> allocation is only temporary. This is what we need to align on. Those
> allocations should be collated and reported to EFI before booting,
> then dropped if the boot fails. This in fact works today, with lmb, so
> we should not need to change it.

I think this emphasises bugs of lmb as being features when they really
shouldn't be. There's classes of CVE that we attempt to paper over today
with lmb, but should really fix instead. The only thing lmb is doing in
bootm is trying to make sure that since we (almost certainly) want to
move the fdt, we don't move it on top of something else we're trying to
boot (or, oh, ourself I guess too).

--=20
Tom

--C0AHZtqMUHJftfxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWAvaIACgkQFHw5/5Y0
tyyMHgv9F4Thj6AYi4KaRGvXmPAb53lcUU2QH3vKA4fweJcerB5xQVHCBgd0O3qh
SOhfF2+OEHWjMhcR06rdyVEphoTXAUr36UCIcZvAt0vhq7l/aqRtOGpC7rYrpswf
lNoS8WSQzIIDHxgCfm7JqLlCBKWz9G6F0H9oo2cZ/W9pc+3f+72bsbJHcXjFVal/
jHxK+q+Yfuz31gEZz4QNsV6HlnPfG1c4b0VuB9EuS6ghdMPfptTxbsGCiJp+STx9
Iq5083poEFP2H2cg/aIiOyIcRWLCLGckBclsuArr5euWDdzU/oFxNvM2F5yFe+xm
rNdIegSAmdT/9DM1M7X+sJ3167gT1D4lw28D7V7CUkQ9fORylrOu1qAU9pNZDyrH
87zoenou2vqkOyrort2cLsVq7jezn7ky07Nf+4JGCzrj6dI4LxECP1Wn5vRUup/T
7u/+vp68VIZbT1wtTF3UPC7ZvMgFFt1Lx2qd7CqZyusTOQfdvtW41Hb84H411CxU
i/UclT5U
=xJmd
-----END PGP SIGNATURE-----

--C0AHZtqMUHJftfxz--
