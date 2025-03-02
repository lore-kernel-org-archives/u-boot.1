Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D49C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 13:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0041806FC;
	Sun,  2 Mar 2025 14:03:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=cknow.org header.i=@cknow.org header.b="UQQ4ynJs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B38E810EA; Sun,  2 Mar 2025 14:03:34 +0100 (CET)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE81A8058A
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 14:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cknow.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=didi.debian@cknow.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
 t=1740920611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tOBe/f5s80zrx/f1e2XVcrB6UiZyDQ3foCdKq9iq/v8=;
 b=UQQ4ynJsLfwMH6scqNlHZjPvA0TFFhsp6WQTjQPUC8D9I2JoSyAY1Pij3oh3hgfE8ZpEkM
 xTEedc5IY6AesT9nu41ppPV31l1xbA/IVXZHBXIto3kWolHDyvMX4UCLEzXLHrENDa8teP
 uGzNAQqTN+erfnHDcc59o36B5/BjM2/NlCI06xguFu36glJ2+ZtXW7HBUGOHezfxfumqJz
 gkNr2Mp7sTGosQba8VzRKYgb+5C1xnyELZDKCl6YI7XHsNHMPdIjKakhBhV3fy1NMI9vMA
 63gL/XK2vfcUW4TFI9Q/pPwwablGKMVX7Ob873PLGEnid2Gupm+nLsU6czb34A==
Content-Type: multipart/signed;
 boundary=29d28975ee63ed6c1c9363ca98a64fa0cc715cf23d059d3ae386ec685d71;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Sun, 02 Mar 2025 14:03:18 +0100
Message-Id: <D85SUHXWUOHV.3EHRFSHX9JETT@cknow.org>
To: "Sean Anderson" <seanga2@gmail.com>, "Tom Rini" <trini@konsulko.com>
Cc: <u-boot@lists.denx.de>, "Simon Glass" <sjg@chromium.org>, "Matthias
 Schiffer" <matthias.schiffer@ew.tq-group.com>
Subject: Re: Invalid SPDX License Identifier for test/lib/strlcat.c
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
References: <D84TW4NT583H.3Q01V3X7V3AX4@cknow.org>
 <db205890-ded8-56e1-6568-486945eb109e@gmail.com>
In-Reply-To: <db205890-ded8-56e1-6568-486945eb109e@gmail.com>
X-Migadu-Flow: FLOW_OUT
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

--29d28975ee63ed6c1c9363ca98a64fa0cc715cf23d059d3ae386ec685d71
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Sat Mar 1, 2025 at 3:54 PM CET, Sean Anderson wrote:
> On 3/1/25 04:39, Diederik de Haas wrote:
>> The file ``test/lib/strlcat.c`` has "SPDX-License-Identifier: GPL-2.1+"
>> and that SPDX identifier doesn't exist.
>> As there is no indication this was a typo it needs to be relicensed by
>> the copyright holders AFAIK.
>
> As noted in the comment, this is adapted from glibc. The referenced file =
is
> licensed LGPL 2.1+. So license in this file should really be whatever the
> compatible version of the GPL is (I guess 2.0+).
>
> --Sean

IANAL, so I searched a bit which led me via SE [1] (and answers further
down) to the GPL-FAQ [2] which has a link to footnote 7:

  7: LGPLv2.1 gives you permission to relicense the code under any
  version of the GPL since GPLv2. If you can switch the LGPLed code in
  this case to using an appropriate version of the GPL instead (as
  noted in the table), you can make this combination.

So I'm guessing you're right.=20
FWIW, all the other files under ``test/lib/`` are licensed GPL-2.0+.

Cheers,
  Diederik

[1] https://opensource.stackexchange.com/questions/5664/linking-from-lgpl-2=
-1-software-to-apache-2-0-library#5756
[2] https://www.gnu.org/licenses/gpl-faq.html#AllCompatibility

--29d28975ee63ed6c1c9363ca98a64fa0cc715cf23d059d3ae386ec685d71
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZ8RXHAAKCRDXblvOeH7b
bmn+AQCbWmR6GugfY+62r2HAluW41MTg1veGCycoI8UdLAKuTgD8DCRUjklZOIrm
JLNBhAdlUlGiASaoEPJuyiZW2ewkJAU=
=PJhI
-----END PGP SIGNATURE-----

--29d28975ee63ed6c1c9363ca98a64fa0cc715cf23d059d3ae386ec685d71--
