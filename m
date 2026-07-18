Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EF7C4450A
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 22:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB8E7846B0;
	Sun, 19 Jul 2026 00:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=vicb.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=vicb.net header.i=@vicb.net header.b="JRqVxiCV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25EDC848A1; Sat, 18 Jul 2026 18:03:14 +0200 (CEST)
Received: from mx0.gmx.wtf (mx0.gmx.wtf [203.137.112.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B7BE84659
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 18:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vicb.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@vicb.net
Date: Sat, 18 Jul 2026 18:03:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=vicb.net;
 s=f747d04263f05989; t=1784390587;
 bh=GLXZrkfnByyLluv2PJiuT2vGlZcWhAmhyGi3snbCnDM=;
 h=Date:From:To:Subject:From;
 b=JRqVxiCVZQhBYUQ9aIfMf5KPWHGmaQ9QpC4kk64b8q2MURifRD0DOoDRyOMEKjR+J
 R1YBYtiIGzm6IR6fCmu6cSs/Y+MmdNRBbVTheZKEggYZnfEjrMUE6j98tYsmKvn9jB
 lobXeVWka63atiLZiK2MgkV4QzLAHyXGzbMFoTBgziTdd8ahkmlD9Dm/hBiKjRysNB
 Q8VgjYwJ5+N69B7hoESM9bbfqn3yZES2xyU61adpDliwlQmfVQQ15Ncyrlyjm067VD
 iYUX/8yFZGMW66WWhbWQuY1cq1a5x5gsdQp/wQj/qIo3zD69zBGMRCoy5rv6YgqU2C
 UiXyBc2PPt2QA==
From: Vic B <u-boot@vicb.net>
To: u-boot@lists.denx.de
Subject: RK3399 TF-A hash verification failure for atf-3
Message-ID: <alujuCnNh13eRfdA@vicb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Sun, 19 Jul 2026 00:54:28 +0200
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

while trying to compile u-boot v2026.07 (or v2026.04) for RK3399-based
NanoPi R4S, I run into issues with current mainline TF-A (using 2.14, more
precisely the lts-v2.14.4 tag). I'm cross-compiling both TF-A and u-boot
using GCC version 14.2.0 (Debian 14.2.0-19) from Debian Trixie.

First, I encountered TF-A build failure with the

 region `PMUSRAM' overflowed by 3928 bytes

error message, which seems to be a long-term issue know since 2018:

 https://github.com/ARM-software/tf-issues/issues/650

and recently also mentioned in this mailing list:

 https://lists.denx.de/pipermail/u-boot/2026-April/613754.html

Although some discussions suggest that this issue may be compiler or
toolchain dependent, I've eventually found a solution in Armbian
sources, which fix this issue by changing PMUSRAM_RSIZE from 8K to 16K:

 https://github.com/armbian/build/blob/main/patch/atf/atf-rockchip64/v2.14/1002-2.14-rk3399-PMUSRAM_RSIZE-8k-16k.patch

I'm also using two other Armbian RK3399-related patches to TF-A as these
looked useful to me:

 https://github.com/armbian/build/blob/main/patch/atf/atf-rockchip64/v2.14/1001-2.14-rk3399-m0-LDFLAGS-no-pie.patch
 https://github.com/armbian/build/blob/main/patch/atf/atf-rockchip64/v2.14/1003-rk3399-fix-pl330-dmac-sgrf-init.patch

With all these patches applied to TF-A lts-v2.14.4, I can successfully
build TF-A and get bl31.elf with .pmusram segment of 0x2f58 (12120)
bytes (i.e. 8192 bytes of the original limit plus 3928 bytes which used
to overflow without the patch):

 $ readelf -l ../trusted-firmware-a/build/rk3399/release/bl31/bl31.elf

 Elf file type is EXEC (Executable file)
 Entry point 0x40000
 There are 6 program headers, starting at offset 64

 Program Headers:
   Type           Offset             VirtAddr           PhysAddr
                  FileSiz            MemSiz              Flags  Align
   LOAD           0x0000000000010000 0x0000000000040000 0x0000000000040000
                  0x0000000000023000 0x0000000000023000  R E    0x10000
   LOAD           0x0000000000033000 0x0000000000063000 0x0000000000063000
                  0x0000000000000051 0x0000000000081000  RW     0x1000
   LOAD           0x0000000000034000 0x00000000ff3b0000 0x00000000ff3b0000
                  0x0000000000002f58 0x0000000000002f58  RWE    0x1000
   LOAD           0x0000000000037000 0x00000000ff8c0000 0x00000000ff8c0000
                  0x0000000000002000 0x0000000000002000  R E    0x1000
   LOAD           0x0000000000000000 0x00000000ff8c2000 0x00000000ff8c2000
                  0x0000000000000000 0x0000000000001000  RW     0x1000
   GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                  0x0000000000000000 0x0000000000000000  RW     0x10

  Section to Segment mapping:
   Segment Sections...
    00     .ro
    01     .data .stacks .bss .per_cpu .xlat_table .coherent_ram
    02     .pmusram
    03     .incbin_sram .text_sram
    04     .stack_sram
    05

I can also successfully build u-boot with nanopi-r4s-rk3399_defconfig
and this bl31.elf, where a 12120 bytes blob goes to atf-3 according to
mkimage:

 Image 3 (atf-3)
  Description:  ARM Trusted Firmware
  Created:      Sat Jul 18 17:02:03 2026
  Type:         Firmware
  Compression:  uncompressed
  Data Size:    12120 Bytes = 11.84 KiB = 0.01 MiB
  Architecture: AArch64
  OS:           ARM Trusted Firmware
  Load Address: 0xff3b0000
  Hash algo:    sha256
  Hash value:   bb3956f441de43bdc2b0946e2429f1166b4e54fe67cbca6c9fbfa9371b5ecfc9

Sadly, when I try to boot it from SD card, it fails because of hash
verification failure for atf-3:

 U-Boot SPL 2026.07 (Jul 17 2026 - 15:40:20 +0200)
 Trying to boot from MMC2
 ## Checking hash(es) for config config-1 ... OK
 ## Checking hash(es) for Image atf-1 ... sha256+ OK
 ## Checking hash(es) for Image u-boot ... sha256+ OK
 ## Checking hash(es) for Image fdt-1 ... sha256+ OK
 ## Checking hash(es) for Image atf-2 ... sha256+ OK
 ## Checking hash(es) for Image atf-3 ... sha256 error!
 Bad hash value for 'hash' hash node in 'atf-3' image node
 spl_load_simple_fit: can't load image loadables index 2 (ret = -1)
 mmc_load_image_raw_sector: mmc block read error

An easy workaround is to disable FIT verification (SPL_FIT_SIGNATURE
and CONFIG_SPL_FIT_FULL_CHECK) in the SPL, without these I get a working
u-boot and smooth running linux-6.18.38 without any signs of trouble:

 U-Boot TPL 2026.07 (Jul 15 2026 - 17:34:15)
 Trying to boot from BOOTROM
 Returning to boot ROM...

 U-Boot SPL 2026.07 (Jul 15 2026 - 17:34:15 +0200)
 Trying to boot from MMC2
 load_simple_fit: Skip load 'atf-5': image size is 0!
 NOTICE:  BL31: v2.14.4(release):lts-v2.14.4-3-g4660bf8b7
 NOTICE:  BL31: Built : 22:54:17, Jul 14 2026


 U-Boot 2026.07 (Jul 15 2026 - 17:34:15 +0200)

 SoC: Rockchip rk3399
 Reset cause: POR
 Model: FriendlyElec NanoPi R4S
 DRAM:  4 GiB (total 3.9 GiB)
 PMIC:  RK808 
 Core:  281 devices, 25 uclasses, devicetree: separate
 MMC:   mmc@fe320000: 1
 Loading Environment from <NULL>... OK
 In:    serial
 Out:   serial
 Err:   serial
 Model: FriendlyElec NanoPi R4S
 Hit any key to stop autoboot: 0
 ** Booting bootflow 'mmc@fe320000.bootdev.part_1' with script
 7211491 bytes read in 310 ms (22.2 MiB/s)
 62459 bytes read in 5 ms (11.9 MiB/s)
    Uncompressing Kernel Image to 0
 ## Flattened Device Tree blob at 12000000
    Booting using the fdt blob at 0x12000000
 Working FDT set to 12000000
    Loading Device Tree to 00000000f4f63000, end 00000000f4f753fa ... OK
 Working FDT set to f4f63000

 Starting kernel ...

However, the need to disable SPL FIT verifications because of the
mysterious hash verification failure for atf-3 (which seems to contain
the PMUSRAM blob whose size I had to change from 8K to 16K to fix the
TF-A build failure) makes the resulting system considerably less
trustworthy to me.

I suspect that the PMUSRAM_RSIZE setting in TF-A may have a
corresponding counterpart in u-boot, which may need to be changed too
when the TF-A value is raised from 8K to 16K. But I didn't manage to
find any such setting in u-boot.

Also, I'm also quite confused that despite mainline TF-A failing to
build for RK3399, there seem to be several people submitting recent
patches for RK3399 boards to u-boot. As TF-A is required by u-boot for
RK3399, this makes me wonder what version of TF-A those people use
and/or how they fix the PMUSRAM region overflow issue.

Any hints or thoughts on what is wrong here will be appreciated.

Vic
