Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77399C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 15:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 990AD80C93;
	Sat, 15 Mar 2025 16:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j9hSoX38";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7318280ECC; Sat, 15 Mar 2025 16:23:22 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE4CE80756
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 16:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-47690eedcc3so18518601cf.3
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 08:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742052198; x=1742656998; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m7F6Ky+db58INVqabWROREhW7IJDNuUbFK/ZVKig19Y=;
 b=j9hSoX38F5CT2bsNpWVjKJNMbigb9yo8q14f+IBaZzIiFwDx0cOJF43TpJGPv8ZUX+
 fZ3l1yrypEzEIEAZP2tLxkiZ/vk1CZIBx7qDmstvek5TafT3/RvLBFGopTt/ssfteHXD
 /Y+zl0SFCHQU5U9kveKfbizemt4VUTd0skbg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742052198; x=1742656998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m7F6Ky+db58INVqabWROREhW7IJDNuUbFK/ZVKig19Y=;
 b=KoVwSmGm/bOa8dkE9u50abCk9sT1/tvv7aawu7npiW7lHGAyPshOSD7Yu/P6vlXuDF
 Wvfp3p3yCv+fjpFufRZJ49uwIi2zmY2xmYJjIr+UJ7PWBFhmwJjkIZMez6+CGkL08gP3
 5h/LVJU8DrxhbEL/UhlkTPyfAxqwvaRmc5QjhqUcG8ytm5KCq75ev2/8nhwjYnLAwpCD
 hOU7XmOsUP7DXBadpfDweoX05Zrhd6A7pUXHOgEqA8CvqObfB+9WeNrAPMMqPm9fT32Y
 pMt90fpb2rAKQXpHNrXdya8LgrDw7TbWIj7QZ+PjGLExFQfeQ6xFT9Ptr5QSnyvhxs5b
 fI2A==
X-Gm-Message-State: AOJu0Yz0rdSTBjq2+g2ZixDn/23qqReUr6gE/qpya23shD4l1WDLxlRh
 rC1SZ5No6WDZ/Rsufw2pWJUGSEjH1ivXm0ZaT6JnMrTfUUG9LMu9heKh8ydihxRqvPfauV5PxnP
 F
X-Gm-Gg: ASbGnctg0q8od/+/cuG4N1YJpIZ1QcF3CbvDH2uB3bMqVD80uS9fSSsIThd2J+9gB+a
 VEdWJHE+8X6BL0zGOPBSbViO2lY3g/WsRU+4w5q5rPFHIcDAkBQIQf5G7if15hBO8zyRaklrCPj
 qwp/em5krbIrrhLAFtDCwXEzztIWAGEwoORex4UADn5VmlT/IKg82UVWUdHum5ajpoCSU/omUev
 T/pSr30ZcLlRXLdmvOHu3pVE0dQw5vn0cYbM2JIIwm9py8F1KyF47tlMOY8p+66FMou4dVtYL+K
 YxtWUIdoiX16mOPSVKO3H2/z4Szf49HrdNtSSyyZ5lbY9g==
X-Google-Smtp-Source: AGHT+IHCR6++TQUVcKy9qGB6vdVMa99VC8TjVrQ9WEZjWILGo1t5nkb36iwqpq5vnbY7RfAVEQ2TIA==
X-Received: by 2002:ac8:7f0a:0:b0:476:7d74:dd10 with SMTP id
 d75a77b69052e-476c81391a0mr96971011cf.19.1742052198249; 
 Sat, 15 Mar 2025 08:23:18 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4f08sm34979781cf.56.2025.03.15.08.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 08:23:17 -0700 (PDT)
Date: Sat, 15 Mar 2025 09:23:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Brandon Maier <brandon.maier@collins.com>
Subject: Re: [PATCH 2/2] u_boot_pylib: Clean up pylint warnings in gitutil.py
Message-ID: <20250315152314.GJ2640854@bill-the-cat>
References: <20250209212714.2317040-1-sjg@chromium.org>
 <20250209212714.2317040-2-sjg@chromium.org>
 <20250217192316.GW1233568@bill-the-cat>
 <CAFLszTjXnz7coW9_MSLxWVH+Ea5bdka8oYByG4LQtTUNpije7g@mail.gmail.com>
 <20250314153615.GR2640854@bill-the-cat>
 <CAFLszThguOxcC2nR467Qc9U+VdO91F48mhPuv7d6DDF7WKbyqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FgBOBQS7Cz5GuW+3"
Content-Disposition: inline
In-Reply-To: <CAFLszThguOxcC2nR467Qc9U+VdO91F48mhPuv7d6DDF7WKbyqQ@mail.gmail.com>
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


--FgBOBQS7Cz5GuW+3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 02:48:18PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 14 Mar 2025 at 15:36, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Mar 14, 2025 at 02:45:27PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 17 Feb 2025 at 19:23, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Feb 09, 2025 at 02:26:01PM -0700, Simon Glass wrote:
> > > >
> > > > > Reduce the number of warnings in this file.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > >  tools/buildman/func_test.py   |   4 +-
> > > > >  tools/u_boot_pylib/gitutil.py | 240 ++++++++++++++++++----------=
------
> > > > >  2 files changed, 128 insertions(+), 116 deletions(-)
> > > >
> > > > As I think these all were warnings from whatever other linting you =
had
> > > > mentioned in another thread, I deferred this patch as it also doesn=
't
> > > > cleanly apply.
> > >
> > > Some of it, yes. But most of it is fixing things that we should fix.
> >
> > To be clear, to the extent any of it was pylint problems, they've now
> > been addressed as we've moved to pylint 3.3.4.
>=20
> Actually, I don't know about those problems, but that's fine.
>=20
> >
> > > This is going to open up a significant diff for patman, unfortunately,
> > > just as I am adding new features for series management. So please
> > > consider applying it. I can rebase if you like?
> >
> > Yes, that's fine, please just explain what's showing the warnings or
> > otherwise update the commit message.
>=20
> Before:
>=20
> ************* Module u_boot_pylib.gitutil
> tools/u_boot_pylib/gitutil.py:1:0: C0114: Missing module docstring
> (missing-module-docstring)
> tools/u_boot_pylib/gitutil.py:13:0: C0103: Constant name
> "use_no_decorate" doesn't conform to UPPER_CASE naming style
> (invalid-name)
> tools/u_boot_pylib/gitutil.py:40:19: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:65:20: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:72:25: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:64:12: W0612: Unused variable 'msg'
> (unused-variable)
> tools/u_boot_pylib/gitutil.py:114:21: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:121:25: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:122:17: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:139:41: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:141:40: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:146:4: R1705: Unnecessary "elif" after
> "return", remove the leading "el" from "elif" (no-else-return)
> tools/u_boot_pylib/gitutil.py:151:15: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:153:25: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:171:11: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:189:21: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:243:22: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:255:22: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:272:22: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:305:22: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:317:22: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:320:0: R0913: Too many arguments (6/5)
> (too-many-arguments)
> tools/u_boot_pylib/gitutil.py:320:0: R0917: Too many positional
> arguments (6/5) (too-many-positional-arguments)
> tools/u_boot_pylib/gitutil.py:345:16: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:347:12: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:353:4: R1705: Unnecessary "else" after
> "return", remove the "else" and de-indent the code inside it
> (no-else-return)
> tools/u_boot_pylib/gitutil.py:402:16: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:416:7: R1714: Consider merging these
> comparisons with 'in' by using 'suppresscc in ('all', 'cccmd')'. Use a
> set instead if elements are hashable. (consider-using-in)
> tools/u_boot_pylib/gitutil.py:420:15: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:433:0: R0913: Too many arguments (12/5)
> (too-many-arguments)
> tools/u_boot_pylib/gitutil.py:433:0: R0917: Too many positional
> arguments (12/5) (too-many-positional-arguments)
> tools/u_boot_pylib/gitutil.py:433:0: R0914: Too many local variables
> (17/15) (too-many-locals)
> tools/u_boot_pylib/gitutil.py:512:19: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:514:19: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:520:24: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:433:0: R1710: Either all return
> statements in a function should return an expression, or none of them
> should. (inconsistent-return-statements)
> tools/u_boot_pylib/gitutil.py:435:36: W0613: Unused argument
> 'get_maintainer_script' (unused-argument)
> tools/u_boot_pylib/gitutil.py:592:14: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:593:8: R1720: Unnecessary "else" after
> "raise", remove the "else" and de-indent the code inside it
> (no-else-raise)
> tools/u_boot_pylib/gitutil.py:601:18: C0209: Formatting a regular
> string which could be an f-string (consider-using-f-string)
> tools/u_boot_pylib/gitutil.py:682:4: W0603: Using the global statement
> (global-statement)
>=20
> ------------------------------------------------------------------
> Your code has been rated at 8.41/10 (previous run: 8.37/10, +0.04)
>=20
>=20
> After:
>=20
> ************* Module u_boot_pylib.gitutil
> tools/u_boot_pylib/gitutil.py:1:0: C0114: Missing module docstring
> (missing-module-docstring)
> tools/u_boot_pylib/gitutil.py:325:0: R0913: Too many arguments (6/5)
> (too-many-arguments)
> tools/u_boot_pylib/gitutil.py:325:0: R0917: Too many positional
> arguments (6/5) (too-many-positional-arguments)
> tools/u_boot_pylib/gitutil.py:439:0: R0913: Too many arguments (11/5)
> (too-many-arguments)
> tools/u_boot_pylib/gitutil.py:439:0: R0917: Too many positional
> arguments (11/5) (too-many-positional-arguments)
> tools/u_boot_pylib/gitutil.py:439:0: R0914: Too many local variables
> (16/15) (too-many-locals)
> tools/u_boot_pylib/gitutil.py:694:4: W0603: Using the global statement
> (global-statement)
>=20
> ------------------------------------------------------------------
> Your code has been rated at 9.73/10 (previous run: 8.41/10, +1.32)

And it's not clear where these warnings come from or why they matter or
how to check things further.

> The patch is here:
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20250209212714.2317040-2=
-sjg@chromium.org/
>=20
> It looks like it will apply for you, if first you accept my PR.

It does, but I'm still not thrilled with the commit message.

--=20
Tom

--FgBOBQS7Cz5GuW+3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfVm1YACgkQFHw5/5Y0
tyyU6AwAnNywEi44wxhgfvIvf5FmgSJEEeQzCN6+TuD14PSYChG6tUYtbyQf1hom
Z0hSxGI8SoiDgQs4EWkzEibylhkmb3v2hXFhH+Gskv74x4hvOyq6w8teT9ClpAkb
cBr+fZfKi82M4T6oaFnqet3yrPHAI80U1FbrVod8bvHYhDHuZQcTdgHi0XppNMBx
exPGZShj6GqCp9p76dXa5PLo28hsSY+k0SCZLPi0XIGwORhXEZIsAbMj35W24eRm
IY4X+ZJmJVJEuV3mcz49fYwOgHTBxdAWEQ1rnxp+7ckG1TEmZaoEVa28KGtNjTZH
e7brmcsE4xP0rl0IQDLeg8ouOySdCpSEO5yUZM7zYnFUWhAtghh+PtVu4ToYtxn9
qvdt/abULEcLHlj6CyV1VQWOxhLELeTLiOu5tGEnSKdLHG3RBZiE9HYWI1cI9MWu
2x+9wQ0h9A34crMGmdnuBtVTwvJA2s1IHHQ3zhjiYvPZK1sc2RRMU7T6z4DHQb/V
oDg7Zzsc
=S06x
-----END PGP SIGNATURE-----

--FgBOBQS7Cz5GuW+3--
