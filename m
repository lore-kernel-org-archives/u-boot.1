Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A47D2A538
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 18:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD42088D9A;
	Wed, 16 Oct 2024 20:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n3bbEN7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5114D88D91; Wed, 16 Oct 2024 20:06:10 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52A0988DBA
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b13b3fa372so8635185a.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729101965; x=1729706765; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LN1jRVLFsk87oe9QLdST/0NUZ6JdRWClw5WR3kcLQC8=;
 b=n3bbEN7Cs73iMun6gOzRLVzOPIZS7yY3gxjLPMoPpuCLrjwRlhxjFz44U3yd3seThO
 6FbgSTbBh4Xk4VP3I/2WU1687C4d2YCXhfdyYmlnw/RNsuu1r5MpqPQ9wFQa4mc3xi0q
 HXgXUOcL29w4ktJ6ysjoNLUXIyctGbBi6cAw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729101965; x=1729706765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LN1jRVLFsk87oe9QLdST/0NUZ6JdRWClw5WR3kcLQC8=;
 b=NBC77fPNrJLW/ffe4Q2EJ0Rb4GwwAN7oiK9mgRXKmYOxBwsVomF2SHo8hU8Mw7oxZj
 BBqsL1rwWHZzDT805/x7FCPBHfholoO0LkyBOVsxa2SB7123DZYgN05RUAo/aZ5oAmKk
 Ab0OFu8x0DN9yB83txQL1kjwyVc4acDcirTOs+3m0eaHf7WtJBgyXCcYCs11nwjahFSj
 /mNptnG8kEWBJBtYpszpt7yW7LC9XQdBbJhbQzJe0LsMqclP+jm/XhS+WFw6g245Ye9f
 c3agBzckwrZHn+z2J0o8iFEWUyZf2pqOkbNWzWiVGXY4Tp1QsbdYkgUVC+LJd+PoXNnr
 QFHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSi/bCSbE9K57K2kO2EBZX0FpQcbIuHgYB4E8tzX5FGTA+G3miOVZVydLnvLEd8Et/Lcquyas=@lists.denx.de
X-Gm-Message-State: AOJu0YxaL5V4RJ/pD0CVhSpJ3lth3OhMrSCM/feZXSW2JKDWaXqVFHg7
 joCV2gb/YsjQxBFMP0GqATRDtH4XLTrBBk5ZPtdh1LmJX1CNHMoPoqZ4obv3zeY=
X-Google-Smtp-Source: AGHT+IEpnYddZ3GwW6bvkxicjzskvFfwZbMMA7Cchi8sC82ThC2pD3y3phd9zCl+oRh1tpC1uD/IOg==
X-Received: by 2002:a05:620a:41c:b0:7b1:4579:80ea with SMTP id
 af79cd13be357-7b145798123mr227599885a.60.1729101965064; 
 Wed, 16 Oct 2024 11:06:05 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1363952c9sm211039185a.97.2024.10.16.11.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 11:06:03 -0700 (PDT)
Date: Wed, 16 Oct 2024 12:06:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Alice Guo <alice.guo@oss.nxp.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH 01/17] mailbox: add i.MX95 Messaging Unit (MU) driver
Message-ID: <20241016180600.GC4959@bill-the-cat>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
 <20241016-imx95-v1-1-f640c8f3bc1b@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h2sYjJMC/R946mmm"
Content-Disposition: inline
In-Reply-To: <20241016-imx95-v1-1-f640c8f3bc1b@oss.nxp.com>
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


--h2sYjJMC/R946mmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 03:17:54PM +0800, Alice Guo wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> i.MX95 Messaging Unit (MU) enables 2 processors on a chip to communicate
> and coordinate by passing messages (e.g. frame information, event
> notices and requests) through the MU interface. This patch provides a
> driver for i.MX95 MU using the common mailbox framework. Currently, SCMI
> exchanges on i.MX95 uses a mailbox transport with SMT format, and the
> harware used is this MU.
>=20
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
>  drivers/mailbox/Kconfig       |   7 +
>  drivers/mailbox/Makefile      |   1 +
>  drivers/mailbox/imx-mailbox.c | 417 ++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 425 insertions(+)

Fabio already noted the general MAINTAINERS missing part, but all of
these new drivers and so forth should be covered under some entry as
well in the top level MAINTAINERS file.

--=20
Tom

--h2sYjJMC/R946mmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcQAIEACgkQFHw5/5Y0
tyw4/gv/Z2HvEfCDYb5pNutv5HXGCFH2Oh6OgGNBcACG7j7otUtNa6lwT7Oe1Z+i
SZN1lviWno78/spBOnCLi+wLGcw0//CIB2oyi2H/umeDRhgng/myjjQBo6jfqf/C
Z5nfBSWYnhV4rVcuElSaOBBhnJeCm/TEJBJlOHiSD/dMavezHQprgtKYEylcEdWA
oUw4RKULwSFqxVkn5W1gSYYahkDFjZdg3tQk3E4R6o5M6p9SGRSS9z4IZuOhE9ir
bVM06YxvO1HQluNyZI/VVWlSO2ZVCnZXREPcmEGAd+CQfevzebUuCmcreKBvnRUs
u8P5YO0iCC1BSU41Dup4qCwr1jbyUgAC2DN9G4wV988RR5IkY0vlYSvX+aHgq0xg
O3Yt0dUPYJ0bd4+a2G+JDT8tkFxRQkIXkqiCr4YwKUGCD5aK4Vfq4EA9N7Nu3inU
n16UlQnNTK08A1pRkEWLuOnBYqBqtHO+aHc4x+Tv8kJEjN1yrRBlum84/tKVa/CW
+73KNGXM
=hot4
-----END PGP SIGNATURE-----

--h2sYjJMC/R946mmm--
