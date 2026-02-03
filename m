Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E32E87834
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 14:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E73B844F5;
	Tue,  3 Feb 2026 15:57:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F0Z15fmv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BF558405A; Tue,  3 Feb 2026 15:57:56 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C97844F5
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 15:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d18f80b5c2so4846628a34.3
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 06:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770130673; x=1770735473; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2wVtectlz5H+QRLFmve/7eG5C7EVa1AEJn9daDs0/+M=;
 b=F0Z15fmvKKuyziF4VfXpeiO8jANvNc/RCFYzyAhXvQRsULpalpxTvBKcYDKwlahQPY
 e7DL2n7AtqPqrLGghYM2ESy5BOSSWYa3KUqAULGFGCeYTh5k72du/Xx1GcEdqv3BB0C5
 bomwKFMSdrzzLRwgJKIZQWDNqpKmYcVGCfM+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770130673; x=1770735473;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2wVtectlz5H+QRLFmve/7eG5C7EVa1AEJn9daDs0/+M=;
 b=Rk7+KEdBOvmbiht0sgpT2jVWHjru6m/XcvXrOFj/uD4KVl5TK3yKnI0vY3QNr+duJi
 0c/tiD1iRDt8yQec0m22ytoUXaQmnOvf5RtevP1OQfvBOZRsfKdFEGyeW8FgwfqV+Qpp
 D8hsKi9gxXjZ0nfb8l8+B4tIjobRWWQPBNIeRk28Uw7nBRfCUM244dEanRVZV/rQBdBH
 GcMKwnHFgooxyfW4CmwZ8Yz7sh3FzOb0Nej38p23gFWqIpndABhWeEUOZqKjVzupeXeW
 srQSVdACwIjvOqi7VC1jedSEEOvmM8vr64zNfhM/KuS9JzTpUKKXclX88WmlggvDmTug
 ta3w==
X-Gm-Message-State: AOJu0Yw9+bUG1KtwEPSwO+t2M0KGqVzhxbq8U+aYHtbtK8AdTBeilYGz
 sds44MLaWFATbMPpo5a5gtlzvy/iwfe/BJkD9ywp57mFXD8GDIw7rD4qEDp1e5JD/+0=
X-Gm-Gg: AZuq6aI16XHpO92N0uDymNbshy7D9GsWp6gDPCgPxyOkMBlugs236gXH+iSnTk9bQBQ
 O+cdb3OjqKPxBAH5ETd5urgY5bBuddPfrSM+1kOhRoiUlY84ewIfLi4i1tIJV523H/Gg0WYTdBT
 r/YryjCeZCx4XvcvKuAWZXRJhrGlHYRnCR7Ouo4C6YHoMojGOY3BidrLXQ4RwhZCfs/+OV++utK
 57Q3Z0yGYFgPmstPvH9Ni/YhRXtNmJk2Bx1wWdXtK5moSVovYCqpshO9KEe9Ob1aR3Qn0xKxo/a
 zVd0/HCExNKHvcdZ2DcpnMLFEi/NkZpnsdxBTiLTyna1qd1OjjVANS8kTau+9EQc9x6vl1YYfUS
 iY0edINHPpHQQt1eW0Tw2GKBUJUIYxghV4DmEt/oIQ5v+I0vzshuXQUs65jiSYBkGtc4cQKHXYp
 dn3KNd8aWSRjDPRX5/O7IYh7SS9K6lQltPjOeHnUERhRE0iAvLrkeCgtpJQgzY1yD371Yze3Mc2
 Y/qHc1SDGTvudLrnp8eeXXB6IGHkGFL2+kXOm0=
X-Received: by 2002:a05:6830:dc6:b0:7cf:db0f:c824 with SMTP id
 46e09a7af769-7d1a536a293mr9191400a34.32.1770130672982; 
 Tue, 03 Feb 2026 06:57:52 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d18c6708e1sm12695878a34.5.2026.02.03.06.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 06:57:52 -0800 (PST)
Date: Tue, 3 Feb 2026 08:57:50 -0600
From: Tom Rini <trini@konsulko.com>
To: dinesh.maniyam@altera.com
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>
Subject: Re: [PATCH v2 2/5] mtd: nand: add generic SPL NAND MTD loader
Message-ID: <20260203145750.GI2603314@bill-the-cat>
References: <20260203074721.25520-1-dinesh.maniyam@altera.com>
 <20260203074721.25520-3-dinesh.maniyam@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XW0zScy3bDa6iXXo"
Content-Disposition: inline
In-Reply-To: <20260203074721.25520-3-dinesh.maniyam@altera.com>
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


--XW0zScy3bDa6iXXo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 03:47:18PM +0800, dinesh.maniyam@altera.com wrote:

> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> Add a generic SPL NAND MTD loader providing nand_get_mtd() and
> nand_spl_load_image() helpers.
>=20
> This allows SPL NAND MTD loading logic to be shared across NAND
> controllers instead of being embedded in individual drivers.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>  drivers/mtd/nand/raw/spl_nand_mtd.c | 76 +++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 drivers/mtd/nand/raw/spl_nand_mtd.c

This is a good idea, and I'd like to see a follow-up RFC that switches
at least one other platform over showing that this really is generic
enough.

--=20
Tom

--XW0zScy3bDa6iXXo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYIM7QAKCRAr4qD1Cr/k
CgT/APwPo2YYGcQOHKQ8tAv+E6MyKmkSQ4h4KXEpeJtNe3VGWgEAz6giNtqw9/VY
4K2015uqmISWzf3cl3iZu6NT+WEZmgc=
=rGP2
-----END PGP SIGNATURE-----

--XW0zScy3bDa6iXXo--
