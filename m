Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D8E606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IzyJ15t5;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=hfEIQfdU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA67B60735;
	Wed, 18 Nov 2026 07:55:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BV2Eh_xxweSO; Wed, 18 Nov 2026 07:55:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 469236081A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794988548;
	b=i44gUGdmycNP/PjZj2GxZZ/+sW3Kc/gLHiRadWUeogGxBkHMZpTe2Uuxl251n9r3H8dz
	 BW/wigfjsdMlWhsCY69LqPqozJY4joloM2BEWZrYcpO07ULm4Bx8FWbGyR+x6hmWyjccm
	 qKuvMt+ZUk+PWEOH0xFEfRLZw7V+sVIHI6iC7KaKTklEsS2ZxjVJFDHqV3ujHLAkxqeEL
	 QGbkrjELGkB3i4lq+B8tnZUwZjWnP8JWlS/hXegAkIOp+vVS0JdXy15D7nk1AsbJG6rpE
	 PoKn7onik0lnrbl/MpdPy30qqpNgAiZOAx23lFBg2xzpPcz83e5a887MfzRvK1SPGXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794988548;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B9Bl4AZWxr/MoWVJj6WWp9czTatOsn7vdhZOdIRSyuI=;
	b=EXyXiB8UJyMIZPTl54R1qN0M2mxj6IA3XGsCoB/7qDl4k1iJ0b3KSwBbPoOOxKhRhhL+
	 9R7ap3QzDKW1U8EOyWckclA5J+5QaSGwGK3zbUnEDfIIoUgAK8iv1goHnvnzKg1+R27Xz
	 Wzjs2s2ahlzFkxPuGBkITq3vBmYdCEUJ/6Zap2vhXlHEq5nRTqZqo0qzy9e2xGIy7KKLX
	 XqALd2diOawEi2+eKLpfjgEWPVr8VouQ3yTtSX9gPwCDmUgCp4EtSKFAFH/qMBWT1uCL4
	 95mM8NIUpyf6XSuVab0OJJfeaAdzj5eeo/t2AuJe7Gvt0xQONmD1tL0Ozf4vttDNhHQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794988548;
	bh=B9Bl4AZWxr/MoWVJj6WWp9czTatOsn7vdhZOdIRSyuI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IzyJ15t5UTlzfeVNFjSfNUoyOv46ewR6tZTQgVRWMjAEMobFivisfEo5Bx/LS11vJ
	 2seclbL8UtORgOpJZ5vjqydnlkplYnqjcLNcJWIZ2Btm7RD8p06ybqwICYnPHiEQha
	 HWGTlSc1Ks/2rnv/gOtRJcRX9bYuFdtSYG4hUz64Gr4yefjlz4ejLHHf8hm7IEetff
	 XVg2Ok15yJznEI4O8eyBj75Bv16RW2HzReF1fAS35bZ8iCXRdoUBE3ajvW3nMG1cAm
	 KqpokooD4WDB7cmoWdL0Q91aoXVWwccEQhr6T63Xk68IpEORawTTRHJVI1uvhkVVwP
	 59muTMBzdFLqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 469236081A;
	Wed, 18 Nov 2026 07:55:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 83FDFD33
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A2D240852
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:55:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x94Y6qZDRlDE for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 07:55:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 91ECF40855
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=hfEIQfdU
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 91ECF40855
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1794988539;
 bh=B9Bl4AZWxr/MoWVJj6WWp9czTatOsn7vdhZOdIRSyuI=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=hfEIQfdUTCNZ1jbkStV41O46zaSfgEvq8WaR0JDbDZO2Tv8+rNmxBDM29OyHVeDfr
 +Nnu8tbQRo+q40PKip3Fl/7Xrpj+25+oztkPLY18o2ByaTL/6jMFvtlkE6oWNr2920
 16d8Hd/7YLVY7aDr973B1wqGCZArgu5gwyMkP7Jsc6coY3U5d0j5jHqGrXJO2ThxXE
 NkjjX8OCg7G2wamSoUoYiw/69heyNGyijQI16UDLktKzVCLUFJYocLW4wTrQ1PjFUU
 tYga3Z1A+56BXVeskJpkY4GjaHnCz6naqB1EasDWAreTa0VSor/L+lpNaIYkpdZ1VT
 adXECSoZTSvCw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 1C947B221C7F;
 Wed, 18 Nov 2026 08:55:38 +0100 (CET)
Message-ID: <5e9eeca5-6772-4aae-b2a7-d49b1676f6d5@freeshell.de>
Date: Tue, 17 Nov 2026 23:55:36 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: StarFive VisionFive 2: NVME not responding randomly
To: Martin Husemann <martin@NetBSD.org>, u-boot@lists.u-boot-project.org
References: <avxWs2PzYcvPidNw@big-apple.aprisoft.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <avxWs2PzYcvPidNw@big-apple.aprisoft.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Martin,

On 11/17/26 05:29, Martin Husemann wrote:
> Hi folks,
> 
> I boot my StarFive VisionFive 2 from NVME usually, but "sometimes"
> (which is actually qite often) u-boot does not recognize the NVME
> and can't read the partition.
> 
> Full boot lo of a working boot below. When it doesn't work it
> says:
> 
> [..]
> USB XHCI 1.00
> Bus xhci_pci: 2 USB Device(s) found
>        scanning usb for storage devices... 0 Storage Device(s) found
> Working FDT set to ff6f4430
> Hit any key to stop autoboot: 0
> Card did not respond to voltage select! : -110
> Card did not respond to voltage select! : -110
>     <------- all normal untill here, now the difference starts:
> ** Invalid partition 1 **
> Couldn't find partition nvme 0:1
> ** Invalid partition 1 **
> Couldn't find partition nvme 0:1
> Cannot persist EFI variables without system partition
> ** Invalid partition 1 **
> Couldn't find partition nvme 0:1
> ** Invalid partition 1 **
> Couldn't find partition nvme 0:1
> ** Booting bootflow '<NULL>' with efi_mgr
> Loading Boot0000 'nvme 0' failed
> EFI boot manager: Cannot load any image
> Boot failed (err=-14)
> 
> 
> I tried everything obvious: software reset, reset button, removing power for
> a minute - nothing made a difference. Sometime later it just works again.
> 
> I can build a debug version, but would like to hear some hints what
> debug stuff I should enable for that, or any hints where to look.
> 
> Thanks,
> 
> Martin
> 
> working boot:
> 
> U-Boot SPL 2026.10 (Nov 12 2026 - 10:42:43 +0100)
> DDR version: dc2e84f0.
> Trying to boot from SPI
> 
> OpenSBI v1.9
>    ____                    _____ ____ _____
>   / __ \                  / ____|  _ \_   _|
>  | |  | |_ __   ___ _ __ | (___ | |_) || |
>  | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
>  | |__| | |_) |  __/ | | |____) | |_) || |_
>   \____/| .__/ \___|_| |_|_____/|____/_____|
>         | |
>         |_|
> 
> Platform Name               : StarFive VisionFive 2 v1.3B
> Platform Features           : medeleg
> Platform HART Count         : 4
> Platform HART Protection    : pmp
> Platform IPI Device         : aclint-mswi
> Platform Timer Device       : aclint-mtimer @ 4000000Hz
> Platform Console Device     : uart8250
> Platform HSM Device         : ---
> Platform PMU Device         : ---
> Platform Reboot Device      : pm-reset
> Platform Shutdown Device    : pm-reset
> Platform Suspend Device     : ---
> Platform CPPC Device        : ---
> Firmware Base               : 0x40000000
> Firmware Size               : 357 KB
> Firmware RW Offset          : 0x40000
> Firmware RW Size            : 101 KB
> Firmware Heap Offset        : 0x4d000
> Firmware Heap Size          : 49 KB (total), 0 KB (reserved), 15 KB (used), 32 KB (free)
> Firmware Scratch Size       : 4096 B (total), 504 B (used), 3592 B (free)
> Runtime SBI Version         : 3.0
> Standard SBI Extensions     : rfnc,ipi,base,hsm,srst,pmu,dbcn,fwft,legacy,dbtr,sse,time
> Experimental SBI Extensions : none
> 
> Domain0 Name                : root
> Domain0 Boot HART           : 3
> Domain0 HARTs               : 0x1*,0x2*,0x3*,0x4*
> Domain0 Region00            : 0x0000000040040000-0x000000004005ffff M: (F,R,W) S/U: ()
> Domain0 Region01            : 0x0000000040000000-0x000000004003ffff M: (F,R,X) S/U: ()
> Domain0 Region02            : 0x0000000010000000-0x0000000010000fff M: (I,R,W) S/U: (R,W)
> Domain0 Region03            : 0x0000000002000000-0x000000000200ffff M: (I,R,W) S/U: ()
> Domain0 Region04            : 0x000000000c000000-0x000000000fffffff M: (I,R,W) S/U: (R,W)
> Domain0 Region05            : 0x0000000000000000-0xffffffffffffffff M: () S/U: (R,W,X)
> Domain0 Next Address        : 0x0000000040200000
> Domain0 Next Arg1           : 0x00000000402e5628
> Domain0 Next Mode           : S-mode
> Domain0 SysReset            : yes
> Domain0 SysSuspend          : yes
> 
> Boot HART ID                : 3
> Boot HART Domain            : root
> Boot HART Priv Version      : v1.11
> Boot HART Base ISA          : rv64imafdcbx
> Boot HART ISA Extensions    : zihpm,sdtrig,f,d
> Boot HART PMP Count         : 8
> Boot HART PMP Granularity   : 12 bits
> Boot HART PMP Address Bits  : 34
> Boot HART MHPM Info         : 2 (0x00000018)
> Boot HART Debug Triggers    : 8 triggers
> Boot HART MIDELEG           : 0x0000000000000222
> Boot HART MEDELEG           : 0x000000000000b109
> 
> 
> U-Boot 2026.10 (Nov 12 2026 - 10:42:43 +0100)
> 
> CPU:   sifive,u74-mc
> Model: StarFive VisionFive 2 v1.3B
> DRAM:  8 GiB
> Core:  159 devices, 30 uclasses, devicetree: board
> WDT:   Not starting watchdog@13070000
> MMC:   mmc@16010000: 0, mmc@16020000: 1
> Loading Environment from SPIFlash...
> SF: Detected gd25lq128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
> *** Warning - bad CRC, using default environment
> 
> StarFive EEPROM format v2
> 
> --------EEPROM INFO--------
> Vendor : StarFive Technology Co., Ltd.
> Product full SN: VF7110B1-2253-D008E000-00004536
> data version: 0x2
> PCB revision: 0xb2
> BOM revision: A
> Ethernet MAC0 address: 6c:cf:39:00:46:cc
> Ethernet MAC1 address: 6c:cf:39:00:46:cd
> --------EEPROM INFO--------
> 
> In:    serial@10000000
> Out:   serial@10000000
> Err:   serial@10000000
> Net:   eth0: ethernet@16030000, eth1: ethernet@16040000
> starting USB...
> USB XHCI 1.00
> Bus xhci_pci: 2 USB Device(s) found
>        scanning usb for storage devices... 0 Storage Device(s) found
> Working FDT set to ff6f4430
> [2K
> Hit any key to stop autoboot: 2[2K
> Hit any key to stop autoboot: 0
> StarFive # nvme detail
> Blk device 0: Optional Admin Command Support:
> 	Namespace Management/Attachment: no
> 	Firmware Commit/Image download: yes
> 	Format NVM: yes
> 	Security Send/Receive: yes
> Blk device 0: Optional NVM Command Support:
> 	Reservation: yes
> 	Save/Select field in the Set/Get features: no
> 	Write Zeroes: yes
> 	Dataset Management: yes
> 	Write Uncorrectable: yes
> Blk device 0: Format NVM Attributes:
> 	Support Cryptographic Erase: yes
> 	Support erase a particular namespace: Yes
> 	Support format a particular namespace: No
> Blk device 0: LBA Format Support:
> Blk device 0: End-to-End DataProtect Capabilities:
> 	As last eight bytes: No
> 	As first eight bytes: No
> 	Support Type3: No
> 	Support Type2: No
> 	Support Type1: No
> Blk device 0: Metadata capabilities:
> 	As part of a separate buffer: No
> 	As part of an extended data LBA: No
> StarFive # nvme info
> Device 0: Vendor: 0x144d Rev: 5B2QGXA7 Prod: S5GYNX0T302900W     
>             Type: Hard Disk
>             Capacity: 476940.0 MB = 465.7 GB (976773168 x 512)
> StarFive # nvme part
> Partition Map for nvme device 0  --   Partition Type: EFI
> 
> Part	Start LBA	End LBA		Name
> 	Attributes
> 	Type GUID
> 	Partition GUID
>   1	0x00000040	0x0002003f	"NvmeEFI"
> 	attrs:	0x0000000000000000
> 	type:	c12a7328-f81f-11d2-ba4b-00a0c93ec93b
> 		(EFI System Partition)
> 	guid:	f0fa7669-f18e-4335-9267-9bee56f2db5f
>   2	0x00020040	0x0142003f	"NvmeSwap"
> 	attrs:	0x0000000000000000
> 	type:	49f48d32-b10e-11dc-b99b-0019d1879648
> 		(49f48d32-b10e-11dc-b99b-0019d1879648)
> 	guid:	7f8fc315-f7e6-467a-8811-79c272b1e331
>   3	0x01420040	0x3a38600e	"NvmeRoot"
> 	attrs:	0x0000000000000000
> 	type:	49f48d5a-b10e-11dc-b99b-0019d1879648
> 		(49f48d5a-b10e-11dc-b99b-0019d1879648)
> 	guid:	689f41fa-13d8-43c9-b409-4acddeec0476
> StarFive #
> 
> (and it would have booted from the EFI partition hapilly if I hadn't 
> interrupted it here)

My understanding of PCIe on JH-7110 SoC is there's a hardware design
flaw and the "fix" is a delay-and-wait that was rejected by Linux
upstream. This presents more readily with *some* NVMe drives. It was a
hot topic for discussion and based on that I selected Samsung 970
EVOPlus 500GB and 250GB models and I've never had an issue appear with
the 250GB on which I do all my RISC-V development as with a Home
Assistant Yellow baseboard hosting the Milk-V Mars CM Lite (JH-7110 SoC)
system-on-module.

Is this the issue you're experiencing? What exact make/model is that
NVMe module?

-E
