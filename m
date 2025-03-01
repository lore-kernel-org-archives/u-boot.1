Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FEEC021B8
	for <u-boot@archiver.kernel.org>; Sat,  1 Mar 2025 13:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D4F810F4;
	Sat,  1 Mar 2025 14:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=cknow.org header.i=@cknow.org header.b="Lgu77+GS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA5B1810ED; Sat,  1 Mar 2025 10:39:59 +0100 (CET)
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com
 [91.218.175.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 501A1805D7
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 10:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cknow.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=didi.debian@cknow.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
 t=1740821996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=H2quwtugvJBXbrEIcNvyahuk6subluO5oUrQxI7ZFTg=;
 b=Lgu77+GS/OsqHZ2y6L602Db/m/PUlgvifnFPyYALfQhA4vwXQBrl5u0R97GkXqMQla8pYj
 1eocmPyWxWk5Z12VHycMa7ZaQFL/M6V+ZbmkNRhY6tprBG77OYKH6f0Qz+zD0ejxFQriu5
 MzuLdiArzh1Dlvl5a/7ZyLtiLi4SX2XtIhT1LTt4OSxwKxE0hU22gJAmUEI18Pvuz7B+dv
 +PjO07YAU8X4GvCjqfTT+rdHhIkTYnkytsqgWBnkW2EeuQZPk72VfVxUTEJ4qw7qbl5HCf
 7QZ2tY3ZKEIRavx+LzG5wsRGIcHzwbEteyoMEIa1O1l6gXYYbs63/+sEoc8otw==
Content-Type: multipart/signed;
 boundary=591add8c91739701c2117ee90c3696144ab00c8fab4c5325bc574707f358;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Sat, 01 Mar 2025 10:39:47 +0100
Message-Id: <D84TW4NT583H.3Q01V3X7V3AX4@cknow.org>
Cc: <u-boot@lists.denx.de>, "Simon Glass" <sjg@chromium.org>, "Matthias
 Schiffer" <matthias.schiffer@ew.tq-group.com>
Subject: Invalid SPDX License Identifier for test/lib/strlcat.c
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Sean Anderson" <seanga2@gmail.com>, "Tom Rini" <trini@konsulko.com>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Sat, 01 Mar 2025 14:07:30 +0100
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

--591add8c91739701c2117ee90c3696144ab00c8fab4c5325bc574707f358
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

The file ``test/lib/strlcat.c`` has "SPDX-License-Identifier: GPL-2.1+"
and that SPDX identifier doesn't exist.
As there is no indication this was a typo it needs to be relicensed by
the copyright holders AFAIK.

Cheers,
  Diederik

--591add8c91739701c2117ee90c3696144ab00c8fab4c5325bc574707f358
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZ8LV5QAKCRDXblvOeH7b
bpdbAQCF79VGgyyUhNyKktZGMCyVcevro/v8Zo4bXn8KafYIkgEA4ji75fFO/HWy
YtIyi/bedT2cZNXi0nyjqfSZITOnbQQ=
=a882
-----END PGP SIGNATURE-----

--591add8c91739701c2117ee90c3696144ab00c8fab4c5325bc574707f358--
