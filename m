Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B20C47072
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 15:43:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9FF687AA2;
	Fri, 29 Dec 2023 16:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WOkcK7SC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F16987AC9; Fri, 29 Dec 2023 16:43:14 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A663B87A54
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 16:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dbd990ad852so5025374276.1
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 07:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703864590; x=1704469390; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XMLNMfW9J7XdrO54hxngyIne7O3DACimhu1QICOSz5s=;
 b=WOkcK7SCXAuk3HEab1sXCDrrQhhj1PKHnOyIFjnfjS+FQsTuyEJ40L+RAOtnulnfEh
 znuPKQIlK3otWVYQy0e5/sVF9S31xjFudfBijA5Ez67IfoVfX19AkB94tRwGCbzFIufn
 rSt0xnSWFJ0AmpITUU2stDXm+ICJlusHCm93k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703864590; x=1704469390;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMLNMfW9J7XdrO54hxngyIne7O3DACimhu1QICOSz5s=;
 b=JbnybWUZAy3H8DIiBfdEBhvooXJehQi5htqXrnqoViz5MLg1I1H8qbkNpAHHILJkxs
 zlbCM4M3PjlqwO0oiEJ6swQiMzzK387R76kDhR0BG2luzed37YAXBjX2f9dWT1zK1iZM
 QyjtNBgZ7iIYygB34ilMVDXMTPxHQPFgxaLlsABSrQWJQM8oYjAjhAPA061eqcMXTvP1
 pzL875VUX9zdQZOGEkjyeAJxiJEyrI1U4PzIaV/e4opveM7md/W4X2FVtm9op9VIw7ku
 2TK+qPfgc7VyLuWxum3Dp6mVILDHGSqV37vXjn99HOKxilaFj2LBWNvMEMBXogwJi+oY
 wPfg==
X-Gm-Message-State: AOJu0Yy9h8sKCgJDVR3P/e759K85RsJTTcZTA5A3engH30wVG6PVnYyL
 0yqh+8bV+MUzxIQLvBKo1HsalJUn97kF4g==
X-Google-Smtp-Source: AGHT+IF4uPcE3sr5pNi548f76ogYZCqaP8ejV38HPYSNsb2Aa2xkv+Mg0Q8f0kMrGw+0APjup0fMSw==
X-Received: by 2002:a25:3615:0:b0:dbd:c1f1:4ff8 with SMTP id
 d21-20020a253615000000b00dbdc1f14ff8mr6820398yba.44.1703864590248; 
 Fri, 29 Dec 2023 07:43:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 h17-20020a258a91000000b00dbd5b48cce1sm6912065ybl.2.2023.12.29.07.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 07:43:09 -0800 (PST)
Date: Fri, 29 Dec 2023 10:43:07 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: Proposal: U-Boot memory management
Message-ID: <20231229154307.GS2652760@bill-the-cat>
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <CAFLszThqH01GOqnTxucVE7s+wJU-dz7uqUtkb4iKxs6GgX6tqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p+3roYuRee6gGero"
Content-Disposition: inline
In-Reply-To: <CAFLszThqH01GOqnTxucVE7s+wJU-dz7uqUtkb4iKxs6GgX6tqw@mail.gmail.com>
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


--p+3roYuRee6gGero
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 05:36:09AM +0000, Simon Glass wrote:
> Hi,
>=20
> On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi,
> >
> > This records my thoughts after a discussion with Ilias & Heinrich re
> > memory allocation in U-Boot.
> >
> > 1. malloc()
> >
> > malloc() is used for programmatic memory allocation. It allows memory
> > to be freed. It is not designed for very large allocations (e.g. a
> > 10MB kernel or 100MB ramdisk).
> >
> > 2. lmb
> >
> > lmb is used for large blocks of memory, such as those needed for a
> > kernel or ramdisk. Allocation is only transitory, for the purposes of
> > loading some images and booting. If the boot fails, then all lmb
> > allocations go away.
> >
> > lmb is set up by getting all available memory and then removing what
> > is used by U-Boot (code, data, malloc() space, etc.)
> >
> > lmb reservations have a few flags so that areas of memory can be
> > provided with attributes
> >
> > There are some corner cases...e.g. loading a file does an lmb
> > allocation but only for the purpose of avoiding a file being loaded
> > over U-Boot code/data. The allocation is dropped immediately after the
> > file is loaded. Within the bootm command, or when using standard boot,
> > this would be fairly easy to solve.
> >
> > Linux has renamed lmb to memblock. We should consider doing the same.
> >
> > 3. EFI
> >
> > EFI has its own memory-allocation tables.
> >
> > Like lmb, EFI is able to deal with large allocations. But via a 'pool'
> > function it can also do smaller allocations similar to malloc(),
> > although each one uses at least 4KB at present.
> >
> > EFI allocations do not go away when a boot fails.
> >
> > With EFI it is possible to add allocations post facto, in which case
> > they are added to the allocation table just as if the memory was
> > allocated with EFI to begin with.
> >
> > The EFI allocations and the lmb allocations use the same memory, so in
> > principle could conflict.
> >
> > EFI allocations are sometimes used to allocate internal U-Boot data as
> > well, if needed by the EFI app. For example, while efi_image_parse()
> > uses malloc(), efi_var_mem.c uses EFI allocations since the code runs
> > in the app context and may need to access the memory after U-Boot has
> > exited. Also efi_smbios.c uses allocate_pages() and then adds a new
> > mapping as well.
> >
> > EFI memory has attributes, including what the memory is used for (to
> > some degree of granularity). See enum efi_memory_type and struct
> > efi_mem_desc. In the latter there are also attribute flags - whether
> > memory is cacheable, etc.
> >
> > EFI also has the x86 idea of 'conventional' memory, meaning (I
> > believe) that below 4GB that isn't reserved for the hardware/system.
> > This is meaningless, or at least confusing, on ARM systems.
> >
> > 4. reservations
> >
> > It is perhaps worth mentioning a fourth method of memory management,
> > where U-Boot reserves chunks of memory before relocation (in
> > board_init_f.c), e.g. for the framebuffer, U-Boot code, the malloc()
> > region, etc.
> >
> >
> > Problems
> > =E2=80=94-------
> >
> > There are no urgent problems, but here are some things that could be im=
proved:
> >
> > 1. EFI should attach most of its data structures to driver model. This
> > work has started, with the partition support, but more effort would
> > help. This would make it easier to see which memory is related to
> > devices and which is separate.
> >
> > 2. Some drivers do EFI reservations today, whether EFI is used for
> > booting or not (e.g. rockchip video rk_vop_probe()).
> >
> > 3. U-Boot doesn't really map arch-specific memory attributes (e.g.
> > armv8's struct mm_region) to EFI ones.
> >
> > 4. EFI duplicates some code from bootm, some of which relates to
> > memory allocation (e.g. FDT fixup).
> >
> > 5. EFI code is used even if EFI is never used to boot
> >
> > 6. EFI allocations can result in the same memory being used as has
> > already been allocated by lmb. Users may load files which overwrite
> > memory allocated by EFI.
>=20
> 7. We need to support doing an allocation when a file is loaded (to
> ensure files do not overlap), without making it too difficult to load
> multiple files to the same place, if desired.
>=20
> >
> >
> > Lifetime
> > --------
> >
> > We have three different memory allocators with different purposes. Can
> > we unify them a little?
> >
> > Within U-Boot:
> > - malloc() space lives forever
> > - lmb lives while setting out images for booting
> > - EFI (mostly) lives while booting an EFI app
> >
> > In practice, EFI is set up early in U-Boot. Some of this is necessary,
> > some not. EFI allocations stay around forever. This works OK since
> > large allocations are normally not done in EFI, so memory isn't really
> > consumed to any great degree by the boot process.
> >
> > What happens to EFI allocations if the app returns? They are still
> > present, in case another app is run. This seems fine.
> >
> > API
> > =E2=80=93--
> > Can we unify some APIs?
> >
> > It should be possible to use lmb for large EFI memory allocations, so
> > long as they are only needed for booting. We effectively do this
> > today, since EFI does not manage the arrangement of loaded images in
> > memory. for the most part.
> >
> > It would not make sense to use EFI allocation to replace lmb and
> > malloc(), of course.
> >
> > Could we use a common (lower-level) API for allocation, used by both
> > lmb and EFI? They do have some similarities. However they have
> > different lifetime constraints (EFI allocations are never dropped,
> > unlikely lmb).
> >
> > ** Overall, it seems that the existence of memory allocation in
> > boot-time services has created confusion. Memory allocation is
> > muddled, with both U-Boot code and boot-time services calling the same
> > memory allocator. This just has not been clearly thought out.
> >
> >
> > Proposal
> > =E2=80=94-------
> >
> > Here are some ideas:
> >
> > 1. For video, use the driver model API to locate the video regions, or
> > block off the entire framebuffer memory, for all devices as a whole.
> > Use efi_add_memory_map()
> >
> > 2. Add memory attributes to UCLASS_RAM and use them in EFI, mapping to
> > the EFI_MEMORY_... attributes in struct efi_mem_desc.
> >
> > 3. Add all EFI reservations just before booting the app, as we do with
> > devicetree fixup. With this model, malloc() and lmb are used for all
> > allocation. Then efi_add_memory_map() is called for each region in
> > turn just before booting. Memory attributes are dealt with above. The
> > type (enum efi_memory_type) can be determined simply by the data
> > structure stored in it, as is done today. For example, SMBIOS tables
> > can use EFI_ACPI_RECLAIM_MEMORY. Very few types are used and EFI code
> > understands the meaning of each.
> >
> > 4. Avoid setting up EFI memory at the start of U-Boot. Do it only when
> > booting. This looks to require very little effort.
> >
> > 5. Avoid calling efi_allocate_pages() and efi_allocate_pool() outside
> > boot-time services. This solves the problem 6. If memory is needed by
> > an app, allocate it with malloc() and see 3. There are only two
> > efi_allocate_pages() (smbios and efi_runtime). There are more calls of
> > efi_allocate_pool(), but most of these seem easy to fix up. For
> > example, efi_init_event_log() allocates a buffer, but this can be
> > allocated in normal malloc() space or in a bloblist.
> >
> > 6. Don't worry too much about whether EFI will be used for booting.
> > The cost is likely not that great: use bootstage to measure it as is
> > done for driver model. Try to minmise the cost of its tables,
> > particularly for execution time, but otherwise just rely on the
> > ability to disable EFI_LOADER.
>=20
> 7. Add a flag to the 'load' command:
>=20
> -m <type> - make an lmb allocation for the file
>    <type> is the image type to use (kernel, ramdisk, flat_dt)
>=20
> any existing allocation for that type will be automatically freed
> first. If <type> is "none" then no freeing is possible: any loaded
> images just stack up in lmb.
>=20
> Add an 'lmb' (or memblock) command to allow listing and clearing allocati=
ons.

I would really not like to change the user interface and instead simply
handle this with flags to whatever mark/allocation function is called.
You can always overwrite things that are brought in to memory, you
cannot overwrite U-Boot or our internals. Optionally noting that some
previous load to memory has been at least partially overwritten could be
helpful, if it's not too much extra logic.

--=20
Tom

--p+3roYuRee6gGero
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWO6QEACgkQFHw5/5Y0
tyzQWQv+N//tuhPGY3/HWjZuaOvCl4f+1E5YYfD1IAHemMn3pdw5kSKjj57dMUSi
M280kwN7lMX5y6Jrg8/8fU0ylABodfDavMZ6rQjVTDEF89AEfLkhKXvqLtZ+Yv9E
2JPnOvOooSey0Iq5BKujizF9miqNCdRYd5bLqekD0dpReYTepN2wKULbzYH48VMW
TF0peDshG20NlZUsASLHtSHPQnJqYi3MUvhRcUoOBzNVvPDTslTHlCULBqTYZCGx
C49mrrkp9iNYb0no1F23Sp1Rrd3LipeW1OSF4FofdKANALYLQiGUwcegnGKVghQL
j39XvNTD5nFPFu5KqjpzGa5BYNCCZhXiC6jtBwLvlCgqTbu0pHW3t85kaa8PHYBf
SdctYlbY196MK680OqS/pq163pbhsBdso7YLg1m04C9qA/BEENB5PJ5sSWz37dgR
riCnsWUsjvb+CZhJCG3I/JwLBK+1eJzlkVWdsWqsJLVHKzLtp8DCxkErJakAfnIZ
VZaeqVwl
=Lgmc
-----END PGP SIGNATURE-----

--p+3roYuRee6gGero--
