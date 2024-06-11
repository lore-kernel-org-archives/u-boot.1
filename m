Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA346C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 251448875C;
	Tue, 11 Jun 2024 20:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ar158o5j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B12738877B; Tue, 11 Jun 2024 20:52:30 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C908F88755
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b065d12dc6so7446346d6.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131946; x=1718736746; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5BjsaTnTovlbkpNonOVVFykeA/drKPgm5J4jsIZJHlc=;
 b=ar158o5j1/UrXuNGBA8QCWz2QpWji/qjkdRp6nobYJSHg6NKZjotqSESg6IZ2TBx6z
 iwC7XigAwPQPcv+47Gf1SaOkNdSxT/V6U/KH1xPnCDm7MNdaZLaWARa0ASNgBKwb0Ur1
 2TrEKprcK8o7+jHO+eKUBEq41B7rNMzlhzKkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131946; x=1718736746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5BjsaTnTovlbkpNonOVVFykeA/drKPgm5J4jsIZJHlc=;
 b=h0gOKVRpgiDC4zl5CPsajRnVSjZsQVDtHBn4WLOwKwbrhjRBm2cm534eLO3JOijvAm
 uKnvuiAQIdjFZXyHyHND1EqtQMHlB39WnbqOzxjmmcbv+FY2n5/i2s+YsBuurxKRMPoD
 kkTgd0DGDVpR0upby5GBQAfZkmRutiRjPlCE5Nb5535lnBOkU+LWsL7mA7oLsU378JqY
 TRFRpq3BMuUfBawEEjtORTL2UWXRlm9OPvX/ZN7VX1qSEJ8lie2iQLzq3I5d2VJ1U4Yc
 g/QBeEUPKayiXhpxAZ4H3CfUIRnJQAj5j1/WC9xGYfTaO2nWmQvU9DPhfvjXwGBQX7FB
 FfXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOTRZSJoKrxD9bV3Dy88p6hALnhx8u4LVDX7yIVtl3xOQ0ZG6p7G13IdoPe5JtsMvcd04Z72xCOG758smSiv2pl3e4kw==
X-Gm-Message-State: AOJu0YyaPJko7A9fmPF6op9uX52/svh1NkbZBG6KjjrYHn4A1qZ1Lnn/
 kY7UqnhTqqGfrKWKmArTFP3pKjK+87CPG1WyhUiet2HMuA2n82MdA01LIGz5vfOjiYGFJzD6VBg
 vwgwK1wmMR60adI5AA/L3cgoenvmSwH4DnM8w
X-Google-Smtp-Source: AGHT+IEV6MnP8Buo9lOxTCAGRrro9/UTqBGm56tGFCpL5YqqIFeOZVzsoeDClSYc0EDShyCN7Z6prcPTO9pdG0poB0Q=
X-Received: by 2002:a05:6214:3f93:b0:6b0:76b5:d750 with SMTP id
 6a1803df08f44-6b076b5d9abmr107645456d6.3.1718131945175; Tue, 11 Jun 2024
 11:52:25 -0700 (PDT)
MIME-Version: 1.0
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
 <20240610162927.GO68077@bill-the-cat>
In-Reply-To: <20240610162927.GO68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 12:52:14 -0600
Message-ID: <CAFLszTiAOsVs-Oi8HpDoGcefBbLWo=Df_V5kQodHyaLqvTB+mQ@mail.gmail.com>
Subject: Re: Proposal: U-Boot memory management
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
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

Hi Tom,

On Mon, 10 Jun 2024 at 10:29, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jun 10, 2024 at 07:55:44AM -0600, Simon Glass wrote:
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
> >
> > Making LMB persistent and global is a solution looking for a problem,
> > IMO. Can we go up a level and figure out exactly what is broken here?
> > That is what I attempted to do in my original email. Perhaps you could
> > reply to that and suggest where you agree / disagree?
>
> Again, the fundamental problem is that LMB as originally introduced was
> fine enough for the time it was introduced and the limited sets of
> problems we were caring about, which was essentially ONLY "put a few
> objects in non-conflicting areas for the OS". That's no longer the case,
> so we need something different that IS persistent from caller to caller.
> I do need to read Sughosh's series, but it is the starting point for
> discussion of an implementation for modern systems and problems, not a
> call to go back to the drawing board.

OK I will make a few comments there.

Regards,
Simon
