Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22620C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 14:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8070C87594;
	Mon, 27 Nov 2023 15:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XnV35cOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6448C875C5; Mon, 27 Nov 2023 15:27:24 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 735898753F
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 15:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5cbcfdeaff3so42889837b3.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 06:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701095240; x=1701700040; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p7XKDYvMMRdr7sResh/vfC5OOhPmZt2kcsQD3JAI5vM=;
 b=XnV35cOMAj54VESCrtY/AaX9q0Pq7TKjpcXjiqsN1VSyN/rjqfm31GGPNO4ZqrcI9U
 iof9cZ0hF5TpuyfV1eIEzFfeDh+fFT9uWtKop120B0ptSx6DHiyonHKPEt8aApDgu4pf
 uonW0R9rT//LDgcW/lfL+WM7MT1fnESDNW3Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701095240; x=1701700040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p7XKDYvMMRdr7sResh/vfC5OOhPmZt2kcsQD3JAI5vM=;
 b=R/JHJz5dGj9VyxFAhCQNcIHEXpxcmBtC39AysGxkwah7dgyrP3VSLZb64DRbFWz4H2
 rLHRazqEH/HRm3f60BVQu7yE5x6BxV0Pb4TW+5R8Bn/HqNSBua5R1dD05BLP6oePV3lr
 xsAmJj/btUxyihY7n9mAMjC01U1kBM0ETnaPwzeGpsBtCdlO9/Rr+WvXL1/o0uje20qP
 AmLg6yrLOCfdzQgMr4QgWpxHxNy7cpHao94uZVT6pN/G7btV5nJvfw4DZS6tTZpubLAo
 VEASBtOaJiGwdJEyF7A6jupsGREfYxkfqgRsiumvdqQ/CKIDnZ66GOeh3t8UXNU/TF6l
 G3dA==
X-Gm-Message-State: AOJu0YwW7CUobFjA2Tl2ZNtVm3dE/nc5DA0Owf4Xx2Wpp+e9pYI0fuFS
 UO5R//gv+AgMUl2yux//tY55R9Ox+DaHDUnCgER8tQ==
X-Google-Smtp-Source: AGHT+IGGsBHy6nmjoBZjhh7mJeaoxOB9Om79uXGfZ+WTPAZm4nbTomIsYWH+sUDOuqVyOrlxn39nuQ==
X-Received: by 2002:a0d:f807:0:b0:5d0:c58f:9e53 with SMTP id
 i7-20020a0df807000000b005d0c58f9e53mr1695401ywf.6.1701095239999; 
 Mon, 27 Nov 2023 06:27:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 d62-20020a0ddb41000000b005cab0d7b0f1sm3312231ywe.6.2023.11.27.06.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 06:27:19 -0800 (PST)
Date: Mon, 27 Nov 2023 09:27:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Vagrant Cascadian <vagrant@debian.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: Licensing discrepancies or ambiguities
Message-ID: <20231127142717.GH2513409@bill-the-cat>
References: <8734wyudku.fsf@contorta> <20231121193719.GH2513409@bill-the-cat>
 <87bkbhwj7q.fsf@contorta>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YeHTNFmq/+FdPzfE"
Content-Disposition: inline
In-Reply-To: <87bkbhwj7q.fsf@contorta>
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


--YeHTNFmq/+FdPzfE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 02:39:53PM -0800, Vagrant Cascadian wrote:
> On 2023-11-21, Tom Rini wrote:
> > On Tue, Nov 21, 2023 at 11:10:57AM -0800, Vagrant Cascadian wrote:
> >
> >> I've been reviewing the copyright and license information for Das U-Bo=
ot
> >> in preparation for uploading to Debian, and found a few surprises.
> >>=20
> >>  tools/libfdt/fdt_rw.c: /* SPDX-License-Identifier: GPL-2.0+ BSD-2-Cla=
use */
> >
> > This comes from the kernel and has been clarified there:
> > // SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>=20
> That's much better! Thanks for looking into it! I suspect there are
> quite a few that get pulled in from linux or elsewhere that might have
> similar issues.
>=20
>=20
> >> I *think* according to the SPDX spec this needs an OR or an AND. I also
> >> see no copyright declaration, although maybe there is a standard
> >> interpretation for this.
> >>=20
> >> Similar issue with (though thankfully they include copyright
> >> declarations):
> >>=20
> >>  include/bloblist.h:/* SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause =
*/
> >>  common/bloblist.c:// SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause
> >
> > Simon?
> >
> >>  doc/README.ubispl:# SPDX-License-Identifier: GPL 2.0+ BSD-3-Clause
> >
> > Should be an OR as well, yes, but it's also out of date and we could
> > just delete if a problem.
>=20
> Ok.
>=20
> >> This one has a non-existent license:
> >>=20
> >>   test/lib/strlcat.c: // SPDX-License-Identifier: GPL-2.1+
> >>=20
> >> No such license exists, though thankfully it references the exact file
> >> in the original glibc sources it came from, which is listed as
> >> LGPL-2.1+.
> >
> > Since you did the research would you mind sending the patch? Thanks.
>=20
> Will do eventually!
>=20
>=20
>=20
> Also found some more ambiguous ones where the license text is in
> conflict with the SPDX identifiers:
>=20
>   arch/sandbox/cpu/u-boot-spl.lds-/* SPDX-License-Identifier: GPL-2.0+ */
>   arch/sandbox/cpu/u-boot-spl.lds-/*
>   arch/sandbox/cpu/u-boot-spl.lds- * Copyright (c) 2011-2012 The Chromium=
 OS Authors.
>   arch/sandbox/cpu/u-boot-spl.lds: * Use of this source code is governed =
by a BSD-style license that can be
>   arch/sandbox/cpu/u-boot-spl.lds- * found in the LICENSE file.
>   arch/sandbox/cpu/u-boot-spl.lds- */
>=20
> The referred to LICENSE file does not appear to exist in u-boot, and
> exactly what the text of this BSD-style license is ... a mystery.
>=20
> And lib/zstd includes many entries in a similar situation:
>=20
>   lib/zstd/Makefile-# Copyright (c) Facebook, Inc.
>   lib/zstd/Makefile-# All rights reserved.
>   lib/zstd/Makefile-#
>   lib/zstd/Makefile:# This source code is licensed under both the BSD-sty=
le license (found in the
>   lib/zstd/Makefile-# LICENSE file in the root directory of this source t=
ree) and the GPLv2 (found
>   lib/zstd/Makefile-# in the COPYING file in the root directory of this s=
ource tree).
>   lib/zstd/Makefile-# You may select, at your option, one of the above-li=
sted licenses.
>=20
> This seems like it would be "GPL-2.0 OR BSD-*something*", but it is uncle=
ar
> what BSD-style maps to, as the LICENSE file is not present where it
> claims.
>=20
> Many similar discrepancies can be found with:
>=20
>   git grep -B4 -A3 'BSD-style'
>=20
>=20
> I probably have mroe to dig up, but these are the ones that leapt out at
> me for now!

So, with my project maintainer hat on, U-Boot is essentially a GPLv2
project. We have a large amount of source code borrowed directly from
the Linux Kernel and that is GPL-2.0 (and not or later), and today
there's no feasible way to do not use that code. So everything in use
must be something that is compatible with GPL-2.0, and anything with an
incompatible license is worrisome and needs to be addressed.

In general, some of our inconsistencies should match the Linux Kernel
(zstd is another one), and it might be best to file issues at
https://source.denx.de/u-boot/u-boot/-/issues/ for these as you find
them so that they can be tracked, if you aren't able to submit patches
correcting them. There are a few cases, such as the sandbox one that are
U-Boot specific and I assume can be fixed by the author once noted (and
in that specific case I know Simon also likes issues to be filed).

Thanks again for looking in to these kind of issues, I appreciate it.

--=20
Tom

--YeHTNFmq/+FdPzfE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVkp0IACgkQFHw5/5Y0
tyzyeAv/SxQnCpyJCRYPOC2QXqetDmu/0qFnAOD3HgmZn1SIHAxYEWbW7Vx2yxFj
w15ouDcH7Lxomw2amGbwq/RowT7VtkvZ2Q1tgOimZdYtJ8ejQG+DtCas8gMAi9za
U7hFNcmiMs2f0eBSInipXzxaUII/h6RIfs2jZfffP6XkV41WIhOHa/0Km+hwS+gw
E3iW5uUmS0fxoZVRiHcv5EjKrkuB/qw0e+FZpHjECWcwLFi3rsoDw6ABPmeafd/i
Q8en7UJjao+bKUu21YQ7hhGhq8HkQJ75AVFWI2LSr16AoQId5gP97DT0P7bSRmEV
gnu2ze1GV4KeZx9b49cFDdl5DxlxjHhcjg0Hl2fRpb/WEvsk38k4sgm/s2GtqT7V
oZgsAx4XD0EB65wkfv1PZS/2uOIA6pYk1iABmifIz8tKeG+rVUtm/yOdYCczthl+
bFM68mg/CnIx+BrS4wS4WoLDlmAuQeIMTpic3Nfc2mAL55hs5l9RwXuEPuOeKXh0
PxAAHAZq
=yEMI
-----END PGP SIGNATURE-----

--YeHTNFmq/+FdPzfE--
