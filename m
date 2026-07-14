Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0698FC44508
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 17:38:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78AFE84D5B;
	Tue, 14 Jul 2026 19:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Uq8Wd1Qt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61CC784D5E; Tue, 14 Jul 2026 19:38:29 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D097384D26
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 19:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7eb1dc6bd53so2498851a34.2
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 10:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784050705; x=1784655505; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G3QmcTZDnkhVbjT6SbmPKrFF9alpK8ZzSJXeT1wLlCc=;
 b=Uq8Wd1Qt5sLBFCvUX3aB7Z7g7u3rofR0kq9nZe72BFYJnUy3cy7MSToIcCsFim14ON
 RLDX+yrnYfJ0NX7oA8ZQlZM6rrCfxHQDeJIY7e2SaTAtfDRhH2C4P4BZCyqAVHzZkWLX
 3lMe6YTuvYlfWX1EoVpCGyWJZRf9xpYoaoFR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784050705; x=1784655505;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G3QmcTZDnkhVbjT6SbmPKrFF9alpK8ZzSJXeT1wLlCc=;
 b=Xigj48HM4/4dGkkEQSv16s58TiWPi6RWKVysIa45X19f4iMkjP7+FlcuLLu4ZLcHeE
 DhzphQstmNtn5fm58Ac7iV7XBSaJFDF5qBfmniAqUv37/lIKI6/wmnUuntpBddQxo0Lo
 a156qJc1v8cNlZNXRwhBmvIuaXiQ01yZKLAH8Y9TJOGCC8qgxHReAAV1v+jIrlbx3tGB
 wQ3w1olQ+/Kybf0EaXsWejJfVEHqTh07b5Dhlwqbctz1S7g+gEm7gFiYHX4AbR9QlSit
 VD0DFiGeo3b7rUS6oS322RmOZeU/w48g8NuJ2RIEguXd6TcENadUaFS4CWLHp4+u1CM/
 sT9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jbR0GohTHYJYHIA82karxQECJ/PuOyfkV56eM6KpNF7ga2ykd2FFcyfcXYp8OK3LBYThxHNg=@lists.denx.de
X-Gm-Message-State: AOJu0YwsDAZ5jfHg6hSjRMhkuTAJbUNi5H5khCz9dDgliLH6WAgt9s8q
 tIvKy/5d3tqDfEhGRMDXIfIZEsJfKatBJBZH+RMbhtUQXp998PO4Ix8O6+ZDYDH4P9w=
X-Gm-Gg: AfdE7cnRzU1f6PKH+zqsOTrleuyatOpoU5cHblk0UV6/bn8/AU2KygKWyYFGvOV1qq5
 bfSPniSNitT+qH2FpQW/hG6E+uoYiO5iDACDHv3Ac7Ro9gab2k+sAKE30C+kCr4Qzv/jom4Ymel
 993DncEk/P4rlMsjK4eRFfu7vJxJSAbQyIQxX9a5lgKusKbbh81Oy8/EHlKVX/yvjEbMGr9pdYu
 7tHKaeiL3x6R2xa3o/g+cDaKqF7bWApC74G8HjYhvLEVDV2jMD1TodLVxaiBuOyn3FUgHrMbM12
 24xrRlTf4Sh01HLV/y2AWNuR6WF0rt8qBm+cM3Sltjhmhm5LQlVwTx8X1PAXvdxO7HsZDWSBo/k
 6cVeCtV8BQvvJ1BhPlKWSPk/SuDqVSecB5lxhKBl2UF4O4t36oVDpF4zqCXuXEdC0lSFeP13xh2
 Abu/R1vp8XECkR+nGqrr5ydIrs9EE7w8VW8SZ/ivP7n87ITrguD60fTIUWvJFHcPOGNUgH/0ScZ
 /+3Mo7mWufzGGfALSEyokOseDNhIBDUHvgcXQ==
X-Received: by 2002:a05:6820:1ca7:b0:69d:e4c8:86f6 with SMTP id
 006d021491bc7-6a3cba72972mr1684337eaf.15.1784050705304; 
 Tue, 14 Jul 2026 10:38:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451ec3a6c19sm10890719fac.1.2026.07.14.10.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 10:38:24 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:38:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 00/16] LoongArch initial support
Message-ID: <20260714173822.GD749385@bill-the-cat>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701175926.GS749385@bill-the-cat> <alZxPrNmjeVSsTUv@pie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CgJz75Uq9y2V0WKR"
Content-Disposition: inline
In-Reply-To: <alZxPrNmjeVSsTUv@pie>
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


--CgJz75Uq9y2V0WKR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 05:26:22PM +0000, Yao Zi wrote:
> On Wed, Jul 01, 2026 at 11:59:26AM -0600, Tom Rini wrote:
> > On Wed, Jul 01, 2026 at 11:17:52AM +0000, Yao Zi wrote:
> >=20
> > > Hi all,
> > >=20
> > > After talking to Jiaxun privately, I decided to take over the series.
> > >=20
> > > So far this series has implemented general support for initializing C=
PU,
> > > exceptions, kernel booting, CPU and timer drivers, QEMU LoongArch virt
> > > machine support and UEFI standard compliant EFI booting support.
> > >=20
> > > LoongArch had defined 3 ISA variants, LA64, LA32 and LA32R (Reduced,
> > > intended for MCUs and education purpose). This is a little-endian only
> > > architecture. Only LA64 is implemented in this series since the hardw=
are
> > > is more widely available, and I'll work on 32bit support later.
> > >=20
> > > This series had passed checkpatch with exceptions on some false alarms
> > > and headers imported elsewhere. I've tested virtio devices, direct
> > > kernel booting, efistub kernel booting and grub. For loongarch64 CI, I
> > > would continue to work on Jiaxun's another series[1] soon.
> > >=20
> > > Toolchain can be found at [2] or using upstream one, to build
> > >=20
> > > 	make qemu-loongarch64_defconfig
> > > 	make
> > >=20
> > > To run in QEMU:
> > >=20
> > > 	qemu-system-loongarch64 -nographic -machine virt -bios u-boot.bin
> >=20
> > So on this note, we need to also have changes for:
> > - buildman to fetch the toolchain, which is easy since it's part of the
> >   normal kernel.org ones.
> > - tools/docker/Dockerfile to fetch the toolchain, for CI
> > - Changes to .gitlab-ci.yml and .azure-pipelines.yml to build loongarch
> > - Changes to those files to also fire off QEMU for loonarch
> > - Changes to https://source.denx.de/u-boot/u-boot-test-hooks to support
> >   the previous requirement.
>=20
> Okay, I've talked to Jiaxun and will also continue to work on his
> previous series[1] to add CI stuff.
>=20
> > >=20
> > > TODOs on the architecture & board:
> > > - loongson,ls7a-rtc driver
> > >  - The only device on QEMU board haven't been supported yet
> > > - LoongArch sandbox host support
> > > - TLB enablement
> > >  - This is required for real CPU to utilize caches
> > > - Possibly EFI-APP support for real machine
> > >=20
> > > I have one question regarding the process: I've decided to
> > > coordinate with Jiaxun to maintain the loongarch port, and AFAIK we
> > > would need a custodian tree on U-Boot's GitLab instance in order to r=
un
> > > CI. If this true, what's the process of creating a tree?
> >=20
> > I can work with you both off-list to get one created.
>=20
> Thanks, should we contact with you now so I could include a MAINTAINERS
> patch with correct git URL in the next version, or wait until this
> series gets merged?

Lets go ahead and get started now. Please register on
git.u-boot-project.org and from there I'll make a u-boot-loongarch tree
for you to work in.

--=20
Tom

--CgJz75Uq9y2V0WKR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalZ0CgAKCRAr4qD1Cr/k
CiMoAPwIpXh3F2wt2MFMu3zlURfiyMLpcv2DjR6rLQHBV2ekUgEA1LZzPKiApAqu
kLFTuBtYH8iZbb0R2rUZV15TlumX0gA=
=Ctps
-----END PGP SIGNATURE-----

--CgJz75Uq9y2V0WKR--
