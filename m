Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E90C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C7C80944;
	Wed, 23 Apr 2025 16:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lOArBvAE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01E8480944; Wed, 23 Apr 2025 16:56:44 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61CB28070C
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 16:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72bb9725de1so1459373a34.2
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 07:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745420200; x=1746025000; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=heP9YC4KeP4Epl0CkF1Y/1c4ht3/PC9jbujbp0F1Nu4=;
 b=lOArBvAESmBpW3r4xWj+605DCfgGUmr83Lah9gJflLGal84PDOgWe1Su8yjcgOaU21
 fbrGxtGq9P36q7IVS5XQIXxbCy5EDZXQsCIBaJ9MCOlMSA+wdKvotvH8bTJHLiWeVNvI
 DglKZLzzCTntGPd4xQB1cJnBBwHRP0j3J1/iA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745420200; x=1746025000;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=heP9YC4KeP4Epl0CkF1Y/1c4ht3/PC9jbujbp0F1Nu4=;
 b=mhFT0Iibw7tN5IQ2s1RsPloTVKVCBErknLs8Orfvtn5qPMjiDLkuoqT22ls6az7ldZ
 IOnTy+i7dWsSYQd5+ZVzv6qO12IEv4ys5yi4x5iJA2kzWGnDf/oYsa+7V+7SwrcIVQLn
 HAxjReQMdAQc23Xsq+JlTtKPWtnC8qeOq1JrFBHTzbYYY00Tp8LZT2khfk85BSCppEK6
 dky1L/3R/ucKoebQQfSGXC6lLCnclSp/HInJMwoapa/9aO86BMk0g33RMPL8XabsdH5x
 DER6NF4ogart1z0IZFXIaZkTJgPlhZblkuZzYLzt+WmCQUzlP74yKUbyagfZzVdpZwh7
 gn8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE7IDYksbdlJghdn2mYDGbax/018gLHkTkWr6NTBLT4I4xyq+s2PRyCkXSPTqVsJ6DEjs9KoU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzlz3FxtDnoWNjlmAqs/zBONAeq83cuiy/rscwTVp/PSHv3eDTd
 Enbk9pzRoFwiJFj4PifBW9TbHJsJ6KksLG6BMYRJ9XPkzy3mnH1CE6FYsZ7Hsy+vo7SlbGElgTI
 BJko=
X-Gm-Gg: ASbGncvURdUbjpLp/ISMcu58ploreuKWVI9gZwwjsV6KiGhLtw4TzhzuFhvjhXtfRf5
 WigUddvseUaTNaoqaDVwkC/ds1pduRjRJtOUiRwL/bX1iYVHsHgAPVpUS/EiLsH95juo0oElJf8
 QQPWyG0BcR+S+VnghjdRH3SN5pGQEakKTqDsCMohDRt4YHZBXwKDigLDMR0bI4aI96Ls3p0ll10
 ih+JAVG5i7OgcI27UngdoR4ZD+a2CBaGiXKGAO5fThiAQuiv5BJaIaOgbCh9J79P9FahVV1wLu+
 xAn9RXJZE546FXyMSmQiZUeWwexzY8pB1lQUnIK0sAWaq/W2nAkIgonz+T7HDhslglttPPVeVWi
 BOA==
X-Google-Smtp-Source: AGHT+IFR0rWQ8USjuwi/QOmJFVMYEhX5/jSGd08CL2MYo/IE7Wu1d/KZnXLC6JKguh6mhbYPzBf+Kg==
X-Received: by 2002:a05:6830:64cb:b0:72b:8785:890 with SMTP id
 46e09a7af769-730061f2e40mr12713739a34.4.1745420200084; 
 Wed, 23 Apr 2025 07:56:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7300478ee02sm2493025a34.14.2025.04.23.07.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 07:56:39 -0700 (PDT)
Date: Wed, 23 Apr 2025 08:56:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH] Dockerfile: Simplify applying cadence_gem commit to QEMU
Message-ID: <20250423145637.GF5495@bill-the-cat>
References: <5061af5aef7e964431679bee94b7ccfd2579e521.1745412278.git.michal.simek@amd.com>
 <b6e719bc-58dd-46b1-a4c5-79f2a8848358@gmx.de>
 <678c1b23-402c-45f3-95c2-96bd3ca3d240@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="76clxLHL9EtWaTmy"
Content-Disposition: inline
In-Reply-To: <678c1b23-402c-45f3-95c2-96bd3ca3d240@amd.com>
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


--76clxLHL9EtWaTmy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 03:50:35PM +0200, Michal Simek wrote:
>=20
>=20
> On 4/23/25 15:42, Heinrich Schuchardt wrote:
> > On 23.04.25 14:44, Michal Simek wrote:
> > > No reason to call format-patch and then apply it with git am. It is e=
nough
> > > to cherry-pick it directly like it is done by commit 074bfab54d83 ("C=
I:
> > > Cherry-pick reset support for m68k for QEMU").
> > >=20
> > > Fixes: 50a907edbb2c ("docker: build QEMU v8.2.0")
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > ---
> > >=20
> > > =A0 tools/docker/Dockerfile | 3 +--
> > > =A0 1 file changed, 1 insertion(+), 2 deletions(-)
> > >=20
> > > diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> > > index a0fd174ff602..0aa9d3ab3a84 100644
> > > --- a/tools/docker/Dockerfile
> > > +++ b/tools/docker/Dockerfile
> > > @@ -222,8 +222,7 @@ RUN git clone
> > > https://gitlab.com/qemu-project/qemu.git / tmp/qemu && \
> > > =A0=A0=A0=A0=A0 # config user.name and user.email to make 'git am' ha=
ppy
> > > =A0=A0=A0=A0=A0 git config user.name u-boot && \
> > > =A0=A0=A0=A0=A0 git config user.email u-boot@denx.de && \
> > > -=A0=A0=A0 git format-patch 0c7ffc977195~..0c7ffc977195 && \
> > > -=A0=A0=A0 git am 0001-hw-net-cadence_gem-Fix-MDIO_OP_xxx-values.patc=
h && \
> > > +=A0=A0=A0 git cherry-pick 0c7ffc977195 && \
> > > =A0=A0=A0=A0=A0 git cherry-pick d3c79c3974 && \
> > > =A0=A0=A0=A0=A0 ./configure --prefix=3D/opt/qemu
> > > --target-list=3D"aarch64-softmmu,arm-
> > > softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64e=
l-
> > > softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh=
4-
> > > softmmu,x86_64-softmmu,xtensa-softmmu" && \
> > > =A0=A0=A0=A0=A0 make -j$(nproc) all install && \
> >=20
> > This change looks good but we should move to a newer QEMU version inste=
ad, see
> >=20
> > [PATCH 1/1] Dockerfile: use QEMU 9.2.3
> > https://lore.kernel.org/u-boot/20250418025743.529973-1-
> > heinrich.schuchardt@canonical.com/
> >=20
> > Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>=20
> Definitely much better. v10.0.0 would be also good one because it has MB-=
V enabled.
>=20
> Tom: Feel free to ignore if update patch to v9.2.3 is applied.

I plan to move to at least v9.2.3 soon. I see v10.0.0 was released
yesterday. Perhaps we'll get ahead of the curve for once and update
sooner rather than later. Heinrich, would you mind redoing your v9.2.3
patch as v10.0.0 ?

--=20
Tom

--76clxLHL9EtWaTmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgI/6EACgkQFHw5/5Y0
tyzi6Av8D+4+SA4rSD/AhUxhx3xvwylKd+xVAz/CGDeEYWhH/M7BZmn07DOfn2ZK
ZsFYHVhWaNDXGwEQyQBkI7TaPi8knJsi/IfpuuFS3HPCyvwZlI83uAylaiHhX6Yo
3AP/ELZvwlhR7ztzvOmRGlwd8XSEdbGJ6FpEhlVHizPsSkr2Ux/msq3dhnDrgYBv
fFSQ+pVs4dyAV9KOGw5cg0nTs1PTayYajnQYhGMU6hPQIMoPf32XpU/+WU+285C8
scB+f/IzhA+sqHu3vDACzcjIKQ4vow2chHQNECKVW0/7pca8TyCxjD4Tqii3WTWs
mHwFph0DKtkWmoXcNewkOgEy+l1ESUY8Vtm9VS0xxAo7RGrd+1oFRIXtFDRKMqbG
tGoKa6p1M4coC6Sr2uTOcsXTForIgJr2h3iW/9KkIcpZwsgF0G982gcl79FVpb4L
93b33ziEZrfJQLAK+XoCPv0fL3ZB6JftszJj13xg1YxNEDF2tD2y5y1eDZG2MFee
H6ddAOYh
=QLSI
-----END PGP SIGNATURE-----

--76clxLHL9EtWaTmy--
