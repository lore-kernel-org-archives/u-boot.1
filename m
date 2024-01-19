Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EDEC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0933087BB5;
	Fri, 19 Jan 2024 17:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=jens-maus.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=jens-maus.de header.i=@jens-maus.de header.b="A2KKBF8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86B0687B98; Fri, 19 Jan 2024 17:53:16 +0100 (CET)
Received: from mail.light-speed.de (mail.light-speed.de
 [IPv6:2a01:238:43f2:8900:dd04:e3a0:ee11:a73d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF5687A2A
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=jens-maus.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@jens-maus.de
Received: from smtpclient.apple (unknown
 [IPv6:2a02:810a:8280:47aa:e1ca:9c29:360a:5e29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.light-speed.de (Postfix) with ESMTPSA id D6AAE3D48651;
 Fri, 19 Jan 2024 17:53:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jens-maus.de;
 s=mail; t=1705683194;
 bh=i4g8OPDUjFWMC7jE0H2y1bbKoet56CSqmdfL7gI78TI=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=A2KKBF8LdqbSxOmN4+XwJB97S8QVbYwURN2jDJBcuFd0EOPq2lb4Pkd+s/8Q7YZBy
 71/MlbDBLNUDu49yjAutueVB2/F10rsokWD4D02xgvJ4VEfnuH5qQleAymI0au/fo/
 6OPRJ73fg/A7sBUEw1e9S2n3xy14RMHsK7v5/d1M=
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH v4 0/6] rpi5: initial support
From: Jens Maus <mail@jens-maus.de>
In-Reply-To: <dvpwizpui6a52dfmy57ghv4zmplvgqvow6oec7x5opwzh63zzl@jehyglofr6yh>
Date: Fri, 19 Jan 2024 17:53:03 +0100
Cc: Stefan Wahren <wahrenst@gmx.net>,
 u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <489FBAE5-501A-49F6-894D-58BE5C5429CC@jens-maus.de>
References: <03bbe9ad-7cc6-491d-8bd9-631f1cf04f39@gmx.net>
 <418F8AAE-136A-44A0-80C3-D01FFE00EC2E@jens-maus.de>
 <sjmi6dftbgx56isfyjtaryehzq2iollwxm2etlspiygehh3n6v@k4ws56nsbgfn>
 <6C9E5E0C-9C27-45A4-886F-8B8C641EF7A3@jens-maus.de>
 <ejituxf7ggiu2ciswrwoeqqjytb7mj2vn6gkxllywtnlm4aefi@br4zq7rfytlo>
 <3FB75D28-9BF9-4518-8BF1-519C884516F7@jens-maus.de>
 <fa7j66z5r7pul6zp5ljcntrb7xbazqxesz6wysrslrpxxhpafc@krztduo6pjm6>
 <25AB43C7-829F-4F62-AC8E-3284B22ACB03@jens-maus.de>
 <E7BFDAEE-00A9-463A-AF73-75101AFF2BC6@suse.de>
 <FB66DFF3-03B0-4DA5-8916-AB80CA6C6EB5@jens-maus.de>
 <dvpwizpui6a52dfmy57ghv4zmplvgqvow6oec7x5opwzh63zzl@jehyglofr6yh>
To: "Ivan T. Ivanov" <iivanov@suse.de>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
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


> Am 19.01.2024 um 17:29 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>=20
>> So you say with your own u-boot.bin you see serial U-Boot output =
after that =E2=80=9ENOTICE: BL31: =E2=80=A6=E2=80=9C lines? On that =
special UART port on the rpi5 or on the UART on the GPIO header?
>>=20
>=20
> Yes :-) See attached log file.

Really strange that in your case U-Boot seems to come up nicely and =
outputs something on the debug UART. Here definitely not. And the only =
difference in the rpi boot loader log outputs I could spot between yours =
and mine is:

=E2=80=94 cut here =E2=80=94
--- uboot2.log	2024-01-19 17:36:18.099674743 +0100
+++ uboot1.log	2024-01-19 17:33:06.794258533 +0100
@@ -1,13 +1,13 @@
-RPi: BOOTSYS release VERSION:30cc5f37 DATE: 2024/01/05 TIME: 15:57:40
-BOOTMODE: 0x06 partition 0 build-ts BUILD_TIMESTAMP=3D1704470260 serial =
9127ae99 boardrev d04170 stc 930201
+RPi: BOOTSYS release VERSION:30de0ba5 DATE: 2023/10/30 TIME: 16:45:10
+BOOTMODE: 0x06 partition 0 build-ts BUILD_TIMESTAMP=3D1698684310 serial =
3c533ede boardrev c04170 stc 815886
 AON_RESET: 00000003 PM_RSTS 00001000
 RP1_BOOT chip ID: 0x20001927
 PM_RSTS: 0x00001000
 part 00000000 reset_info 00000000
 PMIC reset-event 00000000 rtc 00000000 alarm 00000000 enabled 0
 uSD voltage 3.3V
-Initialising SDRAM 'Micron' 32Gb x2 total-size: 64 Gbit 4267
-DDR 4267 1 0 64 152
+Initialising SDRAM 'Samsung' 16Gb x2 total-size: 32 Gbit 4267
+DDR 4267 1 0 32 152
 RP1_BOOT chip ID: 0x20001927
=20
 RP1_BOOT chip ID: 0x20001927
@@ -17,18 +17,17 @@
 PCIe scan 00001de4:00000001
 RP1_CHIP_INFO 20001927
=20
-RPi: BOOTLOADER release VERSION:30cc5f37 DATE: 2024/01/05 TIME: =
15:57:40
-BOOTMODE: 0x06 partition 0 build-ts BUILD_TIMESTAMP=3D1704470260 serial =
9127ae99 boardrev d04170 stc 3949421
+RPi: BOOTLOADER release VERSION:30de0ba5 DATE: 2023/10/30 TIME: =
16:45:10
+BOOTMODE: 0x06 partition 0 build-ts BUILD_TIMESTAMP=3D1698684310 serial =
3c533ede boardrev c04170 stc 3726990
 AON_RESET: 00000003 PM_RSTS 00001000
-M.2 PCIe HAT not detected.
 usb_pd_init status 1
 Boot mode: SD (01) order f4
 SD HOST: 200000000 CTL0: 0x00800000 BUS: 400000 Hz actual: 390625 HZ =
div: 512 (256) status: 0x1fff0000 delay: 276
 SD HOST: 200000000 CTL0: 0x00800f00 BUS: 400000 Hz actual: 390625 HZ =
div: 512 (256) status: 0x1fff0000 delay: 276
-OCR c0ff8000 [310]
-CID: 00035344534536344780519441cb0123
-CSD: 400e00325b590001dbd37f800a404000
-SD: bus-width: 4 spec: 2 SCR: 0x02458443 0x00000000
+OCR c0ff8000 [118]
+CID: 00035344534e33324780fa570bda0169
+CSD: 400e00325b590000edb07f800a400000
+SD: bus-width: 4 spec: 2 SCR: 0x02358483 0x00000000
 SD HOST: 200000000 CTL0: 0x00800f04 BUS: 50000000 Hz actual: 50000000 =
HZ div: 4 (2) status: 0x1fff0000 delay: 2
 MBR: 0x00002000,  131072 type: 0x0c
 MBR: 0x00022000, 1024000 type: 0x82
@@ -39,7 +38,6 @@
 rsc 4 fat-sectors 128 root dir cluster 1 sectors 32 entries 512
 FAT16 clusters 32695
 [sdcard] autoboot.txt not found
-Select partition rsts 0 C(boot_partition) 0 EEPROM config 0 result 0
 Trying partition: 0
 type: 16 lba: 8192 'mkfs.fat' '  V       ^ ' clusters 32695 (4)
 rsc 4 fat-sectors 128 root dir cluster 1 sectors 32 entries 512
@@ -52,6 +50,7 @@
 Read bcm2712-rpi-5-b.dtb bytes    79357 hnd 0x139f
 dt-match: compatible: raspberrypi,5-model-b match: brcm,bcm2712
 dt-match: compatible: brcm,bcm2712 match: brcm,bcm2712
+PM_RSTS 00001000
 Selecting USB low current limit
=20
 NOTICE:  BL31: v2.6(release):v2.6-239-g2a9ede0bd
=E2=80=94 cut here =E2=80=94

So lets see if after you updated to a more recent rpi eeprom U-boot is =
still able to boot=E2=80=A6

regards,
jens
--=20
Jens Maus, Dresden/Germany
http://jens-maus.de/

