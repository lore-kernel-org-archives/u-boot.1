Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CC5CCD19F
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 17:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C05B783642;
	Mon, 20 Oct 2025 19:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linenoise.info
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linenoise.info header.i=@linenoise.info header.b="dKVKLaH+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEF8F831D5; Mon, 20 Oct 2025 18:51:47 +0200 (CEST)
Received: from ibeerc.linenoise.info (ibeerc.linenoise.info [130.61.186.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33B0782C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 18:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linenoise.info
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alvaro@linenoise.info
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linenoise.info;
 s=ibeerc; t=1760979102;
 bh=TnWMM3GOoess2gDA9kLcN1ShDyKa3Xq8znEF2iuIfIw=;
 h=Date:From:To:Subject:References:From;
 b=dKVKLaH+jEbUb74ORX46n8m/1Xut/SoVt7/R7nFr1GNzraP/qu5Mq5lT+pM0yxtbi
 UNoKl/Br7v+/HEL37WbEgkCCuN+I34SvUnbdH6gfT6KHj09w7Nl6yUmuHNoqApY1YH
 wG+Oyxv0dkvzungRNgA4wYgbto0XETzjEqUhphZp3fXtV6YxSeyOO1MHNxn5QtttED
 Alb4d9oeeJoZ9ITUHhIbkIKTjQJzIl9ykbOFL7L2mqnUhlA+nqRufQnNa/dmUXjJsW
 wdtDzq0yM4gVFzqiYNgjLJwavFYEknqD2LY5hpFv9nClqr4Ns9zptSkHK17O5U7ldv
 A2JvLnxTP/fXg==
Received: from ehlo.thunderbird.net (209.pool80-103-136.dynamic.orange.es
 [80.103.136.209])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ibeerc.linenoise.info (Postfix) with ESMTPSA id 0EFE7218C5
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 18:51:42 +0200 (CEST)
Date: Mon, 20 Oct 2025 18:51:42 +0200
From: =?ISO-8859-1?Q?=C1lvaro_G=2E_M=2E?= <alvaro@linenoise.info>
To: u-boot@lists.denx.de
Subject: Zynqmp: SPL loads from jtag but it gets stuck when run from SD
References: <2c13c953dbd7f71c8f5cd8737e43e8356bf1a165.camel@hazent.com>
Message-ID: <720649EA-D97D-43A8-A291-AB9DD3D0EED9@linenoise.info>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 20 Oct 2025 19:17:28 +0200
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi,

I'm trying to get u-boot SPL to load by itself, without using the Xilinx F=
SBL
workflow on a COTS board that fits an xczu7eg-ffvf1517=2E I export the XSA=
 file
from Vivado and Petalinux is able to boot it with no issue=2E I use the sa=
me XSA
file to generate psu_init_gpl=2Ec (minimized using zynqmp_psu_init_minimiz=
e=2Esh)
and pm_cfg_obj=2Ec from Vitis and right now I'm using one of the prebuilt =
PMUFW
images from Luca Ceresoli at
https://github=2Ecom/lucaceresoli/zynqmp-pmufw-binaries/

Since my full project is a buildroot based one, I'm using buildroot to com=
pile
u-boot, which eases most of the cross compiling issues and also
generates pm_cfg_obj=2Ebin object for me, alongisde ARM trusted firmware b=
l31,
and such other things=2E

A few years ago I did exactly the same with another board, a full custom o=
ne,
that used a xczu4cg, so to ease the transition from one board to the other=
 and=C2=A0
before upgrading u-boot, I'm trying to load the same old u-boot version,
2022=2E04=2E Since the workflow is the same I was expecting this to work
without any issues=2E Sadly, I'm having a few of them=2E

So, what's happening is that when placing u-spl/boot=2Ebin and u-boot=2Eit=
b files
on the SD card, I get no output at all on the serial console, but I can se=
e via
xsdb that the SPL is being executed but got stuck at hang():

xsdb% stop
Info: Cortex-A53 #0 (target 9) Stopped at 0xfffc6a2c (External Debug Reque=
st)
hang() at include/bootstage=2Eh: 389
389: 	return 0;


I can set PC back to the start address and then it will proceed past this =
stage:

xsdb% rwr pc 0xfffc0000
xsdb% con

At the terminal:
<debug_uart>
### ERROR ### Please RESET the board ###


I understand that this is not orthodox at all, moving the PC like that, bu=
t
this just proves that SPL ELF file is there on the CPU, so I get why some
unspecified error may be occurring=2E However, if I just upload spl ELF fi=
le
through xsdb, then it somehow goes on further=2E This is with the SD card
removed from the board:


xsdb% rst -processor -clear-registers
Info: Cortex-A53 #0 (target 9) Stopped at 0xffff0000 (Reset Catch)
xsdb% dow spl/u-boot-spl=20
Downloading Program --
/home/sslayer/Proyectos/ART/DAR/DAR=2Egit/SAR/output/build/uboot-2022=2E04=
/spl/u-
boot-spl
	section, =2Etext: 0xfffc0000 - 0xfffd0847
	section, =2Erodata: 0xfffd0850 - 0xfffd4008
	section, =2Edtb=2Einit=2Erodata: 0xfffd4010 - 0xfffd4eff
	section, =2Edata: 0xfffd4f00 - 0xfffd585f
	section, =2Eu_boot_list: 0xfffd5860 - 0xfffd6357
	section, =2Eimage_copy_end: 0xfffd6358 - 0xfffd6357
	section, =2Eend: 0xfffd6358 - 0xfffd6357
	section, =2Ebss_start: 0x00000000 - 0xffffffffffffffff
	section, =2Ebss: 0x00000000 - 0x00000167
	section, =2Ebss_end: 0x00000168 - 0x00000167
100%    0MB   0=2E2MB/s  00:00   =20
Setting PC to Program Start Address 0xfffc0000
Successfully downloaded
/home/sslayer/Proyectos/ART/DAR/DAR=2Egit/SAR/output/build/uboot-2022=2E04=
/spl/u-
boot-spl
xsdb% con


And this is serial output:

<debug_uart>

U-Boot SPL 2022=2E04 (Oct 20 2025 - 14:33:53 +0200)
PMUFW is not found - Please load it!

### ERROR ### Please RESET the board ###


If I let it boot from SD card and the proceed to upload SPL via xsdb,
then it is able to find PMUFW, which I assume has been placed in memory
during the SD card boot process:

xsdb% rst -processor -clear-registers
Info: Cortex-A53 #0 (target 9) Stopped at 0xffff0000 (External Debug Reque=
st)
xsdb% dow spl/u-boot-spl=20
Downloading Program --
/home/sslayer/Proyectos/ART/DAR/DAR=2Egit/SAR/output/build/uboot-2022=2E04=
/spl/u-
boot-spl
	section, =2Etext: 0xfffc0000 - 0xfffd0847
	section, =2Erodata: 0xfffd0850 - 0xfffd4008
	section, =2Edtb=2Einit=2Erodata: 0xfffd4010 - 0xfffd4eff
	section, =2Edata: 0xfffd4f00 - 0xfffd585f
	section, =2Eu_boot_list: 0xfffd5860 - 0xfffd6357
	section, =2Eimage_copy_end: 0xfffd6358 - 0xfffd6357
	section, =2Eend: 0xfffd6358 - 0xfffd6357
	section, =2Ebss_start: 0x00000000 - 0xffffffffffffffff
	section, =2Ebss: 0x00000000 - 0x00000167
	section, =2Ebss_end: 0x00000168 - 0x00000167
100%    0MB   0=2E2MB/s  00:00   =20
Setting PC to Program Start Address 0xfffc0000
Successfully downloaded
/home/sslayer/Proyectos/ART/DAR/DAR=2Egit/SAR/output/build/uboot-2022=2E04=
/spl/u-
boot-spl
xsdb% con


And UART output is:

U-Boot SPL 2022=2E04 (Oct 20 2025 - 14:33:53 +0200)
PMUFW:	v1=2E1
Loading new PMUFW cfg obj (1984 bytes)
PMUFW no permission to change config object
Silicon version:	3
EL Level:	EL3
Secure Boot:	not authenticated, not encrypted
Multiboot:	0
Trying to boot from MMC2
spl: could not initialize mmc=2E error: -19
Trying to boot from MMC1
spl: could not initialize mmc=2E error: -19
SPL: Unsupported Boot Device!
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###

So, it seems that the SoC is properly reading boot=2Ebin from SD card,
is placing PMUFW somewhere in memory and it runs, but doesn't get to
show <debug_uart> message=2E Booting from JTAG succeeds in showing some
UART messages, and if PMUFW was loaded by the SoC from boot=2Ebin file,
SPL is even able to find and load it=2E

I'm quite lost at the moment, specially because this very same procedure
is the one I used a couple of years ago and that I've replicated today=2E
The same workflow generates a boot=2Ebin and u-boot=2Eitb file that my old
board boots=2E

The only difference should be the different psu_init_gpl=2Ec and pm_cfg_ob=
j=2Ec
files, but they are obtained the same way using Xilinx' tools=2E

I'll be trying directly with master or latest official release of u-boot,
but I'm not sure if that'll help, as it seems I'm doing something wrong,
given that the same procedure on the other board works fine=2E=2E=2E I dun=
no=2E

Any help would be greatly appreciated=2E

Thanks
