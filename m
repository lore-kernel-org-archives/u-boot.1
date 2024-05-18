Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43F9C25B79
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 00:08:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F47E885E2;
	Sat, 18 May 2024 02:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oD9453rK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A34B1885D1; Sat, 18 May 2024 02:08:39 +0200 (CEST)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3C8E885A0
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 02:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4df3d4f0bf7so402416e0c.0
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 17:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715990915; x=1716595715; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RjllgxfuCHZzbk6Arb0PGUb1KUIFJlxTbfp3dsikWfA=;
 b=oD9453rKeVW4mOTvh4Io1qSlEi3SzCHiTjmhPeyjIPgkXAiKjsCuElk+WBDb1qa87J
 zDC9EoE5coj8N4qZgQykFZWAZ9vVOygcIlg+CoVGyRwX6pCaazsOG1GiSoAQHrcwZkY5
 rVJpcwR3aHdz6NJ4AWgnIxuu8u3L83yp3E9hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715990915; x=1716595715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjllgxfuCHZzbk6Arb0PGUb1KUIFJlxTbfp3dsikWfA=;
 b=F4jBSAt+YnX63MkF1O880Eojqb2xHI4xSMnOsHHP8fsPTEPfhSvIhbnZsYxIfsU2gm
 qaC2n/ja4Zt6IFXO/TqkYFoBKi7zfh/BJIDLRAyq3Ds5uGOj77LHEr9nRSmEFGMZXMC7
 jb3JQCc6nDWjsQ8ugfNxFC07LgM1hYl9/zrOYuAg2iGpuIosyOKavdACyW2ZX8O+N/Hz
 +iqF4xIJb8FAgEVYiPAcAQ13SGpVYwgXcvArmvjQAq+dZOQulxce2AnBv6G+wr4c8kD8
 84ww+hNmQZfSjaEzYfTqk8wXVbvIXP+7t4xbHFY1PgnJpjfsFsZ5flv+0eBixZ/4ZphO
 yGQw==
X-Gm-Message-State: AOJu0Yz/LFs+9Hs/QJVWpRG3UbXh59of2ehQKNQH+8gtvw01hng1jixY
 R75jqTtEfonvuhbsJ1ElHeS4A6z07GQjD3YYGbnk1XoVAyelS0VhRHeKc0H+wkE=
X-Google-Smtp-Source: AGHT+IE2Ttzw8YaKG3PVZVeWfkhnxH3IJ8lEdSQi5IkWIZmabKGi4NUhFjbPmwp/RjUJltd3ON5KNA==
X-Received: by 2002:a05:6102:160d:b0:47b:cba4:42d2 with SMTP id
 ada2fe7eead31-48077dcfc17mr23346286137.6.1715990915568; 
 Fri, 17 May 2024 17:08:35 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1797ebsm90155466d6.4.2024.05.17.17.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 17:08:35 -0700 (PDT)
Date: Fri, 17 May 2024 18:08:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Bin Meng <bmeng.cn@gmail.com>, Rogier Stam <rogier@unrailed.org>
Subject: Re: [PATCH] Init virtio before loading ENV from EXT4 or FAT
Message-ID: <20240518000832.GO2568172@bill-the-cat>
References: <20240501085409.3457803-1-fiona.klute@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v1gBzlX/yzbimu7e"
Content-Disposition: inline
In-Reply-To: <20240501085409.3457803-1-fiona.klute@gmx.de>
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


--v1gBzlX/yzbimu7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 10:54:09AM +0200, Fiona Klute wrote:

> Specifying a file in an EXT4 or FAT partition on a virtio device as
> environment location failed because virtio hadn't been initialized by
> the time the environment was loaded. This patch mirrors commit
> 54ee5ae84191 ("Add SCSI scan for ENV in EXT4 or FAT") in issue and
> fix, just for a different kind of block device.
>=20
> The additional include in include/virtio.h is needed so all functions
> called there are defined, the alternative would have been to include
> dm/device.h separately in the env/ sources.
>=20
> Checkpatch suggests using "if (IS_ENABLED(CONFIG...))" instead of
> "#if defined(CONFIG_...)", I'm sticking to the style of the existing
> code here.
>=20
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> CC: Joe Hershberger <joe.hershberger@ni.com>
> CC: Bin Meng <bmeng.cn@gmail.com>
> CC: Rogier Stam <rogier@unrailed.org>

As this problem was reported by another user:
https://stackoverflow.com/questions/78490686/custom-u-boot-writes-to-enviro=
nment-file-but-cannot-read-from-it
I've decided it's worth pulling this in now rather than for a later
release via -next, so, applied to u-boot/master, thanks!

--=20
Tom

--v1gBzlX/yzbimu7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZH8YAACgkQFHw5/5Y0
tyyJDAwAojy3LOBo2FPzwdvGoMvqP1YVKznSPQWFg7yK3e5F1cukUYZYWDqJsDfl
JNm3L5KITYgK59BroEA6SJahvOdyINxXKwK9X4+mEhW8azPKs8avSj1x9qiWx4zZ
NKbDANrw7c/09mntbO5o9gSJANK3p+bOIo63zieeGXs1/zdaDH13djO7XGUcMrnO
Jl0ISEbbprnMPjuZKQt0EknE8PPqnmuT3RQ6F033vxD3kHOVQ6bBRiKwbSXQHBC1
8bBoXJsjdlFoBur/fWBvhZsaykiw9ixRKHbrfOvDSxcl1GfHqA6BWI8AK//Wa7Rz
U+ctnjlNKAAw8UYLh5WM601YSt5mofK5tv5bMXY0k+xonFPZFQOTAsZJB5hHbtLA
AErEqVAyG5TIdfW88znsvuGJao5GiesgQV/eThJZDb5gEL7RTm8kRHv5ch8TWlh6
1bGQLkkXpkelZuAr7AA9KGq0aCPMQj6ytn3Zms0Fm0/iQndzx2l/9b3Pi7Qs250T
GNE3YlO9
=0FCD
-----END PGP SIGNATURE-----

--v1gBzlX/yzbimu7e--
