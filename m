Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8316FC46CA6
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 23:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CA328718E;
	Wed, 15 Nov 2023 00:21:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MmsDA529";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A16AD87118; Wed, 15 Nov 2023 00:21:31 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41D7B8718E
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 00:20:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-677a0ac3797so24323146d6.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 15:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700004015; x=1700608815; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zKxyL4m46XYypTIs7GG51GtanuUT4Xn5lEcDh0Kf3lU=;
 b=MmsDA52925sbUjPOsrklMHDt+TxY6/sPHsy5H1hHbfi6pjzolbmde0qSR9wd4lkQRG
 Q2zXbGVavdwi8b3yuVFwD5aFdYqy4Ywb5o6R71U7CSLMVeRFPtVA2rA0YnMu+7SAx0KN
 OX75Bc7+jm7BuUBZ5zlTQ+ASM573JGmvZQOec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700004015; x=1700608815;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zKxyL4m46XYypTIs7GG51GtanuUT4Xn5lEcDh0Kf3lU=;
 b=f9fChp2rtohjgAGOeW9/gG5w622g9XiFfn2FYbfEuSL5bz925sPPs8+rQRfa1LSj4p
 6C+5NIVCnQphz7lQHRvn4LnO2B1yAaX5Jmz5c6d0kp5XSR9DpAp7RpwniQDBHXk0y1b6
 NQFDhQZGB+qPPHbWX3/QZtZ5vhsomHvHMD52coYVxMkIn79v+IqykjTr9u8ETNdvsatn
 AUAmRmoNdnBxpiBs+qKH9mgwX7xvKfiVsw8pqs2Uq7VlI61ZYyKd95/NAyfjqRR3JQnO
 FI0yud7IRqX7T0KxQFBAwidc82c6kd4SUwrUIWE92QjBWXHIRCULhVyUxUc/wQCoesXn
 CW4Q==
X-Gm-Message-State: AOJu0YxfiqQbKyUpr+PhJBWOhou5FoewionR/KqX7bWFkU2s1s8PlvuC
 12AZZcrpDzXGXMuD8Z5ZleAElg==
X-Google-Smtp-Source: AGHT+IEwywaU2gDjGM1O0pcMWSEOT+h5CPBZ5qYCr8boADG7yuLsDInH4Dw9aGHTd7erhkswzOSkOw==
X-Received: by 2002:a0c:fd86:0:b0:672:22d:270d with SMTP id
 p6-20020a0cfd86000000b00672022d270dmr3731933qvr.30.1700004015165; 
 Tue, 14 Nov 2023 15:20:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-03f5-0f73-ac9e-a6c1.res6.spectrum.com.
 [2603:6081:7b00:6400:3f5:f73:ac9e:a6c1])
 by smtp.gmail.com with ESMTPSA id
 c10-20020a05621401ea00b006648514e276sm36904qvu.78.2023.11.14.15.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 15:20:14 -0800 (PST)
Date: Tue, 14 Nov 2023 18:20:12 -0500
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Simon Glass <sjg@google.com>, heinrich.schuchardt@canonical.com,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de, dianders@google.com
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
Message-ID: <20231114232012.GD6601@bill-the-cat>
References: <ea1ba7c2-7f9c-4702-a6da-efb728771e24@canonical.com>
 <20231020162410.GK3119521@bill-the-cat>
 <CAPnjgZ0zwQ+J-17YEhAtTtLhTcK7K9=nqNNqOdNmG5bY+rFrhg@mail.gmail.com>
 <7481371f-657d-46d6-b8e7-74da7a200ee9@canonical.com>
 <CAPnjgZ3_WSS+Z2xsRTvf-7ChPN42OVLgLf8ZvGv=2FVrNuHkhA@mail.gmail.com>
 <87h6mhqri9.fsf@bloch.sibelius.xs4all.nl>
 <20231023163455.GL496310@bill-the-cat>
 <87fs21qnex.fsf@bloch.sibelius.xs4all.nl>
 <CAPnjgZ3Yqf3-9wjVTYh5eR_=rFuf-2eWUvZmfv=U1xDCVEWSXQ@mail.gmail.com>
 <877cmk9mnz.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N0GECREEJNaVvX+L"
Content-Disposition: inline
In-Reply-To: <877cmk9mnz.fsf@bloch.sibelius.xs4all.nl>
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


--N0GECREEJNaVvX+L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 08:09:52PM +0100, Mark Kettenis wrote:
> > From: Simon Glass <sjg@google.com>
> > Date: Fri, 3 Nov 2023 13:17:18 -0600
> >=20
> > Hi,
> >=20
> > On Mon, 23 Oct 2023 at 11:06, Mark Kettenis <mark.kettenis@xs4all.nl> w=
rote:
> > >
> > > > Date: Mon, 23 Oct 2023 12:34:55 -0400
> > > > From: Tom Rini <trini@konsulko.com>
> > > >
> > > > On Mon, Oct 23, 2023 at 05:37:34PM +0200, Mark Kettenis wrote:
> > > > > > From: Simon Glass <sjg@google.com>
> > > > > > Date: Mon, 23 Oct 2023 00:08:40 -0700
> > > > > >
> > > > > > > > fdt_node_check_compatible() does most of the work...then yo=
u need to
> > > > > > > > check which FDT has the most specific match (i.e. latest in=
 the string
> > > > > > > > list). That handles things like board revisions, variants, =
etc.
> > > > > > > >
> > > > > > > > My concern is about adding a feature when there is already =
a defined
> > > > > > > > spec and mechanism for this to work. What happens when we l=
oad the
> > > > > > > > file and the compatible is wrong?
> > > > > > > >
> > > > > > > > At best, I see the filename as a hint.
> > > > > > > >
> > > > > > > > [Perhaps this is the wrong time to ask, but why are kernels=
 +DT not
> > > > > > > > shipped in FIT on ARM?]
> > > > > > >
> > > > > > > FIT is U-Boot specific. For Linux distributions it is easier =
to use a
> > > > > > > firmware agnostic method of booting.
> > > > > >
> > > > > > I'd like to suggest that distros use both. Then U-Boot can work=
 as it
> > > > > > was designed and we can avoid these work-arounds.
> > > > > >
> > > > > > FIT is actually implemented in various other bootloaders. In fa=
ct
> > > > > > perhaps grub is the only one that doesn't? I can't think of any
> > > > > > others.
> > > > >
> > > > > Simon, please stop pushing this.  OpenBSD's bootloader does not
> > > > > support FIT and we have no interest in supporting it.  Our users
> > > > > expect to be able to just copy a new kernel in place and use it a=
nd
> > > > > our OS upgrade procedure depends on this as well.  And this is
> > > > > incompatble with FIT.  I've explained this about a dozen times to=
 you
> > > > > now.
> > > >
> > > > In the context of this thread, genuinely, how will OpenBSD (and the=
 rest
> > > > of the BSD families) operate? I agree U-Boot doesn't want to have to
> > > > know all of the UFSes, so that means the SCT will be populated eith=
er by
> > > > the DT passed to U-Boot, or the DT we were built with. Is it that s=
ince
> > > > the next stage is an EFI app, it will check that variable and use t=
hat
> > > > hint?
> > >
> > > Yes, that is exactly what I want to do.  Hopefully the DT that is
> > > passed to U-Boot or that U-Boot was built with will be good enough in
> > > most cases.  But when it isn't users can use the OpenBSD bootloader
> > > (which is an EFI app) to load an updated DT.
> > >
> > > I can't speak for the other BSDs, but I think both FreeBSD and NetBSD
> > > have a very similar boot mechanism.
> >=20
> > I've been thinking about this patch a bit more, and I have grave misgiv=
ings.
> >=20
> > I predict that if we take this, it will become an ABI from U-Boot and
> > we will not be able to drop it.
>=20
> Why would we want to drop it?

Because filename isn't an obvious great idea to encode as ABI? It's not
formally one right now, even with the Linux Kernel installing the ARM=3Darm
dtb files in a single directory even after re-organizing the source
directory to match ARCH=3Darm64 with per-vendor directories.

> > Here is what I suggest instead: provide a protocol for U-Boot to
> > provide the DT over EFI. Provide any information needed by U-Boot,
> > such as the directory containing the files.
>=20
> So you want something more complicated than a simple EFI variable?  Why?

I think part of this all came out of the issues Fedora was having where
they (a) need to override the DTB to ensure the kernel boots and (b)
oops, the logic they had been using wasn't being invoked (unexpected
Fedora-based change).

Some way to say "here is the device tree you should use" needs to come
=66rom somewhere. It would be great if the running device tree was already
correct, but we don't know that it will be, and that's also still not a
U-Boot problem. One of the examples here was that the Pi firmware DTB
wasn't 100% correct. I forget what the exact fixup ended up being there.

So, some sort of hint for the board to say "here is the device tree you
should use". I know you earlier noted that you didn't think U-Boot would
want to know how to read N different UFS formats, and yes, true. Maybe
that just means that it needs to reside on some other filesystem format,
like Linux has to do? I don't know. How to best do that, I don't know.

> > We already have the ability to put a DT in the system table. We
> > already have a way to package DT into a FIT and allow U-Boot to select
> > the correct one.
>=20
> Please stop pushing FIT for use cases where it doesn't make sense.

OK, but where is that? At least part of the "we don't want to use FIT"
camp instead has
https://uapi-group.org/specifications/specs/unified_kernel_image/ which
then leaves the details on how to select the right device tree up to
the implementation.  Which, sigh, that's the hard part. And at least as
I understand it part of the motivation is that "everyone" wants a single
file that can be used for UEFI secure boot and include all of the device
trees, so that they can be covered by the signature. Which is something
FIT images have had for forever (minus a "wrap it inside a .data section
so it can be included in a signature).

Life is a lot easier if we know the device's compatible string and then
if needed, load a newer device tree based on that compatible string.
Unfortunately, that too is not an ABI and there's a few examples where
that wouldn't work, and hasn't been fixed yet because so little relies
on the machine compatible string itself today.

> > With something like this it will be impossible for U-Boot to boot a
> > distro without using grub, etc. since it won't know what DT to use.
> > This information would be held in a script somewhere which no one can
> > figure out without executing it.
>=20
> Huh?  U-Boot already knows the name of name of the DT filename.  It is
> what we currently use in the distroboot scripts.  You are free to use
> a U-Boot specific bootflow based on that if you really want to.  But
> many distros (or other OSes like OpenBSD) really don't want to
> maintain support for multiple boot flows.

U-Boot doesn't know the DT filename, we have assorted bits of
board-specific logic to either setenv at runtime, or we hard-code that
filename at build time. We do however "know" the machine compatible
string already because you need that for a valid device tree which you
need for U-Boot today. And yes, if and only if the device tree we get
=66rom the prior stage (or build in) is correct, we don't need to do
anything else, and can pass that to the next stage. But it also doesn't
seem like today any Linux distribution does the same thing another Linux
distribution does (excepting "spins" and so on) when it comes to loading
the kernel and device tree. Not to pick on Fedora (really!) but part of
the issue was that the patch to change where device trees are loaded
=66rom was applied, but then not in the boot command that was being used.

Maybe part of the issue is that enough of us don't know how it works and
haven't experimented. And since at least I learn best by investigating,
should I try pine64_plus_defconfig or rpi_arm64_defconfig (on a 3 B+) on
a fresh SD card to get a better feel for what's going on?

--=20
Tom

--N0GECREEJNaVvX+L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVUAKYACgkQFHw5/5Y0
tyxjnAv/Xvp1YKiO6QeMy6RfK2Fd6VnjS64kjVVunHmyYAcEDEqUXcDN5M5jMMO+
wpZcRT2GZfACYOIF9ykA5b6CRZgHKlDMCDdYwg4P1z1v9yHmscu1ITvyl2MbMmc5
1XiWrl4AssyJgjUMIMY68anhkoFn4SqD9sVKhnAoBaRcUSc0f6Y9w/nk6xOORu+V
JNQNR/QxS8u9pTbFZfWqtHXC/liXeoRCJ0A2oEE7VqTxlmCLKnyNfhWgmFKWa3rR
xDJWADnhdatEKmg30ZcCSIiUu5UO+MmIwGS7fnXl4n+st695Ux+8tg9djFmPeY6L
yG7WYE9isyTZhCCeTabS5d5F5c118dYrOcJB4kkqAqIu8kpJrY8cnBDFdWLuqO3c
EWnLd7+wak+MAimcGIH7anz/45rpxYJKNAnqJcfxVsJrBKSer8Jp8AwNHbUVTyeK
6pCOwyis0Qj2rAMe8et3pjw19FdsxWStvPGCzJPP6VFTUzZXbuTFeBQO65SnDA8x
eIm/Smge
=pAMk
-----END PGP SIGNATURE-----

--N0GECREEJNaVvX+L--
