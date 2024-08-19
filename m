Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC08C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 13:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CA2A888FD;
	Mon, 19 Aug 2024 15:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C4D488993; Mon, 19 Aug 2024 15:11:24 +0200 (CEST)
Received: from eclipse.jkvinge.net (eclipse.jkvinge.net [217.170.205.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 813F388881
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 15:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=opensuse.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jonaski@opensuse.org
Received: from ni246.in.jkvinge.net (ti0116a430-0074.bb.online.no
 [88.91.110.75]) (authenticated bits=0)
 by eclipse.jkvinge.net (8.15.2/8.15.2/SuSE Linux 0.8) with ESMTPSA id
 47JDBJRH011258
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 15:11:19 +0200
Message-ID: <b24ba149599b9e0261676110894d14a0f69eb6a2.camel@opensuse.org>
Subject: u-boot on raspberry pi with secure boot
From: Jonas Kvinge <jonaski@opensuse.org>
To: u-boot@lists.denx.de
Date: Mon, 19 Aug 2024 15:11:19 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
Received-SPF: pass (eclipse.jkvinge.net: authenticated connection)
 receiver=eclipse.jkvinge.net; client-ip=88.91.110.75;
 helo=ni246.in.jkvinge.net; envelope-from=jonaski@opensuse.org;
 x-software=spfmilter 2.001 http://www.acme.com/software/spfmilter/ with
 libspf2-1.2.10; 
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

I have a custom installation of openSUSE Tumbleweed which uses u-boot
and Grub.
To use secure boot on the RPI, one creates a boot.img containing the
kernel and other files which is signed, and the eeprom is locked to
only allow booting with this signature.
(https://github.com/raspberrypi/usbboot/blob/master/secure-boot-recovery/RE=
ADME.md
).
Since I'm using u-boot, I'm creating a boot.img containing u-boot.bin
instead of the linux kernel and ramdisk.
But then nothing is locking down which kernel can boot, since that's
controller by UEFI and Grub. u-boot starts Grub from the UEFI
partition, and Grub starts the kernel from a separate /boot partition.
And I see no way to change this
I use a 3 partition setup where the partitions are 1. FAT UEFI
partition, 2. Linux ext4 /boot partition, 3. Encrypted LUKS ext4 root
partition.
I've been looking into
https://trac.gateworks.com/wiki/secure_boot#SecuringtheKernelFDTramdiskviaF=
ITimages
But is that possible to do with my current setup? Can I include grub
and the kernel/initrd in the boot.img and make u-boot use that instead
of from the UEFI partition?

Jonas

