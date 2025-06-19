Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA05CC7115E
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 07:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB4082BA1;
	Thu, 19 Jun 2025 09:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4180282CBB; Thu, 19 Jun 2025 09:35:33 +0200 (CEST)
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F39BC82B18
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 09:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=eb@emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id A72585F850
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 09:35:30 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: u-boot@lists.denx.de
Subject: Was plain U-Boot affected by CVE-2023-39902?
Date: Thu, 19 Jun 2025 09:35:25 +0200
Message-ID: <5896532.DvuYhMxLoT@devpool92.emlix.com>
Organization: emlix GmbH
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6166297.lOV4Wx5bFT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Mailman-Approved-At: Thu, 19 Jun 2025 09:51:31 +0200
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

--nextPart6166297.lOV4Wx5bFT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: u-boot@lists.denx.de
Subject: Was plain U-Boot affected by CVE-2023-39902?
Date: Thu, 19 Jun 2025 09:35:25 +0200
Message-ID: <5896532.DvuYhMxLoT@devpool92.emlix.com>
Organization: emlix GmbH
MIME-Version: 1.0

Hi all,

for entirely unrelated reasons I came accross CVE-2023-39902:

> A software vulnerability has been identified in the U-Boot Secondary Prog=
ram
> Loader (SPL) before 2023.07 on select NXP i.MX 8M family processors. Under
> certain conditions, a crafted Flattened Image Tree (FIT) format structure
> can be used to overwrite SPL memory, allowing unauthenticated software to
> execute on the target, leading to privilege escalation.

This links to https://community.nxp.com/t5/i-MX-Security/U-Boot-Secondary-P=
rogram-Loader-Authentication-Vulnerability-CVE/ta-p/1736196, which links 4=
=20
patches. The relevant one seems to me https://github.com/nxp-imx/uboot-imx/
commit/0746cfd931de8f7591d263ff60dd806ffe23c093, and for my limited=20
understanding the actual fix is the first hunk.

A similar change has been made in 6039e0edc8540bd2a ("imx: hab: Simplify th=
e=20
mechanism"), so I wonder if this is just an unnoticed instance of the very=
=20
same bug?

Opinions?

Regards,

Eike
=2D-=20
Rolf Eike Beer

emlix GmbH
Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
Phone +49 (0)551 30664-0, e-mail info@emlix.com
District Court of G=C3=B6ttingen, Registry Number HR B 3160
Managing Directors: Heike Jordan, Dr. Uwe Kracke
VAT ID No. DE 205 198 055
Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
Office Bonn: Bachstr. 6, 53115 Bonn, Germany
http://www.emlix.com

emlix - your embedded Linux partner
--nextPart6166297.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCaFO9vQAKCRCr5FH7Xu2t
/K3gA/9KP3uLU5NyVsSXCwoXi9lnTy2lW31AXhaDmG+gYcUjGV1DWI3wp+1cHJ7T
FE5jfWLfvV3vp5qwCQR7HS16O2eOH8WLMFsg8YmeovAYz3zxb6+yWYRKi7FwCD3y
zfK9OOKXwonyt/XV4PgYUwOUpuFOctUNQuHyktZhanONPWKjOw==
=57LA
-----END PGP SIGNATURE-----

--nextPart6166297.lOV4Wx5bFT--



