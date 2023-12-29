Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3316FC47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9AB387BAC;
	Fri, 29 Dec 2023 18:52:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Id6kWJTa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A58387BAF; Fri, 29 Dec 2023 18:52:21 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC86987B8F
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:52:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dbd7248ac28so4719950276.2
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 09:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703872337; x=1704477137; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3ZTCYy3xYLXJNjF7aBVbeeQSbN9IitfsKOjpVs91vt8=;
 b=Id6kWJTaJqx2q+OAS0aaHW3ZPwlunAAlVbGS/J68qfN1hmHqIirE38KE63JMauFXPM
 xB2adqdPK/iop4re35l8g1zYbNmtGmKe//TCsSW86mBk2yLOtXGMcBjpKO0IKrxcNH/p
 /g9kAhAJSK7d1M1tmisdyHO8nCEucnoZJcte8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703872337; x=1704477137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ZTCYy3xYLXJNjF7aBVbeeQSbN9IitfsKOjpVs91vt8=;
 b=MuqHrybTgP9X2Su+lywKuxsVPvA7IoVIx5HACApeBwxwFzrBBpINf6IKHUyO/cfDMQ
 nGMNwWY9+Yj/FYEzmlJbIc5QUNV035TDia9JR8sm5jrxHJ/uQEPHkJKCXg/D/mjr/dR6
 DJW6PjDeZSp6+qatb1GqEHgGaIHBbt/3j+zn9IWpCH1wLPmvlquYK48QY03gbjJxtcL8
 jsaCMP+Jcx0oJNfUM8vA4nDmQmKy9JE8vrzd//gsKMfxgUC00Za3n9Pge1Imp61EpDhs
 7LV8oGuE8lKNVuPa54lqAXUzFYp4C07aA5Mfuv9YiKl9gAMQi+cI7cSg5ArxBIaE/8wY
 +s8w==
X-Gm-Message-State: AOJu0Yx20mc4Xsh8K+OnV9zPsvjuxtK8AidDcOwwcHx8QiurrW8T7C0r
 GEYxT72tW0h/gMDGX9s/671Arnd+OMGxWfnQ7hF9x7Uxalk=
X-Google-Smtp-Source: AGHT+IG+vWa/Bf6JFAFqPYHl9IoU38pAv0mcpNO01VK/FAyScloUFPNHb/UKydHh09xXlb+ErzS3ig==
X-Received: by 2002:a05:690c:3745:b0:5ea:e8d:df7f with SMTP id
 fw5-20020a05690c374500b005ea0e8ddf7fmr6996456ywb.22.1703872337310; 
 Fri, 29 Dec 2023 09:52:17 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 q133-20020a815c8b000000b005e4e79d4921sm8633789ywb.94.2023.12.29.09.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:52:16 -0800 (PST)
Date: Fri, 29 Dec 2023 12:52:15 -0500
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: xypron.glpk@gmx.de, sjg@chromium.org, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org
Subject: Re: Proposal: U-Boot memory management
Message-ID: <20231229175215.GY2652760@bill-the-cat>
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <CAFLszThqH01GOqnTxucVE7s+wJU-dz7uqUtkb4iKxs6GgX6tqw@mail.gmail.com>
 <20231229154307.GS2652760@bill-the-cat>
 <7CDAA354-803C-4AFD-BD38-F432B811DB96@gmx.de>
 <20231229161744.GU2652760@bill-the-cat>
 <871qb4nbtc.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QuC3BUkNgyz7GI05"
Content-Disposition: inline
In-Reply-To: <871qb4nbtc.fsf@bloch.sibelius.xs4all.nl>
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


--QuC3BUkNgyz7GI05
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 06:44:15PM +0100, Mark Kettenis wrote:
> > Date: Fri, 29 Dec 2023 11:17:44 -0500
> > From: Tom Rini <trini@konsulko.com>
> >=20
> > On Fri, Dec 29, 2023 at 05:05:17PM +0100, Heinrich Schuchardt wrote:
> > >=20
> > >=20
> > > Am 29. Dezember 2023 16:43:07 MEZ schrieb Tom Rini <trini@konsulko.co=
m>:
> > > >On Fri, Dec 29, 2023 at 05:36:09AM +0000, Simon Glass wrote:
> > > >> Hi,
> > > >>=20
> > > >> On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM Simon Glass <sjg@chromium.=
org> wrote:
> > > >> >
> > > >> > Hi,
> > > >> >
> > > >> > This records my thoughts after a discussion with Ilias & Heinric=
h re
> > > >> > memory allocation in U-Boot.
> > > >> >
> > > >> > 1. malloc()
> > > >> >
> > > >> > malloc() is used for programmatic memory allocation. It allows m=
emory
> > > >> > to be freed. It is not designed for very large allocations (e.g.=
 a
> > > >> > 10MB kernel or 100MB ramdisk).
> > > >> >
> > > >> > 2. lmb
> > > >> >
> > > >> > lmb is used for large blocks of memory, such as those needed for=
 a
> > > >> > kernel or ramdisk. Allocation is only transitory, for the purpos=
es of
> > > >> > loading some images and booting. If the boot fails, then all lmb
> > > >> > allocations go away.
> > > >> >
> > > >> > lmb is set up by getting all available memory and then removing =
what
> > > >> > is used by U-Boot (code, data, malloc() space, etc.)
> > > >> >
> > > >> > lmb reservations have a few flags so that areas of memory can be
> > > >> > provided with attributes
> > > >> >
> > > >> > There are some corner cases...e.g. loading a file does an lmb
> > > >> > allocation but only for the purpose of avoiding a file being loa=
ded
> > > >> > over U-Boot code/data. The allocation is dropped immediately aft=
er the
> > > >> > file is loaded. Within the bootm command, or when using standard=
 boot,
> > > >> > this would be fairly easy to solve.
> > > >> >
> > > >> > Linux has renamed lmb to memblock. We should consider doing the =
same.
> > > >> >
> > > >> > 3. EFI
> > > >> >
> > > >> > EFI has its own memory-allocation tables.
> > > >> >
> > > >> > Like lmb, EFI is able to deal with large allocations. But via a =
'pool'
> > > >> > function it can also do smaller allocations similar to malloc(),
> > > >> > although each one uses at least 4KB at present.
> > > >> >
> > > >> > EFI allocations do not go away when a boot fails.
> > > >> >
> > > >> > With EFI it is possible to add allocations post facto, in which =
case
> > > >> > they are added to the allocation table just as if the memory was
> > > >> > allocated with EFI to begin with.
> > > >> >
> > > >> > The EFI allocations and the lmb allocations use the same memory,=
 so in
> > > >> > principle could conflict.
> > > >> >
> > > >> > EFI allocations are sometimes used to allocate internal U-Boot d=
ata as
> > > >> > well, if needed by the EFI app. For example, while efi_image_par=
se()
> > > >> > uses malloc(), efi_var_mem.c uses EFI allocations since the code=
 runs
> > > >> > in the app context and may need to access the memory after U-Boo=
t has
> > > >> > exited. Also efi_smbios.c uses allocate_pages() and then adds a =
new
> > > >> > mapping as well.
> > > >> >
> > > >> > EFI memory has attributes, including what the memory is used for=
 (to
> > > >> > some degree of granularity). See enum efi_memory_type and struct
> > > >> > efi_mem_desc. In the latter there are also attribute flags - whe=
ther
> > > >> > memory is cacheable, etc.
> > > >> >
> > > >> > EFI also has the x86 idea of 'conventional' memory, meaning (I
> > > >> > believe) that below 4GB that isn't reserved for the hardware/sys=
tem.
> > > >> > This is meaningless, or at least confusing, on ARM systems.
> > > >> >
> > > >> > 4. reservations
> > > >> >
> > > >> > It is perhaps worth mentioning a fourth method of memory managem=
ent,
> > > >> > where U-Boot reserves chunks of memory before relocation (in
> > > >> > board_init_f.c), e.g. for the framebuffer, U-Boot code, the mall=
oc()
> > > >> > region, etc.
> > > >> >
> > > >> >
> > > >> > Problems
> > > >> > =E2=80=94-------
> > > >> >
> > > >> > There are no urgent problems, but here are some things that coul=
d be improved:
> > > >> >
> > > >> > 1. EFI should attach most of its data structures to driver model=
=2E This
> > > >> > work has started, with the partition support, but more effort wo=
uld
> > > >> > help. This would make it easier to see which memory is related to
> > > >> > devices and which is separate.
> > > >> >
> > > >> > 2. Some drivers do EFI reservations today, whether EFI is used f=
or
> > > >> > booting or not (e.g. rockchip video rk_vop_probe()).
> > > >> >
> > > >> > 3. U-Boot doesn't really map arch-specific memory attributes (e.=
g.
> > > >> > armv8's struct mm_region) to EFI ones.
> > > >> >
> > > >> > 4. EFI duplicates some code from bootm, some of which relates to
> > > >> > memory allocation (e.g. FDT fixup).
> > > >> >
> > > >> > 5. EFI code is used even if EFI is never used to boot
> > > >> >
> > > >> > 6. EFI allocations can result in the same memory being used as h=
as
> > > >> > already been allocated by lmb. Users may load files which overwr=
ite
> > > >> > memory allocated by EFI.
> > > >>=20
> > > >> 7. We need to support doing an allocation when a file is loaded (to
> > > >> ensure files do not overlap), without making it too difficult to l=
oad
> > > >> multiple files to the same place, if desired.
> > > >>=20
> > > >> >
> > > >> >
> > > >> > Lifetime
> > > >> > --------
> > > >> >
> > > >> > We have three different memory allocators with different purpose=
s. Can
> > > >> > we unify them a little?
> > > >> >
> > > >> > Within U-Boot:
> > > >> > - malloc() space lives forever
> > > >> > - lmb lives while setting out images for booting
> > > >> > - EFI (mostly) lives while booting an EFI app
> > > >> >
> > > >> > In practice, EFI is set up early in U-Boot. Some of this is nece=
ssary,
> > > >> > some not. EFI allocations stay around forever. This works OK sin=
ce
> > > >> > large allocations are normally not done in EFI, so memory isn't =
really
> > > >> > consumed to any great degree by the boot process.
> > > >> >
> > > >> > What happens to EFI allocations if the app returns? They are sti=
ll
> > > >> > present, in case another app is run. This seems fine.
> > > >> >
> > > >> > API
> > > >> > =E2=80=93--
> > > >> > Can we unify some APIs?
> > > >> >
> > > >> > It should be possible to use lmb for large EFI memory allocation=
s, so
> > > >> > long as they are only needed for booting. We effectively do this
> > > >> > today, since EFI does not manage the arrangement of loaded image=
s in
> > > >> > memory. for the most part.
> > > >> >
> > > >> > It would not make sense to use EFI allocation to replace lmb and
> > > >> > malloc(), of course.
> > > >> >
> > > >> > Could we use a common (lower-level) API for allocation, used by =
both
> > > >> > lmb and EFI? They do have some similarities. However they have
> > > >> > different lifetime constraints (EFI allocations are never droppe=
d,
> > > >> > unlikely lmb).
> > > >> >
> > > >> > ** Overall, it seems that the existence of memory allocation in
> > > >> > boot-time services has created confusion. Memory allocation is
> > > >> > muddled, with both U-Boot code and boot-time services calling th=
e same
> > > >> > memory allocator. This just has not been clearly thought out.
> > > >> >
> > > >> >
> > > >> > Proposal
> > > >> > =E2=80=94-------
> > > >> >
> > > >> > Here are some ideas:
> > > >> >
> > > >> > 1. For video, use the driver model API to locate the video regio=
ns, or
> > > >> > block off the entire framebuffer memory, for all devices as a wh=
ole.
> > > >> > Use efi_add_memory_map()
> > > >> >
> > > >> > 2. Add memory attributes to UCLASS_RAM and use them in EFI, mapp=
ing to
> > > >> > the EFI_MEMORY_... attributes in struct efi_mem_desc.
> > > >> >
> > > >> > 3. Add all EFI reservations just before booting the app, as we d=
o with
> > > >> > devicetree fixup. With this model, malloc() and lmb are used for=
 all
> > > >> > allocation. Then efi_add_memory_map() is called for each region =
in
> > > >> > turn just before booting. Memory attributes are dealt with above=
=2E The
> > > >> > type (enum efi_memory_type) can be determined simply by the data
> > > >> > structure stored in it, as is done today. For example, SMBIOS ta=
bles
> > > >> > can use EFI_ACPI_RECLAIM_MEMORY. Very few types are used and EFI=
 code
> > > >> > understands the meaning of each.
> > > >> >
> > > >> > 4. Avoid setting up EFI memory at the start of U-Boot. Do it onl=
y when
> > > >> > booting. This looks to require very little effort.
> > > >> >
> > > >> > 5. Avoid calling efi_allocate_pages() and efi_allocate_pool() ou=
tside
> > > >> > boot-time services. This solves the problem 6. If memory is need=
ed by
> > > >> > an app, allocate it with malloc() and see 3. There are only two
> > > >> > efi_allocate_pages() (smbios and efi_runtime). There are more ca=
lls of
> > > >> > efi_allocate_pool(), but most of these seem easy to fix up. For
> > > >> > example, efi_init_event_log() allocates a buffer, but this can be
> > > >> > allocated in normal malloc() space or in a bloblist.
> > > >> >
> > > >> > 6. Don't worry too much about whether EFI will be used for booti=
ng.
> > > >> > The cost is likely not that great: use bootstage to measure it a=
s is
> > > >> > done for driver model. Try to minmise the cost of its tables,
> > > >> > particularly for execution time, but otherwise just rely on the
> > > >> > ability to disable EFI_LOADER.
> > > >>=20
> > > >> 7. Add a flag to the 'load' command:
> > > >>=20
> > > >> -m <type> - make an lmb allocation for the file
> > > >>    <type> is the image type to use (kernel, ramdisk, flat_dt)
> > > >>=20
> > > >> any existing allocation for that type will be automatically freed
> > > >> first. If <type> is "none" then no freeing is possible: any loaded
> > > >> images just stack up in lmb.
> > > >>=20
> > > >> Add an 'lmb' (or memblock) command to allow listing and clearing a=
llocations.
> > > >
> > > >I would really not like to change the user interface and instead sim=
ply
> > > >handle this with flags to whatever mark/allocation function is calle=
d.
> > > >You can always overwrite things that are brought in to memory, you
> > > >cannot overwrite U-Boot or our internals. Optionally noting that some
> > > >previous load to memory has been at least partially overwritten coul=
d be
> > > >helpful, if it's not too much extra logic.
> > > >
> > >=20
> > > In most use cases users load exactly one file at  each address. An
> > > unload command would be the cleanest way for a user to indicate that
> > > he wants to reuse the memory.
> >=20
> > I very much do not want to change the API. There's untold numbers of
> > scripts out there and they should continue to work. I mentioned to Ilias
> > off list just now that I'm not against adding a command to add flags to
> > these areas, but I don't think it's worthwhile to prevent overwrites the
> > user did early. The biggest long running problem in this space was that
> > for 32bit ARM we couldn't know where the kernel BSS was going to be and
> > so would have ramdisk at the wrong spot and get partially eaten, and
> > this was hard to figure out. The current example is "ooops,
> > decompression buffer for Image.gz/etc is too close to other things"
> > which ends up failing nice and loudly, and in the future once this
> > proposal is done we can just dynamically find and use a spot, since
> > we'll have that ability finally.
>=20
> In order to keep the existing interfaces we need lmb to keep track of
> (at least ) three different states.  I think of those as "free",
> "allocated" and "reserved".  The load command would "reserve" memory
> insteaf "allocate".  And it would pass a flag to lmb when reserving
> memory to indicate that reserving memory that is already reserved is
> ok.  Both "reserved" and "allocated" memory should show up as not free
> in the EFI memory map (probably as EfiLoaderData).

Yes, something like this is what I was getting at, thanks.

--=20
Tom

--QuC3BUkNgyz7GI05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWPB04ACgkQFHw5/5Y0
tyzPxgwApJjLBZ8V08SH434lYhYCri4Vtx0+LM51kXv3Y3LeN7/KOqpN41sOvbc7
YuGv06iyA2iaLiLdwWjEObvnL8vyAjAUZFXH9SZDr//QwHfKwbNbETRuQ9my2vqt
hD2tCFLs5lLL37g0eDgnY/VyURMJ4WG1HoNq7qxWMtqjZ97UW/xnbGHitalLLFCs
zUEpORIw66koyffUn2/vITo08mdWUeRqbIGatJbJef2xGISXJhd7j37oPLSWHWzI
VFhHtXQIJX9YqwwLV8QBdPUPx+/T2vKQ4fXSgmAyJ7B5HeZIqOyykgeBLSq/yxf2
ngpl5tA5OzcAkSt8p/9m204tnOcphe3EJb14kj99x0SGMUYTcb2on7eTV2ItgXd2
fYXkCeiVRainc3+L5omFFt+K0sx38B+iVUk11AKpSDqZ2bClJyHLe7wzjxTDu40T
qEOEWWRUK6Nsjs7Ndyh6om5XL9sZfk037nViptoG0k4Q2DORRH5KLDNb2/8RKAmp
VEdxCQ4K
=62zX
-----END PGP SIGNATURE-----

--QuC3BUkNgyz7GI05--
