Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449FEC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 16:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAC3B8785F;
	Sun, 31 Dec 2023 17:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SVcB4E0F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C345287909; Sun, 31 Dec 2023 17:16:37 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A0618785E
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 17:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4279b73b5feso61312941cf.3
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 08:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704039394; x=1704644194; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X8pLmtZitSSZ1lz0tTQXfIS869t/z3GXTq6X67BkgL8=;
 b=SVcB4E0FjDcMtIZubHHDphnJA9lD1UGC0xA6H996SZsj88ZLr5LCIHEwKglfnDiii5
 kimmQCMaHIH/xBxWSUWwmq7UnwPkShanbdZLUytM7EsTkCGlsm5vMi8MZBTbnbz6+FDq
 1JIo2XLm6Kyoyvj/2Vop2oQ1fkzbqxp4iYUAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704039394; x=1704644194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X8pLmtZitSSZ1lz0tTQXfIS869t/z3GXTq6X67BkgL8=;
 b=Lv1wpSnMqQHYTwD4kt828HrffA0Zaz9H+kMwAT1hxrWXpZKUJ97FCjNv0UQu1rFBXY
 NC3+X69KGo0mNByRGwm3f3ZXAMaN0eH0InlGax6IrzJ7deVv9NZbU+hNfvWc2sLzSqdZ
 l8sbFvRBjCivrWqVk1znfP7UWQAFqbVTadJKfmWQrdb5hicwi00lpbeZBLMVFucyeQCX
 4QuUHrOejUpK7fjNNZizLC4xrLYORGy1IXjpzHcVeSyybQQbn/8Lb9k2R6rLaKqgE0qc
 0PZZkY5dKUBgFEXOtiCzM/y1JQP1bXaK9n2hvmJ0cBjMgrCdMibvrfmtD1h/jxLAwV1Z
 9ouw==
X-Gm-Message-State: AOJu0YxKjl8OZO+8midwFPvpeIYU6MTU+eRdd5ZeDx/884td1CL3MDxG
 rGaUyJUcVKwo11+dU1qzezpJ6dIahId4Kg==
X-Google-Smtp-Source: AGHT+IElZ7O6z/jV23S8Wu+AvI6ymmC+fgEmxjZ924kEKY5lIBCPpqeuJ13PzJT/KQ+nN48kp4JamQ==
X-Received: by 2002:ac8:5809:0:b0:427:e769:93b8 with SMTP id
 g9-20020ac85809000000b00427e76993b8mr14660137qtg.45.1704039393648; 
 Sun, 31 Dec 2023 08:16:33 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 ez15-20020a05622a4c8f00b00427fe1def2fsm3262994qtb.23.2023.12.31.08.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 08:16:33 -0800 (PST)
Date: Sun, 31 Dec 2023 11:16:30 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 u-boot@lists.denx.de, ilias.apalodimas@linaro.org
Subject: Re: Proposal: U-Boot memory management
Message-ID: <20231231161630.GE2652760@bill-the-cat>
References: <20231229154307.GS2652760@bill-the-cat>
 <7CDAA354-803C-4AFD-BD38-F432B811DB96@gmx.de>
 <20231229161744.GU2652760@bill-the-cat>
 <871qb4nbtc.fsf@bloch.sibelius.xs4all.nl>
 <20231229175215.GY2652760@bill-the-cat>
 <CAFLszTjXrmhOBeMvGfpy3mfZujNrCu2BKmUbEYz-rmxwyWdg3A@mail.gmail.com>
 <20231231135357.GZ2652760@bill-the-cat>
 <CAFLszTgCSDsobu9ak495vnRP-bjakK5Ytxd5YXro0-7GmYj9vA@mail.gmail.com>
 <20231231151144.GD2652760@bill-the-cat>
 <5599D28A-0255-4352-93E6-1095743F8983@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ytD3qQ1SZejuATqv"
Content-Disposition: inline
In-Reply-To: <5599D28A-0255-4352-93E6-1095743F8983@gmx.de>
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


--ytD3qQ1SZejuATqv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023 at 04:40:06PM +0100, Heinrich Schuchardt wrote:
>=20
>=20
> Am 31. Dezember 2023 16:11:44 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >On Sun, Dec 31, 2023 at 07:22:10AM -0700, Simon Glass wrote:
> >> Hi Tom,
> >>=20
> >> On Sun, Dec 31, 2023 at 6:54=E2=80=AFAM Tom Rini <trini@konsulko.com> =
wrote:
> >> >
> >> > On Sun, Dec 31, 2023 at 05:48:23AM -0700, Simon Glass wrote:
> >> > > Hi,
> >> > >
> >> > > On Fri, Dec 29, 2023 at 10:52=E2=80=AFAM Tom Rini <trini@konsulko.=
com> wrote:
> >> > > >
> >> > > > On Fri, Dec 29, 2023 at 06:44:15PM +0100, Mark Kettenis wrote:
> >> > > > > > Date: Fri, 29 Dec 2023 11:17:44 -0500
> >> > > > > > From: Tom Rini <trini@konsulko.com>
> >> > > > > >
> >> > > > > > On Fri, Dec 29, 2023 at 05:05:17PM +0100, Heinrich Schuchard=
t wrote:
> >> > > > > > >
> >> > > > > > >
> >> > > > > > > Am 29. Dezember 2023 16:43:07 MEZ schrieb Tom Rini <trini@=
konsulko.com>:
> >> > > > > > > >On Fri, Dec 29, 2023 at 05:36:09AM +0000, Simon Glass wro=
te:
> >> > > > > > > >> Hi,
> >> > > > > > > >>
> >> > > > > > > >> On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM Simon Glass <sj=
g@chromium.org> wrote:
> >> > > > > > > >> >
> >> > > > > > > >> > Hi,
> >> > > > > > > >> >
> >> > > > > > > >> > This records my thoughts after a discussion with Ilia=
s & Heinrich re
> >> > > > > > > >> > memory allocation in U-Boot.
> >> > > > > > > >> >
> >> > > > > > > >> > 1. malloc()
> >> > > > > > > >> >
> >> > > > > > > >> > malloc() is used for programmatic memory allocation. =
It allows memory
> >> > > > > > > >> > to be freed. It is not designed for very large alloca=
tions (e.g. a
> >> > > > > > > >> > 10MB kernel or 100MB ramdisk).
> >> > > > > > > >> >
> >> > > > > > > >> > 2. lmb
> >> > > > > > > >> >
> >> > > > > > > >> > lmb is used for large blocks of memory, such as those=
 needed for a
> >> > > > > > > >> > kernel or ramdisk. Allocation is only transitory, for=
 the purposes of
> >> > > > > > > >> > loading some images and booting. If the boot fails, t=
hen all lmb
> >> > > > > > > >> > allocations go away.
> >> > > > > > > >> >
> >> > > > > > > >> > lmb is set up by getting all available memory and the=
n removing what
> >> > > > > > > >> > is used by U-Boot (code, data, malloc() space, etc.)
> >> > > > > > > >> >
> >> > > > > > > >> > lmb reservations have a few flags so that areas of me=
mory can be
> >> > > > > > > >> > provided with attributes
> >> > > > > > > >> >
> >> > > > > > > >> > There are some corner cases...e.g. loading a file doe=
s an lmb
> >> > > > > > > >> > allocation but only for the purpose of avoiding a fil=
e being loaded
> >> > > > > > > >> > over U-Boot code/data. The allocation is dropped imme=
diately after the
> >> > > > > > > >> > file is loaded. Within the bootm command, or when usi=
ng standard boot,
> >> > > > > > > >> > this would be fairly easy to solve.
> >> > > > > > > >> >
> >> > > > > > > >> > Linux has renamed lmb to memblock. We should consider=
 doing the same.
> >> > > > > > > >> >
> >> > > > > > > >> > 3. EFI
> >> > > > > > > >> >
> >> > > > > > > >> > EFI has its own memory-allocation tables.
> >> > > > > > > >> >
> >> > > > > > > >> > Like lmb, EFI is able to deal with large allocations.=
 But via a 'pool'
> >> > > > > > > >> > function it can also do smaller allocations similar t=
o malloc(),
> >> > > > > > > >> > although each one uses at least 4KB at present.
> >> > > > > > > >> >
> >> > > > > > > >> > EFI allocations do not go away when a boot fails.
> >> > > > > > > >> >
> >> > > > > > > >> > With EFI it is possible to add allocations post facto=
, in which case
> >> > > > > > > >> > they are added to the allocation table just as if the=
 memory was
> >> > > > > > > >> > allocated with EFI to begin with.
> >> > > > > > > >> >
> >> > > > > > > >> > The EFI allocations and the lmb allocations use the s=
ame memory, so in
> >> > > > > > > >> > principle could conflict.
> >> > > > > > > >> >
> >> > > > > > > >> > EFI allocations are sometimes used to allocate intern=
al U-Boot data as
> >> > > > > > > >> > well, if needed by the EFI app. For example, while ef=
i_image_parse()
> >> > > > > > > >> > uses malloc(), efi_var_mem.c uses EFI allocations sin=
ce the code runs
> >> > > > > > > >> > in the app context and may need to access the memory =
after U-Boot has
> >> > > > > > > >> > exited. Also efi_smbios.c uses allocate_pages() and t=
hen adds a new
> >> > > > > > > >> > mapping as well.
> >> > > > > > > >> >
> >> > > > > > > >> > EFI memory has attributes, including what the memory =
is used for (to
> >> > > > > > > >> > some degree of granularity). See enum efi_memory_type=
 and struct
> >> > > > > > > >> > efi_mem_desc. In the latter there are also attribute =
flags - whether
> >> > > > > > > >> > memory is cacheable, etc.
> >> > > > > > > >> >
> >> > > > > > > >> > EFI also has the x86 idea of 'conventional' memory, m=
eaning (I
> >> > > > > > > >> > believe) that below 4GB that isn't reserved for the h=
ardware/system.
> >> > > > > > > >> > This is meaningless, or at least confusing, on ARM sy=
stems.
> >> > > > > > > >> >
> >> > > > > > > >> > 4. reservations
> >> > > > > > > >> >
> >> > > > > > > >> > It is perhaps worth mentioning a fourth method of mem=
ory management,
> >> > > > > > > >> > where U-Boot reserves chunks of memory before relocat=
ion (in
> >> > > > > > > >> > board_init_f.c), e.g. for the framebuffer, U-Boot cod=
e, the malloc()
> >> > > > > > > >> > region, etc.
> >> > > > > > > >> >
> >> > > > > > > >> >
> >> > > > > > > >> > Problems
> >> > > > > > > >> > =E2=80=94-------
> >> > > > > > > >> >
> >> > > > > > > >> > There are no urgent problems, but here are some thing=
s that could be improved:
> >> > > > > > > >> >
> >> > > > > > > >> > 1. EFI should attach most of its data structures to d=
river model. This
> >> > > > > > > >> > work has started, with the partition support, but mor=
e effort would
> >> > > > > > > >> > help. This would make it easier to see which memory i=
s related to
> >> > > > > > > >> > devices and which is separate.
> >> > > > > > > >> >
> >> > > > > > > >> > 2. Some drivers do EFI reservations today, whether EF=
I is used for
> >> > > > > > > >> > booting or not (e.g. rockchip video rk_vop_probe()).
> >> > > > > > > >> >
> >> > > > > > > >> > 3. U-Boot doesn't really map arch-specific memory att=
ributes (e.g.
> >> > > > > > > >> > armv8's struct mm_region) to EFI ones.
> >> > > > > > > >> >
> >> > > > > > > >> > 4. EFI duplicates some code from bootm, some of which=
 relates to
> >> > > > > > > >> > memory allocation (e.g. FDT fixup).
> >> > > > > > > >> >
> >> > > > > > > >> > 5. EFI code is used even if EFI is never used to boot
> >> > > > > > > >> >
> >> > > > > > > >> > 6. EFI allocations can result in the same memory bein=
g used as has
> >> > > > > > > >> > already been allocated by lmb. Users may load files w=
hich overwrite
> >> > > > > > > >> > memory allocated by EFI.
> >> > > > > > > >>
> >> > > > > > > >> 7. We need to support doing an allocation when a file i=
s loaded (to
> >> > > > > > > >> ensure files do not overlap), without making it too dif=
ficult to load
> >> > > > > > > >> multiple files to the same place, if desired.
> >> > > > > > > >>
> >> > > > > > > >> >
> >> > > > > > > >> >
> >> > > > > > > >> > Lifetime
> >> > > > > > > >> > --------
> >> > > > > > > >> >
> >> > > > > > > >> > We have three different memory allocators with differ=
ent purposes. Can
> >> > > > > > > >> > we unify them a little?
> >> > > > > > > >> >
> >> > > > > > > >> > Within U-Boot:
> >> > > > > > > >> > - malloc() space lives forever
> >> > > > > > > >> > - lmb lives while setting out images for booting
> >> > > > > > > >> > - EFI (mostly) lives while booting an EFI app
> >> > > > > > > >> >
> >> > > > > > > >> > In practice, EFI is set up early in U-Boot. Some of t=
his is necessary,
> >> > > > > > > >> > some not. EFI allocations stay around forever. This w=
orks OK since
> >> > > > > > > >> > large allocations are normally not done in EFI, so me=
mory isn't really
> >> > > > > > > >> > consumed to any great degree by the boot process.
> >> > > > > > > >> >
> >> > > > > > > >> > What happens to EFI allocations if the app returns? T=
hey are still
> >> > > > > > > >> > present, in case another app is run. This seems fine.
> >> > > > > > > >> >
> >> > > > > > > >> > API
> >> > > > > > > >> > =E2=80=93--
> >> > > > > > > >> > Can we unify some APIs?
> >> > > > > > > >> >
> >> > > > > > > >> > It should be possible to use lmb for large EFI memory=
 allocations, so
> >> > > > > > > >> > long as they are only needed for booting. We effectiv=
ely do this
> >> > > > > > > >> > today, since EFI does not manage the arrangement of l=
oaded images in
> >> > > > > > > >> > memory. for the most part.
> >> > > > > > > >> >
> >> > > > > > > >> > It would not make sense to use EFI allocation to repl=
ace lmb and
> >> > > > > > > >> > malloc(), of course.
> >> > > > > > > >> >
> >> > > > > > > >> > Could we use a common (lower-level) API for allocatio=
n, used by both
> >> > > > > > > >> > lmb and EFI? They do have some similarities. However =
they have
> >> > > > > > > >> > different lifetime constraints (EFI allocations are n=
ever dropped,
> >> > > > > > > >> > unlikely lmb).
> >> > > > > > > >> >
> >> > > > > > > >> > ** Overall, it seems that the existence of memory all=
ocation in
> >> > > > > > > >> > boot-time services has created confusion. Memory allo=
cation is
> >> > > > > > > >> > muddled, with both U-Boot code and boot-time services=
 calling the same
> >> > > > > > > >> > memory allocator. This just has not been clearly thou=
ght out.
> >> > > > > > > >> >
> >> > > > > > > >> >
> >> > > > > > > >> > Proposal
> >> > > > > > > >> > =E2=80=94-------
> >> > > > > > > >> >
> >> > > > > > > >> > Here are some ideas:
> >> > > > > > > >> >
> >> > > > > > > >> > 1. For video, use the driver model API to locate the =
video regions, or
> >> > > > > > > >> > block off the entire framebuffer memory, for all devi=
ces as a whole.
> >> > > > > > > >> > Use efi_add_memory_map()
> >> > > > > > > >> >
> >> > > > > > > >> > 2. Add memory attributes to UCLASS_RAM and use them i=
n EFI, mapping to
> >> > > > > > > >> > the EFI_MEMORY_... attributes in struct efi_mem_desc.
> >> > > > > > > >> >
> >> > > > > > > >> > 3. Add all EFI reservations just before booting the a=
pp, as we do with
> >> > > > > > > >> > devicetree fixup. With this model, malloc() and lmb a=
re used for all
> >> > > > > > > >> > allocation. Then efi_add_memory_map() is called for e=
ach region in
> >> > > > > > > >> > turn just before booting. Memory attributes are dealt=
 with above. The
> >> > > > > > > >> > type (enum efi_memory_type) can be determined simply =
by the data
> >> > > > > > > >> > structure stored in it, as is done today. For example=
, SMBIOS tables
> >> > > > > > > >> > can use EFI_ACPI_RECLAIM_MEMORY. Very few types are u=
sed and EFI code
> >> > > > > > > >> > understands the meaning of each.
> >> > > > > > > >> >
> >> > > > > > > >> > 4. Avoid setting up EFI memory at the start of U-Boot=
=2E Do it only when
> >> > > > > > > >> > booting. This looks to require very little effort.
> >> > > > > > > >> >
> >> > > > > > > >> > 5. Avoid calling efi_allocate_pages() and efi_allocat=
e_pool() outside
> >> > > > > > > >> > boot-time services. This solves the problem 6. If mem=
ory is needed by
> >> > > > > > > >> > an app, allocate it with malloc() and see 3. There ar=
e only two
> >> > > > > > > >> > efi_allocate_pages() (smbios and efi_runtime). There =
are more calls of
> >> > > > > > > >> > efi_allocate_pool(), but most of these seem easy to f=
ix up. For
> >> > > > > > > >> > example, efi_init_event_log() allocates a buffer, but=
 this can be
> >> > > > > > > >> > allocated in normal malloc() space or in a bloblist.
> >> > > > > > > >> >
> >> > > > > > > >> > 6. Don't worry too much about whether EFI will be use=
d for booting.
> >> > > > > > > >> > The cost is likely not that great: use bootstage to m=
easure it as is
> >> > > > > > > >> > done for driver model. Try to minmise the cost of its=
 tables,
> >> > > > > > > >> > particularly for execution time, but otherwise just r=
ely on the
> >> > > > > > > >> > ability to disable EFI_LOADER.
> >> > > > > > > >>
> >> > > > > > > >> 7. Add a flag to the 'load' command:
> >> > > > > > > >>
> >> > > > > > > >> -m <type> - make an lmb allocation for the file
> >> > > > > > > >>    <type> is the image type to use (kernel, ramdisk, fl=
at_dt)
> >> > > > > > > >>
> >> > > > > > > >> any existing allocation for that type will be automatic=
ally freed
> >> > > > > > > >> first. If <type> is "none" then no freeing is possible:=
 any loaded
> >> > > > > > > >> images just stack up in lmb.
> >> > > > > > > >>
> >> > > > > > > >> Add an 'lmb' (or memblock) command to allow listing and=
 clearing allocations.
> >> > > > > > > >
> >> > > > > > > >I would really not like to change the user interface and =
instead simply
> >> > > > > > > >handle this with flags to whatever mark/allocation functi=
on is called.
> >> > > > > > > >You can always overwrite things that are brought in to me=
mory, you
> >> > > > > > > >cannot overwrite U-Boot or our internals. Optionally noti=
ng that some
> >> > > > > > > >previous load to memory has been at least partially overw=
ritten could be
> >> > > > > > > >helpful, if it's not too much extra logic.
> >> > > > > > > >
> >> > > > > > >
> >> > > > > > > In most use cases users load exactly one file at  each add=
ress. An
> >> > > > > > > unload command would be the cleanest way for a user to ind=
icate that
> >> > > > > > > he wants to reuse the memory.
> >> > > > > >
> >> > > > > > I very much do not want to change the API. There's untold nu=
mbers of
> >> > > > > > scripts out there and they should continue to work. I mentio=
ned to Ilias
> >> > > > > > off list just now that I'm not against adding a command to a=
dd flags to
> >> > > > > > these areas, but I don't think it's worthwhile to prevent ov=
erwrites the
> >> > > > > > user did early. The biggest long running problem in this spa=
ce was that
> >> > > > > > for 32bit ARM we couldn't know where the kernel BSS was goin=
g to be and
> >> > > > > > so would have ramdisk at the wrong spot and get partially ea=
ten, and
> >> > > > > > this was hard to figure out. The current example is "ooops,
> >> > > > > > decompression buffer for Image.gz/etc is too close to other =
things"
> >> > > > > > which ends up failing nice and loudly, and in the future onc=
e this
> >> > > > > > proposal is done we can just dynamically find and use a spot=
, since
> >> > > > > > we'll have that ability finally.
> >> > > > >
> >> > > > > In order to keep the existing interfaces we need lmb to keep t=
rack of
> >> > > > > (at least ) three different states.  I think of those as "free=
",
> >> > > > > "allocated" and "reserved".  The load command would "reserve" =
memory
> >> > > > > insteaf "allocate".  And it would pass a flag to lmb when rese=
rving
> >> > > > > memory to indicate that reserving memory that is already reser=
ved is
> >> > > > > ok.  Both "reserved" and "allocated" memory should show up as =
not free
> >> > > > > in the EFI memory map (probably as EfiLoaderData).
> >> > > >
> >> > > > Yes, something like this is what I was getting at, thanks.
> >> > >
> >> > > Yes, that is a good way of putting it. There is definitely a disti=
nction there.
> >> > >
> >> > > If we don't want this flag, we could make U-Boot always do a
> >> > > reservation on load, with a '-f' command to force loading over an
> >> > > existing reservation / releasing it first?
> >> >
> >> > Again, this is an API change and I don't want to change the API.
> >>=20
> >> The flag is only needed to drop a reservation, since we apparently
> >> want the 'load' command to create a permanent reservation. It should
> >> not affect existing boot scripts since they won't load overlapping
> >> images.
> >>=20
> >> Anyway, what do you suggest?
> >
> >That "load" (and sf read and nand read and tftp and wget and ...)
> >"reserve" memory but not "allocate" memory and "reserve" means something
> >is there and "allocate" means that it can't be modified again. For
> >example, running U-Boot and our malloc pool are "allocated" but just
> >loading a file to memory is "reserved".  And then yes, I can see use for
> >the command where some cases might want to "reserve" memory to fiddle
> >with it and then "allocate" it so something else can't change it.
> >
> >This is one of those cases where english is terrible to discuss things
> >in as both reserve and allocate can mean similar things.
> >
>=20
> I have no clue what the semantics of the mentioned "reserved" state might=
 be. Up to now  memory reservations designated address ranges that U-Boot m=
ust not use at all, e.g. the memory used by OpenSBI or TF-A.
>=20
> Who can and who cannot write into "reserved" memory?
>=20
> What is wrong about allocating memory for files to forbid any other use u=
ntil you are done with the file and free the memory?

So, historically (lets say mid 2010s), you could use "load" to bring a
file in to memory, anywhere, and it could even overwrite part of U-Boot
(running, or malloc pool or whatever). You could also use "load" to
bring a file in to memory and then bring another file in to that same
location in memory for whatever reason (assorted development cases).

Then later someone noted that using "load" to overwrite U-Boot should
get a CVE and instead of ignoring it we decided to use "lmb" to try and
make sure that we couldn't use "load" to overwrite U-Boot itself, and
that that's a pre-check. This still allows overwriting a previously
loaded file in memory.

Overwriting something the user put in memory is part of the ABI and has
some use cases.

So for whatever future system we setup, a memory location can be:
- Free.
- Readable but not Writable.
- Readable and Writable.

Something like $loadaddr starts as Free. If someone then uses "load" to
bring in an OS image, it's now "Readable and Writable". But if someone
does an API call to ask for a new region memory, it wouldn't return
$loadaddr because it's not Free. On the other hand, $relocaddr where
U-Boot is, at least in terms of the API is that it's "Readable but not
Writable".

Does that help?

--=20
Tom

--ytD3qQ1SZejuATqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWRk9sACgkQFHw5/5Y0
tyy++wv/bV0zqf2U+JkBub7ayhn/O13AayJY/EtLLgI+DTs2vbSPif6x4dJlTakZ
1GRuHHNuP69xUt7xJ8OCSyHw0cytjYnDwjhbggdhyB7N4C7vZlLrjlvVe2K1Dl1s
niwkGLULEwyI+sN4ujnlu34scbXBVB32zBnzSJMlH+CL1zGNJjA0umHfLjcm9YlP
jySzCONzgoZeM9imSo6Nn7CTaASOCSHmyLNHkvOFT6zjp2dlTH4uHQxMQHzepoVl
W2hOk7+zInqMzKiHz3XTWdsbTfwWS3+G5Ko075bMiuT2mcoDTtixyKudFPzXdNXP
IZ8qTqCBEaqUexspYrK/7Dpf2kvNialrSnpa7FEO4456fpLsIhov87DQCOG601U8
yFlKH/Dbn9cqXFgxbsuLe4y9FWT/fjqExpo0SOo9dnN3soXcdSsap3V/7+9pPeH0
SQ8z/7LcTz1qx88k9m0gFIFMtoKHslRfZZauVnaR4J3kvUWb1tJ0JNhtnaR9vgZi
kqi02OvG
=fhae
-----END PGP SIGNATURE-----

--ytD3qQ1SZejuATqv--
