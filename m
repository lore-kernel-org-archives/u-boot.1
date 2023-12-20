Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF41C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 19:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 607DE87828;
	Wed, 20 Dec 2023 20:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vwm+sM2m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A47BB8781E; Wed, 20 Dec 2023 20:12:25 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A8B287823
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 20:12:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5e811c5c1adso322657b3.2
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 11:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703099541; x=1703704341; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U66yYd5uenOjtKdmj5Irm4oB7AuHrhI50cv22l4UhDw=;
 b=Vwm+sM2mfvI9IrpCuqC15eCdSwnIxPW/9Dm1zwtqfOThjK/VxSkWLhWJ+2wc19GBnE
 khlTp3czIR6+yqpNhRBSI+EZa8nR9+w9iiYiOqBIJwDsPgt0kqsLjdCQwpPEANwgutBO
 CO6elb1YZbKVSFM6nSQYBFs38D81Wehe9QvRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703099541; x=1703704341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U66yYd5uenOjtKdmj5Irm4oB7AuHrhI50cv22l4UhDw=;
 b=maFYU47jMIq2GWgwjs3fZ1JqbeVgtEt8Vdyg19fE+cSnOrSQRa2GLqqQcR4/6WdwoB
 be5KSn/yIxlvwm9Al6qOMt8HsuykEXQY6LeVEjlF2++LE2J6/RymPQ9NoN0EvZPzQsqE
 f62P+vUTozGoTbukfyKW/VFitztUTdGCczhXKprqru9VsH0xNAfUMG4MxWi4eGuVLQgx
 cFMGR9vs2EjRzUCXncNC14Cw0aQVMt0vsq3qguyBAC7aEAKzpfJIsEXnNr5k1Hz2c9yO
 cLG4kBsADhlfB2fPW2D5QeRxKP980m3iBVxMiYdjzE+O/Wnp7Nf1eWxs6yE0xQwK2ycE
 6a4A==
X-Gm-Message-State: AOJu0YyNQ5bs/2ZC+Q/pO/9ECilN9XDAZyalencM2qDqLu0F0sh4ZQnZ
 QZixSByO5E5MCw0xunEErCfvPA==
X-Google-Smtp-Source: AGHT+IFA4gLiGoFe/P4aHe1Oo2FWFdIHphvFGkP4OVHDGTQcZRKQq+TVyhe3ZacCuixWNaYaDN92xQ==
X-Received: by 2002:a0d:d487:0:b0:5d3:b982:57ae with SMTP id
 w129-20020a0dd487000000b005d3b98257aemr250765ywd.4.1703099541269; 
 Wed, 20 Dec 2023 11:12:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 p84-20020a0de657000000b005e1a5593c0csm150285ywe.60.2023.12.20.11.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 11:12:20 -0800 (PST)
Date: Wed, 20 Dec 2023 14:12:19 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Proposal: U-Boot memory management
Message-ID: <20231220191219.GP2513409@bill-the-cat>
References: <20231218224108.GN2513409@bill-the-cat>
 <3DAFAD12-98E4-46CC-B02E-E8EE40D57AC3@gmx.de>
 <20231218231640.GO2513409@bill-the-cat>
 <058AE676-FD71-4DEB-AEB3-0C805B74E8EE@gmx.de>
 <20231218233130.GP2513409@bill-the-cat>
 <688C13A3-9C5F-4A39-9F8F-54C2E8D08EE8@gmx.de>
 <20231219012600.GQ2513409@bill-the-cat>
 <E0572546-90AA-41C4-8433-EF02BB12E434@gmx.de>
 <20231219124553.GS2513409@bill-the-cat>
 <CAPnjgZ1SUoRKEWaK6k1rrVN4t0WLD24GGeRj7uer3A0XA_MKoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vNH3w7riGpuGyrWd"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1SUoRKEWaK6k1rrVN4t0WLD24GGeRj7uer3A0XA_MKoA@mail.gmail.com>
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


--vNH3w7riGpuGyrWd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 09:15:21PM -0700, Simon Glass wrote:
> Hi,
>=20
> On Tue, 19 Dec 2023 at 05:46, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Dec 19, 2023 at 03:15:38AM +0100, Heinrich Schuchardt wrote:
> > >
> > >
> > > Am 19. Dezember 2023 02:26:00 MEZ schrieb Tom Rini <trini@konsulko.co=
m>:
> > > >On Tue, Dec 19, 2023 at 01:01:51AM +0100, Heinrich Schuchardt wrote:
> > > >>
> > > >>
> > > >> Am 19. Dezember 2023 00:31:30 MEZ schrieb Tom Rini <trini@konsulko=
=2Ecom>:
> > > >> >On Tue, Dec 19, 2023 at 12:29:19AM +0100, Heinrich Schuchardt wro=
te:
> > > >> >>
> > > >> >>
> > > >> >> Am 19. Dezember 2023 00:16:40 MEZ schrieb Tom Rini <trini@konsu=
lko.com>:
> > > >> >> >On Tue, Dec 19, 2023 at 12:08:31AM +0100, Heinrich Schuchardt =
wrote:
> > > >> >> >>
> > > >> >> >>
> > > >> >> >> Am 18. Dezember 2023 23:41:08 MEZ schrieb Tom Rini <trini@ko=
nsulko.com>:
> > > >> >> >> >On Mon, Dec 18, 2023 at 11:34:16PM +0100, Heinrich Schuchar=
dt wrote:
> > > >> >> >> >
> > > >> >> >> >[snip]
> > > >> >> >> >> Or take:
> > > >> >> >> >>
> > > >> >> >> >> load host 0:1 $c kernel.efi
> > > >> >> >> >> load host 0:1 $d initrd.img
> > > >> >> >> >>
> > > >> >> >> >> How could we ensure that initrd.img is not overwriting a =
part of kernel.efi without memory allocation?
> > > >> >> >> >
> > > >> >> >> >Today, invalid checksum as part of some part of the kernel =
fails. But
> > > >> >> >> >how do we do this tomorrow, are you suggesting that "load" =
perform
> > > >> >> >> >malloc() in some predefined size? If $c is below $d and $c =
+ kernel.efi
> > > >> >> >> >is now above $d we can throw an error before trying to load=
, yes. But
> > > >> >> >> >what about:
> > > >> >> >> >load host 0:1 $d initrd.img
> > > >> >> >> >load host 0:1 $c kernel.efi
> > > >> >> >> >
> > > >> >> >> >In that case (which is only marginally contrived, the more =
real case is
> > > >> >> >> >loading device tree in to unexpectedly large ramdisk becaus=
e someone
> > > >> >> >> >didn't understand the general advice on why device tree is =
lower than
> > > >> >> >> >ramdisk address) I'm fine with an error that amounts to "yo=
u just
> > > >> >> >> >corrupted another allocation" and then "fail, reset the boa=
rd" or so.
> > > >> >> >> >
> > > >> >> >>
> > > >> >> >> Our current malloc library cannot manage the complete memory=
=2E We need a library like lmb which should also cover the memory managemen=
t that we currently have in lib/efi/efi_memory.c. This must include a memor=
y type attribute for usage in the GetMemoryMap() service. A management on p=
age level seems sufficient.
> > > >> >> >>
> > > >> >> >> The load command should permanently allocate memory in that =
lmb+ library.
> > > >> >> >>
> > > >> >> >> We need an unload command to free the memory if we want to r=
euse the memory or we might let the load comand free the memory if exactly =
the same start address is reused.
> > > >> >> >
> > > >> >> >Our current way of loading things in to memory does not handle=
 the case
> > > >> >> >I described, yes. How would what you're proposing handle it?
> > > >> >>
> > > >> >> If the load command has to allocate memory for the image and th=
at allocation is kept, any attempt to allocate overlapping memory would fai=
l.
> > > >> >
> > > >> >So you're saying that the load command has to pre-allocate memory=
? Or as
> > > >> >it goes? If the latter, in what size chunks? This starts to get a=
t what
> > > >> >Simon was talking about with respect to memory fragmentation. Whi=
ch to
> > > >> >be clear is a problem we have today, we just let things overlap a=
nd hope
> > > >> >something later catches an incorrect checksum.
> > > >> >
> > > >>
> > > >> I don't want to replace the malloc library which handles large num=
bets of allocations.
> > > >
> > > >I'm confused. The normal malloc library is not involved with current
> > > >image loading, it's direct to memory (with some attempts at sanity
> > > >checking by lmb).  Are you proposing a different allocator with
> > > >malloc/free like behavior? If so, please outline how it will determi=
ne
> > > >pool size, and how we'll use it to load thing to memory.
> > >
> > > All memory below the stack needs to be managed. Malloc uses a small m=
emory area (a few MiB) above the stack.
> >
> > That's a rather huge change for how U-Boot works.
> >
> > > >> Closing the eyes when the user loads multiple files does not solve=
 the fragmentation problem.
> > > >
> > > >Yes. I'm only noting that today we just ignore the problem and somet=
imes
> > > >catch it via checksums.
> > > >
> > > >> Fragmentation only happens if we have many concurrent allocations.=
  In EFI we are allocating top down. The number of concurrent allocations i=
s low. Typically a few dozen at most. After terminating an application thes=
e should be freed again.
> > > >
> > > >OK, so are you saying that we would no longer be loading _to_ a loca=
tion
> > > >in memory and instead just be saying "load this thing" and picking w=
here
> > > >dynamically?
> > >
> > > Both preassigned and allocator assigned adresses are compatible with =
memory management.
> > >
> > > Architectures and binaries have different requirements. On riscv64 yo=
u can load Linux kernel, initrd, fdt anywhere. We don't need predefined add=
resses there. Other architectures have restrictions.
> >
> > Yes, 64 bit architecture tend to only have alignment requirements while
> > 32bit architectures have both alignment requirements and some memory
> > window requirement. Whatever we implement here needs to handle both
> > cases.
> >
> > > >> When loading a file from a file system we know the filesize before=
hand. So allocation is trivial.
> > > >>
> > > >> The loady command currently does not use the  offered size informa=
tion but could do so.
> > > >
> > > >We should be using that information to make sure we don't overwrite
> > > >U-Boot itself, but I don't recall how exactly we handle it today
> > > >off-hand.
> > >
> > > If the user issues multiple load commands, he can overwrite previous =
files.
> >
> > Then it sounds like we lost one benefit of all of this overhead.
> >
> > > During boot command execution I guess the different allocations respe=
ct each other.
> > >
> > > >
> > > >> TFTP is problematic because it does not transfer the filesize. We =
would probably try to allocate a large chunk of memory and then downsize th=
e allocation after reading the whole file.
> > > >
> > > >Reading from non-filesystem flash also has this problem, but we at l=
east
> > > >specify the amount to read too. But yes, it gets back to what I was
> > > >asking about on how you're proposing to handle network load cases.
> > > >
> > >
> > > It depends on the protocol. Http conveys the size before the data. Tf=
tp does not.
> > >
> > > If you don't know the size, you must preallocate a big chunk, check t=
hat the download does not exceed it, and downsize the allocation afterwards=
=2E This is not a new problem but exists already with current lmb usage.
> >
> > Yes, and what I'm trying to find out is if what you're suggesting would
> > do anything about it, since previous statements you made implied to me
> > that we would prevent it.
> >
> > To me, at this point it sounds like what we need is more like persistent
> > memory blocks and a hook that can be called in to for both "give me all
> > known memory blocks" and "add this memory block to the list", so that
> > EFI can do whatever it needs to do upon starting an application and then
> > upon return to U-Boot. Both malloc/free allocations and "load this blob
> > to memory from whatever" allocations would call the appropriate hook for
> > tracking.
>=20
> In my mind the solution to this entire problem is fairly minor changes
> to how memory is allocated and only for EFI.
>=20
> I tried to map out what that would look like and we have IMO got lost
> in the weeds a bit.
>=20
> I am not trying to solve the problem of the 'load' command doing an
> allocation and throwing it away. To be that is WAI, at least until we
> come up with another type of command. This is one of the reasons for
> standard boot, allowing a more cohesive approach to booting.
>=20
> I will think about this some more...

OK, but please keep in mind that lmb not being at all persistent is a
problem for everyone, not just EFI. That really needs to be addressed,
maybe with some flags for dis-allowing overwrites to the area. For
example, the apple-m1 code to use lmb to find locations for the
kernel/etc can be written to more than once (allocate the address, then
write to it to start with, even) but the range that covers U-Boot itself
(malloc pool and so forth) need to be stopped.

--=20
Tom

--vNH3w7riGpuGyrWd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDPJMACgkQFHw5/5Y0
tyzllAv/Wf7rOfRrGPVuWVPaai+8idcYNBkrB7a5JbJ+UIBtQyGCHDGnrcEXeffV
gE4a/udUtopMeaPUTEi+jTTns2qcqEWHCoul2TENJPdU9Wps6FNaMg26usQ44zJa
r6caoVv2J6HEA5/l01UZCFYgp6P0KZX8NdJUfu3GaSRLyLah0gHEdIzsZoxI+HRH
f4zyp7bIffVW6og9QDRjGKV1+SWjMXFawkrA5DvVVnAXIzmF0kOFGAUd8Og4Yuyb
CaKvQcY52gw3yuWpK7hbP/5s5twjznMEJPkZPVcoLrFPU5viCc+3LiqZhDEPuLUO
njw3jvLA06n6UpVympHtahpv5MUFGLqLxJYBAdhXqroN2KHXLK+3jBvODUxFcY2Z
gHh6T9x0Rf8zCpOAkB9RvwCLo8iEPrqGNO0/LygVTpXi5DkZ3FHBhQvN7aSKR0EI
QPCG3MXNGpR6WkabXzbMcmn8OBmgIRA/fgADde7USKIIsoegKBZGmJocugUA4mlB
9/OKnoic
=jTJV
-----END PGP SIGNATURE-----

--vNH3w7riGpuGyrWd--
