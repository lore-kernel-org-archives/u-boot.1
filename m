Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33474C30653
	for <u-boot@archiver.kernel.org>; Sun,  7 Jul 2024 12:50:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CCEF882B6;
	Sun,  7 Jul 2024 14:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F4FF87F5C; Sun,  7 Jul 2024 04:41:28 +0200 (CEST)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by phobos.denx.de (Postfix) with ESMTP id A8C3287EDC
 for <u-boot@lists.denx.de>; Sun,  7 Jul 2024 04:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vt@altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
 by vmicros1.altlinux.org (Postfix) with ESMTP id 2D03672C8F5
 for <u-boot@lists.denx.de>; Sun,  7 Jul 2024 05:41:26 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
 by imap.altlinux.org (Postfix) with ESMTPSA id 2404D36D0193
 for <u-boot@lists.denx.de>; Sun,  7 Jul 2024 05:41:26 +0300 (MSK)
Date: Sun, 7 Jul 2024 05:41:25 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: u-boot@lists.denx.de
Subject: x86_64+kvm: int_exception_handler() Exception 13 while executing
 option rom
Message-ID: <20240707024125.npvtj43nnddv7uwu@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
X-Mailman-Approved-At: Sun, 07 Jul 2024 14:50:46 +0200
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

I noticed that u-boot.rom does not boot in qemu-system-x86_64 (8.2.4)
with KVM accelerator:

  builder@x86_64:~/RPM/BUILD/u-boot-qemu-2024.07$ qemu-system-x86_64 -M accel=kvm -nographic -bios ./u-boot.rom
  
  U-Boot SPL 2024.07 (Jul 04 2024 - 09:26:24 +0000)
  int_exception_handler() Exception 13 while executing option rom
  <hangs>

The same rom with `-M accel=tcg` boots OK[1].

Thanks,

[1] ps. Log of TCG boot:

  builder@x86_64:~/RPM/BUILD/u-boot-qemu-2024.07$ qemu-system-x86_64 -M accel=tcg -nographic -bios ./u-boot.rom

  U-Boot SPL 2024.07 (Jul 04 2024 - 09:26:24 +0000)
  Video: 1024x768x32
	  alloc_simple() alloc space exhausted
  Trying to boot from SPI
  Jumping to 64-bit U-Boot: Note many features are missing


  U-Boot 2024.07 (Jul 04 2024 - 09:26:24 +0000)

  CPU:   QEMU Virtual CPU version 2.5+
  DRAM:  128 MiB
  Core:  20 devices, 13 uclasses, devicetree: separate
  Loading Environment from nowhere... OK
  Video: 1024x768x0
  Model: QEMU x86 (I440FX)
  Net:   e1000: 52:54:00:12:34:56
	 eth0: e1000#0

  Hit any key to stop autoboot:  0
  Scanning for bootflows in all bootdevs
  Seq  Method       State   Uclass    Part  Name                      Filename
  ---  -----------  ------  --------  ----  ------------------------  ----------------
  Scanning global bootmeth 'efi_mgr':
  efi_set_blk_dev_to_system_partition() No EFI system partition
  efi_set_blk_dev_to_system_partition() No EFI system partition
       efi_var_to_file() Failed to persist EFI variables
  Hunting with: nvme
  Hunting with: qfw
  Hunting with: scsi
  scanning bus for devices...
  Hunting with: virtio
  Scanning bootdev 'qfw_pio.bootdev':
  fatal: no kernel available
  Hunting with: ide
  Bus 0: not available  Bus 1: OK
    Device 2: Model: QEMU Firm: 2.5+ Ser#: QEMU DVD-ROM
	      Type: Removable CD ROM
	      Capacity: not available
    Device 3: not available
  Hunting with: usb
  No USB controllers found
  Hunting with: ethernet
  BOOTP broadcast 1
  BOOTP broadcast 2
  BOOTP broadcast 3
  DHCP client bound to address 10.0.2.15 (1001 ms)
  Scanning bootdev 'e1000#0.bootdev':
  BOOTP broadcast 1
  BOOTP broadcast 2
  BOOTP broadcast 3
  DHCP client bound to address 10.0.2.15 (1000 ms)
  *** Warning: no boot file name; using '0A00020F.img'
  Using e1000#0 device
  TFTP from server 10.0.2.2; our IP address is 10.0.2.15
  Filename '0A00020F.img'.
  Load address: 0x1000000
  Loading: *
  TFTP error: 'Access violation' (2)
  Not retrying...
  No more bootdevs
  ---  -----------  ------  --------  ----  ------------------------  ----------------
  (0 bootflows, 0 valid)
  =>

