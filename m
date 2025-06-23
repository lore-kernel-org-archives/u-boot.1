Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A6CC77B7C
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 20:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 622568210D;
	Mon, 23 Jun 2025 22:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DzUBW6Qc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C863E81E13; Mon, 23 Jun 2025 22:10:49 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55CB182D83
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 22:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2e9a38d2a3aso3556669fac.3
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 13:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750709444; x=1751314244; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S1KKdtFFg4iPTpDGrMCN8qz4EWqOv6UOBy2CcQ7fTW8=;
 b=DzUBW6QcXWm1XMf7ZEClLypT3N/sAjdGHmk5zNVc63DTtbA4oau58oddGZz1fJm73N
 /pSdY6yzxEAF3K1fzEqE1rZEZvSdq7vUUYAbNgaukV3I8igmtgIF/9taRpjcrgKJUqcI
 xm8oB0eDtmd1CTmK3cP9RfDCAxHugft+xbrlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750709444; x=1751314244;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S1KKdtFFg4iPTpDGrMCN8qz4EWqOv6UOBy2CcQ7fTW8=;
 b=CPe435x4TZ7yOYzmzwn+d/YtvDnTtdgW0u34vni/Ri/PNQQG/4rmb5pqfNONYQzFvu
 ul4dabCRUNT8cxwEYNZXSywaCd366Q8Nmy1TYG2V3q9m72LFZmUP8zAdCpR8Mx/SFjUB
 xZSwNkiOiFsRrTv6tmHyN+5DoJcXMwbMm9yhq4ZEtWGgLO5zbLFh4xc8omkge7IXtxm8
 IIt2Z+EMAsSjNsHpcfmFt1BBhdPY0t5ZUTvxm03tUZyv1FJoLnxRV4bsNmyQe3EZcTO2
 EGqv6WpAIO41RHg0FEX8WDL8l3nQAWawnlWIeYLBs/S5VoRG8/ZB2gWLjEyyxLkUuhAp
 o9WQ==
X-Gm-Message-State: AOJu0YxIMXo4lEehg1ich+2St3ZRhMYDIe7+AR9quR0I6aXzcUJWdNGO
 ATIEY8AowvUO0IjmMDnD4H25wCBbBzQ1Ype7ZfHI3Ozps7M3tGHut5JiB5glNMEYqdlDlkkgocB
 UJ9OmqUY=
X-Gm-Gg: ASbGnctOUONmQIe3YkCZ6VYt5S7Ow2gLwI+Pa+LoSY/3UixYxuHKw3pD1Rm+C0L0HvU
 AcH4tcNGnd9oGVmf7m1CLchX8JtVIZU4b1NuusCeGKZSwQnoHM/WLu7TDzv2MW04OLuFNaz5g/U
 eMv7rjo9VEsbVVfkAamVTLc8LOEcgbvwpl/4UOiMNkld9/paBr1VoW9wKrzxfv7dv94pO3SWHBk
 4X1dtQolQrX30pLttdbslTf+gDP9VzO5+9nxM+gdaoc6FSaUKWX9iR99iukQOCHjdm1ARdkhx2l
 pXDvCYouS6sON6RfL75X+2IFVr0KrpWScnI7tBQ7QB7zjfxOwAoVmZFq6qRnYSIoRSJ1ghn+1ru
 niXqTmEa4hlUghkGCZiBQVf8=
X-Google-Smtp-Source: AGHT+IEZfS7KFqoG3/Q1CWnZlrwWBiVQalN57n8vsc/ZN5Sr1vDkGtqltPk0DyN9wiJENtFM4LXIRQ==
X-Received: by 2002:a05:6870:ce88:b0:2d4:ce45:6990 with SMTP id
 586e51a60fabf-2eeda55dbd0mr8777157fac.7.1750709443933; 
 Mon, 23 Jun 2025 13:10:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ee8a8ea97dsm1787114fac.29.2025.06.23.13.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 13:10:43 -0700 (PDT)
Date: Mon, 23 Jun 2025 14:10:40 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.07-rc5 released
Message-ID: <20250623201040.GF4003484@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="deZtbhxshNCqa07h"
Content-Disposition: inline
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


--deZtbhxshNCqa07h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and so here is -rc5. I will be merging this to the
next branch shortly and pushing that out as well. As the next tag in
two weeks is the release, anything now should be either a clear fix or
clear documentation updates.

I also want to repeat the link I sent out last tag and thank the people
that have reached out so far, but I hope we can find more support still:
https://lore.kernel.org/u-boot/20250602222738.GC100073@bill-the-cat/
In short, I think for the overall health of the community and the
project I need some help from others in the community, on not strictly
technical matters.

We're continuing with a community meeting following the release and is
the same time as the previous meeting. The meeting details itself are:
https://meet.google.com/btj-wgcg-euw
June 24th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

In terms of a changelog, roughly:
- Assorted regression fixes against earlier parts of this release cycle.
- Assorted platform and infrastructure fixes

As I said above, the next tag is for the release itself on 07 July 2025.

Thanks all!

--=20
Tom

--deZtbhxshNCqa07h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhZtMAACgkQFHw5/5Y0
tyydQAwAuSyIbX/bG9MkvhsY+aqnkYGhXdmJqQnffPNMiE4FHj0aEPW5Bs7ru/NS
Pe6NuUClcIdDBVgQxOOkctRP3Xm6s5qTNEizogCBtP5CkWu6zic1V8GxX5FGcHvM
iyFNei0sFOJ9mJXKjrTD32Js2F+/eYS8ZOycnZyFKZenWf/lj5cWsdXsBFDt/Ge0
xgJNBodbyaE/tEONASClcj5WO8/rXzINN/kfRhMZeGgjNQ35+leEynr+pRqimNSE
/91/eTsaXWuY7RFcRI7LLkQPo32mHCDjlH3nzLuE0JFqtmLoZaOMgDRucZMSaRTI
jYByUzv2ECYNhvQzn0KyV1fZzmHkgldJg+TnxOa1raHVurlpLpkOkcaUtqGmIq1C
CBxt+V1Eo77E5dv7reBHG/tKHMv2ccxieoMoI45Dz1QUCv+/eFrcFDsjAq09acYy
wojNzLydDmZP36s75w81nvZfyHHJIGzzOH8OJwcGC8DRikIYClWUZVVPHcfhnEAc
fpZUvkMF
=JkoJ
-----END PGP SIGNATURE-----

--deZtbhxshNCqa07h--
