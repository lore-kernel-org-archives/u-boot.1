Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B07C47072
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1496787A27;
	Fri, 29 Dec 2023 18:21:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bjWYW0bF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C62187A27; Fri, 29 Dec 2023 18:21:48 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3797887A16
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:21:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5e6c8b70766so60916657b3.3
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 09:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703870504; x=1704475304; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RLmgoXVde9DprBBeMQKz+h4cQgLfJDUGlMqYrryophQ=;
 b=bjWYW0bFkzDtrjwE/FKC267gQDRyAiEFBQVi0yyVYq2zCJYuiz+DWVmxqns8L/V8jG
 JeO+9PoCBxj4VRHy/D00eYoaGv6wVNQNhbb+Ac0RwEuhvWOc+NGncAXb4lNAYjPx4QSz
 aEH48BdtEtLoO4sVGVwqymI54oIpFZc/KbdVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703870504; x=1704475304;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLmgoXVde9DprBBeMQKz+h4cQgLfJDUGlMqYrryophQ=;
 b=Kc7EMi1jeALrWNvmWKKDsNprwVig09++CL8w7ef22n7zcDxcHN4JVV7R+uACu5IZyw
 EY7qf26o2V6DzfmicR53gfVALogUOoEA+MKEKb21frTde3l9K6yB+4zwGy3UNguib9x2
 gw63KJV9sY2sJqzd/Hznt6wccUqlsad60JIfQzgBjmpqWnc3pFd8kcIrPbuYCr+BKz8W
 mz5PJ5grqqhNT6vXKp0NmEbTlayyUuVScIuk5/lYDtRsakbFpBgRrK5Y7XLlb3Tw6s0Z
 yB/4+RZczpY1Y8ajJip9maMonk/mEirnufCs0S6EVSAQ38b43J9vVp0aQWTvvmPiEgbz
 6bMw==
X-Gm-Message-State: AOJu0Yw5uj9vrE1R2ZCxmhJHks+rjZrDOgE62PPw8VaWUPehjjRfqfJU
 oqURkvSgKP+hcw/Dn6bnwK3WBE8tKwy7SEWbXnfy69iUofo=
X-Google-Smtp-Source: AGHT+IFIIodEtShpNqjFGkfLsKrjJfGOhPYWwgdVUuj4pBa1IMjm78B6e0Ya0XWCW3lTQOjggXaSlw==
X-Received: by 2002:a0d:d44e:0:b0:5de:a261:9074 with SMTP id
 w75-20020a0dd44e000000b005dea2619074mr6896485ywd.7.1703870503763; 
 Fri, 29 Dec 2023 09:21:43 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 l186-20020a0dc9c3000000b005e8991c1a69sm8571931ywd.140.2023.12.29.09.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:21:43 -0800 (PST)
Date: Fri, 29 Dec 2023 12:21:39 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: Proposal: U-Boot memory management
Message-ID: <20231229172139.GW2652760@bill-the-cat>
References: <20231218233130.GP2513409@bill-the-cat>
 <688C13A3-9C5F-4A39-9F8F-54C2E8D08EE8@gmx.de>
 <20231219012600.GQ2513409@bill-the-cat>
 <E0572546-90AA-41C4-8433-EF02BB12E434@gmx.de>
 <20231219124553.GS2513409@bill-the-cat>
 <CAPnjgZ1SUoRKEWaK6k1rrVN4t0WLD24GGeRj7uer3A0XA_MKoA@mail.gmail.com>
 <20231220191219.GP2513409@bill-the-cat>
 <be5fb3fc-2ac9-41ae-a1b5-c08441b1cbe2@gmx.de>
 <20231229164724.GV2652760@bill-the-cat>
 <857521d0-780d-47f1-964f-4720ed09492b@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hCY00DDlPhh7Qrbc"
Content-Disposition: inline
In-Reply-To: <857521d0-780d-47f1-964f-4720ed09492b@gmx.de>
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


--hCY00DDlPhh7Qrbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 06:09:44PM +0100, Heinrich Schuchardt wrote:
> On 12/29/23 17:47, Tom Rini wrote:
> > On Fri, Dec 29, 2023 at 05:42:17PM +0100, Heinrich Schuchardt wrote:
> > > On 12/20/23 20:12, Tom Rini wrote:
> > > > On Tue, Dec 19, 2023 at 09:15:21PM -0700, Simon Glass wrote:
> > > > > Hi,
> > > > >=20
> > > > > On Tue, 19 Dec 2023 at 05:46, Tom Rini <trini@konsulko.com> wrote:
> > > > > >=20
> > > > > > On Tue, Dec 19, 2023 at 03:15:38AM +0100, Heinrich Schuchardt w=
rote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > Am 19. Dezember 2023 02:26:00 MEZ schrieb Tom Rini <trini@kon=
sulko.com>:
> > > > > > > > On Tue, Dec 19, 2023 at 01:01:51AM +0100, Heinrich Schuchar=
dt wrote:
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Am 19. Dezember 2023 00:31:30 MEZ schrieb Tom Rini <trini=
@konsulko.com>:
> > > > > > > > > > On Tue, Dec 19, 2023 at 12:29:19AM +0100, Heinrich Schu=
chardt wrote:
> > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > Am 19. Dezember 2023 00:16:40 MEZ schrieb Tom Rini <t=
rini@konsulko.com>:
> > > > > > > > > > > > On Tue, Dec 19, 2023 at 12:08:31AM +0100, Heinrich =
Schuchardt wrote:
> > > > > > > > > > > > >=20
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Am 18. Dezember 2023 23:41:08 MEZ schrieb Tom Rin=
i <trini@konsulko.com>:
> > > > > > > > > > > > > > On Mon, Dec 18, 2023 at 11:34:16PM +0100, Heinr=
ich Schuchardt wrote:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > [snip]
> > > > > > > > > > > > > > > Or take:
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > load host 0:1 $c kernel.efi
> > > > > > > > > > > > > > > load host 0:1 $d initrd.img
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > How could we ensure that initrd.img is not ov=
erwriting a part of kernel.efi without memory allocation?
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Today, invalid checksum as part of some part of=
 the kernel fails. But
> > > > > > > > > > > > > > how do we do this tomorrow, are you suggesting =
that "load" perform
> > > > > > > > > > > > > > malloc() in some predefined size? If $c is belo=
w $d and $c + kernel.efi
> > > > > > > > > > > > > > is now above $d we can throw an error before tr=
ying to load, yes. But
> > > > > > > > > > > > > > what about:
> > > > > > > > > > > > > > load host 0:1 $d initrd.img
> > > > > > > > > > > > > > load host 0:1 $c kernel.efi
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > In that case (which is only marginally contrive=
d, the more real case is
> > > > > > > > > > > > > > loading device tree in to unexpectedly large ra=
mdisk because someone
> > > > > > > > > > > > > > didn't understand the general advice on why dev=
ice tree is lower than
> > > > > > > > > > > > > > ramdisk address) I'm fine with an error that am=
ounts to "you just
> > > > > > > > > > > > > > corrupted another allocation" and then "fail, r=
eset the board" or so.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Our current malloc library cannot manage the comp=
lete memory. We need a library like lmb which should also cover the memory =
management that we currently have in lib/efi/efi_memory.c. This must includ=
e a memory type attribute for usage in the GetMemoryMap() service. A manage=
ment on page level seems sufficient.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > The load command should permanently allocate memo=
ry in that lmb+ library.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > We need an unload command to free the memory if w=
e want to reuse the memory or we might let the load comand free the memory =
if exactly the same start address is reused.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Our current way of loading things in to memory does=
 not handle the case
> > > > > > > > > > > > I described, yes. How would what you're proposing h=
andle it?
> > > > > > > > > > >=20
> > > > > > > > > > > If the load command has to allocate memory for the im=
age and that allocation is kept, any attempt to allocate overlapping memory=
 would fail.
> > > > > > > > > >=20
> > > > > > > > > > So you're saying that the load command has to pre-alloc=
ate memory? Or as
> > > > > > > > > > it goes? If the latter, in what size chunks? This start=
s to get at what
> > > > > > > > > > Simon was talking about with respect to memory fragment=
ation. Which to
> > > > > > > > > > be clear is a problem we have today, we just let things=
 overlap and hope
> > > > > > > > > > something later catches an incorrect checksum.
> > > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > I don't want to replace the malloc library which handles =
large numbets of allocations.
> > > > > > > >=20
> > > > > > > > I'm confused. The normal malloc library is not involved wit=
h current
> > > > > > > > image loading, it's direct to memory (with some attempts at=
 sanity
> > > > > > > > checking by lmb).  Are you proposing a different allocator =
with
> > > > > > > > malloc/free like behavior? If so, please outline how it wil=
l determine
> > > > > > > > pool size, and how we'll use it to load thing to memory.
> > > > > > >=20
> > > > > > > All memory below the stack needs to be managed. Malloc uses a=
 small memory area (a few MiB) above the stack.
> > > > > >=20
> > > > > > That's a rather huge change for how U-Boot works.
> > > > > >=20
> > > > > > > > > Closing the eyes when the user loads multiple files does =
not solve the fragmentation problem.
> > > > > > > >=20
> > > > > > > > Yes. I'm only noting that today we just ignore the problem =
and sometimes
> > > > > > > > catch it via checksums.
> > > > > > > >=20
> > > > > > > > > Fragmentation only happens if we have many concurrent all=
ocations.  In EFI we are allocating top down. The number of concurrent allo=
cations is low. Typically a few dozen at most. After terminating an applica=
tion these should be freed again.
> > > > > > > >=20
> > > > > > > > OK, so are you saying that we would no longer be loading _t=
o_ a location
> > > > > > > > in memory and instead just be saying "load this thing" and =
picking where
> > > > > > > > dynamically?
> > > > > > >=20
> > > > > > > Both preassigned and allocator assigned adresses are compatib=
le with memory management.
> > > > > > >=20
> > > > > > > Architectures and binaries have different requirements. On ri=
scv64 you can load Linux kernel, initrd, fdt anywhere. We don't need predef=
ined addresses there. Other architectures have restrictions.
> > > > > >=20
> > > > > > Yes, 64 bit architecture tend to only have alignment requiremen=
ts while
> > > > > > 32bit architectures have both alignment requirements and some m=
emory
> > > > > > window requirement. Whatever we implement here needs to handle =
both
> > > > > > cases.
> > > > > >=20
> > > > > > > > > When loading a file from a file system we know the filesi=
ze beforehand. So allocation is trivial.
> > > > > > > > >=20
> > > > > > > > > The loady command currently does not use the  offered siz=
e information but could do so.
> > > > > > > >=20
> > > > > > > > We should be using that information to make sure we don't o=
verwrite
> > > > > > > > U-Boot itself, but I don't recall how exactly we handle it =
today
> > > > > > > > off-hand.
> > > > > > >=20
> > > > > > > If the user issues multiple load commands, he can overwrite p=
revious files.
> > > > > >=20
> > > > > > Then it sounds like we lost one benefit of all of this overhead.
> > > > > >=20
> > > > > > > During boot command execution I guess the different allocatio=
ns respect each other.
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > > TFTP is problematic because it does not transfer the file=
size. We would probably try to allocate a large chunk of memory and then do=
wnsize the allocation after reading the whole file.
> > > > > > > >=20
> > > > > > > > Reading from non-filesystem flash also has this problem, bu=
t we at least
> > > > > > > > specify the amount to read too. But yes, it gets back to wh=
at I was
> > > > > > > > asking about on how you're proposing to handle network load=
 cases.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > It depends on the protocol. Http conveys the size before the =
data. Tftp does not.
> > > > > > >=20
> > > > > > > If you don't know the size, you must preallocate a big chunk,=
 check that the download does not exceed it, and downsize the allocation af=
terwards. This is not a new problem but exists already with current lmb usa=
ge.
> > > > > >=20
> > > > > > Yes, and what I'm trying to find out is if what you're suggesti=
ng would
> > > > > > do anything about it, since previous statements you made implie=
d to me
> > > > > > that we would prevent it.
> > > > > >=20
> > > > > > To me, at this point it sounds like what we need is more like p=
ersistent
> > > > > > memory blocks and a hook that can be called in to for both "giv=
e me all
> > > > > > known memory blocks" and "add this memory block to the list", s=
o that
> > > > > > EFI can do whatever it needs to do upon starting an application=
 and then
> > > > > > upon return to U-Boot. Both malloc/free allocations and "load t=
his blob
> > > > > > to memory from whatever" allocations would call the appropriate=
 hook for
> > > > > > tracking.
> > > > >=20
> > > > > In my mind the solution to this entire problem is fairly minor ch=
anges
> > > > > to how memory is allocated and only for EFI.
> > > > >=20
> > > > > I tried to map out what that would look like and we have IMO got =
lost
> > > > > in the weeds a bit.
> > > > >=20
> > > > > I am not trying to solve the problem of the 'load' command doing =
an
> > > > > allocation and throwing it away. To be that is WAI, at least unti=
l we
> > > > > come up with another type of command. This is one of the reasons =
for
> > > > > standard boot, allowing a more cohesive approach to booting.
> > > > >=20
> > > > > I will think about this some more...
> > > >=20
> > > > OK, but please keep in mind that lmb not being at all persistent is=
 a
> > > > problem for everyone, not just EFI. That really needs to be address=
ed,
> > > > maybe with some flags for dis-allowing overwrites to the area. For
> > > > example, the apple-m1 code to use lmb to find locations for the
> > > > kernel/etc can be written to more than once (allocate the address, =
then
> > > > write to it to start with, even) but the range that covers U-Boot i=
tself
> > > > (malloc pool and so forth) need to be stopped.
> > > >=20
> > >=20
> > > The range managed by the EFI sub-system extends over all of RAM
> > > including the addresses used by load commands. Hence, "the range that
> > > covers U-Boot itself (malloc pool and so forth)" includes all memory.
> > >=20
> > > Maybe we could pre-allocate a memory area for file loading. This just
> > > requires to define a device-specific high file memory address above
> > > which no file loads will be allowed and below which EFI, bootm, etc w=
ill
> > > not be allowed to allocate memory for further uses.
> >=20
> > We're not just / only an EFI runtime. When we load something persistent
> > to memory outside of EFI, we need to note that, so that when EFI_LOADER
> > beings work it can see this and do whatever it needs to do. And if/when
> > EFI_LOADER returns control back to U-Boot itself, it needs to update
> > that list with any new allocations that were done and mark them
> > appropriately.
>=20
> The idea of EFI loader returning control is misleading.
>=20
> You can load an EFI driver binary which provides a device to U-Boot.
> Whenever U-Boot accesses that driver allocations might occur.

We cannot, today, load an EFI driver and then make use of it outside of
the context of having bootefi'd something, yes?

Or is this about that separate runtime area from another thread?

But even then, if something is making an allocation it needs to inform
the rest of the world.

> I thought that we already agreed to have only one memory management and
> get rid of the LMB/EFI memory management duplication.

We've agreed that today, CONFIG_LMB does not fit the use cases that we
have in a modern system, for anyones usage. It has been suggested and I
know it's somewhere on Ilias' TODO list, to try and take what we have
in the EFI_LOADER & co area and make it usable and useful for all
contexts. We also have what in some ways feels to me to be the inverse
of that, which is Simon's proposal.

We have not agreed that the EFI model and restrictions are what
everything will now be using. What's on Ilias' TODD list might bring us
in that direction, and I want to see what that looks like in practice.
But it's not agreed to as the end goal here.

And to be clear, I also would like to see what Simon's proposed, in
practice.

--=20
Tom

--hCY00DDlPhh7Qrbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWPACAACgkQFHw5/5Y0
tyxzBQwAmt047vYXeQ3vB80Hxu/pbBXHhCp3mpCFh3Ca5p6r9PLCKOr5c/NCIf4K
5zOwNgbXjuI9qw1opm8A+9veeABCIK0wDkiYRfeq8MoTSKRoffMDXg8Q23xVBwaU
T/ULkyNi243tuhJ7xgDn6YQbtOQt79bj4PF9iCPUiXTv/0cnkTvrTs6S1AvPKOdW
/yscZFf0TAB9zg5jjZ9RoCtznjdYcIplCwI+LtJsoEuyU0L4YzZ4Axpi5bDq/6IE
uVnZsvW1qNlpS0pZB+zeN13AMdBzyYY1vGzB15NycN0HnKhncW823d4YwUI9DLS8
nO07JTL5FS/g6q/Kai4cM+H7sLld178YO/9xhuIHMtXP52j2pwPILDEkPa2FvexA
tM6pfwiDiNqOS/eKHH2RqZsVEt58gui09U/3nYiNHk/v5lxY5YH7TrwvPc8Fk5Pe
GMugq95rmb38AS0tISvLvgqymHeqqq87BCYkD4vxJUlao32dpYo2RBUfz76nYDbI
brt9wYcg
=mfYQ
-----END PGP SIGNATURE-----

--hCY00DDlPhh7Qrbc--
