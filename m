Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F9BC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB64E8852C;
	Mon, 10 Jun 2024 15:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZwVzL121";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0B108852C; Mon, 10 Jun 2024 15:56:05 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C86A5884C5
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-dfb3ff45c06so574636276.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 06:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718027756; x=1718632556; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUuhyqiP4EKAddxYxnAJJQ2bhWBjQvH8PZOmf90i9K4=;
 b=ZwVzL121c7CLW+5hxyUEUmm4oqh6tCcWnOMWLLg9hUL6qYxA5Z68fixeigMk5U4Cav
 oqmiZK6udDc1QC+7hsLSs1NPxAxyElgftiv3irP95I7ic1ggOkSusTspI6gYE6cQ5oqg
 C0cxcCzMBRJZJ5KS7cY7sSt3Ol6YoSI0n2+mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718027756; x=1718632556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUuhyqiP4EKAddxYxnAJJQ2bhWBjQvH8PZOmf90i9K4=;
 b=FPq0nNwLfI6VTb8z0DaUIMKihZ4ygIWMbFCSgUAgl2j/UmKMab95B1Lbsqsy+2UmBt
 LjNu3b5xGZMvboWuQmiDpBpCM4DAlLTkuNMY6L4jqbyHviuLYBktDrXslW0UtKhJALoP
 DSFxrY1UQyWcJS9+sLYjvVb2AYkQsnHCOhJsTwODtMxnWXzMeXcSBUQRfnVmIZ8+s2Fr
 eVo35K+d9LFPPsbmD4hBdloWkF7Kr5fOzUVdXHyg/ntm8YBH/4vMaNJ5YvdLcFewkKp8
 JJc8Nzqlmwj29G1h6ACzm/XmY5rGfw7KgMwHNAT0qJhKgktMTPJdXbIILRinmooQmf7S
 OdVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/qONMKs5HdPDftkRpYd2d9kvlDS+3sjFV1A+8kHeTp2Xv1PGC0A6bOoiO4w1Ay2hxIraZ5AIZT4oNlUllUVGzjsEBcw==
X-Gm-Message-State: AOJu0YxFWXYVgbC52prtG0QHVc033IcN/Pywm6P7K98CQ9QxPXn3tkaU
 TEaXH2ZIf3Fcs/JY9/kNZXe1uO2rlMs4xAC9iyHPsfYGr9yDxyyptk4U0ap/CGf2YPO7g7Uy0xF
 q4vHOnhOxUNImyRhCC0l6KPFeosI7DFn6XXSW
X-Google-Smtp-Source: AGHT+IFTe4mYzDNGx6tq8arL8QvjDDwFeCeMF3NGo/Sa24CQkW/Q78JfbMtzRnECUx2uR7HtiXJbzqurJvEa2pD1xno=
X-Received: by 2002:a25:d305:0:b0:df7:8f1b:3ea2 with SMTP id
 3f1490d57ef6-dfaf654aa57mr9811934276.5.1718027756360; Mon, 10 Jun 2024
 06:55:56 -0700 (PDT)
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
 <CAFLszTgn2wq-QAEdgseAv7jx6TDyEQ+j6bQZZzdii2gmHtV5VA@mail.gmail.com>
 <CADg8p96jSeXOvkSX9R7g8343k9aJ6bwouSh5WJjy=AnQ+R8Kcw@mail.gmail.com>
In-Reply-To: <CADg8p96jSeXOvkSX9R7g8343k9aJ6bwouSh5WJjy=AnQ+R8Kcw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Jun 2024 07:55:44 -0600
Message-ID: <CAFLszTgQKHXZ89aNz0uxUKGFCXcS5A+6Fqje+ga=gOhjWv=KOw@mail.gmail.com>
Subject: Re: Proposal: U-Boot memory management
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org
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

Hi Sughosh,

On Thu, 6 Jun 2024 at 13:18, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Wed, 29 May 2024 at 22:00, Simon Glass <sjg@chromium.org> wrote:
> >
> > +Sughosh Ganu for reference
> >
> >
> > On Sun, 31 Dec 2023 at 09:16, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Dec 31, 2023 at 04:40:06PM +0100, Heinrich Schuchardt wrote:
> > > >
> > > >
> > > > Am 31. Dezember 2023 16:11:44 MEZ schrieb Tom Rini <trini@konsulko.=
com>:
> > > > >On Sun, Dec 31, 2023 at 07:22:10AM -0700, Simon Glass wrote:
> > > > >> Hi Tom,
> > > > >>
> > > > >> On Sun, Dec 31, 2023 at 6:54=E2=80=AFAM Tom Rini <trini@konsulko=
.com> wrote:
> > > > >> >
> > > > >> > On Sun, Dec 31, 2023 at 05:48:23AM -0700, Simon Glass wrote:
> > > > >> > > Hi,
> > > > >> > >
> > > > >> > > On Fri, Dec 29, 2023 at 10:52=E2=80=AFAM Tom Rini <trini@kon=
sulko.com> wrote:
> > > > >> > > >
> > > > >> > > > On Fri, Dec 29, 2023 at 06:44:15PM +0100, Mark Kettenis wr=
ote:
> > > > >> > > > > > Date: Fri, 29 Dec 2023 11:17:44 -0500
> > > > >> > > > > > From: Tom Rini <trini@konsulko.com>
> > > > >> > > > > >
> > > > >> > > > > > On Fri, Dec 29, 2023 at 05:05:17PM +0100, Heinrich Sch=
uchardt wrote:
> > > > >> > > > > > >
> > > > >> > > > > > >
> > > > >> > > > > > > Am 29. Dezember 2023 16:43:07 MEZ schrieb Tom Rini <=
trini@konsulko.com>:
> > > > >> > > > > > > >On Fri, Dec 29, 2023 at 05:36:09AM +0000, Simon Gla=
ss wrote:
> > > > >> > > > > > > >> Hi,
> > > > >> > > > > > > >>
> > > > >> > > > > > > >> On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM Simon Gla=
ss <sjg@chromium.org> wrote:
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > Hi,
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > This records my thoughts after a discussion wit=
h Ilias & Heinrich re
> > > > >> > > > > > > >> > memory allocation in U-Boot.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > 1. malloc()
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > malloc() is used for programmatic memory alloca=
tion. It allows memory
> > > > >> > > > > > > >> > to be freed. It is not designed for very large =
allocations (e.g. a
> > > > >> > > > > > > >> > 10MB kernel or 100MB ramdisk).
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > 2. lmb
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > lmb is used for large blocks of memory, such as=
 those needed for a
> > > > >> > > > > > > >> > kernel or ramdisk. Allocation is only transitor=
y, for the purposes of
> > > > >> > > > > > > >> > loading some images and booting. If the boot fa=
ils, then all lmb
> > > > >> > > > > > > >> > allocations go away.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > lmb is set up by getting all available memory a=
nd then removing what
> > > > >> > > > > > > >> > is used by U-Boot (code, data, malloc() space, =
etc.)
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > lmb reservations have a few flags so that areas=
 of memory can be
> > > > >> > > > > > > >> > provided with attributes
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > There are some corner cases...e.g. loading a fi=
le does an lmb
> > > > >> > > > > > > >> > allocation but only for the purpose of avoiding=
 a file being loaded
> > > > >> > > > > > > >> > over U-Boot code/data. The allocation is droppe=
d immediately after the
> > > > >> > > > > > > >> > file is loaded. Within the bootm command, or wh=
en using standard boot,
> > > > >> > > > > > > >> > this would be fairly easy to solve.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > Linux has renamed lmb to memblock. We should co=
nsider doing the same.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > 3. EFI
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > EFI has its own memory-allocation tables.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > Like lmb, EFI is able to deal with large alloca=
tions. But via a 'pool'
> > > > >> > > > > > > >> > function it can also do smaller allocations sim=
ilar to malloc(),
> > > > >> > > > > > > >> > although each one uses at least 4KB at present.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > EFI allocations do not go away when a boot fail=
s.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > With EFI it is possible to add allocations post=
 facto, in which case
> > > > >> > > > > > > >> > they are added to the allocation table just as =
if the memory was
> > > > >> > > > > > > >> > allocated with EFI to begin with.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > The EFI allocations and the lmb allocations use=
 the same memory, so in
> > > > >> > > > > > > >> > principle could conflict.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > EFI allocations are sometimes used to allocate =
internal U-Boot data as
> > > > >> > > > > > > >> > well, if needed by the EFI app. For example, wh=
ile efi_image_parse()
> > > > >> > > > > > > >> > uses malloc(), efi_var_mem.c uses EFI allocatio=
ns since the code runs
> > > > >> > > > > > > >> > in the app context and may need to access the m=
emory after U-Boot has
> > > > >> > > > > > > >> > exited. Also efi_smbios.c uses allocate_pages()=
 and then adds a new
> > > > >> > > > > > > >> > mapping as well.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > EFI memory has attributes, including what the m=
emory is used for (to
> > > > >> > > > > > > >> > some degree of granularity). See enum efi_memor=
y_type and struct
> > > > >> > > > > > > >> > efi_mem_desc. In the latter there are also attr=
ibute flags - whether
> > > > >> > > > > > > >> > memory is cacheable, etc.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > EFI also has the x86 idea of 'conventional' mem=
ory, meaning (I
> > > > >> > > > > > > >> > believe) that below 4GB that isn't reserved for=
 the hardware/system.
> > > > >> > > > > > > >> > This is meaningless, or at least confusing, on =
ARM systems.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > 4. reservations
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > It is perhaps worth mentioning a fourth method =
of memory management,
> > > > >> > > > > > > >> > where U-Boot reserves chunks of memory before r=
elocation (in
> > > > >> > > > > > > >> > board_init_f.c), e.g. for the framebuffer, U-Bo=
ot code, the malloc()
> > > > >> > > > > > > >> > region, etc.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > Problems
> > > > >> > > > > > > >> > =E2=80=94-------
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > There are no urgent problems, but here are some=
 things that could be improved:
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > 1. EFI should attach most of its data structure=
s to driver model. This
> > > > >> > > > > > > >> > work has started, with the partition support, b=
ut more effort would
> > > > >> > > > > > > >> > help. This would make it easier to see which me=
mory is related to
> > > > >> > > > > > > >> > devices and which is separate.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > 2. Some drivers do EFI reservations today, whet=
her EFI is used for
> > > > >> > > > > > > >> > booting or not (e.g. rockchip video rk_vop_prob=
e()).
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > 3. U-Boot doesn't really map arch-specific memo=
ry attributes (e.g.
> > > > >> > > > > > > >> > armv8's struct mm_region) to EFI ones.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > 4. EFI duplicates some code from bootm, some of=
 which relates to
> > > > >> > > > > > > >> > memory allocation (e.g. FDT fixup).
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > 5. EFI code is used even if EFI is never used t=
o boot
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > 6. EFI allocations can result in the same memor=
y being used as has
> > > > >> > > > > > > >> > already been allocated by lmb. Users may load f=
iles which overwrite
> > > > >> > > > > > > >> > memory allocated by EFI.
> > > > >> > > > > > > >>
> > > > >> > > > > > > >> 7. We need to support doing an allocation when a =
file is loaded (to
> > > > >> > > > > > > >> ensure files do not overlap), without making it t=
oo difficult to load
> > > > >> > > > > > > >> multiple files to the same place, if desired.
> > > > >> > > > > > > >>
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > Lifetime
> > > > >> > > > > > > >> > --------
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > We have three different memory allocators with =
different purposes. Can
> > > > >> > > > > > > >> > we unify them a little?
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > Within U-Boot:
> > > > >> > > > > > > >> > - malloc() space lives forever
> > > > >> > > > > > > >> > - lmb lives while setting out images for bootin=
g
> > > > >> > > > > > > >> > - EFI (mostly) lives while booting an EFI app
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > In practice, EFI is set up early in U-Boot. Som=
e of this is necessary,
> > > > >> > > > > > > >> > some not. EFI allocations stay around forever. =
This works OK since
> > > > >> > > > > > > >> > large allocations are normally not done in EFI,=
 so memory isn't really
> > > > >> > > > > > > >> > consumed to any great degree by the boot proces=
s.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > What happens to EFI allocations if the app retu=
rns? They are still
> > > > >> > > > > > > >> > present, in case another app is run. This seems=
 fine.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > API
> > > > >> > > > > > > >> > =E2=80=93--
> > > > >> > > > > > > >> > Can we unify some APIs?
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > It should be possible to use lmb for large EFI =
memory allocations, so
> > > > >> > > > > > > >> > long as they are only needed for booting. We ef=
fectively do this
> > > > >> > > > > > > >> > today, since EFI does not manage the arrangemen=
t of loaded images in
> > > > >> > > > > > > >> > memory. for the most part.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > It would not make sense to use EFI allocation t=
o replace lmb and
> > > > >> > > > > > > >> > malloc(), of course.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > Could we use a common (lower-level) API for all=
ocation, used by both
> > > > >> > > > > > > >> > lmb and EFI? They do have some similarities. Ho=
wever they have
> > > > >> > > > > > > >> > different lifetime constraints (EFI allocations=
 are never dropped,
> > > > >> > > > > > > >> > unlikely lmb).
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > ** Overall, it seems that the existence of memo=
ry allocation in
> > > > >> > > > > > > >> > boot-time services has created confusion. Memor=
y allocation is
> > > > >> > > > > > > >> > muddled, with both U-Boot code and boot-time se=
rvices calling the same
> > > > >> > > > > > > >> > memory allocator. This just has not been clearl=
y thought out.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > Proposal
> > > > >> > > > > > > >> > =E2=80=94-------
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > Here are some ideas:
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > 1. For video, use the driver model API to locat=
e the video regions, or
> > > > >> > > > > > > >> > block off the entire framebuffer memory, for al=
l devices as a whole.
> > > > >> > > > > > > >> > Use efi_add_memory_map()
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > 2. Add memory attributes to UCLASS_RAM and use =
them in EFI, mapping to
> > > > >> > > > > > > >> > the EFI_MEMORY_... attributes in struct efi_mem=
_desc.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > 3. Add all EFI reservations just before booting=
 the app, as we do with
> > > > >> > > > > > > >> > devicetree fixup. With this model, malloc() and=
 lmb are used for all
> > > > >> > > > > > > >> > allocation. Then efi_add_memory_map() is called=
 for each region in
> > > > >> > > > > > > >> > turn just before booting. Memory attributes are=
 dealt with above. The
> > > > >> > > > > > > >> > type (enum efi_memory_type) can be determined s=
imply by the data
> > > > >> > > > > > > >> > structure stored in it, as is done today. For e=
xample, SMBIOS tables
> > > > >> > > > > > > >> > can use EFI_ACPI_RECLAIM_MEMORY. Very few types=
 are used and EFI code
> > > > >> > > > > > > >> > understands the meaning of each.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > 4. Avoid setting up EFI memory at the start of =
U-Boot. Do it only when
> > > > >> > > > > > > >> > booting. This looks to require very little effo=
rt.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > 5. Avoid calling efi_allocate_pages() and efi_a=
llocate_pool() outside
> > > > >> > > > > > > >> > boot-time services. This solves the problem 6. =
If memory is needed by
> > > > >> > > > > > > >> > an app, allocate it with malloc() and see 3. Th=
ere are only two
> > > > >> > > > > > > >> > efi_allocate_pages() (smbios and efi_runtime). =
There are more calls of
> > > > >> > > > > > > >> > efi_allocate_pool(), but most of these seem eas=
y to fix up. For
> > > > >> > > > > > > >> > example, efi_init_event_log() allocates a buffe=
r, but this can be
> > > > >> > > > > > > >> > allocated in normal malloc() space or in a blob=
list.
> > > > >> > > > > > > >> >
> > > > >> > > > > > > >> > 6. Don't worry too much about whether EFI will =
be used for booting.
> > > > >> > > > > > > >> > The cost is likely not that great: use bootstag=
e to measure it as is
> > > > >> > > > > > > >> > done for driver model. Try to minmise the cost =
of its tables,
> > > > >> > > > > > > >> > particularly for execution time, but otherwise =
just rely on the
> > > > >> > > > > > > >> > ability to disable EFI_LOADER.
> > > > >> > > > > > > >>
> > > > >> > > > > > > >> 7. Add a flag to the 'load' command:
> > > > >> > > > > > > >>
> > > > >> > > > > > > >> -m <type> - make an lmb allocation for the file
> > > > >> > > > > > > >>    <type> is the image type to use (kernel, ramdi=
sk, flat_dt)
> > > > >> > > > > > > >>
> > > > >> > > > > > > >> any existing allocation for that type will be aut=
omatically freed
> > > > >> > > > > > > >> first. If <type> is "none" then no freeing is pos=
sible: any loaded
> > > > >> > > > > > > >> images just stack up in lmb.
> > > > >> > > > > > > >>
> > > > >> > > > > > > >> Add an 'lmb' (or memblock) command to allow listi=
ng and clearing allocations.
> > > > >> > > > > > > >
> > > > >> > > > > > > >I would really not like to change the user interfac=
e and instead simply
> > > > >> > > > > > > >handle this with flags to whatever mark/allocation =
function is called.
> > > > >> > > > > > > >You can always overwrite things that are brought in=
 to memory, you
> > > > >> > > > > > > >cannot overwrite U-Boot or our internals. Optionall=
y noting that some
> > > > >> > > > > > > >previous load to memory has been at least partially=
 overwritten could be
> > > > >> > > > > > > >helpful, if it's not too much extra logic.
> > > > >> > > > > > > >
> > > > >> > > > > > >
> > > > >> > > > > > > In most use cases users load exactly one file at  ea=
ch address. An
> > > > >> > > > > > > unload command would be the cleanest way for a user =
to indicate that
> > > > >> > > > > > > he wants to reuse the memory.
> > > > >> > > > > >
> > > > >> > > > > > I very much do not want to change the API. There's unt=
old numbers of
> > > > >> > > > > > scripts out there and they should continue to work. I =
mentioned to Ilias
> > > > >> > > > > > off list just now that I'm not against adding a comman=
d to add flags to
> > > > >> > > > > > these areas, but I don't think it's worthwhile to prev=
ent overwrites the
> > > > >> > > > > > user did early. The biggest long running problem in th=
is space was that
> > > > >> > > > > > for 32bit ARM we couldn't know where the kernel BSS wa=
s going to be and
> > > > >> > > > > > so would have ramdisk at the wrong spot and get partia=
lly eaten, and
> > > > >> > > > > > this was hard to figure out. The current example is "o=
oops,
> > > > >> > > > > > decompression buffer for Image.gz/etc is too close to =
other things"
> > > > >> > > > > > which ends up failing nice and loudly, and in the futu=
re once this
> > > > >> > > > > > proposal is done we can just dynamically find and use =
a spot, since
> > > > >> > > > > > we'll have that ability finally.
> > > > >> > > > >
> > > > >> > > > > In order to keep the existing interfaces we need lmb to =
keep track of
> > > > >> > > > > (at least ) three different states.  I think of those as=
 "free",
> > > > >> > > > > "allocated" and "reserved".  The load command would "res=
erve" memory
> > > > >> > > > > insteaf "allocate".  And it would pass a flag to lmb whe=
n reserving
> > > > >> > > > > memory to indicate that reserving memory that is already=
 reserved is
> > > > >> > > > > ok.  Both "reserved" and "allocated" memory should show =
up as not free
> > > > >> > > > > in the EFI memory map (probably as EfiLoaderData).
> > > > >> > > >
> > > > >> > > > Yes, something like this is what I was getting at, thanks.
> > > > >> > >
> > > > >> > > Yes, that is a good way of putting it. There is definitely a=
 distinction there.
> > > > >> > >
> > > > >> > > If we don't want this flag, we could make U-Boot always do a
> > > > >> > > reservation on load, with a '-f' command to force loading ov=
er an
> > > > >> > > existing reservation / releasing it first?
> > > > >> >
> > > > >> > Again, this is an API change and I don't want to change the AP=
I.
> > > > >>
> > > > >> The flag is only needed to drop a reservation, since we apparent=
ly
> > > > >> want the 'load' command to create a permanent reservation. It sh=
ould
> > > > >> not affect existing boot scripts since they won't load overlappi=
ng
> > > > >> images.
> > > > >>
> > > > >> Anyway, what do you suggest?
> > > > >
> > > > >That "load" (and sf read and nand read and tftp and wget and ...)
> > > > >"reserve" memory but not "allocate" memory and "reserve" means som=
ething
> > > > >is there and "allocate" means that it can't be modified again. For
> > > > >example, running U-Boot and our malloc pool are "allocated" but ju=
st
> > > > >loading a file to memory is "reserved".  And then yes, I can see u=
se for
> > > > >the command where some cases might want to "reserve" memory to fid=
dle
> > > > >with it and then "allocate" it so something else can't change it.
> > > > >
> > > > >This is one of those cases where english is terrible to discuss th=
ings
> > > > >in as both reserve and allocate can mean similar things.
> > > > >
> > > >
> > > > I have no clue what the semantics of the mentioned "reserved" state=
 might be. Up to now  memory reservations designated address ranges that U-=
Boot must not use at all, e.g. the memory used by OpenSBI or TF-A.
> > > >
> > > > Who can and who cannot write into "reserved" memory?
> > > >
> > > > What is wrong about allocating memory for files to forbid any other=
 use until you are done with the file and free the memory?
> > >
> > > So, historically (lets say mid 2010s), you could use "load" to bring =
a
> > > file in to memory, anywhere, and it could even overwrite part of U-Bo=
ot
> > > (running, or malloc pool or whatever). You could also use "load" to
> > > bring a file in to memory and then bring another file in to that same
> > > location in memory for whatever reason (assorted development cases).
> > >
> > > Then later someone noted that using "load" to overwrite U-Boot should
> > > get a CVE and instead of ignoring it we decided to use "lmb" to try a=
nd
> > > make sure that we couldn't use "load" to overwrite U-Boot itself, and
> > > that that's a pre-check. This still allows overwriting a previously
> > > loaded file in memory.
> > >
> > > Overwriting something the user put in memory is part of the ABI and h=
as
> > > some use cases.
> > >
> > > So for whatever future system we setup, a memory location can be:
> > > - Free.
> > > - Readable but not Writable.
> > > - Readable and Writable.
> > >
> > > Something like $loadaddr starts as Free. If someone then uses "load" =
to
> > > bring in an OS image, it's now "Readable and Writable". But if someon=
e
> > > does an API call to ask for a new region memory, it wouldn't return
> > > $loadaddr because it's not Free. On the other hand, $relocaddr where
> > > U-Boot is, at least in terms of the API is that it's "Readable but no=
t
> > > Writable".
> > >
> > > Does that help?
>
> Thanks for sharing this with me. I have been working on a solution for
> this issue [1], and plan to send a rfc series by the end of this week.
> My primary motivation behind this work is to have some kind of
> synchronisation between the allocations done by the LMB module and the
> EFI subsystem. As you are aware, the way things stand today, either of
> the two can make memory allocations overwriting any earlier allocated
> memory. The primary reasons behind this is 1) the LMB allocations are
> private to their respective callers, so the LMB memory map is not
> global and persistent, and 2) the EFI allocation routines do not have
> any view of the allocations that would have been made by the LMB
> module.
>
> To fix these issues, I am working on a solution which 1) makes LMB
> memory map persistent and global, and 2) have notifications between
> the two modules when either of the two has made any changes to it's
> memory map. This way, it would be possible to prohibit one module from
> allocating memory which is in use.
>
> I am aware that we have a whole bunch of tests and user scripts which
> work with an assumption that the memory can be re-used. The solution
> that I would be proposing takes care of this assumption. Hopefully I
> should be in a position to send a rfc series this week. We can discuss
> on the patches. Thanks.

I actually am not sure what we are on the same page here. I described
the problems in my original email but your series seems to solve
somewhat different problems, while IMO introducing a whole new class
of problems.

Making LMB persistent and global is a solution looking for a problem,
IMO. Can we go up a level and figure out exactly what is broken here?
That is what I attempted to do in my original email. Perhaps you could
reply to that and suggest where you agree / disagree?

Regards,
Simon

>
> -sughosh
>
> [1] - https://docs.google.com/document/d/1LJj4f1oBaxPIALnMlIy8Bf-3pESjecT=
yKhrQoeCfyrk/edit?usp=3Dsharing
>
> > >
> > > --
> > > Tom
