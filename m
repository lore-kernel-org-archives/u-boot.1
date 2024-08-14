Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9433CC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 14:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A67C889D3;
	Wed, 14 Aug 2024 16:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=liwest.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=liwest.at header.i=@liwest.at header.b="v6SjRuvh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF5F889ED; Wed, 14 Aug 2024 14:41:08 +0200 (CEST)
Received: from so.liwest.at (so.liwest.at [212.33.55.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C09E48899D
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 14:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=liwest.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jackie@liwest.at
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=liwest.at; 
 s=20140502;
 h=Content-Type:MIME-Version:Subject:Message-ID:To:From:Date:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=di/omKeg1c+QlKiO8k5on4lqlSsiJxQF7x6vBG8kJHc=; b=v6SjRuvhT75H70rLh+AAheR9sp
 2uVFVYLSXLkgaX9FSzxTdmyYxvmNW30hNhGJOv1z6wouhKA4IXK5I1z0hmr0N/oTLSTWadsAue2qf
 EDBch8TzTS53hmeUyTdkAuD96nSGwoHMg/jB9WpYVdQgvXjDpQT1Hakn/3J3EoPB28hVHNxjZikLF
 ezUoT/MUFmjh6epArpycsBBVjziOdW5402FkgMud4/aQQDJrJznZD2AOBAyV14dcuXKnb95sEmE3K
 SwPrMgS2kwJx3vqq0EFB3PqyEEJVktmOpjoXK0OUmcW560ZH9g/yVG3f/LWTTtVB7zRsixPUdq1L/
 eVggY4gw==;
Received: from [192.168.224.101] (helo=ox111.liwestmail.local)
 by so.liwest.at with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <jackie@liwest.at>) id 1seDJJ-00GQzt-3l
 for u-boot@lists.denx.de; Wed, 14 Aug 2024 14:41:05 +0200
Date: Wed, 14 Aug 2024 14:41:04 +0200 (CEST)
From: jackie@liwest.at
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Message-ID: <1285791895.63856.1723639264510@webmail.liwest.at>
Subject: u-boot does not detect and correct bitflip when loading kernel from
 NAND
MIME-Version: 1.0
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.4-Rev30
X-Originating-Client: open-xchange-appsuite
X-Mailman-Approved-At: Wed, 14 Aug 2024 16:19:31 +0200
Content-Type: text/plain; charset=UTF-8
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

Hi to all and especially to Albert ARIBAUD, who is I think the maintainer o=
f my board.
I=E2=80=99m new to U-Boot and I=E2=80=99m trying to solve an issue regardin=
g NAND Flash.

Issue:

After system reboot U-Boot loads the same Kernel from NAND into RAM without=
 any error message, whoever the Kernel says =E2=80=98Verifying Checksum ...=
 Bad Data CRC=E2=80=99

Configuration:

Phytec pcm052 (Vybrid vf610), Micron MT29F4G16 =E2=80=A6., U-Boot Timesys 2=
013.07, Kernel 3.13

Kernel uses mtdparts to create partitions defined in the device tree, FDT N=
AND uses ECC hw, on top sits UBIFS

Observations:
1. Loading both, the Kernel from Flash into RAM and the corresponding origi=
nal copy from SD-Card revealed one single bitflip.
2. Writing the correct byte into Flash lets the Kernel start
3. Timesys U-Boot 2016.09 seems to recognize the bitflip, because after loa=
ding the Kernel starts to work, but the scheduler of the MQX OS does not wo=
rk correctly. You introduced a new feature into U-Boot to load and start an=
 image for the M4 core. Maybe this does some initialization which causes so=
me problems in MQX. Debugging the OS shows that the scheduler starts before=
 the IDLE task has been queued in.
4. After booting from the 2nd Kernel and a reflashing the partition of 1st =
one, lets it start without any problems
5. This issue happens after month and years after flashing and running the =
system 24/7
Assumptions about the root cause:
1. Different ECC calculations in U-Boot and Kernel
2. Different OOB or Bad Block handling
Questions:

Are my assumptions correct am I missing something?
Is this a known issue?
How can I compare the setting U-Boot/Kernel?
E.g. Which ECC does U-Boot use (HW NFC or =E2=80=98on die=E2=80=99 ,  SW,  =
Algorithm BCH ?, how many bit, =E2=80=A6)?

Many thanks in advance

Tanja
