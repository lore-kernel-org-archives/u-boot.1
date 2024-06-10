Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3270FC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8006488631;
	Mon, 10 Jun 2024 18:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hOWJgCl5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0ABE885FB; Mon, 10 Jun 2024 18:29:35 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC9688638
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f124e97d31so87965a34.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718036971; x=1718641771; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vfqsfL1EFpCIr4P5QWp1Dcyzh5D/D43c6aJrNhAaCAU=;
 b=hOWJgCl5wYspqNRwG6cO/WsM3REpdro7iBZrjjtvFDhdeefyBbrg+xk1YtvScagK3M
 a+YQ6VMnmflgh9rNLVNQsD/8OzTwRrdhP8W5AFDdvFERTq+EnSZX1sA1ktxe1PyXZQk7
 PwNbD2AuGaq/k7rNPwqswEpFV+/7z+nAJ0CQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718036971; x=1718641771;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfqsfL1EFpCIr4P5QWp1Dcyzh5D/D43c6aJrNhAaCAU=;
 b=JtinwV3j5t436NpekyuVh8ndBtqPqr0LSVwoSRL3RmL/LEqEXiSEEZPNnpnjVZftsJ
 +vghPuekTAZ7gDHYfZT7gEDcUG7GH3sflS5I7ivqQ9SLffpKi8nRqXJNfAqylH6Lo2PQ
 zZOLRB2MvfUfrbYJx9ZOvnc9gVhb5bCN7o9YFWAtw86zuX438VNVO0EFPdVBshIeVU5c
 jjiUmev3BifQmatmWKpVL9ZhbLL/GD7A9dFEMFLgF+tbTwcyCjR7EUMoyM7dPSilABDU
 bRzpwb7ihAKSchLTXzdrRaq6T7zmaZOHvDOut4lUQDjD7PLsKRGWkvTNjgq7yhhgbeKP
 Tqqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbTcfWUhVwIJZc6ybyJ5rogqFXHzJD4cInxS+R92R3/EgnaX2E1H+GAharJ2T5g6tHU5SNSRG5fAUrDK1HQpe5wM5qiA==
X-Gm-Message-State: AOJu0YzXA5A9EF2y3c8lZ3a4ANCboGIic0G/81M6mU14lfwY5ceiFn8S
 NibtWEGQgrqhsfjFZygOGjFKyEZMB18mMZNmW+4zh86tfw80eGnayMqWbwnjc5g=
X-Google-Smtp-Source: AGHT+IGTo53S9kck971w776ff5i1GNL/uRXqgoEWdWoRr8S+9rWOawrjF8N2EzFqDI3P/LHkWyMynw==
X-Received: by 2002:a05:6830:1e0b:b0:6f9:82ca:15b5 with SMTP id
 46e09a7af769-6f982ca1677mr5963076a34.18.1718036971202; 
 Mon, 10 Jun 2024 09:29:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f9a1b38da7sm610969a34.67.2024.06.10.09.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:29:29 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:29:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org
Subject: Re: Proposal: U-Boot memory management
Message-ID: <20240610162927.GO68077@bill-the-cat>
References: <20231229175215.GY2652760@bill-the-cat>
 <CAFLszTjXrmhOBeMvGfpy3mfZujNrCu2BKmUbEYz-rmxwyWdg3A@mail.gmail.com>
 <20231231135357.GZ2652760@bill-the-cat>
 <CAFLszTgCSDsobu9ak495vnRP-bjakK5Ytxd5YXro0-7GmYj9vA@mail.gmail.com>
 <20231231151144.GD2652760@bill-the-cat>
 <5599D28A-0255-4352-93E6-1095743F8983@gmx.de>
 <20231231161630.GE2652760@bill-the-cat>
 <CAFLszTgn2wq-QAEdgseAv7jx6TDyEQ+j6bQZZzdii2gmHtV5VA@mail.gmail.com>
 <CADg8p96jSeXOvkSX9R7g8343k9aJ6bwouSh5WJjy=AnQ+R8Kcw@mail.gmail.com>
 <CAFLszTgQKHXZ89aNz0uxUKGFCXcS5A+6Fqje+ga=gOhjWv=KOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I/PCkq5Y9kYX6FDo"
Content-Disposition: inline
In-Reply-To: <CAFLszTgQKHXZ89aNz0uxUKGFCXcS5A+6Fqje+ga=gOhjWv=KOw@mail.gmail.com>
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


--I/PCkq5Y9kYX6FDo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 07:55:44AM -0600, Simon Glass wrote:
> Hi Sughosh,
>=20
> On Thu, 6 Jun 2024 at 13:18, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > hi Simon,
> >
> > On Wed, 29 May 2024 at 22:00, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > +Sughosh Ganu for reference
> > >
> > >
> > > On Sun, 31 Dec 2023 at 09:16, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Dec 31, 2023 at 04:40:06PM +0100, Heinrich Schuchardt wrote:
> > > > >
> > > > >
> > > > > Am 31. Dezember 2023 16:11:44 MEZ schrieb Tom Rini <trini@konsulk=
o.com>:
> > > > > >On Sun, Dec 31, 2023 at 07:22:10AM -0700, Simon Glass wrote:
> > > > > >> Hi Tom,
> > > > > >>
> > > > > >> On Sun, Dec 31, 2023 at 6:54=E2=80=AFAM Tom Rini <trini@konsul=
ko.com> wrote:
> > > > > >> >
> > > > > >> > On Sun, Dec 31, 2023 at 05:48:23AM -0700, Simon Glass wrote:
> > > > > >> > > Hi,
> > > > > >> > >
> > > > > >> > > On Fri, Dec 29, 2023 at 10:52=E2=80=AFAM Tom Rini <trini@k=
onsulko.com> wrote:
> > > > > >> > > >
> > > > > >> > > > On Fri, Dec 29, 2023 at 06:44:15PM +0100, Mark Kettenis =
wrote:
> > > > > >> > > > > > Date: Fri, 29 Dec 2023 11:17:44 -0500
> > > > > >> > > > > > From: Tom Rini <trini@konsulko.com>
> > > > > >> > > > > >
> > > > > >> > > > > > On Fri, Dec 29, 2023 at 05:05:17PM +0100, Heinrich S=
chuchardt wrote:
> > > > > >> > > > > > >
> > > > > >> > > > > > >
> > > > > >> > > > > > > Am 29. Dezember 2023 16:43:07 MEZ schrieb Tom Rini=
 <trini@konsulko.com>:
> > > > > >> > > > > > > >On Fri, Dec 29, 2023 at 05:36:09AM +0000, Simon G=
lass wrote:
> > > > > >> > > > > > > >> Hi,
> > > > > >> > > > > > > >>
> > > > > >> > > > > > > >> On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM Simon G=
lass <sjg@chromium.org> wrote:
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > Hi,
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > This records my thoughts after a discussion w=
ith Ilias & Heinrich re
> > > > > >> > > > > > > >> > memory allocation in U-Boot.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > 1. malloc()
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > malloc() is used for programmatic memory allo=
cation. It allows memory
> > > > > >> > > > > > > >> > to be freed. It is not designed for very larg=
e allocations (e.g. a
> > > > > >> > > > > > > >> > 10MB kernel or 100MB ramdisk).
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > 2. lmb
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > lmb is used for large blocks of memory, such =
as those needed for a
> > > > > >> > > > > > > >> > kernel or ramdisk. Allocation is only transit=
ory, for the purposes of
> > > > > >> > > > > > > >> > loading some images and booting. If the boot =
fails, then all lmb
> > > > > >> > > > > > > >> > allocations go away.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > lmb is set up by getting all available memory=
 and then removing what
> > > > > >> > > > > > > >> > is used by U-Boot (code, data, malloc() space=
, etc.)
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > lmb reservations have a few flags so that are=
as of memory can be
> > > > > >> > > > > > > >> > provided with attributes
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > There are some corner cases...e.g. loading a =
file does an lmb
> > > > > >> > > > > > > >> > allocation but only for the purpose of avoidi=
ng a file being loaded
> > > > > >> > > > > > > >> > over U-Boot code/data. The allocation is drop=
ped immediately after the
> > > > > >> > > > > > > >> > file is loaded. Within the bootm command, or =
when using standard boot,
> > > > > >> > > > > > > >> > this would be fairly easy to solve.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > Linux has renamed lmb to memblock. We should =
consider doing the same.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > 3. EFI
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > EFI has its own memory-allocation tables.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > Like lmb, EFI is able to deal with large allo=
cations. But via a 'pool'
> > > > > >> > > > > > > >> > function it can also do smaller allocations s=
imilar to malloc(),
> > > > > >> > > > > > > >> > although each one uses at least 4KB at presen=
t.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > EFI allocations do not go away when a boot fa=
ils.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > With EFI it is possible to add allocations po=
st facto, in which case
> > > > > >> > > > > > > >> > they are added to the allocation table just a=
s if the memory was
> > > > > >> > > > > > > >> > allocated with EFI to begin with.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > The EFI allocations and the lmb allocations u=
se the same memory, so in
> > > > > >> > > > > > > >> > principle could conflict.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > EFI allocations are sometimes used to allocat=
e internal U-Boot data as
> > > > > >> > > > > > > >> > well, if needed by the EFI app. For example, =
while efi_image_parse()
> > > > > >> > > > > > > >> > uses malloc(), efi_var_mem.c uses EFI allocat=
ions since the code runs
> > > > > >> > > > > > > >> > in the app context and may need to access the=
 memory after U-Boot has
> > > > > >> > > > > > > >> > exited. Also efi_smbios.c uses allocate_pages=
() and then adds a new
> > > > > >> > > > > > > >> > mapping as well.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > EFI memory has attributes, including what the=
 memory is used for (to
> > > > > >> > > > > > > >> > some degree of granularity). See enum efi_mem=
ory_type and struct
> > > > > >> > > > > > > >> > efi_mem_desc. In the latter there are also at=
tribute flags - whether
> > > > > >> > > > > > > >> > memory is cacheable, etc.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > EFI also has the x86 idea of 'conventional' m=
emory, meaning (I
> > > > > >> > > > > > > >> > believe) that below 4GB that isn't reserved f=
or the hardware/system.
> > > > > >> > > > > > > >> > This is meaningless, or at least confusing, o=
n ARM systems.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > 4. reservations
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > It is perhaps worth mentioning a fourth metho=
d of memory management,
> > > > > >> > > > > > > >> > where U-Boot reserves chunks of memory before=
 relocation (in
> > > > > >> > > > > > > >> > board_init_f.c), e.g. for the framebuffer, U-=
Boot code, the malloc()
> > > > > >> > > > > > > >> > region, etc.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > Problems
> > > > > >> > > > > > > >> > =E2=80=94-------
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > There are no urgent problems, but here are so=
me things that could be improved:
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > 1. EFI should attach most of its data structu=
res to driver model. This
> > > > > >> > > > > > > >> > work has started, with the partition support,=
 but more effort would
> > > > > >> > > > > > > >> > help. This would make it easier to see which =
memory is related to
> > > > > >> > > > > > > >> > devices and which is separate.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > 2. Some drivers do EFI reservations today, wh=
ether EFI is used for
> > > > > >> > > > > > > >> > booting or not (e.g. rockchip video rk_vop_pr=
obe()).
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > 3. U-Boot doesn't really map arch-specific me=
mory attributes (e.g.
> > > > > >> > > > > > > >> > armv8's struct mm_region) to EFI ones.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > 4. EFI duplicates some code from bootm, some =
of which relates to
> > > > > >> > > > > > > >> > memory allocation (e.g. FDT fixup).
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > 5. EFI code is used even if EFI is never used=
 to boot
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > 6. EFI allocations can result in the same mem=
ory being used as has
> > > > > >> > > > > > > >> > already been allocated by lmb. Users may load=
 files which overwrite
> > > > > >> > > > > > > >> > memory allocated by EFI.
> > > > > >> > > > > > > >>
> > > > > >> > > > > > > >> 7. We need to support doing an allocation when =
a file is loaded (to
> > > > > >> > > > > > > >> ensure files do not overlap), without making it=
 too difficult to load
> > > > > >> > > > > > > >> multiple files to the same place, if desired.
> > > > > >> > > > > > > >>
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > Lifetime
> > > > > >> > > > > > > >> > --------
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > We have three different memory allocators wit=
h different purposes. Can
> > > > > >> > > > > > > >> > we unify them a little?
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > Within U-Boot:
> > > > > >> > > > > > > >> > - malloc() space lives forever
> > > > > >> > > > > > > >> > - lmb lives while setting out images for boot=
ing
> > > > > >> > > > > > > >> > - EFI (mostly) lives while booting an EFI app
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > In practice, EFI is set up early in U-Boot. S=
ome of this is necessary,
> > > > > >> > > > > > > >> > some not. EFI allocations stay around forever=
=2E This works OK since
> > > > > >> > > > > > > >> > large allocations are normally not done in EF=
I, so memory isn't really
> > > > > >> > > > > > > >> > consumed to any great degree by the boot proc=
ess.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > What happens to EFI allocations if the app re=
turns? They are still
> > > > > >> > > > > > > >> > present, in case another app is run. This see=
ms fine.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > API
> > > > > >> > > > > > > >> > =E2=80=93--
> > > > > >> > > > > > > >> > Can we unify some APIs?
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > It should be possible to use lmb for large EF=
I memory allocations, so
> > > > > >> > > > > > > >> > long as they are only needed for booting. We =
effectively do this
> > > > > >> > > > > > > >> > today, since EFI does not manage the arrangem=
ent of loaded images in
> > > > > >> > > > > > > >> > memory. for the most part.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > It would not make sense to use EFI allocation=
 to replace lmb and
> > > > > >> > > > > > > >> > malloc(), of course.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > Could we use a common (lower-level) API for a=
llocation, used by both
> > > > > >> > > > > > > >> > lmb and EFI? They do have some similarities. =
However they have
> > > > > >> > > > > > > >> > different lifetime constraints (EFI allocatio=
ns are never dropped,
> > > > > >> > > > > > > >> > unlikely lmb).
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > ** Overall, it seems that the existence of me=
mory allocation in
> > > > > >> > > > > > > >> > boot-time services has created confusion. Mem=
ory allocation is
> > > > > >> > > > > > > >> > muddled, with both U-Boot code and boot-time =
services calling the same
> > > > > >> > > > > > > >> > memory allocator. This just has not been clea=
rly thought out.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > Proposal
> > > > > >> > > > > > > >> > =E2=80=94-------
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > Here are some ideas:
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > 1. For video, use the driver model API to loc=
ate the video regions, or
> > > > > >> > > > > > > >> > block off the entire framebuffer memory, for =
all devices as a whole.
> > > > > >> > > > > > > >> > Use efi_add_memory_map()
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > 2. Add memory attributes to UCLASS_RAM and us=
e them in EFI, mapping to
> > > > > >> > > > > > > >> > the EFI_MEMORY_... attributes in struct efi_m=
em_desc.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > 3. Add all EFI reservations just before booti=
ng the app, as we do with
> > > > > >> > > > > > > >> > devicetree fixup. With this model, malloc() a=
nd lmb are used for all
> > > > > >> > > > > > > >> > allocation. Then efi_add_memory_map() is call=
ed for each region in
> > > > > >> > > > > > > >> > turn just before booting. Memory attributes a=
re dealt with above. The
> > > > > >> > > > > > > >> > type (enum efi_memory_type) can be determined=
 simply by the data
> > > > > >> > > > > > > >> > structure stored in it, as is done today. For=
 example, SMBIOS tables
> > > > > >> > > > > > > >> > can use EFI_ACPI_RECLAIM_MEMORY. Very few typ=
es are used and EFI code
> > > > > >> > > > > > > >> > understands the meaning of each.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > 4. Avoid setting up EFI memory at the start o=
f U-Boot. Do it only when
> > > > > >> > > > > > > >> > booting. This looks to require very little ef=
fort.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > 5. Avoid calling efi_allocate_pages() and efi=
_allocate_pool() outside
> > > > > >> > > > > > > >> > boot-time services. This solves the problem 6=
=2E If memory is needed by
> > > > > >> > > > > > > >> > an app, allocate it with malloc() and see 3. =
There are only two
> > > > > >> > > > > > > >> > efi_allocate_pages() (smbios and efi_runtime)=
=2E There are more calls of
> > > > > >> > > > > > > >> > efi_allocate_pool(), but most of these seem e=
asy to fix up. For
> > > > > >> > > > > > > >> > example, efi_init_event_log() allocates a buf=
fer, but this can be
> > > > > >> > > > > > > >> > allocated in normal malloc() space or in a bl=
oblist.
> > > > > >> > > > > > > >> >
> > > > > >> > > > > > > >> > 6. Don't worry too much about whether EFI wil=
l be used for booting.
> > > > > >> > > > > > > >> > The cost is likely not that great: use bootst=
age to measure it as is
> > > > > >> > > > > > > >> > done for driver model. Try to minmise the cos=
t of its tables,
> > > > > >> > > > > > > >> > particularly for execution time, but otherwis=
e just rely on the
> > > > > >> > > > > > > >> > ability to disable EFI_LOADER.
> > > > > >> > > > > > > >>
> > > > > >> > > > > > > >> 7. Add a flag to the 'load' command:
> > > > > >> > > > > > > >>
> > > > > >> > > > > > > >> -m <type> - make an lmb allocation for the file
> > > > > >> > > > > > > >>    <type> is the image type to use (kernel, ram=
disk, flat_dt)
> > > > > >> > > > > > > >>
> > > > > >> > > > > > > >> any existing allocation for that type will be a=
utomatically freed
> > > > > >> > > > > > > >> first. If <type> is "none" then no freeing is p=
ossible: any loaded
> > > > > >> > > > > > > >> images just stack up in lmb.
> > > > > >> > > > > > > >>
> > > > > >> > > > > > > >> Add an 'lmb' (or memblock) command to allow lis=
ting and clearing allocations.
> > > > > >> > > > > > > >
> > > > > >> > > > > > > >I would really not like to change the user interf=
ace and instead simply
> > > > > >> > > > > > > >handle this with flags to whatever mark/allocatio=
n function is called.
> > > > > >> > > > > > > >You can always overwrite things that are brought =
in to memory, you
> > > > > >> > > > > > > >cannot overwrite U-Boot or our internals. Optiona=
lly noting that some
> > > > > >> > > > > > > >previous load to memory has been at least partial=
ly overwritten could be
> > > > > >> > > > > > > >helpful, if it's not too much extra logic.
> > > > > >> > > > > > > >
> > > > > >> > > > > > >
> > > > > >> > > > > > > In most use cases users load exactly one file at  =
each address. An
> > > > > >> > > > > > > unload command would be the cleanest way for a use=
r to indicate that
> > > > > >> > > > > > > he wants to reuse the memory.
> > > > > >> > > > > >
> > > > > >> > > > > > I very much do not want to change the API. There's u=
ntold numbers of
> > > > > >> > > > > > scripts out there and they should continue to work. =
I mentioned to Ilias
> > > > > >> > > > > > off list just now that I'm not against adding a comm=
and to add flags to
> > > > > >> > > > > > these areas, but I don't think it's worthwhile to pr=
event overwrites the
> > > > > >> > > > > > user did early. The biggest long running problem in =
this space was that
> > > > > >> > > > > > for 32bit ARM we couldn't know where the kernel BSS =
was going to be and
> > > > > >> > > > > > so would have ramdisk at the wrong spot and get part=
ially eaten, and
> > > > > >> > > > > > this was hard to figure out. The current example is =
"ooops,
> > > > > >> > > > > > decompression buffer for Image.gz/etc is too close t=
o other things"
> > > > > >> > > > > > which ends up failing nice and loudly, and in the fu=
ture once this
> > > > > >> > > > > > proposal is done we can just dynamically find and us=
e a spot, since
> > > > > >> > > > > > we'll have that ability finally.
> > > > > >> > > > >
> > > > > >> > > > > In order to keep the existing interfaces we need lmb t=
o keep track of
> > > > > >> > > > > (at least ) three different states.  I think of those =
as "free",
> > > > > >> > > > > "allocated" and "reserved".  The load command would "r=
eserve" memory
> > > > > >> > > > > insteaf "allocate".  And it would pass a flag to lmb w=
hen reserving
> > > > > >> > > > > memory to indicate that reserving memory that is alrea=
dy reserved is
> > > > > >> > > > > ok.  Both "reserved" and "allocated" memory should sho=
w up as not free
> > > > > >> > > > > in the EFI memory map (probably as EfiLoaderData).
> > > > > >> > > >
> > > > > >> > > > Yes, something like this is what I was getting at, thank=
s.
> > > > > >> > >
> > > > > >> > > Yes, that is a good way of putting it. There is definitely=
 a distinction there.
> > > > > >> > >
> > > > > >> > > If we don't want this flag, we could make U-Boot always do=
 a
> > > > > >> > > reservation on load, with a '-f' command to force loading =
over an
> > > > > >> > > existing reservation / releasing it first?
> > > > > >> >
> > > > > >> > Again, this is an API change and I don't want to change the =
API.
> > > > > >>
> > > > > >> The flag is only needed to drop a reservation, since we appare=
ntly
> > > > > >> want the 'load' command to create a permanent reservation. It =
should
> > > > > >> not affect existing boot scripts since they won't load overlap=
ping
> > > > > >> images.
> > > > > >>
> > > > > >> Anyway, what do you suggest?
> > > > > >
> > > > > >That "load" (and sf read and nand read and tftp and wget and ...)
> > > > > >"reserve" memory but not "allocate" memory and "reserve" means s=
omething
> > > > > >is there and "allocate" means that it can't be modified again. F=
or
> > > > > >example, running U-Boot and our malloc pool are "allocated" but =
just
> > > > > >loading a file to memory is "reserved".  And then yes, I can see=
 use for
> > > > > >the command where some cases might want to "reserve" memory to f=
iddle
> > > > > >with it and then "allocate" it so something else can't change it.
> > > > > >
> > > > > >This is one of those cases where english is terrible to discuss =
things
> > > > > >in as both reserve and allocate can mean similar things.
> > > > > >
> > > > >
> > > > > I have no clue what the semantics of the mentioned "reserved" sta=
te might be. Up to now  memory reservations designated address ranges that =
U-Boot must not use at all, e.g. the memory used by OpenSBI or TF-A.
> > > > >
> > > > > Who can and who cannot write into "reserved" memory?
> > > > >
> > > > > What is wrong about allocating memory for files to forbid any oth=
er use until you are done with the file and free the memory?
> > > >
> > > > So, historically (lets say mid 2010s), you could use "load" to brin=
g a
> > > > file in to memory, anywhere, and it could even overwrite part of U-=
Boot
> > > > (running, or malloc pool or whatever). You could also use "load" to
> > > > bring a file in to memory and then bring another file in to that sa=
me
> > > > location in memory for whatever reason (assorted development cases).
> > > >
> > > > Then later someone noted that using "load" to overwrite U-Boot shou=
ld
> > > > get a CVE and instead of ignoring it we decided to use "lmb" to try=
 and
> > > > make sure that we couldn't use "load" to overwrite U-Boot itself, a=
nd
> > > > that that's a pre-check. This still allows overwriting a previously
> > > > loaded file in memory.
> > > >
> > > > Overwriting something the user put in memory is part of the ABI and=
 has
> > > > some use cases.
> > > >
> > > > So for whatever future system we setup, a memory location can be:
> > > > - Free.
> > > > - Readable but not Writable.
> > > > - Readable and Writable.
> > > >
> > > > Something like $loadaddr starts as Free. If someone then uses "load=
" to
> > > > bring in an OS image, it's now "Readable and Writable". But if some=
one
> > > > does an API call to ask for a new region memory, it wouldn't return
> > > > $loadaddr because it's not Free. On the other hand, $relocaddr where
> > > > U-Boot is, at least in terms of the API is that it's "Readable but =
not
> > > > Writable".
> > > >
> > > > Does that help?
> >
> > Thanks for sharing this with me. I have been working on a solution for
> > this issue [1], and plan to send a rfc series by the end of this week.
> > My primary motivation behind this work is to have some kind of
> > synchronisation between the allocations done by the LMB module and the
> > EFI subsystem. As you are aware, the way things stand today, either of
> > the two can make memory allocations overwriting any earlier allocated
> > memory. The primary reasons behind this is 1) the LMB allocations are
> > private to their respective callers, so the LMB memory map is not
> > global and persistent, and 2) the EFI allocation routines do not have
> > any view of the allocations that would have been made by the LMB
> > module.
> >
> > To fix these issues, I am working on a solution which 1) makes LMB
> > memory map persistent and global, and 2) have notifications between
> > the two modules when either of the two has made any changes to it's
> > memory map. This way, it would be possible to prohibit one module from
> > allocating memory which is in use.
> >
> > I am aware that we have a whole bunch of tests and user scripts which
> > work with an assumption that the memory can be re-used. The solution
> > that I would be proposing takes care of this assumption. Hopefully I
> > should be in a position to send a rfc series this week. We can discuss
> > on the patches. Thanks.
>=20
> I actually am not sure what we are on the same page here. I described
> the problems in my original email but your series seems to solve
> somewhat different problems, while IMO introducing a whole new class
> of problems.
>=20
> Making LMB persistent and global is a solution looking for a problem,
> IMO. Can we go up a level and figure out exactly what is broken here?
> That is what I attempted to do in my original email. Perhaps you could
> reply to that and suggest where you agree / disagree?

Again, the fundamental problem is that LMB as originally introduced was
fine enough for the time it was introduced and the limited sets of
problems we were caring about, which was essentially ONLY "put a few
objects in non-conflicting areas for the OS". That's no longer the case,
so we need something different that IS persistent from caller to caller.
I do need to read Sughosh's series, but it is the starting point for
discussion of an implementation for modern systems and problems, not a
call to go back to the drawing board.

--=20
Tom

--I/PCkq5Y9kYX6FDo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZnKeEACgkQFHw5/5Y0
tyzvMwwAk1GcDzNR7gTMJdJc0Jrp5BgG9FI557OaZPZbJMFU+SjlXHI2orFz2HUG
rKc1lFAHLewpSMa++UIgHqt8TSmOB9Vxg9XpyDQoFNun6xFqA1wapIm83bxtLKYj
0NHQNDqygJiANxOTeF9Ba1nTB7Rq7B66bLB/jyyXoA5zwq7M4al4rFUyQOVxyTpE
9ju0gRi8gOS2DtXUOBToBeV3aqSECjIBHv1Uo1tPZHD4RMAlX6ZNLEVhcmvahDDz
R6rzgTj7l+t4ed/rVQdKKT7Gl+AsIww89LM5Sg2PR/acAk9sugV+L4ruMGNnicId
ExA2fIbbDodEQz0k1qtI95MEl8A2UWWouoiApGIiJ/QE/U0X3Mk+L44CDsZ7kZri
RUotmA1/oHINRKMvRuZMa/wKs9QzrDDtcBxS6br3EiLxZQkGBEyQg8G4c7EzJuLZ
GMhTqPE5sjhlxrNxKr65XL1gf9Qhpv6v0UaGQ0/6a4Y0VT+6Xn/8xWKJP2NdT390
E4vC4ZDL
=RsiF
-----END PGP SIGNATURE-----

--I/PCkq5Y9kYX6FDo--
