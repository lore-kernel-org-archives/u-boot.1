Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3669EC4167B
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 22:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABCC8870E7;
	Sat, 25 Nov 2023 23:40:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="NObdsm+U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83E78870E7; Sat, 25 Nov 2023 23:40:11 +0100 (CET)
Received: from cascadia.aikidev.net (cascadia.aikidev.net
 [IPv6:2600:3c01:e000:267:0:a171:de7:c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DADF870A0
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 23:40:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=vagrant@debian.org
Received: from localhost (unknown [IPv6:2600:3c01:e000:21:7:77:0:20])
 (Authenticated sender: vagrant@cascadia.debian.net)
 by cascadia.aikidev.net (Postfix) with ESMTPSA id D59011AE3B;
 Sat, 25 Nov 2023 14:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=debian.org;
 s=1.vagrant.user; t=1700952003;
 bh=3xGb9+rxnfpW+752nWaQifexAmD+BH8RDmBpvUAEzvI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=NObdsm+UhKsYJNb06FWRmAfoQDlQLEhLdq1wnsXro91sbSr5aQLHe940zqzHtJe+E
 2p867oY+t1IL+pXNT756rlOFeTePn/opCYE/+Q6FlG1qlNlegk4KoseC2f682955/P
 a4FBYgxayVpkyfR0hsz+NxuhW4ZlD9MOUFv219Axaw7YfdEhUnz/bghvjhvEWs3nZO
 iJf7bTFfe10MYOajrJFE1ncbDRLUbmcuJKy4Zbj+U1/5aXtveFA0BVZ/6b1mWHyivJ
 mncfxAYYmaDV3+KVcFZ+dabBa8yfpGi9uXY8BC3TlIMWuKdkU+UnwYkunw9S73T9Qw
 2HxY9arH8cFJg==
From: Vagrant Cascadian <vagrant@debian.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: Licensing discrepancies or ambiguities
In-Reply-To: <20231121193719.GH2513409@bill-the-cat>
References: <8734wyudku.fsf@contorta> <20231121193719.GH2513409@bill-the-cat>
Date: Sat, 25 Nov 2023 14:39:53 -0800
Message-ID: <87bkbhwj7q.fsf@contorta>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
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

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 2023-11-21, Tom Rini wrote:
> On Tue, Nov 21, 2023 at 11:10:57AM -0800, Vagrant Cascadian wrote:
>
>> I've been reviewing the copyright and license information for Das U-Boot
>> in preparation for uploading to Debian, and found a few surprises.
>>=20
>>  tools/libfdt/fdt_rw.c: /* SPDX-License-Identifier: GPL-2.0+ BSD-2-Claus=
e */
>
> This comes from the kernel and has been clarified there:
> // SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)

That's much better! Thanks for looking into it! I suspect there are
quite a few that get pulled in from linux or elsewhere that might have
similar issues.


>> I *think* according to the SPDX spec this needs an OR or an AND. I also
>> see no copyright declaration, although maybe there is a standard
>> interpretation for this.
>>=20
>> Similar issue with (though thankfully they include copyright
>> declarations):
>>=20
>>  include/bloblist.h:/* SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause */
>>  common/bloblist.c:// SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause
>
> Simon?
>
>>  doc/README.ubispl:# SPDX-License-Identifier: GPL 2.0+ BSD-3-Clause
>
> Should be an OR as well, yes, but it's also out of date and we could
> just delete if a problem.

Ok.

>> This one has a non-existent license:
>>=20
>>   test/lib/strlcat.c: // SPDX-License-Identifier: GPL-2.1+
>>=20
>> No such license exists, though thankfully it references the exact file
>> in the original glibc sources it came from, which is listed as
>> LGPL-2.1+.
>
> Since you did the research would you mind sending the patch? Thanks.

Will do eventually!



Also found some more ambiguous ones where the license text is in
conflict with the SPDX identifiers:

  arch/sandbox/cpu/u-boot-spl.lds-/* SPDX-License-Identifier: GPL-2.0+ */
  arch/sandbox/cpu/u-boot-spl.lds-/*
  arch/sandbox/cpu/u-boot-spl.lds- * Copyright (c) 2011-2012 The Chromium O=
S Authors.
  arch/sandbox/cpu/u-boot-spl.lds: * Use of this source code is governed by=
 a BSD-style license that can be
  arch/sandbox/cpu/u-boot-spl.lds- * found in the LICENSE file.
  arch/sandbox/cpu/u-boot-spl.lds- */

The referred to LICENSE file does not appear to exist in u-boot, and
exactly what the text of this BSD-style license is ... a mystery.

And lib/zstd includes many entries in a similar situation:

  lib/zstd/Makefile-# Copyright (c) Facebook, Inc.
  lib/zstd/Makefile-# All rights reserved.
  lib/zstd/Makefile-#
  lib/zstd/Makefile:# This source code is licensed under both the BSD-style=
 license (found in the
  lib/zstd/Makefile-# LICENSE file in the root directory of this source tre=
e) and the GPLv2 (found
  lib/zstd/Makefile-# in the COPYING file in the root directory of this sou=
rce tree).
  lib/zstd/Makefile-# You may select, at your option, one of the above-list=
ed licenses.

This seems like it would be "GPL-2.0 OR BSD-*something*", but it is unclear
what BSD-style maps to, as the LICENSE file is not present where it
claims.

Many similar discrepancies can be found with:

  git grep -B4 -A3 'BSD-style'


I probably have mroe to dig up, but these are the ones that leapt out at
me for now!

live well,
  vagrant

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRlgHNhO/zFx+LkXUXcUY/If5cWqgUCZWJ3ugAKCRDcUY/If5cW
qhdBAP9DsY8DT4kO8jmIxXLg1lIhpPgXA1QrtOAqyOhGdKD27AEAhO8HKdi32KJN
zO9hSkh+Ku4SFklRsV8kHXradhTltgo=
=tPKs
-----END PGP SIGNATURE-----
--=-=-=--
