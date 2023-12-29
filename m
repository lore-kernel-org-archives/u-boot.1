Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECA6C47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:52:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1AEB87BD6;
	Fri, 29 Dec 2023 18:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dU8JPGLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDA5687BAC; Fri, 29 Dec 2023 18:51:22 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28ED087B87
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5f00bef973aso7113427b3.0
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 09:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703872279; x=1704477079; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mdial25cB8UhitVXP4CgUoxuTPY/EWjv5+wJ2dtB0PM=;
 b=dU8JPGLwLNzwn2L9ysplSJU+mlQHxkubwbuxpdY9U9mIOLLvhC4JdD90ShiYsJZnmE
 veTJnZiLQ8n0Wdj0NVITeWyl3/eprhpLjCQdir/gG2NQ48ed9YFiMUYu7CBTy+iVcuuy
 pqvzkcanPI00gESYH1kvm4EzHd5ENYpNQUSR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703872279; x=1704477079;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdial25cB8UhitVXP4CgUoxuTPY/EWjv5+wJ2dtB0PM=;
 b=pvFVl4BSv7eAAl38sCMG5V0s71sZ1ZjetSdllApPrrVbDYMpZbe9vdZi3OZigYxwAH
 77M8fnpGOH82pBpfzy5WjQgFg9m32TYJFmXYA3NA4H+AlrvN1tz33B75uy/xVOHGTjmW
 7fxMpLnhZzN/G8ujB0IM4FeGl+MOWoWewmav3Y0ZMXe+Yla+Es2T4rwHT34AZajI0cX6
 46t1DON9hQMHX6dd7WqRlZO7DO9edRlahhGNDMguIYpqisEwWQfgK6Acxqj3Uct96Bdj
 ed61FVLwX9qJWt8sSiITd2Ue4vVg4ONmrqYHFbRX1nYOmmwzYiK8hR3Kr2TGjLShBFuE
 RIFw==
X-Gm-Message-State: AOJu0YzvffETAROHSskCBDkVjIg7j6jcRGh8O6ZCglG3rd4JZBulMojO
 c3FdZKIFSjMw7gq21opzrHDgGWYxsOaR/WWgTIpm2X8Qrag=
X-Google-Smtp-Source: AGHT+IFNDGlaQPVJZLYK5HY8v/UaLsnHsK/D17LhbxWwX/Z3kve/ptRBVbwQPXLLJyzxxDsdNa59mA==
X-Received: by 2002:a81:9a52:0:b0:5ef:e39e:31f with SMTP id
 r79-20020a819a52000000b005efe39e031fmr1402371ywg.22.1703872278718; 
 Fri, 29 Dec 2023 09:51:18 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c67-20020a0df346000000b005e7d8d6e446sm8642974ywf.93.2023.12.29.09.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:51:18 -0800 (PST)
Date: Fri, 29 Dec 2023 12:51:15 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: Proposal: U-Boot memory management
Message-ID: <20231229175115.GX2652760@bill-the-cat>
References: <20231219012600.GQ2513409@bill-the-cat>
 <E0572546-90AA-41C4-8433-EF02BB12E434@gmx.de>
 <20231219124553.GS2513409@bill-the-cat>
 <CAPnjgZ1SUoRKEWaK6k1rrVN4t0WLD24GGeRj7uer3A0XA_MKoA@mail.gmail.com>
 <20231220191219.GP2513409@bill-the-cat>
 <be5fb3fc-2ac9-41ae-a1b5-c08441b1cbe2@gmx.de>
 <20231229164724.GV2652760@bill-the-cat>
 <857521d0-780d-47f1-964f-4720ed09492b@gmx.de>
 <20231229172139.GW2652760@bill-the-cat>
 <eeeba72f-d216-4daf-8f1b-055fc638b689@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SA/oiO1dsPN1sraY"
Content-Disposition: inline
In-Reply-To: <eeeba72f-d216-4daf-8f1b-055fc638b689@gmx.de>
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


--SA/oiO1dsPN1sraY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 06:30:43PM +0100, Heinrich Schuchardt wrote:
> On 12/29/23 18:21, Tom Rini wrote:
> > On Fri, Dec 29, 2023 at 06:09:44PM +0100, Heinrich Schuchardt wrote:
> > > On 12/29/23 17:47, Tom Rini wrote:
> > > > On Fri, Dec 29, 2023 at 05:42:17PM +0100, Heinrich Schuchardt wrote:
> > > > > On 12/20/23 20:12, Tom Rini wrote:
> > > > > > On Tue, Dec 19, 2023 at 09:15:21PM -0700, Simon Glass wrote:
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > On Tue, 19 Dec 2023 at 05:46, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >=20
> > > > > > > > On Tue, Dec 19, 2023 at 03:15:38AM +0100, Heinrich Schuchar=
dt wrote:
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Am 19. Dezember 2023 02:26:00 MEZ schrieb Tom Rini <trini=
@konsulko.com>:
> > > > > > > > > > On Tue, Dec 19, 2023 at 01:01:51AM +0100, Heinrich Schu=
chardt wrote:
> > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > Am 19. Dezember 2023 00:31:30 MEZ schrieb Tom Rini <t=
rini@konsulko.com>:
> > > > > > > > > > > > On Tue, Dec 19, 2023 at 12:29:19AM +0100, Heinrich =
Schuchardt wrote:
> > > > > > > > > > > > >=20
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Am 19. Dezember 2023 00:16:40 MEZ schrieb Tom Rin=
i <trini@konsulko.com>:
> > > > > > > > > > > > > > On Tue, Dec 19, 2023 at 12:08:31AM +0100, Heinr=
ich Schuchardt wrote:
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Am 18. Dezember 2023 23:41:08 MEZ schrieb Tom=
 Rini <trini@konsulko.com>:
> > > > > > > > > > > > > > > > On Mon, Dec 18, 2023 at 11:34:16PM +0100, H=
einrich Schuchardt wrote:
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > [snip]
> > > > > > > > > > > > > > > > > Or take:
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > load host 0:1 $c kernel.efi
> > > > > > > > > > > > > > > > > load host 0:1 $d initrd.img
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > How could we ensure that initrd.img is no=
t overwriting a part of kernel.efi without memory allocation?
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > Today, invalid checksum as part of some par=
t of the kernel fails. But
> > > > > > > > > > > > > > > > how do we do this tomorrow, are you suggest=
ing that "load" perform
> > > > > > > > > > > > > > > > malloc() in some predefined size? If $c is =
below $d and $c + kernel.efi
> > > > > > > > > > > > > > > > is now above $d we can throw an error befor=
e trying to load, yes. But
> > > > > > > > > > > > > > > > what about:
> > > > > > > > > > > > > > > > load host 0:1 $d initrd.img
> > > > > > > > > > > > > > > > load host 0:1 $c kernel.efi
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > In that case (which is only marginally cont=
rived, the more real case is
> > > > > > > > > > > > > > > > loading device tree in to unexpectedly larg=
e ramdisk because someone
> > > > > > > > > > > > > > > > didn't understand the general advice on why=
 device tree is lower than
> > > > > > > > > > > > > > > > ramdisk address) I'm fine with an error tha=
t amounts to "you just
> > > > > > > > > > > > > > > > corrupted another allocation" and then "fai=
l, reset the board" or so.
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Our current malloc library cannot manage the =
complete memory. We need a library like lmb which should also cover the mem=
ory management that we currently have in lib/efi/efi_memory.c. This must in=
clude a memory type attribute for usage in the GetMemoryMap() service. A ma=
nagement on page level seems sufficient.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > The load command should permanently allocate =
memory in that lmb+ library.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > We need an unload command to free the memory =
if we want to reuse the memory or we might let the load comand free the mem=
ory if exactly the same start address is reused.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Our current way of loading things in to memory =
does not handle the case
> > > > > > > > > > > > > > I described, yes. How would what you're proposi=
ng handle it?
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > If the load command has to allocate memory for th=
e image and that allocation is kept, any attempt to allocate overlapping me=
mory would fail.
> > > > > > > > > > > >=20
> > > > > > > > > > > > So you're saying that the load command has to pre-a=
llocate memory? Or as
> > > > > > > > > > > > it goes? If the latter, in what size chunks? This s=
tarts to get at what
> > > > > > > > > > > > Simon was talking about with respect to memory frag=
mentation. Which to
> > > > > > > > > > > > be clear is a problem we have today, we just let th=
ings overlap and hope
> > > > > > > > > > > > something later catches an incorrect checksum.
> > > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > I don't want to replace the malloc library which hand=
les large numbets of allocations.
> > > > > > > > > >=20
> > > > > > > > > > I'm confused. The normal malloc library is not involved=
 with current
> > > > > > > > > > image loading, it's direct to memory (with some attempt=
s at sanity
> > > > > > > > > > checking by lmb).  Are you proposing a different alloca=
tor with
> > > > > > > > > > malloc/free like behavior? If so, please outline how it=
 will determine
> > > > > > > > > > pool size, and how we'll use it to load thing to memory.
> > > > > > > > >=20
> > > > > > > > > All memory below the stack needs to be managed. Malloc us=
es a small memory area (a few MiB) above the stack.
> > > > > > > >=20
> > > > > > > > That's a rather huge change for how U-Boot works.
> > > > > > > >=20
> > > > > > > > > > > Closing the eyes when the user loads multiple files d=
oes not solve the fragmentation problem.
> > > > > > > > > >=20
> > > > > > > > > > Yes. I'm only noting that today we just ignore the prob=
lem and sometimes
> > > > > > > > > > catch it via checksums.
> > > > > > > > > >=20
> > > > > > > > > > > Fragmentation only happens if we have many concurrent=
 allocations.  In EFI we are allocating top down. The number of concurrent =
allocations is low. Typically a few dozen at most. After terminating an app=
lication these should be freed again.
> > > > > > > > > >=20
> > > > > > > > > > OK, so are you saying that we would no longer be loadin=
g _to_ a location
> > > > > > > > > > in memory and instead just be saying "load this thing" =
and picking where
> > > > > > > > > > dynamically?
> > > > > > > > >=20
> > > > > > > > > Both preassigned and allocator assigned adresses are comp=
atible with memory management.
> > > > > > > > >=20
> > > > > > > > > Architectures and binaries have different requirements. O=
n riscv64 you can load Linux kernel, initrd, fdt anywhere. We don't need pr=
edefined addresses there. Other architectures have restrictions.
> > > > > > > >=20
> > > > > > > > Yes, 64 bit architecture tend to only have alignment requir=
ements while
> > > > > > > > 32bit architectures have both alignment requirements and so=
me memory
> > > > > > > > window requirement. Whatever we implement here needs to han=
dle both
> > > > > > > > cases.
> > > > > > > >=20
> > > > > > > > > > > When loading a file from a file system we know the fi=
lesize beforehand. So allocation is trivial.
> > > > > > > > > > >=20
> > > > > > > > > > > The loady command currently does not use the  offered=
 size information but could do so.
> > > > > > > > > >=20
> > > > > > > > > > We should be using that information to make sure we don=
't overwrite
> > > > > > > > > > U-Boot itself, but I don't recall how exactly we handle=
 it today
> > > > > > > > > > off-hand.
> > > > > > > > >=20
> > > > > > > > > If the user issues multiple load commands, he can overwri=
te previous files.
> > > > > > > >=20
> > > > > > > > Then it sounds like we lost one benefit of all of this over=
head.
> > > > > > > >=20
> > > > > > > > > During boot command execution I guess the different alloc=
ations respect each other.
> > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > > TFTP is problematic because it does not transfer the =
filesize. We would probably try to allocate a large chunk of memory and the=
n downsize the allocation after reading the whole file.
> > > > > > > > > >=20
> > > > > > > > > > Reading from non-filesystem flash also has this problem=
, but we at least
> > > > > > > > > > specify the amount to read too. But yes, it gets back t=
o what I was
> > > > > > > > > > asking about on how you're proposing to handle network =
load cases.
> > > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > It depends on the protocol. Http conveys the size before =
the data. Tftp does not.
> > > > > > > > >=20
> > > > > > > > > If you don't know the size, you must preallocate a big ch=
unk, check that the download does not exceed it, and downsize the allocatio=
n afterwards. This is not a new problem but exists already with current lmb=
 usage.
> > > > > > > >=20
> > > > > > > > Yes, and what I'm trying to find out is if what you're sugg=
esting would
> > > > > > > > do anything about it, since previous statements you made im=
plied to me
> > > > > > > > that we would prevent it.
> > > > > > > >=20
> > > > > > > > To me, at this point it sounds like what we need is more li=
ke persistent
> > > > > > > > memory blocks and a hook that can be called in to for both =
"give me all
> > > > > > > > known memory blocks" and "add this memory block to the list=
", so that
> > > > > > > > EFI can do whatever it needs to do upon starting an applica=
tion and then
> > > > > > > > upon return to U-Boot. Both malloc/free allocations and "lo=
ad this blob
> > > > > > > > to memory from whatever" allocations would call the appropr=
iate hook for
> > > > > > > > tracking.
> > > > > > >=20
> > > > > > > In my mind the solution to this entire problem is fairly mino=
r changes
> > > > > > > to how memory is allocated and only for EFI.
> > > > > > >=20
> > > > > > > I tried to map out what that would look like and we have IMO =
got lost
> > > > > > > in the weeds a bit.
> > > > > > >=20
> > > > > > > I am not trying to solve the problem of the 'load' command do=
ing an
> > > > > > > allocation and throwing it away. To be that is WAI, at least =
until we
> > > > > > > come up with another type of command. This is one of the reas=
ons for
> > > > > > > standard boot, allowing a more cohesive approach to booting.
> > > > > > >=20
> > > > > > > I will think about this some more...
> > > > > >=20
> > > > > > OK, but please keep in mind that lmb not being at all persisten=
t is a
> > > > > > problem for everyone, not just EFI. That really needs to be add=
ressed,
> > > > > > maybe with some flags for dis-allowing overwrites to the area. =
For
> > > > > > example, the apple-m1 code to use lmb to find locations for the
> > > > > > kernel/etc can be written to more than once (allocate the addre=
ss, then
> > > > > > write to it to start with, even) but the range that covers U-Bo=
ot itself
> > > > > > (malloc pool and so forth) need to be stopped.
> > > > > >=20
> > > > >=20
> > > > > The range managed by the EFI sub-system extends over all of RAM
> > > > > including the addresses used by load commands. Hence, "the range =
that
> > > > > covers U-Boot itself (malloc pool and so forth)" includes all mem=
ory.
> > > > >=20
> > > > > Maybe we could pre-allocate a memory area for file loading. This =
just
> > > > > requires to define a device-specific high file memory address abo=
ve
> > > > > which no file loads will be allowed and below which EFI, bootm, e=
tc will
> > > > > not be allowed to allocate memory for further uses.
> > > >=20
> > > > We're not just / only an EFI runtime. When we load something persis=
tent
> > > > to memory outside of EFI, we need to note that, so that when EFI_LO=
ADER
> > > > beings work it can see this and do whatever it needs to do. And if/=
when
> > > > EFI_LOADER returns control back to U-Boot itself, it needs to update
> > > > that list with any new allocations that were done and mark them
> > > > appropriately.
> > >=20
> > > The idea of EFI loader returning control is misleading.
> > >=20
> > > You can load an EFI driver binary which provides a device to U-Boot.
> > > Whenever U-Boot accesses that driver allocations might occur.
> >=20
> > We cannot, today, load an EFI driver and then make use of it outside of
> > the context of having bootefi'd something, yes?
>=20
> We already can use iPXE to access iSCSI which provides a U-Boot block
> device. But it is an app. A similar binary could be compiled as EFI
> driver return to U-Boot and provide a block device to be directly
> addressed by the user via the CLI.

To be clear:

Today we can, or cannot, use iPXE to access an iSCSI device and then
"ext4load" off of it?

Today we can, or cannot, use iPXE to access an iSCSI device and then
"bootefi" another EFI application such as grub which can then load off
if it?

Today we can, or cannot, use iPXE to access an iSCSI device and have it
place a Linux Kernel Image at $loadaddr which we can then "md" or any
other standard U-Boot command with?

My assumption is that we can do the last two, today, and the first one
is something that yes, the specification allows, but not something we
have today and requires some discussion on how much we want to allow
modules-by-another-name to work. I very much don't want to start that
discussion right now either.

> > Or is this about that separate runtime area from another thread?
> >=20
> > But even then, if something is making an allocation it needs to inform
> > the rest of the world.
>=20
> We should have one memory management. When EFI's AllocatPages() or
> AllocatePool() is called it should use the same backend as any other
> allocation (except for the small region managed by malloc()).
>=20
> >=20
> > > I thought that we already agreed to have only one memory management a=
nd
> > > get rid of the LMB/EFI memory management duplication.
> >=20
> > We've agreed that today, CONFIG_LMB does not fit the use cases that we
> > have in a modern system, for anyones usage. It has been suggested and I
> > know it's somewhere on Ilias' TODO list, to try and take what we have
> > in the EFI_LOADER & co area and make it usable and useful for all
> > contexts. We also have what in some ways feels to me to be the inverse
> > of that, which is Simon's proposal.
>=20
> LMB and efi/loader/efi_memory.c have a big overlap in functionality.
>=20
> But we use LMB in a unfavorable way discarding all allocations.

Yes, we all agree that what we do with CONFIG_LMB today is not good nor
what we want long term. In some ways that feels like the single point of
agreement.

> > We have not agreed that the EFI model and restrictions are what
> > everything will now be using. What's on Ilias' TODD list might bring us
> > in that direction, and I want to see what that looks like in practice.
> > But it's not agreed to as the end goal here.
> >=20
> > And to be clear, I also would like to see what Simon's proposed, in
> > practice.

Because this part here. We've probably all talked this out a lot.
Without an implementation to examine we're probably going to continue to
not agree and possibly unintentionally misunderstand each other.

--=20
Tom

--SA/oiO1dsPN1sraY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWPBw0ACgkQFHw5/5Y0
tyxMsgwAhcFW8j9pD6DYcNPar1DCuss/OO5KqpMax+UqvlFkgXCvkISbOPje0Lqh
R9dpv8RHijGFzaxN9ogDKijZ8nKRcKTlY4OLFvdF31zvwvgnVndVBvf/DkzFjHbv
+BnIiT7sEJWrO0HKbOWF9oAZzWoRXpSvwmw5LzC9Pl4XGXFUw3t14LVzUEoW9wPy
omAKJ7yp/00qhRxEJ+EvgSTRe1EB40ohrQ9qSsRiTkdCzLgl2RCPnbncbnQQejWV
65ghgO3de0r0v7yMi92lClQrO/ywJPhtxjSbYbByZjqOrATI9mWffVOHQITAwLOX
J6wobL5MlfLHIJOBaSqju2NfPr/5KwB/CP3PcHq7BTDzjzFKXyjcEp3Itf//N3/F
gihrIZqER3uVsUUV7tVkS/7sTLgF9SitLlzdEdh7AqrkxvDZfg75VjFCc89bz6wH
fgJfRkIbqzm1qjA4Kbn/v7ifThzroUQRhbc5hNa9Uznnt9v3cOKWJ6N+oAex6Cid
52YjKEow
=mROz
-----END PGP SIGNATURE-----

--SA/oiO1dsPN1sraY--
