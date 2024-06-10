Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12832C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87237885BF;
	Mon, 10 Jun 2024 17:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jLFGQvCV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79919885C9; Mon, 10 Jun 2024 17:03:20 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60A02866F6
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 17:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2c2dee9d9a1so1390212a91.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 08:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718031796; x=1718636596; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fJVRJXlgiK2MHvbWA8VqfjO359NJ88q0ckFG4y5x19M=;
 b=jLFGQvCVo/62Drb2ujJdEwOqVM6l9HeAxjex9ngUHnieRoJYgSD0rG3Jkt4cy+cTp4
 p1NSqMg2h9/iPMixLFalx/BL1Ivq2FMoDFLyGNburoNT4yhnO8MpcJLp4Ybg/QeFz1vZ
 bPIgEHNXUemXStE9+ES4jiPazvq5sPlZxm3Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031796; x=1718636596;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fJVRJXlgiK2MHvbWA8VqfjO359NJ88q0ckFG4y5x19M=;
 b=qbGqwU6TIa5pgQVVdl/LfadESCQAXVhRE0TDDkDW0mYtaDaqRj0LK6XVM3USKxkJpt
 jNtMi0hgZezXTd7cenCm4TSx1sGGA36l2Qa3o7HVvrqo1AICogPJla18RTBsANH7Hely
 WNtuHh/TbiHlnnDbsfNWcMfpsgFCgwTrJzSuRzb+2PKJ/wQjz6FJ64gVtYkCnNZ0x5tn
 AjdOzftJ+pElvYLUwrv1dNMSOX7xIG0Q7gJLj1GMG3q3DCBwfsNUZOLn3RPvwMDSTgOP
 b+PWv+skSNZlnJCPIh5KMkU9tzZOCHUGxu9gRzyWZ95B6kmubg+NwvJQJs+zdZpinTJT
 NYdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAdM+VTOvxbE0lGXV1oWXu5o+EGlxjZZmk78NbO+ln/B9XbhzRyTCW4RkknzB4qJq31TuEH+s69zLr9VSpqfs4az4MpQ==
X-Gm-Message-State: AOJu0YxtssU0DhSMYg0vXDvjFt6IisKRZPwSdfpiqGCmvt52L1bhLqJx
 rA8L+YA9yHOduCBkFh9KtbAD/MWZOkoHcCL0p35wwDL5Ao2N2odtzHX8Ee91kQJs17KSk3W1rpr
 ycQc1s7scsyy5ahC80+HLX4sGY05kLLmyvOLK
X-Google-Smtp-Source: AGHT+IHUltfUxPBpmx4GNRKO1llYC1b9R5LV9gY39lnjUMNwrvk5YVJ3CdQlHWw9l40adfHd8WLw1noS2oyZZJLl6Us=
X-Received: by 2002:a17:90a:de92:b0:2c2:f07e:48ca with SMTP id
 98e67ed59e1d1-2c2f07e4addmr3632464a91.33.1718031795528; Mon, 10 Jun 2024
 08:03:15 -0700 (PDT)
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
In-Reply-To: <CADg8p95eRCduZ-HKDsFO-rRpdV3q033nespjCAfAd1oE64iRtw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Jun 2024 09:02:59 -0600
Message-ID: <CAFLszTihZjxsLhROmr=KKqPfqAxsBZs0RzmnKpsgtfmtg8cZog@mail.gmail.com>
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

On Mon, 10 Jun 2024 at 08:40, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Mon, 10 Jun 2024 at 19:25, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Thu, 6 Jun 2024 at 13:18, Sughosh Ganu <sughosh.ganu@linaro.org> wro=
te:
> > >
> > > hi Simon,
> > >
> > > On Wed, 29 May 2024 at 22:00, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > +Sughosh Ganu for reference
> > > >
> > > >
> > > > On Sun, 31 Dec 2023 at 09:16, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Dec 31, 2023 at 04:40:06PM +0100, Heinrich Schuchardt wro=
te:
> > > > > >
> > > > > >
> > > > > > Am 31. Dezember 2023 16:11:44 MEZ schrieb Tom Rini <trini@konsu=
lko.com>:
> > > > > > >On Sun, Dec 31, 2023 at 07:22:10AM -0700, Simon Glass wrote:
> > > > > > >> Hi Tom,
> > > > > > >>
> > > > > > >> On Sun, Dec 31, 2023 at 6:54=E2=80=AFAM Tom Rini <trini@kons=
ulko.com> wrote:
> > > > > > >> >
> > > > > > >> > On Sun, Dec 31, 2023 at 05:48:23AM -0700, Simon Glass wrot=
e:
> > > > > > >> > > Hi,
> > > > > > >> > >
> > > > > > >> > > On Fri, Dec 29, 2023 at 10:52=E2=80=AFAM Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > >> > > >
> > > > > > >> > > > On Fri, Dec 29, 2023 at 06:44:15PM +0100, Mark Ketteni=
s wrote:
> > > > > > >> > > > > > Date: Fri, 29 Dec 2023 11:17:44 -0500
> > > > > > >> > > > > > From: Tom Rini <trini@konsulko.com>
> > > > > > >> > > > > >
> > > > > > >> > > > > > On Fri, Dec 29, 2023 at 05:05:17PM +0100, Heinrich=
 Schuchardt wrote:
> > > > > > >> > > > > > >
> > > > > > >> > > > > > >
> > > > > > >> > > > > > > Am 29. Dezember 2023 16:43:07 MEZ schrieb Tom Ri=
ni <trini@konsulko.com>:
> > > > > > >> > > > > > > >On Fri, Dec 29, 2023 at 05:36:09AM +0000, Simon=
 Glass wrote:
> > > > > > >> > > > > > > >> Hi,
> > > > > > >> > > > > > > >>
> > > > > > >> > > > > > > >> On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM Simon=
 Glass <sjg@chromium.org> wrote:
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > Hi,
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > This records my thoughts after a discussion=
 with Ilias & Heinrich re
> > > > > > >> > > > > > > >> > memory allocation in U-Boot.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > 1. malloc()
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > malloc() is used for programmatic memory al=
location. It allows memory
> > > > > > >> > > > > > > >> > to be freed. It is not designed for very la=
rge allocations (e.g. a
> > > > > > >> > > > > > > >> > 10MB kernel or 100MB ramdisk).
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > 2. lmb
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > lmb is used for large blocks of memory, suc=
h as those needed for a
> > > > > > >> > > > > > > >> > kernel or ramdisk. Allocation is only trans=
itory, for the purposes of
> > > > > > >> > > > > > > >> > loading some images and booting. If the boo=
t fails, then all lmb
> > > > > > >> > > > > > > >> > allocations go away.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > lmb is set up by getting all available memo=
ry and then removing what
> > > > > > >> > > > > > > >> > is used by U-Boot (code, data, malloc() spa=
ce, etc.)
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > lmb reservations have a few flags so that a=
reas of memory can be
> > > > > > >> > > > > > > >> > provided with attributes
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > There are some corner cases...e.g. loading =
a file does an lmb
> > > > > > >> > > > > > > >> > allocation but only for the purpose of avoi=
ding a file being loaded
> > > > > > >> > > > > > > >> > over U-Boot code/data. The allocation is dr=
opped immediately after the
> > > > > > >> > > > > > > >> > file is loaded. Within the bootm command, o=
r when using standard boot,
> > > > > > >> > > > > > > >> > this would be fairly easy to solve.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > Linux has renamed lmb to memblock. We shoul=
d consider doing the same.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > 3. EFI
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > EFI has its own memory-allocation tables.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > Like lmb, EFI is able to deal with large al=
locations. But via a 'pool'
> > > > > > >> > > > > > > >> > function it can also do smaller allocations=
 similar to malloc(),
> > > > > > >> > > > > > > >> > although each one uses at least 4KB at pres=
ent.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > EFI allocations do not go away when a boot =
fails.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > With EFI it is possible to add allocations =
post facto, in which case
> > > > > > >> > > > > > > >> > they are added to the allocation table just=
 as if the memory was
> > > > > > >> > > > > > > >> > allocated with EFI to begin with.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > The EFI allocations and the lmb allocations=
 use the same memory, so in
> > > > > > >> > > > > > > >> > principle could conflict.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > EFI allocations are sometimes used to alloc=
ate internal U-Boot data as
> > > > > > >> > > > > > > >> > well, if needed by the EFI app. For example=
, while efi_image_parse()
> > > > > > >> > > > > > > >> > uses malloc(), efi_var_mem.c uses EFI alloc=
ations since the code runs
> > > > > > >> > > > > > > >> > in the app context and may need to access t=
he memory after U-Boot has
> > > > > > >> > > > > > > >> > exited. Also efi_smbios.c uses allocate_pag=
es() and then adds a new
> > > > > > >> > > > > > > >> > mapping as well.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > EFI memory has attributes, including what t=
he memory is used for (to
> > > > > > >> > > > > > > >> > some degree of granularity). See enum efi_m=
emory_type and struct
> > > > > > >> > > > > > > >> > efi_mem_desc. In the latter there are also =
attribute flags - whether
> > > > > > >> > > > > > > >> > memory is cacheable, etc.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > EFI also has the x86 idea of 'conventional'=
 memory, meaning (I
> > > > > > >> > > > > > > >> > believe) that below 4GB that isn't reserved=
 for the hardware/system.
> > > > > > >> > > > > > > >> > This is meaningless, or at least confusing,=
 on ARM systems.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > 4. reservations
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > It is perhaps worth mentioning a fourth met=
hod of memory management,
> > > > > > >> > > > > > > >> > where U-Boot reserves chunks of memory befo=
re relocation (in
> > > > > > >> > > > > > > >> > board_init_f.c), e.g. for the framebuffer, =
U-Boot code, the malloc()
> > > > > > >> > > > > > > >> > region, etc.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > Problems
> > > > > > >> > > > > > > >> > =E2=80=94-------
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > There are no urgent problems, but here are =
some things that could be improved:
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > 1. EFI should attach most of its data struc=
tures to driver model. This
> > > > > > >> > > > > > > >> > work has started, with the partition suppor=
t, but more effort would
> > > > > > >> > > > > > > >> > help. This would make it easier to see whic=
h memory is related to
> > > > > > >> > > > > > > >> > devices and which is separate.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > 2. Some drivers do EFI reservations today, =
whether EFI is used for
> > > > > > >> > > > > > > >> > booting or not (e.g. rockchip video rk_vop_=
probe()).
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > 3. U-Boot doesn't really map arch-specific =
memory attributes (e.g.
> > > > > > >> > > > > > > >> > armv8's struct mm_region) to EFI ones.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > 4. EFI duplicates some code from bootm, som=
e of which relates to
> > > > > > >> > > > > > > >> > memory allocation (e.g. FDT fixup).
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > 5. EFI code is used even if EFI is never us=
ed to boot
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > 6. EFI allocations can result in the same m=
emory being used as has
> > > > > > >> > > > > > > >> > already been allocated by lmb. Users may lo=
ad files which overwrite
> > > > > > >> > > > > > > >> > memory allocated by EFI.
> > > > > > >> > > > > > > >>
> > > > > > >> > > > > > > >> 7. We need to support doing an allocation whe=
n a file is loaded (to
> > > > > > >> > > > > > > >> ensure files do not overlap), without making =
it too difficult to load
> > > > > > >> > > > > > > >> multiple files to the same place, if desired.
> > > > > > >> > > > > > > >>
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > Lifetime
> > > > > > >> > > > > > > >> > --------
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > We have three different memory allocators w=
ith different purposes. Can
> > > > > > >> > > > > > > >> > we unify them a little?
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > Within U-Boot:
> > > > > > >> > > > > > > >> > - malloc() space lives forever
> > > > > > >> > > > > > > >> > - lmb lives while setting out images for bo=
oting
> > > > > > >> > > > > > > >> > - EFI (mostly) lives while booting an EFI a=
pp
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > In practice, EFI is set up early in U-Boot.=
 Some of this is necessary,
> > > > > > >> > > > > > > >> > some not. EFI allocations stay around forev=
er. This works OK since
> > > > > > >> > > > > > > >> > large allocations are normally not done in =
EFI, so memory isn't really
> > > > > > >> > > > > > > >> > consumed to any great degree by the boot pr=
ocess.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > What happens to EFI allocations if the app =
returns? They are still
> > > > > > >> > > > > > > >> > present, in case another app is run. This s=
eems fine.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > API
> > > > > > >> > > > > > > >> > =E2=80=93--
> > > > > > >> > > > > > > >> > Can we unify some APIs?
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > It should be possible to use lmb for large =
EFI memory allocations, so
> > > > > > >> > > > > > > >> > long as they are only needed for booting. W=
e effectively do this
> > > > > > >> > > > > > > >> > today, since EFI does not manage the arrang=
ement of loaded images in
> > > > > > >> > > > > > > >> > memory. for the most part.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > It would not make sense to use EFI allocati=
on to replace lmb and
> > > > > > >> > > > > > > >> > malloc(), of course.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > Could we use a common (lower-level) API for=
 allocation, used by both
> > > > > > >> > > > > > > >> > lmb and EFI? They do have some similarities=
. However they have
> > > > > > >> > > > > > > >> > different lifetime constraints (EFI allocat=
ions are never dropped,
> > > > > > >> > > > > > > >> > unlikely lmb).
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > ** Overall, it seems that the existence of =
memory allocation in
> > > > > > >> > > > > > > >> > boot-time services has created confusion. M=
emory allocation is
> > > > > > >> > > > > > > >> > muddled, with both U-Boot code and boot-tim=
e services calling the same
> > > > > > >> > > > > > > >> > memory allocator. This just has not been cl=
early thought out.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > Proposal
> > > > > > >> > > > > > > >> > =E2=80=94-------
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > Here are some ideas:
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > 1. For video, use the driver model API to l=
ocate the video regions, or
> > > > > > >> > > > > > > >> > block off the entire framebuffer memory, fo=
r all devices as a whole.
> > > > > > >> > > > > > > >> > Use efi_add_memory_map()
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > 2. Add memory attributes to UCLASS_RAM and =
use them in EFI, mapping to
> > > > > > >> > > > > > > >> > the EFI_MEMORY_... attributes in struct efi=
_mem_desc.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > 3. Add all EFI reservations just before boo=
ting the app, as we do with
> > > > > > >> > > > > > > >> > devicetree fixup. With this model, malloc()=
 and lmb are used for all
> > > > > > >> > > > > > > >> > allocation. Then efi_add_memory_map() is ca=
lled for each region in
> > > > > > >> > > > > > > >> > turn just before booting. Memory attributes=
 are dealt with above. The
> > > > > > >> > > > > > > >> > type (enum efi_memory_type) can be determin=
ed simply by the data
> > > > > > >> > > > > > > >> > structure stored in it, as is done today. F=
or example, SMBIOS tables
> > > > > > >> > > > > > > >> > can use EFI_ACPI_RECLAIM_MEMORY. Very few t=
ypes are used and EFI code
> > > > > > >> > > > > > > >> > understands the meaning of each.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > 4. Avoid setting up EFI memory at the start=
 of U-Boot. Do it only when
> > > > > > >> > > > > > > >> > booting. This looks to require very little =
effort.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > 5. Avoid calling efi_allocate_pages() and e=
fi_allocate_pool() outside
> > > > > > >> > > > > > > >> > boot-time services. This solves the problem=
 6. If memory is needed by
> > > > > > >> > > > > > > >> > an app, allocate it with malloc() and see 3=
. There are only two
> > > > > > >> > > > > > > >> > efi_allocate_pages() (smbios and efi_runtim=
e). There are more calls of
> > > > > > >> > > > > > > >> > efi_allocate_pool(), but most of these seem=
 easy to fix up. For
> > > > > > >> > > > > > > >> > example, efi_init_event_log() allocates a b=
uffer, but this can be
> > > > > > >> > > > > > > >> > allocated in normal malloc() space or in a =
bloblist.
> > > > > > >> > > > > > > >> >
> > > > > > >> > > > > > > >> > 6. Don't worry too much about whether EFI w=
ill be used for booting.
> > > > > > >> > > > > > > >> > The cost is likely not that great: use boot=
stage to measure it as is
> > > > > > >> > > > > > > >> > done for driver model. Try to minmise the c=
ost of its tables,
> > > > > > >> > > > > > > >> > particularly for execution time, but otherw=
ise just rely on the
> > > > > > >> > > > > > > >> > ability to disable EFI_LOADER.
> > > > > > >> > > > > > > >>
> > > > > > >> > > > > > > >> 7. Add a flag to the 'load' command:
> > > > > > >> > > > > > > >>
> > > > > > >> > > > > > > >> -m <type> - make an lmb allocation for the fi=
le
> > > > > > >> > > > > > > >>    <type> is the image type to use (kernel, r=
amdisk, flat_dt)
> > > > > > >> > > > > > > >>
> > > > > > >> > > > > > > >> any existing allocation for that type will be=
 automatically freed
> > > > > > >> > > > > > > >> first. If <type> is "none" then no freeing is=
 possible: any loaded
> > > > > > >> > > > > > > >> images just stack up in lmb.
> > > > > > >> > > > > > > >>
> > > > > > >> > > > > > > >> Add an 'lmb' (or memblock) command to allow l=
isting and clearing allocations.
> > > > > > >> > > > > > > >
> > > > > > >> > > > > > > >I would really not like to change the user inte=
rface and instead simply
> > > > > > >> > > > > > > >handle this with flags to whatever mark/allocat=
ion function is called.
> > > > > > >> > > > > > > >You can always overwrite things that are brough=
t in to memory, you
> > > > > > >> > > > > > > >cannot overwrite U-Boot or our internals. Optio=
nally noting that some
> > > > > > >> > > > > > > >previous load to memory has been at least parti=
ally overwritten could be
> > > > > > >> > > > > > > >helpful, if it's not too much extra logic.
> > > > > > >> > > > > > > >
> > > > > > >> > > > > > >
> > > > > > >> > > > > > > In most use cases users load exactly one file at=
  each address. An
> > > > > > >> > > > > > > unload command would be the cleanest way for a u=
ser to indicate that
> > > > > > >> > > > > > > he wants to reuse the memory.
> > > > > > >> > > > > >
> > > > > > >> > > > > > I very much do not want to change the API. There's=
 untold numbers of
> > > > > > >> > > > > > scripts out there and they should continue to work=
. I mentioned to Ilias
> > > > > > >> > > > > > off list just now that I'm not against adding a co=
mmand to add flags to
> > > > > > >> > > > > > these areas, but I don't think it's worthwhile to =
prevent overwrites the
> > > > > > >> > > > > > user did early. The biggest long running problem i=
n this space was that
> > > > > > >> > > > > > for 32bit ARM we couldn't know where the kernel BS=
S was going to be and
> > > > > > >> > > > > > so would have ramdisk at the wrong spot and get pa=
rtially eaten, and
> > > > > > >> > > > > > this was hard to figure out. The current example i=
s "ooops,
> > > > > > >> > > > > > decompression buffer for Image.gz/etc is too close=
 to other things"
> > > > > > >> > > > > > which ends up failing nice and loudly, and in the =
future once this
> > > > > > >> > > > > > proposal is done we can just dynamically find and =
use a spot, since
> > > > > > >> > > > > > we'll have that ability finally.
> > > > > > >> > > > >
> > > > > > >> > > > > In order to keep the existing interfaces we need lmb=
 to keep track of
> > > > > > >> > > > > (at least ) three different states.  I think of thos=
e as "free",
> > > > > > >> > > > > "allocated" and "reserved".  The load command would =
"reserve" memory
> > > > > > >> > > > > insteaf "allocate".  And it would pass a flag to lmb=
 when reserving
> > > > > > >> > > > > memory to indicate that reserving memory that is alr=
eady reserved is
> > > > > > >> > > > > ok.  Both "reserved" and "allocated" memory should s=
how up as not free
> > > > > > >> > > > > in the EFI memory map (probably as EfiLoaderData).
> > > > > > >> > > >
> > > > > > >> > > > Yes, something like this is what I was getting at, tha=
nks.
> > > > > > >> > >
> > > > > > >> > > Yes, that is a good way of putting it. There is definite=
ly a distinction there.
> > > > > > >> > >
> > > > > > >> > > If we don't want this flag, we could make U-Boot always =
do a
> > > > > > >> > > reservation on load, with a '-f' command to force loadin=
g over an
> > > > > > >> > > existing reservation / releasing it first?
> > > > > > >> >
> > > > > > >> > Again, this is an API change and I don't want to change th=
e API.
> > > > > > >>
> > > > > > >> The flag is only needed to drop a reservation, since we appa=
rently
> > > > > > >> want the 'load' command to create a permanent reservation. I=
t should
> > > > > > >> not affect existing boot scripts since they won't load overl=
apping
> > > > > > >> images.
> > > > > > >>
> > > > > > >> Anyway, what do you suggest?
> > > > > > >
> > > > > > >That "load" (and sf read and nand read and tftp and wget and .=
..)
> > > > > > >"reserve" memory but not "allocate" memory and "reserve" means=
 something
> > > > > > >is there and "allocate" means that it can't be modified again.=
 For
> > > > > > >example, running U-Boot and our malloc pool are "allocated" bu=
t just
> > > > > > >loading a file to memory is "reserved".  And then yes, I can s=
ee use for
> > > > > > >the command where some cases might want to "reserve" memory to=
 fiddle
> > > > > > >with it and then "allocate" it so something else can't change =
it.
> > > > > > >
> > > > > > >This is one of those cases where english is terrible to discus=
s things
> > > > > > >in as both reserve and allocate can mean similar things.
> > > > > > >
> > > > > >
> > > > > > I have no clue what the semantics of the mentioned "reserved" s=
tate might be. Up to now  memory reservations designated address ranges tha=
t U-Boot must not use at all, e.g. the memory used by OpenSBI or TF-A.
> > > > > >
> > > > > > Who can and who cannot write into "reserved" memory?
> > > > > >
> > > > > > What is wrong about allocating memory for files to forbid any o=
ther use until you are done with the file and free the memory?
> > > > >
> > > > > So, historically (lets say mid 2010s), you could use "load" to br=
ing a
> > > > > file in to memory, anywhere, and it could even overwrite part of =
U-Boot
> > > > > (running, or malloc pool or whatever). You could also use "load" =
to
> > > > > bring a file in to memory and then bring another file in to that =
same
> > > > > location in memory for whatever reason (assorted development case=
s).
> > > > >
> > > > > Then later someone noted that using "load" to overwrite U-Boot sh=
ould
> > > > > get a CVE and instead of ignoring it we decided to use "lmb" to t=
ry and
> > > > > make sure that we couldn't use "load" to overwrite U-Boot itself,=
 and
> > > > > that that's a pre-check. This still allows overwriting a previous=
ly
> > > > > loaded file in memory.
> > > > >
> > > > > Overwriting something the user put in memory is part of the ABI a=
nd has
> > > > > some use cases.
> > > > >
> > > > > So for whatever future system we setup, a memory location can be:
> > > > > - Free.
> > > > > - Readable but not Writable.
> > > > > - Readable and Writable.
> > > > >
> > > > > Something like $loadaddr starts as Free. If someone then uses "lo=
ad" to
> > > > > bring in an OS image, it's now "Readable and Writable". But if so=
meone
> > > > > does an API call to ask for a new region memory, it wouldn't retu=
rn
> > > > > $loadaddr because it's not Free. On the other hand, $relocaddr wh=
ere
> > > > > U-Boot is, at least in terms of the API is that it's "Readable bu=
t not
> > > > > Writable".
> > > > >
> > > > > Does that help?
> > >
> > > Thanks for sharing this with me. I have been working on a solution fo=
r
> > > this issue [1], and plan to send a rfc series by the end of this week=
.
> > > My primary motivation behind this work is to have some kind of
> > > synchronisation between the allocations done by the LMB module and th=
e
> > > EFI subsystem. As you are aware, the way things stand today, either o=
f
> > > the two can make memory allocations overwriting any earlier allocated
> > > memory. The primary reasons behind this is 1) the LMB allocations are
> > > private to their respective callers, so the LMB memory map is not
> > > global and persistent, and 2) the EFI allocation routines do not have
> > > any view of the allocations that would have been made by the LMB
> > > module.
> > >
> > > To fix these issues, I am working on a solution which 1) makes LMB
> > > memory map persistent and global, and 2) have notifications between
> > > the two modules when either of the two has made any changes to it's
> > > memory map. This way, it would be possible to prohibit one module fro=
m
> > > allocating memory which is in use.
> > >
> > > I am aware that we have a whole bunch of tests and user scripts which
> > > work with an assumption that the memory can be re-used. The solution
> > > that I would be proposing takes care of this assumption. Hopefully I
> > > should be in a position to send a rfc series this week. We can discus=
s
> > > on the patches. Thanks.
> >
> > I actually am not sure what we are on the same page here. I described
> > the problems in my original email but your series seems to solve
> > somewhat different problems, while IMO introducing a whole new class
> > of problems.
>
> Can you please describe in a little more detail what "whole new class
> of problems" are being introduced here. If there are problems being
> introduced, it is better if they are enumerated, so that I can try to
> fix them.

Please see my point immediately below:

>
> >
> > Making LMB persistent and global is a solution looking for a problem,
> > IMO. Can we go up a level and figure out exactly what is broken here?
> > That is what I attempted to do in my original email. Perhaps you could
> > reply to that and suggest where you agree / disagree?
>
> I have gone through this thread multiple times, and my understanding
> was that there was no conclusive agreement that was arrived at. I saw
> a reply from Tom where he broadly mentioned what kind of a solution he
> is looking for. I am not sure if you have gone through the
> cover-letter of my RFC series [1], which clearly states the problem my
> patch series is trying to fix. Like I said above, it would help if you
> can describe in a little more detail the kind of issues you see with
> the RFC series. Thanks.

My request was for you to reply to the thread with any thoughts so we
can agree what to do about it. I believe my original email mostly
stands as a summary of where things are and what the problems are. If
it helps, I can update it based on the discussion above. It is
important to avoid over-complicating U-Boot.

My fundamental expectation is that LMB reservations only apply for a
particular boot. They should not be global, nor need freeing, nor
should they be similar to memory allocations. We discussed it in this
thread.

Regards,
Simon
