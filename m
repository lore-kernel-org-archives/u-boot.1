Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F081C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 12:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 898CE874F6;
	Tue, 19 Dec 2023 13:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CxsWnvZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CC14874F6; Tue, 19 Dec 2023 13:46:02 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A5A874FB
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 13:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5e784ce9bb8so7256387b3.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 04:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702989956; x=1703594756; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iAUDsFATvJWG7lNFMZwepgO/JrDOn3J+Enh/f44VEqE=;
 b=CxsWnvZmRtA2fgPV3b95HsoSdhQbuqY15Qnqm/Qk6QxSLWYzrk8Pr+URbidDe2/Bic
 BeNIH7y4rcN1cfScVEqW37a7t8lIFK5XLxjW0uAFIPnPI91EORlrTwwpvw/GHs4qp2qo
 MCiO3Ys/71gcuVhki8e8KdlJGJRHELzzQdmZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702989956; x=1703594756;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAUDsFATvJWG7lNFMZwepgO/JrDOn3J+Enh/f44VEqE=;
 b=AhzJ5nJnjTsY5mFgrFAR6JYp6yxAdFYsshJVUvTd8Chy027w6fj9tE2EVeHF0sh+JP
 uSPs7jubBRG6NHRxf9lc7g0gBII/p/l7G4OlV1Rd2MYAGRG/5THuU9GQZ11bBC7YMcEo
 YkoCjPXY6sM82ydU1ThuxMR0/6w+dLWyRSjZva3uK5BlguNDHGu+xbrc1+nRF8LwoYWO
 /egJFA+anc1HbtjzIsqnBV6iNghKhuQZ8TDuVOir6U5h7EzTFbBDqnnw069laCZY/jBp
 OuosE52keUKOquV7BZSXPyI2sLvdOHjsKmRCrtSX9YCuGoKIOnaasCDkTJzSSr4YRISu
 wLuw==
X-Gm-Message-State: AOJu0YyOPnVJRH0Xy0TDr9c1jOubrFfQu6/86rdMnGBjwD/ACzpywSur
 GdKlcPYor01lYVJ+OrjM9uPF/rsUZEyMEQ==
X-Google-Smtp-Source: AGHT+IEB0patupuXTbCvSTHSbeQpYUDMcT525AsKv89F0tJUPZUtVslzvpK4iAqm9Zter9c6sFTGhA==
X-Received: by 2002:a0d:d711:0:b0:5cc:69df:7cf with SMTP id
 z17-20020a0dd711000000b005cc69df07cfmr486633ywd.14.1702989956485; 
 Tue, 19 Dec 2023 04:45:56 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 dt16-20020a05690c251000b005e57b03477asm2693587ywb.140.2023.12.19.04.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 04:45:55 -0800 (PST)
Date: Tue, 19 Dec 2023 07:45:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Proposal: U-Boot memory management
Message-ID: <20231219124553.GS2513409@bill-the-cat>
References: <CAPnjgZ1=JBEh49G654DfkYM-fcOEhwh=Xuu1scXTLsNkZk2SNQ@mail.gmail.com>
 <DEECD6D4-58C6-4032-BBF9-28A65B9096DD@gmx.de>
 <20231218224108.GN2513409@bill-the-cat>
 <3DAFAD12-98E4-46CC-B02E-E8EE40D57AC3@gmx.de>
 <20231218231640.GO2513409@bill-the-cat>
 <058AE676-FD71-4DEB-AEB3-0C805B74E8EE@gmx.de>
 <20231218233130.GP2513409@bill-the-cat>
 <688C13A3-9C5F-4A39-9F8F-54C2E8D08EE8@gmx.de>
 <20231219012600.GQ2513409@bill-the-cat>
 <E0572546-90AA-41C4-8433-EF02BB12E434@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s5TcPYhLtyCJ1SP8"
Content-Disposition: inline
In-Reply-To: <E0572546-90AA-41C4-8433-EF02BB12E434@gmx.de>
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


--s5TcPYhLtyCJ1SP8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 03:15:38AM +0100, Heinrich Schuchardt wrote:
>=20
>=20
> Am 19. Dezember 2023 02:26:00 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >On Tue, Dec 19, 2023 at 01:01:51AM +0100, Heinrich Schuchardt wrote:
> >>=20
> >>=20
> >> Am 19. Dezember 2023 00:31:30 MEZ schrieb Tom Rini <trini@konsulko.com=
>:
> >> >On Tue, Dec 19, 2023 at 12:29:19AM +0100, Heinrich Schuchardt wrote:
> >> >>=20
> >> >>=20
> >> >> Am 19. Dezember 2023 00:16:40 MEZ schrieb Tom Rini <trini@konsulko.=
com>:
> >> >> >On Tue, Dec 19, 2023 at 12:08:31AM +0100, Heinrich Schuchardt wrot=
e:
> >> >> >>=20
> >> >> >>=20
> >> >> >> Am 18. Dezember 2023 23:41:08 MEZ schrieb Tom Rini <trini@konsul=
ko.com>:
> >> >> >> >On Mon, Dec 18, 2023 at 11:34:16PM +0100, Heinrich Schuchardt w=
rote:
> >> >> >> >
> >> >> >> >[snip]
> >> >> >> >> Or take:
> >> >> >> >>=20
> >> >> >> >> load host 0:1 $c kernel.efi
> >> >> >> >> load host 0:1 $d initrd.img
> >> >> >> >>=20
> >> >> >> >> How could we ensure that initrd.img is not overwriting a part=
 of kernel.efi without memory allocation?
> >> >> >> >
> >> >> >> >Today, invalid checksum as part of some part of the kernel fail=
s. But
> >> >> >> >how do we do this tomorrow, are you suggesting that "load" perf=
orm
> >> >> >> >malloc() in some predefined size? If $c is below $d and $c + ke=
rnel.efi
> >> >> >> >is now above $d we can throw an error before trying to load, ye=
s. But
> >> >> >> >what about:
> >> >> >> >load host 0:1 $d initrd.img
> >> >> >> >load host 0:1 $c kernel.efi
> >> >> >> >
> >> >> >> >In that case (which is only marginally contrived, the more real=
 case is
> >> >> >> >loading device tree in to unexpectedly large ramdisk because so=
meone
> >> >> >> >didn't understand the general advice on why device tree is lowe=
r than
> >> >> >> >ramdisk address) I'm fine with an error that amounts to "you ju=
st
> >> >> >> >corrupted another allocation" and then "fail, reset the board" =
or so.
> >> >> >> >
> >> >> >>=20
> >> >> >> Our current malloc library cannot manage the complete memory. We=
 need a library like lmb which should also cover the memory management that=
 we currently have in lib/efi/efi_memory.c. This must include a memory type=
 attribute for usage in the GetMemoryMap() service. A management on page le=
vel seems sufficient.
> >> >> >>=20
> >> >> >> The load command should permanently allocate memory in that lmb+=
 library.
> >> >> >>=20
> >> >> >> We need an unload command to free the memory if we want to reuse=
 the memory or we might let the load comand free the memory if exactly the =
same start address is reused.
> >> >> >
> >> >> >Our current way of loading things in to memory does not handle the=
 case
> >> >> >I described, yes. How would what you're proposing handle it?
> >> >>=20
> >> >> If the load command has to allocate memory for the image and that a=
llocation is kept, any attempt to allocate overlapping memory would fail.
> >> >
> >> >So you're saying that the load command has to pre-allocate memory? Or=
 as
> >> >it goes? If the latter, in what size chunks? This starts to get at wh=
at
> >> >Simon was talking about with respect to memory fragmentation. Which to
> >> >be clear is a problem we have today, we just let things overlap and h=
ope
> >> >something later catches an incorrect checksum.
> >> >
> >>=20
> >> I don't want to replace the malloc library which handles large numbets=
 of allocations.
> >
> >I'm confused. The normal malloc library is not involved with current
> >image loading, it's direct to memory (with some attempts at sanity
> >checking by lmb).  Are you proposing a different allocator with
> >malloc/free like behavior? If so, please outline how it will determine
> >pool size, and how we'll use it to load thing to memory.
>=20
> All memory below the stack needs to be managed. Malloc uses a small memor=
y area (a few MiB) above the stack.

That's a rather huge change for how U-Boot works.

> >> Closing the eyes when the user loads multiple files does not solve the=
 fragmentation problem.
> >
> >Yes. I'm only noting that today we just ignore the problem and sometimes
> >catch it via checksums.
> >
> >> Fragmentation only happens if we have many concurrent allocations.  In=
 EFI we are allocating top down. The number of concurrent allocations is lo=
w. Typically a few dozen at most. After terminating an application these sh=
ould be freed again.
> >
> >OK, so are you saying that we would no longer be loading _to_ a location
> >in memory and instead just be saying "load this thing" and picking where
> >dynamically?
>=20
> Both preassigned and allocator assigned adresses are compatible with memo=
ry management.
>=20
> Architectures and binaries have different requirements. On riscv64 you ca=
n load Linux kernel, initrd, fdt anywhere. We don't need predefined address=
es there. Other architectures have restrictions.

Yes, 64 bit architecture tend to only have alignment requirements while
32bit architectures have both alignment requirements and some memory
window requirement. Whatever we implement here needs to handle both
cases.

> >> When loading a file from a file system we know the filesize beforehand=
=2E So allocation is trivial.
> >>=20
> >> The loady command currently does not use the  offered size information=
 but could do so.
> >
> >We should be using that information to make sure we don't overwrite
> >U-Boot itself, but I don't recall how exactly we handle it today
> >off-hand.
>=20
> If the user issues multiple load commands, he can overwrite previous file=
s.

Then it sounds like we lost one benefit of all of this overhead.

> During boot command execution I guess the different allocations respect e=
ach other.
>=20
> >
> >> TFTP is problematic because it does not transfer the filesize. We woul=
d probably try to allocate a large chunk of memory and then downsize the al=
location after reading the whole file.
> >
> >Reading from non-filesystem flash also has this problem, but we at least
> >specify the amount to read too. But yes, it gets back to what I was
> >asking about on how you're proposing to handle network load cases.
> >
>=20
> It depends on the protocol. Http conveys the size before the data. Tftp d=
oes not.
>=20
> If you don't know the size, you must preallocate a big chunk, check that =
the download does not exceed it, and downsize the allocation afterwards. Th=
is is not a new problem but exists already with current lmb usage.

Yes, and what I'm trying to find out is if what you're suggesting would
do anything about it, since previous statements you made implied to me
that we would prevent it.

To me, at this point it sounds like what we need is more like persistent
memory blocks and a hook that can be called in to for both "give me all
known memory blocks" and "add this memory block to the list", so that
EFI can do whatever it needs to do upon starting an application and then
upon return to U-Boot. Both malloc/free allocations and "load this blob
to memory from whatever" allocations would call the appropriate hook for
tracking.

--=20
Tom

--s5TcPYhLtyCJ1SP8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWBkHoACgkQFHw5/5Y0
tyzE0wv/amhn8ScIPPEqw3M4Hwy/9LmEK3LawFiDUOZrK4kCT3yLyduJAe6W9JkJ
5CkKmeGrqGTUJCsLzRndbTOO4AKN9RV6fcSgGaLLmbWT4Bohvxb7LjtJ0WwufBvT
78gOOeOMAmhg9Wvh5ewnL87FSLsBzURtsGCT6109ogDdWliIhD6JjlZEuuSz2Xmm
y53gOfcVjUlojXaIoyEqze8/HJCbu8nsVdRULPtUt1VSGm4mrffqAIv8DTEXjyvd
hzghe6tisdf8n8Zyym9HuWxU63L69A8bj39PvGzQ/3OksFlWl8d0EqEwEGFriLgU
9DX09Zia0OEsjpuaWlqnFvzSqMzRg9J6dainMLW1+mkF6pmjmujwL2EZA72+xTTC
Ueb1yZn7PaUizLwbiAjcdeFM4rodKM2wdj4F3jHBDcu3U1O6dSj1BL4qb+f2GN9e
mf5ndcshWjqJNecaWIbaSSG81t2M1uIARJwqSDLdwyQn+O82QFc1WZhy0cUHIvw0
I83iJlH+
=NaiQ
-----END PGP SIGNATURE-----

--s5TcPYhLtyCJ1SP8--
