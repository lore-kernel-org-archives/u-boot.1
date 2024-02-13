Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373FDC4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 11:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FBA487D55;
	Tue, 13 Feb 2024 12:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=optimcloud.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA844877D0; Tue, 13 Feb 2024 04:06:24 +0100 (CET)
Received: from mail.optimcloud.com (unknown [46.23.82.132])
 by phobos.denx.de (Postfix) with ESMTP id 5426A875FD
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 04:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=optimcloud.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lists@optimcloud.com
Content-Type: text/plain; charset=utf-8; format=flowed
Authentication-Results: mail.optimcloud.com;
 auth=pass smtp.mailfrom=lists@optimcloud.com
Message-Id: <1707793391213.2198684831.3775960691@optimcloud.com>
From: Embedded <lists@optimcloud.com>
To: u-boot@lists.denx.de
Subject: Warning: eth0 MAC addresses don't match:
Date: Tue, 13 Feb 2024 03:06:09 +0000
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Spamd-Bar: /
X-Mailman-Approved-At: Tue, 13 Feb 2024 12:59:13 +0100
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

We are trying to move a board from QSDK to OpenWRT, however, once we had 
the image built and flashed bootipq exited with


Net:   MAC0 addr:44:d1:fa:a4:f1:66
PHY ID1: 0x4d
PHY ID2: 0xd101
EDMA ver 1 hw init
Num rings - TxDesc:1 (0-0) TxCmpl:1 (0-0)
RxDesc:1 (15-15) RxFill:1 (7-7)
ipq6018_edma_alloc_rings: successfull
ipq6018_edma_setup_ring_resources: successfull
ipq6018_edma_configure_rings: successfull
ipq6018_edma_hw_init: successfull
, eth0
Warning: eth0 MAC addresses don't match:
Address in SROM is         44:d1:fa:a4:f1:66
Address in environment is  44:d1:fa:a4:f1:67

and printenv shows

IPQ6018# printenv
baudrate=115200
bootargs=console=ttyMSM0,115200n8 ubi.mtd=rootfs root=mtd:ubi_rootfs 
rootfstype=squashfs rootwait ubi.mtd=rootfs root=mtd:ubi_rootfs 
rootfstype=squashfs rootwait ubi.mtd=rootfs root=mtd:ubi_rootfs 
rootfstype=squt
bootcmd=bootipq
bootdelay=2
eth1addr=44:d1:fa:a4:f1:67
eth2addr=44:d1:fa:a4:f1:68
eth3addr=44:d1:fa:a4:f1:69
eth4addr=44:d1:fa:a4:f1:6a
ethact=eth0
ethaddr=44:d1:fa:a4:f1:66
fdt_high=0x48500000
fdtcontroladdr=4a46e7d0
flash_type=7
fsbootargs=ubi.mtd=rootfs root=mtd:ubi_rootfs rootfstype=squashfs
ipaddr=192.168.10.10
machid=8030000
mtddevname=fs
mtddevnum=0
mtdids=nand0=nand0
mtdparts=mtdparts=nand0:0x3c00000@0x0(fs),
netmask=255.255.255.0
partition=nand0,0
serverip=192.168.10.1
soc_version_major=1
soc_version_minor=0
stderr=serial@78B1000
stdin=serial@78B1000
stdout=serial@78B1000

Environment size: 887/65532 bytes

SO how can i resolve booting this device? 
-- 
Sent with Vivaldi Mail. Download Vivaldi for free at vivaldi.com
