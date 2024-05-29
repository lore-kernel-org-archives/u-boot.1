Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA848C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 16:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A96C58866D;
	Wed, 29 May 2024 18:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D09A8C7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7685488615; Wed, 29 May 2024 18:30:12 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE36D88210
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 18:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3d1bdefedc0so1192766b6e.1
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717000208; x=1717605008; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBOj+yvjrzmyL2+O9UxVTGG3PGtgFmLUkr7sNWMw5Xc=;
 b=D09A8C7zKfTrWrOQVzXziA32FEMz21rvjRPpB1cj2z4zdGcMqtJOk4Fe7HQg+gVaZM
 rKdUdYAQN0cieCn14Zrj2IT3OvBFmm/12afVD1OWPS0tFb0DR7BbioU+rSxUZQMOeJhx
 94WPD8/WtcdTjARbCWSOUxVx/FADAnYmpBFag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717000208; x=1717605008;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZBOj+yvjrzmyL2+O9UxVTGG3PGtgFmLUkr7sNWMw5Xc=;
 b=NAs7Yab1GriAwlFzPY0XRftB7rP9pUc2G7mLs7k1LmxYlAplz6Tn447TcivreeaanF
 qR4GDjoYqqCcYQR/40JhsMZqWIa6A0pOT3C6slw5qvqMUReVQILuotuXlJbDOKa4N2SD
 DkKUDmf3zE41zTJvkosqorjAXOGVglUj5swBvG/jWsFaMmfTVWxBR9iWldBXgzlN3nKo
 hGGiaX7tImgjTjWyYZ13mk/hgksTswS93MhwitoI7u7amwEBnSN6V18PiVLbeB4z0Q6u
 W7Alsl5rQFu7m4HNI1sF+tTUB/ucUJiC1dszPpnp/PgtLkk5Rhd8HXByBPKl7aiCwKkz
 iz/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn6KvaKPRJantFwjdYjiRgJcxcUvf+jpRUpDpgy0Mrdu7QvuKYaj9D3g/kVvxHWsUqr3K7qUdj1Z1iaMPtk85PEoEKwg==
X-Gm-Message-State: AOJu0YwYqnxXozCETFltCvL8+wOEV+daoGAAQ1O8tc8n2nen6VM4Asqg
 82hCGcdTjtOBkbrVEjl6Y5t+FNNQMlh0DzSp0G1ApJ1GW4kBPh6/apzHfRna83Jn0AKum1y3pXL
 VPVM5xVcYg1Uy5cHsoap8IRsDwY+pq3JtvPi+
X-Google-Smtp-Source: AGHT+IEP3kLeJ7un1Z9PeY3+I54IffCZ9qpC5ujkui9sO21FHw2Eg2FSjv3uOOgPsqeZfhIFYbh0AbS91MobRpN3/YY=
X-Received: by 2002:a05:6808:f8b:b0:3c7:ef1:483e with SMTP id
 5614622812f47-3d1a7646fa6mr19206665b6e.39.1717000207788; Wed, 29 May 2024
 09:30:07 -0700 (PDT)
MIME-Version: 1.0
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
 <20231231161630.GE2652760@bill-the-cat>
In-Reply-To: <20231231161630.GE2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 May 2024 10:29:55 -0600
Message-ID: <CAFLszTgn2wq-QAEdgseAv7jx6TDyEQ+j6bQZZzdii2gmHtV5VA@mail.gmail.com>
Subject: Re: Proposal: U-Boot memory management
To: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de, 
 ilias.apalodimas@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 29 May 2024 18:32:00 +0200
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

+Sughosh Ganu for reference


On Sun, 31 Dec 2023 at 09:16, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Dec 31, 2023 at 04:40:06PM +0100, Heinrich Schuchardt wrote:
> >
> >
> > Am 31. Dezember 2023 16:11:44 MEZ schrieb Tom Rini <trini@konsulko.com>=
:
> > >On Sun, Dec 31, 2023 at 07:22:10AM -0700, Simon Glass wrote:
> > >> Hi Tom,
> > >>
> > >> On Sun, Dec 31, 2023 at 6:54=E2=80=AFAM Tom Rini <trini@konsulko.com=
> wrote:
> > >> >
> > >> > On Sun, Dec 31, 2023 at 05:48:23AM -0700, Simon Glass wrote:
> > >> > > Hi,
> > >> > >
> > >> > > On Fri, Dec 29, 2023 at 10:52=E2=80=AFAM Tom Rini <trini@konsulk=
o.com> wrote:
> > >> > > >
> > >> > > > On Fri, Dec 29, 2023 at 06:44:15PM +0100, Mark Kettenis wrote:
> > >> > > > > > Date: Fri, 29 Dec 2023 11:17:44 -0500
> > >> > > > > > From: Tom Rini <trini@konsulko.com>
> > >> > > > > >
> > >> > > > > > On Fri, Dec 29, 2023 at 05:05:17PM +0100, Heinrich Schucha=
rdt wrote:
> > >> > > > > > >
> > >> > > > > > >
> > >> > > > > > > Am 29. Dezember 2023 16:43:07 MEZ schrieb Tom Rini <trin=
i@konsulko.com>:
> > >> > > > > > > >On Fri, Dec 29, 2023 at 05:36:09AM +0000, Simon Glass w=
rote:
> > >> > > > > > > >> Hi,
> > >> > > > > > > >>
> > >> > > > > > > >> On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM Simon Glass <=
sjg@chromium.org> wrote:
> > >> > > > > > > >> >
> > >> > > > > > > >> > Hi,
> > >> > > > > > > >> >
> > >> > > > > > > >> > This records my thoughts after a discussion with Il=
ias & Heinrich re
> > >> > > > > > > >> > memory allocation in U-Boot.
> > >> > > > > > > >> >
> > >> > > > > > > >> > 1. malloc()
> > >> > > > > > > >> >
> > >> > > > > > > >> > malloc() is used for programmatic memory allocation=
. It allows memory
> > >> > > > > > > >> > to be freed. It is not designed for very large allo=
cations (e.g. a
> > >> > > > > > > >> > 10MB kernel or 100MB ramdisk).
> > >> > > > > > > >> >
> > >> > > > > > > >> > 2. lmb
> > >> > > > > > > >> >
> > >> > > > > > > >> > lmb is used for large blocks of memory, such as tho=
se needed for a
> > >> > > > > > > >> > kernel or ramdisk. Allocation is only transitory, f=
or the purposes of
> > >> > > > > > > >> > loading some images and booting. If the boot fails,=
 then all lmb
> > >> > > > > > > >> > allocations go away.
> > >> > > > > > > >> >
> > >> > > > > > > >> > lmb is set up by getting all available memory and t=
hen removing what
> > >> > > > > > > >> > is used by U-Boot (code, data, malloc() space, etc.=
)
> > >> > > > > > > >> >
> > >> > > > > > > >> > lmb reservations have a few flags so that areas of =
memory can be
> > >> > > > > > > >> > provided with attributes
> > >> > > > > > > >> >
> > >> > > > > > > >> > There are some corner cases...e.g. loading a file d=
oes an lmb
> > >> > > > > > > >> > allocation but only for the purpose of avoiding a f=
ile being loaded
> > >> > > > > > > >> > over U-Boot code/data. The allocation is dropped im=
mediately after the
> > >> > > > > > > >> > file is loaded. Within the bootm command, or when u=
sing standard boot,
> > >> > > > > > > >> > this would be fairly easy to solve.
> > >> > > > > > > >> >
> > >> > > > > > > >> > Linux has renamed lmb to memblock. We should consid=
er doing the same.
> > >> > > > > > > >> >
> > >> > > > > > > >> > 3. EFI
> > >> > > > > > > >> >
> > >> > > > > > > >> > EFI has its own memory-allocation tables.
> > >> > > > > > > >> >
> > >> > > > > > > >> > Like lmb, EFI is able to deal with large allocation=
s. But via a 'pool'
> > >> > > > > > > >> > function it can also do smaller allocations similar=
 to malloc(),
> > >> > > > > > > >> > although each one uses at least 4KB at present.
> > >> > > > > > > >> >
> > >> > > > > > > >> > EFI allocations do not go away when a boot fails.
> > >> > > > > > > >> >
> > >> > > > > > > >> > With EFI it is possible to add allocations post fac=
to, in which case
> > >> > > > > > > >> > they are added to the allocation table just as if t=
he memory was
> > >> > > > > > > >> > allocated with EFI to begin with.
> > >> > > > > > > >> >
> > >> > > > > > > >> > The EFI allocations and the lmb allocations use the=
 same memory, so in
> > >> > > > > > > >> > principle could conflict.
> > >> > > > > > > >> >
> > >> > > > > > > >> > EFI allocations are sometimes used to allocate inte=
rnal U-Boot data as
> > >> > > > > > > >> > well, if needed by the EFI app. For example, while =
efi_image_parse()
> > >> > > > > > > >> > uses malloc(), efi_var_mem.c uses EFI allocations s=
ince the code runs
> > >> > > > > > > >> > in the app context and may need to access the memor=
y after U-Boot has
> > >> > > > > > > >> > exited. Also efi_smbios.c uses allocate_pages() and=
 then adds a new
> > >> > > > > > > >> > mapping as well.
> > >> > > > > > > >> >
> > >> > > > > > > >> > EFI memory has attributes, including what the memor=
y is used for (to
> > >> > > > > > > >> > some degree of granularity). See enum efi_memory_ty=
pe and struct
> > >> > > > > > > >> > efi_mem_desc. In the latter there are also attribut=
e flags - whether
> > >> > > > > > > >> > memory is cacheable, etc.
> > >> > > > > > > >> >
> > >> > > > > > > >> > EFI also has the x86 idea of 'conventional' memory,=
 meaning (I
> > >> > > > > > > >> > believe) that below 4GB that isn't reserved for the=
 hardware/system.
> > >> > > > > > > >> > This is meaningless, or at least confusing, on ARM =
systems.
> > >> > > > > > > >> >
> > >> > > > > > > >> > 4. reservations
> > >> > > > > > > >> >
> > >> > > > > > > >> > It is perhaps worth mentioning a fourth method of m=
emory management,
> > >> > > > > > > >> > where U-Boot reserves chunks of memory before reloc=
ation (in
> > >> > > > > > > >> > board_init_f.c), e.g. for the framebuffer, U-Boot c=
ode, the malloc()
> > >> > > > > > > >> > region, etc.
> > >> > > > > > > >> >
> > >> > > > > > > >> >
> > >> > > > > > > >> > Problems
> > >> > > > > > > >> > =E2=80=94-------
> > >> > > > > > > >> >
> > >> > > > > > > >> > There are no urgent problems, but here are some thi=
ngs that could be improved:
> > >> > > > > > > >> >
> > >> > > > > > > >> > 1. EFI should attach most of its data structures to=
 driver model. This
> > >> > > > > > > >> > work has started, with the partition support, but m=
ore effort would
> > >> > > > > > > >> > help. This would make it easier to see which memory=
 is related to
> > >> > > > > > > >> > devices and which is separate.
> > >> > > > > > > >> >
> > >> > > > > > > >> > 2. Some drivers do EFI reservations today, whether =
EFI is used for
> > >> > > > > > > >> > booting or not (e.g. rockchip video rk_vop_probe())=
.
> > >> > > > > > > >> >
> > >> > > > > > > >> > 3. U-Boot doesn't really map arch-specific memory a=
ttributes (e.g.
> > >> > > > > > > >> > armv8's struct mm_region) to EFI ones.
> > >> > > > > > > >> >
> > >> > > > > > > >> > 4. EFI duplicates some code from bootm, some of whi=
ch relates to
> > >> > > > > > > >> > memory allocation (e.g. FDT fixup).
> > >> > > > > > > >> >
> > >> > > > > > > >> > 5. EFI code is used even if EFI is never used to bo=
ot
> > >> > > > > > > >> >
> > >> > > > > > > >> > 6. EFI allocations can result in the same memory be=
ing used as has
> > >> > > > > > > >> > already been allocated by lmb. Users may load files=
 which overwrite
> > >> > > > > > > >> > memory allocated by EFI.
> > >> > > > > > > >>
> > >> > > > > > > >> 7. We need to support doing an allocation when a file=
 is loaded (to
> > >> > > > > > > >> ensure files do not overlap), without making it too d=
ifficult to load
> > >> > > > > > > >> multiple files to the same place, if desired.
> > >> > > > > > > >>
> > >> > > > > > > >> >
> > >> > > > > > > >> >
> > >> > > > > > > >> > Lifetime
> > >> > > > > > > >> > --------
> > >> > > > > > > >> >
> > >> > > > > > > >> > We have three different memory allocators with diff=
erent purposes. Can
> > >> > > > > > > >> > we unify them a little?
> > >> > > > > > > >> >
> > >> > > > > > > >> > Within U-Boot:
> > >> > > > > > > >> > - malloc() space lives forever
> > >> > > > > > > >> > - lmb lives while setting out images for booting
> > >> > > > > > > >> > - EFI (mostly) lives while booting an EFI app
> > >> > > > > > > >> >
> > >> > > > > > > >> > In practice, EFI is set up early in U-Boot. Some of=
 this is necessary,
> > >> > > > > > > >> > some not. EFI allocations stay around forever. This=
 works OK since
> > >> > > > > > > >> > large allocations are normally not done in EFI, so =
memory isn't really
> > >> > > > > > > >> > consumed to any great degree by the boot process.
> > >> > > > > > > >> >
> > >> > > > > > > >> > What happens to EFI allocations if the app returns?=
 They are still
> > >> > > > > > > >> > present, in case another app is run. This seems fin=
e.
> > >> > > > > > > >> >
> > >> > > > > > > >> > API
> > >> > > > > > > >> > =E2=80=93--
> > >> > > > > > > >> > Can we unify some APIs?
> > >> > > > > > > >> >
> > >> > > > > > > >> > It should be possible to use lmb for large EFI memo=
ry allocations, so
> > >> > > > > > > >> > long as they are only needed for booting. We effect=
ively do this
> > >> > > > > > > >> > today, since EFI does not manage the arrangement of=
 loaded images in
> > >> > > > > > > >> > memory. for the most part.
> > >> > > > > > > >> >
> > >> > > > > > > >> > It would not make sense to use EFI allocation to re=
place lmb and
> > >> > > > > > > >> > malloc(), of course.
> > >> > > > > > > >> >
> > >> > > > > > > >> > Could we use a common (lower-level) API for allocat=
ion, used by both
> > >> > > > > > > >> > lmb and EFI? They do have some similarities. Howeve=
r they have
> > >> > > > > > > >> > different lifetime constraints (EFI allocations are=
 never dropped,
> > >> > > > > > > >> > unlikely lmb).
> > >> > > > > > > >> >
> > >> > > > > > > >> > ** Overall, it seems that the existence of memory a=
llocation in
> > >> > > > > > > >> > boot-time services has created confusion. Memory al=
location is
> > >> > > > > > > >> > muddled, with both U-Boot code and boot-time servic=
es calling the same
> > >> > > > > > > >> > memory allocator. This just has not been clearly th=
ought out.
> > >> > > > > > > >> >
> > >> > > > > > > >> >
> > >> > > > > > > >> > Proposal
> > >> > > > > > > >> > =E2=80=94-------
> > >> > > > > > > >> >
> > >> > > > > > > >> > Here are some ideas:
> > >> > > > > > > >> >
> > >> > > > > > > >> > 1. For video, use the driver model API to locate th=
e video regions, or
> > >> > > > > > > >> > block off the entire framebuffer memory, for all de=
vices as a whole.
> > >> > > > > > > >> > Use efi_add_memory_map()
> > >> > > > > > > >> >
> > >> > > > > > > >> > 2. Add memory attributes to UCLASS_RAM and use them=
 in EFI, mapping to
> > >> > > > > > > >> > the EFI_MEMORY_... attributes in struct efi_mem_des=
c.
> > >> > > > > > > >> >
> > >> > > > > > > >> > 3. Add all EFI reservations just before booting the=
 app, as we do with
> > >> > > > > > > >> > devicetree fixup. With this model, malloc() and lmb=
 are used for all
> > >> > > > > > > >> > allocation. Then efi_add_memory_map() is called for=
 each region in
> > >> > > > > > > >> > turn just before booting. Memory attributes are dea=
lt with above. The
> > >> > > > > > > >> > type (enum efi_memory_type) can be determined simpl=
y by the data
> > >> > > > > > > >> > structure stored in it, as is done today. For examp=
le, SMBIOS tables
> > >> > > > > > > >> > can use EFI_ACPI_RECLAIM_MEMORY. Very few types are=
 used and EFI code
> > >> > > > > > > >> > understands the meaning of each.
> > >> > > > > > > >> >
> > >> > > > > > > >> > 4. Avoid setting up EFI memory at the start of U-Bo=
ot. Do it only when
> > >> > > > > > > >> > booting. This looks to require very little effort.
> > >> > > > > > > >> >
> > >> > > > > > > >> > 5. Avoid calling efi_allocate_pages() and efi_alloc=
ate_pool() outside
> > >> > > > > > > >> > boot-time services. This solves the problem 6. If m=
emory is needed by
> > >> > > > > > > >> > an app, allocate it with malloc() and see 3. There =
are only two
> > >> > > > > > > >> > efi_allocate_pages() (smbios and efi_runtime). Ther=
e are more calls of
> > >> > > > > > > >> > efi_allocate_pool(), but most of these seem easy to=
 fix up. For
> > >> > > > > > > >> > example, efi_init_event_log() allocates a buffer, b=
ut this can be
> > >> > > > > > > >> > allocated in normal malloc() space or in a bloblist=
.
> > >> > > > > > > >> >
> > >> > > > > > > >> > 6. Don't worry too much about whether EFI will be u=
sed for booting.
> > >> > > > > > > >> > The cost is likely not that great: use bootstage to=
 measure it as is
> > >> > > > > > > >> > done for driver model. Try to minmise the cost of i=
ts tables,
> > >> > > > > > > >> > particularly for execution time, but otherwise just=
 rely on the
> > >> > > > > > > >> > ability to disable EFI_LOADER.
> > >> > > > > > > >>
> > >> > > > > > > >> 7. Add a flag to the 'load' command:
> > >> > > > > > > >>
> > >> > > > > > > >> -m <type> - make an lmb allocation for the file
> > >> > > > > > > >>    <type> is the image type to use (kernel, ramdisk, =
flat_dt)
> > >> > > > > > > >>
> > >> > > > > > > >> any existing allocation for that type will be automat=
ically freed
> > >> > > > > > > >> first. If <type> is "none" then no freeing is possibl=
e: any loaded
> > >> > > > > > > >> images just stack up in lmb.
> > >> > > > > > > >>
> > >> > > > > > > >> Add an 'lmb' (or memblock) command to allow listing a=
nd clearing allocations.
> > >> > > > > > > >
> > >> > > > > > > >I would really not like to change the user interface an=
d instead simply
> > >> > > > > > > >handle this with flags to whatever mark/allocation func=
tion is called.
> > >> > > > > > > >You can always overwrite things that are brought in to =
memory, you
> > >> > > > > > > >cannot overwrite U-Boot or our internals. Optionally no=
ting that some
> > >> > > > > > > >previous load to memory has been at least partially ove=
rwritten could be
> > >> > > > > > > >helpful, if it's not too much extra logic.
> > >> > > > > > > >
> > >> > > > > > >
> > >> > > > > > > In most use cases users load exactly one file at  each a=
ddress. An
> > >> > > > > > > unload command would be the cleanest way for a user to i=
ndicate that
> > >> > > > > > > he wants to reuse the memory.
> > >> > > > > >
> > >> > > > > > I very much do not want to change the API. There's untold =
numbers of
> > >> > > > > > scripts out there and they should continue to work. I ment=
ioned to Ilias
> > >> > > > > > off list just now that I'm not against adding a command to=
 add flags to
> > >> > > > > > these areas, but I don't think it's worthwhile to prevent =
overwrites the
> > >> > > > > > user did early. The biggest long running problem in this s=
pace was that
> > >> > > > > > for 32bit ARM we couldn't know where the kernel BSS was go=
ing to be and
> > >> > > > > > so would have ramdisk at the wrong spot and get partially =
eaten, and
> > >> > > > > > this was hard to figure out. The current example is "ooops=
,
> > >> > > > > > decompression buffer for Image.gz/etc is too close to othe=
r things"
> > >> > > > > > which ends up failing nice and loudly, and in the future o=
nce this
> > >> > > > > > proposal is done we can just dynamically find and use a sp=
ot, since
> > >> > > > > > we'll have that ability finally.
> > >> > > > >
> > >> > > > > In order to keep the existing interfaces we need lmb to keep=
 track of
> > >> > > > > (at least ) three different states.  I think of those as "fr=
ee",
> > >> > > > > "allocated" and "reserved".  The load command would "reserve=
" memory
> > >> > > > > insteaf "allocate".  And it would pass a flag to lmb when re=
serving
> > >> > > > > memory to indicate that reserving memory that is already res=
erved is
> > >> > > > > ok.  Both "reserved" and "allocated" memory should show up a=
s not free
> > >> > > > > in the EFI memory map (probably as EfiLoaderData).
> > >> > > >
> > >> > > > Yes, something like this is what I was getting at, thanks.
> > >> > >
> > >> > > Yes, that is a good way of putting it. There is definitely a dis=
tinction there.
> > >> > >
> > >> > > If we don't want this flag, we could make U-Boot always do a
> > >> > > reservation on load, with a '-f' command to force loading over a=
n
> > >> > > existing reservation / releasing it first?
> > >> >
> > >> > Again, this is an API change and I don't want to change the API.
> > >>
> > >> The flag is only needed to drop a reservation, since we apparently
> > >> want the 'load' command to create a permanent reservation. It should
> > >> not affect existing boot scripts since they won't load overlapping
> > >> images.
> > >>
> > >> Anyway, what do you suggest?
> > >
> > >That "load" (and sf read and nand read and tftp and wget and ...)
> > >"reserve" memory but not "allocate" memory and "reserve" means somethi=
ng
> > >is there and "allocate" means that it can't be modified again. For
> > >example, running U-Boot and our malloc pool are "allocated" but just
> > >loading a file to memory is "reserved".  And then yes, I can see use f=
or
> > >the command where some cases might want to "reserve" memory to fiddle
> > >with it and then "allocate" it so something else can't change it.
> > >
> > >This is one of those cases where english is terrible to discuss things
> > >in as both reserve and allocate can mean similar things.
> > >
> >
> > I have no clue what the semantics of the mentioned "reserved" state mig=
ht be. Up to now  memory reservations designated address ranges that U-Boot=
 must not use at all, e.g. the memory used by OpenSBI or TF-A.
> >
> > Who can and who cannot write into "reserved" memory?
> >
> > What is wrong about allocating memory for files to forbid any other use=
 until you are done with the file and free the memory?
>
> So, historically (lets say mid 2010s), you could use "load" to bring a
> file in to memory, anywhere, and it could even overwrite part of U-Boot
> (running, or malloc pool or whatever). You could also use "load" to
> bring a file in to memory and then bring another file in to that same
> location in memory for whatever reason (assorted development cases).
>
> Then later someone noted that using "load" to overwrite U-Boot should
> get a CVE and instead of ignoring it we decided to use "lmb" to try and
> make sure that we couldn't use "load" to overwrite U-Boot itself, and
> that that's a pre-check. This still allows overwriting a previously
> loaded file in memory.
>
> Overwriting something the user put in memory is part of the ABI and has
> some use cases.
>
> So for whatever future system we setup, a memory location can be:
> - Free.
> - Readable but not Writable.
> - Readable and Writable.
>
> Something like $loadaddr starts as Free. If someone then uses "load" to
> bring in an OS image, it's now "Readable and Writable". But if someone
> does an API call to ask for a new region memory, it wouldn't return
> $loadaddr because it's not Free. On the other hand, $relocaddr where
> U-Boot is, at least in terms of the API is that it's "Readable but not
> Writable".
>
> Does that help?
>
> --
> Tom
