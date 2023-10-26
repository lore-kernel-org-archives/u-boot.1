Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEED7C25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 12:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9097287614;
	Thu, 26 Oct 2023 14:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=inside-m2m.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=inside-m2m.de header.i=@inside-m2m.de header.b="KnxBgyqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4441875F9; Thu, 26 Oct 2023 14:42:09 +0200 (CEST)
Received: from mail.inside-m2m.de (mail.inside-m2m.de [188.68.57.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 295FC87025
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 14:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=inside-m2m.de
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=konstantin.kletschke@inside-m2m.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=inside-m2m.de;
 s=default; t=1698324095;
 bh=8mGNTaQbiTZnW1gd+v3wr+XWpvcR5C7F1PsXcje02w8=;
 h=Date:From:To:Subject:From;
 b=KnxBgyqPLhEnjXEnHoEO4wKgGFSjmemAdoj1U2dmQcz2unPYQlVuwdm62Qj/nekqr
 i5IV9XDW6+ZCw5etS/d4LyI99IpgRYhwVRV+8u/VBwH77XwgfOGahBXkZV7dQruvH7
 cth2uO1cRFrcMgNv93XCGbY/oF91LThS4Thv4aeeka32CHZHuMmzfIng7tMyivRRoS
 dPM1a8Ifv6Nj+GWnZh6mfRDLUivm5fUJ7V5yeaCSQbT4OEN6CpUe+VazdFIynOs569
 ae2rpvhVQkge1BrrocdDtAgT/aWF13FdfN42/m0b2qbkRTGwn3bKOztefKIxi2A41B
 acZf5Pyb/Y5AQ==
Received: from hephaistos.inside-m2m.de
 (business-90-187-159-109.pool2.vodafone-ip.de [90.187.159.109])
 (Authenticated sender: konstantin.kletschke@inside-m2m.de)
 by mail.inside-m2m.de (Postfix) with ESMTPSA id CA52C400D4
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 14:41:33 +0200 (CEST)
Date: Thu, 26 Oct 2023 14:41:32 +0200
From: Konstantin Kletschke <konstantin.kletschke@inside-m2m.de>
To: u-boot@lists.denx.de
Subject: Starting kernel invokes "Synchronous Abort" - rk3328
Message-ID: <ZTpefOD0SYF_lkO_@hephaistos.inside-m2m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 26 Oct 2023 14:56:48 +0200
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

Dear u-boot community,
I have a rockchip rk3328 Board here I am trying to boot linux kernel
upon. It is a Dusun DSGW-210 which seems to resemble the setup

board=evb_rk3328
board_name=evb_rk3328

Dusun offers a SDK which they claim to be working in their system, the
rootfs can be a debian or a buildroot one. I can not compile it (Host
needs to be darn old, I got stuck realizing python2 with ftdi libs is
required). Reagardeless I want to port their stuff to yocto linux anyway
and since the u-boot an kernel config resemble vanilla evb_rk3328 setup and
config I thought it should not be too hard. But it is. For me.

I used the JeffyCN yocto meta layer, compiled it and flashed the images.
And voila, u-boot seems to work fine!
When U-boot starts the kernel I get

"Synchronous Abort" handler, esr 0x02000000

The output looks this way:

=> boot
Could not find misc partition
ANDROID: reboot reason: "(none)"
Not AVB images, AVB skip
Booting IMAGE kernel at 0x00280000 with fdt at 0x08300000...


Fdt Ramdisk skip relocation
No misc partition
## Booting Android Image at 0x0027f800 ...
Kernel: 0x00280000 - 0x00af2957 (8651 KiB)
## Flattened Device Tree blob at 0x08300000
  Booting using the fdt blob at 0x08300000
  XIP Kernel Image from 0x00280000 to 0x00280000 ... OK
  kernel loaded at 0x00280000, end = 0x00af2957
  Using Device Tree in place at 0000000008300000, end 00000000083156fd
WARNING: could not set reg FDT_ERR_BADOFFSET.
## reserved-memory:
 drm-logo@00000000: addr=7df00000 size=b8000
Adding bank: 0x00200000 - 0x08400000 (size: 0x08200000)
Adding bank: 0x0a200000 - 0x80000000 (size: 0x75e00000)
== DO RELOCATE == Kernel from 0x00280000 to 0x00200000
Total: 126428.23/126891.316 ms


Starting kernel ...

"Synchronous Abort" handler, esr 0x02000000


The decoded stackdump looks like this:

./scripts/stacktrace.sh stackdump

SYMBOL File: ./u-boot.sym

Call trace:
PC:	[< ffffffff8278f004 >]
LR:	[< 00201d90 >]  do_bootm_linux+0x5c/0x74      /home/konsti/Dusun/yocto-JeffyCN/build/tmp/work/dsgw_210-poky-linux/u-boot-rockchip/1_2017.09-r0/git/arch/arm/lib/bootm.c:498

Stack:
      [< ffffffff8278f004 >]         [< 0021757c >]  boot_selected_os+0x48/0x80
      [< 00216fbc >]  do_bootm_states+0x8d0/0x950
      [< 00226c44 >]  android_bootloader_boot_kernel+0x15c/0x250
      [< 00227918 >]  android_bootloader_boot_flow+0x2a0/0x2a4
      [< 00207970 >]  do_boot_android+0xd0/0xf8
      [< 0022c104 >]  cmd_process+0xdc/0x10c
      [< 00215284 >]  run_list_real+0x6e4/0x728
      [< 00215438 >]  parse_stream_outer+0x170/0x66c
      [< 00214b88 >]  parse_string_outer+0xcc/0xe4
      [< 0021513c >]  run_list_real+0x59c/0x728
      [< 00215438 >]  parse_stream_outer+0x170/0x66c
      [< 00214b4c >]  parse_string_outer+0x90/0xe4
      [< 0022b628 >]  run_command_list+0x50/0x90
      [< 00215ad8 >]  autoboot_command+0x40/0x114
      [< 00213984 >]  main_loop+0x58/0x68
      [< 00216150 >]  run_main_loop+0xc/0x10
      [< 0027c46c >]  initcall_run_list+0x58/0x94
      [< 00216364 >]  board_init_r+0x20/0x24
      [< 00201940 >]  relocation_return+0x4/0x0

PC Surrounding Instructions:
./make.sh: line 418: -D: command not found



I kindly ask, what could be the culprit?
What should I do next to further debug the issue?

What I especiall wonder is what does "WARNING: could not set reg
FDT_ERR_BADOFFSET." mean, is this harmful or leading to the root cause?

I have full boot logs for the working Dusun u-boot and my u-boot
available, is it from interest or helpful to post them here completely
to compare?

Also I found one - may be significant - difference:

My u-boot says:

Model: Rockchip RK3328 EVB
MPIDR: 0x80000000
PreSerial: 2, raw, 0xff130000
DRAM:  2 GiB
Sysmem: init
Relocation Offset: 7da71000
Relocation fdt: 7bc664a8 - 7bc67ce2
CR: M/C/I
Using default environment

The Dusun u-boot says:

Model: Rockchip RK3328 EVB
MPIDR: 0x80000000
PreSerial: 2, raw, 0xff130000
DRAM:  2 GiB
Sysmem: init
Relocation Offset: 7da71000
Relocation fdt: 7bc664a8 - 7bc67ce2
CR: M/C/I
Using default environment

Is the difference in "Relocation Offset" my problem?

Other Addresses appearing look similair in my u-boot like the Dusun
u-boot (kernel load addr, RAM banks added, device tree addresses...).

Kind Regards
Konstantin Kletschke



-- 
INSIDE M2M GmbH
Konstantin Kletschke
Berenbosteler Strasse 76 B
30823 Garbsen

Telefon: +49 (0) 5137 90950136
Mobil: +49 (0) 151 15256238
Fax: +49 (0) 5137 9095010

konstantin.kletschke@inside-m2m.de
http://www.inside-m2m.de 

Gesch"aftsf"uhrung: Michael Emmert, Derek Uhlig
HRB: 111204, AG Hannover

