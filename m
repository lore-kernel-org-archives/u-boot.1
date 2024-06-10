Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C12C27C5F
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:54:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3291588614;
	Mon, 10 Jun 2024 17:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b5/BlbAu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5DE68858E; Mon, 10 Jun 2024 17:54:19 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7DC4885EB
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 17:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7965d034cedso481385a.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718034855; x=1718639655; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gw7aO5+0jxrcVfZmjgpcJfmafLE/SYS44qgI8HkjLYg=;
 b=b5/BlbAuixaiv9f1z8falgirfgyBpyRJL5bGqpucqGfboSo2G3SK9kQBRa6kvI47vL
 g9CpqoKi6dUXP7mOKG5Wiy3QW9XAfjhIwuZ+m0NLiKOmOen10+It+BgCRq+fjcMMl3s+
 zLWGCxsNzmrpt+LsyiFelH0wLLKQAuS08EFnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718034855; x=1718639655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gw7aO5+0jxrcVfZmjgpcJfmafLE/SYS44qgI8HkjLYg=;
 b=osFuUmCMuFwfWbUrwhLsSFsl9sqhgDRRPSSSva1PGGO5oT0ahd7Tq3cqWNCr6CKAKH
 icXFM2UL43y4PXOlDYp5z475SaabBWylDViHNrfMRQiPIWCeVSfy5hHsyuPiiZGJYMHg
 XfAAhuaHg6EaLdJMnbI+3NapXad6iaqTcZRjEAS+m3a6cAkvulXMB3En8GlbsAl0AV9G
 WhI8S0p1flY+fX0VSnYy1BgKCGG+O4QfMudXUI+3qUfOCnzi0DsaH8op18sMEAhVhb1H
 1bMQgR4ZlSBZiPwdvqeDr25RhhFWOj1ZdPe6rK+kFw3O8jUnK0U2NlLp7ceGjdrafhIj
 sUng==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0gl/D5fpMCxp/hAdwqllDvbZlURUP5yO5T43CRMInN3ijawedqZyaCxvaOtgz9g58c+xUzlEViNq5RDXx5cCvz9cR/w==
X-Gm-Message-State: AOJu0Yy92COe9RJHyHsUooSPdruGbHbGNNAELzFTR6vepHvOi3zcbp1L
 Wh3goxsOHqK4aUJa/YJUB4TX34oSVfbdIMkQ7ONMrllsPdVmkJq6yeJxuuSd8YPYAJDRORthyiE
 wVo7NLLfrZGHq5uJFrOPYsforqjZ/3duquOC+j8gZG77mRZY=
X-Google-Smtp-Source: AGHT+IFy/Kqd9B+2SGo4IcXySxfdeWpZzJvVjGmbK3rCdSYKOmzg4FN9sV61j31F9ttdewMQXc6QcrDCFkwVds9gJMo=
X-Received: by 2002:a05:6214:1ccb:b0:6b0:5e79:14b with SMTP id
 6a1803df08f44-6b05e790313mr99737706d6.18.1718034855218; Mon, 10 Jun 2024
 08:54:15 -0700 (PDT)
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
 <CAFLszTgQKHXZ89aNz0uxUKGFCXcS5A+6Fqje+ga=gOhjWv=KOw@mail.gmail.com>
 <CADg8p95eRCduZ-HKDsFO-rRpdV3q033nespjCAfAd1oE64iRtw@mail.gmail.com>
 <CAFLszTihZjxsLhROmr=KKqPfqAxsBZs0RzmnKpsgtfmtg8cZog@mail.gmail.com>
 <CADg8p97uQrBr_tbHSHkKnQtoj7r=3xaMHYpJnCtcuYE-q7hSCQ@mail.gmail.com>
In-Reply-To: <CADg8p97uQrBr_tbHSHkKnQtoj7r=3xaMHYpJnCtcuYE-q7hSCQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Jun 2024 09:54:04 -0600
Message-ID: <CAFLszTigMmcnvxyCzVJ3bSZsHcwf0Wohe3yBaBqd4-AsPFV8zQ@mail.gmail.com>
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

On Mon, 10 Jun 2024 at 09:17, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Mon, 10 Jun 2024 at 20:33, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Mon, 10 Jun 2024 at 08:40, Sughosh Ganu <sughosh.ganu@linaro.org> wr=
ote:
> > >
> > > hi Simon,
> > >
> > > On Mon, 10 Jun 2024 at 19:25, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Thu, 6 Jun 2024 at 13:18, Sughosh Ganu <sughosh.ganu@linaro.org>=
 wrote:
> > > > >
> > > > > hi Simon,
> > > > >
> > > > > On Wed, 29 May 2024 at 22:00, Simon Glass <sjg@chromium.org> wrot=
e:
> > > > > >
> > > > > > +Sughosh Ganu for reference
> > > > > >
> > > > > >
> > > > > > On Sun, 31 Dec 2023 at 09:16, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Sun, Dec 31, 2023 at 04:40:06PM +0100, Heinrich Schuchardt=
 wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > Am 31. Dezember 2023 16:11:44 MEZ schrieb Tom Rini <trini@k=
onsulko.com>:
> > > > > > > > >On Sun, Dec 31, 2023 at 07:22:10AM -0700, Simon Glass wrot=
e:
> > > > > > > > >> Hi Tom,
> > > > > > > > >>
> > > > > > > > >> On Sun, Dec 31, 2023 at 6:54=E2=80=AFAM Tom Rini <trini@=
konsulko.com> wrote:
> > > > > > > > >> >
> > > > > > > > >> > On Sun, Dec 31, 2023 at 05:48:23AM -0700, Simon Glass =
wrote:
> > > > > > > > >> > > Hi,
> > > > > > > > >> > >
> > > > > > > > >> > > On Fri, Dec 29, 2023 at 10:52=E2=80=AFAM Tom Rini <t=
rini@konsulko.com> wrote:
> > > > > > > > >> > > >
> > > > > > > > >> > > > On Fri, Dec 29, 2023 at 06:44:15PM +0100, Mark Ket=
tenis wrote:
> > > > > > > > >> > > > > > Date: Fri, 29 Dec 2023 11:17:44 -0500
> > > > > > > > >> > > > > > From: Tom Rini <trini@konsulko.com>
> > > > > > > > >> > > > > >
> > > > > > > > >> > > > > > On Fri, Dec 29, 2023 at 05:05:17PM +0100, Hein=
rich Schuchardt wrote:
> > > > > > > > >> > > > > > >
> > > > > > > > >> > > > > > >
> > > > > > > > >> > > > > > > Am 29. Dezember 2023 16:43:07 MEZ schrieb To=
m Rini <trini@konsulko.com>:
> > > > > > > > >> > > > > > > >On Fri, Dec 29, 2023 at 05:36:09AM +0000, S=
imon Glass wrote:
> > > > > > > > >> > > > > > > >> Hi,
> > > > > > > > >> > > > > > > >>
> > > > > > > > >> > > > > > > >> On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM S=
imon Glass <sjg@chromium.org> wrote:
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > Hi,
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > This records my thoughts after a discus=
sion with Ilias & Heinrich re
> > > > > > > > >> > > > > > > >> > memory allocation in U-Boot.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > 1. malloc()
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > malloc() is used for programmatic memor=
y allocation. It allows memory
> > > > > > > > >> > > > > > > >> > to be freed. It is not designed for ver=
y large allocations (e.g. a
> > > > > > > > >> > > > > > > >> > 10MB kernel or 100MB ramdisk).
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > 2. lmb
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > lmb is used for large blocks of memory,=
 such as those needed for a
> > > > > > > > >> > > > > > > >> > kernel or ramdisk. Allocation is only t=
ransitory, for the purposes of
> > > > > > > > >> > > > > > > >> > loading some images and booting. If the=
 boot fails, then all lmb
> > > > > > > > >> > > > > > > >> > allocations go away.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > lmb is set up by getting all available =
memory and then removing what
> > > > > > > > >> > > > > > > >> > is used by U-Boot (code, data, malloc()=
 space, etc.)
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > lmb reservations have a few flags so th=
at areas of memory can be
> > > > > > > > >> > > > > > > >> > provided with attributes
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > There are some corner cases...e.g. load=
ing a file does an lmb
> > > > > > > > >> > > > > > > >> > allocation but only for the purpose of =
avoiding a file being loaded
> > > > > > > > >> > > > > > > >> > over U-Boot code/data. The allocation i=
s dropped immediately after the
> > > > > > > > >> > > > > > > >> > file is loaded. Within the bootm comman=
d, or when using standard boot,
> > > > > > > > >> > > > > > > >> > this would be fairly easy to solve.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > Linux has renamed lmb to memblock. We s=
hould consider doing the same.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > 3. EFI
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > EFI has its own memory-allocation table=
s.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > Like lmb, EFI is able to deal with larg=
e allocations. But via a 'pool'
> > > > > > > > >> > > > > > > >> > function it can also do smaller allocat=
ions similar to malloc(),
> > > > > > > > >> > > > > > > >> > although each one uses at least 4KB at =
present.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > EFI allocations do not go away when a b=
oot fails.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > With EFI it is possible to add allocati=
ons post facto, in which case
> > > > > > > > >> > > > > > > >> > they are added to the allocation table =
just as if the memory was
> > > > > > > > >> > > > > > > >> > allocated with EFI to begin with.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > The EFI allocations and the lmb allocat=
ions use the same memory, so in
> > > > > > > > >> > > > > > > >> > principle could conflict.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > EFI allocations are sometimes used to a=
llocate internal U-Boot data as
> > > > > > > > >> > > > > > > >> > well, if needed by the EFI app. For exa=
mple, while efi_image_parse()
> > > > > > > > >> > > > > > > >> > uses malloc(), efi_var_mem.c uses EFI a=
llocations since the code runs
> > > > > > > > >> > > > > > > >> > in the app context and may need to acce=
ss the memory after U-Boot has
> > > > > > > > >> > > > > > > >> > exited. Also efi_smbios.c uses allocate=
_pages() and then adds a new
> > > > > > > > >> > > > > > > >> > mapping as well.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > EFI memory has attributes, including wh=
at the memory is used for (to
> > > > > > > > >> > > > > > > >> > some degree of granularity). See enum e=
fi_memory_type and struct
> > > > > > > > >> > > > > > > >> > efi_mem_desc. In the latter there are a=
lso attribute flags - whether
> > > > > > > > >> > > > > > > >> > memory is cacheable, etc.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > EFI also has the x86 idea of 'conventio=
nal' memory, meaning (I
> > > > > > > > >> > > > > > > >> > believe) that below 4GB that isn't rese=
rved for the hardware/system.
> > > > > > > > >> > > > > > > >> > This is meaningless, or at least confus=
ing, on ARM systems.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > 4. reservations
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > It is perhaps worth mentioning a fourth=
 method of memory management,
> > > > > > > > >> > > > > > > >> > where U-Boot reserves chunks of memory =
before relocation (in
> > > > > > > > >> > > > > > > >> > board_init_f.c), e.g. for the framebuff=
er, U-Boot code, the malloc()
> > > > > > > > >> > > > > > > >> > region, etc.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > Problems
> > > > > > > > >> > > > > > > >> > =E2=80=94-------
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > There are no urgent problems, but here =
are some things that could be improved:
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > 1. EFI should attach most of its data s=
tructures to driver model. This
> > > > > > > > >> > > > > > > >> > work has started, with the partition su=
pport, but more effort would
> > > > > > > > >> > > > > > > >> > help. This would make it easier to see =
which memory is related to
> > > > > > > > >> > > > > > > >> > devices and which is separate.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > 2. Some drivers do EFI reservations tod=
ay, whether EFI is used for
> > > > > > > > >> > > > > > > >> > booting or not (e.g. rockchip video rk_=
vop_probe()).
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > 3. U-Boot doesn't really map arch-speci=
fic memory attributes (e.g.
> > > > > > > > >> > > > > > > >> > armv8's struct mm_region) to EFI ones.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > 4. EFI duplicates some code from bootm,=
 some of which relates to
> > > > > > > > >> > > > > > > >> > memory allocation (e.g. FDT fixup).
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > 5. EFI code is used even if EFI is neve=
r used to boot
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > 6. EFI allocations can result in the sa=
me memory being used as has
> > > > > > > > >> > > > > > > >> > already been allocated by lmb. Users ma=
y load files which overwrite
> > > > > > > > >> > > > > > > >> > memory allocated by EFI.
> > > > > > > > >> > > > > > > >>
> > > > > > > > >> > > > > > > >> 7. We need to support doing an allocation=
 when a file is loaded (to
> > > > > > > > >> > > > > > > >> ensure files do not overlap), without mak=
ing it too difficult to load
> > > > > > > > >> > > > > > > >> multiple files to the same place, if desi=
red.
> > > > > > > > >> > > > > > > >>
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > Lifetime
> > > > > > > > >> > > > > > > >> > --------
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > We have three different memory allocato=
rs with different purposes. Can
> > > > > > > > >> > > > > > > >> > we unify them a little?
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > Within U-Boot:
> > > > > > > > >> > > > > > > >> > - malloc() space lives forever
> > > > > > > > >> > > > > > > >> > - lmb lives while setting out images fo=
r booting
> > > > > > > > >> > > > > > > >> > - EFI (mostly) lives while booting an E=
FI app
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > In practice, EFI is set up early in U-B=
oot. Some of this is necessary,
> > > > > > > > >> > > > > > > >> > some not. EFI allocations stay around f=
orever. This works OK since
> > > > > > > > >> > > > > > > >> > large allocations are normally not done=
 in EFI, so memory isn't really
> > > > > > > > >> > > > > > > >> > consumed to any great degree by the boo=
t process.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > What happens to EFI allocations if the =
app returns? They are still
> > > > > > > > >> > > > > > > >> > present, in case another app is run. Th=
is seems fine.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > API
> > > > > > > > >> > > > > > > >> > =E2=80=93--
> > > > > > > > >> > > > > > > >> > Can we unify some APIs?
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > It should be possible to use lmb for la=
rge EFI memory allocations, so
> > > > > > > > >> > > > > > > >> > long as they are only needed for bootin=
g. We effectively do this
> > > > > > > > >> > > > > > > >> > today, since EFI does not manage the ar=
rangement of loaded images in
> > > > > > > > >> > > > > > > >> > memory. for the most part.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > It would not make sense to use EFI allo=
cation to replace lmb and
> > > > > > > > >> > > > > > > >> > malloc(), of course.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > Could we use a common (lower-level) API=
 for allocation, used by both
> > > > > > > > >> > > > > > > >> > lmb and EFI? They do have some similari=
ties. However they have
> > > > > > > > >> > > > > > > >> > different lifetime constraints (EFI all=
ocations are never dropped,
> > > > > > > > >> > > > > > > >> > unlikely lmb).
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > ** Overall, it seems that the existence=
 of memory allocation in
> > > > > > > > >> > > > > > > >> > boot-time services has created confusio=
n. Memory allocation is
> > > > > > > > >> > > > > > > >> > muddled, with both U-Boot code and boot=
-time services calling the same
> > > > > > > > >> > > > > > > >> > memory allocator. This just has not bee=
n clearly thought out.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > Proposal
> > > > > > > > >> > > > > > > >> > =E2=80=94-------
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > Here are some ideas:
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > 1. For video, use the driver model API =
to locate the video regions, or
> > > > > > > > >> > > > > > > >> > block off the entire framebuffer memory=
, for all devices as a whole.
> > > > > > > > >> > > > > > > >> > Use efi_add_memory_map()
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > 2. Add memory attributes to UCLASS_RAM =
and use them in EFI, mapping to
> > > > > > > > >> > > > > > > >> > the EFI_MEMORY_... attributes in struct=
 efi_mem_desc.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > 3. Add all EFI reservations just before=
 booting the app, as we do with
> > > > > > > > >> > > > > > > >> > devicetree fixup. With this model, mall=
oc() and lmb are used for all
> > > > > > > > >> > > > > > > >> > allocation. Then efi_add_memory_map() i=
s called for each region in
> > > > > > > > >> > > > > > > >> > turn just before booting. Memory attrib=
utes are dealt with above. The
> > > > > > > > >> > > > > > > >> > type (enum efi_memory_type) can be dete=
rmined simply by the data
> > > > > > > > >> > > > > > > >> > structure stored in it, as is done toda=
y. For example, SMBIOS tables
> > > > > > > > >> > > > > > > >> > can use EFI_ACPI_RECLAIM_MEMORY. Very f=
ew types are used and EFI code
> > > > > > > > >> > > > > > > >> > understands the meaning of each.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > 4. Avoid setting up EFI memory at the s=
tart of U-Boot. Do it only when
> > > > > > > > >> > > > > > > >> > booting. This looks to require very lit=
tle effort.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > 5. Avoid calling efi_allocate_pages() a=
nd efi_allocate_pool() outside
> > > > > > > > >> > > > > > > >> > boot-time services. This solves the pro=
blem 6. If memory is needed by
> > > > > > > > >> > > > > > > >> > an app, allocate it with malloc() and s=
ee 3. There are only two
> > > > > > > > >> > > > > > > >> > efi_allocate_pages() (smbios and efi_ru=
ntime). There are more calls of
> > > > > > > > >> > > > > > > >> > efi_allocate_pool(), but most of these =
seem easy to fix up. For
> > > > > > > > >> > > > > > > >> > example, efi_init_event_log() allocates=
 a buffer, but this can be
> > > > > > > > >> > > > > > > >> > allocated in normal malloc() space or i=
n a bloblist.
> > > > > > > > >> > > > > > > >> >
> > > > > > > > >> > > > > > > >> > 6. Don't worry too much about whether E=
FI will be used for booting.
> > > > > > > > >> > > > > > > >> > The cost is likely not that great: use =
bootstage to measure it as is
> > > > > > > > >> > > > > > > >> > done for driver model. Try to minmise t=
he cost of its tables,
> > > > > > > > >> > > > > > > >> > particularly for execution time, but ot=
herwise just rely on the
> > > > > > > > >> > > > > > > >> > ability to disable EFI_LOADER.
> > > > > > > > >> > > > > > > >>
> > > > > > > > >> > > > > > > >> 7. Add a flag to the 'load' command:
> > > > > > > > >> > > > > > > >>
> > > > > > > > >> > > > > > > >> -m <type> - make an lmb allocation for th=
e file
> > > > > > > > >> > > > > > > >>    <type> is the image type to use (kerne=
l, ramdisk, flat_dt)
> > > > > > > > >> > > > > > > >>
> > > > > > > > >> > > > > > > >> any existing allocation for that type wil=
l be automatically freed
> > > > > > > > >> > > > > > > >> first. If <type> is "none" then no freein=
g is possible: any loaded
> > > > > > > > >> > > > > > > >> images just stack up in lmb.
> > > > > > > > >> > > > > > > >>
> > > > > > > > >> > > > > > > >> Add an 'lmb' (or memblock) command to all=
ow listing and clearing allocations.
> > > > > > > > >> > > > > > > >
> > > > > > > > >> > > > > > > >I would really not like to change the user =
interface and instead simply
> > > > > > > > >> > > > > > > >handle this with flags to whatever mark/all=
ocation function is called.
> > > > > > > > >> > > > > > > >You can always overwrite things that are br=
ought in to memory, you
> > > > > > > > >> > > > > > > >cannot overwrite U-Boot or our internals. O=
ptionally noting that some
> > > > > > > > >> > > > > > > >previous load to memory has been at least p=
artially overwritten could be
> > > > > > > > >> > > > > > > >helpful, if it's not too much extra logic.
> > > > > > > > >> > > > > > > >
> > > > > > > > >> > > > > > >
> > > > > > > > >> > > > > > > In most use cases users load exactly one fil=
e at  each address. An
> > > > > > > > >> > > > > > > unload command would be the cleanest way for=
 a user to indicate that
> > > > > > > > >> > > > > > > he wants to reuse the memory.
> > > > > > > > >> > > > > >
> > > > > > > > >> > > > > > I very much do not want to change the API. The=
re's untold numbers of
> > > > > > > > >> > > > > > scripts out there and they should continue to =
work. I mentioned to Ilias
> > > > > > > > >> > > > > > off list just now that I'm not against adding =
a command to add flags to
> > > > > > > > >> > > > > > these areas, but I don't think it's worthwhile=
 to prevent overwrites the
> > > > > > > > >> > > > > > user did early. The biggest long running probl=
em in this space was that
> > > > > > > > >> > > > > > for 32bit ARM we couldn't know where the kerne=
l BSS was going to be and
> > > > > > > > >> > > > > > so would have ramdisk at the wrong spot and ge=
t partially eaten, and
> > > > > > > > >> > > > > > this was hard to figure out. The current examp=
le is "ooops,
> > > > > > > > >> > > > > > decompression buffer for Image.gz/etc is too c=
lose to other things"
> > > > > > > > >> > > > > > which ends up failing nice and loudly, and in =
the future once this
> > > > > > > > >> > > > > > proposal is done we can just dynamically find =
and use a spot, since
> > > > > > > > >> > > > > > we'll have that ability finally.
> > > > > > > > >> > > > >
> > > > > > > > >> > > > > In order to keep the existing interfaces we need=
 lmb to keep track of
> > > > > > > > >> > > > > (at least ) three different states.  I think of =
those as "free",
> > > > > > > > >> > > > > "allocated" and "reserved".  The load command wo=
uld "reserve" memory
> > > > > > > > >> > > > > insteaf "allocate".  And it would pass a flag to=
 lmb when reserving
> > > > > > > > >> > > > > memory to indicate that reserving memory that is=
 already reserved is
> > > > > > > > >> > > > > ok.  Both "reserved" and "allocated" memory shou=
ld show up as not free
> > > > > > > > >> > > > > in the EFI memory map (probably as EfiLoaderData=
).
> > > > > > > > >> > > >
> > > > > > > > >> > > > Yes, something like this is what I was getting at,=
 thanks.
> > > > > > > > >> > >
> > > > > > > > >> > > Yes, that is a good way of putting it. There is defi=
nitely a distinction there.
> > > > > > > > >> > >
> > > > > > > > >> > > If we don't want this flag, we could make U-Boot alw=
ays do a
> > > > > > > > >> > > reservation on load, with a '-f' command to force lo=
ading over an
> > > > > > > > >> > > existing reservation / releasing it first?
> > > > > > > > >> >
> > > > > > > > >> > Again, this is an API change and I don't want to chang=
e the API.
> > > > > > > > >>
> > > > > > > > >> The flag is only needed to drop a reservation, since we =
apparently
> > > > > > > > >> want the 'load' command to create a permanent reservatio=
n. It should
> > > > > > > > >> not affect existing boot scripts since they won't load o=
verlapping
> > > > > > > > >> images.
> > > > > > > > >>
> > > > > > > > >> Anyway, what do you suggest?
> > > > > > > > >
> > > > > > > > >That "load" (and sf read and nand read and tftp and wget a=
nd ...)
> > > > > > > > >"reserve" memory but not "allocate" memory and "reserve" m=
eans something
> > > > > > > > >is there and "allocate" means that it can't be modified ag=
ain. For
> > > > > > > > >example, running U-Boot and our malloc pool are "allocated=
" but just
> > > > > > > > >loading a file to memory is "reserved".  And then yes, I c=
an see use for
> > > > > > > > >the command where some cases might want to "reserve" memor=
y to fiddle
> > > > > > > > >with it and then "allocate" it so something else can't cha=
nge it.
> > > > > > > > >
> > > > > > > > >This is one of those cases where english is terrible to di=
scuss things
> > > > > > > > >in as both reserve and allocate can mean similar things.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I have no clue what the semantics of the mentioned "reserve=
d" state might be. Up to now  memory reservations designated address ranges=
 that U-Boot must not use at all, e.g. the memory used by OpenSBI or TF-A.
> > > > > > > >
> > > > > > > > Who can and who cannot write into "reserved" memory?
> > > > > > > >
> > > > > > > > What is wrong about allocating memory for files to forbid a=
ny other use until you are done with the file and free the memory?
> > > > > > >
> > > > > > > So, historically (lets say mid 2010s), you could use "load" t=
o bring a
> > > > > > > file in to memory, anywhere, and it could even overwrite part=
 of U-Boot
> > > > > > > (running, or malloc pool or whatever). You could also use "lo=
ad" to
> > > > > > > bring a file in to memory and then bring another file in to t=
hat same
> > > > > > > location in memory for whatever reason (assorted development =
cases).
> > > > > > >
> > > > > > > Then later someone noted that using "load" to overwrite U-Boo=
t should
> > > > > > > get a CVE and instead of ignoring it we decided to use "lmb" =
to try and
> > > > > > > make sure that we couldn't use "load" to overwrite U-Boot its=
elf, and
> > > > > > > that that's a pre-check. This still allows overwriting a prev=
iously
> > > > > > > loaded file in memory.
> > > > > > >
> > > > > > > Overwriting something the user put in memory is part of the A=
BI and has
> > > > > > > some use cases.
> > > > > > >
> > > > > > > So for whatever future system we setup, a memory location can=
 be:
> > > > > > > - Free.
> > > > > > > - Readable but not Writable.
> > > > > > > - Readable and Writable.
> > > > > > >
> > > > > > > Something like $loadaddr starts as Free. If someone then uses=
 "load" to
> > > > > > > bring in an OS image, it's now "Readable and Writable". But i=
f someone
> > > > > > > does an API call to ask for a new region memory, it wouldn't =
return
> > > > > > > $loadaddr because it's not Free. On the other hand, $relocadd=
r where
> > > > > > > U-Boot is, at least in terms of the API is that it's "Readabl=
e but not
> > > > > > > Writable".
> > > > > > >
> > > > > > > Does that help?
> > > > >
> > > > > Thanks for sharing this with me. I have been working on a solutio=
n for
> > > > > this issue [1], and plan to send a rfc series by the end of this =
week.
> > > > > My primary motivation behind this work is to have some kind of
> > > > > synchronisation between the allocations done by the LMB module an=
d the
> > > > > EFI subsystem. As you are aware, the way things stand today, eith=
er of
> > > > > the two can make memory allocations overwriting any earlier alloc=
ated
> > > > > memory. The primary reasons behind this is 1) the LMB allocations=
 are
> > > > > private to their respective callers, so the LMB memory map is not
> > > > > global and persistent, and 2) the EFI allocation routines do not =
have
> > > > > any view of the allocations that would have been made by the LMB
> > > > > module.
> > > > >
> > > > > To fix these issues, I am working on a solution which 1) makes LM=
B
> > > > > memory map persistent and global, and 2) have notifications betwe=
en
> > > > > the two modules when either of the two has made any changes to it=
's
> > > > > memory map. This way, it would be possible to prohibit one module=
 from
> > > > > allocating memory which is in use.
> > > > >
> > > > > I am aware that we have a whole bunch of tests and user scripts w=
hich
> > > > > work with an assumption that the memory can be re-used. The solut=
ion
> > > > > that I would be proposing takes care of this assumption. Hopefull=
y I
> > > > > should be in a position to send a rfc series this week. We can di=
scuss
> > > > > on the patches. Thanks.
> > > >
> > > > I actually am not sure what we are on the same page here. I describ=
ed
> > > > the problems in my original email but your series seems to solve
> > > > somewhat different problems, while IMO introducing a whole new clas=
s
> > > > of problems.
> > >
> > > Can you please describe in a little more detail what "whole new class
> > > of problems" are being introduced here. If there are problems being
> > > introduced, it is better if they are enumerated, so that I can try to
> > > fix them.
> >
> > Please see my point immediately below:
> >
> > >
> > > >
> > > > Making LMB persistent and global is a solution looking for a proble=
m,
> > > > IMO. Can we go up a level and figure out exactly what is broken her=
e?
> > > > That is what I attempted to do in my original email. Perhaps you co=
uld
> > > > reply to that and suggest where you agree / disagree?
> > >
> > > I have gone through this thread multiple times, and my understanding
> > > was that there was no conclusive agreement that was arrived at. I saw
> > > a reply from Tom where he broadly mentioned what kind of a solution h=
e
> > > is looking for. I am not sure if you have gone through the
> > > cover-letter of my RFC series [1], which clearly states the problem m=
y
> > > patch series is trying to fix. Like I said above, it would help if yo=
u
> > > can describe in a little more detail the kind of issues you see with
> > > the RFC series. Thanks.
> >
> > My request was for you to reply to the thread with any thoughts so we
> > can agree what to do about it. I believe my original email mostly
> > stands as a summary of where things are and what the problems are. If
> > it helps, I can update it based on the discussion above. It is
> > important to avoid over-complicating U-Boot.
> >
> > My fundamental expectation is that LMB reservations only apply for a
> > particular boot. They should not be global, nor need freeing, nor
> > should they be similar to memory allocations. We discussed it in this
> > thread.
>
> Please note that I have run the patches through CI, and they pass the
> CI run. There are numerous examples in the CI test scripts where the
> LMB memory is re-used, and these patches are not changing that
> behaviour in any which way. The only reason why the LMB memory needs
> to be persistent and global is because it needs to work cohesively
> with the EFI memory allocator.

I believe that is the central misunderstanding here. The EFI memory
allocator was written as if it has access to all the memory in U-Boot.
It is sort-of an allocator and sort-of a classifier, for memory. We
need to be very careful to avoid conflating those two things.

Here I am repeating myself, but let me try.

Within U-Boot, there is a malloc() pool and that should be used for
all allocations, including those which purport to be EFI allocations
while U-Boot itself is running (and has not booted into an EFI app). I
believe this is the case today, but we don't have a test for it, and
the early init of EFI memory could be causing issues / confusion.

The EFI 'allocator' should be set up just before booting an EFI
application, and only be used after boot, to handle requests from EFI
applications.

LMB should also be set up on a per-boot basis. It is just there to
avoid conflicts.

>
> At this point, I guess the EFI maintainers and Tom have to provide
> their input on how we go about this. But if we have to have EFI
> allocations live alongside LMB, the *only* other solution that I see
> is to then break up the memory into two sections, one for LMB and one
> for EFI. But then again, that introduces it's own set of issues, for
> e.g. a platform might not be able to use some memory region simply
> because it is allocated to the other subsystem. But I would let the
> maintainers chime in at this point. Thanks.

As in the other thread, LMB is not an allocator, really. We should
perhaps rename the functions to avoid any confusion.

I'd like to come back to the problems we are trying to solve. I listed
6...just to repeat:

> There are no urgent problems, but here are some things that could be impr=
oved:
>
> 1. EFI should attach most of its data structures to driver model. This
> work has started, with the partition support, but more effort would
> help. This would make it easier to see which memory is related to
> devices and which is separate.
>
> 2. Some drivers do EFI reservations today, whether EFI is used for
> booting or not (e.g. rockchip video rk_vop_probe()).
>
> 3. U-Boot doesn't really map arch-specific memory attributes (e.g.
> armv8's struct mm_region) to EFI ones.
>
> 4. EFI duplicates some code from bootm, some of which relates to
> memory allocation (e.g. FDT fixup).
>
> 5. EFI code is used even if EFI is never used to boot
>
> 6. EFI allocations can result in the same memory being used as has
> already been allocated by lmb. Users may load files which overwrite
> memory allocated by EFI.
>

Do you agree with those? Would you add others? It is this discussion
which I believe is very important, before we end up re-inventing
Tianocore :-)

Regards,
SImon
