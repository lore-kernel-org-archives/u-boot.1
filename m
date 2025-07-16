Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4290C83F22
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 22:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C0F982D32;
	Thu, 17 Jul 2025 00:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZK/XeKoC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AB8B82D32; Thu, 17 Jul 2025 00:16:44 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F9D9805D7
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 00:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-40aef72f252so139857b6e.0
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 15:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752704199; x=1753308999; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6i7FFqjI2GYcdxNpOknQgkIR3hKt9sSoM38eMnhW/ok=;
 b=ZK/XeKoC2wAV5ZtgnaibvoXA2Qtbp5hYUUW8EkAfkdPgBtlqaGOsk4k+A04QZ8Vw+O
 fSt+nv4t9op2oVXE7THraYvqv4V4EzxxGxWoAHKPaVB7Dobv0ky189jWcA43LPqK/4Uf
 pbAkO76HHvzFIjL+1QYKUw7ih6j6w8qfff0v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752704199; x=1753308999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6i7FFqjI2GYcdxNpOknQgkIR3hKt9sSoM38eMnhW/ok=;
 b=AHAYKZ0XhceD+xWUvi3gU/JXfs4qePIHfKwQjdW7Kgva8L0gmUYaPTa1WvuQ65reEi
 6aF7y14oKZz4OCVKK2uvqDDRAmoytcj9k+hE60PQwLzskbkEEUg/NiHfL8f+IlyNcwMQ
 009y+3pzZeM9I+a0pIgkVzy+okSHpNRP210loQ0hJ+s44ZlWFAAEN9b3S0/Mrbc613Ua
 /XHF+xNMjlrygurww/OAlCg6qSFVDCbD223YtynFrT5BPCsz6FWfSTZaQoe1cRW6b//q
 2qgb/sl+ELv2m2gaThzYsVobYUbUMa0BQUsXBorM14pd5RP+7Q4EGPEzkiK/wabN8YPQ
 gPVA==
X-Gm-Message-State: AOJu0YyBug0khICgGOOV5PLQZ1uVMJ36O7s3mvSJ2bEtxKuGJ05Co/DM
 ++pUxAhrVix6P5C9KYL/UvAR5l2F8qFAekEv+f3etSi570+cSSnG3R3rlLTtWPGOmWuRekKFKVY
 Y9ZAgksE=
X-Gm-Gg: ASbGncs7Vn2/I2OQr6WY7dgPgKKXw/wSdNCyJ+GTh8GQIFfh+9FWn0QYmLNA6f9rmgS
 ov6Dvxn6zAHo0Nxf5vu1m6Cq1KjQLC9GavmWCG6XSrLWX2fvrzsBPUobXJZ2qxFSakV+k6bUgDz
 tCS5rNLrImQd1/2QPP4je79wVRHrugWE3w18cVN7Ps3UzbMkkgl81moAdtK/3+aeCORjrIj4GF5
 Br/sW1Gsa1fOHUlxOBmOg43AIhgGMakFlXeP2v+BdFAEff2WfTiya+up/lqGakaIBvP33w1P/zd
 YSEK3KMmzDtdF6heNt4KigPt1nhqsB73xk7qKXAR35QVSS7jQ1uFwNcGqcf+K1g4L0p29cuIvcC
 iTMQDtgXIy/bUqTnuoV2S/438FkT/LR1pBY+1nqA0XezxEzOjwNnjFx5p/0R+ahRPKx0=
X-Google-Smtp-Source: AGHT+IHeS4qVWQlw9FQpkghRGEE8biaItioDsGgF5SfxjnyX+PWKQgqgwbmptSZt5B8Kk8EpIT9DRA==
X-Received: by 2002:a05:6808:1587:b0:40b:121b:65b4 with SMTP id
 5614622812f47-41cefb1a43bmr3424983b6e.21.1752704199201; 
 Wed, 16 Jul 2025 15:16:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-414197c6064sm3058162b6e.20.2025.07.16.15.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 15:16:38 -0700 (PDT)
Date: Wed, 16 Jul 2025 16:16:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-next-20250716 into master
Message-ID: <20250716221636.GJ193579@bill-the-cat>
References: <87y0so30tv.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kPIpSXu5dy2rxTLR"
Content-Disposition: inline
In-Reply-To: <87y0so30tv.fsf@kernel.org>
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


--kPIpSXu5dy2rxTLR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 12:08:12PM +0200, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Please find the following fixes for master:
>=20
> Android:
> - Fix printing lbaint_t format in AVB and android_ab messages
>=20
> DFU:
> - Fix dfu_config_interfaces() for single interface DFU syntax
>=20
> CI Job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/27074
>=20
> Please note that this is probably my last pull request before my
> paternity leave. I plan to be out in August and September.
> Becoming a dad will be a life-changing event for me, so I'd like to
> not be on my computer for the early months :)
>=20
> As we discussed on IRC, thanks a lot for keeping an eye out for
> fastboot, android AB/AVB, USB gadget and DFU.
>=20
> Regards,
> Mattijs
>=20
> The following changes since commit b379335f141e3ddca0cdbb5d9d39af04445305=
42:
>=20
>   configs: Resync with savedefconfig (2025-07-07 14:15:18 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20250716
>=20
> for you to fetch changes up to 772526fb9f55a1fea439ea3a6923136cd121cc88:
>=20
>   dfu: Fix dfu_config_interfaces() for single interface DFU syntax (2025-=
07-15 11:27:19 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--kPIpSXu5dy2rxTLR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh4JMAACgkQFHw5/5Y0
tywFmwwAuSQT/UK4swzJ0j7yPfMzp3t5+47zdL5XS1zqTgNpFjT2/tJzqEtDKNts
PPp1C9o1Tmk3IQ9Qp4hsaL8cQupGIfRNesSSXBN6LLOsjoy4lCCNunHFBqog0OVW
6XnTMHGD3hQpdEQy/yZ7W+AbHe/T7gJb1nZDbkJB4Fm9ugXkPceOP/10/CMSl5wl
w2tSrFMKC5jmSLZkOPxds2DXWq8H8nUfQ54hhaP4hwgnqzj77Z0UUEP43MGIVd9V
0T3k/z0+zWlzRIGvgBlxywtEDedTRlXlfZdFuXBuot2FcrVBqhZNQfygMsrJX65C
DLr7qpNV4eLp85r9hvF4eHHg6F2J5FZiCtmDPC4kWbUBlEeBL3lNrvvdLpMHHUWd
zvfoFeDT4Kg/Kps0tK2Tu/TdVdf8HvjPAPRorTtAVAnCWb9KuG+D6b5AlLqZpCYh
Yfh6j0j2Cj9Al3sfHEIqNNnPirxqrih9KGKJKhXjNXdu2VDx5xWIK7YGd7NlZXFp
CTC69yoM
=C1Ex
-----END PGP SIGNATURE-----

--kPIpSXu5dy2rxTLR--
