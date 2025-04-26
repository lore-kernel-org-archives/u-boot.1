Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C61C369CB
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 23:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAF3481E0F;
	Sun, 27 Apr 2025 01:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=nathaniel.land
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nathaniel.land header.i=@nathaniel.land header.b="vthFoTXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF6B481F45; Sun, 27 Apr 2025 01:25:57 +0200 (CEST)
Received: from goldencat.email (host212.sub-63-47-114.myvzw.com
 [63.47.114.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4720480FDE
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 01:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nathaniel.land
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=I@nathaniel.land
Date: Sat, 26 Apr 2025 18:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nathaniel.land;
 s=dkim; t=1745709950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sOT5It04wu21xdq+IOb5di2zihb0uezypvKOM39KPTs=;
 b=vthFoTXCXnb9vHtUZQZIXU+SMTTrFccrpszMnsCkEptppL1PeiZDiHFMnFCBaVaJbdWv1l
 9aYdqZajp28P7VT/WWRk/ebMDIiJxtlJzEG59lCQoNJEPvXFI8kv5V1cK/LgqNHn2xLAsE
 ofPbkjPz3MuLzAQlkREqXa9XqRfFukTA18jdpDiSa3yXzy+eewNQc0AKMaXv3NfX1zEhrM
 kFxhQspVqsqLtQHbv4JUQPaQJl3Hw5EojPumJ4GaT+Ta+XenUsw+Et2ldPfXCbkexxwR3S
 p13SbL7dOPsr9x/Vd+7UpNt3oryhqCVIVvzsN78mM7qKYZcpgsDR7vJZPlcwrw==
Authentication-Results: goldencat.email;
 auth=pass smtp.mailfrom=I@nathaniel.land
From: Nathaniel <I@nathaniel.land>
To: Yao Zi <ziyao@disroot.org>
Cc: UBML <u-boot@lists.denx.de>
Message-ID: <EF1C62F4-2780-4DD4-B0FE-355AA66A10C4@getmailspring.com>
In-Reply-To: <aAx9bjXivAAuth-y@pie>
References: <aAx9bjXivAAuth-y@pie>
Subject: Re: Build for RISC-V with LLVM
MIME-Version: 1.0
X-Spamd-Bar: /
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Apr 26 2025, at 1:30 am, Yao Zi <ziyao=40disroot.org> wrote:
> On =46ri, Apr 25, 2025 at 12:43:08PM -0500, Nathaniel Hourt wrote:
> > Hi, all
> >
> > I am trying to build u-boot and SPL for my Mars board (riscv, variant=
 of the
> > starfive visionfive2) following the board-specific docs =5B1=5D, usin=
g
> > LLVM/clang as my toolchain with the HOSTCC and CC make options mentio=
ned in
> > =5B2=5D. I'm building from a RISC-V native chroot using qemu-binfmt s=
o I am not
> > using the cross-compile options; thus my make invocation looks like =60=
make
> > HOSTCC=3Dclang CC=3Dclang=60 (for OpenSBI, I just pass 'LLVM=3D1'). N=
ote that the
> > chroot I'm building from does not contain gcc/binutils at all; LLVM i=
s the
> > only toolchain present.
> >
> > The build usually succeeds, so I try to pass the SPL to the MaskROM o=
ver
> > UART (using the u-boot-spl.bin.normal.out image) and it just hangs. N=
o
> > output, no response, and I have to reset the board. If I pass a worki=
ng SPL
>
> Have you tried to apply this patch=5B1=5D=3F U-Boot support for JH7110 =
is
> broken at least in v2025.04 release afaik.
>
> Best regards,
> Yao Zi
>
> =5B1=5D: https://lore.kernel.org/all/20250330162421.238483-1-heinrich.s=
chuchardt=40canonical.com/
> > I downloaded, it logs some output then accepts a main u-boot payload =
over
> > UART, so if I send the main u-boot payload I built (u-boot.itb), I ge=
t a
> > =22Load address misaligned=22 error as in =5B3=5D.
> >
> > I attempted to configure my SPL to log to UART by turning on various =
logging
> > options in =60menuconfig=60, including the options recently mentioned=
 by
> > Heinrich Schuchardt in =5B4=5D, but I have been unsuccessful in getti=
ng any
> > output from the SPL I built.
> >
> > So I am looking for guidance. Is building with LLVM/clang (for riscv)=

> > supported=3F I don't know what to try next.
> >
> > Thanks
> > =E2=80=94
> > Nathaniel
> >
> >
> > =5B1=5D
> > https://docs.u-boot.org/en/latest/board/starfive/milk-v=5Fmars.html=23=
milk-v-mars
> > =5B2=5D https://docs.u-boot.org/en/latest/build/clang.html
> > =5B3=5D https://pastebin.com/xwEcqEpz
> > =5B4=5D https://lists.denx.de/pipermail/u-boot/2025-April/586264.html=

>

I just tried the patch, and also pulled latest master, which has that pat=
ch by now, but it didn't change the SPL's behavior.
I have heard that I need to be using v2025.01; however, that fails to bui=
ld for me:
LD lib/efi=5Floader/boothart=5Fefi.so
ld: error: section type mismatch for .dynamic
>>> <internal>:(.dynamic): SHT=5FDYNAMIC
>>> output section .text: SHT=5FPROGBITS
make=5B2=5D: *** =5Bscripts/Makefile.lib:539: lib/efi=5Floader/boothart=5F=
efi.so=5D Error 1
make=5B1=5D: *** =5Bscripts/Makefile.build:398: lib/efi=5Floader=5D Error=
 2
make: *** =5BMakefile:1915: lib=5D Error 2

I don't understand that error; I'm guessing it's EL=46 wizardry thus far =
beyond my ken.
So master builds but doesn't run (at all=3F there's no output) and going =
off of =5B1=5D, wouldn't we expect there to be some output from the SPL w=
hen it doesn't work for the known reasons=3F
v2025.01 doesn't build with my LLVM toolchain, and I'm wondering whether =
I'm getting actually sane images even when master builds successfully. I =
have no idea how to verify that... Does anyone know how to analyze the SP=
L image output, or even what format it's in=3F Or alternatively, is there=
 a hello world SPL I can build just to test whether I can produce working=
 binaries at all=3F
Or am I barking up the wrong tree altogether=3F Ideas welcome. =3D)
=E2=80=94
Nathaniel

=5B1=5D https://lore.kernel.org/all/20250330162421.238483-1-heinrich.schu=
chardt=40canonical.com/
