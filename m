Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2442C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 19:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26FE9871CD;
	Tue, 21 Nov 2023 20:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="H2VbSLjO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 369AF875A8; Tue, 21 Nov 2023 20:11:10 +0100 (CET)
Received: from cascadia.aikidev.net (cascadia.aikidev.net
 [IPv6:2600:3c01:e000:267:0:a171:de7:c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12D2E86FB5
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 20:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=vagrant@debian.org
Received: from localhost (unknown [IPv6:2600:3c01:e000:21:7:77:0:20])
 (Authenticated sender: vagrant@cascadia.debian.net)
 by cascadia.aikidev.net (Postfix) with ESMTPSA id 1C7991AD75
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 11:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=debian.org;
 s=1.vagrant.user; t=1700593863;
 bh=Vbk36g+v/Bzc3B7iOXRspdu1gLilzslTwBFT9ELz17M=;
 h=From:To:Subject:Date:From;
 b=H2VbSLjOpF60PvAY876ASCbGqDUuzggnuRkPzfR379gn5iwC+t3/TlhRBjX3PV533
 rhx7azc50CPtLC8lSfv4hOTpV5KjT1PvYTR3ixdqYUM4ntpFMeWi1Tz378g9Xj8R37
 lw6Whh+9N0Jk9KwBYNTnB1OHeOEEDuLrg1zAfQP++PiRdJVKxF0yBTUJs8VApr2oMP
 5xWAn2Tuky1SprY0/cHMEU/oqmZYogV7paMavG2Q8byZNS0PBuZlF5pL7A/RK45BMi
 uWVe1AujyM+V+QiWNKNSd/BXThgY9W6X0HduiJrMS1pQHDubcw1iwxSzUXemAK7Tl/
 d3Y3onpiNRM+A==
From: Vagrant Cascadian <vagrant@debian.org>
To: u-boot@lists.denx.de
Subject: Licensing discrepancies or ambiguities
Date: Tue, 21 Nov 2023 11:10:57 -0800
Message-ID: <8734wyudku.fsf@contorta>
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

I've been reviewing the copyright and license information for Das U-Boot
in preparation for uploading to Debian, and found a few surprises.

 tools/libfdt/fdt_rw.c: /* SPDX-License-Identifier: GPL-2.0+ BSD-2-Clause */

I *think* according to the SPDX spec this needs an OR or an AND. I also
see no copyright declaration, although maybe there is a standard
interpretation for this.

Similar issue with (though thankfully they include copyright
declarations):

 include/bloblist.h:/* SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause */
 common/bloblist.c:// SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause
 doc/README.ubispl:# SPDX-License-Identifier: GPL 2.0+ BSD-3-Clause

This one has a non-existent license:

  test/lib/strlcat.c: // SPDX-License-Identifier: GPL-2.1+

No such license exists, though thankfully it references the exact file
in the original glibc sources it came from, which is listed as
LGPL-2.1+.

There are certainly more ambiguous issues, but figured I would start
with those!

live well,
  vagrant

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRlgHNhO/zFx+LkXUXcUY/If5cWqgUCZV0AwgAKCRDcUY/If5cW
qk3wAQCw3GXw8oti8xdO89n1Lm6SvpETrM45IGMgY04rmnNGIQEAlz8MMJ+UYcxO
9/sEJpA1+g5YGZ2+k/H7FFFDhgYaPAA=
=t5Ri
-----END PGP SIGNATURE-----
--=-=-=--
