Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB09CFC52F
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 09:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D81889003;
	Mon, 14 Oct 2024 11:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="g/AqL/nJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 239A488EF7; Mon, 14 Oct 2024 11:43:07 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by phobos.denx.de (Postfix) with ESMTP id C998189049
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 11:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=andyshrk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=j9LuE
 jCPFbM74wUm3Cd4E7AQOxUbxa6bxIpIYQ4po4k=; b=g/AqL/nJokr4rBonSks70
 1kYZgod+zzLsMJMC4S+5ZFoOaMEPh/Bio7M7ECBQdThSNx6VBCR5SiEzLV0CL7ty
 RYqBz5l2Bvv4QJ2wcgaR22vkmS+XPDe5c3IisiRpflSc36LwvU29Orwr2oiW1ReW
 BqAO+T3w+F5KULUhAgX/Zg=
Received: from ProDesk.. (unknown [58.22.7.114])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wD3P7yY5wxnyo9ABA--.5498S2; 
 Mon, 14 Oct 2024 17:42:52 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: trini@konsulko.com,
	sughosh.ganu@linaro.org,
	u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com,
	Andy Yan <andyshrk@163.com>
Subject: [Regression]  rk3588 failed to boot linux
Date: Mon, 14 Oct 2024 17:42:46 +0800
Message-ID: <20241014094246.2944-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3P7yY5wxnyo9ABA--.5498S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww1kCFyDGw1fur4UKF4UArb_yoW7CF1Dpr
 1agr15Gr48Jry7Jr17Jr1UtF1UJF4qyF17Jr1UCryjvr1UWw1UJr1UGrW8KayUJr4fJ3sr
 t3ZrJr42yr45Gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE0PfsUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMx14XmcM4MiVQwABsc
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

When test with current main branch on rk3588 based coolpi 4b,
the board failed to boot linux os[0]:
I do the same test on another board that is preparing to send
patches upstream, and it also failed.

The two boards boots fine with v2024.10.
With some bisect, it seems that this issue is caused by:

commit 360aaddd9cea8c256f50c576794415cadfb61819
Merge: 2c832abc732 f8ffc6f3cc4
Author: Tom Rini <trini@konsulko.com>
Date:   Tue Sep 3 14:09:30 2024 -0600

    Merge patch series "Make LMB memory map global and persistent"
    
    Sughosh Ganu <sughosh.ganu@linaro.org> says:

My boards boot fine before this merge on u-boot/next, and all failed
to boot linux after this merge.

I am not familiar with the LMB mechanism, so i don't know how to find
the root case now.

I dump the bdinfo for both good case[1] and gegression case[2], not sure
if they are usefull for debug this issue. 

[0] Synchronous Abort when starting kernel:
Scanning bootdev 'mmc@fe2c0000.bootdev':
Card did not respond to voltage select! : -110
Scanning bootdev 'mmc@fe2e0000.bootdev':
  1  script       ready   mmc          1  mmc@fe2e0000.bootdev.part
/boot/boot.scr
** Booting bootflow 'mmc@fe2e0000.bootdev.part_1' with script
Boot script loaded from mmc 0:1
224 bytes read in 7 ms (31.3 KiB/s)
26510301 bytes read in 97 ms (260.6 MiB/s)
32883200 bytes read in 122 ms (257 MiB/s)
148323 bytes read in 30 ms (4.7 MiB/s)
Working FDT set to 12000000
Trying kaslrseed command... Info: Unknown command can be safely ignored
since kaslrseed does not apply to all boards.
Unknown command 'kaslrseed' - try 'help'
## Loading init Ramdisk from Legacy Image at 12180000 ...
   Image Name:   uInitrd
   Image Type:   AArch64 Linux RAMDisk Image (gzip compressed)
   Data Size:    26510237 Bytes = 25.3 MiB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 12000000
   Booting using the fdt blob at 0x12000000
Working FDT set to 12000000
   Loading Ramdisk to eb58f000, end eced739d ... OK
   Loading Device Tree to 00000000eb502000, end 00000000eb58efff ... OK
Working FDT set to eb502000

Starting kernel ...

"Synchronous Abort" handler, esr 0x96000004, far 0x96142b896930b907
elr: 0000000000a8d3b8 lr : 0000000000a77450 (reloc)
elr: 00000000effa13b8 lr : 00000000eff8b450
x0 : 96142b896930b907 x1 : 00000000effab870
x2 : 0000000000000010 x3 : 00000000edf47310
x4 : 0000000000000000 x5 : 96142b896930b907
x6 : 0000000000000007 x7 : 0000000000000004
x8 : 0000000000000040 x9 : fffffffffffffff0
x10: 00000000eb526fff x11: 00000000edf3a808
x12: 0000000000000006 x13: 00000000eb502000
x14: 00000000ffffffff x15: 00000000ededb588
x16: 00000000eff68738 x17: 0000000000000000
x18: 00000000edef4d70 x19: 00000000eceb4040
x20: 00000000eff14f50 x21: 00000000eceac000
x22: 00000000effcc000 x23: 0000000000000001
x24: 0000000000000001 x25: 0000000000200000
x26: 00000000edf385c0 x27: 00000000eced8000
x28: 00000000eced9000 x29: 00000000ededb3c0

Code: eb04005f 54000061 52800000 14000006 (386468a3) 
Resetting CPU ...

[1] bdinfo for success boot
=> bdinfo 
boot_params = 0x0000000000000000
DRAM bank   = 0x0000000000000000
-> start    = 0x0000000000200000
-> size     = 0x00000000efe00000
DRAM bank   = 0x0000000000000001
-> start    = 0x00000001f0000000
-> size     = 0x0000000010000000
flashstart  = 0x0000000000000000
flashsize   = 0x0000000000000000
flashoffset = 0x0000000000000000
baudrate    = 1500000 bps
relocaddr   = 0x00000000eff14000
reloc off   = 0x00000000ef514000
Build       = 64-bit
current eth = unknown
eth-1addr   = (not set)
IP addr     = <NULL>
fdt_blob    = 0x00000000ededcd80
new_fdt     = 0x00000000ededcd80
fdt_size    = 0x0000000000017fa0
lmb_dump_all:
 memory.cnt = 0x2 / max = 0x10
 memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes flags: 0
 memory[1]      [0x1f0000000-0x1ffffffff], 0x10000000 bytes flags: 0
 reserved.cnt = 0x2 / max = 0x10
 reserved[0]    [0xeced8000-0xefffffff], 0x03128000 bytes flags: 0
 reserved[1]    [0x1f0000000-0x1ffffffff], 0x10000000 bytes flags: 0
devicetree  = separate
serial addr = 0x00000000feb50000
 width      = 0x0000000000000004
 shift      = 0x0000000000000002
 offset     = 0x0000000000000000
 clock      = 0x00000000016e3600
arch_number = 0x0000000000000000
TLB addr    = 0x00000000efff0000
irq_sp      = 0x00000000ededcd70
sp start    = 0x00000000ededcd70
Early malloc usage: 2440 / 10000
=> 


[2] bdinfo for boot failed case;
=> bdinfo 
boot_params = 0x0000000000000000
DRAM bank   = 0x0000000000000000
-> start    = 0x0000000000200000
-> size     = 0x00000000efe00000
DRAM bank   = 0x0000000000000001
-> start    = 0x00000001f0000000
-> size     = 0x0000000010000000
flashstart  = 0x0000000000000000
flashsize   = 0x0000000000000000
flashoffset = 0x0000000000000000
baudrate    = 1500000 bps
relocaddr   = 0x00000000eff14000
reloc off   = 0x00000000ef514000
Build       = 64-bit
current eth = unknown
eth-1addr   = (not set)
IP addr     = <NULL>
fdt_blob    = 0x00000000ededc1b0
lmb_dump_all:
 memory.count = 0x1
 memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes flags: none
 reserved.count = 0x1
 reserved[0]    [0xeced81a0-0xefffffff], 0x03127e60 bytes flags:
no-overwrite
devicetree  = separate
serial addr = 0x00000000feb50000
 width      = 0x0000000000000004
 shift      = 0x0000000000000002
 offset     = 0x0000000000000000
 clock      = 0x00000000016e3600
arch_number = 0x0000000000000000
TLB addr    = 0x00000000efff0000
irq_sp      = 0x00000000ededc1a0
sp start    = 0x00000000ededc1a0
Early malloc usage: 2440 / 10000
-- 
2.34.1

