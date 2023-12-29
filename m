Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC16AC47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 16:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07AAE87A54;
	Fri, 29 Dec 2023 17:47:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AVQ+7V9+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D29087B58; Fri, 29 Dec 2023 17:47:31 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F02C87A3D
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 17:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5edf3780534so26620347b3.0
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 08:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703868447; x=1704473247; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8x3qPsLTS5SGDkrMbqTYEra0uhf5ny3LLWbel+iOFYg=;
 b=AVQ+7V9+Wp2AQVR86/5jb2f/26L44AoBk8ttQw1elq3u5MTAwG5NJrdTEE/SlKE3Sa
 zrYTglT0oq/jnq0BWZMxM62kichBYqEHU6D64c5t9gPJ1TJgYu4X32WcZlLwAAA4T78i
 FdkTdbuF8UnIiNTylf8pkoIR3NQ/i8fexWY7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703868447; x=1704473247;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8x3qPsLTS5SGDkrMbqTYEra0uhf5ny3LLWbel+iOFYg=;
 b=OW/2Tn8cfLuAO5q+bj/kqRCgC3Ql+3eUJGwXnMVbYvbGzGSo/AqWJtglJst7eG3ORF
 JbCBdP3Ao9mC5t76YfXhKHepZ2pguK0L0c7fttUKbruSgWQ5zF4KpYU5DR94QtqUDqDA
 n194iY8EWpRFYzis2zITbviQuBhOYxPCoXTklS7PCAg2cpzCvQw1o+b0jiWVYdbtlXEr
 8qeiFFKRFeng0QypMuNx6bTO1E0i2bolHwwb4J/1O8hjWSmur34fWvwa+8lDbSfdT3zk
 m0qVGxAbG6wkzX0/1gagsoWky1aHtBwELf9STZaZJAro+xtu1HY9kOXc5nHUoo+fYnu6
 Ubdg==
X-Gm-Message-State: AOJu0YzPBO71omnHJogqCF6TiD/YnXokIMfT4sivD5Qs3mLF2c4tH21J
 +z0BwpBKmybEkGLtdAB6N0wxHd98CtbAsQ==
X-Google-Smtp-Source: AGHT+IGq2gHJBdvtBawp4DfCWtXS5ldV2YXGI9zhCtV2MsWjo2QveePENItZnLcdGh2d7p1BxrcuTQ==
X-Received: by 2002:a0d:f6c2:0:b0:5d7:1941:357b with SMTP id
 g185-20020a0df6c2000000b005d71941357bmr8311480ywf.98.1703868446923; 
 Fri, 29 Dec 2023 08:47:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 h187-20020a0ddec4000000b005a4da74b869sm8678087ywe.139.2023.12.29.08.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 08:47:26 -0800 (PST)
Date: Fri, 29 Dec 2023 11:47:24 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: Proposal: U-Boot memory management
Message-ID: <20231229164724.GV2652760@bill-the-cat>
References: <20231218231640.GO2513409@bill-the-cat>
 <058AE676-FD71-4DEB-AEB3-0C805B74E8EE@gmx.de>
 <20231218233130.GP2513409@bill-the-cat>
 <688C13A3-9C5F-4A39-9F8F-54C2E8D08EE8@gmx.de>
 <20231219012600.GQ2513409@bill-the-cat>
 <E0572546-90AA-41C4-8433-EF02BB12E434@gmx.de>
 <20231219124553.GS2513409@bill-the-cat>
 <CAPnjgZ1SUoRKEWaK6k1rrVN4t0WLD24GGeRj7uer3A0XA_MKoA@mail.gmail.com>
 <20231220191219.GP2513409@bill-the-cat>
 <be5fb3fc-2ac9-41ae-a1b5-c08441b1cbe2@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9V5XtQMoPxeyu06X"
Content-Disposition: inline
In-Reply-To: <be5fb3fc-2ac9-41ae-a1b5-c08441b1cbe2@gmx.de>
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


--9V5XtQMoPxeyu06X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 05:42:17PM +0100, Heinrich Schuchardt wrote:
> On 12/20/23 20:12, Tom Rini wrote:
> > On Tue, Dec 19, 2023 at 09:15:21PM -0700, Simon Glass wrote:
> > > Hi,
> > >=20
> > > On Tue, 19 Dec 2023 at 05:46, Tom Rini <trini@konsulko.com> wrote:
> > > >=20
> > > > On Tue, Dec 19, 2023 at 03:15:38AM +0100, Heinrich Schuchardt wrote:
> > > > >=20
> > > > >=20
> > > > > Am 19. Dezember 2023 02:26:00 MEZ schrieb Tom Rini <trini@konsulk=
o.com>:
> > > > > > On Tue, Dec 19, 2023 at 01:01:51AM +0100, Heinrich Schuchardt w=
rote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > Am 19. Dezember 2023 00:31:30 MEZ schrieb Tom Rini <trini@kon=
sulko.com>:
> > > > > > > > On Tue, Dec 19, 2023 at 12:29:19AM +0100, Heinrich Schuchar=
dt wrote:
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Am 19. Dezember 2023 00:16:40 MEZ schrieb Tom Rini <trini=
@konsulko.com>:
> > > > > > > > > > On Tue, Dec 19, 2023 at 12:08:31AM +0100, Heinrich Schu=
chardt wrote:
> > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > Am 18. Dezember 2023 23:41:08 MEZ schrieb Tom Rini <t=
rini@konsulko.com>:
> > > > > > > > > > > > On Mon, Dec 18, 2023 at 11:34:16PM +0100, Heinrich =
Schuchardt wrote:
> > > > > > > > > > > >=20
> > > > > > > > > > > > [snip]
> > > > > > > > > > > > > Or take:
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > load host 0:1 $c kernel.efi
> > > > > > > > > > > > > load host 0:1 $d initrd.img
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > How could we ensure that initrd.img is not overwr=
iting a part of kernel.efi without memory allocation?
> > > > > > > > > > > >=20
> > > > > > > > > > > > Today, invalid checksum as part of some part of the=
 kernel fails. But
> > > > > > > > > > > > how do we do this tomorrow, are you suggesting that=
 "load" perform
> > > > > > > > > > > > malloc() in some predefined size? If $c is below $d=
 and $c + kernel.efi
> > > > > > > > > > > > is now above $d we can throw an error before trying=
 to load, yes. But
> > > > > > > > > > > > what about:
> > > > > > > > > > > > load host 0:1 $d initrd.img
> > > > > > > > > > > > load host 0:1 $c kernel.efi
> > > > > > > > > > > >=20
> > > > > > > > > > > > In that case (which is only marginally contrived, t=
he more real case is
> > > > > > > > > > > > loading device tree in to unexpectedly large ramdis=
k because someone
> > > > > > > > > > > > didn't understand the general advice on why device =
tree is lower than
> > > > > > > > > > > > ramdisk address) I'm fine with an error that amount=
s to "you just
> > > > > > > > > > > > corrupted another allocation" and then "fail, reset=
 the board" or so.
> > > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > Our current malloc library cannot manage the complete=
 memory. We need a library like lmb which should also cover the memory mana=
gement that we currently have in lib/efi/efi_memory.c. This must include a =
memory type attribute for usage in the GetMemoryMap() service. A management=
 on page level seems sufficient.
> > > > > > > > > > >=20
> > > > > > > > > > > The load command should permanently allocate memory i=
n that lmb+ library.
> > > > > > > > > > >=20
> > > > > > > > > > > We need an unload command to free the memory if we wa=
nt to reuse the memory or we might let the load comand free the memory if e=
xactly the same start address is reused.
> > > > > > > > > >=20
> > > > > > > > > > Our current way of loading things in to memory does not=
 handle the case
> > > > > > > > > > I described, yes. How would what you're proposing handl=
e it?
> > > > > > > > >=20
> > > > > > > > > If the load command has to allocate memory for the image =
and that allocation is kept, any attempt to allocate overlapping memory wou=
ld fail.
> > > > > > > >=20
> > > > > > > > So you're saying that the load command has to pre-allocate =
memory? Or as
> > > > > > > > it goes? If the latter, in what size chunks? This starts to=
 get at what
> > > > > > > > Simon was talking about with respect to memory fragmentatio=
n. Which to
> > > > > > > > be clear is a problem we have today, we just let things ove=
rlap and hope
> > > > > > > > something later catches an incorrect checksum.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > I don't want to replace the malloc library which handles larg=
e numbets of allocations.
> > > > > >=20
> > > > > > I'm confused. The normal malloc library is not involved with cu=
rrent
> > > > > > image loading, it's direct to memory (with some attempts at san=
ity
> > > > > > checking by lmb).  Are you proposing a different allocator with
> > > > > > malloc/free like behavior? If so, please outline how it will de=
termine
> > > > > > pool size, and how we'll use it to load thing to memory.
> > > > >=20
> > > > > All memory below the stack needs to be managed. Malloc uses a sma=
ll memory area (a few MiB) above the stack.
> > > >=20
> > > > That's a rather huge change for how U-Boot works.
> > > >=20
> > > > > > > Closing the eyes when the user loads multiple files does not =
solve the fragmentation problem.
> > > > > >=20
> > > > > > Yes. I'm only noting that today we just ignore the problem and =
sometimes
> > > > > > catch it via checksums.
> > > > > >=20
> > > > > > > Fragmentation only happens if we have many concurrent allocat=
ions.  In EFI we are allocating top down. The number of concurrent allocati=
ons is low. Typically a few dozen at most. After terminating an application=
 these should be freed again.
> > > > > >=20
> > > > > > OK, so are you saying that we would no longer be loading _to_ a=
 location
> > > > > > in memory and instead just be saying "load this thing" and pick=
ing where
> > > > > > dynamically?
> > > > >=20
> > > > > Both preassigned and allocator assigned adresses are compatible w=
ith memory management.
> > > > >=20
> > > > > Architectures and binaries have different requirements. On riscv6=
4 you can load Linux kernel, initrd, fdt anywhere. We don't need predefined=
 addresses there. Other architectures have restrictions.
> > > >=20
> > > > Yes, 64 bit architecture tend to only have alignment requirements w=
hile
> > > > 32bit architectures have both alignment requirements and some memory
> > > > window requirement. Whatever we implement here needs to handle both
> > > > cases.
> > > >=20
> > > > > > > When loading a file from a file system we know the filesize b=
eforehand. So allocation is trivial.
> > > > > > >=20
> > > > > > > The loady command currently does not use the  offered size in=
formation but could do so.
> > > > > >=20
> > > > > > We should be using that information to make sure we don't overw=
rite
> > > > > > U-Boot itself, but I don't recall how exactly we handle it today
> > > > > > off-hand.
> > > > >=20
> > > > > If the user issues multiple load commands, he can overwrite previ=
ous files.
> > > >=20
> > > > Then it sounds like we lost one benefit of all of this overhead.
> > > >=20
> > > > > During boot command execution I guess the different allocations r=
espect each other.
> > > > >=20
> > > > > >=20
> > > > > > > TFTP is problematic because it does not transfer the filesize=
=2E We would probably try to allocate a large chunk of memory and then down=
size the allocation after reading the whole file.
> > > > > >=20
> > > > > > Reading from non-filesystem flash also has this problem, but we=
 at least
> > > > > > specify the amount to read too. But yes, it gets back to what I=
 was
> > > > > > asking about on how you're proposing to handle network load cas=
es.
> > > > > >=20
> > > > >=20
> > > > > It depends on the protocol. Http conveys the size before the data=
=2E Tftp does not.
> > > > >=20
> > > > > If you don't know the size, you must preallocate a big chunk, che=
ck that the download does not exceed it, and downsize the allocation afterw=
ards. This is not a new problem but exists already with current lmb usage.
> > > >=20
> > > > Yes, and what I'm trying to find out is if what you're suggesting w=
ould
> > > > do anything about it, since previous statements you made implied to=
 me
> > > > that we would prevent it.
> > > >=20
> > > > To me, at this point it sounds like what we need is more like persi=
stent
> > > > memory blocks and a hook that can be called in to for both "give me=
 all
> > > > known memory blocks" and "add this memory block to the list", so th=
at
> > > > EFI can do whatever it needs to do upon starting an application and=
 then
> > > > upon return to U-Boot. Both malloc/free allocations and "load this =
blob
> > > > to memory from whatever" allocations would call the appropriate hoo=
k for
> > > > tracking.
> > >=20
> > > In my mind the solution to this entire problem is fairly minor changes
> > > to how memory is allocated and only for EFI.
> > >=20
> > > I tried to map out what that would look like and we have IMO got lost
> > > in the weeds a bit.
> > >=20
> > > I am not trying to solve the problem of the 'load' command doing an
> > > allocation and throwing it away. To be that is WAI, at least until we
> > > come up with another type of command. This is one of the reasons for
> > > standard boot, allowing a more cohesive approach to booting.
> > >=20
> > > I will think about this some more...
> >=20
> > OK, but please keep in mind that lmb not being at all persistent is a
> > problem for everyone, not just EFI. That really needs to be addressed,
> > maybe with some flags for dis-allowing overwrites to the area. For
> > example, the apple-m1 code to use lmb to find locations for the
> > kernel/etc can be written to more than once (allocate the address, then
> > write to it to start with, even) but the range that covers U-Boot itself
> > (malloc pool and so forth) need to be stopped.
> >=20
>=20
> The range managed by the EFI sub-system extends over all of RAM
> including the addresses used by load commands. Hence, "the range that
> covers U-Boot itself (malloc pool and so forth)" includes all memory.
>=20
> Maybe we could pre-allocate a memory area for file loading. This just
> requires to define a device-specific high file memory address above
> which no file loads will be allowed and below which EFI, bootm, etc will
> not be allowed to allocate memory for further uses.

We're not just / only an EFI runtime. When we load something persistent
to memory outside of EFI, we need to note that, so that when EFI_LOADER
beings work it can see this and do whatever it needs to do. And if/when
EFI_LOADER returns control back to U-Boot itself, it needs to update
that list with any new allocations that were done and mark them
appropriately. The user gets full memory minus a bit, to do with as they
need for their use case.

--=20
Tom

--9V5XtQMoPxeyu06X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWO+BUACgkQFHw5/5Y0
tyz1rgv/eiU7fBMZXzvQP4pwVJhJhDge5FLQRLbxG84sOkWNFEHWqPyP3/wRO/HW
g6sXAGo4ZCaiZg7akpHnnlVKocUrUYF0dKSXuRuz8c0JSRRKlGXw20+b+Mc8cn4W
eDpAZn1JErB8Nca64arRQ4eiLVWqKNI1hX5svQTA+Ap1x8Ba2qQuvdAgcWMF4co6
jPd1JCp0Vrl5zez9XIjLOm8igQykN/+Fnk6xxR9XmwHteKF0jU06HQ1IH7Jt/NH7
eBiIma95bUgT3rvAcPWksol80OGQdxbiy0H2PEufUR7KvMvVeG5heYPbRVXEPC/U
tYebEk3CIzKx1Hu4G6/1Eq3f1zQOx8xfex2tSYqsdm6mrdOq9sa/O3Xj3InSpeLp
HOeD41jtQCVRihSTKqTtjBenPOBNrcpkFTKYBFv1GVHdttV9l8mdIn/O0r0Q1S8+
wO9eXq5AsYFVB12/rl6+G10z0HVLnwFj/+PiO/5pAPUZgg50MvU3m2YbxjVhHPRw
wAiBVQgX
=Jvx+
-----END PGP SIGNATURE-----

--9V5XtQMoPxeyu06X--
