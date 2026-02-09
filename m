Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108EFE81BCD
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 14:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D7D2839A5;
	Mon,  9 Feb 2026 15:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mvbgGLV2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90DB583BDD; Mon,  9 Feb 2026 15:23:16 +0100 (CET)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68ACE8341A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 15:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-45c9f47e1e8so1447889b6e.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 06:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770646988; x=1771251788; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8SL21HBzX7hVnfr1PugjBUejl5WIRbTtVinShdgUEpw=;
 b=mvbgGLV2HhsOBkLRs4eHsJOllVKcIzjUuY6mok/wYvnB0660pf9xzSEukP/OwGziGS
 TXBV0MVzwIX05yuURTvKqHag+weZvEoqMBaD+U1MTGJVmvVvBwJ00olNhSFSaNxE8Hea
 OiIJ2aJd5MZQ4Xfmr0PBtYrN+RfJZ/ma8+rmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770646988; x=1771251788;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8SL21HBzX7hVnfr1PugjBUejl5WIRbTtVinShdgUEpw=;
 b=DeJ2gyvN3vW+4tSbKtGxidBfvsryE3AyVQ3mP0BURZa4H41yAfiFFjRS/wbmJcOlVU
 uOsMr5qYcSyU+Fshig5NJxGZ8dflP0yLSzeqFVSHy+/9/t4Un4ChA80tSkvGUq7RrP6U
 z61q5EGqJU6gNXd+d1KlH3sWI6hpKOgoCqCZXVcIsP8UGlKWflYcuS2SNEQ/X3sz1tAe
 i8JHTaCmpuC1P/aSp/fM0vPa8Ug48vLpByTMrw8reYk959Xqrt5eFjX7+t5jJ4HfRD8f
 ymzz4GnrGic3kskXHlcOu+1kEtlkB5kzCBrKLYmXfm1yHiwGYOvH7JGHRpoR/345Kwvu
 thdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXECGWuibDX9yFRyiJGqeCvi8TjA+Rj4j2ZIo57HE6lAYElyT/Rk9QRXAAdNhVHvXpv0IyKJWQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8FyNlrX8l3JCTiNLQLPeKBcwltpDr5aL2sm4cCtH/pGnoaStC
 xGkxDL9fC0f9TpmICdu/etHMF3JH16wdFT6ZbZvuWhdFCjpfEyUd6pqVvNkMmt/qqf0=
X-Gm-Gg: AZuq6aLyTrkujDog9ECBJCyy0MGbwU+ZWGAzymv/f90/nE7SOVyWebenAnKqJNnq/0q
 f065nIjNa09Lv7CMp5iqmqVlgb5YYljn00FEUcrjFUFgblo1PxKvTs14Yqh7zIqb0Natq068Fzt
 C7jMMGp32UpBdgZ47gCT//Pl3ZQqPw0xqU5ogAT1v9f4MX/i5qlXnSUxNL+mwipijdAhl1VAu8I
 kFQl1oZKxZcb82Dh2bT9r88B7PWlPfw/ylJBeIUTJh6WFRcukEyTS0uu31hZZxgXbLH4Lghgqjj
 e2EuFnBj2B7rh8SpZCcH++yg/3Em33Fp8DS2Cd/1Kt55kfm8mzW9DBy2D8G/7KF3LedcNrqxakx
 ofTFoclDnalryWl4ISwIS50BOGYo+qmaKH57WPt5rZqRIwjKQB0buE9vbLgatKeaNcNyCLh0QHS
 z6kfgewpv8UdQpU9b7e0S8jG8S4VyLlE6S8lGRu3gpazIc3riP1b9P03+TfBNzJZ8sg29fB2bTz
 Kg289z/zpAM9ifvCxjxpRPbInqiyPBi5UKjpUWKzHMsw5F8t2MV/pBaFgyBcA==
X-Received: by 2002:a05:6808:4fe7:b0:44d:bcb0:1409 with SMTP id
 5614622812f47-462fca2e955mr6224251b6e.22.1770646987952; 
 Mon, 09 Feb 2026 06:23:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462fe9db9fcsm6828442b6e.8.2026.02.09.06.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 06:23:07 -0800 (PST)
Date: Mon, 9 Feb 2026 08:23:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Simon Glass <simon.glass@canonical.com>
Subject: Re: [PATCH v3 0/6] clk: support arbitrary clk_register() sequence
Message-ID: <20260209142305.GE2603314@bill-the-cat>
References: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
 <20260202201706.GA4073175@bill-the-cat>
 <TY0PR02MB5551507C4879363FBB96E946969BA@TY0PR02MB5551.apcprd02.prod.outlook.com>
 <20260203161559.GN2603314@bill-the-cat>
 <SEYPR02MB5557614A996414970C90C11A9667A@SEYPR02MB5557.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wn+aCs/N/Tm5Ua5c"
Content-Disposition: inline
In-Reply-To: <SEYPR02MB5557614A996414970C90C11A9667A@SEYPR02MB5557.apcprd02.prod.outlook.com>
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


--wn+aCs/N/Tm5Ua5c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 07, 2026 at 10:58:16PM +0800, Yang Xiwen wrote:
> On 2/4/2026 12:15 AM, Tom Rini wrote:
> > On Tue, Feb 03, 2026 at 11:28:03PM +0800, Yang Xiwen wrote:
> > > On 2/3/2026 4:17 AM, Tom Rini wrote:
> > > > On Tue, Jan 20, 2026 at 03:07:17AM +0800, Yang Xiwen wrote:
> > > >=20
> > > > > Currently, the U-Boot clk framework mandates that clock registrat=
ion
> > > > > begins at the root and proceeds to children. This creates an addi=
tional
> > > > > requirement that does not exist in the Linux kernel, making the p=
orting
> > > > > of clk drivers more difficult.
> > > > >=20
> > > > > This series handles the dependency entirely within the clk framew=
ork,
> > > > > allowing drivers the freedom to register clocks in any order.
> > > > >=20
> > > > > This is achieved by assigning the parent "lazily". The framework =
caches
> > > > > the parent name in the core clk struct and attempts to resolve the
> > > > > actual parent when clk consumers call clk_get_parent(). The proce=
ss is
> > > > > transparent to clk consumers as long as they use standard clk fra=
mework
> > > > > APIs.
> > > > >=20
> > > > > I've run `ut dm clk*` and verified these commits do not break any
> > > > > existing test cases. It also passes the new test case.
> > > > >=20
> > > > > This feature is disabled for xPLs by default. I have not found a =
clean
> > > > > way to enable this separately for xPLs without introducing a repe=
titive
> > > > > Kconfig entry (e.g., xPL_CLK_LAZY_REPARENT), which looks very ugl=
y.
> > > > >=20
> > > > > Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> > > > This, like some previous clk reworks, leads to run-time breakage
> > > > (failure to boot) on TI K3 and likely other platforms (I want to say
> > > > some rockchip was broken last time) as well.
> > > >=20
> > > It's sad to hear that. Could you please provide the log so I can try =
to fix
> > > that? This also means our testcases can't cover all cases.
> > On am62x_beagleplay_a53 + am62x_beagleplay_r5:
> > U-Boot SPL 2026.04-rc1-00076-gfd070b0e7186 (Feb 03 2026 - 16:07:42 +000=
0)
> > SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
> > Set clock rates for '/a53@0', CPU: 1250MHz at Speed Grade 'T'
> > SPL initial stack usage: 13464 bytes
> > Trying to boot from MMC2
> > Starting ATF on ARM64 core...
> >=20
> > NOTICE:  BL31: v2.10.0(release):v2.10.0-729-gc8be7c08c
> > NOTICE:  BL31: Built : 14:04:51, Jun 24 2024
> > I/TC:
> > I/TC: OP-TEE version: 4.2.0-22-g16fbd46d2 (gcc version 13.2.0 (GCC)) #4=
 Mon Jun 24 20:04:07 U
> > TC 2024 aarch64
> > I/TC: WARNING: This OP-TEE configuration might be insecure!
> > I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/arch=
itecture/porting_guide
> > lines.html
> > I/TC: Primary CPU initializing
> > I/TC: GIC redistributor base address not provided
> > I/TC: Assuming default GIC group status and modifier
> > I/TC: SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala=
)')
> > I/TC: HUK Initialized
> > I/TC: Primary CPU switching to normal world boot
> >=20
> > U-Boot SPL 2026.04-rc1-00076-gfd070b0e7186 (Feb 03 2026 - 16:09:31 +000=
0)
> > SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
> > SPL initial stack usage: 2048 bytes
> > Trying to boot from MMC2
> >=20
> >=20
> > U-Boot 2026.04-rc1-00076-gfd070b0e7186 (Feb 03 2026 - 16:09:31 +0000)
> >=20
> > SoC:   AM62X SR1.0 GP
> > Reset reason: POR
> > Model: BeagleBoard.org BeaglePlay
> > DRAM:  2 GiB
> > I/TC: Reserved shared memory is enabled
> > I/TC: Dynamic shared memory is enabled
> > I/TC: Normal World virtualization support is disabled
> > I/TC: Asynchronous notifications are disabled
> > Core:  112 devices, 33 uclasses, devicetree: separate
> > MMC:   mmc@fa10000: 0, mmc@fa00000: 1, mmc@fa20000: 2
> > Loading Environment from nowhere... OK
> > In:    serial@2800000
> > Out:   serial@2800000
> > Err:   serial@2800000
> > Net:   "Synchronous Abort" handler, esr 0x02000000
> > elr: 00000000808c1b28 lr : 00000000808357b0 (reloc)
> > elr: 00000000fffd2b28 lr : 00000000fff467b0
> > x0 : 00000000fdef7340 x1 : 00000000fffd2b28
> > x2 : 000000000000000a x3 : 0000000000000000
> > x4 : 000000000000000d x5 : 0000000000000064
> > x6 : 00000000fffb088b x7 : 0000000000000044
> > x8 : 000000000000000a x9 : 0000000000000034
> > x10: 0000000000000002 x11: 00000000ffffffff
> > x12: 00000000fdede730 x13: 0000000000007040
> > x14: 00000000fdede730 x15: 00000000ffffffff
> > x16: 00000000fff53ac8 x17: 0000000000000000
> > x18: 00000000fdef1e10 x19: 0000000000000000
> > x20: 00000000fdef7340 x21: 00000000fffccfc0
> > x22: 00000000fffd4ed0 x23: 00000000fffd4000
> > x24: 00000000fdefac18 x25: 00000000fdefac18
> > x26: 00000000fff7bcfc x27: 00000000fff7bdb4
> > x28: 00000000fffaa8f0 x29: 00000000fdede5b0
> >=20
> > Code: fffd2b08 00000000 fffd2b08 00000000 (fffd2b18)
> > Resetting CPU ...
> >=20
> > resetting ...
> >=20
>=20
> Is the uboot image built by buildman toolchain or some other toolchain? I=
've
> tried to generate the image with `tools/buildman/buildman -M -k
> am62x_beagleplay_r5` and debug it with `gdb-multiarch
> ../current/am62x_beagleplay_r5/u-boot`. But the result doesn't seem corre=
ct.
>=20
>=20
> The output of gdb:
>=20
> (gdb) disas/r 0x808357b0
> Dump of assembler code for function menu_destroy.isra.0:
> =A0 =A00x8083578c <+0>:=A0 =A0 =A0b5f8=A0 =A0 =A0 =A0 =A0 =A0 push=A0 =A0=
 {r3, r4, r5, r6, r7, lr}
> =A0 =A00x8083578e <+2>:=A0 =A0 =A04605=A0 =A0 =A0 =A0 =A0 =A0 mov=A0 =A0 =
=A0r5, r0
> =A0 =A00x80835790 <+4>:=A0 =A0 =A04604=A0 =A0 =A0 =A0 =A0 =A0 mov=A0 =A0 =
=A0r4, r0
> =A0 =A00x80835792 <+6>:=A0 =A0 =A0f855 3f24=A0 =A0 =A0 =A0ldr.w=A0 =A0r3,=
 [r5, #36]!
> =A0 =A00x80835796 <+10>:=A0 =A0 681e=A0 =A0 =A0 =A0 =A0 =A0 ldr=A0 =A0 =
=A0r6, [r3, #0]
> =A0 =A00x80835798 <+12>:=A0 =A0 42ab=A0 =A0 =A0 =A0 =A0 =A0 cmp=A0 =A0 =
=A0r3, r5
> =A0 =A00x8083579a <+14>:=A0 =A0 d108=A0 =A0 =A0 =A0 =A0 =A0 bne.n=A0 =A00=
x808357ae
> <menu_destroy.isra.0+34>
> =A0 =A00x8083579c <+16>:=A0 =A0 68a0=A0 =A0 =A0 =A0 =A0 =A0 ldr=A0 =A0 =
=A0r0, [r4, #8]
> =A0 =A00x8083579e <+18>:=A0 =A0 b108=A0 =A0 =A0 =A0 =A0 =A0 cbz=A0 =A0 =
=A0r0, 0x808357a4
> <menu_destroy.isra.0+24>
> =A0 =A00x808357a0 <+20>:=A0 =A0 f7d6 fae6=A0 =A0 =A0 =A0bl=A0 =A0 =A0 0x8=
080bd70 <free>
> =A0 =A00x808357a4 <+24>:=A0 =A0 4620=A0 =A0 =A0 =A0 =A0 =A0 mov=A0 =A0 =
=A0r0, r4
> =A0 =A00x808357a6 <+26>:=A0 =A0 e8bd 40f8=A0 =A0 =A0 =A0ldmia.w sp!, {r3,=
 r4, r5, r6, r7,
> lr}
> =A0 =A00x808357aa <+30>:=A0 =A0 f7d6 bae1=A0 =A0 =A0 =A0b.w=A0 =A0 =A00x8=
080bd70 <free>
> =A0 =A00x808357ae <+34>:=A0 =A0 f853 0c08=A0 =A0 =A0 =A0ldr.w=A0 =A0r0, [=
r3, #-8]
> =A0 =A00x808357b2 <+38>:=A0 =A0 f1a3 0708=A0 =A0 =A0 =A0sub.w=A0 =A0r7, r=
3, #8
> =A0 =A00x808357b6 <+42>:=A0 =A0 b108=A0 =A0 =A0 =A0 =A0 =A0 cbz=A0 =A0 =
=A0r0, 0x808357bc
> <menu_destroy.isra.0+48>
> =A0 =A00x808357b8 <+44>:=A0 =A0 f7d6 fada=A0 =A0 =A0 =A0bl=A0 =A0 =A0 0x8=
080bd70 <free>
> =A0 =A00x808357bc <+48>:=A0 =A0 4638=A0 =A0 =A0 =A0 =A0 =A0 mov=A0 =A0 =
=A0r0, r7
> =A0 =A00x808357be <+50>:=A0 =A0 f7d6 fad7=A0 =A0 =A0 =A0bl=A0 =A0 =A0 0x8=
080bd70 <free>
> =A0 =A00x808357c2 <+54>:=A0 =A0 4633=A0 =A0 =A0 =A0 =A0 =A0 mov=A0 =A0 =
=A0r3, r6
> =A0 =A00x808357c4 <+56>:=A0 =A0 6836=A0 =A0 =A0 =A0 =A0 =A0 ldr=A0 =A0 =
=A0r6, [r6, #0]
> =A0 =A00x808357c6 <+58>:=A0 =A0 e7e7=A0 =A0 =A0 =A0 =A0 =A0 b.n=A0 =A0 =
=A00x80835798
> <menu_destroy.isra.0+12>
> End of assembler dump.

I can send you the binaries if needed, off-list. But the likely answer
is that we're on the a53 part of the system and not the r5 part of the
system at this point.

--=20
Tom

--wn+aCs/N/Tm5Ua5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYntwAAKCRAr4qD1Cr/k
CoHyAP9HH08A8cL6Nhi5Q0nBVguvMnsNLS2q3pIuw92UIgVsMAEA+DOVsFSKvCAn
k/ySwRQck0kNKaJvIEnhkmfu2YMh6A8=
=z6pX
-----END PGP SIGNATURE-----

--wn+aCs/N/Tm5Ua5c--
