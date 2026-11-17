Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD06606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EYHh8oV6;
	dkim=pass (1024-bit key, unprotected) header.d=netbsd.org header.i=@netbsd.org header.a=rsa-sha256 header.s=20240131 header.b=ul6XhqAU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4E7B80C8B;
	Tue, 17 Nov 2026 13:29:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dC0F2SmmvVOE; Tue, 17 Nov 2026 13:29:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CCA3380BCF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794922172;
	b=SIZVAjmamTYZJmI0fLhfo34H8Q9ZIJeDBI9DZxKXZSQh4BWImXj7PDAjyLJ7vOr12X71
	 25KmXNd/Q6UXvmsdeh5MjhA/qDwpLwxpb2RVK6kT+r0NYZYNS/q3VNvI1Fvn+Wa55x3BK
	 DmorEGd5x9MOArbbo1f1dMlD/ZN7Iyjxgg/Uja8gFfqe5ZY/pPRfugioSvxoSAdlzAeLJ
	 ahdZncRDW+OkA3I9SRsIiH7/klwvPTTkG50iCPIYMZ9lNfhY/3K/xiNTrlJhLW6PKfdDS
	 AdJrZI3/Cpqeyt+B61JHb3HLQ5O6UVjhLXZjwhaihH1b0MJueYV6/H/+pFazD0oRgRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794922172;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jvftXw8z+VsKYcGRJ7npNsmDI2r1UY5uJlYsPsI0gYA=;
	b=Y0tSytTd3ORac99bw5F0juAdB8qNiarS7gm1FmH8aqtNo0t72ZtemU2GbaieaEt/Yjvv
	 v66c7Qq8tiADkzGj9m6rY7BZCJnSTjydBkfX5jO3P90Tru3UHAdQwt3oSwkEejYPzvjqF
	 yYo9j4uNqG54zR2k6busgihjsbVfYh6OaaJ5LzCO7mG86zNsUSpv9+Me4zKKVe2sBnHuM
	 E8z7QN5vEheLlUABqYRCWI5UOJ67KpcLJqHf4gkSLwv5ONhglWetsOGXI8H1yxqLpXmN+
	 bYYnA50Lh8C5kzc8vbihVLmERDS0zwWE5j1QMv1KF7OjYmRQGO12lcDKA2pgt573kKA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794922171;
	bh=jvftXw8z+VsKYcGRJ7npNsmDI2r1UY5uJlYsPsI0gYA=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EYHh8oV6+cZPxgZkQ2wjbB7QtSfcl++cbYSfavDbCGLgEFAXMYcqUaO4okLXr6J+m
	 SvBHb5YkOYL0iQdWZHMRwxOpQt2Glql14M39qfAkPJR9rS7mKZYt+1gVU4Ty+2+w3/
	 OFuzUUncY74J+2bVOCsDBnubemUg6l9vTidP3QfAoNfEAzAHvw3CeJjYiYV7gWgmoz
	 ARkaiCpiisOPCS+rUIvbzucEsZA9LGK8lfFQapFQHgHH4PDnztSx3V/fSX3PC0Yloj
	 esCXk34ii4tHVQ3NjJXRQATWmO77ZQdT/Xr3awTVhUKMROwWDcgL5lT9t+Hf1D7i18
	 Qoq2Fp8d6qhCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCA3380BCF;
	Tue, 17 Nov 2026 13:29:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AB1A2105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:29:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C827405CF
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:29:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZaQjZE9dPSFc for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 13:29:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E4E50405C5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:470:a085:999::25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:470:a085:999::25; helo=mail.netbsd.org;
 envelope-from=martin@netbsd.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=NetBSD.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=netbsd.org header.i=@netbsd.org header.a=rsa-sha256
 header.s=20240131 header.b=ul6XhqAU
Received: from mail.netbsd.org (mail.NetBSD.org [IPv6:2001:470:a085:999::25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E4E50405C5
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:29:27 +0000 (UTC)
Received: by mail.netbsd.org (Postfix, from userid 1214)
 id 260D284DCE; Tue, 17 Nov 2026 13:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netbsd.org;
 s=20240131; t=1794922166;
 bh=jvftXw8z+VsKYcGRJ7npNsmDI2r1UY5uJlYsPsI0gYA=;
 h=Date:From:To:Subject;
 b=ul6XhqAUPqDYu2l7bOFTtCBtsri5EE4K/kW2WAtQ5rRjKSNHApSIwUpKkEki31SUL
 8qoSO5bBqpk4VBlHtjrbezA7QrMXDLLo70TZbokYSqx+9QFNhdYzh0JjMKRF5Lj4ys
 WgsEKQ76pQV38S2zkUK2fBBVlsKskVCAtis1U6KM=
Date: Tue, 17 Nov 2026 14:29:23 +0100
From: Martin Husemann <martin@NetBSD.org>
To: u-boot@lists.u-boot-project.org
Subject: StarFive VisionFive 2: NVME not responding randomly
Message-ID: <avxWs2PzYcvPidNw@big-apple.aprisoft.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi folks,

I boot my StarFive VisionFive 2 from NVME usually, but "sometimes"
(which is actually qite often) u-boot does not recognize the NVME
and can't read the partition.

Full boot lo of a working boot below. When it doesn't work it
says:

[..]
USB XHCI 1.00
Bus xhci_pci: 2 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Working FDT set to ff6f4430
Hit any key to stop autoboot: 0
Card did not respond to voltage select! : -110
Card did not respond to voltage select! : -110
    <------- all normal untill here, now the difference starts:
** Invalid partition 1 **
Couldn't find partition nvme 0:1
** Invalid partition 1 **
Couldn't find partition nvme 0:1
Cannot persist EFI variables without system partition
** Invalid partition 1 **
Couldn't find partition nvme 0:1
** Invalid partition 1 **
Couldn't find partition nvme 0:1
** Booting bootflow '<NULL>' with efi_mgr
Loading Boot0000 'nvme 0' failed
EFI boot manager: Cannot load any image
Boot failed (err=3D-14)


I tried everything obvious: software reset, reset button, removing power for
a minute - nothing made a difference. Sometime later it just works again.

I can build a debug version, but would like to hear some hints what
debug stuff I should enable for that, or any hints where to look.

Thanks,

Martin

working boot:

U-Boot SPL 2026.10 (Nov 12 2026 - 10:42:43 +0100)
DDR version: dc2e84f0.
Trying to boot from SPI

OpenSBI v1.9
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name               : StarFive VisionFive 2 v1.3B
Platform Features           : medeleg
Platform HART Count         : 4
Platform HART Protection    : pmp
Platform IPI Device         : aclint-mswi
Platform Timer Device       : aclint-mtimer @ 4000000Hz
Platform Console Device     : uart8250
Platform HSM Device         : ---
Platform PMU Device         : ---
Platform Reboot Device      : pm-reset
Platform Shutdown Device    : pm-reset
Platform Suspend Device     : ---
Platform CPPC Device        : ---
Firmware Base               : 0x40000000
Firmware Size               : 357 KB
Firmware RW Offset          : 0x40000
Firmware RW Size            : 101 KB
Firmware Heap Offset        : 0x4d000
Firmware Heap Size          : 49 KB (total), 0 KB (reserved), 15 KB (used),=
 32 KB (free)
Firmware Scratch Size       : 4096 B (total), 504 B (used), 3592 B (free)
Runtime SBI Version         : 3.0
Standard SBI Extensions     : rfnc,ipi,base,hsm,srst,pmu,dbcn,fwft,legacy,d=
btr,sse,time
Experimental SBI Extensions : none

Domain0 Name                : root
Domain0 Boot HART           : 3
Domain0 HARTs               : 0x1*,0x2*,0x3*,0x4*
Domain0 Region00            : 0x0000000040040000-0x000000004005ffff M: (F,R=
,W) S/U: ()
Domain0 Region01            : 0x0000000040000000-0x000000004003ffff M: (F,R=
,X) S/U: ()
Domain0 Region02            : 0x0000000010000000-0x0000000010000fff M: (I,R=
,W) S/U: (R,W)
Domain0 Region03            : 0x0000000002000000-0x000000000200ffff M: (I,R=
,W) S/U: ()
Domain0 Region04            : 0x000000000c000000-0x000000000fffffff M: (I,R=
,W) S/U: (R,W)
Domain0 Region05            : 0x0000000000000000-0xffffffffffffffff M: () S=
/U: (R,W,X)
Domain0 Next Address        : 0x0000000040200000
Domain0 Next Arg1           : 0x00000000402e5628
Domain0 Next Mode           : S-mode
Domain0 SysReset            : yes
Domain0 SysSuspend          : yes

Boot HART ID                : 3
Boot HART Domain            : root
Boot HART Priv Version      : v1.11
Boot HART Base ISA          : rv64imafdcbx
Boot HART ISA Extensions    : zihpm,sdtrig,f,d
Boot HART PMP Count         : 8
Boot HART PMP Granularity   : 12 bits
Boot HART PMP Address Bits  : 34
Boot HART MHPM Info         : 2 (0x00000018)
Boot HART Debug Triggers    : 8 triggers
Boot HART MIDELEG           : 0x0000000000000222
Boot HART MEDELEG           : 0x000000000000b109


U-Boot 2026.10 (Nov 12 2026 - 10:42:43 +0100)

CPU:   sifive,u74-mc
Model: StarFive VisionFive 2 v1.3B
DRAM:  8 GiB
Core:  159 devices, 30 uclasses, devicetree: board
WDT:   Not starting watchdog@13070000
MMC:   mmc@16010000: 0, mmc@16020000: 1
Loading Environment from SPIFlash...=0DSF: Detected gd25lq128 with page siz=
e 256 Bytes, erase size 4 KiB, total 16 MiB
*** Warning - bad CRC, using default environment

StarFive EEPROM format v2

--------EEPROM INFO--------
Vendor : StarFive Technology Co., Ltd.
Product full SN: VF7110B1-2253-D008E000-00004536
data version: 0x2
PCB revision: 0xb2
BOM revision: A
Ethernet MAC0 address: 6c:cf:39:00:46:cc
Ethernet MAC1 address: 6c:cf:39:00:46:cd
--------EEPROM INFO--------

In:    serial@10000000
Out:   serial@10000000
Err:   serial@10000000
Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
starting USB...
USB XHCI 1.00
Bus xhci_pci: 2 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found
Working FDT set to ff6f4430
=1B[2K=0DHit any key to stop autoboot: 2=1B[2K=0DHit any key to stop autobo=
ot: 0
StarFive # nvme detail
Blk device 0: Optional Admin Command Support:
	Namespace Management/Attachment: no
	Firmware Commit/Image download: yes
	Format NVM: yes
	Security Send/Receive: yes
Blk device 0: Optional NVM Command Support:
	Reservation: yes
	Save/Select field in the Set/Get features: no
	Write Zeroes: yes
	Dataset Management: yes
	Write Uncorrectable: yes
Blk device 0: Format NVM Attributes:
	Support Cryptographic Erase: yes
	Support erase a particular namespace: Yes
	Support format a particular namespace: No
Blk device 0: LBA Format Support:
Blk device 0: End-to-End DataProtect Capabilities:
	As last eight bytes: No
	As first eight bytes: No
	Support Type3: No
	Support Type2: No
	Support Type1: No
Blk device 0: Metadata capabilities:
	As part of a separate buffer: No
	As part of an extended data LBA: No
StarFive # nvme info
Device 0: Vendor: 0x144d Rev: 5B2QGXA7 Prod: S5GYNX0T302900W    =20
            Type: Hard Disk
            Capacity: 476940.0 MB =3D 465.7 GB (976773168 x 512)
StarFive # nvme part
Partition Map for nvme device 0  --   Partition Type: EFI

Part	Start LBA	End LBA		Name
	Attributes
	Type GUID
	Partition GUID
  1	0x00000040	0x0002003f	"NvmeEFI"
	attrs:	0x0000000000000000
	type:	c12a7328-f81f-11d2-ba4b-00a0c93ec93b
		(EFI System Partition)
	guid:	f0fa7669-f18e-4335-9267-9bee56f2db5f
  2	0x00020040	0x0142003f	"NvmeSwap"
	attrs:	0x0000000000000000
	type:	49f48d32-b10e-11dc-b99b-0019d1879648
		(49f48d32-b10e-11dc-b99b-0019d1879648)
	guid:	7f8fc315-f7e6-467a-8811-79c272b1e331
  3	0x01420040	0x3a38600e	"NvmeRoot"
	attrs:	0x0000000000000000
	type:	49f48d5a-b10e-11dc-b99b-0019d1879648
		(49f48d5a-b10e-11dc-b99b-0019d1879648)
	guid:	689f41fa-13d8-43c9-b409-4acddeec0476
StarFive #

(and it would have booted from the EFI partition hapilly if I hadn't=20
interrupted it here)
