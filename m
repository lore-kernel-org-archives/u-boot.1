Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F462E87847
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 16:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D721D83B5E;
	Tue,  3 Feb 2026 17:16:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RttJX89a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C50783B5E; Tue,  3 Feb 2026 17:16:06 +0100 (CET)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE95A83B32
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 17:16:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-45c715116dbso4048491b6e.3
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 08:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770135363; x=1770740163; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qk3eMbCYuc9D18Vt8cDzLQM7k8VpB7OiLSMSO7VA9ZQ=;
 b=RttJX89a3wv7um012+FPk/vp3QxXMOsb6sa0emyGNxWHLUS4CChHrsDazaY0ZScPyH
 waJKdv0POLpfFKTPsejFu7GpJBhYL+bIesoILqyDm7fBvVEZ2zYLsFswSGyOeeNZXjKc
 Se+tuE5GxCiaR/Zd1y/LMmiBQT8urPi7HOj60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770135363; x=1770740163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qk3eMbCYuc9D18Vt8cDzLQM7k8VpB7OiLSMSO7VA9ZQ=;
 b=Mpgune4x91otp7Rz4bwki3Oj/80chFTLAPEcpvYVyfiMueuM9PrlEFQVv8DU+aSegz
 tH34Pfw0TXikXlcwWHVNiEc1xPmvPLuBWN/zEvJODC4OYUuK3dhHHODPwaL2lUieimEj
 RAfcLkULNOQvWf+WMzgbVnf9RvXJ//eMBLwntVSUsH5iN9e1Q6Vdy6x57gNm1CTimOSh
 lmYU5RyFJpsur+4A50Bv+A61eXvvGBKCYl33dUhJM3cBQI42NUFi32U1J2qY+6fgpk/T
 QBrPCk/rHJ0KZY1JE/skiskBQk6b4XZBXVKPszulwZ2vrPL4/LTNVKHF1l2OwfeoZoyE
 pJDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXouTjBcVdH64tIEdvTkhdq7kQb7Bk3Q8QnzdrObCWEZa/UZSBtD0AS0k2H0ZTsH10RMEEFqnY=@lists.denx.de
X-Gm-Message-State: AOJu0YwOT98tgHQiOZjmU+/mw42CdaPh5gu0eKnCHjAQuJGqgfLXOdDf
 61oYkTJ5du/R2kNM7Jkio4r+cl62w1rb2E2fqshL3kEG4lAYY/r+HFGlaip/Trb6u2g=
X-Gm-Gg: AZuq6aLANIupNL2vQMuC2HYwri6X72kaftz+jK5CeDKSFBa0btsXipUlaVEfygX3pk8
 LrFiOERJsDJ+sfWgrvXslb0yaXXRTz3j1+DPhnw9RHGvlSRHIQ6nlpMwi3pdR+xwx+gEKYUlU5i
 e0bI0llnO+nPUQnF0Rm4BvMuS66WPHbdeiE9Zr2k6ONmLXhH8gUVNf8sexQ/BmwaZyQaQT59z1u
 mlFgBIokdjbYNwWu39BRxod9rno9OVCDEarTesuPBU3P+6SDYG/edWYEKRy+Ipdrx0c9gd6xIJe
 Vvh8LMaIzJROFujNREJNkSCVYJm/8cPFjneA5RQNzJ2t5oM3I3jDRWA30EeINAKFPv5ePglVNcG
 zPI3/K5f8e/qdWotFzMDIB7E/Wxt71qWQVp2YvS807vn43FyuaXqrRTqsM/UHxaI7clonA7YMz2
 aqOnHc6In7TBuI9Ozwldm+dY9okHdRTAtRB+WPjqaV6K2+Dunseu+RucYZnlm2th4T/ta0FISnx
 vjnhGgm2mveKq2hSCiM3Sa5H7DSGOI0N2GvONU=
X-Received: by 2002:a05:6808:2218:b0:45c:8724:3608 with SMTP id
 5614622812f47-45f34cb5868mr8752525b6e.35.1770135362562; 
 Tue, 03 Feb 2026 08:16:02 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f22b4e676sm9615852b6e.3.2026.02.03.08.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 08:16:01 -0800 (PST)
Date: Tue, 3 Feb 2026 10:15:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Simon Glass <simon.glass@canonical.com>
Subject: Re: [PATCH v3 0/6] clk: support arbitrary clk_register() sequence
Message-ID: <20260203161559.GN2603314@bill-the-cat>
References: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
 <20260202201706.GA4073175@bill-the-cat>
 <TY0PR02MB5551507C4879363FBB96E946969BA@TY0PR02MB5551.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pzYjGsaVILkawR9q"
Content-Disposition: inline
In-Reply-To: <TY0PR02MB5551507C4879363FBB96E946969BA@TY0PR02MB5551.apcprd02.prod.outlook.com>
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


--pzYjGsaVILkawR9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 11:28:03PM +0800, Yang Xiwen wrote:
> On 2/3/2026 4:17 AM, Tom Rini wrote:
> > On Tue, Jan 20, 2026 at 03:07:17AM +0800, Yang Xiwen wrote:
> >=20
> > > Currently, the U-Boot clk framework mandates that clock registration
> > > begins at the root and proceeds to children. This creates an addition=
al
> > > requirement that does not exist in the Linux kernel, making the porti=
ng
> > > of clk drivers more difficult.
> > >=20
> > > This series handles the dependency entirely within the clk framework,
> > > allowing drivers the freedom to register clocks in any order.
> > >=20
> > > This is achieved by assigning the parent "lazily". The framework cach=
es
> > > the parent name in the core clk struct and attempts to resolve the
> > > actual parent when clk consumers call clk_get_parent(). The process is
> > > transparent to clk consumers as long as they use standard clk framewo=
rk
> > > APIs.
> > >=20
> > > I've run `ut dm clk*` and verified these commits do not break any
> > > existing test cases. It also passes the new test case.
> > >=20
> > > This feature is disabled for xPLs by default. I have not found a clean
> > > way to enable this separately for xPLs without introducing a repetiti=
ve
> > > Kconfig entry (e.g., xPL_CLK_LAZY_REPARENT), which looks very ugly.
> > >=20
> > > Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> > This, like some previous clk reworks, leads to run-time breakage
> > (failure to boot) on TI K3 and likely other platforms (I want to say
> > some rockchip was broken last time) as well.
> >=20
>=20
> It's sad to hear that. Could you please provide the log so I can try to f=
ix
> that? This also means our testcases can't cover all cases.

On am62x_beagleplay_a53 + am62x_beagleplay_r5:
U-Boot SPL 2026.04-rc1-00076-gfd070b0e7186 (Feb 03 2026 - 16:07:42 +0000)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
Set clock rates for '/a53@0', CPU: 1250MHz at Speed Grade 'T'
SPL initial stack usage: 13464 bytes
Trying to boot from MMC2
Starting ATF on ARM64 core...

NOTICE:  BL31: v2.10.0(release):v2.10.0-729-gc8be7c08c
NOTICE:  BL31: Built : 14:04:51, Jun 24 2024
I/TC:=20
I/TC: OP-TEE version: 4.2.0-22-g16fbd46d2 (gcc version 13.2.0 (GCC)) #4 Mon=
 Jun 24 20:04:07 U
TC 2024 aarch64
I/TC: WARNING: This OP-TEE configuration might be insecure!
I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architec=
ture/porting_guide
lines.html
I/TC: Primary CPU initializing
I/TC: GIC redistributor base address not provided
I/TC: Assuming default GIC group status and modifier
I/TC: SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
I/TC: HUK Initialized
I/TC: Primary CPU switching to normal world boot

U-Boot SPL 2026.04-rc1-00076-gfd070b0e7186 (Feb 03 2026 - 16:09:31 +0000)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
SPL initial stack usage: 2048 bytes
Trying to boot from MMC2


U-Boot 2026.04-rc1-00076-gfd070b0e7186 (Feb 03 2026 - 16:09:31 +0000)

SoC:   AM62X SR1.0 GP
Reset reason: POR
Model: BeagleBoard.org BeaglePlay
DRAM:  2 GiB
I/TC: Reserved shared memory is enabled
I/TC: Dynamic shared memory is enabled
I/TC: Normal World virtualization support is disabled
I/TC: Asynchronous notifications are disabled
Core:  112 devices, 33 uclasses, devicetree: separate
MMC:   mmc@fa10000: 0, mmc@fa00000: 1, mmc@fa20000: 2
Loading Environment from nowhere... OK
In:    serial@2800000
Out:   serial@2800000
Err:   serial@2800000
Net:   "Synchronous Abort" handler, esr 0x02000000
elr: 00000000808c1b28 lr : 00000000808357b0 (reloc)
elr: 00000000fffd2b28 lr : 00000000fff467b0
x0 : 00000000fdef7340 x1 : 00000000fffd2b28
x2 : 000000000000000a x3 : 0000000000000000
x4 : 000000000000000d x5 : 0000000000000064
x6 : 00000000fffb088b x7 : 0000000000000044
x8 : 000000000000000a x9 : 0000000000000034
x10: 0000000000000002 x11: 00000000ffffffff
x12: 00000000fdede730 x13: 0000000000007040
x14: 00000000fdede730 x15: 00000000ffffffff
x16: 00000000fff53ac8 x17: 0000000000000000
x18: 00000000fdef1e10 x19: 0000000000000000
x20: 00000000fdef7340 x21: 00000000fffccfc0
x22: 00000000fffd4ed0 x23: 00000000fffd4000
x24: 00000000fdefac18 x25: 00000000fdefac18
x26: 00000000fff7bcfc x27: 00000000fff7bdb4
x28: 00000000fffaa8f0 x29: 00000000fdede5b0

Code: fffd2b08 00000000 fffd2b08 00000000 (fffd2b18)=20
Resetting CPU ...

resetting ...

--=20
Tom

--pzYjGsaVILkawR9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYIfPwAKCRAr4qD1Cr/k
Cvy2AQCha9O10JWIOCz0Ys/DgRGri9w3FijGSng2YvAz42tRAwEA3uwX513qlsic
MPPUlyBeLo16+8fDFouxDlPX5EkV7QU=
=AdSb
-----END PGP SIGNATURE-----

--pzYjGsaVILkawR9q--
