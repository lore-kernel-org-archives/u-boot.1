Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF44C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 15:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05F6987120;
	Sun, 31 Dec 2023 16:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jMf0xfH7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FE5D87561; Sun, 31 Dec 2023 16:11:52 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 615FD86F42
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:11:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-67fe0210665so38985236d6.1
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 07:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704035508; x=1704640308; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2kcm+hmnxnhMGwalE3cgGiOro6iqP/vlGsuNe1r42UU=;
 b=jMf0xfH7MpwZkaaCHLsrNPE2FEtxGw98oYHO5WbLBMsJ/gx915EAdDhww6QJR0frc4
 2K1J+gfZbJzhjlpgFmto7G7KXF+SDmsiGit7Vpomx5KhoxJSTkJBv0hw9GqJWh34tWTc
 OCQcui1qHU83CfzaTj29F/n8Dkx4LXcQm9UTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704035508; x=1704640308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2kcm+hmnxnhMGwalE3cgGiOro6iqP/vlGsuNe1r42UU=;
 b=Bnlye3ndzB8soGw5+ZMrwGk0Oe6qBo0sxQvxpKd3nW+MTytyduXsusu3Ptpu0bd0nm
 Sz/WebUTXgMv2OhSdDEAkrTvpHEL3ebPiTIzzBUTb2JfHnPfo62EBbpeDb/miykF7my/
 nyarZfy1aBSbIS/DlaGeAwNE6UZbDslL3mCgXQhcenbAvfg6vqXyto55WuKocZb8E9TP
 eAXgdYUHRAl0oitUVgi7uRwXB3t2XRVDWbJFXSmiYTDjWR0wVkTlNOA70aBJgeCSqd9N
 7xwamg++vLAV+9EatVSc/mHlFYK5BOqe2uZfrVF9Mb+SfYS7HLjAHMqEdEbw/8spB8gc
 miRg==
X-Gm-Message-State: AOJu0YzpLS7XqMzW9FAbcabC0gEVV81ItEmdDrRfJC8fdvmY1gW9xT9n
 W9d/K6Llkv2Nf32YqupmRleu6WvKaG9VEg==
X-Google-Smtp-Source: AGHT+IFB1X9c/bn7/3QGtn3Y4uTRUTNGkYRlGMAenf3paTYToFpsPlwNkp5jJ2rY19QDdv44tLgCpg==
X-Received: by 2002:a05:6214:413:b0:67a:4f43:e130 with SMTP id
 z19-20020a056214041300b0067a4f43e130mr19018461qvx.18.1704035508009; 
 Sun, 31 Dec 2023 07:11:48 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 z16-20020a0ce610000000b0067f0d8cf418sm8682096qvm.70.2023.12.31.07.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 07:11:46 -0800 (PST)
Date: Sun, 31 Dec 2023 10:11:44 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, xypron.glpk@gmx.de,
 u-boot@lists.denx.de, ilias.apalodimas@linaro.org
Subject: Re: Proposal: U-Boot memory management
Message-ID: <20231231151144.GD2652760@bill-the-cat>
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <CAFLszThqH01GOqnTxucVE7s+wJU-dz7uqUtkb4iKxs6GgX6tqw@mail.gmail.com>
 <20231229154307.GS2652760@bill-the-cat>
 <7CDAA354-803C-4AFD-BD38-F432B811DB96@gmx.de>
 <20231229161744.GU2652760@bill-the-cat>
 <871qb4nbtc.fsf@bloch.sibelius.xs4all.nl>
 <20231229175215.GY2652760@bill-the-cat>
 <CAFLszTjXrmhOBeMvGfpy3mfZujNrCu2BKmUbEYz-rmxwyWdg3A@mail.gmail.com>
 <20231231135357.GZ2652760@bill-the-cat>
 <CAFLszTgCSDsobu9ak495vnRP-bjakK5Ytxd5YXro0-7GmYj9vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T+ZuoWqoWyMVnMYr"
Content-Disposition: inline
In-Reply-To: <CAFLszTgCSDsobu9ak495vnRP-bjakK5Ytxd5YXro0-7GmYj9vA@mail.gmail.com>
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


--T+ZuoWqoWyMVnMYr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023 at 07:22:10AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, Dec 31, 2023 at 6:54=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Sun, Dec 31, 2023 at 05:48:23AM -0700, Simon Glass wrote:
> > > Hi,
> > >
> > > On Fri, Dec 29, 2023 at 10:52=E2=80=AFAM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Fri, Dec 29, 2023 at 06:44:15PM +0100, Mark Kettenis wrote:
> > > > > > Date: Fri, 29 Dec 2023 11:17:44 -0500
> > > > > > From: Tom Rini <trini@konsulko.com>
> > > > > >
> > > > > > On Fri, Dec 29, 2023 at 05:05:17PM +0100, Heinrich Schuchardt w=
rote:
> > > > > > >
> > > > > > >
> > > > > > > Am 29. Dezember 2023 16:43:07 MEZ schrieb Tom Rini <trini@kon=
sulko.com>:
> > > > > > > >On Fri, Dec 29, 2023 at 05:36:09AM +0000, Simon Glass wrote:
> > > > > > > >> Hi,
> > > > > > > >>
> > > > > > > >> On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM Simon Glass <sjg@c=
hromium.org> wrote:
> > > > > > > >> >
> > > > > > > >> > Hi,
> > > > > > > >> >
> > > > > > > >> > This records my thoughts after a discussion with Ilias &=
 Heinrich re
> > > > > > > >> > memory allocation in U-Boot.
> > > > > > > >> >
> > > > > > > >> > 1. malloc()
> > > > > > > >> >
> > > > > > > >> > malloc() is used for programmatic memory allocation. It =
allows memory
> > > > > > > >> > to be freed. It is not designed for very large allocatio=
ns (e.g. a
> > > > > > > >> > 10MB kernel or 100MB ramdisk).
> > > > > > > >> >
> > > > > > > >> > 2. lmb
> > > > > > > >> >
> > > > > > > >> > lmb is used for large blocks of memory, such as those ne=
eded for a
> > > > > > > >> > kernel or ramdisk. Allocation is only transitory, for th=
e purposes of
> > > > > > > >> > loading some images and booting. If the boot fails, then=
 all lmb
> > > > > > > >> > allocations go away.
> > > > > > > >> >
> > > > > > > >> > lmb is set up by getting all available memory and then r=
emoving what
> > > > > > > >> > is used by U-Boot (code, data, malloc() space, etc.)
> > > > > > > >> >
> > > > > > > >> > lmb reservations have a few flags so that areas of memor=
y can be
> > > > > > > >> > provided with attributes
> > > > > > > >> >
> > > > > > > >> > There are some corner cases...e.g. loading a file does a=
n lmb
> > > > > > > >> > allocation but only for the purpose of avoiding a file b=
eing loaded
> > > > > > > >> > over U-Boot code/data. The allocation is dropped immedia=
tely after the
> > > > > > > >> > file is loaded. Within the bootm command, or when using =
standard boot,
> > > > > > > >> > this would be fairly easy to solve.
> > > > > > > >> >
> > > > > > > >> > Linux has renamed lmb to memblock. We should consider do=
ing the same.
> > > > > > > >> >
> > > > > > > >> > 3. EFI
> > > > > > > >> >
> > > > > > > >> > EFI has its own memory-allocation tables.
> > > > > > > >> >
> > > > > > > >> > Like lmb, EFI is able to deal with large allocations. Bu=
t via a 'pool'
> > > > > > > >> > function it can also do smaller allocations similar to m=
alloc(),
> > > > > > > >> > although each one uses at least 4KB at present.
> > > > > > > >> >
> > > > > > > >> > EFI allocations do not go away when a boot fails.
> > > > > > > >> >
> > > > > > > >> > With EFI it is possible to add allocations post facto, i=
n which case
> > > > > > > >> > they are added to the allocation table just as if the me=
mory was
> > > > > > > >> > allocated with EFI to begin with.
> > > > > > > >> >
> > > > > > > >> > The EFI allocations and the lmb allocations use the same=
 memory, so in
> > > > > > > >> > principle could conflict.
> > > > > > > >> >
> > > > > > > >> > EFI allocations are sometimes used to allocate internal =
U-Boot data as
> > > > > > > >> > well, if needed by the EFI app. For example, while efi_i=
mage_parse()
> > > > > > > >> > uses malloc(), efi_var_mem.c uses EFI allocations since =
the code runs
> > > > > > > >> > in the app context and may need to access the memory aft=
er U-Boot has
> > > > > > > >> > exited. Also efi_smbios.c uses allocate_pages() and then=
 adds a new
> > > > > > > >> > mapping as well.
> > > > > > > >> >
> > > > > > > >> > EFI memory has attributes, including what the memory is =
used for (to
> > > > > > > >> > some degree of granularity). See enum efi_memory_type an=
d struct
> > > > > > > >> > efi_mem_desc. In the latter there are also attribute fla=
gs - whether
> > > > > > > >> > memory is cacheable, etc.
> > > > > > > >> >
> > > > > > > >> > EFI also has the x86 idea of 'conventional' memory, mean=
ing (I
> > > > > > > >> > believe) that below 4GB that isn't reserved for the hard=
ware/system.
> > > > > > > >> > This is meaningless, or at least confusing, on ARM syste=
ms.
> > > > > > > >> >
> > > > > > > >> > 4. reservations
> > > > > > > >> >
> > > > > > > >> > It is perhaps worth mentioning a fourth method of memory=
 management,
> > > > > > > >> > where U-Boot reserves chunks of memory before relocation=
 (in
> > > > > > > >> > board_init_f.c), e.g. for the framebuffer, U-Boot code, =
the malloc()
> > > > > > > >> > region, etc.
> > > > > > > >> >
> > > > > > > >> >
> > > > > > > >> > Problems
> > > > > > > >> > =E2=80=94-------
> > > > > > > >> >
> > > > > > > >> > There are no urgent problems, but here are some things t=
hat could be improved:
> > > > > > > >> >
> > > > > > > >> > 1. EFI should attach most of its data structures to driv=
er model. This
> > > > > > > >> > work has started, with the partition support, but more e=
ffort would
> > > > > > > >> > help. This would make it easier to see which memory is r=
elated to
> > > > > > > >> > devices and which is separate.
> > > > > > > >> >
> > > > > > > >> > 2. Some drivers do EFI reservations today, whether EFI i=
s used for
> > > > > > > >> > booting or not (e.g. rockchip video rk_vop_probe()).
> > > > > > > >> >
> > > > > > > >> > 3. U-Boot doesn't really map arch-specific memory attrib=
utes (e.g.
> > > > > > > >> > armv8's struct mm_region) to EFI ones.
> > > > > > > >> >
> > > > > > > >> > 4. EFI duplicates some code from bootm, some of which re=
lates to
> > > > > > > >> > memory allocation (e.g. FDT fixup).
> > > > > > > >> >
> > > > > > > >> > 5. EFI code is used even if EFI is never used to boot
> > > > > > > >> >
> > > > > > > >> > 6. EFI allocations can result in the same memory being u=
sed as has
> > > > > > > >> > already been allocated by lmb. Users may load files whic=
h overwrite
> > > > > > > >> > memory allocated by EFI.
> > > > > > > >>
> > > > > > > >> 7. We need to support doing an allocation when a file is l=
oaded (to
> > > > > > > >> ensure files do not overlap), without making it too diffic=
ult to load
> > > > > > > >> multiple files to the same place, if desired.
> > > > > > > >>
> > > > > > > >> >
> > > > > > > >> >
> > > > > > > >> > Lifetime
> > > > > > > >> > --------
> > > > > > > >> >
> > > > > > > >> > We have three different memory allocators with different=
 purposes. Can
> > > > > > > >> > we unify them a little?
> > > > > > > >> >
> > > > > > > >> > Within U-Boot:
> > > > > > > >> > - malloc() space lives forever
> > > > > > > >> > - lmb lives while setting out images for booting
> > > > > > > >> > - EFI (mostly) lives while booting an EFI app
> > > > > > > >> >
> > > > > > > >> > In practice, EFI is set up early in U-Boot. Some of this=
 is necessary,
> > > > > > > >> > some not. EFI allocations stay around forever. This work=
s OK since
> > > > > > > >> > large allocations are normally not done in EFI, so memor=
y isn't really
> > > > > > > >> > consumed to any great degree by the boot process.
> > > > > > > >> >
> > > > > > > >> > What happens to EFI allocations if the app returns? They=
 are still
> > > > > > > >> > present, in case another app is run. This seems fine.
> > > > > > > >> >
> > > > > > > >> > API
> > > > > > > >> > =E2=80=93--
> > > > > > > >> > Can we unify some APIs?
> > > > > > > >> >
> > > > > > > >> > It should be possible to use lmb for large EFI memory al=
locations, so
> > > > > > > >> > long as they are only needed for booting. We effectively=
 do this
> > > > > > > >> > today, since EFI does not manage the arrangement of load=
ed images in
> > > > > > > >> > memory. for the most part.
> > > > > > > >> >
> > > > > > > >> > It would not make sense to use EFI allocation to replace=
 lmb and
> > > > > > > >> > malloc(), of course.
> > > > > > > >> >
> > > > > > > >> > Could we use a common (lower-level) API for allocation, =
used by both
> > > > > > > >> > lmb and EFI? They do have some similarities. However the=
y have
> > > > > > > >> > different lifetime constraints (EFI allocations are neve=
r dropped,
> > > > > > > >> > unlikely lmb).
> > > > > > > >> >
> > > > > > > >> > ** Overall, it seems that the existence of memory alloca=
tion in
> > > > > > > >> > boot-time services has created confusion. Memory allocat=
ion is
> > > > > > > >> > muddled, with both U-Boot code and boot-time services ca=
lling the same
> > > > > > > >> > memory allocator. This just has not been clearly thought=
 out.
> > > > > > > >> >
> > > > > > > >> >
> > > > > > > >> > Proposal
> > > > > > > >> > =E2=80=94-------
> > > > > > > >> >
> > > > > > > >> > Here are some ideas:
> > > > > > > >> >
> > > > > > > >> > 1. For video, use the driver model API to locate the vid=
eo regions, or
> > > > > > > >> > block off the entire framebuffer memory, for all devices=
 as a whole.
> > > > > > > >> > Use efi_add_memory_map()
> > > > > > > >> >
> > > > > > > >> > 2. Add memory attributes to UCLASS_RAM and use them in E=
FI, mapping to
> > > > > > > >> > the EFI_MEMORY_... attributes in struct efi_mem_desc.
> > > > > > > >> >
> > > > > > > >> > 3. Add all EFI reservations just before booting the app,=
 as we do with
> > > > > > > >> > devicetree fixup. With this model, malloc() and lmb are =
used for all
> > > > > > > >> > allocation. Then efi_add_memory_map() is called for each=
 region in
> > > > > > > >> > turn just before booting. Memory attributes are dealt wi=
th above. The
> > > > > > > >> > type (enum efi_memory_type) can be determined simply by =
the data
> > > > > > > >> > structure stored in it, as is done today. For example, S=
MBIOS tables
> > > > > > > >> > can use EFI_ACPI_RECLAIM_MEMORY. Very few types are used=
 and EFI code
> > > > > > > >> > understands the meaning of each.
> > > > > > > >> >
> > > > > > > >> > 4. Avoid setting up EFI memory at the start of U-Boot. D=
o it only when
> > > > > > > >> > booting. This looks to require very little effort.
> > > > > > > >> >
> > > > > > > >> > 5. Avoid calling efi_allocate_pages() and efi_allocate_p=
ool() outside
> > > > > > > >> > boot-time services. This solves the problem 6. If memory=
 is needed by
> > > > > > > >> > an app, allocate it with malloc() and see 3. There are o=
nly two
> > > > > > > >> > efi_allocate_pages() (smbios and efi_runtime). There are=
 more calls of
> > > > > > > >> > efi_allocate_pool(), but most of these seem easy to fix =
up. For
> > > > > > > >> > example, efi_init_event_log() allocates a buffer, but th=
is can be
> > > > > > > >> > allocated in normal malloc() space or in a bloblist.
> > > > > > > >> >
> > > > > > > >> > 6. Don't worry too much about whether EFI will be used f=
or booting.
> > > > > > > >> > The cost is likely not that great: use bootstage to meas=
ure it as is
> > > > > > > >> > done for driver model. Try to minmise the cost of its ta=
bles,
> > > > > > > >> > particularly for execution time, but otherwise just rely=
 on the
> > > > > > > >> > ability to disable EFI_LOADER.
> > > > > > > >>
> > > > > > > >> 7. Add a flag to the 'load' command:
> > > > > > > >>
> > > > > > > >> -m <type> - make an lmb allocation for the file
> > > > > > > >>    <type> is the image type to use (kernel, ramdisk, flat_=
dt)
> > > > > > > >>
> > > > > > > >> any existing allocation for that type will be automaticall=
y freed
> > > > > > > >> first. If <type> is "none" then no freeing is possible: an=
y loaded
> > > > > > > >> images just stack up in lmb.
> > > > > > > >>
> > > > > > > >> Add an 'lmb' (or memblock) command to allow listing and cl=
earing allocations.
> > > > > > > >
> > > > > > > >I would really not like to change the user interface and ins=
tead simply
> > > > > > > >handle this with flags to whatever mark/allocation function =
is called.
> > > > > > > >You can always overwrite things that are brought in to memor=
y, you
> > > > > > > >cannot overwrite U-Boot or our internals. Optionally noting =
that some
> > > > > > > >previous load to memory has been at least partially overwrit=
ten could be
> > > > > > > >helpful, if it's not too much extra logic.
> > > > > > > >
> > > > > > >
> > > > > > > In most use cases users load exactly one file at  each addres=
s. An
> > > > > > > unload command would be the cleanest way for a user to indica=
te that
> > > > > > > he wants to reuse the memory.
> > > > > >
> > > > > > I very much do not want to change the API. There's untold numbe=
rs of
> > > > > > scripts out there and they should continue to work. I mentioned=
 to Ilias
> > > > > > off list just now that I'm not against adding a command to add =
flags to
> > > > > > these areas, but I don't think it's worthwhile to prevent overw=
rites the
> > > > > > user did early. The biggest long running problem in this space =
was that
> > > > > > for 32bit ARM we couldn't know where the kernel BSS was going t=
o be and
> > > > > > so would have ramdisk at the wrong spot and get partially eaten=
, and
> > > > > > this was hard to figure out. The current example is "ooops,
> > > > > > decompression buffer for Image.gz/etc is too close to other thi=
ngs"
> > > > > > which ends up failing nice and loudly, and in the future once t=
his
> > > > > > proposal is done we can just dynamically find and use a spot, s=
ince
> > > > > > we'll have that ability finally.
> > > > >
> > > > > In order to keep the existing interfaces we need lmb to keep trac=
k of
> > > > > (at least ) three different states.  I think of those as "free",
> > > > > "allocated" and "reserved".  The load command would "reserve" mem=
ory
> > > > > insteaf "allocate".  And it would pass a flag to lmb when reservi=
ng
> > > > > memory to indicate that reserving memory that is already reserved=
 is
> > > > > ok.  Both "reserved" and "allocated" memory should show up as not=
 free
> > > > > in the EFI memory map (probably as EfiLoaderData).
> > > >
> > > > Yes, something like this is what I was getting at, thanks.
> > >
> > > Yes, that is a good way of putting it. There is definitely a distinct=
ion there.
> > >
> > > If we don't want this flag, we could make U-Boot always do a
> > > reservation on load, with a '-f' command to force loading over an
> > > existing reservation / releasing it first?
> >
> > Again, this is an API change and I don't want to change the API.
>=20
> The flag is only needed to drop a reservation, since we apparently
> want the 'load' command to create a permanent reservation. It should
> not affect existing boot scripts since they won't load overlapping
> images.
>=20
> Anyway, what do you suggest?

That "load" (and sf read and nand read and tftp and wget and ...)
"reserve" memory but not "allocate" memory and "reserve" means something
is there and "allocate" means that it can't be modified again. For
example, running U-Boot and our malloc pool are "allocated" but just
loading a file to memory is "reserved".  And then yes, I can see use for
the command where some cases might want to "reserve" memory to fiddle
with it and then "allocate" it so something else can't change it.

This is one of those cases where english is terrible to discuss things
in as both reserve and allocate can mean similar things.

--=20
Tom

--T+ZuoWqoWyMVnMYr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWRhLAACgkQFHw5/5Y0
tyxnNAwAiZwIA0HIXTubZvwoN0lMkgZRHqoqhLB9mAFHD1KoHjglKOhyy3xqflre
iWny8hBQSvqDqoLFMaLqdOV/hdTsdt6BufqHKwdB0t47C6U35xVALJkx2kga0+66
33DmOgn3gFT/6e3I3ON4MvxtOpH5nLp2PsZr7T9IHAYnOo+EOprRjTzEMcr7q2nV
2VWjnbY3CpzljP7orlhb4d69zyBu11daHxmrtCruiZij1AYPM8hy3rK9Fa4lHoSZ
B9qx38dlLHvhhsVy80vjXPq9uHNG1Svqr+P9lcEsiaRZnHkWK4OWXb8HXGX1zqW8
X5Kr4nPDfWlIuQsQVX5s7JYFk+EEJ0ns5PxRAQBaLO0dc/KiAz4VIoqUDBhukCR0
US6rqx7sCvpzoHhc0NN0MdpTpS3xyCDGrCHFNN/XFolZWchSQOCR3R4Ay2QPzW3K
3EHK6RXL8tChjZVXqQQGgfXkcCWVwt2eaNFciUW8yBhoVmX2eXiC8uxIPYWU5saM
gaXPF4bk
=o0ap
-----END PGP SIGNATURE-----

--T+ZuoWqoWyMVnMYr--
