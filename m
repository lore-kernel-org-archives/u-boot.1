Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCA5C27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 19:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5684D8806C;
	Thu,  6 Jun 2024 21:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JcTosYB+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BEE2882E2; Thu,  6 Jun 2024 21:18:38 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 824E387D9B
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 21:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57a20c600a7so1423234a12.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717701515; x=1718306315; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u4NMwoN++CgXxsiN6JtfSfDIBEaQh57DPz5OkZRqqko=;
 b=JcTosYB+YgSVurIb638BLxH/0MMculmSmfDnnTql3YH21qL9Mvmn5pwZjTo4gp8hoO
 lXV/0Iyrea2wHcxnZFeBW0vPoH8MJgsWVgtyVFT3omsoZ/WnwdJY+ZvPW3Xpd35zwGj5
 lPGMvgs3O8BWe15W1J5N8vlZBRTQBFztu9u8/6K9zwB8sY2VNryVZThVsGV1z7hV4ylv
 UIdz9J4U2CZ9oh3Hofyj0LO0b5ybCYAcz12og/Fvm0t/rpAxStzaOPP1/X+z0O+I80pM
 Hh3A2NSqbZMgQ2XT3zIXmX8lqz1M4eo1501rLTCj4oGe+PWezc8FH6ik+lrhv6GC2MJI
 y3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717701515; x=1718306315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u4NMwoN++CgXxsiN6JtfSfDIBEaQh57DPz5OkZRqqko=;
 b=agtcQCUPRQbKjqzPXLtC1NkbmV0yHy7uFtyhrUry8jUe/Xs/duQZdUWhXY+2zgKRMl
 S+iNomspZxSDM8yCcwLU68zdVQN8IPhjY5LUzcykM7zLAsKaJc20QenidQrfW+YJhHXU
 iPFACbvVS1FfQXziaWGIRWRY0WW0syvQAe1iRexmCgE5J9SA/9kfy+5ZzENyvobKHi+P
 ZAW95/pGu2Buk9cqmMMyHk8gZIAIWgxZmpFziioRn4NeO6hMOgkuOsPJRIlDJuDU0POB
 VMlzy3S5NDvL8T/zqt6hiRRJ5DkNtgeR7sLmWu6WsZ33knB015oG7VNfEpJkhiJ4X4wy
 ghgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNfZdw7RgIvy79BXdIxRFBqr3doYb+ZWTBR7BlNPCsYo3fmCqss8r0kHmfbY8jubdA1f8sCqwlWCTHkC77/Vdubz8EwA==
X-Gm-Message-State: AOJu0YwHevTj3AbplqUglwcSf9DxQtVA02Zs/oqmeVP+NaGhRBBm5bNe
 8HbQsVSRat3bvYBc+VTV/c3YEb7yFYylURs5RZH6VNswshU0SYFQsIDf6laYaqby6GscIh24rAr
 GYfZetXeN/0P9Jrh1LQ2gBByuq6KvTkZswnLdNw==
X-Google-Smtp-Source: AGHT+IF7bflIS71j4mAXwhpTbtmhrC4zp/yYw0lcImb2exTafqNuU1Ez5qQcuBMIKQAJ6Q0pS1jOae07OCCU20BoUKM=
X-Received: by 2002:a50:bb28:0:b0:57a:7585:bd4d with SMTP id
 4fb4d7f45d1cf-57c5099b048mr146219a12.42.1717701514415; Thu, 06 Jun 2024
 12:18:34 -0700 (PDT)
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
In-Reply-To: <CAFLszTgn2wq-QAEdgseAv7jx6TDyEQ+j6bQZZzdii2gmHtV5VA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 7 Jun 2024 00:48:23 +0530
Message-ID: <CADg8p96jSeXOvkSX9R7g8343k9aJ6bwouSh5WJjy=AnQ+R8Kcw@mail.gmail.com>
Subject: Re: Proposal: U-Boot memory management
To: Simon Glass <sjg@chromium.org>
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

hi Simon,

On Wed, 29 May 2024 at 22:00, Simon Glass <sjg@chromium.org> wrote:
>
> +Sughosh Ganu for reference
>
>
> On Sun, 31 Dec 2023 at 09:16, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Dec 31, 2023 at 04:40:06PM +0100, Heinrich Schuchardt wrote:
> > >
> > >
> > > Am 31. Dezember 2023 16:11:44 MEZ schrieb Tom Rini <trini@konsulko.co=
m>:
> > > >On Sun, Dec 31, 2023 at 07:22:10AM -0700, Simon Glass wrote:
> > > >> Hi Tom,
> > > >>
> > > >> On Sun, Dec 31, 2023 at 6:54=E2=80=AFAM Tom Rini <trini@konsulko.c=
om> wrote:
> > > >> >
> > > >> > On Sun, Dec 31, 2023 at 05:48:23AM -0700, Simon Glass wrote:
> > > >> > > Hi,
> > > >> > >
> > > >> > > On Fri, Dec 29, 2023 at 10:52=E2=80=AFAM Tom Rini <trini@konsu=
lko.com> wrote:
> > > >> > > >
> > > >> > > > On Fri, Dec 29, 2023 at 06:44:15PM +0100, Mark Kettenis wrot=
e:
> > > >> > > > > > Date: Fri, 29 Dec 2023 11:17:44 -0500
> > > >> > > > > > From: Tom Rini <trini@konsulko.com>
> > > >> > > > > >
> > > >> > > > > > On Fri, Dec 29, 2023 at 05:05:17PM +0100, Heinrich Schuc=
hardt wrote:
> > > >> > > > > > >
> > > >> > > > > > >
> > > >> > > > > > > Am 29. Dezember 2023 16:43:07 MEZ schrieb Tom Rini <tr=
ini@konsulko.com>:
> > > >> > > > > > > >On Fri, Dec 29, 2023 at 05:36:09AM +0000, Simon Glass=
 wrote:
> > > >> > > > > > > >> Hi,
> > > >> > > > > > > >>
> > > >> > > > > > > >> On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM Simon Glass=
 <sjg@chromium.org> wrote:
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > Hi,
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > This records my thoughts after a discussion with =
Ilias & Heinrich re
> > > >> > > > > > > >> > memory allocation in U-Boot.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > 1. malloc()
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > malloc() is used for programmatic memory allocati=
on. It allows memory
> > > >> > > > > > > >> > to be freed. It is not designed for very large al=
locations (e.g. a
> > > >> > > > > > > >> > 10MB kernel or 100MB ramdisk).
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > 2. lmb
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > lmb is used for large blocks of memory, such as t=
hose needed for a
> > > >> > > > > > > >> > kernel or ramdisk. Allocation is only transitory,=
 for the purposes of
> > > >> > > > > > > >> > loading some images and booting. If the boot fail=
s, then all lmb
> > > >> > > > > > > >> > allocations go away.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > lmb is set up by getting all available memory and=
 then removing what
> > > >> > > > > > > >> > is used by U-Boot (code, data, malloc() space, et=
c.)
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > lmb reservations have a few flags so that areas o=
f memory can be
> > > >> > > > > > > >> > provided with attributes
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > There are some corner cases...e.g. loading a file=
 does an lmb
> > > >> > > > > > > >> > allocation but only for the purpose of avoiding a=
 file being loaded
> > > >> > > > > > > >> > over U-Boot code/data. The allocation is dropped =
immediately after the
> > > >> > > > > > > >> > file is loaded. Within the bootm command, or when=
 using standard boot,
> > > >> > > > > > > >> > this would be fairly easy to solve.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > Linux has renamed lmb to memblock. We should cons=
ider doing the same.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > 3. EFI
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > EFI has its own memory-allocation tables.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > Like lmb, EFI is able to deal with large allocati=
ons. But via a 'pool'
> > > >> > > > > > > >> > function it can also do smaller allocations simil=
ar to malloc(),
> > > >> > > > > > > >> > although each one uses at least 4KB at present.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > EFI allocations do not go away when a boot fails.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > With EFI it is possible to add allocations post f=
acto, in which case
> > > >> > > > > > > >> > they are added to the allocation table just as if=
 the memory was
> > > >> > > > > > > >> > allocated with EFI to begin with.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > The EFI allocations and the lmb allocations use t=
he same memory, so in
> > > >> > > > > > > >> > principle could conflict.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > EFI allocations are sometimes used to allocate in=
ternal U-Boot data as
> > > >> > > > > > > >> > well, if needed by the EFI app. For example, whil=
e efi_image_parse()
> > > >> > > > > > > >> > uses malloc(), efi_var_mem.c uses EFI allocations=
 since the code runs
> > > >> > > > > > > >> > in the app context and may need to access the mem=
ory after U-Boot has
> > > >> > > > > > > >> > exited. Also efi_smbios.c uses allocate_pages() a=
nd then adds a new
> > > >> > > > > > > >> > mapping as well.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > EFI memory has attributes, including what the mem=
ory is used for (to
> > > >> > > > > > > >> > some degree of granularity). See enum efi_memory_=
type and struct
> > > >> > > > > > > >> > efi_mem_desc. In the latter there are also attrib=
ute flags - whether
> > > >> > > > > > > >> > memory is cacheable, etc.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > EFI also has the x86 idea of 'conventional' memor=
y, meaning (I
> > > >> > > > > > > >> > believe) that below 4GB that isn't reserved for t=
he hardware/system.
> > > >> > > > > > > >> > This is meaningless, or at least confusing, on AR=
M systems.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > 4. reservations
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > It is perhaps worth mentioning a fourth method of=
 memory management,
> > > >> > > > > > > >> > where U-Boot reserves chunks of memory before rel=
ocation (in
> > > >> > > > > > > >> > board_init_f.c), e.g. for the framebuffer, U-Boot=
 code, the malloc()
> > > >> > > > > > > >> > region, etc.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > Problems
> > > >> > > > > > > >> > =E2=80=94-------
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > There are no urgent problems, but here are some t=
hings that could be improved:
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > 1. EFI should attach most of its data structures =
to driver model. This
> > > >> > > > > > > >> > work has started, with the partition support, but=
 more effort would
> > > >> > > > > > > >> > help. This would make it easier to see which memo=
ry is related to
> > > >> > > > > > > >> > devices and which is separate.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > 2. Some drivers do EFI reservations today, whethe=
r EFI is used for
> > > >> > > > > > > >> > booting or not (e.g. rockchip video rk_vop_probe(=
)).
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > 3. U-Boot doesn't really map arch-specific memory=
 attributes (e.g.
> > > >> > > > > > > >> > armv8's struct mm_region) to EFI ones.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > 4. EFI duplicates some code from bootm, some of w=
hich relates to
> > > >> > > > > > > >> > memory allocation (e.g. FDT fixup).
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > 5. EFI code is used even if EFI is never used to =
boot
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > 6. EFI allocations can result in the same memory =
being used as has
> > > >> > > > > > > >> > already been allocated by lmb. Users may load fil=
es which overwrite
> > > >> > > > > > > >> > memory allocated by EFI.
> > > >> > > > > > > >>
> > > >> > > > > > > >> 7. We need to support doing an allocation when a fi=
le is loaded (to
> > > >> > > > > > > >> ensure files do not overlap), without making it too=
 difficult to load
> > > >> > > > > > > >> multiple files to the same place, if desired.
> > > >> > > > > > > >>
> > > >> > > > > > > >> >
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > Lifetime
> > > >> > > > > > > >> > --------
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > We have three different memory allocators with di=
fferent purposes. Can
> > > >> > > > > > > >> > we unify them a little?
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > Within U-Boot:
> > > >> > > > > > > >> > - malloc() space lives forever
> > > >> > > > > > > >> > - lmb lives while setting out images for booting
> > > >> > > > > > > >> > - EFI (mostly) lives while booting an EFI app
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > In practice, EFI is set up early in U-Boot. Some =
of this is necessary,
> > > >> > > > > > > >> > some not. EFI allocations stay around forever. Th=
is works OK since
> > > >> > > > > > > >> > large allocations are normally not done in EFI, s=
o memory isn't really
> > > >> > > > > > > >> > consumed to any great degree by the boot process.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > What happens to EFI allocations if the app return=
s? They are still
> > > >> > > > > > > >> > present, in case another app is run. This seems f=
ine.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > API
> > > >> > > > > > > >> > =E2=80=93--
> > > >> > > > > > > >> > Can we unify some APIs?
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > It should be possible to use lmb for large EFI me=
mory allocations, so
> > > >> > > > > > > >> > long as they are only needed for booting. We effe=
ctively do this
> > > >> > > > > > > >> > today, since EFI does not manage the arrangement =
of loaded images in
> > > >> > > > > > > >> > memory. for the most part.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > It would not make sense to use EFI allocation to =
replace lmb and
> > > >> > > > > > > >> > malloc(), of course.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > Could we use a common (lower-level) API for alloc=
ation, used by both
> > > >> > > > > > > >> > lmb and EFI? They do have some similarities. Howe=
ver they have
> > > >> > > > > > > >> > different lifetime constraints (EFI allocations a=
re never dropped,
> > > >> > > > > > > >> > unlikely lmb).
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > ** Overall, it seems that the existence of memory=
 allocation in
> > > >> > > > > > > >> > boot-time services has created confusion. Memory =
allocation is
> > > >> > > > > > > >> > muddled, with both U-Boot code and boot-time serv=
ices calling the same
> > > >> > > > > > > >> > memory allocator. This just has not been clearly =
thought out.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > Proposal
> > > >> > > > > > > >> > =E2=80=94-------
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > Here are some ideas:
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > 1. For video, use the driver model API to locate =
the video regions, or
> > > >> > > > > > > >> > block off the entire framebuffer memory, for all =
devices as a whole.
> > > >> > > > > > > >> > Use efi_add_memory_map()
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > 2. Add memory attributes to UCLASS_RAM and use th=
em in EFI, mapping to
> > > >> > > > > > > >> > the EFI_MEMORY_... attributes in struct efi_mem_d=
esc.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > 3. Add all EFI reservations just before booting t=
he app, as we do with
> > > >> > > > > > > >> > devicetree fixup. With this model, malloc() and l=
mb are used for all
> > > >> > > > > > > >> > allocation. Then efi_add_memory_map() is called f=
or each region in
> > > >> > > > > > > >> > turn just before booting. Memory attributes are d=
ealt with above. The
> > > >> > > > > > > >> > type (enum efi_memory_type) can be determined sim=
ply by the data
> > > >> > > > > > > >> > structure stored in it, as is done today. For exa=
mple, SMBIOS tables
> > > >> > > > > > > >> > can use EFI_ACPI_RECLAIM_MEMORY. Very few types a=
re used and EFI code
> > > >> > > > > > > >> > understands the meaning of each.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > 4. Avoid setting up EFI memory at the start of U-=
Boot. Do it only when
> > > >> > > > > > > >> > booting. This looks to require very little effort=
.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > 5. Avoid calling efi_allocate_pages() and efi_all=
ocate_pool() outside
> > > >> > > > > > > >> > boot-time services. This solves the problem 6. If=
 memory is needed by
> > > >> > > > > > > >> > an app, allocate it with malloc() and see 3. Ther=
e are only two
> > > >> > > > > > > >> > efi_allocate_pages() (smbios and efi_runtime). Th=
ere are more calls of
> > > >> > > > > > > >> > efi_allocate_pool(), but most of these seem easy =
to fix up. For
> > > >> > > > > > > >> > example, efi_init_event_log() allocates a buffer,=
 but this can be
> > > >> > > > > > > >> > allocated in normal malloc() space or in a blobli=
st.
> > > >> > > > > > > >> >
> > > >> > > > > > > >> > 6. Don't worry too much about whether EFI will be=
 used for booting.
> > > >> > > > > > > >> > The cost is likely not that great: use bootstage =
to measure it as is
> > > >> > > > > > > >> > done for driver model. Try to minmise the cost of=
 its tables,
> > > >> > > > > > > >> > particularly for execution time, but otherwise ju=
st rely on the
> > > >> > > > > > > >> > ability to disable EFI_LOADER.
> > > >> > > > > > > >>
> > > >> > > > > > > >> 7. Add a flag to the 'load' command:
> > > >> > > > > > > >>
> > > >> > > > > > > >> -m <type> - make an lmb allocation for the file
> > > >> > > > > > > >>    <type> is the image type to use (kernel, ramdisk=
, flat_dt)
> > > >> > > > > > > >>
> > > >> > > > > > > >> any existing allocation for that type will be autom=
atically freed
> > > >> > > > > > > >> first. If <type> is "none" then no freeing is possi=
ble: any loaded
> > > >> > > > > > > >> images just stack up in lmb.
> > > >> > > > > > > >>
> > > >> > > > > > > >> Add an 'lmb' (or memblock) command to allow listing=
 and clearing allocations.
> > > >> > > > > > > >
> > > >> > > > > > > >I would really not like to change the user interface =
and instead simply
> > > >> > > > > > > >handle this with flags to whatever mark/allocation fu=
nction is called.
> > > >> > > > > > > >You can always overwrite things that are brought in t=
o memory, you
> > > >> > > > > > > >cannot overwrite U-Boot or our internals. Optionally =
noting that some
> > > >> > > > > > > >previous load to memory has been at least partially o=
verwritten could be
> > > >> > > > > > > >helpful, if it's not too much extra logic.
> > > >> > > > > > > >
> > > >> > > > > > >
> > > >> > > > > > > In most use cases users load exactly one file at  each=
 address. An
> > > >> > > > > > > unload command would be the cleanest way for a user to=
 indicate that
> > > >> > > > > > > he wants to reuse the memory.
> > > >> > > > > >
> > > >> > > > > > I very much do not want to change the API. There's untol=
d numbers of
> > > >> > > > > > scripts out there and they should continue to work. I me=
ntioned to Ilias
> > > >> > > > > > off list just now that I'm not against adding a command =
to add flags to
> > > >> > > > > > these areas, but I don't think it's worthwhile to preven=
t overwrites the
> > > >> > > > > > user did early. The biggest long running problem in this=
 space was that
> > > >> > > > > > for 32bit ARM we couldn't know where the kernel BSS was =
going to be and
> > > >> > > > > > so would have ramdisk at the wrong spot and get partiall=
y eaten, and
> > > >> > > > > > this was hard to figure out. The current example is "ooo=
ps,
> > > >> > > > > > decompression buffer for Image.gz/etc is too close to ot=
her things"
> > > >> > > > > > which ends up failing nice and loudly, and in the future=
 once this
> > > >> > > > > > proposal is done we can just dynamically find and use a =
spot, since
> > > >> > > > > > we'll have that ability finally.
> > > >> > > > >
> > > >> > > > > In order to keep the existing interfaces we need lmb to ke=
ep track of
> > > >> > > > > (at least ) three different states.  I think of those as "=
free",
> > > >> > > > > "allocated" and "reserved".  The load command would "reser=
ve" memory
> > > >> > > > > insteaf "allocate".  And it would pass a flag to lmb when =
reserving
> > > >> > > > > memory to indicate that reserving memory that is already r=
eserved is
> > > >> > > > > ok.  Both "reserved" and "allocated" memory should show up=
 as not free
> > > >> > > > > in the EFI memory map (probably as EfiLoaderData).
> > > >> > > >
> > > >> > > > Yes, something like this is what I was getting at, thanks.
> > > >> > >
> > > >> > > Yes, that is a good way of putting it. There is definitely a d=
istinction there.
> > > >> > >
> > > >> > > If we don't want this flag, we could make U-Boot always do a
> > > >> > > reservation on load, with a '-f' command to force loading over=
 an
> > > >> > > existing reservation / releasing it first?
> > > >> >
> > > >> > Again, this is an API change and I don't want to change the API.
> > > >>
> > > >> The flag is only needed to drop a reservation, since we apparently
> > > >> want the 'load' command to create a permanent reservation. It shou=
ld
> > > >> not affect existing boot scripts since they won't load overlapping
> > > >> images.
> > > >>
> > > >> Anyway, what do you suggest?
> > > >
> > > >That "load" (and sf read and nand read and tftp and wget and ...)
> > > >"reserve" memory but not "allocate" memory and "reserve" means somet=
hing
> > > >is there and "allocate" means that it can't be modified again. For
> > > >example, running U-Boot and our malloc pool are "allocated" but just
> > > >loading a file to memory is "reserved".  And then yes, I can see use=
 for
> > > >the command where some cases might want to "reserve" memory to fiddl=
e
> > > >with it and then "allocate" it so something else can't change it.
> > > >
> > > >This is one of those cases where english is terrible to discuss thin=
gs
> > > >in as both reserve and allocate can mean similar things.
> > > >
> > >
> > > I have no clue what the semantics of the mentioned "reserved" state m=
ight be. Up to now  memory reservations designated address ranges that U-Bo=
ot must not use at all, e.g. the memory used by OpenSBI or TF-A.
> > >
> > > Who can and who cannot write into "reserved" memory?
> > >
> > > What is wrong about allocating memory for files to forbid any other u=
se until you are done with the file and free the memory?
> >
> > So, historically (lets say mid 2010s), you could use "load" to bring a
> > file in to memory, anywhere, and it could even overwrite part of U-Boot
> > (running, or malloc pool or whatever). You could also use "load" to
> > bring a file in to memory and then bring another file in to that same
> > location in memory for whatever reason (assorted development cases).
> >
> > Then later someone noted that using "load" to overwrite U-Boot should
> > get a CVE and instead of ignoring it we decided to use "lmb" to try and
> > make sure that we couldn't use "load" to overwrite U-Boot itself, and
> > that that's a pre-check. This still allows overwriting a previously
> > loaded file in memory.
> >
> > Overwriting something the user put in memory is part of the ABI and has
> > some use cases.
> >
> > So for whatever future system we setup, a memory location can be:
> > - Free.
> > - Readable but not Writable.
> > - Readable and Writable.
> >
> > Something like $loadaddr starts as Free. If someone then uses "load" to
> > bring in an OS image, it's now "Readable and Writable". But if someone
> > does an API call to ask for a new region memory, it wouldn't return
> > $loadaddr because it's not Free. On the other hand, $relocaddr where
> > U-Boot is, at least in terms of the API is that it's "Readable but not
> > Writable".
> >
> > Does that help?

Thanks for sharing this with me. I have been working on a solution for
this issue [1], and plan to send a rfc series by the end of this week.
My primary motivation behind this work is to have some kind of
synchronisation between the allocations done by the LMB module and the
EFI subsystem. As you are aware, the way things stand today, either of
the two can make memory allocations overwriting any earlier allocated
memory. The primary reasons behind this is 1) the LMB allocations are
private to their respective callers, so the LMB memory map is not
global and persistent, and 2) the EFI allocation routines do not have
any view of the allocations that would have been made by the LMB
module.

To fix these issues, I am working on a solution which 1) makes LMB
memory map persistent and global, and 2) have notifications between
the two modules when either of the two has made any changes to it's
memory map. This way, it would be possible to prohibit one module from
allocating memory which is in use.

I am aware that we have a whole bunch of tests and user scripts which
work with an assumption that the memory can be re-used. The solution
that I would be proposing takes care of this assumption. Hopefully I
should be in a position to send a rfc series this week. We can discuss
on the patches. Thanks.

-sughosh

[1] - https://docs.google.com/document/d/1LJj4f1oBaxPIALnMlIy8Bf-3pESjecTyK=
hrQoeCfyrk/edit?usp=3Dsharing

> >
> > --
> > Tom
